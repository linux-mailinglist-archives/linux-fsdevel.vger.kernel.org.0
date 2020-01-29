Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A128714D0F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 20:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgA2TG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 14:06:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36119 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgA2TG6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:06:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id w25so374829qki.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 11:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FhknuesOl8lF6FjwV2Qc/z+nG0xejuInhcls4JdTHTE=;
        b=DCehkkTPUKR/9mbJVh0nUrN/gskyVcvXI5B/eGdZLKEDp2a2IvK3KP27QsnLVrulFo
         7FeUrVYKeUtQbXyLVsEUMSLVDdWeU3hDie02VUj4zCFu/f7+t9k/LrKu3YXphoB7kgS5
         Dr+ubaFziWqyJAanEe1MV1xCL8jdrRvT15y2Xf03sBspj0ZEmpof5gX8nyKdTxIP/vtP
         8TFzloPPg6j/QKMhpBLqMrZpuslq6kseN4umpk3KaACEb81xTF1zRnK8UgAMIEx3wen+
         zKCAzmTS5qYpNM4GEoxRfHvttHY5guooy8wlnmqIDidMA65CN8Cp7Ow1DDmuubTJ6+no
         xwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FhknuesOl8lF6FjwV2Qc/z+nG0xejuInhcls4JdTHTE=;
        b=PcIdXA2VS8AtrgOi6c2bAQyxTWwND7E1OuFi6mAXljg3HWOnx2sLHZGRZY3unDqf+k
         P92YIx/1Bl/yafmS6/zfSkFW/afDXO4k3eNARcIJdN0ePgrDWHjHGK6ji/vNnQmfmp9/
         1DFm5WhrVA2wIwOUy6UuHc5qxsvwzi2R/HYSJnE24xqdc9gVaFVMbb6thb5V5GK3GU2s
         O3w/EEljCf35mBvhxzyeiSmGRpzQBwv+/LxLyK5Uy3W9i9kGtXz82rRvgtfRYIBD9+2P
         0tDolzOEKcCjHywlzgLW/o2ii7mVB1ORpuImz1ENDdnJbyDikXRhn8FY+Bk4ndi61A4p
         XH6w==
X-Gm-Message-State: APjAAAXmzuKEqPeMKscu9vmAPZOqt+pEihtY7zT9XY0qcHnT/AoI+l2W
        aCfdDR2ExXOtFMftNQgQ4d1Nsg==
X-Google-Smtp-Source: APXvYqwPr6EFcwzsD4a9IE6KvyyzcOfmje3dq69CM1Rmuk5CYXrxg2b6W6h23S9/HHiJ0XgFpUrhUQ==
X-Received: by 2002:a37:a8ca:: with SMTP id r193mr1300286qke.346.1580324816647;
        Wed, 29 Jan 2020 11:06:56 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v2sm1406940qkj.29.2020.01.29.11.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 11:06:56 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH 1/1] mm: sysctl: add panic_on_inconsistent_mm sysctl
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200129180851.551109-1-ghalat@redhat.com>
Date:   Wed, 29 Jan 2020 14:06:54 -0500
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, ssaner@redhat.com, atomlin@redhat.com,
        oleksandr@redhat.com, vbendel@redhat.com, kirill@shutemov.name,
        khlebnikov@yandex-team.ru, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Transfer-Encoding: quoted-printable
Message-Id: <526F3E1C-87D3-4049-BC93-A4F0EDA45608@lca.pw>
References: <20200129180851.551109-1-ghalat@redhat.com>
To:     Grzegorz Halat <ghalat@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 29, 2020, at 1:08 PM, Grzegorz Halat <ghalat@redhat.com> wrote:
>=20
> Memory management subsystem performs various checks at runtime,
> if an inconsistency is detected then such event is being logged and =
kernel
> continues to run. While debugging such problems it is helpful to =
collect
> memory dump as early as possible. Currently, there is no easy way to =
panic
> kernel when such error is detected.

Also, why can=E2=80=99t you have a simple script that checking for the =
tainted flags
periodically, and then trigger the crash dump once it happened?

