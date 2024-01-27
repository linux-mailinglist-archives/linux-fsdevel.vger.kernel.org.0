Return-Path: <linux-fsdevel+bounces-9152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E483E927
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF3C1C2666B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 01:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C953B66B;
	Sat, 27 Jan 2024 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhWEXBcr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5FB947B;
	Sat, 27 Jan 2024 01:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320433; cv=none; b=itIEHTBVP4OzyzMY76XBV4Ve9OBONy/L7kYRwFwKmX6UTEAFw6qtkinpycTjeYBKFEObVSwycFv10EQJ4hGEvlSb6wAvxl3HSxaycNTK0L11xOohENuISfci7Zd0GPErFiWe4M3+4i2xejXL1lj/cQVFfvPAwsnD0FzafWXEKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320433; c=relaxed/simple;
	bh=wFkjKKrofu5eHKkYSyn90lOxk94cwD9UKcmefnl2/PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9imWHZuOaJw67hsJDxY7Jwj8ZVwsrUom2z3lDbGXVZ3AGXuXiNxpcOEpGU1qhH5Sa2vzh/gz1LcItyZ/JUFNYWA294eYiQjq7XNgBgJJ2Aa8NbeNTiQSvJpqkhv9v2y8+FMGzyc2uOG6JU7QuC2h8tyEBSWLMkPkVKNG1j2mVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhWEXBcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF13C43390;
	Sat, 27 Jan 2024 01:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706320433;
	bh=wFkjKKrofu5eHKkYSyn90lOxk94cwD9UKcmefnl2/PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhWEXBcrZINo0GQmtAJ5UAJ3gDdF1IOQsqVxVRc6KnlVyFvSXoVi1VC5kglXsJUTg
	 gay1BaK9GLGLy3ZUe/iaL8ZIbRarD6AmwZFKugIXnb8yrGLL1fBy2fXmWlDyZjzLlw
	 SFKMwNgWymUz6Z+kwj1SLhm4nTA3xmNvEWcQ/okycXXbcBb3tvtalUkc9bvut9ioXl
	 p8PHEPfZa+DZD3Sa5naah6C+fo3+h5YtsIgbYFRohWYSgrrlACIQ5cGGApdO106mkT
	 CmDlSOhhaeCBt5jshyEjcKtYKfZZn7uX3gTEMl/rKJI3AuslvFKOGCBu2PIg5A4vmQ
	 ivis9oBvVE2hg==
Date: Fri, 26 Jan 2024 17:53:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-bcache@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
	Coly Li <colyli@suse.de>
Subject: Re: [PATCH 4/5] time_stats: Promote to lib/
Message-ID: <20240127015352.GB6184@frogsfrogsfrogs>
References: <20240126220655.395093-1-kent.overstreet@linux.dev>
 <20240126220655.395093-4-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126220655.395093-4-kent.overstreet@linux.dev>

On Fri, Jan 26, 2024 at 05:06:54PM -0500, Kent Overstreet wrote:
> Library code from bcachefs for tracking latency measurements.
> 
> The main interface is
>   time_stats_update(stats, start_time);
> 
> which collects a new event with an end time of the current time.
> 
> It features percpu buffering of input values, making it very low
> overhead, and nicely formatted output to printbufs or seq_buf.
> 
> Sample output, from the bcache conversion:
> 
> root@moria-kvm:/sys/fs/bcache/bdaedb8c-4554-4dd2-87e4-276e51eb47cc# cat internal/btree_sort_times
> count: 6414
>                        since mount        recent
> duration of events
>   min:                          440 ns
>   max:                         1102 us
>   total:                        674 ms
>   mean:                         105 us     102 us
>   stddev:                       101 us      88 us
> time between events
>   min:                          881 ns
>   max:                            3 s
>   mean:                           7 ms       6 ms
>   stddev:                        52 ms       6 ms
> 
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Coly Li <colyli@suse.de>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Hmm.  Ok, so, if I wanted to report timestats information for, say,
xfs_log_reserve, I would do ... what?

Embed a struct time_stats into struct xlog;

