Return-Path: <linux-fsdevel+bounces-2096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F647E264B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 15:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8068B281582
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53D25107;
	Mon,  6 Nov 2023 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Jkr+U9Ti";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DXkSqb4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D089249F6
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:53 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC0DBF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 06:08:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 3F17D3200950;
	Mon,  6 Nov 2023 09:08:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 06 Nov 2023 09:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1699279730; x=1699366130; bh=eibgNUcdpu43gd1WH4ELoJJ2gUiCqNLiN9H
	+8bxdpkA=; b=Jkr+U9Tidk1DHubuVXRByNODFBjaNXjsS0L+WQnosZH7zVE+Bjj
	bXI44HEtzHfa554HaIAIBgA2431OEcX1/Al7nQSolU/NaC8z6UXce3PeFdi73bs8
	IPQ+m57hb0F4gd/ernv55ySeU7BUPurisXAT5OZICbVaIi1FbyGF7qCeWvjqAJ/S
	Bo9tBZEMDTA/aQr6+XmfQ1u07GMHCxU6bUuCidLmJZjnjn38oatGmQivxB2VYmGH
	6/cU/70TxoYp/Dc6PSIwDm3vcVqNiSTmqgOtsOShyvbOpJRd4jZ2ILbEImv9C7al
	rHdiADUS3zJgt/BWOH/ZZTTF4lFATr3ICsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1699279730; x=1699366130; bh=eibgNUcdpu43gd1WH4ELoJJ2gUiCqNLiN9H
	+8bxdpkA=; b=DXkSqb4GF45n8q1iC3YUC7s7EDuEH3tCvr/cCRGolbKQ5J6em2a
	6AlCiapraT0yZwlb2WmXFYW7s4pVSijbYDT2oHfluZEKSvBo0aCtTALPQRZLNJux
	rn8oa+Hrhi3X0mpdR8wzkRZaM/Bp3k3jQrDhoAxuK9lYFCJXqyeM1WZMsO3gjApJ
	dGggzHqI1IP0PbjbcsvK+IG7WKbgKOdpSdADkD9ClUCgLZARX1pfeWsVr7Hy5sKn
	me2546x/m5qVDdAeMfzQqQN8QEDFn8VcVm+awj5ODrZSFv1Y/6CqeG+UqGU05yrb
	tq4y+wcEY+80rZlHJp73LXqXyOhSUFpHiTw==
X-ME-Sender: <xms:cvNIZZ4k8nM768vdqGKo8k13_iaD3xRlj0sLO-7jDpRrjyglOl-yAA>
    <xme:cvNIZW6nnfhhGIVUMgZJJSuveuKoampMkgWckLBJqCLGDKCI5n6TpTxi1-FBFdDLo
    ijYN6IPy18-MvEi>
X-ME-Received: <xmr:cvNIZQd2VTREeHEIi3R4ix7A1avXUetdmnSmW3T8szJLTR7HuydUa9u5euuvILj9qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddugedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:cvNIZSL3xDVoXMEuvHFRYk3zBiMLL677HROgHmFQGFH8H2hOT1CNig>
    <xmx:cvNIZdKJgWbCr-Lm9onHpw9YG109QjXrVWtD32YfYMhyLhRYQTTNNw>
    <xmx:cvNIZbz2eLGar0vepNyp26XPR4c6jLjFf0o-vP79joXPe5ACdXE9_Q>
    <xmx:cvNIZaG2y6W8NJMhZg0dhavHczhKpzszEqRh3fR0bHA3bYsjawoTEg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Nov 2023 09:08:49 -0500 (EST)
Message-ID: <32469b14-8c7a-4763-95d6-85fd93d0e1b5@fastmail.fm>
Date: Mon, 6 Nov 2023 15:08:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
To: Miklos Szeredi <miklos@szeredi.hu>, Tyler Fanelli <tfanelli@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, gmaglione@redhat.com,
 hreitz@redhat.com
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
Content-Language: en-US
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegtVbmFnjN_eg9U=C1GBB0U5TAAqag3wY_mi7v8rDSGzgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Miklos,

On 9/20/23 10:15, Miklos Szeredi wrote:
> On Wed, 20 Sept 2023 at 04:41, Tyler Fanelli <tfanelli@redhat.com> wrote:
>>
>> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the purpose
>> of allowing shared mmap of files opened/created with DIRECT_IO enabled.
>> However, it leaves open the possibility of further relaxing the
>> DIRECT_IO restrictions (and in-effect, the cache coherency guarantees of
>> DIRECT_IO) in the future.
>>
>> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its purpose. It
>> only serves to allow shared mmap of DIRECT_IO files, while still
>> bypassing the cache on regular reads and writes. The shared mmap is the
>> only loosening of the cache policy that can take place with the flag.
>> This removes some ambiguity and introduces a more stable flag to be used
>> in FUSE_INIT. Furthermore, we can document that to allow shared mmap'ing
>> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
>>
>> Tyler Fanelli (2):
>>    fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
>>    docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
> 
> Looks good.
> 
> Applied, thanks.  Will send the PR during this merge window, since the
> rename could break stuff if already released.

I'm just porting back this feature to our internal fuse module and it 
looks these rename patches have been forgotten?


Thanks,
Bernd

