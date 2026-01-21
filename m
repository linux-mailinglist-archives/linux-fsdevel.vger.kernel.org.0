Return-Path: <linux-fsdevel+bounces-74925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P6JFFJDcWn2fgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:21:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 268295DF67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D175876AE61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CACB40FDB3;
	Wed, 21 Jan 2026 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2UWJXv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AC3AA1B9
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028250; cv=none; b=H0MYQn51YRV+Wn5ngD7DiH+9yVgYL7J+68CDN2JLR9yvmvhG9M1iGI/mu2ZICVVtywodCORtfXayTaCe1KxBw6i7QY583HLIV55xZzJpfLA4IdSNcCUoN9+gydCgL8SeWvcXMIUJK/38j5Q6eCbfeQUXFftae2w9zpymVJUgkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028250; c=relaxed/simple;
	bh=gp6uZcDaqeINKWl7KU1Q0sBCQuqNMLIl7WmvXETbjyU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aE+F+Buf5gwoO/XJ/frSE71Q8UGveAPLBs6FTw3KNAXWvREwxKXy3Bu62w9P2kFFLlMDclmXUIICYx03UShPYNyhS4sCAXrSuwRaUfv6cD9V7a6vzs73BIq976IbkdqRACaGmkU54Bp92OFztMpaNSuAZz0noi5DqM20YconcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2UWJXv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A17EC16AAE;
	Wed, 21 Jan 2026 20:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769028249;
	bh=gp6uZcDaqeINKWl7KU1Q0sBCQuqNMLIl7WmvXETbjyU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=k2UWJXv6SqBTimgty+284y91TnWxnmX5j/NWAxrKENk1rlO7gbHMHkh7HbLs/kv+d
	 CeVWjCcyIH7XyPjikCrV5J59bhHwoxpdMT5gp12ltMcgUbuF4x/DJRG1jI7XDvU4I3
	 vcHW8EAWjDeVcL4fyxeQSFFbn66oqMODGbz7C/+GErzDa1RYNr0ITtgaIT3OhwP5OH
	 ziRKPNHGfhN7aZc09jOHunSaH1uSx9RORnZG2+MVYLWroCjatiKiAx7ZceHKdspnQw
	 M4KGJZASDgNXK5cewCtvYFlhUjA2Y9aQsGtSKFn5304d67LkL6wuSHW5QmgO0rgrcA
	 6fRGerELIE6HQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1CC05F40068;
	Wed, 21 Jan 2026 15:44:08 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 21 Jan 2026 15:44:08 -0500
X-ME-Sender: <xms:lzpxaaLbrZCOuOItD9h2qCF9kJXOKx7yKKJsQ2EmtPUAvGv3gp8iqw>
    <xme:lzpxac_jQJ6FJu7c8MaD4N29QNGqxQVTYzYfBVSiqr8g9jbC7Hojq4qqAhpCtK5ip
    G_kqZ2QKiMON_nYxzHKD7uiPYM-NA9YEMJuQyiJyNv_ITogxPSD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrd
    hnrghmvgdprhgtphhtthhopehrihgtkhdrmhgrtghklhgvmhesghhmrghilhdrtghomhdp
    rhgtphhtthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomhdprhgtph
    htthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mDpxabzhwE0wKOSn6FC0B0GRJogAsSPz-pcEg-CayxVb7vVxrfe-ug>
    <xmx:mDpxafFvcEQJEeACRcHLLkj7HSlzM0PDf3ijz1vZa0DDngYeidbzNA>
    <xmx:mDpxaQtp7yAbQqOSnEe7NEON5x2W4U6Yix5NwBfk3NI7So92HhNrug>
    <xmx:mDpxafDYIbH-IzCJECAhgoCrn7LKdNRBgJw6Z1hWVEoiFFRtVOIfsQ>
    <xmx:mDpxabCUGzjP58KtV8X0A03AyQFhIKyjyYJy_zI0xvzNYBXg2IPvmeHE>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DFF93780070; Wed, 21 Jan 2026 15:44:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1vGOqVGteog
