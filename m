Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCA44380C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbfFMPDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:03:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46484 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732500AbfFMOYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:24:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id x18so852112qkn.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8qDvqM2GUVe0Bp/JZny67bgQgfoSmGEovigFpwQP//c=;
        b=HB8OPOL/WvPwqHDl2eYxS6syerahFtAspxoibofrZcQcf7QOvufT6iB4Sd3jez8tJG
         pUmGjRjzeKQnLG/T5ErSc2j8oWTcC1W1uueLQjpD604phcVGRT/glCi/mgHMGGiP/f4V
         cd0tAw2hzbWuoOYVvC3hIQm7Lg2irgI1qj7/Nv7/VzIYXJfIuwwnOzKyHVovagfv1Sng
         ZkzxgpOSIXATFY7an1X03hoSAzOgaDtDBS6im5xDx8oftM6RWVJDGeLw7OMQ1iEIbF/P
         AIFGyr0GWbMK3PnjyNaey0w0JnaJSVn5B9tu+zZ4eOwC6jDdPEJVTDWzSq6DRFmyBDre
         FHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8qDvqM2GUVe0Bp/JZny67bgQgfoSmGEovigFpwQP//c=;
        b=gsVEY2XtYjz+ghNdRifBx+o8NPOm6HbK0ycYne/tWYF1mZj9Nz4WpCHXBlCGSgolDe
         mHnSl5WclLksSEt8ZE8W0Vc6J8Nm0fnr8+K/IyJvi547dd8JMpu6gWj+knRlVzTrRpnw
         ni+Eszca4iNSBk+xyjiqMD+gUcgMDYfSTPJMNluEkypJr0XrinNQSHyGV3hcEznNOQbx
         YYLwc/dMJhI87HVoXCBg3ZSbXkFOqA8eTgcw1IBgpPgV4dqfcH6Tr2NVBP05S9p6p23K
         hcP0hFwunqOCjYHgGE6kwrIK59ZikcTVR062i2+LCdGaVlx8NavTS2TqoZcEsGXkavuR
         m1lw==
X-Gm-Message-State: APjAAAWRM+AbHnzO4EHj56z0bFXxkCR1xQ9Ot53ZmYBZ0LkZoBdUAUoI
        Q829ZsauW9mCYilNmUhzrPHT4kj3n9IMc7vp
X-Google-Smtp-Source: APXvYqxGE0ZYsyK3nVI/b9flMV6ouxTsNZIBKq6tl5RD2bgPpCoybjKSs/KC5OMu1+Ywi1Wh3n186A==
X-Received: by 2002:a37:9481:: with SMTP id w123mr52587980qkd.319.1560435851467;
        Thu, 13 Jun 2019 07:24:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::9d6b])
        by smtp.gmail.com with ESMTPSA id 2sm2066304qtz.73.2019.06.13.07.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:24:10 -0700 (PDT)
Date:   Thu, 13 Jun 2019 10:24:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 14/19] btrfs: redirty released extent buffers in
 sequential BGs
