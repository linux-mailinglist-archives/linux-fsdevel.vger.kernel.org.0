Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3934B1C7247
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 15:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgEFN63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgEFN63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 09:58:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FF7C061A0F;
        Wed,  6 May 2020 06:58:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so2783341wmh.3;
        Wed, 06 May 2020 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+EZWEZLLTI3Gi05jCgh0gur+NH9htHBwJfh43Oi88+w=;
        b=Q6HPTt+u3+89M2HFaPVRacO/JQ3o6TncSmdWSGOQ0aPRnnnZjOBQMYjCkj81udQqpM
         z822xxWIPHed1tEBquN88P8vzAjlh+EsUFSF2Hst5yMyGKVo7g+Fwp8CpqvgHmCgtvU+
         QnqhNYrsoleXRli8jMRR9IfkdLU4IBvPjcFCL0GYrZmdO3JRLCQ9T0ZuSPK0/QZUlXBV
         m1ECS8ST0niSClCdgxrpbbzA/8B13pqxMz8FIft0JLf8RXaGDI2ZJXBf9JftnJJwenG8
         ZnkPA1EkBHstMnBaleNuzPPikWJ66SMB46cXZnNG28/NhwLDZiuC6hPEL338zXOxNh+D
         h+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+EZWEZLLTI3Gi05jCgh0gur+NH9htHBwJfh43Oi88+w=;
        b=fgTNRbuGBCwZx5YpgEBXomO9/IkxkZPqcmL+ccIvFkBrnqrdhGu1sxvY7c+u2HJa5a
         mhRZA/CcFV0oP8XLatpGMiok3Ibwl8SqyEvDolwMoHY00Sf/Qx+KVfnrVqYLwE3T4jjt
         cUT7hpPXiXVxYgl/5JGm+Jl/xwc6l6G846I8mcsJXsoU5hR5dvqyK+7zKrYA3PxDBoPy
         XW8e3yMHnqTTuJZKomN+iBSB1yjrVGxrw6c5uguO2MmbiU53Tq8j+V7hnFiN/MmTJh6d
         lnkF3mNVV8IE6wL+fsVqpTwDN5g7BKuGOnUvRjqtLv+CIoiJA2jRDXmdCjzKnOhPRnRg
         Hbcw==
X-Gm-Message-State: AGi0PuZIKrm5QSmOSD8XAD4T/yHowIwyFUrpMQV6ptUNciNts1+UMRja
        vaXX3BrWX9JDU1OFypT8S0JQqYUNUwvPDn3mZ8c=
X-Google-Smtp-Source: APiQypKjKQAId4IZ/DADa6i5YJiFkV0MIE/wVRudVIYBUwp4MA9TqjXOBxPzV8T9K3OYvXCy4DV8NSplZatxaHWSUKw=
X-Received: by 2002:a7b:c3ca:: with SMTP id t10mr4560109wmj.94.1588773507683;
 Wed, 06 May 2020 06:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200505153156.925111-1-mic@digikod.net> <d4616bc0-39df-5d6c-9f5b-d84cf6e65960@digikod.net>
In-Reply-To: <d4616bc0-39df-5d6c-9f5b-d84cf6e65960@digikod.net>
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Wed, 6 May 2020 16:58:16 +0300
Message-ID: <CAP22eLHres_shVWEC+2=wcKXRsQzfNKDAnyRd8yuO_gJ3Wi_JA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add support for O_MAYEXEC
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
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
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 6:36 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
>
> On 05/05/2020 17:31, Micka=C3=ABl Sala=C3=BCn wrote:
> > Hi,
> >
> > This fifth patch series add new kernel configurations (OMAYEXEC_STATIC,
> > OMAYEXEC_ENFORCE_MOUNT, and OMAYEXEC_ENFORCE_FILE) to enable to
> > configure the security policy at kernel build time.  As requested by
> > Mimi Zohar, I completed the series with one of her patches for IMA.
> >
> > The goal of this patch series is to enable to control script execution
> > with interpreters help.  A new O_MAYEXEC flag, usable through
> > openat2(2), is added to enable userspace script interpreter to delegate
> > to the kernel (and thus the system security policy) the permission to
> > interpret/execute scripts or other files containing what can be seen as
> > commands.
> >
> > A simple system-wide security policy can be enforced by the system
> > administrator through a sysctl configuration consistent with the mount
> > points or the file access rights.  The documentation patch explains the
> > prerequisites.
> >
> > Furthermore, the security policy can also be delegated to an LSM, eithe=
r
> > a MAC system or an integrity system.  For instance, the new kernel
> > MAY_OPENEXEC flag closes a major IMA measurement/appraisal interpreter
> > integrity gap by bringing the ability to check the use of scripts [1].
> > Other uses are expected, such as for openat2(2) [2], SGX integration
> > [3], bpffs [4] or IPE [5].
> >
> > Userspace needs to adapt to take advantage of this new feature.  For
> > example, the PEP 578 [6] (Runtime Audit Hooks) enables Python 3.8 to be
> > extended with policy enforcement points related to code interpretation,
> > which can be used to align with the PowerShell audit features.
> > Additional Python security improvements (e.g. a limited interpreter
> > withou -c, stdin piping of code) are on their way.
> >
> > The initial idea come from CLIP OS 4 and the original implementation ha=
s
> > been used for more than 12 years:
> > https://github.com/clipos-archive/clipos4_doc
> >
> > An introduction to O_MAYEXEC was given at the Linux Security Summit
> > Europe 2018 - Linux Kernel Security Contributions by ANSSI:
> > https://www.youtube.com/watch?v=3DchNjCRtPKQY&t=3D17m15s
> > The "write xor execute" principle was explained at Kernel Recipes 2018 =
-
> > CLIP OS: a defense-in-depth OS:
> > https://www.youtube.com/watch?v=3DPjRE0uBtkHU&t=3D11m14s
> >
> > This patch series can be applied on top of v5.7-rc4.  This can be teste=
d
> > with CONFIG_SYSCTL.  I would really appreciate constructive comments on
> > this patch series.
> >
> > Previous version:
> > https://lore.kernel.org/lkml/20200428175129.634352-1-mic@digikod.net/
>
> The previous version (v4) is
> https://lore.kernel.org/lkml/20200430132320.699508-1-mic@digikod.net/


Hi Michael

I have couple of question
1. Why you did not add O_MAYEXEC to open()?
Some time ago (around v4.14) open() did not return EINVAL when
VALID_OPEN_FLAGS check failed.
Now it does, so I do not see a problem that interpreter will use
simple open(),  ( Although that path might be manipulated, but file
contents will be verified by IMA)
2. When you apply a new flag to mount, it means that IMA will check
all files under this mount and it does not matter whether the file in
question is a script or not.
IMHO it is too hard overhead for performance reasons.

Regards,
LEv
