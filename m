Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA2489A06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 14:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiAJNfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 08:35:38 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:53211 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiAJNfi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:35:38 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M76jv-1n01kV0AKV-008Wk7; Mon, 10 Jan 2022 14:35:36 +0100
Received: by mail-wm1-f50.google.com with SMTP id w26so2889549wmi.0;
        Mon, 10 Jan 2022 05:35:35 -0800 (PST)
X-Gm-Message-State: AOAM532MFWpxvbCxx+X/oeE0JToA4T3wqp321Pt2i1Hd2GSgB3W5pgGf
        vHWkW/9LX14vQosawU7weRqiMFvL7P/LABu5sGc=
X-Google-Smtp-Source: ABdhPJxi0Z/ZiBz/NSOKjhoGPprS74nLPOzeNY5wtnvdjs0k7wca4Io+stHgBpdw9GGPmWr9NuMWVabYObO8sOckUL0=
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr8601383wmf.173.1641821735504;
 Mon, 10 Jan 2022 05:35:35 -0800 (PST)
MIME-Version: 1.0
References: <20211228143958.3409187-1-guoren@kernel.org> <20211228143958.3409187-4-guoren@kernel.org>
In-Reply-To: <20211228143958.3409187-4-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 10 Jan 2022 14:35:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2zn9M6X09WsjJ9HYiS9WnO_YPCvJLSBk+HaH+yZHQqfA@mail.gmail.com>
Message-ID: <CAK8P3a2zn9M6X09WsjJ9HYiS9WnO_YPCvJLSBk+HaH+yZHQqfA@mail.gmail.com>
Subject: Re: [PATCH V2 03/17] asm-generic: fcntl: compat: Remove duplicate definitions
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VpEEgoOWThxhQixjfpbEos42H1TvCPgcGI8o8I9o2XPlaGQHEJg
 +ochkhXHJkoDcYX7WdO0YF6qmZsqV9i+JNq7tnyAps349sZDyX+w6yafKFBWb/9eV5r5yZv
 3SvHGUwopX7Vi5CkXf25eeiZufSGTVCL1JZhUnsEfo3F5ypep9VY577JGYB86kaQosT03n6
 2OHSwKnra3Mhb7C++W0gg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ZNMXf9sxdg=:zWE9RxiaoQrl4scWs6UtFD
 eDXCgOBPCpSzNlBDRlGb2LYPadMU6qGp+0YF/4Gp1Zg6IvG0ojkeTuOiebeV+a68nD7aSlzQ9
 AlcrSV6OhoJhLlE10D3xZgRlw/GJxqrRQkiL7jJ156HTHrtgXZPr6g4yEExrWa2K/70q1+cW6
 3vEg12xrzfXFFCId8X98XivvVMBYIoJ6yy2FcjngfKYVqzgl42veBb2f/69h1L0dK1eiOdaky
 jIWrEaje9akGfrXQgcomjz4Fz/ZTnDg8vj5OKDNBEioRXMqrTC72rez4Ae83/CoU2iix/FXtX
 3jBd5jLBRbjYky4PtX7sFV3L1w1fKQGUHf0uyh4GVIZW3jWX481OBmTNnB2LsocgdSf+NGxYq
 OF4BPGNITowFmmCRC+mkihFQADoVE/HL4fl5j6np1Cr/0b7WXwYrfOPYCisdu/3b5PPGNk1y4
 fOvtT4fBxuxUzYXPFnl+3sQfk4SwtnndGUQ6/qORYNOjkQb5TiFvMjxst5wHC4TOI+2d02vqC
 gwHcDouioSLNbJY85SN9M2+8jD7Kc9fpXtXFTRs9a4sPwG9XnUxUFYlBFdDX4ZAcB3duJhfjU
 Avu5p1SpyzH37+vigu464kdBKdaNS6t1z3WXiPlr4uT03jYchIBgzJ2ZQML8ASDE2m+52d1Yy
 745v4fHQ+H37Ozvbmh/7E6o7e8/72Ix1g1uTRZ7kODf+jCZKTAZDmm5NuK31zQEtEtpJC1W3W
 Txq1AcgLAwcJonk3l8+07QOU7OiP1CAnzzp6KUtg/OmJU75PV9g7O4ckLUqePNXS+l+rKKQdH
 pg/iqLbREtRyJVusbhvpE263c8IrdJ6tlU3dvSDQ+JZp6BxBsE=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 28, 2021 at 3:39 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Remove duplicate F_GETLK64,F_SETLK64,F_SETLKW64 definitions in
> arch/*/include/asm/compat.h.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Unfortunately, this one does not look correct to me:

> @@ -116,7 +116,7 @@
>  #define F_GETSIG       11      /* for sockets. */
>  #endif
>
> -#ifndef CONFIG_64BIT
> +#if !defined(CONFIG_64BIT) || defined(CONFIG_COMPAT)
>  #ifndef F_GETLK64
>  #define F_GETLK64      12      /*  using 'struct flock64' */
>  #define F_SETLK64      13

The problem here is that include/uapi/ headers cannot contain checks for
CONFIG_* symbols because those may have different meanings in user space
compared to kernel.

This is a preexisting problem in the header, but I think the change
makes it worse.

With the current behavior, user space will always see the definitions,
unless it happens to have its own definition for CONFIG_64BIT already.
On 64-bit parisc, this has the effect of defining the macros to the
same values as F_SETOWN/F_SETSIG/F_GETSIG, which is potentially
harmful. On MIPS, it uses values that are different from the 32-bit numbers
but are otherwise unused. Everywhere else, we get the definition from
the 32-bit architecture in user space, which will do nothing in the kernel.

The correct check for a uapi header would be to test for
__BITS_PER_LONG==32. We should probably do that here, but
this won't help you move the definitions, and it is a user-visible change
as the incorrect definition will no longer be visible. [Adding Jeff and Bruce
(the flock mainainers) to Cc for additional feedback on this]

For your series, I would suggest just moving the macro definitions to
include/linux/compat.h along with the 'struct compat_flock64'
definition, and leaving the duplicate one in the uapi header unchanged
until we have decided on a solution.

        Arnd
