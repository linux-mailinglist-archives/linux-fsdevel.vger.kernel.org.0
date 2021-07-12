Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43C3C6655
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 00:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhGLWZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 18:25:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:35182 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhGLWZz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 18:25:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="190443884"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="gz'50?scan'50,208,50";a="190443884"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="gz'50?scan'50,208,50";a="629823721"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2021 15:23:02 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m34KL-000HHB-Ka; Mon, 12 Jul 2021 22:23:01 +0000
Date:   Tue, 13 Jul 2021 06:22:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 08/18] mm/memcg: Convert mem_cgroup_charge() to take
 a folio
Message-ID: <202107130626.PXtTZF3U-lkp@intel.com>
References: <20210712194551.91920-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20210712194551.91920-9-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Matthew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.14-rc1 next-20210712]
[cannot apply to hnaz-linux-mm/master tip/perf/core linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/Convert-memcg-to-folios/20210713-035650
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e73f0f0ee7541171d89f2e2491130c7771ba58d3
config: nds32-allnoconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/3aa23c53058c0abac2b7fd5d8c80f9b458a2665f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Convert-memcg-to-folios/20210713-035650
        git checkout 3aa23c53058c0abac2b7fd5d8c80f9b458a2665f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/dax.h:6,
                    from mm/filemap.c:15:
   include/linux/mm.h:1380:42: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1380 | static inline int folio_nid(const struct folio *folio)
         |                                          ^~~~~
   include/linux/mm.h: In function 'folio_nid':
   include/linux/mm.h:1382:27: error: dereferencing pointer to incomplete type 'const struct folio'
    1382 |  return page_to_nid(&folio->page);
         |                           ^~
   In file included from include/linux/swap.h:9,
                    from mm/filemap.c:23:
   include/linux/memcontrol.h: At top level:
   include/linux/memcontrol.h:1120:53: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1120 | static inline struct mem_cgroup *folio_memcg(struct folio *folio)
         |                                                     ^~~~~
   include/linux/memcontrol.h:1141:44: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1141 | static inline bool folio_memcg_kmem(struct folio *folio)
         |                                            ^~~~~
   include/linux/memcontrol.h:1193:44: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1193 | static inline int mem_cgroup_charge(struct folio *folio,
         |                                            ^~~~~
   mm/filemap.c: In function '__add_to_page_cache_locked':
>> mm/filemap.c:875:29: error: implicit declaration of function 'page_folio'; did you mean 'page_endio'? [-Werror=implicit-function-declaration]
     875 |   error = mem_cgroup_charge(page_folio(page), NULL, gfp);
         |                             ^~~~~~~~~~
         |                             page_endio
   mm/filemap.c:875:29: warning: passing argument 1 of 'mem_cgroup_charge' makes pointer from integer without a cast [-Wint-conversion]
     875 |   error = mem_cgroup_charge(page_folio(page), NULL, gfp);
         |                             ^~~~~~~~~~~~~~~~
         |                             |
         |                             int
   In file included from include/linux/swap.h:9,
                    from mm/filemap.c:23:
   include/linux/memcontrol.h:1193:51: note: expected 'struct folio *' but argument is of type 'int'
    1193 | static inline int mem_cgroup_charge(struct folio *folio,
         |                                     ~~~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/security.h:33,
                    from include/linux/fs_context.h:14,
                    from include/linux/fs_parser.h:11,
                    from include/linux/ramfs.h:5,
                    from mm/shmem.c:28:
   include/linux/mm.h:1380:42: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1380 | static inline int folio_nid(const struct folio *folio)
         |                                          ^~~~~
   include/linux/mm.h: In function 'folio_nid':
   include/linux/mm.h:1382:27: error: dereferencing pointer to incomplete type 'const struct folio'
    1382 |  return page_to_nid(&folio->page);
         |                           ^~
   In file included from include/linux/swap.h:9,
                    from mm/shmem.c:35:
   include/linux/memcontrol.h: At top level:
   include/linux/memcontrol.h:1120:53: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1120 | static inline struct mem_cgroup *folio_memcg(struct folio *folio)
         |                                                     ^~~~~
   include/linux/memcontrol.h:1141:44: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1141 | static inline bool folio_memcg_kmem(struct folio *folio)
         |                                            ^~~~~
   include/linux/memcontrol.h:1193:44: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1193 | static inline int mem_cgroup_charge(struct folio *folio,
         |                                            ^~~~~
   mm/shmem.c: In function 'shmem_add_to_page_cache':
>> mm/shmem.c:688:29: error: implicit declaration of function 'page_folio'; did you mean 'page_endio'? [-Werror=implicit-function-declaration]
     688 |   error = mem_cgroup_charge(page_folio(page), charge_mm, gfp);
         |                             ^~~~~~~~~~
         |                             page_endio
   mm/shmem.c:688:29: warning: passing argument 1 of 'mem_cgroup_charge' makes pointer from integer without a cast [-Wint-conversion]
     688 |   error = mem_cgroup_charge(page_folio(page), charge_mm, gfp);
         |                             ^~~~~~~~~~~~~~~~
         |                             |
         |                             int
   In file included from include/linux/swap.h:9,
                    from mm/shmem.c:35:
   include/linux/memcontrol.h:1193:51: note: expected 'struct folio *' but argument is of type 'int'
    1193 | static inline int mem_cgroup_charge(struct folio *folio,
         |                                     ~~~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors
--
   In file included from mm/memory.c:43:
   include/linux/mm.h:1380:42: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1380 | static inline int folio_nid(const struct folio *folio)
         |                                          ^~~~~
   include/linux/mm.h: In function 'folio_nid':
   include/linux/mm.h:1382:27: error: dereferencing pointer to incomplete type 'const struct folio'
    1382 |  return page_to_nid(&folio->page);
         |                           ^~
   In file included from include/linux/swap.h:9,
                    from mm/memory.c:50:
   include/linux/memcontrol.h: At top level:
   include/linux/memcontrol.h:1120:53: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1120 | static inline struct mem_cgroup *folio_memcg(struct folio *folio)
         |                                                     ^~~~~
   include/linux/memcontrol.h:1141:44: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1141 | static inline bool folio_memcg_kmem(struct folio *folio)
         |                                            ^~~~~
   include/linux/memcontrol.h:1193:44: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
    1193 | static inline int mem_cgroup_charge(struct folio *folio,
         |                                            ^~~~~
   mm/memory.c: In function 'page_copy_prealloc':
>> mm/memory.c:993:24: error: implicit declaration of function 'page_folio'; did you mean 'page_endio'? [-Werror=implicit-function-declaration]
     993 |  if (mem_cgroup_charge(page_folio(new_page), src_mm, GFP_KERNEL)) {
         |                        ^~~~~~~~~~
         |                        page_endio
   mm/memory.c:993:24: warning: passing argument 1 of 'mem_cgroup_charge' makes pointer from integer without a cast [-Wint-conversion]
     993 |  if (mem_cgroup_charge(page_folio(new_page), src_mm, GFP_KERNEL)) {
         |                        ^~~~~~~~~~~~~~~~~~~~
         |                        |
         |                        int
   In file included from include/linux/swap.h:9,
                    from mm/memory.c:50:
   include/linux/memcontrol.h:1193:51: note: expected 'struct folio *' but argument is of type 'int'
    1193 | static inline int mem_cgroup_charge(struct folio *folio,
         |                                     ~~~~~~~~~~~~~~^~~~~
   mm/memory.c: In function 'wp_page_copy':
   mm/memory.c:3022:24: warning: passing argument 1 of 'mem_cgroup_charge' makes pointer from integer without a cast [-Wint-conversion]
    3022 |  if (mem_cgroup_charge(page_folio(new_page), mm, GFP_KERNEL))
         |                        ^~~~~~~~~~~~~~~~~~~~
         |                        |
         |                        int
   In file included from include/linux/swap.h:9,
                    from mm/memory.c:50:
   include/linux/memcontrol.h:1193:51: note: expected 'struct folio *' but argument is of type 'int'
    1193 | static inline int mem_cgroup_charge(struct folio *folio,
         |                                     ~~~~~~~~~~~~~~^~~~~
   mm/memory.c: In function 'do_anonymous_page':
   mm/memory.c:3771:24: warning: passing argument 1 of 'mem_cgroup_charge' makes pointer from integer without a cast [-Wint-conversion]
    3771 |  if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
         |                        ^~~~~~~~~~~~~~~~
         |                        |
         |                        int
   In file included from include/linux/swap.h:9,
                    from mm/memory.c:50:
   include/linux/memcontrol.h:1193:51: note: expected 'struct folio *' but argument is of type 'int'
    1193 | static inline int mem_cgroup_charge(struct folio *folio,
         |                                     ~~~~~~~~~~~~~~^~~~~
   mm/memory.c: In function 'do_cow_fault':
   mm/memory.c:4186:24: warning: passing argument 1 of 'mem_cgroup_charge' makes pointer from integer without a cast [-Wint-conversion]
    4186 |  if (mem_cgroup_charge(page_folio(vmf->cow_page), vma->vm_mm,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                        |
         |                        int
   In file included from include/linux/swap.h:9,
                    from mm/memory.c:50:
   include/linux/memcontrol.h:1193:51: note: expected 'struct folio *' but argument is of type 'int'
    1193 | static inline int mem_cgroup_charge(struct folio *folio,
         |                                     ~~~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors


vim +875 mm/filemap.c

   855	
   856	noinline int __add_to_page_cache_locked(struct page *page,
   857						struct address_space *mapping,
   858						pgoff_t offset, gfp_t gfp,
   859						void **shadowp)
   860	{
   861		XA_STATE(xas, &mapping->i_pages, offset);
   862		int huge = PageHuge(page);
   863		int error;
   864		bool charged = false;
   865	
   866		VM_BUG_ON_PAGE(!PageLocked(page), page);
   867		VM_BUG_ON_PAGE(PageSwapBacked(page), page);
   868		mapping_set_update(&xas, mapping);
   869	
   870		get_page(page);
   871		page->mapping = mapping;
   872		page->index = offset;
   873	
   874		if (!huge) {
 > 875			error = mem_cgroup_charge(page_folio(page), NULL, gfp);
   876			if (error)
   877				goto error;
   878			charged = true;
   879		}
   880	
   881		gfp &= GFP_RECLAIM_MASK;
   882	
   883		do {
   884			unsigned int order = xa_get_order(xas.xa, xas.xa_index);
   885			void *entry, *old = NULL;
   886	
   887			if (order > thp_order(page))
   888				xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
   889						order, gfp);
   890			xas_lock_irq(&xas);
   891			xas_for_each_conflict(&xas, entry) {
   892				old = entry;
   893				if (!xa_is_value(entry)) {
   894					xas_set_err(&xas, -EEXIST);
   895					goto unlock;
   896				}
   897			}
   898	
   899			if (old) {
   900				if (shadowp)
   901					*shadowp = old;
   902				/* entry may have been split before we acquired lock */
   903				order = xa_get_order(xas.xa, xas.xa_index);
   904				if (order > thp_order(page)) {
   905					xas_split(&xas, old, order);
   906					xas_reset(&xas);
   907				}
   908			}
   909	
   910			xas_store(&xas, page);
   911			if (xas_error(&xas))
   912				goto unlock;
   913	
   914			mapping->nrpages++;
   915	
   916			/* hugetlb pages do not participate in page cache accounting */
   917			if (!huge)
   918				__inc_lruvec_page_state(page, NR_FILE_PAGES);
   919	unlock:
   920			xas_unlock_irq(&xas);
   921		} while (xas_nomem(&xas, gfp));
   922	
   923		if (xas_error(&xas)) {
   924			error = xas_error(&xas);
   925			if (charged)
   926				mem_cgroup_uncharge(page);
   927			goto error;
   928		}
   929	
   930		trace_mm_filemap_add_to_page_cache(page);
   931		return 0;
   932	error:
   933		page->mapping = NULL;
   934		/* Leave page->index set: truncation relies upon it */
   935		put_page(page);
   936		return error;
   937	}
   938	ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
   939	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--WIyZ46R2i8wDzkSu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICJ247GAAAy5jb25maWcAnFzbjts4k76fpxAywGIGyKFPySRY9AUtUTbHkqgWKR9yIzi2
umPEbffvw0yyT79VpGRREulkd4BJd7OKZJEsVn1VJPX7b7975HTcPS+O6+Vis/nhPZXbcr84
livvcb0p/9sLuJdw6dGAybfAHK23p+/vtqvD7Y33/u313durN/vltTcu99ty4/m77eP66QT1
17vtb7//5vMkZMPC94sJzQTjSSHpTN6/UvU35ZsNtvbmabn0/hj6/p/ep7e3b69eGdWYKIBw
/6MuGjZN3X+6ur26OvNGJBmeSediIlQTSd40AUU1283tXdNCFCDrIAwaViiysxqEK0PaEbRN
RFwMueRNKwaBJRFLaI+U8CLNeMgiWoRJQaTMGhaWPRRTno2bEjnKKAFhk5DDP4UkAokw2797
Q7V4G+9QHk8vzfwPMj6mSQHTL+LUaDphsqDJpCAZjInFTN7f3kArtXA8TlEkSYX01gdvuzti
w+dJ4D6J6ll49aqpZxIKkktuqTzIGcyhIJHEqlVhQEOSR1LJZSkecSETEtP7V39sd9vyT6NL
MSWp2UtDmIsJS30rbUqkPyoecppTK93PuBBFTGOezXFRiD+y8uWCRmxgktRawMJ5h9OXw4/D
sXxu1mJIE5oxX62rGPGpodsGxR+xtK0DAY8JS5qyEUkCWBxdjBxA+t0rtytv99jpu9uBZDEt
JjA1sE5Rv38fFnBMJzSRotYruX4u9wfbcEafixRq8YD5SoCqGDQaKAwktE6ZIlspIzYcFRkV
SshMtHmq0fWkUTIO0rAl4LlJIBTVYK3NtSvWA0szSuNUgqhqw55bq8snPMoTSbK5dRgVV08p
/DR/JxeHb94RxuAtQIDDcXE8eIvlcnfaHtfbp2ZqJfPHBVQoiO9z6IslQ1OQgQjQavgUlBQ4
pF0Owaxj/gU5lLyZn3uiv+ogy7wAmikP/FnQGSiDzVgIzWxWF3X9SqR2V027bKx/sY6PjUdg
CzuKcrZDaGdg7UcslPfXfzUryxI5BuMT0i7PrR61WH4tV6dNufcey8XxtC8PqrgS1EI1jMYw
43lqEwdNl0gJrJc5a7kE8y9cdiVz0VIWuEj+iPrjlMMYcR9Jntm3oAC+QJlnJbHLeoYC7C9o
s08kDaxMGY2IfRMMojFUnih7ntkrDziXRX99G/fIUzAE7DM4Rp6hpYEfMUn81pbssgn4xaaD
YANkZFZ0qmsM/obh/Dc6q+eiZzRDbYebgpQLNqusl1GqdK75e5APmz9oFMIcZEYjAyJgKHmr
oxygU+dPUAOjlZSb/IINExKZaEbJZBYoG28WiBF4OwMpMQPFMF7kmTZBNTmYMBCzmhJjsNDI
gGQZM6dvjCzzWPRL9GBRiySbtNYVF0C5/tCuPNANDYK2Wp6944QqdSnajqzCqWm5f9ztnxfb
ZenRf8otWD4Cm9tH2weuxfQeRiNWS/qLLdaCTWLdWKFMektHRJQPYL9o1WihMCIBwo3tWzQi
A5uuQ1tmK8gG65INaQ2nnK0VIfiuiAkwH6DaPP4FxhHJAgAP9lUSozwMAamkBDqHNQd0CEbJ
4TURBIOSWWe6DW7PZjUQtzcWEEMAk2VgtGC8YJ8sDCKP+6WjKQUAIo1Nk4HFRngVRmQI+z9P
U54ZdAGwcKyZerQQDAElWTSHv4vWzkqHkgxgTiLQBdg5N5XbUa7Pkz9eSvhbFaX73bI8HHZ7
L2w8Ua0ZAA0GuA2SgJGkpTNAiZiU0IMmWmc7THObzYW6PkBdXCtGRAd0IDW5fm93PIp2e4F2
5aQFF9oM2vUMyuTWsEZJAKhRKRna/+Ju3NoAXfLH8cDZIdPjD5jARXLL9X9im2ZMUgjdeD60
hxHTQUKsBFiHYRKjzQA9szvq0bTWviJPGn6AhYAO7ZIpoaIbV3NpGzYoZYzL593+h7fsBPnn
apNYpKB2xa3NlzdEdNbm0tSUGzvEq8nXtlbVgvIwFFTeX30fXOn/GpthFflsOjJcIHF/fXZc
sQFSlWFRgSrA1SKQAx3k1iDQ2KumZwlNwNjESNdXNh0Gws37K3MuoOT2yr5NdCv2Zu6hmZ5L
Cht0ipZk9y8gVnBQi6fyGfyTt3vByTDsCckgHBa5SMFmIIwRbBC1/HFFs5vu2Gqznb220hWL
/fLr+lguUdw3q/IFKlslhFUuQsNjKi+vxFYWeMS5AbFU+e3NAFQHFKSQnWoZBXMOVkFb8Gqr
FMREVJHkdfhXKwgP8gjsCCAThdoQtXTapTPoUKdojDxPBM0A0PHHU3CVwuLftaAI0Xrbbujz
yZsvi0O58r7plX3Z7x7XGx0sNu7xElvXh/5kxmu5wZ7ECDSpMekKrokYUfBVM4xqZmypHkwn
tALXKiwYCPuGN+idvIolspB0CIb1cvzxmbuwCXL4cYBJOTAlGeBNJ9t0YIdMSBMQSfGURE4G
nfcDZ+xnc4hUeNJb5HSxP65x8pVJaSNQkkkmVTItmGDsYwO8sQi4aFgNkB+yVnGzNTs96qQV
b8LblhDxA0QAOmYMQLVxONbRGnzj+cAxnzXHIHywWo22FE26Uk2iSMEc5wlqVZX2atNVclTT
L9GsdZWTdlU2iVVtNUP0e7k8HRdfNqVKmXsqDji2Zm/AkjCWaDLsKqLJws9Y6tAyzREz4VsW
H4PHIFep3fMcuqQyPXl8wRsA3pUtzKq9cCrV8JXfvOtYMb+r2YYKD3HyEaD00H0dDorYMrI6
9xvHJIXR4xYIsvu7q08fzm6agiJBkKaw1jhumdaIwnZBoGOHQLEdb31OObdv5c/K7HF7OhmT
nXqg6IzGrnGCqCgpeJ12QKlNfZ7qdPu2LFcH77jzvi7+KT0VFILng7XFBV2ZZt+9lEa6lfYz
kUH5zxpi1WC//qcb8fo+aadrGme9XlY1PH5WmCZe15HtiEapY+ODNZZxGtohKUxJEhD0lK6U
qmo+ZFkMXpTqM4SemOF6//zvYl96m91iVe4NhZ4WEcdcoWEbZ7BU5wZbhxhnbp2GuzCmhhM3
QdYD3NU6deU6wxRQqKlyU8Yu7saqGEbQCatzh6Yz76+IzoafDt5KLXHbjI8YzJtdQrNKU2OY
OCKIWNr8UCCN0zoemtuRh2A8ISq1HycBFU2OzCg1G9ABtJ005oO/WwVoHGD+W2UtM88RssF6
TsBmaONmSscnNHPlMsGFovW6hDN6qphMAM2J08vLbn80FwHLi9C3LkKrjrbV68PStpSgKvEc
h2fPjSWAOUUO2wSHi5pj33MZsSd4ZpiHmRUiCKnd3Pk33fnQzpCmGY+9Q3/UmlJ8uvVnH6xD
71TVB0/l98XBY9vDcX96Vlm1w1fYRCvvuF9sD8jnAcAtvRVM0voFfzVt4/+jtqpONkdAyV6Y
Dgk4z2rfrnb/bnHves87BCbeH/vyP6c1xFceu/H/bI3UH3G7Ek1SkjD7wreWWaeDfMGqEmM+
64UDIoLu1gkMYYE6PXaste84DLJ1ZKQfpN1NxnZILUk2pFIZM/vR3yTuKQ3bvpyOzqGyJM1b
CQNVUEBMB1s4ciU4NJNQqH4cO/ImmikmMmOzLpOSLD+U+w0ej60xjfu46OzBqj4HH9ExAB2W
v/n8MgOd/IwOEMAxcW5XruuO6XzAieMExhjCZfkFnkdeYFEZTbuBrBh47o8A41JqB4mVJB2I
22h3zO56aqUGO1rsV2qLsnfcQ91pzYHA42lri0MS075RrzaFrdFzfGLTV90n2JfFElTFsNj1
xpBGFnpipCPgh+CRgo2JwFMQ+NvkrBmMRMPUKGsSZdIgYMQQdDBoDdMSNvv0EZD8vJWIiOiQ
+HNVbJ2tKICVUQeGCHd6iyAAiiw23qqvhLgAJCo+3ry/6tVKdts3inDQ1ZVNtjiPqo0cAlmI
QhwnmppHsJBNLnP4fjJznHhqjoEff7idzS6xkEhSAI9/SzJEqX6B9WdslctNxU85SWbfIhU5
FFERpT9rRHFBWBnR2c9Y4S86I4C9AzZkPqy/HQnX05t2TU3tZ9oq0quYgOqqGMBhqpI8inAb
XepcJY66ALfeIAzCT17vELsNSmNWXa2xjxF22IVjMegdfJLdL/rwfzdL2oCtaO6C5X2TYnp8
FAUsRy6kOkvXkUjfT9z4tl2Fxdb8i8FucN86tC5ljvLYThh1cUgNj9J+RJzK1Ftudstvhvwa
aKpQ2EtHc0wSoouGKBcvyhVQpBKpoEtxiiYQwuhDWXrHr6W3WK1UzgvUULV6eGvixX5nhnAs
8WVmzwsMU8ZdqcrptX2sfAoRIwYjjos7io6HOpFd30fT2JFskSOaxY5kpLrzFnCbWxBiYM/6
C9sBM1hIYmUfdNIqOoY5bY7rx9N2qfKNleO0uIo4RAAbU7BOYJZ8xy5ruEaRH9iVEnli3AsO
8ArkEftwd3NdgJbamxhJH8I+wXz7kSY2MaZxGtmNlRJAfrj99JeTLOL3V3btUNS58B0rjGTJ
ChLf3r6fFVL45MIsyId49tEecV1cFsPK0GEeOQ/tM98N9mMaMFL41K+PJy9wWTh03mm/ePm6
Xh5sBizI+sEEgTIzXK7GahbrRNF+8Vx6X06Pj2Bag358HQ6sc2atplMui+W3zfrp69H7Lw/0
sh/PNFDKD/DCshBVVseeVSD+OMLLCBdY68zN5Z5117vtYbdRse7LZvGjWuZ+tKXTCj3I2SqG
n1EeA0r9eGWnZ3wq7m/eG07sJ72fU1rdxTbsEM+TPuwcscA2w1hsRfUG+xkPg+HjI5+1r0y0
LyINLitw7Nh+NHZHTQmdAuYO7FBFH0eyAUDCNt6pNx3YJvA4rehf+lpT7MgEjWEvD6QzwTEZ
5KFxAtBM+TzxC7yW7moSr07GfEIBukkW2h1VxaZy2JcYRpSkdgTUEdCYpXwGQUnqytnljrhv
EroIABDBprBJ7+ZxG0HGNMntdLyj3iNXabzlfnfYPR690Y+Xcv9m4j2dykM72Dmngi6zGsAj
o33ceA4r0a66Mu1D1/nEkEdByMTIonTqfNuPjJOxugST8ykxbzBC74BPKm6tUwpYVRv/cbdX
FjkrwYyWeGluVR7WT231Y76w7zfsUaQfu/eJalvzax21ZqqStSAzhj+HjhSFwRmyGSaRY4cq
VcHcxLcrymiKx5h4lNZTFC2+2J32LYzUDF2Ax8V+W9ebpJ8yeX11pW952q0R8zOODwsAy8oP
d3b3Zu3daIOwaMDtgTGDycmdbjwrn3fH8mW/W9qAX0ZjLjH/aw9ILJV1oy/Phydre2ks6u1q
b7FVs+NlpsySZRIg2x/VtR++hbBs/fKnd3gpl+vH8xnMoY5OyPNm9wTFYue3xKvBiIWsMcR+
t1gtd8+uila6zqTM0nfhviwPywX42Yfdnj24GvkZq+Jdv41nrgZ6NDMii9bHUlMHp/VmhV6+
niTLQmE2ZwazjiAykRmPeoF3fTrwy62r5h9Oiw3Mk3MirXRTDfCZTE8HZnid5rurTRv1nPv4
Je0x4r8YAV+YUcfxzkw6gwP1YMm+Qx3GKp1acvLZg7cEKS35+Oyhep7UmB8I2LpRlPEUqdWO
IU6KN69c/kvFxg6t0KmB0bz1NqVxYdWxKTJYhzsCpEoSnXD1Kbp7OwL342LME4L47+YnrQU0
8WkBMVJGE0dEb/AFv9KYINHEsV7Ahek7BpFd/IDiOdlicFMR/Juyy52mM1LcfExiTM7YwWyL
C2fEutztRTFqYz7DdxzDxL59ABnpo1WyXe1365W53iQJMu4A/DW7ATeJ3X0l3dSdji+meFi4
XG+frGlpac9Q4L20qJAjq0iWJo2oE88cbU2GjqSZYA53LCIWu/YWypfB7wl1vBurXifY4Xj7
uKm6dQG2WS96y7xPSMQCvIUfiksX7MCc3RSOayFAu71Au3PRMsrw/Yhw0f92k2Zu0jAUTkkH
8kJ3CYsuVA1v3DXxCVZbZ8+jR6QVtk5x6jJ97bLg1qdo6qUx0ju3+2NMvkt87mpyuISy32Y0
OcCwuu5mBhciRqZp6uaNvWlyofZDzh0n1nh2FQqnwmiycxXwzq+DVl0c6ZD1Plgsv3bySsJy
Ja1G35pbswdvMh6/CyaB2l2WzcUE//Thw5VLqjwIe6S6H3vbOh3AxbuQyHd0hv+CM3P0rm+c
OvqeQF33pr1ATKRlCWrDc0kyDQkO5Wm1UxceG4lrDwTBRdHeLKpo3M1emsTzm0GzUF3ygziQ
wVbpNQfQKAqydvxY0cc0S8zr6+pJodmA+26c/uGeGsvAzcBP6DQOdChp7Jj4yKFFCfN5YJsg
xotp69V5ywlUh8LL0359/GFLLo2p46BZUD9Hu1EEMRUKB0pAc64DSs17kRjabKBKXdQP15Sp
8Xk6bx6otV5ldNlcWRUJqBN5Ypix/pXB2vRVd1qbcRLjzlwk4vtXeOUEA/HX+A9ePHr9Y/G8
eI3Xj17W29eHxWMJDa5Xr/FayhPO8OsvL4+vWi9Rvi72q3KLKKOZfPPy73q7Pq4Xm/X/dD7W
ob4KoR9FdN++KxLeQ8dJOo/DYf9rZnwl6ORtX2LtitR50GIZUXO03FE0Y+ugk+I9wxytv+wX
0Od+dzqut90b9z3HV7t4JvEaKgCZ/i1NUNPEBxUK8Zpb+/GwyRLRpKYa2zsLXLA7w681JHk8
sL9yz9SFEdJ61+zjmYzPpAPbZf71BxelkNdXAbNfU0cyk3lhu74JNPUM02S+vQEdj0LHhc+K
IWI+Hcw/Wqpqyp1LFGQh2ZQ4boNoDlgvF/WDs2UnwX6UF7GB6sxxTzLzPzqCGzy7d8xRA0U/
w96x3fmvVco0WGdzJTAZZ17e10XqgWBM0nZ5EBtvmNR1eihBNmXRzDMgKAZhIpLhCdCIYqjb
eW+F7alTA+TFt/j60OFnXH6aW1iQiollS2dIAutUE9T7gDb1TMLb/G1SRnvcAcsgFDpTzLMJ
fBPWP73oroLkMQOValnL7KHAN/mWaqAyYdB9RRzQlHfLcB5GBVgHsBc358M2AWrdERR9ZDJ0
6FJlJHsmrzsKxjtTUxNA3gIEiQJ26yRmTmJ0iRjn7lb9OA2Y5XE30vIzse30lt/0uzhV+rIH
B/lN3Q5ZPZeHJxsOqT4H0n1616XjNw4c4YjxBlx/14jZbsb71dloxIfq2XftE+//cnI85IzK
+7vmuwpCIPTstXBnKOw8IaCJl47bTA730b2YxwMOJrigWYafLrFqlHN+qyPn5xeAhG/UN2Yg
sFl+OyjWpS7fWx4dZdBTMSVZcn99dXPXVu9UfUILPxlhP1LRH4IB3AHrYd11esQAu9RjOkDF
Md6GMXZch6IEAcgSzU2U+8ujar2aqfQzKL+cnp4Qwhi30ltRFRkyFXY47vWfnwJZsfpAdN/6
d56KXBSj2wvGK7Q1kSZ+PLfRRk5DfAIraSIuvgVLOQSviSu50HwJwwUuFUfvDZUJ7ashqCvi
xDiy1OXVV73Ul8a6X2MbE5jF2tb0qHjFDC1twoGLSfyWQPPspAtomzmq3lzBnx7fvRxeexEg
+9OLVp3RYvvUAaAQdSF45vYETouOSbacNh+i00S0ZzyX98a78Mvd64Dt/G2j9vL2Pn1kjqyt
NdjxmNK0s7gadOPhYqN8fxwgmlHX8F57z6dj+b2EX8rj/1ZyNTsIgzD4VXwC3mEhmR5ECY7t
TCbxaKLG57c/w1GpMZ7ZGmih/VroNxtjREPFNHEb8o/w9ofwz0kXgg9F16t3r+MtuQZwM5Af
nwAyAWhqn4VWNl86ss/pkTZ44OaGJIA3O+SCA2KXEKJSWRN2/CKS70Vt1A0oB8SB6eOB3R+t
VcDJenQbOr/TvymRpS/aEgI4QDqqLAPQwpRH0qwQfnlzqKz1MvpR9wKd83vlRQvTU9YKqDHC
kO9IcEZb316f+ZYuWRQmsEtNC+DsAODY2+O4EMN4wXoXkKXNMWMirqZ9JyITWn0mTdbLkOYF
2bTz26tTAAA=

--WIyZ46R2i8wDzkSu--
