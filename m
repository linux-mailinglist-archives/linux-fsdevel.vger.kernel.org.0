Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EEC6E1B9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 07:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDNFV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 01:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjDNFVV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:21:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0441FDD;
        Thu, 13 Apr 2023 22:21:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a6715ee82fso6843315ad.1;
        Thu, 13 Apr 2023 22:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681449677; x=1684041677;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iS7kgCuFTqiVN/Bz+MqnxuPztiETlMQu93+xqhvh7sg=;
        b=sh8uWItGgH61q+UiXM4Cj9sUSI2ZtMEO6fDL64sncJOFUSoiVa6VrsiD1tiZettjcN
         JVHXkOEywyZx4bTcw+SYHjhe+fSOBjaHqEzKr/th8wUJZ+yEuRe+hyBVC3wvAX12t8K8
         fEvO4pUb2XuANjnron07MTqjnCX+vaKN/o0TUM3U3YgVHAXVo7X+l+4PXbsOw9N2xuz4
         Upoe06mnvNWbTInQ5VfUrOJ9VwjQkCaFt/5G6xP7WJqw9+yTQK3keBcemc5H6gbeDjBE
         I3pZ6e19ezSAMyrsAopjqP+Gi5eCoYVzvovsYiowb18w7V7npWEzx2qhXN+B6MMVWmw6
         09gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681449677; x=1684041677;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iS7kgCuFTqiVN/Bz+MqnxuPztiETlMQu93+xqhvh7sg=;
        b=gpAbS+66NPnWCrY74hot9ailcTrLT98LK2+obwrnNsk7Uhj0XQAvIiPGDkWNnbLy03
         ERB9djRbwWrILS3EiBCv29r2UwZnL4KTTBCGBvXfrd4JIuF+fEbKKz2ex6zMA8F5kigF
         Nr8viAAqJ9Lfd8jsL+4rGQo9aiuZ9LLOF4gCXVnxG+j/WH7G7aNj/5Xavq/bWttnBMt6
         JV/+KoeVmJWQeDuGinjDaVBlDfjYQAdENgahp2QPITRxyVUtRs/DNDlrXYEt603MZ0Dr
         wINPLrqc4llmE/izs9iUNpghQ5WcgCPippqHy26m/Nklj93L6nSNNvB/BKW4y87iu7DO
         PShg==
X-Gm-Message-State: AAQBX9f4ktwW0xBoMtRxrufgWnfMbafRy0LaRb2Iun7NpHxWv+tojT8+
        s8vjnjXiDBO9yQaTUTOMuYw=
X-Google-Smtp-Source: AKy350ZIzwySzn4xyuCwBttISPYDI/W86bO2UYQf+scOW12ZcWrhun0W7FcwR0qn0oM4BKPGERsUPw==
X-Received: by 2002:a05:6a00:1411:b0:63b:599b:a2ec with SMTP id l17-20020a056a00141100b0063b599ba2ecmr4399347pfu.27.1681449676708;
        Thu, 13 Apr 2023 22:21:16 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id s19-20020aa78293000000b0063b6b217883sm231952pfm.38.2023.04.13.22.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 22:21:16 -0700 (PDT)
