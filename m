Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E9F16715
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 17:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfEGPou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 11:44:50 -0400
Received: from mail-yw1-f45.google.com ([209.85.161.45]:40402 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEGPou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 11:44:50 -0400
Received: by mail-yw1-f45.google.com with SMTP id 18so8775748ywe.7;
        Tue, 07 May 2019 08:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=95PbOYAHtHirAH273eT8TE+sELrKNbTZVJfMG89uTQQ=;
        b=Rm1d97Ww/qfjixZBExu6LQA0eIl7cJomOSjGKK3EAo1kJWSXjUD+SfZVa8kPD8Bem0
         tXsXCBq/MPvUkPsc9YpGSQKzDwIxtJdb20pssSuYySmU6nNmOKpwaSaqFmgUlewZGHp6
         8t7sVPowTutJI+auBxi9wABjgxvWtoytpsPk28Q7OfeydObi1zsPn6dDT2eKr9T7Rd2Y
         z2g7UAA1v8Xw2KtX1Ab/YaMhQRJvmj+X7jkdNhrjLIWE0uDHqPi53gSmg9khrvj998gJ
         t3Nt6R1zcOgYBXn80LswdqeTzCL3JQLcQ83s8HVPCCXrpuJzovGS2Nbp6v8s8V5ErH6I
         FUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=95PbOYAHtHirAH273eT8TE+sELrKNbTZVJfMG89uTQQ=;
        b=G1jt16AxxiDYrmVJMXGDAfVFHwF8xJyAAEpxmLa29XL2ZpyGmYT1VLY+9/349AmexV
         efu6laHAQv6o+PMOgHzv0g/jwAu2Tej4plEvLt0ojK/zNYq4zI5Yb7jmQWmnV8r+pMG4
         AuEfUOI327H7JFAQdASeNBtfqKtSa2Bbfr0f90/1YdkxDwrt7KvonPECKjLZmAkMRWzK
         UYijqJ/FkVuW0T2Z+7sibkMOcyP6oxhibD5G/mdODrwlg0Gx41UxwGrQJjHfCG75qPVk
         +XGzDzTPE11VO3nlY9QES2ya9AZHzji27XJ5qNViqDa0ptqZQxHMGqdLJrqRx82okYS3
         Tf4Q==
X-Gm-Message-State: APjAAAVfaOYbM92HUYTpb0ICINd8+7FDW8XX035pgU3jcXOQ4DF6h7Iu
        IHgnv201rldzbEm9QMz/8MY=
X-Google-Smtp-Source: APXvYqxMPIIzlpPQeHXi6Y0U8C6AYLaLtrKXhZ0O1VUDWm6RqHvgfOX8c0wXQ4yTm722V1k5VeNXdw==
X-Received: by 2002:a25:40d:: with SMTP id 13mr21925188ybe.9.1557243888605;
        Tue, 07 May 2019 08:44:48 -0700 (PDT)
Received: from localhost.localdomain ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id w3sm3808445ywc.45.2019.05.07.08.44.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 08:44:47 -0700 (PDT)
Subject: Re: Testing devices for discard support properly
To:     Bryan Gurney <bgurney@redhat.com>
Cc:     Lukas Czerner <lczerner@redhat.com>, Jan Tulak <jtulak@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507071021.wtm25mxx2as6babr@work>
 <CACj3i71HdW0ys_YujGFJkobMmZAZtEPo7B2tgZjEY8oP_T9T6g@mail.gmail.com>
 <20190507094015.hb76w3rjzx7shxjp@work>
 <09953ba7-e4f2-36e9-33b7-0ddbbb848257@gmail.com>
 <CAHhmqcT_yabMDY+dZoBAUA28f6tkPe0uH+xtRUS51gvv4p2vuQ@mail.gmail.com>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <5a02e30d-cb46-a2ab-554f-b8ef4807bd97@gmail.com>
Date:   Tue, 7 May 2019 11:44:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHhmqcT_yabMDY+dZoBAUA28f6tkPe0uH+xtRUS51gvv4p2vuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/7/19 11:35 AM, Bryan Gurney wrote:
> On Tue, May 7, 2019 at 8:57 AM Ric Wheeler <ricwheeler@gmail.com> wrote:
>>
>> On 5/7/19 5:40 AM, Lukas Czerner wrote:
>>> On Tue, May 07, 2019 at 10:48:55AM +0200, Jan Tulak wrote:
>>>> On Tue, May 7, 2019 at 9:10 AM Lukas Czerner <lczerner@redhat.com> wrote:
>>>>> On Mon, May 06, 2019 at 04:56:44PM -0400, Ric Wheeler wrote:
>>>> ...
>>>>>> * Whole device discard at the block level both for a device that has been
>>>>>> completely written and for one that had already been trimmed
>>>>> Yes, usefull. Also note that a long time ago when I've done the testing
>>>>> I noticed that after a discard request, especially after whole device
>>>>> discard, the read/write IO performance went down significanly for some
>>>>> drives. I am sure things have changed, but I think it would be
>>>>> interesting to see how does it behave now.
>>
>> My understanding of how drives (not just SSD's but they are the main
>> target here) can handle a discard can vary a lot, including:
>>
>> * just ignore it for any reason and not return a failure - it is just a
>> hint by spec.
>>
>> * update metadata to mark that region as unused and then defer any real
>> work to later (like doing wear level stuff, pre-erase for writes, etc).
>> This can have a post-discard impact. I think of this kind of like
>> updating page table entries for virtual memory - low cost update now,
>> all real work deferred.
>>
>> * do everything as part of the command - this can be relatively slow,
>> most of the cost of a write I would guess (i.e., go in and over-write
>> the region with zeros or just do the erase of the flash block under the
>> region).
>>
>> Your earlier work supports the need to test IO performance after doing
>> the trims/discards - we might want to test it right away, then see if
>> waiting 10 minutes, 30 minutes, etc helps?
> Using blktrace / blkparse may be a good way to visualize certain
> latency differences of a drive, depending on the scenario.
>
> I tried these quick fio tests in succession while tracing an NVMe device:
>
> - fio --name=writetest --filename=/dev/nvme0n1p1 --rw=write
> --bs=1048576 --size=2G --iodepth=32 --ioengine=libaio --direct=1
> - fio --name=writetest --filename=/dev/nvme0n1p1 --rw=trim
> --bs=1048576 --size=128M --iodepth=32 --ioengine=libaio --direct=1
> - fio --name=writetest --filename=/dev/nvme0n1p1 --rw=write
> --bs=1048576 --size=2G --iodepth=32 --ioengine=libaio --direct=1
>
> ...and if I run "blkparse -t -i nvme0n1p1.blktrace.0", I see output
> that looks like this:
>
> (The number after the "sector + size" in parentheses is the "time
> delta per IO", which I believe is effectively the "completion latency"
> for the IO.)
>
> 259,1   23       42     0.130790560 13843  C  WS 2048 + 256 (   69234) [0]
> 259,1   23       84     0.130832015 13843  C  WS 2304 + 256 (  106529) [0]
> 259,1   23      110     0.130879691 13843  C  WS 2560 + 256 (  151234) [0]
> 259,1   23      127     0.130932938 13843  C  WS 2816 + 256 (  201708) [0]
> 259,1   23      169     0.130985313 13843  C  WS 3072 + 256 (  251695) [0]
> 259,1   23      244     0.131068599 13843  C  WS 3328 + 256 (  332505) [0]
> 259,1   23      255     0.131120364 13843  C  WS 3584 + 256 (  382228) [0]
> 259,1   23      295     0.131169431 13843  C  WS 3840 + 256 (  429079) [0]
> 259,1   23      337     0.131254437 13843  C  WS 4096 + 256 (  452715) [0]
> 259,1   23      379     0.131303693 13843  C  WS 4352 + 256 (  498415) [0]
> ...
>
> 259,1   23     2886     0.145571119     0  C  WS 68864 + 256 (12172318) [0]
> 259,1   23     2887     0.145621801     0  C  WS 69120 + 256 (12220934) [0]
> 259,1   23     2888     0.145707376     0  C  WS 69376 + 256 (12304282) [0]
> 259,1   23     2889     0.145758056 13843  C  WS 69632 + 256 (12305257) [0]
> 259,1   23     2897     0.145806491 13843  C  WS 69888 + 256 (12351416) [0]
> 259,1   23     2932     0.145855909     0  C  WS 70144 + 256 (12398688) [0]
> 259,1   23     2933     0.145906931     0  C  WS 70400 + 256 (12447322) [0]
> 259,1   23     2934     0.145955324     0  C  WS 70656 + 256 (12493640) [0]
> 259,1   23     2935     0.146047271     0  C  WS 70912 + 256 (12583404) [0]
> 259,1   23     2936     0.146098918     0  C  WS 71168 + 256 (12633107) [0]
> 259,1   23     2937     0.146147758     0  C  WS 71424 + 256 (12680779) [0]
> 259,1   23     2938     0.146199611 13843  C  WS 71680 + 256 (12673451) [0]
> 259,1   23     2947     0.146248198 13843  C  WS 71936 + 256 (12717754) [0]
> ...
>
> 259,1   19        8     1.654335893     0  C  DS 2048 + 2048 (  703367) [0]
> 259,1   19       16     1.654407034     0  C  DS 4096 + 2048 (   16801) [0]
> 259,1   19       24     1.654441037     0  C  DS 6144 + 2048 (   14973) [0]
> 259,1   19       32     1.654473187     0  C  DS 8192 + 2048 (   18403) [0]
> 259,1   19       40     1.654508066     0  C  DS 10240 + 2048 (   15949) [0]
> 259,1   19       48     1.654546974     0  C  DS 12288 + 2048 (   25803) [0]
> 259,1   19       56     1.654575186     0  C  DS 14336 + 2048 (   15839) [0]
> 259,1   19       64     1.654602836     0  C  DS 16384 + 2048 (   15449) [0]
> 259,1   19       72     1.654629376     0  C  DS 18432 + 2048 (   14659) [0]
> 259,1   19       80     1.654655744     0  C  DS 20480 + 2048 (   14653) [0]
> 259,1   19       88     1.654682306     0  C  DS 22528 + 2048 (   14769) [0]
> 259,1   19       96     1.654710616     0  C  DS 24576 + 2048 (   16660) [0]
> 259,1   19      104     1.654737113     0  C  DS 26624 + 2048 (   14876) [0]
> 259,1   19      112     1.654763661     0  C  DS 28672 + 2048 (   14707) [0]
> 259,1   19      120     1.654790141     0  C  DS 30720 + 2048 (   14809) [0]
>
> I can see two things:
>
> 1. The writes appear to be limited to 128 kilobytes, which agrees with
> the device's "queue/max_hw_sectors_kb" value.
> 2. The discard completion latency ("C DS" actions) is very low, at
> about 16 microseonds.
>
> It's possible to filter this output further:
>
> blkparse -t -i nvme0n1p1.blktrace.0 | grep C\ *[RWD] | tr -d \(\) |
> awk '{print $4, $6, $7, $8, $9, $10, $11}'
>
> ...to yield output that's more digestible to a graphing program like gnuplot:
>
> 0.130790560 C WS 2048 + 256 69234
> 0.130832015 C WS 2304 + 256 106529
> 0.130879691 C WS 2560 + 256 151234
> 0.130932938 C WS 2816 + 256 201708
> 0.130985313 C WS 3072 + 256 251695
> 0.131068599 C WS 3328 + 256 332505
> 0.131120364 C WS 3584 + 256 382228
>
> ...at which point you can look at the graph, and see patterns, like
> the peak latency during a sustained write, or "two bands" of latency,
> as though there are "two queues" on the device, for some reason, and
> so on.
>
> I usually create a graph with the timestamp as the X axis, and the
> "track-ios" output as the Y axis.


Thanks Bryan - this is very much in line with what I think we need to 
do. If we can get the right mix of jobs for fio to run to verify this, 
it will make it easy for everyone to contribute and for the vendors to 
use internally.

I don't have a lot of time soon, but plan to play with this over the 
next few weeks.

Regards,

Ric


>>>>>> * Discard performance at the block level for 4k discards for a device that
>>>>>> has been completely written and again the same test for a device that has
>>>>>> been completely discarded.
>>>>>>
>>>>>> * Same test for large discards - say at a megabyte and/or gigabyte size?
>>>>>   From my testing (again it was long time ago and things probably changed
>>>>> since then) most of the drives I've seen had largely the same or similar
>>>>> timing for discard request regardless of the size (hence, the conclusion
>>>>> was the bigger the request the better). A small variation I did see
>>>>> could have been explained by kernel implementation and discard_max_bytes
>>>>> limitations as well.
>>>>>
>>>>>> * Same test done at the device optimal discard chunk size and alignment
>>>>>>
>>>>>> Should the discard pattern be done with a random pattern? Or just
>>>>>> sequential?
>>>>> I think that all of the above will be interesting. However there are two
>>>>> sides of it. One is just pure discard performance to figure out what
>>>>> could be the expectations and the other will be "real" workload
>>>>> performance. Since from my experience discard can have an impact on
>>>>> drive IO performance beyond of what's obvious, testing mixed workload
>>>>> (IO + discard) is going to be very important as well. And that's where
>>>>> fio workloads can come in (I actually do not know if fio already
>>>>> supports this or not).
>>>>>
>> Really good points. I think it is probably best to test just at the
>> block device level to eliminate any possible file system interactions
>> here.  The lessons learned though might help file systems handle things
>> more effectively?
>>
>>>> And:
>>>>
>>>> On Tue, May 7, 2019 at 10:22 AM Nikolay Borisov <nborisov@suse.com> wrote:
>>>>> I have some vague recollection this was brought up before but how sure
>>>>> are we that when a discard request is sent down to disk and a response
>>>>> is returned the actual data has indeed been discarded. What about NCQ
>>>>> effects i.e "instant completion" while doing work in the background. Or
>>>>> ignoring the discard request altogether?
>>>> As Nikolay writes in the other thread, I too have a feeling that there
>>>> have been a discard-related discussion at LSF/MM before. And if I
>>>> remember, there were hints that the drives (sometimes) do asynchronous
>>>> trim after returning a success. Which would explain the similar time
>>>> for all sizes and IO drop after trim.
>>> Yes, that was definitely the case  in the past. It's also why we've
>>> seen IO performance drop after a big (whole device) discard as the
>>> device was busy in the background.
>> For SATA specifically, there was a time when the ATA discard command was
>> not queued so we had to drain all other pending requests, do the
>> discard, and then resume. This was painfully slow then (not clear that
>> this was related to the performance impact you saw - it would be an
>> impact I think for the next few dozen commands?).
>>
>> The T13 people (and most drives I hope) fixed this years back to be a
>> queued command so we don't have that same concern now I think.
> There are still some ATA devices that are blacklisted due to problems
> handling queued trim (ATA_HORKAGE_NO_NCQ_TRIM), as well as problems
> handing zero-after-trim (ATA_HORKAGE_ZERO_AFTER_TRIM).  Most newer
> drives fixed those problems, but the older drives will still be out in
> the field until they get replaced with newer drives.
>
> The "zero after trim" issue might be important to applications that
> expect a discard to zero the blocks that were specified in the discard
> command.  For drives that "post-process" discards, is there a time
> threshold of when those blocks are expected to return zeroes?
>
>
> Thanks,
>
> Bryan
>
>>> However Nikolay does have a point. IIRC device is free to ignore discard
>>> requests, I do not think there is any reliable way to actually tell that
>>> the data was really discarded. I can even imagine a situation that the
>>> device is not going to do anything unless it's pass some threshold of
>>> free blocks for wear leveling. If that's the case our tests are not
>>> going to be very useful unless they do stress such corner cases. But
>>> that's just my speculation, so someone with a better knowledge of what
>>> vendors are doing might tell us if it's something to worry about or not.
>>
>> The way I think of it is our "nirvana" state for discard would be:
>>
>> * all drives have very low cost discard commands with minimal
>> post-discard performance impact on the normal workload which would let
>> us issue the in-band discards (-o discard mount option)
>>
>> * drives might still (and should be expected to) ignore some of these
>> commands so freed and "discarded" space might still not be really discarded.
>>
>> * we will still need to run a periodic (once a day? a week?) fstrim to
>> give the drive a chance to clean up anything even when using "mount -o
>> discard". Of course, the fstrim size is bigger I expect than the size
>> from inband discard so testing larger sizes will be important.
>>
>> Does this make sense?
>>
>> Ric
>>
>>
>>>> So, I think that the mixed workload (IO + discard) is a pretty
>>>> important part of the whole topic and a pure discard test doesn't
>>>> really tell us anything, at least for some drives.
>>> I think both are important especially since mixed IO tests are going to
>>> be highly workload specific.
>>>
>>> -Lukas
>>>
>>>> Jan
>>>>
>>>>
>>>>
>>>> --
>>>> Jan Tulak
