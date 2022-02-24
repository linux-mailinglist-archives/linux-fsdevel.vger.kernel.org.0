Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DD34C2178
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 03:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiBXCB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 21:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiBXCBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:01:55 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31D915B3EF;
        Wed, 23 Feb 2022 18:01:26 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id b35so913201ybi.13;
        Wed, 23 Feb 2022 18:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDzVZls32Tn+CgZQqLjQPwA2ePA8pNdpM8QzmA533pc=;
        b=OQw7yyeyEfFjC3dZHjfMUxfYBAU6NRghHcNxQF46CLKtKLTCRbMhhIOy/86n2j985E
         0Vmj9b1akLS6fQiSBG5w/PNqCfUgNLZuvwpZcDO65I+hCX7QbLCusXXBrrErXdl4uqUA
         h2GGW+pwPYI2ZnE/6se/UMP+7x4QsMf040AkEqX1ftBaJHRMN7yJ7VqGzTZ4SQWkUylL
         6VCJ5jMq3ANhXUTxzd7HHKyKp5vZs/WIibePxYqzWgwrjVvib+nKCq5gMjuwlfJgh1Tx
         VTDst8A4foBg6aCtgMiMJc8yBoXtifMA2RumB//CZdWVFYSm/w2MTrF1xCxz/SG8yauR
         yAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDzVZls32Tn+CgZQqLjQPwA2ePA8pNdpM8QzmA533pc=;
        b=wNPqZabYgXD/XJ4yIhSHEiuOZXw3ry0mKdiDVeLZlA4U32hYbaN/6XjNN51T7TrnGf
         2uM3tvw0F7+LZ00xdgFnLKIYuyatcJmaCcLVig7wXWVKhG/1B1c7ermGE0UtmTq6xhJ5
         lyhl/FMOaUs5BVdRtn+emwG6GFd9wreoH4U88yPzE8n+2CdVPe8T5Lpd1/rt1A2c3q+M
         o9jGj6uqJ1szJISGhoRNy6lOlhxw0eA9exCrMdv5K9xxZHB0OiSLBfZwDg8OOhJs+HF1
         btURGBikcTP6rVPjkWzF6mupEGRk9vnreWVjYBI91ZWFo/3n4F1kaRxZ7vSwZ0H/J28t
         lCQQ==
X-Gm-Message-State: AOAM531NA4+65DHJqUt6DRFfIVBT9FI5suU+1Bxzj64XlusMlvbD/7o/
        JpFSuW3wLAbkcQr5RDCJZpTQqBHhDKZh6J47B8mcSkAM5xlRPw==
X-Google-Smtp-Source: ABdhPJwBkfAmaXuOhrLE426LrrsjRbaXAoxNnVJ3cgIzCOgY7z7HXNhGXPYupIwMI7HYn8OiRm7Xoc5MQ0loQQ/Trk4=
X-Received: by 2002:a25:241:0:b0:61e:fb6e:8f33 with SMTP id
 62-20020a250241000000b0061efb6e8f33mr278196ybc.413.1645663892466; Wed, 23 Feb
 2022 16:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20220223231752.52241-1-ppbuk5246@gmail.com> <YhbCGDzlTWp2OJzI@zeniv-ca.linux.org.uk>
 <CAM7-yPTM6FNuT4vs2EuKAKitTWMTHw_XzKVggxQJzn5hqbBHpw@mail.gmail.com>
 <CAM7-yPSk35UoGmRY_rCo2=RryBvwbQEjeWfL2tz1ADUosCXNjw@mail.gmail.com> <878ru1umcu.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <878ru1umcu.fsf@email.froward.int.ebiederm.org>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Thu, 24 Feb 2022 09:51:21 +0900
Message-ID: <CAM7-yPTPZXPxhtwvvH6KqpRng2idxZiNCLsJHXbWM4ge1wqsBQ@mail.gmail.com>
Subject: Re: [PATCH] fs/exec.c: Avoid a race in formats
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Mostly of what has been happening with binary formats lately is code
> removal.
>
> So I humbly suggest the best defense against misuse by modules is to
> simply remove "EXPORT_SYMBOL(__register_binfmt)".

It could be a solution. but that means the kernel doesn't allow
dynamic binfmt using modules too.
I think the best safe way to remove registered binfmt is ...

unregister binfmt list first ---- (1)
synchronize_rcu_task();
// tasklist stack-check...
unload module.

But for this, there shouldn't happen in the above situation of (1).
If unregister_binfmt has this problem.. I think there is no way to
unload safely for dynamic registered binfmt via module.



On Thu, Feb 24, 2022 at 9:42 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Yun Levi <ppbuk5246@gmail.com> writes:
>
> > On Thu, Feb 24, 2022 at 8:59 AM Yun Levi <ppbuk5246@gmail.com> wrote:
> >>
> >> On Thu, Feb 24, 2022 at 8:24 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> >
> >> > On Thu, Feb 24, 2022 at 08:17:52AM +0900, Levi Yun wrote:
> >> > > Suppose a module registers its own binfmt (custom) and formats is like:
> >> > >
> >> > > +---------+    +----------+    +---------+
> >> > > | custom  | -> |  format1 | -> | format2 |
> >> > > +---------+    +----------+    +---------+
> >> > >
> >> > > and try to call unregister_binfmt with custom NOT in __exit stage.
> >> >
> >> > Explain, please.  Why would anyone do that?  And how would such
> >> > module decide when it's safe to e.g. dismantle data structures
> >> > used by methods of that binfmt, etc.?
> >> > Could you give more detailed example?
> >>
> >> I think if someone wants to control their own binfmt via "ioctl" not
> >> on time on LOAD.
> >> For example, someone wants to control exec (notification,
> >> allow/disallow and etc..)
> >> and want to enable and disable own's control exec via binfmt reg / unreg
> >> In that situation, While the module is loaded, binfmt is still live
> >> and can be reused by
> >> reg/unreg to enable/disable his exec' control.
> >>
> >> module can decide it's safe to unload by tracing the stack and
> >> confirming whether some tasks in the custom binfmt's function after it
> >> unregisters its own binfmt.
> >>
> >> > Because it looks like papering over an inherently unsafe use of binfmt interfaces..
> >>
> >> I think the above example it's quite a trick and stupid.  it's quite
> >> unsafe to use as you mention.
> >> But, misuse allows that situation to happen without any warning.
> >> As a robustness, I just try to avoid above situation But,
> >> I think it's better to restrict unregister binfmt unregister only when
> >> there is no module usage.
> >
> > And not only stupid exmaple,
> > if someone loadable custom binfmt register in __init and __exit via
> > register and unregister_binfmt,
> > I think that situation could happen.
>
> Mostly of what has been happening with binary formats lately is code
> removal.
>
> So I humbly suggest the best defense against misuse by modules is to
> simply remove "EXPORT_SYMBOL(__register_binfmt)".
>
> Eric
