Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8D44F25D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Nov 2021 10:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhKMJxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Nov 2021 04:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbhKMJxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Nov 2021 04:53:02 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44262C061766;
        Sat, 13 Nov 2021 01:50:10 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id j28so11414866ila.1;
        Sat, 13 Nov 2021 01:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0M6QSfsSS/oM2rDeS98+cxW334FWJdvg+b/xRTy3W2s=;
        b=ayJc+qZ6BMXGbJP4bdrgq0SC6ETERr/TMCXnY8wIlRTURo0ajiVi6jvunoZZJjG1M6
         kO7cfg3w/+VA+mV7h0pcXnz6zRlxHRX+9V6bXmxcC2ImLkkeslHkvayKMvG33evCOxhP
         Plbc4w/LI36kYk46v/vNKC8SCSokcbEKT8PgoMvsdEwTdskZuzHtFulz/W+6FH7mTCDR
         t4Y9LyBIrANRjiAuFfWyLcxLBrjzjCE9QjxhxPeQc1GdIB4qOKYK8i1+/QpSTPtHqCsz
         D/KBZ03aJL7fk/mK0NiAlzh79lE4hGot8ecFPBYwvJloUAXMTviAVKk3jO0+uUzWAs8O
         y55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0M6QSfsSS/oM2rDeS98+cxW334FWJdvg+b/xRTy3W2s=;
        b=bQzXGraL5SzRjtjd742oZyJCRntAbRgNyP9PQoNA7vL67a/r9DH73jhOqdJ+BzNigg
         m5OEY3fZ5JPl50mQ5ltX8rNGEOo5T29M+eA5G7PEywcAV/xBEXEkqTUqndZBldOSxv7D
         ZIYdZ5EulczfdQXvZgfXtl/N+PlXDruo9DHxTwr76Jw7OLFMs94tqhW+edBHJIcNTKWd
         Y9/orJeOvgjVUa6w9cmGCcdRdbF/8CCAWYHSFGVMrc9AZPPbtLkCPN6fH4ARr+okHjy7
         l63gMcCs1oe2yyrGnOWIFYfJTZYJG0K/OP60dSESZKbLFn2lVIgVrD8OiMZ6OrV8OrA4
         l3PQ==
X-Gm-Message-State: AOAM533kESdP75d+uVhucDrJ7cnDK/4DuiEgyDHPiUQSmARA4wgpV1SS
        IBAVMau9ouQH6oxSXOjJD7yFcPjB3HY8Ifr+1Gw=
X-Google-Smtp-Source: ABdhPJxc7vH0jexd54dpvoi9/wVTZnMvLw+4TJuCOuiMoy7uHV/a9x+q4MABVbhadKTYHBC798a+8nbsaq0lXEOQjSc=
X-Received: by 2002:a05:6e02:19ca:: with SMTP id r10mr13591941ill.319.1636797009646;
 Sat, 13 Nov 2021 01:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20211029114028.569755-1-amir73il@gmail.com> <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
 <20211112163955.GA30295@quack2.suse.cz>
In-Reply-To: <20211112163955.GA30295@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 13 Nov 2021 11:49:58 +0200
Message-ID: <CAOQ4uxgT5a7UFUrb5LCcXo77Uda4t5c+1rw+BFDfTAx8szp+HQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 12, 2021 at 6:39 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Sat 06-11-21 18:29:39, Amir Goldstein wrote:
> > On Fri, Oct 29, 2021 at 2:40 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > This patch set follows up on the discussion on FAN_REPORT_TARGET_FID [1]
> > > from 3 months ago.
> > >
> > > With FAN_REPORT_PIDFD in 5.15 and FAN_FS_ERROR on its way to 5.16,
> > > I figured we could get an early (re)start of the discussion on
> > > FAN_REPORT_TARGET_FID towards 5.17.
> > >
> > > The added information in dirent events solves problems for my use case -
> > > It helps getting the following information in a race free manner:
> > > 1. fid of a created directory on mkdir
> > > 2. from/to path information on rename of non-dir
> > >
> > > I realize those are two different API traits, but they are close enough
> > > so I preferred not to clutter the REPORT flags space any further than it
> > > already is. The single added flag FAN_REPORT_TARGET_FID adds:
> > > 1. child fid info to CREATE/DELETE/MOVED_* events
> > > 2. new parent+name info to MOVED_FROM event
> > >
> > > Instead of going the "inotify way" and trying to join the MOVED_FROM/
> > > MOVED_TO events using a cookie, I chose to incorporate the new
> > > parent+name intomation only in the MOVED_FROM event.
> > > I made this choice for several reasons:
> > > 1. Availability of the moved dentry in the hook and event data
> > > 2. First info record is the old parent+name, like FAN_REPORT_DFID_NAME
> > > 3. Unlike, MOVED_TO, MOVED_FROM was useless for applications that use
> > >    DFID_NAME info to statat(2) the object as we suggested
> > >
> > > I chose to reduce testing complexity and require all other FID
> > > flags with FAN_REPORT_TARGET_FID and there is a convenience
> > > macro FAN_REPORT_ALL_FIDS that application can use.
> >
> > Self comment - Don't use ALL_ for macro names in uapi...
> > There are 3 comment of "Deprecated ..."  for ALL flags in fanotify.h alone...
>
> Yeah, probably the ALL_FIDS is not worth the possible confusion when we add
> another FID flag later ;)
>
> > BTW, I did not mention the FAN_RENAME event alternative proposal in this posting
> > not because I object to FAN_RENAME, just because it was simpler to implement
> > the MOVED_FROM alternative, so I thought I'll start with this proposal
> > and see how
> > it goes.
>
> I've read through all the patches and I didn't find anything wrong.
> Thinking about FAN_RENAME proposal - essentially fsnotify_move() would call
> fsnotify_name() once more with FS_RENAME event and we'd gate addition of
> second dir+name info just by FS_RENAME instead of FS_MOVED_FROM &&
> FAN_REPORT_TARGET_FID. Otherwise everything would be the same as in the
> current patch set, wouldn't it? IMHO it looks like a bit cleaner API so I'd
> lean a bit more towards that.

I grew to like FAN_RENAME better myself as well.
To make sure we are talking about the same thing:
1. FAN_RENAME always reports 2*(dirfid+name)
2. FAN_REPORT_TARGET_FID adds optional child fid record to
    CREATE/DELETE/RENAME/MOVED_TO/FROM

Thanks,
Amir.
