Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BF46E1DA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 09:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDNH5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjDNH4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:56:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE357ECD;
        Fri, 14 Apr 2023 00:56:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso3911628pjr.3;
        Fri, 14 Apr 2023 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681459013; x=1684051013;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h8Po7L2XXvw2on2O9WIZJmGP5CTPRpEak29+DCnGfNg=;
        b=Ony+F6GHx4EYgX/W+q0UgO9ijATGHm2Gljo8mPlLnGX3hWMH+uSK3APyQosX5uuonz
         EjIj+dDlXMpypvQDh4tzKXRUM/Psn/igpGUCp264t+DzJpqvsGWwlPine/prPNPLXmeb
         tl5nk7DEN56Aja2CdtLsZBpeSnYHBHJQ1UqBY8AZ71uoNRaLEHZ7E5J9VhsigJrdm0Pb
         VHDXpluEaGE9QqOQuzmD77OM2ikwfyFbYMJQp7hBFjQbstm9Qy3OcYpgpMm/vgaTxCsD
         2PGTqZlgc6e5g9qBPX0QCaqMawc/fCiR295zSak7p+zCwV+Un7wdvfvNBQSTm20X6rAW
         gpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681459013; x=1684051013;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8Po7L2XXvw2on2O9WIZJmGP5CTPRpEak29+DCnGfNg=;
        b=gryS6M7xtIL0Lr3iA2K6COLGWETptYKVyl50by4VvwwDcRa3YT1/LUiwftjPPsOVLn
         npFhUqoEXwxA1OVpCKBsltSR9t8MdAZvb2JFPaffs98HOJPb68kvkGXdsGy0OWlUmyoW
         siAZDqG7vgtz8CKihaHjPftac3engupUYbGIkoktT08zHfbSQRIN+gfuQ+5JY0DIRg/G
         mWhCOE2G75bBQfzFUVHS37eBkgnCFno7mZb9pKeyYH6oiDEULzqLx4v/LtnWu4tBk9jS
         03ZHCj/bFc8crI5zaZgMU9P/WJMfhrXmUJV0ErtR2WtqEgOkefv/6tyUW6TU8nZrJwQN
         sjdg==
X-Gm-Message-State: AAQBX9cZn4HXJWJO5+ebAa/CKYqXW/RaoILB+GElQSnycl3fBqI5lTAi
        HO90+INK9a4RC5eFWvluqkQ=
X-Google-Smtp-Source: AKy350YmjBaj2fXQxZIdfjgZ2NXdGPYqX6S1fjYIMiEQyVk/oEdC958n1/GJxTmTWUmvtAK9cXOhpg==
X-Received: by 2002:a17:902:da8f:b0:1a6:9794:a4 with SMTP id j15-20020a170902da8f00b001a6979400a4mr2234893plx.63.1681459013419;
        Fri, 14 Apr 2023 00:56:53 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b001a63d8902b6sm2578912pld.93.2023.04.14.00.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 00:56:53 -0700 (PDT)
Date:   Fri, 14 Apr 2023 13:26:38 +0530
Message-Id: <877cuezykp.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 10/10] iomap: Add trace points for DIO path
In-Reply-To: <ZDjs+/T/mf1nHUHI@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>> +	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before, ret);
>>  	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, private,
>>  			     done_before);
>>  	if (IS_ERR_OR_NULL(dio)) {
>> @@ -689,6 +691,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>  	}
>>  	ret = iomap_dio_complete(dio);
>>  out:
>> +	trace_iomap_dio_rw_end(iocb, iter, dio_flags, done_before, ret);
>
> The trace_iomap_dio_rw_end tracepoint heere seems a bit weird,
> and we'll miss it for file systems using  __iomap_dio_rw directly.

Sorry, yes you are right.

>
> I'd instead add a trace_iomap_dio_rw_queued for the case where
> __iomap_dio_rw returns ERR_PTR(-EIOCBQUEUED), as otherwise we're
> nicely covered by the complete trace points.
>

How about this below change? Does this look good to you?
It should cover all error types and both entry and exit.

And should I fold this entire change in 1 patch or should I split the
refactoring of common out routine into a seperate one?


diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5871956ee880..e412fdc4ee86 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -130,6 +130,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
        if (ret > 0)
                ret += dio->done_before;

+       trace_iomap_dio_complete(iocb, dio->error, ret);
        kfree(dio);

        return ret;
@@ -493,12 +494,15 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
        struct blk_plug plug;
        struct iomap_dio *dio;

+       trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before, ret);
        if (!iomi.len)
-               return NULL;
+               goto out;

        dio = kmalloc(sizeof(*dio), GFP_KERNEL);
-       if (!dio)
-               return ERR_PTR(-ENOMEM);
+       if (!dio) {
+               ret = -ENOMEM;
+               goto out;
+       }

        dio->iocb = iocb;
        atomic_set(&dio->ref, 1);
@@ -650,8 +654,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
         */
        dio->wait_for_completion = wait_for_completion;
        if (!atomic_dec_and_test(&dio->ref)) {
-               if (!wait_for_completion)
-                       return ERR_PTR(-EIOCBQUEUED);
+               if (!wait_for_completion) {
+                       ret = -EIOCBQUEUED;
+                       goto out;
+               }
+

                for (;;) {
                        set_current_state(TASK_UNINTERRUPTIBLE);
@@ -663,10 +670,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
                __set_current_state(TASK_RUNNING);
        }

+       trace_iomap_dio_rw_end(iocb, iter, dio_flags, done_before, ret);
        return dio;

 out_free_dio:
        kfree(dio);
+out:
+       trace_iomap_dio_rw_end(iocb, iter, dio_flags, done_before, ret);
        if (ret)
                return ERR_PTR(ret);
        return NULL;


>> +		  __print_flags(__entry->dio_flags, "|", TRACE_IOMAP_DIO_STRINGS),
>
> Please avoid the overly lone line here.

Somehow my checkpatch never gave a warning about it.
I will check why was that. But yes, I have anyways made the name to
IOMAP_DIO_STRINGS similar to other namings used in fs/iomap/trace.h

-ritesh
