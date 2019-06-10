Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452A13BD2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389337AbfFJTx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389255AbfFJTx2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:53:28 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A57F2089E
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2019 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560196407;
        bh=wOihLllZn9jb+HP18QFES48hPN0FStRExpBhK0fzcWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uAFo3TEMkLIhsip7s70tLqYegboY8gx4x/AFMwOE/1EV8+gh+Qz6VXsvzhUyEopLq
         +3VyxpS1eU7uOSfZrvSP/pTKxzyroqF3Hx9xHOOCBXy5SdOAn6sXZCiuLldV+Ojp4W
         MtATR0O33RIzYknn7ST2vlYr9R159z1eD9/lH5/o=
Received: by mail-wr1-f42.google.com with SMTP id m3so10451174wrv.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2019 12:53:27 -0700 (PDT)
X-Gm-Message-State: APjAAAXk+8ZWNPMEj50fLBRRKeLc2xx8nZVXtjon++Yyv8hw4Cge1pGS
        +LfV5KBVk8h5tgJE2JEn1FseskVURA41y/TeOO4hVQ==
X-Google-Smtp-Source: APXvYqw8aF5NWUK70L17npsUmtHiDuIYCLGXM6hmXrPcXPm1SKMwo7rg5etzLGFCyPVps+0OodMqTTJ25zkC5G2Qcfo=
X-Received: by 2002:a5d:6207:: with SMTP id y7mr27028791wru.265.1560196405847;
 Mon, 10 Jun 2019 12:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
 <be966d9c-e38d-7a30-8d80-fad5f25ab230@tycho.nsa.gov> <0cf7a49d-85f6-fba9-62ec-a378e0b76adf@schaufler-ca.com>
 <CALCETrX5O18q2=dUeC=hEtK2=t5KQpGBy9XveHxFw36OqkbNOg@mail.gmail.com>
 <dac74580-5b48-86e4-8222-cac29a9f541d@schaufler-ca.com> <E0925E1F-E5F2-4457-8704-47B6E64FE3F3@amacapital.net>
 <4b7d02b2-2434-8a7c-66cc-7dbebc37efbc@schaufler-ca.com>
In-Reply-To: <4b7d02b2-2434-8a7c-66cc-7dbebc37efbc@schaufler-ca.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Jun 2019 12:53:14 -0700
X-Gmail-Original-Message-ID: <CALCETrU+PKVbrKQJoXj9x_5y+vTZENMczHqyM_Xb85ca5YDZuA@mail.gmail.com>
Message-ID: <CALCETrU+PKVbrKQJoXj9x_5y+vTZENMczHqyM_Xb85ca5YDZuA@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/13] Mount, FS, Block and Keyrings notifications
 [ver #4]
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        USB list <linux-usb@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        raven@themaw.net, Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 12:34 PM Casey Schaufler <casey@schaufler-ca.com> w=
rote:
> >>> I think you really need to give an example of a coherent policy that
> >>> needs this.
> >> I keep telling you, and you keep ignoring what I say.
> >>
> >>>  As it stands, your analogy seems confusing.
> >> It's pretty simple. I have given both the abstract
> >> and examples.
> > You gave the /dev/null example, which is inapplicable to this patchset.
>
> That addressed an explicit objection, and pointed out
> an exception to a generality you had asserted, which was
> not true. It's also a red herring regarding the current
> discussion.

This argument is pointless.

Please humor me and just give me an example.  If you think you have
already done so, feel free to repeat yourself.  If you have no
example, then please just say so.

>
> >>>  If someone
> >>> changes the system clock, we don't restrict who is allowed to be
> >>> notified (via, for example, TFD_TIMER_CANCEL_ON_SET) that the clock
> >>> was changed based on who changed the clock.
> >> That's right. The system clock is not an object that
> >> unprivileged processes can modify. In fact, it is not
> >> an object at all. If you care to look, you will see that
> >> Smack does nothing with the clock.
> > And this is different from the mount tree how?
>
> The mount tree can be modified by unprivileged users.
> If nothing that unprivileged users can do to the mount
> tree can trigger a notification you are correct, the
> mount tree is very like the system clock. Is that the
> case?

The mount tree can't be modified by unprivileged users, unless a
privileged user very carefully configured it as such.  An unprivileged
user can create a new userns and a new mount ns, but then they're
modifying a whole different mount tree.

>
> >>>  Similarly, if someone
> >>> tries to receive a packet on a socket, we check whether they have the
> >>> right to receive on that socket (from the endpoint in question) and,
> >>> if the sender is local, whether the sender can send to that socket.
> >>> We do not check whether the sender can send to the receiver.
> >> Bzzzt! Smack sure does.
> > This seems dubious. I=E2=80=99m still trying to get you to explain to a=
 non-Smack person why this makes sense.
>
> Process A sends a packet to process B.
> If A has access to TopSecret data and B is not
> allowed to see TopSecret data, the delivery should
> be prevented. Is that nonsensical?

It makes sense.  As I see it, the way that a sensible policy should do
this is by making sure that there are no sockets, pipes, etc that
Process A can write and that Process B can read.

If you really want to prevent a malicious process with TopSecret data
from sending it to a different process, then you can't use Linux on
x86 or ARM.  Maybe that will be fixed some day, but you're going to
need to use an extremely tight sandbox to make this work.

>
> >>> The signal example is inapplicable.
> >> From a modeling viewpoint the actions are identical.
> > This seems incorrect to me
>
> What would be correct then? Some convoluted combination
> of system entities that aren't owned or controlled by
> any mechanism?
>

POSIX signal restrictions aren't there to prevent two processes from
communicating.  They're there to prevent the sender from manipulating
or crashing the receiver without appropriate privilege.


> >  and, I think, to most everyone else reading this.
>
> That's quite the assertion. You may even be correct.
>
> >  Can you explain?
> >
> > In SELinux-ese, when you write to a file, the subject is the writer and=
 the object is the file.  When you send a signal to a process, the object i=
s the target process.
>
> YES!!!!!!!!!!!!
>
> And when a process triggers a notification it is the subject
> and the watching process is the object!
>
> Subject =3D=3D active entity
> Object  =3D=3D passive entity
>
> Triggering an event is, like calling kill(), an action!
>

And here is where I disagree with your interpretation.  Triggering an
event is a side effect of writing to the file.  There are *two*
security relevant actions, not one, and they are:

First, the write:

Subject =3D=3D the writer
Action =3D=3D write
Object =3D=3D the file

Then the event, which could be modeled in a couple of ways:

Subject =3D=3D the file
Action =3D=3D notify
Object =3D=3D the recipient

or

Subject =3D=3D the recipient
Action =3D=3D watch
Object =3D=3D the file

By conflating these two actions into one, you've made the modeling
very hard, and you start running into all these nasty questions like
"who actually closed this open file"
