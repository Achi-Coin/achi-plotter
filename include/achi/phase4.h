/*
 * phase4.h
 *
 *  Created on: Jun 2, 2021
 *      Author: mad
 */

#ifndef INCLUDE_ACHI_PHASE4_H_
#define INCLUDE_ACHI_PHASE4_H_

#include <achi/phase3.h>


namespace phase4 {

struct output_t {
	phase1::input_t params;
	uint64_t plot_size = 0;
	std::string plot_file_name;
};


} // phase4

#endif /* INCLUDE_ACHI_PHASE4_H_ */
