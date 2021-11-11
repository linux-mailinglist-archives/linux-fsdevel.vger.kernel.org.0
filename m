Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E413644CF15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 02:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhKKBlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 20:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhKKBlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:41:45 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C2C061766
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 17:38:57 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id k83so1583593vke.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 17:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oHV9y7kOp6mxZvvGYbcZCGcroNkENuUom/GnZmfXJSI=;
        b=S6SqjEhkI3qzFIz1d7SjY2MTbtSP2oNEbjDF1qplmd4E/IE5edW4CQQ9TErpspqnGL
         4nOqRwZbWS/IwFJ1Y2PqWXAmprcH4Bwb0AXCntiHl1SZtSMuXLUBjflj0gTd7zSnUywl
         QOPLJBb3TOqULhbWSKB9bYvlW5reMHVAX+gfd9HLMKEguGJwTIXdEaZ4VySqmL5b7D7E
         J/IDlbUODj22BMcQ8ZEaJzbLOXrgU9qxhUAMNCx+tE0hMyVw6uBZtsI+Qwx8BwayhBWf
         toAOOjFJNauOiUeVGpHs78vYVn9MGx5ZgQxm5YCeJ/+sQMSaUE3BEP6Er7sfEmQ8tyXh
         Ewvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oHV9y7kOp6mxZvvGYbcZCGcroNkENuUom/GnZmfXJSI=;
        b=K0yyUBQ0z76wWbjajSADvPLOHPhi9OxobtryiYqANvrpdUIVkbXBbGjgXCyxCxB7Xn
         DXmrQYANcxOqqYdicYLdjjXlcgOAD/3NRIaec3drhJQ6NYMpLgCsdg1rhSgkIf5/08+F
         c431DrIy9ZgmK07VFy9zVlrLmfvEEaRO5fzpIFqmJZgJlMZ4kVBOuya5yAdX7yz5t+Sh
         5gTytZmxess67LwityjWlHAys2xum2uLb4THWqbuqJn88gxpS8lwyH5uQ2HyFcRBwy85
         pE3iUxnCypWmdK2X9w5qMHLJQFj5pGnSU4rrQja88qp3SKlEuYawOYIB1OX+SQCQLcQ3
         SVGw==
X-Gm-Message-State: AOAM530mSs7jz6JHxd54Lk4FlzvB++ILiW7+BMW3c5bSXUAY53K3zB6D
        2ER6Zo/o9TzoxbNOBO4D4qqY3gSjK6RqYJ6yGVxnFxxPm67luw==
X-Google-Smtp-Source: ABdhPJxd57wFkYjwbmtVWeFeEhVG/oythhx9UAJe/C3le4Il3TknCdOn6KJlWa2iGEMq1eoguIDyMSmAY2D3Jm0f4us=
X-Received: by 2002:a1f:a857:: with SMTP id r84mr5441080vke.0.1636594736528;
 Wed, 10 Nov 2021 17:38:56 -0800 (PST)
MIME-Version: 1.0
References: <CAPm50a+j8UL9g3UwpRsye5e+a=M0Hy7Tf1FdfwOrUUBWMyosNg@mail.gmail.com>
 <CAJfpegtbdz-wzfiKXAaFYoW-Hqw6Wm17hhMgWMqpTCtNXgAnew@mail.gmail.com>
 <CAPm50aKJ4ckQJw=iYDOCqvm=VTYaEcfgNL52dsj+FX8pcVYNmw@mail.gmail.com>
 <CAJfpegt9J75jAXWo=r+EOmextpSze0LFDUV1=TamxNoPchBSUQ@mail.gmail.com>
 <CAPm50aLPuqZoP+eSAGKOo+8DjKFR5akWUhTg=WFp11vLiC=HOA@mail.gmail.com>
 <CAPm50aLuK8Smy4NzdytUPmGM1vpzokKJdRuwxawUDA4jnJg=Fg@mail.gmail.com> <CAJfpegs1Ue3-EFYuKfqb0jagfftgHdhDts7C7k+8hUg1eWcung@mail.gmail.com>
