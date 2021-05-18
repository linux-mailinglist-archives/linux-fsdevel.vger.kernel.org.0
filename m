Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88D387D0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350214AbhERQD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 12:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344303AbhERQD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 12:03:57 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4EDC061573
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 09:02:39 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d11so9928105iod.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUFwm2Xz16PCMO37kpdkB0wFOZas6xPlFUJQPIeqSTc=;
        b=bi764Y3WExCOJj2llYjy4XGKKMJ1alNtq1TN79s+01usvBsdfEDp5ir+CSKWbfeucQ
         08PcH8O/CVvCSEjaB3MD4obgcRaGb0i/4tH0aOw7itQM8JfU3+VgsQt5A/Zrvp1/AKoC
         pqNsp5MFJO/1sg0eGtU++SRVsbmDTbun/yY9j+Bqjf5sSjlIQ4aWoao6scRSAJUcbke2
         Ep5wiCwb6r+qgHtgeu3GBajvuPq9Rm7aM7h+EkoKxapVDq2En3mEX42ZZhNJlvjfPtRi
         vG/uCKsBFTYbFWVsmcp737NLtHK4Yn88NOPUKNQ8rM+8i8s7uyyP+ulPYdxDl9FS3V8w
         xVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUFwm2Xz16PCMO37kpdkB0wFOZas6xPlFUJQPIeqSTc=;
        b=BBshYmwJjTxbB6hiWcVDFIaa/Jr5chc2kLD6+TBdccfhue7l1YUopsmXzvdDr1g1wK
         ZhsXVlVW2OQNeljUuPTP/aR0Un5TnCw37GQ/ifSB30c95iTRp21yU/O1/E0DPrCWHIIV
         g6zH4Xzlszo5vh4Jy4fspM/JWfZyR/zAKD99+PTufWKOEwwzdgF1nxU7LMBgiWsK3Tox
         tKxy7bVgIgtGDWfbHQdpmU7+e7oYpJf8UHS3lmUQViCboBC2oq/tcwnN1VAafZUqFKps
         fY+q3UR5omGeplOXeq19Zep9Y/NM/5Rro9ENL61tVk25xH/K44rG66jzpbh3lYzc79bX
         k1Og==
X-Gm-Message-State: AOAM532k2sM5FQSWr8oYzO8cTVOidU3DAtirWl6VvXtGXCULQJ++EsWQ
        1YtFefUKQ7Lv9z9jRCDjn5o75V+3teaGbuyWUIP3j74a
X-Google-Smtp-Source: ABdhPJyIDXt/cJAqV0mOwkWKbbz2vKvZ7NeBYQPenpYtpJpRd/QfI6bPVAR6II9cKFNdfbX7npL0tfMwNP+I6dFQJ/s=
X-Received: by 2002:a05:6638:3445:: with SMTP id q5mr6466548jav.120.1621353759171;
 Tue, 18 May 2021 09:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210503165315.GE2994@quack2.suse.cz> <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz> <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz> <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
 <20210512152625.i72ct7tbmojhuoyn@wittgenstein> <20210513105526.GG2734@quack2.suse.cz>
 <20210514135632.d53v3pwrh56pnc4d@wittgenstein> <CAOQ4uxgngZjBseOC_qYtxjZ_J4Rc50_Y7G+CSSpJznKBXvSU5A@mail.gmail.com>
 <20210518101135.jrldavggoibfpjhs@wittgenstein>
In-Reply-To: <20210518101135.jrldavggoibfpjhs@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 May 2021 19:02:28 +0300
Message-ID: <CAOQ4uxh09LqGOiTE-RgDfEwyXeK=bMn6LXr0W+Chp4rD5LZhRA@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > > > 2. data sharing among containers or among the host and containers etc.
> > > > > The most common use-case is to share data from the host with the
> > > > > container such as a download folder or the Linux folder on ChromeOS.
> > > > > Most container managers will simly re-use the container's userns for
> > > > > that too. More complex cases arise where data is shared between
> > > > > containers with different idmappings then often a separate userns will
> > > > > have to be used.
> > > >
> > > > OK, but if say on ChromeOS you copy something to the Linux folder by app A
> > > > (say file manager) and containerized app B (say browser) watches that mount
> > >
> > > For ChromeOS it is currently somewhat simple since they currently only
> > > allow a single container by default. So everytime you start an app in
> > > the container it's the same app so they all write to the Linux Files
> > > folder through the same container. (I'm glossing over a range of details
> > > but that's not really relevant to the general spirit of the example.).
> > >
> > >
> > > > for changes with idmap-filtered mark, then it won't see notification for
> > > > those changes because A presumably runs in a different namespace than B, am
> > > > I imagining this right? So mark which filters events based on namespace of
> > > > the originating process won't be usable for such usecase AFAICT.
> > >
> > > Idmap filtered marks won't cover that use-case as envisioned now. Though
> > > I'm not sure they really need to as the semantics are related to mount
> > > marks.
> >
> > We really need to refer to those as filesystem marks. They are definitely
> > NOT mount marks. We are trying to design a better API that will not share
> > as many flaws with mount marks...
> >
> > > A mount mark would allow you to receive events based on the
> > > originating mount. If two mounts A and B are separate but expose the
> > > same files you wouldn't see events caused by B if you're watching A.
> > > Similarly you would only see events from mounts that have been delegated
> > > to you through the idmapped userns. I find this acceptable especially if
> > > clearly documented.
> > >
> >
> > The way I see it, we should delegate all the decisions over to userspace,
> > but I agree that the current "simple" proposal may not provide a good
> > enough answer to the case of a subtree that is shared with the host.
>
> I was focussed on what happens if you set an idmapped filtered mark for
> a container for a set of files that is exposed to another container via
> another idmapped mount. And it seemed to me that it was ok if the
> container A doesn't see events from container B.
>
> You seem to be looking at this from the host's perspective right now
> which is interesting as well.
>
> >
> > IMO, it should be a container manager decision whether changes done by
> > the host are:
> > a) Not visible to containerized application
>
> Yes, that seems ok.
>
> > b) Watched in host via recursive inode watches
> > c) Watched in host by filesystem mark filtered in userspace
> > d) Watched in host by an "noop" idmapped mount in host, through
> >      which all relevant apps in host access the shared folder
>
> So b)-d) are concerned with the host getting notifcations for changes
> done from any container that uses a given set of files possibly through
> different mounts.
>

My perception was that container manager knows about all the idmapped
mounts that share the same folder, so when container A requests to watch
the shared folder, container manager sets idmapped marks on *all* the
idmapped mounts and when a new container is started which also maps
the shared folder, idmapped marks are added to *all* the fanotify groups
that the container manager currently maintains, which are interested in the
shared folder.

With (d) this can still be the model.
With (c) it still makes sense to save filtering cycles in userspace in case
events originate inside containers.
With (b) there doesn't seem to be any need for the idmapped filtered marks
at all.

Thanks,
Amir.
