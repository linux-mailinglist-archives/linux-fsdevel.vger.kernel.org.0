Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D79C23846
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 15:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfETNgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 09:36:25 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37384 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfETNgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 09:36:24 -0400
Received: by mail-yb1-f195.google.com with SMTP id z12so153352ybr.4;
        Mon, 20 May 2019 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJAnFoSa3j9LASmywgs5KN5MvU/rxFP1PvW6zwXyemU=;
        b=p8xO4hzBN9m/8acf9YeANieDNiOTVbzuugZuvszRBpXGxi0LWqgoJVCWXYYDR5LnBw
         GnQRBO77n34IOPhPGbVWuf38SOweivDFZ+hLyiI9dUHBGO6mEK4bYpt5VZSW5D/yOTbl
         ZAXI/KKGSzowryav59SnV7iMwJUSiiiyw6ZZ0jkGX1dSsp5V2/6zlJlqUMmgE+0+C5S9
         fx+4lTG5ZkLYsaOU/xEoNQw1e/UjVzP424UCW/4IxdroLpmZorql8+KWJfEogFSaU83s
         ceUDdsqXvV/8JfdkVRw0s3MjLbs1MZk28OtgX8fkuzLd2Fbe+aEQqHVqm5nO+N0azB+q
         /jCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJAnFoSa3j9LASmywgs5KN5MvU/rxFP1PvW6zwXyemU=;
        b=oCBXrSv3nT0s0tICu5bgmuoBvgGLCSFqd6HrmHCUkW48CLrWCgg1tbOEmSEuLGmywC
         SwdIIyLXNEtifOWAWmKBj+9fkTSCqUsISUG52zJPcrjIEl8A/9Gmx5aLFoZ6UgoxEgOj
         B/RNTBTviU3jn44rZDEta6B8MgqIyVG0O3ofGLp5mt8UpQX2KLnOcxihgloNehMRTUv2
         DEEHMOtBb0cO4pnneBfu2R6JzSz49eCFBDrlIsnmhmxioCjys/i/HqjHxMBcXEx4pT0m
         zkcClDWgesStWqiQS58bpFiCvZbm+uzbiCdax7j44efqmb7XIdK3qiV6QbamePZ6rVU5
         l8sw==
X-Gm-Message-State: APjAAAUgMSkKVHM6pxPo0Lsg0fRGqeRVQ9hIfV9WksP07LhnXXaWiXdZ
        3vxdsaY0PNy+s3dn0dUyr3cTzoo2FU5bYHynnIs=
X-Google-Smtp-Source: APXvYqxAWNDFMVo1nWZ8IE/8/QMU8cHNHHEKvEsoUZxuYGHXtHxHebTKxfAZaQ2uPz73XLFNAHXL1r07NfLcOboso7E=
X-Received: by 2002:a25:cb0c:: with SMTP id b12mr11943199ybg.144.1558359383123;
 Mon, 20 May 2019 06:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181203083416.28978-1-david@fromorbit.com> <20181203083416.28978-2-david@fromorbit.com>
 <CAOQ4uxhOQY8M5rbgHKREN5qpeDGHv0-xK3r37Lj6XfqFoE4qjg@mail.gmail.com>
 <20181204151332.GA32245@infradead.org> <20181204212948.GO6311@dastard>
 <CAN-5tyGU=y5JO5UNcmn3rX1gRyK_UxjQvQ+kCsP34_NT2-mQ_A@mail.gmail.com>
 <20181204223102.GR6311@dastard> <CAOQ4uxhPoJ2vOwGN7PFWkD6+_zdTeMAhT4KphnyktaQ23zqvBw@mail.gmail.com>
 <CAN-5tyGN8LPAxxjApBifbs6+eAgOVE8G1x3vawSMfT2Ufo7Bpw@mail.gmail.com>
