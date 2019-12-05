Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0AF113934
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 02:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfLEBSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 20:18:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:2377 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbfLEBSI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 20:18:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 17:18:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="208989540"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2019 17:18:03 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1icfmJ-0009QL-P1; Thu, 05 Dec 2019 09:17:59 +0800
Date:   Thu, 5 Dec 2019 09:17:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     kbuild-all@lists.01.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Subject: Re: [PATCH 5/8] f2fs: Handle casefolding with Encryption
Message-ID: <201912050955.3f2DMo5g%lkp@intel.com>
References: <20191203051049.44573-6-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203051049.44573-6-drosen@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20191202 next-20191204]
[cannot apply to ext4/dev f2fs/dev-test v5.4 v5.4-rc8 v5.4-rc7 v5.4]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Daniel-Rosenberg/Support-for-Casefolding-and-Encryption/20191203-131410
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 76bb8b05960c3d1668e6bee7624ed886cbd135ba
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-91-g817270f-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/f2fs/dir.c:205:13: sparse: sparse: incorrect type in assignment (different base types) @@    expected int len @@    got restricted __le16 [usertyint len @@
>> fs/f2fs/dir.c:205:13: sparse:    expected int len
   fs/f2fs/dir.c:205:13: sparse:    got restricted __le16 [usertype] name_len
--
>> fs/f2fs/hash.c:90:27: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le32 [usertype] f2fs_hash @@    got __le32 [usertype] f2fs_hash @@
>> fs/f2fs/hash.c:90:27: sparse:    expected restricted __le32 [usertype] f2fs_hash
>> fs/f2fs/hash.c:90:27: sparse:    got unsigned long long
   fs/f2fs/hash.c:133:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __le32 @@    got e32 @@
   fs/f2fs/hash.c:133:24: sparse:    expected restricted __le32
   fs/f2fs/hash.c:133:24: sparse:    got int
   fs/f2fs/hash.c:141:11: sparse: sparse: incorrect type in assignment (different base types) @@    expected int r @@    got restricted __int r @@
   fs/f2fs/hash.c:141:11: sparse:    expected int r
   fs/f2fs/hash.c:141:11: sparse:    got restricted __le32
   fs/f2fs/hash.c:144:16: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __le32 @@    got le32 @@
   fs/f2fs/hash.c:144:16: sparse:    expected restricted __le32
   fs/f2fs/hash.c:144:16: sparse:    got int r

vim +205 fs/f2fs/dir.c

   199	
   200		if (de->hash_code != namehash)
   201			return false;
   202	
   203	#ifdef CONFIG_UNICODE
   204		name = d->filename[bit_pos];
 > 205		len = de->name_len;
   206	
   207		if (sb->s_encoding && needs_casefold(parent)) {
   208			if (cf_str->name) {
   209				struct qstr cf = {.name = cf_str->name,
   210						  .len = cf_str->len};
   211				return !f2fs_ci_compare(parent, &cf, name, len, true);
   212			}
   213			return !f2fs_ci_compare(parent, fname->usr_fname, name, len,
   214						false);
   215		}
   216	#endif
   217		if (fscrypt_match_name(fname, d->filename[bit_pos],
   218					le16_to_cpu(de->name_len)))
   219			return true;
   220		return false;
   221	}
   222	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
