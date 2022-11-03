Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318C6617E09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiKCNiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 09:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiKCNiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:38:51 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A581C44
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 06:38:50 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id q127so1888833vsa.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=INsunqQpE5URsyhPqjf1htWq3wFvpqBO4IGEXif+fbU=;
        b=Rhkh8Bf8hRCvmgM0X2I1jqo0ySFte57cfkdn1brgi9CkLSMIrOjo0aydb99rd/0Mbl
         N1h9CZpNXbbvgOO9qbd+msc9cbz/24qd36KPrVekvG81Pqitw+nWFuIMYfcbqSoomDvy
         jgOrwnkm0sbkWTxuwwN0G5WlAfTGix7GtPv+El+2ahpYxXvBi/t1X8Nwz5aQAwwJ0vrF
         BWZOVWEOfkcI5iC6+buwfatsFZpoqxTj9Nwfe0WxeAroEmV98YQxfcZM2wEqzr2UsKwC
         RFBAjr3bqQ/cf3yvYMJJpV5AX/pnJq70h0+WjeGVQk5H+jozSzUxNuEAzmTjUDbTKXgz
         vPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INsunqQpE5URsyhPqjf1htWq3wFvpqBO4IGEXif+fbU=;
        b=o7K7XshJ2xjKHJwG0QoQDh5POeBjNPRlKRZo0GFMj83glFJBtgG0YOM2hrOBLxDLDQ
         dlZ+40r92AZaiV0VUYCLQLXIDhwPqRhHbtDQy9lXZLiYwi+QiiXAeFbbucsdj+SkUQjl
         IycQlhkITFnqJyCEFeOg8jmYBfa8Ov9H5NtLLZnTiG0geE78L3pHTtFtXFbzt3HImMKI
         GCBqivIAENfBOcGJLQi1puHFcf1sLg9og/x7BgNccEEpN+vWTP+MvAvy6VshLgRugghw
         YHZhGm8uYATnqAQigISE8SL3JxWwUSO7TfYpGhXaL4liRK3lWm+T/+sAIML6ejIOo6u0
         FZng==
X-Gm-Message-State: ACrzQf21kZyBNIjvf7qqWQzXOvCOLNF4vkHhG9NCr+5z/VlpFh3fWMu7
        vz1+3K4t3d54F96oMHAF5hImKMoKIyL4NV3n1wCLnM1ebnk=
X-Google-Smtp-Source: AMsMyM7tohq3bvTbTyZ/osyEbV4SWUfciATdZzdud6xf1cUVOj/iAQ9b1weyBp0msAPs2tNxSSgDBDeVaeG9h9DDwYk=
X-Received: by 2002:a67:c08d:0:b0:3ac:d0e5:719a with SMTP id
 x13-20020a67c08d000000b003acd0e5719amr13658453vsi.3.1667482729192; Thu, 03
 Nov 2022 06:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3> <CAOQ4uxj_xr4WvHNneeswZO2GEtEGgabc6r-91YR-1P+gPHPhdA@mail.gmail.com>
 <20220926152735.fgvx37rppdfhuokz@quack3> <CAOQ4uxgU4q1Pj2-9q7DZGZiw1EPZKXbc_Cp=H_Tu5_sxD6-twA@mail.gmail.com>
 <20220929100145.wruxmbwapjn6dapy@quack3> <CAOQ4uxjAn50Z03SysRT0v8AVmtvDHpFUMG6_TYCCX_L9zBD+fg@mail.gmail.com>
 <20221012154402.h5al3junehejsv24@quack3> <CAOQ4uxjY3eDtqXObbso1KtZTMB7+zYHBRiUANg12hO=T=vqJrw@mail.gmail.com>
 <CAOQ4uxi7Y_W+-+TiveYWixk4vYauSQuNAfFFZyEAVPUehT_Gaw@mail.gmail.com> <20221103125748.474y4l3vf2h62mot@quack3>
In-Reply-To: <20221103125748.474y4l3vf2h62mot@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 3 Nov 2022 15:38:35 +0200
Message-ID: <CAOQ4uxgKwjKbH_qbzpWzzMq8bktn+DeV1OZNtrxa6jaBPSMHsg@mail.gmail.com>
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

