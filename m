Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F923944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbfETOC0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 10:02:26 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39571 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbfETOCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 10:02:25 -0400
Received: by mail-yb1-f194.google.com with SMTP id a3so2526733ybr.6;
        Mon, 20 May 2019 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5YS02G6eiV2qqnap6SlWSI++GReaf+7UZEjDRSx2pQ=;
        b=oGblTUFFwb7iq7+pqJSVjsnBcS5iL9059eHF0nUh8rQZLagMLvbK2egngYJXs9sjdF
         rNqGricYIZALKUW/lwba8vFx/n7mBtBH4vVJzGR3xq4wtYTPBn83Oxk1vniY29tvO3fE
         ia0nxzEZDp99MARXWvb9PBsFlH/UPrEYyggQxFHazj+n2C8EPM6FV3DPVqitNeWrSCHf
         tTa8g5+MEzz8wWDxPiQcphDL2TTc79t8INY40h8npKD99nHguW1TrxnY6uU0T9MpK26j
         KrpS2Iuen7LxWBuJqZoQ4nM3fnVA0nAyqaxBpctQ4cYufHjVl/QTLHeba34eO1uWSApE
         XHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5YS02G6eiV2qqnap6SlWSI++GReaf+7UZEjDRSx2pQ=;
        b=p2Jy7GHuUAjc20Tqx+q5qP8gpMuOE4q1JKThoJwWXHghtJ4r9hUQXwRhhoFHGqsrKg
         LvyG2/POENZS0rLAUAm753VQufbFcCE221p0aIgU856pJvjvgymbCFZBU7CfyovPJvKV
         dokndqasPaQARWyLRcjW1uBYz7G4ANY/0ifk16CDNspYR/UvvRNQvNpe6C+Q1N368d7o
         g/J/v4FVDNP4z3eMBzEMmxmWn1PIBdA6YzzjPkD27jE/pKD53UTRhufP4WLb4zMOmhW+
         2g4oI1/xnqfjYB5g4yz6PruNZPn7i3dVjthcrBceOlabsIZyn7YH+AYqLgLuISTmv4YS
         5yRQ==
X-Gm-Message-State: APjAAAWq3Y6qvjkTm5O8zJ1a91TEirGj+paywggqCs5zoeAbKRTSwBD4
        OD6uCQUW4N0p4hgPi2QnJDtkxx1QDC7Cs+sFvBEF4s6c
X-Google-Smtp-Source: APXvYqwW2EGZwGv6GnHASoWkgqUmd8gFl22iAyys7K83qOsBp5JuvB6Hg952dHbLCQS1BEkfHqEOv5V77lnnDBNqU44=
X-Received: by 2002:a25:8109:: with SMTP id o9mr5321490ybk.132.1558360944547;
 Mon, 20 May 2019 07:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181203083416.28978-1-david@fromorbit.com> <20181203083416.28978-2-david@fromorbit.com>
 <CAOQ4uxhOQY8M5rbgHKREN5qpeDGHv0-xK3r37Lj6XfqFoE4qjg@mail.gmail.com>
 <20181204151332.GA32245@infradead.org> <20181204212948.GO6311@dastard>
 <CAN-5tyGU=y5JO5UNcmn3rX1gRyK_UxjQvQ+kCsP34_NT2-mQ_A@mail.gmail.com>
 <20181204223102.GR6311@dastard> <CAOQ4uxhPoJ2vOwGN7PFWkD6+_zdTeMAhT4KphnyktaQ23zqvBw@mail.gmail.com>
 <CAN-5tyGN8LPAxxjApBifbs6+eAgOVE8G1x3vawSMfT2Ufo7Bpw@mail.gmail.com>
 <CAOQ4uxgvCz+-snW8h-M-q2KqaPSk-oMYRVn2gWeMNg2jrMP_zg@mail.gmail.com> <CAN-5tyFq33w5H2Awd4EZOtS_SeZ6rLak727tC_88hL=Uc_KWKA@mail.gmail.com>
In-Reply-To: <CAN-5tyFq33w5H2Awd4EZOtS_SeZ6rLak727tC_88hL=Uc_KWKA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 20 May 2019 17:02:13 +0300
Message-ID: <CAOQ4uxhiT6d-747YoWH1HDq1D2KT9AAkiUkpre3dptcr+KmWzw@mail.gmail.com>
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

