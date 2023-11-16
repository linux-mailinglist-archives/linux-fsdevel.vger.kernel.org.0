Return-Path: <linux-fsdevel+bounces-2953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A547EDF52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 12:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE68280E47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 11:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5DF2DF96;
	Thu, 16 Nov 2023 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQSsv3Kv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBCDC1;
	Thu, 16 Nov 2023 03:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700133293; x=1731669293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7gt3FHKL7bzyekRJmKMiYCkahV29r6/XjmQm9S/idIg=;
  b=BQSsv3KvAP//B+TtIOmI+21hgv3yzzeogXON5bBa/Dx0tLzYq02KXpkN
   4VTaAGtuhRwbvlLjcBq0qBKbiHfn1B2p5Uad9BqMgmi1bmQ+dHrGWer6D
   sWSepQkC0yglBQ8SQtZ+25vMAkA2yC6f+oioYO+FTULXAScPwd+SFW4bd
   EyqY1g1SfKcLRLrDY7Jug5dTGlrde/WZ9XBIW234ULrkXqRwNmu1PshaN
   Ct5qeRi4QiuCGlo5jCAzx9bdEy/nFGmlv+r5qHiqVtM+u2X5+CUUbWvnE
   LyThhkd6sTeRv/7mTVhz09P0KDBDJwQwkbVlWvekBxqA2k+FYb0+LeH91
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381465325"
X-IronPort-AV: E=Sophos;i="6.03,308,1694761200"; 
   d="scan'208";a="381465325"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 03:14:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="909084429"
X-IronPort-AV: E=Sophos;i="6.03,308,1694761200"; 
   d="scan'208";a="909084429"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2023 03:14:49 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3aKY-0001an-32;
	Thu, 16 Nov 2023 11:14:44 +0000
Date: Thu, 16 Nov 2023 19:13:31 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Bill O'Donnell <billodo@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Ian Kent <raven@themaw.net>,
	syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
Subject: Re: [PATCH] autofs: add: new_inode check in autofs_fill_super()
Message-ID: <202311161857.bZMQmWsW-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.7-rc1 next-20231116]
[cannot apply to vfs-idmapping/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Kent/autofs-add-new_inode-check-in-autofs_fill_super/20231116-081017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20231116000746.7359-1-raven%40themaw.net
patch subject: [PATCH] autofs: add: new_inode check in autofs_fill_super()
config: i386-buildonly-randconfig-001-20231116 (https://download.01.org/0day-ci/archive/20231116/202311161857.bZMQmWsW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311161857.bZMQmWsW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311161857.bZMQmWsW-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/autofs/inode.c: In function 'autofs_fill_super':
>> fs/autofs/inode.c:330:22: error: expected identifier or '*' before '-' token
     330 |                 goto -ENOMEM;
         |                      ^
>> fs/autofs/inode.c:349:25: error: 'ret' undeclared (first use in this function); did you mean 'net'?
     349 |                         ret = invalf(fc, "Could not find process group %d",
         |                         ^~~
         |                         net
   fs/autofs/inode.c:349:25: note: each undeclared identifier is reported only once for each function it appears in
>> fs/autofs/inode.c:312:24: warning: unused variable 'root' [-Wunused-variable]
     312 |         struct dentry *root;
         |                        ^~~~


vim +330 fs/autofs/inode.c

   306	
   307	static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
   308	{
   309		struct autofs_fs_context *ctx = fc->fs_private;
   310		struct autofs_sb_info *sbi = s->s_fs_info;
   311		struct inode *root_inode;
 > 312		struct dentry *root;
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
 > 349				ret = invalf(fc, "Could not find process group %d",
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

