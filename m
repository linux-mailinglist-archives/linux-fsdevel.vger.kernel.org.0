Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8F40F5D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 12:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbhIQKYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 06:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242513AbhIQKYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:24:41 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61EEC061574;
        Fri, 17 Sep 2021 03:23:19 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y18so11624137ioc.1;
        Fri, 17 Sep 2021 03:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5I8500HOfJqf+DHPfMAaFXDmAkB73OxLlGzUcUBNbuc=;
        b=ByYtUEl1WYBhq6zB++Cd54KeJCa4AUB0r9hGqeJZ7EhgXXQdwInudDgDUK4mfdzm5E
         m8bMF1/Pe35Tt+FuHGCFBiKyo86V6AXQDLNYcp6coYnpevfsMGFQwQaxvQYoKNuI3jug
         Iv91N/Zz/ks3Es6ausNVzudbRmFnBeGPZVKZ6BeE8ObPlUDltIcCE/B1jgDP+LlUlQ3p
         rbHDQtfEuFfWwXs5Jd7xYPaQCteKN2OJJTZwcoldNRRhRR1ziXgrCWv9tRHR8PKFPUu7
         eWr4On707UoOuhzkEVokRm0ICfmFjXGazw66ABaFHUPcPQ4OdUGA8+PyZN0j7Y3+cXnk
         GqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5I8500HOfJqf+DHPfMAaFXDmAkB73OxLlGzUcUBNbuc=;
        b=D+DJzgSVFYZZ8o5yjEbQVQUE6vM1pp9TI0upWAn8IExim8pdelGHxXSDSkxAr7QrmZ
         4oNLux3sS37X3xTmK3VtZIR3zPV/FyVxd8ebNfb12r+V22EZThFxaCb5YUZLnooW+sht
         93W5XdMKgmFvtv9gFivq1SwngtqViAvvuaLl3gbzEztD0YMMhyYYS5lWFRGGZz6zr9Aq
         bPUZWhxGx+MNFjwA9ipMHlNIepgYxRe0QDENt0wRKxpfqrzfbUMuBIE4L//k4wRVvKZ0
         Z0UG6/l5LFIIWz/2xI3LmQ25lHhg1Lb3/VLECsdfYmGy2ja2vY1z5pBioM0befHlfEPF
         RDZQ==
X-Gm-Message-State: AOAM532Orsoo1bvnpM+Nru7G0nnZZlKV+Z6NSmsafebt7uIMNK2/ROQR
        LW8iqzWhJLSHnfsTLNismSL035Djl1LOZHyfvro=
X-Google-Smtp-Source: ABdhPJxLL9zUfQkSkZTQYnjTJGmrSzuaxOJ6qcfrFEl3P1HyMYA9URTqrHImGmokgpB/fHOUJ9HwT+uHHHAjpcwymbc=
X-Received: by 2002:a5e:dc02:: with SMTP id b2mr8058153iok.197.1631874199220;
 Fri, 17 Sep 2021 03:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210916013916.GD34899@magnolia> <20210917083043.GA6547@quack2.suse.cz>
 <20210917083608.GB6547@quack2.suse.cz> <20210917093838.GC6547@quack2.suse.cz>
