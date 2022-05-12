Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8D5247BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351375AbiELIQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351373AbiELIQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 04:16:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0831B43AE7;
        Thu, 12 May 2022 01:16:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso4206845pjb.5;
        Thu, 12 May 2022 01:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1RNkyHw4cxdvcq3ilcwkh6SqZBQf4i1CPA0FxFQUbtA=;
        b=Ww1dHTlqBOxOmJeBXT1UeXm2Ze3bm5xgZkRta9IRE4JaKCgQaYCMEbK+H61d760O4H
         +qYbYgPSUwkkjwF5G6J63zr5L46yiNT8ztSq2NxZopZkLAbANejewmJW/Mu+pn/6F7Uc
         kCxkt7L3Oymf3lEIovr6ZHrD5g942OQGnbnDOhZrvU3JpQauOIc7PsUzwcujRX0PMcnB
         woY/uL4H70w2TFpOnCVACy63AYPNtjCfznFR5dN+8StA46QVwV2CnAC54SMx58ypIVoN
         APVq+FpkiBYGHWPFJqbTWuhKEFmPOaojhv/t8ZRJCAy2pt5CFK86Jv/CYljlMVQC4uiH
         i0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1RNkyHw4cxdvcq3ilcwkh6SqZBQf4i1CPA0FxFQUbtA=;
        b=a8ixMU4Co40HcsIJo//e/gwIHdMFhAVjBJ8mtF9XPZvEzk8fJtuLz8KIT5pWtMRWvb
         BirkEMYYZKPwDNLmQEVlkYsA5vmj1PeGlpaAqDGzFtFS4rmWn2XIH4rjRU8KZupZ5v6P
         982dPEuhM5EwIO45nlh0F2/kKONzXwUxztebwtQwAaRqRKc+nUnvVOMrvSyq+5FUTXIz
         +tfA/tOBpvjVCD3dmF2LT+0k8ACIt2nUeMUz+1j3XmbHv6/g0YzG+iH2P2qtI/U4l8jw
         naa3yaJHUfgaNCuyI/WFh4w4wrzIyNRHiHvowXfMZ1EaedIoSk8/eayZ8eU8W7nk1PgX
         oD2w==
X-Gm-Message-State: AOAM532J7VcszRiEnrQspv+h586ZGRFBXxPmWKDCVyo/GskQOIpjCYLO
        HT3fjL45tl9B5KDs5ne1gk9ZDphmi2zLghT0enNz7PGNxnA=
X-Google-Smtp-Source: ABdhPJyUe1/gU1YTFoYXyof0mkoQAgo/dWFLGhWHAZ/QsusGlcfM72vKFEwoVn1qBduL7T6GOMtJU68YNPSStWOznuw=
X-Received: by 2002:a17:902:e809:b0:15e:c67d:14c5 with SMTP id
 u9-20020a170902e80900b0015ec67d14c5mr28623742plg.13.1652343384404; Thu, 12
 May 2022 01:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <YnLRnR3Xqu0cYPdb@redhat.com> <CACUYsyEsRph+iFC_fj3F6Ceqhq7NCTuFPH3up8R6C+_bGHktZg@mail.gmail.com>
 <YnPI6f2fRZUXbCFP@redhat.com> <882fbf7f-a56b-1e82-a158-9e2186ec7c4c@ddn.com>
 <YnQsizX5Q1sMnlI2@redhat.com> <CAJfpegseGaWHkjdQj7XiR=TQNFpPZzDF_rTXces2oRz=x0N7OA@mail.gmail.com>
 <YnvwiZ+s+y3VDUMW@redhat.com> <YnwOwS/bmUkbazeL@redhat.com>
