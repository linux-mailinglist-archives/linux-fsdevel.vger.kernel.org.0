Return-Path: <linux-fsdevel+bounces-14258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3BA87A0D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 02:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C031C220A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 01:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D3BA2D;
	Wed, 13 Mar 2024 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0TCvmlS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB30AD56;
	Wed, 13 Mar 2024 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293472; cv=none; b=l0YvECfSk2Tw2zmTGrqdty8eJ/sYmSnuj8yhuQcRqKZ+0JUtY2x8h8wpQ71Drm4z2zW9sgN7B8TYXkKwzeuDIk1YJKi4eq6UHlSx0AUmUZdS5k7dBi9PbwFhSpFz0OOermZuKzgxyK+BubO04p2Wzo4VB3FQZOUiNNyv0w4QRKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293472; c=relaxed/simple;
	bh=XSxgWVMGm0WFpPL9jfo/9EH6x7yKmpMZTIzFFuPvzSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWzvegOEYGZ9vOz7+IxhCeqXmzX1cfdo/InlQnJq29V+GjRMOW6kvPChVLc9BTE0VfN6QaO3PaJl4oxcO6eNGc25Nr1ohXjedFOPRyndfhWAIAHqxciK+UqneAIQN6AsjIvfJBq9Z5+Y2sFAGwZiX5OOYKvwLz/OhOQj3o0N7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0TCvmlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B22C433C7;
	Wed, 13 Mar 2024 01:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710293471;
	bh=XSxgWVMGm0WFpPL9jfo/9EH6x7yKmpMZTIzFFuPvzSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0TCvmlSVcvL9YpDVE8vvTYK7U4h9vzF8G+8XHKsxwudxp/pUtirWjpmPmmPqfOX4
	 JwGt9+gtS5lUWz1RxYwmXWY0KrnMGUxIiObDPhng4wWpjmt/LOV6oLF6RVjsxYqnkD
	 hxxVmvYDJUIiIgYjJpDkS4wwloTakPLQfUjh+qYcoNBU37a/Pzo1LXVDjTJ7bNRYtx
	 oBYe5Au46nymEQxWNQBlqXSXn86SDEg3h0M7h3s6uwUGULIRp1m+wkE3aDuMlHV9OO
	 ufecOpetpg/qgvgDoZBJTnwTwq1KPhvHWHQaJ5OQCetisx6fYRke3rnf5VrOMsPjaU
	 MxW+VgUP204yQ==
Date: Tue, 12 Mar 2024 18:31:10 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Ed Tsai =?utf-8?B?KOiUoeWul+i7kik=?= <Ed.Tsai@mediatek.com>
Cc: "hdanton@sina.com" <hdanton@sina.com>,
	Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	Freddy Hsin =?utf-8?B?KOi+m+aBkuixkCk=?= <Freddy.Hsin@mediatek.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Chun-Hung Wu =?utf-8?B?KOW3q+mnv+Wujyk=?= <Chun-hung.Wu@mediatek.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in
 f2fs_filemap_fault
Message-ID: <ZfEB3rPLQUjePNRz@google.com>
References: <0000000000000b4e27060ef8694c@google.com>
 <20240115120535.850-1-hdanton@sina.com>
 <4bbab168407600a07e1a0921a1569c96e4a1df31.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bbab168407600a07e1a0921a1569c96e4a1df31.camel@mediatek.com>

