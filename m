Return-Path: <linux-fsdevel+bounces-75396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JvwAqaTdmmpSQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 23:05:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED5F829D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 23:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5481D3009FBB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 22:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEB430DEC7;
	Sun, 25 Jan 2026 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyHfL3ow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC73824BD
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769378706; cv=none; b=eA+lS8dRuldlZKOr4/Yza9nTmClKRMZcPy7t0H0SJGx8veQptAFQYfk1qCnrVv8Rf4JKQedFGvLjQAOuQv40R8sIyeeBahVjgHkW2bdRmvV2mlnXd6L1b4pbE0IDJ/ej+IEFc4BIQVkj7l2KseWi8AS1okRcrBRR4B4f840TEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769378706; c=relaxed/simple;
	bh=kJ6JgpGimrqEkXHyyvMzGefViVzL30DBbsFX3mmThgY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SiUesWWdaxW1CbM0B86scJLcVunqhMiQ1/atfo9sGcfjjmk3u4wqTUcnezOp9s8/On6cQT1FGISbweABTEmiUmhPk0T2xfgPLcdkJSZNKEXXLcVkbyfhr6NkxCc5kq6rSFOzcxVYLqvSfXWwwyYj2bGhH10+531+ArWQHPklq5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyHfL3ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A643C16AAE;
	Sun, 25 Jan 2026 22:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769378706;
	bh=kJ6JgpGimrqEkXHyyvMzGefViVzL30DBbsFX3mmThgY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DyHfL3owAK89asDfhQXM+IKQMD6vTQqEPbBdlwvj3880nuKIlVyf0kJ1GWPbCGPat
	 ucjDTwAD/CkI8yzM7fzV0IV1MPYMuEawgnD5iynCNY1ALkgKv9sFW+xgBFPy2nBWnB
	 Vw+0zrgr5jSTJthmnkVQToa1I1dR/qL6o7Ch+y/wWUAc0vKP1TA6wWml6AXOjXI6Ud
	 wRJJetxsZsBVnKN3ZkHGem1LlGmy9X9i3cYEDDqsf5mulhsYsRhiGDhq8pPLXkSRY9
	 Q/jryTZwAIVg5WNUGz1emfgbxV2fX/c6/OJoOuOkdhXdxGxrwa/yVeRymmj5pXCgov
	 /I04uTvCKfnnw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8D84FF40072;
	Sun, 25 Jan 2026 17:05:04 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 25 Jan 2026 17:05:04 -0500
X-ME-Sender: <xms:kJN2accIXvnGH35KtDNF6o27-vsyP7fzrVQ3dK_GjAydqEa0PFcBrg>
    <xme:kJN2aZBa7y0fs14pjg7lavRyA7jBb1Qhce04atH46-2W2obEGeMJmlkomgp3SRqDp
    RxhMSUHJfOa5bplDrkrJDlMGsPyRyRCS3mbKX_4B0vg8QEm1E6G5Ck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheehleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepfedupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtth
    hopegrughilhhgvghrrdhkvghrnhgvlhesughilhhgvghrrdgtrgdprhgtphhtthhopehs
    lhgrvhgrseguuhgsvgihkhhordgtohhmpdhrtghpthhtoheprhhonhhnihgvshgrhhhlsg
    gvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gtvghmsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhgroheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kJN2aSIv3Pu0DWq4PlLBY4O9yN-ASCFm0sosaH_aM7i9EA4YDsTCuA>
    <xmx:kJN2abYeSpo0MinYvffT8rAw785eZVBG-PcKAL_iaP1ucQhp7re9OQ>
    <xmx:kJN2aYBSjrpqZHogzuyFxSOU5KPVQuDnSKrscsTWeqY38TyPK1u9Gg>
    <xmx:kJN2aVWy8CkKlf6gkg775B1qrJHTuZBvRHE-xJ4xFo2VZTjC_zlGZA>
    <xmx:kJN2aZ0YOApvQBKMC0QERIDFvmWsvDPu2rt_WQDuXHRp4Iy5hsK3cKSX>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5D6FA780076; Sun, 25 Jan 2026 17:05:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdRvsg_UpIrR
Date: Sun, 25 Jan 2026 17:04:28 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
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
Message-Id: <a1692040-58d0-412d-b0fc-c7b7a62585c4@app.fastmail.com>
In-Reply-To: <20260124-gezollt-vorbild-4f65079ab1f1@brauner>
References: <20260120142439.1821554-1-cel@kernel.org>
 <20260123-zwirn-verfassen-c93175b7a1ee@brauner>
 <41b1274b-0720-451d-80db-210697cdb6ac@app.fastmail.com>
 <20260124-gezollt-vorbild-4f65079ab1f1@brauner>
Subject: Re: [PATCH v6 00/16] Exposing case folding behavior
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-75396-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5ED5F829D7
X-Rspamd-Action: no action



On Sat, Jan 24, 2026, at 7:52 AM, Christian Brauner wrote:
> On Fri, Jan 23, 2026 at 10:39:55AM -0500, Chuck Lever wrote:
>> 
>> 
>> On Fri, Jan 23, 2026, at 7:12 AM, Christian Brauner wrote:
>> >> Series based on v6.19-rc5.
>> >
>> > We're starting to cut it close even with the announced -rc8.
>> > So my current preference would be to wait for the 7.1 merge window.
>> 
>> Hi Christian -
>> 
>> Do you have a preference about continuing to post this series
>> during the merge window? I ask because netdev generally likes
>> a quiet period during the merge window.
>
> It's usually most helpful if people resend after -rc1 is out because
> then I can just pull it without having to worry about merge conflicts.
> But fwiw, I have you series in vfs-7.1.casefolding already. Let me push
> it out so you can see it.

There will be at least one more revision of this series (and it can
happen in a few weeks) to split 1/16 as Darrick requested, and
address the nit that Jan noted.


-- 
Chuck Lever

