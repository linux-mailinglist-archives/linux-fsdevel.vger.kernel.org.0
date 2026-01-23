Return-Path: <linux-fsdevel+bounces-75183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHWBKQ/Ecmk/pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:42:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC6A6ED4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FBF8300E3BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9633E363;
	Fri, 23 Jan 2026 00:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShZI1/yN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C5314D0C;
	Fri, 23 Jan 2026 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128961; cv=none; b=uTNxrb1t/03f9ZtBy3bVPBtvb5X6npzet81voa4qPnJDNprXAgnomF+fh16CwhgLjenGF3SFdVMrIDuiUlC/gwwiTpB0Wl7qBjGNG4kb4X5YgZL3LmQijs6NRdKcApa/IusvqQjJYm+enoZCfTORqad6XJQ/opfSoK7PTMqU8Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128961; c=relaxed/simple;
	bh=YxGwcerMm4XsXjm+1niJ1WYBTECA2bIMf19KywNaCDg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X8nUQ0SKpcKOkvkkJnGibow4R7U6en93Fn2uuXx6nEVLKhDcxgYrydFjF1XFj4Bd5VYkEDkeBzrugVokNZ66E4oAjR4cbYaqAKILLnZU38r2PUXzjRDP0XUBzKfSGNPkY8cwdXOwnvRcqU3RjaJCIcHCb6BoUrXWthpPVkqVuC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShZI1/yN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D617C4AF09;
	Fri, 23 Jan 2026 00:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769128961;
	bh=YxGwcerMm4XsXjm+1niJ1WYBTECA2bIMf19KywNaCDg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ShZI1/yNzfRZmu3sAjPE26FJHVCzdjNlR+PLLp4IBIjapKolYcMC/p/AzlQi8kHOy
	 E6N/2W2E5pbB7ftb730Cw4JH/VlIVqvxbnyT1of+3pueWWa9Uliru6CZhIiNC88aWu
	 VqzFK4TQxalFuLYdfa7Gk1bYZr2eTNdyfe6gSwFV/oQuP8DRhWTVOPyO0H6/XntitM
	 tBUss/brfrvJZRVZ5OZuEX1lA9AjU+iqu/0VZA+qg0XEwsarVMGki7cWdIvd9MnvDN
	 8t5ul/t6LL2uITv0UmRDtXRalCIU4WNFGdULXYG+BjWbMjHexyK30Qy9s4VGX+KALh
	 C96ziga6Ri68w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 37676F40068;
	Thu, 22 Jan 2026 19:42:39 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 22 Jan 2026 19:42:39 -0500
X-ME-Sender: <xms:_8NyacyT6qdzAUxIj7fj3Nsl5-8VCaqp1T4qK26YUXr5Y2aLA_2NeQ>
    <xme:_8NyabEJSUOtxd1CnvO613uISWenl61hqckxjKSALI97Y6gbT7BTG5imlp1tVtD5E
    dZmK-v-K3MOUkKiTHhKdFXjV_m_beGWUd8A8yfrOFy-NV1DzTUMBrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepfeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtth
    hopegrughilhhgvghrrdhkvghrnhgvlhesughilhhgvghrrdgtrgdprhgtphhtthhopehs
    lhgrvhgrseguuhgsvgihkhhordgtohhmpdhrtghpthhtoheprhhonhhnihgvshgrhhhlsg
    gvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gtvghmsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgroheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_8Nyae8fZEj0DQVrfCxr0FyILU_fNTywtQD_OdmOVcWNU77PmfI2QA>
    <xmx:_8NyaVi4xh0mDAqTYl6Aak7mh9kYy0ReitnlyVgR-YCNKQ747f-2xw>
    <xmx:_8Nyac8j6VWHBiYHUbMz1HkDlTHqHH88I_1l7dpKX9shblHKGUUhGQ>
    <xmx:_8NyaZQERqfU2S5JiAxoVvJLMQM2fwqj5pfagVYnH43qwMV8tHCRpg>
    <xmx:_8NyaXduDdH_fuVXwK1_-Pl2iicEZJxM3cCk9MYctO41spFo2tlD5lzS>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F0153780076; Thu, 22 Jan 2026 19:42:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A--SnukTeK5R
Date: Thu, 22 Jan 2026 19:42:15 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>,
 almaz.alexandrovich@paragon-software.com,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 frank.li@vivo.com, "Theodore Tso" <tytso@mit.edu>,
 adilger.kernel@dilger.ca, "Carlos Maiolino" <cem@kernel.org>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Chao Yu" <chao@kernel.org>, "Hans de Goede" <hansg@kernel.org>,
 senozhatsky@chromium.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <bb2bb55c-6078-4494-9851-c684dfd9aa8c@app.fastmail.com>
In-Reply-To: <20260123002646.GL5945@frogsfrogsfrogs>
References: <20260122160311.1117669-1-cel@kernel.org>
 <20260122160311.1117669-2-cel@kernel.org>
 <20260123002646.GL5945@frogsfrogsfrogs>
Subject: Re: [PATCH v7 01/16] fs: Add case sensitivity flags to file_kattr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-75183-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0BC6A6ED4A
X-Rspamd-Action: no action



On Thu, Jan 22, 2026, at 7:26 PM, Darrick J. Wong wrote:
> On Thu, Jan 22, 2026 at 11:02:56AM -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Enable upper layers such as NFSD to retrieve case sensitivity
>> information from file systems by adding FS_XFLAG_CASEFOLD and
>> FS_XFLAG_CASENONPRESERVING flags.
>>=20
>> Filesystems report case-insensitive or case-nonpreserving behavior
>> by setting these flags directly in fa->fsx_xflags. The default
>> (flags unset) indicates POSIX semantics: case-sensitive and
>> case-preserving. These flags are read-only; userspace cannot set
>> them via ioctl.
>>=20
>> Remove struct file_kattr initialization from fileattr_fill_xflags()
>> and fileattr_fill_flags(). Callers at ioctl/syscall entry points
>> zero-initialize the struct themselves, which allows them to pass
>> hints (flags_valid, fsx_valid) to the filesystem's ->fileattr_get()
>> callback via the fa argument. Filesystem handlers that invoke these
>> fill functions can now set flags directly in fa->fsx_xflags before
>> calling them, without the fill functions zeroing those values.
>
> In hindsight I regret not asking for the file_kattr initialization
> change to be in a separate patch.

If I=E2=80=99m asked to post another revision of this series, I=E2=80=99=
ll look at splitting
1/16 into two patches.


>> Case sensitivity information is exported to userspace via the
>> fa_xflags field in the FS_IOC_FSGETXATTR ioctl and file_getattr()
>> system call.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>
> The UAPI changes still look ok to me.  AFAICT the file_kattr
> initialization now seem like they don't zap fields to confuse
> vfs_fileattr_get.
>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>


--=20
Chuck Lever

