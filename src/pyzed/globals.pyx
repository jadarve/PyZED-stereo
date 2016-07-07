
import numpy as np

# enum MODE symbols
MODE_NONE           = NONE
MODE_PERFORMANCE    = PERFORMANCE
MODE_QUALITY        = QUALITY

# enum SIDE symbols
SIDE_RIGHT          = RIGHT
SIDE_LEFT           = LEFT
SIDE_LEFT_GREY      = LEFT_GREY
SIDE_RIGHT_GREY     = RIGHT_GREY
SIDE_LAST_SIDE      = LAST_SIDE


# enum SENSING_MODE symbols
SENSING_MODE_FILL               = FILL
SENSING_MODE_STANDARD           = STANDARD
SENSING_MODE_LAST_SENSING_MODE  = LAST_SENSING_MODE


# enum MEASURE symbols
MEASURE_DISPARITY       = DISPARITY
MEASURE_DEPTH           = DEPTH
MEASURE_CONFIDENCE      = CONFIDENCE
MEASURE_XYZ             = XYZ
MEASURE_XYZRGBA         = XYZRGBA
MEASURE_LAST_MEASURE    = LAST_MEASURE

# enum UNIT symbols
UNIT_MILLIMETER = MILLIMETER
UNIT_METER      = METER
UNIT_INCH       = INCH
UNIT_FOOT       = FOOT
UNIT_LAST_UNIT  = LAST_UNIT

# enum COORDINATE_SYSTEM symbols
COORDINATE_SYSTEM_IMAGE                     = IMAGE
COORDINATE_SYSTEM_LEFT_HANDED               = LEFT_HANDED
COORDINATE_SYSTEM_RIGHT_HANDED              = RIGHT_HANDED
COORDINATE_SYSTEM_ROBOTIC                   = ROBOTIC
COORDINATE_SYSTEM_APPLY_PATH                = APPLY_PATH
COORDINATE_SYSTEM_LAST_COORDINATE_SYSTEM    = LAST_COORDINATE_SYSTEM


cdef class CamParameters:
    
    def __init__(self):
        pass


    def __cinit__(self):
        pass


    def __dealloc__(self):
        # nothing to do
        pass


    def __str__(self):

        s = list()
        s.append('fx:\t{0}'.format(self.fx))
        s.append('fy:\t{0}'.format(self.fy))
        s.append('cx:\t{0}'.format(self.cx))
        s.append('cy:\t{0}'.format(self.cy))
        s.append('disto:\t{0}'.format([self.param.disto[p] for p in range(5)]))
        return '\n'.join(s)


    def getIntrinsicsMatrix(self):

        K = np.zeros((3,3), dtype=np.float32)

        K[0,0] = self.fx
        K[0,2] = self.cx
        K[1,1] = self.fy
        K[1,2] = self.cy
        K[2,2] = 1

        return K


    property fx:
        def __get__(self):
            return self.param.fx

        def __set__(self, float fx):
            self.param.fx = fx

        def __del__(self):
            pass


    property fy:
        def __get__(self):
            return self.param.fy

        def __set__(self, float fy):
            self.param.fy = fy

        def __del__(self):
            pass


    property cx:
        def __get__(self):
            return self.param.cx

        def __set__(self, float cx):
            self.param.cx = cx

        def __del__(self):
            pass


    property cy:
        def __get__(self):
            return self.param.cy

        def __set__(self, float cy):
            self.param.cy = cy

        def __del__(self):
            pass


    # TODO
    property disto:
        def __get__(self):
            return None

        def __set__(self, value):
            pass

        def __del__(self):
            pass



cdef class StereoParameters:
    
    def __init__(self):
        pass


    def __cinit__(self):
        pass


    def __dealloc__(self):
        # nothing to do
        pass


    def __str__(self):

        s = list()
        s.append('baseline:\t{0}'.format(self.baseline))
        s.append('Ty:\t\t{0}'.format(self.Ty))
        s.append('Tz:\t\t{0}'.format(self.Tz))
        s.append('convergence:\t{0}'.format(self.convergence))
        s.append('Rx:\t\t{0}'.format(self.Rx))
        s.append('Rz:\t\t{0}'.format(self.Rz))
        s.append('LeftCam:\n{0}'.format('\n'.join(['\t{0}'.format(p) for p in str(self.LeftCam).split('\n')])))
        s.append('RightCam:\n{0}'.format('\n'.join(['\t{0}'.format(p) for p in str(self.RightCam).split('\n')])))
        return '\n'.join(s)


    property baseline:
        def __get__(self):
            return self.param.baseline

        def __set__(self, float baseline):
            self.param.baseline = baseline

        def __del__(self):
            pass


    property Ty:
        def __get__(self):
            return self.param.Ty

        def __set__(self, float Ty):
            self.param.Ty = Ty

        def __del__(self):
            pass


    property Tz:
        def __get__(self):
            return self.param.Tz

        def __set__(self, float Tz):
            self.param.Tz = Tz

        def __del__(self):
            pass


    property convergence:
        def __get__(self):
            return self.param.convergence

        def __set__(self, float convergence):
            self.param.convergence = convergence

        def __del__(self):
            pass


    property Rx:
        def __get__(self):
            return self.param.Rx

        def __set__(self, float Rx):
            self.param.Rx = Rx

        def __del__(self):
            pass


    property Rz:
        def __get__(self):
            return self.param.Rz

        def __set__(self, float Rz):
            self.param.Rz = Rz

        def __del__(self):
            pass


    property LeftCam:
        def __get__(self):
            cdef CamParameters cam = CamParameters()
            cam.param = self.param.LeftCam
            return cam

        def __set__(self, CamParameters LeftCam):
            self.param.LeftCam = LeftCam.param

        def __del__(self):
            pass


    property RightCam:
        def __get__(self):
            cdef CamParameters cam = CamParameters()
            cam.param = self.param.RightCam
            return cam

        def __set__(self, CamParameters RightCam):
            self.param.RightCam = RightCam.param

        def __del__(self):
            pass