Call time_stats_init on it when we create the xlog object (and
time_stats_exit when we're tearing down the log)

Then, in xfs_log_reserve, we'd do something like:

	u64	start_time;

	...

	trace_xfs_log_reserve(log, tic);
	start_time = local_clock();				/* new */

	error = xlog_grant_head_check(log, &log->l_reserve_head, tic,
				      &need_bytes);
	if (error)
		goto out_error;

	xlog_grant_add_space(log, &log->l_reserve_head.grant, need_bytes);
	xlog_grant_add_space(log, &log->l_write_head.grant, need_bytes);
	trace_xfs_log_reserve_exit(log, tic);
	time_stats_update(&log->l_grant_stall, start_time);	/* new */
	xlog_verify_grant_tail(log);

And then we create a debugfs file somewhere and make its
xlog_grant_head_stall_read function do something along the lines of:

	char			buf[PAGE_SIZE];
	struct xlog		*xlog = file->private_data;

	seq_buf_init(&s, buf, sizeof(buf));
	time_stats_to_seq_buf(&s, &xlog->l_grant_stall);

	return simple_read_from_buffer(ubuf, count, ppos, buf,
			seq_buf_used(&s));

This will get us a report of the number of times we've added to the
reserve and write heads; various stats about how much time we've spent
waiting for the grants, and how much time goes by between the two?

The mean time between events might be much more useful for tracking time
between online repair events though.

Or, we could put a couple of these into struct xfs_perag for the AGF and
AGI buffers and use track_event_change to keep track of the time spent
with the AGF/AGI locked vs. unlocked.  Maybe it would be more useful to
track the time that the AG[FI] buffer locks are contended, vs. merely
held by someone in the system.

If my understanding of all this is correct, then this looks promising
for augmenting pcp a bit;
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/bcachefs/Kconfig                 |   2 +-
>  fs/bcachefs/alloc_foreground.c      |  13 +-
>  fs/bcachefs/bcachefs.h              |  11 +-
>  fs/bcachefs/btree_cache.c           |   2 +-
>  fs/bcachefs/btree_gc.c              |   2 +-
>  fs/bcachefs/btree_io.c              |   8 +-
>  fs/bcachefs/btree_iter.c            |   8 +-
>  fs/bcachefs/btree_locking.h         |   2 +-
>  fs/bcachefs/btree_update_interior.c |   8 +-
>  fs/bcachefs/io_read.c               |   4 +-
>  fs/bcachefs/io_write.c              |   4 +-
>  fs/bcachefs/journal.c               |   5 +-
>  fs/bcachefs/journal_io.c            |   5 +-
>  fs/bcachefs/journal_reclaim.c       |   9 +-
>  fs/bcachefs/journal_types.h         |  11 +-
>  fs/bcachefs/nocow_locking.c         |   2 +-
>  fs/bcachefs/super.c                 |  12 +-
>  fs/bcachefs/util.c                  | 262 +--------------------------
>  fs/bcachefs/util.h                  |  83 +--------
>  include/linux/time_stats.h          | 134 ++++++++++++++
>  lib/Kconfig                         |   4 +
>  lib/Makefile                        |   2 +
>  lib/time_stats.c                    | 264 ++++++++++++++++++++++++++++
>  23 files changed, 455 insertions(+), 402 deletions(-)
>  create mode 100644 include/linux/time_stats.h
>  create mode 100644 lib/time_stats.c
> 
> diff --git a/fs/bcachefs/Kconfig b/fs/bcachefs/Kconfig
> index 72d1179262b3..8c587ddd2f85 100644
> --- a/fs/bcachefs/Kconfig
> +++ b/fs/bcachefs/Kconfig
> @@ -24,7 +24,7 @@ config BCACHEFS_FS
>  	select XXHASH
>  	select SRCU
>  	select SYMBOLIC_ERRNAME
> -	select MEAN_AND_VARIANCE
> +	select TIME_STATS
>  	help
>  	The bcachefs filesystem - a modern, copy on write filesystem, with
>  	support for multiple devices, compression, checksumming, etc.
> diff --git a/fs/bcachefs/alloc_foreground.c b/fs/bcachefs/alloc_foreground.c
> index 633d3223b353..ca58193dd902 100644
> --- a/fs/bcachefs/alloc_foreground.c
> +++ b/fs/bcachefs/alloc_foreground.c
> @@ -236,8 +236,7 @@ static struct open_bucket *__try_alloc_bucket(struct bch_fs *c, struct bch_dev *
>  		if (cl)
>  			closure_wait(&c->open_buckets_wait, cl);
>  
> -		track_event_change(&c->times[BCH_TIME_blocked_allocate_open_bucket],
> -				   &c->blocked_allocate_open_bucket, true);
> +		track_event_change(&c->times[BCH_TIME_blocked_allocate_open_bucket], true);
>  		spin_unlock(&c->freelist_lock);
>  		return ERR_PTR(-BCH_ERR_open_buckets_empty);
>  	}
> @@ -263,11 +262,8 @@ static struct open_bucket *__try_alloc_bucket(struct bch_fs *c, struct bch_dev *
>  	ca->nr_open_buckets++;
>  	bch2_open_bucket_hash_add(c, ob);
>  
> -	track_event_change(&c->times[BCH_TIME_blocked_allocate_open_bucket],
> -			   &c->blocked_allocate_open_bucket, false);
> -
> -	track_event_change(&c->times[BCH_TIME_blocked_allocate],
> -			   &c->blocked_allocate, false);
> +	track_event_change(&c->times[BCH_TIME_blocked_allocate_open_bucket], false);
> +	track_event_change(&c->times[BCH_TIME_blocked_allocate], false);
>  
>  	spin_unlock(&c->freelist_lock);
>  	return ob;
> @@ -555,8 +551,7 @@ static struct open_bucket *bch2_bucket_alloc_trans(struct btree_trans *trans,
>  			goto again;
>  		}
>  
> -		track_event_change(&c->times[BCH_TIME_blocked_allocate],
> -				   &c->blocked_allocate, true);
> +		track_event_change(&c->times[BCH_TIME_blocked_allocate], true);
>  
>  		ob = ERR_PTR(-BCH_ERR_freelist_empty);
>  		goto err;
> diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
> index b80c6c9efd8c..81070ee618bb 100644
> --- a/fs/bcachefs/bcachefs.h
> +++ b/fs/bcachefs/bcachefs.h
> @@ -200,6 +200,7 @@
>  #include <linux/seqlock.h>
>  #include <linux/shrinker.h>
>  #include <linux/srcu.h>
> +#include <linux/time_stats.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  #include <linux/zstd.h>
> @@ -593,7 +594,7 @@ struct bch_dev {
>  
>  	/* The rest of this all shows up in sysfs */
>  	atomic64_t		cur_latency[2];
> -	struct bch2_time_stats	io_latency[2];
> +	struct time_stats	io_latency[2];
>  
>  #define CONGESTED_MAX		1024
>  	atomic_t		congested;
> @@ -640,8 +641,8 @@ struct btree_debug {
>  #define BCH_TRANSACTIONS_NR 128
>  
>  struct btree_transaction_stats {
> -	struct bch2_time_stats	duration;
> -	struct bch2_time_stats	lock_hold_times;
> +	struct time_stats	duration;
> +	struct time_stats	lock_hold_times;
>  	struct mutex		lock;
>  	unsigned		nr_max_paths;
>  	unsigned		journal_entries_size;
> @@ -919,8 +920,6 @@ struct bch_fs {
>  	/* ALLOCATOR */
>  	spinlock_t		freelist_lock;
>  	struct closure_waitlist	freelist_wait;
> -	u64			blocked_allocate;
> -	u64			blocked_allocate_open_bucket;
>  
>  	open_bucket_idx_t	open_buckets_freelist;
>  	open_bucket_idx_t	open_buckets_nr_free;
> @@ -1104,7 +1103,7 @@ struct bch_fs {
>  	unsigned		copy_gc_enabled:1;
>  	bool			promote_whole_extents;
>  
> -	struct bch2_time_stats	times[BCH_TIME_STAT_NR];
> +	struct time_stats	times[BCH_TIME_STAT_NR];
>  
>  	struct btree_transaction_stats btree_transaction_stats[BCH_TRANSACTIONS_NR];
>  
> diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
> index d7c81beac14a..8b3c04fc406f 100644
> --- a/fs/bcachefs/btree_cache.c
> +++ b/fs/bcachefs/btree_cache.c
> @@ -648,7 +648,7 @@ struct btree *bch2_btree_node_mem_alloc(struct btree_trans *trans, bool pcpu_rea
>  	bch2_btree_keys_init(b);
>  	set_btree_node_accessed(b);
>  
> -	bch2_time_stats_update(&c->times[BCH_TIME_btree_node_mem_alloc],
> +	time_stats_update(&c->times[BCH_TIME_btree_node_mem_alloc],
>  			       start_time);
>  
>  	memalloc_nofs_restore(flags);
> diff --git a/fs/bcachefs/btree_gc.c b/fs/bcachefs/btree_gc.c
> index 1102995643b1..774df395e4c7 100644
> --- a/fs/bcachefs/btree_gc.c
> +++ b/fs/bcachefs/btree_gc.c
> @@ -1970,7 +1970,7 @@ int bch2_gc_gens(struct bch_fs *c)
>  
>  	c->gc_count++;
>  
> -	bch2_time_stats_update(&c->times[BCH_TIME_btree_gc], start_time);
> +	time_stats_update(&c->times[BCH_TIME_btree_gc], start_time);
>  	trace_and_count(c, gc_gens_end, c);
>  err:
>  	for_each_member_device(c, ca) {
> diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
> index aa9b6cbe3226..a56dcabb7ace 100644
> --- a/fs/bcachefs/btree_io.c
> +++ b/fs/bcachefs/btree_io.c
> @@ -327,7 +327,7 @@ static void btree_node_sort(struct bch_fs *c, struct btree *b,
>  	BUG_ON(vstruct_end(&out->keys) > (void *) out + bytes);
>  
>  	if (sorting_entire_node)
> -		bch2_time_stats_update(&c->times[BCH_TIME_btree_node_sort],
> +		time_stats_update(&c->times[BCH_TIME_btree_node_sort],
>  				       start_time);
>  
>  	/* Make sure we preserve bset journal_seq: */
> @@ -397,7 +397,7 @@ void bch2_btree_sort_into(struct bch_fs *c,
>  			&dst->format,
>  			true);
>  
> -	bch2_time_stats_update(&c->times[BCH_TIME_btree_node_sort],
> +	time_stats_update(&c->times[BCH_TIME_btree_node_sort],
>  			       start_time);
>  
>  	set_btree_bset_end(dst, dst->set);
> @@ -1251,7 +1251,7 @@ int bch2_btree_node_read_done(struct bch_fs *c, struct bch_dev *ca,
>  out:
>  	mempool_free(iter, &c->fill_iter);
>  	printbuf_exit(&buf);
> -	bch2_time_stats_update(&c->times[BCH_TIME_btree_node_read_done], start_time);
> +	time_stats_update(&c->times[BCH_TIME_btree_node_read_done], start_time);
>  	return retry_read;
>  fsck_err:
>  	if (ret == -BCH_ERR_btree_node_read_err_want_retry ||
> @@ -1323,7 +1323,7 @@ static void btree_node_read_work(struct work_struct *work)
>  		}
>  	}
>  
> -	bch2_time_stats_update(&c->times[BCH_TIME_btree_node_read],
> +	time_stats_update(&c->times[BCH_TIME_btree_node_read],
>  			       rb->start_time);
>  	bio_put(&rb->bio);
>  
> diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
> index 5467a8635be1..f2d7b1dabcfb 100644
> --- a/fs/bcachefs/btree_iter.c
> +++ b/fs/bcachefs/btree_iter.c
> @@ -2899,7 +2899,7 @@ u32 bch2_trans_begin(struct btree_trans *trans)
>  
>  	if (!IS_ENABLED(CONFIG_BCACHEFS_NO_LATENCY_ACCT) &&
>  	    time_after64(now, trans->last_begin_time + 10))
> -		__bch2_time_stats_update(&btree_trans_stats(trans)->duration,
> +		__time_stats_update(&btree_trans_stats(trans)->duration,
>  					 trans->last_begin_time, now);
>  
>  	if (!trans->restarted &&
> @@ -3224,7 +3224,7 @@ void bch2_fs_btree_iter_exit(struct bch_fs *c)
>  	     s < c->btree_transaction_stats + ARRAY_SIZE(c->btree_transaction_stats);
>  	     s++) {
>  		kfree(s->max_paths_text);
> -		bch2_time_stats_exit(&s->lock_hold_times);
> +		time_stats_exit(&s->lock_hold_times);
>  	}
>  
>  	if (c->btree_trans_barrier_initialized)
> @@ -3240,8 +3240,8 @@ void bch2_fs_btree_iter_init_early(struct bch_fs *c)
>  	for (s = c->btree_transaction_stats;
>  	     s < c->btree_transaction_stats + ARRAY_SIZE(c->btree_transaction_stats);
>  	     s++) {
> -		bch2_time_stats_init(&s->duration);
> -		bch2_time_stats_init(&s->lock_hold_times);
> +		time_stats_init(&s->duration);
> +		time_stats_init(&s->lock_hold_times);
>  		mutex_init(&s->lock);
>  	}
>  
> diff --git a/fs/bcachefs/btree_locking.h b/fs/bcachefs/btree_locking.h
> index 4bd72c855da1..f2e2c5881b7e 100644
> --- a/fs/bcachefs/btree_locking.h
> +++ b/fs/bcachefs/btree_locking.h
> @@ -122,7 +122,7 @@ static void btree_trans_lock_hold_time_update(struct btree_trans *trans,
>  					      struct btree_path *path, unsigned level)
>  {
>  #ifdef CONFIG_BCACHEFS_LOCK_TIME_STATS
> -	__bch2_time_stats_update(&btree_trans_stats(trans)->lock_hold_times,
> +	__time_stats_update(&btree_trans_stats(trans)->lock_hold_times,
>  				 path->l[level].lock_taken_time,
>  				 local_clock());
>  #endif
> diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_update_interior.c
> index 17a5938aa71a..94b5df7c3d4d 100644
> --- a/fs/bcachefs/btree_update_interior.c
> +++ b/fs/bcachefs/btree_update_interior.c
> @@ -516,7 +516,7 @@ static void bch2_btree_update_free(struct btree_update *as, struct btree_trans *
>  	bch2_disk_reservation_put(c, &as->disk_res);
>  	bch2_btree_reserve_put(as, trans);
>  
> -	bch2_time_stats_update(&c->times[BCH_TIME_btree_interior_update_total],
> +	time_stats_update(&c->times[BCH_TIME_btree_interior_update_total],
>  			       as->start_time);
>  
>  	mutex_lock(&c->btree_interior_update_lock);
> @@ -1038,7 +1038,7 @@ static void bch2_btree_update_done(struct btree_update *as, struct btree_trans *
>  	continue_at(&as->cl, btree_update_set_nodes_written,
>  		    as->c->btree_interior_update_worker);
>  
> -	bch2_time_stats_update(&c->times[BCH_TIME_btree_interior_update_foreground],
> +	time_stats_update(&c->times[BCH_TIME_btree_interior_update_foreground],
>  			       start_time);
>  }
>  
> @@ -1629,7 +1629,7 @@ static int btree_split(struct btree_update *as, struct btree_trans *trans,
>  
>  	bch2_trans_verify_locks(trans);
>  
> -	bch2_time_stats_update(&c->times[n2
> +	time_stats_update(&c->times[n2
>  			       ? BCH_TIME_btree_node_split
>  			       : BCH_TIME_btree_node_compact],
>  			       start_time);
> @@ -1935,7 +1935,7 @@ int __bch2_foreground_maybe_merge(struct btree_trans *trans,
>  
>  	bch2_btree_update_done(as, trans);
>  
> -	bch2_time_stats_update(&c->times[BCH_TIME_btree_node_merge], start_time);
> +	time_stats_update(&c->times[BCH_TIME_btree_node_merge], start_time);
>  out:
>  err:
>  	if (new_path)
> diff --git a/fs/bcachefs/io_read.c b/fs/bcachefs/io_read.c
> index 3c574d8873a1..dce136cd2271 100644
> --- a/fs/bcachefs/io_read.c
> +++ b/fs/bcachefs/io_read.c
> @@ -134,7 +134,7 @@ static void promote_done(struct bch_write_op *wop)
>  		container_of(wop, struct promote_op, write.op);
>  	struct bch_fs *c = op->write.op.c;
>  
> -	bch2_time_stats_update(&c->times[BCH_TIME_data_promote],
> +	time_stats_update(&c->times[BCH_TIME_data_promote],
>  			       op->start_time);
>  	promote_free(c, op);
>  }
> @@ -356,7 +356,7 @@ static inline struct bch_read_bio *bch2_rbio_free(struct bch_read_bio *rbio)
>  static void bch2_rbio_done(struct bch_read_bio *rbio)
>  {
>  	if (rbio->start_time)
> -		bch2_time_stats_update(&rbio->c->times[BCH_TIME_data_read],
> +		time_stats_update(&rbio->c->times[BCH_TIME_data_read],
>  				       rbio->start_time);
>  	bio_endio(&rbio->bio);
>  }
> diff --git a/fs/bcachefs/io_write.c b/fs/bcachefs/io_write.c
> index ef3a53f9045a..a1859cc326b3 100644
> --- a/fs/bcachefs/io_write.c
> +++ b/fs/bcachefs/io_write.c
> @@ -88,7 +88,7 @@ void bch2_latency_acct(struct bch_dev *ca, u64 submit_time, int rw)
>  
>  	bch2_congested_acct(ca, io_latency, now, rw);
>  
> -	__bch2_time_stats_update(&ca->io_latency[rw], submit_time, now);
> +	__time_stats_update(&ca->io_latency[rw], submit_time, now);
>  }
>  
>  #endif
> @@ -457,7 +457,7 @@ static void bch2_write_done(struct closure *cl)
>  
>  	EBUG_ON(op->open_buckets.nr);
>  
> -	bch2_time_stats_update(&c->times[BCH_TIME_data_write], op->start_time);
> +	time_stats_update(&c->times[BCH_TIME_data_write], op->start_time);
>  	bch2_disk_reservation_put(c, &op->res);
>  
>  	if (!(op->flags & BCH_WRITE_MOVE))
> diff --git a/fs/bcachefs/journal.c b/fs/bcachefs/journal.c
> index bc890776eb57..c5d6cc29be87 100644
> --- a/fs/bcachefs/journal.c
> +++ b/fs/bcachefs/journal.c
> @@ -518,8 +518,7 @@ static int __journal_res_get(struct journal *j, struct journal_res *res,
>  	ret = journal_entry_open(j);
>  
>  	if (ret == JOURNAL_ERR_max_in_flight) {
> -		track_event_change(&c->times[BCH_TIME_blocked_journal_max_in_flight],
> -				   &j->max_in_flight_start, true);
> +		track_event_change(&c->times[BCH_TIME_blocked_journal_max_in_flight], true);
>  		if (trace_journal_entry_full_enabled()) {
>  			struct printbuf buf = PRINTBUF;
>  			buf.atomic++;
> @@ -727,7 +726,7 @@ int bch2_journal_flush_seq(struct journal *j, u64 seq)
>  	ret = wait_event_interruptible(j->wait, (ret2 = bch2_journal_flush_seq_async(j, seq, NULL)));
>  
>  	if (!ret)
> -		bch2_time_stats_update(j->flush_seq_time, start_time);
> +		time_stats_update(j->flush_seq_time, start_time);
>  
>  	return ret ?: ret2 < 0 ? ret2 : 0;
>  }
> diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
> index bfd6585e746d..4bd78776f0d4 100644
> --- a/fs/bcachefs/journal_io.c
> +++ b/fs/bcachefs/journal_io.c
> @@ -1574,7 +1574,7 @@ static CLOSURE_CALLBACK(journal_write_done)
>  	u64 v, seq;
>  	int err = 0;
>  
> -	bch2_time_stats_update(!JSET_NO_FLUSH(w->data)
> +	time_stats_update(!JSET_NO_FLUSH(w->data)
>  			       ? j->flush_write_time
>  			       : j->noflush_write_time, j->write_start_time);
>  
> @@ -1637,8 +1637,7 @@ static CLOSURE_CALLBACK(journal_write_done)
>  	bch2_journal_reclaim_fast(j);
>  	bch2_journal_space_available(j);
>  
> -	track_event_change(&c->times[BCH_TIME_blocked_journal_max_in_flight],
> -			   &j->max_in_flight_start, false);
> +	track_event_change(&c->times[BCH_TIME_blocked_journal_max_in_flight], false);
>  
>  	closure_wake_up(&w->wait);
>  	journal_wake(j);
> diff --git a/fs/bcachefs/journal_reclaim.c b/fs/bcachefs/journal_reclaim.c
> index 820d25e19e5f..00f7f8199301 100644
> --- a/fs/bcachefs/journal_reclaim.c
> +++ b/fs/bcachefs/journal_reclaim.c
> @@ -62,12 +62,9 @@ void bch2_journal_set_watermark(struct journal *j)
>  		? BCH_WATERMARK_reclaim
>  		: BCH_WATERMARK_stripe;
>  
> -	if (track_event_change(&c->times[BCH_TIME_blocked_journal_low_on_space],
> -			       &j->low_on_space_start, low_on_space) ||
> -	    track_event_change(&c->times[BCH_TIME_blocked_journal_low_on_pin],
> -			       &j->low_on_pin_start, low_on_pin) ||
> -	    track_event_change(&c->times[BCH_TIME_blocked_write_buffer_full],
> -			       &j->write_buffer_full_start, low_on_wb))
> +	if (track_event_change(&c->times[BCH_TIME_blocked_journal_low_on_space], low_on_space) ||
> +	    track_event_change(&c->times[BCH_TIME_blocked_journal_low_on_pin], low_on_pin) ||
> +	    track_event_change(&c->times[BCH_TIME_blocked_write_buffer_full], low_on_wb))
>  		trace_and_count(c, journal_full, c);
>  
>  	swap(watermark, j->watermark);
> diff --git a/fs/bcachefs/journal_types.h b/fs/bcachefs/journal_types.h
> index 38817c7a0851..b93e02c0a178 100644
> --- a/fs/bcachefs/journal_types.h
> +++ b/fs/bcachefs/journal_types.h
> @@ -274,14 +274,9 @@ struct journal {
>  	u64			nr_noflush_writes;
>  	u64			entry_bytes_written;
>  
> -	u64			low_on_space_start;
> -	u64			low_on_pin_start;
> -	u64			max_in_flight_start;
> -	u64			write_buffer_full_start;
> -
> -	struct bch2_time_stats	*flush_write_time;
> -	struct bch2_time_stats	*noflush_write_time;
> -	struct bch2_time_stats	*flush_seq_time;
> +	struct time_stats	*flush_write_time;
> +	struct time_stats	*noflush_write_time;
> +	struct time_stats	*flush_seq_time;
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	struct lockdep_map	res_map;
> diff --git a/fs/bcachefs/nocow_locking.c b/fs/bcachefs/nocow_locking.c
> index 3c21981a4a1c..181efa4a83fa 100644
> --- a/fs/bcachefs/nocow_locking.c
> +++ b/fs/bcachefs/nocow_locking.c
> @@ -85,7 +85,7 @@ void __bch2_bucket_nocow_lock(struct bucket_nocow_lock_table *t,
>  		u64 start_time = local_clock();
>  
>  		__closure_wait_event(&l->wait, __bch2_bucket_nocow_trylock(l, dev_bucket, flags));
> -		bch2_time_stats_update(&c->times[BCH_TIME_nocow_lock_contended], start_time);
> +		time_stats_update(&c->times[BCH_TIME_nocow_lock_contended], start_time);
>  	}
>  }
>  
> diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
> index e74534096cb5..6498c8cbab1d 100644
> --- a/fs/bcachefs/super.c
> +++ b/fs/bcachefs/super.c
> @@ -520,7 +520,7 @@ static void __bch2_fs_free(struct bch_fs *c)
>  	unsigned i;
>  
>  	for (i = 0; i < BCH_TIME_STAT_NR; i++)
> -		bch2_time_stats_exit(&c->times[i]);
> +		time_stats_exit(&c->times[i]);
>  
>  	bch2_free_pending_node_rewrites(c);
>  	bch2_fs_sb_errors_exit(c);
> @@ -753,7 +753,7 @@ static struct bch_fs *bch2_fs_alloc(struct bch_sb *sb, struct bch_opts opts)
>  	c->journal_keys.initial_ref_held = true;
>  
>  	for (i = 0; i < BCH_TIME_STAT_NR; i++)
> -		bch2_time_stats_init(&c->times[i]);
> +		time_stats_init(&c->times[i]);
>  
>  	bch2_fs_copygc_init(c);
>  	bch2_fs_btree_key_cache_init_early(&c->btree_key_cache);
> @@ -1168,8 +1168,8 @@ static void bch2_dev_free(struct bch_dev *ca)
>  	bch2_dev_buckets_free(ca);
>  	free_page((unsigned long) ca->sb_read_scratch);
>  
> -	bch2_time_stats_exit(&ca->io_latency[WRITE]);
> -	bch2_time_stats_exit(&ca->io_latency[READ]);
> +	time_stats_exit(&ca->io_latency[WRITE]);
> +	time_stats_exit(&ca->io_latency[READ]);
>  
>  	percpu_ref_exit(&ca->io_ref);
>  	percpu_ref_exit(&ca->ref);
> @@ -1260,8 +1260,8 @@ static struct bch_dev *__bch2_dev_alloc(struct bch_fs *c,
>  
>  	INIT_WORK(&ca->io_error_work, bch2_io_error_work);
>  
> -	bch2_time_stats_init(&ca->io_latency[READ]);
> -	bch2_time_stats_init(&ca->io_latency[WRITE]);
> +	time_stats_init(&ca->io_latency[READ]);
> +	time_stats_init(&ca->io_latency[WRITE]);
>  	ca->io_latency[READ].quantiles_enabled = true;
>  	ca->io_latency[WRITE].quantiles_enabled = true;
>  
> diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
> index f2c8550c1331..a4c37ec66f23 100644
> --- a/fs/bcachefs/util.c
> +++ b/fs/bcachefs/util.c
> @@ -337,32 +337,6 @@ void bch2_prt_datetime(struct printbuf *out, time64_t sec)
>  }
>  #endif
>  
> -static const struct time_unit {
> -	const char	*name;
> -	u64		nsecs;
> -} time_units[] = {
> -	{ "ns",		1		 },
> -	{ "us",		NSEC_PER_USEC	 },
> -	{ "ms",		NSEC_PER_MSEC	 },
> -	{ "s",		NSEC_PER_SEC	 },
> -	{ "m",          (u64) NSEC_PER_SEC * 60},
> -	{ "h",          (u64) NSEC_PER_SEC * 3600},
> -	{ "eon",        U64_MAX          },
> -};
> -
> -static const struct time_unit *pick_time_units(u64 ns)
> -{
> -	const struct time_unit *u;
> -
> -	for (u = time_units;
> -	     u + 1 < time_units + ARRAY_SIZE(time_units) &&
> -	     ns >= u[1].nsecs << 1;
> -	     u++)
> -		;
> -
> -	return u;
> -}
> -
>  void bch2_pr_time_units(struct printbuf *out, u64 ns)
>  {
>  	const struct time_unit *u = pick_time_units(ns);
> @@ -370,119 +344,7 @@ void bch2_pr_time_units(struct printbuf *out, u64 ns)
>  	prt_printf(out, "%llu %s", div_u64(ns, u->nsecs), u->name);
>  }
>  
> -/* time stats: */
> -
> -#ifndef CONFIG_BCACHEFS_NO_LATENCY_ACCT
> -static void bch2_quantiles_update(struct bch2_quantiles *q, u64 v)
> -{
> -	unsigned i = 0;
> -
> -	while (i < ARRAY_SIZE(q->entries)) {
> -		struct bch2_quantile_entry *e = q->entries + i;
> -
> -		if (unlikely(!e->step)) {
> -			e->m = v;
> -			e->step = max_t(unsigned, v / 2, 1024);
> -		} else if (e->m > v) {
> -			e->m = e->m >= e->step
> -				? e->m - e->step
> -				: 0;
> -		} else if (e->m < v) {
> -			e->m = e->m + e->step > e->m
> -				? e->m + e->step
> -				: U32_MAX;
> -		}
> -
> -		if ((e->m > v ? e->m - v : v - e->m) < e->step)
> -			e->step = max_t(unsigned, e->step / 2, 1);
> -
> -		if (v >= e->m)
> -			break;
> -
> -		i = eytzinger0_child(i, v > e->m);
> -	}
> -}
> -
> -static inline void bch2_time_stats_update_one(struct bch2_time_stats *stats,
> -					      u64 start, u64 end)
> -{
> -	u64 duration, freq;
> -
> -	if (time_after64(end, start)) {
> -		duration = end - start;
> -		mean_and_variance_update(&stats->duration_stats, duration);
> -		mean_and_variance_weighted_update(&stats->duration_stats_weighted, duration);
> -		stats->max_duration = max(stats->max_duration, duration);
> -		stats->min_duration = min(stats->min_duration, duration);
> -		stats->total_duration += duration;
> -		bch2_quantiles_update(&stats->quantiles, duration);
> -	}
> -
> -	if (time_after64(end, stats->last_event)) {
> -		freq = end - stats->last_event;
> -		mean_and_variance_update(&stats->freq_stats, freq);
> -		mean_and_variance_weighted_update(&stats->freq_stats_weighted, freq);
> -		stats->max_freq = max(stats->max_freq, freq);
> -		stats->min_freq = min(stats->min_freq, freq);
> -		stats->last_event = end;
> -	}
> -}
> -
> -static void __bch2_time_stats_clear_buffer(struct bch2_time_stats *stats,
> -					   struct bch2_time_stat_buffer *b)
> -{
> -	for (struct bch2_time_stat_buffer_entry *i = b->entries;
> -	     i < b->entries + ARRAY_SIZE(b->entries);
> -	     i++)
> -		bch2_time_stats_update_one(stats, i->start, i->end);
> -	b->nr = 0;
> -}
> -
> -static noinline void bch2_time_stats_clear_buffer(struct bch2_time_stats *stats,
> -						  struct bch2_time_stat_buffer *b)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&stats->lock, flags);
> -	__bch2_time_stats_clear_buffer(stats, b);
> -	spin_unlock_irqrestore(&stats->lock, flags);
> -}
> -
> -void __bch2_time_stats_update(struct bch2_time_stats *stats, u64 start, u64 end)
> -{
> -	unsigned long flags;
> -
> -	WARN_ONCE(!stats->duration_stats_weighted.weight ||
> -		  !stats->freq_stats_weighted.weight,
> -		  "uninitialized time_stats");
> -
> -	if (!stats->buffer) {
> -		spin_lock_irqsave(&stats->lock, flags);
> -		bch2_time_stats_update_one(stats, start, end);
> -
> -		if (mean_and_variance_weighted_get_mean(stats->freq_stats_weighted) < 32 &&
> -		    stats->duration_stats.n > 1024)
> -			stats->buffer =
> -				alloc_percpu_gfp(struct bch2_time_stat_buffer,
> -						 GFP_ATOMIC);
> -		spin_unlock_irqrestore(&stats->lock, flags);
> -	} else {
> -		struct bch2_time_stat_buffer *b;
> -
> -		preempt_disable();
> -		b = this_cpu_ptr(stats->buffer);
> -
> -		BUG_ON(b->nr >= ARRAY_SIZE(b->entries));
> -		b->entries[b->nr++] = (struct bch2_time_stat_buffer_entry) {
> -			.start = start,
> -			.end = end
> -		};
> -
> -		if (unlikely(b->nr == ARRAY_SIZE(b->entries)))
> -			bch2_time_stats_clear_buffer(stats, b);
> -		preempt_enable();
> -	}
> -}
> +/* time stats: printbuf output */
>  
>  static void bch2_pr_time_units_aligned(struct printbuf *out, u64 ns)
>  {
> @@ -503,7 +365,7 @@ static inline void pr_name_and_units(struct printbuf *out, const char *name, u64
>  
>  #define TABSTOP_SIZE 12
>  
> -void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats)
> +void bch2_time_stats_to_text(struct printbuf *out, struct time_stats *stats)
>  {
>  	s64 f_mean = 0, d_mean = 0;
>  	u64 f_stddev = 0, d_stddev = 0;
> @@ -513,7 +375,7 @@ void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats
>  
>  		spin_lock_irq(&stats->lock);
>  		for_each_possible_cpu(cpu)
> -			__bch2_time_stats_clear_buffer(stats, per_cpu_ptr(stats->buffer, cpu));
> +			__time_stats_clear_buffer(stats, per_cpu_ptr(stats->buffer, cpu));
>  		spin_unlock_irq(&stats->lock);
>  	}
>  
> @@ -624,124 +486,6 @@ void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats
>  	}
>  }
>  
> -#include <linux/seq_buf.h>
> -
> -static void seq_buf_time_units_aligned(struct seq_buf *out, u64 ns)
> -{
> -	const struct time_unit *u = pick_time_units(ns);
> -
> -	seq_buf_printf(out, "%8llu %s", div64_u64(ns, u->nsecs), u->name);
> -}
> -
> -void bch2_time_stats_to_seq_buf(struct seq_buf *out, struct bch2_time_stats *stats)
> -{
> -	s64 f_mean = 0, d_mean = 0;
> -	u64 f_stddev = 0, d_stddev = 0;
> -
> -	if (stats->buffer) {
> -		int cpu;
> -
> -		spin_lock_irq(&stats->lock);
> -		for_each_possible_cpu(cpu)
> -			__bch2_time_stats_clear_buffer(stats, per_cpu_ptr(stats->buffer, cpu));
> -		spin_unlock_irq(&stats->lock);
> -	}
> -
> -	/*
> -	 * avoid divide by zero
> -	 */
> -	if (stats->freq_stats.n) {
> -		f_mean = mean_and_variance_get_mean(stats->freq_stats);
> -		f_stddev = mean_and_variance_get_stddev(stats->freq_stats);
> -		d_mean = mean_and_variance_get_mean(stats->duration_stats);
> -		d_stddev = mean_and_variance_get_stddev(stats->duration_stats);
> -	}
> -
> -	seq_buf_printf(out, "count: %llu\n", stats->duration_stats.n);
> -
> -	seq_buf_printf(out, "                       since mount        recent\n");
> -
> -	seq_buf_printf(out, "duration of events\n");
> -
> -	seq_buf_printf(out, "  min:                     ");
> -	seq_buf_time_units_aligned(out, stats->min_duration);
> -	seq_buf_printf(out, "\n");
> -
> -	seq_buf_printf(out, "  max:                     ");
> -	seq_buf_time_units_aligned(out, stats->max_duration);
> -	seq_buf_printf(out, "\n");
> -
> -	seq_buf_printf(out, "  total:                   ");
> -	seq_buf_time_units_aligned(out, stats->total_duration);
> -	seq_buf_printf(out, "\n");
> -
> -	seq_buf_printf(out, "  mean:                    ");
> -	seq_buf_time_units_aligned(out, d_mean);
> -	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->duration_stats_weighted));
> -	seq_buf_printf(out, "\n");
> -
> -	seq_buf_printf(out, "  stddev:                  ");
> -	seq_buf_time_units_aligned(out, d_stddev);
> -	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->duration_stats_weighted));
> -	seq_buf_printf(out, "\n");
> -
> -	seq_buf_printf(out, "time between events\n");
> -
> -	seq_buf_printf(out, "  min:                     ");
> -	seq_buf_time_units_aligned(out, stats->min_freq);
> -	seq_buf_printf(out, "\n");
> -
> -	seq_buf_printf(out, "  max:                     ");
> -	seq_buf_time_units_aligned(out, stats->max_freq);
> -	seq_buf_printf(out, "\n");
> -
> -	seq_buf_printf(out, "  mean:                    ");
> -	seq_buf_time_units_aligned(out, f_mean);
> -	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->freq_stats_weighted));
> -	seq_buf_printf(out, "\n");
> -
> -	seq_buf_printf(out, "  stddev:                  ");
> -	seq_buf_time_units_aligned(out, f_stddev);
> -	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted));
> -	seq_buf_printf(out, "\n");
> -
> -	if (stats->quantiles_enabled) {
> -		int i = eytzinger0_first(NR_QUANTILES);
> -		const struct time_unit *u =
> -			pick_time_units(stats->quantiles.entries[i].m);
> -		u64 last_q = 0;
> -
> -		prt_printf(out, "quantiles (%s):\t", u->name);
> -		eytzinger0_for_each(i, NR_QUANTILES) {
> -			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
> -
> -			u64 q = max(stats->quantiles.entries[i].m, last_q);
> -			seq_buf_printf(out, "%llu ", div_u64(q, u->nsecs));
> -			if (is_last)
> -				seq_buf_printf(out, "\n");
> -			last_q = q;
> -		}
> -	}
> -}
> -#else
> -void bch2_time_stats_to_text(struct printbuf *out, struct bch2_time_stats *stats) {}
> -#endif
> -
> -void bch2_time_stats_exit(struct bch2_time_stats *stats)
> -{
> -	free_percpu(stats->buffer);
> -}
> -
> -void bch2_time_stats_init(struct bch2_time_stats *stats)
> -{
> -	memset(stats, 0, sizeof(*stats));
> -	stats->duration_stats_weighted.weight = 8;
> -	stats->freq_stats_weighted.weight = 8;
> -	stats->min_duration = U64_MAX;
> -	stats->min_freq = U64_MAX;
> -	spin_lock_init(&stats->lock);
> -}
> -
>  /* ratelimit: */
>  
>  /**
> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
> index 7ff2d4fe26f6..cf8d16a91162 100644
> --- a/fs/bcachefs/util.h
> +++ b/fs/bcachefs/util.h
> @@ -15,6 +15,7 @@
>  #include <linux/preempt.h>
>  #include <linux/ratelimit.h>
>  #include <linux/slab.h>
> +#include <linux/time_stats.h>
>  #include <linux/vmalloc.h>
>  #include <linux/workqueue.h>
>  #include <linux/mean_and_variance.h>
> @@ -360,87 +361,7 @@ static inline void prt_bdevname(struct printbuf *out, struct block_device *bdev)
>  #endif
>  }
>  
> -#define NR_QUANTILES	15
> -#define QUANTILE_IDX(i)	inorder_to_eytzinger0(i, NR_QUANTILES)
> -#define QUANTILE_FIRST	eytzinger0_first(NR_QUANTILES)
> -#define QUANTILE_LAST	eytzinger0_last(NR_QUANTILES)
> -
> -struct bch2_quantiles {
> -	struct bch2_quantile_entry {
> -		u64	m;
> -		u64	step;
> -	}		entries[NR_QUANTILES];
> -};
> -
> -struct bch2_time_stat_buffer {
> -	unsigned	nr;
> -	struct bch2_time_stat_buffer_entry {
> -		u64	start;
> -		u64	end;
> -	}		entries[32];
> -};
> -
> -struct bch2_time_stats {
> -	spinlock_t	lock;
> -	bool		quantiles_enabled;
> -	/* all fields are in nanoseconds */
> -	u64             min_duration;
> -	u64		max_duration;
> -	u64		total_duration;
> -	u64             max_freq;
> -	u64             min_freq;
> -	u64		last_event;
> -	struct bch2_quantiles quantiles;
> -
> -	struct mean_and_variance	  duration_stats;
> -	struct mean_and_variance_weighted duration_stats_weighted;
> -	struct mean_and_variance	  freq_stats;
> -	struct mean_and_variance_weighted freq_stats_weighted;
> -	struct bch2_time_stat_buffer __percpu *buffer;
> -};
> -
> -#ifndef CONFIG_BCACHEFS_NO_LATENCY_ACCT
> -void __bch2_time_stats_update(struct bch2_time_stats *stats, u64, u64);
> -
> -static inline void bch2_time_stats_update(struct bch2_time_stats *stats, u64 start)
> -{
> -	__bch2_time_stats_update(stats, start, local_clock());
> -}
> -
> -static inline bool track_event_change(struct bch2_time_stats *stats,
> -				      u64 *start, bool v)
> -{
> -	if (v != !!*start) {
> -		if (!v) {
> -			bch2_time_stats_update(stats, *start);
> -			*start = 0;
> -		} else {
> -			*start = local_clock() ?: 1;
> -			return true;
> -		}
> -	}
> -
> -	return false;
> -}
> -#else
> -static inline void __bch2_time_stats_update(struct bch2_time_stats *stats, u64 start, u64 end) {}
> -static inline void bch2_time_stats_update(struct bch2_time_stats *stats, u64 start) {}
> -static inline bool track_event_change(struct bch2_time_stats *stats,
> -				      u64 *start, bool v)
> -{
> -	bool ret = v && !*start;
> -	*start = v;
> -	return ret;
> -}
> -#endif
> -
> -void bch2_time_stats_to_text(struct printbuf *, struct bch2_time_stats *);
> -
> -struct seq_buf;
> -void bch2_time_stats_to_seq_buf(struct seq_buf *, struct bch2_time_stats *);
> -
> -void bch2_time_stats_exit(struct bch2_time_stats *);
> -void bch2_time_stats_init(struct bch2_time_stats *);
> +void bch2_time_stats_to_text(struct printbuf *, struct time_stats *);
>  
>  #define ewma_add(ewma, val, weight)					\
>  ({									\
> diff --git a/include/linux/time_stats.h b/include/linux/time_stats.h
> new file mode 100644
> index 000000000000..caefa7aba65a
> --- /dev/null
> +++ b/include/linux/time_stats.h
> @@ -0,0 +1,134 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * time_stats - collect statistics on events that have a duration, with nicely
> + * formatted textual output on demand
> + *
> + * - percpu buffering of event collection: cheap enough to shotgun
> + *   everywhere without worrying about overhead
> + *
> + * tracks:
> + *  - number of events
> + *  - maximum event duration ever seen
> + *  - sum of all event durations
> + *  - average event duration, standard and weighted
> + *  - standard deviation of event durations, standard and weighted
> + * and analagous statistics for the frequency of events
> + *
> + * We provide both mean and weighted mean (exponentially weighted), and standard
> + * deviation and weighted standard deviation, to give an efficient-to-compute
> + * view of current behaviour versus. average behaviour - "did this event source
> + * just become wonky, or is this typical?".
> + *
> + * Particularly useful for tracking down latency issues.
> + */
> +#ifndef _LINUX_TIME_STATS_H
> +#define _LINUX_TIME_STATS_H
> +
> +#include <linux/mean_and_variance.h>
> +#include <linux/sched/clock.h>
> +#include <linux/spinlock_types.h>
> +
> +struct time_unit {
> +	const char	*name;
> +	u64		nsecs;
> +};
> +
> +/*
> + * given a nanosecond value, pick the preferred time units for printing:
> + */
> +const struct time_unit *pick_time_units(u64 ns);
> +
> +/*
> + * quantiles - do not use:
> + *
> + * Only enabled if time_stats->quantiles_enabled has been manually set - don't
> + * use in new code.
> + */
> +
> +#define NR_QUANTILES	15
> +#define QUANTILE_IDX(i)	inorder_to_eytzinger0(i, NR_QUANTILES)
> +#define QUANTILE_FIRST	eytzinger0_first(NR_QUANTILES)
> +#define QUANTILE_LAST	eytzinger0_last(NR_QUANTILES)
> +
> +struct quantiles {
> +	struct quantile_entry {
> +		u64	m;
> +		u64	step;
> +	}		entries[NR_QUANTILES];
> +};
> +
> +struct time_stat_buffer {
> +	unsigned	nr;
> +	struct time_stat_buffer_entry {
> +		u64	start;
> +		u64	end;
> +	}		entries[32];
> +};
> +
> +struct time_stats {
> +	spinlock_t	lock;
> +	bool		quantiles_enabled;
> +	/* all fields are in nanoseconds */
> +	u64             min_duration;
> +	u64		max_duration;
> +	u64		total_duration;
> +	u64             max_freq;
> +	u64             min_freq;
> +	u64		last_event;
> +	u64		last_event_start;
> +	struct quantiles quantiles;
> +
> +	struct mean_and_variance	  duration_stats;
> +	struct mean_and_variance_weighted duration_stats_weighted;
> +	struct mean_and_variance	  freq_stats;
> +	struct mean_and_variance_weighted freq_stats_weighted;
> +	struct time_stat_buffer __percpu *buffer;
> +};
> +
> +void __time_stats_clear_buffer(struct time_stats *, struct time_stat_buffer *);
> +void __time_stats_update(struct time_stats *stats, u64, u64);
> +
> +/**
> + * time_stats_update - collect a new event being tracked
> + *
> + * @stats	- time_stats to update
> + * @start	- start time of event, recorded with local_clock()
> + *
> + * The end duration of the event will be the current time
> + */
> +static inline void time_stats_update(struct time_stats *stats, u64 start)
> +{
> +	__time_stats_update(stats, start, local_clock());
> +}
> +
> +/**
> + * track_event_change - track state change events
> + *
> + * @stats	- time_stats to update
> + * @v		- new state, true or false
> + *
> + * Use this when tracking time stats for state changes, i.e. resource X becoming
> + * blocked/unblocked.
> + */
> +static inline bool track_event_change(struct time_stats *stats, bool v)
> +{
> +	if (v != !!stats->last_event_start) {
> +		if (!v) {
> +			time_stats_update(stats, stats->last_event_start);
> +			stats->last_event_start = 0;
> +		} else {
> +			stats->last_event_start = local_clock() ?: 1;
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +struct seq_buf;
> +void time_stats_to_seq_buf(struct seq_buf *, struct time_stats *);
> +
> +void time_stats_exit(struct time_stats *);
> +void time_stats_init(struct time_stats *);
> +
> +#endif /* _LINUX_TIME_STATS_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 5ddda7c2ed9b..3ba8b965f8c7 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -785,3 +785,7 @@ config POLYNOMIAL
>  
>  config FIRMWARE_TABLE
>  	bool
> +
> +config TIME_STATS
> +	tristate
> +	select MEAN_AND_VARIANCE
> diff --git a/lib/Makefile b/lib/Makefile
> index 6b09731d8e61..57858997c87a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -370,6 +370,8 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
>  
>  obj-$(CONFIG_PARMAN) += parman.o
>  
> +obj-$(CONFIG_TIME_STATS) += time_stats.o
> +
>  obj-y += group_cpus.o
>  
>  # GCC library routines
> diff --git a/lib/time_stats.c b/lib/time_stats.c
> new file mode 100644
> index 000000000000..a5b9f149e2c6
> --- /dev/null
> +++ b/lib/time_stats.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/eytzinger.h>
> +#include <linux/jiffies.h>
> +#include <linux/percpu.h>
> +#include <linux/time.h>
> +#include <linux/time_stats.h>
> +#include <linux/spinlock.h>
> +
> +static const struct time_unit time_units[] = {
> +	{ "ns",		1		 },
> +	{ "us",		NSEC_PER_USEC	 },
> +	{ "ms",		NSEC_PER_MSEC	 },
> +	{ "s",		NSEC_PER_SEC	 },
> +	{ "m",          (u64) NSEC_PER_SEC * 60},
> +	{ "h",          (u64) NSEC_PER_SEC * 3600},
> +	{ "eon",        U64_MAX          },
> +};
> +
> +const struct time_unit *pick_time_units(u64 ns)
> +{
> +	const struct time_unit *u;
> +
> +	for (u = time_units;
> +	     u + 1 < time_units + ARRAY_SIZE(time_units) &&
> +	     ns >= u[1].nsecs << 1;
> +	     u++)
> +		;
> +
> +	return u;
> +}
> +
> +static void quantiles_update(struct quantiles *q, u64 v)
> +{
> +	unsigned i = 0;
> +
> +	while (i < ARRAY_SIZE(q->entries)) {
> +		struct quantile_entry *e = q->entries + i;
> +
> +		if (unlikely(!e->step)) {
> +			e->m = v;
> +			e->step = max_t(unsigned, v / 2, 1024);
> +		} else if (e->m > v) {
> +			e->m = e->m >= e->step
> +				? e->m - e->step
> +				: 0;
> +		} else if (e->m < v) {
> +			e->m = e->m + e->step > e->m
> +				? e->m + e->step
> +				: U32_MAX;
> +		}
> +
> +		if ((e->m > v ? e->m - v : v - e->m) < e->step)
> +			e->step = max_t(unsigned, e->step / 2, 1);
> +
> +		if (v >= e->m)
> +			break;
> +
> +		i = eytzinger0_child(i, v > e->m);
> +	}
> +}
> +
> +static inline void time_stats_update_one(struct time_stats *stats,
> +					      u64 start, u64 end)
> +{
> +	u64 duration, freq;
> +
> +	if (time_after64(end, start)) {
> +		duration = end - start;
> +		mean_and_variance_update(&stats->duration_stats, duration);
> +		mean_and_variance_weighted_update(&stats->duration_stats_weighted, duration);
> +		stats->max_duration = max(stats->max_duration, duration);
> +		stats->min_duration = min(stats->min_duration, duration);
> +		stats->total_duration += duration;
> +
> +		if (stats->quantiles_enabled)
> +			quantiles_update(&stats->quantiles, duration);
> +	}
> +
> +	if (time_after64(end, stats->last_event)) {
> +		freq = end - stats->last_event;
> +		mean_and_variance_update(&stats->freq_stats, freq);
> +		mean_and_variance_weighted_update(&stats->freq_stats_weighted, freq);
> +		stats->max_freq = max(stats->max_freq, freq);
> +		stats->min_freq = min(stats->min_freq, freq);
> +		stats->last_event = end;
> +	}
> +}
> +
> +void __time_stats_clear_buffer(struct time_stats *stats,
> +			       struct time_stat_buffer *b)
> +{
> +	for (struct time_stat_buffer_entry *i = b->entries;
> +	     i < b->entries + ARRAY_SIZE(b->entries);
> +	     i++)
> +		time_stats_update_one(stats, i->start, i->end);
> +	b->nr = 0;
> +}
> +EXPORT_SYMBOL_GPL(__time_stats_clear_buffer);
> +
> +static noinline void time_stats_clear_buffer(struct time_stats *stats,
> +					     struct time_stat_buffer *b)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&stats->lock, flags);
> +	__time_stats_clear_buffer(stats, b);
> +	spin_unlock_irqrestore(&stats->lock, flags);
> +}
> +
> +void __time_stats_update(struct time_stats *stats, u64 start, u64 end)
> +{
> +	unsigned long flags;
> +
> +	WARN_ONCE(!stats->duration_stats_weighted.weight ||
> +		  !stats->freq_stats_weighted.weight,
> +		  "uninitialized time_stats");
> +
> +	if (!stats->buffer) {
> +		spin_lock_irqsave(&stats->lock, flags);
> +		time_stats_update_one(stats, start, end);
> +
> +		if (mean_and_variance_weighted_get_mean(stats->freq_stats_weighted) < 32 &&
> +		    stats->duration_stats.n > 1024)
> +			stats->buffer =
> +				alloc_percpu_gfp(struct time_stat_buffer,
> +						 GFP_ATOMIC);
> +		spin_unlock_irqrestore(&stats->lock, flags);
> +	} else {
> +		struct time_stat_buffer *b;
> +
> +		preempt_disable();
> +		b = this_cpu_ptr(stats->buffer);
> +
> +		BUG_ON(b->nr >= ARRAY_SIZE(b->entries));
> +		b->entries[b->nr++] = (struct time_stat_buffer_entry) {
> +			.start = start,
> +			.end = end
> +		};
> +
> +		if (unlikely(b->nr == ARRAY_SIZE(b->entries)))
> +			time_stats_clear_buffer(stats, b);
> +		preempt_enable();
> +	}
> +}
> +EXPORT_SYMBOL_GPL(__time_stats_update);
> +
> +#include <linux/seq_buf.h>
> +
> +static void seq_buf_time_units_aligned(struct seq_buf *out, u64 ns)
> +{
> +	const struct time_unit *u = pick_time_units(ns);
> +
> +	seq_buf_printf(out, "%8llu %s", div64_u64(ns, u->nsecs), u->name);
> +}
> +
> +void time_stats_to_seq_buf(struct seq_buf *out, struct time_stats *stats)
> +{
> +	s64 f_mean = 0, d_mean = 0;
> +	u64 f_stddev = 0, d_stddev = 0;
> +
> +	if (stats->buffer) {
> +		int cpu;
> +
> +		spin_lock_irq(&stats->lock);
> +		for_each_possible_cpu(cpu)
> +			__time_stats_clear_buffer(stats, per_cpu_ptr(stats->buffer, cpu));
> +		spin_unlock_irq(&stats->lock);
> +	}
> +
> +	/*
> +	 * avoid divide by zero
> +	 */
> +	if (stats->freq_stats.n) {
> +		f_mean = mean_and_variance_get_mean(stats->freq_stats);
> +		f_stddev = mean_and_variance_get_stddev(stats->freq_stats);
> +		d_mean = mean_and_variance_get_mean(stats->duration_stats);
> +		d_stddev = mean_and_variance_get_stddev(stats->duration_stats);
> +	}
> +
> +	seq_buf_printf(out, "count: %llu\n", stats->duration_stats.n);
> +
> +	seq_buf_printf(out, "                       since mount        recent\n");
> +
> +	seq_buf_printf(out, "duration of events\n");
> +
> +	seq_buf_printf(out, "  min:                     ");
> +	seq_buf_time_units_aligned(out, stats->min_duration);
> +	seq_buf_printf(out, "\n");
> +
> +	seq_buf_printf(out, "  max:                     ");
> +	seq_buf_time_units_aligned(out, stats->max_duration);
> +	seq_buf_printf(out, "\n");
> +
> +	seq_buf_printf(out, "  total:                   ");
> +	seq_buf_time_units_aligned(out, stats->total_duration);
> +	seq_buf_printf(out, "\n");
> +
> +	seq_buf_printf(out, "  mean:                    ");
> +	seq_buf_time_units_aligned(out, d_mean);
> +	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->duration_stats_weighted));
> +	seq_buf_printf(out, "\n");
> +
> +	seq_buf_printf(out, "  stddev:                  ");
> +	seq_buf_time_units_aligned(out, d_stddev);
> +	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->duration_stats_weighted));
> +	seq_buf_printf(out, "\n");
> +
> +	seq_buf_printf(out, "time between events\n");
> +
> +	seq_buf_printf(out, "  min:                     ");
> +	seq_buf_time_units_aligned(out, stats->min_freq);
> +	seq_buf_printf(out, "\n");
> +
> +	seq_buf_printf(out, "  max:                     ");
> +	seq_buf_time_units_aligned(out, stats->max_freq);
> +	seq_buf_printf(out, "\n");
> +
> +	seq_buf_printf(out, "  mean:                    ");
> +	seq_buf_time_units_aligned(out, f_mean);
> +	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_mean(stats->freq_stats_weighted));
> +	seq_buf_printf(out, "\n");
> +
> +	seq_buf_printf(out, "  stddev:                  ");
> +	seq_buf_time_units_aligned(out, f_stddev);
> +	seq_buf_time_units_aligned(out, mean_and_variance_weighted_get_stddev(stats->freq_stats_weighted));
> +	seq_buf_printf(out, "\n");
> +
> +	if (stats->quantiles_enabled) {
> +		int i = eytzinger0_first(NR_QUANTILES);
> +		const struct time_unit *u =
> +			pick_time_units(stats->quantiles.entries[i].m);
> +		u64 last_q = 0;
> +
> +		seq_buf_printf(out, "quantiles (%s):\t", u->name);
> +		eytzinger0_for_each(i, NR_QUANTILES) {
> +			bool is_last = eytzinger0_next(i, NR_QUANTILES) == -1;
> +
> +			u64 q = max(stats->quantiles.entries[i].m, last_q);
> +			seq_buf_printf(out, "%llu ", div_u64(q, u->nsecs));
> +			if (is_last)
> +				seq_buf_printf(out, "\n");
> +			last_q = q;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(time_stats_to_seq_buf);
> +
> +void time_stats_exit(struct time_stats *stats)
> +{
> +	free_percpu(stats->buffer);
> +}
> +EXPORT_SYMBOL_GPL(time_stats_exit);
> +
> +void time_stats_init(struct time_stats *stats)
> +{
> +	memset(stats, 0, sizeof(*stats));
> +	stats->duration_stats_weighted.weight = 8;
> +	stats->freq_stats_weighted.weight = 8;
> +	stats->min_duration = U64_MAX;
> +	stats->min_freq = U64_MAX;
> +	spin_lock_init(&stats->lock);
> +}
> +EXPORT_SYMBOL_GPL(time_stats_init);
> -- 
> 2.43.0
> 
> 

