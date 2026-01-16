Return-Path: <linux-fsdevel+bounces-74177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF2D3369D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0330F30B9745
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F922D781;
	Fri, 16 Jan 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WENukcBO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72AA341059
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579929; cv=none; b=AAiEBpaDA0o2n3w05dKjRgtB1m6ucefaZkFEcQ8zipTjQZNr/wVwhqI784SADlzzqby1VNgMAgFAHL/ns+53CDiiiUjk87hnocv3PA5cRqh0mPr32K9AuxJzrGovMB3tfEQgiaCRItl4Jvnb7VgVeiQOWhjDqkFse4EX+7HCcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579929; c=relaxed/simple;
	bh=ZjiVzUpqEPxuT2JBjX6+0+xnAqiXUIIxneeq6rbdWPM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FRQZrErO6Cl4oqIEz+phZNB/56tCPimp3g3hI88D7DRnTFK6aAmWMR8rTjTn10r6vVYJvgbYCnieXme9BZ2Wdmn8tDpnCzIS92zJiE+G0x1JuuGcqYRttuKd+lBDMa/ULSbFf9M4wlLmTGEpRwY/jvmDqWT5qPZVt7v7qHfkidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WENukcBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477BAC4AF0B;
	Fri, 16 Jan 2026 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768579929;
	bh=ZjiVzUpqEPxuT2JBjX6+0+xnAqiXUIIxneeq6rbdWPM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WENukcBOvoxNP3YuW4q7PX/nt0O2pvih2CBNMEoLJQlJtQnaDhJvZFRXgYkwBs+D4
	 JN6MWnKwMv+zOAWkeWG8qf0ssMPRDbamz75a7HBVSMzfvB+NPAxI9Q+krCG3hcoKRB
	 T4F6XJ0ts54zekvJ9DCox5j/YskiyBnte3glt+24bcX4U2oR/kfan1axllKaUKvvXP
	 liAzxumGObA8xxwclXAQj5ne4Pwz/lE9YfgX5EUolqAg9Zd4PtzC1In17KxppAuTWA
	 ujAJjRMx2mJLfAH93urP3M10Pag6DXCwv5Q9e4wmVVsWytHCJutNvCwErm5fenY6R7
	 TRMoXgMh4pz+w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 30693F40071;
	Fri, 16 Jan 2026 11:12:08 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 11:12:08 -0500
X-ME-Sender: <xms:WGNqaX_831z-RwAvkXRUUSE8IjUpPViHOOEIKBpZ-gA91dzwEICjwA>
    <xme:WGNqaehv24oJ3ILTYPrYk7AyNiVWSh4VgQSVM_PZUzp2HM7FxMlBkPvkbEsKOwY1s
    zSUTQqZYh3Ldn5X40m9P7WN0S19UtKgp4UqvOSWYj9p8A8beY5lpDEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelfeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WGNqaQFbPtkvphahmKE_0mQBHl1eGBoH7HgvURURyXaiwoMYqoWcZA>
    <xmx:WGNqaVIQbQUuWO4ZZVzyYaFLR9Yuqvf7QWW4G8_B4U_6B8TTae2mXw>
    <xmx:WGNqaVjYAjyWNWIOD9c8yhJGLqNN3jRiCByS8XVcuyOqfAinW_YW_A>
    <xmx:WGNqablqYw9HaYo21fqcWJIySuOBeywXr7RIze3-KZEAwXw1JyDjXg>
    <xmx:WGNqaUU9TfYOYY6x4Juwt2lDEHnVytUvNX1HcGipn7Bw_1GyjyAClpTi>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0EAD6780076; Fri, 16 Jan 2026 11:12:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AO3h44zqd9zZ
Date: Fri, 16 Jan 2026 11:11:26 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <bb62acdd-4185-41ed-8e91-001f96c78602@app.fastmail.com>
In-Reply-To: 
 <c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v1 2/4] nfsd: Add a key for signing filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
> Expand the nfsd_net to hold a siphash_key_t value "fh_key".
>
> Expand the netlink server interface to allow the setting of the 128-bit
> fh_key value to be used as a signing key for filehandles.
>
> Add a file to the nfsd filesystem to set and read the 128-bit key,
> formatted as a uuid.

Generally I like to see more "why" in the commit message. This
message just repeats what the diff says.

Since the actual rationale will be lengthy, I would say this is
one of those rare occasions when including a Link: tag that refers
the reader to the cover letter in the lore archive might be helpful.


> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
>  fs/nfsd/netlink.c                     | 15 +++++
>  fs/nfsd/netlink.h                     |  1 +
>  fs/nfsd/netns.h                       |  2 +
>  fs/nfsd/nfsctl.c                      | 85 +++++++++++++++++++++++++++
>  fs/nfsd/trace.h                       | 19 ++++++
>  include/uapi/linux/nfsd_netlink.h     |  2 +
>  7 files changed, 136 insertions(+)
>
> diff --git a/Documentation/netlink/specs/nfsd.yaml 
> b/Documentation/netlink/specs/nfsd.yaml
> index badb2fe57c98..a467888cfa62 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -81,6 +81,9 @@ attribute-sets:
>        -
>          name: min-threads
>          type: u32
> +      -
> +        name: fh-key
> +        type: binary
>    -
>      name: version
>      attributes:
> @@ -227,3 +230,12 @@ operations:
>            attributes:
>              - mode
>              - npools
> +    -
> +      name: fh-key-set
> +      doc: set encryption key for filehandles

Nit: "set signing key for filehandles"


> +      attribute-set: server
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - fh-key
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 887525964451..98100ee4bcd6 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -47,6 +47,14 @@ static const struct nla_policy 
> nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
>  	[NFSD_A_POOL_MODE_MODE] = { .type = NLA_NUL_STRING, },
>  };
> 
> +/* NFSD_CMD_FH_KEY_SET - do */
> +static const struct nla_policy 
> nfsd_fh_key_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
> +	[NFSD_A_SERVER_FH_KEY] = {
> +		.type = NLA_BINARY,
> +		.len = 16
> +	},
> +};
> +
>  /* Ops table for nfsd */
>  static const struct genl_split_ops nfsd_nl_ops[] = {
>  	{
> @@ -102,6 +110,13 @@ static const struct genl_split_ops nfsd_nl_ops[] = 
> {
>  		.doit	= nfsd_nl_pool_mode_get_doit,
>  		.flags	= GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		= NFSD_CMD_FH_KEY_SET,
> +		.doit		= nfsd_nl_fh_key_set_doit,
> +		.policy		= nfsd_fh_key_set_nl_policy,
> +		.maxattr	= NFSD_A_SERVER_FH_KEY,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>  };
> 
>  struct genl_family nfsd_nl_family __ro_after_init = {
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index 478117ff6b8c..84d578d628e8 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -26,6 +26,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, 
> struct genl_info *info);
>  int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info 
> *info);
>  int nfsd_nl_pool_mode_set_doit(struct sk_buff *skb, struct genl_info 
> *info);
>  int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info 
> *info);
> +int nfsd_nl_fh_key_set_doit(struct sk_buff *skb, struct genl_info 
> *info);
> 
>  extern struct genl_family nfsd_nl_family;
> 
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
> index 8ccc65bb09fd..aabd66468413 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/fsnotify.h>
>  #include <linux/nfslocalio.h>
> +#include <crypto/skcipher.h>
> 
>  #include "idmap.h"
>  #include "nfsd.h"
> @@ -49,6 +50,7 @@ enum {
>  	NFSD_Ports,
>  	NFSD_MaxBlkSize,
>  	NFSD_MinThreads,
> +	NFSD_Fh_Key,
>  	NFSD_Filecache,
>  	NFSD_Leasetime,
>  	NFSD_Gracetime,
> @@ -69,6 +71,7 @@ static ssize_t write_versions(struct file *file, char 
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
> @@ -88,6 +91,7 @@ static ssize_t (*const write_op[])(struct file *, 
> char *, size_t) = {
>  	[NFSD_Ports] = write_ports,
>  	[NFSD_MaxBlkSize] = write_maxblksize,
>  	[NFSD_MinThreads] = write_minthreads,
> +	[NFSD_Fh_Key] = write_fh_key,
>  #ifdef CONFIG_NFSD_V4
>  	[NFSD_Leasetime] = write_leasetime,
>  	[NFSD_Gracetime] = write_gracetime,
> @@ -950,6 +954,54 @@ static ssize_t write_minthreads(struct file *file, 
> char *buf, size_t size)
>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
>  }
> 
> +/*
> + * write_fh_key - Set or report the current NFS filehandle key
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

Nit: it would be nice to explain (briefly) why fh_key rotation during
server operation is prohibited.


> + */
> +static ssize_t write_fh_key(struct file *file, char *buf, size_t size)
> +{
> +	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
> +
> +	if (size > 35 && size < 38) {
> +		siphash_key_t *sip_fh_key;
> +		uuid_t uuid_fh_key;
> +		int ret;
> +
> +		/* Is the key already set? */
> +		if (nn->fh_key)
> +			return -EEXIST;
> +
> +		ret = uuid_parse(buf, &uuid_fh_key);
> +		if (ret)
> +			return ret;
> +
> +		sip_fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
> +		if (!sip_fh_key)
> +			return -ENOMEM;
> +
> +		memcpy(sip_fh_key, &uuid_fh_key, sizeof(siphash_key_t));

What protects updates of nn->fh_key from concurrent writers?
A race might result in leaking a previous fh_key buffer, when
it should return EEXIST. So you'll need some mutual exclusion
here -- probably nfsd_mutex.

Ditto for the netlink interface.


> +		nn->fh_key = sip_fh_key;
> +
> +		trace_nfsd_ctl_fh_key_set((const char *)sip_fh_key, ret);
> +	}
> +

If user space reads the key before it has been set, would
nn->fh_key be NULL here?


> +	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%pUb\n",
> +							nn->fh_key);
> +}
> +
>  #ifdef CONFIG_NFSD_V4
>  static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t 
> size,
>  				  time64_t *time, struct nfsd_net *nn)
> @@ -1343,6 +1395,7 @@ static int nfsd_fill_super(struct super_block 
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
> @@ -2199,6 +2252,37 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff 
> *skb, struct genl_info *info)
>  	return err;
>  }
> 
> +int nfsd_nl_fh_key_set_doit(struct sk_buff *skb, struct genl_info 
> *info)
> +{
> +	siphash_key_t *fh_key;
> +	struct nfsd_net *nn;
> +	int fh_key_len;
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_FH_KEY))
> +		return -EINVAL;
> +
> +	fh_key_len = nla_len(info->attrs[NFSD_A_SERVER_FH_KEY]);
> +	if (fh_key_len != sizeof(siphash_key_t))
> +		return -EINVAL;
> +
> +	/* Is the key already set? */
> +	nn = net_generic(genl_info_net(info), nfsd_net_id);
> +	if (nn->fh_key)
> +		return -EEXIST;
> +
> +	fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
> +	if (!fh_key)
> +		return -ENOMEM;
> +
> +	memcpy(fh_key, nla_data(info->attrs[NFSD_A_SERVER_FH_KEY]), 
> sizeof(siphash_key_t));
> +	nn = net_generic(genl_info_net(info), nfsd_net_id);
> +	nn->fh_key = fh_key;
> +

