Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57FC51B76F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 07:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243423AbiEEF1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 01:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiEEF1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 01:27:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7C1CFFE
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 22:23:31 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h3so2450827qtn.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 May 2022 22:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWZc08k4G6qijI2eiulIFe2RbJQDuB/dcvNknClUTuY=;
        b=VHSvRydv5Ys9zzV4VpSFN5KtbKDdmuWm6XhqxHVsqzmvkgB4cbS88+FP39xt4CYoM5
         cmTQgEVbUeSL2Ge5a9VKT5Pbd1IUcCjIHpQNTRgmVAHo4H19E+eGFetYH4Bb5TVAqGTq
         DXYEKfRY2JbJef7cS0W/u9S+/scapFOMK+ct75WZuDKfPeBCLzHaO6X3L16PyGC+jaFY
         0c5gwLWy4JFcZT9DKwMfLF5ILOBUqWf92YRnmJEyAG46dG0xUUx1H2jhDylskONCTwGJ
         1WXy2eFdzT23C8pk9xG7fCsBszvSm6/cDztfszJbEAAhJihkHukzPtdYh9oLZfrl0Lg8
         ZTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWZc08k4G6qijI2eiulIFe2RbJQDuB/dcvNknClUTuY=;
        b=xBi0WBMnFu4WN6vA4YYd6MxlfVxz8zIR1iRdyrtBtvz1xMAg6XqhOGMCSAYxO5ALVG
         zp7wKB/q79OLcQ8ldgJSSVgEQwrX7yCIgXBin6n7jn5G22acTJqFKlOGfqHAdsrxTlmt
         X6qY+NKSOk39D/T6hY137d7J2pQU28hpebyjGLALQ33f9H2JA7z5g/HBEodfN38eDrJ3
         pXbJuiKQzYX5zdGJy3x14vNzo7hZGLkE2TqHHsU7wbqSjzkt1V036cz90V9jmsWmNyIX
         6WBPkFEq4BdryD8aiycAsMA+cS5pIXlaoOibrulsZxlYxF/mLznLXtcP5LyNhQBTwpli
         Sd+Q==
X-Gm-Message-State: AOAM530NhKugWGvxoT3SOKqG09mpO//AoioNrw7K1jmU5/s9pYL5xKZV
        h2LVTzjSb3kWWsoBxV3GAP1yJyiFzShBEMIk+hk=
X-Google-Smtp-Source: ABdhPJzfNb604/hrJhJ3W133ez/Yf+Jf7wYgv/bbuvqdD48x/moRuAlf2Y3FQzNGws8orXI+HiH0MQtP61pBwGYg/cQ=
X-Received: by 2002:ac8:5a4f:0:b0:2ed:d39b:5264 with SMTP id
 o15-20020ac85a4f000000b002edd39b5264mr22543851qta.477.1651728210600; Wed, 04
 May 2022 22:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220503183750.1977-1-duguoweisz@gmail.com> <20220503194943.6bcmsxjvinfjrqxa@quack3.lan>
 <CAC+1Nxv5n0eGtRhfS6pxt8Z-no5scu2kO2pu+_6CpbkeeBqFAw@mail.gmail.com>
 <20220504192751.76axinbuuptqdpsz@quack3.lan> <CAC+1Nxt2NsyA=HpyK=75oaFuKSp9y_ze3JOS2rE0+AEETn5iiQ@mail.gmail.com>
In-Reply-To: <CAC+1Nxt2NsyA=HpyK=75oaFuKSp9y_ze3JOS2rE0+AEETn5iiQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 May 2022 08:23:19 +0300
Message-ID: <CAOQ4uxiO2fNt-DFqpbX5pZ1dVjMxT+E4-GVFZxY7_LJx1E4rkw@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: add generic perm check for unlink/rmdir
To:     guowei du <duguoweisz@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
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

On Thu, May 5, 2022 at 6:28 AM guowei du <duguoweisz@gmail.com> wrote:
>
> thanks very much for your replay.
>
> I am a starter for kernel filesystem study, i see the newest plan with the 'pre modify events',
> I think the plan is great and meaningful,I am looking forward to it.

Welcome. Since you are new let me start with some basics.
I don't know what generated the long list of CC that you used,
I suppose it was get_maintainer.pl - this list is way too long and irrelevant
I cut it down to the list and maintainers listed in the MAINTAINERS file.

>
> for the legacy modify events, i mean to implement most blocking events which are not yet
> done for now, maybe the permission model is old or legacy, and,sure ,expending the
> blocking events such as unlink/rmdir/rename will do pollute EVENTS namespace in part.
> but, it is only a little ,maybe all usual blocking events are  open/access/rmdir/unlink/rename,
> they cover some usecases,and other modify events can be only audited or notified.

Sorry, I don't understand what you mean.

>
> With the fanotify, open/access/rmdir/unlink/rename need to occupy a fsnotify bit to explicitly
> separate from others.if Blocking event is denied,then there will be no normal events to notify.
>

Sorry, I don't understand what you mean.
What I meant is that adding different bits for FAN_OPEN and FAN_OPEN_PERM
was a mistake that was done a long time ago and we need to live with it.
We do NOT need to repeat the same mistake again.

We need to initialize fanotify with class FAN_CLASS_PERM and then when
setting events FAN_UNLINK|FAN_RMDIR in mask they will be blocking events
which reader will need to allow/deny.

Here is my old example implementation of dir modify permission events that use
just one more bit in mask:
https://github.com/amir73il/linux/commits/fsnotify_dirent_perm

This was never designed to be exported to users via fanotify, but it could
be extended. I also did not think yet how this could be combined with pre-modify
events that have different implementations.
I am just giving that as an example of how only a single new bit can be used
to describe blocking events for all the legacy notification events.

> By now ,fanotify is a way that userspace could make choice to allow or deny some events,so
> I expand fsnotify and use fanotify to do some work.
>
> so,that is why I expand the fsnotify blocking events.

Since you are new, I will try to be very clear about expectations.
In order to get the requested changes into the kernel you will have to
address the comments that we gave you.
If you do not understand the comments, please ask for clarifications.
These will not be the last comments that you will get.
Other people may also have more comments on your patches.
You will be asked to write tests.

Thanks,
Amir.
