Return-Path: <linux-fsdevel+bounces-75314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNRHA2vpc2nhzQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 22:34:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B87AF06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 22:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5E393005174
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB3C2F6910;
	Fri, 23 Jan 2026 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3Zaz0ep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909729E113
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769204063; cv=none; b=THYJG8WYwbKIlSme7WPAd95mIWYMMfO5QgzdRHFkofJdxa3MNrR6p2RNxi/rVLi4iyr2zfXQe0yS8wTr9C4/KdfQs9cS9ykhvju5o3a5Sy02VQAqC+KgAPX5YqR5XYY98xJYC51Ya995rHP7XQ8fABdFmN7AQYP0cQPuDi0J8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769204063; c=relaxed/simple;
	bh=vw2/q88ZQdbNmtifK6znXic6JJELdzqo7BH4BvuRUvE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Jrw4ILpQ+NKfuH+cknzP1Ji3VGPvcQXlilov8pSEUyw7yQT18gjbeDSNYASCV3UJYNKtEHl01/I8sP8e5RQ4LDGz8p4Mqomgau1vHaObuch3Zusk+iOEaOGNOlLAt9pngCNH/LdjpQGcGu9EszMk5Mq/hddKLjztIZ/APJLwVno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3Zaz0ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF62C19423;
	Fri, 23 Jan 2026 21:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769204063;
	bh=vw2/q88ZQdbNmtifK6znXic6JJELdzqo7BH4BvuRUvE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=m3Zaz0ephijmdY+tk3sAaL9iBYU1d9GpPILkphzwiiARcEJ5LnTf4RHb1+tuDKAVf
	 HB2Sn43M3M5j0qZTCA654n9rrjMZpFXb3bsdl87HVO+/Z0TGs6KD2dhpELsP9Kn76e
	 TetKF42Ec+MGg+WM6tMXXLxr8zIWGdrvo25452nkLQmo2ajfwnibtsMLmQYBoLbHI/
	 Hf7+/28lYDH4ps6AkhcgLKfHs5ETzulNYldkBSKJ5CouSNFspR7h8nQnlmWWcuBf+x
	 fIFwDI0axlRftJlOAHhIeI6k1jZI8ENO3tnS4dB9gzJO3kxsc1f5JNdB6FckRLLcHf
	 T+WgPl2Dw3UgA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DEDFDF4006A;
	Fri, 23 Jan 2026 16:34:21 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 23 Jan 2026 16:34:21 -0500
X-ME-Sender: <xms:XelzaZvPjK4vfn9B0yXiTNAzLXfNTkUR_Jgn7s6GIU_5FUazJFeFOQ>
    <xme:XelzadR67HxgsZy_rDJt95z-R3g8oOi7doYq7f16ybgf6htRTxKu4q4gWFm3zDdJ5
    -in9hYJuYehcdCfsrr6yNgJQ2Kc_cuFzMQZCTG-_twdMb54jwYhiaKT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtuddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Xelzaf04ueCMVVFqZuctZRBW5SNcxjTCww-smmiUkmaSz93OIMHdrQ>
    <xmx:XelzaZ78fcQM2SXZ5yR-0jnSCmZURiAtRX_2ZJ-unv743uMxm2QD8w>
    <xmx:XelzabS8k4iVXyhDLOF_5SOZLy_3hhITT1WHkxw9NDpRJOnCe2-Myw>
    <xmx:XelzaeVNDyMxJJswRQUYQbL63NigESwmzQktIwIlqRYjsKGEx7yb9g>
    <xmx:XelzaQF_JllNltrRcc6qGm2IO6ii9SlKXsYaHyQFSACposv4ES6BVFyu>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B866F780070; Fri, 23 Jan 2026 16:34:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvBI4pOdhfek
