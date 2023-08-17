Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC277F480
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 12:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350030AbjHQKvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 06:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350046AbjHQKvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:51:32 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4172D71
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 03:51:30 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4476f713e15so2788167137.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 03:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692269489; x=1692874289;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PwRqCw0HUOyaGtPxJbMKB04qbbd6HmPDl9unJunOuNs=;
        b=NKajdjqWcACz7+jTBBXWsHK9nYEI6CzWcAvyNsvWKuMV0bvOUvAzto8jQrP+a5yRk9
         HuM8dTxLXsggqjdO/5oqkqDrEgafMqnuf7pEqRCdfU44u23YJkLxO2cWlezOHun2Ed9J
         97H7pRpjcAmsNVgybv/uTZ61ZN+laRT5AcfmPFRNWAXLRSD4Wpkdx30vXH9FNRd6Yr8x
         C8X2bCShYgikSSEKWtvwj0OIBgWKowyMk7C66pSHf7SwWHOldYX4T3URwQJzoG1JHRmB
         SQfF1R6gHS+nliyDFx0Vrsx+w7LFfOlnkXXcK/XrJk07dkfvjYshMzHLqAJKJZiZetL1
         RLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692269489; x=1692874289;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PwRqCw0HUOyaGtPxJbMKB04qbbd6HmPDl9unJunOuNs=;
        b=Q0fWCgoJDARbp9SHiNDp8JDpMl9vLEdcTJ9eQUZN+WNApERfru5LeZuKXpCysfCTuZ
         4JoyevTlN7Ot5mzWZAxD9JwDlTx8cH9fRbZaAFYozElxNG2yBIHz42X3lHW8yNAIQhHn
         dWYNokGwBhjtY37JLnDnOpXblShdFEdbUaZMGTikTC0TD8oFjRxG7QbFmtA/EPtakVs3
         BS0t4QFH0LDYO+CmupAFWNkfPcuWh4NapJJwZVMbm4V+f0Z3anoU7OEyEeZYr4KLuVBN
         gsJ/bUvlnv6K9FMPW5yLSoeKNKvxDMb+/Of7Nv5zTDPydOztX+PCJwNYO0Kjkporpa70
         9LBQ==
X-Gm-Message-State: AOJu0Yxne6FFB2EDlF3txLFrFIYqS0nVVmCB0sVlOKcOo/dOdMeG+ykR
        foIzJmO9AuboV6sM/ujX0Lw6DSPgfwFXmM02uDJQYQ==
X-Google-Smtp-Source: AGHT+IGo4834Qu+hswUxKMIx1Kiswwy8W/FJPj8GnmqgXzkPnBafwOOVSsprB+brYtziKci5XXZIq8FKLRo7t2quaNY=
X-Received: by 2002:a67:f491:0:b0:447:6c24:7d93 with SMTP id
 o17-20020a67f491000000b004476c247d93mr4177330vsn.20.1692269489522; Thu, 17
 Aug 2023 03:51:29 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 17 Aug 2023 16:21:17 +0530
Message-ID: <CA+G9fYvFD-kE0+EGWkwcnR1DXRxh7p7OwQThJ6KWxYWVROJ4+A@mail.gmail.com>
Subject: landlock: fs_test: fs_test.c:4524:9: error: initializer element is
 not a compile-time constant
To:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        lkft-triage@lists.linaro.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While building selftests landlock following warnings / errors noticed on the
Linux next with clang-17.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
------------
landlock/fs_test
fs_test.c:4524:9: error: initializer element is not a compile-time constant
 4524 |         .mnt = mnt_tmp,
      |                ^~~~~~~
1 error generated.

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2U69ue7AaypfY7eRU4UUygecrDx/

Steps to reproduce:
tuxmake --runtime podman --target-arch arm64 --toolchain clang-17
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2U69ue7AaypfY7eRU4UUygecrDx/config
LLVM=1 LLVM_IAS=1 dtbs dtbs-legacy headers kernel kselftest modules

--
Linaro LKFT
https://lkft.linaro.org