On Mon, May 20, 2019 at 4:58 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Mon, May 20, 2019 at 9:36 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, May 20, 2019 at 4:12 PM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > >
> > > On Mon, May 20, 2019 at 5:10 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Wed, Dec 5, 2018 at 12:31 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > >
> > > > > On Tue, Dec 04, 2018 at 04:47:18PM -0500, Olga Kornievskaia wrote:
> > > > > > On Tue, Dec 4, 2018 at 4:35 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > >
> > > > > > > On Tue, Dec 04, 2018 at 07:13:32AM -0800, Christoph Hellwig wrote:
> > > > > > > > On Mon, Dec 03, 2018 at 02:46:20PM +0200, Amir Goldstein wrote:
> > > > > > > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > > > > > >
> > > > > > > > > > The man page says:
> > > > > > > > > >
> > > > > > > > > > EINVAL Requested range extends beyond the end of the source file
> > > > > > > > > >
> > > > > > > > > > But the current behaviour is that copy_file_range does a short
> > > > > > > > > > copy up to the source file EOF. Fix the kernel behaviour to match
> > > > > > > > > > the behaviour described in the man page.
> > > > > > > >
> > > > > > > > I think the behavior implemented is a lot more useful than the one
> > > > > > > > documented..
> > > > > > >
> > > > > > > The current behaviour is really nasty. Because copy_file_range() can
> > > > > > > return short copies, the caller has to implement a loop to ensure
> > > > > > > the range hey want get copied.  When the source range you are
> > > > > > > trying to copy overlaps source EOF, this loop:
> > > > > > >
> > > > > > >         while (len > 0) {
> > > > > > >                 ret = copy_file_range(... len ...)
> > > > > > >                 ...
> > > > > > >                 off_in += ret;
> > > > > > >                 off_out += ret;
> > > > > > >                 len -= ret;
> > > > > > >         }
> > > > > > >
> > > > > > > Currently the fallback code copies up to the end of the source file
> > > > > > > on the first copy and then fails the second copy with EINVAL because
> > > > > > > the source range is now completely beyond EOF.
> > > > > > >
> > > > > > > So, from an application perspective, did the copy succeed or did it
> > > > > > > fail?
> > > > > > >
> > > > > > > Existing tools that exercise copy_file_range (like xfs_io) consider
> > > > > > > this a failure, because the second copy_file_range() call returns
> > > > > > > EINVAL and not some "there is no more to copy" marker like read()
> > > > > > > returning 0 bytes when attempting to read beyond EOF.
> > > > > > >
> > > > > > > IOWs, we cannot tell the difference between a real error and a short
> > > > > > > copy because the input range spans EOF and it was silently
> > > > > > > shortened. That's the API problem we need to fix here - the existing
> > > > > > > behaviour is really crappy for applications. Erroring out
> > > > > > > immmediately is one solution, and it's what the man page says should
> > > > > > > happen so that is what I implemented.
> > > > > > >
> > > > > > > Realistically, though, I think an attempt to read beyond EOF for the
> > > > > > > copy should result in behaviour like read() (i.e. return 0 bytes),
> > > > > > > not EINVAL. The existing behaviour needs to change, though.
> > > > > >
> > > > > > There are two checks to consider
> > > > > > 1. pos_in >= EOF should return EINVAL
> > > > > > 2. however what's perhaps should be relaxed is pos_in+len >= EOF
> > > > > > should return a short copy.
> > > > > >
> > > > > > Having check#1 enforced allows to us to differentiate between a real
> > > > > > error and a short copy.
> > > > >
> > > > > That's what the code does right now and *exactly what I'm trying to
> > > > > fix* because it EINVAL is ambiguous and not an indicator that we've
> > > > > reached the end of the source file. EINVAL can indicate several
> > > > > different errors, so it really has to be treated as a "copy failed"
> > > > > error by applications.
> > > > >
> > > > > Have a look at read/pread() - they return 0 in this case to indicate
> > > > > a short read, and the value of zero is explicitly defined as meaning
> > > > > "read position is beyond EOF".  Applications know straight away that
> > > > > there is no more data to be read and there was no error, so can
> > > > > terminate on a successful short read.
> > > > >
> > > > > We need to allow applications to terminate copy loops on a
> > > > > successful short copy. IOWs, applications need to either:
> > > > >
> > > > >         - get an immediate error saying the range is invalid rather
> > > > >           than doing a short copy (as per the man page); or
> > > > >         - have an explicit marker to say "no more data to be copied"
> > > > >
> > > > > Applications need the "no more data to copy" case to be explicit and
> > > > > unambiguous so they can make sane decisions about whether a short
> > > > > copy was successful because the file was shorter than expected or
> > > > > whether a short copy was a result of a real error being encountered.
> > > > > The current behaviour is largely unusable for applications because
> > > > > they have to guess at the reason for EINVAL part way through a
> > > > > copy....
> > > > >
> > > >
> > > > Dave,
> > > >
> > > > I went a head and implemented the desired behavior.
> > > > However, while testing I observed that the desired behavior is already
> > > > the existing behavior. For example, trying to copy 10 bytes from a 2 bytes file,
> > > > xfs_io copy loop ends as expected:
> > > > copy_file_range(4, [0], 3, [0], 10, 0)  = 2
> > > > copy_file_range(4, [2], 3, [2], 8, 0)   = 0
> > > >
> > > > This was tested on ext4 and xfs with reflink on recent kernel as well as on
> > > > v4.20-rc1 (era of original patch set).
> > > >
> > > > Where and how did you observe the EINVAL behavior described above?
> > > > (besides man page that is). There are even xfstests (which you modified)
> > > > that verify the return 0 for past EOF behavior.
> > > >
> > > > For now, I am just dropping this patch from the patch series.
> > > > Let me know if I am missing something.
> > >
> > > The was fixing inconsistency in what the man page specified (ie., it
> > > must fail with EINVAL if offsets are out of range) which was never
> > > enforced by the code. The patch then could be to fix the existing
> > > semantics (man page) of the system call.
> > >
> > > Copy file range range is not only read and write but rather
> > > lseek+read+write and if somebody specifies an incorrect offset to the
> >
> > Nope. it is like either read+write or pread+pwrite.
> >
> > > lseek the system call should fail. Thus I still think that copy file
> > > range should enforce that specifying a source offset beyond the end of
> > > the file should fail with EINVAL.
> >
> > You appear to be out numbered by reviewers that think copy_file_range(2)
> > should behave like pread(2) and return 0 when offf_in >= size_in.
> >
> > >
> > > If the copy file range returned 0 bytes does it mean it's a stopping
> > > condition, not according to the current semantics.
> >
> > Yes. Same as read(2)/pread(2).
>
> If that's the case, then it's great. Perhaps it's the fact that the
> copy_file_range man page doesn't talk about it that makes it
> confusing.
>

We agreed that updating the man page is better, see:
https://github.com/amir73il/man-pages/commits/copy_file_range-v2

I'm currently testing reworked patches.
Will post them once they pass the tests.

Thanks,
Amir.
