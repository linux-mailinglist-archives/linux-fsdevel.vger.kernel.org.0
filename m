Return-Path: <linux-fsdevel+bounces-75749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJKbMM01eml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:14:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AFEA54B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D36E3058AB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD88930C60D;
	Wed, 28 Jan 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmSQyHTe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE203093A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616629; cv=none; b=aod4YOZyyX0oBG4kNAuI76hh3W0gSXBDFIN8TkZPsoz8eegUcgWURFK04JeFH8nrGtblnj2lfWJvqJZ7i4PFOm/PxZMmIDN4Eaey+ow4bFbMekPbKdStmccTLTqPfM0lT9WjEhIJAh/ftTHQmEBrulVWY7zoIVORj8Oq51mm8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616629; c=relaxed/simple;
	bh=09yykJGA09GAb6bXsIvujqOvg+rbtgLoyAWIF2nhBRE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iZ4vc7c6tIk6layQCHzbXIYlFj6N69Mrwn7ZUzMtJWsh9ORvVi2t3Mmn8lheeeQxgxQllqkNUeCxA5MohwxdHuxp5s/W0u9bD2d6B+yxex95zqel6Zn/Wnzuga8tT7wAuQAJuCEsuUfPPfAibwcMkdrI+RUw1WRiXNr2cRsqnSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmSQyHTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A92FC4CEF1;
	Wed, 28 Jan 2026 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769616628;
	bh=09yykJGA09GAb6bXsIvujqOvg+rbtgLoyAWIF2nhBRE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KmSQyHTe7nSMAyKr9PM284BwbjbKByFMMG1IZvazqUnUA/ROv33wULbdrxDcVnx70
	 xEH1u2X7AxNQpbMlIrRxuNmwYYnp5DM7mtVIO8NewfRxe7zxDmb3ny/uYMMZYeUN/F
	 HM5BvDN/4Li4h2rLFQCM3gZ3a9vjur9/RTEi5sg23poEydNjcrV4QNcWDb7NcVMtbD
	 fPIK1QKCGF009nzQAkTof5xM5YoH6XrCnYdTQHM5oNydkdXj0ZHlyO3pDkZ95oyBNI
	 /wpldfR4yS2s/z5+bnjlJO0Y+1woQgrNW/9OwYxEKMe8eXwKC6ff8n5T0HSb32+s6u
	 vg5pXBquM5XCQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8D762F4006A;
	Wed, 28 Jan 2026 11:10:27 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 28 Jan 2026 11:10:27 -0500
X-ME-Sender: <xms:8zR6aZ2SisiSU0nau9c90FRXY5lA9QZxdMyBMOczCkCsrIlhuXXlVA>
    <xme:8zR6aa5OBA2OO07_F1fMbqwO5hmc4DJ7ha6aRl_RCR7-zjwW6H14iRUOl1xx2mqlA
    vtX3JGeAH8OSwe0I3FTlTXN-204EJ_l8aOtQ6roJoLPcAUbbuC_mPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrmhhirhejfehilh
    esghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hhtghhsehlshhtrdguvgdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghl
    vgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8zR6aeHOWiJZyup8suq9aUf0W1YwzzgvdeRbZoLmx5IDIUXKun91Dw>
    <xmx:8zR6afzxlR24oLzVamtn_fvj6uVL0upSPoGoePEh-UMjJRnwwQIjOQ>
    <xmx:8zR6aY1sl7Vo39HXvsy3nPaTEBzGTPLCLirk6LQAlvpJngJ07-CUCw>
    <xmx:8zR6afrMxyylhquCU70oMRdW0k-A3TdGwtG2YbuTYnU3mZMRDNwWrA>
    <xmx:8zR6aVUbWck4LSAEsXy7jdZfFwXN3gMoJNn4hHe_GpH_HpNM64Te3Jn2>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6C844780070; Wed, 28 Jan 2026 11:10:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyEaqJ85SK6V
Date: Wed, 28 Jan 2026 11:09:56 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Amir Goldstein" <amir73il@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 NeilBrown <neil@brown.name>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <34bda263-4b41-4388-b58a-6fdab6d1fb49@app.fastmail.com>
In-Reply-To: <20260128111645.902932-2-amir73il@gmail.com>
References: <20260128111645.902932-1-amir73il@gmail.com>
 <20260128111645.902932-2-amir73il@gmail.com>
Subject: Re: [PATCH v3 1/2] exportfs: clarify the documentation of open()/permission()
 expotrfs ops
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75749-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 55AFEA54B9
X-Rspamd-Action: no action

Typo in Subject: s/expotrfs/exportfs


On Wed, Jan 28, 2026, at 6:16 AM, Amir Goldstein wrote:
> pidfs and nsfs recently gained support for encode/decode of file handles
> via name_to_handle_at(2)/opan_by_handle_at(2).

s/opan/open

And one more below:


> These special kernel filesystems have custom ->open() and ->permission()
> export methods, which nfsd does not respect and it was never meant to be
> used for exporting those filesystems by nfsd.
>
> Update kernel-doc comments to express the fact the those methods are for
> open_by_handle(2) system only and not compatible with nfsd.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  include/linux/exportfs.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 262e24d833134..fafd22ed4c648 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -192,7 +192,9 @@ struct handle_to_path_ctx {
>  #define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR)
> 
>  /**
> - * struct export_operations - for nfsd to communicate with file systems
> + * struct export_operations
> + *
> + * Methods for nfsd to communicate with file systems:

Let's not remove the brief description for the export_operations
struct in the Doxygen output.


>   * @encode_fh:      encode a file handle fragment from a dentry
>   * @fh_to_dentry:   find the implied object and get a dentry for it
>   * @fh_to_parent:   find the implied object's parent and get a dentry for it
> @@ -200,6 +202,10 @@ struct handle_to_path_ctx {
>   * @get_parent:     find the parent of a given directory
>   * @commit_metadata: commit metadata changes to stable storage
>   *
> + * Methods for open_by_handle(2) syscall with special kernel file systems:
> + * @permission:     custom permission for opening a file by handle
> + * @open:           custom open routine for opening file by handle
> + *
>   * See Documentation/filesystems/nfs/exporting.rst for details on how to use
>   * this interface correctly and the definition of the flags.
>   *
> @@ -244,10 +250,14 @@ struct handle_to_path_ctx {
>   *    space cannot be allocated, a %ERR_PTR should be returned.
>   *
>   * @permission:
> - *    Allow filesystems to specify a custom permission function.
> + *    Allow filesystems to specify a custom permission function for the
> + *    open_by_handle_at(2) syscall instead of the default permission check.
> + *    This custom permission function is not respected by nfsd.
>   *
>   * @open:
> - *    Allow filesystems to specify a custom open function.
> + *    Allow filesystems to specify a custom open function for the
> + *    open_by_handle_at(2) syscall instead of the default file_open_root().
> + *    This custom open function is not respected by nfsd.
>   *
>   * @commit_metadata:
>   *    @commit_metadata should commit metadata changes to stable storage.
> -- 
> 2.52.0

-- 
Chuck Lever

