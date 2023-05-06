Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE0C6F94DA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 01:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEFXBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 19:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEFXBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 19:01:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A373D19D4E;
        Sat,  6 May 2023 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683414050; i=quwenruo.btrfs@gmx.com;
        bh=onm5rCQaDvEvaJNyNpTYEGH/jagb6snfPqiOO/wI2x0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qxZxo+DZZd6aNlXSLeMtkBYYnpnnhZx6jdt2hTCunczzEvD2mPe1GUJUqZStb3BOZ
         M9Ln1gNt6893Q6Ol54C9BDilGUTbkUxkLa2JXlFw3tusnnf5C3VroUzdk1tURyKh8Q
         RPnon3bL6Ta/MKzpSaBBnpuMd6ii1DtA4Q/wYyBhf6a4EViKpJ8bpFIVyN8mlSVj2G
         zWQIGiIOQZW8o7J9iuQ3y2qH4h9mbeo3tWfYicIW53ZCSiyFa0Ex0wbdldBV+98Uoy
         wPWCnPj2GH1UgvoSX+q66dMHhDkoW/tro3yV6GBCgdWOFIASccBIknsjsBzp0bFNbA
         2xR0HUudTkUOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0NU-1qfWDB31BI-00kMcr; Sun, 07
 May 2023 01:00:50 +0200
Message-ID: <9002b4a5-47f8-c96f-4b89-2a88af61e4ba@gmx.com>
Date:   Sun, 7 May 2023 07:00:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
To:     kreijack@inwind.it, Qu Wenruo <wqu@suse.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
 <26e62159-8df9-862a-8c14-7871b2cba961@libero.it>
 <9e12da58-3c53-79a4-c3fc-733346578965@suse.com>
 <a440cc5b-6dd0-19a7-9fd6-f940d3f72927@inwind.it>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a440cc5b-6dd0-19a7-9fd6-f940d3f72927@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EmvQ3GoUHpC29V0a5okhD72QJotRjt+Ee/JuTkpPsmqtJ9noxfj
 YtRWP4te1fbe3kL8oo6T5xAKJSONdQL+j4PJ/hO1uBaHSpBcC83dFllNGTrQcDmuETSksG7
 bYfARYY5UneahLJAOoXlUxdMaSgYwK0f1saLH8jzPU4Ub2F8VYjQrV8tV5iimmlcmVv1g3u
 p5teORuSbBbMGLHUDgn2A==
UI-OutboundReport: notjunk:1;M01:P0:bpY//nPPEAM=;5B4CtOzqymbmv4m4sm9ihEaR+Sb
 q0TDA1d8inESng7iC4YmgajnNLzCEO1zOK/cjtCp41st7/eBvPFuJG7Bn+P+zWKaWF+KuXESi
 dqKmCciPkaJX4HHbnYmh91swyPAnC0INwlBLIvZtqa45OSzbnna1UXCECnUATwOJUe/QSdYg9
 NzyKbhVkqgPdHnf0ERAQX9TZOstRUsFV30gXcUlaNvH1joDx1s/Na+j712ViJeBA8TYnbmsyd
 AaPLaq5EyfWlsFnDPkUD/wh/+LZr0chb5XTwckILJqOMkjtgh//i3ahjzz2SWfjtFw7qpxQqa
 kwvlM59MBoPWXNhiUAM/0+gCDQXe8Eqf3Z/dcDgLWAqVxicZFhCPpJFHbWx9EzOOlxAlMLWFZ
 mLfFoZYJu5UblLCSaF27pOtNfY2+udkX5OASP9dQxk0umI9KKfobE+9E1ciiAEcsNtRoBjJHF
 QyOSq1c9w8YNB4DZB8K8OqGdDssfXwLvMKWWeVviCVbWvnEA4NeD2h9W8YYfXwum5QHGL0lxC
 1D8VouCP881wEvOlOfJGTD6Iyg8IH3F5nEHe291+NjXWLjMx3l6+4I1Kw80SpblyiW9XFBrFL
 kaAZK9BgFSOciLfLZwrCwk3vZeuDIlQGf/YAY2WRrQZ5kTmCX3Z+s5I9GG9l3CQcZIpIMFlJu
 ctAHO2NG0l6Z7IPKEng9MRBtT5+Az26lejOu1+AnrOZ7SQUQPm6F1viXIxt+VTWOWlJEy3OOn
 e/AZNpOqgaLs1OM5b4DMd7ZdbOxDkpG8ByrDzc9JgIoj9PzzeAdOyzNzpui3DNikhLR9ct8jO
 CAWry47IwVGarjd/GLHC6twLmdD9NblkaEVI1AMeerTmeEHZiYjIZrbYjXLrWYZRTkEdcRDse
 OWkBCJbre4mTyG8clHpIvSzx5aXf3HCnmD7z00D/hblu5GUxnDopuIxgpEeIbA20CitZL3Dv/
 aNL7Mg2/cgOdH6mL6odNSnZpqHs=
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/7 01:30, Goffredo Baroncelli wrote:
> On 06/05/2023 00.31, Qu Wenruo wrote:
>>
>>
>> On 2023/5/6 01:34, Goffredo Baroncelli wrote:
>>> On 05/05/2023 09.21, Qu Wenruo wrote:
>>>>
>>>> I would prefer a much simpler but more explicit method.
>>>>
>>>> Just introduce a new compat_ro feature, maybe call it SINGLE_DEV.
>>>
>>> It is not clear to me if we need that.
>>>
>>> I don't understand in what checking for SINGLE_DEV is different from
>>> btrfs_super_block.disks_num =3D=3D 1.
>>
>> Because disks_num =3D=3D 1 doesn't exclude the ability to add new disks=
 in