In-Reply-To: <CAJfpegs1Ue3-EFYuKfqb0jagfftgHdhDts7C7k+8hUg1eWcung@mail.gmail.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Thu, 11 Nov 2021 09:38:21 +0800
Message-ID: <CAPm50aJZ2Vr6O5fF+PfyF+Ec-uz+YOHJ3yhDEkiDmZWCfUQvJQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add a dev ioctl for recovery
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 10, 2021 at 6:14 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 10 Nov 2021 at 04:43, Hao Peng <flyingpenghao@gmail.com> wrote:
> >
> > On Wed, Sep 8, 2021 at 5:27 PM Hao Peng <flyingpenghao@gmail.com> wrote=
:
> > >
> > > On Wed, Sep 8, 2021 at 5:08 PM Miklos Szeredi <miklos@szeredi.hu> wro=
te:
> > > >
> > > > On Wed, 8 Sept 2021 at 04:25, Hao Peng <flyingpenghao@gmail.com> wr=
ote:
> > > > >
> > > > > On Tue, Sep 7, 2021 at 5:34 PM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> > > > > >
> > > > > > On Mon, 6 Sept 2021 at 14:36, Hao Peng <flyingpenghao@gmail.com=
> wrote:
> > > > > > >
> > > > > > > For a simple read-only file system, as long as the connection
> > > > > > > is not broken, the recovery of the user-mode read-only file
> > > > > > > system can be realized by putting the request of the processi=
ng
> > > > > > > list back into the pending list.
> > > > > >
> > > > > > Thanks for the patch.
> > > > > >
> > > > > > Do you have example userspace code for this?
> > > > > >
> > > > > Under development. When the fuse user-mode file system process is=
 abnormal,
> > > > > the process does not terminate (/dev/fuse will not be closed), en=
ter
> > > > > the reset procedure,
> > > > > and will not open /dev/fuse again during the reinitialization.
> > > > > Of course, this can only solve part of the abnormal problem.
> > > >
> > > > Yes, that's what I'm mainly worried about.   Replaying the few
> > > > currently pending requests is easy, but does that really help in re=
al
> > > > situations?
> > > >
> > > > Much more information is needed about what you are trying to achiev=
e
> > > > and how, as well as a working userspace implementation to be able t=
o
> > > > judge this patch.
> > > >
> > > I will provide a simple example in a few days. The effect achieved is=
 that the
> > > user process will not perceive the abnormal restart of the read-only =
file system
> > > process based on fuse.
> > >
> > > > Thanks,
> > > > Miklos
> > Hi=EF=BC=8CI have implemented a small test program to illustrate this n=
ew feature.
> > After downloading and compiling from
> > https://github.com/flying-122/libfuse/tree/flying
> > #gcc -o testfile testfile.c -D_GNU_SOURCE
> > #./example/passthrough_ll -o debug -s  /mnt3
> > #./testfile (on another console)
> > #ps aux | grep pass
> > #root       34889  0.0  0.0   8848   864 pts/2    S+   13:10   0:00
> > ./example/passthrough_ll -o debug -s /mnt3
> > #root       34896  0.0  0.0   9880   128 pts/2    S+   13:10   0:00
> > ./example/passthrough_ll -o debug -s /mnt3
> > #root       34913  0.0  0.0  12112  1060 pts/1    S+   13:10   0:00
> > grep --color=3Dauto pass
> > // kill child process
> > #kill 34896
> > You will see that ./testfile continues to execute without noticing the
> > abnormal restart of the fuse file system.
>
> This is a very good first example demonstrating the limits of the
> recovery.   The only state saved is the actual device file descriptor
> and the result of the INIT negotiation.
>
> It works if there are a fixed number of files, e.g. a read only
> filesystem, where the files can be enumerated (i.e. a file or
> directory can be found  based on a single 64bit index)
>
> Is this your use case?
>
The version used is more complicated to maintain file/directory
information, and is used
for the internal read-only file system. As long as the number of files
remains the same, it
is also possible to write files. I plan to use this recovery method for lxc=
fs.
Thanks.
> Are you ever planning to extend this to read-write filesystems?
>
> Thanks,
> Miklos
