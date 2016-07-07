
from libcpp cimport bool
from libcpp.string cimport string
from libcpp.memory cimport shared_ptr



cimport pyzed.globals as sl
from pyzed.mat cimport Mat

cdef extern from 'zed/Camera.hpp' namespace 'sl::zed':

    cdef cppclass Camera_cpp 'sl::zed::Camera':
            
            Camera_cpp(sl.ZEDResolution_mode zedRes_mode = sl.ZEDResolution_mode.HD720, float fps = 0.0, int zed_linux_id = 0) except +
            Camera_cpp(string zed_record_filename) except +

            #sl.ERRCODE init(sl.MODE quality, int device, bool verbose, bool vflip, bool disable_self_calib)
            sl.ERRCODE init(sl.InitParams& parameters)

            #bool grab(sl.SENSING_MODE dm_type = sl.SENSING_MODE.RAW, bool computeMeasure = 1, bool computeDisparity = 1, bool computeXYZ = 0)
            bool grab(sl.SENSING_MODE dm_type, bool computeMeasure, bool computeDisparity, bool computeXYZ)

            Mat getView(sl.VIEW_MODE view)
            Mat getView_gpu(sl.VIEW_MODE view)

            Mat retrieveImage(sl.SIDE side)
            Mat retrieveMeasure(sl.MEASURE measure)

            #Mat retrieveImage_gpu(sl.SIDE side)
            #Mat retrieveMeasure_gpu(sl.MEASURE measure)

            Mat normalizeMeasure(sl.MEASURE measure, float min = 0, float max = 0)
            #Mat normalizeMeasure_gpu(sl.MEASURE measure, float min = 0, float max = 0)

            sl.StereoParameters_cpp* getParameters()

            void setConfidenceThreshold(int ThresholdIdx)
            int getConfidenceThreshold()

            #CUcontext getCUDAContext()

            sl.resolution getImageSize()

            unsigned int getZEDSerial()
            unsigned int getZEDFirmware()

            bool setSVOPosition(int frame)
            int getSVOPosition()

            int getSVONumberOfFrames()

            void setDepthClampValue(int distanceMax)
            int getDepthClampValue()

            void setCameraSettingsValue(sl.ZEDCamera_settings mode, int value, bool usedefault = false)
            int getCameraSettingsValue(sl.ZEDCamera_settings mode)

            #float getCurrentFPS()

            #long long getCameraTimestamp()

            #long long getCurrentTimestamp()

            #void setBaselineRatio(float ratio)

            #ZED_SELF_CALIBRATION_STATUS getSelfCalibrationStatus()

            #sl::double3 getSelfCalibrationRotation()


            #bool resetSelfCalibration()

            #float getClosestDepthValue()

            #bool setFPS(int desiredFPS)

            #void setFlip(bool flip)

            #ERRCODE initRecording(std::string filepath, bool avi_file = false, bool side_by_side = true)

            #bool record()

            #sl::zed::Mat getCurrentRawRecordedFrame()

            #bool stopRecording()

            #void displayRecorded()

            #static std::string getSDKVersion()

            #static int isZEDconnected()

            #static int sticktoCPUCore(int cpu_core)



cdef class Camera:
    
    cdef shared_ptr[Camera_cpp] thisptr

    # true if thisptr is constructed using SVO filepath
    cdef bool fileMode