Return-Path: <linux-fsdevel+bounces-67209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F04DC3804E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 22:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC1344ED21E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 21:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245622DAFB8;
	Wed,  5 Nov 2025 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NBHnJwpj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3M/rrUhi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF92C236D;
	Wed,  5 Nov 2025 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378069; cv=none; b=n5YURDpxDuQmUtzARuFI80OXZhMWoF0LYMHA4URtQeX4tcDwOuA9Y9oh2D6lCjhtIA4Oe4RazGr3WvNZrbkC/ACaPF5XlasQU2KZEezr3+9axVq1BtvanY6TEaZU69/7W73eXqJR+86a1Kg0Zsp6g5XadzMx99mD0RAEuyTKOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378069; c=relaxed/simple;
	bh=bsJ/Udr6HIBj2j3DHtF1mJqwIo8FnbCO8DJuuTTp7AY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UF1HRXU3T5n1v8Zh88rIW7d38dZB8hJ0jejZ3gc1padRMQTcbYWaCTCOQvwNpktoLk50XzQixqlOHZnq3MBhRx+DAWwhoLZ2Su+MQ2cijeBGpE6cTL5eoxwAfjUs/0fBrV2lG3tiE/UfiY9pm/8ssIPtPuXQ8Th4fvSrMV60s/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NBHnJwpj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3M/rrUhi; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 0D9511300C27;
	Wed,  5 Nov 2025 16:27:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 05 Nov 2025 16:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762378064; x=1762385264; bh=5CX/6mtoYFxir8X1F5OVPvA/OUy5Hh9/ND3
	R8DtJqdE=; b=NBHnJwpjzuHIsUT27Y57rWaJK10DtVOwxECp26qAgU5U2ikzYZl
	M90AeLnEPJscbb16J19gvwy+B4NZoJRivr0Kl/sDL1WtKYsBIOcIU/852lrhgqq/
	GKpuXfd3fOlM1hSTmng5Eykm2SDZU+rDa1/3QCl4npJjdOdSa4TG9dpLKZzWTZau
	gQKLJddbfSk7iP2cfocCd6lwvv8WNjntDUxjyvhguNRIoYy5cYz8v7pgB6OdrZID
	eo/hzOuwTPvx8j13d20hMasG3aiklwbNYaKqed8tm9GulrRukjfYfVMUU+ubDqNE
	5IFnjPvLo6riN3CKxIUqANOUuK511UeBr+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762378064; x=
	1762385264; bh=5CX/6mtoYFxir8X1F5OVPvA/OUy5Hh9/ND3R8DtJqdE=; b=3
	M/rrUhioH8XUekNhjPbddPDnBn7n7UQz6zEWYhMdJzgaKPUZki5Si9V9oHY1Ogop
	wXK5pvp5JtloGloRJyhjQ+2g3DFkHJIsPf1kJQ9SRoFA1OYYao78/h5ua/7WVVKr
	DX+Ajwtsc07FWpwIeyLBbksAID7RZIbG2vTFcoPvGOBOYPZWyaoKettLH2wbO2Id
	zKDpw89eEUWl/BgYOURwsIfdCSu9Zdtbf8szQKl7cVJ5bzYuDeYhoPqbJZCUYoKO
	UZQ0HyqjcmXxStXvR2TDlvY0c4w3Pn/LIGuOHcFde9b8MNLY8rM1ER7IKpgSaQz2
	fo67zQAgkeqNFzV2z+NIw==
X-ME-Sender: <xms:UMELaTX303FHgII2VhPCDsLqAaz7DXpODKCSAw4DGpYCqOIYMw_8zQ>
    <xme:UMELaalAv0IbTqHYOiNCaxTQxCHNYl3ObvfykhtHLjOM-xv4HXM4-O5UB5FicXKO4
    aJ5vH9vBYrGmrMZ_ywg8xmZ6HOs7HRayKsq762rTphtV6QY5VU>
X-ME-Received: <xmr:UMELaXr1-Ji_La_HqW1BRUEv9gTeMOwPrnbybPjNk5nkzekaJJ_jmOB-OurJPK7b-HcbN7SNbSmn59Pi_qJVyNSOkvZPYWst3NWLBXCl3DJX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvggtrhihphhtfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UMELaas2dgxfilRLBUrQKjBzvFla9FVJzR7OHV29epBrN0TxHC_Zrg>
    <xmx:UMELaXL_tyUQYVcmu-B8I71Pa7g3b9MIUvkmgGp58Io5P9qADq2c4w>
    <xmx:UMELaX8_nhpfJRosFBux8I7DSDNy8EkxssJf6tgxkmBv96HvCzl8zA>
    <xmx:UMELaT6oKvaTbilSvWrldHDoodd9WTL6TODMPNKGUr-HrQG2M0IzRg>
    <xmx:UMELacRM2CO16jgdzCpw14XismqrJauCEWxLaqWueHVYB4MJELrVVaIb>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:27:33 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>, "Tom Talpey" <tom@talpey.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>,
 "David Howells" <dhowells@redhat.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Carlos Maiolino" <cem@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v5 09/17] vfs: clean up argument list for vfs_create()
In-reply-to: <20251105-dir-deleg-ro-v5-9-7ebc168a88ac@kernel.org>
References: <20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org>,
 <20251105-dir-deleg-ro-v5-9-7ebc168a88ac@kernel.org>
Date: Thu, 06 Nov 2025 08:27:31 +1100
Message-id: <176237805165.634289.1849067298194355086@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 06 Nov 2025, Jeff Layton wrote:
> As Neil points out:
> 
> "I would be in favour of dropping the "dir" arg because it is always
> d_inode(dentry->d_parent) which is stable."
> 
> ...and...
> 
> "Also *every* caller of vfs_create() passes ".excl = true".  So maybe we
> don't need that arg at all."
> 
> Drop both arguments from vfs_create() and fix up the callers.
> 
> Suggested-by: NeilBrown <neilb@ownmail.net>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

This I like.

Reviewed-by: NeilBrown <neil@brown.name>

It would be consistent to also remove the 'dir' arg from vfs_mkdir(),
vfs_mknod(), etc.  I wouldn't do that until we find out what other
people think of the change.

Thanks,
NeilBrown



