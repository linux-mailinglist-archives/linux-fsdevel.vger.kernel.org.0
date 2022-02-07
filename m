Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813F94ABEF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 14:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377072AbiBGNBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 08:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388518AbiBGLnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:43:52 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A9BC043181
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 03:43:51 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id g14so38924747ybs.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Feb 2022 03:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DqWgmzwxtL264zlQQi/aWGo5dgkPVyz0CHwO9F0ARvI=;
        b=ZAikxu6W0Tse6pSUT3PJpXsbcq5ghw55uIWE0umxyXZEov02vMAXWebaGqeBOBgn56
         1Ha7T/JXuYFUlO62olgXb4gI02cv2zI720VybXH7rTrhWTBUAWHZ0eqruQ/fT3laLs2m
         8xgr98g8CCxRpqF6yQM70NsJIvRyh0tiu4PzuAhMG1fQ5TnCE+K2YpSjIv0HSRPbvolC
         dSL5QjqZ7/EKycgejQkK04Ol4o2V9r0x1MBrSnexX4x/L5LxY2olpuQHEfhCNnPBek5c
         gnOQ/9kW1rge0Fii1i9jjtMDIhLyhKfNm83PewOARZF4Q4wlL7RCg02SEhj8UL1HBC/S
         e25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DqWgmzwxtL264zlQQi/aWGo5dgkPVyz0CHwO9F0ARvI=;
        b=xAQ1pATl2/lZCOT8g6SSLREL5IJlCXW75PyV/Tb9fDsxYMDwvKyYJmh1tgEXF4OoCP
         2bqfbyaqlI/EMR2x2OfopnJfTiJRx79g1SLuuWqK4Udt8B4A6xDgkO8IuPnEFUTPyLle
         NQpyzpwQC3tAqu6uDjA3Aqk+DIqG3uzxrKsOl/zKpTKLg/wh5PYw4I+hB5X+nJBLsjmi
         vNNRFC8z9tCywNx3VVNWQHOLMjRaTM/xrMgnp4ePDgTfRtt89bqtp8U6KXN8SO88eZ7R
         qADp0m1kYQ+svi2g1zPtUSlfTuIgVcbOO20wPvQ2YvShPLDptyWKWztFY/fzKqXff1hG
         omBQ==
X-Gm-Message-State: AOAM533i3feO3KwLuiSZo1pi9GOhe9tds99TBtmYqIrvw3lSpY67AygM
        fLnqBXkfhfyZsG0+rAixZXR7Hb6pLg3tCi4D6D1oDQ==
X-Google-Smtp-Source: ABdhPJw/wYJhy6Xitu0IqzKj85on6zJBb6VfDZyyxSheyccof0ONf81+HJUrXnY2Ll7yMc9fC0rcJahUmQTUQMqcTTA=
X-Received: by 2002:a81:b662:: with SMTP id h34mr10605194ywk.366.1644234230804;
 Mon, 07 Feb 2022 03:43:50 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 7 Feb 2022 17:13:39 +0530
Message-ID: <CA+G9fYsZuC=36zJoj2UPNhF3hQTf-osgs-m59Zey3TB_E0wZUg@mail.gmail.com>
Subject: [next] fs/proc/task_mmu.c:1444:14: warning: unused variable 'migration'
To:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Yang Shi <shy828301@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While building Linux next-20220207 for arm architecture the following
error was noticed.

make --silent --keep-going --jobs=8  \
     ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- \
     'CC=sccache arm-linux-gnueabihf-gcc' \
     'HOSTCC=sccache gcc' \
     vexpress_defconfig

fs/proc/task_mmu.c: In function 'pagemap_pmd_range':
fs/proc/task_mmu.c:1444:14: warning: unused variable 'migration'
[-Wunused-variable]
 1444 |         bool migration = false;
      |              ^~~~~~~~~

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
https://builds.tuxbuild.com/24lg0EnsbEf6deWnMXwXiwh8oVi/

metadata:
    git_describe: next-20220207
    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
    git_short_log: b3c0a155ef77 (\"Add linux-next specific files for 20220207\")
    target_arch: arm
    toolchain: gcc-10


--
Linaro LKFT
https://lkft.linaro.org
