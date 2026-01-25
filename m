Return-Path: <linux-fsdevel+bounces-75395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OKUMeKQdmksSAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 22:53:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AC28295B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 22:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39B3B3008746
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CF130DEA2;
	Sun, 25 Jan 2026 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uu5psUQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152D335BA
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769378001; cv=none; b=AIlXzk0BpNTt4B2OUAO+FbHCenFNrixiy3zp97va7PBrVFMHAS2NMIf8XY9ZjFMey57mVe4Ji693XOzqF8RWAqc3TO5nJu8KarNbVEd6RVRKUsxtUZapMvcrvRwf1/f70oN54PWGJaQFVKgHeKX4Q3dgVzhahlfN3yb0ioB2Cwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769378001; c=relaxed/simple;
	bh=Bjdi2yT63o0/wlrLV6DYuZNMUy6JuG9T2JELDHnobPk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kkseh1pCvJE0kkn77cxPppM7ltfU2wzr2+K0IAFxPuyLoGw5Ius+v46NyVLFajzX+DEbb0D1sC5/Q+GnKX7VkflvHbyNFdwrUGa/aXKdK9KPg2dT5kVf/C0eZGOAdZuEaMibvA9eLigHCVB0zdOt2Ss6vIERU1Yln+4K7aYiNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uu5psUQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DD1C4AF09;
	Sun, 25 Jan 2026 21:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769378001;
	bh=Bjdi2yT63o0/wlrLV6DYuZNMUy6JuG9T2JELDHnobPk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uu5psUQcTWbGDH48Ka+dKSbzcqypki2wWhUrN4Stzq+6XD9zf0GtwlbTj4a8O/acT
	 vBJjq//Tu7tXdxaGsfV+8/bs63Z70wec8a+pEPxOTdUUoQsLtH2JJjd01f91z4nly5
	 EFF/bYZpRzYR43gN6dh8DiC1qLuoVzokrpFDVRV5FoDlGQSEadUpqYNl1utweQ1o0J
	 mJL50Dki/7OuCcs90JeTXTyfm6CZOqe3eiHkeahC2x+pxp8k+NqQgCRxurKZa4Z4oH
	 6zWD1PG7B1UMMS92JJizmV9CGCczYKWzj+KjXA8VgbmzqBkTcAFyjoM6n9pG3oVdAe
	 9sNnWh9gWaciQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id EF8B5F40068;
	Sun, 25 Jan 2026 16:53:19 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 25 Jan 2026 16:53:19 -0500
X-ME-Sender: <xms:z5B2afLYRytISK9fvtfIDL_KW303uExqjj6XagGnyk2dO-Sw_18deQ>
    <xme:z5B2ad-eJ7Hx_mWLBQpImxzhImDiFseYMWVraSle7-cosEI8uCvjiBTyIe8cnmgiv
    SXiBDZaAIE_mpc4RgIKpCE-ju2s15NbIcj2pDkv2DD-dEPAkEIvQm4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheehledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprhhitghkrdhmrg
    gtkhhlvghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggtohguughinhhgsehhrghm
    mhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqtghrhihpthhosehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:z5B2aYF7C1kfja5PQjwGeenrgNg8HwytIcsCA6nh10UtgeHBYjhPaA>
    <xmx:z5B2aVu1FrzfopJ1MzFVX38kGbG08q_0Z2E77TMiGn61zzspFsYL1g>
    <xmx:z5B2aQA3LclAwpXAU-jVWnig-4hv-W5D_JmpNl5ceg_Atadei7eyzA>
    <xmx:z5B2aYABNULs1eYmDqIRuIjG3X7-e6AKSnt-WLpMb_FLQ2LfO-oHBg>
    <xmx:z5B2aSp16VxjhCZr-jzpJn2D1jo3OwwUwqtalBiAkoI2af4PHdWfSuUp>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C96CB780076; Sun, 25 Jan 2026 16:53:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyedVEnZDM_s
