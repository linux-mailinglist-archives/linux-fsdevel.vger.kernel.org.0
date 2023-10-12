Return-Path: <linux-fsdevel+bounces-202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4337C7806
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 22:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD57282C8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 20:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B273D394;
	Thu, 12 Oct 2023 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="IbrHVHNW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sk7jwblU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B79D53C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 20:44:29 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A189CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 13:44:28 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id EEB5B5C01E2;
	Thu, 12 Oct 2023 16:44:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 12 Oct 2023 16:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1697143467; x=1697229867; bh=G6H86tQ5FIWslUbWHSyQcjyY8AYHNPa6p77
	fjIFjUgw=; b=IbrHVHNWYnUDqN4NrAkObiUWo1tKBKR5HfwA+pIG8WnaCUss619
	j2sNIcbSXQG14NNMG/x4qgkHFk3+zCLj4SZ2KZyDzluqY0nO+pf7CUaAKyeuQp+N
	AkNSmnfiED3dogsPw7BSMT/Z7qJGTHNX8i/9IB3FmRZ4oufYUS/GOlo5JjvT6N8C
	CzaGDbR8t3k2Ie/uS2N22qodyI6Y266SspFnUeBk6mrMU1KWKtjDC+VqlI+QF9j8
	uBkle3loDEbkYbx79jj9WDskyjdISWUXvlPYmVMrl7vy9+RP5KoarGjnxeD2LycN
	dnvvEM6oejywsrgU+kjGb2ha7NNvrOjJ3Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1697143467; x=1697229867; bh=G6H86tQ5FIWslUbWHSyQcjyY8AYHNPa6p77
	fjIFjUgw=; b=Sk7jwblUFwM/faypHZcyCSuMjXMae3q1osLX5YMxvLXn8WLKcw/
	s8XgMml+iXNdiRsdp1Q3apL+pX8fine+GEG7lgGYInejAB2gPQknvswyNh8LonDW
	F3YgZOKA00jdchlrphT5z3JgEmUwq05YryT5sbUiGDkVzzVTgjqu63TbGtJ5hdGm
	N6Nq451wbYon/pbrRHkIlRPLCXD55nk/nv8bHMj61CSR4nzbGJVoMCkNr6ZjQamW
	sVGFxrFHqzvxDM7k1WkE6+HPK9urBqnHjoSsfhAv4K3TOvtMhG7rKAgw366LPjJl
	QeWJ59h0cIZL+G9/YwVCu4/CLgpVXi0KYLA==
X-ME-Sender: <xms:q1ooZegwvhjgmzwa08QeCIFe_YHifwY_nTE5pmm77twShabJMZGawg>
    <xme:q1ooZfBewfYHFORX5dLHh4FnvA8L9MC_6g75DYJmMTogvz_NhUH7DEmMWaEyDqinq
    Q0UhKOe5qvZ7pfD>
X-ME-Received: <xmr:q1ooZWFkQWgpnV4QsBjkftDKKRGS32D87V4Oghjxvxxjt3DqBwhyPA_4LWSNNZUmUsgZKFbQDTCj18s5zUH6gyYC9ScmaMZr6C0wSvSgHBvEn_0Z0vLz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnheptddugefgjeefkedtgefhheegvddtfeejheeh
    ueeufffhfeelfeeuheetfedutdeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:q1ooZXRPVhBeigHmS5Kp6adWlWZObdKI65oA9_hoX1B2tubpwLpssg>
    <xmx:q1ooZbzQVZOqMsGrekGf1unby2MGGQBo_qwGHxLbzDqxOcUgNOEmEQ>
    <xmx:q1ooZV5kScuDH5OIBBCIYSPastkN7JWJ1LY3HAfh_CyV-Vfw1FBeSQ>
    <xmx:q1ooZSmgOZmRZUGTZ1TNnyw0Oa8iyfQnI5YquRlxO_qY1OurU3GGWg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 16:44:26 -0400 (EDT)
Message-ID: <afd45cb5-7aec-4a48-b932-95fb3f644ecb@fastmail.fm>
Date: Thu, 12 Oct 2023 22:44:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/7] fuse: introduce atomic open
Content-Language: en-US, de-DE
To: Bernd Schubert <bschubert@ddn.com>, Yuan Yao <yuanyaogoog@chromium.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "miklos@szeredi.hu" <miklos@szeredi.hu>, Dharmendra Singh <dsingh@ddn.com>,
 Horst Birthelmer <hbirthelmer@ddn.com>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
References: <20230920173445.3943581-1-bschubert@ddn.com>
 <20230920173445.3943581-3-bschubert@ddn.com>
 <7616CA3C-312F-4F9F-9BB3-903D3A77289B@chromium.org>
 <db0cb59d-66b8-480c-abd4-0bb235d68908@ddn.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <db0cb59d-66b8-480c-abd4-0bb235d68908@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Yuan,

>>
>> My concernn is: what is the expected behavior for opening a symbolic
>> link, both on the kernel side and the server side? Is it possible for
>> the fuse server to return the dentry containing the inode of the link
>> destination instead of the inode of the symbolic link itself?
> 
> nfs_atomic_open handles -ELOOP. Possibly fuse server needs to check for
> O_NOFOLLOW, but I'm not sure. Will look into that in the morning.
> 


thanks again for testing atomic open and reporting the symlink issue. 
And sorry for the delay.

Actually interesting that it was not caught by xfstests (or I somehow 
didn't notice) Horst (in CC) is currently adding fuse specific tests - 
we will catch it in the future. Will also check for existing symlink 
tests - this is actually not fuse specific...

I just pushed an initial fix to

https://github.com/bsbernd/linux/tree/atomic-open-for-6.5-v10
https://github.com/libfuse/libfuse/pull/813

I'm going to add further changes for symlinks, though. Right now atomic 
open just reports -ELOOP and then falls back to fuse_create_open, which 
sends a lookup - atomic_open now adds in overhead - the opposite of what 
I want. I had tried to return the attributes and the error for 
atomic_open, but that is not accepted in fuse_dev_do_write(). It would 
be possible to hack that function with checks for FUSE_OPEN_ATOMIC, but 
it would be rather hackish. So we need to extend fuse_entry_out with the 
error code, or add a new struct.

Thanks,
Bernd

