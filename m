Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 211028A31E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfHLQPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:15:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36015 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfHLQPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:15:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id k18so28763617otr.3;
        Mon, 12 Aug 2019 09:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kuNcGLEjiuYlGL2n41FoYam66qU04XkuNZaeF+qT9E=;
        b=mCrQrFolk5ybQj6q8icgzSXLpZNICQtXeYSKc0iZKxqPSR/awHVH3zZ/Q16n9tcS9v
         SXq7Is7yGOq3D5WFcEWu+HIR7Km/bLt71/hi3rCy81stGSHYW0NfxQp1uNQjLB4X850U
         MnxF5RuwxlsqZB5ClArRTyQ/NbNNIyMOru6+BTmP7c/XQOnyDPCCMGR1Ocmjo+yymMxb
         rRRPc0psV9RGTlG7dzmFLrMh6ga4VgCbeLalFbAdnjRwtHgdqFvW2ECBpZv5mpVUvw37
         FbXA5mXoqsJkyjanLRT4giOe5iSHVzJ4XRtddj/+dHna51Obfp8Lx2IrKNa5dGfe11Bk
         kBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kuNcGLEjiuYlGL2n41FoYam66qU04XkuNZaeF+qT9E=;
        b=C2PbK7AGC9kprPmyDdxB7LP92YoqH7Y8GCVvO4whno2CYNIXAndNncos6JXiyHrlqV
         ksgkkYuh6lui68hsL4L213DClzZoQJae4Rh8qjV3JdXWQgZcTkPtAGIASC4tGxQgHhgl
         1H9EO6sh5+sThlLibuQBjFdsHWB0q4/IBTrfSSvRFKxYlhvta52WHL2wNNTwxo0EMqMn
         iW25dsraxvvaGHKn89oVbjBgTcOO7MS3s9m4i0kBVgrfGQJUEBfgdLaQXIUPWnSRamm4
         ahiMcP9Z22hxpEaoUXB2u2qPjGLLinTjsa8V2/1MYMPi/5KTOn759IY8TPH/Gr4sWd8T
         xOsw==
X-Gm-Message-State: APjAAAWE48gVrJQ7A+le7e09igbYvfxGcp45VHqgNiWfMs8Cr7qdyueO
        um52ATeaYeXhR8TpFAY3Fio8ghIfzpk/Al8adRSLGw==
X-Google-Smtp-Source: APXvYqzhmBdBLh1PXMmUTtckJ5u6+J4GFZy9FpD6KhwzLC2zvYBMgsjtyPWcLQassPbIRCtJMdIiigcqxkX5UkMBC5E=
X-Received: by 2002:a5d:85c3:: with SMTP id e3mr34721246ios.265.1565626547412;
 Mon, 12 Aug 2019 09:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-5-deepa.kernel@gmail.com>
 <c508fe0116b77ff0496ebb17a69f756c47be62b7.camel@codethink.co.uk>
 <CABeXuvruROn7j1DiCDbP6MLBt9SB4Pp3HoKqcQbUNPDJgGWLgw@mail.gmail.com>
 <53df9d81bfb4ee7ec64fabf1089f91d80dceb491.camel@codethink.co.uk>
 <CAK8P3a0CADLUeXvsBHNAC8ekLoo0o0uYz2arBqZ=1N+Xp8HNvA@mail.gmail.com> <CABeXuvpAPp98G2gCczB3n=izv4aM7vacdbPONiELrw-1ZOrd=g@mail.gmail.com>
In-Reply-To: <CABeXuvpAPp98G2gCczB3n=izv4aM7vacdbPONiELrw-1ZOrd=g@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Mon, 12 Aug 2019 09:15:36 -0700
Message-ID: <CABeXuvoa4VUQp3QxsEfq6PBKNv4Q2icp++5_EP=1e_72KLk_9w@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 04/20] mount: Add mount warning for impending
 timestamp expiry
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 9:09 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Mon, Aug 12, 2019 at 7:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Aug 12, 2019 at 3:25 PM Ben Hutchings
> > <ben.hutchings@codethink.co.uk> wrote:
> > > On Sat, 2019-08-10 at 13:44 -0700, Deepa Dinamani wrote:
> > > > On Mon, Aug 5, 2019 at 7:14 AM Ben Hutchings
> > > > <ben.hutchings@codethink.co.uk> wrote:
> > > > > On Mon, 2019-07-29 at 18:49 -0700, Deepa Dinamani wrote:
> > > > > > The warning reuses the uptime max of 30 years used by the
> > > > > > setitimeofday().
> > > > > >
> > > > > > Note that the warning is only added for new filesystem mounts
> > > > > > through the mount syscall. Automounts do not have the same warning.
> > > > > [...]
> > > > >
> > > > > Another thing - perhaps this warning should be suppressed for read-only
> > > > > mounts?
> > > >
> > > > Many filesystems support read only mounts only. We do fill in right
> > > > granularities and limits for these filesystems as well. In keeping
> > > > with the trend, I have added the warning accordingly. I don't think I
> > > > have a preference either way. But, not warning for the red only mounts
> > > > adds another if case. If you have a strong preference, I could add it
> > > > in.
> > >
> > > It seems to me that the warning is needed if there is a possibility of
> > > data loss (incorrect timestamps, potentially leading to incorrect
> > > decisions about which files are newer).  This can happen only when a
> > > filesystem is mounted read-write, or when a filesystem image is
> > > created.
> > >
> > > I think that warning for read-only mounts would be an annoyance to
> > > users retrieving files from old filesystems.
> >
> > I agree, the warning is not helpful for read-only mounts. An earlier
> > plan was to completely disallow writable mounts that might risk an
> > overflow (in some configurations at least). The warning replaces that
> > now, and I think it should also just warn for the cases that would
> > otherwise have been dangerous.
>
> Ok, I will make the change to exclude new read only mounts. I will use
> __mnt_is_readonly() so that it also exculdes filesystems that are
> readonly also.
> The diff looks like below:
>
> -       if (!error && sb->s_time_max &&
> +       if (!error && !__mnt_is_readonly(mnt) &&
>             (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
>
> Note that we can get rid of checking for non zero sb->s_time_max now.

One more thing, we will probably have to add a second warning for when
the filesystem is re-mounted rw after the initial readonly mount.

-Deepa
