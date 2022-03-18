Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5324DDDBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 17:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbiCRQIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 12:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238854AbiCRQIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:08:13 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E8B871
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 09:06:53 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so10667400ooj.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=psZZZZEFRXz/OWFYqEQ964HKU4lbygX8QRdqbHrKehk=;
        b=nul8ihtzLLh4avKDNjp9kb5Tw0+jDLoJ0qstxXUgmzq4x3M+d+YARp003jKyig1xxd
         bPwAsrAQOpxdC+/0QBcn8noV7pVNlly8zHfBJJLmsxDwDB9XqPvvNaSgUx6LaFY/UWoh
         IZSxq0/viunjQmBBrl5XWMdxLP6tg5/SCB7tHcLLcnQ1oV34uaSbsGg6YgWnag5amME+
         ugzk8LpYkmQMHyHHqmeJCR8LKFs87Vjys4brHPvU3iRNCV+0lwPGgSlSuEzb9PHzweNO
         kPXuY10z8rFx+f9qwN8fgoBUELxYYKw3kz2pmUriS3YeKf40QNmuxWbh9cmj0Fdbl993
         z3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=psZZZZEFRXz/OWFYqEQ964HKU4lbygX8QRdqbHrKehk=;
        b=ANwBl2juYNfnC3XUzMwyFEMjCtGdHGGvMl6eMBWXvoCYi/esQ9RmFW0csI7tVkEpvk
         N6HVGXUnineVAt5UifMXtvDKqABigN5j9XhRiUIx6HCBgirwLL65v/XWtK9GaRRSzn26
         HBOOvmOQkqBI0SGYtHf7qQSTX0iFSj0HI5edxobuh6sSpDcOzKt1X6uZlu+ZW5I6odsY
         gAx/jnR03ol+/pd66IyAqlCu+qtDXuFf2kkh8Dqy6X38uGT9tYSc0r85LK7Nlg7Y4cdU
         skpojL6Fxbjsrg38Vaaw55xILZ+ODnW3OfzH/sHmv2FLsOntIojUPFQjUrVfSpsOrgOh
         XfqA==
X-Gm-Message-State: AOAM532+uMpx+vfbpBBkc+i7x0k7Es1avv4kB42A50NdtnEasRGsVF2w
        pM5WgbLx5RK//ueYX5ZlV0TbUEW4uZyxIYr9/yOufxo9yXQ=
X-Google-Smtp-Source: ABdhPJzY3hgURY3Yi226i4bYRZ1o9+smoF1Jd2S5Uu3eK++09D7cUBUqMdwg/Iu4DS2o3j/mpmjlhEuj3Qp8B9QH7/U=
X-Received: by 2002:a05:6870:d20b:b0:da:b3f:2b2c with SMTP id
 g11-20020a056870d20b00b000da0b3f2b2cmr7301955oac.203.1647619613313; Fri, 18
 Mar 2022 09:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220307155741.1352405-5-amir73il@gmail.com>
 <20220317153443.iy5rvns5nwxlxx43@quack3.lan> <20220317154550.y3rvxmmfcaf5n5st@quack3.lan>
 <CAOQ4uxi85LV7upQuBUjL==aaWoY8WGMG4DRQToj6Y-JCn-Ex=g@mail.gmail.com>
 <20220318103219.j744o5g5bmsneihz@quack3.lan> <CAOQ4uxj_-pYg4g6V8OrF8rD-8R+Mn1tMsPBq52WnfkvjZWYVrw@mail.gmail.com>
 <20220318140951.oly4ummcuu2snat5@quack3.lan>
In-Reply-To: <20220318140951.oly4ummcuu2snat5@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 18 Mar 2022 18:06:40 +0200
Message-ID: <CAOQ4uxisrc_u761uv9_EwgiENz4J6SNk=hPxpr7Nn=vC1S2gLg@mail.gmail.com>
Subject: Re: [PATCH 4/5] fanotify: add support for exclusive create of mark
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

> > > So far my thinking is that we either follow the path of possibly generating
> > > more events than necessary (i.e., any merge of two masks that do not both
> > > have FAN_MARK_VOLATILE set will clear FAN_MARK_VOLATILE)

I agree that would provide predictable behavior which is also similar to
that of _SURV_MODIFY.
But IMO, this is very weird to explain/document in the wider sense.
However, if we only document that
"FAN_MARK_VOLATILE cannot be set on an existing mark and any update
 of the mask without FAN_MARK_VOLATILE clears that flag"
(i.e. we make _VOLATILE imply the _CREATE behavior)
then the merge logic is the same as you suggested, but easier to explain.

> > > or we rework the
> > > whole mark API (and implementation!) to completely avoid these strange
> > > effects of flag merging. I don't like FAN_MARK_CREATE much because IMO it
> > > solves only half of the problem - when new mark with a flag wants to merge
> > > with an existing mark, but does not solve the other half when some other
> > > mark wants to merge to a mark with a flag. Thoughts?
> > >
> >
> > Yes. Just one thought.
> > My applications never needed to change the mark mask after it was
> > set and I don't really see a huge use case for changing the mask
> > once it was set (besides removing the entire mark).
> >
> > So instead of FAN_MARK_CREATE, we may try to see if FAN_MARK_CONST
> > results in something that is useful and not too complicated to implement
> > and document.
> >
> > IMO using a "const" initialization for the "volatile" mark is not such a big
> > limitation and should not cripple the feature.
>
> OK, so basically if there's mark already placed at the inode and we try to
> add FAN_MARK_CONST, the addition would fail, and similarly if we later tried
> to add further mark to the inode with FAN_MARK_CONST mark, it would fail?
>
> Thinking out loud: What does FAN_MARK_CONST bring compared to the
> suggestion to go via the path of possibly generating more events by
> clearing FAN_MARK_VOLATILE? I guess some additional safety if you would add
> another mark to the same inode by an accident. Because if you never update
> marks, there's no problem with additional mark flags.
> Is the new flag worth it? Not sure...  :)

I rather not add new flags if we can do without them.

To summarize my last proposal:

1. On fanotify_mark() with FAN_MARK_VOLATILE
1.a. If the mark is new, the HAS_IREF flag is not set and no ihold()
1.b. If mark already exists without HAS_IREF flag, mask is updated
1.c. If mark already exists with HAS_IREF flag, mark add fails with EEXISTS

2. On fanotify_mark() without FAN_MARK_VOLATILE
2.a. If the mark is new or exists without HAS_IREF, the HAS_IREF flag
is set and ihold()
2.b. If mark already exists with HAS_IREF flag, mask is updated

Do we have a winner?

Thanks,
Amir.
