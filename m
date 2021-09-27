Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C134194C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 15:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhI0NI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 09:08:26 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55091 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230089AbhI0NI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:08:26 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CCD4E3200BF9;
        Mon, 27 Sep 2021 09:06:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 27 Sep 2021 09:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=/
        GKVm9aT1QMpB/PByfoVomF5FC+99BMfJqPbdonFHp4=; b=YS1kiQTMUOFzQSTzT
        Kfv2rv7W/w1qHoGhCyLgmR7ixr5gyB3NmITvwsC9YmAhiS3omMnq75e5+Z1Yw7rY
        BkJ+aHrBO0RTxtFNaVHs4FN7vBKy18hd4BrIjnHz0Fl3lm7JQ0YRVrm4rvI44IaY
        BK/HkB5FJgwkv9uNRchLwjpsyh0uWLbhbUCftEAK81sdtthaxmOyumNGwp1u4fek
        l4yppv7tjT+Ep4PI8kShCuTD0A6IeM83o+x6+vFSF0Y0FNNRY5ygNH6mGAJUp6um
        9p5TqXIxtBNCislqinmGEqqj0VoSaPXLHBpgChg4SE4TqyX4W7DYm2XMr7u0fvHL
        2OpNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=/GKVm9aT1QMpB/PByfoVomF5FC+99BMfJqPbdonFH
        p4=; b=K25pBMePdTG4j5ulgG0Vgs0SXd5RIo28O7/AK+XLgMlHWqVJSJrBK0J3a
        Y+9sedgG2LQE+gTFTaNcapB31/3S2BOkXpw8UPeaLI+8BJpsrZXSsxg4FSrgrAsp
        +nc4Pu1aDMaZjkMRb0zQ+q0GlxEDo6PhQbeZIGaELsTxhaAQ+vp+fCkaeYzb30lI
        D2sNpCm4aVPH0dPjmKOQ08cVI9Ev7Df7p/udHMo+quw/AN1EhoHu6ozhokW++w39
        em4dCu4wQECwdl6vPJEIqR0rtNct1k75LzdWU0ln5eR9VDJlxFkw7sGgzFC73FRk
        C6pLrJ0/WT/nbhFLP77R2YyeWlZZQ==
X-ME-Sender: <xms:58FRYax23m1wBEGwFvzO_19kjjp-mMoJ7UFnqSjLV4YoBSXQwaPi4w>
    <xme:58FRYWQr3Xyjur_pRLpT7VnveLXUj4qL2pyCZBPGxGYQmCnpphXz9tiLAfr59wkZi
    EB1SOp45AsFsuvY>
X-ME-Received: <xmr:58FRYcWpt47LZa6xz3tXPUtXW5zdMilMwdBf6bf8YQvByAi9hhBieNLxVtCZ1uLtbVM1Z3xmfWwWzFTjPU3-k8BEWuPhSdQXEIQVM6J1hOfTlLgdkqUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejkedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeduhfdvuefgieejueekjefhieeuffeigfdtvedu
    ledutdejtdehueegfedugeduueenucffohhmrghinhepsggtrggthhgvfhhsrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:58FRYQizOWPCrsi2RmJN95TDBUzHhXcxqZorO0gBkLvPQVXeSp4VwQ>
    <xmx:58FRYcAuDk58yfqeuG408CxWEfCt6dFJgvl5455BHEKGiF6pqHXLtw>
    <xmx:58FRYRIE8RO5CFJhkk-1ijRBcRVTBqgSqDl11fAZgaqfq1H0m6uAJw>
    <xmx:58FRYfNTaJ3w07NlPUFx2cP3KA6HWdjo_myz4onw1wVO6uaZ8hEc7A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Sep 2021 09:06:46 -0400 (EDT)
Subject: Re: bcachefs - snapshots
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <YVEjEwCiqje7yDyV@moria.home.lan>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
Message-ID: <dbe56ac2-22bd-74d5-ab5d-9f6673884212@fastmail.fm>
Date:   Mon, 27 Sep 2021 15:06:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVEjEwCiqje7yDyV@moria.home.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/27/21 3:49 AM, Kent Overstreet wrote:
> Snapshots have been merged! 9 months of work and 3k lines of new code, finally
> released. Some highlights:
> 
>  - btrfs style subvolumes & snapshots interface
>  - snapshots are writeable
>  - highly scalable: number of snapshots is limited only by your disk space
>  - highly space efficient: no internal fragmentation issues
> 
> Design doc here: https://bcachefs.org/Snapshots/
> 
> The core functionality is complete - snapshot creation and deletion works, fsck
> changes are done (most of the complexity was in making fsck work without
> O(number of snapshots) performance - tricky). Everything else is a todo item:
> 
>  - still need to export different st_dev for files in different subvolumes
>    (we'll never allocate a new inode with an inode number that collides with an
>    inode inother subvolume - but snapshots will naturally result in colliding
>    inode numbers)

With my limited high level view on it - shouldn't you discuss with Neil
about a solution and to avoid going the btrfs route for colliding inode
numbers?
