Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596586FBBC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 02:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjEIACg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 20:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEIACf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 20:02:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E81E7D95;
        Mon,  8 May 2023 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683590531; i=quwenruo.btrfs@gmx.com;
        bh=sOUfl4KZW/zaBOIVT5rs8BPc9GdBK+y3h5uSgAOgYRE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=soTh5x8dDBnooSEp+JBuAajTxXHf0bqzrThMLwA5ruzZOR1XZQo597GzZsdBGR7zw
         kceQt/FitDBZovopksPF/2J2ParZLC1SYUgM9+3DCZqLBe33Sy6Y/U/+FIZpvwz84D
         kFF/qazLxPwj4+kDOwXUmhJjO/C3UzJ5Rnt9nCjXLMZbAnvK3zP8CUE0ki95K8GmHb
         6hNo/9ka9Py4lFs0jKtLra6Oe8th6eTk6EyICI9ID8HNC1yYN97ZWv31KfM+BXa21a
         Qn+uOs2MWZbUcxw4jfUqjN+MuAUU5pVZ+aoCjdATe9prrowz8+1vRUesyJs/56+TeW
         /+F5CVVTsn6hQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mz9Ux-1q9b3h3PZD-00wGhh; Tue, 09
 May 2023 02:02:11 +0200
Message-ID: <019c2ceb-1874-90bd-a124-d286c6f441df@gmx.com>
Date:   Tue, 9 May 2023 08:02:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, dsterba@suse.cz,
        Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <20230505131825.GN6373@twin.jikos.cz>
 <a28b9ff4-c16c-b9ba-8b4b-a00252c32857@igalia.com>
 <20230505230003.GU6373@twin.jikos.cz>
 <ed84081e-3b92-1253-2cf5-95f979c6c2f0@igalia.com>
 <f04cfb6d-9b1f-b5bf-0a41-a93efff47c15@gmx.com>
 <9fb396ab-d76f-bb07-a940-3f6842a3020d@igalia.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
In-Reply-To: <9fb396ab-d76f-bb07-a940-3f6842a3020d@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B4iQc64x3meSFopVTeYTdxzZvI7Gt0gqz6wW6SN6k7iRmI1ueVb
 NHGa5Oju4JvudSqzpy72fFYdEDCZ4RDVyrYiVuoSDZScAU2u8amCzHDNKH1fnkkGGaPuK2z
 pVimeAuF9Cy6Wk2aMAgC5kgu2sgeL1tTa4lupVrSBzkIV8rGmxZ8urnBPKSmW6e+lgLt4pB
 ft9AOSa2PyYL4Je4/KYvQ==
UI-OutboundReport: notjunk:1;M01:P0:VaHJ2dpofNY=;QQtWtuiEYjuvQLAYdhYryHxmQp6
 tikj82tZ7HKrSWAk5vnjtc91IqncOIjddwN+VpRyGJjXp3PKBTOdxPFLVm0XzdPTGmIcyPpBL
 cssv1ce7lcEjOga7WgUnQduZMFJa3oS4bhI2pIkYAwhasXXKuUerbPsq+dSin3anvUSXAloPK
 t6fyThO1Oyv9g2uH/dQjobpBHzXc5K4NBl5R9nvtNUui5i2J4WmRjxi1dZ4BdhUC7FckhGWC4
 yJ/iXCOs/fA+Wy9VtvHxwAvPDJu1QNZ9e4aXNMQTr+SL3FOfq35CAjnQYp49FQa2FcUlRFo7s
 IPCzG+lzvkKrSYkKBkV5j3fTtkLiCxhTP1S07PtkebsB3wN8Ai2GtnzEvbhdNRXJ49CVDpjSf
 vzK1sYLUwynPRb24M9DRMMOSWY/NKgp4IhE0OqKcYUoGeLk+zZ7/8XyIGrhv+Eror78JDlRbu
 BzI9jpVaVMEVXCF6fDV3LXjBC2hIUFxNEsNQXNeVIJSVdpuyG8oGafzPArXSbcozK4g1TfCbC
 +W/TFlhjisWuP6DGIADgy16wppL2ThrfVLZccRLi/I2ojwf5JP/qvJYqD+Fz2QLygE7ivpf7W
 BH0fF30NqejWzCxPT/fc1P9T49kBEezz4+k/GT/yvv6hw6fX0IFPi3sKP/4R/yb9oIbfkRERS
 bFbcWyY/LYE2ax86WK2Mtd+9uwRWv+ali+rFWZaFnmePU31qCKeEkztVT/SZZdbz8Q3fLk9eu
 XxjcEvXjo36njMHxUF/Or+4KbfKa8fKL9khuaQ+UNzr5d+dF5BWRxvi1mNa+ekAsah30vrgwL
 JCoYRQ/MwPqqbjzR7Y6oa4blE0kCRhwBGDn3MzLgTOhqssfAHnskoTESbQ0tcRJEyjSePud9J
 wM4nxWIFIRAnhZXrjWuHy9dreXSKLx57cm+8h1NQvNxxOnIAy2moZzvZOFg/sYVDlA0JeV0uN
 KTCbLeNv4AFIFx9hYTSUrvXku9U=
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/9 07:49, Guilherme G. Piccoli wrote:
> On 08/05/2023 20:18, Qu Wenruo wrote:
>> [...]
>>> I see that we seem to have 3 proposals here:
>>>
>>> (a) The compat_ro flag from Qu;
>>>
>>> (b) Your idea (that requires some clarification for my fully
>>> understanding - thanks in advance!);
>>>
>>> (c) Renaming the mount option "virtual_fsid" to "nouuid" to keep
>>> filesystem consistency, like XFS (courtesy of Dave Chinner) - please
>>> correct me here if I misunderstood you Dave =3D)
>>
>> To me, (a) and (c) don't conflict at all.
>>
>> We can allow "nouuid" only to work with SINGLE_DEV compat_ro.
>>
>> That compat_ro flags is more like a better guarantee that the fs will
>> never have more disks.
>>
>> As even with SINGLE_DEV compat_ro flags, we may still want some checks
>> to prevent the same fs being RW mounted at different instances, which
>> can cause other problems, thus dedicated "nouuid" may still be needed.
>>
>> Thanks,
>> Qu
>
> Hey Qu, I confess now I'm a bit confused heh
>
> The whole idea of (a) was to *not* use a mount option, right?! Per my
> understanding of your objections in this thread, you're not into a mount
> option for this same-fsid feature (based on a bad previous experience,
> as you explained).

My bad, I initially thought there would be some extra checks inside VFS
layer rejecting the same fs.

But after checking the xfs code, it looks like it's handling the nouuid
internally.

Thus no need for nouuid mount option if we go compat_ro.

Although I would still like a nouuid mount option, which is only valid
if the fs has the compat_ro flags, to provide a generic behavior just
like XFS.

Thanks,
Qu
>
> If we're keeping the "nouuid" mount option, why we'd require the
> compat_ro flag? Or vice-versa: having the compat_ro flag, why we'd need
> the mount option? >
> Thanks in advance for clarifications,
>
>
> Guilherme
