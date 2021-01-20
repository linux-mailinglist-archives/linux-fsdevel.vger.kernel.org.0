Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1A42FD9E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 20:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392621AbhATTkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 14:40:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:28745 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392702AbhATTjc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:39:32 -0500
IronPort-SDR: ikiurRhDktEYYdJwJQldc1a9sE1Esxyc/swh5vfZsRoeTrCYu7Q1SYgo7UCP1Ifi5h5svb6ppo
 CyQJN6fiTB4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="179250165"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="gz'50?scan'50,208,50";a="179250165"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:38:43 -0800
IronPort-SDR: ZA/pNRFncNYHKV1pwuEwxVi5PWGttBmhRLZC+cKfkan62WwqyG/DgS/I7HcRz4LRu8+FJM8Yl3
 jqkXnQW7n8Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="gz'50?scan'50,208,50";a="467177587"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2021 11:38:40 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2JJP-0005xr-VJ; Wed, 20 Jan 2021 19:38:39 +0000
Date:   Thu, 21 Jan 2021 03:37:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 2/2] security.capability: fix conversions on getxattr
Message-ID: <202101210338.CfDbwXUh-lkp@intel.com>
References: <20210119162204.2081137-3-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20210119162204.2081137-3-mszeredi@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Miklos,

I love your patch! Perhaps something to improve:

[auto build test WARNING on security/next-testing]
[also build test WARNING on linux/master linus/master v5.11-rc4 next-20210120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Miklos-Szeredi/capability-conversion-fixes/20210120-152933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-testing
config: xtensa-randconfig-s032-20210120 (attached as .config)
compiler: xtensa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-208-g46a52ca4-dirty
        # https://github.com/0day-ci/linux/commit/bcf70adf8bcc3e52cb1b262ae2e1d9154da75097
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miklos-Szeredi/capability-conversion-fixes/20210120-152933
        git checkout bcf70adf8bcc3e52cb1b262ae2e1d9154da75097
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=xtensa 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   security/commoncap.c:424:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] nsmagic @@     got int @@
   security/commoncap.c:424:41: sparse:     expected restricted __le32 [usertype] nsmagic
   security/commoncap.c:424:41: sparse:     got int
>> security/commoncap.c:425:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] magic @@     got unsigned int @@
   security/commoncap.c:425:39: sparse:     expected restricted __le32 [usertype] magic
   security/commoncap.c:425:39: sparse:     got unsigned int
   security/commoncap.c:426:37: sparse: sparse: restricted __le32 degrades to integer
   security/commoncap.c:427:49: sparse: sparse: invalid assignment: |=
   security/commoncap.c:427:49: sparse:    left side has type restricted __le32
   security/commoncap.c:427:49: sparse:    right side has type int
   security/commoncap.c:429:52: sparse: sparse: cast from restricted __le32
>> security/commoncap.c:429:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] nsmagic @@
   security/commoncap.c:429:52: sparse:     expected unsigned int [usertype] val
   security/commoncap.c:429:52: sparse:     got restricted __le32 [usertype] nsmagic
   security/commoncap.c:429:52: sparse: sparse: cast from restricted __le32
   security/commoncap.c:429:52: sparse: sparse: cast from restricted __le32
   security/commoncap.c:429:52: sparse: sparse: cast from restricted __le32
   security/commoncap.c:429:52: sparse: sparse: cast from restricted __le32
   security/commoncap.c:455:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] magic @@     got int @@
   security/commoncap.c:455:31: sparse:     expected restricted __le32 [usertype] magic
   security/commoncap.c:455:31: sparse:     got int
   security/commoncap.c:456:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] nsmagic @@     got unsigned int @@
   security/commoncap.c:456:33: sparse:     expected restricted __le32 [usertype] nsmagic
   security/commoncap.c:456:33: sparse:     got unsigned int
   security/commoncap.c:457:29: sparse: sparse: restricted __le32 degrades to integer
   security/commoncap.c:458:39: sparse: sparse: invalid assignment: |=
   security/commoncap.c:458:39: sparse:    left side has type restricted __le32
   security/commoncap.c:458:39: sparse:    right side has type int
   security/commoncap.c:460:42: sparse: sparse: cast from restricted __le32
   security/commoncap.c:460:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] magic @@
   security/commoncap.c:460:42: sparse:     expected unsigned int [usertype] val
   security/commoncap.c:460:42: sparse:     got restricted __le32 [usertype] magic
   security/commoncap.c:460:42: sparse: sparse: cast from restricted __le32
   security/commoncap.c:460:42: sparse: sparse: cast from restricted __le32
   security/commoncap.c:460:42: sparse: sparse: cast from restricted __le32
   security/commoncap.c:460:42: sparse: sparse: cast from restricted __le32
   security/commoncap.c:1281:41: sparse: sparse: dubious: !x | y

