Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0C32E05A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCEEFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:05:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:15030 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhCEEFC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:05:02 -0500
IronPort-SDR: 5kX5WAEHUHnHmleB1zrvQcFqI8Rfiouf/+BdhCY4mVqx8IJe57T3jP4EZzASRID2hqoSpEJF9a
 PCv4p9YNPGRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="184184750"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="gz'50?scan'50,208,50";a="184184750"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 20:05:00 -0800
IronPort-SDR: /SaMz328p4LBIz4QU9CcrRTJj1+e1VSmdudE+v/wIrdZkJkyWH0o3CfkavaNltWUt3yrH2QmGJ
 ro77nuiNLE1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="gz'50?scan'50,208,50";a="518909844"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Mar 2021 20:04:56 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lI1hw-0002ZE-8o; Fri, 05 Mar 2021 04:04:56 +0000
Date:   Fri, 5 Mar 2021 12:04:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@01.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com
Subject: Re: [PATCH v22 09/10] fs/ntfs3: Add NTFS3 in fs/Kconfig and
 fs/Makefile
Message-ID: <202103051151.Ab56fnLC-lkp@intel.com>
References: <20210301160102.2884774-10-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20210301160102.2884774-10-almaz.alexandrovich@paragon-software.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Konstantin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8]

url:    https://github.com/0day-ci/linux/commits/Konstantin-Komarov/NTFS-read-write-driver-GPL-implementation-by-Paragon-Software/20210302-000938
base:   fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
config: openrisc-randconfig-r031-20210305 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/94dd419cbcd18faff52a6d852f2571684175a98f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Konstantin-Komarov/NTFS-read-write-driver-GPL-implementation-by-Paragon-Software/20210302-000938
        git checkout 94dd419cbcd18faff52a6d852f2571684175a98f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/ntfs3/attrib.c: In function 'attr_data_get_block':
>> fs/ntfs3/attrib.c:834:6: warning: variable 'new_size' set but not used [-Wunused-but-set-variable]
     834 |  u64 new_size, total_size;
         |      ^~~~~~~~
--
>> fs/ntfs3/index.c:554:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     554 | static const inline struct NTFS_DE *hdr_find_split(const struct INDEX_HDR *hdr)
         | ^~~~~~
   fs/ntfs3/index.c:585:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     585 | static const inline struct NTFS_DE *
         | ^~~~~~
   fs/ntfs3/index.c: In function 'indx_add_allocate':
>> fs/ntfs3/index.c:1465:17: warning: variable 'alloc_size' set but not used [-Wunused-but-set-variable]
    1465 |  u64 data_size, alloc_size;
         |                 ^~~~~~~~~~
   fs/ntfs3/index.c: In function 'indx_insert_into_root':
>> fs/ntfs3/index.c:1555:8: warning: variable 'next' set but not used [-Wunused-but-set-variable]
    1555 |  char *next;
         |        ^~~~
>> fs/ntfs3/index.c:1552:40: warning: variable 'aoff' set but not used [-Wunused-but-set-variable]
    1552 |  u32 hdr_used, hdr_total, asize, used, aoff, to_move;
         |                                        ^~~~
--
   fs/ntfs3/run.c: In function 'run_packed_size':
>> fs/ntfs3/run.c:603:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     603 |  return (const u8 *)n + sizeof(n) - p;
         |         ^


vim +/new_size +834 fs/ntfs3/attrib.c

