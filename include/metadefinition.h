#ifndef META_DEFINITION
#define META_DEFINITION
#include "devcommon.h"
namespace REPAIR
{
    template <typename T>
    inline T ceil(T const &A, T const &B)
    {
        return T((A + B - 1) / B);
    };
    enum EncodeType
    {
        Xorbas,
        Azure_LRC,
        Azure_LRC_1,
        Optimal_LRC
    };
    enum PlacementType
    {
        Random,
        Flat,
        Best_Placement
    };
    // namespace REPAIR
    // data globle local
    //[cluster id, cluster id]
    typedef std::vector<unsigned int> Placement;
    typedef std::map<std::string, std::vector<std::string>> RepairRequest;
    typedef struct StripeItem
    {
        std::vector<unsigned int> node_ids;
        int value_size_bytes;
        int block_size_bytes;
    } StripeItem;
    class MyRand
    {
    public:
        int operator()(int n)
        {
            struct timespec tp;
            clock_gettime(CLOCK_THREAD_CPUTIME_ID, &tp);
            srand(tp.tv_nsec);
            return rand() % n;
        }
    };
}
#endif