vim +425 security/commoncap.c

   357	
   358	/*
   359	 * getsecurity: We are called for security.* before any attempt to read the
   360	 * xattr from the inode itself.
   361	 *
   362	 * This gives us a chance to read the on-disk value and convert it.  If we
   363	 * return -EOPNOTSUPP, then vfs_getxattr() will call the i_op handler.
   364	 *
   365	 * Note we are not called by vfs_getxattr_alloc(), but that is only called
   366	 * by the integrity subsystem, which really wants the unconverted values -
   367	 * so that's good.
   368	 */
   369	int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
   370				  bool alloc)
   371	{
   372		int size, ret;
   373		kuid_t kroot;
   374		__le32 nsmagic, magic;
   375		uid_t root, mappedroot;
   376		char *tmpbuf = NULL;
   377		struct vfs_cap_data *cap;
   378		struct vfs_ns_cap_data *nscap = NULL;
   379		struct dentry *dentry;
   380		struct user_namespace *fs_ns;
   381	
   382		if (strcmp(name, "capability") != 0)
   383			return -EOPNOTSUPP;
   384	
   385		dentry = d_find_any_alias(inode);
   386		if (!dentry)
   387			return -EINVAL;
   388	
   389		size = sizeof(struct vfs_ns_cap_data);
   390		ret = (int) vfs_getxattr_alloc(dentry, XATTR_NAME_CAPS,
   391					 &tmpbuf, size, GFP_NOFS);
   392		dput(dentry);
   393	
   394		if (ret < 0)
   395			return ret;
   396	
   397		fs_ns = inode->i_sb->s_user_ns;
   398		cap = (struct vfs_cap_data *) tmpbuf;
   399		if (is_v2header((size_t) ret, cap)) {
   400			root = 0;
   401		} else if (is_v3header((size_t) ret, cap)) {
   402			nscap = (struct vfs_ns_cap_data *) tmpbuf;
   403			root = le32_to_cpu(nscap->rootid);
   404		} else {
   405			size = -EINVAL;
   406			goto out_free;
   407		}
   408	
   409		kroot = make_kuid(fs_ns, root);
   410	
   411		/* If the root kuid maps to a valid uid in current ns, then return
   412		 * this as a nscap. */
   413		mappedroot = from_kuid(current_user_ns(), kroot);
   414		if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {
   415			size = sizeof(struct vfs_ns_cap_data);
   416			if (alloc) {
   417				if (!nscap) {
   418					/* v2 -> v3 conversion */
   419					nscap = kzalloc(size, GFP_ATOMIC);
   420					if (!nscap) {
   421						size = -ENOMEM;
   422						goto out_free;
   423					}
   424					nsmagic = VFS_CAP_REVISION_3;
 > 425					magic = le32_to_cpu(cap->magic_etc);
   426					if (magic & VFS_CAP_FLAGS_EFFECTIVE)
   427						nsmagic |= VFS_CAP_FLAGS_EFFECTIVE;
   428					memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
 > 429					nscap->magic_etc = cpu_to_le32(nsmagic);
   430				} else {
   431					/* use allocated v3 buffer */
   432					tmpbuf = NULL;
   433				}
   434				nscap->rootid = cpu_to_le32(mappedroot);
   435				*buffer = nscap;
   436			}
   437			goto out_free;
   438		}
   439	
   440		if (!rootid_owns_currentns(kroot)) {
   441			size = -EOVERFLOW;
   442			goto out_free;
   443		}
   444	
   445		/* This comes from a parent namespace.  Return as a v2 capability */
   446		size = sizeof(struct vfs_cap_data);
   447		if (alloc) {
   448			if (nscap) {
   449				/* v3 -> v2 conversion */
   450				cap = kzalloc(size, GFP_ATOMIC);
   451				if (!cap) {
   452					size = -ENOMEM;
   453					goto out_free;
   454				}
   455				magic = VFS_CAP_REVISION_2;
   456				nsmagic = le32_to_cpu(nscap->magic_etc);
   457				if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
   458					magic |= VFS_CAP_FLAGS_EFFECTIVE;
   459				memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
   460				cap->magic_etc = cpu_to_le32(magic);
   461			} else {
   462				/* use unconverted v2 */
   463				tmpbuf = NULL;
   464			}
   465			*buffer = cap;
   466		}
   467	out_free:
   468		kfree(tmpbuf);
   469		return size;
   470	}
   471	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--IS0zKkzwUGydFO0o--
