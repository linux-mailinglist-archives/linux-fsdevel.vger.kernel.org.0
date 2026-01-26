Return-Path: <linux-fsdevel+bounces-75480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL+QKZqTd2n0iwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:17:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8408A912
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57E2A3062C65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB92D838B;
	Mon, 26 Jan 2026 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teKHFGMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750D92DAFA2
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443916; cv=none; b=eD3597zEaNFxFNLJO/YXyMmtQ8X7Qxq575D5W9zKtI6Rjpm4qrNLMgYSl+1RjtnL7mTLbzP02fMnN8rzJtFgQVw83eGpdEaZ+eOutRIKERCkTC9tZ6Woerq0l4+Z3hNXH6K14KeGbvgyAKCAcsdP4vOyK037DYBLBjNiHErHcF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443916; c=relaxed/simple;
	bh=uCVI6R/FdMcCx93SyVKdOZJHloUHONef3GwkBc0Pxm4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DaG5CDORxAbnU9GKDy71U36TMRFeEW2ccEHbDMYLhOXCexyWtgMc7cD0OE7CiCpCwRx6rIvhFWerDBpv/DQtWfgq0O+QhwEGWAsy8TBeKKAnFG4Pb0XAeqDltMyc14GXGuPOT43qgOZD0ysNDpSFUc+UfzGp8lnY3axT8z4z8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teKHFGMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED98CC4AF09;
	Mon, 26 Jan 2026 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769443916;
	bh=uCVI6R/FdMcCx93SyVKdOZJHloUHONef3GwkBc0Pxm4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=teKHFGMuTMqHOlyDgfhUErntoz6DOIyGd4EK9MmJSl+KDwzBb1Cmv6svfwTTcuU+7
	 zk2oSZ9atl2frf6AcI28EOcB2w79FXZ8jh9RWfmnVxSFqY+NoLde0/8AxbzhDJzXO7
	 fo033vMpSVAhBY0bUI5C/0mNgQy0lo4gPjuC4wETKtSH05EjZmGORL8NsHORr7871v
	 QCHJVTg0kcAqEn9IILkRLhIiKaEEMKmlSLluwnVWfLKyx8fRTRL6BfXR4tBmRF0xrQ
	 3LrINPVX+sH+oHwn1BEHdNCzpGtc1ntcNU56WyPADwdzIFjcazSu/5iDKgc4VlA+JU
	 3E31h48TCPWpg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D39B5F4006A;
	Mon, 26 Jan 2026 11:11:54 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 26 Jan 2026 11:11:54 -0500
X-ME-Sender: <xms:SpJ3aRMbXPTPRkTMPxsCQ5qTO3wjCrL7ZNQ9OMQQNQNVZBRDBMlfQg>
    <xme:SpJ3aexsnRZmZNyN-HinEi1U6-BxkwKpM-tcdtIkEice_zX2bKTS7z6HAfBXxU-RJ
    O4YXuoOYRE9KVSFGIWqgjLKn6JHablijnW7mEXmX7ZqbrSRdF7A1hM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekuddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:SpJ3aaLg5CdWswZ932ot1kYWPCQF4sQwOtYyQx-Mlc8uMGPd20UNgA>
    <xmx:SpJ3aXV4HWBw9zuJ9s37CVi1HRFbdNaeOhqUj272AHFhEHvIIYK4xw>
    <xmx:SpJ3aeHvCwgAFyH1xU8G96sOogmIbgTYm7vjTE42d3sqLtDMTcF4Zw>
    <xmx:SpJ3ae6HIwYEcxiHnnFucjOy4_f7EZ32Ag_hxxVxcvy7fW6r1JrFEA>
    <xmx:SpJ3acdHJB8pKI8NLOBAmQ_8YVP3Rhe4YPgRSws31XHtP4d7yttvfQfw>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AD031780076; Mon, 26 Jan 2026 11:11:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARLdmr4K1fyg