In-Reply-To: <YnwOwS/bmUkbazeL@redhat.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Thu, 12 May 2022 13:46:12 +0530
Message-ID: <CACUYsyGTR54tX8xqBqJ2LUfWO-rV0LqgBfy0xOv7f-dq65BX8Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 1:00 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, May 11, 2022 at 01:21:13PM -0400, Vivek Goyal wrote:
> > On Wed, May 11, 2022 at 11:40:59AM +0200, Miklos Szeredi wrote:
> > > On Thu, 5 May 2022 at 21:59, Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > > Oh, I have no issues with the intent. I will like to see cut in net=
work
> > > > traffic too (if we can do this without introducing problems). My pr=
imary
> > > > interest is that this kind of change should benefit virtiofs as wel=
l.
> > >
> > > One issue with that appears to be checking permissions.   AFAIU this
> > > patchset only enables the optimization if default_permissions is
> > > turned off (i.e. all permission checking is done by the server).  But
> > > virtiofs uses the default_permissions model.
> >
> > IIUC, only 3rd patch mentions that default_permission should be turned
> > off. IOW, first patch where lookup + create + open is a single operatio=
n
> > and second patch which does "lookup + open" in a single operation does
> > not seem to require that default_permissions are not in effect.
> >
> > So if first two patches work fine, I think virtiofs should benefit too.
> > (IMHO, 3rd patch is too hacky anyway)
> >
> > W.r.t permission checks, looks like may_open() will finally be called
> > after ->atomic_open(). So even if we open the file, we should still be
> > able to check whether we have permissions to open the file or not
> > after the fact.
> >
> > fs/namei.c
> >
> > path_openat()
> > {
> >       open_last_lookups()  <--- This calls ->atomic_open()
> >       do_open()  <--- This calls may_open()
> > }
>
> Actually I am not sure about it. I was playing with
>
> open(foo.txt, O_CREAT | O_RDWR, O_IRUSR)
>
> This succeeds if file is newly created but if file already existed, this
> fails with -EACCESS
>
> So man 2 open says following. Thanks to Andy Price for pointing me to it.
>
>     Note that mode applies only to future accesses of the newly cre=E2=80=
=90
>     ated  file;  the  open()  call that creates a read-only file may
>     well return a read/write file descriptor.
>
>
> Now I am wondering how will it look like with first patch. Assume file
> already exists on the server (But there is no negative dentry present)
> and I do following. And assume file only has read permission for user
> and I am trying to open it read-write.
>
> open(foo.txt, O_CREAT | O_RDWR, O_IRUSR)
>
> In normal circumstances, user will expect -EACCESS as file is read-only
> and user is trying to open it read-write.
>
> I am wondering how will it look like with this first patch.
>
> Current fuse ->atomic_open() looks up the dentry and does not open
> the file if dentry is positive.
>
> New implementation will skip lookup and open the file anyway and
> set file->f_mode |=3D FMODE_CREATED; (First patch in series)
>
> So first of all this seems wrong. I thought FMODE_CREATED should be
> set only if file was newly created. Is that a correct understanding.

You are right. we should mark in f_mode only if the file was actually creat=
ed.
Thanks for catching this. Appreciate your efforts:)

>
> And I am looking at do_open() code. It does bunch of things based
> on FMODE_CREATED flag. One of the things it does is reset acc_mode =3D0
>
>         if (file->f_mode & FMODE_CREATED) {
>                 /* Don't check for write permission, don't truncate */
>                 open_flag &=3D ~O_TRUNC;
>                 acc_mode =3D 0;
>         }
>         error =3D may_open(mnt_userns, &nd->path, acc_mode, open_flag);
>
> I suspect this is the code which allows opening a newly created read-only
> file as O_RDWR. (Though I am not 100% sure).

Correct. I could see it.

>
> I suspect with first patch this will be broken. We will set FMODE_CREATED
> even if file already existed and VFS will assume a new file has been
> created and do bunch of things which is wrong.
>
> So looks like fuse ->atomic_open() should set FMODE_CREATED only if
> it really created the file.

This looks like an obvious bug with new patches. But If I do not miss
anything then its a bug on distributed file systems with current code
as well.
It could happen this way(Taking your example which is perfect to trace
this on distributed systems):
Lets start with File is non-existent yet on the file system. There
comes the first client which does a lookup on the file, it does not
find the file. Meanwhile another client created the file on the File
system. Now  when this first client goes to create the file, before
going down it sets FMODE_CREATED on the file handle and then goes down
the lower layers. It comes back with inode but f->mode as
FMODE_CREATED which is incorrect. This mode then results in acc_mode
being set to zero which then allows access to the file as O_RDWR.

I think Miklos proposed to return the flag from user space if the file
was actually created, this would solve two problems 1) this access
problem and code execution going the wrong path 2) correct update if
parent dir changed or not.
