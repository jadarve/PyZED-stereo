
from libc.string cimport memcpy

import numpy as np
cimport numpy as np


# enum DATA_TYPE symbols
DATA_TYPE_FLOAT = FLOAT
DATA_TYPE_UCHAR = UCHAR


cdef toNumpy(Mat img):
    """ Returns a numpy array with a copy of Mat image.

    Parameters
    ----------
    img : Mat
        Mat object to take data from.

    Returns
    -------
    arr : np.ndarray
        Numpy array with copy of Mat img
    """
    

    shape = None

    if img.channels == 1:
        shape = (img.height, img.width)
    else:
        shape = (img.height, img.width, img.channels)


    cdef size_t size = 0
    dtype = None

    if img.data_type == DATA_TYPE_UCHAR:
        size = img.height*img.width*img.channels
        dtype = np.uint8
    elif img.data_type == DATA_TYPE_FLOAT:
        size = img.height*img.width*img.channels*sizeof(float)
        dtype = np.float32
    else:
        raise RuntimeError('Unknown Mat data_type value: {0}'.format(img.data_type))


    cdef np.ndarray arr = np.zeros(shape, dtype=dtype)
    memcpy(<void*>arr.data, <void*>img.data, size);

    return arr
