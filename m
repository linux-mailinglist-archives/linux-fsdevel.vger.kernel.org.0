Return-Path: <linux-fsdevel+bounces-76618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNMEMh4qhmm1KAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:51:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA6D101779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B50433070B1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73873425CFC;
	Fri,  6 Feb 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeG/16Bu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FB425CC7
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400059; cv=none; b=t5V81wNYvMOGy6m7Kc+hNvC1V0lXYV7aSkfRLWaLA2koVl9bypKbfIRaPjTx+4TxfZ5htV+NU/yMXECQ1ygMxFjCVyhTnb10u4SkVm88UTfaar0oZCkkAqrveZvnvXThcAo4/PckUf/qtU+TAe2palFH6qhuaMC864ErwaXa6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400059; c=relaxed/simple;
	bh=eGHyO3nZ+BVDjRrZ4xSq5FENEf8MBQZR6hC9Qs6g2qU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RsY0MGwrqJ4mNmzR1Wh21fs/aTcZXHqFa6Fep5sXh2r5iw1a0SKo5wnaO7VSnNkcRzNgFvJoxjHBNHnSw3GALCgFXsTV2XHNb+AQ8iiSf4sMS6GTADNtffUD3oru+OwaXKbcxo3d47Oy6DjZOLKJZ7xvK9prjPhpTJqNEhI2tMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeG/16Bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E749C4AF09;
	Fri,  6 Feb 2026 17:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770400058;
	bh=eGHyO3nZ+BVDjRrZ4xSq5FENEf8MBQZR6hC9Qs6g2qU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NeG/16BuzVeDULRLHCoiWx0dRmU5MYswh6WW8PidyHE9TpG/FFYUU01MBnW8lYg6D
	 PSIQYBasm8XEa3qeSc6FJpM8NZ+DP6fga6nIZ1+DbbPYpPyjiPUqv6gpt16dTczAy0
	 h95ku9a+BbdB4TKo9tQQ4pQj6Fpar820j51atK/2wSVK/051d0hucdQa5v+RprV46a
	 yIa3AfYPWfioa1L6SWvnve5su/gvbi7oEbMMSG/gf8H/ge4Vorz7L8AXyArjbufa1K
	 I+nmMlwV7gxYgsWgwAmolYp9vEzPh6wreyRRIpaOE2ZdXtDYCa5HOsAbWcKgmFMT/g
	 I54VxMVw/yGYw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5B12FF4006A;
	Fri,  6 Feb 2026 12:47:37 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 06 Feb 2026 12:47:37 -0500
X-ME-Sender: <xms:OSmGafPL17Gh4KwG4b85Si8P9FJ7JU11Z-mMu_v2ska7aiVL-1dUAQ>
    <xme:OSmGaUz8sDN14HIeAKKYRuzi3ZHuUNn4nMYUiCw3itM9RFJ2Ox-zA22L2mEbmkW4q
    rpREEf3r6ZCk18DZnBue1R534G0Vm-jyFUc7YH6GMOZxuGwzzRxbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekkeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:OSmGaRXsN9rtCJ2tLCuGpI5YrsUBX7SyM0hUUs1Rr0M5KE5DaxJZRg>
    <xmx:OSmGadbNd74vg_LYCTbq1LWmQb2MqGYz2IZkKl15J4IOpEzt0Ilg5g>
    <xmx:OSmGaYwhitlv3_n62yvejoYyvQf8gfjwCVn9kuddNQN5CQs-6rqo1w>
    <xmx:OSmGad1NskGG_CLauesjgLizZviXvcunSIfIbdPeCQExa52ScZIUYw>
    <xmx:OSmGaZlLJt9V2wnB7fifmYaAyFO-L6zHCYNlZPtFdGE7v-RPh5EXeop4>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 371B5780077; Fri,  6 Feb 2026 12:47:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AbzEDecHu5PJ
Date: Fri, 06 Feb 2026 12:47:16 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Message-Id: <3865f8f2-186f-4750-8b6f-1a589723fdf7@app.fastmail.com>
In-Reply-To: 
 <d34d4f79a7d4c6b77ad260f925cb51c34fd53ce5.1770390036.git.bcodding@hammerspace.com>
References: <cover.1770390036.git.bcodding@hammerspace.com>
 <d34d4f79a7d4c6b77ad260f925cb51c34fd53ce5.1770390036.git.bcodding@hammerspace.com>
Subject: Re: [PATCH v4 3/3] NFSD: Sign filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76618-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[hammerspace.com,oracle.com,kernel.org,brown.name,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.738];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2CA6D101779
X-Rspamd-Action: no action



