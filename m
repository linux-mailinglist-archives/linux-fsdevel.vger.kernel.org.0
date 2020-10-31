Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0852A125E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 02:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgJaBXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 21:23:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:24106 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJaBXt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 21:23:49 -0400
IronPort-SDR: gHmWQ0XAI77YacP3EXz1xM9nmHmLWqTUFl09SkHJFz9Ns7L3pahIP+QHii/2+WbqFrK2GJPmMX
 hmhRsmIV1Eag==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="166101736"
X-IronPort-AV: E=Sophos;i="5.77,435,1596524400"; 
   d="gz'50?scan'50,208,50";a="166101736"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 18:23:46 -0700
IronPort-SDR: iiLNx0H+6vpqHbr2u4kPVin/1JsssubbUFAwtltP+ryEQ5593Deuf+dPSo9dP7SfpbCMvHl+Az
 H4OpXaOpy5WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,435,1596524400"; 
   d="gz'50?scan'50,208,50";a="425495715"
Received: from lkp-server02.sh.intel.com (HELO fcc9f8859912) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2020 18:23:43 -0700
Received: from kbuild by fcc9f8859912 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYfcM-0000Mj-PB; Sat, 31 Oct 2020 01:23:42 +0000
Date:   Sat, 31 Oct 2020 09:23:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com
Subject: Re: [PATCH v11 09/10] fs/ntfs3: Add NTFS3 in fs/Kconfig and
 fs/Makefile
Message-ID: <202010310907.5Rxaxtib-lkp@intel.com>
References: <20201030150239.3957156-10-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20201030150239.3957156-10-almaz.alexandrovich@paragon-software.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Konstantin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.10-rc1 next-20201030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Konstantin-Komarov/NTFS-read-write-driver-GPL-implementation-by-Paragon-Software/20201030-230756
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 07e0887302450a62f51dba72df6afb5fabb23d1c
config: h8300-randconfig-s031-20201030 (attached as .config)
compiler: h8300-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-68-g49c98aa3-dirty
        # https://github.com/0day-ci/linux/commit/7c34316b6c7f9af2046f8343d3b010c37340ef1d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Konstantin-Komarov/NTFS-read-write-driver-GPL-implementation-by-Paragon-Software/20201030-230756
        git checkout 7c34316b6c7f9af2046f8343d3b010c37340ef1d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast to restricted __le32
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast from restricted __le64
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast to restricted __le32
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast from restricted __le64
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast to restricted __le32
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast from restricted __le64
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast to restricted __le32
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast from restricted __le64
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast to restricted __le32
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast from restricted __le64
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast to restricted __le32
>> fs/ntfs3/frecord.c:569:33: sparse: sparse: cast from restricted __le64

vim +569 fs/ntfs3/frecord.c

