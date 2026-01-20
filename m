Return-Path: <linux-fsdevel+bounces-74684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCnEJzC2b2nHMAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:06:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA7A48417
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4041F5E8A55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDA743E9DF;
	Tue, 20 Jan 2026 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNp+7ZUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98E43E4BC;
	Tue, 20 Jan 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922409; cv=none; b=r7FpuyCJIvx197PJYDfy4w9pxmVsZIVnBZMK7pL42DzKOGvw1ez0aeFd+UYcTbe2dK9mJ0YkOnyVt9o02YsJwYxFllV/jXLqLt94EzqtNxvIwH40Q+6XXIFajVkCCqW8XigBmMmiQL/r1IDZP3s9PPsloKz/uOqB6PxmFh5OCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922409; c=relaxed/simple;
	bh=OT/uP2g+o7vKcDPIDFUU59p6D1YTfTjfk8Jsai7NrfE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JH9Bnp788pZiGDJb+uq7jjnkem8brLP3Fy1YAHi6Qz8k1KfaRSy/w8vn9viiygnetm+ERiUqj5kbjXRI+hGVysDfdESzC2BM42x+gFmcrW07Mk9vdq+wKo54z7p5J9W7j63hBro2ZPPBt1rCXJfV4JL5dgWVMxnrp5AULIvFiH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNp+7ZUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D402C16AAE;
	Tue, 20 Jan 2026 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768922408;
	bh=OT/uP2g+o7vKcDPIDFUU59p6D1YTfTjfk8Jsai7NrfE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mNp+7ZUv00SiE6WzdCTRulxXg25c1mrc5Gz/+lYy1EE5giW6Y1YSPpnzc0eBSuygJ
	 Rq2Fr36gKBGTkMX6pxSrjZiI3ZrILCebzZJ79l+3BhUPkLxjJ974CKct6kn5HPh0Io
	 80fjmCLDtJoFiMJm3Pgb+zKTeQ25ClI0SySvxGZVU6e5J4LAuRok4C35BXViR88g6K
	 GhslNNfngXKPq0KWecOMuIn0tSp9vGHH/2QRr6yd4wnmxVrGI8+K0319PUPaBB4qI4
	 lDmv2WvdoYoP8dvZbZFwH4a/FZeZzF2oXYOcIxl3N9+4kFp/Mv+EXEH7BhRV3nZWOU
	 AfxrJJcbMGlOg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2B2BBF40069;
	Tue, 20 Jan 2026 10:20:06 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 20 Jan 2026 10:20:06 -0500
X-ME-Sender: <xms:Jp1vadk0b_U9qDyAxUcfioQGKVnuYar44syArv20_53pURcL_IgWlA>
    <xme:Jp1vaTpKbyuEXNQGmkeylap9afb27escSV8Ko2MY13-cEjb8QBx8M9lOBoKWtojBV
    GvAWXnkNp6ZQ4RDcDi57ui9NO9ng_93fsPNzsMPtV-Cdf5q56yLPow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghlvgigrdgrrh
    hinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtoheptghhuhgtkh
    drlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhr
    rggtlhgvrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehlihhnuhig
    qdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Jp1vaVzHBS4mcrNnJ0S3RyG3dxHN_oO_eMqH-KhZ0NRKk9IpXmZBEQ>
    <xmx:Jp1vabQBZTM_Am4Zg_iL4K3__aZhN5XavkSn03MQs3Z5YLshTYmk7w>
    <xmx:Jp1vaaLaOd8o26orgrNCo4cVFn2G1tdl3L8f_X0HkXvbTIHsF8MeIA>
    <xmx:Jp1vaaWz2dEUccg2DRF956SB0M2AhqXpO9PA6NErwhbIbbgHfEGxiQ>
    <xmx:Jp1vaWR9riypL7vu7CN9UKz-u9gxxIiIGPiCJDn2ltSFRlZZaWrG_IFX>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EC5E0780070; Tue, 20 Jan 2026 10:20:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAuGWFrNsRM3
