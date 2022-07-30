Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE613585C10
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jul 2022 22:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiG3UWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jul 2022 16:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiG3UWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jul 2022 16:22:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A2B13DCB;
        Sat, 30 Jul 2022 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659212539;
        bh=iMXA1hs77gEE5+qZkXF1dL4HGbE2QZySA3XLvuVpUTc=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=efi6VxjAjglOxegRvGvbzfEVxpZbw8UbkP1GyR0RXET80+lUyjzsQ2LjlrYTeT4ax
         l1oDlMMxFvZ2/p79YK2Q3LudIXp+/MI7jSP0FrxQ5WLe8e6SzdX46lhdKkymjTZueM
         wut1OkJX+4oZZDK03GA6K/cYV2R/qCYxdi65cywU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.141.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1oDVFL0BKi-00DDhx; Sat, 30
 Jul 2022 22:22:19 +0200
Message-ID: <0c844f53-f853-ac02-e6a3-399f9bd0ebe2@gmx.de>
Date:   Sat, 30 Jul 2022 22:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
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
 <2843f0fb-e11f-0622-da3a-1b9b46ca88f8@gmx.de>
In-Reply-To: <2843f0fb-e11f-0622-da3a-1b9b46ca88f8@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CkSKABwjua2D5aBq2Ckm3th24owKtsqeGxLQ3XlB4E7+wd+IqXX
 IgjWmDr0YVGv4wGZgvowNQEG8Gl6ctY586I3xVDjOUQ+q4CA5n5lea6RctUs0ReDp8TwWtZ
 hrGWhuNfSMBlcHxvOc5jIVZU5Kgb0Nb41hcZk2g7X3eweVBHJi3z12hzq2VgFAdX0RkpJAc
 Hb1ye3imr591ebCLpcxvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WTvWaiIYSJQ=:j2G5BSRCSQO/RH/BHd1kdW
 O4z4tRoghn/bMEAuuoMCsheErN4noH9HCo4c+0BF3WVMXd60PGeyMOYZ2IXwt0olv3eFzMDQv
 dDvdRqolekzR7hXxnAGqUUsVth8vh9OxynsmUeJuBX4ClqnDoo0n7fGZYiKT2mZGLWPtfYEpK
 zW6lwtV1yaqgJmkqDD9PWfSS9OAF8zkDMWjlwgoMY113WMrQWRapWwsP3fCZjvFdSsxC9xTSk
 hIzdY8M+KHL1k+WdenUpjzF/UE4j2S6TeBrz6FJc4mBh65DXsprVD3qAlFsGffWRrs6O+dKCJ
 p5fk+snZfIRHa9bZuDM7l/JvTu1Zusuhw1UMIleE+Hr456Lmq+0OXbwq/HLj24Aq2+8FTegjF
 ROIxidHfkP1ImpjGugbsTDbWQCTuYI8eti3m07nBGb4Dt7s1L0gq8qcJOOXnBGECsgxMcVgPr
 LJBmSeV7ku9HJGvCQdEQFWRgip21DGFB0LDz4Wq37Dg40QHsPxx3w9CCibS5O/OfVweLl0RVY
 jzBx6JuVPeRrHlsGeRRZpDd2Mbo/JFbEzMvgtQah9xwOtLW65xRzStfDrnPrvcY8ZvuOoEQkM
 rCDuKocTSBlOs6+UDQNO81pvHMQo2MBSwhrQl2miT6BDx9ste1o1zCDPGrdf2aeU0hy9nBI3i
 AuNvv14x2lh9uSXQOIrkr/lg9WydJdTJoCj978+CjQebLZTdPuu76t0t/UPkhD5z2nLL7UHeV
 xfV3yRmSCmO+wYJRkq9R5vG9kwDW9VD+OddGTLZ0cvOHw8T8Sq58MNbjF78y6luZaE3yegpmK
 lStxvRuRvIuAf03BNDPo/9fqplaQ5QaaZvSkjTzPIpTj9jk8h8RBkdLnA+01ZgKGKLga09bpK
 Xeu2JIq+A6Kf+eWfjH4VfufKHWfEv6hdm7EEGWw1O9HqX/Oalv1VfszqbQ9Yl9E8pudlnv5iI
 qjUOL1oTkjnPvhPt4TFk1LzFiuhIx/wROYPfq7oNS8LmfnYVRa4PDuH5fmmXCwZg9fnVuXrwM
 wgTJrFgHI1wflgcXARqir1/s4Num70EOSa+qt7xclKHWw+q9qcu+6lrfqZM1xKYfoFRXH56oz
 n2PWX5gVX3Kdv99MBVfYjjDm3lqFsUQZWtG3bsJhlwdl2Ffu9D5hPGNNA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/21/22 05:54, Helge Deller wrote:
> On 7/21/22 01:15, Sam James wrote:
>>> On 20 Jul 2022, at 18:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>
>>> On Wed, Jul 20, 2022 at 07:00:32PM +0800, Hillf Danton wrote:
>>>
>>>> To help debug it, de-union d_in_lookup_hash with d_alias and add debu=
g
>>>> info after dentry is killed. If any warning hits, we know where to ad=
d
>>>> something like
>>>>
>>>> 	WARN_ON(dentry->d_flags & DCACHE_DENTRY_KILLED);
>>>>
>>>> before hlist_bl_add or hlist_add.
>>
>>> [snip]
>>> I wonder if anyone had seen anything similar outside of parisc...
>
> Me too.
> Of course it could be caused by the platform code, as we have had
> issues with caches, spinlocks and so on.
> On older kernels we also have seen RCU stalls in d_alloc_parallel().
>
>>> I don't know if I have any chance to reproduce it here - the only
>>> parisc box I've got is a 715/100 (assuming the disk is still alive)
>>> and it's 32bit, unlike the reported setups and, er, not fast.
>
> It's fun to boot it, but it will be too slow for actual testing.
>
>>> qemu seems to have some parisc support, but it's 32bit-only at the
>>> moment...
>
> Yes. I think it will be hard to reproduce it in the VM.
>
>> I don't think I've seen this on parisc either, but I don't think
>> I've used tmpfs that heavily. I'll try it in case it's somehow more
>> likely to trigger it.
>
> It happened on the debian buildd server with tmpfs. To rule out tmpfs
> I switched to ext4 (on SATA SSD) and it happened there as well.
> I assume Dave's report is on ext3/ext4 with SCSI discs.
>
>> Helge, were there any particular steps to reproduce this? Or just
>> start doing your normal Debian builds on a tmpfs and it happens
>> soon enough?
>
> Currently it's not easy to reproduce for me either.
> It happens on the debian buildd server (4-way c8000 machine) while build=
ing
> the webkit2gtk package. I think it happens at the end when sbuild
> cleans the build directories by deleting all files.
> Maybe there is a filesystem test toolkit which you could try which hamme=
rs
> the fs by deleting lots of files in parallel?

I currently can't reproduce the issue any longer.
In case it pops up again, I'll follow up here again.

Helge
