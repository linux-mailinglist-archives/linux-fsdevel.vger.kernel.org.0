Return-Path: <linux-fsdevel+bounces-4921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C2F806509
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 03:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12411F216E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF276AA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ftSLFoF7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0FEC6
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 17:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3fc5j/2w64P+bZoWi9Zqmy+ohyTwgaq2JDVxeNkai/w=; b=ftSLFoF7fSptNwos8VuR8jugnI
	OChogKqK2q6Aje1wDRuRwnJeydnjupBzxYCYmtB9Z7vNJJEkefmfFGMhhc6bSiVN0bL6S9gRSo7aF
	Okg9FqbH0Ldg/dF8T/vA0SDPTjZe+NF39D7U8NlJWO6JPRjgYGzNmJQnseCCrkxzQWxqggIYj5ipQ
	tDgkSc+6YcMeSorGqETj4bBJo5hSsbpWqtheWtYSAPnUwQfwzg9phZ7iNAEGH3cHgH7oNTJTPyUeY
	DL0LLtgIlQUtRIdI9Qw04s+N9UlYjFdx+4qoEUSBpR3FulVAO5A2O9YZwBSIlk3UDI4vtV/M9LFaj
	E8Y0WkcA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAgIA-007WlE-2q;
	Wed, 06 Dec 2023 01:01:35 +0000
Date: Wed, 6 Dec 2023 01:01:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:carved-up-__dentry_kill 22/28] fs/dcache.c:1101:33:
 error: 'dentry' undeclared
Message-ID: <20231206010134.GK1674809@ZenIV>
References: <202312060802.HxDqIoDc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312060802.HxDqIoDc-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 06, 2023 at 08:29:37AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git carved-up-__dentry_kill
> head:   20f7d1936e8a2859fee51273c8ffadcca4304968
> commit: c73bce0494d44e0d26ec351106558e4408cf1cd9 [22/28] step 3: have __dentry_kill() return the parent
> config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20231206/202312060802.HxDqIoDc-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060802.HxDqIoDc-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312060802.HxDqIoDc-lkp@intel.com/
> 
> Note: the viro-vfs/carved-up-__dentry_kill HEAD 20f7d1936e8a2859fee51273c8ffadcca4304968 builds fine.
>       It only hurts bisectability.

Argh...  carve-up fuckups...  delta to fix that one up follows,
the breakage actually disappears on the next step.  Sorry about that...
Updated branch force-pushed

diff --git a/fs/dcache.c b/fs/dcache.c
index b35d120193e0..fc8347b8ac98 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1098,10 +1098,10 @@ EXPORT_SYMBOL(d_prune_aliases);
 
 static inline void shrink_kill(struct dentry *victim, struct list_head *list)
 {
-	struct dentry *parent = dentry->d_parent;
-	if (parent != victim && if (!--parent->d_lockref.count)
+	struct dentry *parent = victim->d_parent;
+	if (parent != victim && !--parent->d_lockref.count)
 		to_shrink_list(parent, list);
-	parent = __dentry_kill(dentry);
+	parent = __dentry_kill(victim);
 	if (parent)
 		spin_unlock(&parent->d_lock);
 }