Date: Wed, 21 Jan 2026 15:43:34 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <e299b7c6-9d37-4ffe-8d45-a95d92e33406@app.fastmail.com>
In-Reply-To: 
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <6d7bfccbaf082194ea257749041c19c2c2385cce.1769026777.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v2 1/3] NFSD: Add a key for signing filehandles
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
	TAGGED_FROM(0.00)[bounces-74925-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_TO(0.00)[hammerspace.com,oracle.com,kernel.org,brown.name,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,app.fastmail.com:mid,hammerspace.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 268295DF67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
> A future patch will enable NFSD to sign filehandles by appending a Message
> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
> that can persist across reboots.  A persisted key allows the server to
> accept filehandles after a restart.  Enable NFSD to be configured with this
> key via both the netlink and nfsd filesystem interfaces.
>
> Since key changes will break existing filehandles, the key can only be set
> once.  After it has been set any attempts to set it will return -EEXIST.
>
> Link: 
> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  6 ++
>  fs/nfsd/netlink.c                     |  5 +-
>  fs/nfsd/netns.h                       |  2 +
>  fs/nfsd/nfsctl.c                      | 94 +++++++++++++++++++++++++++
>  fs/nfsd/trace.h                       | 25 +++++++
>  include/uapi/linux/nfsd_netlink.h     |  1 +
>  6 files changed, 131 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/netlink/specs/nfsd.yaml 
> b/Documentation/netlink/specs/nfsd.yaml
> index badb2fe57c98..d348648033d9 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -81,6 +81,11 @@ attribute-sets:
>        -
>          name: min-threads
>          type: u32
> +      -
> +        name: fh-key
> +        type: binary
> +        checks:
> +            exact-len: 16
>    -
>      name: version
>      attributes:
> @@ -163,6 +168,7 @@ operations:
>              - leasetime
>              - scope
>              - min-threads
> +            - fh-key
>      -
>        name: threads-get
>        doc: get the number of running threads
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 887525964451..81c943345d13 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -24,12 +24,13 @@ const struct nla_policy 
> nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
>  };
> 
>  /* NFSD_CMD_THREADS_SET - do */
> -static const struct nla_policy 
> nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] = {
> +static const struct nla_policy 
> nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
>  	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
>  	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
>  	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
>  	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
>  	[NFSD_A_SERVER_MIN_THREADS] = { .type = NLA_U32, },
> +	[NFSD_A_SERVER_FH_KEY] = NLA_POLICY_EXACT_LEN(16),
>  };
> 
>  /* NFSD_CMD_VERSION_SET - do */
> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>  		.cmd		= NFSD_CMD_THREADS_SET,
>  		.doit		= nfsd_nl_threads_set_doit,
>  		.policy		= nfsd_threads_set_nl_policy,
> -		.maxattr	= NFSD_A_SERVER_MIN_THREADS,
> +		.maxattr	= NFSD_A_SERVER_FH_KEY,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 9fa600602658..c8ed733240a0 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -16,6 +16,7 @@
>  #include <linux/percpu-refcount.h>
>  #include <linux/siphash.h>
>  #include <linux/sunrpc/stats.h>
> +#include <linux/siphash.h>
> 
>  /* Hash tables for nfs4_clientid state */
>  #define CLIENT_HASH_BITS                 4
> @@ -224,6 +225,7 @@ struct nfsd_net {
>  	spinlock_t              local_clients_lock;
>  	struct list_head	local_clients;
>  #endif
> +	siphash_key_t		*fh_key;
>  };
> 
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 30caefb2522f..e59639efcf5c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -49,6 +49,7 @@ enum {
>  	NFSD_Ports,
>  	NFSD_MaxBlkSize,
>  	NFSD_MinThreads,
> +	NFSD_Fh_Key,
>  	NFSD_Filecache,
>  	NFSD_Leasetime,
>  	NFSD_Gracetime,
> @@ -69,6 +70,7 @@ static ssize_t write_versions(struct file *file, char 
> *buf, size_t size);
>  static ssize_t write_ports(struct file *file, char *buf, size_t size);
>  static ssize_t write_maxblksize(struct file *file, char *buf, size_t 
> size);
>  static ssize_t write_minthreads(struct file *file, char *buf, size_t 
> size);
> +static ssize_t write_fh_key(struct file *file, char *buf, size_t size);
>  #ifdef CONFIG_NFSD_V4
>  static ssize_t write_leasetime(struct file *file, char *buf, size_t 
> size);
>  static ssize_t write_gracetime(struct file *file, char *buf, size_t 
> size);
> @@ -88,6 +90,7 @@ static ssize_t (*const write_op[])(struct file *, 
> char *, size_t) = {
>  	[NFSD_Ports] = write_ports,
>  	[NFSD_MaxBlkSize] = write_maxblksize,
>  	[NFSD_MinThreads] = write_minthreads,
> +	[NFSD_Fh_Key] = write_fh_key,
>  #ifdef CONFIG_NFSD_V4
>  	[NFSD_Leasetime] = write_leasetime,
>  	[NFSD_Gracetime] = write_gracetime,
> @@ -950,6 +953,60 @@ static ssize_t write_minthreads(struct file *file, 
> char *buf, size_t size)
>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
>  }
> 
> +/*
> + * write_fh_key - Set or report the current NFS filehandle key, the key
> + * 		can only be set once, else -EEXIST because changing the key
> + * 		will break existing filehandles.

Do you really need both a /proc/fs/nfsd API and a netlink API? I
think one or the other would be sufficient, unless you have
something else in mind (in which case, please elaborate in the
patch description).

Also "set once" seems to be ambiguous. Is it "set once" per NFSD
module load, one per system boot epoch, or set once, _ever_ ?

While it's good UX safety to prevent reseting the key, there are
going to be cases where it is both needed and safe to replace the
FH signing key. Have you considered providing a key rotation
mechanism or a recipe to do so?


> + *
> + * Input:
> + *			buf:		ignored
> + *			size:		zero
> + * OR
> + *
> + * Input:
> + *			buf:		C string containing a parseable UUID
> + *			size:		non-zero length of C string in @buf
> + * Output:
> + *	On success:	passed-in buffer filled with '\n'-terminated C string
> + *			containing the standard UUID format of the server's fh_key
> + *			return code is the size in bytes of the string
> + *	On error:	return code is zero or a negative errno value
> + */
> +static ssize_t write_fh_key(struct file *file, char *buf, size_t size)
> +{
> +	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
> +	int ret = -EEXIST;
> +
> +	if (size > 35 && size < 38) {
> +		siphash_key_t *sip_fh_key;
> +		uuid_t uuid_fh_key;
> +
> +		mutex_lock(&nfsd_mutex);
> +
> +		/* Is the key already set? */
> +		if (nn->fh_key)
> +			goto out;
> +
> +		ret = uuid_parse(buf, &uuid_fh_key);
> +		if (ret)
> +			goto out;
> +
> +		sip_fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
> +		if (!sip_fh_key) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		memcpy(sip_fh_key, &uuid_fh_key, sizeof(siphash_key_t));
> +		nn->fh_key = sip_fh_key;
> +	}
> +	ret = scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%pUb\n", nn->fh_key);
> +out:
> +	mutex_unlock(&nfsd_mutex);
> +	trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
> +	return ret;
> +}
> +
>  #ifdef CONFIG_NFSD_V4
>  static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t 
> size,
>  				  time64_t *time, struct nfsd_net *nn)
> @@ -1343,6 +1400,7 @@ static int nfsd_fill_super(struct super_block 
> *sb, struct fs_context *fc)
>  		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
>  		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, 
> S_IWUSR|S_IRUGO},
>  		[NFSD_MinThreads] = {"min_threads", &transaction_ops, 
> S_IWUSR|S_IRUGO},
> +		[NFSD_Fh_Key] = {"fh_key", &transaction_ops, S_IWUSR|S_IRUSR},
>  		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, 
> S_IRUGO},
>  #ifdef CONFIG_NFSD_V4
>  		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, 
> S_IWUSR|S_IRUSR},
> @@ -1615,6 +1673,33 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff 
> *skb,
>  	return ret;
>  }
> 
> +/**
> + * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
> + * @attr: nlattr NFSD_A_SERVER_FH_KEY
> + * @nn: nfsd_net
> + *
> + * Callers should hold nfsd_mutex, returns 0 on success or negative 
> errno.
> + */
> +static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct 
> nfsd_net *nn)
> +{
> +	siphash_key_t *fh_key;
> +
> +	if (nla_len(attr) != sizeof(siphash_key_t))
> +		return -EINVAL;
> +
> +	/* Is the key already set? */
> +	if (nn->fh_key)
> +		return -EEXIST;
> +
> +	fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
> +	if (!fh_key)
> +		return -ENOMEM;
> +
> +	memcpy(fh_key, nla_data(attr), sizeof(siphash_key_t));
> +	nn->fh_key = fh_key;
> +	return 0;
> +}
> +
>  /**
>   * nfsd_nl_threads_set_doit - set the number of running threads
>   * @skb: reply buffer
> @@ -1691,6 +1776,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff 
> *skb, struct genl_info *info)
>  	if (attr)
>  		nn->min_threads = nla_get_u32(attr);
> 
> +	attr = info->attrs[NFSD_A_SERVER_FH_KEY];
> +	if (attr) {
> +		ret = nfsd_nl_fh_key_set(attr, nn);
> +		trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
> +		if (ret && ret != -EEXIST)
> +			goto out_unlock;
> +	}
> +
>  	ret = nfsd_svc(nrpools, nthreads, net, get_current_cred(), scope);
>  	if (ret > 0)
>  		ret = 0;
> @@ -2284,6 +2377,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
>  {
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> 
> +	kfree_sensitive(nn->fh_key);
>  	nfsd_proc_stat_shutdown(net);
>  	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>  	nfsd_idmap_shutdown(net);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index d1d0b0dd0545..c1a5f2fa44ab 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -2240,6 +2240,31 @@ TRACE_EVENT(nfsd_end_grace,
>  	)
>  );
> 
> +TRACE_EVENT(nfsd_ctl_fh_key_set,
> +	TP_PROTO(
> +		const char *key,
> +		int result
> +	),
> +	TP_ARGS(key, result),
> +	TP_STRUCT__entry(
> +		__array(unsigned char, key, 16)
> +		__field(unsigned long, result)
> +		__field(bool, key_set)
> +	),
> +	TP_fast_assign(
> +		__entry->key_set = true;
> +		if (!key)
> +			__entry->key_set = false;
> +		else
> +			memcpy(__entry->key, key, 16);
> +		__entry->result = result;
> +	),
> +	TP_printk("key=%s result=%ld",
> +		__entry->key_set ? __print_hex_str(__entry->key, 16) : "(null)",
> +		__entry->result
> +	)
> +);
> +
>  DECLARE_EVENT_CLASS(nfsd_copy_class,
>  	TP_PROTO(
>  		const struct nfsd4_copy *copy
> diff --git a/include/uapi/linux/nfsd_netlink.h 
> b/include/uapi/linux/nfsd_netlink.h
> index e9efbc9e63d8..97c7447f4d14 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -36,6 +36,7 @@ enum {
>  	NFSD_A_SERVER_LEASETIME,
>  	NFSD_A_SERVER_SCOPE,
>  	NFSD_A_SERVER_MIN_THREADS,
> +	NFSD_A_SERVER_FH_KEY,
> 
>  	__NFSD_A_SERVER_MAX,
>  	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
> -- 
> 2.50.1

-- 
Chuck Lever

