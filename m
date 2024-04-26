Return-Path: <linux-fsdevel+bounces-17918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07108B3C0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B48281120
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB85F14A4D4;
	Fri, 26 Apr 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="fFXCufbW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88312148FE5;
	Fri, 26 Apr 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146572; cv=none; b=E0UVHwzH2H3xobNxC8CYwVSzo8tVBoEhZ1se2IVwuEgmBYMOE1/StU5G7xOxVfD1msI1UgZ3D50mqusYNHX+04frOFdlD1k/UBdtI7Ihcj1PcWykv9XrIO8s7Rs3NoDEYxlOEbgA+e2V15ybPFtyupwm9lomXvxVXvPEra7JeJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146572; c=relaxed/simple;
	bh=ywqzQlcBdT+XYVePsldZkrYZeUdhQTc1iSqyiEwdgjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoLZByQIHyV434/Dfs1PUmCqkEUmqlFr9xQz/O36XIaxreGB+V0IRrD7H6WmjjiUzwbU9mX3BEaeAWVRnCVN6ErcvOSwAwBOO02BKWCwO018uVgwRL8X/P4C8D9U2s4nMKHxr0RwcBWfmP30jSeuisV1Ttc1hVM//GVvWDM2EIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=fFXCufbW; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VQxx133srz9sq6;
	Fri, 26 Apr 2024 17:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714146565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XNNw6TAlLezpTq9qoSuGur/Xk2cZhgELQYdUZKIkBRA=;
	b=fFXCufbW2/eqJVZpXbrEBjvew3iTSt7TwmO55jD3Ziim1za9z7hXnhBBkMkCqgITa+BGXr
	wwm5gBcD8ShA7EPmhuJq31ka/N31bA9+d2R8MeV3659FpHAeOHBUVpBW5NZR+gP4xCwEjQ
	/TzO+4nki4F0mdJuSWGqS1X7cVXY9+YgdleSZdwj0pAHE01PQlrZIrTLOQNTCWQo1sVMZM
	lOj8MKV11cSQZuc9ryfWk7MUdr/fNOYwt7109AyXJS5JLmQWfb2+RGb0IJ6pW1nhnyQXAX
	LhJPoPMyqlmvyobKegjFGtAnHaly1KmAZUPPcVQ2Xb9CAap2h/TyaWVy8TI7hA==
Date: Fri, 26 Apr 2024 15:49:19 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 05/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <20240426154919.hupoxurihhbfj67x@quentin>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-6-kernel@pankajraghav.com>
 <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziq4qAJ_p7P9Smpn@casper.infradead.org>

On Thu, Apr 25, 2024 at 09:10:16PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 25, 2024 at 01:37:40PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Splitting a larger folio with a base order is supported using
> > split_huge_page_to_list_to_order() API. However, using that API for LBS
> > is resulting in an NULL ptr dereference error in the writeback path [1].
> > 
> > Refuse to split a folio if it has minimum folio order requirement until
> > we can start using split_huge_page_to_list_to_order() API. Splitting the
> > folio can be added as a later optimization.
> > 
> > [1] https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
> 
> Obviously this has to be tracked down and fixed before this patchset can
> be merged ... I think I have some ideas.  Let me look a bit.  How
> would I go about reproducing this?

I am able to reproduce it in a VM with 4G RAM and running generic/447
(sometimes you have to run it twice) on a 16K BS on a 4K PS system.

I have a suspicion on this series: https://lore.kernel.org/linux-fsdevel/20240215063649.2164017-1-hch@lst.de/
but I am still unsure why this is happening when we split with LBS
configurations.

If you have kdevops installed, then go with Luis's suggestion, or else
this is my local config.

This is the diff I applied instead of this patch:

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
 
(END)

xfstests is based on https://github.com/kdave/xfstests/tree/v2024.04.14

xfstests config:

[default]
FSTYP=xfs
RESULT_BASE=/root/results/
DUMP_CORRUPT_FS=1
CANON_DEVS=yes
RECREATE_TEST_DEV=true
TEST_DEV=/dev/nvme0n1
TEST_DIR=/media/test
SCRATCH_DEV=/dev/vdb
SCRATCH_MNT=/media/scratch
LOGWRITES_DEV=/dev/vdc

