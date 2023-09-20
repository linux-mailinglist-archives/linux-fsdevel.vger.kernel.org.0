Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895237A8A97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 19:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjITR20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 13:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjITR2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:28:25 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C168C6
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 10:28:19 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34e1757fe8fso25445ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695230898; x=1695835698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkLqg2B+adiov6jsupv3kMfmjBJ7fS80McpmCcLUPX8=;
        b=ULEYS0ovbxUEr54Io+CL/1yDYP5o6wwj90efvSPsjIYGnjEWhT0Rl23PA9/gdH8gCv
         p6VOXYewGq+uKn2O7cbPBZsK1aZctAU5ZrhytnTbX0zye3wG+ElI+A2+0J6+rPGoZkrA
         xOp59usLJGyEwTgDrtUm8A6pkuRQsynLFx0sHACJmCRbk+odSLSEGAE//loYXxDQ2GEk
         Ku2gTfTYLrVfvF3TSc5cOjqlt1hxI4O2H8Top2IAJCEp1p9Hd+uU4CLmh7/EN5INaLmi
         +b9eGYHy0onBW9ZOq30a89ctX4Al5Eonoqn0wtYXS3dQTcuzTMKqMPxQLIabOLuqmNzC
         rKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230898; x=1695835698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkLqg2B+adiov6jsupv3kMfmjBJ7fS80McpmCcLUPX8=;
        b=IET3glQBEhu9FD+64L7VNF8SpRwiaVj8IZU2RdC9meXFUZaqemx3CJOH0SPMn5WzqD
         1QuNSXh775UPZLmm3Wkds830LQEd3SM5hpN86NepU2l6t29BRa0MAxTV9KLJc3nu6TC7
         ljkGpcMpYJl/n6uZaVHdKlZZfkzzHq/A3VaS2W6/10mNYiLAA62WJXhoijGIPDMqoWWz
         cxHo5tAGL63wrkRC15C8eEY4U1EmmywJYYP1Uc3EC4RKEnQkuGvb9C79ZS8GPgP4Nt1N
         qaGLhkbvItT7UeO5t4JpiUXfw6S8EBmHkBdYXeQLumgNqDLZPU8H5o1o5rBAFmqLFc6U
         QE6A==
X-Gm-Message-State: AOJu0Yy8ayRlHwgbrHQ6b9xLKWLyA6XvAcKVTno9EboCxWVUFFpRvUY3
        /LUP5V4dANlJ7MZbMlbsP/HhQBLY5GYGyIBXymCsqg==
X-Google-Smtp-Source: AGHT+IH8ast9/jQse5Zw9YqcdIGsX6l6RDDVbdigCMzzsjRmjCk8jCwi/O/TtNcPRIKcV9tagNVo4Q==
X-Received: by 2002:a05:6602:3807:b0:792:9b50:3c3d with SMTP id bb7-20020a056602380700b007929b503c3dmr4444110iob.1.1695230898513;
        Wed, 20 Sep 2023 10:28:18 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k28-20020a02c77c000000b0042b2959e6dcsm4312765jao.87.2023.09.20.10.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:28:17 -0700 (PDT)
Message-ID: <f37c00c5-467a-4339-9e20-ca5a12905cd3@kernel.dk>
Date:   Wed, 20 Sep 2023 11:28:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/splice: don't block splice_direct_to_actor() after
 data was read
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Max Kellermann <max.kellermann@ionos.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230919081259.1094971-1-max.kellermann@ionos.com>
 <20230919-kommilitonen-hufen-d270d1568897@brauner>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230919-kommilitonen-hufen-d270d1568897@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/19/23 8:18 AM, Christian Brauner wrote:
