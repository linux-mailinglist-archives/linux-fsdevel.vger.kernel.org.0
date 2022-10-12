Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FC65FC945
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJLQ25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 12:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJLQ2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:28:39 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E16C90C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 09:28:38 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id k6so15841838vsp.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UeVceXH8JhpPGY+nsuPn5FDX/oiJkbwVgYYIGTA0FA0=;
        b=Psxco8yF6uvUVJ/ToBYJq26rY+XAyQNBQZoLy3Pid0H3iMW/8+ULwVHgQj6JFHrfvY
         WVE3Mc7NOSnCdgj3cr6ZERjsMJwBuYYASJD4fujWH9M5/BC73PH0ld0355ZbC7Lassnv
         UwA1vobn/zoZPuz5KjgWg81ogt8V+UvoufwWXHATEG38cm9Bhmahgm5VRFi9VqMX1iXD
         fdmVBVj87bi9bC4MxXAPJHcbYG7u953xHjFrdcGTsZbddxnR6R/wVBCMWYrcdDXn77A1
         Ao/FJrljDvGhCOK0igK0TMDYFhnhiE98A4KNdDq2bF8PvbVkZRZi8uXYOCwvR7VI0WBT
         iV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeVceXH8JhpPGY+nsuPn5FDX/oiJkbwVgYYIGTA0FA0=;
        b=KtOT4RDJeAHhW5ZmrK92+x1ZZh0SxaIiSwOB38kuq+YCy7FGv3GPUSfha8LwoiIr3n
         l24VvHT/0Vry4YrlvEgLXt0bdykwfk7r8K9podvu+URZ5wSMld4EvCVZSHQom90KKimE
         tDndN7U8w3kMFdU1vYEzlk2Sm0batk3DR8BOZBxLZwPc1RZx/SGRqqYhZvoMEUuZ53NA
         XVzKItF1k1QXNtXVTaSxGi5T5XPiLHjK0fQt4MqfHW4EJpUymTDvLFOWpzz6YYrR4VRF
         gyRKe9Mgce6CUDLPP9qTjjEydsIPTY3kCVpQINKLP5Oywa2OtA4lsyOC9sJ1bsMly06q
         YvJw==
X-Gm-Message-State: ACrzQf3ufC/0P8fLkxvHE3T0jufSHWAvAmy3rq6QWWm/UK1kM07Z+UEc
        06HPGqKoRkQQCn2NHtHrx/Fr8fsV0WXdfBnlcmSI/LdU+Bs=
X-Google-Smtp-Source: AMsMyM4872AahCJlNQUBpuiMMGRF/x2c7EhPPZ4jmBaX2eQkdkTVREDnJwW7jEKHvRkqIKAlsfLmc25Lv39DsdLgXV0=
X-Received: by 2002:a67:c190:0:b0:3a7:e91:9072 with SMTP id
 h16-20020a67c190000000b003a70e919072mr15204794vsj.36.1665592117668; Wed, 12
 Oct 2022 09:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3> <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3> <CAOQ4uxj_xr4WvHNneeswZO2GEtEGgabc6r-91YR-1P+gPHPhdA@mail.gmail.com>
 <20220926152735.fgvx37rppdfhuokz@quack3> <CAOQ4uxgU4q1Pj2-9q7DZGZiw1EPZKXbc_Cp=H_Tu5_sxD6-twA@mail.gmail.com>
 <20220929100145.wruxmbwapjn6dapy@quack3> <CAOQ4uxjAn50Z03SysRT0v8AVmtvDHpFUMG6_TYCCX_L9zBD+fg@mail.gmail.com>
 <20221012154402.h5al3junehejsv24@quack3>
In-Reply-To: <20221012154402.h5al3junehejsv24@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 12 Oct 2022 19:28:25 +0300
Message-ID: <CAOQ4uxjY3eDtqXObbso1KtZTMB7+zYHBRiUANg12hO=T=vqJrw@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
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

