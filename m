Return-Path: <linux-fsdevel+bounces-3137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972A27F0567
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90C11C20869
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B56D284;
	Sun, 19 Nov 2023 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="j4uQs60l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPX2aj4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFFCB6;
	Sun, 19 Nov 2023 02:23:56 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 99DCD320090B;
	Sun, 19 Nov 2023 05:23:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 19 Nov 2023 05:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1700389432; x=1700475832; bh=vLP7CS3hWF8TwbCJyhaj4FZ2G7iGG7Hui2j
	FMmmwK8g=; b=j4uQs60l0zMpMfS3qEPNTEQqwjJ7ZLq/IAyYtjCvka7C2g1EDq6
	FZfWAE/VqiZ5x69XI4WxlZNZextAPyYWgWr/XF81q1AQVyjstdcwO4irq67zRQV4
	/VfEJf6uvLMHUO33ehrYXLMj8sHnde/dELOzElaFLndzhx6++f2+jvuDJJBN4Vr4
	HcJJa+vPoMF0xtda7xkv1p926FjcVAKmVhtbL8aIYS4Y81ukZHDDIt/e5mYMpgWo
	g1ApCTnU4+5fl1w9zz0vNLhrOGeVe2vD4ktLkuGxdSLHXaHrb38GgyHOnTB+KobB
	B8kS3Gmtz+x+TgfH4WTVHqZQB6pvBqQDFoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1700389432; x=1700475832; bh=vLP7CS3hWF8TwbCJyhaj4FZ2G7iGG7Hui2j
	FMmmwK8g=; b=LPX2aj4cUM/qmhxv1OgVAJjEXlsnxJPYsDcd9bUo1aGdfcj/nvh
	1llILe/43VSF5U3UVyQ9lSQemSEWlgvRwzQ3WZdN+kIAwJoTbZnb5vYTTFLC2GwL
	GzVGCquxE7uPNHLaEMCQaHvQzRY5Ts1Pa3VGG6CwWn0wWp6YCf4ATA3POGiYaZ6K
	x0MzwDZdx0uMg9/cgUPe/2Y3ZcuLhqEmDLOahRW0tA4lr9LrQ2WldFJYlpW2eTGh
	MfLH1utxibCUS++vuGy5cSZMMkPt4OXSJbas3LO7D1ohePqCovu0ya6BGHi0bz2U
	VbceYRdAmLaeCKU8tYfgkMkyBofOY0Dt7UA==
X-ME-Sender: <xms:N-JZZWSGgrMGtku0KuMGrl9OpCO0kjEwOCeeOPz-zQ7UMogc2v9dzQ>
    <xme:N-JZZbwsd5eYaxRsnJ5x-_XjVoV5gWXnuYjpaR1OzZQhQbG95hGJDZwCsHgpIFSPR
    KEqZuuSCieR>
X-ME-Received: <xmr:N-JZZT1Mn8wej9ahcSUy6NeGk_WinxoWV3aRXYEVHKpAje-HjmmNtEvnuJ3snvr0mu6FEwEk5bbFdROMV7jB_mRtR484L3w9YdySNtnHytygLdiqw1eDlDWt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeggedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfhffuvfevfhgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epvddvudfhkeelheefueefleffgfffffefleejheduvdeutdekleevheekieefteegnecu
    ffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhgihhthhhusgdrtghomhdpkhgvrhhnvg
    hlrdhorhhgpddtuddrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:N-JZZSCwcbExj6Q352Tpfke95PkKQO-pfVFEMqY79O6S_SoSfcAWjA>
    <xmx:N-JZZfiBaAs-vYc4wgOA07scQBHcbwyxe4AkC3XE5qb2RVBA5tg_-Q>
    <xmx:N-JZZerCyiHoCRWkiHyFGqSz9UP7pFZe9SzMVJEORkO53418B5RomQ>
    <xmx:OOJZZfhdNRtWpwvuhiWA9MRrB0z1up52J565-3vJjSvtE7ghi-wVbw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Nov 2023 05:23:47 -0500 (EST)
Message-ID: <9ad32b90-b03b-f493-14fb-ce31a1409774@themaw.net>
Date: Sun, 19 Nov 2023 18:23:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs: add: new_inode check in autofs_fill_super()
To: kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Bill O'Donnell <billodo@redhat.com>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 autofs mailing list <autofs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
References: <20231116000746.7359-1-raven@themaw.net>
 <202311161909.KHau6jEj-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202311161909.KHau6jEj-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/11/23 19:23, kernel test robot wrote:
> Hi Ian,
>
> kernel test robot noticed the following build warnings:

Crikey, how did this compile ... I think I need to just send a replacement

patch.


Ian

> [auto build test WARNING on brauner-vfs/vfs.all]
> [also build test WARNING on linus/master v6.7-rc1 next-20231116]
> [cannot apply to vfs-idmapping/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:https://github.com/intel-lab-lkp/linux/commits/Ian-Kent/autofs-add-new_inode-check-in-autofs_fill_super/20231116-081017
> base:https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git  vfs.all
> patch link:https://lore.kernel.org/r/20231116000746.7359-1-raven%40themaw.net
> patch subject: [PATCH] autofs: add: new_inode check in autofs_fill_super()
> config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231116/202311161909.KHau6jEj-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git  ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311161909.KHau6jEj-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot<lkp@intel.com>
> | Closes:https://lore.kernel.org/oe-kbuild-all/202311161909.KHau6jEj-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>     fs/autofs/inode.c:330:8: error: expected identifier
>                     goto -ENOMEM;
>                          ^
>>> fs/autofs/inode.c:330:8: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
>     fs/autofs/inode.c:329:2: note: previous statement is here
>             if (!ino)
>             ^
>     fs/autofs/inode.c:349:4: error: use of undeclared identifier 'ret'
>                             ret = invalf(fc, "Could not find process group %d",
>                             ^
>     fs/autofs/inode.c:351:11: error: use of undeclared identifier 'ret'
>                             return ret;
>                                    ^
>>> fs/autofs/inode.c:330:8: warning: expression result unused [-Wunused-value]
>                     goto -ENOMEM;
>                          ^~~~~~~
>     2 warnings and 3 errors generated.
>
>
> vim +/if +330 fs/autofs/inode.c
>
>     306	
>     307	static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
>     308	{
>     309		struct autofs_fs_context *ctx = fc->fs_private;
>     310		struct autofs_sb_info *sbi = s->s_fs_info;
>     311		struct inode *root_inode;
>     312		struct dentry *root;
>     313		struct autofs_info *ino;
>     314	
>     315		pr_debug("starting up, sbi = %p\n", sbi);
>     316	
>     317		sbi->sb = s;
>     318		s->s_blocksize = 1024;
>     319		s->s_blocksize_bits = 10;
>     320		s->s_magic = AUTOFS_SUPER_MAGIC;
>     321		s->s_op = &autofs_sops;
>     322		s->s_d_op = &autofs_dentry_operations;
>     323		s->s_time_gran = 1;
>     324	
>     325		/*
>     326		 * Get the root inode and dentry, but defer checking for errors.
>     327		 */
>     328		ino = autofs_new_ino(sbi);
>     329		if (!ino)
>   > 330			goto -ENOMEM;
>     331	
>     332		root_inode = autofs_get_inode(s, S_IFDIR | 0755);
>     333		if (root_inode) {
>     334			root_inode->i_uid = ctx->uid;
>     335			root_inode->i_gid = ctx->gid;
>     336			root_inode->i_fop = &autofs_root_operations;
>     337			root_inode->i_op = &autofs_dir_inode_operations;
>     338		}
>     339		s->s_root = d_make_root(root_inode);
>     340		if (unlikely(!s->s_root)) {
>     341			autofs_free_ino(ino);
>     342			return -ENOMEM;
>     343		}
>     344		s->s_root->d_fsdata = ino;
>     345	
>     346		if (ctx->pgrp_set) {
>     347			sbi->oz_pgrp = find_get_pid(ctx->pgrp);
>     348			if (!sbi->oz_pgrp) {
>     349				ret = invalf(fc, "Could not find process group %d",
>     350					     ctx->pgrp);
>     351				return ret;
>     352			}
>     353		} else {
>     354			sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
>     355		}
>     356	
>     357		if (autofs_type_trigger(sbi->type))
>     358			/* s->s_root won't be contended so there's little to
>     359			 * be gained by not taking the d_lock when setting
>     360			 * d_flags, even when a lot mounts are being done.
>     361			 */
>     362			managed_dentry_set_managed(s->s_root);
>     363	
>     364		pr_debug("pipe fd = %d, pgrp = %u\n",
>     365			 sbi->pipefd, pid_nr(sbi->oz_pgrp));
>     366	
>     367		sbi->flags &= ~AUTOFS_SBI_CATATONIC;
>     368		return 0;
>     369	}
>     370	
>