10063fbe42995c Konstantin Komarov 2021-03-01   822  
10063fbe42995c Konstantin Komarov 2021-03-01   823  int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
10063fbe42995c Konstantin Komarov 2021-03-01   824  			CLST *len, bool *new)
10063fbe42995c Konstantin Komarov 2021-03-01   825  {
10063fbe42995c Konstantin Komarov 2021-03-01   826  	int err = 0;
10063fbe42995c Konstantin Komarov 2021-03-01   827  	struct runs_tree *run = &ni->file.run;
10063fbe42995c Konstantin Komarov 2021-03-01   828  	struct ntfs_sb_info *sbi;
10063fbe42995c Konstantin Komarov 2021-03-01   829  	u8 cluster_bits;
10063fbe42995c Konstantin Komarov 2021-03-01   830  	struct ATTRIB *attr = NULL, *attr_b;
10063fbe42995c Konstantin Komarov 2021-03-01   831  	struct ATTR_LIST_ENTRY *le, *le_b;
10063fbe42995c Konstantin Komarov 2021-03-01   832  	struct mft_inode *mi, *mi_b;
10063fbe42995c Konstantin Komarov 2021-03-01   833  	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end;
10063fbe42995c Konstantin Komarov 2021-03-01  @834  	u64 new_size, total_size;
10063fbe42995c Konstantin Komarov 2021-03-01   835  	u32 clst_per_frame;
10063fbe42995c Konstantin Komarov 2021-03-01   836  	bool ok;
10063fbe42995c Konstantin Komarov 2021-03-01   837  
10063fbe42995c Konstantin Komarov 2021-03-01   838  	if (new)
10063fbe42995c Konstantin Komarov 2021-03-01   839  		*new = false;
10063fbe42995c Konstantin Komarov 2021-03-01   840  
10063fbe42995c Konstantin Komarov 2021-03-01   841  	down_read(&ni->file.run_lock);
10063fbe42995c Konstantin Komarov 2021-03-01   842  	ok = run_lookup_entry(run, vcn, lcn, len, NULL);
10063fbe42995c Konstantin Komarov 2021-03-01   843  	up_read(&ni->file.run_lock);
10063fbe42995c Konstantin Komarov 2021-03-01   844  
10063fbe42995c Konstantin Komarov 2021-03-01   845  	if (ok && (*lcn != SPARSE_LCN || !new)) {
10063fbe42995c Konstantin Komarov 2021-03-01   846  		/* normal way */
10063fbe42995c Konstantin Komarov 2021-03-01   847  		return 0;
10063fbe42995c Konstantin Komarov 2021-03-01   848  	}
10063fbe42995c Konstantin Komarov 2021-03-01   849  
10063fbe42995c Konstantin Komarov 2021-03-01   850  	if (!clen)
10063fbe42995c Konstantin Komarov 2021-03-01   851  		clen = 1;
10063fbe42995c Konstantin Komarov 2021-03-01   852  
10063fbe42995c Konstantin Komarov 2021-03-01   853  	if (ok && clen > *len)
10063fbe42995c Konstantin Komarov 2021-03-01   854  		clen = *len;
10063fbe42995c Konstantin Komarov 2021-03-01   855  
10063fbe42995c Konstantin Komarov 2021-03-01   856  	sbi = ni->mi.sbi;
10063fbe42995c Konstantin Komarov 2021-03-01   857  	cluster_bits = sbi->cluster_bits;
10063fbe42995c Konstantin Komarov 2021-03-01   858  	new_size = ((u64)vcn + clen) << cluster_bits;
10063fbe42995c Konstantin Komarov 2021-03-01   859  
10063fbe42995c Konstantin Komarov 2021-03-01   860  	ni_lock(ni);
10063fbe42995c Konstantin Komarov 2021-03-01   861  	down_write(&ni->file.run_lock);
10063fbe42995c Konstantin Komarov 2021-03-01   862  
10063fbe42995c Konstantin Komarov 2021-03-01   863  	le_b = NULL;
10063fbe42995c Konstantin Komarov 2021-03-01   864  	attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL, 0, NULL, &mi_b);
10063fbe42995c Konstantin Komarov 2021-03-01   865  	if (!attr_b) {
10063fbe42995c Konstantin Komarov 2021-03-01   866  		err = -ENOENT;
10063fbe42995c Konstantin Komarov 2021-03-01   867  		goto out;
10063fbe42995c Konstantin Komarov 2021-03-01   868  	}
10063fbe42995c Konstantin Komarov 2021-03-01   869  
10063fbe42995c Konstantin Komarov 2021-03-01   870  	if (!attr_b->non_res) {
10063fbe42995c Konstantin Komarov 2021-03-01   871  		*lcn = RESIDENT_LCN;
10063fbe42995c Konstantin Komarov 2021-03-01   872  		*len = 1;
10063fbe42995c Konstantin Komarov 2021-03-01   873  		goto out;
10063fbe42995c Konstantin Komarov 2021-03-01   874  	}
10063fbe42995c Konstantin Komarov 2021-03-01   875  
10063fbe42995c Konstantin Komarov 2021-03-01   876  	asize = le64_to_cpu(attr_b->nres.alloc_size) >> sbi->cluster_bits;
10063fbe42995c Konstantin Komarov 2021-03-01   877  	if (vcn >= asize) {
10063fbe42995c Konstantin Komarov 2021-03-01   878  		err = -EINVAL;
10063fbe42995c Konstantin Komarov 2021-03-01   879  		goto out;
10063fbe42995c Konstantin Komarov 2021-03-01   880  	}
10063fbe42995c Konstantin Komarov 2021-03-01   881  
10063fbe42995c Konstantin Komarov 2021-03-01   882  	clst_per_frame = 1u << attr_b->nres.c_unit;
10063fbe42995c Konstantin Komarov 2021-03-01   883  	to_alloc = (clen + clst_per_frame - 1) & ~(clst_per_frame - 1);
10063fbe42995c Konstantin Komarov 2021-03-01   884  
10063fbe42995c Konstantin Komarov 2021-03-01   885  	if (vcn + to_alloc > asize)
10063fbe42995c Konstantin Komarov 2021-03-01   886  		to_alloc = asize - vcn;
10063fbe42995c Konstantin Komarov 2021-03-01   887  
10063fbe42995c Konstantin Komarov 2021-03-01   888  	svcn = le64_to_cpu(attr_b->nres.svcn);
10063fbe42995c Konstantin Komarov 2021-03-01   889  	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
10063fbe42995c Konstantin Komarov 2021-03-01   890  
10063fbe42995c Konstantin Komarov 2021-03-01   891  	attr = attr_b;
10063fbe42995c Konstantin Komarov 2021-03-01   892  	le = le_b;
10063fbe42995c Konstantin Komarov 2021-03-01   893  	mi = mi_b;
10063fbe42995c Konstantin Komarov 2021-03-01   894  
10063fbe42995c Konstantin Komarov 2021-03-01   895  	if (le_b && (vcn < svcn || evcn1 <= vcn)) {
10063fbe42995c Konstantin Komarov 2021-03-01   896  		attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0, &vcn,
10063fbe42995c Konstantin Komarov 2021-03-01   897  				    &mi);
10063fbe42995c Konstantin Komarov 2021-03-01   898  		if (!attr) {
10063fbe42995c Konstantin Komarov 2021-03-01   899  			err = -EINVAL;
10063fbe42995c Konstantin Komarov 2021-03-01   900  			goto out;
10063fbe42995c Konstantin Komarov 2021-03-01   901  		}
10063fbe42995c Konstantin Komarov 2021-03-01   902  		svcn = le64_to_cpu(attr->nres.svcn);
10063fbe42995c Konstantin Komarov 2021-03-01   903  		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
10063fbe42995c Konstantin Komarov 2021-03-01   904  	}
10063fbe42995c Konstantin Komarov 2021-03-01   905  
10063fbe42995c Konstantin Komarov 2021-03-01   906  	err = attr_load_runs(attr, ni, run, NULL);
10063fbe42995c Konstantin Komarov 2021-03-01   907  	if (err)
10063fbe42995c Konstantin Komarov 2021-03-01   908  		goto out;
10063fbe42995c Konstantin Komarov 2021-03-01   909  
10063fbe42995c Konstantin Komarov 2021-03-01   910  	if (!ok) {
10063fbe42995c Konstantin Komarov 2021-03-01   911  		ok = run_lookup_entry(run, vcn, lcn, len, NULL);
10063fbe42995c Konstantin Komarov 2021-03-01   912  		if (ok && (*lcn != SPARSE_LCN || !new)) {
10063fbe42995c Konstantin Komarov 2021-03-01   913  			/* normal way */
10063fbe42995c Konstantin Komarov 2021-03-01   914  			err = 0;
10063fbe42995c Konstantin Komarov 2021-03-01   915  			goto ok;
10063fbe42995c Konstantin Komarov 2021-03-01   916  		}
10063fbe42995c Konstantin Komarov 2021-03-01   917  
10063fbe42995c Konstantin Komarov 2021-03-01   918  		if (!ok && !new) {
10063fbe42995c Konstantin Komarov 2021-03-01   919  			*len = 0;
10063fbe42995c Konstantin Komarov 2021-03-01   920  			err = 0;
10063fbe42995c Konstantin Komarov 2021-03-01   921  			goto ok;
10063fbe42995c Konstantin Komarov 2021-03-01   922  		}
10063fbe42995c Konstantin Komarov 2021-03-01   923  
10063fbe42995c Konstantin Komarov 2021-03-01   924  		if (ok && clen > *len) {
10063fbe42995c Konstantin Komarov 2021-03-01   925  			clen = *len;
10063fbe42995c Konstantin Komarov 2021-03-01   926  			new_size = ((u64)vcn + clen) << cluster_bits;
10063fbe42995c Konstantin Komarov 2021-03-01   927  			to_alloc = (clen + clst_per_frame - 1) &
10063fbe42995c Konstantin Komarov 2021-03-01   928  				   ~(clst_per_frame - 1);
10063fbe42995c Konstantin Komarov 2021-03-01   929  		}
10063fbe42995c Konstantin Komarov 2021-03-01   930  	}
10063fbe42995c Konstantin Komarov 2021-03-01   931  
10063fbe42995c Konstantin Komarov 2021-03-01   932  	if (!is_attr_ext(attr_b)) {
10063fbe42995c Konstantin Komarov 2021-03-01   933  		err = -EINVAL;
10063fbe42995c Konstantin Komarov 2021-03-01   934  		goto out;
10063fbe42995c Konstantin Komarov 2021-03-01   935  	}
10063fbe42995c Konstantin Komarov 2021-03-01   936  
10063fbe42995c Konstantin Komarov 2021-03-01   937  	/* Get the last lcn to allocate from */
10063fbe42995c Konstantin Komarov 2021-03-01   938  	hint = 0;
10063fbe42995c Konstantin Komarov 2021-03-01   939  
10063fbe42995c Konstantin Komarov 2021-03-01   940  	if (vcn > evcn1) {
10063fbe42995c Konstantin Komarov 2021-03-01   941  		if (!run_add_entry(run, evcn1, SPARSE_LCN, vcn - evcn1,
10063fbe42995c Konstantin Komarov 2021-03-01   942  				   false)) {
10063fbe42995c Konstantin Komarov 2021-03-01   943  			err = -ENOMEM;
10063fbe42995c Konstantin Komarov 2021-03-01   944  			goto out;
10063fbe42995c Konstantin Komarov 2021-03-01   945  		}
10063fbe42995c Konstantin Komarov 2021-03-01   946  	} else if (vcn && !run_lookup_entry(run, vcn - 1, &hint, NULL, NULL)) {
10063fbe42995c Konstantin Komarov 2021-03-01   947  		hint = -1;
10063fbe42995c Konstantin Komarov 2021-03-01   948  	}
10063fbe42995c Konstantin Komarov 2021-03-01   949  
10063fbe42995c Konstantin Komarov 2021-03-01   950  	err = attr_allocate_clusters(
10063fbe42995c Konstantin Komarov 2021-03-01   951  		sbi, run, vcn, hint + 1, to_alloc, NULL, 0, len,
10063fbe42995c Konstantin Komarov 2021-03-01   952  		(sbi->record_size - le32_to_cpu(mi->mrec->used) + 8) / 3 + 1,
10063fbe42995c Konstantin Komarov 2021-03-01   953  		lcn);
10063fbe42995c Konstantin Komarov 2021-03-01   954  	if (err)
10063fbe42995c Konstantin Komarov 2021-03-01   955  		goto out;
10063fbe42995c Konstantin Komarov 2021-03-01   956  	*new = true;
10063fbe42995c Konstantin Komarov 2021-03-01   957  
10063fbe42995c Konstantin Komarov 2021-03-01   958  	end = vcn + *len;
10063fbe42995c Konstantin Komarov 2021-03-01   959  
10063fbe42995c Konstantin Komarov 2021-03-01   960  	total_size = le64_to_cpu(attr_b->nres.total_size) +
10063fbe42995c Konstantin Komarov 2021-03-01   961  		     ((u64)*len << cluster_bits);
10063fbe42995c Konstantin Komarov 2021-03-01   962  
10063fbe42995c Konstantin Komarov 2021-03-01   963  repack:
10063fbe42995c Konstantin Komarov 2021-03-01   964  	err = mi_pack_runs(mi, attr, run, max(end, evcn1) - svcn);
10063fbe42995c Konstantin Komarov 2021-03-01   965  	if (err)
10063fbe42995c Konstantin Komarov 2021-03-01   966  		goto out;
10063fbe42995c Konstantin Komarov 2021-03-01   967  
10063fbe42995c Konstantin Komarov 2021-03-01   968  	attr_b->nres.total_size = cpu_to_le64(total_size);
10063fbe42995c Konstantin Komarov 2021-03-01   969  	inode_set_bytes(&ni->vfs_inode, total_size);
10063fbe42995c Konstantin Komarov 2021-03-01   970  	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
10063fbe42995c Konstantin Komarov 2021-03-01   971  
10063fbe42995c Konstantin Komarov 2021-03-01   972  	mi_b->dirty = true;
10063fbe42995c Konstantin Komarov 2021-03-01   973  	mark_inode_dirty(&ni->vfs_inode);
10063fbe42995c Konstantin Komarov 2021-03-01   974  
10063fbe42995c Konstantin Komarov 2021-03-01   975  	/* stored [vcn : next_svcn) from [vcn : end) */
10063fbe42995c Konstantin Komarov 2021-03-01   976  	next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
10063fbe42995c Konstantin Komarov 2021-03-01   977  
10063fbe42995c Konstantin Komarov 2021-03-01   978  	if (end <= evcn1) {
10063fbe42995c Konstantin Komarov 2021-03-01   979  		if (next_svcn == evcn1) {
10063fbe42995c Konstantin Komarov 2021-03-01   980  			/* Normal way. update attribute and exit */
10063fbe42995c Konstantin Komarov 2021-03-01   981  			goto ok;
10063fbe42995c Konstantin Komarov 2021-03-01   982  		}
10063fbe42995c Konstantin Komarov 2021-03-01   983  		/* add new segment [next_svcn : evcn1 - next_svcn )*/
10063fbe42995c Konstantin Komarov 2021-03-01   984  		if (!ni->attr_list.size) {
10063fbe42995c Konstantin Komarov 2021-03-01   985  			err = ni_create_attr_list(ni);
10063fbe42995c Konstantin Komarov 2021-03-01   986  			if (err)
10063fbe42995c Konstantin Komarov 2021-03-01   987  				goto out;
10063fbe42995c Konstantin Komarov 2021-03-01   988  			/* layout of records is changed */
10063fbe42995c Konstantin Komarov 2021-03-01   989  			le_b = NULL;
10063fbe42995c Konstantin Komarov 2021-03-01   990  			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
10063fbe42995c Konstantin Komarov 2021-03-01   991  					      0, NULL, &mi_b);
10063fbe42995c Konstantin Komarov 2021-03-01   992  			if (!attr_b) {
10063fbe42995c Konstantin Komarov 2021-03-01   993  				err = -ENOENT;
10063fbe42995c Konstantin Komarov 2021-03-01   994  				goto out;
10063fbe42995c Konstantin Komarov 2021-03-01   995  			}
10063fbe42995c Konstantin Komarov 2021-03-01   996  
10063fbe42995c Konstantin Komarov 2021-03-01   997  			attr = attr_b;
10063fbe42995c Konstantin Komarov 2021-03-01   998  			le = le_b;
10063fbe42995c Konstantin Komarov 2021-03-01   999  			mi = mi_b;
10063fbe42995c Konstantin Komarov 2021-03-01  1000  			goto repack;
10063fbe42995c Konstantin Komarov 2021-03-01  1001  		}
10063fbe42995c Konstantin Komarov 2021-03-01  1002  	}
10063fbe42995c Konstantin Komarov 2021-03-01  1003  
10063fbe42995c Konstantin Komarov 2021-03-01  1004  	svcn = evcn1;
10063fbe42995c Konstantin Komarov 2021-03-01  1005  
10063fbe42995c Konstantin Komarov 2021-03-01  1006  	/* Estimate next attribute */
10063fbe42995c Konstantin Komarov 2021-03-01  1007  	attr = ni_find_attr(ni, attr, &le, ATTR_DATA, NULL, 0, &svcn, &mi);
10063fbe42995c Konstantin Komarov 2021-03-01  1008  
10063fbe42995c Konstantin Komarov 2021-03-01  1009  	if (attr) {
10063fbe42995c Konstantin Komarov 2021-03-01  1010  		CLST alloc = bytes_to_cluster(
10063fbe42995c Konstantin Komarov 2021-03-01  1011  			sbi, le64_to_cpu(attr_b->nres.alloc_size));
10063fbe42995c Konstantin Komarov 2021-03-01  1012  		CLST evcn = le64_to_cpu(attr->nres.evcn);
10063fbe42995c Konstantin Komarov 2021-03-01  1013  
10063fbe42995c Konstantin Komarov 2021-03-01  1014  		if (end < next_svcn)
10063fbe42995c Konstantin Komarov 2021-03-01  1015  			end = next_svcn;
10063fbe42995c Konstantin Komarov 2021-03-01  1016  		while (end > evcn) {
10063fbe42995c Konstantin Komarov 2021-03-01  1017  			/* remove segment [svcn : evcn)*/
10063fbe42995c Konstantin Komarov 2021-03-01  1018  			mi_remove_attr(mi, attr);
10063fbe42995c Konstantin Komarov 2021-03-01  1019  
10063fbe42995c Konstantin Komarov 2021-03-01  1020  			if (!al_remove_le(ni, le)) {
10063fbe42995c Konstantin Komarov 2021-03-01  1021  				err = -EINVAL;
10063fbe42995c Konstantin Komarov 2021-03-01  1022  				goto out;
10063fbe42995c Konstantin Komarov 2021-03-01  1023  			}
10063fbe42995c Konstantin Komarov 2021-03-01  1024  
10063fbe42995c Konstantin Komarov 2021-03-01  1025  			if (evcn + 1 >= alloc) {
10063fbe42995c Konstantin Komarov 2021-03-01  1026  				/* last attribute segment */
10063fbe42995c Konstantin Komarov 2021-03-01  1027  				evcn1 = evcn + 1;
10063fbe42995c Konstantin Komarov 2021-03-01  1028  				goto ins_ext;
10063fbe42995c Konstantin Komarov 2021-03-01  1029  			}
10063fbe42995c Konstantin Komarov 2021-03-01  1030  
10063fbe42995c Konstantin Komarov 2021-03-01  1031  			if (ni_load_mi(ni, le, &mi)) {
10063fbe42995c Konstantin Komarov 2021-03-01  1032  				attr = NULL;
10063fbe42995c Konstantin Komarov 2021-03-01  1033  				goto out;
10063fbe42995c Konstantin Komarov 2021-03-01  1034  			}
10063fbe42995c Konstantin Komarov 2021-03-01  1035  
10063fbe42995c Konstantin Komarov 2021-03-01  1036  			attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0,
10063fbe42995c Konstantin Komarov 2021-03-01  1037  					    &le->id);
10063fbe42995c Konstantin Komarov 2021-03-01  1038  			if (!attr) {
10063fbe42995c Konstantin Komarov 2021-03-01  1039  				err = -EINVAL;
10063fbe42995c Konstantin Komarov 2021-03-01  1040  				goto out;
10063fbe42995c Konstantin Komarov 2021-03-01  1041  			}
10063fbe42995c Konstantin Komarov 2021-03-01  1042  			svcn = le64_to_cpu(attr->nres.svcn);
10063fbe42995c Konstantin Komarov 2021-03-01  1043  			evcn = le64_to_cpu(attr->nres.evcn);
10063fbe42995c Konstantin Komarov 2021-03-01  1044  		}
10063fbe42995c Konstantin Komarov 2021-03-01  1045  
10063fbe42995c Konstantin Komarov 2021-03-01  1046  		if (end < svcn)
10063fbe42995c Konstantin Komarov 2021-03-01  1047  			end = svcn;
10063fbe42995c Konstantin Komarov 2021-03-01  1048  
10063fbe42995c Konstantin Komarov 2021-03-01  1049  		err = attr_load_runs(attr, ni, run, &end);
10063fbe42995c Konstantin Komarov 2021-03-01  1050  		if (err)
10063fbe42995c Konstantin Komarov 2021-03-01  1051  			goto out;
10063fbe42995c Konstantin Komarov 2021-03-01  1052  
10063fbe42995c Konstantin Komarov 2021-03-01  1053  		evcn1 = evcn + 1;
10063fbe42995c Konstantin Komarov 2021-03-01  1054  		attr->nres.svcn = cpu_to_le64(next_svcn);
10063fbe42995c Konstantin Komarov 2021-03-01  1055  		err = mi_pack_runs(mi, attr, run, evcn1 - next_svcn);
10063fbe42995c Konstantin Komarov 2021-03-01  1056  		if (err)
10063fbe42995c Konstantin Komarov 2021-03-01  1057  			goto out;
10063fbe42995c Konstantin Komarov 2021-03-01  1058  
10063fbe42995c Konstantin Komarov 2021-03-01  1059  		le->vcn = cpu_to_le64(next_svcn);
10063fbe42995c Konstantin Komarov 2021-03-01  1060  		ni->attr_list.dirty = true;
10063fbe42995c Konstantin Komarov 2021-03-01  1061  		mi->dirty = true;
10063fbe42995c Konstantin Komarov 2021-03-01  1062  
10063fbe42995c Konstantin Komarov 2021-03-01  1063  		next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
10063fbe42995c Konstantin Komarov 2021-03-01  1064  	}
10063fbe42995c Konstantin Komarov 2021-03-01  1065  ins_ext:
10063fbe42995c Konstantin Komarov 2021-03-01  1066  	if (evcn1 > next_svcn) {
10063fbe42995c Konstantin Komarov 2021-03-01  1067  		err = ni_insert_nonresident(ni, ATTR_DATA, NULL, 0, run,
10063fbe42995c Konstantin Komarov 2021-03-01  1068  					    next_svcn, evcn1 - next_svcn,
10063fbe42995c Konstantin Komarov 2021-03-01  1069  					    attr_b->flags, &attr, &mi);
10063fbe42995c Konstantin Komarov 2021-03-01  1070  		if (err)
10063fbe42995c Konstantin Komarov 2021-03-01  1071  			goto out;
10063fbe42995c Konstantin Komarov 2021-03-01  1072  	}
10063fbe42995c Konstantin Komarov 2021-03-01  1073  ok:
10063fbe42995c Konstantin Komarov 2021-03-01  1074  	run_truncate_around(run, vcn);
10063fbe42995c Konstantin Komarov 2021-03-01  1075  out:
10063fbe42995c Konstantin Komarov 2021-03-01  1076  	up_write(&ni->file.run_lock);
10063fbe42995c Konstantin Komarov 2021-03-01  1077  	ni_unlock(ni);
10063fbe42995c Konstantin Komarov 2021-03-01  1078  
10063fbe42995c Konstantin Komarov 2021-03-01  1079  	return err;
10063fbe42995c Konstantin Komarov 2021-03-01  1080  }
10063fbe42995c Konstantin Komarov 2021-03-01  1081  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Q68bSM7Ycu6FN28Q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICAClQWAAAy5jb25maWcAnDtrb9u4st/3Vwhd4GIXONn6kbQJLvKBoiiJtSSqIuVHvgiu
46ZGHTvHdna3//4OqRcpUWlxD7Cn0cyQHM4M50X6999+d9Dr5fi8vuw26/3+h/O0PWxP68v2
0fm622//1/GYkzDhEI+Kv4A42h1e/31/fNkeTrvzxrn5azz5a3R12oyd2fZ02O4dfDx83T29
whS74+G333/DLPFpUGBczEnGKUsKQZbi/t3xNP5+tZezXT1tNs4fAcZ/Ond/Tf8avdPGUF4A
4v5HDQraee7vRtPRqKGNUBI0qAYceXIK1/faKQBUk02m1+0MkYYYaSyEiBeIx0XABGtn0RA0
iWhCNBRLuMhyLFjGWyjNPhcLls0AAlL53QmUnPfOeXt5fWnl5GZsRpICxMTjVBudUFGQZF6g
DDilMRX300m7YJzSiIBgudD2yTCK6g29a4Tq5hQ2ylEkNKBHfJRHQi1jAYeMiwTF5P7dH4fj
YfvnO+C/IuELlDq7s3M4XuRWNMSKz2mKrbgFEjgsPuckJ1Y8zhjnRUxilq0KJATCoZUu5ySi
ro5SogVRO+fXL+cf58v2uRVtQBKSUaw0kWbM1VSmo3jIFnYMDmlqKtRjMaKJCeM0thEVISUZ
ynC4MrE+4oIw2qLBrhIvIrrtlJB6IhjVoniKMk4qWCMYnWuPuHngc1OA28Ojc/zakZRtzzHo
n9Ys9cWCwcpmZE4Swd9ESrtGHkbKQJWSxO55ezrb9CQonsEBIKAIzZzDhyKFWZlHsb7ThEkM
Be70DepIbQoahEVGOKwQl/JtBNHjph6TZoTEqYCp1BFv1q3hcxbliUDZymqgFZWFtXo8ZjC8
lglO8/diff7uXIAdZw2snS/ry9lZbzbH18Nld3jqSAkGFAirOWgStDtNOTWY5bQ5yx7lyI2I
Z7WHX2CgcTqwNOUsQkL6l2oDGc4dbtNosioA1zIIHwVZgkI1DXODQo3pgBCfcTW0sjALqgfK
PWKDiwzhtxFgKcgrYlc3E3N/rYDprPzDomg6C2EeaW7PrWeWbtgHT0N9cT/+2NoETcQMfLNP
ujTTUr588237+Lrfnpyv2/Xl9bQ9K3DFnQXbaCvIWJ5qZzRFASmNTz/W4HJx0PksZvBPC3Oj
WTWbFvHUd7HIqCAuwrMehuOQaCHYRzQrTEzr+31wFuBuFtQTdq+fCX2sReTVoin1uDFzCc68
GA0P8uFcPugiqeAemVNMemA4BXD+RA/upr5laeWKLWtzhmcNDRJImy4keJYysAvpuCCj0FhQ
2y9QLlitDj34ghg9Al4GI2EVUkYitDLVCntUGUCmqUp9oxhm4yzPQALvtOCfeUXwQO3xH3Au
4CZDyOjBVIOOWz4Mj2LDqGvbNr3igQvDwlzGpN8dOK+Q2LEUAgR9IIXPMhl04J8YJdjw/10y
Dn9YZgvRnBQ59cYfNFEr26g+GifYzKwiLmQ2mc1QAiJicFNSwZDdRZoxKI234GY6v4zd9vDE
OF1W0dAao6Q/0hjPA0OOCBIPP48iy1A/hyxfO/DyEw6ktu+UGezTIEGRb+hJ8eXbbFflFHpO
z8PSRzVjEWU2X8yKPCsDZUvpzSnso5Ict8oJJndRllGrTmZy2CrWfGsNKQwNNVAlN3n8BJ0T
wyz6apV2oOK2vtsZ1ksD4I14nu5eUzweXdchuSrL0u3p6/H0vD5stg75e3uAoI4gamAZ1iHz
0cPIL46oV5vHpT7qaGL4XB7lbt/ttacIKhckIDmc2WuICLm2UwCTmoswd3A8KC+DUFelP9bZ
gEi6/Yhy8LJwWlhszq7jQ5R5kHzYrJKHue9Dmq5CK2gR6i9w2MYRFSRWDl4WmtSnuE6emgPH
fBoZmZxKR1QAMPJVs3qsiVlKkoxyLS+SWZorjSTxKNJWimMt8anz9XBBIEPWghnkz5SlDAJu
jNIOT7I68CMUgNPJU0ljyf95riUOHMq4WTm0N0IWChCtNIQyyPR03GzP5+PJufx4KfNRLe+p
N52NZ8V4Mhq100GhAbGxzEdECMExCFtkLSRVCUOWWXjClVGtzMD36/PZodShh/Pl9LqRTQx9
rXqs8usU6vzC98e6tdgoorHFWiyE4PktbLZ4j851G7DzqhlubI/MUC+NR6Mh1ORmZItjD8VU
Sbgzi532XmvMlFlKmMl6xbI7MDGeQvjMCo8vh3bPQ+SxRRGkelGMY0/1XWrVedsvr09PUKI4
x5dabQ23n/I4LfKUJUWelAHRg9ALJ0sewLe0Q4CzhlBGwDIl0/VgWbhGvWXARhdofdp82122
G4m6ety+wHjwuNpO6k1niIfgNo08kICNGd0CEJlsJZQHNWRs1j+bYByqai7gfEB90hKogbK1
BWmymjpP1GkaIsERQdkQ0XTiUlEw3y+E4XuKAImQZFL74HADbTORYHWtXZMzL4+gaIdQWJDI
V5FTc5mBkOVsEUEMivi90RODyFIyIDMJ09noIYs3LTnM5ldf1ufto/O9jIEvp+PX3d6ouyVR
MSNZQiLDIb81tuu1f6LtJneVLgESJ6IpVyUPPJZJwtiUkMyhCpWqip7wjPyypAZKLMtM5NlT
npIqT7oULb7qLfLuarJqr3u9RjLT8mmDlRxZOJU4ZGaZ5YE/qm9IUp62F+dydM67p4Nz2v73
dXcCNTwfZS18dv7ZXb45581p93I5v5ckV7Kx3SpUWwX8zHiAAUBNJtdviaqmuvnwC1TT21+Z
62Y8sYu+poFDGN6/O39bj9/15pAnAGpGW2JfUcgcZVHElHNIOQrZ4OWpiuyxDMI9vcreCJEm
w2Z68e/K82QWktnnMv/pHDyJ4phTOMKfc6NX3TYVimwBiUIHJQtTlwdWYERdWxUrSADR31rg
VqhCjEdtT6ZGP4Dv8fqjZBYhhJma9XEgm4VRIcltlWGqUH3azKp0SbZwbbmpJhcqW20kwSur
1CjDrCtQlXYbkUGHNjs12OAQF1mKokE+y8sOyCdxtuoFzzJpW58uO+nIHAExz4jCIANBVSCF
qktW1FbPwj3GW1Kt0PGpAW6jbGdFfbvx52JOYQyrnTwUhk2fTAusQEdZmat4EA+rG532TLXo
2cq11oE13vWNVjx8FrWOeg2rthFvcNXEUJ6MtVowqYTPU5ooz6yfOxVvZYxU1yqeIpIUfJgk
W3QI2uaXEhX5d7t5vay/7LfqLtBR5eBFE5pLEz8WMiprWop8Mz2piDjOaGo0OioE+B/7LZGc
xsu7SWwlsCHeFOPx9vl4+uHE68P6aftsTaSgdBFGX1MCIPPwiKz2zXqHpxEkEalQiQNUVPz+
2kgzcGOQjZ0HssKXXhS8gs3GaZCh7qgZjy2kdd8+BpZgnDw6XnZ/Pbr70FRpBHSZQjYli72Z
tiWZmpV5mdG5srY/H1LGjL7Rg5vbTufD1GeR1/rNB5WLMONOpobJkk9YVasyTyUlmaLOOkJq
5UgyuSc5jS2MBXCoqjvPxi6GVa/dGRHRTya2f+82W8c77f42/EKKMcoMN5niGFPUd3v4arM+
PTpfTrvHJ+X22gR/t6kmdljXDvMyEQ1JlOpdZwMMkhKhcS07F3HqG1ldDYNYDSmtvRsioPBB
Ebj9obsqtaZPs3iBMlLeFPf26e9Oz/+sT1tnf1w/bk/aiVqobFLfRQNSuvbkhYbe+QTdN6tp
22tHye5XK5q2pWkjKHywOXn5YOtGNgPqpEg3me6O6lELBNKQAb52REbbUOVOOtYq1DLaehmd
D8T+ioDMgSvr6ZdoaeTVJOBWYqa3DRUO8VWCa4rybrs5oU03Bk5SeYuheXzOZB9EA2QkMHxf
+V0gfPexnbIC0gnuEfI0pj3CxbgHimPKeoONm+16QrBnb0EzbUeqMg3BaJRF+brFSZQPyUnp
WEivZdY/icqo3dez86g8gHY0URZX2aLs4xWRfgkmxgVKjSakAi2pva1COY0ofBSR+SKiwn8G
syyISydGyhFSqRpr9NP5bfSccP0OHr4gm8soijRTkMBYXjHaEJxmvh2Tu8seIjYvVeBTmSJ/
Ix98WZ/Oda9ZG4ayjyqvs1YqgHdx/GG6XJY0WlECKC25FtzgrWC+DVpm4VDhgD8SKDBnq5Ai
W3Z3Jq0t5dGbbII5qpslC5s1ygMzls+CVlXRdDUenADyu6qFTHpyNgll+4Yl0WqALWlbXKY0
tTQsaXOtGKWZHP504qp4lh1/cVofznv1nsuJ1j/MtFnqJ5qBX+lsudzgs8m4AhaZ/QrPF7aL
pATAWkMaviBtbQFU4Vvn4ntFOaCNetz37Pklj7trGswylg6puqlCwAPF8v1OkzJnKH6fsfi9
v1+fvzmbb7sX57FJKYzpsU8HZv9EPII7TlzCwZF3fXs1kSyn1HWk2Y2pkAmTj7S6RiQxLgT5
lSDDj7hqwuhXCQPCYiKyIWOUDt1FCZS78na/GJvMdrCTN7HX/Y3SsQXWmYUJqySkn48gIxng
W8k49uRFck/2kFahPjQX1HSWBZhGB8BikzfkckjA9CP6hjmVhc765UU2niugrIJKqvVG9p3N
cypzH9ijFCTUhkHHUtJwxWXkf7YAq26qdYDcfybuR//ejtT/bCQR0Z5U6gipT6XO+4mpk5qA
+UNHsCIIUsrKkshgTvCbm9Gosxmo8EoltNXCT+RXPrrZ7r9ebY6Hy3p32D46MFUVe4eONk9l
S5zHQwecRz1bSEMJMu1deF0YfBeCCRSp5wZGEVhhSab6wxI7ntz2HPIkVhZcVjy78/crdrjC
cr9D5Y8c6TEcTLXcB4flE9civh9f96ECquP2SdJPZad4SaAyMReVkM49hzq+CZEYK7C8VF2V
1352ivrdWCcu1WiOYp4P1KI6HTiRAdXWFJOldNVBT6kZWhTVBsp4sf7nPUTf9X6/3SspOF/L
ow4iOx33+54y1OzAJqTykf5QqMExOBWT7gYbjNTT4PZKGZSpzsD+yuVFTCLrEjHK5sT6IKSd
P8IyC55OlksL9/GbWDfDcV/9JQrH1x+Xy8SPZEvcuv1lggaed9QkPqR41Ldl6A3J3P8wHkEe
gm3ML7F5qiuBFn6EhV1gHprTBA85CkUilsu7xPNj3I1bFcvxm/yCPS+pdaQsSm5GtjdTDYnM
HW371B8FabunNqGo+skC5yKeTgrY1sQis5hwlljg0ttb5pKeXd58WUZgKPsTTCyDELhK40lE
jVC5QBEFcX1I4915YzmF8v/kY+/+oh7lM5ZUz8UtSm/QZT73Zjf8jUGe6mSM3l7BdYVyiL26
jGAMXvoJ/LJzfn15OZ4ulj0SbDc7gEMyWIQI6vg3HKZO2/M8dSfXwkeNU3FBcRulsF3nf8p/
J06KY+e5bPU92mKWIjM18xlqBdYk0M0SP5/Y3FLu2mt8iQtXKck6NXuF9oR2OJjxOBQq1Tyh
QlbPtpcIvuw1yUcqXJ9A9avlfZwBhLwjWtlRM+Z+MgDeKkExNbhqbEqHGU0ZJu/foUiey8pH
b5+XCBbNzVUZxGTjnSmUTtULH/1WSL0xQsvb24939tvTmgaSGvvFaXUZ17PyZB4Th3ftW0LL
7EJzygqoXl/KfqutFpUE4SLWL6UUzEcuZBVaq6GE4t7skCoHRFiPgcFo43a0rpT2YvFmcrMs
vJTZ7MXL43hlKg1Yu5tO+PVorDOkojiUx/biGJxmxHieEdn4UU3Dob4VZhDBiPnoVCHkL1sy
a78LpR6/ux1NUKTJjPJocjcaaZlmCZmMdK6hQuIs45DgR5ObG/srpprGDccfP9peKNUEio+7
kZZqhDH+ML3RQpLHxx9ujXyKQ1JnXXYpn+4tC+75xLbpdJ6iRD9veKK/dSMEXFPcd8UlHLQ1
uW65qoARCRBe6cxViBgtP9x+vLE9nS0J7qZ4+aE3H1Rixe1dmBK+7OEIGY9G17rn7HBc/qpn
++/6XD1Ie1ZvRs/f1vI1xkU2kSSds5ee/hFse/ci/9Rfnv4/Rve1HlE+la1pm91FAgokWbGm
RjpGcGjvScnH/cR6XI3DWZaJmNO6uOlpUT17iJnWPsgQlZm00H8YIqnML9nQNrpZEgZix4Xf
77QqDqqlywdnf4Ckvv/Huaxftv9xsHcF+vpTdyX1EwZu/RlFmJVI0fLUwAJdfg0U29ym4lnV
hqh+xapjIhYEQzmEIuAYJeUNh33HojaOc0fePKU2CUOZxxt4Zykk7cflA4VCSZOl5WirXXQ5
+s3c6kK9U9NlQBVG9XPVG/7hhWXCXnRY0/G5z0PsdfZaAi0Zco0tsJfwt/DeAhcCv0UhGbOA
BS0+fZyMiQVlPOZpoGS5SlhfKYO/mpHI6nFH59CEndm9sMg8hHtkRZhCatpfMSyItayqsSjK
ke4KbWe/cTpCaw9y+fg7ZNxIgKoH4S6TLxyzjNlvCiWVeiJntxCJTs1byPKkt52E8inc4Xi4
4r7vHNYXyG+dnXzN/3W90V7EqblQiKlF6QpM42UHgskcdUCfWUY/d3YeECgXNFuRMOCljoGS
rU2X383r+XJ8dtSvtjReDbm4cedHXeXNE2VXx8P+R3de7XZfSa3dpJZvAkJeIVW43tz1beLX
9X7/Zb357rx39tun9cZWj/ReWUlfGdtcrtt7rVFC3vgJRUVQZWt88LRUdOVNcUYCCslZ7wlK
zZxne4lSJq912lwDMaQNvcseCfVpRKg9rEp0qs6MDRsxlsqLfGu2XFuTm1rQ5QMvQogznt5d
O3/4u9N2Af/92Q/IPs2IulX+0YXIuSf64X5zQi3jN4qCIgVZ9iGlepq3aIeX18tgzkCTNDf8
hAJA0ufZQkCJ9H1ZlkVGDVdiyh+Kz4wWf4mJkcjossI0V4B7+Vi9OXBGAVINYzknnZLLIPjE
VoDurkbmVmBPKr2OdGf5GVm5DGW2U6TxZzQvJADszv6TxBJb3nK/QYBXKLW9nyqxJIJURT6L
eLbDzScTHRyPjZcYJXbOl8ulccGkwFUjrMs9lPSpgHKvm/92ZAea4fL3GIOyU2/qDdsrIZV8
igWCAs/WOqyGsxyHHGeEaJWyBpQZrPzZIzVfpusUt7dpfPthtLT7D40QeR9vP979ApktnhsU
2Xg0GVfas8+hKubYekto0OWsSOkS02xoJjefjEfj6U/mUVSTuyERyfYeSwiU98ntdHz7UxHg
1S0WMRpf20riPmEwHo/s2sMrIXjaDQR9AuMg9PHX9f3OALclzZAl67QeuhtNbeZoEMnDkTH7
lkIUpzykw+wQImxdeoMkQBFa2ndc4tpHNPY1lng6Gvhllk7n55+o4PlP6QLGPLr8Cdch9aCQ
t0uFRvT/GLuWLrdtJf1XvJxZZMI3qUUWFEVJjAkKTVAt2hudvnHPxOc6jo/tzCT/flAAQeJR
gLywu7u+Ih6FVwGoKvAe6KlSB9tQX1VYwd6VBeb3ZhTwOrz3dKH27XRM4qTECwZzpue73tPC
Ysq636ooikMMcoJG60TqOY6r6FGlSMPySL97NkDC4jjz5tD2R74DJR191JmJ+MPTMGQurv19
0v1ADXxo584jJfK2jBNfo9J28FuXGo1w4JrIlM9R8aga3Un3kNUh8fso/FHRWorfb52nG0xg
r5Gm+SzEgLJcmz2fCj3ttEzfnna6HaaqnGfPKZPBSfjUPHvTITuezENxkpnd+7H2mDGZnAl2
6Gd2zzgtq9RXJPF7NyUPF6eJZVUU+boKl7qY7DAvfIsviaI5sJZIjiyQEYfLB9mM5D55VQ3G
NyoeLziTza9WGXxTnKSY35bJRI66baKFUe86xK5Dhm+bDK65KnL8osQQHmVFHpWPloj37VQk
ibfLvPefShgL+qXv9mN3fz56ju2NBrucyaL/POqI3RPLZ+8Qew8BTNBFcNklGO7ykqZ0z/tl
4LsMdwcmcAV7U+aKaZzN9k5HUk3VaEHG7v1lqLkqIlR4BxbKZ8NBMfNbRd5zvS6PbGqbzhGX
4jSJy3SrFrwOfGtxf+aNAvbN3npQ0jWCk95GEIeTEF8Xy5L3owfykGy7dKmgXVYOV7tdqVB7
jypnLSjDWh+TgdRV5kpAmIftuYLTjvYXAjq0zeXQjm6lBCpk463Q23n6ded+Obanay8sxmVV
vN+P7XT1V0iMzSSuAhy3PovS6DGDqIZb0Kv44W/35ljlZWZLlN7IJlC7S3EsLDMh1vECAdPg
inGRvcFyqMukinzDAFT9PF9HpoMV6YI5hZNL8R1191djc+7TbLaTXcjYmOVzT1LsaneKaEht
q/JmUcfnBGYYVUu7JgAXuQZb6UsGNVrwSwPJKW4N6OXWjtbgtLutCLRAt97kLTtfcUs1cbgl
YxNMGLF3MhhJl1nLvSBZ+25BYwSP6yLAY5QGwDgOgdjyLKHUCHKx0PCVdAE9UawEmKMhqSSU
q/Ou88vXD8L/qPv58sa+xwIdSrvMgD/hf9uGQgK0Ht/ucU1GMvAV2Dr/MuCxvmkH9oK0XJny
r8xbeJEdS4gVU8fiqMfGe+C2cNBgiS49bTgPo3a5hB4kimUJR8wwBv0qhbi5tNSkteWnaPeB
5XmFFGdl6I07cKzt1nNj7HRXHmT+/vL15bfvr19dp6NJ91l/NsrIf7BLLzybBibjLuID/3lS
vEhFzjcF6mnzTzYAPHMPvivZ69DNO74qTe/wzKVNQgA/QFgViFpnR5ZYjK2/fnz55F6iLAeP
wsCpMS8tFqiyItdI858/P/8kgG8yXXE17t7OyxSkXes/GBWTmYFTn5OJzsQbt0ZDUEmmpqes
jOPZHmlg7+1aJpsMcCXnlo1Tsa6AsSnJhviu9Tj1li2hVc4zXx46c7Cu5PswiiSYbu2/cJyZ
svsNyMcKe7MSA63DumP3HChwXw9T94R8KIHAQFr4nlqsuZpmmD1xkRVHXHSsDFV36si+HQ91
3zryXGblX6f6BAJ1+6yJa/L5Ib77/h2t9Sskkz2UpUiG6/IygkgWYNrX1wPfebS/xHHOt/Du
kNF4f6APwyFJDcx+gS4GWpSpGthpmAw/lCtfae7hXPka6AqLr4veNuEYHyhSgLEFgoV6T9EG
2CBv0oKlG459O3skYHH8iAj4X+0sXKW7U8c3+ehWUvV6cFVusAED1uBBQT+3+6sjaZvrcsN8
DxaQDyWkxpz6eJCTrt+3NeyZmK2O2ehd9XynBgbXDwgWZlq3wqtjjbFO2iVqprG3rOUXaJCG
WIdaj/I63M+H3oyrfe3FeoWf1Mgoft2A3SCen5UnupO3CNlz1Y+9pndOlNGNJoN6/bL6OAmq
nmxPsZmfUvxWWpoKuYOj4xsWN8K5oIL5hxWRV9LBklPGEDN2QBvGptGnQQku6YkvfA3GY91g
fU/wsc7KmvEVzclTBNQ/XAL5iR3g5Yi50wn8bcPue6LNVDWjEFcE6ILBAAfaENgDGqhuWyw/
3k8riue7d+SgmeLetmCcNknGhu0uVtTXDd/XWYpd1GwctuHYhoi5SK/NBgm/lGCy4BuDfiqN
24LfglSxyvKNNJuMmHgb1vCRrgel2pC5o+dWd73hojZM9vnfby0BgnuaG6xCDcyG/6MErx4H
fJ90zLEZElSHIKwgmjE3bxU0TGjRgWyEhQWnDK1+GKajw/X5Yp2GAvzMiw9GCTN2YqG+Z1Oa
vqe6GbaNmEdEXJvo3xnTnaKAA4i2iXS3g+tRwSLc8cpXTrARXSOsSEuZpEHMhnQTE6izMJMB
5xdj2gBRC69ebGQCKCLd6pY6nEius7IRIn99+v7xy6fXv3mxoRzCjXQrjJFRPe7lvpwn2vft
cEKnO5m+XLXsXDlV5m2kC0A/NVka4V4jioc29S7PsPnA5Pgby4B2A6ymwQzG1jP1cvzQelKx
0iD93FARWmkzMg/J2MxlCYID+2pPHsq8aO059af/+fPrx++///HN6Dxc8T5d9t1kdiIg0uaI
EaVWpQ49zITXzNaDEghdgvXZ+7mb8/MhMfq2eGfhzb8g2sniof0ff/z57funf968/vGv1w8f
Xj+8+Xnh+onv9MF1+z+dzif2ER6hyIXK7G71tItdCsSBfm5lvHa++AyTacch2Oa582W0BztJ
YTHxj01+exlqizo2hE17Z7zC1AHDw9/XXHdSqy9CoHUR3QmzbNU5lTJvF0KuY7k3C7t8Rguf
znxbbYSIElM2OZnyhvOInlqmGAK40BTdMgP46/usrCIzpZ42yVtnVE9F7k2FTGWRxGYByXOR
zeYdoyDPnoN3WGikhuTFL7AkonacABohmATl1psEPuw2w2UTIbzzUFMMdJgtwlzbteEk2cc9
hZLOXk1n5jZ2ndNKLG2SLEYvPwA93wmfX/RTDUHuyNRao0P3PJF/c83smGHE0inEdSi42pvc
MLMtwfBueLpyjdPqjMJf+b6nxBLhdeD6VGfdemn0+9Hb1hAMt546z24POG7EEyePY/JQwlOJ
uXcG6NzTnbd3j02thXfkKsdnvonkwM98deCz7MuHly9CD0GsbqGLSC9MT9pTfWF8T7S6TV++
/y7XrSVxbRo3Z3618hntcBQ+Jca6gq4hZle47q3OAR3a6RpyJpfua57OIVjAJRdcc800ZUw2
8zByo8OaiNHl4mvUx6lCqmmPwi2HU1SAoc0j8WaSt2MDvvHeEKRipKOd4Dg3nfEhxcaIiOSm
n5fATo4wIgwCQKXD9jK6I9BZ+DVtuqe87GKd5YqxkT99BJ8/vdNBEqCIIllR4zUjylbL+oU0
THThkb4glKkMXPUDPm/6DqIfvhU7y60SGiRuLsyDhhXzjwyNadFs1/IsTy3++VUvkkQnykv7
52//toH2swh5Ss/v4OE7MNEf2gmeFYSAOGJXzKaaQHgfERD79fUNH4R8WH8Qgb74WBepfvsv
3evSzWwtu1RaN6GqWIILcHdeleoGUNMxflBxj9ehsYJUQUr8NzwLCazylgPJr0mrUtUsLRNj
B78iXJHjjYDdyq4sRFMHFXFP4qqKzFID/VBXeXSnV2pGCF1QrnzEFToVKw7S0CRlUWVu2mzU
RSBgt76ArvQ5znV35pU+keOMFZGn0w4dfnWleC5N21/w9Wktaddw1RbCTTCvfromd8P3Ulvr
ibOjE37pbnPhiqjNhdmhrm3bkKSKZ0RqAklzVG7CB9ej6yqm5t1p4Bq7MSIUNjAs2YFRv4K/
MSWQ5gMe+pAHhgluibcKoB257nHfn7Im3P4hbVfxcP0yyR+zoNaIaz9jBB3W9KmKiuCoBo4q
wz7u6FMWxbgHicbzIAPBUWbukORAEcWVC/C6VElS4EBRRDiwQ4ED2RVxjtUOvpnL8FgS6cah
MSI48tRTpNJTid0OFbiEPHE+DB7MEENxPDUsixB5i22K0FVAT/HhbO/DWVPGFSJjTk9wesX5
ZwQ4ENmKTuU4UmXhiYsd5hyz5F5xUsU5VhoC1g4oPcXoPdzzwl5b6SUj10m+vXx78+Xj59++
f0UMMdSXI1+nWc2QteZ8p0dkNZN061JKA0E58KDwXUva5wSHxqouy90uD6FZ8NMIm4xX3ONe
5qYTnk03PvSJJYQtDhcLd/ly08EsqF2ucGa7ItQdNTZES9LQB5lghmAuVxVurh0a88Vlq0NF
zYJ5pHVoLRjf17GbNKcmwXJnP1buLNTPswdZ4CaTLl94wdj4mh8rcovIY0MxaW3oHpXl4O1J
7FwmHtNQm614XE3BtntQSc7E88QrITBvqwCKei7aTHnpT75CVdQVDS3sC1PqGwui9GkA88yr
7Dyn+nGHb1lx1gFp54bVx3uBun4Lx46YHs+BAgeobgShU/myvquwuUxeDiPFW84mk1BfWXiK
nT+BMgsrRgtXEV6SBNfZGu4YD6Ex1rOm7t5dDssLwU7q6sjTsbYkrx8+vkyv//ZrDy28ZGzE
j1w1Pg/xjq36QCcX4wROh2g9duj+ikxJiTpwbgxlYXo6GUhY6mSq4jS0TAJDUvoKFuMGUBtL
UQYXYWAod5hECr4mYnReI1S4VVx4SlnFZahPAUPlEV8VB5d3zpDrryRrpU93pT6XeHuZo9xe
mvNQn+oRU8InQp/L0uNtvc45T9dOeK1dsYNiUFaN58cWgoh8BzEE731HuumXPF6fJbwcLRVX
fdKNT3a8UHnc5T0OEBfqTsgoHWzg/v4f6wsg3p+xMSBgFSHZKKDw3Uqj7e5fBsj84+XLl9cP
b0QJkRsD8WXJJ17x2Ie/Dt4LWolaN7QaUR42OTXkgvdo7NL7iH+8b8fxHe3gNtfPqO5mfSUD
fD6x9VrX+lre4fqTXyLTehsPMQaXLmu3mgaSbcH4jI64F4jkwMMXCuw4wY8IvbzT+4d+92im
cBo9p2ICFaHCzL517m9283YX6qTbX05d84zZkUlYnrVaaTuhpGVv3lcFKx0qFW6ONtW6DpZE
PdDzQmEWj7glUY3hNCKdcbch2UMb9MZDYqYRq5wEalLnh4TPWpf91fehNIS3Csm6i9vB2ABX
FpZJi8GA1YjPePf5VmMGVGqmaky/DUEW161+UQg4rnCdSHIIP3RfruutrVnv5w4KM9ldcYbe
fWd7myxuYJ2izz0WBV5OQeRwPwovXfthMmzOXO1dBPX17y8vnz8YWtPyyAHN86qyyrZQl4Cv
1kR4GLwlPN3uxpWrNs1Hdt8GauIMDEk1I83Kvg22VKnbrxY6fOErlWApI6cm0hcVOxmWfYB2
TVLp4WpU19gtj1Zrt66WkOWCdjy4wreEKd2zvYvBoYzypHIqzelxleAnNQsDr3FMbs9+Funz
6p/50l2WWm3W06pMZ4SYFznSkOC+7RR9bPIpr/CdtBzSfVLBxX2AA0IZ+FsNog9UhVVKQd7F
iU1+InNVuPOH9HH2F2EJ8+FnkH7BvkLe5MHpPzZRnW2r0e12INGDnj9+/f7Xy6ewjlSfTny2
9Tjhyza6NPLN3TVDNGH1zS1W197xT//3cTGYIC/fvhuzyi1eTAXuB5ZklbGr3TC+1qGy07+O
b7hKsfF4dIKNgZ0Mcw+k3Hp92KeX/zVj0t2UgR68K+4tjWSB57DwwkgcxBHlW/8zAW0GtgDx
FBdELvRwxKk+xsyP8RXO4EnwoajzVBE2TRippJGndGnsqXHqL3aackUB08lMLo/Icv3aRAfK
ylPIsoqtXrpVvUXfsjBZYmMjaXYmbfcHvhIizj1q0CFQdqW01+Paa1TbFMXAVPz4LbdDLTnw
KWrRt+tDc9/XEx8qmIa1xDaAvnfV7NYWskjdkJuY1NxcF1g8Kak+WmhL3mtsFM1Q6QxxOEeh
iUSF1onUJ3UzVbssr93EmlsSxcbhpUKgrQt80tZZKkzxMxhiN1dBT7Bc+/bEt0fP2AmHYlkM
JvQRoSC2x3biSjxMf7+B1EOtiEhK+yeIsICtSWsdIOJdhNUBopSVURaW3cKEnccYLEk8u+2p
wooQ3if10quaYqEbrSTGOY/dHiRCwETG8ZGCkGXe4gDlRg8Xp+imO8GWlWgAl72f0iKPsWqB
o0FcJLjximI6tJN44VGILytyfFrXKixUr0C1VNQctwryIpvs9y7E+08W57NbOwHsIqx6ACV5
GSwv8JToCafGkUPOeAZ5tQvVFTisyz0dKjwGJusII/s0C1dgCaqDM6nOeaqvpxaaO9mhPiMr
36U/HDvztam1g095lOLrtSrLOPFJEbcCWGvUJCXqxna8tv1SThmNBRP4tWFxFGFjfJXqumlx
gN1ul2t3O+OQTwUEIxKrAjLFwwJgvLhnvZMi/uT77oNNWqxp5dmnjNkgA5Mj2vL6bsehzGL8
7s5gwexHNgYC8V634piAYUxjQth9msmx0x32NSD1ZBeXpSe7XeKZyTeeqbRs7T08eEAcg6fw
uWBrPB6TMZMH79Yrz3lCDxhXHAzTUIGwBk7jQp/O3f1YQ7C5YRovPZ4InB2H0phmijQUPPBM
nycsyQW61309EvR9hoWx4f/V3XiH513dPqJQyq5u9sItc2oJdb87sCIxZs0NiMPikicL2KcQ
LnzGZnrFcAQzqfyIiQOgKjni0UoUS56WOXOrebLDA0iyiv+Gh3FeP+7zuGIESbXPk4gRV3Qn
rmXWCD/vZgizOCHXI88q5NydiziNXKDbk7pF8uV02s5uxh0ciIuZ0/1kqkr3g1+bLMEExifq
MU6S0DCDl7O5EuTmhN6braBYF8MDXPKU3nCZBh+qEpgcaA2FPpaHejdwJHHuCk0ASeIBshwR
CQAFOsgkFCoH6IJJ6SYK9CIq0KVGYDFmTGBwFBVWJIB2WExUjSGNS6zDwstRBbYsCiDdeYAM
GS4CyNGJXEA/UMIdVsKGprBwO8DUFHmGiYNrfUlaFeEFkLTDMYn3pJHjL8w7lrnPxmjtFqTA
9pEbXKZINyMlOhtzekhYHK6wxCpU+Jz+qOjVg/FNqnBxsHbjVKSTcGqKjEOyy5M0w0vPoSzc
lpIntHrRpirTAhUPQFkSqt8wNfKYsWN8q4elMTQTH5qh9geOskTmJg6UVYRIarGxx7rHwOo0
ONVfmuZOKzM8gYa5RHHhortBU6Ic2GxOYj14iWrNSYHvhA0e9MG6VceCIGvHFpM2X0zvzfFI
Q5pXNzB6He8dZZShaYxpniThbsV5PF4AGwdluXxn0UZYX1Rch8FGQJJHRYGuOcmurLyLcFlt
sWYfLbNpFYeEu6xEmWeNKiJ8QUiiUj9ONpEckYKc1St0jgMsy9DHKTSWqtCvQFeAcnEgyzYl
RVlk04ggc8vXV6TwT3nGfo2jqkaGIF9IsigzrTk1LE8Lj+GJYro2hx0eFlbnSCKkXPOBtjGm
s7zveT1QzQTC8XJ1NVgi3RrGWfjsPcFy34f1SLafPM85rRx81xfqgxzH9A5OTv92m4KTG6SD
HUjL9ZoSk0bL9xBZFJqTOUcSm+ePGlTAYXWo/IQ1WUliVDoLhlrAmUz7dIeo+WyaWJlj4iGk
KJBlhG+U4qQ6VDGiGNQHVlYJOrHUvJ5VcMvYDXUSIWog0PHViSPpo6l1ajw+SivDmTToQenK
QGiMLZuCjqhago4Ih9PRCRzoqNZJaG5e7CnkeYqTOCTKW5WWZXpy0wSgig84sPMCyQETv4BC
3V4woFOyRGAOAWvIYPtw1p5P7FNYFZBchSeQ6cpTJOUZPVmQWHvGwpitPOrJDYSeG/Ok0OE8
r31hEdVUgmzPt9eMdXsjxKJuNgQs7NBd4KVHnXerkMaAS4wzyEhcvrvzfUNqpBxANk6kgU2U
g12wsxOBLzmRTnfmlhkc+5qdLeKgiGYuqrykbu4NwdcdgzFQMeOdPBEH6b//+vwbOLGriMru
O4vHg/OiFNDU/SNaHmCQsaRPFD9cEkmwtIy12VfRLMcOERgBDLJQZVx8VE9JVUZW9AiBQIyh
K7PCckoEYgdDSM4GjVex8Zz75tDYyYpXvkljp8qlnO8i9JJRwMosySnNTJPIefrGYCEQowx9
JE+IrWt0hxKQmbjNnO2cxOFk4nlkZ2XIsc8KbJ1dQWO2Xqix51ESgMEo8C1fl9H7R8EgXFOk
M+U2NwNyqqcWwjOog01dSk2cGvamGtF+hkpANClQ7xIBqieCrOTmJL9PTF7UavRzV/DFzPKA
XYA8nyWwXdTA87+q3dYyAZUX07L/0tLqnliRzP9P2ZU0R24r6b9Sp/fsmHlh7suhDyguVWxx
a5LFonxhaNSyrRi11CGp59nz6wcJkCwsiZLn0Evll8SORALIRKptfZNV5k94ZBVLrgQn+ggx
sLRBw+5d/RC/4VsYwjAwTlDBGk6jiqZqF2rsImUIwwh1vlngKLZC5KsoRsM3baioGV6IkZbS
ELgG44kVRs/eGLgeg8lVhVglak+2SU43ri5WzcXoTnn3kX3Eos6oSW3+2oZS8etUufKLeaJa
+e4msrB7P4bxW0y5RH2WoMtGX3hhwCNTmVcOxAJShCvfsrV0gWh262AsN7cRHcX4bRzZT/7S
tKZslwBS/EH9oXq8f315eHq4f399eX68f9txq8xije2KxVhlLLqQXx8f/vtpaistPMrVJaZ1
bLMSF2hSLDdNlG3mr1JGYA0SmYYBTbCs9OFMygoNrg5GA7blyyGmmO0qeou5BtVSKnExdpVy
5XT0DmSDHTuU6wwVUAx8BTI38dVzcQwxQjeGKMANLDaGGK2wADtKgRaqEhKXI1TOi/fhq1WR
rhmtCDmlsrcPBQLLuzoVzqXthC4ih8rK9V1NeAyJ60exSSfaTJDFdLa7Mlnt4tbiKFFvjaT3
wtLx1NKcK99G7TdW0Lb0T2CVMH6CrRaU6qFHUgsobaYuNCWU8UL3LYyG8sbimwxcbJ29yFbG
NA8EB0b0kwGRLVjkb1SE+bzSScIf+fpLhxjQqx+xiEYae660y82RpBC9MznJ32/GMXMm9Psa
b2kZmvKbr6a9zvbxeu4rWOhsYccU69MLkBdTls5jUw5w7YswwJvYJ/6kf3+SWujCA9F0+hbe
f7/GRdWzAxUnorSTwAr32VF4AllLuqCwpYtQZ1iBJ/XdOMJLQGr6D+76JzDxvdr1TJYpXaaN
bchq4aBDCCyAr6fGt5l4Omy7efVzbTJIkK0c+SkguhMUeZD9oDDm2A7uagr6bk3G0OtSicUW
z98kxBFP8hXERqcCqX3X930sPYZJz71dsMWaFKkC31J9MKQ40+ijO0mJzRfNNy9I0Zd0G+ob
oMAJbYJhdLULXMNs3Fawq0UCNStEm58hDpormOSi1VC1Fxnx0fpp3ksCxNdtExSEAQbBVtEX
93QSxDaJhs+UHaKERYEX44OcgcH1nl/3hoa0Y98xp60s/EYuTC1WqycrqiqKHicrTHCHbWq9
yME7ZDn8UKIDSjiELjZAkWhfIEKtTbvL1HCt76FPn4ksUeSb+pRiBq1ZZPoSxuiJg8BDN+U2
Or8Y4hu6g2KoD8SFpd0X4itdApCQWIqYKkB5NMlXiiJ2+jWzDQ51AttIJajhEELh+qgCwBOb
SnPGdpIXnBnJd211xNtveyzu40RO/X4epWgOFwbxElUMPkyGoahv0S+Wwwu0VMsxxdUygY6L
Jjx4kXzmIGKqUTrCUo0OKtp6p2qJhS6mAPX44O39KgoDVJ5x43YUKQ9042OhQ5Or6fumkR9F
VhnGLsv3p9ycQnvu8EZatP2rrbTsVOaxks/VBY7byLYC7Axc4okcD10fGRTWGAR2BnbgosJ1
O6lA2gUwxw0M84gfQxg8DFU21BFbZcIXVobZcngdBVXcM3Am6ahBwtZjBSz5K77CwgYHed0I
YRuNV6IXHt212MCE3mxLLNzfGBdNJdkXohtQl1x2lRdSRfANT1mgHpxdsgbHFqMTd3OdJULU
7AudSjQDPUDpn0c8nb6pb3GA1Ld4wG6KHUnXrhhaywIUAbjGSTG2C9NUtYY8Cu6tcjWLLqmq
qzysVcciQUM/JJnecVWWFoQhneHCbWOA7SX+BjnnWXDhcEIkz3lRDrKb6Irv025kkWX6rMzk
l4Avz36tRxXvf32XPbOXApIKojkiZVQY6da8bA7zMH5YHwhRMkCczI1VOI9hHB1JWahgFOzT
ToCUUqzP23xYCOYrKyYjPlIlt8n64VikGQzkUe0J+gOcVqQwdOm4X8fE8qDA14cXr3x8/vHn
7uU7nBEJN+A85dErBeF4ocmncAIdejijPdxK7/1zBpKO/EAJ7TLOw8+VqqJmqlB9QAc3y4nZ
Dcwl5U5K6a6Uo+eaThzxMAyrrTDkLoEE9LZQmxRaUu8gJAWWfvr4++P73dNuGIWUt2pDp1SK
PBUhMtF2I+0AstMO5O/S25rAnTdrLqyhGBOLGdVn7LV8ukOHN3qbgzwqTmW2HfVttULKLU7R
7aKHV3KJqfTb49P7w+vD193dGy0IXOrA/993/8wZsPsmfvxPsSH4BFvrig8Rr+SThBt94ExQ
HxMTyy9/fH04g7P+T0WWZTvbjb2fd4RHK9G6Ji+6LB2UB1XkeSm+vMNJd8/3j09Pd69/IYYl
XDANA0mO6gSChYEd57OkyI+vjy901t+/wBMg/7n7/vpy//D2BhEeIFbDt8c/pYR5EsPIbzaU
KTukJPRcbSZTchx5kuX6BthxHOLqxsKSkcCzfWy5FxgcJPGqb138loDjSe+6ojXdSvVdz9dT
A3rpOrhFzlKScnQdixSJ42KBRjjTiVbZ9bQmoupSGCLZAt3FDXQXadg6YV+1mHrLGZhysh9y
uqWfRDn19/qdP7Cd9hujOhJ6QgJ44klIWWK/rABiErrEBte8K9XkHNhG8IJ70aQ3IAAB+szG
BY/0/ljIoKToC8weHoY0pkhRP1DTo8RAI970luRktYzbMgpomQMNoE0dwv2ZVkcOmIcAO2oM
5RtnGYF6mj8fW9/2Jm1WA9nHZvXYhrgT94KfncjykO/OcYwaOwtwgH+GXvKuE2RyHVQ+kCl2
5GfahMEKc+BOmiL6sGXtju4sF5kxOf4q90TtAJ0dD8/GCRYio4SRI0RisJli8HgWOXB3qQuH
ixoDCXiMjCcAfNSAeMVjN4r32my7iaRb1KVjj33kWEjzbU0lNN/jNyrA/ufh28Pz+w5iKmrt
eGrTgG6lbaJmw4HlYEvKR0/zsmL+wlnuXygPFZtw8blmq4+SIPSdY48u7tcT4+Ywabd7//FM
tRqlYrAdAMcVe1k5VlMXhZ9rDI9v9w9UWXh+ePnxtvvj4em7kJ46o4596F6ZiZXvhDEyo3Cz
x6UVBhbLK7Uc6ebYXCpe9bbQy7pWU8WUXc6pZvthXr0fb+8v3x7/9wG0TNY2mq7E+CGkXytG
KRIx0FbkUBUKGjnxNTCcrqUr3lQpaBxFoQHMiB8Gpi8ZaPiyGhxrMhQIsMBQE4a5RswRVzkF
s11DQb8MtiWvayI6JY7loHZREpNvWVeS8CzD8b9UxqmkqfjYDkdnCwdTblXieX1k8LWVGGHu
oiYB+vCQTAAFNE8syza0K8McUzEZ+nEhl+xRmx6BLfOutH+e0IXwb7R/FHV9QNO5cnbBy3Qi
sWUZat0XDjwQj2LFENuuYdR3dLHRTpq2Hnctu8tN9ftS2alNmxN9nUpj3NMaSi8xYtJJFFtv
Dzu6R9zlr3TnTz/ZNsPM7ubtnaoqd69fdz+93b1TWfr4/vDz7jeBVdpn9sPeimJMeV1Q5pj3
TSaOVmz9iRBtnTOgCqoUkvpCxw0N2OEDnVCoLQcDoyjtXe4PhdX6nkUX/I8d3VXTtfP99fHu
6Ur90266MWS0iuHESVOlXgVMU5lW1VHkhY5aVU52NaWSYv/qjV0kJEB1Rs9WG5YRHVcpweCK
NwpA+rWkvecGGDHWOsU/2h56w7v2rxNFek/uA9wZdPsojtFBgYwJOqpMKcF6acl3jWsXWRYa
HWT9ygls9asx6+0Jvf9nHy2CIbUtdeRziPcIVhaamWnUUgm1zCTpI56WqfwcDbG+19uPjknj
nBl6umQqlaGTyNILBO+KExt3dL+0eGijA3rY/WScdWJRW6q/qKICaJNWUydU+4ATlXHOxq6r
EOnUVuZtGXjwmuI3dZZT8atkXU9DoHU/nWA+MsFcX5mIabGHpq32ODnRyCGQUWqrUWN9VPIa
aHOT5LGyngtglqBy3Q1CfYimDl0JsbumDfZsKbovJXdD6USuNrw4GVsVN7kaKS2c2nSphdPk
Jl0lPoy1ZJH0V2Q7zPPIKNF4sznocFBFKxdk4XZEOvQ0+/rl9f2PHfn28Pp4f/f8y83L68Pd
8264TIBfErYUpcN4pZB0pNE9rWniNp0PDrhyaYBoq6N9n1Sur4vV8pAOrmtMf4GVtWyhBkRP
jXaQUdrDJLQUaU9Oke9oqyKnzsoBt84weqX6Kcvluu4QyC7q/Gn6Pr0un+RMYtR/fJmCkUlu
OpZ+6s8yllf6f/w/SzMk4ERomjRMw/DcLbDJen0ipL17eX76a1Ekf2nLUhbHlKCtZWyho1Wl
oh5X0xUu2fmDb9WzZL2aWu4Q33a/vbxyzUcuAZXUbjzdftaGW70/ot5kG6iMNkpr1RnNaMpk
ATtTTx31jKh+zYnaYg9be3yrxKdJHx1KY8EBnZQFhwx7qti6umgPAl/Tn4vJ8S0ff21/UZE7
uuIbtSlYGVxFxB2b7tS72ownfdIMDu49xj7LyqzOtM5PXr59e3kWfKl+ymrfchz7Z/G6Enke
c11SrBi/5OC6guJVJm+btN0RS394eXl6g4DidCw+PL183z0//NukoKSnqrqdc9mnwXDDxhI/
vN59/wNcyC6hzi8mFdU0F+1pdE0+Pmknrv1dxWPcp2KQGaCmLZWKE3velMdEEjH2AGmflTnc
QMqp3VQ99FIrrdALPd+vEJIczbDqh3lo2qZsDrdzl+W9zJezO/esAkOeQnR5u4DNmHWkLJvk
E11WhW7cGMqMsMDvvfakvcRcNiSd6cY5hZvR6kwMDo1LQ+G3FwAesmpmrwkg1YYWMWHwXX+k
JUTRPjlmm3YCp57LifSOyjvT0Sp8R1lph1JFD90BLAx9Udris0YrvZ5adhgYy9dcGqx6hQtx
REzF5FpOV62CWzxmFcly68Hi2LcQcE8pznhAgxUwiDa6yg6xg+b0PB9T1Kh1YynHtJebpSV1
Vq5eo+nj2/enu7927d3zw5M4w1fGmUABsq6no1c84xUY+lM//2pZdBZUfuvPNd0B+HGAse6b
bD4WYJ3uhHFq4hhG27LPp2quSzQVOuvpEMSQpbJSQ3GEH1EbGoqzZGWRkvkmdf3BlgT/xpFn
xVTU8w0tHpVYzp5IWyyR7ZbUhzm/pYqB46WFExDXQqtblMWQ3cA/cRTZCcpS101JZVprhfGv
CcGr9zkt5nKg2VWZ5RvWtI158V8beks8lhfwoj4sg5Q2hxWHqeWhrZ2RFEpfDjc0paNre8H5
Az5atmNK9xsxxlc3IwE+NoAULR1jCoLQwSxvL8wVqYdimquS5JYfnjP5wfcLX1MWVTbNZZLC
f+sT7WXcaVv4pCt6eAP+ODcDOLnF10vS9Cn8oSNncPwonH13wKYl/E36pi6SeRwn28ot16st
tJcMtug4621a0PnUVUFoi4/9oSzL9aHO0tT7Zu72dJSlrqF3lrCucx+kdpAatGKEO3OPBPeC
R7kD97M1Ge4KDB9U1+eEwBtFxJrpT893stxCW0vkJgRtrY2lyWkqpubKiptm9tzzmNu44Z3A
y0xfyy90CHV2P6FPlGncveWGY5ieDdVYmTx3sMvMMsyOvhho39N51A8hHlXVxItKUWZbQ5LJ
czxy0+JZDilYBtGRdu6PqA+dwNqdyttl0Qnn85fpQLBcx6Kn2lczwQiP+Xkrki+d+G1Ge21q
W8v3EyfElWhl1RRz23dFKjrdCkvbikgL70X7378+fv39QVmDk7TumZorVSk50kYeaJqgF6lr
1Sq6KalmMSrUqpb0W5jr5RAHqNmBznSalLUJVtoZzJ8VepUdCLzxDy/Zpe0EXl6HbN5HvkV1
+/ysFgX0r3aoXQ8/MGFt15E0m9s+Chxttd0gT5mDVB2kf4oocDSgiC1n0on8FVqJCBrD2msS
NByLGgJQJYFL28Gma7xar6Hpj8WeLKZChuf2EUbM5AphCz/ID3//QWdEH2JlbHRNyVtPX4Qp
0NeBT0ckfqGwfNumttNbti+3Gzf5psKB1FOgGAyqeIg7KktsaWtOnza6lj5o/GZjm226Vce0
jXxP0T0laP4cOnYmG+Sa5rOYSDbUZCxGtWALGXuoTqxel7SHk1JlHiD3kCtDeijSXlEwSpia
t7JkyibuEgBOM3RT3GNyi2o6WT2wzev85VR0N2q6xR6swdOmWmVb/nr37WH3Xz9++41ultJt
d7R8Q/fTSZXCo/SX3CitboYivxVJog3huqFl21ukfSDRHCyCy7KjQk9KGYCkaW/p50QD6G7k
kO2pGi4hPd1qo2kBgKYFgJjWpeR7aN6sONRzVqcFwR5eXXNsxGf5cjAPz6mGR/tXjCRN6RD/
qywOR+EUg1IrKo6XnXevlAD2blCwoZCfZNS764+716//vntFw7JAky3RivFK0BGqZJxwu3yc
/bCXhwD9TReQ6pMnJdGOHXasS5GGrtVwXiTt+aAt7ZQ5GONfnSu6GvlKOc/VAAtV16CPSwOD
cjEJjVqhzxpCAdT3oGCg7av5MA2ej+7OoPZrmCGxSZaXOpScqwy0rKbCz3dggHQNSftjluEe
OFBE04YYsB7uk0JpcDUVaR2lSoy2nqsZ/Wc2xvoE51n9J1dDqKyi+1xlDm4QTlWfP9Gx3PRl
Ao4iyQABaqmaQgZjDm1hQEY68AwQHMjQHCopKtLC4W0cGuSLENLIFOxT7KRHLnFvKnFV1HOe
3MxUOMxtcvPJMmVSZlk7kxxidUIt9fCITCLAB/meK8DM7DdbTslS1aliSx3makpTbVriBo4y
omUWrnuYhq7Cu+oa19pm04XndCz0cS3gaOeIDJvfGsK1nE+1UojTD5tKMI8Cp0SqvqObDnRV
ZZ2xv7v/76fH3/943/1jVybp6o2GnLPDCQfzyFq8E5E229YWiVHsrgvHzZA6Pr4NvzDxF7iu
5tSeKzwD43MzFxbmGXsuM+F87QIuz1ohCEnhRQcLz5aB6ItAFx49QKbwPX9RCIPYCy0WwfNl
IGZnJrBQ/VOOuyc0I2hhhijrF64PYuNtdWBvFF0tixxyUSjj6DtWWLYYtk8DW1xahAy7ZErq
Gq/a8orWR0MtS9Gp88EEWcvCjK4VLWqBFrGw3Ns9v708UQ1pUfm5piRMt1U5Zjdk9EffiA83
S2RYi05V3X+KLBzvmnP/yfEFAdiRiq5ueQ5WVpwJv+i7Xso1NyrLBN0Sfs3sBJRqkzUOjAdi
S/G5BSwpT4PjeGiBtPu/Ne2+OdVCuMBe+TErj7gBqU0qjTBnZaoTiyyJ/UimpxXJ6gPs4Vvx
HgGg4znNWpm7z76sQlCid+RcFWkhE6kwaumK2c9NnsN1nJz6Zylm9Eqhqk97GmZ+Ybm1KqBN
38PFITIJ1+ohbXPsEKLsjSpj4MaakC6lmpkj57+6jFPNFLyGTeXommTOe7XwY9btmz5jcI6G
bJGYinq4UZPQHJLFL3lAca2vTlQxQMh8WqkZALC0F2y2yKnENNiVE7p7zqhWNOjJ60MBqFR9
14GqPXmWPZ+I6KMPAEniUD1UY83AnWWVHl3qI35fNo0yePECDC0Z5SyqoZeiwrDydwUp55Md
+OLrQZcaiJKajQM6VCpSOxMaOWet3xIkm8pzpfAyuHYHVVSZ0D2m/2JeP4IjD4z1lCjzNyVb
KG26GihtBug6w6WiA0D3+oxgKDyw8Im6z1QRIWNsI/7J1nNoIdYAu6VHX6VY2dgIgBjz5ZDd
qI18YeCK6Ifp9MWhIkNWmhMaC1xlkLkMF80yU1J0nfh0koI2dTaRejDixJKsuHVUflAGw+km
BnPXV1iZe4Epo75wLd8zjitRt99GpZ6S+LTZSs2mwYC00N1lA5n/mn0KPBEHN/dz0SnzZaXC
+ZsiGbi+Lq4jU36WKUXPjo/0FBt+vie18T7bN5hztlQMeKXDEtVhCR1In5BKTXiDq2Y4Xckg
J+ri2zeKjKQELkJ4+DIFWUWCvPJrbOvqrSOrgY8ZmW9OdTEsx6hKPVnhUkPYpBWvQAaaxu4S
3kGt9f9RdiVNbuPI+q9UxLt0HyZGJEWKmoh3oEhKYhc3E9RSvjD83NVux9guR1V1TPvfPyRA
Ulg+sDwXu5RfAkhsycSWOZPlYi1zoW2mRQDQwcKHAlfFfdeIz3ePtrnEdyA9tlMW/IdRwoyy
Niv2vTE0dmnlx0GoSGB2xsOhNnUJTxQFImwCGy7HgvWlemOLOPJ2SwyypeQdy6d0fLdPNyv3
z4+PLx8/cMM4bU/zo6DxKt6NdXSqAZL8S3OfPsq6Z3QPxuG5R2ViiUuJztmceF9dUYeI9Oyt
9KKx7dYkKOelY4SPjn1RYuyanjuMcFH9o9mvoj+rq6jHyaoHIUZ8mtvb1KWO0pSXT5F4I99b
2SPnt/frzXqFR9V90d1fmgZoDxWhG09JlgSb1ZDtUN0OlhUpyUKuwhGGzWBrTk5Dc+Si082y
pPOXUw+lkD3NC0Rj5YYbJUHOls8kOrZteG7cpuaGxZAlMADzlEicPjN587HkJnFpK0bJU2m+
VHSMXEzz9WyR11n5QCfOh4GvUnKgfqv+ftj16ZllZmXbK4Ujs8eUkcE7HFJngvkS5V6Eprd0
xrhYFUOye/z2+PLhhVD9UfXb3GaBrNkvNB2h/FtQoJ4lrIFxsRQGuSfPVfcOtabk4CU3tBts
uc1S2eoGrEcMEHnXUtlYzz+9/ZDsiiE95um9ay2oCY/F2Tddms/lCjvbUahsgWt3qnn5Dhfg
Nv+0HC3a5eF0SyEl4vwUoqugQ9KfTJjXyW7y7LRn3HrlbfPfJZ3PRPsugVu5dkqSc1+SohN3
oBfbrsv7pKjJnhaneNx2XS7CNVjlXJ8G+3IV2w4d7s5wX8wTFEYmCfw7UgQf1LmoLxhlNuQY
VGjHTvPu819kKi//fvnyn8/fyGeEpQGMUkXgMTSTTnVcaOs5Cw9XbzDwnJEFJwBRSVeLirKT
TKw+yNVklbRqayzVTnGCpaq8/vFvrvCKby+vz3+RA5BZVZo2czHkGQWdE9tv8umBlTTjppKS
+b/sbLLkXNRpQZcg0OCb4HOqt4HFSCc05D460z4Rjjr+39OH599f7v7z+fVPd31xEeYS2nAr
9RMtabbA5MPU1s8TMiS6I3sLLzMcu9Lka6/MXyiGz+0EjnDOdC3Kor661hkjKnyjkTqtkr53
eNU0kiyObmLr9+0hwasLcReI/m5nnSKkt73CzQu0spQVBLnZh0FzqjFAjAVcquF42oG8OJBk
eEQndJFuJaVYqLe2jwgWol4coMtbCsM2gCsQiVCbvZnciEGuYPEK0TeB5hb9BiSn4dQXpWNN
nZy8YGPFDnQzviW6YAuwHN5m5ZDQ21ydSLSAjI2ExSX8J8TVHmubyHIB8U8VsN1snFlw7Cez
cI2H5ERuzxyIp0U1NpDheHHJJWDsWElhO8crxygnaEkpSg44TJjnbXCu92tv5Yh9rLA4Yncp
LOsQ+fVRGMIgBJJxerh2CBbBJ/Aqw9ra7Z8RGOpaYdig8XkfBqrjcIUehqjPyzSMfNTgBNi7
wgTtMj+O/KWK7fqBpY2dafputdoGZzhz0q5hg9jLNnSwzcmCsITP+HUOUCsJmOcxMwC6VwKg
RVO29ss1mGACCGG3jtAbM0hyOXN2yYK0KwG4ums/grVd+xvwGRF0MNwk3aUMR3RZjxHT9QqG
5ghg/cbBwAuwpAGeUwJBd0AUhk3p4VYR0eUwgEcNB2IXsMVycwDON+nsFYZunziu/mq9xok5
tPHRTZ+JY9zYc5iYhPrhzm31EEP0tulEbBtnKSUYu1my8c1Dq5nu4gfjSNC3kB74wLAcw2yh
dQ+OrzrB4wVFRzvlbOMFrgPckcFfgzmWszjwIpxlHPjW99jFZkxDi+3QV9Hix/mYJbKStowj
BKzxQky7AGgzen85dPfBCmnXgiW7vCxzMFSq9XYdgv6fw3ANDIwwGVIb0a/ccI7BuJEImqsj
Aqa3QIJw4yooQEpUIOEK6BeBqD4TNWDruyTY+qBJR8SVG7TOJwQr4Rll2cWFOtsvdAH63cEZ
YlW89aLhkmbLB/Qm8xjkAOXZppUXxUtDnjg2MVAeI+D68gl46w7ybvItfyKJS8aCxMCSFAS/
mXuwWoEJIIAIdNMILBQr4LeL5a0PZsqELOUv8DcLoOivuIDQ8/92AgsFC3i5XK7SAh80Z1dy
oxlMf04P1khjdL2/AUqBk5GFz8lbVCp5M0WlEh3oD0lvIaC5atLoMWouiZByWGqtPgw9uHzi
SASd06kMsEE5fQ2GraDDGoQRttcFsmQyEgOaIYIO9KmgO0SIYO+FEbLHBR1ocqLH4Fsr6a5x
PaJvdZTmDU8j4w8Ah/DI42R3Ctg6nIxTsENfhiskmIw+j+iHatwGdCD4Yzej84a+xSDetSb8
32Jf6NGPDJ7qtGSQs6Lbj7u2rjNCfBWBscqHc5SAENnGBEQruHAYoTeU3cSFm4xV6xCZL6xP
pOltl8oRGMtLYQh98EGmc/btJoJ2MqPHtTAy/cTRJ8wP0ZJbABFsIIKMh8WYB753UDj0UG8q
sPFgIwkIuhZUOKK1D9WqiIoCA0bMHPtkG29AGyshRRZBl55RWd5ajdx4sTtQiy8wHJAucPrX
9ZuWmc7909LCNzU6F18qBcFC82Tp1Vsvdi4LEt/fgLVRz+SmiQMx714KQIb0g/Jcymi1xq/F
Jh4RQGZxWStDzACRBBDDkrndvg0CHBNC41kvNfel9PwNbOlLtVrBIB03Bs8PV0N+Bt+vS+XD
Dw6n+5geGk9cNWRpH5MY0BaIjHiIs4xxlCGFIXRkGaJpLehQkRDicKOusOCnTiqDD09BBLK0
Hy9iEUGrTSD4FZbKssZuPFUW03kZYsGv9FSWRf0vGID6J3oMvzsciVdvK7CRbfnzTXExXWMz
3jocAWksS1OfGJAhTvQQmClER9a0oLu6ehstz6B4i/ZcBB2oQ0EHhhLRY4cu4Qh6I6sxOLJE
uyOC7hB5i2eoFttUoztaeQvtJIGg2LEaA6zKdoVOS4mOq7jdIDuV6B6wwgQdtz5LKFjP4jh9
XwZmJG2TQ9yS2Eaaq9YJLKt1HEIdRdtVm8X1oeBACzux04VWcFaI9hko/cjDmpiCmIfL2kyw
LKlTwbB15B4ttl6dnOIArdsICJECICBGXyEBoE6QABjlEoDb9X2bRF6wcvg/m7u3pcfY3ZUu
1HbYOZ3O2kPW6XGodtVFE1Yu/eg94HzvAsNmXeRS8NAl7VHgoCvmBxrjjZtjkdkX5jhReXdb
ZMNOXAh6oHukeX3oj+q1RY53CdoPOFE2X9Vspuc74yte9v3xI7l9JhmsOz/En6zJvZ8uCm9Q
/U77TBz26CaSgFstOJIgnei5j07b5eV9UevFpUdy8GfSCv7rwRQibU6HBL0qI5APhKQsjYza
rsmK+/yB6XKMb6P0Mh/ksxiNkTf8oanJDaLaITequ0Vy8qq713OjiMNNpRebv+fiGb1NTmZ3
BRxdAt13lZWibLqiOaGFNcHn4pyU6hNJIvKChVNFM6/7B3xJl7BLUho3jbVS8otw7GgMyodO
ugU2urNIk8xdUtG7sd+SXYd8URLWX4r6mNS6CPd5zQo+rxqDXqbiNaZBzDOTUDfnxqA1h0LM
HUilH612vW1G9vieJuHdqdqVeZtk/hLXgRtyS/jlmOclc4/MKjkUacXHSq4Ph4p3bWc2UJU8
iDjHOmuXyylg8BZ0caTZ9+aAquhqdZc/uAQ6lX0hR6KWX90XOqHp6LGokXmb1ORSjI9/13xp
8z4pH+qrnlnLVUyZZpBoOOZSkdkRg6uwkW98mAvzSAt89VPwlEkt3EumrrlMjg9ZP82oEVCI
pHYMJUjuiHUaSwrj4a2kCoeejoKFG7ayqK0uYH2eYI/dI8rHI/8s5czNc6rb8uTGO/NSsape
yCVswgqXQmBV0vW/NQ9UgPY9V+iu+SQUSnHGtogAm5bluWvkkRPFQ6UPsf7YnVg/P+yfc1Pp
S+KcyBgYWoYufQkNXRRV0+dmH12LukJPHAl7n3eN2ToTza1H3j9kZHvV1mjgupacDJ12zjok
ZWv09fQ6ARgssy91aEnRHWehG5Rv7Y02HBpuAFxVJ4ZmTmYi8XZZ4Ue8J7YbmmNaDORujpuK
0umd2hDE4XYXVlWaD7n20pEjhZyTAfOIjgEolWScfdiVTYriljGyU4X3BSMBvYlR+WXktCr9
J8v+SYnujk8vr+RYZYrNYDm7olyM50tEYhlvEEAaKKh6mnLTSnPKccPbst8rc+QG0AMxoXMc
YE5/qWNWQ1mbdFe8b3njIwukhu+KFJ6akaM9JISQgN57Yimy5oxtmBtLnx+gJXPjYEGKiuYN
k3SoOTk/PQFH0C6thnt5UR+Isqf/4d22G09VlLs8UR9rKv1MTlB0oGquifrqTpGyN4WQr0dg
iM1b8awyk40PYNzNHOC9ObUloeUgJkslDv5UtwQT2WqBwqYIh5e8L+wOLJRHqBY+P3gxpi48
ExYZHum/Ym8mOFFJUdeUjgiblPRUX9GuJGHpO5rRmmhH9s7SQPKN+2K/XbkBXTtmKu/2xbRJ
FamHJWKoXJT3pBVfafVFqhklE812riPV3ePXp+cf7PXzx3/by+I57almyT4n34CnSte7fMQ0
Ts3L130CmtbgamFv6tY6vxguXeiXdHyAaMNknN9WADdM2NXc4mzQklnw7TqyZGvy5XS8UESZ
+pBnk+DkaMxqHZHMfgkkyEnSe74e/lnS62Dlh1vsgEVycOMQeYCSIAuidZiYhV38lRcYbSJc
J/ixJYGgwz03AQvvfSurFQUZ7Wjf0MCQipzbqRfRZ+JWP2Of6SvoZlbAXHP56+vV7txmx1dq
w7vTDn23VJYueWelbtNku1Ar4e5Ob9SyDbbrtd06nBy6W6cNV9erlVMYXq+T49CvFuZ7dhsR
GZm6MxpZzd3G4QrlRL4QXTmJZgnNET1Sp1axWzIK8H63YJCOGYX3VbgxMzOp9y8FUbqENFqP
HEjqlC4/UMSlpjOnQebHK99s/D4It+Z4nba4ddaamYnrvL/uioPVBnzZlTp7p0+TKFxtrER9
mYZb1xUBKVZy3WwiePlEwbeB1ckUdgefm8xzNvzbqFvTa2fFMp+83vverkqtEsgdqBFXUIUL
Fnj7MvC29rwdIV+vuKFq5fPbL5+//fsX79c7voq46w67u9Hn41/fyKUqWCPd/XJbbf5qKOsd
rdgrSxpumqQN8tMtx1oVr9Q3SrJRyisfcVZO5OHCOQT4Eqk63VwF2wpwsbMieevSGD4ti7xV
uDB8ihaasbLehyrw1mZ/Jym9Ig7FOJD+wr98ePlTeLLtn54//rnwMez6OBQnLnNP9s+fP32y
GXv+sT0YbstVQPo5dLbkyNTwr/Wx6Z2ZZAVDVonGU/WZMQcm5MgXFT238Hu71UcOuP+FWdMW
+bvSWJK0L85F/+CsDmnet0sa/egN+oAWHfL5+ysFX325e5W9cptH9ePrH5+/vFKss6dvf3z+
dPcLdd7rh+dPj6+/ag6FtU7qkppRsICfqH/C+xMt7jSuNqmL1NEdrTgVqh2oOIwyBvIspmjT
eUjuSKNYdRKqAdZDLtiLHcXuQtu2XZ/qPtmIMFmpcy5EPKZ9w3UNLIVwjvXNEe17EGrsMxCp
PpP7/LFunHD3eYpGoUw4YuQrrD1lv7dkEgitVh2lCtxwVarSh1ORDw6npULq7jz5Hpk3r0hS
EG5gYp9M6oUcBcvqagpFULLbhe9zhu+I3Jjy5j06Ib8xXGX+Bn3XpXxJtLMBcp/s+zY9Y8K1
voM+pHz2nLoHVBHi2KB7LApDtAFFHh+qOIwClCe3CSIcUF7hiLdIYGlOxI5cHZaGwsGNFPU+
6YR0LEx5y9lAwUrP12/w6xAM/muwRHY9rpweolq06T7G9rXGsVIv0GtIEAV2cQJxJolBimrt
9fr9Qx0ZLhlWuPMYzTar0Mfvymeed4GPvo3zlB3vX1rScYsjXq0CD7Vgl4Y9r9JiwcQTwXu+
Ewfja8ntKrGL3lfibS0qmE9WR/wAhSWM8WUUNRcf75JOLHnFl+9LA707cwY4aAkJ8J2PG0sc
r5YGIAsrlDXLuCqJrc893bHTVa2qvxV/KD9u/GTl/YSKzljgw4WzMrp9z9/AzqIm2qZvNMU1
8vQeFWK0Xz688lXBV3e9RsXoI13D6aEHRy4h4VLLk66Nw2GfVEX5gPpAMizWSbDgCM4Ky8Z/
O5vNGl7tUzniOIQfnc0a6NqM+evVGvDLN8eowTgSLQ7V/t7b9An+XqzjHoYTUxnU9+sqXb8N
NiOsivz18pjavVvHqzeGXRumq2UtQaN36QM6hqCw2nLc3LDoLPU3V8AvDzVAVd8/1O+q1poa
T9/+QYuMNyZuwqqtD7d+bj0rDhHAYCgOcgfV7hdyDrrvqyEpkw5qqCpncIGt4cOZ/7TLbSY/
ZdZ3wmkpk6YWfmHt3M7d2lMPsOaG6bdex9tG3f5QMZZUcOCNt8wWJDn35MQJdDAdN4DP/xkY
l9JDaQzqM57agT7p+V/8q4gmIOsr7CFxFiJ1BdSaOKR7BrvYspU7tQig/R5gIVXxFdHFcSDQ
AVcwRjhxOPtwlNRn94JLJBXncktjs/fl7V87aR8Fy2Zvv5FRLK2kVxo3S3bEJtD3bZWue8uK
6DPP2y713XiS/ON2KZM9fnshF6ZLX9U5XpkiVUb+CyhUBrP0EYd2p/3kWFlxr/ZQpxRrT3Xw
fRFU7c7AmNyuhAR4t53zWwxBVSBCXYEkRpjl5d6MfyiRY560DqpYnueVeh/CqOOUKjldp6Dv
c07pMenoipUSYWa93sQrK3TYSFducFQ8R5YWxaBf0eq96F47dEkzXxG9TToRy6MV4d9vl6PG
sNMC/N+VQe4a0TNK+BkJyOMwUtMsOaBxO1Zv2JUUCUXtERXBvlIVDnGEh+59jJW4jQ8Yiu+8
VzeB6BcfIgVv4NOtXQS1oh0NJbuZ6I6TRZH57MgcRNXPQySFds1PsLbnY8N6C5bHo+SN9OXp
j9e744/vj8//ON99+uvx5VUL7DWOvLdYJ/kOXf6wM+569cnBCAs5Y9Mcd/RT11Q5Xa/ryW0j
VqtVXpYJxV2e2CBXw78Gw7XxNtjUlXNiSEu0RD1e+EKlHo+Vb1epZqp1jI54HP6hFQ567qzM
SgVouwwDpJo1mVheDafYiAApzbIvTx//fcee/nr++GirXBmgplHKlxTh4FnRKeU969KhqvQR
OHnad+2hT1dfzGBCk//UiXxTqpPl58wyuwxJu7NT7vu+6rgR4kxYXFtuLZiSCHMwsrNrLqUz
py5L7ATSK66VZMaFjbGAS9ttgaFu02ozVQBvH0uL2yn32InZ7koltV2qKqsp/Kpds+rKnFnW
fEiSm2gzDd2z4fUVUQ3bBZFHkWYv8UtM0rlyie6tcKv1vKnEZ7NQ42DJSBStHjZ3DE+BDLGp
JHkhdzz7vQ2xce3hrk5zrRPGl3agwW7N2d87m5MmvDlCR5l+owtRZlXYcZyuaQVdaE9w1Z80
ddFxk5BxSfn3AWvNOWVfodOkfGwE4TfblLS9JppqigMa11WHtwln2MPP3EccHmpJGUTgBwqe
3NutxiisYar3fsob0VucauJKPTntp/aO1saN2umhE9Krs1pJinLXKEsNErIiinp3XHy1huqo
RN6W668hoJneXfhgq2Q2t64b4wkIAE2Fss+5otHLOhZBxBVDpYlEcS78lVXAKLp1ZXWERVDM
pE3pvFc7pydd32apSy45e3kaZU1FUyGtsneTtKoyjeje4cGRF00TvYZCLD13YY1RcDmTdAsq
ID6Qh8dvj8+fP94J8K798OlRnF3eMevSs0jNLa720JObfDPfGyIVknYC5mCZFwhwjL0lmpn9
6PIfff1GXJ7Y0jO+nttYp4PyxIQc6usGrLgc6qTNx4T22JTygo6TTueNLFmw5YuT9DLTb+OA
kATkp2lTC5WHlI9fn14fvz8/fQQLzZwu64ubsz9s2pAap5Dchs3rgq/72xNX7p0jIAiJwtIW
diQQRgr5/evLJyBfy8e+siFBP/m31qSIQX8Qb0OcCBEWUEbHughmlfYMUyJyxYFrqNVk7loK
wDlGGBvDn/z17ffL5+fHOc7w/1i8QoDpagfjrf0L+/Hy+vj1rvl2l/75+fuvdy90GecPPjFu
VzmlT/2vX54+cTKFFQBXTGnnL03qc6K05Egt7/lfCTt1+p1TAR5EEJii3mPzRDJVDqbJDz+Q
TIosdkiwxBKjLxh93JSltQKwmiIzmkjrJ1MSxTwU0KKUtjDql3PriVfABXyAO6Fs302dvXt+
+vD7x6evuHbT4kG+BVRnfZNO4biQDiHUPBv/f8qepblxnMe/4prTbtXMtiW/D3OQJdlWR6+I
stvpiyqTeLpdm9i9iVM7/f36BUhKJijQ/e2lOwYgvgkCJB7y8MmW5o0JW7lsVr4vP11zQN2f
35J7voX32yQMG5XW7VrXFmAiLb4QyPUHSonrLbnwKYPA77L1GnkwftUQZUrzX9meb56ci2w/
JxdFPXJlCwHKzz//8MVoxeg+Wxv37RqYl8QrhylGFh+f5LGUHi8HVfny4/iC1j7dRu1bcSV1
bNpa4k/ZIwDUVZGS9Gsau11W8VrlMRxfG/XvV64tw5+Pj/Xhvx1MQoskBoOo0aB9F5SW4AKb
qArC1ZpCS0yF+6UKSB5QfTK4DHIQnWU9bHv/wrVX9uT+4/EFFrhje0kujtcb+PYq0411FSr+
D0caSB9sixSBWHI+ChKXpmZKPgmCE2LDgMrIAuoTh9YFpw1Su6rDb6RFr7ENNaL0y14Fgqng
BgNXed7DXEgdImVngR1ryrK0UsVdGLRy0bpaOeSlCOSqhHu3kixV6aPXvsf7h7xAO2D5YNOD
Y5ky1EFXk0aUWaMq4lqpaTrzZnT8L9M+a5aaPSgOuyKtg3XckvF6ZEs/uklvUifkcl5eVfQP
Hbn+98eX48lmat2McdjO4fHfEio6TS1DBrCq4vv2YNM/B+szEJ7O5rbTqGZd7NqQFkUexbgL
jRPBICrjSqamyc1EpIQAz0eZ1dh8DjEI0BRYlHyiLlIQSP3JLrY70XOHgSXVLoblVhh9v4oC
QIEarYHmrtK7cbNTWxNwW1dehMZWZknK0tQbKEm3maJVYu6IOpRvHuqc+ufydD5p0bPfcUXc
BKDFynzqr+YGUiiVc4fdPZJgJYLFmNpUaYxtU0uxWbAfjcyQUFd4a3PfQ6AlHFNRWecTzxG4
S5MolghnVZMlgtdmNGVVzxezEe9EpElENpmwQdw0Hp1yqYPLFQH7Hf4d+UMqdWdFxdm/Juab
C/yA9bdamXdlV1gTLjlS6aPpgGs5j8OimxaIb9vMFEoQf7dKVpKKgrU9MEjbuoUEq/5cCfYb
2pm2VoFsoiPxDdUUiMQX91uSxrdfvtIvr+2Ue6jHYYOnp8PL4e38erhYVh5BtE9vpUdaZoEV
hs9AhbA8pbEzZ8obBb75JhkFJHsTzFMVDac2YGEBvKHdVVGrGptRsE94OexuLyLeaOpuH36+
84Yeb3CYhSPf4cEbzMbmptYAOzwogq0IUyZuPmY9vgCzmEw8K+23htoA4rST7UOYHIeX9j6c
+hM2nFt9Nx+R4GQAWAY6DGOrQdIVo1bR6RGU38HlPHg+fjteHl/Q9B8474WeOtFsuPAqY7QA
4ptx4OD31Jx69btJMId3l9SWaLzRbMGaJwRR0sAyQE5vFIcabB8CwlcwiXyNIded0vcaERzz
y1UWVNiadRzWpi1TK72ZVeEjS1rhyUPAMoPy3p/YtW/2fFjJ9qaKFAIn9SyioLQMvTnod1ax
2nLG0aW0Dv3xjPr4IYi1EJSYhRHfDQ4sbzSl6zDYL6YebwSXheVozBpeyyhSdXyHRjGT2Qxt
IKxu5MF25rK/w2c0R//kqbjDOeh8JamOoOyHmn1x43t5qiZWg66Y3a8+BbxpjhgGFUZyKuyZ
qnI0bp47etLJQiKorA+VEaDjO2kJSFeKkCsHE+Jqp0dj++ONvhoukwN1cBsUrUSUtcSGkcAV
52hVncE+IgXWcqCGc8+GCRrUH2EZCFZ763Nlc445USh0itB1ScC71dQb0u91lshu3bXM7xaj
M1nh6u18ugzi07N5DQOHVBWLMKB3RP0v9E3njxdQVmhouSwc60CA3a1jR6UO7++H1+MTtEtZ
YZnct04DEDI2Oo6MyQMREX8tephlFk/Nk1r9poHQw1DMzeM7Ce7t+S8zMRuytugijEZDe3FJ
GA22LkEY6sgMfIetTSoMzCTWJcmTVQrz5+7rfEFS9fbGSJmuHZ9b0zWYqEF4fn09n0x1kycw
JzcTegiFbr+63xZl+12/0D6SyHW1VSCP0wOodD69LmGJPqqFxR/Fk+HUiP4Av0fmTMPv8Zgc
xJPJwkcvRRFb0FFFAMQxB38vprTtUVnUmCGe6LpiPPb5MPPtOcbnlM+m/shMvATnzcQjKhNC
5j53ksL5g3m/ejws6LO1IOwxNeA7AJ5MZlzRiqG0nWwN/G7NjLrDhWX1/PH6+lPfZ5gLpYdT
7rRvh//5OJyefg7Ez9Pl++H9+C90W44i8alM0/bRRD1ky6fGx8v57VN0fL+8Hf/6QEtDs46b
dMpn4vvj++GPFMgOz4P0fP4x+A+o5z8Hf3fteDfaYZb9//2y/e4XPSRr/tvPt/P70/nHAebC
4n7LbO1NCSvD33RlrvaB8L3hkIdR2qzcjoZmfAENYPepPN6lVsKj0H+mRV9VmnoNWrOlMlhL
qd9hxcoOjy+X78YR0ELfLoPq8XIYZOfT8XK29L1VPB6zsa7x5mLomcbsGuKby5st3kCaLVLt
+Xg9Ph8vP/uTFWQ+CbYbbWrziNlEIbSGhlKNQt/ltbWphe/zIuim3jowIplZ+pOB8IlC1OuH
2suwiS4YTuD18Pj+8XbARNyDDxgXsigTa1EmzKIsxJykpWkhto55l+2nvMawa5IwG/tTsxQT
ai1awMBqnsrVTO5jTAStW6/mVGTTSOzZNXtjQJQ79fHb94uxFgwd73PUiBGrDQXRdu+p+Wgh
Ka5M8hszThiAMhKLkTkUEkKisgdiNvLNJbfceDOajQAhjtQAIZwZHptzDTE04SxARqyfaIhB
bIw9gL+npta/Lv2gJOmPFQQ6Oxyat1X3YuqD2mtlwW7FCpH6i6HHhs0mJGa6LwnxaETqzyLw
fM/hTVBWwwl7Brd19IL+1NXETJid7mBSxyHpAjAhYFiOKyiN5HxD8yKgab6Ksob1YNRWQlf8
IYWJxPNIul34TTJt1XejEYn3XTfbXSKogKFBdMPVoRiNvbEFmPncfNUw9JMpf0slcXNuMSFm
ZjpGA2A8oakltmLizf2ILXkX5qlzqBWSjVS2izOpcBnCuITMyFbapaDncrdrX2FmYCI8k9tS
NqHeex+/nQ4XdSHFHCZ3NA2C/G3eQd0NFwuy19XtZRascxZoCQLBeuTRy8gsC0cTn81vo/mk
LIYXCNoabHS7AEAFnMzHIyeil5hIo6ts5ClOz07iQ5AFmwD+E5MRL3Owo6zG/+PlcvzxcvjH
ukGWKtGWPw3IN/rAfHo5nnqzaJwfDF4StHFhBn8M3i+Pp2eQrU8HqnZvKm3syt+Sy6CB1bas
WwLn1CkDZbuwHskNghqDvKRFUTq+x8AapJ26/3wv9dF5AuFL+ls/nr59vMDfP87vRxTb+/tB
ngfjpiwE3Va/LoLI2j/OFzjAj9eHg6vK51PWFQmP90RH1YykzUWNbGjmcEPAxMx/WJepLXc6
GsQ2FgbOlL/SrFx4w+HwVnHqE6X8vB3eUXJheMyyHE6H2drkF6VPr07wt705o3QD3JAztopK
QU6TTTk09nwSlp4lkZepZ4rM6rets6QjSiQmU5Pzqd+9twuAOnINaZ4lA/xzx85kPCTXwZvS
H055BvS1DEA0mrLMojfwV4HxdDx947hFH6mn8PzP8RWFdVzpz0fcSU/MhEoJh0ogSRRU0kzJ
cg7Nlh4fvqBM8rVJWK2i2WzMJ8OqVkOa9mS/GPHZu/aLCcnABV8aGwbP4hGRh3fpZJQOr/lz
uyG9ORDavvb9/IKx01zvOobx601KxaUPrz/wXoFuoOtSQrY0DIADxxkbuDTdL4ZTU0pSECpO
1xmIxFw0AIkw3ipq4LPUKVZCbPmn5b1M27tpNsMHwo9+aCQE9pxICVY6rNzGglC45BYZ4LWZ
JW3FMq5SMyWIhNlGlQhs3YIoVLu8v5ow7R1DCTfJcldTUJLtPbv/APN5HiKxcP6mTbrmXVUk
hVoeTrwMpsmLxQqtbhFFyHk8aIqRb/cYhkb0IZ1jB0VJM8LEzLoqofoty4LuBR0zaXQfZcoz
iJDKcJjziQXck2DTCMKHJEffWmegutzSWttXJGsBd8ZopAJgifOwTHkNQRLg25KjCdLRkXRB
UDswBcp4TtriYPjtbsunI8c3lte/BCVxGFj9Bdim6m3j2gyGrAEyhYnVaOXW1zOsSKr7wdP3
4w8msn51r8f8esUBGyvh7reLyrvD9BbXlnyWXmJBQvwa1PTCLgqx9NLc9x0Sau1Dq6+B16Ku
h4+eaFkgq02O56hKVPeGKYt+lq7DLUW0NW3mqoHE66K674JyQ5eimNucaIUGhJjtgjogIjyv
ewqGRusneKwiLLJlkvMhIIsiX6Nxfxlu6DgDo9QduWog9pR2TSyD8E7mprp6vMjHKsAUYR2k
5nCIuDYtoInPHuKCejNzBPZR+L3w+Hh2Ei3N6scTu0b7ONBQfSC8smD9WNlv4kZEbLwviURb
BLtAxd/XX/pF3fmsmKOQmLIlue9/pLm58zvpr2H3VTlxqERjQbXsl4p2A84iO/9Vu1jlLVeY
YcQNRGm+KSu4CLOkB+vloNBwZHpZ6U3YwCCKpAhX5Tqwa7cDwkhgnejwtDbCiIzPwpt1uiWv
XwqN0YO4q0vlca/XinRMNO4xKRIdFP/UT5fl5mEgPv56l1a7V36po+I0gL62zwA2WVImoDBt
SPAORLSnvkwrUjvEL6BzBVBBnHZoQxtG4yTBWpXnkOcHiCRSaB89AgaTuKrQK3O/lkRcLYiT
vUSCJsiDtDBsxRk6ORpWi7TDDTaHj8mAROHDOt+KW61FsyhRYSmGdttGAcCRaFTd1ie5UMNE
Wp0LX05OZEZBkF9UWEtQB/aUSgSGb77ZOD2OtGcquFFTF1VlWUIyVFGvEy1GwH6oAlfpIkgd
WY2QCiVo6c9zb/eBrp1kD+yym0gnnfbvvVWU9gt2j9gmQU6PR2Svx4DCfBp50S5wc2tJ1tzs
qr2PkQZwvO3NpygqEAjwc+7xRkWimk2knXC6lRmayC6XUypPLrUY7BWtUDeHcgeKVwOVQCu3
dca5u5hkcxlFv9cGELcbf56DtiNMGYGg+qsbUbhN6EbNypHePLShCMfiXS3EoAK9hiF0uxJ9
4F70aIswTgs0GqmiWNDZlDIH1yrtdH0/HnqLm+MsCe8dE90RyOxNeSmaVZzVBV6k/GSKQaqN
kKP6y8KsrrftnQ+nez32pPwqkD6xt3qiDPLiXM6SQ6NEss4ZQf7a828jhFJupUgk9p7maPWO
4lD1Qxlbi1ALu1HZ7ECKLlikZCcK/cqg+xW2MTK2K2u1dAjm2BOTcgcinWvLI0knVPS5ioka
2UV3SPtw4qmCTeja7Wg6hbqqN4KWwrj0z8orxVhTOCsEPXYzHs5urimlvAIF/HBtcKmseotx
U/pbOipRoIUYczXLCwOtRzSu9oHAVyZl7F7FSjC/i+NsGTz0EqXdIHUfKN1djjxUCnsHXtE3
a9P2l/34lNcbTCItdi1AVyqi4Ud1SWK8ZCE/T1XQjzsXnJ7fzsdnYo2QR1WR8NeELXlXtZkd
so2vbv7s3xUqsNRtE/427EpRhEXNXZViOMX5sIlXW9NYT33XisQxxkHIXFgo10ah+bqskNx9
w0kjq3EZPN+vZDW9DkpDaBEFrMLVMjrVAc6b0uq3VTgKga6x0dXL/YgRyIgfacc7XH1SXyvr
vv5gtFECbn+NQSRhoNelqW0FOxAdy96saFNuayZlcJR2cEjZleqQMq/6Mri8PT7JJxD7CkrU
ZE7gJ4YDgxN5GfASyJUC4/CQLBaIirZZxh1piBPFtgrjzjneqlZju/wYtwtZ1VVgxidVzKQm
YSRbWLOuueh/HVrUm35BDZxsDLQ0M+Z20Gt0lNYSrD/k7UdUR8dfTbau+tq7jWkCaswkQ/+U
Fcg4ltl0DyVvqc2B6YpGpip/McMjiZZVEq3JVOnSV1Ucf401nvlac+0SM4e0vsWvpOgqXlsZ
q4uViXE1KVqlVkkAaYLVloHmSSH0LJVB2OSj9omXG4isdA6FIBfU8FOmkcPAjnkRcd1HEp1o
VrpDvjKIzXbJwuHfJlyRZprIkk+GizQiLDK7oWIZo98id3kbd6bi8CfnVm2Cu9tQTHkH07mX
E2pbfTBBFrboj7GeLXzj/h2BdFwQkqmkj5xlSK8ZJTD20jjbRWJGiMJf0mFZV2JcaCfZ0pEF
WZp+wN95zD4NwSrOa/NizLTvCHMjYSe1DVEoUxCL72PuQMJwc/fbIIINY4xLF56sDkE5D8p6
S63Ps8IRT8pyfFZG4seXw0DJSeTJdRfgo3YNbFWgcx2fbgpwiYyabfr2+s2KmOJpULMP6por
BPCj/icjWXEhElgrIeco2tKIONxWKpvRFTNuqOSkQb8qcGwVSL93xfqVyDuQD+pGxfrtpurz
MjLUfvxlJ9eB+rJlGIQb47iu4gSGGzBWEp0WDMQhn0GoI5GeiXbEi37xak7YSlyDxVK2Q8YS
fpY0LGrfQ2nEeiXsZbSsKxd1nqSa/jqufm/8JAijiLhao7/pL1RKIYf/dhkyylqSfwa2kThi
EbeV4Y0SWsjwx9vXIo/7HcFchdwDhzlndPViwLuVzpEKXNLR9iSNG6RwBe2FEuI8rB5Kd69E
s4vtldDhuijarQrUD6udKFAvv921hkBRcErFtqgNaamsgH0rYPMlqPLEDKGiwNZmVMC6ig3R
6X6V1c3OswHG3YT8KqzJiAfbuliJMb9cFbIxb05QXrfWe7h1ROfRcZ8dC7CA8U+DBwutOPvj
03cz4tpKKMbzagHkJrFWnELgfXCxrgJe+WypXHyyxRdL3BhNmgjDNkSicAUao3KF2TNlYLo2
mcK27qrqdvQH6E2fol0kDzvmrEtEscCLcHa2ttGq3X9t4XyByqiwEJ9WQf0p3uO/ee2qMhNA
6ZrD3arHpLqdrFDXMVKQNrJjUmCMcxHXf/72cfl7/puh/dZO7gkY+wBWsPTrvtn37PcsIvdB
0Uodt4ZEve29Hz6ez4O/yVB1uxhOMnKJjYA7nR/8ei2EUHy/rB2mUogvMf5QVsBBzWZnVsEf
N0kaVbHxCnoXV7nZgPZappXespKyZwn4xeGpaFwSESjqq6gJq5hEvFL/XU+D9qqrP3hXSVGo
DAgqoYDR6KLCMPsWEwqitnAKaCryNh+s3Ad6LE8Hfp1trNLhd5luKWxpt0kCrM2/tAqKrd+f
V7Y00EJ0SUNTONGYL3BqxSpci0OKQUKxzbKgcsk5uii3/KBIjCMf3UvgP264FO1XkvBRwaS5
ujkjIXA/x4QIUB/ExsVn+vLXlUElOaxfdiKLzJ7Jsiej3Of7sYvhAG7aTrP5wbSdIPbez65U
QTAzKsbZeejyvxsXgpQgq3nrtF5BBXs3pMhgynoVlXAAVZzKD9tuR1bz1uqD+q3WHoVaSz6u
it4Qt7Ab5qMdiVP3agm+mnZ+HbR7d0XGCXpyUv/pdcdGanQEfrRn0J+/Hd/P8/lk8YdnHj8p
irpRLEsajziTFUIyG5GUbhQ349yJCMmc+uNZOO7xySKZ0L4ZGHe75o4YPhYR5+pmkfg36uCc
JSwSww7awkzcozLlLKMtkoWj4MVo6hivhekGbX3juzBjVz3zmdU1kNxwqTVzxweeb2ZCs1Ee
/UrmvuHL92ghLdi3h7NF8I9qJgXnS23iJ3xDpjx4xoMXjt6M+O54Y1d/PNeOuyuSeVPZy1VC
+YjdiM6CENlpwGm8LT6M09o0p7jC8zreVgXtmcRURVAnQc5gHqokTZPQ7h3i1kGcJvxTY0cC
CiFn0tjiE2grxnfs1Zvk26TmKpWdT272v95WdyoHloHY1qu5cU7kCa7mHqDJMaBkmnwNahkA
RYeYv9KB9viFGK+SS0AVl+Tw9PGGHiC9tFp38QM5hvB3U8X32xgvqVEv4wXwuBKgqWGoRvgC
VPM1JxosrxW0knKFR1CkoFetR11D9ODwq4k2IFXFlew8aWl7S9VEWSykmWJdJezFbktJhBx8
hgPlKopzqBbvJ8KifGiCFMQBGRnJoLSIzEb0S1hBESh9cCJzjxhZlyiDnD6VQV9DSZPB9G/i
tORz52gl8ToOgZkDXWR//vbX28fl8DtG+ng+/+/p95+Pr4/w6/H5x/H0+/vj3wco7fj8Oyb/
/oar4/e/fvz9m1owd4e30+Fl8P3x7fkgXauuC0fHXX49v/0cHE9H9PM//utRxxdplyTenqIV
7R2sXjPctkSg9SKOs5Fznl4aKRp8gXKkpTfiKbPtaNHubnRBeeyd0elnuCLRpEHp+W8/f1zO
g6fz22Fwfht8P7z8kDFbCDEoZ2YSOA0M0jVJW0HAfh8eBxEL7JOKuzApNyS9DEX0P9mA+sAC
/6+yI1uOG8f9iitPu1U7WbvHdjwPeaAkqqW0LouS2/ZLl+P02F2Jj3K3Z3f+fgFQBw9Iyb7E
aQDiCYIgCIA+aW0a2EYYSzhoi17DJ1siphq/qiqfemVeBfUl4MnLJwVZLJZMuR3cUsZsFIb0
0GseZPdn5Z7zgbxu8B0ol9wmXsYni4u8zbwWFW3GA/1O0R+GL9omkUXowe0NogMOqe+1leb9
64/d/W/ft38f3RNzP7zdvT7+7fF0rYRXUuTzkAz9VsiQCN3Bk2EdKT68q+ffnNPp+6Fo6yu5
ODs7+aPving/PGIA7/3dYfvtSD5TfzCa+T+7w+OR2O9f7neEiu4Od6bZri8x5C2g/fyxsQL9
twnskWJxXJXZTZdqwv1eyGWKL0tPF6LkZXrFDF8iQBZe9bewAaVsenr5Zlp9+2YEZp62DhYH
Ph81/sIIG19oyTBgepLV67mBKmPOUaxDVthEnxmu51YO7P9u9v1+TCPQt5p2ZmLQInPVc0hy
t3+cGrlc+EOX5MJn52s9yG5TrnI7XVkfjb7dH/zK6vD3hV8ygbnBuU7E1KOKmiLIxEouZoZd
EyifOeqwOTmO0thrzJLdIwb+ZqRnxJ1+BiS3JPIUeJv83nldvZc9eXTCPjrdr5tEnHgtBeDi
7JwDn50we2gifmf6pHI2UU+HxDuloFwy362rMzsxjhY3u9dHy2dikAyMuiCVkzZ/mMly7b6x
6cypwFc0U+FPNnmceGlQDSx3IDTQ516RkVRMG2P6+3NpybQC1N3KidXwJ2WG0Zp1GVsnLBs+
dl/PyMvTK2YasLTWoWtxhqZ6t6TstvRgF6cLhu6Uk523pwnnbtehb1UzvKxc3z1/e3k6Kt6f
vm7f+hx9XEtFodJNWNXF0p+fOljSa7H+5o0YVsBpDLf6CcPtHYjwgF/SppEYeFPr05KvbZIz
g6Nb/9h9fbsDXf7t5f2we2YkdZYG7IpBeCfm+lgxf05GGhanGXP4nKtCk/CoQSWZL8HUXHx0
NNG3XvSCKoaP5ZzMkcxVb4jwqd4ZegxHNCFakzUjCtB3Dk5567Tgw3ENsv6tkoKTqEigzngf
YLMqSpwg5KzaPhI2kZzRO0Y6xcz4iE2ZvXzEciqxVfLi+FRM9PiSzf9vEeCTPHbWEQOd5stG
hhtXffAJO79IIf11gejunWoOpUQsr0M7R7uBDkPYJOfrpqAzJf3VSqOUZ+UyDTfL6+xneM+d
wGzkgjl4IaaPbihDRXsubC4Tc8FQon483zfuI07RdmmTsP2FZgAViXDiogW3Kwp1k+cSLWJk
RcNAIuMmeERWbZB1NKoNOrLxcngkbKrcpOI8gs+O/9iEEhgmTkP0NdSOhmO11SpUF+jIc4VY
LIyj+NQ/Fz+BxbMtfmx5faZLtKtVUns9odMStcFxbNLbDeam/JMOi/ujP1/ejva7h2ed7+X+
cXv/fff8YDi3YqZ0DAQlY+TnD/fw8f7f+AWQbeDw/PF1+/RhMDTSxbxp5KwtNyUfrz5/MK7V
Ory2Khgjyds0yyIS9Q1Tm1sebHzhCv1zehrWlPYr49LXHqQFVk0+WXG/j2eTG3iWFpiKnrwU
TN8PQc5pIyBIQbOGyTOjHfrob1C6ixDtqzXFA5p8YZJksnCwYVlHpkYAjc7lpmjzACoawdrC
bOZvGOLOw9T1i+1RDhgTlHSvt5gLPQRhCCqRBTo5tyn8wxiU3rQb+yv3lAgA9s1ZmwAWuAxu
LphPNYbPxt2RiHrtcKBDAZPGV31+arXd/vXJMFWngX8uDo07QH0MNpsPnBSV+XznQTUffDPG
shCKAQsuHD0zUCvNLCedW62XOVA4CDAlI5QrGRR/lvrUpB5rhHPAZgLM0V/fItj9vbm+ODfH
q4NSxFzFH7k7klScc9tJh9Xv07nfALRJYD1Nf6dAlPuNDMIvTGkT0zl2vj8rOWuRubqp9ROp
WZnbeTBGKBZrLsUgTKwfFMvU0Hs0psOVUPgEIUiMK3z6uRbGKScR5EVvxv8hCJ+qGgDwAyvO
RI3BUgmdlYzCa6gXv1E3RUi0cVmPYmUYL8QIzBsw6TCCFBg7GsgiBHWh5i6l1DLTQ2eMaFYG
9i/m1nEY9qbMU3utZ7ebRlgRrJiaB04WnJ9+XqWWUxT8iCOjnjKNKF4IhLsxygpD47K0sSBV
WRrim66fIlmVjQPTJ1DYFfDxreMBBXLMEuYV5iwwrp/L4ItYmpt5g1vpODJWhk1nJ7Tv1Hod
g6Cvb7vnw3edmu9pu3/wr2hpl11tXDexDhziQ0nsAUtH4W1ATc5gU82GO5pPkxSXbSqbz6fD
1HR6mFfCQBHdFALfSHUUcAu86Zw7B50kD0pUOWVdA5X1Iu3kWAw2m92P7W+H3VOnkuyJ9F7D
3/yRi2HVSvIW/3xyvDg1Zw6OPApjcnMnKENE+j13xZmWE0Dj820pyARh3t3ojiodIICOmrlo
TEniYqhNm7LIrMtkXQosdgx/bAv9ichSTCDM2nhJUqxF0XQ9rUoKcTIDJ0z4VF1rKVb0JF1Y
tbxq+KsjT/PUv3Pf8Xu0/fr+8ICXr+nz/vD2jsngbedpgec40FVrLsNQ11DFNF6R4FrjvzMf
0q0e0eUY4DVTDl5Vcy7jgRLG9hHSsVpDNwE+c266AM5AcbonUCpJY6tlGhylcECXNRf2owna
Ajg2TJBl/a8DEIfstqDRsmCvT+h4pbtsSLRfmlN75NHRWnprBJ2Y+wNDd3k/FGYyBTl1wUEI
H/5hY2l0cUjW717OtA4o6Cmt6U568f4sWF255k1VhIQ1pEo76mSsBwRH7MJ1XATDtx2C1V0n
SGPelmITUTSimmjGZl3Wq+m2YOoelG6/0BYQFCAn+mjJn7bKHvzReqmyNvBDUzpBStt0i5sP
7wYdJqjCEZUsopkQOl3eFcfoHT/S86Tkc2IqbFfSbApG4cTWI/GzyE5CrAQuM98iq7E4H6g/
FCVQpU16i4+iRZ1y7/q3jEvEaUCi8xbqO0ckOipfXvf/OsLHd95ftZRO7p4fTHVCYPJGdFYv
K+swboAxXrQ1TM0aiQxWto3pcK/KuEEH6rYankZkhxpRmwQzyTRCrcxx1O49A2qo5GRhVAOi
rCEd3CCkNnFOZ1O0XaeMYteXsHvCdhyVnJM6SULdOVMUzg+zdreDPfLbO26MrGzT7DvlG6+x
3QWJCRsXS++7xFRj8wcO5krKSostbaVBJ4JRfv9j/7p7RscC6M3T+2H73y38Z3u4//jx4z8N
Aw4GGlKRS9J52wpDEA3mqWEV9MGGLrgWa11AAQNq4QmK3XIXVt1s8raR19ITZwr60nns2+uY
J1+vNQbETbmuRJN4Na2VFUqjodQw51SEMDhOcKQa7AgdfTCCiiUbDD5+jSOK57h+P7AEIrUE
VhVGhXtH45GRh25O20NUGFsFWQeW/4MphuWB+TnwZBdnYumNoA8nYamTehj9I0UYRhpUGQXn
cuB8bduZkeYrvbVMjmmHhz05k0JJWzx+1wrMt7vD3RFqLvdo4LRefKdp0cGMrkaB4JmGqYlT
OCEpzjWFDZoTWbhfgronGoGnJXydIu18Ii2hM9F4t6qwhoEsmlRkftQobPSWULJXath6ixcU
Azu00+Kh0agCdPTcZc9bBtzhOgMDapP5lVWaxyoIlJdzATLUCPIC3iyJO0FXSUs+gZM9EO4Q
ws6gz0a1dyqy6HQINuipaJ+xWAZNhkV405RsaiJ6EgRaaBir9G98KWPourXSQlvskfHBfTKd
Hv4mekvOwp8G26jWKR4+3ZqNorqTkFpblhDQPnNgyfpSf0rHSWW3z6qvtw1xXWT3j9ibbNzF
cffqv2HnG3NFl3Hc1TO5lw7NGN2215lopj/rpkIVolKJaT9yEP2h2RkvPV8BCDLMNF2XMabK
sS5mLJz0Dp6GjUcTiALEh8BbHv0le3k9EIM07cmYSid7HWQrfXdcugzY23OIvazY2aJJRuhQ
kx4AzYw6bwLbu5GZZi2UJnsOdFx1IiNrJw4CW98yLK+GUdIsx9JpFG5YILeq6V3XbNgUMUM6
5GIh/o5kBiqqbdgblhsgxc1Umcbo44rrReioZgrMND0RSKqlJEw3HIC8TeLldfv8ttvfWzuF
acNstvsDKgqo94Yvf23f7h6MV5goeYp5PauzqZDEZENIx2wr/lfymroxNQiaCFneSdbS77do
ZyzrMX2HOUJlDDvQHD1ToZMNxJBhIs1UZtu9EaYNBKRM8txmFzgEh7B1p8jiK9lH6Ni108rt
jk82Ikbl0ITZVRo2NqumPOQqsr8d1TpceFb+pO6kC+dbXHiaprIsNXVbaCGvTwbksMYOEnCp
vwztIA+WJx1FM0+VwnqiMmxzlFq8Nk06aZBqVlBzlfbG/P8BtVLNFzgPAgA=

--Q68bSM7Ycu6FN28Q--
