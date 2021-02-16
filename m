Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9590331D2B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 23:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhBPWeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 17:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhBPWeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:34:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C018C061756;
        Tue, 16 Feb 2021 14:33:21 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w18so7094601pfu.9;
        Tue, 16 Feb 2021 14:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9ZZeFmYPar4ytuiy5T3uV3Ra8gNfUPO9xYra3G7Xhw=;
        b=XmFTtHZldE5lRMPe+UlIyvO/3oTod6GuU3b1wQ9y+1Mhl8pYYOV7KPIYvyqkQpd0I0
         G+0fOi7SEyT52e0UPpYQUbN4kfbtshTMGUylgHUPWvHjwkFzHjfX0mg9XJpLi0ds12nX
         H8QNsd2enAwrjAQzzDgYBwoJuLwIIT7GQyAz8YtMXOSpglg/nUaiddF/sMgs6uYT23pa
         KljDTdmBjnRJ3+hGKacyGRtdA5pCYXXi2paBhVC3MrZJPTduzm8GAdvvHRRIBbWh808A
         ZZoUXjvPTaiGJJFGMnjuDqIDc9npMmqsgVnpeBlIrz8ctB2I0mmcAg1T/TRiVWyZkGtR
         bwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9ZZeFmYPar4ytuiy5T3uV3Ra8gNfUPO9xYra3G7Xhw=;
        b=Slm1N5N0TCzv1QKAKokYas5+HBo7Izr3gqfA5qpQSbi3N9vC3Q/kxAQCvRyEsol8Ik
         zEprGu02i21Oqi6uxxZyB12NRd6eyBniGFPpO45/xUzCFAhAeisDZSlefA7qEMTnkHv2
         QUlObMl0qhj4MyJ7kDV1PvlLBntTVVddD9OagvO1mvE9hpaeTNzxQ3J/i7WUeCLu9i9F
         opQGUYD49eQ1vwJNTu94ihougw/zlLTF0s6PBN9gpvT++9vVXB2FXUvAiun8axN7DtMl
         UQrqBY7e+oIXP0hM1ZJiybRAaUApyJ/8SLNBmK54AbC30x4XKVUcmkWcscOoT/y5jyhj
         /d1g==
X-Gm-Message-State: AOAM53320i0qSWKqgqy2TCUifk9wEWxvv7appWwXSmFdLnSQS3yfaD/z
        eOvguemFCGVCsHkAqgyhuFKFg9APAKjpag==
X-Google-Smtp-Source: ABdhPJybxANDX5GpfdyuVwCzXZXoYYD/NsASwVvyoBw6OuxtZPozwJ2an07Vrizq6DDYG5S7UpbPPQ==
X-Received: by 2002:a63:2e01:: with SMTP id u1mr21197769pgu.408.1613514801147;
        Tue, 16 Feb 2021 14:33:21 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id w5sm579pfb.11.2021.02.16.14.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 14:33:20 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v2 0/2] Add FITRIM ioctl support for exFAT filesystem
Date:   Wed, 17 Feb 2021 07:33:04 +0900
Message-Id: <20210216223306.47693-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is for adding FITRIM ioctl functionality for exFAT filesystem.
For this, add generic ioctl handler and FITRIM operation.

Changelog
=========

v1->v2:
- Change variable declaration order as reverse tree style.
- Return -EOPNOTSUPP from sb_issue_discard() just as it is.
- Remove cond_resched() in while loop.
- Move ioctl related code into it's helper function.

Hyeongseok Kim (2):
  exfat: add initial ioctl function
  exfat: add support FITRIM ioctl

 fs/exfat/balloc.c   | 81 +++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/dir.c      |  5 +++
 fs/exfat/exfat_fs.h |  4 +++
 fs/exfat/file.c     | 54 ++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+)

-- 
2.27.0.83.g0313f36

