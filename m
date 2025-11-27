Return-Path: <linux-fsdevel+bounces-70001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844CFC8DE67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F283AC740
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10D932C333;
	Thu, 27 Nov 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ka/lpb95";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ms5xnA/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D92E88BB;
	Thu, 27 Nov 2025 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241630; cv=none; b=eNKhoruAcwxBwkoSqXHP5+Y9MT5loYk4IbXYXNrrB8DD/Ew7mU4tnNUUnk6YVdmp+vMs6h35zD34BQMpTaVH35n7ajq62ghxqTP4rc0Hgn+BbAhdTXebnFZO+9RDudp95IUBxzuJ9IBprz2EO9PdtLNnUolFI6fqLHkYJnSNWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241630; c=relaxed/simple;
	bh=HkBd2PnP2K/+bMjcvkK7yrb9pbkDjya1rb823D1Fcag=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Y62r2oFl6gOJTPg7c/B8MjQgRCfwneS52K7WzqJET94BbK08H4L+rzGUEPFK58IxpH4/XSP5NULwt2sZq2v/3QK212Y68RwRAJzjFnqtqW6MOzuS06TnX4e+LowU2LvnOnRQhPnGdFLvGUxSlQuyEzutDKpj4sGnwYdwN2GawDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ka/lpb95; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ms5xnA/R; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 3934213002C9;
	Thu, 27 Nov 2025 06:07:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 27 Nov 2025 06:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764241627; x=1764248827; bh=m686wgdc6rAxQpfWyfWaFqyG5nu4q2ogZY9
	nkpeW1PE=; b=ka/lpb951xyrUAhG228/mNtM/Zb9CjXuyuVQmzJs0zy6mIUSv+8
	27XbMO2idf1NWcxigbnwXlZWeQYu0m5gs2qBCAnsvYzXRiNj67BflxygkrwFNewY
	RkRuep2U5ALdKQFt4+4CCk6GeSyrCxEuikoJ6Y7vUgWzf0PWB7Ol6uoOLjGEml8D
	pbV+sGvXx+C9HItTFqbNNTyNyBVRU1c36Hv0s4pt/xxL7i9AKq6y91OAH63evckO
	x0MVXnfZ8/GAxa65+ef/XWPDbgslK04E5CPTk89S9JFHjxAVwn8Lgkczl8skdG74
	3NOjBt/91SsI4rEGj3HlJ6nhVuNyP3oSQkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764241627; x=
	1764248827; bh=m686wgdc6rAxQpfWyfWaFqyG5nu4q2ogZY9nkpeW1PE=; b=M
	s5xnA/RELvPaIKfoYDyxpt6wKNPRae1X3vEoeGdovZBw7eEkrADfocpCTCkTGgMb
	Oq/tBsYlAVe4oEtyD82733pyf7utzAd7zJ3NDbGRKvcRJCUyd2dBrS+wvMUFRaiK
	dHCdMa9TIOKnrPvlmLY6TfFH+RQcGG3Ul7af7JNqjvTdSkHnDvNeoxOdq7iSL/aG
	5ocRkgOBWoaCr5x5B3nByaAj4MbPEA70y80ml8PflOjJzqQP3IahZQSGlGVVTMUe
	wPsBJuQPOJNQcvA55LtVKnZj39egORZlnj2USFqP7PKaIhK43mZosPjVqc8I7HYO
	hGUyTknRFA43YmpTEpNQA==
X-ME-Sender: <xms:2TAoaaB11YFlS2f6wd6h4jfbETQ-9-jeye7yhKZX6JXoPrQGDqHWFQ>
    <xme:2TAoaZmjEiykDgCLVW_GPBdHLx9bIxx1xPG6Jc7S1he2zy3wtswqCvGYQTBopQHz_
    4Ea5sOCXbqZ6A2DbCQzjZ1kzTzA0t9daZgqib1dj98T-jukeVQ>
X-ME-Received: <xmr:2TAoaaljHe1k06sSs1PaDKWniCu09rNffC_V-qJcdQDwteiF6ONhtZAqnewfvxbffeJ5qr_iC-UQxi68duzRY0yDbkGir9K5iZL-YTnpepe7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeejtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:2TAoaWfmB0ALOniHx1zW9AacCFYVD5fLnqMOL3YO5AlOZ4rz17fYVw>
    <xmx:2TAoaQw74tDplhDPWvATTSLE4zXp3wG1ArOQZRBzSLzkq2_1ZjALvw>
    <xmx:2TAoaYv6TFwNcJAzl9venNBL9E0uF7_-JcSW_t1M4YdygybdaNa6Ag>
    <xmx:2TAoadqjPNS0cVjqyMonmMxrVa_pCcpnpniXDI9BOyRhhfLoHJyRPA>
    <xmx:2zAoaUfBxXG1RVPgWI2CO0psTGTJvAtu_rsnDw18bmzCEnY1zT9_1teQ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 06:06:55 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chris Mason" <clm@fb.com>, "David Sterba" <dsterba@suse.com>,
 "David Howells" <dhowells@redhat.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Namjae Jeon" <linkinjeon@kernel.org>,
 "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Carlos Maiolino" <cem@kernel.org>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Stefan Berger" <stefanb@linux.ibm.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 00/15] Create and use APIs to centralise locking for
 directory ops
In-reply-to: <20251114-baden-banknoten-96fb107f79d7@brauner>
References: <20251113002050.676694-1-neilb@ownmail.net>,
 <20251114-baden-banknoten-96fb107f79d7@brauner>
Date: Thu, 27 Nov 2025 22:06:53 +1100
Message-id: <176424161356.634289.1248496397204103747@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 14 Nov 2025, Christian Brauner wrote:
> On Thu, Nov 13, 2025 at 11:18:23AM +1100, NeilBrown wrote:
> > Following is a new version of this series:
> >  - fixed a bug found by syzbot
> >  - cleanup suggested by Stephen Smalley
> >  - added patch for missing updates in smb/server - thanks Jeff Layton
> 
> The codeflow right now is very very gnarly in a lot of places which
> obviously isn't your fault. But start_creating() and end_creating()
> would very naturally lend themselves to be CLASS() guards.

I agree that using guards would be nice.  One of my earlier versions did
that but Al wants the change to use guards to be separate from other
changes.  I'll suggest something at some stage if no-one else does it first.

> 
> Unrelated: I'm very inclined to slap a patch on top that renames
> start_creating()/end_creating() and start_dirop()/end_dirop() to
> vfs_start_creating()/vfs_end_creating() and
> vfs_start_dirop()/vfs_end_dirop(). After all they are VFS level
> maintained helpers and I try to be consistent with the naming in the
> codebase making it very easy to grep.
> 

I don't object to adding a vfs_ prefix.
(What would be really nice is of the vfs_ code was in a separate vfs/
directory, but that is probably too intrusive to be worth it).

Thanks,
NeilBrown


