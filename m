Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585396C53EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 19:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCVSmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 14:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjCVSm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:42:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E9164B31
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 11:42:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o12so76826597edb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eitmlabs-org.20210112.gappssmtp.com; s=20210112; t=1679510536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GTe3n7OwhSgzqoIQ2iOIM4yrg4KI4oJcuqkh7kjwuXY=;
        b=Q7bonuSCkCN8hOjv0FPyTNs60RcvkqrFId4E5FbWUJ0wtMACXvUUMVeMKIwoLkWLqA
         LrWPyh5OkOVQgRebCaUkZBcqYNnNc4+iemm6IC5Vd+fGprLqdQjxxFfqpBRFh8VvcJA7
         FkK83VXh164YCND2Y12dTFBaZTKKXj+muuDOFLLsd7R37/RAg7j0vNkkh5TRsZ+z/BgN
         kkwvPi3/yciyC67pQ7+X4FBbZIWtgZ7C98gvv8gk3Wjl5/8jskVofYI+wp4UQl+8jw1F
         GonTueDZcE4QHTwDOrqj8e1uLY/YlsJAvBnb6e2n9ks3fMiV90c+9vI4c9t6kdj/LWBt
         130A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679510536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTe3n7OwhSgzqoIQ2iOIM4yrg4KI4oJcuqkh7kjwuXY=;
        b=2at5G2ZBh9MOZFLHzqeh3ueQCEAGfHkb3WdMi9V97VUxNef8ajM4O+uTJBZkKbgPLl
         MUr2CuOPNY7fcjCys38XqfDl6qgk5LBV28nbflhbFnWlbymqTYXs76gFsKPhnLUZ76u/
         4UvJ/enJkdJwVXcNpFX5Zx1rlpMNtiwCQe1qUzl3Esh+OB+vpo+yTdQERs1ggEqfaABy
         Krh0e1qppx/xNDElLFYqqldCHyCZvbUOhap+LLBG7vAOG/HaCp2qN6oqDxFHogmyBG1+
         +PYXk+mwtk5nK0F3QrTRfoK6HlUjWO6kaLmIajgMGZY/DOihLzzKEKaVJ7obEoTwQAwP
         OikQ==
X-Gm-Message-State: AO0yUKW5+bRMQbzHNCljnh8rUx/V7xnWV2lsta+YirVZ2rYop6iw/Adj
        CivXOmUQHOkVQlz6LY9N2bNHFCUXR0jzxaHF6eODWA==
X-Google-Smtp-Source: AK7set9OwQl4tQH3N94ZDG+acssBbhWTsr4FduMnFN8SVEnueMIs6/QUQRrMzUL6yWi0UBkT8ZC3ISY80DHvT16gEio=
X-Received: by 2002:a50:9ecb:0:b0:501:d489:f797 with SMTP id
 a69-20020a509ecb000000b00501d489f797mr4142134edf.1.1679510535961; Wed, 22 Mar
 2023 11:42:15 -0700 (PDT)
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
 <CALKgVmfZdVnqMAW81T12sD5ZLTO0fp-oADp-WradW5O=PBjp1Q@mail.gmail.com>
 <CAJfpeguKVzCyUraDQPGw6vdQFfPwTCuZv0JkMxNA69AiRib3kg@mail.gmail.com>
 <CALKgVmcC1VUV_gJVq70n--omMJZUb4HSh_FqvLTHgNBc+HCLFQ@mail.gmail.com>
 <CAJfpegt0rduBcSqSR=XmQ8bd_ws7Qy=4pxVF0_iysfc7wFagQQ@mail.gmail.com> <CALKgVmdyQwXcwQHBNEzE7XsCYmqQFeNLXZ5-hTPErjYz4PvgaQ@mail.gmail.com>
In-Reply-To: <CALKgVmdyQwXcwQHBNEzE7XsCYmqQFeNLXZ5-hTPErjYz4PvgaQ@mail.gmail.com>
Reply-To: jonathan@eitm.org
From:   Jonathan Katz <jkatz@eitmlabs.org>
Date:   Wed, 22 Mar 2023 11:42:00 -0700
Message-ID: <CALKgVmeohJVEreXdb1OH3x9VS4O5VMpR+82=QFbk0+95y3xyYA@mail.gmail.com>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Confirmed bindfs interaction:

Based on your bindfs comment I redid my configuration as follows:
ORIGINAL  (FAILS):
    FS1 - exports "/Data"  (nfs)
    FS2 - Mounts "/Data", does a bindfs, does an overlay

TEST (SUCCEEDS):
    FS1 - does a bindfs and exports a series of directories:
              # bindfs -u 5007, -g 5007 /Data /Data-jiajun
              /etc/exports:
                    /Data  machine.org(ro,sync,no_subtree_check)
                    /Data-jiajun machine.org(ro,fsid=3D12,sync,no_subtree_c=
heck)
     FS2 - used to do bindfs to make the lowers, but, now mounts
"/Data-jiajun" as the lower
               FS2 then does the overlay and samba share.
                It would not let me do the 2nd export if I did not
include the fsid entry....

WOOT WOOT.


