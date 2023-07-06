Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410647492C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 02:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjGFAyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 20:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGFAyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:54:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8119171A;
        Wed,  5 Jul 2023 17:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688604829; x=1689209629; i=quwenruo.btrfs@gmx.com;
 bh=sh0LGEKBi7t+gs431m83i8UhS/20EPhvC3QQhuDUgKw=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=pna0OjYVmEIBwguN/dDimLXnxk3J2ltwqVB5DZSxTCXzTAerYjyKRTs1n89wWO4yElAY6l5
 kOBaiwT2pOWZacwXDYHzetFyWitRpg2T8+8iLbYUNP1V8gqH1C0BH9ClQlETZLTdqT566gvwG
 GxDe6Jp/UKHd405/UgNl853Ki9xKEJJ0DYzDRmgwqkXQn0w+R/hfCWlf1wUTDDzJsL+e48NiN
 DC83Df1nFb5FqQH/d5DQ9UF3HIhKfBNz0k3+9WSyE6wV7fani7o9b8+EixdaBzRcoOiqAANke
 rliWJ6/6/ohKSlQfn7qgTva1iX15aOomy7V9MO9SYrEgv66QZFVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbBu-1pyAzz0YLe-00scXF; Thu, 06
 Jul 2023 02:53:49 +0200
Message-ID: <0d6dc2f3-75a5-bc72-f3b5-2a3749db1683@gmx.com>
Date:   Thu, 6 Jul 2023 08:53:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Qu Wenruo <wqu@suse.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
 <bc897780-2c81-fe1f-a8d4-148a08962a20@igalia.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
In-Reply-To: <bc897780-2c81-fe1f-a8d4-148a08962a20@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hxVwijMo8bIMIsTtfR6C4mMTd0r40PTeZ+dTuUS+mZWdTe+LYah
 QA7i5rau5hGzKSoM3IBIs1cdqQ0PL43Pe4+WtiQV1bNhk8bGJQPUD0VLNiei2u1i05+ZJDw
 BwutkVKwCjxdVFKOj2Reg4yTwH9I/E7sEkwmTyJnRgQnaTE1Jm5VXC+uiUZ8eHMloimTINV
 CxCpxaYzZu1LjUCoqOurQ==
UI-OutboundReport: notjunk:1;M01:P0:COQW6h5lxOs=;Flhr9mksVc6JWsiqUOF9Fz39qqM
 wHdm4M4I6qpTbCkSfIo2MhG3oGbgs60Bh8MQ8bA7eJ10ZLnf3lC08o44uzWLL95GNjxg30h1l
 IJTjeSckD3iWYNyB5S2VMIJeKR2GcZqhd7VkoKdb1G4GTIfgaqBSDU5G+kVHTVaxFwxOQLhQq
 en4pchxHb67k/k/3Nrrulwot07Q3N6uSJUYr2h1kYXeG4IBkFfHHdb+25nr+PdExg39Q01CuT
 p53Cq6xIMmbuC2d0+woKqMasIZ/Wk6tEIW4WhlCDpacmXCzM50OPNr+Ha3KTMkaecxsXOUuke
 oWrHJRm/CTaJ8z2vBy0vlj/GUf/AVmryWpCrV+9b+vGMD/V9HUiiBUWKaBF+UsHOK3TlFBMs6
 wtgbldlmF3fTM4/5L/9u5ddC2duvU6w9/EON+TMfp5ocB8GweRyfCZdypEsic8LXBzDBPMNWo
 qQL3sfYUCKqsGuGL135vCAG9a0ODQumLrQDgDKIL+aSVpylvQSVQgcUXiSDjhCJEj8pj34b16
 JlzdbbP/kEdApsvJ8Ez3Qo642o4tPVeRzS36XVLcsC6yi/R6IQ1PGHSa9iOpuvcSzRO8DQO2u
 1thpFVCNesWoM/kM9B88rZG9hmoZi8PzL8QVqrCDFroWqEFGBpO/8ORugbYAqksmJFfeklI8h
 qPmjn7kb+VuKsjtatX8uqfxJ35NqfwxOd7dSNd7WrN4qG8ovD1sn/kc2FiPvbjUyLOETLrxLY
 VomaB+53aPq038vrlzKAf0POttqZuyHYhSVDjHhPiAb4+kV/EeYplxp2Z3gCrXTs1W9mtawAl
 ulaTH72sqNzWxQSG0WeUWC+oIzSsSXYArPELxGVTHfxoDC2goN3Yn8937G9aXQ1n7KphePoUY
 9dGZW3iKzpU8o7JIgfZASE/+Q9JrR1HwpxpMLxcKETESmSYr1MUwmp/CIwkv4vPA/hZPI9Lzg
 3XhvDCmsnUiEWb3GKlWfWCTe1Rw=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/6 06:52, Guilherme G. Piccoli wrote:
