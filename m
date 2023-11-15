Return-Path: <linux-fsdevel+bounces-2877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C627EBA89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 01:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21352813A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 00:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D571E393;
	Wed, 15 Nov 2023 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="FTUs0y93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jdUTpEQ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56AD19D;
	Wed, 15 Nov 2023 00:18:45 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AFCD6;
	Tue, 14 Nov 2023 16:18:44 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 103405C017D;
	Tue, 14 Nov 2023 19:18:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 14 Nov 2023 19:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1700007521; x=1700093921; bh=8UNRQ0/oIGU64hY2VFE/OgCRWo1yxL2UGJe
	DwHttqWA=; b=FTUs0y935INg4jxfdThRL3uXzr5gqAt9QL7hQu9Y/miaJ34tym2
	tqgjs/itQ8RO5wfKt+uUR8LZb0uIYPv//MXeMvgcaG2IB9/kjvhlto2Izrq2W5z3
	c6U51N1WGFaY4uNdenVeiwLOcBEXpRwpHPFSW2u2la0vxJasKEH161Fo9k7VBMP/
	P6alYUzewj3v/l8pmc0s4bHxKZpTcNyaVTv4OW8bQOAiwUKSYjVCIBVg14pOTxsm
	Bs9vSzsPnO1+Am1SzgxRLQiVKwdV6Hs4p5kaMKdE1LJCiBzEjSwG9aoskUimGHN5
	k0q8sBRV3IiABe/OP+jEEpLaytdgZgbZFng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1700007521; x=1700093921; bh=8UNRQ0/oIGU64hY2VFE/OgCRWo1yxL2UGJe
	DwHttqWA=; b=jdUTpEQ58PIDhLrD60eos6sb2d3c4qxP1+69A5MK1GXefD3OKYq
	YL69i+Mu41wThrsOxS6E+IFAJL5hsnwCX+PSypH2nbqEDJTUFvVlU3lcR6VIXzY+
	k1jZ/LjQKFzeVlJbYHnhqwGBddY4jTTx7LGr//U7kUHWK0Qb0HTQ0K51iXEWQCd/
	cpihmeRBOhHJywKAtzcvEi86db1ZtFeE+cayULh8jFUiKs7w7BLUt2q3sHGhMeZo
	GVwadqghlmxEawj/J3/TJlk3XZVOsbe1CdQ6UB5pHvlymXfnodzU8fiPkDJTFywn
	1v3ZBN1A08xbTVX0cEJipbTeZiIUY/UMsBA==
X-ME-Sender: <xms:YA5UZZi9QZcD8vUw5J2Tq1DooKs_Qmc4DT6SjQcA804KNzngJuGGUA>
    <xme:YA5UZeBlalczRa8XUhJvGErpfV86VVKMHMK8fa4uQZeIa7J_csZuWPydnbnYb07_c
    w48JrEwK-cZ>
X-ME-Received: <xmr:YA5UZZH4tPGXswII2WWylI435I2kVhrSloIS7pogyyCwegwdxyXCb25eYLCjGtgUbCYp17CBECZMtqYX51iooGcbtcC84ZNmZ7TFxsfD7-Pdotolz97ZQlZ6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epjeegkedvhfekueejgeefieejtdevledvtdelieevveekffejfedtvdehkeefjeeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:YA5UZeSH76lw44TZ0dF2-8tmitV9ptCSrhvLnPgbq4WfCdwzVq3ANg>
    <xmx:YA5UZWx4h8nzjpe1dMlzz1FUB6ExA_Fvd219W-mRv-kKQbSsQ3-5XQ>
    <xmx:YA5UZU7qVbGBtSl8kDgyqyAe9vcLrwIfHragW7Ugs0H_glfQ_KyPzg>
    <xmx:YQ5UZQvTUz3iXKvo7LRK4VrOtI_SzqAIV1Mk05_0AEFUvzFavKnXjg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 19:18:37 -0500 (EST)
Message-ID: <7b982b5e-ecad-1b55-7388-faf759b65cfe@themaw.net>
Date: Wed, 15 Nov 2023 08:18:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com,
 autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ae5995060a125650@google.com>
 <tencent_3744B76B9760E6DA33798369C96563B2C405@qq.com>
 <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
 <20231114044110.GR1957730@ZenIV>
 <e2654c2c-947a-60e5-7b86-9a13590f6211@themaw.net>
 <20231114152601.GS1957730@ZenIV>
From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: fix null deref in autofs_fill_super
In-Reply-To: <20231114152601.GS1957730@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 14/11/23 23:26, Al Viro wrote:
> On Tue, Nov 14, 2023 at 04:30:25PM +0800, Ian Kent wrote:
>
>> I'll prepare a patch, the main thing that I was concerned about was
>>
>> whether the cause really was NULL root_inode but Edward more or less
>>
>> tested that.
> One thing: that was a massaged copy of the variant in my local tree, so
> this
>
>>> 		managed_dentry_set_managed(s->s_root);
> might be worth an explanation; mainline has __managed_dentry_set_managed()
> here, and yes, it is safe since nothing can access it yet, but... it's
> not worth skipping on spin_lock/spin_unlock for ->d_flags update here.

Sorry, do you mean explanation of why we are not skipping the spin lock

or why we are setting automount trigger flags on the autofs root dentry?


Being a trigger mount (type direct or offset) they do need the flags, the

mount is mounted over the trigger.


I guess that including the locking is not going to make much difference.

I don't remember now but it was probably done because there may be many

mounts (potentially several thousand) being done and I wanted to get rid

of anything that wasn't needed.


Ian


