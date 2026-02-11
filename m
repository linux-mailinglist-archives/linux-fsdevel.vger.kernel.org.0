Return-Path: <linux-fsdevel+bounces-76977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF/6KDv9jGn4wgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 23:05:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F7127F3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 23:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7108830C9D7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 22:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA9031A576;
	Wed, 11 Feb 2026 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABf9170z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA930CDB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847533; cv=none; b=qojQ56CdFqEqmR2joR80iWLBV4JYrbh7iIhPBOnVS+I9JHhcv8bFIRLq6/VL4bXEpQWeyZt0uYXqYepgu1frNc+feAhS458TiPjZ4psY3AOOKcSDf+YQR3elUGrkAEyes84bNhy2cv6cbKj6TrMq5mmFZgXuWQzy4VxdgtB51KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847533; c=relaxed/simple;
	bh=TwwUO04dGqFYl7FBMT/0KdV3iyGcEzy/h2J4D+lHVW0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eg9fXBbeLbhAhMcv8n9GQo6st/rCuKlq8UFRe/+FlDDgNlwgBJPko9OoX1VqberFN84z2KVpG6m9VN3NtIMqSCfmvwYkvF63xGnn5tUrqzvxbYoKovvjel/22Iv3jX962jw/YFkO7jVv3NqsepHlZIIad9G8WrLJyg4MKbU2Slw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABf9170z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F1FC4CEF7;
	Wed, 11 Feb 2026 22:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770847533;
	bh=TwwUO04dGqFYl7FBMT/0KdV3iyGcEzy/h2J4D+lHVW0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ABf9170zn76atTbBiwaYM114Ip3pn23kaBZufP4D3t7vmBu0S8RJ8o7BEaShsrAv2
	 Ku1qUbwYbnXh2nbGvP2t0S/nH4QqXgkfrWoWPHNDvebt0zA/uE6++SVqHe3yc+c2RX
	 EbbEfVXjvQ3Vcq/sMIs/bKnLT+i2y5W24iMMjrZf79F+dfbJJhoxxargkKwKD902vq
	 fPq1YGV9Or2J5AQTPSkVgPRsKvms+sQyQaQEjI6IWX0d8LNt/kznd0cBjTin5L56+a
	 eyIbV6CCMt2XNLiuIXD0xEW3Wq57JFlbvkeGIntU37fnXIDL9/HlAw0FWSdqBdlWpB
	 dGR05QqInP+FQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9DF4CF40068;
	Wed, 11 Feb 2026 17:05:31 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 11 Feb 2026 17:05:31 -0500
X-ME-Sender: <xms:K_2MaeN1831T_ilEmsELlhi2D3K55ootnOaRgJSSQoeqw7Y_OXCF5A>
    <xme:K_2MaXz3Zb-9Tmiq5_nm-Ei7ybtMr2WghtCCVbK-4MP6UlyltCwNy2VG6GSx19JAP
    ur1JHLfM0p_it0RpRR_RCQg3f88W0eQp89xDz-Wnrt5h9qcL8zKE30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefjedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:K_2MaYXtP9S9VSIJVQx3gCtdO9vnF0Bma-50LanoFzuUlevBK1b1nA>
    <xmx:K_2MaYYKa9hpvzl7qjF_4EozP929zgUCFxDOtf-qZ0A_gT0IX5nN8Q>
    <xmx:K_2MaXwY4QDG8hkWuCLqXqchw5AS9tXTpgzvDL_dIrl4H8NLnaIQUg>
    <xmx:K_2MaQ0S1ehCjpAcBneUoiNQCk_U1JSv7ZmLmDHZANd39NT018ce1Q>
    <xmx:K_2MaQn0dsGXilqStsFgmzqua6ddjaKwISWfNcErcbr6Lmmf9apbS8Me>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 74A7E780070; Wed, 11 Feb 2026 17:05:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASi17ho3PCMk
Date: Wed, 11 Feb 2026 17:05:04 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <f75f0d1b-9feb-4a0e-8c4e-4825f59f8053@app.fastmail.com>
In-Reply-To: 
 <cb46e1aee9656be5f3692e239300148813b5c05d.1770828956.git.bcodding@hammerspace.com>
References: <cover.1770828956.git.bcodding@hammerspace.com>
 <cb46e1aee9656be5f3692e239300148813b5c05d.1770828956.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v6 3/3] NFSD: Sign filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-76977-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[hammerspace.com,oracle.com,kernel.org,brown.name,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 115F7127F3B
X-Rspamd-Action: no action

On Wed, Feb 11, 2026, at 12:09 PM, Benjamin Coddington wrote:
> NFS clients may bypass restrictive directory permissions by using
> open_by_handle() (or other available OS system call) to guess the
> filehandles for files below that directory.

> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 68b629fbaaeb..3bab2ad0b21f 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c

> @@ -236,13 +288,18 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
> *rqstp, struct net *net,
>  	/*
>  	 * Look up the dentry using the NFS file handle.
>  	 */
> -	error = nfserr_badhandle;
> -
>  	fileid_type = fh->fh_fileid_type;
> 
> -	if (fileid_type == FILEID_ROOT)
> +	if (fileid_type == FILEID_ROOT) {

Still need a comment here explaining why ROOT is exempt from
file handle signing checks.


>  		dentry = dget(exp->ex_path.dentry);
> -	else {
> +	} else {
> +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
> +			trace_nfsd_set_fh_dentry_badmac(rqstp, fhp, -EKEYREJECTED);
> +			goto out;
> +		} else {
> +			data_left -= sizeof(u64)/4;
> +		}

The data_left bug identified during v5 review:
https://lore.kernel.org/linux-nfs/8574c412-31fb-4810-a675-edf72240ae29@oracle.com/

does not appear to be addressed in v6 3/3. Likewise, the
"sizeof(u64)/4" has not been replaced by a symbolic constant.

Additionally, the goto out path when MAC verification fails has an
error value problem in the !NOSUBTREECHECK case:

    error = nfsd_setuser_and_check_port(rqstp, cred, exp);
    if (error)
        goto out;
    /* error is now nfs_ok (0) */
    ...
    if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
        trace_nfsd_set_fh_dentry_badmac(...);
        goto out;   /* returns nfs_ok */
    }

nfsd_set_fh_dentry() returns 0 without setting fhp->fh_dentry or
fhp->fh_export. The caller __fh_verify() then proceeds with:

    dentry = fhp->fh_dentry;   /* NULL */
    exp = fhp->fh_export;      /* NULL */
    check_pseudo_root(dentry, exp);

check_pseudo_root() dereferences exp on its first line:

    if (!(exp->ex_flags & NFSEXP_V4ROOT))

Can this NULL dereference occur for signed exports that also have
subtree checking enabled?


> +
>  		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
>  						data_left, fileid_type, 0,
>  						nfsd_acceptable, exp);


-- 
Chuck Lever