[16k_4ks]
MKFS_OPTIONS='-f -m reflink=1,rmapbt=1, -i sparse=1, -b size=16k, -s size=4k'

[nix-shell:~]# lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
vdb     254:16   0   32G  0 disk /media/scratch
vdc     254:32   0   32G  0 disk 
nvme0n1 259:0    0   32G  0 disk /media/test

$ ./check -s 16k_4ks generic/447

BT:
[   74.170698] BUG: KASAN: null-ptr-deref in filemap_get_folios_tag+0x14b/0x510                                                                                                                                                                                                                                                                                                               
[   74.170938] Write of size 4 at addr 0000000000000036 by task kworker/u16:6/284                                                                                                                                                                                                                                                                                                             
[   74.170938]                                                                                                                                                                                                                                                                                                                                                                                
[   74.170938] CPU: 0 PID: 284 Comm: kworker/u16:6 Not tainted 6.9.0-rc4-00011-g4676d00b6f6f #7                                                                                                                                                                                                                                                                                               
[   74.170938] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014                                                                                                                                                                                                                                                               
[   74.170938] Workqueue: writeback wb_workfn (flush-254:16)                                                                                                                                                                                                                                                                                                                                  
[   74.170938] Call Trace:                                                                                                                                                                                                                                                                                                                                                                    
[   74.170938]  <TASK>                                                                                                                                                                                                                                                                                                                                                                        
[   74.170938]  dump_stack_lvl+0x51/0x70                                                                                                                                                                                                                                                                                                                                                      
[   74.170938]  kasan_report+0xab/0xe0                                                                                                                                                                                                                                                                                                                                                        
[   74.170938]  ? filemap_get_folios_tag+0x14b/0x510                                                                                                                                                                                                                                                                                                                                          
[   74.170938]  kasan_check_range+0x35/0x1b0                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  filemap_get_folios_tag+0x14b/0x510                                                                                                                                                                                                                                                                                                                                            
[   74.170938]  ? __pfx_filemap_get_folios_tag+0x10/0x10                                                                                                                                                                                                                                                                                                                                      
[   74.170938]  ? srso_return_thunk+0x5/0x5f                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  writeback_iter+0x508/0xcc0                                                                                                                                                                                                                                                                                                                                                    
[   74.170938]  ? __pfx_iomap_do_writepage+0x10/0x10                                                                                                                                                                                                                                                                                                                                          
[   74.170938]  write_cache_pages+0x80/0x100                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? __pfx_write_cache_pages+0x10/0x10                                                                                                                                                                                                                                                                                                                                           
[   74.170938]  ? srso_return_thunk+0x5/0x5f                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? srso_return_thunk+0x5/0x5f                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? srso_return_thunk+0x5/0x5f                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? _raw_spin_lock+0x87/0xe0                                                                                                                                                                                                                                                                                                                                                    
[   74.170938]  iomap_writepages+0x85/0xe0                                                                                                                                                                                                                                                                                                                                                    
[   74.170938]  xfs_vm_writepages+0xe3/0x140 [xfs]                                                                                                                                                                                                                                                                                                                                            
[   74.170938]  ? __pfx_xfs_vm_writepages+0x10/0x10 [xfs]                                                                                                                                                                                                                                                                                                                                     
[   74.170938]  ? kasan_save_track+0x10/0x30                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? srso_return_thunk+0x5/0x5f                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? __kasan_kmalloc+0x7b/0x90                                                                                                                                                                                                                                                                                                                                                   
[   74.170938]  ? srso_return_thunk+0x5/0x5f                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? virtqueue_add_split+0x605/0x1b00                                                                                                                                                                                                                                                                                                                                            
[   74.170938]  do_writepages+0x176/0x740                                                                                                                                                                                                                                                                                                                                                     
[   74.170938]  ? __pfx_do_writepages+0x10/0x10                                                                                                                                                                                                                                                                                                                                               
[   74.170938]  ? __pfx_virtqueue_add_split+0x10/0x10                                                                                                                                                                                                                                                                                                                                         
[   74.170938]  ? __pfx_update_sd_lb_stats.constprop.0+0x10/0x10                                                                                                                                                                                                                                                                                                                              
[   74.170938]  ? srso_return_thunk+0x5/0x5f                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? virtqueue_add_sgs+0xfe/0x130                                                                                                                                                                                                                                                                                                                                                
[   74.170938]  ? srso_return_thunk+0x5/0x5f                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? virtblk_add_req+0x15c/0x280                                                                                                                                                                                                                                                                                                                                                 
[   74.170938]  __writeback_single_inode+0x9f/0x840                                                                                                                                                                                                                                                                                                                                           
[   74.170938]  ? wbc_attach_and_unlock_inode+0x345/0x5d0                                                                                                                                                                                                                                                                                                                                     
[   74.170938]  writeback_sb_inodes+0x491/0xce0                                                                                                                                                                                                                                                                                                                                               
[   74.170938]  ? __pfx_wb_calc_thresh+0x10/0x10                                                                                                                                                                                                                                                                                                                                              
[   74.170938]  ? __pfx_writeback_sb_inodes+0x10/0x10                                                                                                                                                                                                                                                                                                                                         
[   74.170938]  ? __wb_calc_thresh+0x1a0/0x3c0                                                                                                                                                                                                                                                                                                                                                
[   74.170938]  ? __pfx_down_read_trylock+0x10/0x10                                                                                                                                                                                                                                                                                                                                           
[   74.170938]  ? wb_over_bg_thresh+0x16b/0x5e0                                                                                                                                                                                                                                                                                                                                               
[   74.170938]  ? __pfx_move_expired_inodes+0x10/0x10                                                                                                                                                                                                                                                                                                                                         
[   74.170938]  __writeback_inodes_wb+0xb7/0x200                                                                                                                                                                                                                                                                                                                                              
[   74.170938]  wb_writeback+0x2c4/0x660                                                                                                                                                                                                                                                                                                                                                      
[   74.170938]  ? __pfx_wb_writeback+0x10/0x10                                                                                                                                                                                                                                                                                                                                                
[   74.170938]  ? __pfx__raw_spin_lock_irq+0x10/0x10                                                                                                                                                                                                                                                                                                                                          
[   74.170938]  wb_workfn+0x54e/0xaf0                                                                                                                                                                                                                                                                                                                                                         
[   74.170938]  ? srso_return_thunk+0x5/0x5f                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? __pfx_wb_workfn+0x10/0x10                                                                                                                                                                                                                                                                                                                                                   
[   74.170938]  ? __pfx___schedule+0x10/0x10                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? __pfx__raw_spin_lock_irq+0x10/0x10                                                                                                                                                                                                                                                                                                                                          
[   74.170938]  process_one_work+0x622/0x1020                                                                                                                                                                                                                                                                                                                                                 
[   74.170938]  worker_thread+0x844/0x10e0                                                                                                                                                                                                                                                                                                                                                    
[   74.170938]  ? srso_return_thunk+0x5/0x5f                                                                                                                                                                                                                                                                                                                                                  
[   74.170938]  ? __kthread_parkme+0x82/0x150                                                                                                                                                                                                                                                                                                                                                 
[   74.170938]  ? __pfx_worker_thread+0x10/0x10                                                                                                                                                                                                                                                                                                                                               
[   74.170938]  kthread+0x2b4/0x380                                                                                                                                                                                                                                                                                                                                                           
[   74.170938]  ? __pfx_kthread+0x10/0x10                                                                                                                                                                                                                                                                                                                                                     
[   74.170938]  ret_from_fork+0x30/0x70                                                                                                                                                                                                                                                                                                                                                       
[   74.170938]  ? __pfx_kthread+0x10/0x10                                                                                                                                                                                                                                                                                                                                                     
[   74.170938]  ret_from_fork_asm+0x1a/0x30       
[   74.170938]  </TASK>

