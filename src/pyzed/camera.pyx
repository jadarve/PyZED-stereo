
from cython.operator cimport dereference as deref

from libcpp cimport nullptr
from libcpp.string cimport string
from libcpp.memory cimport shared_ptr

import numpy as np
cimport numpy as np

cimport pyzed.globals as sl
import pyzed.globals as sl

cimport pyzed.mat as mat


def errcodeToString(sl.ERRCODE code):
    
    return {0 : 'Success',
            1 : 'No gpu compatible',
            2 : 'Not enough gpu memory',
            3 : 'ZED not available',
            4 : 'ZED resolution invalid',
            5 : 'ZED settings file not available',
            6 : 'Invalid SVO file',
            7 : 'Recorder error',
            8 : 'Last error code'}[code]



cdef class Camera:
    

    def __init__(self, str filepath):
        """Creates a new ZED Camera instance

        Parameters
        ----------
        filepath : string, optional.
            File path to Stereo Video file (.svo).
        """


    def __cinit__(self, str filepath = None):


        cdef string fpath_cpp = string()
        fpath_cpp.append(bytes(filepath))

        # NOTE: make_shared does not work!
        #cdef shared_ptr[Camera_cpp] ptr =  mem.make_shared[Camera_cpp]('moni')

        if filepath is not None:
            self.fileMode = True
            self.thisptr = shared_ptr[Camera_cpp](new Camera_cpp(fpath_cpp))


    def __dealloc__(self):
        # nothing to do. self.thisptr is deleted by shared_ptr destructor
        pass


    def init(self, sl.MODE mode = sl.MODE_QUALITY, int device = -1,
        bool verbose = True, bool vflip = False,
        bool disable_self_calib = False):

        cdef sl.ERRCODE err = self.thisptr.get().init(mode, device, verbose,
            vflip, disable_self_calib)

        if err != sl.SUCCESS:
            raise RuntimeError('Error initializing camera: {0}'.format(errcodeToString(err)))

        # FIXME:    For some reason, I need to grab 2 frames before actually reading
        #           frames from the SVO video in order to properly position SVOPosition
        #           at zero
        if self.fileMode:
            for _ in range(2):
                self.grab()
                self.SVOPosition = 0


    def grab(self, sl.SENSING_MODE mode = sl.SENSING_MODE_RAW,
        bool computeMeasure = True, bool computeDisparity = True,
        bool computeXYZ = True):
        
        cdef bool res = self.thisptr.get().grab(mode, computeMeasure,
            computeDisparity, computeXYZ)

        return res


    def retrieveImage(self, sl.SIDE side= sl.SIDE_LEFT):

        cdef mat.Mat img = self.thisptr.get().retrieveImage(side)
        return mat.toNumpy(img)


    def retrieveMeasure(self, sl.MEASURE measure):

        cdef mat.Mat img = self.thisptr.get().retrieveMeasure(measure)
        return mat.toNumpy(img)


    def getParameters(self):
        """Returns a copy of the camera parameters

        Modification of the parameters through this function is not
        supported yet.

        Returns
        -------
        param : StereoParameters
            Copy of the camera parameters
        """

        cdef sl.StereoParameters param = sl.StereoParameters()
        param.param = deref(self.thisptr.get().getParameters())
        return param



    property SVOPosition:
        def __get__(self):
            cdef int pos = self.thisptr.get().getSVOPosition()
            return pos

        def __set__(self, int frame):
            if not self.thisptr.get().setSVOPosition(frame):
                raise RuntimeError('Error setting SVO position')

        def __del__(self):
            pass


    property SVONumberOfFrames:
        def __get__(self):
            return self.thisptr.get().getSVONumberOfFrames()

        def __set__(self, value):
            raise RuntimeError('SVONumberOfFrames cannot be set')

        def __del__(self):
            pass


    property ImageSize:
        def __get__(self):
            cdef int height = self.thisptr.get().getImageSize().height
            cdef int width = self.thisptr.get().getImageSize().width
            return (height, width)

        def __set__(self, value):
            raise RuntimeError('ImageSize cannot be set')

        def __del__(self):
            pass

