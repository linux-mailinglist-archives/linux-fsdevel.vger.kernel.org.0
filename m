Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572B157C308
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 05:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiGUDzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 23:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUDzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:55:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5879FED;
        Wed, 20 Jul 2022 20:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658375696;
        bh=48cKDIu5LTpLN2aSvk61E4guPih8QwzLLDZ7+x6KSM0=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=PHRU1jXDHyqrx2T3MqsIcxJPbYUbXDnVqFEkNqUI61COkfRqWLbybp71U8u05je0Q
         ONuJuVXcG7SKLeQMrBXPkflPfhMIrH9EyUCj/7hoy9OvNatczLBjejdw1CwiZmvEoW
         2GJ06WUkiYfv7mBFDKwHReUQOleX7yNrSl2IAQlg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.166.214]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf0BG-1nYzqU1QkM-00gbyQ; Thu, 21
 Jul 2022 05:54:56 +0200
Message-ID: <2843f0fb-e11f-0622-da3a-1b9b46ca88f8@gmx.de>
Date:   Thu, 21 Jul 2022 05:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Sam James <sam@gentoo.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Hillf Danton <hdanton@sina.com>,
        John David Anglin <dave.anglin@bell.net>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de> <Ytd2g72cj0Aq1MBG@ZenIV>
 <860792bb-1fd6-66c6-ef31-4edd181e2954@gmx.de> <YtepmwLj//zrD3V3@ZenIV>
 <20220720110032.1787-1-hdanton@sina.com> <Ytg2CDLzLo+FKbTZ@ZenIV>
 <9B4CB715-FEA1-4991-ABA1-23B2DF203258@gentoo.org>
From:   Helge Deller <deller@gmx.de>
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
In-Reply-To: <9B4CB715-FEA1-4991-ABA1-23B2DF203258@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QfAgaJDPnnPFTanAOSR7rUPB8J0o9zYJfDtSETEgK6/HX2MZa7j
 0Pwd5fdxMDLtBWmHyGfmQdRqzaFqnzlO0fYJzSWAHf6LQgzF6ro9JTjLxnnBHoeK13Qw6Cl
 5+hiaiKQgDf7AhOm/v5OCWs7ckjcOv6ExYI1CCY+4sSn/sGKZOA1gBDUCy1vNKgfsqMSZj4
 PUEvX+FbAdSvKE37phO8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MMb0h3331H0=:2Ka8OWXK0T4iMBJdvCkLNe
 22UrZBiMCeT6Nv2BGkbddx3E/5JyXeQbIsFwTLYFwfRElxQ6y1SoYYyjJjachUcMWVqegFbrf
 3MwsOLDcRytD6cLiEg+iEepWW2O9o/b2l+mpIq1ZhuimhlTZwv4bgG+Ej/jK8pboFk0IweBRa
 sM+prgP872P7sw2xMKc1wlOg00T0hHn4Nxo0MztkfoRG6pvYd9ZfGhJBVH99DdZWLgRwRU8PY
 zzyVlfGN0RROLHWdJIaWl8WS047aP/2jj6ATUXyKk1c0oovrLkz0AQcM3xCbjVlKyhuov9nRd
 2WnZSffEmfJaf/+RfjqFrKzP3djDxCvBQF5sHyjVRDZv8nycKO7Y/F/5WVKh2WsGKpLs+AiUR
 OF76wBz7Un1Igtu7vo8sKr9UOLeYastlAYqlvjsz6o6NppTnO3shayKEdIx2jge3O/GejP5jN
 rEBdwCgVOkaYiGS178AJyAIDGjrmYwVu+FcJRUwWDMLI2ChT2RVf6Ky2b0p99RkuuFadZgctJ
 ppYLZ6bOsa2i/sY5YFK/15pLV/HWKPCUdgIFyCeGVZEnmqwbs2DkYHvEkdpRoJzo8rlP6q6Hx
 6LWUnZdFAWusFo++T7v11MlWpjsMO4saDcLV2T4PKt1RPaL5b0QDh0WbYQrcfYV9h3TZcNLGI
 PA4TAn/MTFsFaPn31wuCdx/vSK3/+XWQ3t1njDcnjuc+eYpYpo4ZVgyg2IrqwH7js+5vPneV/
 kTj1RgTTqptYdejIxitRvKMm4U+ISw5u5QB2lDk1whEy1Tq2gdcdfJIGNGBqLXJA0DbYJB/4y
 NP0X+gz4n/QRNOftg6mxjGT7iV8tRGOZTkQvSGpq7qWzPPGY9mGYWL4tq4ufupA+jH4MaQMsM
 xOaNJ+18uoHLG8gOTpWSXZNPZeOCbkZy5EurFjxCv9+TW75opTVIOJ6xr7Ti0d6VZGf2sgKyz
 COfjSSuArx5DQVBQp8hEyju6az1mgEppGU4Fm6molfuax+doD8Fot6h9mAX2//+dXxvIWN9PQ
 acYhMChYRfShNb5RTLcVNkyEomjh69GtjcHpn86X77/dUD0/nuGAzItKwBkv2D9u/HUx3+RdN
 Z0bw+IuXG57G5zFkbcxPgmCqw7LgL23wokAvQsXROxmb2XvmkCYpInf7w==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/21/22 01:15, Sam James wrote:
>> On 20 Jul 2022, at 18:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> On Wed, Jul 20, 2022 at 07:00:32PM +0800, Hillf Danton wrote:
>>
>>> To help debug it, de-union d_in_lookup_hash with d_alias and add debug
>>> info after dentry is killed. If any warning hits, we know where to add
>>> something like
>>>
>>> 	WARN_ON(dentry->d_flags & DCACHE_DENTRY_KILLED);
>>>
>>> before hlist_bl_add or hlist_add.
>
>> [snip]
>> I wonder if anyone had seen anything similar outside of parisc...

Me too.
Of course it could be caused by the platform code, as we have had
issues with caches, spinlocks and so on.
On older kernels we also have seen RCU stalls in d_alloc_parallel().

>> I don't know if I have any chance to reproduce it here - the only
>> parisc box I've got is a 715/100 (assuming the disk is still alive)
>> and it's 32bit, unlike the reported setups and, er, not fast.

It's fun to boot it, but it will be too slow for actual testing.

>> qemu seems to have some parisc support, but it's 32bit-only at the
>> moment...

Yes. I think it will be hard to reproduce it in the VM.

> I don't think I've seen this on parisc either, but I don't think
> I've used tmpfs that heavily. I'll try it in case it's somehow more
> likely to trigger it.

It happened on the debian buildd server with tmpfs. To rule out tmpfs
I switched to ext4 (on SATA SSD) and it happened there as well.
I assume Dave's report is on ext3/ext4 with SCSI discs.

> Helge, were there any particular steps to reproduce this? Or just
> start doing your normal Debian builds on a tmpfs and it happens
> soon enough?

Currently it's not easy to reproduce for me either.
It happens on the debian buildd server (4-way c8000 machine) while buildin=
g
the webkit2gtk package. I think it happens at the end when sbuild
cleans the build directories by deleting all files.
Maybe there is a filesystem test toolkit which you could try which hammers
the fs by deleting lots of files in parallel?

Helge