In-Reply-To: <CAN-5tyGN8LPAxxjApBifbs6+eAgOVE8G1x3vawSMfT2Ufo7Bpw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 20 May 2019 16:36:12 +0300
Message-ID: <CAOQ4uxgvCz+-snW8h-M-q2KqaPSk-oMYRVn2gWeMNg2jrMP_zg@mail.gmail.com>
Subject: Re: [PATCH 01/11] vfs: copy_file_range source range over EOF should fail
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        ceph-devel@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 20, 2019 at 4:12 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Mon, May 20, 2019 at 5:10 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Dec 5, 2018 at 12:31 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Tue, Dec 04, 2018 at 04:47:18PM -0500, Olga Kornievskaia wrote:
> > > > On Tue, Dec 4, 2018 at 4:35 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > >
> > > > > On Tue, Dec 04, 2018 at 07:13:32AM -0800, Christoph Hellwig wrote:
> > > > > > On Mon, Dec 03, 2018 at 02:46:20PM +0200, Amir Goldstein wrote:
> > > > > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > > > >
> > > > > > > > The man page says:
> > > > > > > >
> > > > > > > > EINVAL Requested range extends beyond the end of the source file
> > > > > > > >
> > > > > > > > But the current behaviour is that copy_file_range does a short
> > > > > > > > copy up to the source file EOF. Fix the kernel behaviour to match
> > > > > > > > the behaviour described in the man page.
> > > > > >
> > > > > > I think the behavior implemented is a lot more useful than the one
> > > > > > documented..
> > > > >
> > > > > The current behaviour is really nasty. Because copy_file_range() can
> > > > > return short copies, the caller has to implement a loop to ensure
> > > > > the range hey want get copied.  When the source range you are
> > > > > trying to copy overlaps source EOF, this loop:
> > > > >
> > > > >         while (len > 0) {
> > > > >                 ret = copy_file_range(... len ...)
> > > > >                 ...
> > > > >                 off_in += ret;
> > > > >                 off_out += ret;
> > > > >                 len -= ret;
> > > > >         }
> > > > >
> > > > > Currently the fallback code copies up to the end of the source file
> > > > > on the first copy and then fails the second copy with EINVAL because
> > > > > the source range is now completely beyond EOF.
> > > > >
> > > > > So, from an application perspective, did the copy succeed or did it
> > > > > fail?
> > > > >
> > > > > Existing tools that exercise copy_file_range (like xfs_io) consider
> > > > > this a failure, because the second copy_file_range() call returns
> > > > > EINVAL and not some "there is no more to copy" marker like read()
> > > > > returning 0 bytes when attempting to read beyond EOF.
> > > > >
> > > > > IOWs, we cannot tell the difference between a real error and a short
> > > > > copy because the input range spans EOF and it was silently
> > > > > shortened. That's the API problem we need to fix here - the existing
> > > > > behaviour is really crappy for applications. Erroring out
> > > > > immmediately is one solution, and it's what the man page says should
> > > > > happen so that is what I implemented.
> > > > >
> > > > > Realistically, though, I think an attempt to read beyond EOF for the
> > > > > copy should result in behaviour like read() (i.e. return 0 bytes),
> > > > > not EINVAL. The existing behaviour needs to change, though.
> > > >
> > > > There are two checks to consider
> > > > 1. pos_in >= EOF should return EINVAL
> > > > 2. however what's perhaps should be relaxed is pos_in+len >= EOF
> > > > should return a short copy.
> > > >
> > > > Having check#1 enforced allows to us to differentiate between a real
> > > > error and a short copy.
> > >
> > > That's what the code does right now and *exactly what I'm trying to
> > > fix* because it EINVAL is ambiguous and not an indicator that we've
> > > reached the end of the source file. EINVAL can indicate several
> > > different errors, so it really has to be treated as a "copy failed"
> > > error by applications.
> > >
> > > Have a look at read/pread() - they return 0 in this case to indicate
> > > a short read, and the value of zero is explicitly defined as meaning
> > > "read position is beyond EOF".  Applications know straight away that
> > > there is no more data to be read and there was no error, so can
> > > terminate on a successful short read.
> > >
> > > We need to allow applications to terminate copy loops on a
> > > successful short copy. IOWs, applications need to either:
> > >
> > >         - get an immediate error saying the range is invalid rather
> > >           than doing a short copy (as per the man page); or
> > >         - have an explicit marker to say "no more data to be copied"
> > >
> > > Applications need the "no more data to copy" case to be explicit and
> > > unambiguous so they can make sane decisions about whether a short
> > > copy was successful because the file was shorter than expected or
> > > whether a short copy was a result of a real error being encountered.
> > > The current behaviour is largely unusable for applications because
> > > they have to guess at the reason for EINVAL part way through a
> > > copy....
> > >
> >
> > Dave,
> >
> > I went a head and implemented the desired behavior.
> > However, while testing I observed that the desired behavior is already
> > the existing behavior. For example, trying to copy 10 bytes from a 2 bytes file,
> > xfs_io copy loop ends as expected:
> > copy_file_range(4, [0], 3, [0], 10, 0)  = 2
> > copy_file_range(4, [2], 3, [2], 8, 0)   = 0
> >
> > This was tested on ext4 and xfs with reflink on recent kernel as well as on
> > v4.20-rc1 (era of original patch set).
> >
> > Where and how did you observe the EINVAL behavior described above?
> > (besides man page that is). There are even xfstests (which you modified)
> > that verify the return 0 for past EOF behavior.
> >
> > For now, I am just dropping this patch from the patch series.
> > Let me know if I am missing something.
>
> The was fixing inconsistency in what the man page specified (ie., it
> must fail with EINVAL if offsets are out of range) which was never
> enforced by the code. The patch then could be to fix the existing
> semantics (man page) of the system call.
>
> Copy file range range is not only read and write but rather
> lseek+read+write and if somebody specifies an incorrect offset to the

Nope. it is like either read+write or pread+pwrite.

> lseek the system call should fail. Thus I still think that copy file
> range should enforce that specifying a source offset beyond the end of
> the file should fail with EINVAL.

You appear to be out numbered by reviewers that think copy_file_range(2)
should behave like pread(2) and return 0 when offf_in >= size_in.

>
> If the copy file range returned 0 bytes does it mean it's a stopping
> condition, not according to the current semantics.

Yes. Same as read(2)/pread(2).

Thanks,
Amir.