> On 05/05/2023 04:21, Qu Wenruo wrote:
>> [...]
>> I would prefer a much simpler but more explicit method.
>>
>> Just introduce a new compat_ro feature, maybe call it SINGLE_DEV.
>>
>> By this, we can avoid multiple meanings of the same super member, nor
>> need any special mount option.
>> Remember, mount option is never a good way to enable/disable a new feat=
ure.
>>
>> The better method to enable/disable a feature should be mkfs and btrfst=
une.
>>
>> Then go mostly the same of your patch, but maybe with something extra:
>>
>> - Disbale multi-dev code
>>     Include device add/replace/removal, this is already done in your
>>     patch.
>>
>> - Completely skip device scanning
>>     I see no reason to keep btrfs with SINGLE_DEV feature to be added t=
o
>>     the device list at all.
>>     It only needs to be scanned at mount time, and never be kept in the
>>     in-memory device list.
>>
>
> Hi Qu, I'm implementing this compat_ro idea of yours, but I'd like to
> ask your input in some "design decisions" I'm facing here.
>
> (a) I've skipped the device_list_add() step of adding the recent created
> fs_devices struct to fs_uuids list, but I kept the btrfs_device creation
> step. With that, the mount of two filesystems with same fsid fails..at
> sysfs directory creation!
>
> Of course - because it tries to add the same folder name to
> /sys/fs/btrfs/ !!! I have some options here:
>
> (I) Should I keep using a random generated fsid for single_dev devices,
> in order we can mount many of them while not messing too much with the
> code? I'd continue "piggybacking" on metadata_uuid idea if (I) is the
> proper choice.
>
> (II) Or maybe track down all fsid usage in the code (like this sysfs
> case) and deal with that? In the sysfs case, we could change that folder
> name to some other format, like fsid.NUM for single_dev devices, whereas
> NUM is an incremental value for devices mounted with same fsid.
>
> I'm not too fond of this alternative due to its complexity and "API"
> breakage - userspace already expects /sys/fs/btrfs/ entries to be the fs=
id.
>
> (III) Should we hide the filesystem from sysfs (and other potential
> conflicts that come from same fsid mounting points)? Seems a hideous
> approach, due to API breakage and bug potentials.

Personally speaking, I would go one of the following solution:

- Keep the sysfs, but adds a refcount to the sysfs related structures
   If we still go register the sysfs interface, then we have to keep a
   refcount, or any of the same fsid got unmounted, we would remove the
   whole sysfs entry.

- Skip the sysfs entry completely for any fs with the new compat_ro flag
   This would your idea (III), but the sysfs interface itself is not that
   critical (we add and remove entries from time to time), so I believe
   it's feasible to hide the sysfs for certain features.

>
> Maybe there are other choices, better than mine - lemme know if you have
> some ideas!
>
> Also, one last question/confirmation: you mentioned that "The better
> method to enable/disable a feature should be mkfs" - you mean the same
> way mkfs could be used to set features like "raid56" or "no-holes"?

Yes.

>
> By checking "mkfs.btrfs -O list-all", I don't see metadata_uuid for
> example, which is confined to btrfstune it seems. I'm already modifying
> btrfs-progs/mkfs, but since I'm emailing you, why not confirm, right? he=
h

I'm not familiar with metadata_uuid, but there are similar features like
seeding, which is only available in btrfstune, but not in mkfs.

It's not that uncommon, but yeah, you have found something we should
improve on.

Thanks,
Qu

>
> Thanks again for the advice and suggestions - much appreciated!
> Cheers,
>
>
> Guilherme
