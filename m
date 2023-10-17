Return-Path: <linux-fsdevel+bounces-543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEE87CCA11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 19:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B9E281995
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 17:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361749CA77;
	Tue, 17 Oct 2023 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL2Tcku5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5CD44469;
	Tue, 17 Oct 2023 17:44:16 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F254B0;
	Tue, 17 Oct 2023 10:44:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so10304121a12.0;
        Tue, 17 Oct 2023 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697564652; x=1698169452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAbIIRYDWhAwyhng7S7d49FJtlugEyorbb7eIRB4Uq8=;
        b=DL2Tcku5zbWMuHqpS2LVUuuuqno2r3e6UMYVXBfYLsaa92o+zCOjODoP7nRC7eyutt
         pkoHKbxmGNmL6rwRJfpV+idYW4zkCBxxgp6LJ8gSI1DB7gbwM7Mqa2nVvIr6/Vd3BhJg
         QbE27tKC28boAKyFvtri4yMDyGltTXBUnnJuSPnuZ1Uyc2+yxIUMj2iAdBTdiXDFFggk
         TVJib1sUoLLbPUudTwmVYkCirK6nwCGId5nTs3rRE9krVVME0HOg35n/ozXsRRGYEcUU
         ev2/P30xxUvF1lqaYf/gDrKR3bfduIahls6QlG4oBGTDiYkFZlTU+Aeuij4OLhma3ajP
         Vj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697564652; x=1698169452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAbIIRYDWhAwyhng7S7d49FJtlugEyorbb7eIRB4Uq8=;
        b=RC7CFnZu6VyaBcyW+La434xCibkzkmTEse0Sj9MihVkflDgvr+vERULNbVcnI+JjMP
         10nSnjV9nVrdj1GSsGMa6HChoFsbHPZecbhb3Zwl5lipMj54CjKJ/MLnuR9cRqvSd3a1
         fqL5JDbe9MHvrrZXj/YKYODDLK4lhhOS4iZDESwmQbQbdJBXEiRniwRH14ownN0i48Px
         tum3heq4ytK+DffdnmMDeEKU4zegMQFDSkKOYWSDTsuWCD8U/7Sf7MoZAx/OoJ1FyzmX
         2fW6zYrxm7Hf5nAGV0blGmb6nLVLEh/G8EoNTwEvS4Yg4zXDXWIB/MX9h/8z6Pq95WAx
         gbHg==
X-Gm-Message-State: AOJu0YzdX1bvZIdbup13IGdh3KoXxg5g9xV+sp0bUu6ANNTPgUZEAPkB
	W1+s26NtQX3UNGt9kp9DXdbKF+cpgeEElRw82xY=
X-Google-Smtp-Source: AGHT+IEaYBlIDsuqXTLWTVMQQsQrI0+VnKE10ZEbi58ENFFmqvMgA2wEhCPcDulab/6SsClXkh/+SC16Rr4EkTT32pA=
X-Received: by 2002:a05:6402:5256:b0:536:e5f7:b329 with SMTP id
 t22-20020a056402525600b00536e5f7b329mr2800108edd.33.1697564651724; Tue, 17
 Oct 2023 10:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016180220.3866105-1-andrii@kernel.org> <20231016180220.3866105-18-andrii@kernel.org>
 <ZS5ptHMhvMAkB+Tb@krava> <CAEf4BzZEoAAfb3BdDavAjHAsQSEsEOwHA7ELUMGqskinH19HTQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZEoAAfb3BdDavAjHAsQSEsEOwHA7ELUMGqskinH19HTQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Oct 2023 10:44:00 -0700
