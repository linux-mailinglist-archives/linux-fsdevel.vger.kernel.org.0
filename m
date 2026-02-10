Return-Path: <linux-fsdevel+bounces-76766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFU+BBl2immmKgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:04:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C71115864
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28D03301E972
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200853EBF30;
	Tue, 10 Feb 2026 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6ZkybjV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAC8C1F;
	Tue, 10 Feb 2026 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770681871; cv=none; b=aIKR4oW3pY9FQx9ZU42ZZ8cR064yz4yTPHGJN1sWb7DSiBGocW0NYQJ8tIBI2UbeCFUcZiNLwfOxQA6yaGM9Tbi0RiIsKHoDfbsjUgKSxUeQ+U31IAGPQg8Qg6nOf1BgaSW4FpudL/QfigjWsNkGNadq2LmOeVdX09C5j6nzOhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770681871; c=relaxed/simple;
	bh=bXcydLhXbfRg8jbcHa6gdBu5FS8Uc0H1XE1uLH6XNBE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eimwLzHbMSi1Y49/mtC9o+fOPZOkW7d2iXYSMqutHI61Qgj89UA44AIdMArDGwp1XK+w9i9Xu3vyK7gUaUw5Ls/bJZU58yaTXUa7QqtVQs5GCTzV9Y4LadbIeMLBUKClmHYd1DoFF2WBbo+7e4k0TGmP3DR3V48SIhQFpBIbojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6ZkybjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C33C19425;
	Tue, 10 Feb 2026 00:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770681871;
	bh=bXcydLhXbfRg8jbcHa6gdBu5FS8Uc0H1XE1uLH6XNBE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=k6ZkybjVlY7fyGLjY4kIbmhYkrj3PpB9HwH6U4Dg83kuCwc5evQtDf23S2FKZzoih
	 XRQVfz3jE1l5/g7NVtt52eXNQTFHEFA26+Y94+lNbrTJXUnVDo8spCAEYyV+PjJO38
	 t9bIq+QV37miONonoFA0SXUetxySEDTTDt11j1CFGhWfA5yoLktZ8lNyjmxdzPCTTB
	 WRqtz98a5uKD+rKX5hz1RBimKA4/R6jD/oK7JGq0qaa8qraYXFY7pKx/84d6AfiPt1
	 Fb3TL0ZdkywC8NCFssK0MBP/7ipcTnm4b9p/tA7746tgtiZXsSRhHNKNQO2rLfdd+e
	 y2n4+MWSN9xRw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CC45BF4006C;
	Mon,  9 Feb 2026 19:04:29 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 09 Feb 2026 19:04:29 -0500
X-ME-Sender: <xms:DXaKaY2BvyXRP7-kLbGv-bU74T2-fhsQSJ_fzJLrlRpmArLgkFArmQ>
    <xme:DXaKad6qebDH28eWvem5Rs8VHMNUmR2U2RlZpnlXxgl5Pgj6JM_GcWC-fpkNpOB5i
    NbXyMBNMt-1srna8k8mEF8imNFadM09I9GKOr8wq5ytdOAtdRiyttdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleekvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghlvgigrdgrrh
    hinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohephhgthheslhhsthdruggvpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhr
    rggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehj
    rggtkhesshhushgvrdgtii
X-ME-Proxy: <xmx:DXaKadwIbWN1QcpAVdSvffwRD83G12OHhDJl_lXaxP4mnLTkLS2pCA>
    <xmx:DXaKaSe1sm6_e3PjXRmkKUSZnvCk-yaLpAoH8ItZNfM2ypCsAii-jQ>
    <xmx:DXaKaauzNqKjw--gnUEcAuY1xtVbYvik1yUx7P8LJRFFfUut76Ckrw>
    <xmx:DXaKafBgeMAmR8RlW6e_6Uubbf9ki7md-BwGC7evyR-Uc8x5aO8g4g>
    <xmx:DXaKaaF5FHrvQUwFREEXV67cFdiRip8nYRmN_OlJAtWnUmBg0mV8FwJZ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 92CC4780070; Mon,  9 Feb 2026 19:04:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5l7aiVFrsZV