In-Reply-To: <20210917093838.GC6547@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 17 Sep 2021 13:23:08 +0300
Message-ID: <CAOQ4uxg3FYuQ3hrhG5H87Uzd-2gYXbFfUkeTPY7ESsDdjGB5EQ@mail.gmail.com>
Subject: Re: Shameless plug for the FS Track at LPC next week!
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:38 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 17-09-21 10:36:08, Jan Kara wrote:
> > Let me also post Amir's thoughts on this from a private thread:
>
> And now I'm actually replying to Amir :-p
>
> > On Fri 17-09-21 10:30:43, Jan Kara wrote:
> > > We did a small update to the schedule:
> > >
> > > > Christian Brauner will run the second session, discussing what idmapped
> > > > filesystem mounts are for and the current status of supporting more
> > > > filesystems.
> > >
> > > We have extended this session as we'd like to discuss and get some feedback
> > > from users about project quotas and project ids:
> > >
> > > Project quotas were originally mostly a collaborative feature and later got
> > > used by some container runtimes to implement limitation of used space on a
> > > filesystem shared by multiple containers. As a result current semantics of
> > > project quotas are somewhat surprising and handling of project ids is not
> > > consistent among filesystems. The main two contending points are:
> > >
> > > 1) Currently the inode owner can set project id of the inode to any
> > > arbitrary number if he is in init_user_ns. It cannot change project id at
> > > all in other user namespaces.
> > >
> > > 2) Should project IDs be mapped in user namespaces or not? User namespace
> > > code does implement the mapping, VFS quota code maps project ids when using
> > > them. However e.g. XFS does not map project IDs in its calls setting them
> > > in the inode. Among other things this results in some funny errors if you
> > > set project ID to (unsigned)-1.
> > >
> > > In the session we'd like to get feedback how project quotas / ids get used
> > > / could be used so that we can define the common semantics and make the
> > > code consistently follow these rules.
> >
> > I think that legacy projid semantics might not be a perfect fit for
> > container isolation requirements. I added project quota support to docker
> > at the time because it was handy and it did the job of limiting and
> > querying disk usage of containers with an overlayfs storage driver.
> >
> > With btrfs storage driver, subvolumes are used to create that isolation.
> > The TREE_ID proposal [1] got me thinking that it is not so hard to
> > implement "tree id" as an extention or in addition to project id.
> >
> > The semantics of "tree id" would be:
> > 1. tree id is a quota entity accounting inodes and blocks
> > 2. tree id can be changed only on an empty directory
> > 3. tree id can be set to TID only if quota inode usage of TID is 0
> > 4. tree id is always inherited from parent
> > 5. No rename() or link() across tree id (clone should be possible)
> >
> > AFAIK btrfs subvol meets all the requirements of "tree id".
> >
> > Implementing tree id in ext4/xfs could be done by adding a new field to
> > inode on-disk format and a new quota entity to quota on-disk format and
> > quotatools.
> >
> > An alternative simpler way is to repurpose project id and project quota:
> > * Add filesystem feature projid-is-treeid
> > * The feature can be enabled on fresh mkfs or after fsck verifies "tree id"
> >    rules are followed for all usage of projid
> > * Once the feature is enabled, filesystem enforces the new semantics
> >   about setting projid and projid_inherit
> >
> > This might be a good option if there is little intersection between
> > systems that need to use the old project semantics and systems
> > that would rather have the tree id semantics.
>
> Yes, I actually think that having both tree-id and project-id on a
> filesystem would be too confusing. And I'm not aware of realistic usecases.
> I've heard only of people wanting current semantics (although these we more
> of the kind: "sometime in the past people used the feature like this") and
> the people complaining current semantics is not useful for them. This was
> discussed e.g. in ext4 list [2].
>
> > I think that with the "tree id" semantics, the user_ns/idmapped
> > questions become easier to answer.
> > Allocating tree id ranges per userns to avoid exhausting the tree id
> > namespace is a very similar problem to allocating uids per userns.
>
> It still depends how exactly tree ids get used - if you want to use them to
> limit space usage of a container, you still have to forbid changing of tree
> ids inside the container, don't you?
>

Yes.
This is where my view of userns becomes hazy (so pulling Christain into
the discussion), but in general I think that this use case would be similar
to the concept of single uid container - the range of allowed tree ids that
is allocated for the container in that case is a single tree id.

I understand that the next question would be about nesting subtree quotas
and I don't have a good answer to that question.

Are btrfs subvolume nested w.r.t. capacity limit? I don't think that they are.

Thanks,
Amir.
