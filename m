Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D94D9BD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 14:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbiCONIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 09:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242220AbiCONIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:08:48 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C750E1B
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 06:07:35 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id s207so20699180oie.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 06:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yex+oh+u+z84zLlQkc+APgSHZoy1uYZ8BCInQvP77fI=;
        b=iL+Jm++0kQGM3I/MR4m+/BxCmgQUokamSyub3+iB5gJE2T0zqQDl/4cobCPhn8Rrg5
         7Zco0JCBqi5mmhhctsId5jOyjJN45vm1yRg9DywYWt2BlLqlHGkmuULhVL98dDgXx2fR
         89PndnVKccQ0bFyl2/LzB5eHu2JlV6xJjYHcckd37Q6k8dD/GWRhNMFw5O+ehE9Rn3e4
         WUYFXu5PAZ1cEpIEvvWB61H5XopQCqSmLKtN9EZo9hLUmpIM4vlVCSTb+mxEBqJ0m6CF
         /RR4N2Al7dCrNo1lDNTss7d9LfaYObKY2+V56ypRPliW44HMwC05vN1C8zRBjHHo7gHJ
         nYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yex+oh+u+z84zLlQkc+APgSHZoy1uYZ8BCInQvP77fI=;
        b=P2llj0igaoaX0ZsIHWVSNA6TQp9xYrKQ83DAuX/AX51SQHZRpD5NUFPK/e/ctnqmCY
         q+N5OAypde1J2UXn9jNeidE9AUOTMHv+hfsIiajFapp2RKmcZMWSLlWG0Yc4GbxOBqiG
         iNnvq3M0F5r4OKAd7yCsKVKr8XBk3lTN7QCz4eTxl1dpkg4MdtzYd952yQobFoTc8uX5
         eMKyMUxXBCh1BJqzgxVeR6ga3S2t2rIDo0+7EqSgfu7nCgzEgyp1l6A3/Nsz8P/8DlNR
         ZZ0CvmX+B/F+jM8gLd3NKqA/0ALfl8vYHI6wBtlRyfb3Pvew6ddhVcVWYo3HRFl5y3Hi
         A9fA==
X-Gm-Message-State: AOAM531+OddLAEHLoIg/vGcAEihi6W9WdB05PCp3dGUKP4L1t1bewn/M
        QinU2e1of4QlmhHa5ZVNLGtWe/P0JauCQp3vN80=
X-Google-Smtp-Source: ABdhPJw9MGNYUE8wnNG/2hTJ0V0yfoGYu0xofxrk7Q6Yb+re4doZXLg/OAqKcNIQGWN1h/Vh1HAdHsjys1rX2cyH5VM=
X-Received: by 2002:aca:b845:0:b0:2d4:4207:8fd5 with SMTP id
 i66-20020acab845000000b002d442078fd5mr1710751oif.98.1647349655180; Tue, 15
 Mar 2022 06:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com> <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <20220314113337.j7slrb5srxukztje@quack3.lan> <CAOQ4uxhwXgqbMKMSQJwNqQpKi-iAtS4dsFwkeDDMv=Y0ewp=og@mail.gmail.com>
 <20220315111536.jlnid26rv5pxjpas@quack3.lan>
In-Reply-To: <20220315111536.jlnid26rv5pxjpas@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 15 Mar 2022 15:07:24 +0200
Message-ID: <CAOQ4uxhSKk=rPtF4vwiW0u1Yy4p8Rhdd+wKC2BLJxHR8Q9V9AA@mail.gmail.com>
Subject: Re: Fanotify Directory exclusion not working when using FAN_MARK_MOUNT
To:     Jan Kara <jack@suse.cz>
Cc:     Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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

> > > Overall I guess the functionality makes sense to me (in fact it is somewhat
> > > surprising it is not working like that from the beginning), API-wise it is
> > > not outright horrible, and technically it seems doable. What do you think?
> >
> > I think that having ONDIR and ON_CHILD in ignored mask is source for
> > confusion. Imagine a mount mark with FAN_ONDIR and ignored mark (on dir
> > inode) without FAN_ONDIR.  What should the outcome be?
> > Don't ignore the events on dir because ignore mask does not have ONDIR?
> > That is not the obvious behavior that people will expect.
> >
> > ON_CHILD may be a different case, but I also prefer not to deviate it from
> > ONDIR.
> >
> > The only thing I can think of to add clarification is FAN_MARK_PARENT.
> >
> > man page already says:
> > "The flag has no effect when marking mounts and filesystems."
> > It can also say:
> > "The flag has no effect when set in the ignored mask..."
> > "The flag is implied for both mask and ignored mask when marking
> >  directories with FAN_MARK_PARENT".
> >
> > Implementation wise, this would be very simple, because we already
> > force set FAN_EVENT_ON_CHILD for FAN_MARK_MOUNT
> > and FAN_MARK_FILESYSTEM with REPORT_DIR_FID, se we can
> > also force set it for FAN_MARK_PARENT.
> >
> > But maybe it's just me that thinks this would be more clear??
>
> Yeah, I'm not sure if adding another flag that iteracts with ON_CHILD or
> ONDIR adds any clarity to this mess. In my opinion defining that ON_CHILD
> flag in the ignore mask means "apply this ignore mask to events from
> immediate children" has an intuitive meaning as it is exactly matching the
> semantics of ON_CHILD in the normal mark mask.
>

Ok.

The only thing is, as you wrote to Srinivas, there is really no practical
way to make ignore mask with ON_CHILD work on old kernels, so
what can users do if they want to write a portable program?
Add this mark and hope for the best?
If users had FAN_MARK_PARENT, the outcome at least would
have been predictable.
Maybe FAN_MARK_PARENT is an overkill.
Maybe what we need is FAN_MARK_IGNORED_ON_CHILD.
It's not very pretty, but it is clear.

> With ONDIR I agree things are not as obvious. Historically we have applied
> ignore mask even for events coming from directories regardless of ONDIR
> flag in the ignore mask. So ignore mask without any special flag has the
> implicit meaning of "apply to all events regardless of type of originating
> inode". I don't think we can change that meaning at this point. We could
> define meaning of ONDIR in ignore mask to either "ignore only events from
> directories" or to "ignore only events from ordinary files". But neither
> seems particularly natural or useful.
>

TBH, I always found it annoying that fanotify cannot be used to specify
a filter to get only mkdirs, which is a pretty common thing to want to be
notified of (i.e. for recursive watch).
But I have no intention to propose API changes to fix that.

> Another concern is that currently fanotify_mark() ignores both ONDIR and
> ON_CHILD flags in the ignore mask. So there is a chance someone happens to
> set them by accident. For the ON_CHILD flag I would be willing to take a
> chance and assign the meaning to this flag because I think chances for
> real world breakage are really low. But for ONDIR, given it is unclear
> whether ignore masks should apply for directory events without that flag, I
> think the chances someone sets it "just to be sure" are high enough that I
> would be reluctant to take that chance. So for ONDIR I think we are more or
> less stuck with keeping it unused in the ignore mask.
>

I agree with your risk assessment, so no hard objection to ON_CHILD
on ignored mask.
If we go with FAN_MARK_IGNORED_ON_CHILD it will not be a concern
at all.

I should be able to find some time to fix this one way or the other
when we decide on the design.

Thanks,
Amir.