Date: Mon, 09 Feb 2026 19:04:05 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>, "Alexander Aring" <alex.aring@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <e957053b-53d2-4291-afaa-d5dc08f8c44b@app.fastmail.com>
In-Reply-To: <20260209212618.366116-1-dai.ngo@oracle.com>
References: <20260209212618.366116-1-dai.ngo@oracle.com>
Subject: Re: [PATCH v8 1/1] NFSD: Enforce timeout on layout recall and integrate lease
 manager fencing
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-76766-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 66C71115864
X-Rspamd-Action: no action



On Mon, Feb 9, 2026, at 4:26 PM, Dai Ngo wrote:
> When a layout conflict triggers a recall, enforcing a timeout is
> necessary to prevent excessive nfsd threads from being blocked in
> __break_lease ensuring the server continues servicing incoming
> requests efficiently.
>
> This patch introduces a new function to lease_manager_operations:
>
> lm_breaker_timedout: Invoked when a lease recall times out and is
> about to be disposed of. This function enables the lease manager
> to inform the caller whether the file_lease should remain on the
> flc_list or be disposed of.
>
> For the NFSD lease manager, this function now handles layout recall
> timeouts. If the layout type supports fencing and the client has not
> been fenced, a fence operation is triggered to prevent the client
> from accessing the block device.
>
> While the fencing operation is in progress, the conflicting file_lease
> remains on the flc_list until fencing is complete. This guarantees
> that no other clients can access the file, and the client with
> exclusive access is properly blocked before disposal.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  Documentation/filesystems/locking.rst |   2 +
>  fs/locks.c                            |  16 +++-
>  fs/nfsd/blocklayout.c                 |  41 +++++++--
>  fs/nfsd/nfs4layouts.c                 | 127 +++++++++++++++++++++++++-
>  fs/nfsd/nfs4state.c                   |   1 +
>  fs/nfsd/pnfs.h                        |   2 +-
>  fs/nfsd/state.h                       |   6 ++
>  include/linux/filelock.h              |   1 +
>  8 files changed, 182 insertions(+), 14 deletions(-)
>
> v2:
>     . Update Subject line to include fencing operation.
>     . Allow conflicting lease to remain on flc_list until fencing
>       is complete.
>     . Use system worker to perform fencing operation asynchronously.
>     . Use nfs4_stid.sc_count to ensure layout stateid remains
>       valid before starting the fencing operation, nfs4_stid.sc_count
>       is released after fencing operation is complete.
>     . Rework nfsd4_scsi_fence_client to:
>          . wait until fencing to complete before exiting.
>          . wait until fencing in progress to complete before
>            checking the NFSD_MDS_PR_FENCED flag.
>     . Remove lm_need_to_retry from lease_manager_operations.
> v3:
>     . correct locking requirement in locking.rst.
>     . add max retry count to fencing operation.
>     . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>     . remove special-casing of FL_LAYOUT in lease_modify.
>     . remove lease_want_dispose.
>     . move lm_breaker_timedout call to time_out_leases.
> v4:
>     . only increment ls_fence_retry_cnt after successfully
>       schedule new work in nfsd4_layout_lm_breaker_timedout.
> v5:
>     . take reference count on layout stateid before starting
>       fence worker.
>     . restore comments in nfsd4_scsi_fence_client and the
>       code that check for specific errors.
>     . cancel fence worker before freeing layout stateid.
>     . increase fence retry from 5 to 20.
>
> NOTE:
>     I experimented with having the fence worker handle lease
>     disposal after fencing the client. However, this requires
>     the lease code to export the lease_dispose_list function,
>     and for the fence worker to acquire the flc_lock in order
>     to perform the disposal. This approach adds unnecessary
>     complexity and reduces code clarity, as it exposes internal
>     lease code details to the nfsd worker, which should not
>     be the case.
>
>     Instead, the lm_breaker_timedout operation should simply
>     notify the lease code about how to handle a lease that
>     times out during a lease break, rather than directly
>     manipulating the lease list.
> v6:
>    . unlock the lease as soon as the fencing is done, so that
>      tasks waiting on it can proceed.
>
> v7:
>    . Change to retry fencing on error forever by default.
>    . add module parameter option to allow the admim to specify
>      the maximun number of retries before giving up.
>
> v8:
>    . reinitialize 'remove' inside the loop.
>    . remove knob to stop fence worker from retrying forever.
>    . use exponential back off when retrying fence operation.
>    . Fix nits.
>
> diff --git a/Documentation/filesystems/locking.rst 
> b/Documentation/filesystems/locking.rst
> index 04c7691e50e0..79bee9ae8bc3 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -403,6 +403,7 @@ prototypes::
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
>          bool (*lm_lock_expirable)(struct file_lock *);
>          void (*lm_expire_lock)(void);
> +        bool (*lm_breaker_timedout)(struct file_lease *);
> 
>  locking rules:
> 
> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>  lm_lock_expirable	yes		no			no
>  lm_expire_lock		no		no			yes
>  lm_open_conflict	yes		no			no
> +lm_breaker_timedout     yes             no                      no
>  ======================	=============	=================	=========
> 
>  buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index 46f229f740c8..9ec36c008edd 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, 
> struct list_head *dispose)
>  {
>  	struct file_lock_context *ctx = inode->i_flctx;
>  	struct file_lease *fl, *tmp;
> +	bool remove;
> 
>  	lockdep_assert_held(&ctx->flc_lock);
> 
> @@ -1531,8 +1532,19 @@ static void time_out_leases(struct inode *inode, 
> struct list_head *dispose)
>  		trace_time_out_leases(inode, fl);
>  		if (past_time(fl->fl_downgrade_time))
>  			lease_modify(fl, F_RDLCK, dispose);
> -		if (past_time(fl->fl_break_time))
> -			lease_modify(fl, F_UNLCK, dispose);
> +
> +		remove = true;
> +		if (past_time(fl->fl_break_time)) {
> +			/*
> +			 * Consult the lease manager when a lease break times
> +			 * out to determine whether the lease should be disposed
> +			 * of.
> +			 */
> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);
> +			if (remove)
> +				lease_modify(fl, F_UNLCK, dispose);
> +		}
>  	}
>  }
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 7ba9e2dd0875..b7030c91964c 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -443,15 +443,33 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, 
> struct svc_rqst *rqstp,
>  	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>  }
> 
> -static void
> +/*
> + * Perform the fence operation to prevent the client from accessing the
> + * block device. If a fence operation is already in progress, wait for
> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
> + * update the layout stateid by setting the ls_fenced flag to indicate
> + * that the client has been fenced.
> + *
> + * The cl_fence_mutex ensures that the fence operation has been fully
> + * completed, rather than just in progress, when returning from this
> + * function.
> + *
> + * Return true if client was fenced otherwise return false.
> + */
> +static bool
>  nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>  {
>  	struct nfs4_client *clp = ls->ls_stid.sc_client;
>  	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>  	int status;
> +	bool ret;
> 
> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
> -		return;
> +	mutex_lock(&clp->cl_fence_mutex);
> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
> +		mutex_unlock(&clp->cl_fence_mutex);
> +		return true;
> +	}
> 
>  	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, 
> NFSD_MDS_PR_KEY,
>  			nfsd4_scsi_pr_key(clp),
> @@ -470,13 +488,22 @@ nfsd4_scsi_fence_client(struct 
> nfs4_layout_stateid *ls, struct nfsd_file *file)
>  	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>  	 * retry loop.
>  	 */
> -	if (status < 0 ||
> -	    status == PR_STS_PATH_FAILED ||
> -	    status == PR_STS_PATH_FAST_FAILED ||
> -	    status == PR_STS_RETRY_PATH_FAILURE)
> +	switch (status) {
> +	case 0:
> +	case PR_STS_IOERR:
> +	case PR_STS_RESERVATION_CONFLICT:
> +		ret = true;
> +		break;
> +	default:
> +		/* retry-able and other errors */
> +		ret = false;
>  		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
> +		break;
> +	}
> +	mutex_unlock(&clp->cl_fence_mutex);
> 
>  	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
> +	return ret;
>  }
> 
>  const struct nfsd4_layout_ops scsi_layout_ops = {
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index ad7af8cfcf1f..3aceae6bf1af 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -177,6 +177,13 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
> 
>  	trace_nfsd_layoutstate_free(&ls->ls_stid.sc_stateid);
> 
> +	spin_lock(&ls->ls_lock);
> +	if (ls->ls_fence_in_progress) {
> +		spin_unlock(&ls->ls_lock);
> +		cancel_delayed_work_sync(&ls->ls_fence_work);
> +	} else
> +		spin_unlock(&ls->ls_lock);
> +
>  	spin_lock(&clp->cl_lock);
>  	list_del_init(&ls->ls_perclnt);
>  	spin_unlock(&clp->cl_lock);
> @@ -271,6 +278,9 @@ nfsd4_alloc_layout_stateid(struct 
> nfsd4_compound_state *cstate,
>  	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>  	spin_unlock(&fp->fi_lock);
> 
> +	ls->ls_fence_in_progress = false;
> +	ls->ls_fenced = false;
> +	ls->ls_fence_secs = 0;
>  	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>  	return ls;
>  }
> @@ -747,11 +757,9 @@ static bool
>  nfsd4_layout_lm_break(struct file_lease *fl)
>  {
>  	/*
> -	 * We don't want the locks code to timeout the lease for us;
> -	 * we'll remove it ourself if a layout isn't returned
> -	 * in time:
> +	 * Enforce break lease timeout to prevent NFSD
> +	 * thread from hanging in __break_lease.
>  	 */
> -	fl->fl_break_time = 0;
>  	nfsd4_recall_file_layout(fl->c.flc_owner);
>  	return false;
>  }
> @@ -782,10 +790,121 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>  	return 0;
>  }
> 
> +static void
> +nfsd4_layout_fence_worker(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct nfs4_layout_stateid *ls = container_of(dwork,
> +			struct nfs4_layout_stateid, ls_fence_work);
> +	struct nfsd_file *nf;
> +	struct block_device *bdev;
> +	LIST_HEAD(dispose);
> +
> +	spin_lock(&ls->ls_lock);
> +	if (list_empty(&ls->ls_layouts)) {
> +		spin_unlock(&ls->ls_lock);
> +dispose:
> +		/* unlock the lease so that tasks waiting on it can proceed */
> +		nfsd4_close_layout(ls);
> +
> +		ls->ls_fenced = true;
> +		ls->ls_fence_in_progress = false;
> +		nfs4_put_stid(&ls->ls_stid);
> +		return;
> +	}
> +	spin_unlock(&ls->ls_lock);
> +
> +	rcu_read_lock();
> +	nf = nfsd_file_get(ls->ls_file);
> +	rcu_read_unlock();
> +	if (!nf)
> +		goto dispose;
> +
> +	if (nfsd4_layout_ops[ls->ls_layout_type]->fence_client(ls, nf)) {
> +		/* fenced ok */
> +		nfsd_file_put(nf);
> +		goto dispose;
> +	}
> +	/* fence failed */
> +	bdev = nf->nf_file->f_path.mnt->mnt_sb->s_bdev;
> +	nfsd_file_put(nf);
> +
> +	pr_warn("%s: FENCE failed client[%pISpc] device[0x%x]\n",
> +		__func__, (struct sockaddr *)&ls->ls_stid.sc_client->cl_addr,
> +		bdev->bd_dev);
> +	/*
> +	 * The fence worker retries the fencing operation indefinitely to
> +	 * prevent data corruption. The admin needs to take the following
> +	 * actions to restore access to the file for other clients:
> +	 *
> +	 *  . shutdown or power off the client being fenced.
> +	 *  . manually expire the client to release all its state on the server;
> +	 *    echo 'expire' > proc/fs/nfsd/clients/clientid/ctl'.
> +	 */
> +	ls->ls_fence_secs <<= 1;
> +	if ((!ls->ls_fence_secs) || (ls->ls_fence_secs > 3600))
> +		ls->ls_fence_secs = 1;

Instead of resetting to 1 second, just let it remain at the maximum.

Assuming you meant 3600 seconds and not 3600 jiffies, is an hour
between retries too long? Maybe the maximum should be capped at 3
minutes or something? Opinions?

Let's define a constant somewhere to document the maximum number of
timeout seconds.


> +
> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, ls->ls_fence_secs);

