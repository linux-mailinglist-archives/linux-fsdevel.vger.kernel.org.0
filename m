Return-Path: <linux-fsdevel+bounces-15356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDC288C8A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 17:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C9B1F81746
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE1313C9DE;
	Tue, 26 Mar 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="yHdjTcr3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1913C9DA;
	Tue, 26 Mar 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469431; cv=none; b=OFONFl82acBT0QBHlUECca3HO/emSxaapkzVk2DR2SQ6TJ2NrBJO6byzLOXQt4lesZx6Y4n0Y41WoCkXV/tITh92pl+zfySa0zqWldQxhrvodKjFQCddlbJxPoI0eeoJQo38vfu+vrklnNLXcek1z1jpQIMaOnOhSAbsDGJxTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469431; c=relaxed/simple;
	bh=/SwuSRn116nG3Z+Fz1PchQ+dbuLiQb7TRnc9ZAa32x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAoC0pJCFaa3udlmhmdi395Xm1BCCd8bLuPk5L2xCfIdzoQaoyyVnAkfKAna07wWMlwa2mJxpAGwli7X5btyzk+5VoqjLoU+gSWnbUL4WKTwHUb8oB+tTT8czJtFmdEH/y9FvrpNV9I6tT3GY89mk/lrXeEIk3qSf+/PN3AYY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=yHdjTcr3; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4V3vsV0n1cz9scM;
	Tue, 26 Mar 2024 17:10:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711469422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3WN8iTw5DCvKXICzDy7GvWDFRE7iUHmu0GOhWN9n+ms=;
	b=yHdjTcr384i1cvB7hFZT30C9uBwMD8Us2p3BaRxE0yzhUO6JeAPk0zbE/aLeBCdkTVl7D5
	9z4OZ76A4edSg78yhI+sI+LkX0vMgIvnkZ87Umo2iejOCXrLpLweRxhAkG/pX+b5lhwt+1
	CZf+iNlgRGCVeHaRVugTq+BcwLBVgJS+TnAibuVTetwJsAYtyvFH7+VzgyA0d/xTMPMysY
	ljgBOdTodJUMIj6yb/ml9uROxuNUdW954fQNFWTMA4SPwNQHnqbUJ/qyPpwP/d4QAelyv9
	btnQQq2OrXVss98yKjHHtksrbitZ6nra40b6cZZDvZVZdPf3F6Zj5BvBkKPtSA==
Date: Tue, 26 Mar 2024 17:10:18 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>, ziy@nvidia.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	gost.dev@samsung.com, chandan.babu@oracle.com, hare@suse.de, mcgrof@kernel.org, 
	djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	david@fromorbit.com, akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 07/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <muprk3zff7dsn3futp3by3t6bxuy5m62rpylmrp77ss3kay24k@wx4fn7uw7y6r>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-8-kernel@pankajraghav.com>
 <ZgHLHNYdK-kU3UAi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHLHNYdK-kU3UAi@casper.infradead.org>
X-Rspamd-Queue-Id: 4V3vsV0n1cz9scM

On Mon, Mar 25, 2024 at 07:06:04PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 13, 2024 at 06:02:49PM +0100, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > As we don't have a way to split a folio to a any given lower folio
> > order yet, avoid splitting the folio in split_huge_page_to_list() if it
> > has a minimum folio order requirement.
> 
> FYI, Zi Yan's patch to do that is now in Andrew's tree.
> c010d47f107f609b9f4d6a103b6dfc53889049e9 in current linux-next (dated
> Feb 26)

Yes, I started playing with the patches but I am getting a race condition
resulting in a null-ptr-deref for which I don't have a good answer for
yet.

@zi yan Did you encounter any issue like this when you were testing?

I did the following change (just a prototype) instead of this patch:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..63ee7b6ed03d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3041,6 +3041,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 {
        struct folio *folio = page_folio(page);
        struct deferred_split *ds_queue = get_deferred_split_queue(folio);
+       unsigned int mapping_min_order = mapping_min_folio_order(folio->mapping);
+
+       if (!folio_test_anon(folio))
+               new_order = max_t(unsigned int, mapping_min_order, new_order);
        /* reset xarray order to new order after split */
        XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
        struct anon_vma *anon_vma = NULL;
@@ -3117,6 +3121,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
                        goto out;
                }
 
