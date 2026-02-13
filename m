Return-Path: <linux-fsdevel+bounces-77148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOkqKPdGj2kiPAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 16:44:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEDA137AA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 16:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 987423053ABC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919C536213E;
	Fri, 13 Feb 2026 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy1KtufS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D773590C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770997438; cv=none; b=edDiOlEoOqknwVCXtz0n/oW88gbm68/FcRdYcfl9e0nQsPsjIxmnO/fp1LlQSN1pECqtDzV3rwBGD+1c3+S0Dfvj8uv3Ct3OJj6dkcLG8snzwB7pIVOms4PrUuzptqXjh8iI775q2yu1gWm7Ha4kyZRN+mlT9bnpodOHf9ApNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770997438; c=relaxed/simple;
	bh=iKjY4w5g95eC85bWb7UtMrxduDGPMHQWbFTcM1c4YAc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=byPFX9Q48JdRQT2P3TdM1xQhoNV0bRQFVj393JpJV6ulyKa5HR30fK77jxTX8drCXJKp5oLQ5kaILg7BmyrSwTEsgMEesp2dtyyjsLP79gntC+pXb1r6U0dEOF7EOr2EGDYSkNrm7VU7/OjgFviMjpLLFlBUGnT9UWQpSJ660IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy1KtufS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9450C4AF09;
	Fri, 13 Feb 2026 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770997437;
	bh=iKjY4w5g95eC85bWb7UtMrxduDGPMHQWbFTcM1c4YAc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Uy1KtufS5XWv8GdVeIGQJO4LtsCaVa9eh8YiGM2U+ll7UL49PPZncELF8rAPUQKAb
	 jo1HWCjrSmvw/8pfuwmsew9YOOVHtQ+1Ko8MM0lx/h88qYHvFSBD1PRfe/42WZh2XU
	 oTG/Aj/vvIQ+z0pDuZOgB521DBDURcCNb+zrY5a4cmd6LRWtnlBaKSut0RCqsNYd7P
	 DsQhbeQxY7uXXBsMtVhG9FZRgVaamiQA0W5R7Fqux+PZaGQg4faFDTWpdzjRV2dEx1
	 vRkSqNheMZcliapIfgZaaULLPsBUlf0m1zyBWh2cvCjKM/sG8wpSE1Lj3BChZOKQe6
	 o37MYj6C+fnjA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8C310F40069;
	Fri, 13 Feb 2026 10:43:56 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 13 Feb 2026 10:43:56 -0500
X-ME-Sender: <xms:vEaPabbWaymJXQm-3ATCTBsUE4mHtc-YD9UCh4R6eB5JU6S4QhE7EQ>
    <xme:vEaPaVPDKCVTxJH6R7dwQA-6emTcNdaAxBvjJ3-fmGErTD8MU2bhzKrn5JHkqUTwT
    iJR43ugI_zPKiSyOejUC0AsZJkIBGgf8lbLYb3NtsaJK-eY9lMUOPpK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekieegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:vEaPaWWPC6_JYtCAD6EB9ks6RknD07NJKy4TmgN33glnm62mx4X4Fw>
    <xmx:vEaPaXwTXeJD5wmh50mQ3yqdFE-l8eFcSVYWB8mmwosnuKkXDgG77A>
    <xmx:vEaPadw73Z6YyMq3xOAB5QYhAIi4iEPkXSPso0AbS9V-em158mI6kQ>
    <xmx:vEaPac1j6PyVigM_c5muD5g6wMYvCdFg1NoxxVTbjDZ44dwTa4gdTQ>
    <xmx:vEaPabo_FCJs1DS27HctSQmdRDu2-q2tLyiHY2PXkn6a4k7VkQP_pFW2>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 621FB780077; Fri, 13 Feb 2026 10:43:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AcKYO-0hHkoc