Date:   Fri, 14 Apr 2023 10:51:05 +0530
Message-Id: <87a5zbyr7i.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 10/10] iomap: Add trace points for DIO path
In-Reply-To: <20230414021601.GE360877@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, Apr 14, 2023 at 01:48:49AM +0530, Ritesh Harjani wrote:
>> "Darrick J. Wong" <djwong@kernel.org> writes:
>>
>> > On Thu, Apr 13, 2023 at 02:10:32PM +0530, Ritesh Harjani (IBM) wrote:
>> >> This patch adds trace point events for iomap DIO path.
>> >>
>> >> <e.g. iomap dio trace>
>> >>      xfs_io-8815  [000]   526.790418: iomap_dio_rw_begin:   dev 7:7 ino 0xc isize 0x0 pos 0x0 count 4096 flags DIRECT dio_flags DIO_FORCE_WAIT done_before 0 aio 0 ret 0
>> >>      xfs_io-8815  [000]   526.790978: iomap_dio_complete:   dev 7:7 ino 0xc isize 0x1000 pos 0x1000 flags DIRECT aio 0 error 0 ret 4096
>> >>      xfs_io-8815  [000]   526.790988: iomap_dio_rw_end:     dev 7:7 ino 0xc isize 0x1000 pos 0x1000 count 0 flags DIRECT dio_flags DIO_FORCE_WAIT done_before 0 aio 0 ret 4096
>> >>         fsx-8827  [005]   526.939345: iomap_dio_rw_begin:   dev 7:7 ino 0xc isize 0x922f8 pos 0x4f000 count 61440 flags NOWAIT|DIRECT|ALLOC_CACHE dio_flags  done_before 0 aio 1 ret 0
>> >>         fsx-8827  [005]   526.939459: iomap_dio_rw_end:     dev 7:7 ino 0xc isize 0x922f8 pos 0x4f000 count 0 flags NOWAIT|DIRECT|ALLOC_CACHE dio_flags  done_before 0 aio 1 ret -529
>> >> ksoftirqd/5-41    [005]   526.939564: iomap_dio_complete:   dev 7:7 ino 0xc isize 0x922f8 pos 0x5e000 flags NOWAIT|DIRECT|ALLOC_CACHE aio 1 error 0 ret 61440
>> >>
>> >> Tested-by: Disha Goel <disgoel@linux.ibm.com>
>> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> >> ---
>> >>  fs/iomap/direct-io.c |  3 ++
>> >>  fs/iomap/trace.c     |  1 +
>> >>  fs/iomap/trace.h     | 90 ++++++++++++++++++++++++++++++++++++++++++++
>> >>  3 files changed, 94 insertions(+)
>> >>
>> >> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> >> index 5871956ee880..bb7a6dfbc8b3 100644
>> >> --- a/fs/iomap/direct-io.c
>> >> +++ b/fs/iomap/direct-io.c
>> >> @@ -130,6 +130,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>> >>  	if (ret > 0)
>> >>  		ret += dio->done_before;
>> >>
>> >> +	trace_iomap_dio_complete(iocb, dio->error, ret);
>> >>  	kfree(dio);
>> >>
>> >>  	return ret;
>> >> @@ -681,6 +682,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>> >>  	struct iomap_dio *dio;
>> >>  	ssize_t ret = 0;
>> >>
>> >> +	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before, ret);
>> >>  	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, private,
>> >>  			     done_before);
>> >>  	if (IS_ERR_OR_NULL(dio)) {
>> >> @@ -689,6 +691,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>> >>  	}
>> >>  	ret = iomap_dio_complete(dio);
>> >>  out:
>> >> +	trace_iomap_dio_rw_end(iocb, iter, dio_flags, done_before, ret);
>> >>  	return ret;
>> >>  }
>> >>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
>> >> diff --git a/fs/iomap/trace.c b/fs/iomap/trace.c
>> >> index da217246b1a9..728d5443daf5 100644
>> >> --- a/fs/iomap/trace.c
>> >> +++ b/fs/iomap/trace.c
>> >> @@ -3,6 +3,7 @@
>> >>   * Copyright (c) 2019 Christoph Hellwig
>> >>   */
>> >>  #include <linux/iomap.h>
>> >> +#include <linux/uio.h>
>> >>
>> >>  /*
>> >>   * We include this last to have the helpers above available for the trace
>> >> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
>> >> index f6ea9540d082..dcb4dd4db5fb 100644
>> >> --- a/fs/iomap/trace.h
>> >> +++ b/fs/iomap/trace.h
>> >> @@ -183,6 +183,96 @@ TRACE_EVENT(iomap_iter,
>> >>  		   (void *)__entry->caller)
>> >>  );
>> >>
>> >> +#define TRACE_IOMAP_DIO_STRINGS \
>> >> +	{IOMAP_DIO_FORCE_WAIT, "DIO_FORCE_WAIT" }, \
>> >> +	{IOMAP_DIO_OVERWRITE_ONLY, "DIO_OVERWRITE_ONLY" }, \
>> >> +	{IOMAP_DIO_PARTIAL, "DIO_PARTIAL" }
>> >
>> > Can you make the strings line up too, please?
>> >
>>
>> Ok near other _STRINGS macro. Sure, will do that.
>>
>>
>> >> +
>> >> +DECLARE_EVENT_CLASS(iomap_dio_class,
>> >> +	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter,
>> >> +		 unsigned int dio_flags, u64 done_before, int ret),
>> >
>> > We're passing in ssize_t values for @ret, shouldn't the types match?
>> >
>>
>> Yes, I missed to correct that. Will make it loff_t.
>> This should be fixed in ext2 trace point macro too.
>>
>> (ssize_t can vary based on 32 bit v/s 64 bit, so while printing it as
>> %llx it gives warning on 32bit. Hence will use loff_t for ret)
>
> How about %zd?

Aah yes. My bad, I wanted to look into print-format specifiers, but
missed it.

Documentation/core-api/printk-formats.rst
		size_t			%zu or %zx
		ssize_t			%zd or %zx

Will send the next revision soon with the comments addressed then.

Thanks!
-ritesh