Since mod_delayed_work() takes jiffies as its third argument,
you need a "* HZ" here.


> +}
> +
> +/**
> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
> + * @fl: file to check
> + *
> + * If the layout type supports a fence operation, schedule a worker to
> + * fence the client from accessing the block device.
> + *
> + * This function runs under the protection of the spin_lock flc_lock.
> + * At this time, the file_lease associated with the layout stateid is
> + * on the flc_list. A reference count is incremented on the layout
> + * stateid to prevent it from being freed while the fence worker is
> + * executing. Once the fence worker finishes its operation, it releases
> + * this reference.
> + *
> + * The fence worker continues to run until either the client has been
> + * fenced or the layout becomes invalid. The layout can become invalid
> + * as a result of a LAYOUTRETURN or when the CB_LAYOUT recall callback
> + * has completed.
> + *
> + * Return true if the file_lease should be disposed of by the caller;
> + * otherwise, return false.
> + */
> +static bool
> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
> +{
> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
> +
> +	if ((!nfsd4_layout_ops[ls->ls_layout_type]->fence_client) ||
> +			ls->ls_fenced)
> +		return true;
> +	if (ls->ls_fence_in_progress)
> +		return false;
> +
> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);

Can this INIT_DELAYED_WORK be moved to nfsd4_alloc_layout_stateid() ?
INIT at allocation time is more conventional and safer.


