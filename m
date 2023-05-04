Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542FE6F77CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 23:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEDVKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 17:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEDVKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 17:10:47 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 14:10:45 PDT
Received: from libero.it (smtp-32.italiaonline.it [213.209.10.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990861385A
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 14:10:45 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.135.124])
        by smtp-32.iol.local with ESMTPA
        id ugCppiLdIeiWIugCqp7FK6; Thu, 04 May 2023 23:09:41 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1683234581; bh=FCz0cBfpfz82x2ioZh6TbbJgQJZbCHOKGVrnU+4mMKw=;
        h=From;
        b=lWbaAr5JmA1cWKuCWPUJhBAvXtnzKCRK2YyUUaPfp0aLzghyDA/bNopItqNe9rD23
         g0FiqDO4tfxQ/yE0ELbUBg1iG/puFyKq2AiqqzVZxGdVcxbKRmCrv7gyZdY3b+V0p/
         7sY9H4SGqrEKIvAy8chT/oknGybV5dUeutX/Rk9OniFQdGO/NtuT9v5dy694AsnfwT
         /oXrSZRsBncTxmg40NnjZIHGf4qSk8bKDC/uSXNa2n9/fa6z7+tLqQcs08i0QAbkP6
         4q7SBOS/y4Cpj12Dc0BVn3MOdYAaYY7bBiOWhwPAx/VY2mCNnX70PJ/vBz+ZqvwNT3
         jor0Dy2abuNhw==
X-CNFS-Analysis: v=2.4 cv=aYun3zkt c=1 sm=1 tr=0 ts=64541f15 cx=a_exe
 a=qXvG/jU0CoArVbjQAwGUAg==:117 a=qXvG/jU0CoArVbjQAwGUAg==:17
 a=IkcTkHD0fZMA:10 a=pFx6aJ86eklTIDPkIqkA:9 a=QEXdDO2ut3YA:10
Message-ID: <e42e2e38-2c79-c14e-a06b-65d94c37e3db@inwind.it>
Date:   Thu, 4 May 2023 23:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <5056b834-077c-d1bb-4c46-3213bf6da74b@libero.it>
 <1818142b-ec3a-323d-7a8d-0b93c33756fc@igalia.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <1818142b-ec3a-323d-7a8d-0b93c33756fc@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBVy9DfIznZK9ebDAh69274pyftF29JIjH63I1qBmRtSE0DotuV7U9dtSQj0c28Afy8a1gX4/oen+9vzfwtaFuhv1upY7RMbjtkl0rml26qZopCv61nD
 n41usLNp1WfA6wu4/qVjg9kJBblMeOoyHc+/2kKxTkzPPZQZH8R7yA7PWzQRu37UoT8dDTVNHwhGq30FM3kYJsoEjE4E+j5TnjVO09PZEFqVb+zkUmhOZbR/
 hGV6bZIpWWKMybMeXteGtmvQpAXmoTRkYQ82FmcV78p74jSQRHylhN/lXXvWiAaO1hAmEQ4B5kkEwcPcrSR267fQb8hogmKSUMJTcMLpF+qK0QrUnHly7CjG
 vEo0DuO2r74vZvVCvukv/Xw8MlkTAxAXQ33yN988P6/7+qQdtUZJjNp0n4YrMzTdSShOXoe3fpr571AASuD1mZXrSR0iSgJ0QDpwrbTps0B8VW2u+C/B83r9
 NqheBbkfU2djevoFqHjfbLn87BVhYrwly1sn/ZcM7ptz7HQ4GzcD5DHq1IY=
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/05/2023 22.10, Guilherme G. Piccoli wrote:
> On 04/05/2023 16:28, Goffredo Baroncelli wrote:
>> [...]
>> Hi Guilherme,
>>
>> did you tried to run "btrfs dev scan --forget /dev/sd.." before
>> mount the filesystem ?
>>
>> Assuming that you have two devices /dev/sdA and /dev/sdB with two btrfs
>> filesystem with the same uuid, you should mount /dev/sdA
>>
>> btrfs dev scan --forget /dev/sdB # you can use event /dev/sdA
>> mount /dev/sdA /mnt/target
>>
>> and to mount /dev/sdB
>>
>> btrfs dev scan --forget /dev/sdA # you can use event /dev/sdB
>> mount /dev/sdB /mnt/target
>>
>> I made a quick test using two loop devices and it seems that it works
>> reliably.
> 
> Hi Goffredo, thanks for your suggestion!
> 
> This seems interesting with regards the second patch here..indeed, I can
> mount any of the 2 filesystems if I use the forget option - interesting
> option, wasn't aware of that.
> 
> But unfortunately it seems limited to mounting one device at a time, and
> we need to be able to mount *both* of them, due to an installation step.
> If I try to forget the device that is mounted, it gets (obviously) a
> "busy device" error.

Ahh, I didn't realized that you want to mount the two FS at the
same time.

> 
> Is there any missing step from my side, or mounting both devices is
> really a limitation when using the forget option?
> 

 From my limited BTRFS internal knowledge, I think that your patches
takes the correct approach: using the "metadata_uuid" code to allow
two filesystems with the same uuid to exist at the same time.


> 
>>
>> Another option should be make a kernel change that "forget" the device
>> before mounting *if* the filesystem is composed by only one device (
>> and another few exceptions like the filesystem is already mounted).
>>
>> This would avoid all the problem related to make a "temporary" uuid.
> 
> I guess again this would be useful in the scope of the second patch
> here...we could check the way you're proposing instead of having the
> module parameter. In a way this is similar to the forget approach,
> right? But it's kind of an "automatic" forget heh
> 
> How btrfs would know it is a case for single-device filesystem? In other
> words: how would we distinguish between the cases we want to auto-forget
> before mounting, and the cases in which this behavior is undesired?

If I remember correctly in the super-block there is the number of disks
that compose the filesystem. If the count is 1, it should be safe to
forget-before-mount the filesystem (or to not store in the cache
after a scan)


> 
> Thanks again for your feedback, it is much appreciated.
> Cheers,
> 
> 
> Guilherme

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