>> the future.
>>
>> Without that new SINGLE_DEV compat_ro, we should still do the regular
>> device scan.
>>
>>>
>>> Let me to argument:
>>>
>>> I see two scenarios:
>>> 1) mount two different fs with the same UUID NOT at the same time:
>>> This could be done now with small change in the kernel:
>>> - we need to NOT store the data of a filesystem when a disk is
>>> =C2=A0=C2=A0 scanned IF it is composed by only one disk
>>> - after the unmount we need to discard the data too (checking again
>>> =C2=A0=C2=A0 that the filesystem is composed by only one disk)
>>>
>>> No limit is needed to add/replace a disk. Of course after a disk is
>>> added a filesystem with the same UUID cannot be mounted without a
>>> full cycle of --forget.
>>
>> The problem is, what if:
>>
>> - Both btrfs have single disk
>> - Both btrfs have the same fsid
>> - Both btrfs have been mounted
>> - Then one of btrfs is going to add a new disk
>>
>
> Why the user should be prevented to add a disk. It may
> a aware user that want to do that, knowing the possible consequence.
>
>
> [...]
>
>>
>> - Scan and record the fsid/device at device add time
>> =C2=A0=C2=A0 This means we should reject the device add.
>> =C2=A0=C2=A0 This can sometimes cause confusion to the end user, just b=
ecause they
>> =C2=A0=C2=A0 have mounted another fs, now they can not add a new device=
.
>
> I agree about the confusion. But not about the cause.
> The confusion is due to the poor communication between the kernel (where
> the error is
> detected) and the user. Now the only solution is to look at dmesg.
>
> Allowing to mount two filesystem with the same UUID is technically
> possible.
> There are some constraints bat are well defined; there are some corner c=
ase
> but are well defined (like add a device to a single device filesystem).
>
> However when we hit one of these corner case, now it is difficult to inf=
orm
> the user about the problem. Because now the user has to look at the dmes=
g
> to understand what is the problem.
>
> This is the real problem. The communication. And we have a lot of these
> problem (like mount a multi device filesystem without some disk, or with=
 a
> brain slip problem, or better inform the user if it is possible the
> mount -o degraded).
>
> Look this in another way; what if we had a mount.btrfs helper that:
>
> - look for the devices which compose the filesystem at mounting time
> - check if these devices are consistent:
>  =C2=A0=C2=A0=C2=A0=C2=A0- if the fs is one-device, we don't need furthe=
r check; otherwise
> check
>  =C2=A0=C2=A0=C2=A0=C2=A0- if all the devices are present
>  =C2=A0=C2=A0=C2=A0=C2=A0- if all the device have the same transaction i=
d
>  =C2=A0=C2=A0=C2=A0=C2=A0- if ...
>  =C2=A0 if any of the check above fails, write an error message; otherwi=
se
> - register the device(s) in the kernel or (better) pass it in the mount
> command
>  =C2=A0 line
> - finally mount the filesystem
>
>
> No need of strange flag; all the corner case can be handle safely and av=
oid
> any confusion to the user.

Just handling corner cases is not good for maintaining already.

So nope, I don't believe this is the good way to go.

Furthermore, if someone really found the same fsid limits is a problem,
they should go with the SINGLE_DEV features, not relying on some extra
corner cases handling, which may or may not be supported on certain kernel=
s.

On the other handle, a compat_ro flag is clear dedicated way to tell the
compatibility.

In fact, if you're going to introduce an unexpected behavior change,
it's way more strange to do without any compat_ro/ro/incompact flags.

Thanks,
Qu
>
>
>
>
>
>
>>
>> =C2=A0=C2=A0 And this is going to change device add code path quite hug=
ely.
>> =C2=A0=C2=A0 We currently expects all device scan/trace thing done way =
before
>> =C2=A0=C2=A0 mount.
>> =C2=A0=C2=A0 Such huge change can lead to hidden bugs.
>>
>> To me, neither is good to the end users.
>>
>> A SINGLE_DEV feature would reject the corner case in a way more
>> user-friendly and clear way.
>>
>> =C2=A0=C2=A0 With SINGLE_DEV feature, just no dev add/replace/delete no=
 matter
>> =C2=A0=C2=A0 what.
>>
>>
>>>
>>> I have to point out that this problem would be easily solved in
>>> userspace if we switch from the current model where the disks are
>>> scanned asynchronously (udev which call btrfs dev scan) to a model
>>> where the disk are scanned at mount time by a mount.btrfs helper.
>>>
>>> A mount.btrfs helper, also could be a place to put some more clear err=
or
>>> message like "we cannot mount this filesystem because one disk of a
>>> raid5 is missing, try passing -o degraded"
>>> or "we cannot mount this filesystem because we detect a brain split
>>> problem" ....
>>>
>>> 2) mount two different fs with the same UUID at the SAME time:
>>> This is a bit more complicated; we need to store a virtual UUID
>>> somewhere.
>>>
>>> However sometime we need to use the real fsid (during a write),
>>> and sometime we need to use the virtual_uuid (e.g. for
>>> /sys/fs/btrfs/<uuid>)
>>
>> Another thing is, we already have too many uuids.
>>
>> Some are unavoidable like fsid and device uuid.
>>
>> But I still prefer not to add a new layer of unnecessary uuids.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Both in 1) and 2) we need to/it is enough to have
>>> btrfs_super_block.disks_num =3D=3D 1
>>> In the case 2) using a virtual_uuid mount option will prevent
>>> to add a disk.
>>
>
