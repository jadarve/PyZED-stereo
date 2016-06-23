from libcpp.string cimport string


cdef extern from 'zed/utils/GlobalDefine.hpp' namespace 'sl':
    
    ctypedef unsigned char uchar

    cdef struct uchar3Struct:
        uchar c1
        uchar c2
        uchar c3

        uchar3Struct(uchar c1_ = 0, uchar c2_ = 0, uchar c3_ = 0)
        void setValue(uchar c1_, uchar c2_ = 0, uchar c3_ = 0)

    ctypedef uchar3Struct uchar3


    cdef struct float3Struct:
        float f1
        float f2
        float f3

        float3Struct(float f1_ = 0, float f2_ = 0, float f3_ = 0)

    ctypedef float3Struct float3


    cdef struct double3Struct:
        double d1
        double d2
        double d3

        double3Struct(float d1_ = 0, float d2_ = 0, float d3_ = 0)
    
    ctypedef double3Struct double3



    cdef enum DEPTH_FORMAT:
        PNG
        PFM
        PGM
        LAST_DEPTH_FORMAT


    enum POINT_CLOUD_FORMAT:
        XYZ
        PCD
        PLY
        VTK
        LAST_CLOUD_FORMAT
    


cdef extern from 'zed/utils/GlobalDefine.hpp' namespace 'sl::zed':

    
    ctypedef enum MODE:
        NONE
        PERFORMANCE
        QUALITY


    cdef enum VIEW_MODE:
        STEREO_LEFT
        STEREO_RIGHT
        STEREO_ANAGLYPH
        STEREO_DIFF
        STEREO_SBS
        STEREO_OVERLAY
        STEREO_LEFT_GREY
        STEREO_RIGHT_GREY
        LAST_VIEW_MODE

    
    cdef enum SIDE:
        LEFT
        RIGHT
        LEFT_GREY
        RIGHT_GREY
        LAST_SIDE
        

    cdef enum SENSING_MODE:
        FULL
        RAW 

        
    cdef enum MEASURE:
        DISPARITY
        DEPTH
        CONFIDENCE
        XYZ
        XYZRGBA
        LAST_MEASURE


    cdef enum ERRCODE:
        SUCCESS
        NO_GPU_COMPATIBLE
        NOT_ENOUGH_GPUMEM
        ZED_NOT_AVAILABLE
        ZED_RESOLUTION_INVALID
        ZED_SETTINGS_FILE_NOT_AVAILABLE
        INVALID_SVO_FILE
        RECORDER_ERROR
        LAST_ERRCODE


    cdef enum ZED_SELF_CALIBRATION_STATUS:
        SELF_CALIBRATION_NOT_CALLED
        SELF_CALIBRATION_RUNNING
        SELF_CALIBRATION_FAILED
        SELF_CALIBRATION_SUCCESS


    cdef enum ZEDResolution_mode:
        HD2K
        HD1080
        HD720
        VGA
        LAST_RESOLUTION


    cdef struct resolution:
        int width
        int height

        resolution(int w_, int h_)


        
    #static std::vector<resolution> zedResolution = [] {
    #    std::vector<resolution> v;
    #    v.push_back(resolution(2208, 1242));    // HD2K
    #    v.push_back(resolution(1920, 1080));    // HD1080
    #    v.push_back(resolution(1280, 720));     // HD720
    #    v.push_back(resolution(640, 480));      // VGA
    #    return v;
    #}();


    cdef enum ZEDCamera_settings:
        ZED_BRIGHTNESS
        ZED_CONTRAST
        ZED_HUE
        ZED_SATURATION
        ZED_GAIN
        ZED_WHITEBALANCE
        LAST_SETTINGS


    inline string errcode2str(ERRCODE err)

    inline string statuscode2str(ZED_SELF_CALIBRATION_STATUS stat)

    inline string qualitycode2str(MODE qual)


    cdef struct CamParameters_cpp 'sl::zed::CamParameters':
        float fx
        float fy
        float cx
        float cy

        double disto[5]

        void SetUp(float fx_, float fy_, float cx_, float cy_)


    cdef struct StereoParameters_cpp 'sl::zed::StereoParameters':
        float baseline
        float Ty
        float Tz
        float convergence
        float Rx
        float Rz
        CamParameters_cpp LeftCam
        CamParameters_cpp RightCam



cdef class CamParameters:
    cdef CamParameters_cpp param

cdef class StereoParameters:
    cdef StereoParameters_cpp param

