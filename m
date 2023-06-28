Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179F1741ABA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 23:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjF1VWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 17:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjF1VWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:22:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FB435BF
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 14:17:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b7e31154c4so660705ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687987065; x=1690579065;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQziuYew91uw/0bw2Pl0Zc1BFg+GVKPj9CR2YVGi5Aw=;
        b=t0JfEyC4VCwk0TDX5fgFzNA1W/AC0cp+cY4pSXiKLQ5cRkjoC9Auv7zdmpsRdNo9SL
         Kev05hC8jnTwSuWnzLfDnB6qHIV9Z8QOZXBMldUNiWSTyayPXkFgdyiqjmSkU+G9E42G
         am0pzlVPpYFnCh8DBcK8JMdjVbD4Ok1bKqAzdvVmlmSfcd1v4kyA6LYjWIV1e6mEW6yL
         lc6hKXH4wIYu64cAzVsLS+L09TZ6qCT7aWT0XFzXtyEPKybvsimdjobwgPI+BVKSHhJG
         VGczUOtqgaziUl4AAlB/DnyZZ2Fj3k1LyDhLomXMrDgf2BaaIP5FAkvxa7yd67z+BSMQ
         pFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687987065; x=1690579065;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQziuYew91uw/0bw2Pl0Zc1BFg+GVKPj9CR2YVGi5Aw=;
        b=ZYGTMVFb9lSOK9rL3Bl8k5+yYJcI815MHd0gokYDKl7ePZNZSRYkq1W74vVcxpBBXU
         AR2Fn8KGVZ/JiY2KmLD7X3bnaVpNVTK95I1o+rpy+gcNPoOFqb6PmADpgnHbZqiRgj+E
         GzvFOmnXibAy5My/wy0CCwRzAswu5Z8BLv6syb1MHKUJPpI6OtE/PjkAA7462HXhUvjm
         uYmkV1dzvBmW6roD1nXp1Z5BEG6w2xSNcRVP/Idedl2CzDEOrXGfOcIREUhUD2yUlN5w
         wjlI5RAVqEjGrUtc/E7wfFeZe90dvlL5K672VvhT7MVF4Pvm+CmSG+nUPCqlbP+3dAiz
         1z8Q==
X-Gm-Message-State: AC+VfDxR6BAMIEAUVrG/0idEOmBvJaBnLS/N4dlM24MONG99rFqzWQ8u
        4lNy2mvFuv6Y9t6O3Ekj7Uhlptyo6mZMqvhAUCI=
X-Google-Smtp-Source: ACHHUZ7wLqD+FTjJOLVRqthq+lfZRxWqssJ5dC4d2+07nBRUW0cx35fP1Tj7YFExunDGZggSBp2MMQ==
X-Received: by 2002:a17:903:2051:b0:1b8:2ba0:c9a8 with SMTP id q17-20020a170903205100b001b82ba0c9a8mr4657183pla.2.1687987065278;
        Wed, 28 Jun 2023 14:17:45 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id az12-20020a170902a58c00b001b0034557afsm8086924plb.15.2023.06.28.14.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 14:17:44 -0700 (PDT)
Message-ID: <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
Date:   Wed, 28 Jun 2023 15:17:43 -0600
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
References: <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
 <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
 <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
In-Reply-To: <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 2:44?PM, Jens Axboe wrote:
> On 6/28/23 11:52?AM, Kent Overstreet wrote:
>> On Wed, Jun 28, 2023 at 10:57:02AM -0600, Jens Axboe wrote:
>>> I discussed this with Christian offline. I have a patch that is pretty
>>> simple, but it does mean that you'd wait for delayed fput flush off
>>> umount. Which seems kind of iffy.
>>>
>>> I think we need to back up a bit and consider if the kill && umount
>>> really is sane. If you kill a task that has open files, then any fput
>>> from that task will end up being delayed. This means that the umount may
>>> very well fail.
>>>
>>> It'd be handy if we could have umount wait for that to finish, but I'm
>>> not at all confident this is a sane solution for all cases. And as
>>> discussed, we have no way to even identify which files we'd need to
>>> flush out of the delayed list.
>>>
>>> Maybe the test case just needs fixing? Christian suggested lazy/detach
>>> umount and wait for sb release. There's an fsnotify hook for that,
>>> fsnotify_sb_delete(). Obviously this is a bit more involved, but seems
>>> to me that this would be the way to make it more reliable when killing
>>> of tasks with open files are involved.
>>
>> No, this is a real breakage. Any time we introduce unexpected
>> asynchrony there's the potential for breakage: case in point, there was
>> a filesystem that made rm asynchronous, then there were scripts out
>> there that deleted until df showed under some threshold.. whoops...
> 
> This is nothing new - any fput done from an exiting task will end up
> being deferred. The window may be a bit wider now or a bit different,
> but it's the same window. If an application assumes it can kill && wait
> on a task and be guaranteed that the files are released as soon as wait
> returns, it is mistaken. That is NOT the case.

Case in point, just changed my reproducer to use aio instead of
io_uring. Here's the full script:

#!/bin/bash

DEV=/dev/nvme1n1
MNT=/data
ITER=0

while true; do
	echo loop $ITER
	sudo mount $DEV $MNT
	fio --name=test --ioengine=aio --iodepth=2 --filename=$MNT/foo --size=1g --buffered=1 --overwrite=0 --numjobs=12 --minimal --rw=randread --output=/dev/null &
	Y=$(($RANDOM % 3))
	X=$(($RANDOM % 10))
	VAL="$Y.$X"
	sleep $VAL
	ps -e | grep fio > /dev/null 2>&1
	while [ $? -eq 0 ]; do
		killall -9 fio > /dev/null 2>&1
		echo will wait
		wait > /dev/null 2>&1
		echo done waiting
		ps -e | grep "fio " > /dev/null 2>&1
	done
	sudo umount /data
	if [ $? -ne 0 ]; then
		break
	fi
	((ITER++))
done

and if I run that, fails on the first umount attempt in that loop:

axboe@m1max-kvm ~> bash test2.sh
loop 0
will wait
done waiting
umount: /data: target is busy.

So yeah, this is _nothing_ new. I really don't think trying to address
this in the kernel is the right approach, it'd be a lot saner to harden
the xfstest side to deal with the umount a bit more sanely. There are
obviously tons of other ways that a mount could get pinned, which isn't
too relevant here since the bdev and mount point are basically exclusive
to the test being run. But the kill and delayed fput is enough to make
that case imho.

-- 
Jens Axboe

