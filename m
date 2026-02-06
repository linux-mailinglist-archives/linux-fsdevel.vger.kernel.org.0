Return-Path: <linux-fsdevel+bounces-76615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLoiE0cnhmlSKAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:39:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F10410134B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C5733007A41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9543F23C3;
	Fri,  6 Feb 2026 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5o3+MA5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3E2D8DDF
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399553; cv=none; b=iGigf/Ic9/kPq+LcXhaIH8+uiYSwjDrjvF87p+2709lS/a2V6xOpfMq3G9yvW8qkuTEpNpZQKHNONj0tX3xTp6cdXAzd63F6bEURJkJNNVcTC8znLvo0CXpzpN4Wy2eY/25xRTQuNYSQqz5KvT7oL9xSsvBVDAxR/8fiW+3cgfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399553; c=relaxed/simple;
	bh=MFTGnTfw1PKzzEMRYf5QUruDBUxhWLo7952+l3ri5ME=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RBPkfuu09zSiXPmzkOZbIJOieWp507nYi5baEYIhaPhXoSYCD6PpoZlHlg0uhezF0s1vL2AIokq5zMEHIHUawmdnXh5LI28Cro3zhnbnlBgWVfXStVXgyIggyIFc+AMWxsixM7LHUuyE1jjDllvJPLgXrD2XdIS5fq/wcoOobok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5o3+MA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80C9C116C6;
	Fri,  6 Feb 2026 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770399553;
	bh=MFTGnTfw1PKzzEMRYf5QUruDBUxhWLo7952+l3ri5ME=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=O5o3+MA5H3OWomb4flTAsiPiWkLdD7TUDjM5hc3lMXKr3/A5BzWkb0Ed0hWFT9C8t
	 jj2i4RRPtkZOEE/L0mqO0/oZmJ4x5tpxQpBd8qctLjN3+Y54zZahx5bC5dmuc8ICHN
	 mjXCRHVP6k6sMyK3zjb5U4Xk0Tk8gV1j8S53S2C6K4Tw8l3R4cZTy8BC1vOfHMq+v6
	 q0JF5WdDmzFYbTjn2uvNEtvggVUZjG+UBmJF6f6WuRch1+odJoZV4qWJhyPo40wIMq
	 qwOULpN06732pp7hLO0msbQYMuF/FdtCZKzTyw/YDlfe/T83UynB7wEE7RTNoAGS92
	 Xz8rDInIkfyDw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8C86CF4006A;
	Fri,  6 Feb 2026 12:39:11 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 06 Feb 2026 12:39:11 -0500
X-ME-Sender: <xms:PyeGaWVTxk1sIPlK1MslNZC2CmbfYD8jVq5ux3EzqP6_Ryv7OjG_Aw>
    <xme:PyeGadYTCZ_rZuXLoUnpohBW4zns9fc8tVe_HJZ8hOMvzDWQZgtOi6SEj8hD4DvjK
    1oeWIqxrCYf09sx9fWHsXvjC5vWovryJZ7YGH5RLg0yNgSIt3nkyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekjeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:PyeGaRd2rmzTDwxG2YzUbUHcGJm5EY21wvv3C5CcAZaZblY73qWKZQ>
    <xmx:PyeGabBcxpAHlSd6Qy7fH6ljs7TDAh7Zc8fvpy9bZ7h0CqUB9hcnbw>
    <xmx:PyeGaV7QTLaV7WjornJOQWECcGaXAeT49ql6ZdH6ZHEdssF_KZrqAA>
    <xmx:PyeGaUdpP29uDhjj7oqvX8PUjT41XfR3fRUsIJ9ekTWj9JA6rKpuIg>
    <xmx:PyeGabszlDyEhMW9dWptj6zDHvnFAjypYV7C6AbYczFlbFWc2HOzSzc7>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 64D94780077; Fri,  6 Feb 2026 12:39:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfV0Pu1ThoXF
Date: Fri, 06 Feb 2026 12:38:50 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <88c1ea24-2223-4a80-afb0-89c7272dd440@app.fastmail.com>
In-Reply-To: 
 <09698b80d78c7c0a8709967f0f3cf103b3ddad9d.1770390036.git.bcodding@hammerspace.com>
References: <cover.1770390036.git.bcodding@hammerspace.com>
 <09698b80d78c7c0a8709967f0f3cf103b3ddad9d.1770390036.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v4 1/3] NFSD: Add a key for signing filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76615-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[hammerspace.com,oracle.com,kernel.org,brown.name,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.888];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F10410134B
X-Rspamd-Action: no action



On Fri, Feb 6, 2026, at 10:09 AM, Benjamin Coddington wrote:
> A future patch will enable NFSD to sign filehandles by appending a Message
> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
> that can persist across reboots.  A persisted key allows the server to
> accept filehandles after a restart.  Enable NFSD to be configured with this
> key the netlink interface.
>
> Link: 
> https://lore.kernel.org/linux-nfs/cover.1770390036.git.bcodding@hammerspace.com
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---

> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index a58eb1adac0f..55af3e403750 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1571,6 +1571,31 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
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
> +	siphash_key_t *fh_key = nn->fh_key;
> +
> +	if (nla_len(attr) != sizeof(siphash_key_t))
> +		return -EINVAL;
> +
> +	if (!fh_key) {
> +		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
> +		if (!fh_key)
> +			return -ENOMEM;
> +		nn->fh_key = fh_key;
> +	}
> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));
> +	put_unaligned_le64(fh_key->key[0], nla_data(attr));

put_unaligned_le64() takes a value as its first argument and a
destination pointer as its second.  These two lines write the
contents of fh_key->key[0] into the nlattr buffer rather than
reading userspace data into the key.

On the first call, fh_key was just kmalloc'd and contains
uninitialized heap data, so the key is never populated from
userspace input.

Additionally, both lines reference key[0] -- the second should
reference key[1] and write to an offset of nla_data(attr).

The correct form, following the pattern in
fscrypt_derive_siphash_key(), would be something like:

    fh_key->key[0] = get_unaligned_le64(nla_data(attr));
    fh_key->key[1] = get_unaligned_le64(nla_data(attr) + 8);


> +	return 0;
> +}
> +
>  /**
>   * nfsd_nl_threads_set_doit - set the number of running threads
>   * @skb: reply buffer


-- 
Chuck Lever

