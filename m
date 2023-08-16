Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4500677E976
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 21:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbjHPTNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 15:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345784AbjHPTNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:13:35 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1B32701
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 12:13:34 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51f64817809so856417a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692213214; x=1692818014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWbLBMysk3HpKHREsiWtsftaSHXnBE16cs5lplg8RvI=;
        b=GWCraJzOdPiTPkcfaOLSUkwlp7gZdKWaAKhCFvtveXaJEfp83ODqQwVHKOjHGmPuxl
         iZtMScNL/RqPsCNVlCdaDlYeQvAnvOmRXXhdNPPwDX1Xlu6gQvlbgKMAtnI1s/hbm5Gc
         GK9t/FFEGCGOeqo0eGlBjmUNnf2M4kEEmFLJLqO/1M84pU62ZLjJK6N3J/lHe5w+v7U3
         FIELF8WSDNmwD+BE4Eagr6h2svnuTa6C0XsRJDB9IyRuMrezL9d13bdmoUVleLrU9g3M
         aK2sVX0Rl2xpPsEwYC/anv6m7ZiK/YRMA4HODEFXy2unTVpD6jkfP+DaFw/vioCH1AGZ
         yfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692213214; x=1692818014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWbLBMysk3HpKHREsiWtsftaSHXnBE16cs5lplg8RvI=;
        b=PtmgfFBwOyAgcnw0n5cVmn3/+wCfA2kxG5+jkSpirjTkC5vr7/pOcYHPXvdS5br4Jr
         Yo5TT0EBi2ZfIT85Hppoyk65yfoIvMZJDLgpcetw0GQ6AQE3+JVh6ej51/5qNvx25cdq
         wFtnfdGhluYF067BuWbFLkAcNzlo6gURyh+2mUeMNeOlxP1HWf6GF3lxyU/XzYLOQviO
         R/b8dotGEtvrgMXb7Dk/KD1lSR3YRhiilzFoeX2BOEKwxLkdtZYWUDqXdUc+xO2ZJhh+
         LLqmnckc0J5X43sJsZ7VSQizg5AdWKU2GDYTWpNX5FNC4VW55XU/JEaD013KW3CAolSj
         oBFA==
X-Gm-Message-State: AOJu0YyEEXnFU2Pgx5X86S7D25Dc6KEsl56/OUD8Hf2yPXMU/qrPhe8/
        jfK352R3ZxdHW7PIBDuROIbVXQ==
X-Google-Smtp-Source: AGHT+IGW8ZSRNfY9C/MLK5yieXPxm/qdOoPKJIWq1dy7BSVG6Rh4YRktcK4J3M7qYT3h/eLx53lilA==
X-Received: by 2002:a17:90a:656:b0:26b:5fad:e71c with SMTP id q22-20020a17090a065600b0026b5fade71cmr2334942pje.2.1692213213899;
        Wed, 16 Aug 2023 12:13:33 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id je22-20020a170903265600b001bba7aab822sm13588316plb.5.2023.08.16.12.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 12:13:32 -0700 (PDT)
Message-ID: <e6948836-1d9d-4219-9a21-a2ab442a9a34@kernel.dk>
Date:   Wed, 16 Aug 2023 13:13:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: create kiocb_{start,end}_write() helpers
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20230816085439.894112-1-amir73il@gmail.com>
 <7725feff-8d9d-4b54-9910-951b79f67596@kernel.dk>
 <CAOQ4uxggGRdhyRL15b_nVuf9PHejfXmF+auxY7HPkhJVYmsnCg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOQ4uxggGRdhyRL15b_nVuf9PHejfXmF+auxY7HPkhJVYmsnCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/23 12:58 PM, Amir Goldstein wrote:
>>> diff --git a/fs/aio.c b/fs/aio.c
>>> index 77e33619de40..16fb3ac2093b 100644
>>> --- a/fs/aio.c
>>> +++ b/fs/aio.c
>>> @@ -1444,17 +1444,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res)
>>>       if (!list_empty_careful(&iocb->ki_list))
>>>               aio_remove_iocb(iocb);
>>>
>>> -     if (kiocb->ki_flags & IOCB_WRITE) {
>>> -             struct inode *inode = file_inode(kiocb->ki_filp);
>>> -
>>> -             /*
>>> -              * Tell lockdep we inherited freeze protection from submission
>>> -              * thread.
>>> -              */
>>> -             if (S_ISREG(inode->i_mode))
>>> -                     __sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
>>> -             file_end_write(kiocb->ki_filp);
>>> -     }
>>> +     if (kiocb->ki_flags & IOCB_WRITE)
>>> +             kiocb_end_write(kiocb);
>>
>> Can't we just call kiocb_end_write() here, it checks WRITE_STARTED
>> anyway? Not a big deal, and honestly I'd rather just get rid of
>> WRITE_STARTED if we're not using it like that. It doesn't serve much of
>> a purpose, if we're gating this one IOCB_WRITE anyway (which I do like
>> better than WRITE_STARTED). And it avoids writing to the kiocb at the
>> end too, which is a nice win.
>>
> 
> What I don't like about it is that kiocb_{start,end}_write() calls will
> not be balanced, so it is harder for a code reviewer to realize that the
> code is correct (as opposed to have excess end_write calls).
> That's the reason I had ISREG check inside the helpers in v1, so like
> file_{start,end}_write(), the calls will be balanced and easy to review.

If you just gate it on IOCB_WRITE and local IS_REG test, then it should
be balanced.

> I am not sure, but I think that getting rid of WRITE_STARTED will
> make the code more subtle, because right now, IOCB_WRITE is
> not set by kiocb_start_write() and many times it is set much sooner.
> So I'd rather keep the WRITE_STARTED flag for a more roust code
> if that's ok with you.

Adding random flags to protect against that is not a good idea imho. It
adds overhead and while it may seem like it's hardening, it's also then
just making it easier to misuse.

I would start with just adding the helpers, and having the callers gate
them with IOCB_WRITE && IS_REG like they do now.

>> index b2adee67f9b2..8e5d410a1be5 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -338,6 +338,8 @@ enum rw_hint {
>>>  #define IOCB_NOIO            (1 << 20)
>>>  /* can use bio alloc cache */
>>>  #define IOCB_ALLOC_CACHE     (1 << 21)
>>> +/* file_start_write() was called */
>>> +#define IOCB_WRITE_STARTED   (1 << 22)
>>>
>>>  /* for use in trace events */
>>>  #define TRACE_IOCB_STRINGS \
>>> @@ -351,7 +353,8 @@ enum rw_hint {
>>>       { IOCB_WRITE,           "WRITE" }, \
>>>       { IOCB_WAITQ,           "WAITQ" }, \
>>>       { IOCB_NOIO,            "NOIO" }, \
>>> -     { IOCB_ALLOC_CACHE,     "ALLOC_CACHE" }
>>> +     { IOCB_ALLOC_CACHE,     "ALLOC_CACHE" }, \
>>> +     { IOCB_WRITE_STARTED,   "WRITE_STARTED" }
>>>
>>>  struct kiocb {
>>>       struct file             *ki_filp;
>>
>> These changes will conflict with other changes in linux-next that are
>> going upstream. I'd prefer to stage this one after those changes, once
>> we get to a version that looks good to everybody.
> 
> Changes coming to linux-next from your tree?
> I was basing my patches on Christian's vfs.all branch.
> Do you mean that you would like to stage this cleanup?
> It's fine by me.

From the xfs tree, if you look at linux-next you should see them. I
don't care who stages it, but I don't want to create needless merge
conflicts because people weren't aware of these conflicts.

-- 
Jens Axboe

