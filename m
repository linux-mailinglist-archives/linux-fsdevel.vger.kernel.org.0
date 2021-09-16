Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C10A40DD29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 16:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhIPOrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 10:47:55 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbhIPOry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:47:54 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M8QJq-1mVGNT2Jmq-004VcK; Thu, 16 Sep 2021 16:46:31 +0200
Received: by mail-wr1-f45.google.com with SMTP id t8so2926720wri.1;
        Thu, 16 Sep 2021 07:46:31 -0700 (PDT)
X-Gm-Message-State: AOAM530xVo9AV/+wmRoCBWqx2eitLFi/xQSd9Q5T42A07z3bh1azTUpm
        OfL/eKHFR7vyziNsM8sOGv9CnV314S9ju/MRYng=
X-Google-Smtp-Source: ABdhPJw0W5bi0+GZd/sew9cOdxZp7HStYyKgxFqMcUl8noHqsevWff8BdpCVsxr9NTF++O2SDnoTaYunRSEkTxYUgP0=
X-Received: by 2002:adf:914e:: with SMTP id j72mr6568886wrj.428.1631803591160;
 Thu, 16 Sep 2021 07:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210916131816.8841-1-will@kernel.org>
In-Reply-To: <20210916131816.8841-1-will@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Sep 2021 16:46:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0jQXiYg9u=o2LzqNSdiqMC=4=6o_NttPk_Wx4C3Gx98A@mail.gmail.com>
Message-ID: <CAK8P3a0jQXiYg9u=o2LzqNSdiqMC=4=6o_NttPk_Wx4C3Gx98A@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/compat_binfmt_elf: Introduce sysctl to disable
 compat ELF loader
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Br8Y6xertIc05cgdQ4WQATw0o8lejEZzhHioUAdqtiwLnOw9GIR
 WhpWbOGJYsC7ZXnh1n95MQk9oxBOh30G4zRwzQpWj+HGOUwdksUD5YfGJyvYTMi/Jb+PKZn
 Spau9wMxco1j5FU1kqH4NDq3azRvFbF4X+wBMIrl9HcCTUYW+yyT5icdx6coLPMwCsqmV/l
 /j+XskkFr+s9kZKz3vZpw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7fFYnGbFp+0=:tfUeM3J1jhwqOP92GCtGKx
 yILGuOxtC02q1NWT4vFNBGAgrJ/ZhNK2oMiHG4e+HFBOdPW2gQEtCi2wOkZgAsO5B96NFtX/S
 CLUx3qi5ar/h6Xc9UlVUVij4BNFntLr3zLO79o7Z41PBBVx+u93xlZMcEhk0yjfXIK1xlBJnF
 imTPyTP4vi6YXIfgQAl+974y/oWZoDtWFue9PKfyHQDDrNKoRdqOYLbCn2Os16L8pVH/nwrpX
 snAU4fDNE1aEuc9cZuH5pzpDjAxmnwDbsrjzikh5ijrIADty7Qlao16SFORS5S8t61x2Y8TO6
 HBTYeodWBr36Vgs7NRn+K+S9zAvhWAbdMVyPPsKhMvv8OmQhAhRjrKlOtLKMD6TwYilDQp7K4
 OuuGA6mHKvIErd9i5rfT7fV40K6muwH44sqd2GBNlm7QkjJ6wocURjPIqFLwMUfAQxDKDWaNM
 5Toqb+ThFkDYujil1yN3XKvXaZpT/Z9XXSSlLEjzjzH7n89YQFvYoFumjd+PtgH8a65l1R13a
 nQ+MZAt1jKivDbdGxdHgAHrv3jJyqWM3jHN8LpkQiLuIgmBCag4wHxsbpc10+oYsRVf9bTfI6
 oMKyCLSimMMzNCuZSIOgykNP+9DYqRycwd7Zj+eaNfCfZfm0iH8YszVmhpn65UXvcgkzFh+ub
 EbGSvaaxEiaZq8ahq7pWu3roRpbkB9eH6BCuVjWO3G3USohIUA8QFeb49FWAVK5N9jMqAv/ye
 x3SOg0gxkbn3is6c9Res6LxS/DhJkTWtJjTChmePl5E+WLaNf0EhXpI9DgGIoNimQF/mBWiPX
 vMtucinvgKbN7rIH08EDQyjbprF+d0v5wjcRrWc27rq/+fY94kqIuZaukdbdgFmBQkE9eU2l9
 JGQRl1j4XDMAN8Mpi3GQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 3:18 PM Will Deacon <will@kernel.org> wrote:
>
> Distributions such as Android which support a mixture of 32-bit (compat)
> and 64-bit (native) tasks necessarily ship with the compat ELF loader
> enabled in their kernels. However, as time goes by, an ever-increasing
> proportion of userspace consists of native applications and in some cases
> 32-bit capabilities are starting to be removed from the CPUs altogether.
>
> Inevitably, this means that the compat code becomes somewhat of a
> maintenance burden, receiving less testing coverage and exposing an
> additional kernel attack surface to userspace during the lengthy
> transitional period where some shipping devices require support for
> 32-bit binaries.
>
> Introduce a new sysctl 'fs.compat-binfmt-elf-enable' to allow the compat
> ELF loader to be disabled dynamically on devices where it is not required.
> On arm64, this is sufficient to prevent userspace from executing 32-bit
> code at all.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  fs/compat_binfmt_elf.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> I started off hacking this into the arch code, but then I realised it was
> just as easy doing it in the core for everybody to enjoy. Unfortunately,
> after talking to Peter, it sounds like it doesn't really help on x86
> where userspace can switch to 32-bit without involving the kernel at all.
>
> Thoughts?

I'm not sure I understand the logic behind the sysctl. Are you worried
about exposing attack surface on devices that don't support 32-bit
instructions at all but might be tricked into loading a 32-bit binary that
exploits a bug in the elf loader, or do you want to remove compat support
on some but not all devices running the same kernel?

In the first case, having the kernel make the decision based on CPU
feature flags would be easier. In the second case, I would expect this
to be a per-process setting similar to prctl, capability or seccomp.
This would make it possible to do it for separately per container
and avoid ambiguity about what happens to already-running 32-bit
tasks.

        Arnd
