Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17F163EFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 09:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgBSI0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 03:26:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:52524 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgBSI0x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:26:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 00:26:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,459,1574150400"; 
   d="gz'50?scan'50,208,50";a="228540574"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Feb 2020 00:26:51 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j4Kh0-0009cR-Dc; Wed, 19 Feb 2020 16:26:50 +0800
Date:   Wed, 19 Feb 2020 16:26:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: [vfs:untested.uaccess 40/51]
 arch/sparc/include/asm/checksum_32.h:73:5: error: 'err_ptr' undeclared; did
 you mean 'si_ptr'?
Message-ID: <202002191629.CZ0Ta5ZZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git untested.uaccess
head:   5cc28922fce057003f404a956c978adbfb9fba93
commit: 2ddca056919eada9622f445a8d1da635d9118639 [40/51] sparc: switch to providing csum_and_copy_from_user()
config: sparc-defconfig (attached as .config)
compiler: sparc-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2ddca056919eada9622f445a8d1da635d9118639
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=sparc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/checksum.h:8:0,
                    from include/net/checksum.h:22,
                    from include/linux/skbuff.h:28,
                    from include/linux/if_ether.h:19,
                    from include/uapi/linux/ethtool.h:19,
                    from include/linux/ethtool.h:18,
                    from include/linux/netdevice.h:37,
                    from net/socket.c:62:
   arch/sparc/include/asm/checksum_32.h: In function 'csum_and_copy_from_user':
>> arch/sparc/include/asm/checksum_32.h:73:5: error: 'err_ptr' undeclared (first use in this function); did you mean 'si_ptr'?
       *err_ptr = -EFAULT;
        ^~~~~~~
        si_ptr
   arch/sparc/include/asm/checksum_32.h:73:5: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from arch/sparc/include/asm/checksum.h:8:0,
                    from include/net/checksum.h:22,
                    from include/linux/skbuff.h:28,
                    from include/linux/if_ether.h:19,
                    from include/uapi/linux/ethtool.h:19,
                    from include/linux/ethtool.h:18,
                    from include/linux/netdevice.h:37,
                    from include/linux/rtnetlink.h:7,
                    from net/core/flow_offload.c:5:
   arch/sparc/include/asm/checksum_32.h: In function 'csum_and_copy_from_user':
>> arch/sparc/include/asm/checksum_32.h:73:5: error: 'err_ptr' undeclared (first use in this function); did you mean 'rht_ptr'?
       *err_ptr = -EFAULT;
        ^~~~~~~
        rht_ptr
   arch/sparc/include/asm/checksum_32.h:73:5: note: each undeclared identifier is reported only once for each function it appears in

vim +73 arch/sparc/include/asm/checksum_32.h

    61	
    62	static inline __wsum
    63	csum_and_copy_from_user(const void __user *src, void *dst, int len,
    64				    __wsum sum, int *err)
    65	  {
    66		register unsigned long ret asm("o0") = (unsigned long)src;
    67		register char *d asm("o1") = dst;
    68		register int l asm("g1") = len;
    69		register __wsum s asm("g7") = sum;
    70	
    71		if (unlikely(!access_ok(src, len))) {
    72			if (len)
  > 73				*err_ptr = -EFAULT;
    74			return sum;
    75		}
    76	
    77		__asm__ __volatile__ (
    78		".section __ex_table,#alloc\n\t"
    79		".align 4\n\t"
    80		".word 1f,2\n\t"
    81		".previous\n"
    82		"1:\n\t"
    83		"call __csum_partial_copy_sparc_generic\n\t"
    84		" st %8, [%%sp + 64]\n"
    85		: "=&r" (ret), "=&r" (d), "=&r" (l), "=&r" (s)
    86		: "0" (ret), "1" (d), "2" (l), "3" (s), "r" (err)
    87		: "o2", "o3", "o4", "o5", "o7", "g2", "g3", "g4", "g5",
    88		  "cc", "memory");
    89		return (__force __wsum)ret;
    90	}
    91	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--a8Wt8u1KmwUX3Y2C
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--a8Wt8u1KmwUX3Y2C--
