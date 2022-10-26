Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA96A60DAB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 07:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiJZFlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 01:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJZFlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 01:41:49 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245F67B782;
        Tue, 25 Oct 2022 22:41:48 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id p9so6510059vkf.2;
        Tue, 25 Oct 2022 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x6Xw8MapSJHRjdk07ZDU6EsttnSndzaQLevIUlG6ZmQ=;
        b=JLyapH1rh1wrJX2OoYc5fNdm4hx3nbEFrdNfZhgpk5C/5G7SZOAnK714E6x2YumwiF
         iwNwR2FeZe4i2fqKnXVhPWwAgDIilGKQsnr9KLJZfcYlIveae+uwpgNJSOp8kNm8908r
         h8D1roAqOXzHRlPaY9tapWOp1AtdyYTtHIQEHwv337KLIXjpcL8tSdusrrnhrjZGLZRZ
         RhCe9oQ2vbHQbGxzmwQ3m53Z8xP0xq0xbg1gvXEgVBA/zsXxPgARSJCoQUoT1UfKN59P
         vG8zIlrBPDt1w+LgBgC0k5lrXxeC3IZ8OxV9WfnSyYksr5qGyBooE9qaQ3b+v117Q07j
         JH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6Xw8MapSJHRjdk07ZDU6EsttnSndzaQLevIUlG6ZmQ=;
        b=SnE0C+EAnu8EPEyM4Lxqg2ISbxxgk/ncuKFCldKwT6m6uHrZMXxbti/aUjhZwWxrDA
         ptfivBighTe+lmPnCc/UKOs2HSI0FkLiuBOFAgXEvFIgcs1/QG7gedhUtJehN0TiBdgW
         Wl0JH1CenirfT1sxLZstudP0YzgJTilomwS1ZmmOwoC08z6wCB78X7Arq6+dqDmhKFue
         7dOl0pO43jDUycrkHT+iNW/W964RbtXxS+LDypLS3+lrs2hnObt+lOe8gKHEYcxgIN0d
         B1d0denohugqCllqoq6kW/1uR4q5X6Bt3Oo9rELv9o++k3Sj6M4DDktM92dUO5AtYpTf
         CvSA==
X-Gm-Message-State: ACrzQf0cPUTVNfX4mefbRHB94Qxh+zjkuc1USFJZTyfr0gOEEas1AV3a
        11mmOBJQpziAqahQGI2r1Bd38l8WGJJZWr7xZxdy/y3vZ9I=
X-Google-Smtp-Source: AMsMyM4lL1Yg/jdRbzKAyO6KvGWimMjsVkd1FZub3eGSuqv4stgB9GPvSUCo4+GosarJKq+J2GMtBtlPhvMJFVGJMEg=
X-Received: by 2002:a1f:da86:0:b0:3b7:6af6:1e24 with SMTP id
 r128-20020a1fda86000000b003b76af61e24mr6343236vkg.25.1666762907125; Tue, 25
 Oct 2022 22:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-1-stephen.s.brennan@oracle.com> <20221021010310.29521-3-stephen.s.brennan@oracle.com>
 <CAOQ4uxj+ctptwuJ__gn=2URvzkXUc2NZkJaY=woGFEQQZdZn9Q@mail.gmail.com>
 <CAOQ4uxh7OvmH6o1fUmMoQ_D347jVBx53TLe4R=BjtXTuvCzKCA@mail.gmail.com> <87lep3hjcz.fsf@oracle.com>
In-Reply-To: <87lep3hjcz.fsf@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 26 Oct 2022 08:41:35 +0300
Message-ID: <CAOQ4uxjPMhLRU6Xck_5VJ3Hn561sq88DOb6shzz3ty=1gBGBkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fsnotify: Protect i_fsnotify_mask and child flags
 with inode rwsem
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 9:02 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Fri, Oct 21, 2022 at 11:22 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > ...
> >> > +/*
> >> > + * Objects may need some additional actions to be taken when the last reference
> >> > + * is dropped. Define flags to indicate which actions are necessary.
> >> > + */
> >> > +#define FSNOTIFY_OBJ_FLAG_NEED_IPUT            0x01
> >> > +#define FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN      0x02
> >>
> >> with changed_flags argument, you do not need these, you can use
> >> the existing CONN_FLAGS.
> >>
> >> It is a bit ugly that the direction of the change is not expressed
> >> in changed_flags, but for the current code, it is not needed, because
> >> update_children does care about the direction of the change and
> >> the direction of change to HAS_IREF is expressed by the inode
> >> object return value.
> >>
> >
> > Oh that is a lie...
> >
> > return value can be non NULL because of an added mark
> > that wants iref and also wants to watch children, but the
> > only practical consequence of this is that you can only
> > do the WARN_ON for the else case of update_children
> > in fsnotify_recalc_mask().
> >
> > I still think it is a win for code simplicity as I detailed
> > in my comments.
> >
> >> Maybe try it out in v3 to see how it works.
> >>
> >> Unless Jan has an idea that will be easier to read and maintain...
> >>
> >
> > Maybe fsnotify_update_inode_conn_flags() should return "update_flags"
> > and not "changed_flags", because actually the WATCHING_CHILDREN
> > flag is not changed by the helper itself.
>
> Yeah, this is the way I'd like to go. The approach of "orig_flags ^
> new_flags" doesn't work since we're not changing the WATCHING_CHILDREN
> flag.
>
> At the end of the day, I do believe that it's equivalent to what I had
> originally, except that we'd use FSNOTIFY_CONN_FLAG_* rather than my new
> FSNOTIFY_OBJ_FLAG_*, which works for me, the new constants are a bit of
> clutter.
>

Yeh, that is what I was aiming for :)

> > Then, HAS_IREF is not returned when helper did get_iref() and changed
> > HAS_IREF itself and then the comment that says:
> >      /* Unpin inode after detach of last mark that wanted iref */
> > will be even clearer:
> >
> >         if (want_iref) {
> >                 /* Pin inode if any mark wants inode refcount held */
> >                 fsnotify_get_inode_ref(fsnotify_conn_inode(conn));
> >                 conn->flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
> >         } else {
> >                 /* Unpin inode after detach of last mark that wanted iref */
> >                 ret = inode;
> >                 update_flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
>
> Is it possible that once the spinlock is dropped, another
> fsnotify_recalc_mask() finds that FSNOTIFY_CONN_FLAG_HAS_IREF is still
> set, and so it also sets FSNOTIFY_CONN_FLAG_HAS_IREF, causing two
> threads to both do an iput?
>

Yeh, that's a braino of mine.
What I wanted to emphasise is that update_flags does not
have HAS_IREF for the iget case, so there is no ambiguity
about what HAS_IREF means in update_flags.

> It may not be possible due to the current use of the functions, but I
> guess it would be safer to clear the connector flag here under the
> spinlock, and set the *update_flags accordingly so that only one thread
> performs the iput().
>

Absolutely.

Thanks,
Amir.