Date: Fri, 23 Jan 2026 16:33:36 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <5fb38378-a8e0-46d5-956c-de1a3bdaaf23@app.fastmail.com>
In-Reply-To: 
 <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
 <0aaa9ca4fd3edc7e0d25433ad472cb873560bf7d.1769026777.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75314-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[hammerspace.com,oracle.com,kernel.org,brown.name,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2E7B87AF06
X-Rspamd-Action: no action



On Wed, Jan 21, 2026, at 3:24 PM, Benjamin Coddington wrote:
> NFS clients may bypass restrictive directory permissions by using
> open_by_handle() (or other available OS system call) to guess the
> filehandles for files below that directory.
>
> In order to harden knfsd servers against this attack, create a method to
> sign and verify filehandles using siphash as a MAC (Message Authentication
> Code).  Filehandles that have been signed cannot be tampered with, nor can
> clients reasonably guess correct filehandles and hashes that may exist in
> parts of the filesystem they cannot access due to directory permissions.
>
> Append the 8 byte siphash to encoded filehandles for exports that have set
> the "sign_fh" export option.  The filehandle's fh_auth_type is set to
> FH_AT_MAC(1) to indicate the filehandle is signed.  Filehandles received from
> clients are verified by comparing the appended hash to the expected hash.
> If the MAC does not match the server responds with NFS error _BADHANDLE.
> If unsigned filehandles are received for an export with "sign_fh" they are
> rejected with NFS error _BADHANDLE.
>
> Link: 
> https://lore.kernel.org/linux-nfs/cover.1769026777.git.bcodding@hammerspace.com
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  fs/nfsd/nfsfh.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/nfsd/nfsfh.h |  3 ++
>  2 files changed, 73 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ed85dd43da18..ea3473acbf71 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -11,6 +11,7 @@
>  #include <linux/exportfs.h>
> 
>  #include <linux/sunrpc/svcauth_gss.h>
> +#include <crypto/utils.h>
>  #include "nfsd.h"
>  #include "vfs.h"
>  #include "auth.h"
> @@ -137,6 +138,61 @@ static inline __be32 check_pseudo_root(struct 
> dentry *dentry,
>  	return nfs_ok;
>  }
> 
> +/*
> + * Append an 8-byte MAC to the filehandle hashed from the server's 
> fh_key:
> + */
> +static int fh_append_mac(struct svc_fh *fhp, struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct knfsd_fh *fh = &fhp->fh_handle;
> +	siphash_key_t *fh_key = nn->fh_key;
> +	u64 hash;
> +
> +	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
> +		return 0;
> +
> +	if (!fh_key) {
> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not 
> set.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
> +		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d 
> would be greater"
> +			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), 
> fhp->fh_maxsize);
> +		return -EINVAL;
> +	}
> +
> +	fh->fh_auth_type = FH_AT_MAC;
> +	hash = siphash(&fh->fh_raw, fh->fh_size, fh_key);
> +	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
> +	fh->fh_size += sizeof(hash);
> +
> +	return 0;
> +}
> +
> +/*
> + * Verify that the the filehandle's MAC was hashed from this filehandle
> + * given the server's fh_key:
> + */
> +static int fh_verify_mac(struct svc_fh *fhp, struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct knfsd_fh *fh = &fhp->fh_handle;
> +	siphash_key_t *fh_key = nn->fh_key;
> +	u64 hash;
> +
> +	if (fhp->fh_handle.fh_auth_type != FH_AT_MAC)
> +		return -EINVAL;
> +
> +	if (!fh_key) {
> +		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, 
> fh_key not set.\n");
> +		return -EINVAL;
> +	}
> +
> +	hash = siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key);
> +	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)], &hash, 
> sizeof(hash));
> +}
> +
>  /*
>   * Use the given filehandle to look up the corresponding export and
>   * dentry.  On success, the results are used to set fh_export and
> @@ -166,8 +222,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
> *rqstp, struct net *net,
> 
>  	if (--data_left < 0)
>  		return error;
> -	if (fh->fh_auth_type != 0)
> +
> +	/* either FH_AT_NONE or FH_AT_MAC */
> +	if (fh->fh_auth_type > 1)
>  		return error;
> +
>  	len = key_len(fh->fh_fsid_type) / 4;
>  	if (len == 0)
>  		return error;
> @@ -237,9 +296,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
> *rqstp, struct net *net,
> 
>  	fileid_type = fh->fh_fileid_type;
> 
> -	if (fileid_type == FILEID_ROOT)
> +	if (fileid_type == FILEID_ROOT) {
>  		dentry = dget(exp->ex_path.dentry);
> -	else {
> +	} else {
> +		if (exp->ex_flags & NFSEXP_SIGN_FH && fh_verify_mac(fhp, net)) {
> +			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp, -EKEYREJECTED);
> +			goto out;
> +		}
> +
>  		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
>  						data_left, fileid_type, 0,
>  						nfsd_acceptable, exp);
> @@ -495,6 +559,9 @@ static void _fh_update(struct svc_fh *fhp, struct 
> svc_export *exp,
>  		fhp->fh_handle.fh_fileid_type =
>  			fileid_type > 0 ? fileid_type : FILEID_INVALID;
>  		fhp->fh_handle.fh_size += maxsize * 4;
> +
> +		if (fh_append_mac(fhp, exp->cd->net))
> +			fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
>  	} else {
>  		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
>  	}
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 5ef7191f8ad8..7fff46ac2ba8 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -59,6 +59,9 @@ struct knfsd_fh {
>  #define fh_fsid_type		fh_raw[2]
>  #define fh_fileid_type		fh_raw[3]
> 
> +#define FH_AT_NONE		0
> +#define FH_AT_MAC		1

I'm pleased at how much this patch has shrunk since v1.

This might not be an actionable review comment, but help me understand
this particular point. Why do you need both a sign_fh export option
and a new FH auth type? Shouldn't the server just look for and
validate FH signatures whenever the sign_fh export option is
present?

It seems a little subtle, so perhaps a code comment somewhere could
explain the need for both.


> +
>  static inline u32 *fh_fsid(const struct knfsd_fh *fh)
>  {
>  	return (u32 *)&fh->fh_raw[4];
> -- 
> 2.50.1

-- 
Chuck Lever

