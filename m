Return-Path: <linux-fsdevel+bounces-76674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKnmK0d+h2kmYwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 19:02:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D88E106C6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 19:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD97301E978
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Feb 2026 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE32C2EA147;
	Sat,  7 Feb 2026 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqkpxxEl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B77F1A9FAF
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Feb 2026 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770487355; cv=none; b=OepeXI4S8MGgrriFAkg3Ls++BhAqNG/WbcceEPPmZgJGkjeB738TpTxPcykWHvS7pI4/jP8142kwkXVZA0PQwwn3wIRJYSwZL1bQ7VM4+Fj0Pfg3wXrDJEat1JTt58axJn87TcS3cDPCqYjaQyWBiHvvQ65js0puNJNu2Mw4SRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770487355; c=relaxed/simple;
	bh=sZQ1mDUvCFM2xrsvr4EQgXk1/ZlmsAOh9CS0u2n+ClY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Mh6vhHnmMKjyDJ5wc/ScQI3Dn4uMqxyGIWYye+4W6crgfJWN3K9O3E45Hk7XSfI3KgP8eZBygLMvHKc2lNNM0GC60YFYt7IcUkam/qi3uG74MywQAgcwaVIzx6q23HGMpWAbaERb7joy5SscuKLkA+QNIvQacx+a1tF2grntao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqkpxxEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72894C16AAE;
	Sat,  7 Feb 2026 18:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770487355;
	bh=sZQ1mDUvCFM2xrsvr4EQgXk1/ZlmsAOh9CS0u2n+ClY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XqkpxxElRLRnIpxcTIlk5/veKxSPC21Db+eKNEEcES1wfbN8eaOt149CFgFGhK3QW
	 RxaCYLp2dDjy69SDpjVyFsPmgXy/+c18T0vONT2+9DmsUm88ylVYIelh+mO4yns8ye
	 +ZQRFhEockJBwbzTwfD3CcUry84BwMIbLg6xXJcGGLSm1MrRYO7OsPx4MwHbyrdTqj
	 ORKWDV9Wg3//Ai41gnicvetb2rpdD9y1wvUDxMy0SGKjz0YwfNybacsasizb/n2ni+
	 RdKCcp437VV9GW6WB0oF2bRm2zpIPXegnCMbCL/y2DMwC6u3Jli6mmRKHvcvJh3aZA
	 6C7ohUrbShm0w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5F6A2F4006B;
	Sat,  7 Feb 2026 13:02:33 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 07 Feb 2026 13:02:33 -0500
X-ME-Sender: <xms:OX6HaXJBQZguJE_anxmz18Aa2noE6S7O0bg-rX29mT9a4Az5PKRf-w>
    <xme:OX6HaV8dPIE7Lo4xrdSW8kNthYV8ukh6evJZmg6yOhyKLa7YEhbvq7o1XVjFswpBs
    uMl2Qn09KGD1HYb8E7rF4vJU_c8Ay5hULDyzSucjQjFr2ymRpEPge0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledujedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:OX6HaaG4GHjhITuTsJ-5IPgRMtOVA_Fqu4QDcioLUTu-vBtiV-km7Q>
    <xmx:OX6HaQiKU1szeFgpCLcnneYGY8NfNSskFmwmegHKaIgFxQFeUE_vlw>
    <xmx:OX6HaXh9Xz_HfUetET0tcQQSBDxUKz-IqxaXtlZjDImJr6n3kxcPWQ>
    <xmx:OX6HaTl7IB-rJQ4nZk8aSkPp5mRNKkKEy4tCdvBnHJiO2ajQq4hOng>
    <xmx:OX6HabZAkVhL1nZxptM_U6Ny4DebKuCUwiNqUnrPryCJX_ourD8ykRI->
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 32855780076; Sat,  7 Feb 2026 13:02:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AODLgThZz9wg
Date: Sat, 07 Feb 2026 13:00:51 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>, "Alexander Aring" <alex.aring@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <ebcb1893-bf03-4637-bf0c-918eb42705bd@app.fastmail.com>
In-Reply-To: <20260207060940.2234728-1-dai.ngo@oracle.com>
References: <20260207060940.2234728-1-dai.ngo@oracle.com>
Subject: Re: [PATCH v7 1/1] NFSD: Enforce timeout on layout recall and integrate lease
 manager fencing
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76674-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.718];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0D88E106C6A
X-Rspamd-Action: no action



