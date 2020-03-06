Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3B17C755
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 21:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCFUwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 15:52:02 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37933 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgCFUwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:52:02 -0500
Received: by mail-il1-f195.google.com with SMTP id f5so3284493ilq.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 12:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvYR/A6sU6MOP83SOcaM6fuuOQnX/X3paiURCZQZ5zg=;
        b=gdosk36NodqB1hwovjpQiyfVrBcCT18ZZbADF2DKWw0ltWEDy6wxV7OtCiUiXRbhi8
         wApryLv+o7MA3xTBwKCecpyYXsypPV4llqkjt9QKK3gqFry2pXG6z/9rB5H+p8YONVWw
         ILjY9/lDsSbwbv0gahQM4JqMzI/cQAi2PGmHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvYR/A6sU6MOP83SOcaM6fuuOQnX/X3paiURCZQZ5zg=;
        b=auRWIoKd/60j3qGgxiVdMTwhzYjAap1KW6RzrB4U7bL/uOwKIVpT7DOF8KHAvArxOa
         beCbc6VfjTUdMnWF3H47Tun8I68ekJMT90wcBL6ysW6waaMPc3tszGSR1fdCIXZ3wgbc
         uM+KE8alA37norRWHQQ2AfVq0LhzWFTPRqnoXTabnaUwAzbtk49XfvnJAI1bcX6MMYyz
         f+YXVYsWHgvSCPchSAp8Ag49KTe8A8sxiQXcsZmJ8tO+501IkBLm1fItXTmqcpm2cGEL
         vayboI/Srb/xyFvCE2X18Gcp5a4Dg+edw7y3gOJSR3zaUJ4HlFLHSHiO4GHEPTQpNH+C
         13mw==
X-Gm-Message-State: ANhLgQ3y8Uvg0NoVOdPZjC5/EfcRVSBEx+iXbfYD5DXGEqbwEcPzGQ1s
        JiiL/6WMbT76Y0fMPSus41Hxfri+MqdqG+NcjhJUbg==
X-Google-Smtp-Source: ADFU+vsSfmpgcTtLjaqUd8you1EnB+Adlmsw2R1fb2KCJPMGUn5sreIhU68BBr8zp6cSosp0R0u9BiMc39++38j5ic0=
X-Received: by 2002:a92:8d41:: with SMTP id s62mr4596013ild.63.1583527922077;
 Fri, 06 Mar 2020 12:52:02 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com> <20200306194322.GY23230@ZenIV.linux.org.uk>
 <20200306195823.GZ23230@ZenIV.linux.org.uk> <20200306200522.GA23230@ZenIV.linux.org.uk>
 <20200306203705.GB23230@ZenIV.linux.org.uk> <20200306203844.GC23230@ZenIV.linux.org.uk>
 <20200306204523.GD23230@ZenIV.linux.org.uk> <20200306204926.GE23230@ZenIV.linux.org.uk>
In-Reply-To: <20200306204926.GE23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Mar 2020 21:51:50 +0100
Message-ID: <CAJfpegvK+v9LZ_VinPAgVV+iuxiVSFqYnX3oRXsBJM8keDgzJg@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 6, 2020 at 9:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Mar 06, 2020 at 08:45:23PM +0000, Al Viro wrote:
> > On Fri, Mar 06, 2020 at 08:38:44PM +0000, Al Viro wrote:
> > > On Fri, Mar 06, 2020 at 08:37:05PM +0000, Al Viro wrote:
> > >
> > > > You are misreading mntput_no_expire(), BTW - your get_mount() can
> > > > bloody well race with umount(2), hitting the moment when we are done
> > > > figuring out whether it's busy but hadn't cleaned ->mnt_ns (let alone
> > > > set MNT_DOOMED) yet.  If somebody calls umount(2) on a filesystem that
> > > > is not mounted anywhere else, they are not supposed to see the sucker
> > > > return 0 until the filesystem is shut down.  You break that.
> > >
> > > While we are at it, d_alloc_parallel() requires i_rwsem on parent held
> > > at least shared.
> >
> > Egads...  Let me see if I got it right - you are providing procfs symlinks
> > to objects on the internal mount of that thing.  And those objects happen
> > to be directories, so one can get to their parent that way.  Or am I misreading
> > that thing?
>
> IDGI.  You have (in your lookup) kstrtoul, followed by snprintf, followed
> by strcmp and WARN_ON() in case of mismatch?  Is there any point in having
> stat(2) on "00" spew into syslog?  Confused...

The WARN_ON() is for the buffer overrun, not for the strcmp mismatch.

Thanks,
Miklos
