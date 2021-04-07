Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2357B35701B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbhDGPYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 11:24:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:43366 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353492AbhDGPYN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:24:13 -0400
IronPort-SDR: RYaxzH7jO3Swg1b3pF12Ve4tP/58xq8T9Vl9VI2/BKW5Rv7OSfozb+f1LrlOL/EEUmu5ojpmbr
 AkbroPfNMpdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="190127818"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="gz'50?scan'50,208,50";a="190127818"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 08:24:03 -0700
IronPort-SDR: leCoTbXIIu6s4GMCJlAgfBefrQOssQ0Wjt6K1lyRgxuNmcAbUhrCMjs4+I0FTzp0BQHkMm3Kee
 hTF+Se8UFCug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="gz'50?scan'50,208,50";a="530242882"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Apr 2021 08:23:57 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUA28-000DQz-DZ; Wed, 07 Apr 2021 15:23:56 +0000
Date:   Wed, 7 Apr 2021 23:23:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        mjg59@google.com
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v5 09/12] evm: Allow setxattr() and setattr() for
 unmodified metadata
Message-ID: <202104072340.Ux830CO0-lkp@intel.com>
References: <20210407105252.30721-10-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20210407105252.30721-10-roberto.sassu@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Roberto,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on security/next-testing]
[also build test ERROR on integrity/next-integrity linus/master v5.12-rc6 next-20210407]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Roberto-Sassu/evm-Improve-usability-of-portable-signatures/20210407-185747
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-testing
config: s390-randconfig-r034-20210407 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project c060945b23a1c54d4b2a053ff4b093a2277b303d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/1bdae98f0b81260a925cf7acf785dc10bb7787fe
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Roberto-Sassu/evm-Improve-usability-of-portable-signatures/20210407-185747
        git checkout 1bdae98f0b81260a925cf7acf785dc10bb7787fe
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> security/integrity/evm/evm_main.c:365:7: error: implicit declaration of function 'posix_acl_update_mode' [-Werror,-Wimplicit-function-declaration]
           rc = posix_acl_update_mode(mnt_userns, inode, &mode, &acl_res);
                ^
   1 error generated.


vim +/posix_acl_update_mode +365 security/integrity/evm/evm_main.c

   331	
   332	/*
   333	 * evm_xattr_acl_change - check if passed ACL changes the inode mode
   334	 * @mnt_userns: user namespace of the idmapped mount
   335	 * @dentry: pointer to the affected dentry
   336	 * @xattr_name: requested xattr
   337	 * @xattr_value: requested xattr value
   338	 * @xattr_value_len: requested xattr value length
   339	 *
   340	 * Check if passed ACL changes the inode mode, which is protected by EVM.
   341	 *
   342	 * Returns 1 if passed ACL causes inode mode change, 0 otherwise.
   343	 */
   344	static int evm_xattr_acl_change(struct user_namespace *mnt_userns,
   345					struct dentry *dentry, const char *xattr_name,
   346					const void *xattr_value, size_t xattr_value_len)
   347	{
   348		umode_t mode;
   349		struct posix_acl *acl = NULL, *acl_res;
   350		struct inode *inode = d_backing_inode(dentry);
   351		int rc;
   352	
   353		/* user_ns is not relevant here, ACL_USER/ACL_GROUP don't have impact
   354		 * on the inode mode (see posix_acl_equiv_mode()).
   355		 */
   356		acl = posix_acl_from_xattr(&init_user_ns, xattr_value, xattr_value_len);
   357		if (IS_ERR_OR_NULL(acl))
   358			return 1;
   359	
   360		acl_res = acl;
   361		/* Passing mnt_userns is necessary to correctly determine the GID in
   362		 * an idmapped mount, as the GID is used to clear the setgid bit in
   363		 * the inode mode.
   364		 */
 > 365		rc = posix_acl_update_mode(mnt_userns, inode, &mode, &acl_res);
   366	
   367		posix_acl_release(acl);
   368	
   369		if (rc)
   370			return 1;
   371	
   372		if (inode->i_mode != mode)
   373			return 1;
   374	
   375		return 0;
   376	}
   377	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--4Ckj6UjgE2iN1+kY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--4Ckj6UjgE2iN1+kY--
