Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23EF33095A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 09:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhCHI1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 03:27:36 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:60311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhCHI1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:27:06 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N14xe-1lm92r3ngI-012ZXy; Mon, 08 Mar 2021 09:26:56 +0100
Received: by mail-ot1-f49.google.com with SMTP id f8so3375432otp.8;
        Mon, 08 Mar 2021 00:26:54 -0800 (PST)
X-Gm-Message-State: AOAM531LaElb2wKXlmPxBPFispTGcWriwK2bx+4Msgh5GKbIpqkdM+pZ
        xDzIhUbYlo+WZX3TpFepct/1/NXGTZ9y1Jzo+58=
X-Google-Smtp-Source: ABdhPJz7WzRENGkqrJauNt4Eu43tE41OHtOy5Pi18b4rc5onlz+3B0QPZSg6kqLhqT6QwccMllOlz9JudYJqhcYI0w4=
X-Received: by 2002:a9d:2f24:: with SMTP id h33mr8386599otb.305.1615192013989;
 Mon, 08 Mar 2021 00:26:53 -0800 (PST)
MIME-Version: 1.0
References: <1615185706-24342-1-git-send-email-anshuman.khandual@arm.com> <1615185706-24342-7-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1615185706-24342-7-git-send-email-anshuman.khandual@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Mar 2021 09:26:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Jp6wgGWJ9UDoiN5joOYSONaoHoH=S--i=3SQpm_f4JQ@mail.gmail.com>
Message-ID: <CAK8P3a3Jp6wgGWJ9UDoiN5joOYSONaoHoH=S--i=3SQpm_f4JQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm: Drop redundant HAVE_ARCH_TRANSPARENT_HUGEPAGE
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ac4dihqGbl6+jEr5hvaPprARfRMzuV5tBYOBcFJxgQ6aBn/E5bB
 GXJneuWlAVcyxI+vkcYXKvB59uv/eQ/yEWQvV6WRLKsNnEdMV5MskvBED6sSsQ8qHPsIH8i
 y6VJacjLbXY0SqD78Sae+4qmfdMIGK+K98OMV41tNtw4SHA0l5PG6NwGxEv0snlgh6NxhFf
 SZxZyOLGtxotQuru+ZhsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TKJ0E/7wbKk=:Fdb8DFUaXWhjSNhmzGd9sT
 2Oskqmgzab+15xMwBwvePuCPlbxv5TQSAFFU2I/KB7Yi3nUJuGSP/1HzArwwnLSDS2ouNNzxP
 AT4xNWkrH/VUqa1YSKKUWz79eAhjJeIrJ7GdIgGd6H7ko0taezSY4Q6PxHTY0uN5MsW8Uc1lS
 pNp7n7EEWFKqXbJO8ob0V466m/8bL3U8Aex43XxNtnJhkeSfU8w42bIRmIKxlMUGA9Sb5+lT7
 snIDbhue2uQNnyUZASM2Tmf4Xr8gf2SgHUH++IMIP9LVevIJRZxX87pAUkWrgKLRpeJeWtDFz
 m4kFsbkxzrCu1U6vI1+odbEHJD8fGQfyiUp7E8vqld1Ccv6hUGPYfMP4PfjCLo50NSlYqe5Ea
 4tJO8A/es+NhTOyAw4HUh/qt4+foFDfenv9YX7FhxF21WJKcv4w6z3/lAbwnw
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 8, 2021 at 7:41 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> HAVE_ARCH_TRANSPARENT_HUGEPAGE has duplicate definitions on platforms that
> subscribe it. Drop these reduntant definitions and instead just select it
> on applicable platforms.
>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
