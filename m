Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB08C1567DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 22:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBHVfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Feb 2020 16:35:06 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:35245 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBHVfF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:35:05 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N0Zfg-1jm4Gp29Nk-00wRGd; Sat, 08 Feb 2020 22:35:03 +0100
Received: by mail-qt1-f178.google.com with SMTP id w47so2274171qtk.4;
        Sat, 08 Feb 2020 13:35:03 -0800 (PST)
X-Gm-Message-State: APjAAAXv5R7k3B79AhlHeVGRjCTWO5YVHs/PgzHBwiFnO6mutZM9ambV
        ItlhD1SBdvnMMdHIEXDLQILDf8MDKhbLh/uI8GI=
X-Google-Smtp-Source: APXvYqzLsrtZSLstZGwRAnnF70j94DmIaNuEYsDaDUCYaakD/eZ1IYRcWs9DJZYXOvDiALmXDlsGAhoUCmOwcRKVr9E=
X-Received: by 2002:ac8:74cb:: with SMTP id j11mr4167200qtr.304.1581197702323;
 Sat, 08 Feb 2020 13:35:02 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 8 Feb 2020 22:34:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1fm0_JKd5NVCSgT7HCHoR7TuVyTmxCQ9wjMGhnkDKmgA@mail.gmail.com>
Message-ID: <CAK8P3a1fm0_JKd5NVCSgT7HCHoR7TuVyTmxCQ9wjMGhnkDKmgA@mail.gmail.com>
Subject: [GIT PULL] compat-ioctl fix for v5.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        youling257 <youling257@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:R4cJWSl4x19uee2mEnK4BQyEUDNpe0YaCRERvX7aJ91McR3uY7/
 8fFQ9XDdTcaabQBa1R8Yu7JFYd3Q0mAX6A8A20JiBedI5teNofsXWN2rkDJ8Wr8aw+czMoP
 Oz+3VPpRzmXxnu1Rmv6y9gc7YbQNZXF/kOlGYix8keHwI5D2gVAcNR8x6h079YKiKGNxaG0
 hJWCLjN7U0WM1ibGOAhtw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2IgRJJ+5P8o=:ZOP/4L+s9bizBIpw6nRsDQ
 JxkxFffH27z880yb8/+3kBQch0Kd4427LWPRqbX3ndQqBP5maUYKnHUad7tOuyo9ROwSw6tJB
 ugG85QhLIe7Tq7cmJZudJZFkv7EViYOO/I0UzI7nc0M+cRnWzHgdZwdPp3pgbSSAElcUgKI2w
 FRztw+Qm1FEfNUf+CKFBSgzUWQt0Kw7WFAbkseFShspt4czP1dqI2wrgS9n5HlvV9juPfFWSL
 ZClXSvR77F7SiWTaQV8Kyw5WcPd+Tsy1ehAUaixizN0h+QciWEzvZA5WnhY0fgf3A00X5tbok
 aiIyp6zjodvfpYC9n+xBL5RKAZd3Huiao7Gek7+I7fD3I7m5nfr9ZiuRDeKJ0TfTsxtS328VH
 ipsceEq8tz+t6U8xLNoo6tkZ3292vaF0mW8M2btjJ1ODQwN5/vZ42R+WLplJl9Jsq0dMA+iZO
 OM91WLvN9SuEf8+MhptRz0taShPwvZUhWz/RzyAt4G1S6uaI+u84zrUiMdWzEgTYJ6AZZt8DJ
 M58y47qQBbqDlDI5O8iwuCAKfZjBc6PJJ4HxkioCrYDCvV0kbFvpbVorKk7M+i7eNtiaEzFao
 BVrSnVNyyU14I3NJTXVWmOrO07c9DYfDcnvP8PhpaaoCEsLg7ePmnOb4nchuUUa36huILPW85
 sAWONEqKN4jr2YDZRE91auvSpmo+Rr4msMekhnyngjaCNGlzlbE7Tr7zAtcAZYqOxl4WRQGu/
 z3sV02A426Go3gqj7rcnaqq3q4T8VU+8q4uYiFeG/gZZaaTFe3ML0O/37PWHjCSWm1xOQ7TdW
 n6WKv6QH5DCe5467zABaYhU1x5IrTVCgXoS2CF5UoyZsvCFsBY=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 77b9040195dea3fcddf19e136c9e99a501351778:

  compat_ioctl: simplify the implementation (2020-01-03 09:42:52 +0100)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
tags/compat-ioctl-fix

for you to fetch changes up to 0a061743af93f472687b8c69b0d539d1f12f3fd2:

  compat_ioctl: fix FIONREAD on devices (2020-02-08 18:02:54 +0100)

----------------------------------------------------------------
compat-ioctl fix for v5.6

One patch in the compat-ioctl series broke 32-bit rootfs for multiple
people testing on 64-bit kernels. Let's fix it in -rc1 before others
run into the same issue.

----------------------------------------------------------------
Arnd Bergmann (1):
      compat_ioctl: fix FIONREAD on devices

 fs/ioctl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
