Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCC377B5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 06:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhEJFA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 01:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhEJFA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 01:00:27 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860BC061573;
        Sun,  9 May 2021 21:59:22 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k25so13601114iob.6;
        Sun, 09 May 2021 21:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pA/KXJqoO1A/HmhtaCXdDZYiGzrDbn7kLF51Psi4Dyw=;
        b=eWjrQ6wgozWorOShKZ++4B/G6AY2Q3y+G1iUso63OGhxCdF3GFXCFwc+bhNHcBK8xZ
         8bsaFJPEyy72cq8zO23JAd9vSf5A8NJIRkJes5/4LieMjMEZi+PnEDpkqBowX/1VsEie
         ok/7OtfcbIHznpAQddkPneKJKOurgcNyQCEeqNmo58LDWzmWO8MfOFkP3hEu5RZQUPKA
         X1QBEtDXOoFiXLLLwaKNsoxljlhFSMDb0qg14KmYfNg2YQYaG3DyXUjOAQX13uuzvah8
         CAm7SzGN2KB1HCGRB+LNw2wnEQxfF7VfjBijnGTF+Idcw8Kp7SM15xb9kdC3tvB2RE5m
         XUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pA/KXJqoO1A/HmhtaCXdDZYiGzrDbn7kLF51Psi4Dyw=;
        b=CPzDYdVZkjwir2DALpQnV4AUi3o8XY8Tmi+QZuAwQ94tNdXz52pmWT8+JIg6iA/keZ
         NzDIAKW1Ur2Or3OJr9b/FUXK75mb63g8imFwYoaHoWhJbraxMIi7ONKx3hIa2CmgGGNl
         GW+AGVMty9baCPkHalWpn/nQzJbo1dOg+2b7vECLCWlZ2ExbgHVJmnfOEObDTe0BvHol
         WXyKOoc99v7Y1aHMcdUzEwirD1HfqM7/zcagew2MRExqb9lunXxhVBnisDGe8TejogPZ
         HFoDpZex+ND2DWlt5HZWx31JE5dj3xuyk1cLqSZfOSviu8oVruRJOVry1ATDD8loHE4Z
         X1+w==
X-Gm-Message-State: AOAM533qMA6PlXPU3SX/TOrzh9mbjZPmRrGby2ygddei0BFo2LjVTktZ
        aDjEA0IHJJtqaUb0s1Xc/zv40vUXVaBoA48EDYc=
X-Google-Smtp-Source: ABdhPJxxlA1YbCNK2y+zy2DtZshoYsYRHREA+LvjUmiRA278V9jU+kVNryFMYnUED4ta0rm1KffZGJVEXDFFZzVRFq0=
X-Received: by 2002:a05:6638:190d:: with SMTP id p13mr20270532jal.120.1620622761258;
 Sun, 09 May 2021 21:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210221195833.23828-1-lhenriques@suse.de> <20210222102456.6692-1-lhenriques@suse.de>
 <CAN-5tyELMY7b7CKO-+an47ydq8r_4+SOyhuvdH0qE0-JmdZ44Q@mail.gmail.com>
 <YDYpHccgM7agpdTQ@suse.de> <CANMq1KBgwEXFh8AxpPW2t1SA0NVsyR45m0paLEU4D4w80dc_fA@mail.gmail.com>
 <CANMq1KDTgnGtNxWj2XxAT3mdsNjc551uUCg6EWnh=Hd0KcVQKQ@mail.gmail.com>
 <8735vzfugn.fsf@suse.de> <CAOQ4uxjdVZywBi6=D1eRfBhRk+nobTz4N87jcejDtvzBMMMKXQ@mail.gmail.com>
 <CANMq1KAOwj9dJenwF2NadQ73ytfccuPuahBJE7ak6S7XP6nCjg@mail.gmail.com> <8735v4tcye.fsf@suse.de>
