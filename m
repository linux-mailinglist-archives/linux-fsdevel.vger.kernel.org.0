Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AC2495B1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 08:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379101AbiAUHqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 02:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379105AbiAUHqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:46:12 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D21C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 23:46:12 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 23so25103587ybf.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 23:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6VGlaNwo012lzA+7kz/lrPF90trnFFi6FJ6/mHic+hs=;
        b=xMPuSfeAAlBJoeqTa7zrkdfi+fcCQodwVxBlhLKj0MhKB1NnACApVZgTImEC6sApU8
         9AvVAlCAqJoyMWZ+Bgz1mADiqpeMprrtN8j4Q6zppP3f4GT2ZXfcqw1LKFaBA9WlhIxq
         4TeGYRYUwQV84j7lGnjGaacA+AmlgWCaxzWLNkDqHNv+vDZW6S1SpJf15evnnWP2rPGg
         wI3YE75QumJ8g5TyAOH6Djrq5nRfxp1gHViE1mIi5Q9+WJwHBskFL1YPMI1gycvpkiu5
         /7b5FtsKvlMBUX9pGLIeU0Fr9sZIl6/PdsUCZtjU/vvDU2ObGsMkqhEcpf9OOibLtvNc
         B5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6VGlaNwo012lzA+7kz/lrPF90trnFFi6FJ6/mHic+hs=;
        b=GdFuhqUzDzDXYSUezfzasGhVGcXGipf0L91+t80jQ6xP7jiORJmV0skBf/Eq0OaD5H
         1xIBSnC8cv22sd3ZLgnAyArtruzofRJKy5alyObT3WwsnBGHfGHD3oPJJRGjzlqEbXMm
         U+otP3miU33IE0/L4MGDK5jiZ+BuO9ZLgEX5FxbfTlCiX12hiVG2puWWu5TOkNyCfpsr
         G57UyOGAxZRVi9AAAm/7pOCcy2vVFnl8KQtP0jy7yV/1Lnw+3ynum+Kx26dNSvISwXY0
         1zDmTMiBAq7E87ANnBSKCFVojZ7SktcbPI7BM9msUD+baK9VWZh1FR8vszG9sDShw3jf
         Zzow==
X-Gm-Message-State: AOAM531b1k2p+KcQ8N8bK0p36OoHWKA+SbTxJ0piQyQwHS0W2FnlUfT/
        eDvznDD27lrGbqaTYFyahuCzBzzKz4E+RCOOXpv7QQ==
X-Google-Smtp-Source: ABdhPJwK9URes+a+U/H7ToYTf1isUH/kpRc2JSjoWu9Z7aUB1iVP5o2fLVMPV8e7sZaI40IlE/NocAVbxaMs+F8uP7I=
X-Received: by 2002:a25:8e89:: with SMTP id q9mr5016082ybl.520.1642751171389;
 Thu, 20 Jan 2022 23:46:11 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Jan 2022 13:16:00 +0530
Message-ID: <CA+G9fYvuEqeoLO6dC_qtGyRUz=UPv5i0C3jZ_n9nz5kWOuCHYQ@mail.gmail.com>
Subject: [next] parisc: allnoconfig: ERROR: modpost: Section mismatches
 detected. Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, pavel@ucw.cz,
        rppt@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linux next-20220121 parisc allnoconfig build failed with gcc-9/10/11.

make --silent --keep-going --jobs=8 ARCH=parisc
CROSS_COMPILE=hppa-linux-gnu- 'CC=sccache hppa-linux-gnu-gcc'
'HOSTCC=sccache gcc'

WARNING: modpost: vmlinux.o(.text+0x1c8): Section mismatch in
reference from the function ksys_sync() to the function
.init.text:memblock_alloc_try_nid()
The function ksys_sync() references
the function __init memblock_alloc_try_nid().
This is often because ksys_sync lacks a __init
annotation or the annotation of memblock_alloc_try_nid is wrong.

ERROR: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
make[2]: *** [/builds/linux/scripts/Makefile.modpost:59:
vmlinux.symvers] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git describe: next-20220121
  kernel-config: https://builds.tuxbuild.com/23zIAxC4uCgy4zadA01JYyOwCR4/config
  build: https://builds.tuxbuild.com/23zIAxC4uCgy4zadA01JYyOwCR4/

# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

tuxmake --runtime podman --target-arch parisc --toolchain gcc-11
--kconfig allnoconfig

--
Linaro LKFT
https://lkft.linaro.org