On Wed, Oct 12, 2022 at 6:44 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Fri 07-10-22 16:58:21, Amir Goldstein wrote:
> > > > The other use case of automatic inode marks I was thinking about,
> > > > which are even more relevant for $SUBJECT is this:
> > > > When instantiating a dentry with an inode that has xattr
> > > > "security.fanotify.mask" (a.k.a. persistent inode mark), an inode
> > > > mark could be auto created and attached to a group with a special sb
> > > > mark (we can limit a single special mark per sb).
> > > > This could be implemented similar to get_acl(), where i_fsnotify_mask
> > > > is always initialized with a special value (i.e. FS_UNINITIALIZED)
> > > > which is set to either 0 or non-zero if "security.fanotify.mask" exists.
> > > >
> > > > The details of how such an API would look like are very unclear to me,
> > > > so I will try to focus on the recursive auto inode mark idea.
> > >
> > > Yeah, although initializing fanotify marks based on xattrs does not look
> > > completely crazy I can see a lot of open questions there so I think
> > > automatic inode mark idea has more chances for success at this point :).
> >
> > I realized that there is one sort of "persistent mark" who raises
> > less questions - one that only has an ignore mask.
> >
> > ignore masks can have a "static" namespace that is not bound to any
> > specific group, but rather a set of groups that join this namespace.
> >
> > I played with this idea and wrote some patches:
> > https://github.com/amir73il/linux/commits/fan_xattr_ignore_mask
>
> I have glanced over the patches. In general the idea looks OK to me but I
> have some concerns:
>
> 1) Technically, it may be challenging to call into filesystem xattr
> handling code on first event generated by the inode - that may generate
> some unexpected lock recursion for some filesystems and some events which
> trigger the initialization...

That may be a correct statement in general, but please note that
- Only permission events trigger auto-init of xattr ignore mask
- Permission events are called from security hooks
- Security hooks may also call getxattr to get the security context

Perhaps LSMs always initialize the security context in OPEN and
never in ACCESS?

One of the earlier versions of the patch initialized xattr ignore mask
on LOOKUP permission event, if ANY object was interested in ANY
permission event even if no object was interested in LOOKUP
to mimic the LSM context initialization,
but it was complicated and I wasn't sure if this was necessary.

Maybe that is the way to go...

>
> 2) What if you set the xattr while the group is already listening to
> events? Currently the change will get ignored, won't it? But I guess this
> could be handled by clearing the "cached" flag when the xattr is set.
>

I have created an API to update the xattr via
  fanotify_mark(FAN_MARK_XATTR, ...
which updates the cached ignore mask in the connector.

I see no reason to support "direct" modifications of this xattr.
If such changes are made directly it is fine to ignore them.

> 3) What if multiple applications want to use the persistent mark
> functionality? I think we need some way to associate a particular
> fanotify group with a particular subset of fanotify xattrs so that
> coexistence of multiple applications is possible...
>

Yeh, I thought about this as well.
The API in the patches is quite naive because it implements a single
global namespace for xattr ignore masks, but mostly I wanted to
see if I can get the fast path and auto-init implementation done.

I was generally thinking of ioctl() as the API to join an xattr marks
namespace and negotiate the on-disk format of persistent marks
supported by the application.

I would not want to allow multiple fanotify xattrs per inode -
that could have the consequence of the inode becoming a junkyard.

I'd prefer to have a single xattr (say security.fanotify.mark)
and that mark will have
- on-disk format version
- namespace id
- ignore mask
- etc

If multiple applications want to use persistent marks they need to figure
out how to work together without stepping on each other's toes.
I don't think it is up to fanotify to coordinate that.

fanotify_mark() can fail with EEXIST when a group that joined namespace A
is trying to update a persistent mark when a persistent mark of namespace B
already exists and probably some FAN_MARK_REPLACE flag could be used
to force overwrite the existing persistent mark.

Do you agree?

Thanks,
Amir.
