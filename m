Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 000701667DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgBTUAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 15:00:17 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36275 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgBTUAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:00:17 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so24722515iln.3;
        Thu, 20 Feb 2020 12:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hz+DKsj82X4tdj83FZa6Kg4xxF0FGCDR16OLCe3Lc5k=;
        b=KAtcqCNZ4K4H9jRXFSYY2AI5xegS847mVyu/+kOkKrZM/w/U935ZNLfsSbu0e9AKhC
         /T9DWXwyt9RvfoBkw2Oj+kHIEuxd/nryNGJeR6kDDYArgFAl4mFyp6JVmREm3LpaiqSR
         SMbUbWYUtTJ9w1MrVmaYWoKTDd9p4OKTAkwe0OxaeufxKW0Ed6P3vFzdoo5uTmJcPZWr
         6GAgwXlP2mS+/iLtXIJxGr9Z1jNAejfyYwUyTA/o0uHI3ShEybWovcPphY66DZZAqhjl
         yWjWSp0tYciy9ehjqFP14vJ2DQH3NSwhR8htVH5WQ9s6mZY7Vo4FL90zi3NIkrGIrpxf
         qIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hz+DKsj82X4tdj83FZa6Kg4xxF0FGCDR16OLCe3Lc5k=;
        b=Sf86vikzVPbTLMltn1c/AAURZlJG8WMEFz/Q+wAre4Hbmddh4+LNEhLZMV3Cv9gCWW
         7mN0ugSG9CJgQvEls67AAamwOQjQswW0yNCuF1AJJ/DLF5x2U45Stfs9nV8gzB49CwAa
         p1Wio/Vz+XSAU2z82sXPsuvK10sMFc9qElAE16Qoyb3c0o/KfQ7IrYoRazqOfYaVCaif
         VX7QwYotZb9i5qTGmjsealDp5r5seVeL9YCef3dHtiGTrMNXSXATHID3G6Z0berfzDqb
         oTE6eteVPcAdtpg4Fq9p94FIz3ix6whJXCnH5BWiGw2Jryg6f7sF8YXefKE5+HsEih12
         vsgQ==
X-Gm-Message-State: APjAAAWtvc8SIZ7m9LarHPwmDkwIPS959L+MogTrUNOC88YtRdwbvX/2
        TWWe5WWhrm8b0/9BXXu3zPZi3+taaySYpX4Lb/Q=
X-Google-Smtp-Source: APXvYqwXs3IjemdzTD0tPMYGcRBe1+KGJFOflXyX/3N7UcQRkTWgVSGHNqCOaf0cK3nw/kLawCcKZoEUD4Xv4LR2MVY=
X-Received: by 2002:a92:9c8c:: with SMTP id x12mr31320588ill.275.1582228816324;
 Thu, 20 Feb 2020 12:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <20200204145951.GC11631@redhat.com> <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
 <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com> <CAOQ4uxjFYO28r+0pY+pKxK-dDJcQF2nf2EivnOUBgrgkYTFjPQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjFYO28r+0pY+pKxK-dDJcQF2nf2EivnOUBgrgkYTFjPQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 20 Feb 2020 22:00:05 +0200
Message-ID: <CAOQ4uxhZ8a2ObfB9sUtrc=95mM70qurLtXkaNyHOXYxGEKvxFw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 9:52 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Feb 4, 2020 at 7:02 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Feb 4, 2020 at 6:17 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Tue, Feb 4, 2020 at 3:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Fri, Jan 31, 2020 at 12:50:04PM +0100, Miklos Szeredi wrote:
> > > > > No reason to prevent upper layer being a remote filesystem.  Do the
> > > > > revalidation in that case, just as we already do for lower layers.
> > > > >
> > > > > This lets virtiofs be used as upper layer, which appears to be a real use
> > > > > case.
> > > >
> > > > Hi Miklos,
> > > >
> > > > I have couple of very basic questions.
> > > >
> > > > - So with this change, we will allow NFS to be upper layer also?
> > >
> > > I haven't tested, but I think it will fail on the d_type test.
> >
> > But we do not fail mount on no d_type support...
> > Besides, I though you were going to add the RENAME_WHITEOUT
> > test to avert untested network fs as upper.
> >
>
> Pushed strict remote upper check to:
> https://github.com/amir73il/linux/commits/ovl-strict-upper
>
> FWIW, overlayfs-next+ovl-strict-upper passes the quick xfstests,
> except for overlay/031 - it fails because the RENAME_WHITEOUT check
> leaves behind a whiteout in workdir.
> I think it it is not worth to cleanup that whiteout leftover and
> easier to fix the test.

Nevermind. Fixed the whiteout cleanup and re-pushed.

Thanks,
Amir.
