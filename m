Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5B31E7D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 10:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhBRJA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 04:00:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:50295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhBRI4w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613638492;
        bh=AA4GBMmyUcN7Q2gYpk6jzHSsbCUXTNMZs3rI8avoWHQ=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=PPiVfMBYmrkONh2ZwZ82Iodjlm1JH+xVEenFiJ7DwXvsJQLTI/6H5ZuDvNxLX82J2
         neCraFfnpVe4uqQ+qQPXZpVyGeN+/677+LgNSMTdKdOmH9koKK5NyObUX+pfS62Iam
         CRZYr8fO/g2IIFTeilGw8hke5+R9V7t4MuEciSj8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlGq-1lqPkJ0s2y-00drcV; Thu, 18
 Feb 2021 09:54:52 +0100
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: page->index limitation on 32bit system?
Message-ID: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
Date:   Thu, 18 Feb 2021 16:54:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NLNrHdu2PQlGO41adJCFYaeEDgThaXErXIbDWf1W2nggia1gRVL
 lsgE3nmKTSKpLETVmYtLWWcZ1onIxMdp3u60lWzFKG9daR6ZuZNw3XWAhrhF+AX4eMSCs94
 JHFyRr9SR5/eDlKytdY2QKsOYGQppj3XXrO1LCjkhzEm91WpoxDaCIXPh2NPAedaakqBkVF
 ZwvP7isQuhv0+2c0n3vPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mWjtKmYvCCM=:PL7DHeHyyQZFmcIkitq7GD
 nC5wSDxLnhdmOuyRrkjCEPFzHf5nPZj5Kh2BEF4TblQ3Vs08CDiPzT4AS2P0Zihx9AAIvYIv5
 kT9UM3xjzuIGmNFfGhWU7zrAosoj5AmZN9upRJZsRFlCwslE8+1cvkAJ80CkHDMoBozrxp2oe
 pELhjEyo6l2wK5kjjDXcpAf1O0VlKMDn6XTBD9uyecjybtkVEnZs7UkEsmo0y9sq2vJLCIP99
 WbL6d3BIWTgk3fNxQaDQR3Bpu5aXi21tJLp7JRYP/UKvZ/ozilSktIhSwJkW5oGtz4vcgWI7g
 pFMVFjiu9RYj6bNEoV0d67hQF0i5hMkoJQ+JgMmJ7dOLKsgypG9D1OqqEn0Chsr08xnjFuOCD
 SiYcea66ZHfVFhoMosy5QYTl0f564sgZTBXMV5SXZ7OrAo9AERqGvTuz5Pj/4qKERd6QUkP6N
 TVl8CcaVxkvxygNRUIM3vy94ZuPNw0KDAwmHwfDweeVfVtq0rDgX/RvD3BDsV+z0K7wVyYjWe
 8AuKoXoKCQEOI+kEy7uvknNGhUwDphA8PnGAReKVMnB0BhIa1PvVsKoR/KNmRXvhCUyQ/87Yi
 C+lWZSanj7nSe/7mMsNCONAVoYM5QbtABaF3m5WeOx4DRK3igaUPpvE6ywGCBx1AsIhhNVMlX
 hyRkYl9907g30R+urITcGLIpRzwZBbBsvi/6FWPtAIk7RhghvBeFcuS0Ojhzpt+QJLWJOv56F
 jIUBuV8yKLNJA5gUeECXEBOXROrVxAi2qYxtLUFhK2SinJHJizjHRv5W3bgqyS0WqWjCHpqiV
 /xSRT+t17Vu1WEA3LsthMrrFmIA43LOFhP0zPsLtXXjM22TITqa54IiS7domNgVoVoUKum/OH
 aAGuuJB/IFy34hO98pDQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Recently we got a strange bug report that, one 32bit systems like armv6
or non-64bit x86, certain large btrfs can't be mounted.

It turns out that, since page->index is just unsigned long, and on 32bit
systemts, that can just be 32bit.

And when filesystems is utilizing any page offset over 4T, page->index
get truncated, causing various problems.

This is especially a big problem for btrfs, as btrfs uses its internal
address space, which is from 0 to U64_MAX, but still sometimes relies on
page->index, just like most filesystems.

If a metadata is at or beyond 4T boundary (which is not rare, even with
small btrfs, as btrfs can related its chunks to much higher bytenr than
device boundary), then page->index will be truncated and may even
conflicts with existing pages.

I'm wonder if this is a known problem, and if so is there any plan to fix?
If not a known one, does it mean we have to make page->index u64 to fix
it? (this is definitely not going to be easy)

Thanks,
Qu
