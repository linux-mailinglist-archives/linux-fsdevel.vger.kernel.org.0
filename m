Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E893CFAB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 15:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbhGTMzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 08:55:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:2594 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238679AbhGTMvN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:51:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211234036"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="gz'50?scan'50,208,50";a="211234036"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 06:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="gz'50?scan'50,208,50";a="454095384"
Received: from lkp-server02.sh.intel.com (HELO 1b5a72ed9419) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Jul 2021 06:31:35 -0700
Received: from kbuild by 1b5a72ed9419 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5pqQ-0000HE-El; Tue, 20 Jul 2021 13:31:34 +0000
Date:   Tue, 20 Jul 2021 21:30:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v15 17/17] iomap: Convert iomap_migrate_page to use folios
Message-ID: <202107202157.rCXldl6H-lkp@intel.com>
References: <20210719184001.1750630-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-18-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Matthew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.14-rc2 next-20210720]
[cannot apply to xfs-linux/for-next block/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/Folio-support-in-block-iomap-layers/20210720-152323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
config: openrisc-randconfig-p002-20210720 (attached as .config)
compiler: or1k-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c560a69342e882de7f1fd097fa2589e8d330eba0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Folio-support-in-block-iomap-layers/20210720-152323
        git checkout c560a69342e882de7f1fd097fa2589e8d330eba0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

         |                                  ^
   include/asm-generic/bug.h:65:36: note: in expansion of macro 'unlikely'
      65 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
         |                                    ^~~~~~~~
   fs/iomap/buffered-io.c:207:2: note: in expansion of macro 'BUG_ON'
     207 |  BUG_ON(folio->index);
         |  ^~~~~~
   fs/iomap/buffered-io.c:207:14: error: invalid use of undefined type 'struct folio'
     207 |  BUG_ON(folio->index);
         |              ^~
   include/linux/compiler.h:35:19: note: in definition of macro '__branch_check__'
      35 |           expect, is_constant); \
         |                   ^~~~~~~~~~~
   include/asm-generic/bug.h:65:36: note: in expansion of macro 'unlikely'
      65 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
         |                                    ^~~~~~~~
   fs/iomap/buffered-io.c:207:2: note: in expansion of macro 'BUG_ON'
     207 |  BUG_ON(folio->index);
         |  ^~~~~~
   fs/iomap/buffered-io.c:208:9: error: implicit declaration of function 'folio_multi' [-Werror=implicit-function-declaration]
     208 |  BUG_ON(folio_multi(folio));
         |         ^~~~~~~~~~~
   include/linux/compiler.h:33:34: note: in definition of macro '__branch_check__'
      33 |    ______r = __builtin_expect(!!(x), expect); \
         |                                  ^
   include/asm-generic/bug.h:65:36: note: in expansion of macro 'unlikely'
      65 | #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
         |                                    ^~~~~~~~
   fs/iomap/buffered-io.c:208:2: note: in expansion of macro 'BUG_ON'
     208 |  BUG_ON(folio_multi(folio));
         |  ^~~~~~
   fs/iomap/buffered-io.c:211:9: error: implicit declaration of function 'kmap_local_folio'; did you mean 'kmap_local_fork'? [-Werror=implicit-function-declaration]
     211 |  addr = kmap_local_folio(folio, 0);
         |         ^~~~~~~~~~~~~~~~
         |         kmap_local_fork
   fs/iomap/buffered-io.c:211:7: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     211 |  addr = kmap_local_folio(folio, 0);
         |       ^
   fs/iomap/buffered-io.c: In function 'iomap_readpage_actor':
   fs/iomap/buffered-io.c:251:19: error: invalid use of undefined type 'struct folio'
     251 |   zero_user(&folio->page, poff, plen);
         |                   ^~
   fs/iomap/buffered-io.c:263:44: error: invalid use of undefined type 'struct folio'
     263 |   if (__bio_try_merge_page(ctx->bio, &folio->page, plen, poff,
         |                                            ^~
   fs/iomap/buffered-io.c:270:43: error: invalid use of undefined type 'struct folio'
     270 |   gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
         |                                           ^~
   fs/iomap/buffered-io.c: In function 'iomap_readpage':
   fs/iomap/buffered-io.c:309:24: warning: initialization of 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     309 |  struct folio *folio = page_folio(page);
         |                        ^~~~~~~~~~
   fs/iomap/buffered-io.c:311:29: error: invalid use of undefined type 'struct folio'
     311 |  struct inode *inode = folio->mapping->host;
         |                             ^~
   fs/iomap/buffered-io.c:319:28: error: implicit declaration of function 'folio_pos' [-Werror=implicit-function-declaration]
     319 |   ret = iomap_apply(inode, folio_pos(folio) + poff, len - poff,
         |                            ^~~~~~~~~
   fs/iomap/buffered-io.c: In function 'iomap_readahead_actor':
   fs/iomap/buffered-io.c:360:21: error: implicit declaration of function 'readahead_folio'; did you mean 'readahead_count'? [-Werror=implicit-function-declaration]
     360 |    ctx->cur_folio = readahead_folio(ctx->rac);
         |                     ^~~~~~~~~~~~~~~
         |                     readahead_count
   fs/iomap/buffered-io.c:360:19: warning: assignment to 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     360 |    ctx->cur_folio = readahead_folio(ctx->rac);
         |                   ^
   fs/iomap/buffered-io.c: In function 'iomap_is_partially_uptodate':
   fs/iomap/buffered-io.c:427:24: warning: initialization of 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     427 |  struct folio *folio = page_folio(page);
         |                        ^~~~~~~~~~
   fs/iomap/buffered-io.c: In function 'iomap_releasepage':
   fs/iomap/buffered-io.c:454:24: warning: initialization of 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     454 |  struct folio *folio = page_folio(page);
         |                        ^~~~~~~~~~
   fs/iomap/buffered-io.c:456:31: error: invalid use of undefined type 'struct folio'
     456 |  trace_iomap_releasepage(folio->mapping->host, folio_pos(folio),
         |                               ^~
   fs/iomap/buffered-io.c:464:6: error: implicit declaration of function 'folio_test_dirty' [-Werror=implicit-function-declaration]
     464 |  if (folio_test_dirty(folio) || folio_test_writeback(folio))
         |      ^~~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c:464:33: error: implicit declaration of function 'folio_test_writeback' [-Werror=implicit-function-declaration]
     464 |  if (folio_test_dirty(folio) || folio_test_writeback(folio))
         |                                 ^~~~~~~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c: In function 'iomap_invalidatepage':
   fs/iomap/buffered-io.c:474:24: warning: initialization of 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     474 |  struct folio *folio = page_folio(page);
         |                        ^~~~~~~~~~
   fs/iomap/buffered-io.c:476:34: error: invalid use of undefined type 'struct folio'
     476 |  trace_iomap_invalidatepage(folio->mapping->host, offset, len);
         |                                  ^~
   fs/iomap/buffered-io.c:484:3: error: implicit declaration of function 'folio_cancel_dirty' [-Werror=implicit-function-declaration]
     484 |   folio_cancel_dirty(folio);
         |   ^~~~~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c: In function 'iomap_migrate_page':
   fs/iomap/buffered-io.c:495:24: warning: initialization of 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     495 |  struct folio *folio = page_folio(page);
         |                        ^~~~~~~~~~
   fs/iomap/buffered-io.c:496:27: warning: initialization of 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     496 |  struct folio *newfolio = page_folio(newpage);
         |                           ^~~~~~~~~~
>> fs/iomap/buffered-io.c:499:8: error: implicit declaration of function 'folio_migrate_mapping' [-Werror=implicit-function-declaration]
     499 |  ret = folio_migrate_mapping(mapping, newfolio, folio, 0);
         |        ^~~~~~~~~~~~~~~~~~~~~
>> fs/iomap/buffered-io.c:507:3: error: implicit declaration of function 'folio_migrate_copy' [-Werror=implicit-function-declaration]
     507 |   folio_migrate_copy(newfolio, folio);
         |   ^~~~~~~~~~~~~~~~~~
>> fs/iomap/buffered-io.c:509:3: error: implicit declaration of function 'folio_migrate_flags'; did you mean 'do_migrate_pages'? [-Werror=implicit-function-declaration]
     509 |   folio_migrate_flags(newfolio, folio);
         |   ^~~~~~~~~~~~~~~~~~~
         |   do_migrate_pages
   fs/iomap/buffered-io.c: In function '__iomap_write_begin':
   fs/iomap/buffered-io.c:559:2: error: implicit declaration of function 'folio_clear_error' [-Werror=implicit-function-declaration]
     559 |  folio_clear_error(folio);
         |  ^~~~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c:575:29: error: invalid use of undefined type 'struct folio'
     575 |    zero_user_segments(&folio->page, poff, from, to,
         |                             ^~
   fs/iomap/buffered-io.c: In function 'iomap_write_begin':
   fs/iomap/buffered-io.c:596:52: error: 'FGP_STABLE' undeclared (first use in this function)
     596 |  unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
         |                                                    ^~~~~~~~~~
   fs/iomap/buffered-io.c:596:52: note: each undeclared identifier is reported only once for each function it appears in
   fs/iomap/buffered-io.c:612:10: error: implicit declaration of function '__filemap_get_folio' [-Werror=implicit-function-declaration]
     612 |  folio = __filemap_get_folio(inode->i_mapping, pos >> PAGE_SHIFT, fgp,
         |          ^~~~~~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c:612:8: warning: assignment to 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     612 |  folio = __filemap_get_folio(inode->i_mapping, pos >> PAGE_SHIFT, fgp,
         |        ^
   fs/iomap/buffered-io.c:619:9: error: implicit declaration of function 'folio_file_page' [-Werror=implicit-function-declaration]
     619 |  page = folio_file_page(folio, pos >> PAGE_SHIFT);
         |         ^~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c:619:7: warning: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     619 |  page = folio_file_page(folio, pos >> PAGE_SHIFT);
         |       ^
   fs/iomap/buffered-io.c:636:2: error: implicit declaration of function 'folio_put'; did you mean 'bio_put'? [-Werror=implicit-function-declaration]
     636 |  folio_put(folio);
         |  ^~~~~~~~~
         |  bio_put
   fs/iomap/buffered-io.c: In function '__iomap_write_end':
   fs/iomap/buffered-io.c:649:2: error: implicit declaration of function 'flush_dcache_folio'; did you mean 'flush_cache_all'? [-Werror=implicit-function-declaration]
     649 |  flush_dcache_folio(folio);
         |  ^~~~~~~~~~~~~~~~~~
         |  flush_cache_all
   fs/iomap/buffered-io.c:665:2: error: implicit declaration of function 'filemap_dirty_folio' [-Werror=implicit-function-declaration]
     665 |  filemap_dirty_folio(inode->i_mapping, folio);
         |  ^~~~~~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c: In function 'iomap_write_end_inline':
   fs/iomap/buffered-io.c:678:7: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     678 |  addr = kmap_local_folio(folio, 0);
         |       ^
   fs/iomap/buffered-io.c: In function 'iomap_write_end':
   fs/iomap/buffered-io.c:691:22: warning: initialization of 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     691 |  struct page *page = folio_file_page(folio, pos >> PAGE_SHIFT);
         |                      ^~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c: In function 'iomap_write_actor':
   fs/iomap/buffered-io.c:765:8: warning: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     765 |   page = folio_file_page(folio, pos >> PAGE_SHIFT);
         |        ^
   fs/iomap/buffered-io.c: In function 'iomap_zero':
   fs/iomap/buffered-io.c:891:12: warning: passing argument 1 of 'zero_user' makes pointer from integer without a cast [-Wint-conversion]
     891 |  zero_user(folio_file_page(folio, pos >> PAGE_SHIFT), offset, bytes);
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |            |
         |            int
   In file included from include/linux/bio.h:8,
                    from include/linux/blkdev.h:18,
                    from include/linux/iomap.h:11,
                    from fs/iomap/buffered-io.c:9:
   include/linux/highmem.h:231:43: note: expected 'struct page *' but argument is of type 'int'
     231 | static inline void zero_user(struct page *page,
         |                              ~~~~~~~~~~~~~^~~~
   fs/iomap/buffered-io.c:892:2: error: implicit declaration of function 'folio_mark_accessed' [-Werror=implicit-function-declaration]
     892 |  folio_mark_accessed(folio);
         |  ^~~~~~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c: In function 'iomap_folio_mkwrite_actor':
   fs/iomap/buffered-io.c:970:39: error: invalid use of undefined type 'struct folio'
     970 |   ret = __block_write_begin_int(&folio->page, pos, length, NULL,
         |                                       ^~
   fs/iomap/buffered-io.c:974:28: error: invalid use of undefined type 'struct folio'
     974 |   block_commit_write(&folio->page, 0, length);
         |                            ^~
   fs/iomap/buffered-io.c:977:3: error: implicit declaration of function 'folio_mark_dirty' [-Werror=implicit-function-declaration]
     977 |   folio_mark_dirty(folio);
         |   ^~~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c: In function 'iomap_page_mkwrite':
   fs/iomap/buffered-io.c:985:24: warning: initialization of 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     985 |  struct folio *folio = page_folio(vmf->page);
         |                        ^~~~~~~~~~
   fs/iomap/buffered-io.c:991:2: error: implicit declaration of function 'folio_lock'; did you mean 'osq_lock'? [-Werror=implicit-function-declaration]
     991 |  folio_lock(folio);
         |  ^~~~~~~~~~
         |  osq_lock
   fs/iomap/buffered-io.c:992:8: error: implicit declaration of function 'folio_mkwrite_check_truncate'; did you mean 'page_mkwrite_check_truncate'? [-Werror=implicit-function-declaration]
     992 |  ret = folio_mkwrite_check_truncate(folio, inode);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |        page_mkwrite_check_truncate
   fs/iomap/buffered-io.c:1008:2: error: implicit declaration of function 'folio_wait_stable' [-Werror=implicit-function-declaration]
    1008 |  folio_wait_stable(folio);
         |  ^~~~~~~~~~~~~~~~~
   fs/iomap/buffered-io.c: In function 'iomap_finish_folio_write':
   fs/iomap/buffered-io.c:1030:3: error: implicit declaration of function 'folio_end_writeback'; did you mean 'file_end_write'? [-Werror=implicit-function-declaration]
    1030 |   folio_end_writeback(folio);
         |   ^~~~~~~~~~~~~~~~~~~
         |   file_end_write
   fs/iomap/buffered-io.c: In function 'iomap_add_to_ioend':
   fs/iomap/buffered-io.c:1280:38: error: invalid use of undefined type 'struct folio'
    1280 |  wbc_account_cgroup_owner(wbc, &folio->page, len);


vim +/folio_migrate_mapping +499 fs/iomap/buffered-io.c

   489	
   490	#ifdef CONFIG_MIGRATION
   491	int
   492	iomap_migrate_page(struct address_space *mapping, struct page *newpage,
   493			struct page *page, enum migrate_mode mode)
   494	{
   495		struct folio *folio = page_folio(page);
   496		struct folio *newfolio = page_folio(newpage);
   497		int ret;
   498	
 > 499		ret = folio_migrate_mapping(mapping, newfolio, folio, 0);
   500		if (ret != MIGRATEPAGE_SUCCESS)
   501			return ret;
   502	
   503		if (folio_test_private(folio))
   504			folio_attach_private(newfolio, folio_detach_private(folio));
   505	
   506		if (mode != MIGRATE_SYNC_NO_COPY)
 > 507			folio_migrate_copy(newfolio, folio);
   508		else
 > 509			folio_migrate_flags(newfolio, folio);
   510		return MIGRATEPAGE_SUCCESS;
   511	}
   512	EXPORT_SYMBOL_GPL(iomap_migrate_page);
   513	#endif /* CONFIG_MIGRATION */
   514	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ikeVEW9yuYc//A+q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
m3tPkeSGVqkcJy2kWIrr/w9ZccHbklwBAA==

--ikeVEW9yuYc//A+q--
