Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1256AE8EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 18:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjCGRT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 12:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjCGRSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:18:53 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F7587DA6
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 09:14:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a25so55458905edb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 09:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eitmlabs-org.20210112.gappssmtp.com; s=20210112; t=1678209265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uwDUxJcDJcMxnTkL2V+YwQldX6E+/2r615N9qnjsQ5k=;
        b=loV6EpaQge6cTIm0ELzvl+6/bRyrJcc6FOYdFs0TRbxcEZGfB54dpAEyz14LRrDp50
         P4H64uZoqdhR0rZE2NHKOe0NtYGy7ifOi/XD8e15TdxPvtPrIvHtR9+5xSssfxZiv1N0
         EXIkf3Egrn1M8zOzQYhhfhKBFlqIhOZe1gSVeRAaZ+9fS4wJgL8XgqlNCXbiwGv6Hzcr
         m/CrckAS/z3o1tWyQyDSo0Zh+ASo6JuCnqud7J2RSwVzwI69IIHm7axl8kSorq+ws5pg
         uFqX9/V2NfyADasJ19Uzd3txoFCkMHnUxJEngMSTpmZ/XJ8mRyERbi4fEGqBWb6k9Khs
         MEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwDUxJcDJcMxnTkL2V+YwQldX6E+/2r615N9qnjsQ5k=;
        b=v6lEudv/XtPVEuDecDeV5KBzYYqBUgchIHfeiJIHAvP1RGx61ccSTJw/jHDudoMVNB
         xuntxCaOSwJ+vaDhv++oMHLE4tdxduaVlAhNSly7ACPWSPc5KeXrvNOkzCAfZDnc4OOR
         BqtP0q7RQsKyod4QSSiLM+1BlTwpUMQyETDakrtlF4OI+ZghP5NftjUXUrNeG8klMmlU
         qcN8A3iZzA2etoHLfPnrLRKlxeIKfmE9XJPahWQeDFvRDuKRvrgNGr7rvllOfm0WXUa0
         QCqPCIfaxP7Tv9feqhqFr6kDas6MdJBtENSsTYJdQb+G22siQnIGtc7UjKIG7DOyrVit
         LLAA==
X-Gm-Message-State: AO0yUKUw6f4pqu4ZOeHiUSjuwN/0L8KoKanw2ikhlWAGtNc7x9cN6LwY
        Clen4OXkLY3U7RyzlSIN3uTRr7qYZRNBBDniGS1V3vY2U3zFSiE4
X-Google-Smtp-Source: AK7set/GhvrPLHOVoQw/QGOLf9lH9Ub7ISmxaTsewUUiP9pF0QT7WJRKuFmAjXI6QVFX7jksBphHX/IUgB80KGDUkME=
X-Received: by 2002:a17:906:fcb9:b0:883:ba3b:eb94 with SMTP id
 qw25-20020a170906fcb900b00883ba3beb94mr7566442ejb.3.1678209265306; Tue, 07
 Mar 2023 09:14:25 -0800 (PST)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com> <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
 <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
 <EE5E5841-3561-4530-8813-95C16A36D94A@kohlschutter.com> <CAHk-=wh5V8tQScw9Bgc8OiD0r5XmfVSCPp2OHPEf0p5T3obuZg@mail.gmail.com>
 <CAJfpeguXB9mAk=jwWQmk3rivYnaWoLrju_hq-LwtYyNXG4JOeg@mail.gmail.com>
 <CAHk-=wg+bpP5cvcaBhnmJKzTmAtgx12UhR4qzFXXb52atn9gDw@mail.gmail.com>
 <56E6CAAE-FF25-4898-8F9D-048164582E7B@kohlschutter.com> <490c5026-27bd-1126-65dd-2ec975aae94c@eitmlabs.org>
 <CAJfpegt7CMMapxD0W41n2SdwiBn8+B08vsov-iOpD=eQEiPN1w@mail.gmail.com>
 <CALKgVmeaPJj4e9sYP7g+v4hZ7XaHKAm6BUNz14gvaBd=sFCs9Q@mail.gmail.com>
 <CALKgVmdqircMjn+iEuta5a7v5rROmYGXmQ0VJtzcCQnZYbJX6w@mail.gmail.com>
 <CALKgVmfZdVnqMAW81T12sD5ZLTO0fp-oADp-WradW5O=PBjp1Q@mail.gmail.com> <CAJfpeguKVzCyUraDQPGw6vdQFfPwTCuZv0JkMxNA69AiRib3kg@mail.gmail.com>
In-Reply-To: <CAJfpeguKVzCyUraDQPGw6vdQFfPwTCuZv0JkMxNA69AiRib3kg@mail.gmail.com>
Reply-To: jonathan@eitm.org
From:   Jonathan Katz <jkatz@eitmlabs.org>
Date:   Tue, 7 Mar 2023 09:14:08 -0800
Message-ID: <CALKgVmcC1VUV_gJVq70n--omMJZUb4HSh_FqvLTHgNBc+HCLFQ@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     jonathan@eitm.org,
        =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 7, 2023 at 12:38=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 7 Mar 2023 at 02:12, Jonathan Katz <jkatz@eitmlabs.org> wrote:
