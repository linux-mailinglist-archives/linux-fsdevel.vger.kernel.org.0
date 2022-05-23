Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF6B5307C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 04:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353044AbiEWCnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 22:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240903AbiEWCn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 22:43:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED42E0A6
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 19:43:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so12408894pju.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 19:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=b0lqaRBR1HfiTx3C4hhhDT1N/TC4V9uDrbQZhJOdJD0=;
        b=G3jPuKKl8EuLOfIrGdHdbWJsFCLFBJUB395U/f+hYDohdWReb4fOh0PLzrIoM3vi6P
         5tUWUXJ29PANC/lpGUwUaqkHZwUszYq7pOk5HYi8Y0Gog9LnDq1qGPgArNiE/5Yc4FIM
         TtJ4+Iz/7ol+fNaeUTD97Le4dK2kgiIj5RFqJIaqqm+BR0+j1rJh9zVrbxcXg8QI2EnH
         ypiFHCp0Wm9VKoNw0yMqMKqPiWchKmSV1NC38gA/XNhV50ofY3PwZG2TlJWMTV0QoxI7
         wgydE6xueEpQRUwoZ3Lwuz/fEkHAoMRTu4ij+PA1nsWLfsZgEdsbtFmrx59uqmic9edm
         xbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=b0lqaRBR1HfiTx3C4hhhDT1N/TC4V9uDrbQZhJOdJD0=;
        b=3H3cbsshUMHBHh3jo54A++ascQ01lsH5cHPVR5r7zX/Yc0LiWgl+pU3R3gFFXJHdeR
         GY1h3vu9uj/1CehmNcdQ0ev8kNfx54om2LIrPCSMnbg0fY/ztVW0tG8Qd3RwC88VaPYf
         rRPmVOMEdbKjsr82Qs6wzS43gvwsSk5gtcpZ/3+vg6CmevKKM9kpzhn64i59hooYQUxE
         fg2qAkPj/Ab46XCkWGYdxn5EPJ/nWbJf9N0GqM9BqUmnplG1Ln8QirLOdm/c6T2du2JJ
         R43+2Q1k40qvCke64X3YqWM5AyJtqxC2cRODBJwcoR8d8n2yPwksh1H+RkGm8VXLkiMQ
         saoA==
X-Gm-Message-State: AOAM533ZxWg5bR3Mdlzhv9NiTuNWzMV9xvfKXGwPgPAaSnS6Wq/O6R5k
        7H+20VHT3UBw/wMJsDbnK0hrTA==
X-Google-Smtp-Source: ABdhPJwtipoN/M2qd2dxI92rPxg2pbTuj/DaQapq6lqS7PSHGMA/exqQJRmODifArseS6glVWfNxTw==
X-Received: by 2002:a17:902:7c11:b0:162:1122:8a7f with SMTP id x17-20020a1709027c1100b0016211228a7fmr7426759pll.37.1653273808014;
        Sun, 22 May 2022 19:43:28 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b0015e8d4eb1d7sm3774527plr.33.2022.05.22.19.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 19:43:27 -0700 (PDT)
Message-ID: <6ea33ba8-c5a3-a1e7-92d2-da8744662ed9@kernel.dk>
Date:   Sun, 22 May 2022 20:43:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
 <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
 <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
 <290daf40-a5f6-01f8-0764-2f4eb96b9d40@kernel.dk>
 <22de2da8-7db0-68c5-2c85-d752a67f9604@kernel.dk>
 <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
In-Reply-To: <9c3a6ad4-cdb5-8e0d-9b01-c2825ea891ad@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/22 7:50 PM, Jens Axboe wrote:
> On 5/22/22 7:28 PM, Jens Axboe wrote:
>> On 5/22/22 7:22 PM, Jens Axboe wrote:
>>> On 5/22/22 6:42 PM, Al Viro wrote:
>>>> On Sun, May 22, 2022 at 02:03:35PM -0600, Jens Axboe wrote:
>>>>
>>>>> Right, I'm saying it's not _immediately_ clear which cases are what when
>>>>> reading the code.
>>>>>
>>>>>> up a while ago.  And no, turning that into indirect calls ended up with
>>>>>> arseloads of overhead, more's the pity...
>>>>>
>>>>> It's a shame, since indirect calls make for nicer code, but it's always
>>>>> been slower and these days even more so.
>>>>>
>>>>>> Anyway, at the moment I have something that builds; hadn't tried to
>>>>>> boot it yet.
>>>>>
>>>>> Nice!
>>>>
>>>> Boots and survives LTP and xfstests...  Current variant is in
>>>> vfs.git#work.iov_iter (head should be at 27fa77a9829c).  I have *not*
>>>> looked into the code generation in primitives; the likely/unlikely on
>>>> those cascades of ifs need rethinking.
>>>
>>> I noticed too. Haven't fiddled much in iov_iter.c, but for uio.h I had
>>> the below. iov_iter.c is a worse "offender" though, with 53 unlikely and
>>> 22 likely annotations...
>>
>> Here it is...
> 
> Few more, most notably making sure that dio dirties reads even if they
> are not of the iovec type.
> 
> Last two just add a helper for import_ubuf() and then adopts it for
> io_uring send/recv which is also a hot path. The single range read/write
> can be converted too, but that needs a bit more work...

Branch here:

https://git.kernel.dk/cgit/linux-block/log/?h=iov-iter

First 5 are generic ones, and some of them should just be folded with
your changes.

Last 2 are just converting io_uring to use it where appropriate.

We can also use it for vectored readv/writev and recvmsg/sendmsg with
one segment. The latter is mostly single segment in the real world
anyway, former probably too. Though not sure it's worth it when we're
copying a single iovec first anyway? Something to test...

-- 
Jens Axboe