Date: Sun, 25 Jan 2026 16:51:03 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <7d973130-d4a4-4f84-a7c0-a896e17339e1@app.fastmail.com>
In-Reply-To: <176920977124.16766.1785815212991547773@noble.neil.brown.name>
References: <176920977124.16766.1785815212991547773@noble.neil.brown.name>
Subject: Re: [PATCH/RFC] nfsd: rate limit requests that result in -ESTALE from the
 filesystem
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
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75395-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	FREEMAIL_TO(0.00)[brown.name,oracle.com,kernel.org,hammerspace.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 38AC28295B
X-Rspamd-Action: no action


On Fri, Jan 23, 2026, at 6:09 PM, NeilBrown wrote:

> From: NeilBrown <neil@brown.name>
> Subject: [PATCH] nfsd: rate limit requests that result in -ESTALE from the
>  filesystem
>
> NFS file handles typically contain a 32 bit generation number which is
> randomly generated by the filesystem when the inode (or inode number) is
> allocated.  This makes it hard to guess correct file handles.  Hard but
> not impossible on a low latency network with a high speed server.

Is this claim accurate for commonly-exported filesystems? Looking
at the kernel sources:

  - btrfs sets i_generation = trans->transid (a sequential counter
    starting from 1, incremented per transaction)
  - ext2 uses sbi->s_next_generation++ (sequential counter seeded
    randomly at mount)
  - ocfs2 uses osb->s_next_generation++ (sequential counter)

For btrfs in particular, the generation number contains zero bits of
randomness. An attacker who can estimate the filesystem age or
transaction count can predict valid generation numbers with high
probability. Does the "1 year" security estimate hold for btrfs
exports, or is that filesystem effectively unprotected by this
mitigation?


> Filehandles already contain 32 bits of randomness.

This appears true for ext4, f2fs, XFS v3+, and tmpfs (which use
get_random_u32()), but not for btrfs, ext2, or ocfs2 as noted above.

Additionally, NFS re-exports (fs/nfs/export.c) use no generation number
at all. The nfs_encode_fh() function embeds the backing server's
filehandle verbatim rather than generating a local generation number.
Protection depends entirely on what the backing NFS server uses. If
someone re-exports a btrfs-backed NFS mount, the sequential transaction
IDs on the backing server provide minimal protection.

We can't legitimately extend your cryptanalysis to non-Linux servers
that back re-exported NFS mounts.


> The only known attack methodology is to guess the inode number of a file
> of interest, then iterate over all possible generation numbers.

Is generation number brute-forcing the optimal attack? Inode numbers
are typically sequential and the valid range is much smaller than 2^32.
Could an attacker first enumerate valid inode numbers (which also
triggers ESTALE and the rate limit), then brute-force the generation
for interesting inodes? The rate limit slows both phases equally, but
inode enumeration requires far fewer guesses.


> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 9fa600602658..f7229d1f9d86 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -219,6 +219,8 @@ struct nfsd_net {
>  	/* last time an admin-revoke happened for NFSv4.0 */
>  	time64_t		nfs40_last_revoke;
> 
> +	struct mutex		estale_rate_limit_mutex;
> +
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  	/* Local clients to be invalidated when net is shut down */
>  	spinlock_t              local_clients_lock;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7587c64bf26d..55d25d9b414f 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2198,6 +2198,7 @@ static __net_init int nfsd_net_init(struct net 
> *net)
>  	nfsd4_init_leases_net(nn);
>  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
>  	seqlock_init(&nn->writeverf_lock);
> +	mutex_init(&nn->estale_rate_limit_mutex);
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  	spin_lock_init(&nn->local_clients_lock);
>  	INIT_LIST_HEAD(&nn->local_clients);
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18..7032f65fe21a 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -244,6 +244,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
> *rqstp, struct net *net,
>  						data_left, fileid_type, 0,
>  						nfsd_acceptable, exp);
>  		if (IS_ERR_OR_NULL(dentry)) {
> +			struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +
>  			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
>  					dentry ?  PTR_ERR(dentry) : -ESTALE);
>  			switch (PTR_ERR(dentry)) {
> @@ -252,6 +254,19 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
> *rqstp, struct net *net,
>  				break;
>  			default:
>  				dentry = ERR_PTR(-ESTALE);
> +				/* We limit ESTALE returns to 1 every
> +				 * 15 milliseconds (across all threads) to
> +				 * prevent a client from guessing the
> +				 * correct (32 bit) generation number
> +				 * for an given inode in significantly
> +				 * less than 1 year.  This ensures clients
> +				 * can only access files for which they
> +				 * are allowed to access a path from the
> +				 * exported root.
> +				 */
> +				mutex_lock(&nn->estale_rate_limit_mutex);
> +				msleep(15);
> +				mutex_unlock(&nn->estale_rate_limit_mutex);

The global mutex serializes all ESTALE errors across all nfsd threads
in the network namespace. The impact on legitimate workloads must be
carefully considered.

For example, during file deletion or migration, multiple clients may
encounter genuinely stale file handles simultaneously. With N
concurrent ESTALE errors, the total delay becomes N * 15ms as each
thread waits for the mutex. With 100 concurrent stale handle accesses,
this adds 1.5 seconds of accumulated latency.

Additionally, an attacker does not need to successfully guess file
handles to cause harm. Simply sending requests with invalid file
handles at a modest rate (e.g., 10/sec) can monopolize 15% of the
mutex time, slowing all legitimate ESTALE processing on the server.

Would per-client rate limiting (e.g., a token bucket per client IP)
avoid penalizing legitimate operations while still throttling attacks?

Or, as Jeff suggested, narrowing the blast radius to per-inode
limiting?

Lastly, we've spilled a large number of electrons trying to remove
needless delays of nfsd threads (eg, waiting synchronously for NFS
clients to respond to NFSv4 callbacks) because a malicious client
can use this delay as a timing attack to determine the (maximum)
number of available nfsd threads and simply keep them all busy,
preventing the server from doing useful work.


>  			}
>  		}
>  	}

I think given the gaps in covering exports of first-tier file
systems such as btrfs, the unknowns in protecting re-exported
NFS mounts, and the increase in the surface of timing attacks,
this approach needs significant refinement before I would feel
comfortable with it.

-- 
Chuck Lever

