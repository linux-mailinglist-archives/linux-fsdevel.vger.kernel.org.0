Return-Path: <linux-fsdevel+bounces-1521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EA27DB2DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 06:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E415A1C209DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 05:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9DA186F;
	Mon, 30 Oct 2023 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="bxjFLz7G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LSDQuzyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049E17C0
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 05:37:37 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABABBC;
	Sun, 29 Oct 2023 22:37:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 1235D3200937;
	Mon, 30 Oct 2023 01:37:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 30 Oct 2023 01:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698644250; x=1698730650; bh=KlwqU26/TGhYg5i9/XVkf+zLh3xMVm+1VcQ
	XYi/nzIU=; b=bxjFLz7GBjkmMmXRmQYLNY5j/3HDKh5dSWNuahcG7NeEqMKTEwv
	9/qDvl+AgqwxTQQKbd93b/Ba91Z3NpKX6eW0IF1IaYlshR0AYQHBCJDkBtuI0Jsd
	pzKeVCPk8/DuotQIC5pxP5EpDpRtaQ7f0m2Qt6YAfAsaeWgaMBZt6FxB8SsLJRAK
	c3t69pQuxSFJtt2giTn3oDV+LRxkQuqUhwDCYhbCz18hY+93bPEbG/0F3sQflRSg
	0x/E/bfOsl6dpkgaqMRmvwRzGHgwCGqpaeckRLBa/Emk6im0A8U1GWNqVZziMnZc
	DcYMbEGBAN95jY71+zNKfr25zUpU1VwtZOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698644250; x=1698730650; bh=KlwqU26/TGhYg5i9/XVkf+zLh3xMVm+1VcQ
	XYi/nzIU=; b=LSDQuzyZ852n5SdjaR0R0vJHVrHJkmUAG1EOBZazSTv5+J2RjI6
	G24gBrLLpWpfRb+hbrVt9qgTzoCzQSTYd/567ySL53FXzsjamMS9Mqi5DAWNwvW2
	j1HA2grZ3ecdAy+511jmhJzBw6iIa/jbFb7VN8kL0WELUFL+bd7LVkRllo/5tLqG
	0XnSotZZ3rFRUGHKYb8A/Ix9nqsJ+rimXsnkuZwsUb1sG4qE3OBn+/o/SEgwmtJn
	B21V+cFVsf7wwh5Lx818MriK4apSEpjxFZpRBo4ghyl7KOrjgoqp4eHt48wnhVkC
	BQsazS/T+49+JHlcJhmv4n0ZFIX/BhE9HNQ==
X-ME-Sender: <xms:GUE_ZVP0TWY92X1mUJs17BYd3bpq6iNcnlONyiTus16yLm91HicCPw>
    <xme:GUE_ZX-1LRc-pBMS7B9wV_3zTjdF_d8rM5QXSaqf64ZjUrFLT8JhPFxKqZSFEj39v
    QnQwEluiZkj>
X-ME-Received: <xmr:GUE_ZUS5-lnTzT63ChMIS0aWSvbJr2bwK8f4TIdA-b_5C1skVxmZyt9eDcQNSBtw9uD93H6S4niTqAgY-g1kmKIfqoiJ4dQgaF4hUhMj8QxUVUAUcoCX7fcV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleelgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuhffvvehfjggtgfesthekredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eiveelkefgtdegudefudeftdelteejtedvheeuleevvdeluefhuddtieegveelkeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:GUE_ZRtmx5n2Pt8GUxOwfcskEpb8rIhqA3f7NpkOR0M2G1Wh5T2lPg>
    <xmx:GUE_Zdd_ymZLR_JgM40DbvS-kVQywf3xCuqk8a3vBahdpVM8MQv3ug>
    <xmx:GUE_Zd00LoCgk4mlqBY4XBfLimcgMlzTozWvmZsbmdby04rM2sNfsw>
    <xmx:GkE_Zb1HqFhb2XhpLKpKMcZtSVj3Y4gcEv6x5vbGNL-ekOOuuMWJjQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 01:37:24 -0400 (EDT)
Message-ID: <dfb5f3d5-8db8-34af-d605-14112e8cc485@themaw.net>
Date: Mon, 30 Oct 2023 13:37:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/6] mounts: keep list of mounts in an rbtree
From: Ian Kent <raven@themaw.net>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org,
 linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
 David Howells <dhowells@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>,
 Amir Goldstein <amir73il@gmail.com>, Matthew House
 <mattlloydhouse@gmail.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-3-mszeredi@redhat.com>
 <b69c1c17-35f9-351e-79a9-ef3ef5481974@themaw.net>
 <CAOssrKe76uZ5t714=Ta7GMLnZdS4QGm-fOfT9q5hNFe1fsDMVg@mail.gmail.com>
 <c938a7d9-aa9e-a3ad-a001-fb9022d21475@themaw.net>
Content-Language: en-US
In-Reply-To: <c938a7d9-aa9e-a3ad-a001-fb9022d21475@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/10/23 09:36, Ian Kent wrote:
> On 27/10/23 16:17, Miklos Szeredi wrote:
>> On Fri, Oct 27, 2023 at 5:12 AM Ian Kent <raven@themaw.net> wrote:
>>> On 25/10/23 22:02, Miklos Szeredi wrote:
>>>> The mnt.mnt_list is still used to set up the mount tree and for
>>>> propagation, but not after the mount has been added to a 
>>>> namespace.  Hence
>>>> mnt_list can live in union with rb_node.  Use MNT_ONRB mount flag to
>>>> validate that the mount is on the correct list.
>>> Is that accurate, propagation occurs at mount and also at umount.
>> When propagating a mount, the new mount's mnt_list is used as a head
>> for the new propagated mounts.  These are then moved to the rb tree by
>> commit_tree().
>>
>> When umounting there's a "to umount" list called tmp_list in
>> umount_tree(), this list is used to collect direct umounts and then
>> propagated umounts.  The direct umounts are added in umount_tree(),
>> the propagated ones umount_one().
>>
>> Note: umount_tree() can be called on a not yet finished mount, in that
>> case the mounts are still on mnt_list, so umount_tree() needs to deal
>> with both.
>>
>>> IDG how the change to umount_one() works, it looks like umount_list()
>>>
>>> uses mnt_list. It looks like propagate_umount() is also using mnt_list.
>>>
>>>
>>> Am I missing something obvious?
>> So when a mount is part of a namespace (either anonymous or not) it is
>> on the rb tree, when not then it can temporarily be on mnt_list.
>> MNT_ONRB flag is used to validate that the mount is on the list that
>> we expect it to be on, but also to detect the case of the mount setup
>> being aborted.
>>
>> We could handle the second case differently, since we should be able
>> to tell when we are removing the mount from a namespace and when we
>> are aborting a mount, but this was the least invasive way to do this.
>
> Thanks for the explanation, what you've said is essentially what I
>
> understood reading the series.
>
>
> But I still haven't quite got this so I'll need to spend more time
>
> on this part of the patch series.
>
>
> That's not a problem, ;).

After cloning your git tree and looking in there I don't see what

I was concerned about so I think I was confused by obscurity by

diff rather than seeing a real problem, ;)


Still that union worries me a little bit so I'll keep looking at

the code for a while.


>
>
> Ian
>
>>
>> Thanks,
>> Miklos
>>
>