Date: Mon, 26 Jan 2026 11:11:24 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>, "Alexander Aring" <alex.aring@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <f18c50fa-6f51-47fe-96de-ef2f0245a892@app.fastmail.com>
In-Reply-To: <20260125222129.3855915-1-dai.ngo@oracle.com>
References: <20260125222129.3855915-1-dai.ngo@oracle.com>
Subject: Re: [PATCH v2 1/1] NFSD: Enforce Timeout on Layout Recall and Integrate Lease
 Manager Fencing
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
	TAGGED_FROM(0.00)[bounces-75480-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,app.fastmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A8408A912
X-Rspamd-Action: no action



On Sun, Jan 25, 2026, at 5:21 PM, Dai Ngo wrote:
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
> Fencing operation is done asynchronously using a system worker. This
> is to allow lease_modify to trigger the fencing opeation when layout
> recall timed out.
>
> To ensure layout stateid remains valid while the fencing operation is
> in progress, a reference count is added to layout stateid before
> schedule the system worker to do the fencing operation. The reference
> count is released after the fencing operation is complete. 
>
> While the fencing operation is in progress, the conflicting file_lease
> remains on the flc_list until fencing is complete. This guarantees
> that no other clients can access the file, and the client with exclusive
> access is properly blocked before disposal.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  Documentation/filesystems/locking.rst |  2 +
>  fs/locks.c                            | 29 ++++++++++-
>  fs/nfsd/blocklayout.c                 | 19 ++++++-
>  fs/nfsd/nfs4layouts.c                 | 74 ++++++++++++++++++++++++---
>  fs/nfsd/nfs4state.c                   |  1 +
>  fs/nfsd/state.h                       |  3 ++
>  include/linux/filelock.h              |  2 +
>  7 files changed, 122 insertions(+), 8 deletions(-)
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
>
> diff --git a/Documentation/filesystems/locking.rst 
> b/Documentation/filesystems/locking.rst
> index 04c7691e50e0..f7fe2c1ee32b 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -403,6 +403,7 @@ prototypes::
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
>          bool (*lm_lock_expirable)(struct file_lock *);
>          void (*lm_expire_lock)(void);
> +        void (*lm_breaker_timedout)(struct file_lease *);
> 
>  locking rules:
> 
> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>  lm_lock_expirable	yes		no			no
>  lm_expire_lock		no		no			yes
>  lm_open_conflict	yes		no			no
> +lm_breaker_timedout     no              no                      yes

This might not be consistent with other comments that state
lm_breaker_timedout runs with no locks held and may block.
But looks like the flc_lock spinlock IS held. Documentation
should say flc_lock = yes, may block = no.


>  ======================	=============	=================	=========
> 
>  buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index 46f229f740c8..28e63aa87f74 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1487,6 +1487,25 @@ static void lease_clear_pending(struct 
> file_lease *fl, int arg)
>  	}
>  }
> 
> +/*
> + * A layout lease is about to be disposed. If the disposal is
> + * due to a layout recall timeout, consult the lease manager
> + * to see whether the operation should continue.
> + *
> + * Return true if the lease should be disposed else return
> + * false.
> + */
> +static bool lease_want_dispose(struct file_lease *fl)
> +{
> +	if (!(fl->c.flc_flags & FL_BREAKER_TIMEDOUT))
> +		return true;
> +
> +	if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout &&
> +		(!fl->fl_lmops->lm_breaker_timedout(fl)))
> +		return false;
> +	return true;
> +}
> +
>  /* We already had a lease on this file; just change its type */
>  int lease_modify(struct file_lease *fl, int arg, struct list_head 
> *dispose)
>  {
> @@ -1494,6 +1513,11 @@ int lease_modify(struct file_lease *fl, int arg, 
> struct list_head *dispose)
> 
>  	if (error)
>  		return error;
> +
> +	if ((fl->c.flc_flags & FL_LAYOUT) && (arg == F_UNLCK) &&
> +			(!lease_want_dispose(fl)))
> +		return 0;
> +
>  	lease_clear_pending(fl, arg);
>  	locks_wake_up_blocks(&fl->c);
>  	if (arg == F_UNLCK) {
> @@ -1531,8 +1555,11 @@ static void time_out_leases(struct inode *inode, 
> struct list_head *dispose)
>  		trace_time_out_leases(inode, fl);
>  		if (past_time(fl->fl_downgrade_time))
>  			lease_modify(fl, F_RDLCK, dispose);
> -		if (past_time(fl->fl_break_time))
> +
> +		if (past_time(fl->fl_break_time)) {
> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
>  			lease_modify(fl, F_UNLCK, dispose);
> +		}
>  	}
>  }
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 7ba9e2dd0875..05ddff5a4005 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -443,6 +443,14 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, 
> struct svc_rqst *rqstp,
>  	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>  }
> 
> +/*
> + * Perform the fence operation to prevent the client from accessing the
> + * block device. If a fence operation is already in progress, wait for
> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
> + * update the layout stateid by setting the ls_fenced flag to indicate
> + * that the client has been fenced.
> + */
>  static void
>  nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct 
> nfsd_file *file)
>  {
> @@ -450,8 +458,13 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid 
> *ls, struct nfsd_file *file)
>  	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>  	int status;
> 
> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
> +	mutex_lock(&clp->cl_fence_mutex);
> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
> +		ls->ls_fenced = true;
> +		mutex_unlock(&clp->cl_fence_mutex);
> +		nfs4_put_stid(&ls->ls_stid);
>  		return;
> +	}
> 
>  	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, 
> NFSD_MDS_PR_KEY,
>  			nfsd4_scsi_pr_key(clp),
> @@ -475,6 +488,10 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid 
> *ls, struct nfsd_file *file)
>  	    status == PR_STS_PATH_FAST_FAILED ||
>  	    status == PR_STS_RETRY_PATH_FAILURE)
>  		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
> +	else
> +		ls->ls_fenced = true;
> +	mutex_unlock(&clp->cl_fence_mutex);
> +	nfs4_put_stid(&ls->ls_stid);
> 
>  	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>  }
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index ad7af8cfcf1f..4a11ccd5b0a5 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -222,6 +222,27 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
>  	return 0;
>  }
> 
> +static void
> +nfsd4_layout_fence_worker(struct work_struct *work)
> +{
> +	struct nfsd_file *nf;
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct nfs4_layout_stateid *ls = container_of(dwork,
> +			struct nfs4_layout_stateid, ls_fence_work);
> +	u32 type;
> +
> +	rcu_read_lock();
> +	nf = nfsd_file_get(ls->ls_file);
> +	rcu_read_unlock();
> +	if (!nf)
> +		return;

The refcount was incremented when scheduling the work but is never
released for this early return. Do you need:

if (!nf) {
      nfs4_put_stid(&ls->ls_stid);
      return;
}

here?


> +
> +	type = ls->ls_layout_type;
> +	if (nfsd4_layout_ops[type]->fence_client)
> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
> +	nfsd_file_put(nf);
> +}
> +
>  static struct nfs4_layout_stateid *
>  nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>  		struct nfs4_stid *parent, u32 layout_type)
> @@ -271,6 +292,9 @@ nfsd4_alloc_layout_stateid(struct 
> nfsd4_compound_state *cstate,
>  	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>  	spin_unlock(&fp->fi_lock);
> 
> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
> +	ls->ls_fenced = false;
> +
>  	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>  	return ls;
>  }
> @@ -708,9 +732,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, 
> struct rpc_task *task)
>  		rcu_read_unlock();
>  		if (fl) {
>  			ops = nfsd4_layout_ops[ls->ls_layout_type];
> -			if (ops->fence_client)
> +			if (ops->fence_client) {
> +				refcount_inc(&ls->ls_stid.sc_count);
>  				ops->fence_client(ls, fl);
> -			else
> +			} else
>  				nfsd4_cb_layout_fail(ls, fl);
>  			nfsd_file_put(fl);
>  		}
> @@ -747,11 +772,9 @@ static bool
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
> @@ -782,10 +805,49 @@ nfsd4_layout_lm_open_conflict(struct file *filp, 
> int arg)
>  	return 0;
>  }
> 
> +/**
> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
> + * If the layout type supports a fence operation, schedule a worker to
> + * fence the client from accessing the block device.
> + *
> + * @fl: file to check
> + *
> + * Return true if the file lease should be disposed of by the caller;
> + * otherwise, return false.
> + */
> +static bool
> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
> +{
> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
> +	bool ret;
> +
> +	if (!nfsd4_layout_ops[ls->ls_layout_type]->fence_client)
> +		return true;
> +	if (ls->ls_fenced)
> +		return true;

Between this check and mod_delayed_work(), another thread could
complete fencing. This can cause duplicate worker scheduling and
reference count leaks. Should you hold cl_fence_mutex while
checking ls_fenced?


> +
> +	if (work_busy(&ls->ls_fence_work.work))
> +		return false;
> +	/* Schedule work to do the fence operation */
> +	ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
> +	if (!ret) {
> +		/*
> +		 * If there is no pending work, mod_delayed_work queues
> +		 * new task. While fencing is in progress, a reference
> +		 * count is added to the layout stateid to ensure its
> +		 * validity. This reference count is released once fencing
> +		 * has been completed.
> +		 */
> +		refcount_inc(&ls->ls_stid.sc_count);
> +	}
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
> index 583c13b5aaf3..a57fa3318362 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2385,6 +2385,7 @@ static struct nfs4_client *alloc_client(struct 
> xdr_netobj name,
>  #endif
>  #ifdef CONFIG_NFSD_SCSILAYOUT
>  	xa_init(&clp->cl_dev_fences);
> +	mutex_init(&clp->cl_fence_mutex);
>  #endif
>  	INIT_LIST_HEAD(&clp->async_copies);
>  	spin_lock_init(&clp->async_lock);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 713f55ef6554..d9a3c966a35f 100644
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
> @@ -738,6 +739,8 @@ struct nfs4_layout_stateid {
>  	stateid_t			ls_recall_sid;
>  	bool				ls_recalled;
>  	struct mutex			ls_mutex;
> +	struct delayed_work		ls_fence_work;

nfsd4_free_layout_stateid() needs to cancel ls_fence_work
explicitly before freeing stateid memory. Otherwise if the
fence worker runs after the stateid is freed, it will
access the freed stateid memory.


> +	bool				ls_fenced;
>  };
> 
>  static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 2f5e5588ee07..6939952f2088 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -17,6 +17,7 @@
>  #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>  #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>  #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
> 
>  #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
> 
> @@ -50,6 +51,7 @@ struct lease_manager_operations {
>  	void (*lm_setup)(struct file_lease *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lease *);
>  	int (*lm_open_conflict)(struct file *, int);
> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>  };
> 
>  struct lock_manager {
> -- 
> 2.47.3

In nfsd4_scsi_fence_client(), when a device error occurs (e.g.,
PR_STS_IOERR), ls->ls_fenced is set even though the client may
still have storage access.

Also, if fencing consistently fails with retryable errors,
fencing is continually retried with no maximum retry limit. Is
this new lease breaker timeout designed to take care of that
cleanly, or is it something that needs some explicit logic?
I don't immediately spot a mechanism to force lease disposal
if fencing never completes.

-- 
Chuck Lever

