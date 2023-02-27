Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0E16A4F0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 23:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjB0W73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 17:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjB0W70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:59:26 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E76196B1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 14:59:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u5so5090701plq.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 14:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo1+0CAZcRCPuZo6afWjNhG3Gxe7y95h40a7cdJ7rLQ=;
        b=URcj7ejY0OrkJ8hJriXtp7W8R3ze0wRJWFVf0YAaryzcqRNYjA/7w12xGnZPmOmG7n
         3hUyGxaVdja2SV/l/0DBxvTyJ8qcvlfijw22U5n9EUpFOZij9KK34C7jvELZiO3t1pru
         Wk2q6xiA+KlXKIH6tmB3LZtta3Pxxc02vyKK9hscmxwX5vn5pIFgsagJ/OBnsxV2YoRk
         t5b9cBBrnnLZ41p2vmf1uf0FHllg+1GDNpIYd4dcHnQoAnioP1N4RhEWqMexXIBTrmy5
         95W+Q5B+G0olfkrIyivPrThuTgVSdP/Mv5zntWBjsDl4E6LTTJAzry3c67I33hEoNNFY
         jWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo1+0CAZcRCPuZo6afWjNhG3Gxe7y95h40a7cdJ7rLQ=;
        b=AdEP7c7arlRNvwuCkYVvLEOjUG09RdcC75zNx0jZlhbPcV4vDaULYwr0GNZqgB8U7S
         y7lVFtMOvgv+AxQv9boifDFRIgoLUi6LKgT8LiT8P9WjIkXgHbGOMPink6KYi5xzr35B
         WN6j0E0ryP2aTKc3lEBs5RN/74+XjYmmdGSd1kPgQrx2XlDd4wqwgiVok1CLGqXdNs3b
         HgFMFdFjjziL6x8krETgPYbNAVNZRCbqaQoY8LTi94iAemF9BvJuLjBD439c5xEWzMRt
         R+qiL2zWOc3vsy6gBkFU+qBv4mhkRZX7InZITnU6Q55y6mqnSamcdTcMqfM0GfrK2Vwy
         te1A==
X-Gm-Message-State: AO0yUKWzO5BGJg+ieVLffI1ADf2yfq29iP799I4r2njC9R/4dZFCYOXc
        Rl8FTzn1hfFCxweGEY3zWpfmhw==
X-Google-Smtp-Source: AK7set8rHp7OGsOOkbs9QJgmhvyaKhBAyG2387dyYEVp9nKTsviDGrdmY5tpGSdcsjuXTb+l4/J2Dw==
X-Received: by 2002:a17:903:11cf:b0:19c:be03:d1ba with SMTP id q15-20020a17090311cf00b0019cbe03d1bamr723376plh.6.1677538760524;
        Mon, 27 Feb 2023 14:59:20 -0800 (PST)
Received: from smtpclient.apple ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id jb5-20020a170903258500b0019ad6451a67sm5141891plb.24.2023.02.27.14.59.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2023 14:59:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [External] [RFC PATCH 00/76] SSDFS: flash-friendly LFS file
 system for ZNS SSD
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <Y/y182cYxNo3zJmb@fedora>
Date:   Mon, 27 Feb 2023 14:59:08 -0800
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>, bruno.banelli@sartura.hr
Content-Transfer-Encoding: quoted-printable
Message-Id: <0237BC64-C920-4A63-B676-B2E972A5AF49@bytedance.com>
References: <Y/y182cYxNo3zJmb@fedora>
To:     Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Feb 27, 2023, at 5:53 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
>> Benchmarking results show that SSDFS is capable:
>=20
> Is there performance data showing IOPS?
>=20

Yeah, I completely see your point. :) Everybody would like to see the =
performance
estimation. My first goal was to check how SSDFS can prolong SSD =
lifetime and
decrease write amplification. So, I used blktrace output to estimate the =
write
amplification factor, lifetime prolongation and compare various file =
systems.
Also, blktrace output contains timestamps information. And I realized =
during
comparison of timestamps that, currently, policy of distribution of =
offset translation table
among logs affects read performance of SSDFS file system. So, if I =
compare the whole
cycle between mount and unmount (read + write I/O), then I can see that =
SSDFS can be
faster than NILFS2, XFS but slower than ext4, btrfs, F2FS. However, =
write I/O path
should be faster because SSDFS can decrease the amount of write I/O =
requests.
I am changing the offset translation table=E2=80=99s distribution policy =
(patch is under testing) and
I expect to improve the SSDFS read performance significantly. So, =
performance
benchmarking will make sense after this fix.

> These comparisions include file systems that don't support zoned =
devices
> natively, maybe that's why IOPS comparisons cannot be made?
>=20

Performance comparison can be made for conventional SSD devices.
Of course, ZNS SSD has some peculiarities (limited number of open/active
zones, zone size, write pointer, strict append-only mode) and it =
requires
fair comparison. Because, these peculiarities/restrictions can as help =
as
make life more difficult. However, even if we can compare file systems =
for
the same type of storage device, then various configuration options
(logical block size, erase block size, segment size, and so on) or =
particular
workload can significantly change a file system behavior. It=E2=80=99s =
always not so
easy statement that this file system faster than another one.

