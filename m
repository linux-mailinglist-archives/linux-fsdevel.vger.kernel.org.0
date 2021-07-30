Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49AC3DB343
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 08:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhG3GKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 02:10:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:52331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237294AbhG3GKP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627625379;
        bh=I8WE73oxF7X+UZs1Q1N5gmkD8Cef5zfT4nU/B4xjmLg=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=WuAGcGrFYAaIb5hpZwTNdY4nhTtDx1Da+WFqJnUbKUPI+IX00mDCmbtPAFUFrJ5d1
         RGhiqCGX/DatptY8UCiiAJXUv2xcGmCYlkdZHlMvswKi7g1As7XO4BpJ3T+jsMQoj8
         G3c0cH9b81+8XiW+VAh9j/oW4vwaBx5G/3WrI6dI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McH9i-1mliGs38hQ-00cg1h; Fri, 30
 Jul 2021 08:09:39 +0200
To:     NeilBrown <neilb@suse.de>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Neal Gompa <ngompa13@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com>
 <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>
 <20210729023751.GL10170@hungrycats.org>
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>
 <20210729232017.GE10106@hungrycats.org>
 <162761259105.21659.4838403432058511846@noble.neil.brown.name>
 <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>
 <046c96cd-f2a5-be04-e7b5-012e896c5816@gmx.com>
 <162762485406.21659.16909119511605460065@noble.neil.brown.name>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <d275631f-7f0e-1db4-0e27-9d873eb422f8@gmx.com>
Date:   Fri, 30 Jul 2021 14:09:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162762485406.21659.16909119511605460065@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XeoeEPdAtR0LhBdcOeJiZDS6sIOzzS4iZs0ezV9YNargaHccpHJ
 CZ/IYgNRozpSlXPceK1f//2BF2J3lk6EGuesbcf/oK/nLFNgk2lEfq1jO9gBzwLSAQ9i/Ge
 DX//gelS3QfYdq3/W3PJi3OgeJ7RaVxCe8Ru9GzXZ0wOKl9ytGCXJ4zLueg2uYEJeQrTeFl
 jvMQHLtx/Pfv29IBdff4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3pj23FL4K+E=:M3Zbm1cX0mEQXZ6+7dly8P
 6Vlp4iLZ8svpTYE0SlH5r2Y+r/AQwdqfRUQa95QWE86LMYOm6CxI2eCGZ2vljfMi2sO17YPTl
 WaNuKamtd+7xrD2zhj6nTkwVicIIpytXjDLOdjymScmmht3X5WYhRekL2l4aIQpfnEoDnD8+X
 yTXAe6psJ7TMM+V6hvjeH8puAttCQf9mwRBh1xNo86Lm7yREBIBmQf54sazgS99gmCYEU+YGt
 LTKuPDqOF1LSwTyLUT9lfKBGddGHZF5j1Ie/5NKC53WbmFl6aKcfBnTcG7ONXFtlWp11V4A+t
 Kwe409VkwBAs03dK0fmkXKfprtrfDQHHSzreMWkug+MvVKGjn8l6sa72RbuwGzAHkNn5hBi/7
 CRPkFsPZwy1Yb1vxM4pvpgZcp+uT7ht9eE0FgflbhKNYDwE/75/GWRs+bcys2vISoGqY+4YGK
 JgzNjeD89kcGWjencAfEReiFTvpkwBJBFwbdrYTGEFSdJmUONhd+0ZMEwMjZQHHTnpbyP7h3y
 Uw6i6gKotf2EgRzJWluSk6spB9AeWf82n7ZHfo5LnzD8dnzCY1CA5XcfTurB6v2bWVTVTgsBd
 K/nQHinIHe+WhppBlXzVryCedxokMI8oBri8xtA6+1OKxJMNzeS2vYslXpvzzUGqR/v3CXywQ
 YkgFaQWBFw+/Q7cVk4c7b4s/GmEAWOmI8m5rJZqZtt5xKwkaT1aXz9sNRAelkrROT6QM3YPvb
 FBRWfU8OG+KXiWPTiyiRYFI4xAiJol8VpXZ/pALCTUPu1KCUagY3T4wMyNINMerZq0Jv6rGQd
 PsyKmtb38lCvKoE5KdjbmJFpaL8cFoJtSjgGlSFYlNf1sDKxlWtqfJQoWrLH9mJP/r3e0TgNi
 8MnX1yLxZcdAnov24iiVaYFFhFlhLVL9sm3h8IIBMaBMsftkb3mbawtBSuTBtOVyXk11Igt0w
 FWhlSf7fcqJwQzJcdLFgK4SaE3gz1vsZA7uvjCQMhsg46ZoIFbSLKG+qKy7FUPKtKVWrRRJ9H
 OxE5OccuRLEvMN5Jrc26WZBkeLJgKLdNxwvBqY0YMOjd2cvAo8ZEV5p4CPZ7jGLAZ5ttIxHns
 IT4uZ22vdb8atMio2JZcPJsxR0CFlHx+GiISiiLIM7zA39jtPx+7XwkzA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/7/30 =E4=B8=8B=E5=8D=882:00, NeilBrown wrote:
> On Fri, 30 Jul 2021, Qu Wenruo wrote:
>>
>> On 2021/7/30 =E4=B8=8B=E5=8D=881:25, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/7/30 =E4=B8=8A=E5=8D=8810:36, NeilBrown wrote:
>>>>
>>>> I've been pondering all the excellent feedback, and what I have learn=
t
>>>> from examining the code in btrfs, and I have developed a different
>>>> perspective.
>>>
>>> Great! Some new developers into the btrfs realm!
>>>
>>>>
>>>> Maybe "subvol" is a poor choice of name because it conjures up
>>>> connections with the Volumes in LVM, and btrfs subvols are very diffe=
rent
>>>> things.=C2=A0 Btrfs subvols are really just subtrees that can be trea=
ted as a
>>>> unit for operations like "clone" or "destroy".
>>>>
>>>> As such, they don't really deserve separate st_dev numbers.
>>>>
>>>> Maybe the different st_dev numbers were introduced as a "cheap" way t=
o
>>>> extend to size of the inode-number space.=C2=A0 Like many "cheap" thi=
ngs, it
>>>> has hidden costs.
>>
>> Forgot another problem already caused by this st_dev method.
>>
>> Since btrfs uses st_dev to distinguish them its inode name space, and
>> st_dev is allocated using anonymous bdev, and the anonymous bdev poor
>> has limited size (much smaller than btrfs subvolume id name space), it'=
s
>> already causing problems like we can't allocate enough anonymous bdev
>> for each subvolume, and failed to create subvolume/snapshot.
>
> What sort of numbers do you see in practice? How many subvolumes and how
> many inodes per subvolume?

Normally the "live"(*) subvolume numbers are below the minor dev number
range (1<<20), thus not a big deal.

*: Live here means the subvolume is at least accessed once. Subvolume
exists but never accessed doesn't get its anonymous bdev number allocated.

But (1<<20) is really small compared some real-world users.
Thus we had some reports of such problem, and changed the timing to
allocate such bdev number.

> If we allocated some number of bits to each, with over-allocation to
> allow for growth, could we fit both into 64 bits?

I don't think it's even possible, as currently we use u32 for dev_t,
which is already way below the theoretical limit (U64_MAX - 512).

Thus AFAIK there is no real way to solve it right now.

Thanks,
Qu
>
> NeilBrown
>
>
>>
>> Thus it's really a time to re-consider how we should export this info t=
o
>> user space.
>>
>> Thanks,
>> Qu
>>