On Sat, Feb 7, 2026, at 1:09 AM, Dai Ngo wrote:
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
>  fs/locks.c                            |  15 ++-
>  fs/nfsd/blocklayout.c                 |  41 ++++++--
>  fs/nfsd/nfs4layouts.c                 | 137 +++++++++++++++++++++++++-
>  fs/nfsd/nfs4state.c                   |   1 +
>  fs/nfsd/pnfs.h                        |   2 +-
>  fs/nfsd/state.h                       |   6 ++
>  include/linux/filelock.h              |   1 +
>  8 files changed, 191 insertions(+), 14 deletions(-)
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
> index 46f229f740c8..0e77423cf000 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, 
> struct list_head *dispose)
>  {
>  	struct file_lock_context *ctx = inode->i_flctx;
>  	struct file_lease *fl, *tmp;
> +	bool remove = true;

The "remove" variable is initialized before the loop but is never
reset to true at the start of each iteration. If a lease's
lm_breaker_timedout callback returns false, "remove" stays false
for all subsequent leases in the list.

A later lease that has timed out but has no lm_breaker_timedout
callback (or a NULL fl_lmops) would skip the conditional assignment
and inherit the stale false value, preventing lease_modify() from
disposing of it.

Should "remove" be reset to true inside the loop body before the
fl_break_time check?


>  	lockdep_assert_held(&ctx->flc_lock);
> 
> @@ -1531,8 +1532,18 @@ static void time_out_leases(struct inode *inode, 
> struct list_head *dispose)
>  		trace_time_out_leases(inode, fl);
>  		if (past_time(fl->fl_downgrade_time))
>  			lease_modify(fl, F_RDLCK, dispose);
> -		if (past_time(fl->fl_break_time))
> -			lease_modify(fl, F_UNLCK, dispose);
> +
> +		if (past_time(fl->fl_break_time)) {
> +			/*
> +			 * Consult the lease manager when a lease break times
> +			 * out to determine whether the lease should be disposed
> +			 * of.
> +			 */
> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);

I'm still not enthusiastic about holding flc_lock while calling
another module. Especially since holding that lock does not
appear to be documented in an API contract...


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
> index ad7af8cfcf1f..c02b3219ebeb 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -27,6 +27,25 @@ static struct kmem_cache *nfs4_layout_stateid_cache;
>  static const struct nfsd4_callback_ops nfsd4_cb_layout_ops;
>  static const struct lease_manager_operations nfsd4_layouts_lm_ops;
> 
> +/*
> + * By default, if the server fails to fence a client, it retries the fencing
> + * operation indefinitely to prevent data corruption. The admin needs to take
> + * the following actions to restore access to the file for other clients:
> + *
> + *    . shutdown or power off the client being fenced.
> + *    . manually expire the client to release all its state on the server;
> + *      echo 'expire' > proc/fs/nfsd/clients/clientid/ctl'.

Has there been any testing that shows expiring that client actually
breaks the fence retry loop below?


> + *
> + * The admim can control this behavior by setting nfsd4_fence_max_retries
> + * to specify the maximum number of retries. If the maximum is reached, the
> + * server gives up and removes the conflicting lease, allowing other clients
> + * to access the file.
> + */
> +static int nfsd4_fence_max_retries = 0;		/* default is retry forever */
> +module_param(nfsd4_fence_max_retries, int, 0644);
> +MODULE_PARM_DESC(nfsd4_fence_max_retries,
> +	"Maximum retries for fencing operation, 0 is for retry forever.");
> +

max_retries is a signed integer. What would a negative max retries value
mean?

I haven't seen a clear use case stated for an admin needing to set this
value. The documenting comment just says "The admin /can/ control this
behavior" (emphasis mine) but does not state /why/ she might need to do
that. The documenting comment does not underscore that limiting the
number of retries -- setting this value -- is a data corruption risk.

I'd rather not add this setting unless there is an actual real world
purpose in front of us.


>  const struct nfsd4_layout_ops *nfsd4_layout_ops[LAYOUT_TYPE_MAX] =  {
>  #ifdef CONFIG_NFSD_FLEXFILELAYOUT
>  	[LAYOUT_FLEX_FILES]	= &ff_layout_ops,
> @@ -177,6 +196,13 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
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
> @@ -271,6 +297,9 @@ nfsd4_alloc_layout_stateid(struct 
> nfsd4_compound_state *cstate,
>  	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>  	spin_unlock(&fp->fi_lock);
> 
> +	ls->ls_fence_in_progress = false;
> +	ls->ls_fenced = false;
> +	ls->ls_fence_retries = 0;
>  	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>  	return ls;
>  }
> @@ -747,11 +776,9 @@ static bool
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
> @@ -782,10 +809,112 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
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

nfsd4_close_layout() acquires fi_lock and calls kernel_setlease().
If lease code acquires locks that the fence worker holds, can a
deadlock occur in workqueue context?


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
> +		__func__, (struct sockaddr *)&ls->ls_stid.sc_client,
> +		bdev->bd_dev);

The %pISpc format expects a struct sockaddr pointer.
ls->ls_stid.sc_client is a struct nfs4_client pointer, so
&ls->ls_stid.sc_client yields the address of the pointer field
itself (a struct nfs4_client **), not a socket address.

Compare with client_info_show() in nfs4state.c which uses the
correct form:

    (struct sockaddr *)&clp->cl_addr

Should this be (struct sockaddr *)&ls->ls_stid.sc_client->cl_addr?


> +	if (nfsd4_fence_max_retries &&
> +			ls->ls_fence_retries++ >= nfsd4_fence_max_retries)
> +		goto dispose;

> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 1);

"1" -- is that 1 jiffy? Could this use an exponential back-off
instead?


> +}
> +
> +/**
> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
> + *

Nit: Remove the blank comment line here, please.


> + * @fl: file to check
> + *
> + * If the layout type supports a fence operation, schedule a worker to
> + * fence the client from accessing the block device.
> + *
> + * This function runs under the protection of the spin_lock flc_lock.
> + * At this time, the file_lease associated with the layout stateid is
> + * on the flc_list. A reference count is incremented on the layout
> + * stateid to prevent it from being freed while the fence orker is

Nit: ^ orker^ worker


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
> index 713f55ef6554..be85c9fd6a68 100644
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
> +	int				ls_fence_retries;
> +	bool				ls_fence_in_progress;
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