>=20
> It was proposed[1] to panic the kernel if panic_on_oops is set but =
this
> approach was not accepted. One of alternative proposals was =
introduction of
> a new sysctl.
>=20
> Add a new sysctl - panic_on_inconsistent_mm. If the sysctl is set then =
the
> kernel will be crashed when an inconsistency is detected by memory
> management. This currently means panic when bad page or bad PTE
> is detected(this may be extended to other places in MM).
>=20
> Another use case of this sysctl may be in security-wise environments,
> it may be more desired to crash machine than continue to run with
> potentially damaged data structures.
>=20
> Changes since v1 [2]:
> - rename the sysctl to panic_on_inconsistent_mm
> - move the sysctl from kernel to vm table
> - print modules in print_bad_pte() only before calling panic
>=20
> [1] =
https://lore.kernel.org/linux-mm/1426495021-6408-1-git-send-email-borntrae=
ger@de.ibm.com/
> [2] =
https://lore.kernel.org/lkml/20200127101100.92588-1-ghalat@redhat.com/
>=20
> Signed-off-by: Grzegorz Halat <ghalat@redhat.com>
> ---
> Documentation/admin-guide/sysctl/vm.rst | 14 ++++++++++++++
> include/linux/kernel.h                  |  1 +
> kernel/sysctl.c                         |  9 +++++++++
> mm/memory.c                             |  8 ++++++++
> mm/page_alloc.c                         |  4 +++-
> 5 files changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/admin-guide/sysctl/vm.rst =
b/Documentation/admin-guide/sysctl/vm.rst
> index 64aeee1009ca..57f7926a64b8 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -61,6 +61,7 @@ Currently, these files are in /proc/sys/vm:
> - overcommit_memory
> - overcommit_ratio
> - page-cluster
> +- panic_on_inconsistent_mm
> - panic_on_oom
> - percpu_pagelist_fraction
> - stat_interval
> @@ -741,6 +742,19 @@ extra faults and I/O delays for following faults =
if they would have been part of
> that consecutive pages readahead would have brought in.
>=20
>=20
> +panic_on_inconsistent_mm
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

> +
> +Controls the kernel's behaviour when inconsistency is detected
> +by memory management code, for example bad page state or bad PTE.
> +
> +0: try to continue operation.
> +
> +1: panic immediately.
> +
> +The default value is 0.
> +
> +
> panic_on_oom
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 0d9db2a14f44..b3bd94c558ab 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -518,6 +518,7 @@ extern int oops_in_progress;		/* If =
set, an oops, panic(), BUG() or die() is in
> extern int panic_timeout;
> extern unsigned long panic_print;
> extern int panic_on_oops;
> +extern int panic_on_inconsistent_mm;
> extern int panic_on_unrecovered_nmi;
> extern int panic_on_io_nmi;
> extern int panic_on_warn;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 70665934d53e..a9733311e3a1 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1303,6 +1303,15 @@ static struct ctl_table vm_table[] =3D {
> 		.extra1		=3D SYSCTL_ZERO,
> 		.extra2		=3D &two,
> 	},
> +	{
> +		.procname	=3D "panic_on_inconsistent_mm",
> +		.data		=3D &panic_on_inconsistent_mm,
> +		.maxlen		=3D sizeof(int),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dointvec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_ONE,
> +	},
> 	{
> 		.procname	=3D "panic_on_oom",
> 		.data		=3D &sysctl_panic_on_oom,
> diff --git a/mm/memory.c b/mm/memory.c
> index 45442d9a4f52..b29a18077a6a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -71,6 +71,7 @@
> #include <linux/dax.h>
> #include <linux/oom.h>
> #include <linux/numa.h>
> +#include <linux/module.h>
>=20
> #include <trace/events/kmem.h>
>=20
> @@ -88,6 +89,8 @@
> #warning Unfortunate NUMA and NUMA Balancing config, growing =
page-frame for last_cpupid.
> #endif
>=20
> +int panic_on_inconsistent_mm __read_mostly;
> +
> #ifndef CONFIG_NEED_MULTIPLE_NODES
> /* use the per-pgdat data instead for discontigmem - mbligh */
> unsigned long max_mapnr;
> @@ -543,6 +546,11 @@ static void print_bad_pte(struct vm_area_struct =
*vma, unsigned long addr,
> 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
> 		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
> 		 mapping ? mapping->a_ops->readpage : NULL);
> +
> +	if (panic_on_inconsistent_mm) {
> +		print_modules();
> +		panic("Bad page map detected");
> +	}
> 	dump_stack();
> 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d047bf7d8fd4..a20cd3ece5ba 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -643,9 +643,11 @@ static void bad_page(struct page *page, const =
char *reason,
> 	if (bad_flags)
> 		pr_alert("bad because of flags: %#lx(%pGp)\n",
> 						bad_flags, &bad_flags);
> -	dump_page_owner(page);
>=20
> +	dump_page_owner(page);
> 	print_modules();
> +	if (panic_on_inconsistent_mm)
> +		panic("Bad page state detected");
> 	dump_stack();
> out:
> 	/* Leave bad fields for debug, except PageBuddy could make =
trouble */
> --=20
> 2.21.1
>=20

