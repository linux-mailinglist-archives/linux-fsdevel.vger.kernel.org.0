Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104FA1CA4EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEHHQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 03:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgEHHQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 03:16:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF59C05BD43;
        Fri,  8 May 2020 00:16:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h9so632907wrt.0;
        Fri, 08 May 2020 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f98ody5ofivvfpEVB+MHkT0+pvj3EG0oyyJsAVjVUX8=;
        b=kjfHOAJu6QRyi7ROjFuMXA71cr7WC63FyOi9OXIFsSs1IZHl3a5eLuk7zueS2zm7wS
         Sn6o5f+HUqh43jMlFmz+HHxETZ2OBeTwunPGVNL7MO8847t2QuGNIr8R4zdJPdSwCv42
         P3/G3ZpoYpIh5YhbKAb05sU6vgNQukPk/o1ZkUZBdscLQLwkDn5v2y9GFaEqpgpvdZ1x
         WFH7fivD1ab/1TL4RUu81yHfqjJlMK4MdUFLfPYCWTUaKsdftGrWJuyBA67hoYyJOrz3
         X935R4kxNudrg8grDnLRlBUs1a2CyhbJM3IEaMnm9QhIi1/zVbrIXym0wInbvszrFbVI
         fO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f98ody5ofivvfpEVB+MHkT0+pvj3EG0oyyJsAVjVUX8=;
        b=URxO9VEsgf+M2zGldoyO6YKWD4BLtnBsw69KBt8ETURD9hHpkkOviUAceCjh+B7r8n
         ktXvkyhClti4kwv/Vf8Y9kC4ugqYWtQvekuwU9LjXsqSlVtLh9/tPaYqcZ7xFzP1zRY5
         ObIPidtD0QgIXSsDTo5Y1bwWgf8lgNPu9R5dXiDg72wy6jggBsBZ/Jf5jhFcZW3s5K3b
         iLeaBFzgh2XsBJfibIidllFvtgni/Gsra1aek7290bgeKpKmlYabjGHG4nWpRKKdYv2x
         aFPsV9W44mIMeHI5hThlp9QdRCf8WlzOx5w4j4iBZFxfcEQhxnJmFoaZrspbxWyzGo/q
         7q9w==
X-Gm-Message-State: AGi0PuaMen0VI7pPUWdMtwA6LGI4IRJom9J/V9/RuVeklKbhTOfoA2Ng
        dva7t/p4djdXlSO7OXAF9r4OG6kbR6/RPYXFrtw=
X-Google-Smtp-Source: APiQypJ9eUdgZ6U6tTq3eG//0ZlXZwAD2BqFXPXDJ2zwThqIwa9D2I1/m6cN5rQn8vBGsZhz0fAMbykk4S3gUX8ZBTU=
X-Received: by 2002:a5d:4950:: with SMTP id r16mr1277974wrs.350.1588922167648;
 Fri, 08 May 2020 00:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200505153156.925111-1-mic@digikod.net> <20b24b9ca0a64afb9389722845738ec8@AcuMS.aculab.com>
 <907109c8-9b19-528a-726f-92c3f61c1563@digikod.net> <ad28ab5fe7854b41a575656e95b4da17@AcuMS.aculab.com>
 <64426377-7fc4-6f37-7371-2e2a584e3032@digikod.net> <635df0655b644408ac4822def8900383@AcuMS.aculab.com>
 <1ced6f5f-7181-1dc5-2da7-abf4abd5ad23@digikod.net>
In-Reply-To: <1ced6f5f-7181-1dc5-2da7-abf4abd5ad23@digikod.net>
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Fri, 8 May 2020 10:15:56 +0300
Message-ID: <CAP22eLFmNkeQNbmQ_SAbnrDUnv2W-zYJ+ijnE22C3ph2vUiQiQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add support for O_MAYEXEC
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 7, 2020 at 4:38 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
>
> On 07/05/2020 11:44, David Laight wrote:
> > From: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> >> Sent: 07 May 2020 10:30
> >> On 07/05/2020 11:00, David Laight wrote:
> >>> From: Micka=C3=ABl Sala=C3=BCn
> >>>> Sent: 07 May 2020 09:37
> >>> ...
> >>>>> None of that description actually says what the patch actually does=
.
> >>>>
> >>>> "Add support for O_MAYEXEC" "to enable to control script execution".
> >>>> What is not clear here? This seems well understood by other commente=
rs.
> >>>> The documentation patch and the talks can also help.
> >>>
> >>> I'm guessing that passing O_MAYEXEC to open() requests the kernel
> >>> check for execute 'x' permissions (as well as read).
> >>
> >> Yes, but only with openat2().
> >
> > It can't matter if the flag is ignored.
> > It just means the kernel isn't enforcing the policy.
> > If openat2() fail because the flag is unsupported then
> > the application will need to retry without the flag.
>
> I don't get what you want to prove. Please read carefully the cover
> letter, the use case and the threat model.
>
> >
> > So if the user has any ability create executable files this
> > is all pointless (from a security point of view).
> > The user can either copy the file or copy in an interpreter
> > that doesn't request O_MAYEXEC.>
> > It might stop accidental issues, but nothing malicious.
>
> The execute permission (like the write permission) does not only depends
> on the permission set on files, but it also depends on the
> options/permission of their mount points, the MAC policy, etc. The
> initial use case to enforce O_MAYEXEC is to rely on the noexec mount opti=
on.
>
> If you want a consistent policy, you need to make one. Only dealing with
> file properties may not be enough. This is explain in the cover letter
> and the patches. If you allow all users to write and execute their
> files, then there is no point in enforcing anything with O_MAYEXEC.
>
> >
> >>> Then kernel policy determines whether 'read' access is actually enoug=
h,
> >>> or whether 'x' access (possibly masked by mount permissions) is neede=
d.
> >>>
> >>> If that is true, two lines say what is does.
> >>
> >> The "A simple system-wide security policy" paragraph introduce that, b=
ut
> >> I'll highlight it in the next cover letter.
> >
> > No it doesn't.
> > It just says there is some kind of policy that some flags change.
> > It doesn't say what is being checked for.
>
> It said "the mount points or the file access rights". Please take a look
> at the documentation patch.
>
> >
> >> The most important point is
> >> to understand why it is required, before getting to how it will be
> >> implemented.
> >
> > But you don't say what is required.
>
> A consistent policy. Please take a look at the documentation patch which
> explains the remaining prerequisites. You can also take a look at the
> talks for further details.
>
> > Just a load of buzzword ramblings.
>
> It is a summary. Can you please suggest something better?

I can suggest something better ( I believe)
Some time ago I proposed patch to IMA -  Add suffix in IMA policy rule crit=
eria
It allows IMA to verify scripts, configuration files and even single file.
It is very simple and does not depend on open flags.
Mimi Zohar decided not to include this patch on the reason it tries to
protect the file name.
( Why ??).

https://lore.kernel.org/linux-integrity/20200330122434.GB28214@kl/