In-Reply-To: <8735v4tcye.fsf@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 10 May 2021 07:59:09 +0300
Message-ID: <CAOQ4uxh6PegaOtMXQ9WmU=05bhQfYTeweGjFWR7T+XVAbuR09A@mail.gmail.com>
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Ian Lance Taylor <iant@golang.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 3, 2021 at 11:52 AM Luis Henriques <lhenriques@suse.de> wrote:
>
> Nicolas Boichat <drinkcat@chromium.org> writes:
>
> > On Fri, Apr 9, 2021 at 9:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >>
> >> On Fri, Apr 9, 2021 at 4:39 PM Luis Henriques <lhenriques@suse.de> wrote:
> >> >
> >> > Nicolas Boichat <drinkcat@chromium.org> writes:
> >> >
> >> > > On Wed, Feb 24, 2021 at 6:44 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >> > >>
> >> > >> On Wed, Feb 24, 2021 at 6:22 PM Luis Henriques <lhenriques@suse.de> wrote:
> >> > >> >
> >> > >> > On Tue, Feb 23, 2021 at 08:00:54PM -0500, Olga Kornievskaia wrote:
> >> > >> > > On Mon, Feb 22, 2021 at 5:25 AM Luis Henriques <lhenriques@suse.de> wrote:
> >> > >> > > >
> >> > >> > > > A regression has been reported by Nicolas Boichat, found while using the
> >> > >> > > > copy_file_range syscall to copy a tracefs file.  Before commit
> >> > >> > > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> >> > >> > > > kernel would return -EXDEV to userspace when trying to copy a file across
> >> > >> > > > different filesystems.  After this commit, the syscall doesn't fail anymore
> >> > >> > > > and instead returns zero (zero bytes copied), as this file's content is
> >> > >> > > > generated on-the-fly and thus reports a size of zero.
> >> > >> > > >
> >> > >> > > > This patch restores some cross-filesystem copy restrictions that existed
> >> > >> > > > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> >> > >> > > > devices").  Filesystems are still allowed to fall-back to the VFS
> >> > >> > > > generic_copy_file_range() implementation, but that has now to be done
> >> > >> > > > explicitly.
> >> > >> > > >
> >> > >> > > > nfsd is also modified to fall-back into generic_copy_file_range() in case
> >> > >> > > > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
> >> > >> > > >
> >> > >> > > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> >> > >> > > > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> >> > >> > > > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> >> > >> > > > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> >> > >> > > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> >> > >> > > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >> > >> > >
> >> > >> > > I tested v8 and I believe it works for NFS.
> >> > >> >
> >> > >> > Thanks a lot for the testing.  And to everyone else for reviews,
> >> > >> > feedback,... and patience.
> >> > >>
> >> > >> Thanks so much to you!!!
> >> > >>
> >> > >> Works here, you can add my
> >> > >> Tested-by: Nicolas Boichat <drinkcat@chromium.org>
> >> > >
> >> > > What happened to this patch? It does not seem to have been picked up
> >> > > yet? Any reason why?
> >> >
> >> > Hmm... good question.  I'm not actually sure who would be picking it.  Al,
> >> > maybe...?
> >> >
> >>
> >> Darrick,
> >>
> >> Would you mind taking this through your tree in case Al doesn't pick it up?
> >
> > Err, sorry for yet another ping... but it would be good to move
> > forward with those patches ,-P
>
> Yeah, I'm not sure what else to do, or who else to bug regarding this :-/
>

Luis,

I suggest that you post v9 with my Reviewed-by and Olga's Tested-by
and address your patch to the VFS maintainer and fsdevel list without
the entire world and LKML in CC.

Al,

Would you mind picking this patch?

Linus,

There have been some voices on the discussion saying maybe this is not
a kernel regression that needs to be fixed, but a UAPI that is not being used
correctly by userspace.

The proposed change reminds me a bit of recent changes to splice() from
special files. Since this specific UAPI discussion is a bit subtle and because
we got this UAPI wrong at least two times already, it would be great to get
your ACK on this proposed UAPI change.

Thanks,
Amir.

Latest v8 tested and reviewed by several developers on CC list:
https://lore.kernel.org/linux-fsdevel/20210222102456.6692-1-lhenriques@suse.de/

Proposed man page update:
https://lore.kernel.org/linux-fsdevel/20210509213930.94120-12-alx.manpages@gmail.com/