+               // XXX: Remove it later
+               VM_WARN_ON_FOLIO((new_order < mapping_min_order), folio);
                gfp = current_gfp_context(mapping_gfp_mask(mapping) &
                                                        GFP_RECLAIM_MASK);

I am getting a random null-ptr deref when I run generic/176 multiple
times with different blksizes. I still don't have a minimal reproducer 
for this issue. Race condition during writeback:

filemap_get_folios_tag+0x171/0x5c0:
arch_atomic_read at arch/x86/include/asm/atomic.h:23
(inlined by) raw_atomic_read at include/linux/atomic/atomic-arch-fallback.h:457
(inlined by) raw_atomic_fetch_add_unless at include/linux/atomic/atomic-arch-fallback.h:2426
(inlined by) raw_atomic_add_unless at include/linux/atomic/atomic-arch-fallback.h:2456
(inlined by) atomic_add_unless at include/linux/atomic/atomic-instrumented.h:1518
(inlined by) page_ref_add_unless at include/linux/page_ref.h:238
(inlined by) folio_ref_add_unless at include/linux/page_ref.h:247
(inlined by) folio_ref_try_add_rcu at include/linux/page_ref.h:280
(inlined by) folio_try_get_rcu at include/linux/page_ref.h:313
(inlined by) find_get_entry at mm/filemap.c:1984
(inlined by) filemap_get_folios_tag at mm/filemap.c:2222



