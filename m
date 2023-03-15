Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCC76BA554
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 03:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCOCn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 22:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCOCnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:43:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD7B5245
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 19:43:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z21so4688575edb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 19:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eitmlabs-org.20210112.gappssmtp.com; s=20210112; t=1678848231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xv/KwFdMS345PsD2cRZ5r2isPNxArVDf2kl5yWiyxg4=;
        b=oSUr1P3Mh2bnvl5YbmLojhXl3hKajgoP4UUJ0h2WpN3yPv8TqkzQzzPDrI6BQcZ2ox
         8KCJXE/bK6C/oROKXSw1AIo9GGzjuQTKbjgSN/fGtRAUhH0XcBkxEzc0NeDAAX0enBmA
         im/JL1xwbQmVTUGmLwvh6wTufkMwB11K0/8TMT64cflL1SjwUeemQ0QOIXSyknU0dc36
         2jQS1p0QJPNiJmaqAH6qDlgpcLhcxvDD5gfrf8QYZgBOKhp2wJcGskAHLt9Ivg/0u52b
         NVKRtNTFLTRjvhLZA3m7YpHtwN+7jt8SrXMIX09E4HHZl6/ONYEVygfwpJ6/YF4I8o+2
         T5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678848231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xv/KwFdMS345PsD2cRZ5r2isPNxArVDf2kl5yWiyxg4=;
        b=fKf0H42x6V52VfcBZKLw/fldtAHP/YWPJPEmyvwzqxv5v9sLdNhh9AXXLLSBnU0YOl
         btgoy8uYbYQkmSD/J8uC4aoZvt9D6NDxUT0yNqDUPxvnhkchJieZ3RJMak8T83SLEbhw
         rFKP7TJU8Hw5gTVsN0Gi4DAUcgkNRk4GtUDz5H9wX4PbjsGe3eeZQQCv8VFvnaIu/Vq0
         6t6clhWLuROM3FTR3VTaf4l0DAxoYbTLj9V+eklf4SFKUn9QCoc7Uz5f9kdbxi7G4OAB
         5JYgxvrpNLheMu+3kFRFiIpWtXW+SBle0E/FQtppDCoOr0Fw1iVUP8eZwXlKk87JyNze
         Obig==
X-Gm-Message-State: AO0yUKWKbS5kf0KZcsf3E7bxuK+GirhXdpGsrSmf4ULOLfX8KeM+zxwt
        fO/sZDkXJGVXlRMXjuT0tmRbxr7ieSX0eg4ouLARiw==
X-Google-Smtp-Source: AK7set8Icq2mcZlatdiH3bxNqw9x8fpR+kvFgydUcVFMGgpA698EXIWcPQ0r/BKLCPUo3rcc6VtjdlCvYpswKWOgsfc=
X-Received: by 2002:a50:9f64:0:b0:4fa:71a2:982b with SMTP id
 b91-20020a509f64000000b004fa71a2982bmr597589edf.0.1678848231309; Tue, 14 Mar
 2023 19:43:51 -0700 (PDT)
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
 <CALKgVmcC1VUV_gJVq70n--omMJZUb4HSh_FqvLTHgNBc+HCLFQ@mail.gmail.com> <CAJfpegt0rduBcSqSR=XmQ8bd_ws7Qy=4pxVF0_iysfc7wFagQQ@mail.gmail.com>
