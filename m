Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65D46F9357
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 19:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjEFRae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 13:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEFRad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 13:30:33 -0400
Received: from libero.it (smtp-32.italiaonline.it [213.209.10.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626316349
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 10:30:28 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.135.124])
        by smtp-32.iol.local with ESMTPA
        id vLjkp1D3ceiWIvLjkpKNWy; Sat, 06 May 2023 19:30:26 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1683394226; bh=aM2BdCxuWcvjG1IHASlzSL1CigYSHKmcQOUF3RHjGLE=;
        h=From;
        b=pF3SZ8yn7nj1i2MGvGcOWqeKSIvxOX1CrBKV9tESMFfVj3nboHykFNhwuDOFnMbRJ
         yE9H98+rR2JCVXLAs8nMiqYoe8xS/bUAaQoWWhSTWiMoXu3NrcH5JMIrIqaxpyHPv+
         Tw2awUQ8huvqqVYAq77hGTWCb+/TQM1CKF4zXdr6Bj9S5ZNDSg4X3d1L+atxU5nbKB
         MLuFDr57H9r8NvYonvy2+EhPNdkbIkG5E1FQNqpHmXqqm5ubcU7sqAnprYpfEJeQRs
         keq9/7f2Ii9LLCNAivUCByxrPVmwBo+re/CRYGRcg9Kt0/YFS0fQxLOJcWTSx78unk
         KeRU3J5+9uWtg==
X-CNFS-Analysis: v=2.4 cv=aYun3zkt c=1 sm=1 tr=0 ts=64568eb2 cx=a_exe
 a=qXvG/jU0CoArVbjQAwGUAg==:117 a=qXvG/jU0CoArVbjQAwGUAg==:17
 a=IkcTkHD0fZMA:10 a=mRE26PnBHUNc0bGyH8MA:9 a=QEXdDO2ut3YA:10
Message-ID: <a440cc5b-6dd0-19a7-9fd6-f940d3f72927@inwind.it>
Date:   Sat, 6 May 2023 19:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
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
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <9e12da58-3c53-79a4-c3fc-733346578965@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfF3MR+pha0gY0uJN9oAM2ofLj0dox9PuLygg8MQ7ytJ93SMccTKfBNemf0w+DSQXE8P4idIsZtJIgn6UHzHr1rNHUroYOTG6iDFA8PO3CWwJZXAyvEYf
 NJOCh9/yietEX9RUgpffh7mF/OsbCVSQYXl0fZmiiZy5Egc7yd6L8X5Ui/7bd0ZaUn5ANoDGoFHpTIDJ/Qc0rd1G18BESdYKXR19MGlE9AESpY8UKvLGO1U+
 nQ+sJosQUNbh0gffTW4c//awdY4Ci98iAxkftniyw4J6bJMqSPBPSA5vJUXsFKMc77xf5yvUJG+VUdf2JbtZXPhXkafSKW5Eg7UpjKMY4ofNQP9WULzB+Xkl
 mHiuqlzhabNnCIqbpybQdm4iwpMyxj+VAh/TtGkJfki8LJ064qmZ12A7isb+d83GZ2oShnpyCG3KtZHDtRFglNyJ7mco4L9gbDfNcA5Cb4qg6JHE/Nyde8b+
 Nlvap+hvau25FxF7Pxw0E9IlID9xw+bJ8Ex+F09GJKj0ABEGbvKV+xrFHJg5Bll73ja/rkd1A9Z+sloiAnAZXRlRyZNUlC/NV2D6V66qeFxXZWt2Hpzr4MD3
 3yaPHY1Loi8UMvN6g6r1LJpv
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/05/2023 00.31, Qu Wenruo wrote:
> 
> 
> On 2023/5/6 01:34, Goffredo Baroncelli wrote:
>> On 05/05/2023 09.21, Qu Wenruo wrote:
>>>
>>> I would prefer a much simpler but more explicit method.
>>>
>>> Just introduce a new compat_ro feature, maybe call it SINGLE_DEV.
>>
>> It is not clear to me if we need that.
>>
>> I don't understand in what checking for SINGLE_DEV is different from
>> btrfs_super_block.disks_num == 1.
> 
> Because disks_num == 1 doesn't exclude the ability to add new disks in the future.
> 
> Without that new SINGLE_DEV compat_ro, we should still do the regular device scan.
> 
>>
>> Let me to argument:
>>
>> I see two scenarios:
>> 1) mount two different fs with the same UUID NOT at the same time:
>> This could be done now with small change in the kernel:
>> - we need to NOT store the data of a filesystem when a disk is
>>    scanned IF it is composed by only one disk
>> - after the unmount we need to discard the data too (checking again
>>    that the filesystem is composed by only one disk)
>>
>> No limit is needed to add/replace a disk. Of course after a disk is
>> added a filesystem with the same UUID cannot be mounted without a
>> full cycle of --forget.
> 
> The problem is, what if:
> 
> - Both btrfs have single disk
> - Both btrfs have the same fsid
> - Both btrfs have been mounted
> - Then one of btrfs is going to add a new disk
> 

