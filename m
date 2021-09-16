Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06FB40E033
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhIPQUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 12:20:14 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbhIPQTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:19:32 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mw8gc-1mjfQT1YHc-00s4TK; Thu, 16 Sep 2021 18:18:09 +0200
Received: by mail-wr1-f45.google.com with SMTP id q26so10379083wrc.7;
        Thu, 16 Sep 2021 09:18:09 -0700 (PDT)
X-Gm-Message-State: AOAM5304KOgiYNYvlrcn8rVLWycv2HyX8RwLiVaBuCf1Oavf8Gqzr3nj
        ADVxaZYjCB0VaWClh7bACArYleuTqY8KhxhUYkk=
X-Google-Smtp-Source: ABdhPJyTxi6NI7qAeKdWzxen8DQyGQiIKJB4lMQ3kU9u+D/WgX0QYuP+ldR8vqVUYM1ImqavHjZk4F75SjcrZmpYlt8=
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr7032427wrs.71.1631809088892;
 Thu, 16 Sep 2021 09:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210916131816.8841-1-will@kernel.org> <CAK8P3a0jQXiYg9u=o2LzqNSdiqMC=4=6o_NttPk_Wx4C3Gx98A@mail.gmail.com>
 <20210916151330.GA9000@willie-the-truck>
In-Reply-To: <20210916151330.GA9000@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Sep 2021 18:17:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0wqJX08+tHFXoZbYn3i64K94KKV9jOcRpP09WyBdG0ww@mail.gmail.com>
Message-ID: <CAK8P3a0wqJX08+tHFXoZbYn3i64K94KKV9jOcRpP09WyBdG0ww@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/compat_binfmt_elf: Introduce sysctl to disable
 compat ELF loader
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rROeNIkGF+6/4yGDjMmjNNmy4ngPK9NDbYBZTHhcGtZS7VGK7yB
 GldI9UyH7mCvD/qOoQ2RCH9F4e/mjk2EZyOoNy/eDaXWCsuH2jhivtk3UYgPXnaH8Kmr3Eo
 SBQzCzcuU80idY4/tPxL8rpt6z9sO57Li33ySkUt0yTQ6QgUy053i+icrYTjuoWLiTEJgMO
 bo/dfzG369OFjYZyiSr6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QlYBEE6U+U4=:WD0OaqvSrhYsZQTOhgEzkc
 OleLFZp/7N924cRpBcdj97iSadx0oE7sCl6QUxyH0URzB8Z6waRz96h2avsSanVDnKvLUCEnL
 vaEoIn7eAzbJseNTwNucRhBuZR7RGjLBEa9O+uGuDesybkHFKos1w7hulu67DHsrCXu69R/zA
 Vm5IQVNjgRTkNLlZAq0TjncuObcdfjo4X/c1Y87nGTeHvBkbRYdUXf+DtyuHogQgaIfetWlsQ
 fsYrlT7mZrUFxvcQ09SGhlVUDvOJIS8Zechm72hm6moUcK0GFj5uMs3k4k0KLWHSjbFUY3PDL
 ln+AbHgI3kn98wI+CdrYzmNkbqJRC0HqNKN+C7XfnRJATB8Huu1YyalUkUhS04C4u+lvDMze1
 nPHrNwsp3+Qm1pVrvMlp7PF1hnjl5AdTGnL2pFSbU9FS128DpbqWMm6Ys/nQxOaDxNqTgTfVq
 +QsgPUeQd54cCTqzqMIeWrZ01qnhSLOPJB1WJXFPCNFmpNWLmh6xItroqe0V20iUVBVwrjLoh
 C8DhFFC/kbrEDpcnGN5IeIAUx7ksR/KOG0DgPrpQgmcnlF1zCQOdXMDBpmFkhRm1OWRTmgNE8
 e6ckNllHOnPKdmkIQiEYKf0XZMtiAGdIHxCGZUWAxewkJRC33MjpOtjzZJd7MP9HrYJozIbgT
 JOIItI5PAIt/HrzwMD5WlBbLG5e95QhKSIhIyRXlP0ZxxltO+fy1qwblL3ylpwKKREJiU4Maf
 I316BbqO+tqgfuZb1P5H+Yz2+FF5uQihWjpOQQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 5:13 PM Will Deacon <will@kernel.org> wrote:
> On Thu, Sep 16, 2021 at 04:46:15PM +0200, Arnd Bergmann wrote:
> > On Thu, Sep 16, 2021 at 3:18 PM Will Deacon <will@kernel.org> wrote:
> > In the first case, having the kernel make the decision based on CPU
> > feature flags would be easier. In the second case, I would expect this
> > to be a per-process setting similar to prctl, capability or seccomp.
> > This would make it possible to do it for separately per container
> > and avoid ambiguity about what happens to already-running 32-bit
> > tasks.
>
> I'm not sure I follow the per-process aspect of your suggestion -- we want
> to prevent 32-bit tasks from existing at all. If it wasn't for GKI, we'd
> just disable CONFIG_COMPAT altogether, but while there is a need for 32-bit
> support on some devices then we're not able to do that.
>
> Does that make more sense now?

That sounds rather specific to your use case, but others may have similar
requirements that are better served with a per-container or per-process
flag. If your init process sets the process specific flag to prevent compat
mode and non-root tasks are unable to set it back, the effect for you
should be the same, but others may also be able to use the feature.

Another option would be to make the binfmt helper a device specific
module, in that case you wouldn't need to use a runtime feature at all,
you just prevent the module from getting loaded. ;-)

On a somewhat related note, a topic that has come up in the past
is to make the syscall ABI user selectable across all architectures, and
allow e.g. an arm64 task to call normal syscalls using the arm32
compat calling conventions, in order to simplify user space ISA emulation.
This could even be done in a way to allow using foreign architecture
syscall semantics for things like fex that emulates x86 on arm.
If this gets added, having the conditional in the binfmt loader is
a bit pointless.

      Arnd