[  537.863105] ==================================================================                                                                                                                                                                                                                                             
[  537.863968] BUG: KASAN: null-ptr-deref in filemap_get_folios_tag+0x171/0x5c0                                                                                                                                                                                                                                               
[  537.864581] Write of size 4 at addr 0000000000000036 by task kworker/u32:5/366                                                                                                                                                                                                                                             
[  537.865123]                                                                                                                                                       
[  537.865293] CPU: 6 PID: 366 Comm: kworker/u32:5 Not tainted 6.8.0-11739-g7d0c6e7b5a7d-dirty #795                                                                                                                                                                                                                           
[  537.867201] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014                                                                                                                                                                                               
[  537.868444] Workqueue: writeback wb_workfn (flush-254:32)                                                                                                   
[  537.869055] Call Trace:                                                                                                                                     
[  537.869341]  <TASK>                                                                                                                                         
[  537.869569]  dump_stack_lvl+0x4f/0x70                                                                                                                       
[  537.869938]  kasan_report+0xbd/0xf0                                                                                                                         
[  537.870293]  ? filemap_get_folios_tag+0x171/0x5c0                                                                                                           
[  537.870767]  ? filemap_get_folios_tag+0x171/0x5c0                                                                                                           
[  537.871578]  kasan_check_range+0x101/0x1b0                                                                                                                  
[  537.871893]  filemap_get_folios_tag+0x171/0x5c0                                                                                                                                                                                                                                                                            
[  537.872269]  ? __pfx_filemap_get_folios_tag+0x10/0x10                                                                                                       
[  537.872857]  ? __pfx___submit_bio+0x10/0x10                                                                                                                 
[  537.873326]  ? mlock_drain_local+0x234/0x3f0                                                                                                                
[  537.873938]  writeback_iter+0x59a/0xe00                                                                                                                     
[  537.874477]  ? __pfx_iomap_do_writepage+0x10/0x10                                                                                                           
[  537.874969]  write_cache_pages+0x7f/0x100                                                                                                                   
[  537.875396]  ? __pfx_write_cache_pages+0x10/0x10                                                                                                            
[  537.875892]  ? do_raw_spin_lock+0x12d/0x270                                                                                                                 
[  537.876345]  ? __pfx_do_raw_spin_lock+0x10/0x10                                                                                                                                                                                                                                                                            
[  537.876804]  iomap_writepages+0x88/0xf0                                                                                                                     
[  537.877186]  xfs_vm_writepages+0x120/0x190                                                                                                                  
[  537.877705]  ? __pfx_xfs_vm_writepages+0x10/0x10                                                                                                            
[  537.878161]  ? lock_release+0x36f/0x670                                                                                                                                                                                                                                                                                    
[  537.878521]  ? __wb_calc_thresh+0xe5/0x3b0                                                                                                                                                                                                                                                                                 
[  537.878892]  ? __pfx_lock_release+0x10/0x10                                                                                                                 
[  537.879308]  do_writepages+0x170/0x7a0                                                                                                                                                                                                                                                                                     
[  537.879676]  ? __pfx_do_writepages+0x10/0x10                                                                                                                                                                                                                                                                               
[  537.880182]  ? writeback_sb_inodes+0x312/0xe40                                                                                                                                                                                                                                                                             
[  537.880689]  ? reacquire_held_locks+0x1f1/0x4a0                                                                                                                                                                                                                                                                            
[  537.881193]  ? writeback_sb_inodes+0x312/0xe40                                                                                                                                                                                                                                                                             
[  537.881665]  ? find_held_lock+0x2d/0x110                                                                                                                                                                                                                                                                                   
[  537.882104]  ? lock_release+0x36f/0x670                                                                                                                                                                                                                                                                                    
[  537.883344]  ? wbc_attach_and_unlock_inode+0x3b8/0x710                                                                                                                                                                                                                                                                     
[  537.883853]  ? __pfx_lock_release+0x10/0x10                                                                                                                                                                                                                                                                                
[  537.884229]  ? __pfx_lock_release+0x10/0x10                                                                                                                                                                                                                                                                                
[  537.884604]  ? lock_acquire+0x138/0x2f0                                                                                                                                                                                                                                                                                    
[  537.884952]  __writeback_single_inode+0xd4/0xa60                                                                                                            
[  537.885369]  writeback_sb_inodes+0x4cf/0xe40                                                                                                                
[  537.885760]  ? __pfx_writeback_sb_inodes+0x10/0x10                                                                                                                                                                                                                                                                         
[  537.886208]  ? __pfx_move_expired_inodes+0x10/0x10                                                                                                          
[  537.886640]  __writeback_inodes_wb+0xb4/0x200                                                                                                               
[  537.887037]  wb_writeback+0x55b/0x7c0                                                                                                                       
[  537.887372]  ? __pfx_wb_writeback+0x10/0x10                                                                                                                                                                                                                                                                                
[  537.887750]  ? lock_acquire+0x138/0x2f0                                                                                                                     
[  537.888094]  ? __pfx_register_lock_class+0x10/0x10                                                                                                          
[  537.888521]  wb_workfn+0x648/0xbb0                                                                                                                          
[  537.888835]  ? __pfx_wb_workfn+0x10/0x10                                                                                                                                                                                                                                                                                   
[  537.889192]  ? lock_acquire+0x128/0x2f0                                                                                                                     
[  537.889539]  ? lock_acquire+0x138/0x2f0                                                                                                                     
[  537.889890]  process_one_work+0x7ff/0x1710                                                                                                                                                                                                                                                                                 
[  537.890272]  ? __pfx_process_one_work+0x10/0x10                                                                                                             
[  537.890685]  ? assign_work+0x16c/0x240                                                                                                                                                                                                                                                                                     
[  537.891026]  worker_thread+0x6e8/0x12b0                                                                                                                     
[  537.891381]  ? __pfx_worker_thread+0x10/0x10                                                                                                                
[  537.891768]  kthread+0x2ad/0x380                                                                                                                                                                                                                                                                                           
[  537.892064]  ? __pfx_kthread+0x10/0x10                                                                                                                                                                                                                                                                                     
[  537.892403]  ret_from_fork+0x2d/0x70                                                                                                                                                                                                                                                                                       
[  537.892728]  ? __pfx_kthread+0x10/0x10                                                                                                                                                                                                                                                                                     
[  537.893068]  ret_from_fork_asm+0x1a/0x30                                                                                                                                                                                                                                                                                   
[  537.893434]  </TASK>