On success, "ret" hasn't been initialized. And maybe you want
the error flows above to exit through here to get those return
codes captured by the trace point.

> +	trace_nfsd_ctl_fh_key_set((const char *)fh_key, ret);
> +	return ret;
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> @@ -2284,6 +2368,7 @@ static __net_exit void nfsd_net_exit(struct net 
> *net)
>  {
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> 

To save an extra pointer dereference on the hotter paths, maybe
fh_key should be the actual key rather than a pointer. You can
use kfree_sensitive() when freeing the whole struct nfsd_net, or
just memset the fh_key field before freeing nfsd_net.

Just a random thought.


> +	kfree_sensitive(nn->fh_key);
>  	nfsd_proc_stat_shutdown(net);
>  	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>  	nfsd_idmap_shutdown(net);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index d1d0b0dd0545..2e7d2a4cb7e7 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -2240,6 +2240,25 @@ TRACE_EVENT(nfsd_end_grace,
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
> +	),
> +	TP_fast_assign(
> +		memcpy(__entry->key, key, 16);
> +		__entry->result = result;
> +	),
> +	TP_printk("key=%s result=%ld", __print_hex(__entry->key, 16),
> +		__entry->result
> +	)
> +);
> +
>  DECLARE_EVENT_CLASS(nfsd_copy_class,
>  	TP_PROTO(
>  		const struct nfsd4_copy *copy
> diff --git a/include/uapi/linux/nfsd_netlink.h 
> b/include/uapi/linux/nfsd_netlink.h
> index e9efbc9e63d8..29e5d3d657ca 100644
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
> @@ -90,6 +91,7 @@ enum {
>  	NFSD_CMD_LISTENER_GET,
>  	NFSD_CMD_POOL_MODE_SET,
>  	NFSD_CMD_POOL_MODE_GET,
> +	NFSD_CMD_FH_KEY_SET,
> 
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
> -- 
> 2.50.1

-- 
Chuck Lever

