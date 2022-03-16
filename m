Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8724DB1BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243471AbiCPNoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352902AbiCPNoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:44:14 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEE1E0B9
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 06:42:56 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id x26-20020a4a9b9a000000b003211029e80fso2715387ooj.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tDTcec0DtXdLxeAhHSGkebHZpjAyRASUyWI4GvlCUY=;
        b=EYMwr10bdHmjKsFpJjPV1vRiMVOk5hfcFBxP58BvSXeDes0yICfxJboz0ptv8qZGVg
         Gz82upP6vfxP4ZSzXP/Gka7ZLvoFSWmSA3rfOO69wf5g3H8hsLPFmFgLaNoUfmsC+G3q
         eIo1v4+tOo0V3tWuF+debs+wp1r/u8eAfbH0RVf3eWwNREcI/4wbsU0rOO5r2oWlIox8
         YOyfNhJ73vvjxRaj8VwA0n/mWRh1Qvz9xsDqw33rJ4nn1inwmmJFnNNwSLxVIFue36Ff
         SZF2uuLE/vELTOST8bDmAz8zwR+DTD8ym0jJOqJDAr7AlTA+TPe+VHwXeeCt6EcLIeIw
         cmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tDTcec0DtXdLxeAhHSGkebHZpjAyRASUyWI4GvlCUY=;
        b=IiTIYqU2grPrz2CFD3glosxSjVzNmYuxbPnzUJNWPda2OqD7nqmhqSoONOQy36f4oo
         C+p6jO6tVC0VfmZaYfp5BQKHttEnlXQ2TV3U4vJrsz7ibG6i3IHmH4jqJM8uiUKn3r7Y
         U+2zG6giFp6YS9hbMk+dvA2uo+/p/E4wCoTpXnWgAecGmpv14vsQjIXTaEg38nsOJeLC
         rreyVkQlF/lXzZZVjhc+jPdynVDc6Pjx2i2GtdeGbgUdbgB0jCcH+JqkZxaJ6P+q/WBf
         3nulGCmSaHAL60FaO09xjcoLoRKIot1/fb7hkYXOeSGucOCVx2LsFdzpBktwxlOBozs8
         7BZQ==
X-Gm-Message-State: AOAM532HsSRFgEURvUZ05zEHvdSj5lh9k1o9pNGsvl/2R1nGXnRjPJ3R
        9+72vCIrpGI3iikJ6ZF/An0BvTWl8MRmc+UF31zaifAi8hQ=
X-Google-Smtp-Source: ABdhPJytjTK0Ln5L+m0oXb5rJz8OmlIfgZCRkjVNuGqV3Pg8fbfDi9NS9Kax6ZmdBmmx5TAUs0PvJyXkfFRUE9POyPo=
X-Received: by 2002:a05:6820:174:b0:320:fbeb:da58 with SMTP id
 k20-20020a056820017400b00320fbebda58mr12709488ood.22.1647438175854; Wed, 16
 Mar 2022 06:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com> <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <20220314113337.j7slrb5srxukztje@quack3.lan> <CAOQ4uxhwXgqbMKMSQJwNqQpKi-iAtS4dsFwkeDDMv=Y0ewp=og@mail.gmail.com>
 <20220315111536.jlnid26rv5pxjpas@quack3.lan> <CAOQ4uxhSKk=rPtF4vwiW0u1Yy4p8Rhdd+wKC2BLJxHR8Q9V9AA@mail.gmail.com>
 <20220316115058.a2ki6injgdp7xjf7@quack3.lan>
In-Reply-To: <20220316115058.a2ki6injgdp7xjf7@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Mar 2022 15:42:44 +0200
Message-ID: <CAOQ4uxgG37z7h-OYtGsZ-1=oQNu-DVvQgbN5wNbLXf0ktY1htg@mail.gmail.com>
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

> > The only thing is, as you wrote to Srinivas, there is really no practical
> > way to make ignore mask with ON_CHILD work on old kernels, so
> > what can users do if they want to write a portable program?
> > Add this mark and hope for the best?
>
> OK, this objection probably tipped the balace towards a new flag for me :)
>
> > If users had FAN_MARK_PARENT, the outcome at least would
> > have been predictable.
> > Maybe FAN_MARK_PARENT is an overkill.
> > Maybe what we need is FAN_MARK_IGNORED_ON_CHILD.
> > It's not very pretty, but it is clear.
>
> Or how about FAN_MARK_IGNORED_MASK_CHECKED which would properly check for
> supported bits in the ignore mask and then we can use ON_CHILD as I wanted
> and we would regain ONDIR bit for future use as well?
>

I don't follow the reasoning behind the name MASK_CHECKED.
If anything, I would rather introduce FAN_IGNORE_MARK.
The reasoning is that users may think of this "ignore mark"
as a separate mark from the "inode mark", so on this "mark" the
meaning of ON_CHILD flags would be pretty clear.

The fact that they are implemented as a single mark with two masks
and that each mask also has some flags is an implementation detail.

If we go for FAN_IGNORE_MARK, we would disallow the combination
  fanotify_mark(FAN_IGNORE_MARK, FAN_MARK_IGNORED_MASK, ...
and I am also in favor of disallowing FAN_MARK_IGNORED_SURV_MODIFY.
I find it completely useless for watching children and if people still need
the ignored mask that does not survive modify, they can use the old API.

> > > With ONDIR I agree things are not as obvious. Historically we have applied
> > > ignore mask even for events coming from directories regardless of ONDIR
> > > flag in the ignore mask. So ignore mask without any special flag has the
> > > implicit meaning of "apply to all events regardless of type of originating
> > > inode". I don't think we can change that meaning at this point. We could
> > > define meaning of ONDIR in ignore mask to either "ignore only events from
> > > directories" or to "ignore only events from ordinary files". But neither
> > > seems particularly natural or useful.
> > >
> >
> > TBH, I always found it annoying that fanotify cannot be used to specify
> > a filter to get only mkdirs, which is a pretty common thing to want to be
> > notified of (i.e. for recursive watch).
> > But I have no intention to propose API changes to fix that.
>
> I see, so we could repurpose ONDIR bit in ignore mask for EVENT_IGNORE_NONDIR
> feature or something like that. But as you say, no pressing need...
>

Alas, that does not fit nicely with the FAN_IGNORE_MARK abstraction.
The inverse does:
The "mark" with ONDIR captures all the create events and the "ignore mark"
without ONDIR filters out the non-mkdir.

Thanks,
Amir.
