Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF9D51C069
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 15:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378983AbiEENVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 09:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377190AbiEENU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 09:20:59 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DFD2E684
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 06:17:20 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id s4so3129784qkh.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 May 2022 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHDeuXobOPbOJYxsebPbcLRDlWZm1Xez5L8IQWn8iDM=;
        b=RCvA5nCrZGPUNqNlGBsYDv2XISD1VlRqdxJ+4o+0E/0F67Rf3ySTZiybQAup8fCj7f
         bq8Y452a2T9H650/FnB2vwmCvg8YBumz59nt3DuqNiikT6OCtYqpjuLA3AC21q9wECjJ
         /yB7ZZLdHk6Q0KJAwAPOV07dE2eLSQ6G7zsrpinmHHIw6dWbtJEKJc+jv+dvKikl+d97
         /4rwZ+IC9LMjLsrzE/TsguSS+M/a9mZ5zq9v3Pazn7FqFKOCmG9yRnWSWErjplVqOx4s
         5plQnANuFB7YwC+Ku7WABj1F/tTWx1FZeU37282neBiGaQDsPeAZ98apkm1YwVPE+3M4
         QO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHDeuXobOPbOJYxsebPbcLRDlWZm1Xez5L8IQWn8iDM=;
        b=jo0GZmRLZ9FBWjosd9KmlseXeL4+iBfoRpS36wg0wcMLN21iwKs6IOV8VXWRj1T2vm
         WtsdN0aG+KfNFQ3F2dDVe508JLO6lGqCl5gnz4Y59Y0px6eJea5Uh6VYeTe/C60BiKg3
         +BPnt3LcrwKJ7VXftVjyh+0ScHMFZexWYWdFcfk8a/go3VRCadvSOlfo4grVKIMws6iK
         PEAHcCBT+MbrawTIiPbdaArWXMAErOlzCEjWx1niDxOAKn+vESISz9wkRub/LGLFjq7Z
         Q6YmQYljuMWZDtiWLkVB6p8msrMeEZFw12AfskwH2W1GbhBu+4cFCpfLMTdGILF+bVqi
         oYRA==
X-Gm-Message-State: AOAM532s/BcMovWtjyGPYoXPp49qOZPjJytGLenC2iT1+pzCvkwCgcxt
        rnJ4yZK/fqkXzsY7IOeQ1we0q8uoBN+npth6x6w=
X-Google-Smtp-Source: ABdhPJyJXYWDkJeJFPgbix8AMYiZET3z4nlGnGJ5RFRJ/tmKvY3GnjWNaqg9W33lz1XHWe9YJdz3cbecKQrwC0OVkFA=
X-Received: by 2002:a05:620a:460d:b0:6a0:11c5:a12f with SMTP id
 br13-20020a05620a460d00b006a011c5a12fmr6465743qkb.258.1651756639367; Thu, 05
 May 2022 06:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220503183750.1977-1-duguoweisz@gmail.com> <20220503194943.6bcmsxjvinfjrqxa@quack3.lan>
 <CAC+1Nxv5n0eGtRhfS6pxt8Z-no5scu2kO2pu+_6CpbkeeBqFAw@mail.gmail.com>
 <20220504192751.76axinbuuptqdpsz@quack3.lan> <CAC+1Nxt2NsyA=HpyK=75oaFuKSp9y_ze3JOS2rE0+AEETn5iiQ@mail.gmail.com>
 <CAOQ4uxiO2fNt-DFqpbX5pZ1dVjMxT+E4-GVFZxY7_LJx1E4rkw@mail.gmail.com> <CAC+1NxtcFf8XN9BnyOOLWqCkwCw-ozndKTuc3fYuM_Gbs2w92w@mail.gmail.com>
In-Reply-To: <CAC+1NxtcFf8XN9BnyOOLWqCkwCw-ozndKTuc3fYuM_Gbs2w92w@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 5 May 2022 16:17:07 +0300
Message-ID: <CAOQ4uxjS6ixL4bzVB4NT=k0seP9m1WQ5tNfWa9cdtk1BPvNojQ@mail.gmail.com>
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

On Thu, May 5, 2022 at 10:22 AM guowei du <duguoweisz@gmail.com> wrote:
>
> Ok, I understand.
>
> All replies are very important to me,I need to make some changes for my mistakes.
> I should not do the same wrong things for now.

One more newbie mistake to correct - no "top posting" please.
Answers below the questions.

See one more important comment below.

>
>
> thanks very much.
>
> On Thu, May 5, 2022 at 1:23 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> On Thu, May 5, 2022 at 6:28 AM guowei du <duguoweisz@gmail.com> wrote:
>> >
>> > thanks very much for your replay.
>> >
>> > I am a starter for kernel filesystem study, i see the newest plan with the 'pre modify events',
>> > I think the plan is great and meaningful,I am looking forward to it.
>>
>> Welcome. Since you are new let me start with some basics.
>> I don't know what generated the long list of CC that you used,
>> I suppose it was get_maintainer.pl - this list is way too long and irrelevant
>> I cut it down to the list and maintainers listed in the MAINTAINERS file.
>>
>> >
>> > for the legacy modify events, i mean to implement most blocking events which are not yet
>> > done for now, maybe the permission model is old or legacy, and,sure ,expending the
>> > blocking events such as unlink/rmdir/rename will do pollute EVENTS namespace in part.
>> > but, it is only a little ,maybe all usual blocking events are  open/access/rmdir/unlink/rename,
>> > they cover some usecases,and other modify events can be only audited or notified.
>>
>> Sorry, I don't understand what you mean.
>>
>> >
>> > With the fanotify, open/access/rmdir/unlink/rename need to occupy a fsnotify bit to explicitly
>> > separate from others.if Blocking event is denied,then there will be no normal events to notify.
>> >
>>
>> Sorry, I don't understand what you mean.
>> What I meant is that adding different bits for FAN_OPEN and FAN_OPEN_PERM
>> was a mistake that was done a long time ago and we need to live with it.
>> We do NOT need to repeat the same mistake again.
>>
>> We need to initialize fanotify with class FAN_CLASS_PERM and then when
>> setting events FAN_UNLINK|FAN_RMDIR in mask they will be blocking events
>> which reader will need to allow/deny.
>>
>> Here is my old example implementation of dir modify permission events that use
>> just one more bit in mask:
>> https://github.com/amir73il/linux/commits/fsnotify_dirent_perm
>>

As you can see in the branch above, this is similar to your patch
but more generic.

However, I did not like this approach especially if exporting blocking events
to userspace because the hooks are called with directory inode locked.

That means that as long as the monitoring program does not approve
an unlink, creation of files in that directory are blocked as well.
This could also result in deadlock because userland is not aware of
directory locking order.

So IF we are going to support those blocking events in userspace
and be aware that it is not at all certina that we will, then those events
better be called without the inode lock held as in my pre_modify
patches. I can split
#define FS_NAME_INTENT         0x02000000      /* Subfile about to be
linked/unlinked */
To FS_LINK_INTENT and FS_UNLINK_INTENT if needed
that is not a problem, but separate events for RMDIR and UNLINK is
an overkill. You will be able to use FAN_ONDIR to request or ignore
FS_UNLINK_INTENT events on directories.

I expect to post these patches within month or two.

Thanks,
Amir.
