Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C360B4720
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 08:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392452AbfIQGEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 02:04:30 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:38372 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfIQGEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 02:04:30 -0400
Received: by mail-vk1-f193.google.com with SMTP id s72so474780vkh.5;
        Mon, 16 Sep 2019 23:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYf30STYtd8wS6M1VhEfM29R/tPCrWS/3zFLL7Kf2eM=;
        b=D8u8y8oE6v+IYdTzy1J6NqueZGXlOa81h6Z23l9LmZ0sx9U35tJ2rUVB4sOu8dYGLs
         s9d3aUKiYqQnNHL+8wxg5ei43Bfd6SBeTkkeOgD3UggAdMWtPcBsXvSKwQY6RkZqft0h
         GMW6lM13bWc9mJZSnQG6BU1mMWnFXOD52YBgXzB/v3QsWQa/yHlpf8Kl4AljrJhm60n6
         881plqixpuwIRcUC9tDvAtnD44XmR1+DibX/e7XE+jK0H8jrI/rBVqkPOCFG0zANXp74
         w/ePTmsV0TB77x1gOaTEsTa65fzIoK3GM5WQg5Omcue6IqpwPtBpznM0FhHxYA0D/cAU
         u2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYf30STYtd8wS6M1VhEfM29R/tPCrWS/3zFLL7Kf2eM=;
        b=cppgKPmu/G7W4jhE7TADtlU2SYjpdUctZU3nNsDiWztAhln/E2MvFWBNDZBumPiZu/
         VJ5+9Lb1ZwXYxEX3mSlqWAfYFGvzYWn4BSMbASeR2XM06VFCGeOiIqECcPRcFDa+7Di4
         oghi4Nqmujas5q5HSwBPYSdWcIhb9tAOBTVG1nXxl4m7gN1QfLtLAZILt0Hwnr4oubn8
         gH5QhbL1n2bT2VjefYjfwOQ+7VF8fQ+esNXVL/HIUGR3aUGlkFfbJseyzJPL1bOZJ2An
         45VqYJLtE+MCcCIpcV5+5n3ZUxy6ftYlKPE33FEqJBQ3E/1BrswurFTryBEUx0svMWy8
         kpHg==
X-Gm-Message-State: APjAAAXtASw0elS2778xLRaASJNuCl4JepHTkpGL9gbcGKCjrLJp3hXd
        wLxWWxefzc4sk2o1iaYO8LWEtqVeh8A6Yc/caZ0=
X-Google-Smtp-Source: APXvYqwzqF2CgV83C3ndEgfr+Dfe3YDTx0SA7Jpak4NJ8dMd7WdcjaTRinsxCgKm2+wYVmzNvJ09Ct56Rz2111TwXLY=
X-Received: by 2002:a1f:a4c5:: with SMTP id n188mr692034vke.11.1568700267940;
 Mon, 16 Sep 2019 23:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <8998.1568693976@turing-police> <20190917053134.27926-1-qkrwngud825@gmail.com>
 <20190917054726.GA2058532@kroah.com>
In-Reply-To: <20190917054726.GA2058532@kroah.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Tue, 17 Sep 2019 15:04:16 +0900
Message-ID: <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
To:     Greg KH <gregkh@linuxfoundation.org>, namjae.jeon@samsung.com,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 2:47 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> It's the fact that it actually was in a form that could be merged, no
> one has done that with the sdfat code :)

Well, I'm more than happy to help if you guys are happy with merging
the new base.

> What fixes?  That's what I'm asking here.

I gave this as an example in my previous email:
https://github.com/MotorolaMobilityLLC/kernel-msm/commit/7ab1657

> How do we "know" that this is better than what we currently have today?
> We don't, so it's a bit hard to tell someone, "delete the work you did
> and replace it with this other random chunk of code, causing you a bunch
> more work in the process for no specific reason other than it looks
> 'newer'." :(

The new sdFAT base I'm suggesting, is just as "random" as the one
staging tree is based on.

If exFAT gets merged to Torvald's tree, there will be a lot more eyes
interested in it.
If there's a better base, we better switch to it now and prevent
further headaches long-term.

It's really hard to compare those 2 drivers base and extract
meaningful changelogs.

But regardless, here are some diff stats:
<Full diff stat>
 Kconfig      |   79 +-
 Makefile     |   46 +-
 api.c        |  423 ----
 api.h        |  310 ---
 blkdev.c     |  409 +---
 cache.c      | 1142 ++++-----
 config.h     |   49 -
 core.c       | 5583 ++++++++++++++++++++++++--------------------
 core.h       |  196 --
 core_exfat.c | 1553 ------------
 exfat.h      | 1309 +++++++----
 exfat_fs.h   |  417 ----
 extent.c     |  351 ---
 fatent.c     |  182 --
 misc.c       |  401 ----
 nls.c        |  490 ++--
 super.c      | 5103 +++++++++++++++++++++-------------------
 upcase.c     |  740 ++++++
 upcase.h     |  407 ----
 version.h    |   29 -
 xattr.c      |  136 --
 21 files changed, 8186 insertions(+), 11169 deletions(-)

<diff-filter=M>
 Kconfig  |   79 +-
 Makefile |   46 +-
 blkdev.c |  409 +---
 cache.c  | 1142 +++++-----
 core.c   | 5583 ++++++++++++++++++++++++++----------------------
 exfat.h  | 1309 ++++++++----
 nls.c    |  490 ++---
 super.c  | 5103 ++++++++++++++++++++++---------------------
 8 files changed, 7446 insertions(+), 6715 deletions(-)

> I recommend looking at what we have in the tree now, and seeing what is
> missing compared to "sdfat".  I know a lot of places in the exfat code
> that needs to be fixed up, odds are they are the same stuff that needs
> to be resolved in sdfat as well.

Would there be any more data that I can provide?
It's really hard to go through the full diff :(

Thanks.
