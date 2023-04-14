Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6319A6E25EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjDNOjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjDNOjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:39:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F0CC145;
        Fri, 14 Apr 2023 07:39:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a677dffb37so5220605ad.2;
        Fri, 14 Apr 2023 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681483142; x=1684075142;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B5UHHY4qkZgde2P72x31MsOhkreduRK3Nn0KXMSn7h8=;
        b=M72KdtTk7G8UWBqwpXiBXxsb8CvQPXOjaG4NAqqKEjuhX1831H/nRJUmpcoCrDOg8g
         DeFSpT5y+dJeOe6kmPY1c5CI/f6qdEGUjoR1HfdEXcAFa/NGQHfyyTZOrHF0uXbzxAxA
         3PlJHVzgUpT98prjEhxZELf90zLiZQvdqNbkmUwbb+hgZgHPBaJgmtsGQoHVigjzZISf
         OZLn+yYPD9jWt/Bj0DmBxElYNA8MvOcUj7V680GKEYod7JTI2Z/nKtVy+EPYPyCjJzSx
         BbixNnHKqfpgRPC+iOdwcACg1emNRUhU3lHEK0Ow3JU12cBAfBT4SFKyUdiOmLuenS7b
         u6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681483142; x=1684075142;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5UHHY4qkZgde2P72x31MsOhkreduRK3Nn0KXMSn7h8=;
        b=UGy0FFbQUXmQbrJfMiBJFN0p7xQZxs23XWp2KiAnogQ0A5hv38oEnXqkncA4r4ap8Q
         wWNQGklDPON2yIUPskQw4vFe1YRoSpGjWqB/YSxpjdgDMYWaFR5PyI0RfAwft4MIkxjB
         seKjB2B0qSO6SA0k/00l0Xkfi/iBWKt4uOvuuh8xhLMm9dnlaysuVFiZxq5kQJi9agnB
         xw4vuek1NJWJ9CmjmQO/kenk4klU1YYbJUF93yPj/nwk0KXocfDj1VIm6Cq3cVNkOKxu
         boFZ4rRJV7Es0m/JoqJZnO447SCAdRqJMflsHUb3s1OwuosDlY859DrGaqfdOus8A0Df
         4wzw==
X-Gm-Message-State: AAQBX9edkL8A9CznWAU1xXKxV84HhwHaJOBbLGaZtsXMbtGQhDJInPBv
        VR3kRbeiX7GIyEfde/HtuthtyI+EF8E=
X-Google-Smtp-Source: AKy350aySrzQ+vfs4h17HQ5jAqZyn2M0XdQLBEXmmDao4WogdlJXwMGnSoOEyVh2xd5dXGrCgZxDjg==
X-Received: by 2002:a05:6a00:21d4:b0:639:ae5e:ac57 with SMTP id t20-20020a056a0021d400b00639ae5eac57mr8290511pfj.1.1681483142127;
        Fri, 14 Apr 2023 07:39:02 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79257000000b0062df30c7e7esm3119617pfp.136.2023.04.14.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:39:01 -0700 (PDT)
Date:   Fri, 14 Apr 2023 20:08:55 +0530
Message-Id: <87y1muy1ds.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv3 10/10] iomap: Add trace points for DIO path
In-Reply-To: <ZDlP6EiwKDE35ZG7@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Fri, Apr 14, 2023 at 01:26:38PM +0530, Ritesh Harjani wrote:
>> How about this below change? Does this look good to you?
>> It should cover all error types and both entry and exit.
>
> I don't think it is very useful.  The complete tracepoint is the
> end of the I/O.  Having a separate end one doesn't make sense.
> That's why I suggested a queued one for the asynchronous case.

Ok, does this look good then?

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 36ab1152dbea..859efb5de1bf 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -130,6 +130,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
        if (ret > 0)
                ret += dio->done_before;

+       trace_iomap_dio_complete(iocb, dio->error, ret);
        kfree(dio);

        return ret;
@@ -650,8 +651,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
         */
        dio->wait_for_completion = wait_for_completion;
        if (!atomic_dec_and_test(&dio->ref)) {
-               if (!wait_for_completion)
-                       return ERR_PTR(-EIOCBQUEUED);
+               if (!wait_for_completion) {
+                       ret = -EIOCBQUEUED;
+                       trace_iomap_dio_rw_queued(iocb, iter, dio_flags,
+                                                 done_before, ret);
+                       return ERR_PTR(ret);
+               }

                for (;;) {
                        set_current_state(TASK_UNINTERRUPTIBLE);

-ritesh
