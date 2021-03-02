Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F6132A50F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442669AbhCBLqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243423AbhCBFQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:16:03 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4E3C061788;
        Mon,  1 Mar 2021 21:05:40 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u11so11304423plg.13;
        Mon, 01 Mar 2021 21:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9f99w1DjwazxW9/vNBn1/vZgHeGy+5iymNQh1t1cpm0=;
        b=sh+qB/pcLHvy/H2ES59GXzKInWtNezED2DKe8ZoibXTTUSfVouhL+0gRZEaKn5qRFG
         qnAMX/23h+WbeiQPuyxGMAOA+fN8vnKNvBPqERMhX8Yn1OF0nJ+zV87ankxfB+dZVlms
         VAQdwwa3orq/jpIBnW4KMVEZaFX5M3Oh3fX61ABVW/42At5CLlr/LLuion/d3aj+4sDA
         ziHNtbn1Q5AgBrHIfgXwEfNUuAUngbSJYkDhwP+9m3AkI3+ulFCtoxRng/8aYAN326nJ
         dvG+b7tn7Egak/f4oQR3ho1V2xE30AYEYKFhhgG5gkP/maOFqRg/SOR69U8LeQbaYLnH
         HXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9f99w1DjwazxW9/vNBn1/vZgHeGy+5iymNQh1t1cpm0=;
        b=nZauLoE6xOnf+hjLf/OLe5rXoOxMkCk/vLW1SYnwFPjMbItegKiPeH5Grjgq4Nb4Pw
         /TSVHffN7Ak5MFDekDk+rNWl4p1IuK6M+5mVaPpNHyJdy6EdHsuoCj8+1U9UHJwFVmkD
         /oHhbe7XftavrDesXfw1ht40WgDZE5KO0E1lr+bxHCUnvqSvqK4wT2yF5IF0twp1v5Cj
         iA+8NmX9eaLkYc7fpSS/D2pVHjf7Md6o0apsgT6DKCLTvlMQtK6uu+ri55JhlrgTQFRb
         3sEEiTDibOpknpF5XCFiiQu/OcbaeiJxmBkN1SRbcUs8gJJaTkcVPGVFwMoK1RjO+np7
         PDxw==
X-Gm-Message-State: AOAM531jDmqSyA8Kp44+ZabPGej6AQzwjCxCWP5CjStAoJRLgKD7s3G4
        /u7Te/IhYNzLlVJoPsW8Og0=
X-Google-Smtp-Source: ABdhPJzyJH9LBtkz4KrtUXVqEJl1FBTbsiwAwOVtYVwBy8R9ECR2yOvi8teyeW+D+xkyJmCJBvrwqw==
X-Received: by 2002:a17:902:ec83:b029:e3:ec1f:9dfe with SMTP id x3-20020a170902ec83b02900e3ec1f9dfemr1950990plg.59.1614661540246;
        Mon, 01 Mar 2021 21:05:40 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id s16sm19759143pfs.39.2021.03.01.21.05.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 21:05:39 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v4 0/2] Add FITRIM ioctl support for exFAT filesystem
Date:   Tue,  2 Mar 2021 14:05:19 +0900
Message-Id: <20210302050521.6059-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is for adding FITRIM ioctl functionality to exFAT filesystem.
Firstly, because the fstrim is long operation, introduce bitmap_lock
to narrow the lock range to prevent read operation stall.
After that, add generic ioctl function and FITRIM handler.

Changelog
=========
v3->v4:
- Introduce bitmap_lock mutex to narrow the lock range for bitmap access
  and change to use bitmap_lock instead of s_lock in FITRIM handler to
  prevent read stall while ongoing fstrim.
- Minor code style fix

v2->v3:
- Remove unnecessary local variable
- Merge all changes to a single patch

v1->v2:
- Change variable declaration order as reverse tree style.
- Return -EOPNOTSUPP from sb_issue_discard() just as it is.
- Remove cond_resched() in while loop.
- Move ioctl related code into it's helper function.

Hyeongseok Kim (2):
  exfat: introduce bitmap_lock for cluster bitmap access
  exfat: add support ioctl and FITRIM function

 fs/exfat/balloc.c   | 80 +++++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/dir.c      |  5 +++
 fs/exfat/exfat_fs.h |  5 +++
 fs/exfat/fatent.c   | 37 ++++++++++++++++-----
 fs/exfat/file.c     | 53 ++++++++++++++++++++++++++++++
 fs/exfat/super.c    |  1 +
 6 files changed, 173 insertions(+), 8 deletions(-)

-- 
2.27.0.83.g0313f36

