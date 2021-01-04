Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB232E9EDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 21:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbhADUad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 15:30:33 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40677 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbhADUad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 15:30:33 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C60945C01B2;
        Mon,  4 Jan 2021 15:29:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 04 Jan 2021 15:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=L4o1gT+9Nmi0578JQUpjoRZokjP
        2JxKpsVmdouqDL2Y=; b=VGQ0HerEoQmkJXMmFRbzzU4+J1AoRwwt0qwyTay2ZSx
        5HK8iQdhi641M01S7QEONTthzMoXmjPKqQatTRjlvKi7A/Hiqsd3dGS4v4bXT3KU
        Tzc9QwOTT3K2km12B/zoRjPIzrSiIb6j0xxKqhYoYNnk4fj/aI82Zypm5hpHVuD0
        shsyxpjpPbyrWjcDPDy+H5sv2oyRdI/UYtyP7Qhms7WHeZg+7jmRCD0oeipwwpy6
        PGTXWsa7z0f9oOB/NeTh6v+Fph/FOuulVX1hNilaQ6sSR11KnEAUC8A9kifHxXu/
        mHxNLdm5AgOQZ+qQv+f74sC9CXSuwz8R8cMaNyIxYBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=L4o1gT
        +9Nmi0578JQUpjoRZokjP2JxKpsVmdouqDL2Y=; b=glCIRr71LLSuL9ADgG9Xa1
        wtKFMKWtvFzUdYzJotxLLMBrnA/gosHywKpMb6uBrjXqdFdvccb91ty5xJnDJpHw
        uOXe7mZ83fSingi18PcsKVyAYW4zjDwNVZUCvEKcz6QXA40j5WOdBiup66qFZYpQ
        u9NgR/zy9vZWYqYtGFzovtlK3ZoRV0WTGQelBzLXljoawpb+Oo9qKMLm6QS8e8cs
        UUc1A5LUG+pE4lD2XqIiaSAwQ4nSOXbn51Jipri+JrxYxEXJLplKk3kTmVwSgLKi
        qF2ZWx5QLOVFagcqkEOWBvyfXXZYeQBGzQIfKleq2f0tjubOlmUqizFuOIXGFhzg
        ==
X-ME-Sender: <xms:pnrzXzyhJrO1xOFobn8G7-zRymlkjW6teC9ZEx23Cu7avuQajEUbBg>
    <xme:pnrzX2vcNPYDHaonwd1-8vKRCjkmEWDU0GMfKeSchBTNHpjzQOtzggbpDwimWB7sR
    LSMch-fESQTmOsb2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeffedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeetnhgurhgvshcuhfhrvghunhguuceorghnughrvghssegr
    nhgrrhgriigvlhdruggvqeenucggtffrrghtthgvrhhnpedukefhkeelueegveetheelff
    ffjeegleeuudelfeefuedtleffueejfffhueffudenucfkphepieejrdduiedtrddvudej
    rddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:pnrzXw0PGdeUb0WAG7DSLqsVlgBx3vc5-Gms6OWnuKK_kmmFEpVbDQ>
    <xmx:pnrzXx_9WVqRoWRzMRlKMCMTzbMGt8GQGdiY1RRQYhsZ9pHiYXlmYg>
    <xmx:pnrzXxMzYS89WK5idbN35yK-MYgpLXaY1DgwDRgBbt_Uiwlk2kghJg>
    <xmx:pnrzX5FAbDIm30H8Jib0CLgS1agt5jZ1kBjQ_c1wnAHKx_Iu1Q_P1Q>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3799D240057;
        Mon,  4 Jan 2021 15:29:26 -0500 (EST)
Date:   Mon, 4 Jan 2021 12:29:24 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20210104202924.ugwjnbo376t3jad2@alap3.anarazel.de>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <X/NpsZ8tSPkCwsYE@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/NpsZ8tSPkCwsYE@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2021-01-04 14:17:05 -0500, Theodore Ts'o wrote:
> One thing to note is that there are some devices which support a write
> zeros operation, but where it is *less* performant than actually
> writing zeros via DMA'ing zero pages.  Yes, that's insane.
> Unfortunately, there are a insane devices out there....

That doesn't surprise me at all, unfortunately. I'm planning to send a
proposal to allow disabling a device's use of fua for similar reasons...


> That doesn't meant that your proposal shouldn't be adopted.  But it
> would be a good idea to have some kind of way to either allow some
> kind of tuning knob to disable the user of zeroout (either in the
> block device, file system, or in userspace), and/or some kind of way
> to try to automatically figure out whether using zeroout is actually a
> win, since most users aren't going to be up to adjusting a manual
> tuning knob.

A block device know seems to make sense to me. There already is
  /sys/block/*/queue/write_zeroes_max_bytes
it seems like it could make sense to add a sibling entry to allow tuning
that? Presumably with a quirks (as suggested by Matthew) to choose a
sensible default?

It's not quite analogous, but there's for
max_hw_sectors_kb/max_sectors_kb and discard_max_bytes /
discard_max_hw_bytes, and it seems like something vaguely in that
direction could make sense?

Greetings,

Andres Freund