Date: Tue, 20 Jan 2026 10:19:30 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>, "Alexander Aring" <alex.aring@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <627f9faa-74b0-4028-9e52-0c1021e3500f@app.fastmail.com>
In-Reply-To: <20260119174737.3619599-1-dai.ngo@oracle.com>
References: <20260119174737.3619599-1-dai.ngo@oracle.com>
Subject: Re: [PATCH 1/1] NFSD: Enforce recall timeout for layout conflict
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.45 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74684-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,app.fastmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0DA7A48417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Mon, Jan 19, 2026, at 12:47 PM, Dai Ngo wrote:
> When a layout conflict triggers a recall, enforcing a timeout
> is necessary to prevent excessive nfsd threads from being tied
> up in __break_lease and ensure the server can continue servicing
> incoming requests efficiently.
>
> This patch introduces two new functions in lease_manager_operations:
>
> 1. lm_breaker_timedout: Invoked when a lease recall times out,
>    allowing the lease manager to take appropriate action.
>
>    The NFSD lease manager uses this to handle layout recall
>    timeouts. If the layout type supports fencing, a fence
>    operation is issued to prevent the client from accessing
>    the block device.
>
> 2. lm_need_to_retry: Invoked when there is a lease conflict.
>    This allows the lease manager to instruct __break_lease
>    to return an error to the caller, prompting a retry of
>    the conflicting operation.
>
>    The NFSD lease manager uses this to avoid excessive nfsd
>    from being blocked in __break_lease, which could hinder
>    the server's ability to service incoming requests.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  Documentation/filesystems/locking.rst |  4 ++
>  fs/locks.c                            | 29 +++++++++++-
>  fs/nfsd/nfs4layouts.c                 | 65 +++++++++++++++++++++++++--
>  include/linux/filelock.h              |  7 +++
>  4 files changed, 100 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/filesystems/locking.rst 
> b/Documentation/filesystems/locking.rst
> index 04c7691e50e0..ae9a1b207b95 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -403,6 +403,8 @@ prototypes::
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
>          bool (*lm_lock_expirable)(struct file_lock *);
>          void (*lm_expire_lock)(void);
> +        void (*lm_breaker_timedout)(struct file_lease *);
> +        bool (*lm_need_to_retry)(struct file_lease *, struct 
> file_lock_context *);
> 
>  locking rules:
> 
> @@ -417,6 +419,8 @@ lm_breaker_owns_lease:	yes     	no			no
>  lm_lock_expirable	yes		no			no
>  lm_expire_lock		no		no			yes
>  lm_open_conflict	yes		no			no
> +lm_breaker_timedout     no              no                      yes
> +lm_need_to_retry        yes             no                      no
>  ======================	=============	=================	=========
> 
>  buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index 46f229f740c8..cd08642ab8bb 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -381,6 +381,14 @@ lease_dispose_list(struct list_head *dispose)
>  	while (!list_empty(dispose)) {
>  		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>  		list_del_init(&flc->flc_list);
> +		if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
> +			struct file_lease *fl;
> +
> +			fl = file_lease(flc);
> +			if (fl->fl_lmops &&
> +					fl->fl_lmops->lm_breaker_timedout)
> +				fl->fl_lmops->lm_breaker_timedout(fl);
> +		}
>  		locks_free_lease(file_lease(flc));
>  	}
>  }
> @@ -1531,8 +1539,10 @@ static void time_out_leases(struct inode *inode, 
> struct list_head *dispose)
>  		trace_time_out_leases(inode, fl);
>  		if (past_time(fl->fl_downgrade_time))
>  			lease_modify(fl, F_RDLCK, dispose);
> -		if (past_time(fl->fl_break_time))
> +		if (past_time(fl->fl_break_time)) {
>  			lease_modify(fl, F_UNLCK, dispose);
> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
> +		}
>  	}
>  }
> 
> @@ -1633,6 +1643,8 @@ int __break_lease(struct inode *inode, unsigned 
> int flags)
>  	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
>  		if (!leases_conflict(&fl->c, &new_fl->c))
>  			continue;
> +		if (new_fl->fl_lmops != fl->fl_lmops)
> +			new_fl->fl_lmops = fl->fl_lmops;
>  		if (want_write) {
>  			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
>  				continue;
> @@ -1657,6 +1669,18 @@ int __break_lease(struct inode *inode, unsigned 
> int flags)
>  		goto out;
>  	}
> 
> +	/*
> +	 * Check whether the lease manager wants the operation
> +	 * causing the conflict to be retried.
> +	 */
> +	if (new_fl->fl_lmops && new_fl->fl_lmops->lm_need_to_retry &&
> +			new_fl->fl_lmops->lm_need_to_retry(new_fl, ctx)) {
> +		trace_break_lease_noblock(inode, new_fl);
> +		error = -ERESTARTSYS;

-ERESTARTSYS is for syscall restart after signal delivery, which
doesn't match up well with the semantics here. A better choice
might be -EAGAIN or -EBUSY?


> +		goto out;
> +	}
> +	ctx->flc_in_conflict = true;
> +
>  restart:
>  	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
>  	break_time = fl->fl_break_time;
> @@ -1693,6 +1717,9 @@ int __break_lease(struct inode *inode, unsigned int flags)
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
>  	lease_dispose_list(&dispose);
> +	spin_lock(&ctx->flc_lock);
> +	ctx->flc_in_conflict = false;
> +	spin_unlock(&ctx->flc_lock);