Why the user should be prevented to add a disk. It may
a aware user that want to do that, knowing the possible consequence.


[...]

> 
> - Scan and record the fsid/device at device add time
>    This means we should reject the device add.
>    This can sometimes cause confusion to the end user, just because they
>    have mounted another fs, now they can not add a new device.

I agree about the confusion. But not about the cause.
The confusion is due to the poor communication between the kernel (where the error is
detected) and the user. Now the only solution is to look at dmesg.

Allowing to mount two filesystem with the same UUID is technically possible.
There are some constraints bat are well defined; there are some corner case
but are well defined (like add a device to a single device filesystem).

However when we hit one of these corner case, now it is difficult to inform
the user about the problem. Because now the user has to look at the dmesg
to understand what is the problem.

This is the real problem. The communication. And we have a lot of these
problem (like mount a multi device filesystem without some disk, or with a
brain slip problem, or better inform the user if it is possible the
mount -o degraded).

Look this in another way; what if we had a mount.btrfs helper that:

- look for the devices which compose the filesystem at mounting time
- check if these devices are consistent:
	- if the fs is one-device, we don't need further check; otherwise check
	- if all the devices are present
	- if all the device have the same transaction id
	- if ...
   if any of the check above fails, write an error message; otherwise
- register the device(s) in the kernel or (better) pass it in the mount command
   line
- finally mount the filesystem


No need of strange flag; all the corner case can be handle safely and avoid
any confusion to the user.






> 
>    And this is going to change device add code path quite hugely.
>    We currently expects all device scan/trace thing done way before
>    mount.
>    Such huge change can lead to hidden bugs.
> 
> To me, neither is good to the end users.
> 
> A SINGLE_DEV feature would reject the corner case in a way more user-friendly and clear way.
> 
>    With SINGLE_DEV feature, just no dev add/replace/delete no matter
>    what.
> 
> 
>>
>> I have to point out that this problem would be easily solved in
>> userspace if we switch from the current model where the disks are
>> scanned asynchronously (udev which call btrfs dev scan) to a model
>> where the disk are scanned at mount time by a mount.btrfs helper.
>>
>> A mount.btrfs helper, also could be a place to put some more clear error
>> message like "we cannot mount this filesystem because one disk of a
>> raid5 is missing, try passing -o degraded"
>> or "we cannot mount this filesystem because we detect a brain split
>> problem" ....
>>
>> 2) mount two different fs with the same UUID at the SAME time:
>> This is a bit more complicated; we need to store a virtual UUID
>> somewhere.
>>
>> However sometime we need to use the real fsid (during a write),
>> and sometime we need to use the virtual_uuid (e.g. for /sys/fs/btrfs/<uuid>)
> 
> Another thing is, we already have too many uuids.
> 
> Some are unavoidable like fsid and device uuid.
> 
> But I still prefer not to add a new layer of unnecessary uuids.
> 
> Thanks,
> Qu
> 
>>
>> Both in 1) and 2) we need to/it is enough to have btrfs_super_block.disks_num == 1
>> In the case 2) using a virtual_uuid mount option will prevent
>> to add a disk.
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