On 03/12, Ed Tsai (蔡宗軒) wrote:
> On Mon, 2024-01-15 at 20:05 +0800, Hillf Danton wrote:
> > 
> > ...
> > 
> > --- x/fs/f2fs/file.c
> > +++ y/fs/f2fs/file.c
> > @@ -39,6 +39,7 @@
> >  static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
> >  {
> >         struct inode *inode = file_inode(vmf->vma->vm_file);
> > +       vm_flags_t flags = vmf->vma->vm_flags;
> >         vm_fault_t ret;
> >  
> >         ret = filemap_fault(vmf);
> > @@ -46,7 +47,7 @@ static vm_fault_t f2fs_filemap_fault(str
> >                 f2fs_update_iostat(F2FS_I_SB(inode), inode,
> >                                         APP_MAPPED_READ_IO,
> > F2FS_BLKSIZE);
> >  
> > -       trace_f2fs_filemap_fault(inode, vmf->pgoff, vmf->vma-
> > >vm_flags, ret);
> > +       trace_f2fs_filemap_fault(inode, vmf->pgoff, flags, ret);
> >  
> >         return ret;
> >  }
> > --
> 
> Hi Jaegeuk,
> 
> We recently encountered this slabe-use-after-free issue in KASAN as
> well. Could you please review the patch above and merge it into f2fs?

Where is the patch?

> 
> Best,
> Ed
> 
> ==================================================================
> [29195.369964][T31720] BUG: KASAN: slab-use-after-free in
> f2fs_filemap_fault+0x50/0xe0
> [29195.370971][T31720] Read at addr f7ffff80454ebde0 by task AsyncTask
> #11/31720
> [29195.371881][T31720] Pointer tag: [f7], memory tag: [f1]
> [29195.372549][T31720] 
> [29195.372838][T31720] CPU: 2 PID: 31720 Comm: AsyncTask #11 Tainted:
> G        W  OE      6.6.17-android15-0-gcb5ba718a525 #1
> [29195.374862][T31720] Call trace:
> [29195.375268][T31720]  dump_backtrace+0xec/0x138
> [29195.375848][T31720]  show_stack+0x18/0x24
> [29195.376365][T31720]  dump_stack_lvl+0x50/0x6c
> [29195.376943][T31720]  print_report+0x1b0/0x714
> [29195.377520][T31720]  kasan_report+0xc4/0x124
> [29195.378076][T31720]  __do_kernel_fault+0xb8/0x26c
> [29195.378694][T31720]  do_bad_area+0x30/0xdc
> [29195.379226][T31720]  do_tag_check_fault+0x20/0x34
> [29195.379834][T31720]  do_mem_abort+0x58/0x104
> [29195.380388][T31720]  el1_abort+0x3c/0x5c
> [29195.380899][T31720]  el1h_64_sync_handler+0x54/0x90
> [29195.381529][T31720]  el1h_64_sync+0x68/0x6c
> [29195.382069][T31720]  f2fs_filemap_fault+0x50/0xe0
> [29195.382678][T31720]  __do_fault+0xc8/0xfc
> [29195.383209][T31720]  handle_mm_fault+0xb44/0x10c4
> [29195.383816][T31720]  do_page_fault+0x294/0x48c
> [29195.384395][T31720]  do_translation_fault+0x38/0x54
> [29195.385023][T31720]  do_mem_abort+0x58/0x104
> [29195.385577][T31720]  el0_da+0x44/0x78
> [29195.386057][T31720]  el0t_64_sync_handler+0x98/0xbc
> [29195.386688][T31720]  el0t_64_sync+0x1a8/0x1ac
> [29195.387249][T31720] 
> [29195.387534][T31720] Allocated by task 14784:
> [29195.388085][T31720]  kasan_save_stack+0x40/0x70
> [29195.388672][T31720]  save_stack_info+0x34/0x128
> [29195.389259][T31720]  kasan_save_alloc_info+0x14/0x20
> [29195.389901][T31720]  __kasan_slab_alloc+0x168/0x174
> [29195.390530][T31720]  slab_post_alloc_hook+0x88/0x3a4
> [29195.391168][T31720]  kmem_cache_alloc+0x18c/0x2c8
> [29195.391771][T31720]  vm_area_alloc+0x2c/0xe8
> [29195.392327][T31720]  mmap_region+0x440/0xa94
> [29195.392888][T31720]  do_mmap+0x3d0/0x524
> [29195.393399][T31720]  vm_mmap_pgoff+0x1a0/0x1f8
> [29195.393980][T31720]  ksys_mmap_pgoff+0x78/0xf4
> [29195.394557][T31720]  __arm64_sys_mmap+0x34/0x44
> [29195.395138][T31720]  invoke_syscall+0x58/0x114
> [29195.395727][T31720]  el0_svc_common+0x80/0xe0
> [29195.396292][T31720]  do_el0_svc+0x1c/0x28
> [29195.396812][T31720]  el0_svc+0x38/0x68
> [29195.397302][T31720]  el0t_64_sync_handler+0x68/0xbc
> [29195.397932][T31720]  el0t_64_sync+0x1a8/0x1ac
> [29195.398492][T31720] 
> [29195.398778][T31720] Freed by task 0:
> [29195.399240][T31720]  kasan_save_stack+0x40/0x70
> [29195.399825][T31720]  save_stack_info+0x34/0x128
> [29195.400412][T31720]  kasan_save_free_info+0x18/0x28
> [29195.401043][T31720]  ____kasan_slab_free+0x254/0x25c
> [29195.401682][T31720]  __kasan_slab_free+0x10/0x20
> [29195.402278][T31720]  slab_free_freelist_hook+0x174/0x1e0
> [29195.402961][T31720]  kmem_cache_free+0xc4/0x348
> [29195.403544][T31720]  __vm_area_free+0x84/0xa4
> [29195.404103][T31720]  vm_area_free_rcu_cb+0x10/0x20
> [29195.404719][T31720]  rcu_do_batch+0x214/0x720
> [29195.405284][T31720]  rcu_core+0x1b0/0x408
> [29195.405800][T31720]  rcu_core_si+0x10/0x20
> [29195.406348][T31720]  __do_softirq+0x120/0x3f4
> [29195.406907][T31720] 
> [29195.407191][T31720] The buggy address belongs to the object at
> ffffff80454ebdc0
> [29195.407191][T31720]  which belongs to the cache vm_area_struct of
> size 176
> [29195.408978][T31720] The buggy address is located 32 bytes inside of
> [29195.408978][T31720]  176-byte region [ffffff80454ebdc0,
> ffffff80454ebe70)
> [29195.410625][T31720] 
> [29195.410911][T31720] The buggy address belongs to the physical page:
> [29195.411709][T31720] page:0000000058f0f2f1 refcount:1 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0xc54eb
> [29195.412980][T31720] anon flags:
> 0x4000000000000800(slab|zone=1|kasantag=0x0)
> [29195.413880][T31720] page_type: 0xffffffff()
> [29195.414418][T31720] raw: 4000000000000800 f6ffff8002904500
> fffffffe076fc8c0 dead000000000007
> [29195.415488][T31720] raw: 0000000000000000 0000000000170017
> 00000001ffffffff 0000000000000000

