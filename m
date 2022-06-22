Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A524555514E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357860AbiFVQ1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 12:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350478AbiFVQ1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:27:02 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF4F3EBAA;
        Wed, 22 Jun 2022 09:27:00 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id u13so6530539uaq.10;
        Wed, 22 Jun 2022 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvsWPD4KD1CDVmxEE+WO/I2yWCg0hVyUilN1kuuk5ek=;
        b=cEqkpKddR+pIvfQk1/es2U50CU8jT1gICpCj5aVYJErIEvofgwProR9SGbDL8VVDos
         IZS3emeuXDnY5LWg6CAdENbvM5iaDWsvzX3ETgj2VWgOOG/Yz+FyyL2B4a3zYoymD4fn
         PsP2PGMcQeNyL8EnTKKJZrbuwdeEFnUw+zqjXaJHdy3dcpR+ktBJ+PYTGR+0CFq4oKFo
         tgX0gSKyKDC3m8AR342Y2zoCVlZS6KXeWpogbDn0yFOExTd5EzSclVrsCk0CO2oRlXYE
         ktLo8OoXqklYCheWENy27qOdlTdE5oLP08px+TnneMbYhVmYX9aB4HOezmNcrR0GIdNq
         /IDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvsWPD4KD1CDVmxEE+WO/I2yWCg0hVyUilN1kuuk5ek=;
        b=PSufdb0vkewBecvdELbBN8J8lZmUGLWe0Z6A92IkCxMJtGcpMuoy3pLEjwqRimHg4B
         DjKiGiKGUBVl81MNmIpNcZbemTXgvKWUdjmTI2+YWk85eUjxqKPjE01NDIZyhxN/hfmr
         P+NC3Yd4mHFHgBOkAMY0fE5Zf6gAstYccj+r0FD/Ir0L1EB8SjFIxyR8BfvvmvJqpNEM
         3iCt979yPGF1g+RK5qZEq3sV5PyYPj6ZMc84i0h31FuSEeWKe7cOB6qqauHnCO0T9uOK
         xMowfs9Dpz02OnVnt+ll9AyabWqkKarcKZ6BU7Ap0MERPAO+mU40Ho+guqC2kKlrkT56
         EKJg==
X-Gm-Message-State: AJIora9aRVeHnvrePqowpT6HiRuaKDfr7km5fwpuCWKrKZKQw56SsUHX
        BAC+R9zzullkjkumZUaokIa/PiiaS3StKEmOuyo=
X-Google-Smtp-Source: AGRyM1uZRtD7TMWxgRkt4CCyw4xuiVgQexnT2uyv4kZSseaYXqMPrPB1OF49BJUVNuLC7fRLicwV+QGDiByAiij/Z6w=
X-Received: by 2002:ab0:4973:0:b0:37f:27c2:59fb with SMTP id
 a48-20020ab04973000000b0037f27c259fbmr2528858uad.80.1655915219915; Wed, 22
 Jun 2022 09:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190409082605.GA8107@quack2.suse.cz> <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3> <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan> <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan> <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
 <YrKLG6YhMS+qLl8B@casper.infradead.org> <CAOQ4uxgYbVOSDwufPFvbNwsxnzzseNH9guwxZvP43vMmOFqq+Q@mail.gmail.com>
 <20220622093403.hvsk2zmlw7o37phe@quack3.lan>
In-Reply-To: <20220622093403.hvsk2zmlw7o37phe@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 Jun 2022 19:26:48 +0300
Message-ID: <CAOQ4uxiGNHp55AU-dP1W13Qc=WAi3FTephzus+QtWgJuR24Cjw@mail.gmail.com>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw workload
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I am going to go find a machine with slow disk to test the random rw
> > workload again on both xfs and ext4 pre and post invalidate_lock and
> > to try out the pre-warm page cache solution.
> >
> > The results could be:
> > a) ext4 random rw performance has been degraded by invalidate_lock
> > b) pre-warm page cache before taking IOLOCK is going to improve
> >     xfs random rw performance
> > c) A little bit of both

The correct answer is b. :)

>
> Well, numbers always beat the theory so I'm all for measuring it but let me
> say our kernel performance testing within SUSE didn't show significant hit
> being introduced by invalidate_lock for any major filesystem.
>

