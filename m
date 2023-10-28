Return-Path: <linux-fsdevel+bounces-1469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1E7DA4AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 03:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539211C211AF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 01:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32165C;
	Sat, 28 Oct 2023 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="fZYSL1Hh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F3HFKyzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3F635
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 01:36:38 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DD91A6;
	Fri, 27 Oct 2023 18:36:36 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 066505C0100;
	Fri, 27 Oct 2023 21:36:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 27 Oct 2023 21:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1698456994; x=1698543394; bh=KsUaa2dQRxZCNliH8E4IgB96uElIa6AZYOi
	IzXKoc/g=; b=fZYSL1Hh4egXuicxkMFg+jLgSXE3ZgD8AFpH+th6BJTlZigkseO
	mtkr17z5D5GSLqS3VGFVp3OeFx9U78fXmtLa9W0N/XHvBo5ajUNKShNtUDs7/sKd
	ZV4tr0uGpIz8uPI45OdgM/w5KYporhOEOR24znvm/rirYuDF3x6YBc+zxbDplwcj
	7eBteMNTZrNWsvL9HHyHvp/BuuTW1dNXe++6VfFOS27Qnk8Z+nS9kmlR+bgDjVzf
	gzUPt1jW0vMwPsIsCCc5Gobwv8H4jeIM+R7sWGfp/qmKEDAGzJQ7Vn3acMbKXa6M
	jPYyerd5HZZrgWis7rMj8zYIuHGTycY1cyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698456994; x=1698543394; bh=KsUaa2dQRxZCNliH8E4IgB96uElIa6AZYOi
	IzXKoc/g=; b=F3HFKyzmmg9oxz/ntz+T5+XmYWDdcKhDALX/MCh6lte6GAO0rwY
	RBcb9BjyHp8jfuTcYbT2DGUA7udnstUUZIewC+T0DtyeWdgMhJ1CexKem91iZYy6
	UGw2pgxXP/vDrtoAus18DfE8shNHIcPiyWKBOSmk2oal3LptEcqVlRX5oMXDlu+F
	AF3WjmY+PFO3tr/zpnWzGTezgZo9zPILxeYMg5+G5Z3PliD3q1tUvm7YPhNsNzVD
	HoedNHyyAhNO8zmJjwOqJoRSuLUhPzLCExH6mpE/QFi0Bg+8usyrjuGQNliseQTW
	6ABGQ2psafUCNfRw0eRgJHREBL0cIJ+Q2tA==
X-ME-Sender: <xms:oWU8ZeXAoF6deDOgUPP8C37DgzNB5zqFhXIx_UUlwRxfnidgTS8Z2g>
    <xme:oWU8Zan70Wjt7XusI4EdTk3INHaBCZEJTNlCgkgZlPjZw0Z6YaGz4P_VlXKBWXG_o
    5b2IrLD46uq>
X-ME-Received: <xmr:oWU8ZSZVrs7Ok5a2SVYQddVtyrDFBGeXIx6fztF1Qj5veEm0bWwUb_g9XUSv6pumVvon4v7pGkdUm-az3drwVgg2PHpCw3QRedu6TbUw3NTX1OazR_mEExRB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    egvdetvedvfeeivdeuueejgeetvdehlefhheethfekgfejueffgeeugfekudfhjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:oWU8ZVXRpVhBFGvyoK3JORYTRAnTL3oJArZ07m9g1A_Y-w8QOstB-Q>
    <xmx:oWU8ZYlDTKU5SN-q5rutlx_Ge-tniBq1-2UQr9mEKu7oWWOVtiafRQ>
    <xmx:oWU8ZadzWHfaQcb9lqILEARfOFF8xBUCqVR_7FZPHZC2aNr_ddzUkA>
    <xmx:omU8ZT-ELN39i8ylB1sZIrKCuC2WhY8InDf7as0RWilH3weOxiBTDQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 21:36:27 -0400 (EDT)
Message-ID: <c938a7d9-aa9e-a3ad-a001-fb9022d21475@themaw.net>
Date: Sat, 28 Oct 2023 09:36:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/6] mounts: keep list of mounts in an rbtree
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
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
In-Reply-To: <CAOssrKe76uZ5t714=Ta7GMLnZdS4QGm-fOfT9q5hNFe1fsDMVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/10/23 16:17, Miklos Szeredi wrote:
> On Fri, Oct 27, 2023 at 5:12 AM Ian Kent <raven@themaw.net> wrote:
>> On 25/10/23 22:02, Miklos Szeredi wrote:
>>> The mnt.mnt_list is still used to set up the mount tree and for
>>> propagation, but not after the mount has been added to a namespace.  Hence
>>> mnt_list can live in union with rb_node.  Use MNT_ONRB mount flag to
>>> validate that the mount is on the correct list.
>> Is that accurate, propagation occurs at mount and also at umount.
> When propagating a mount, the new mount's mnt_list is used as a head
> for the new propagated mounts.  These are then moved to the rb tree by
> commit_tree().
>
> When umounting there's a "to umount" list called tmp_list in
> umount_tree(), this list is used to collect direct umounts and then
> propagated umounts.  The direct umounts are added in umount_tree(),
> the propagated ones umount_one().
>
> Note: umount_tree() can be called on a not yet finished mount, in that
> case the mounts are still on mnt_list, so umount_tree() needs to deal
> with both.
>
>> IDG how the change to umount_one() works, it looks like umount_list()
>>
>> uses mnt_list. It looks like propagate_umount() is also using mnt_list.
>>
>>
>> Am I missing something obvious?
> So when a mount is part of a namespace (either anonymous or not) it is
> on the rb tree, when not then it can temporarily be on mnt_list.
> MNT_ONRB flag is used to validate that the mount is on the list that
> we expect it to be on, but also to detect the case of the mount setup
> being aborted.
>
> We could handle the second case differently, since we should be able
> to tell when we are removing the mount from a namespace and when we
> are aborting a mount, but this was the least invasive way to do this.

Thanks for the explanation, what you've said is essentially what I

understood reading the series.


But I still haven't quite got this so I'll need to spend more time

on this part of the patch series.


That's not a problem, ;).


Ian

>
> Thanks,
> Miklos
>