Message-ID: <20190613142408.p3ra5urczrzgqr2q@MacBook-Pro-91.local>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-15-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607131025.31996-15-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:10:20PM +0900, Naohiro Aota wrote:
> Tree manipulating operations like merging nodes often release
> once-allocated tree nodes. Btrfs cleans such nodes so that pages in the
> node are not uselessly written out. On HMZONED drives, however, such
> optimization blocks the following IOs as the cancellation of the write out
> of the freed blocks breaks the sequential write sequence expected by the
> device.
> 
> This patch introduces a list of clean extent buffers that have been
> released in a transaction. Btrfs consult the list before writing out and
> waiting for the IOs, and it redirties a buffer if 1) it's in sequential BG,
> 2) it's in un-submit range, and 3) it's not under IO. Thus, such buffers
> are marked for IO in btrfs_write_and_wait_transaction() to send proper bios
> to the disk.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/disk-io.c     | 27 ++++++++++++++++++++++++---
>  fs/btrfs/extent_io.c   |  1 +
>  fs/btrfs/extent_io.h   |  2 ++
>  fs/btrfs/transaction.c | 35 +++++++++++++++++++++++++++++++++++
>  fs/btrfs/transaction.h |  3 +++
>  5 files changed, 65 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 6651986da470..c6147fce648f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -535,7 +535,9 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
>  	if (csum_tree_block(eb, result))
>  		return -EINVAL;
>  
> -	if (btrfs_header_level(eb))
> +	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags))
> +		ret = 0;
> +	else if (btrfs_header_level(eb))
>  		ret = btrfs_check_node(eb);
>  	else
>  		ret = btrfs_check_leaf_full(eb);
> @@ -1115,10 +1117,20 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
>  void btrfs_clean_tree_block(struct extent_buffer *buf)
>  {
>  	struct btrfs_fs_info *fs_info = buf->fs_info;
> -	if (btrfs_header_generation(buf) ==
> -	    fs_info->running_transaction->transid) {
> +	struct btrfs_transaction *cur_trans = fs_info->running_transaction;
> +
> +	if (btrfs_header_generation(buf) == cur_trans->transid) {
>  		btrfs_assert_tree_locked(buf);
>  
> +		if (btrfs_fs_incompat(fs_info, HMZONED) &&
> +		    list_empty(&buf->release_list)) {
> +			atomic_inc(&buf->refs);
> +			spin_lock(&cur_trans->releasing_ebs_lock);
> +			list_add_tail(&buf->release_list,
> +				      &cur_trans->releasing_ebs);
> +			spin_unlock(&cur_trans->releasing_ebs_lock);
> +		}
> +
>  		if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
>  			percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
>  						 -buf->len,
> @@ -4533,6 +4545,15 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
>  	btrfs_destroy_pinned_extent(fs_info,
>  				    fs_info->pinned_extents);
>  
> +	while (!list_empty(&cur_trans->releasing_ebs)) {
> +		struct extent_buffer *eb;
> +
> +		eb = list_first_entry(&cur_trans->releasing_ebs,
> +				      struct extent_buffer, release_list);
> +		list_del_init(&eb->release_list);
> +		free_extent_buffer(eb);
> +	}
> +
>  	cur_trans->state =TRANS_STATE_COMPLETED;
>  	wake_up(&cur_trans->commit_wait);
>  }
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 13fca7bfc1f2..c73c69e2bef4 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4816,6 +4816,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
>  	init_waitqueue_head(&eb->read_lock_wq);
>  
>  	btrfs_leak_debug_add(&eb->leak_list, &buffers);
> +	INIT_LIST_HEAD(&eb->release_list);
>  
>  	spin_lock_init(&eb->refs_lock);
>  	atomic_set(&eb->refs, 1);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index aa18a16a6ed7..2987a01f84f9 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -58,6 +58,7 @@ enum {
>  	EXTENT_BUFFER_IN_TREE,
>  	/* write IO error */
>  	EXTENT_BUFFER_WRITE_ERR,
> +	EXTENT_BUFFER_NO_CHECK,
>  };
>  
>  /* these are flags for __process_pages_contig */
> @@ -186,6 +187,7 @@ struct extent_buffer {
>  	 */
>  	wait_queue_head_t read_lock_wq;
>  	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
> +	struct list_head release_list;
>  #ifdef CONFIG_BTRFS_DEBUG
>  	atomic_t spinning_writers;
>  	atomic_t spinning_readers;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 3f6811cdf803..ded40ad75419 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -236,6 +236,8 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>  	spin_lock_init(&cur_trans->dirty_bgs_lock);
>  	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
>  	spin_lock_init(&cur_trans->dropped_roots_lock);
> +	INIT_LIST_HEAD(&cur_trans->releasing_ebs);
> +	spin_lock_init(&cur_trans->releasing_ebs_lock);
>  	list_add_tail(&cur_trans->list, &fs_info->trans_list);
>  	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
>  			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
> @@ -2219,7 +2221,31 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  
>  	wake_up(&fs_info->transaction_wait);
>  
> +	if (btrfs_fs_incompat(fs_info, HMZONED)) {
> +		struct extent_buffer *eb;
> +
> +		list_for_each_entry(eb, &cur_trans->releasing_ebs,
> +				    release_list) {
> +			struct btrfs_block_group_cache *cache;
> +
> +			cache = btrfs_lookup_block_group(fs_info, eb->start);
> +			if (!cache)
> +				continue;
> +			mutex_lock(&cache->submit_lock);
> +			if (cache->alloc_type == BTRFS_ALLOC_SEQ &&
> +			    cache->submit_offset <= eb->start &&
> +			    !extent_buffer_under_io(eb)) {
> +				set_extent_buffer_dirty(eb);
> +				cache->space_info->bytes_readonly += eb->len;

Huh?

> +				set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
> +			}
> +			mutex_unlock(&cache->submit_lock);
> +			btrfs_put_block_group(cache);
> +		}
> +	}
> +

Helper here please.
>  	ret = btrfs_write_and_wait_transaction(trans);
> +
>  	if (ret) {
>  		btrfs_handle_fs_error(fs_info, ret,
>  				      "Error while writing out transaction");
> @@ -2227,6 +2253,15 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  		goto scrub_continue;
>  	}
>  
> +	while (!list_empty(&cur_trans->releasing_ebs)) {
> +		struct extent_buffer *eb;
> +
> +		eb = list_first_entry(&cur_trans->releasing_ebs,
> +				      struct extent_buffer, release_list);
> +		list_del_init(&eb->release_list);
> +		free_extent_buffer(eb);
> +	}
> +

Another helper, and also can't we release eb's above that we didn't need to
re-mark dirty?  Thanks,

Josef