Here are the numbers produced on v5.10.109, on v5.19-rc3
and on v5.19-rc3+ which includes the pre-warn test patch [1].

The numbers are produced by a filebench workload [2] that runs
8 random reader threads and 8 random writer threads for 60 seconds
on a cold cache preallocated 5GB file.

Note that the machine I tested with has much faster storage than
the one that was used 3 years ago, but the performance impact
of IOLOCK is still very clear, even larger in this test.

If there are no other objections to the pre-warm concept,
I will go on to write and test a proper patch.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commit/70e94f3471739c442b1110ee46e8b59e5d5f5042
[2] https://github.com/amir73il/filebench/blob/overlayfs-devel/workloads/randomrw.f

--- EXT4 5.10 ---
 filebench randomrw (8 read threads, 8 write threads)
 kernel 5.10.109, ext4

Test #1:
rand-write1          3002127ops    50020ops/s 390.8mb/s    0.156ms/op
[0.002ms - 213.755ms]
rand-read1           31749234ops   528988ops/s 4132.7mb/s
0.010ms/op [0.001ms - 68.884ms]

Test #2:
rand-write1          3083679ops    51381ops/s 401.4mb/s    0.152ms/op
[0.002ms - 181.368ms]
rand-read1           32182118ops   536228ops/s 4189.3mb/s
0.010ms/op [0.001ms - 61.158ms]

--- EXT4 5.19 ---
 filebench randomrw (8 read threads, 8 write threads)
 kernel 5.19-rc3, ext4

Test #1:
rand-write1          2829917ops    47159ops/s 368.4mb/s    0.160ms/op
[0.002ms - 4709.167ms]
rand-read1           36997540ops   616542ops/s 4816.7mb/s
0.009ms/op [0.001ms - 4704.105ms]

Test #2:
rand-write1          2764486ops    46067ops/s 359.9mb/s    0.170ms/op
[0.002ms - 5042.597ms]
rand-read1           38893279ops   648118ops/s 5063.4mb/s
0.008ms/op [0.001ms - 5004.069ms]

--- XFS 5.10 ---
 filebench randomrw (8 read threads, 8 write threads)
 kernel 5.10.109, xfs

Test #1:
rand-write1          1049278ops    17485ops/s 136.6mb/s    0.456ms/op
[0.002ms - 224.062ms]
rand-read1           33325ops      555ops/s   4.3mb/s   14.392ms/op
[0.007ms - 224.833ms]

Test #2:
rand-write1          1127497ops    18788ops/s 146.8mb/s    0.424ms/op
[0.003ms - 445.810ms]
rand-read1           35341ops      589ops/s   4.6mb/s   13.566ms/op
[0.005ms - 445.529ms]

--- XFS 5.19 ---
 filebench randomrw (8 read threads, 8 write threads)
 kernel 5.19-rc3, xfs

Test #1:
rand-write1          3295934ops    54920ops/s 429.1mb/s    0.144ms/op
[0.003ms - 109.703ms]
rand-read1           86768ops     1446ops/s  11.3mb/s    5.520ms/op
[0.003ms - 372.000ms]

Test #2:
rand-write1          3246935ops    54106ops/s 422.7mb/s    0.146ms/op
[0.002ms - 103.505ms]
rand-read1           167018ops     2783ops/s  21.7mb/s    2.867ms/op
[0.003ms - 101.105ms]

--- XFS+ 5.19 ---
 filebench randomrw (8 read threads, 8 write threads)
 kernel 5.19-rc3+ (xfs page cache warmup patch)

Test #1:
rand-write1          3054567ops    50899ops/s 397.6mb/s    0.154ms/op
[0.002ms - 201.531ms]
rand-read1           38107333ops   634990ops/s 4960.9mb/s
0.008ms/op [0.001ms - 60.027ms]

Test #2:
rand-write1          2704416ops    45053ops/s 352.0mb/s    0.174ms/op
[0.002ms - 287.079ms]
rand-read1           38589737ops   642874ops/s 5022.4mb/s
0.008ms/op [0.001ms - 60.741ms]