> [+Cc Jens]
> 
> On Tue, Sep 19, 2023 at 10:12:58AM +0200, Max Kellermann wrote:
>> If userspace calls sendfile() with a very large "count" parameter, the
>> kernel can block for a very long time until 2 GiB (0x7ffff000 bytes)
>> have been read from the hard disk and pushed into the socket buffer.
>>
>> Usually, that is not a problem, because the socket write buffer gets
>> filled quickly, and if the socket is non-blocking, the last
>> direct_splice_actor() call will return -EAGAIN, causing
>> splice_direct_to_actor() to break from the loop, and sendfile() will
>> return a partial transfer.
>>
>> However, if the network happens to be faster than the hard disk, and
>> the socket buffer keeps getting drained between two
>> generic_file_read_iter() calls, the sendfile() system call can keep
>> running for a long time, blocking for disk I/O over and over.
>>
>> That is undesirable, because it can block the calling process for too
>> long.  I discovered a problem where nginx would block for so long that
>> it would drop the HTTP connection because the kernel had just
>> transferred 2 GiB in one call, and the HTTP socket was not writable
>> (EPOLLOUT) for more than 60 seconds, resulting in a timeout:
>>
>>   sendfile(4, 12, [5518919528] => [5884939344], 1813448856) = 366019816 <3.033067>
>>   sendfile(4, 12, [5884939344], 1447429040) = -1 EAGAIN (Resource temporarily unavailable) <0.000037>
>>   epoll_wait(9, [{EPOLLOUT, {u32=2181955104, u64=140572166585888}}], 512, 60000) = 1 <0.003355>
>>   gettimeofday({tv_sec=1667508799, tv_usec=201201}, NULL) = 0 <0.000024>
>>   sendfile(4, 12, [5884939344] => [8032418896], 2147480496) = 2147479552 <10.727970>
>>   writev(4, [], 0) = 0 <0.000439>
>>   epoll_wait(9, [], 512, 60000) = 0 <60.060430>
>>   gettimeofday({tv_sec=1667508869, tv_usec=991046}, NULL) = 0 <0.000078>
>>   write(5, "10.40.5.23 - - [03/Nov/2022:21:5"..., 124) = 124 <0.001097>
>>   close(12) = 0 <0.000063>
>>   close(4)  = 0 <0.000091>
>>
>> In newer nginx versions (since 1.21.4), this problem was worked around
>> by defaulting "sendfile_max_chunk" to 2 MiB:
>>
>>  https://github.com/nginx/nginx/commit/5636e7f7b4
>>
>> Instead of asking userspace to provide an artificial upper limit, I'd
>> like the kernel to block for disk I/O at most once, and then pass back
>> control to userspace.
>>
>> There is prior art for this kind of behavior in filemap_read():
>>
>> 	/*
>> 	 * If we've already successfully copied some data, then we
>> 	 * can no longer safely return -EIOCBQUEUED. Hence mark
>> 	 * an async read NOWAIT at that point.
>> 	 */
>> 	if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
>> 		iocb->ki_flags |= IOCB_NOWAIT;
>>
>> This modifies the caller-provided "struct kiocb", which has an effect
>> on repeated filemap_read() calls.  This effect however vanishes
>> because the "struct kiocb" is not persistent; splice_direct_to_actor()
>> doesn't have one, and each generic_file_splice_read() call initializes
>> a new one, losing the "IOCB_NOWAIT" flag that was injected by
>> filemap_read().
>>
>> There was no way to make generic_file_splice_read() aware that
>> IOCB_NOWAIT was desired because some data had already been transferred
>> in a previous call:
>>
>> - checking whether the input file has O_NONBLOCK doesn't work because
>>   this should be fixed even if the input file is not non-blocking
>>
>> - the SPLICE_F_NONBLOCK flag is not appropriate because it affects
>>   only whether pipe operations are non-blocking, not whether
>>   file/socket operations are non-blocking
>>
>> Since there are no other parameters, I suggest adding the
>> SPLICE_F_NOWAIT flag, which is similar to SPLICE_F_NONBLOCK, but
>> affects the "non-pipe" file descriptor passed to sendfile() or
>> splice().  It translates to IOCB_NOWAIT for regular files.  For now, I
>> have documented the flag to be kernel-internal with a high bit, like
>> io_uring does with SPLICE_F_FD_IN_FIXED, but making this part of the
>> system call ABI may be a good idea as well.

I think adding the flag for this case makes sense, and also exposing it
on the UAPI side. My only concern is full coverage of it. We can't
really have a SPLICE_F_NOWAIT flag that only applies to some cases.

That said, asking for a 2G splice, and getting a 2G splice no matter how
slow it may be, is a bit of a "doctor it hurts when I..." scenario.

-- 
Jens Axboe