On Thu, Nov 3, 2022 at 2:57 PM Jan Kara <jack@suse.cz> wrote:
>
> I'm sorry for the really delayed response. We had an internal conference
> and some stuff around that which made me busy.
>

No problem at all.
There is a lot to process in this thread.
My follow up email about avoiding TOCTOU is worse...
I am happy for whatever feedback you can provide me when you have the time.

> On Thu 13-10-22 15:16:25, Amir Goldstein wrote:
> > On Wed, Oct 12, 2022 at 7:28 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Wed, Oct 12, 2022 at 6:44 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > Hi Amir!
> > > >
> > > > On Fri 07-10-22 16:58:21, Amir Goldstein wrote:
> > > > > > > The other use case of automatic inode marks I was thinking about,
> > > > > > > which are even more relevant for $SUBJECT is this:
> > > > > > > When instantiating a dentry with an inode that has xattr
> > > > > > > "security.fanotify.mask" (a.k.a. persistent inode mark), an inode
> > > > > > > mark could be auto created and attached to a group with a special sb
> > > > > > > mark (we can limit a single special mark per sb).
> > > > > > > This could be implemented similar to get_acl(), where i_fsnotify_mask
> > > > > > > is always initialized with a special value (i.e. FS_UNINITIALIZED)
> > > > > > > which is set to either 0 or non-zero if "security.fanotify.mask" exists.
> > > > > > >
> > > > > > > The details of how such an API would look like are very unclear to me,
> > > > > > > so I will try to focus on the recursive auto inode mark idea.
> > > > > >
> > > > > > Yeah, although initializing fanotify marks based on xattrs does not look
> > > > > > completely crazy I can see a lot of open questions there so I think
> > > > > > automatic inode mark idea has more chances for success at this point :).
> > > > >
> > > > > I realized that there is one sort of "persistent mark" who raises
> > > > > less questions - one that only has an ignore mask.
> > > > >
> > > > > ignore masks can have a "static" namespace that is not bound to any
> > > > > specific group, but rather a set of groups that join this namespace.
> > > > >
> > > > > I played with this idea and wrote some patches:
> > > > > https://github.com/amir73il/linux/commits/fan_xattr_ignore_mask
> > > >
> > > > I have glanced over the patches. In general the idea looks OK to me but I
> > > > have some concerns:
> > > >
> > > > 1) Technically, it may be challenging to call into filesystem xattr
> > > > handling code on first event generated by the inode - that may generate
> > > > some unexpected lock recursion for some filesystems and some events which
> > > > trigger the initialization...
> > >
> > > That may be a correct statement in general, but please note that
> > > - Only permission events trigger auto-init of xattr ignore mask
> > > - Permission events are called from security hooks
> > > - Security hooks may also call getxattr to get the security context
> > >
> > > Perhaps LSMs always initialize the security context in OPEN and
> > > never in ACCESS?
> > >
> > > One of the earlier versions of the patch initialized xattr ignore mask
> > > on LOOKUP permission event, if ANY object was interested in ANY
> > > permission event even if no object was interested in LOOKUP
> > > to mimic the LSM context initialization,
> > > but it was complicated and I wasn't sure if this was necessary.
> > >
> >
> > Also, permission events can sleep by definition
> > so why would getxattr not be safe in the
> > context of permission events handling?
>
> Well, I'm not afraid of sleeping. I was more worried about lock ordering
> issues. But are right that this probably isn't going to be an issue.
>
> > > > 2) What if you set the xattr while the group is already listening to
> > > > events? Currently the change will get ignored, won't it? But I guess this
> > > > could be handled by clearing the "cached" flag when the xattr is set.
> > > >
> > >
> > > I have created an API to update the xattr via
> > >   fanotify_mark(FAN_MARK_XATTR, ...
> > > which updates the cached ignore mask in the connector.
> > >
> > > I see no reason to support "direct" modifications of this xattr.
> > > If such changes are made directly it is fine to ignore them.
> > >
> > > > 3) What if multiple applications want to use the persistent mark
> > > > functionality? I think we need some way to associate a particular
> > > > fanotify group with a particular subset of fanotify xattrs so that
> > > > coexistence of multiple applications is possible...
> > > >
> > >
> > > Yeh, I thought about this as well.
> > > The API in the patches is quite naive because it implements a single
> > > global namespace for xattr ignore masks, but mostly I wanted to
> > > see if I can get the fast path and auto-init implementation done.
> > >
> > > I was generally thinking of ioctl() as the API to join an xattr marks
> > > namespace and negotiate the on-disk format of persistent marks
> > > supported by the application.
> > >
> > > I would not want to allow multiple fanotify xattrs per inode -
> > > that could have the consequence of the inode becoming a junkyard.
> > >
> > > I'd prefer to have a single xattr (say security.fanotify.mark)
> > > and that mark will have
> > > - on-disk format version
> > > - namespace id
> > > - ignore mask
> > > - etc
> > >
> > > If multiple applications want to use persistent marks they need to figure
> > > out how to work together without stepping on each other's toes.
> > > I don't think it is up to fanotify to coordinate that.
>
> I'm not sure if this really scales. Imagine you have your say backup
> application that wants to use persistent marks and then you have your HSM
> application wanting to do the same. Or you have some daemon caching
> preparsed contents of config/ directory and watching whether it needs to
> rescan the dir and rebuild the cache using persistent marks (I'm hearing
> requests like these for persistent marks from desktop people for many
> years). How exactly are these going to coordinate?
>
> I fully understand your concern about the clutter in inode xattrs but if
> we're going to limit the kernel to support only one persistent marks user,
> then IMO we also need to provide a userspace counterpart (in the form of
> some service or library like persistent change notification journal) that
> will handle the coordination. Because otherwise it will become a mess
> rather quickly.
>

