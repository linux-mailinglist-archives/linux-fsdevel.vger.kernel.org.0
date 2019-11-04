Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB29ED721
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 02:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfKDBpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 20:45:47 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35516 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728443AbfKDBpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:45:47 -0500
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41jjgg009841
        for <linux-fsdevel@vger.kernel.org>; Sun, 3 Nov 2019 20:45:45 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41jeO0023449
        for <linux-fsdevel@vger.kernel.org>; Sun, 3 Nov 2019 20:45:45 -0500
Received: by mail-qt1-f199.google.com with SMTP id m20so17324882qtq.16
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2019 17:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=RKwtkBIAams4QpcFBs9xpUD62iCs2qKNfP05u/piSu4=;
        b=FpS9pyq7ueXmrqd0R5dS1jWu4aZTOpPKa4GRN/WN0o/PDMWN6WhH1UjHwrxbryo0LS
         KaCwmyug7pM7zyyrHS5xjyVTbF11Cv6blXk/Q6rhxYwMKSmZB79ZyeZNDufhFJy9I56W
         T235XLyjLBo9ITtKVlA0x/SD44fPYz5Lj57NmAMpj4nBGaUhsGEXAVwcTeMFmSUmP9Pd
         gOggvLt6fYC1Bae0D02sks8uTyx6uninqZt2pYHus4ZAspnQZPkDNBIG7ajh5CRM0wdo
         yOV0XrHKSOFR/eCu4xVhZFhByrqYQ22FXpZXrZjj89f3QU+5iVtFVr7AZf2eZL5+T+t/
         kw+Q==
X-Gm-Message-State: APjAAAWBe+EIcNyQFyzCJjx3RxLwUaidejCe5d6Bd+NDHCmrXhRyw9q3
        jzshnq4ZhWKcr47g8d4bR3bdzMs2mYJO6I+hr1HPy7LitVVEjVkAXlkIUyj7lVg5Y9uAkW0y3UO
        tUZLuIfi6N7STszqhAJGINds1+wULjh7I4VxR
X-Received: by 2002:a37:4d88:: with SMTP id a130mr14181905qkb.28.1572831940632;
        Sun, 03 Nov 2019 17:45:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzRNhCq1LyO5YV8hnPJUKHf4l41tnhvU4mUKxlg/F79Zm3mhjkpCGchHCc3XPJ/nQRA2xMtoA==
X-Received: by 2002:a37:4d88:: with SMTP id a130mr14181892qkb.28.1572831940271;
        Sun, 03 Nov 2019 17:45:40 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:45:39 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] staging: exfat: Clean up return codes, revisited
Date:   Sun,  3 Nov 2019 20:44:56 -0500
Message-Id: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The rest of the conversion from internal error numbers to the
standard values used in the rest of the kernel.

Patch 10/10 is logically separate, merging multiple #defines
into one place in errno.h.  It's included in the series because
it depends on patch 1/10.

Valdis Kletnieks (10):
  staging: exfat: Clean up return codes - FFS_FORMATERR
  staging: exfat: Clean up return codes - FFS_MEDIAERR
  staging: exfat: Clean up return codes - FFS_EOF
  staging: exfat: Clean up return codes - FFS_INVALIDFID
  staging: exfat: Clean up return codes - FFS_ERROR
  staging: exfat: Clean up return codes - remove unused codes
  staging: exfat: Clean up return codes - FFS_SUCCESS
  staging: exfat: Collapse redundant return code translations
  staging: exfat: Correct return code
  errno.h: Provide EFSCORRUPTED for everybody

 drivers/staging/exfat/exfat.h        |  14 --
 drivers/staging/exfat/exfat_blkdev.c |  18 +-
 drivers/staging/exfat/exfat_cache.c  |   4 +-
 drivers/staging/exfat/exfat_core.c   | 202 +++++++++---------
 drivers/staging/exfat/exfat_super.c  | 293 +++++++++++----------------
 fs/erofs/internal.h                  |   2 -
 fs/ext4/ext4.h                       |   1 -
 fs/f2fs/f2fs.h                       |   1 -
 fs/xfs/xfs_linux.h                   |   1 -
 include/linux/jbd2.h                 |   1 -
 include/uapi/asm-generic/errno.h     |   1 +
 11 files changed, 228 insertions(+), 310 deletions(-)

-- 
2.24.0.rc1

