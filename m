Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1273633346F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 05:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhCJEjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 23:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCJEjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 23:39:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9459AC061761
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Mar 2021 20:39:15 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so1410079pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Mar 2021 20:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+6Mi46dcdcY6Da+JW/3IUfZjddU3SLthUc42KkPmXok=;
        b=WVHQdA5geSkOSY2k3mUbcYkex6ma0Gw2o1oSwFbTeaPkVjS435wLMr/aAH7xYFAbsG
         pmmCh0WUXeWGsgxblzt66ObJFDYkyhIjDHeeAIo4W58V1vXCb3ziF6cZZD/uw0NRoIkR
         5AK+k4r9bIgIANyMysONTHMg7VjS5mz7yp1Hobg1oD/qtt16hP45xp/g+BaD53GWgrK1
         9CjkvXdId4bNpmqDBp61v4QboRJcdnj41Vv05Gc7PZZaOSnuO0dL7IGEtsfdyXVUVOgH
         S58fs4sHOok4tIDrwVqrpeJf29up+chRyAK3KbF2erG+UOv9kVoCdA83JkdXwqHVqbdt
         b2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+6Mi46dcdcY6Da+JW/3IUfZjddU3SLthUc42KkPmXok=;
        b=HJjn+DxivobqgDdEgMUqP3HNBNEtwoQ5LvLek7DsPH10hxZfzboBl6W+bUJcmdTbKE
         GBf8vIJ1G4nHyBemFpHsjt4gDf2MQkVlgfMaMI0UYJdB6IHmqM9RBc5Gt1cWqNxoIaaw
         XMWXDYOD7juFOwmk+peUockshHXrkCpQYYPcluESx0KdIaiXkQ/7ltzrU65TuLmsDF+/
         PVi6qaZ8qvCIEh0q/Q57RFBaG524ILYPxv2eiuVfh6RAo2QI4n6HCOr8ikgu0PlVtJV8
         y9qQS3AN78QiIIOIqoglQec4NoshQecmmG+km/8S5Hq2kwrhVXKXDMW+jcc0kphX87lg
         J4RQ==
X-Gm-Message-State: AOAM532x9Vm8MPvlMMSrzevl23UtclXxPDlKLWAs3vaB3OxGObmsbV3H
        kO8cuyKT3IeIK9bwxBU0yGJUeA==
X-Google-Smtp-Source: ABdhPJwUDSugnDD29UAQUcT0onkjP0AQ6O9yVuCP8VU294FXmjWhze4GQofHqYVvDs93mdTUffp8tQ==
X-Received: by 2002:a17:902:d201:b029:e6:bba:52b3 with SMTP id t1-20020a170902d201b02900e60bba52b3mr1165798ply.51.1615351154584;
        Tue, 09 Mar 2021 20:39:14 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v26sm14137171pff.195.2021.03.09.20.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 20:39:14 -0800 (PST)
Date:   Tue, 09 Mar 2021 20:39:14 -0800 (PST)
X-Google-Original-Date: Tue, 09 Mar 2021 19:56:34 PST (-0800)
Subject:     Re: [PATCH 2/6] mm: Generalize SYS_SUPPORTS_HUGETLBFS (rename as ARCH_SUPPORTS_HUGETLBFS)
In-Reply-To: <1615278790-18053-3-git-send-email-anshuman.khandual@arm.com>
CC:     linux-mm@kvack.org, anshuman.khandual@arm.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ysato@users.sourceforge.jp, dalias@libc.org,
        viro@zeniv.linux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     anshuman.khandual@arm.com
Message-ID: <mhng-7d560865-85dd-4876-9f4a-69b4de968c9e@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 09 Mar 2021 00:33:06 PST (-0800), anshuman.khandual@arm.com wrote:
> SYS_SUPPORTS_HUGETLBFS config has duplicate definitions on platforms that
> subscribe it. Instead, just make it a generic option which can be selected
> on applicable platforms. Also rename it as ARCH_SUPPORTS_HUGETLBFS instead.
> This reduces code duplication and makes it cleaner.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm/Kconfig                       | 5 +----
>  arch/arm64/Kconfig                     | 4 +---
>  arch/mips/Kconfig                      | 6 +-----
>  arch/parisc/Kconfig                    | 5 +----
>  arch/powerpc/Kconfig                   | 3 ---
>  arch/powerpc/platforms/Kconfig.cputype | 6 +++---
>  arch/riscv/Kconfig                     | 5 +----
>  arch/sh/Kconfig                        | 5 +----
>  fs/Kconfig                             | 5 ++++-
>  9 files changed, 13 insertions(+), 31 deletions(-)

[...]

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 85d626b8ce5e..69954db3aca9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -30,6 +30,7 @@ config RISCV
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> +	select ARCH_SUPPORTS_HUGETLBFS if MMU
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> @@ -165,10 +166,6 @@ config ARCH_WANT_GENERAL_HUGETLB
>  config ARCH_SUPPORTS_UPROBES
>  	def_bool y
>
> -config SYS_SUPPORTS_HUGETLBFS
> -	depends on MMU
> -	def_bool y
> -
>  config STACKTRACE_SUPPORT
>  	def_bool y

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