> >
> > Hi all,
> >
> > In pursuing this issue, I downloaded the kernel source to see if I
> > could debug it further.  In so doing, it looks like Christian's patch
> > was never committed to the main source tree (sorry if my terminology
> > is wrong).  This is up to and including the 6.3-rc1.  I could also
> > find no mention of the fix in the log.
> >
> > I am trying to manually apply this patch now, but, I am wondering if
> > there was some reason that it was not applied (e.g. it introduces some
> > instability?)?
>
> It's fixing the bug in the wrong place, i.e. it's checking for an
> -ENOSYS return from vfs_fileattr_get(), but that return value is not
> valid at that point.
>
> The right way to fix this bug is to prevent -ENOSYS from being
> returned in the first place.
>
> Commit 02c0cab8e734 ("fuse: ioctl: translate ENOSYS") fixes one of
> those bugs, but of course it's possible that I missed something in
> that fix.
>
> Can you please first verify that an upstream kernel (>v6.0) can also
> reproduce this issue?

Got ya.  that makes a lot of sense, thank you.

I have confirmed that I continue to get the error with 6.2 .
quick summary of the lowerdir:
   server ---- NFS(ro) ---- > client "/nfs"
   client "/nfs" --- bindfs(uidmap) --- > client "/lower"






>
> Thanks,
> Miklos
>
>
>
> >
> > Thank you,
> > Jonathan
> >
> >
> >
> > On Thu, Feb 23, 2023 at 3:11=E2=80=AFPM Jonathan Katz <jkatz@eitmlabs.o=
rg> wrote:
> > >
> > > Hi all,
> > >
> > > Problem persists with me with 6.2.0
> > > # mainline --install-latest
> > > # reboot
> > >
> > > # uname -r
> > > 6.2.0-060200-generic
> > >
> > >
> > > Representative log messages when mounting:
> > > Feb 23 22:50:43 instance-20220314-1510-fileserver-for-overlay kernel:
> > > [   44.641683] overlayfs: null uuid detected in lower fs '/', falling
> > > back to xino=3Doff,index=3Doff,nfs_export=3Doff.
> > >
> > >
> > >
> > > Representative log messages when accessing files:
> > > eb 23 23:06:31 instance-20220314-1510-fileserver-for-overlay kernel: =
[
> > >  992.505357] overlayfs: failed to retrieve lower fileattr (8020
> > > MeOHH2O RecoverySample2-20221219-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1=
722.d/Storage.mcf_idx,
> > > err=3D-38)
> > > Feb 23 23:06:32 instance-20220314-1510-fileserver-for-overlay kernel:
> > > [  993.523712] overlayfs: failed to retrieve lower fileattr (8020
> > > MeOHH2O RecoverySample2-20221219-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1=
722.d/Storage.mcf_idx,
> > > err=3D-38)
> > >
> > >
> > > On Mon, Jan 30, 2023 at 11:27 AM Jonathan Katz <jkatz@eitmlabs.org> w=
rote:
> > > >
> > > > On Thu, Jan 26, 2023 at 5:26 AM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
> > > > >
> > > > > On Wed, 18 Jan 2023 at 04:41, Jonathan Katz <jkatz@eitmlabs.org> =
wrote:
> > > > >
> > > > > > I believe that I am still having issues occur within Ubuntu 22.=
10 with
> > > > > > the 5.19 version of the kernel that might be associated with th=
is
> > > > > > discussion.  I apologize up front for any faux pas I make in wr=
iting
> > > > > > this email.
> > > > >
> > > > > No need to apologize.   The fix in question went into v6.0 of the
> > > > > upstream kernel.  So apparently it's still missing from the distr=
o you
> > > > > are using.
> > > >
> > > > Thank you for the reply! ---  I have upgraded the Kernel and it sti=
ll
> > > > seems to be throwing errors.  Details follow:
> > > >
> > > > Distro: Ubuntu 22.10.
> > > > Upgraded kernel using mainline (mainline --install-latest)
> > > >
> > > > # uname -a
> > > > Linux instance-20220314-1510-fileserver-for-overlay
> > > > 6.1.8-060108-generic #202301240742 SMP PREEMPT_DYNAMIC Tue Jan 24
> > > > 08:13:53 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> > > >
> > > > On mount I still get the following notice in syslog (representative=
):
> > > > Jan 30 19:11:46 instance-20220314-1510-fileserver-for-overlay kerne=
l:
> > > > [   71.613334] overlayfs: null uuid detected in lower fs '/', falli=
ng
> > > > back to xino=3Doff,index=3Doff,nfs_export=3Doff.
> > > >
> > > > And on access (via samba) I still see the following errors in the
> > > > syslog (representative):
> > > > Jan 30 19:19:34 instance-20220314-1510-fileserver-for-overlay kerne=
l:
> > > > [  539.181858] overlayfs: failed to retrieve lower fileattr (8020
> > > > MeOHH2O RecoverySample2-20221219-A-JJL-WebinarHilic10C-TOF-TT54-Neg=
-1722.d/Storage.mcf_idx,
> > > > err=3D-38)
> > > >
> > > > And on the Windows client, the software still fails with the same s=
ymptomology.
> > > >
> > > >
> > > >
> > > >
> > > > >
> > > > > > An example error from our syslog:
> > > > > >
> > > > > > kernel: [2702258.538549] overlayfs: failed to retrieve lower fi=
leattr
> > > > > > (8020 MeOHH2O
> > > > > > RecoverySample2-20221219-A-JJL-WebinarHilic10C-TOF-TT54-Neg-172=
2.d/analysis.tsf,
> > > > > > err=3D-38)
> > > > >
> > > > > Yep, looks like the same bug.
> > > > >
> > > > > Thanks,
> > > > > Miklos
