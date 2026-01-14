Return-Path: <linux-fsdevel+bounces-73803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E9ED20F42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 20:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 990B630167BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCAE344023;
	Wed, 14 Jan 2026 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmSzr7lh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD95341653;
	Wed, 14 Jan 2026 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417304; cv=none; b=teNQ/v3HHl+15alRpgDX59rbM6quxMHjmr5D2sqbF8bJhXi9Ke7MT4FcjlF1s5UCOEK44pCIqBb8G+g5y8gkTR1LQgDgQY6fl5yoQ8b6gjRPSlnXeZCZMeC3thUlcVWk7SDsMLmq0EJBNEIQyp5YE7URq8fDpx8MkdpSZ41RN3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417304; c=relaxed/simple;
	bh=g3HtMKjfyATIBUdWx1OR9FO8cTMPuWSW1+k1E5kr5Ro=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VxN6TBibbkIrQkKVkvjApUwvcyb3T9Sh/y/CHq+xiLRLtvkwHeHEJvtSu+JQWjC2UgeGFCD237AclxPYGofMsvlW01qqh0zgER3Aq9nnMfDKUYWlhC43bMS0FJnbp4FnE3u9smwUWna7UhhksGZsEPlKF8bbMxOIGOTTuNXeBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmSzr7lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D634C4AF09;
	Wed, 14 Jan 2026 19:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768417303;
	bh=g3HtMKjfyATIBUdWx1OR9FO8cTMPuWSW1+k1E5kr5Ro=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RmSzr7lhjh+SuI9fbDFJqw3m4IxQqe0Vaw/b4gJyKK720wWjau1KqfMxKznmVkrZF
	 2N4O6Bc0hb3WeXj4ciDmf782K3DI5ihFjeykVR4v9aMYRWzgIvLCPlEU/VYFogjxxd
	 TwYC1zhLfa6RMe5c0zdIa7aho1huL0kXcWrQilKkAodh38mBiyLoXi8jbO4A6/cYKq
	 kb9KdmvOiYoOkyCHYk0p3k/a89l8lKnHoutJdPmPnYoP/vPV7lMSZwo9bj4hOplvIK
	 3yCvPqJcuulNZMjplUve1lfq9qmXEN1Xfq94K31oj6Pp0Il2HBvbUSiGlGVM0IPhZy
	 GckkrZ4BzTQlw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 18121F40069;
	Wed, 14 Jan 2026 14:01:42 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 14 Jan 2026 14:01:42 -0500
X-ME-Sender: <xms:FehnaUaTdCeNbFj2CKINFlp9fPSNczpMhRHj7Olxm8fSeDvjCeuchg>
    <xme:FehnaaNsCt3HngjIzva8RqVGiR2aFvCG4ua1a4ChD9d6wRY_elyhnSAD9Bxz6nOsX
    hiVfoVAp2xsUW290HXq3DGZGHK9bEWtNGj4xg8AHTCkmQfG6UfCGo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefleeiucetufdoteggodetrf
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
    gvrhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvhhirhgrsehimhgrphdrshhushgv
    rdguvgdprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    hrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvmheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghhrghosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FuhnaWW-M5daRxCF30M52eDLwDirM00lmSqE5Xc12ecFyTnNlLY56w>
    <xmx:FuhnafvkpwPyPR2KRXo5eKd8vRsR0YkZIXmsZrE6ry1YE33KuXSRkw>
    <xmx:Fuhnaa3oCsZSMQFQkIpOksUyk4s72_d3YiPbjNg3YdxOmFSZRimCGQ>
    <xmx:FuhnaeUABkFkasQSrfCIVLfMKlSjqShOkGxbIUShzGsCY5K1wb-Kog>
    <xmx:FuhnaYPaF8tb8lmdcQNpcC4_UvYC2VoD3Kzk5nif1Pt2r8jOSw-dObLv>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DE8C8780070; Wed, 14 Jan 2026 14:01:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOV0ZFhAWQu-
Date: Wed, 14 Jan 2026 14:01:14 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jan Kara" <jack@suse.cz>
Cc: vira@imap.suse.de, "Christian Brauner" <brauner@kernel.org>,
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
Message-Id: <7b6aa90f-79dc-443a-8e5f-3c9b88892271@app.fastmail.com>
In-Reply-To: 
 <3kq2tbdcoxxw3y2gseg7vtnhnze5ee536fu4rnsn22yjrpsmb4@fpfueqqiji5q>
References: <20260114142900.3945054-1-cel@kernel.org>
 <20260114142900.3945054-2-cel@kernel.org>
 <3kq2tbdcoxxw3y2gseg7vtnhnze5ee536fu4rnsn22yjrpsmb4@fpfueqqiji5q>
Subject: Re: [PATCH v4 01/16] fs: Add case sensitivity info to file_kattr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Jan 14, 2026, at 1:11 PM, Jan Kara wrote:
> On Wed 14-01-26 09:28:44, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> Enable upper layers such as NFSD to retrieve case sensitivity
>> information from file systems by adding case_insensitive and
>> case_nonpreserving boolean fields to struct file_kattr.
>> 
>> These fields default to false (POSIX semantics: case-sensitive and
>> case-preserving), allowing filesystems to set them only when
>> behavior differs from the default.
>> 
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ...
>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>> index 66ca526cf786..07286d34b48b 100644
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -229,10 +229,20 @@ struct file_attr {
>>  	__u32 fa_nextents;	/* nextents field value (get)   */
>>  	__u32 fa_projid;	/* project identifier (get/set) */
>>  	__u32 fa_cowextsize;	/* CoW extsize field value (get/set) */
>> +	/* VER1 additions: */
>> +	__u32 fa_case_behavior;	/* case sensitivity (get) */
>> +	__u32 fa_reserved;
>>  };
>>  
>>  #define FILE_ATTR_SIZE_VER0 24
>> -#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
>> +#define FILE_ATTR_SIZE_VER1 32
>> +#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER1
>> +
>> +/*
>> + * Case sensitivity flags for fa_case_behavior
>> + */
>> +#define FS_CASE_INSENSITIVE	0x00000001	/* case-insensitive lookups */
>> +#define FS_CASE_NONPRESERVING	0x00000002	/* case not preserved */
>
> This is a matter of taste so not sure what others think about it but
> file_attr already have fa_xflags field and there is already one flag which
> doesn't directly correspond to on-disk representation (FS_XFLAG_HASATTR) so
> we could also put the two new flags in there... I have hard time imagining
> fa_case_behavior would grow past the two flags you've introduced so u32
> seems a bit wasteful.

No problem. I'll wait for additional guidance on this.


-- 
Chuck Lever