On Fri, Feb 6, 2026, at 10:09 AM, Benjamin Coddington wrote:
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
> the "sign_fh" export option.  Filehandles received from clients are
> verified by comparing the appended hash to the expected hash.  If the MAC
> does not match the server responds with NFS error _BADHANDLE.  If unsigned
> filehandles are received for an export with "sign_fh" they are rejected
> with NFS error _BADHANDLE.
>
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> ---
>  Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
>  fs/nfsd/nfsfh.c                             | 64 +++++++++++++++-
>  2 files changed, 147 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/filesystems/nfs/exporting.rst 
> b/Documentation/filesystems/nfs/exporting.rst
> index de64d2d002a2..54343f4cc4fd 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -238,3 +238,88 @@ following flags are defined:
>      all of an inode's dirty data on last close. Exports that behave 
> this
>      way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
>      waiting for writeback when closing such files.
> +
> +Signed Filehandles
> +------------------
> +
> +To protect against filehandle guessing attacks, the Linux NFS server 
> can be
> +configured to sign filehandles with a Message Authentication Code 
> (MAC).
> +
> +Standard NFS filehandles are often predictable. If an attacker can 
> guess
> +a valid filehandle for a file they do not have permission to access via
> +directory traversal, they may be able to bypass path-based permissions
> +(though they still remain subject to inode-level permissions).
> +
> +Signed filehandles prevent this by appending a MAC to the filehandle
> +before it is sent to the client. Upon receiving a filehandle back from 
> a
> +client, the server re-calculates the MAC using its internal key and
> +verifies it against the one provided. If the signatures do not match,
> +the server treats the filehandle as invalid (returning 
> NFS[34]ERR_STALE).

The documentation says NFS[34]ERR_STALE, but the code in
nfsd_set_fh_dentry() returns nfserr_badhandle on MAC failure.
The commit message also says _BADHANDLE.

Should the code be returning nfserr_stale here to match the
documentation, or should the documentation say BADHANDLE?

IMHO STALE is the right answer for this purpose.


> +
> +Note that signing filehandles provides integrity and authenticity but
> +not confidentiality. The contents of the filehandle remain visible to
> +the client; they simply cannot be forged or modified.
> +
> +Configuration
> +~~~~~~~~~~~~~
> +
> +To enable signed filehandles, the administrator must provide a signing
> +key to the kernel and enable the "sign_fh" export option.
> +
> +1. Providing a Key
> +   The signing key is managed via the nfsd netlink interface. This key
> +   is per-network-namespace and must be set before any exports using
> +   "sign_fh" become active.
> +
> +2. Export Options
> +   The feature is controlled on a per-export basis in /etc/exports:
> +
> +   sign_fh
> +     Enables signing for all filehandles generated under this export.
> +
> +   no_sign_fh
> +     (Default) Disables signing.
> +
> +Key Management and Rotation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The security of this mechanism relies entirely on the secrecy of the
> +signing key.
> +
> +Initial Setup:
> +  The key should be generated using a high-quality random source and
> +  loaded early in the boot process or during the nfs-server startup
> +  sequence.
> +
> +Changing Keys:
> +  If a key is changed while clients have active mounts, existing
> +  filehandles held by those clients will become invalid, resulting in
> +  "Stale file handle" errors on the client side.
> +
> +Safe Rotation:
> +  Currently, there is no mechanism for "graceful" key rotation
> +  (maintaining multiple valid keys). Changing the key is an atomic
> +  operation that immediately invalidates all previous signatures.
> +
> +Transitioning Exports
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +When adding or removing the "sign_fh" flag from an active export, the
> +following behaviors should be expected:
> +
> ++-------------------+---------------------------------------------------+
> +| Change            | Result for Existing Clients                      
>  |
> ++===================+===================================================+
> +| Adding sign_fh    | Clients holding unsigned filehandles will find   
>  |
> +|                   | them rejected, as the server now expects a       
>  |
> +|                   | signature.                                       
>  |
> ++-------------------+---------------------------------------------------+
> +| Removing sign_fh  | Clients holding signed filehandles will find 
> them |
> +|                   | rejected, as the server now expects the          
>  |
> +|                   | filehandle to end at its traditional boundary    
>  |
> +|                   | without a MAC.                                   
>  |
> ++-------------------+---------------------------------------------------+
> +
> +Because filehandles are often cached persistently by clients, adding or
> +removing this option should generally be done during a scheduled 
> maintenance
> +window involving a NFS client unmount/remount.
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 68b629fbaaeb..23ca22baa104 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c

> @@ -240,9 +292,14 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst 
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

When a signed filehandle arrives from a client, fh->fh_size
includes the 8-byte MAC. data_left is computed earlier as
fh->fh_size / 4, so it includes 2 extra u32 words from the
MAC.

After fh_verify_mac() succeeds, data_left is passed unchanged
to exportfs_decode_fh_raw(). The filesystem's fh_to_dentry
callback receives an fh_len that is 2 words larger than the
actual file ID data.

Current filesystem implementations only check minimum fh_len,
so the extra words are harmless in practice. Does data_left
need to be reduced by sizeof(u64) / 4 after MAC verification
so that exportfs_decode_fh_raw() receives the correct file ID
length?


-- 
Chuck Lever