>> (3) decrease the write amplification factor compared with:
>>    1.3x - 116x (ext4),
>>    14x - 42x (xfs),
>>    6x - 9x (btrfs),
>>    1.5x - 50x (f2fs),
>>    1.2x - 20x (nilfs2);
>> (4) prolong SSD lifetime compared with:
>=20
> Is this measuring how many times blocks are erased? I guess this
> measurement includes the background I/O from ssdfs migration and =
moving?
>=20

So, first of all, I need to explain the testing methodology. Testing =
included:
(1) create file (empty, 64 bytes, 16K, 100K), (2) update file, (3) =
delete file.
Every particular test-case is executed as multiple mount/unmount =
operations
sequence. For example, total number of file creation operations were =
1000 and
10000, but one mount cycle included 10, 100, or 1000 file creation, file =
update,
or file delete operations. Finally, file system must flush all dirty =
metadata and
user data during unmount operation.

The blktrace tool registers LBAs and size for every I/O request. These =
data are
the basis for estimation how many erase blocks have been involved into
operations. SSDFS volumes have been created by using 128KB, 512KB, and
8MB erase block sizes. So, I used these erase block sizes for =
estimation.
Generally speaking, we can estimate the total number of erase blocks =
that
were involved into file system operations for particular use-case by =
means of
calculation of number of bytes of all I/O requests and division on erase =
block size.
If file system uses in-place updates, then it is possible to estimate =
how many times
the same erase block (we know LBA numbers) has been completely =
re-written.
For example, if erase block (starting from LBA #32) received 1310720 =
bytes of
write I/O requests, then erase block of 128KB in size has been =
re-written 10x times.
So, it means that FTL needs to store all these data into 10 X 128KB =
erase blocks
in the background or execute around 9 erase operation to keep the actual =
state
of data into one 128KB erase block. So, this is the estimation of FTL GC =
responsibility.

However, if we would like to estimate the total number of erase =
operation, then
we need to take into account:

E total =3D E(FTL GC) + E(TRIM) + E(FS GC) + E(read disturbance) + =
E(retention)

The estimation of erase operation on the basis of retention issue is =
tricky and
it shows negligibly small number for such short testing. So, we can =
ignore it.
However, retention issue is important factor of decreasing SSD lifetime.
I executed the estimation of this factor and I made comparison for =
various
file systems. But this factor is deeply depends on time, workload, and
payload size. So, it=E2=80=99s really hard to share any stable and =
reasonable numbers
for this factor. Especially, it heavily depends on FTL implementation.

It is possible to make estimation of read disturbance but, again, it =
heavily
depends on NAND flash type, organization, and FTL algorithms. Also, this
estimation shows really small numbers that can be ignored for short =
testing.
I=E2=80=99ve made this estimation and I can see that, currently, SSDFS =
has read-intensive
nature because of offset translation table distribution policy. I am =
testing the fix
and I have hope to remove this issue.

SSDFS has efficient TRIM/erase policy. So, I can see TRIM/erase =
operations
even for such =E2=80=9Cshort" test-cases. As far as I can see, no other =
file system issues
discard operations for the same test-cases. I included TRIM/erase =
operations
into the calculation of total number of erase operations.

Estimation of GC operations on FS side (F2FS, NILFS2) is the most =
speculative one.
I=E2=80=99ve made estimation of number of erase operations that FS GC =
can generate.
However, as far as I can see, even without taking into account the FS GC =
erase
operations, SSDFS looks better compared with F2FS and NILFS2.
I need to add here that SSDFS uses migration scheme and doesn=E2=80=99t =
need
in classical GC. But even for such =E2=80=9Cshort=E2=80=9D test-cases =
migration scheme shows
really efficient TRIM/erase policy.=20

So, write amplification factor was estimated on the basis of write I/O =
requests
comparison. And SSD lifetime prolongation has been estimated and =
compared
by using the model that I explained above. I hope I explained it's clear =
enough.
Feel free to ask additional questions if I missed something.

The measurement includes all operations (foreground and background) that
file system initiates because of using mount/unmount model. However, =
migration
scheme requires additional explanation. Generally speaking, migration =
scheme
doesn=E2=80=99t generate additional I/O requests. Oppositely, migration =
scheme decreases
number of I/O requests. It could be tricky to follow. SSDFS uses =
compression,
delta-encoding, compaction scheme, and migration stimulation. It means =
that
reqular file system=E2=80=99s update operations are the main vehicle of =
migration scheme.
Let imagine that application updates 4KB logical block. It means that =
SSDFS
tries to compress (or delta-encode) this piece of data. Let compression =
gives us
1KB compressed piece of data (4KB uncompressed size). It means that we =
can
place 1KB into 4KB memory page and we have 3KB free space. So, migration
logic checks that exhausted (completely full) old erase block that =
received update
operation has another valid block(s). If we have such valid logical =
blocks, then
we can compress this logical blocks and store it into free space of 4K =
memory page.
So, we can finally store 4 compressed logical blocks (1KB in size each), =
for example,
into 4KB memory page. It means that SSDFS issues one I/O request for 4 =
logical
blocks instead of 4 ones. I simplify the explanation, but idea remains =
the same.
I hope I clarified the point. Feel free to ask additional questions if I =
missed something.

Thanks,
Slava.

>>    1.4x - 7.8x (ext4),
>>    15x - 60x (xfs),
>>    6x - 12x (btrfs),
>>    1.5x - 7x (f2fs),
>>    1x - 4.6x (nilfs2).
>=20
> Thanks,
> Stefan