> +
> +	/*
> +	 * Make sure layout has not been returned yet before
> +	 * taking a reference count on the layout stateid.
> +	 */
> +	spin_lock(&ls->ls_lock);
> +	if (list_empty(&ls->ls_layouts)) {
> +		spin_unlock(&ls->ls_lock);
> +		return true;
> +	}
> +	refcount_inc(&ls->ls_stid.sc_count);
> +	ls->ls_fence_in_progress = true;
> +	spin_unlock(&ls->ls_lock);
> +
> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
> +	return false;
> +}
> +
>  static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>  	.lm_break		= nfsd4_layout_lm_break,
>  	.lm_change		= nfsd4_layout_lm_change,
>  	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>  };
> 
>  int
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 98da72fc6067..bad91d1bfef3 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2387,6 +2387,7 @@ static struct nfs4_client *alloc_client(struct 
> xdr_netobj name,
>  #endif
>  #ifdef CONFIG_NFSD_SCSILAYOUT
>  	xa_init(&clp->cl_dev_fences);
> +	mutex_init(&clp->cl_fence_mutex);
>  #endif
>  	INIT_LIST_HEAD(&clp->async_copies);
>  	spin_lock_init(&clp->async_lock);
> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> index db9af780438b..3a2f9e240e85 100644
> --- a/fs/nfsd/pnfs.h
> +++ b/fs/nfsd/pnfs.h
> @@ -38,7 +38,7 @@ struct nfsd4_layout_ops {
>  			struct svc_rqst *rqstp,
>  			struct nfsd4_layoutcommit *lcp);
> 
> -	void (*fence_client)(struct nfs4_layout_stateid *ls,
> +	bool (*fence_client)(struct nfs4_layout_stateid *ls,
>  			     struct nfsd_file *file);
>  };
> 
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 713f55ef6554..69beaffd6c78 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -529,6 +529,7 @@ struct nfs4_client {
>  	time64_t		cl_ra_time;
>  #ifdef CONFIG_NFSD_SCSILAYOUT
>  	struct xarray		cl_dev_fences;
> +	struct mutex		cl_fence_mutex;
>  #endif
>  };
> 
> @@ -738,6 +739,11 @@ struct nfs4_layout_stateid {
>  	stateid_t			ls_recall_sid;
>  	bool				ls_recalled;
>  	struct mutex			ls_mutex;
> +
> +	struct delayed_work		ls_fence_work;
> +	unsigned int			ls_fence_secs;
> +	bool				ls_fence_in_progress;

Seems like there are two sources of truth about whether a fence is
in progress here. Would it make sense to replace ls_fence_in_progress
with a call to delayed_work_pending() ? 


> +	bool				ls_fenced;
>  };
> 
>  static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 2f5e5588ee07..13b9c9f04589 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -50,6 +50,7 @@ struct lease_manager_operations {
>  	void (*lm_setup)(struct file_lease *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lease *);
>  	int (*lm_open_conflict)(struct file *, int);
> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>  };
> 
>  struct lock_manager {
> -- 
> 2.47.3

-- 
Chuck Lever