Not an ideal solution as I have to make changes to 2 servers in order
to accomplish my goal :/.








On Tue, Mar 14, 2023 at 7:43=E2=80=AFPM Jonathan Katz <jkatz@eitmlabs.org> =
wrote:
>
> On Thu, Mar 9, 2023 at 7:31=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Tue, 7 Mar 2023 at 18:14, Jonathan Katz <jkatz@eitmlabs.org> wrote:
> > >
> > > On Tue, Mar 7, 2023 at 12:38=E2=80=AFAM Miklos Szeredi <miklos@szered=
i.hu> wrote:
> > > >
> > > > On Tue, 7 Mar 2023 at 02:12, Jonathan Katz <jkatz@eitmlabs.org> wro=
te:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > In pursuing this issue, I downloaded the kernel source to see if =
I
> > > > > could debug it further.  In so doing, it looks like Christian's p=
atch
> > > > > was never committed to the main source tree (sorry if my terminol=
ogy
> > > > > is wrong).  This is up to and including the 6.3-rc1.  I could als=
o
> > > > > find no mention of the fix in the log.
> > > > >
> > > > > I am trying to manually apply this patch now, but, I am wondering=
 if
> > > > > there was some reason that it was not applied (e.g. it introduces=
 some
> > > > > instability?)?
> > > >
> > > > It's fixing the bug in the wrong place, i.e. it's checking for an
> > > > -ENOSYS return from vfs_fileattr_get(), but that return value is no=
t
> > > > valid at that point.
> > > >
> > > > The right way to fix this bug is to prevent -ENOSYS from being
> > > > returned in the first place.
> > > >
> > > > Commit 02c0cab8e734 ("fuse: ioctl: translate ENOSYS") fixes one of
> > > > those bugs, but of course it's possible that I missed something in
> > > > that fix.
> > > >
> > > > Can you please first verify that an upstream kernel (>v6.0) can als=
o
> > > > reproduce this issue?
> > >
> > > Got ya.  that makes a lot of sense, thank you.
> > >
> > > I have confirmed that I continue to get the error with 6.2 .
> > > quick summary of the lowerdir:
> > >    server ---- NFS(ro) ---- > client "/nfs"
> > >    client "/nfs" --- bindfs(uidmap) --- > client "/lower"
> >
> > Can you please run bindfs in debugging mode (-d) and send the
> > resulting log after reproducing the issue?
> >
> > Thanks,
> > Miklos
>
> OUCH -- MY LAST EMAIL WAS REJECTED FOR BEING TOO BIG
> I HOPE THAT I AM SUMMARIZING THE RELEVANT INFORMATION HERE:
>
>
> Hi Miklos, thank you.... I am sorry for the delay.
>
> The log is somewhat long and was sent in a separate email.
>
> I broke up the log into entries to try to match the chronology of actions=
:
>    * ENTRY 1 nfs mount the external drive
>    * ENTRY 2 perform the bind fs
>    * ENTRY 3 perform the overlay
>    * ENTRY 4 restart smb
>    * ENTRY 5 mount the filesystem on a windows box
>    * ENTRY 6 performing some navigation on the windows file explorer
>    * ENTRY 7 attempt to open a data file with the windows application.
>
> The only place that generated a kernel error in dmesg was at ENTRY 7.
>
> Because the logs are so big, I tried to parse them, I may have made a
> mistake or omitted information -- if you think so, as mentioned, the
> full bindfs logs were sent separately
>
>
> Here is my attempt to parse out the errors associated with this dmesg ent=
ry:
>
> [ 1925.705908] overlayfs: failed to retrieve lower fileattr (8020
> MeOHH2O RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.=
d/chromatography-data.sqlite,
> err=3D-38)
>
> --
> unique: 1550, opcode: GETXATTR (22), nodeid: 71, insize: 73, pid: 3458
> getxattr /eimstims1/deleteme2/8020 MeOHH2O
> RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chroma=
tography-data-pre.sqlite
> trusted.overlay.metacopy 0
>    unique: 1550, error: -95 (Operation not supported), outsize: 16
> --
> unique: 3922, opcode: GETXATTR (22), nodeid: 71, insize: 72, pid: 3458
> getxattr /eimstims1/deleteme2/8020 MeOHH2O
> RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chroma=
tography-data-pre.sqlite
> system.posix_acl_access 132
>    unique: 3922, error: -95 (Operation not supported), outsize: 16
> --
> unique: 3954, opcode: GETXATTR (22), nodeid: 71, insize: 72, pid: 3458
> getxattr /eimstims1/deleteme2/8020 MeOHH2O
> RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chroma=
tography-data-pre.sqlite
> system.posix_acl_access 132
>    unique: 3954, error: -95 (Operation not supported), outsize: 16
> --
> unique: 3960, opcode: GETXATTR (22), nodeid: 71, insize: 72, pid: 3458
> getxattr /eimstims1/deleteme2/8020 MeOHH2O
> RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chroma=
tography-data-pre.sqlite
> system.posix_acl_access 132
>    unique: 3960, error: -95 (Operation not supported), outsize: 16
>
>
> Thank you again!
>
> -Jonathan
