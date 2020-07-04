Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C811214805
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgGDSgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 14:36:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45475 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgGDSgw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 14:36:52 -0400
Received: by mail-oi1-f193.google.com with SMTP id j11so26366138oiw.12;
        Sat, 04 Jul 2020 11:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTLzKsCOiasLijn4Yp3SriUfiPIZzoXuap9Gu/eoheA=;
        b=LvBgBpxheL+R766+UufcuDwFAToNmjBTUpQ9uuGLxu3ewnUrJvgZDiGf34+Kb1p0kg
         N4V+DO4b3OXYa/UQO7ZllgW7ztxqELPUb0gZyq4SuyZ9hEwUxMuivuZMBPUOD6Jz9JcT
         saZCbG88j2MDFT1uBwQNo2LjpnbCHS9T1h60cOjWt7k8TMtUKZo7Y6Qdn1FgEiYNSpd2
         n4DQkSdQkuJt8Es+P4N2k7tY8wwxNAYhFGSAO/CgemUbdaHRIry9xlhXjE9AzyHTdZ4/
         9vVpY8A531anQDsFWnGQ/c4PAJvVyu5UsEvdTBDwlbkhVMPhyagH0/zke/zvqZyxILon
         xx1Q==
X-Gm-Message-State: AOAM531pDshNw29MJvzU4cAy5TM0zTyD5PnHSDbKfxDgUmI1IdN+0x3p
        kSSGOJx/DbOQ0Sc5KWqFtM8OneWJbbW44VpXlMDuJVP+
X-Google-Smtp-Source: ABdhPJyPmyJqACeULqNf//xVptlGeaq+ZxnRtsLH2el2twEg7ZUsbo0HgIy4EmY/ToQyFA36rRYJdp6ZOybBv6stKcs=
X-Received: by 2002:aca:ac10:: with SMTP id v16mr12290013oie.153.1593887811459;
 Sat, 04 Jul 2020 11:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200704140250.423345-1-gregkh@linuxfoundation.org> <20200704140250.423345-3-gregkh@linuxfoundation.org>
In-Reply-To: <20200704140250.423345-3-gregkh@linuxfoundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 4 Jul 2020 20:36:40 +0200
Message-ID: <CAMuHMdXMBH_X6Wv0k8pYV6ewk5pu-b-eVTd2Mw-jXSY4jSkPHw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arch: wire up the readfile syscall
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-man@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 4, 2020 at 4:05 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This wires up the readfile syscall for all architectures
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

>  arch/m68k/kernel/syscalls/syscall.tbl       | 1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
