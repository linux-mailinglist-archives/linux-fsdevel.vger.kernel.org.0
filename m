Return-Path: <linux-fsdevel+bounces-1522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB167DB2EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 06:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2480B20D54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 05:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2267E1376;
	Mon, 30 Oct 2023 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="kH1PljIw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lU/j/+Gs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026A1362
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 05:45:45 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D9BC;
	Sun, 29 Oct 2023 22:45:43 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 01D4C3200988;
	Mon, 30 Oct 2023 01:45:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 30 Oct 2023 01:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698644741; x=1698731141; bh=jaTWG66pDHoMbCEBoC0gkbfu5n/wvjRGKKr
	6RONugiw=; b=kH1PljIwB4mx8xnaIGjwZChPF+ytCawKcocvOonU1W80TSZWp7A
	mlndkyy1y+v/Pp5M1Ti83zkcRGcpZEX8qlYgTYvlWUISmO7ywFth8lvMO1TOM1PW
	ESUBADIRp9beHdJ5/jRCsesd1tHJIl9C2+xvZtsLgEH51g1M0AsnI0UsqfBb+9rM
	46Cyet41GCFc5y01IQJpT62gHDNEp8coBIY66tx86nQbOxtedlnqHFoWxaKYsW6M
	7NBSWFS4kgLFziprja2mK1e0I7mfD/w5NfmRN7XI1jp93GE1UVTgUeG3BLSn5Pvd
	s9F8Tx74suf3yQcN4y6tEb9ZiVtxjAaLvVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698644741; x=1698731141; bh=jaTWG66pDHoMbCEBoC0gkbfu5n/wvjRGKKr
	6RONugiw=; b=lU/j/+GsBZjBEEfDrgUzeheIxy92PUsVQwlz9VpHBPNkyGeJuEp
	Ie4cXb1MwbbxAZXN8YU+ms/igcfooRHZBD/kJqX3qsI3j4GlAs4O6qv8qVOqO9Jf
	Q7AecRB79YnnBiICaFAAmthF6J1Hs3YGSG3DTxQZtOaAWsGTnI/fdiO2Xjr1wLc8
	ASaFSONgTCewvWzr2QWqnM1/6YTeGbWt1AaNniaLvZr6NF3BE5EpiDfxGO3XArfY
	n6vYrs47fmcxnPdnwueK8nerYpL3BgGYFf6euhUHPZFk6Fu0FSaI8Z09EG6Tqiqv
	Q+Roqn/VyaZwP+74u0rJyQfLkxDneCowbRw==
X-ME-Sender: <xms:BUM_ZQU51d17FuPrp3ucPlUeWHzV-9uuv0_BgNGCvO6i_zF4oqFTOA>
    <xme:BUM_ZUnhlTPM7z25YGpWS2ZxZVSSSXtSQZGP2LG53JNy0eCzAf4i3UQ8sXg1U8RiY
    LCswe_wm2w0>
X-ME-Received: <xmr:BUM_ZUba5JMOj-Rr6g8_AzLmFqeUQI5LCVNIQ_07XT1UJRs6BHSEAltH0i9SrxeVqscCJI3GDopPxUEVj1eNOSETAJD-d8TO9GyWuPYDpYsGm2SuqB6ZDgve>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleelgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuhffvvehfjggtgfesthekredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eiveelkefgtdegudefudeftdelteejtedvheeuleevvdeluefhuddtieegveelkeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:BUM_ZfU_98WYEJc-r7pFTctcN3qRayb6W5zTEMzhBM-314_3kPDCCA>
    <xmx:BUM_Zakd3BUGtYMBT6nyVbxOd4PgwA6e-6PQYWHvE2EeEFTJc7486w>
    <xmx:BUM_ZUcTEXgs2896m8D2OQJzisVWovqy1u0DVriyrJmn-Z6jqYO-2Q>
    <xmx:BUM_ZV9DDlqafNvwsJKyNuhtvxWaxOjawSSs8IN8BWocmKLJTS0ikQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 01:45:35 -0400 (EDT)
Message-ID: <cbc065c0-1dc3-974f-6e48-483baaf750a3@themaw.net>
Date: Mon, 30 Oct 2023 13:45:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/6] mounts: keep list of mounts in an rbtree
Content-Language: en-US
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
 <dfb5f3d5-8db8-34af-d605-14112e8cc485@themaw.net>
In-Reply-To: <dfb5f3d5-8db8-34af-d605-14112e8cc485@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/10/23 13:37, Ian Kent wrote:
> On 28/10/23 09:36, Ian Kent wrote:
>> On 27/10/23 16:17, Miklos Szeredi wrote:
>>> On Fri, Oct 27, 2023 at 5:12 AM Ian Kent <raven@themaw.net> wrote:
>>>> On 25/10/23 22:02, Miklos Szeredi wrote:
>>>>> The mnt.mnt_list is still used to set up the mount tree and for
>>>>> propagation, but not after the mount has been added to a 
>>>>> namespace.  Hence
>>>>> mnt_list can live in union with rb_node.  Use MNT_ONRB mount flag to
>>>>> validate that the mount is on the correct list.
>>>> Is that accurate, propagation occurs at mount and also at umount.
>>> When propagating a mount, the new mount's mnt_list is used as a head
>>> for the new propagated mounts.  These are then moved to the rb tree by
>>> commit_tree().
>>>
>>> When umounting there's a "to umount" list called tmp_list in
>>> umount_tree(), this list is used to collect direct umounts and then
>>> propagated umounts.  The direct umounts are added in umount_tree(),
>>> the propagated ones umount_one().
>>>
>>> Note: umount_tree() can be called on a not yet finished mount, in that
>>> case the mounts are still on mnt_list, so umount_tree() needs to deal
>>> with both.
>>>
>>>> IDG how the change to umount_one() works, it looks like umount_list()
>>>>
>>>> uses mnt_list. It looks like propagate_umount() is also using 
>>>> mnt_list.
>>>>
>>>>
>>>> Am I missing something obvious?
>>> So when a mount is part of a namespace (either anonymous or not) it is
>>> on the rb tree, when not then it can temporarily be on mnt_list.
>>> MNT_ONRB flag is used to validate that the mount is on the list that
>>> we expect it to be on, but also to detect the case of the mount setup
>>> being aborted.
>>>
>>> We could handle the second case differently, since we should be able
>>> to tell when we are removing the mount from a namespace and when we
>>> are aborting a mount, but this was the least invasive way to do this.
>>
>> Thanks for the explanation, what you've said is essentially what I
>>
>> understood reading the series.
>>
>>
>> But I still haven't quite got this so I'll need to spend more time
>>
>> on this part of the patch series.
>>
>>
>> That's not a problem, ;).
>
> After cloning your git tree and looking in there I don't see what
>
> I was concerned about so I think I was confused by obscurity by
>
> diff rather than seeing a real problem, ;)
>
>
> Still that union worries me a little bit so I'll keep looking at
>
> the code for a while.

Is fs/namespace.c:iterate_mounts() a problem?

It's called from:

1) ./kernel/audit_tree.c:709: if (iterate_mounts(compare_root,
2) ./kernel/audit_tree.c:839:    err = iterate_mounts(tag_mount, tree, mnt);
3) ./kernel/audit_tree.c:917:        failed = iterate_mounts(tag_mount, 
tree, tagged);


 From functions 1) audit_trim_trees(), 2) audit_add_tree_rule() and

3) audit_tag_tree().


>
>
>>
>>
>> Ian
>>
>>>
>>> Thanks,
>>> Miklos
>>>
>>
>

