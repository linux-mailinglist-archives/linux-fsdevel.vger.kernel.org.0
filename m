Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DF77416D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjF1Q5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 12:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjF1Q5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:57:08 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33430198A
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 09:57:04 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3426f04daf8so5652755ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687971423; x=1690563423;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OppdXy0w3Vc+UjmlsI4lMkBExnAWB4DyrS+PHEKoceA=;
        b=kNjUcJWz6/3eNA0QHbffaSQ/2PJIrvcsm/+xdC+zVxYPWoP7EO/wyCrxhXal295cRr
         sDydonv+8x9QeXkEb3XBXcfrldsTqBCIeDH7NZ3Yek6Pd/05n4rP4sv55/fzzJef2inv
         RALnk5sSbYIBXBtpDby7kzoNfIrKBoGSFpG+hyHVIdWWjXH6rsdLS9ESAVomK5KTX35J
         pxnTiTEw6UW1o6pSi3/dA3gJ/gD3pQZDE6mhN3fNtGrWFrpok0wyr398iMXxTIj9J1JC
         iDbJaXhoMIgSDW3IOHoqNJqg0TMS9w3UU8R3QOSRkrY56/kL4DUZG1geNfwaL0as6//K
         xMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687971423; x=1690563423;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OppdXy0w3Vc+UjmlsI4lMkBExnAWB4DyrS+PHEKoceA=;
        b=XdZk7jEcwZavpWjKxHOp3R51CQLctMhw3jXlfT8oZeYNc+QNK+aSVwm+Z48l/LSEBP
         cUiP8GPxQ65Kw45ILwQnsQXQBaAjBFs1P8UxmalKf+84jOeyyuCMUZ85RszAfUNCxUKP
         usRDqF++9mIZZvDz0uznqU9lq79yYGy3zG9GW1WeOt0N3IYMCbNsZ3KKdTf5Yz2sheyN
         lYSEGhye9pMxfm+dpjQId05NSxlPWxHfoN+xt8pzugc4raSpAadSfmCkDg2UCmcrumko
         8jR5Inv71FiU8tTCqwi9F/yE+qRd9OsGjF8QwzXqDlR0Vhd05lSYXa6+Pk7sZmBB9jD6
         4RRA==
X-Gm-Message-State: AC+VfDzd4EHIHrP6JygSLLdSmRJqHzClbiN70Gtoy72eDX37KWyOONxe
        INQECS09RifjqT8LQ20dP1IG/w==
X-Google-Smtp-Source: ACHHUZ616tY6XEvr4y/z3VG1Yzhf6efd1xUGJeUgEvwLJKqWmBM8bFmVW3ZqfT+srPnr9ZxkQm5vBw==
X-Received: by 2002:a6b:3b06:0:b0:780:cde6:3e22 with SMTP id i6-20020a6b3b06000000b00780cde63e22mr17644062ioa.0.1687971423454;
        Wed, 28 Jun 2023 09:57:03 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dq34-20020a0566384d2200b0042566919376sm3173364jab.30.2023.06.28.09.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 09:57:02 -0700 (PDT)
Message-ID: <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
Date:   Wed, 28 Jun 2023 10:57:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
In-Reply-To: <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 8:58?AM, Jens Axboe wrote:
> On 6/27/23 10:01?PM, Kent Overstreet wrote:
>> On Tue, Jun 27, 2023 at 09:16:31PM -0600, Jens Axboe wrote:
>>> On 6/27/23 2:15?PM, Kent Overstreet wrote:
>>>>> to ktest/tests/xfstests/ and run it with -bcachefs, otherwise it kept
>>>>> failing because it assumed it was XFS.
>>>>>
>>>>> I suspected this was just a timing issue, and it looks like that's
>>>>> exactly what it is. Looking at the test case, it'll randomly kill -9
>>>>> fsstress, and if that happens while we have io_uring IO pending, then we
>>>>> process completions inline (for a PF_EXITING current). This means they
>>>>> get pushed to fallback work, which runs out of line. If we hit that case
>>>>> AND the timing is such that it hasn't been processed yet, we'll still be
>>>>> holding a file reference under the mount point and umount will -EBUSY
>>>>> fail.
>>>>>
>>>>> As far as I can tell, this can happen with aio as well, it's just harder
>>>>> to hit. If the fput happens while the task is exiting, then fput will
>>>>> end up being delayed through a workqueue as well. The test case assumes
>>>>> that once it's reaped the exit of the killed task that all files are
>>>>> released, which isn't necessarily true if they are done out-of-line.
>>>>
>>>> Yeah, I traced it through to the delayed fput code as well.
>>>>
>>>> I'm not sure delayed fput is responsible here; what I learned when I was
>>>> tracking this down has mostly fell out of my brain, so take anything I
>>>> say with a large grain of salt. But I believe I tested with delayed_fput
>>>> completely disabled, and found another thing in io_uring with the same
>>>> effect as delayed_fput that wasn't being flushed.
>>>
>>> I'm not saying it's delayed_fput(), I'm saying it's the delayed putting
>>> io_uring can end up doing. But yes, delayed_fput() is another candidate.
>>
>> Sorry - was just working through my recollections/initial thought
>> process out loud
> 
> No worries, it might actually be a combination and this is why my
> io_uring side patch didn't fully resolve it. Wrote a simple reproducer
> and it seems to reliably trigger it, but is fixed with an flush of the
> delayed fput list on mount -EBUSY return. Still digging...

I discussed this with Christian offline. I have a patch that is pretty
simple, but it does mean that you'd wait for delayed fput flush off
umount. Which seems kind of iffy.

I think we need to back up a bit and consider if the kill && umount
really is sane. If you kill a task that has open files, then any fput
from that task will end up being delayed. This means that the umount may
very well fail.

It'd be handy if we could have umount wait for that to finish, but I'm
not at all confident this is a sane solution for all cases. And as
discussed, we have no way to even identify which files we'd need to
flush out of the delayed list.

Maybe the test case just needs fixing? Christian suggested lazy/detach
umount and wait for sb release. There's an fsnotify hook for that,
fsnotify_sb_delete(). Obviously this is a bit more involved, but seems
to me that this would be the way to make it more reliable when killing
of tasks with open files are involved.

-- 
Jens Axboe