cbd4257e6d85149 Konstantin Komarov 2020-10-30  532  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  533  /*
cbd4257e6d85149 Konstantin Komarov 2020-10-30  534   * random write access to sparsed or compressed file may result to
cbd4257e6d85149 Konstantin Komarov 2020-10-30  535   * not optimized packed runs.
cbd4257e6d85149 Konstantin Komarov 2020-10-30  536   * Here it is the place to optimize it
cbd4257e6d85149 Konstantin Komarov 2020-10-30  537   */
cbd4257e6d85149 Konstantin Komarov 2020-10-30  538  static int ni_repack(struct ntfs_inode *ni)
cbd4257e6d85149 Konstantin Komarov 2020-10-30  539  {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  540  	int err = 0;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  541  	struct ntfs_sb_info *sbi = ni->mi.sbi;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  542  	struct mft_inode *mi, *mi_p = NULL;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  543  	struct ATTRIB *attr = NULL, *attr_p;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  544  	struct ATTR_LIST_ENTRY *le = NULL, *le_p;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  545  	CLST alloc = 0;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  546  	u8 cluster_bits = sbi->cluster_bits;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  547  	CLST svcn, evcn = 0, svcn_p, evcn_p, next_svcn;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  548  	u32 roff, rs = sbi->record_size;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  549  	struct runs_tree run;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  550  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  551  	run_init(&run);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  552  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  553  	while ((attr = ni_enum_attr_ex(ni, attr, &le))) {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  554  		if (!attr->non_res)
cbd4257e6d85149 Konstantin Komarov 2020-10-30  555  			continue;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  556  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  557  		if (ni_load_mi(ni, le, &mi)) {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  558  			err = -EINVAL;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  559  			break;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  560  		}
cbd4257e6d85149 Konstantin Komarov 2020-10-30  561  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  562  		svcn = le64_to_cpu(attr->nres.svcn);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  563  		if (svcn != le64_to_cpu(le->vcn)) {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  564  			err = -EINVAL;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  565  			break;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  566  		}
cbd4257e6d85149 Konstantin Komarov 2020-10-30  567  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  568  		if (!svcn) {
cbd4257e6d85149 Konstantin Komarov 2020-10-30 @569  			alloc = le32_to_cpu(attr->nres.alloc_size) >>
cbd4257e6d85149 Konstantin Komarov 2020-10-30  570  				cluster_bits;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  571  			mi_p = NULL;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  572  		} else if (svcn != evcn + 1) {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  573  			err = -EINVAL;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  574  			break;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  575  		}
cbd4257e6d85149 Konstantin Komarov 2020-10-30  576  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  577  		evcn = le64_to_cpu(attr->nres.evcn);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  578  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  579  		if (svcn > evcn + 1) {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  580  			err = -EINVAL;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  581  			break;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  582  		}
cbd4257e6d85149 Konstantin Komarov 2020-10-30  583  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  584  		if (!mi_p) {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  585  			/* do not try if too little free space */
cbd4257e6d85149 Konstantin Komarov 2020-10-30  586  			if (le32_to_cpu(mi->mrec->used) + 8 >= rs)
cbd4257e6d85149 Konstantin Komarov 2020-10-30  587  				continue;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  588  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  589  			/* do not try if last attribute segment */
cbd4257e6d85149 Konstantin Komarov 2020-10-30  590  			if (evcn + 1 == alloc)
cbd4257e6d85149 Konstantin Komarov 2020-10-30  591  				continue;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  592  			run_close(&run);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  593  		}
cbd4257e6d85149 Konstantin Komarov 2020-10-30  594  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  595  		roff = le16_to_cpu(attr->nres.run_off);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  596  		err = run_unpack(&run, sbi, ni->mi.rno, svcn, evcn, svcn,
cbd4257e6d85149 Konstantin Komarov 2020-10-30  597  				 Add2Ptr(attr, roff),
cbd4257e6d85149 Konstantin Komarov 2020-10-30  598  				 le32_to_cpu(attr->size) - roff);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  599  		if (err < 0)
cbd4257e6d85149 Konstantin Komarov 2020-10-30  600  			break;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  601  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  602  		if (!mi_p) {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  603  			mi_p = mi;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  604  			attr_p = attr;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  605  			svcn_p = svcn;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  606  			evcn_p = evcn;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  607  			le_p = le;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  608  			continue;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  609  		}
cbd4257e6d85149 Konstantin Komarov 2020-10-30  610  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  611  		/*
cbd4257e6d85149 Konstantin Komarov 2020-10-30  612  		 * run contains data from two records: mi_p and mi
cbd4257e6d85149 Konstantin Komarov 2020-10-30  613  		 * try to pack in one
cbd4257e6d85149 Konstantin Komarov 2020-10-30  614  		 */
cbd4257e6d85149 Konstantin Komarov 2020-10-30  615  		err = mi_pack_runs(mi_p, attr_p, &run, evcn + 1 - svcn_p);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  616  		if (err)
cbd4257e6d85149 Konstantin Komarov 2020-10-30  617  			break;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  618  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  619  		next_svcn = le64_to_cpu(attr_p->nres.evcn) + 1;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  620  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  621  		if (next_svcn >= evcn + 1) {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  622  			/* we can remove this attribute segment */
cbd4257e6d85149 Konstantin Komarov 2020-10-30  623  			al_remove_le(ni, le);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  624  			mi_remove_attr(mi, attr);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  625  			le = le_p;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  626  			continue;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  627  		}
cbd4257e6d85149 Konstantin Komarov 2020-10-30  628  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  629  		attr->nres.svcn = le->vcn = cpu_to_le64(next_svcn);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  630  		mi->dirty = true;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  631  		ni->attr_list.dirty = true;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  632  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  633  		if (evcn + 1 == alloc) {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  634  			err = mi_pack_runs(mi, attr, &run,
cbd4257e6d85149 Konstantin Komarov 2020-10-30  635  					   evcn + 1 - next_svcn);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  636  			if (err)
cbd4257e6d85149 Konstantin Komarov 2020-10-30  637  				break;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  638  			mi_p = NULL;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  639  		} else {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  640  			mi_p = mi;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  641  			attr_p = attr;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  642  			svcn_p = next_svcn;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  643  			evcn_p = evcn;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  644  			le_p = le;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  645  			run_truncate_head(&run, next_svcn);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  646  		}
cbd4257e6d85149 Konstantin Komarov 2020-10-30  647  	}
cbd4257e6d85149 Konstantin Komarov 2020-10-30  648  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  649  	if (err) {
cbd4257e6d85149 Konstantin Komarov 2020-10-30  650  		ntfs_inode_warn(&ni->vfs_inode, "there is a problem");
cbd4257e6d85149 Konstantin Komarov 2020-10-30  651  		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  652  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  653  		/* Pack loaded but not packed runs */
cbd4257e6d85149 Konstantin Komarov 2020-10-30  654  		if (mi_p)
cbd4257e6d85149 Konstantin Komarov 2020-10-30  655  			mi_pack_runs(mi_p, attr_p, &run, evcn_p + 1 - svcn_p);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  656  	}
cbd4257e6d85149 Konstantin Komarov 2020-10-30  657  
cbd4257e6d85149 Konstantin Komarov 2020-10-30  658  	run_close(&run);
cbd4257e6d85149 Konstantin Komarov 2020-10-30  659  	return err;
cbd4257e6d85149 Konstantin Komarov 2020-10-30  660  }
cbd4257e6d85149 Konstantin Komarov 2020-10-30  661  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--fUYQa+Pmc3FrFX/N
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--fUYQa+Pmc3FrFX/N--