Unconditionally clearing flc_in_conflict here even though
another thread, racing with this one, might have set it. So
maybe this error flow should clear flc_in_conflict only
if the current thread set it.


>  free_lock:
>  	locks_free_lease(new_fl);
>  	return error;
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index ad7af8cfcf1f..e7777d6ee8d0 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -747,11 +747,9 @@ static bool
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
> @@ -782,10 +780,69 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>  	return 0;
>  }
> 
> +/**
> + * nfsd_layout_breaker_timedout - The layout recall has timed out.
> + * If the layout type supports fence operation then do it to stop
> + * the client from accessing the block device.
> + *
> + * @fl: file to check
> + *
> + * Return value: None.

"Return value: None" is unnecessary for a function returning void.


> + */
> +static void
> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
> +{
> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;

LAYOUTRETURN races with this timeout. Something needs to
guarantee that @ls will remain valid for both racing
threads, so this stateid probably needs an extra reference
count bump somewhere.


> +	struct nfsd_file *nf;
> +	u32 type;
> +
> +	rcu_read_lock();
> +	nf = nfsd_file_get(ls->ls_file);
> +	rcu_read_unlock();
> +	if (!nf)
> +		return;
> +	type = ls->ls_layout_type;
> +	if (nfsd4_layout_ops[type]->fence_client)
> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
> +	nfsd_file_put(nf);
> +}
> +
> +/**
> + * nfsd4_layout_lm_conflict - Handle multiple conflicts in the same file.
> + *
> + * This function is called from __break_lease when a conflict occurs.
> + * For layout conflicts on the same file, each conflict triggers a
> + * layout  recall. Only the thread handling the first conflict needs
> + * to remain in __break_lease to manage the timeout for these recalls;
> + * subsequent threads should not wait in __break_lease.
> + *
> + * This is done to prevent excessive nfsd threads from becoming tied up
> + * in __break_lease, which could hinder the server's ability to service
> + * incoming requests.
> + *
> + * Return true if thread should not wait in __break_lease else return
> + * false.
> + */
> +static bool
> +nfsd4_layout_lm_retry(struct file_lease *fl,
> +				struct file_lock_context *ctx)
> +{
> +	struct svc_rqst *rqstp;
> +
> +	rqstp = nfsd_current_rqst();
> +	if (!rqstp)
> +		return false;
> +	if ((fl->c.flc_flags & FL_LAYOUT) && ctx->flc_in_conflict)
> +		return true;
> +	return false;
> +}
> +
>  static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>  	.lm_break		= nfsd4_layout_lm_break,
>  	.lm_change		= nfsd4_layout_lm_change,
>  	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
> +	.lm_need_to_retry	= nfsd4_layout_lm_retry,
>  };
> 
>  int
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 2f5e5588ee07..6967af8b7fd2 100644
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
> @@ -50,6 +51,9 @@ struct lease_manager_operations {
>  	void (*lm_setup)(struct file_lease *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lease *);
>  	int (*lm_open_conflict)(struct file *, int);
> +	void (*lm_breaker_timedout)(struct file_lease *fl);
> +	bool (*lm_need_to_retry)(struct file_lease *fl,
> +			struct file_lock_context *ctx);

Instead of passing an "internal" structure out of the VFS
locking layer, pass only what is needed, expressed as
common C types (eg, "bool in_conflict").


>  };
> 
>  struct lock_manager {
> @@ -145,6 +149,9 @@ struct file_lock_context {
>  	struct list_head	flc_flock;
>  	struct list_head	flc_posix;
>  	struct list_head	flc_lease;
> +
> +	/* for FL_LAYOUT */
> +	bool			flc_in_conflict;

I'm not certain this is an appropriate spot for this
new boolean. The comment needs more detail, too.

Maybe Jeff has some thoughts.


>  };
> 
>  #ifdef CONFIG_FILE_LOCKING
> -- 
> 2.47.3

-- 
Chuck Lever