Date: Fri, 13 Feb 2026 10:43:33 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>, "Alexander Aring" <alex.aring@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <95aba237-f068-4d0b-ae45-3a6db1176226@app.fastmail.com>
In-Reply-To: <20260213083101.3692692-1-dai.ngo@oracle.com>
References: <20260213083101.3692692-1-dai.ngo@oracle.com>
Subject: Re: [PATCH v11 1/1] NFSD: Enforce timeout on layout recall and integrate lease
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
	TAGGED_FROM(0.00)[bounces-77148-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
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
X-Rspamd-Queue-Id: EDEDA137AA4
X-Rspamd-Action: no action

On Fri, Feb 13, 2026, at 3:30 AM, Dai Ngo wrote:

> diff --git a/fs/locks.c b/fs/locks.c
> index 46f229f740c8..42ae59eda068 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1660,8 +1672,12 @@ int __break_lease(struct inode *inode, unsigned 
> int flags)
>  restart:
>  	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
>  	break_time = fl->fl_break_time;
> -	if (break_time != 0)
> -		break_time -= jiffies;
> +	if (break_time != 0) {
> +		if (time_after(jiffies, break_time))
> +			break_time = jiffies + lease_break_time * HZ;

break_time is set to an absolute jiffies value.


> +		else
> +			break_time -= jiffies;

break_time is set to a relative offset.


> +	}
>  	if (break_time == 0)
>  		break_time++;
>  	locks_insert_block(&fl->c, &new_fl->c, leases_conflict);

Now, further down in __break_lease(), break_time is passed to
wait_event_interruptible_timeout(), whose third argument expects
a relative timeout in jiffies.

Passing an absolute value produces a wait on the order of
billions of jiffies rather than lease_break_time seconds.


> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index ad7af8cfcf1f..b35ae83da0b1 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -782,10 +793,133 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
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
> +	struct nfs4_client *clp;
> +	struct nfsd_net *nn;
> +	LIST_HEAD(dispose);

Nit: "dispose" is unused.


> +
> +	spin_lock(&ls->ls_lock);
> +	if (list_empty(&ls->ls_layouts)) {
> +		spin_unlock(&ls->ls_lock);
> +dispose:
> +		/* unlock the lease so that tasks waiting on it can proceed */
> +		nfsd4_close_layout(ls);
> +
> +		ls->ls_fenced = true;
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
> +	clp = ls->ls_stid.sc_client;
> +	nn = net_generic(clp->net, nfsd_net_id);
> +	bdev = nf->nf_file->f_path.mnt->mnt_sb->s_bdev;
> +	if (nfsd4_layout_ops[ls->ls_layout_type]->fence_client(ls, nf)) {
> +		/* fenced ok */
> +		nfsd_file_put(nf);
> +		pr_warn("%s: FENCED client[%pISpc] clid[%d] to device[%s]\n",
> +			__func__, (struct sockaddr *)&clp->cl_addr,
> +			clp->cl_clientid.cl_id - nn->clientid_base,
> +			bdev->bd_disk->disk_name);
> +		goto dispose;
> +	}
> +	/* fence failed */
> +	nfsd_file_put(nf);
> +
> +	if (!clp->cl_fence_retry_warn) {
> +		pr_warn("%s: FENCE failed client[%pISpc] clid[%d] device[%s]\n",
> +			__func__, (struct sockaddr *)&clp->cl_addr,
> +			clp->cl_clientid.cl_id - nn->clientid_base,
> +			bdev->bd_disk->disk_name);
> +		clp->cl_fence_retry_warn = true;
> +	}
> +	/*
> +	 * The fence worker retries the fencing operation indefinitely to
> +	 * prevent data corruption. The admin needs to take the following
> +	 * actions to restore access to the file for other clients:
> +	 *
> +	 *  . shutdown or power off the client being fenced.
> +	 *  . manually expire the client to release all its state on the server;
> +	 *    echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'.
> +	 *
> +	 *    Where:
> +	 *
> +	 *    clid: is the unique client identifier displayed in
> +	 *          the warning message above.
> +	 */
> +	if (!ls->ls_fence_delay)
> +		ls->ls_fence_delay = HZ;
> +	else if (ls->ls_fence_delay < MAX_FENCE_DELAY)
> +		ls->ls_fence_delay <<= 1;
> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, ls->ls_fence_delay);
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
> +	if (delayed_work_pending(&ls->ls_fence_work))
> +		return false;
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

Wondering if ^^^^ should be refcount_inc_not_zero()?

refcount_inc() on a zero refcount triggers a WARN and still
increments, then mod_delayed_work() re-queues the fence
worker. Once the destructor completes and frees the layout
stateid via kmem_cache_free(), the re-queued fence worker
operates on freed memory.

Using refcount_inc_not_zero() and returning true on failure
would handle this race.


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


-- 
Chuck Lever

