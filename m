Return-Path: <linux-fsdevel+bounces-2954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F22B37EDFA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 12:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDC71F243C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C102E410;
	Thu, 16 Nov 2023 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HffKf7+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CD985;
	Thu, 16 Nov 2023 03:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700133896; x=1731669896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RcibIPyqvevz21yLUfyD0tCzd/eLvTgUwY03gPK7X50=;
  b=HffKf7+6Lp0sipoIzZuNH6u/L8UmZg8CLL1fvoNLCwqVgC0jdPWb/F51
   Dc4YtN59/ffh+7Cx1+ag/jkUPDQPmlmxdxO1L1XnO+oaH97DMtf3L8mJX
   NN3zDRizQiTHOy6/dv5MvfCSxOh2SGdzrB5ErMsVjAupc0nPK8lvTQXri
   ur+moWylt/TPGZjblud0/mxg1jYsbjvNLAVk4rD0CNOKjo8UsDPbIbflu
   PW6DtGyOiImeva8S06QSrvtcdQyL3jhbtLHa4+ZRGLSJHiC7ldHmwFhC/
   ga141vBLtSJ1WHErv0irKR3kQhaZXAUc/JlkTL3+Bm+6I2t7kall47bHZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="371251421"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="371251421"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 03:24:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1096760190"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="1096760190"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Nov 2023 03:24:52 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3aUM-0001bD-2V;
	Thu, 16 Nov 2023 11:24:50 +0000
Date: Thu, 16 Nov 2023 19:23:53 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bill O'Donnell <billodo@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Ian Kent <raven@themaw.net>,
	syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
Subject: Re: [PATCH] autofs: add: new_inode check in autofs_fill_super()
Message-ID: <202311161909.KHau6jEj-lkp@intel.com>
References: <20231116000746.7359-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116000746.7359-1-raven@themaw.net>

Hi Ian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.7-rc1 next-20231116]
[cannot apply to vfs-idmapping/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Kent/autofs-add-new_inode-check-in-autofs_fill_super/20231116-081017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20231116000746.7359-1-raven%40themaw.net
patch subject: [PATCH] autofs: add: new_inode check in autofs_fill_super()
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231116/202311161909.KHau6jEj-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311161909.KHau6jEj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311161909.KHau6jEj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/autofs/inode.c:330:8: error: expected identifier
                   goto -ENOMEM;
                        ^
>> fs/autofs/inode.c:330:8: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
   fs/autofs/inode.c:329:2: note: previous statement is here
           if (!ino)
           ^
   fs/autofs/inode.c:349:4: error: use of undeclared identifier 'ret'
                           ret = invalf(fc, "Could not find process group %d",
                           ^
   fs/autofs/inode.c:351:11: error: use of undeclared identifier 'ret'
                           return ret;
                                  ^
>> fs/autofs/inode.c:330:8: warning: expression result unused [-Wunused-value]
                   goto -ENOMEM;
                        ^~~~~~~
   2 warnings and 3 errors generated.


vim +/if +330 fs/autofs/inode.c

   306	
   307	static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
   308	{
   309		struct autofs_fs_context *ctx = fc->fs_private;
   310		struct autofs_sb_info *sbi = s->s_fs_info;
   311		struct inode *root_inode;
   312		struct dentry *root;
   313		struct autofs_info *ino;
   314	
   315		pr_debug("starting up, sbi = %p\n", sbi);
   316	
   317		sbi->sb = s;
   318		s->s_blocksize = 1024;
   319		s->s_blocksize_bits = 10;
   320		s->s_magic = AUTOFS_SUPER_MAGIC;
   321		s->s_op = &autofs_sops;
   322		s->s_d_op = &autofs_dentry_operations;
   323		s->s_time_gran = 1;
   324	
   325		/*
   326		 * Get the root inode and dentry, but defer checking for errors.
   327		 */
   328		ino = autofs_new_ino(sbi);
   329		if (!ino)
 > 330			goto -ENOMEM;
   331	
   332		root_inode = autofs_get_inode(s, S_IFDIR | 0755);
   333		if (root_inode) {
   334			root_inode->i_uid = ctx->uid;
   335			root_inode->i_gid = ctx->gid;
   336			root_inode->i_fop = &autofs_root_operations;
   337			root_inode->i_op = &autofs_dir_inode_operations;
   338		}
   339		s->s_root = d_make_root(root_inode);
   340		if (unlikely(!s->s_root)) {
   341			autofs_free_ino(ino);
   342			return -ENOMEM;
   343		}
   344		s->s_root->d_fsdata = ino;
   345	
   346		if (ctx->pgrp_set) {
   347			sbi->oz_pgrp = find_get_pid(ctx->pgrp);
   348			if (!sbi->oz_pgrp) {
   349				ret = invalf(fc, "Could not find process group %d",
   350					     ctx->pgrp);
   351				return ret;
   352			}
   353		} else {
   354			sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
   355		}
   356	
   357		if (autofs_type_trigger(sbi->type))
   358			/* s->s_root won't be contended so there's little to
   359			 * be gained by not taking the d_lock when setting
   360			 * d_flags, even when a lot mounts are being done.
   361			 */
   362			managed_dentry_set_managed(s->s_root);
   363	
   364		pr_debug("pipe fd = %d, pgrp = %u\n",
   365			 sbi->pipefd, pid_nr(sbi->oz_pgrp));
   366	
   367		sbi->flags &= ~AUTOFS_SBI_CATATONIC;
   368		return 0;
   369	}
   370	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

