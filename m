Return-Path: <linux-fsdevel+bounces-78855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNh3MjWDpGnOiwUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 19:19:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C87ED1D1130
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 19:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83434300691F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 18:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CB6334C1C;
	Sun,  1 Mar 2026 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a67ysH+K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC62E7F11;
	Sun,  1 Mar 2026 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772389165; cv=none; b=T4X9bbc2SIAv0pibAjLU0XxRCWEQdL2HuUwHbfYsFXea4UzQYaJwpIRDj//nhXk9dIdZ3Mtc+BT8c+4hdQlW7X00AXMmaoHIbBLTjvwSzaWFULaZAtgttUCJoZ9gjIKCkMol3ZNmgfBgnUEqHVY5ZH9iNGyj26knZBDutx+gdRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772389165; c=relaxed/simple;
	bh=nuBGqJp9wHKEQIFVaF8YscjzAS45MPN091edCGD91Pc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=H/1a0rRb8BkHXTFtEBo4yVRCfuht5bnHrg6BMfaMqkGhX12uyYmkJYtfI5DDB5+qrol+dz9Tmv2wtAkuDuQl6NiYa0so0tGuOF0mwZzO/gnteWptFdAK6bB3vS93EtOGpV59MEkVMEUo3QuQ6+8fXKzqIeJHxSdbI69liCBcZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a67ysH+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A0FC2BC86;
	Sun,  1 Mar 2026 18:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772389164;
	bh=nuBGqJp9wHKEQIFVaF8YscjzAS45MPN091edCGD91Pc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=a67ysH+KFsrmvVX9NW9WMKrKle0oDA8YO3N1osFkQC76lUwf956JCcSNZYZkoHCYq
	 yx/XwOFvIhcw5gXG6IvBJkyGZBQSV6e2mlcUbRqMp3iJRFXNbaH/f//E/I+lHvHAHj
	 CBg1JnxW/0RHkulMImBtIijkj92kCyoPf7WGOr40WNl6VnNFKqy0W+flqo1vVexGHb
	 F5HGkWRidzYqExm5n/YBda3MVQaNlhcuENLaY3/ThtETcZsu0CUiCAIq3rDT1Rzuuy
	 +hXuZz+UxV8F/+1I5RrLELG97yV8sw7VTsh7xMBBgQmnDXnXsoT+1G0mtrd9ghDjrq
	 J+BZVwUMBBVlg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0FFE0F40090;
	Sun,  1 Mar 2026 13:19:23 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 01 Mar 2026 13:19:23 -0500
X-ME-Sender: <xms:KoOkafJlgkFc7WkZ7KP7CH8nkWcbU0dnVi95JHI801-TDlFksa5tCA>
    <xme:KoOkad-nw768MaqtkJ_TP7-aYBmi1hLKIKrD5K1q7W9z3uU5j-aQyTkF4enw2ATuU
    tGwOIyaS-cFEsY3E5Zww4Wwg0RU5BrpWI3wB23hD_Oe0_QZ5FDxJtY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheehgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruh
    hnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomh
    dprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehn
    vghilhgssehofihnmhgrihhlrdhnvghtpdhrtghpthhtohepohhkohhrnhhivghvsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtohhmpdhrtghpthht
    ohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:KoOkaYDGr4O9X1Cx3Uvvh5ExirlmQTmy8nqRmSMefXXOqBCsiTS8Ag>
    <xmx:K4OkaSpWLSfjdN7uI6nVBfXLt8aZHEVbRXXc6DOK6qjsZkBxaG4MXg>
    <xmx:K4OkabF5CA5Mna8BlGyLxeM0mbzfdJ1IGJqqX6pRUA__VUHitRLItA>
    <xmx:K4OkaetUh5YGrr6FtZLThJ1i_7To0M31WQRE6Fzq4lfychmRbv7WzA>
    <xmx:K4OkaZZrfj35Z3Eg0_8plzP7Cbq7xQWh7-bID5bB4eeoY5InKAyNAuUs>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DADFD780070; Sun,  1 Mar 2026 13:19:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVsRjBM015Tw
Date: Sun, 01 Mar 2026 13:19:02 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>, "Christian Brauner" <brauner@kernel.org>,
 "Jan Kara" <jack@suse.com>, NeilBrown <neilb@ownmail.net>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
In-Reply-To: 
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
References: <20260224163908.44060-1-cel@kernel.org>
 <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner>
 <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org>
 <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem unmount
 notification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78855-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,suse.com,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C87ED1D1130
X-Rspamd-Action: no action



On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
> On Sun, Mar 1, 2026 at 6:21=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
>> Perhaps that description nails down too much implementation detail,
>> and it might be stale. A broader description is this user story:
>>
>> "As a system administrator, I'd like to be able to unexport an NFSD
>
> Doesn't "unexporting" involve communicating to nfsd?
> Meaning calling to svc_export_put() to path_put() the
> share root path?
>
>> share that is being accessed by NFSv4 clients, and then unmount it,
>> reliably (for example, via automation). Currently the umount step
>> hangs if there are still outstanding delegations granted to the NFSv4
>> clients."
>
> Can't svc_export_put() be the trigger for nfsd to release all resources
> associated with this share?

Currently unexport does not revoke NFSv4 state. So, that would
be a user-visible behavior change. I suggested that approach a
few months ago to linux-nfs@ and there was push-back.


>> The discussion here has added some interesting corner cases: NFSD
>> can export bind mounts (portions of a local physical file system);
>> unprivileged users can create and umount file systems using "share".
>
> The basic question is whether nfsd is exporting a mount, a filesystem
> or something in between (i.e. a subtree of a filesystem).
>
> AFAIK, the current implementation is that nfsd is actually exporting
> one specific mount, so changing the properties of this mount
> (e.g. readonly) would affect the exported share.

AIUI NFSD can export starting at any arbitrary directory
that appears in the mount namespace. It does not have to
start at the local file system's root directory. But even
so, outstanding NFSv4 delegations on a narrow portion of
a mounted file system will still pin that mount.

--=20
Chuck Lever