In-Reply-To: <CAJfpegt0rduBcSqSR=XmQ8bd_ws7Qy=4pxVF0_iysfc7wFagQQ@mail.gmail.com>
Reply-To: jonathan@eitm.org
From:   Jonathan Katz <jkatz@eitmlabs.org>
Date:   Tue, 14 Mar 2023 19:43:34 -0700
Message-ID: <CALKgVmdyQwXcwQHBNEzE7XsCYmqQFeNLXZ5-hTPErjYz4PvgaQ@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 9, 2023 at 7:31=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Tue, 7 Mar 2023 at 18:14, Jonathan Katz <jkatz@eitmlabs.org> wrote:
> >
> > On Tue, Mar 7, 2023 at 12:38=E2=80=AFAM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> > >
> > > On Tue, 7 Mar 2023 at 02:12, Jonathan Katz <jkatz@eitmlabs.org> wrote=
:
> > > >
> > > > Hi all,
> > > >
> > > > In pursuing this issue, I downloaded the kernel source to see if I
> > > > could debug it further.  In so doing, it looks like Christian's pat=
ch
> > > > was never committed to the main source tree (sorry if my terminolog=
y
> > > > is wrong).  This is up to and including the 6.3-rc1.  I could also
> > > > find no mention of the fix in the log.
> > > >
> > > > I am trying to manually apply this patch now, but, I am wondering i=
f
> > > > there was some reason that it was not applied (e.g. it introduces s=
ome
> > > > instability?)?
> > >
> > > It's fixing the bug in the wrong place, i.e. it's checking for an
> > > -ENOSYS return from vfs_fileattr_get(), but that return value is not
> > > valid at that point.
> > >
> > > The right way to fix this bug is to prevent -ENOSYS from being
> > > returned in the first place.
> > >
> > > Commit 02c0cab8e734 ("fuse: ioctl: translate ENOSYS") fixes one of
> > > those bugs, but of course it's possible that I missed something in
> > > that fix.
> > >
> > > Can you please first verify that an upstream kernel (>v6.0) can also
> > > reproduce this issue?
> >
> > Got ya.  that makes a lot of sense, thank you.
> >
> > I have confirmed that I continue to get the error with 6.2 .
> > quick summary of the lowerdir:
> >    server ---- NFS(ro) ---- > client "/nfs"
> >    client "/nfs" --- bindfs(uidmap) --- > client "/lower"
>
> Can you please run bindfs in debugging mode (-d) and send the
> resulting log after reproducing the issue?
>
> Thanks,
> Miklos

OUCH -- MY LAST EMAIL WAS REJECTED FOR BEING TOO BIG
I HOPE THAT I AM SUMMARIZING THE RELEVANT INFORMATION HERE:


Hi Miklos, thank you.... I am sorry for the delay.

The log is somewhat long and was sent in a separate email.

I broke up the log into entries to try to match the chronology of actions:
   * ENTRY 1 nfs mount the external drive
   * ENTRY 2 perform the bind fs
   * ENTRY 3 perform the overlay
   * ENTRY 4 restart smb
   * ENTRY 5 mount the filesystem on a windows box
   * ENTRY 6 performing some navigation on the windows file explorer
   * ENTRY 7 attempt to open a data file with the windows application.

The only place that generated a kernel error in dmesg was at ENTRY 7.

Because the logs are so big, I tried to parse them, I may have made a
mistake or omitted information -- if you think so, as mentioned, the
full bindfs logs were sent separately


Here is my attempt to parse out the errors associated with this dmesg entry=
:

[ 1925.705908] overlayfs: failed to retrieve lower fileattr (8020
MeOHH2O RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/=
chromatography-data.sqlite,
err=3D-38)

--
unique: 1550, opcode: GETXATTR (22), nodeid: 71, insize: 73, pid: 3458
getxattr /eimstims1/deleteme2/8020 MeOHH2O
RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chromato=
graphy-data-pre.sqlite
trusted.overlay.metacopy 0
   unique: 1550, error: -95 (Operation not supported), outsize: 16
--
unique: 3922, opcode: GETXATTR (22), nodeid: 71, insize: 72, pid: 3458
getxattr /eimstims1/deleteme2/8020 MeOHH2O
RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chromato=
graphy-data-pre.sqlite
system.posix_acl_access 132
   unique: 3922, error: -95 (Operation not supported), outsize: 16
--
unique: 3954, opcode: GETXATTR (22), nodeid: 71, insize: 72, pid: 3458
getxattr /eimstims1/deleteme2/8020 MeOHH2O
RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chromato=
graphy-data-pre.sqlite
system.posix_acl_access 132
   unique: 3954, error: -95 (Operation not supported), outsize: 16
--
unique: 3960, opcode: GETXATTR (22), nodeid: 71, insize: 72, pid: 3458
getxattr /eimstims1/deleteme2/8020 MeOHH2O
RecoverySample1-20221216-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1632.d/chromato=
graphy-data-pre.sqlite
system.posix_acl_access 132
   unique: 3960, error: -95 (Operation not supported), outsize: 16


Thank you again!

-Jonathan