The concept of singleton userspace services exists, but getting their
UAPI right is a challenge.
We can draw inspiration from Windows, which is decades a head of
Linux w.r.t persistent fs notifications:
https://learn.microsoft.com/en-us/windows/win32/cfapi/build-a-cloud-file-sync-engine

IIUC, the UAPI allows a single CloudSync engine to register per fs (or
subtree root)
to get the callbacks from a file with the persistent marks (called
reparse points)
in the "Windows.Storage.Provider" namespace.

IOW, you may have OneDrive content provider or GoogleDrive content provider
serving the persistent marks on a specific directory, never both.

But Windows does support different namespaces for reparse points,
so it's an example for both sides of our arguments.

> > > fanotify_mark() can fail with EEXIST when a group that joined namespace A
> > > is trying to update a persistent mark when a persistent mark of namespace B
> > > already exists and probably some FAN_MARK_REPLACE flag could be used
> > > to force overwrite the existing persistent mark.
> >
> > One thing that I feel a bit silly about is something that I only fully
> > noticed after writing this WIP wiki entry:
> > https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#persistent-inode-marks
> >
> > Persistent marks (in xattr) with ignore mask are useful, but only a
> > little bit more useful than Evictable marks with ignore mask.
> >
> > Persistent marks (in xattr) with a "positive" event mask are the real deal.
> > Because with "positive" persistent marks, we will be able to optimize away
> > srcu_read_lock() and marks iteration for the majority of fsnotify hooks
> > by looking at objects interest masks (including the FS_XATTR_CACHED bit).
> >
> > The good thing about the POC patches [1] is that there is no technical
> > limitation in this code for using persistent marks with positive event
> > masks.  It is a bit more challenging to document the fact that a "normal"
> > fs/mount mark is needed in order to "activate" the persistent marks in
> > the inodes of this fs/mount, but the changes to the code to support that
> > would be minimal.
>
> I agree persistent positive marks are very interesting (in fact I've heard
> requests for functionality like this about 15 years ago :)). But if you'd
> like to use them e.g. for backup or HSM then you need to somehow make sure
> you didn't miss any events before you created the activation mark? That
> looks like a bit unpleasant race with possible data (backup) corruption
> consequences?
>

Yeh, positive persistent marks is quite futuristic at this point.
My POC will stick to mount mark and inode ignore marks, where these
races are rather easy to avoid using FAN_MARK_SYNC (see next email).

Anyway, I have made a decision to aim for an initial HSM UAPI implementation
with evictable ignore marks (without persistent marks) because evictable marks
are functionally sufficient and persistent marks have too many UAPI
open questions.

I've modified the POC code to work to try persistent ignore marks
and fall back to evictable ignore marks, which incur a few extra userspace
callbacks after service restart or after drop caches.

Thanks,
Amir.
