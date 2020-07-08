Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCD521810F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 09:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgGHHXB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 8 Jul 2020 03:23:01 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbgGHHXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:23:01 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MD9Kp-1k1YsS10oD-009Bpy; Wed, 08 Jul 2020 09:22:57 +0200
Received: by mail-qk1-f174.google.com with SMTP id k18so40595913qke.4;
        Wed, 08 Jul 2020 00:22:56 -0700 (PDT)
X-Gm-Message-State: AOAM531Ao9c8bH8WoE5qvjA7oR9rRwnqW6BN5uTxdxQpCeKqNmwjYWvE
        TX/PfbVyVwlg71qIqb8nZwqe7xuLOc13eRRlVa4=
X-Google-Smtp-Source: ABdhPJwUBcG/1BpiC+qdY+LuFzWvg9XDNkC9mO5dIZPmuPnsoF/bIile11NCgXsXdn50Udu/UrGJ9q4uKoPO8k6xQnA=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr48812583qko.138.1594192975528;
 Wed, 08 Jul 2020 00:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200707180955.53024-1-mic@digikod.net> <20200707180955.53024-10-mic@digikod.net>
In-Reply-To: <20200707180955.53024-10-mic@digikod.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jul 2020 09:22:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0docCqHkEn9C7=e0GC_ieN1dsYgKQ9PbUmSZYxh9MRnw@mail.gmail.com>
Message-ID: <CAK8P3a0docCqHkEn9C7=e0GC_ieN1dsYgKQ9PbUmSZYxh9MRnw@mail.gmail.com>
Subject: Re: [PATCH v19 09/12] arch: Wire up landlock() syscall
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:54NRw1C3ud7yaXwsDrOd/GoWcgIn8PrBSXpNEPKRDJ07a38YjAa
 fRe0DbjudiX//y9B/2Q7TjMkX8N2Pk4mcWoFORSRZnfcYQP0fecoj89KkY5ctbHDoHzjtiJ
 /krwi+bdtt85jBnNon7Wn3P1yIcUbi62dFhyfqEDkJePew/ow9aK3NN75MuWiDBAi6TrW9Q
 QxDnDTzRoOBzQV6IFe1mg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LVeoa5/caPU=:khu0qv2J2g0myi8u7k17ig
 bIYa6+/GI+nu5ZRnN2SU+D7AWzUNS+2ylYksn30ahSpwbech2IX7S43zNgFNtnjUSId+fdCIq
 xSwjC+cyn9z2mzQcSEeDKYoz0RdmkHn8iHQTifNqtFCmd8XyHeA6UNTkSk2kMrv0JN3v64A9O
 brEJLrsdSjMvkl7Mm74s6Lkfq88luCcNbA4nSg/rkDRL3p+MeFUrQbABjo8zkwzWChib7Mf/w
 JzYC/gKGAxxyZYXH4upG/7BZWAF6TCVbs3AFWHiShf3DXagQCA/bnerjss1iVs2DTdod1Qox7
 uKEMEcz+t5PLLPSphTGrV9xttZRLdXqc1DHoeopex4ZbGJXJFDMmD/mEg3iim49XHaoq7WZb1
 6SAB/ApMXFVQWlArmmIYT1O4z1FG3/trG/OQ+vdUYO+AEIkmxlzcRJC1NLi0cnW7KN6BAkKIg
 szDVYZ8GhVTJMC1Javxfog5QlUGkXmtbJwNFjfVanGoMp017s+6P+823yOfJrBRWVEItshOUm
 VvF1wP5iWhZOMW81ihKMWPPVK25t373uppN42MDNMFANNZpxEBImkIDRXKjlt3QCq93l762aQ
 mbPTTN7YSjYCC+oGvdvJLoT4tpWl2U7ApCkGtG6d226v0xamxhFD9lvJyyWy+1btAkfELlzwk
 GjsdzQHZW6QxsBZe3MTlDpBMp7/QqUvJNkBlL9GEVAId/Rd+kRzEbnNUTzeFQpgy3413ZBuWy
 dRbs4VnRE+Wcp/EHCppclgSw6y7PZbIt1QdH/RgUPC0BMsg/Y1AX4tQvAXKN2sVq6kas7kCor
 tAksJ3UU6OcxIEq0ZSr1H9vPzgYSnMC5eO8Si7tFrOCrPdmvYM0ynk9VZA5BMIFYdolpFi6tV
 KwaMgh8f6vBCJzMZCnMfxs+Eo2FaauwEHBbrN/S0IZ4C4MD5vzjahC5zdvYsjuQXElTMuUslz
 ZDE8LRZFk4/F55oIoPTtu5hSk85FIrVUrQ2MC7P6edfh9X75CsIn3
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic@digikod.net> wrote:

> index f4a01305d9a6..a63a411a74d5 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -857,9 +857,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
>  __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
>  #define __NR_faccessat2 439
>  __SYSCALL(__NR_faccessat2, sys_faccessat2)
> +#define __NR_landlock 440
> +__SYSCALL(__NR_landlock, sys_landlock)
>
>  #undef __NR_syscalls
> -#define __NR_syscalls 440
> +#define __NR_syscalls 441

In linux-next, we already have:

+#define __NR_watch_mount 440
+#define __NR_watch_sb 441
+#define __NR_fsinfo 442
+#define __NR_process_madvise 443

You may want to increase the number again.

      Arnd
