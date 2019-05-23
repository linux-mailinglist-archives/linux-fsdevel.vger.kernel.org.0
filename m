Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE05227A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 12:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfEWKZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 06:25:21 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44829 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfEWKZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 06:25:21 -0400
Received: by mail-yw1-f66.google.com with SMTP id e74so2055017ywe.11;
        Thu, 23 May 2019 03:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NNHjqxy4cA1iR7igWdvYkQtAM2DdUoWQ0xcNKGlcUE=;
        b=uZJ1ml/SqGhO6uZamvp643xn91paeHnqdxomJBvL9LrsYcy8HSgeAjB/fF6RfDeAKw
         suZdXa7S2gd3yDtpE57xSS+ijPDHrJ5fiyz2PTg6IJI5MaViKze6osc2qKSDcTnFvFSJ
         4/c62F8cPWHSY+JakXytNEFIvinZTDg75pTKNjZM+AMRdEPLl/03j44a1i8UV1CUU8xU
         7nSEOqP3oWadaUwlRLXAjl2TTf1v6GaHm1KdFPEsRZ2Teo6f2Z2oV2uK1QM+TRgqTKO6
         O1KkRhDgbnp1oQzd1h8J/L1F9bSk5O8iOo1b9AkYBGUexnd42PUu87SD8cGvbdeIs7qT
         I1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NNHjqxy4cA1iR7igWdvYkQtAM2DdUoWQ0xcNKGlcUE=;
        b=AcGtL7x2ObQo3yF21KZ+clORQUY0BPExei6NvKBeFWUFexAzlDcLnmboKAzxSU4+GZ
         dI/wMjYkIS6rkVf5ZmnP92NQ6y0WZBF7WjrQUtFGxkag2SAm8dOq1CGa/s95J/sO7H6v
         84vNIqpJdylOd/8byspGZHqsP0sTxPkiQBhmMgySZpJP4+nLYQs4kG9gUQQGIfPdW0cf
         YBgx28Sb5OXYNIeyAjiMaWggwhk2KA2yST9j8LX79LBvYkIRsmJa706MBgzN0UT6HS6A
         igy0uVgngJ1xBXB999FvEKFKSktU9ukjUejiffzTg88U4WXFCeNrDY2tpKEwEsXCKgOH
         A9sg==
X-Gm-Message-State: APjAAAWirfEIa7n0nt2sfPST1e/CwKpsHX4RGNMGVaGMPMU0/79Hqe3m
        +dfEik3tsIUeSm9AIvHHvTmbZmlX1c563TAKd8U=
X-Google-Smtp-Source: APXvYqw7w14u3jrVFRwPHVUPg848bC02eoNql2Zpmdzv1MBhrwImOVrrYWjfI+Bfq7H2/0t3f+tF/JPZHbDa8SJnPy8=
X-Received: by 2002:a81:4f06:: with SMTP id d6mr30466460ywb.379.1558607120083;
 Thu, 23 May 2019 03:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190522163150.16849-1-christian@brauner.io> <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
 <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io> <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
 <20190523095506.nyei5nogvv63lm4a@brauner.io>
In-Reply-To: <20190523095506.nyei5nogvv63lm4a@brauner.io>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 23 May 2019 13:25:08 +0300
Message-ID: <CAOQ4uxiBeAzsE+b=tE7+9=25-qS7ohuTdEswYOt8DrCp6eAMuw@mail.gmail.com>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
To:     Christian Brauner <christian@brauner.io>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 12:55 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Wed, May 22, 2019 at 11:00:22PM +0300, Amir Goldstein wrote:
> > On Wed, May 22, 2019 at 9:57 PM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > On May 22, 2019 8:29:37 PM GMT+02:00, Amir Goldstein <amir73il@gmail.com> wrote:
> > > >On Wed, May 22, 2019 at 7:32 PM Christian Brauner
> > > ><christian@brauner.io> wrote:
> > > >>
> > > >> This removes two redundant capable(CAP_SYS_ADMIN) checks from
> > > >> fanotify_init().
> > > >> fanotify_init() guards the whole syscall with capable(CAP_SYS_ADMIN)
> > > >at the
> > > >> beginning. So the other two capable(CAP_SYS_ADMIN) checks are not
> > > >needed.
> > > >
> > > >It's intentional:
> > > >
> > > >commit e7099d8a5a34d2876908a9fab4952dabdcfc5909
> > > >Author: Eric Paris <eparis@redhat.com>
> > > >Date:   Thu Oct 28 17:21:57 2010 -0400
> > > >
> > > >    fanotify: limit the number of marks in a single fanotify group
> > > >
> > > >There is currently no limit on the number of marks a given fanotify
> > > >group
> > > >can have.  Since fanotify is gated on CAP_SYS_ADMIN this was not seen
> > > >as
> > > >a serious DoS threat.  This patch implements a default of 8192, the
> > > >same as
> > > >inotify to work towards removing the CAP_SYS_ADMIN gating and
> > > >eliminating
> > > >    the default DoS'able status.
> > > >
> > > >    Signed-off-by: Eric Paris <eparis@redhat.com>
> > > >
> > > >There idea is to eventually remove the gated CAP_SYS_ADMIN.
> > > >There is no reason that fanotify could not be used by unprivileged
> > > >users
> > > >to setup inotify style watch on an inode or directories children, see:
> > > >https://patchwork.kernel.org/patch/10668299/
> > > >
> > > >>
> > > >> Fixes: 5dd03f55fd2 ("fanotify: allow userspace to override max queue
> > > >depth")
> > > >> Fixes: ac7e22dcfaf ("fanotify: allow userspace to override max
> > > >marks")
> > > >
> > > >Fixes is used to tag bug fixes for stable.
> > > >There is no bug.
> > > >
> > > >Thanks,
> > > >Amir.
> > >
> > > Interesting. When do you think the gate can be removed?
> >
> > Nobody is working on this AFAIK.
> > What I posted was a simple POC, but I have no use case for this.
> > In the patchwork link above, Jan has listed the prerequisites for
> > removing the gate.
> >
> > One of the prerequisites is FAN_REPORT_FID, which is now merged.
> > When events gets reported with fid instead of fd, unprivileged user
> > (hopefully) cannot use fid for privilege escalation.
> >
> > > I was looking into switching from inotify to fanotify but since it's not usable from
> > > non-initial userns it's a no-no
> > > since we support nested workloads.
> >
> > One of Jan's questions was what is the benefit of using inotify-compatible
> > fanotify vs. using inotify.
> > So what was the reason you were looking into switching from inotify to fanotify?
> > Is it because of mount/filesystem watch? Because making those available for
>
> Yeah. Well, I would need to look but you could probably do it safely for
> filesystems mountable in user namespaces (which are few).
> Can you do a bind-mount and then place a watch on the bind-mount or is
> this superblock based?
>

Either.
FAN_MARK_MOUNT was there from day 1 of fanotify.
FAN_MARK_FILESYSTEM was merged to Linux Linux 4.20.

But directory modification events that are supported since v5.1 are
not available
with FAN_MARK_MOUNT, see:
https://github.com/amir73il/man-pages/blob/fanotify_fid/man2/fanotify_init.2#L97

Matthew,

Perhaps this fact is worth a mention in the linked entry for FAN_REPORT_FID
in fanotify_init.2 in addition to the comment on the entry for FAN_MARK_MOUNT
in fanotify_mark.2.

Thanks,
Amir.