Message-ID: <CAEf4BzZ-8Dj0BrrTyjNWOYXTyTCeP1F9c7Q9k2QyexpFT5iF0Q@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 17/18] selftests/bpf: add BPF token-enabled tests
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 10:32=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 17, 2023 at 4:02=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Mon, Oct 16, 2023 at 11:02:19AM -0700, Andrii Nakryiko wrote:
> > > Add a selftest that attempts to conceptually replicate intended BPF
> > > token use cases inside user namespaced container.
> > >
> > > Child process is forked. It is then put into its own userns and mount=
ns.
> > > Child creates BPF FS context object and sets it up as desired. This
> > > ensures child userns is captures as owning userns for this instance o=
f
> > > BPF FS.
> > >
> > > This context is passed back to privileged parent process through Unix
> > > socket, where parent creates and mounts it as a detached mount. This
> > > mount FD is passed back to the child to be used for BPF token creatio=
n,
> > > which allows otherwise privileged BPF operations to succeed inside
> > > userns.
> > >
> > > We validate that all of token-enabled privileged commands (BPF_BTF_LO=
AD,
> > > BPF_MAP_CREATE, and BPF_PROG_LOAD) work as intended. They should only
> > > succeed inside the userns if a) BPF token is provided with proper
> > > allowed sets of commands and types; and b) namespaces CAP_BPF and oth=
er
> > > privileges are set. Lacking a) or b) should lead to -EPERM failures.
> > >
> > > Based on suggested workflow by Christian Brauner ([0]).
> > >
> > >   [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eee=
f785e@brauner/
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  .../testing/selftests/bpf/prog_tests/token.c  | 629 ++++++++++++++++=
++
> > >  1 file changed, 629 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/t=
esting/selftests/bpf/prog_tests/token.c
> > > new file mode 100644
> > > index 000000000000..41cee6b4731e
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/token.c
> > > @@ -0,0 +1,629 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> > > +#define _GNU_SOURCE
> > > +#include <test_progs.h>
> > > +#include <bpf/btf.h>
> > > +#include "cap_helpers.h"
> > > +#include <fcntl.h>
> > > +#include <sched.h>
> > > +#include <signal.h>
> > > +#include <unistd.h>
> > > +#include <linux/filter.h>
> > > +#include <linux/unistd.h>
> > > +#include <sys/mount.h>
> > > +#include <sys/socket.h>
> > > +#include <sys/syscall.h>
> > > +#include <sys/un.h>
> > > +
> > > +/* copied from include/uapi/linux/mount.h, as including it conflicts=
 with
> > > + * sys/mount.h include
> > > + */
> > > +enum fsconfig_command {
> > > +     FSCONFIG_SET_FLAG       =3D 0,    /* Set parameter, supplying n=
o value */
> > > +     FSCONFIG_SET_STRING     =3D 1,    /* Set parameter, supplying a=
 string value */
> > > +     FSCONFIG_SET_BINARY     =3D 2,    /* Set parameter, supplying a=
 binary blob value */
> > > +     FSCONFIG_SET_PATH       =3D 3,    /* Set parameter, supplying a=
n object by path */
> > > +     FSCONFIG_SET_PATH_EMPTY =3D 4,    /* Set parameter, supplying a=
n object by (empty) path */
> > > +     FSCONFIG_SET_FD         =3D 5,    /* Set parameter, supplying a=
n object by fd */
> > > +     FSCONFIG_CMD_CREATE     =3D 6,    /* Invoke superblock creation=
 */
> > > +     FSCONFIG_CMD_RECONFIGURE =3D 7,   /* Invoke superblock reconfig=
uration */
> > > +};
> >
> > I'm getting compilation fail, because fsconfig_command seems to be
> > included through the sys/mount.h include, but CI is green hum :-\
> >
> > when I get -E output I can see:
> >
> >         ...
> >         # 16 "./cap_helpers.h"
> >         int cap_enable_effective(__u64 caps, __u64 *old_caps);
> >         int cap_disable_effective(__u64 caps, __u64 *old_caps);
> >         # 7 "/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf/=
prog_tests/token.c" 2
> >
> >         # 1 "/usr/include/sys/mount.h" 1 3 4
> >         # 27 "/usr/include/sys/mount.h" 3 4
> >         # 1 "/usr/lib/gcc/x86_64-redhat-linux/13/include/stddef.h" 1 3 =
4
> >         # 28 "/usr/include/sys/mount.h" 2 3 4
> >
> >         # 1 "/home/jolsa/kernel/linux-qemu/tools/include/uapi/linux/mou=
nt.h" 1 3 4
> >         # 96 "/home/jolsa/kernel/linux-qemu/tools/include/uapi/linux/mo=
unt.h" 3 4
> >
> >         # 96 "/home/jolsa/kernel/linux-qemu/tools/include/uapi/linux/mo=
unt.h" 3 4
> >         enum fsconfig_command {
> >          FSCONFIG_SET_FLAG =3D 0,
> >          FSCONFIG_SET_STRING =3D 1,
> >          FSCONFIG_SET_BINARY =3D 2,
> >          FSCONFIG_SET_PATH =3D 3,
> >          FSCONFIG_SET_PATH_EMPTY =3D 4,
> >          FSCONFIG_SET_FD =3D 5,
> >          FSCONFIG_CMD_CREATE =3D 6,
> >          FSCONFIG_CMD_RECONFIGURE =3D 7,
> >         };
> >
> >
> >         ...
> >
> >
> >         # 21 "/home/jolsa/kernel/linux-qemu/tools/testing/selftests/bpf=
/prog_tests/token.c"
> >         enum fsconfig_command {
> >          FSCONFIG_SET_FLAG =3D 0,
> >          FSCONFIG_SET_STRING =3D 1,
> >          FSCONFIG_SET_BINARY =3D 2,
> >          FSCONFIG_SET_PATH =3D 3,
> >          FSCONFIG_SET_PATH_EMPTY =3D 4,
> >          FSCONFIG_SET_FD =3D 5,
> >          FSCONFIG_CMD_CREATE =3D 6,
> >          FSCONFIG_CMD_RECONFIGURE =3D 7,
> >         };
> >
> >
> > it's probably included through this bit in the /usr/include/sys/mount.h=
:
> >
> >         #ifdef __has_include
> >         # if __has_include ("linux/mount.h")
> >         #  include "linux/mount.h"
> >         # endif
> >         #endif
> >
> > which was added 'recently' in https://sourceware.org/git/?p=3Dglibc.git=
;a=3Dcommit;h=3D774058d72942249f71d74e7f2b639f77184160a6
> >
> > maybe you use older glibs headers? or perhaps it might be my build setu=
p
>
> No, I'm pretty sure I have older headers. I'd like this to work in
> both environments, so I need to fix this. I'll try to make this work
> with uapi header, I guess. Thanks for reporting!
>

Ok, I just dropped sys/mount.h include and defined my own

static inline int sys_mount(const char *dev_name, const char *dir_name,
                            const char *type, unsigned long flags,
                            const void *data)
{
        return syscall(__NR_mount, dev_name, dir_name, type, flags, data);
}


That was the only thing I needed sys/mount.h for. So consider this fixed.


> >
> > jirka
> >
>
> [...]

