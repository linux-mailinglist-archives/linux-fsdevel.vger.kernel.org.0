Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9993BF86C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 03:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfKLCM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 21:12:59 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:46124 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726960AbfKLCM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:12:59 -0500
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2CweQ028963
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:12:58 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2CruV009668
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:12:58 -0500
Received: by mail-qt1-f200.google.com with SMTP id v23so19093180qth.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 18:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=polEwBDR8XXLARzNp+HkpzWHOByZmMxX1iuAZdjZWhc=;
        b=iw3Q/EnVCAKDAPEgUz60rMT6HNJyiyWza9LNCOPeR3GUVsFlXTWypCOIQCBJ/0JuWq
         zoSjIvvz5Qx0MANaW/YdenWR9MnHSOjcbKasBrndRuWpZQr6ilyJcxAU1ix6XjpCSCBk
         sjlbLF1iFYa2rX+W3k9UbeXmgWakW+KAdT+tFf+KodFk3ilHkUSSJiJ6vpVyFXFMPVFS
         guJpIR4vvLoddJfrpHDSPc7T64laDcspBO9orzS3bUG95Y6dUz3r66H4OeMBaerQHJ5B
         qQFAhMW98nEJKg8XOcU4eB7hhlaY18TzJLc51Tt38tGWLLx1gEbxhiZlHIoJByRhUqwr
         WSuw==
X-Gm-Message-State: APjAAAWwIOYwW1P0nANfJXfE/4aHT37QPiclX21K7jsF6ibOBlPJViBj
        MLzSRBaaSBPdSDSU90TP2ILpQfdrjFlyNPp/uijZMfsiyNcI3a8ptq1dF6veWwWWRAAYzqATfQ+
        qUNGpiRY0R68jHvYcsUUPKU2k9tCGkSeTLtAc
X-Received: by 2002:a05:620a:896:: with SMTP id b22mr12855088qka.386.1573524773447;
        Mon, 11 Nov 2019 18:12:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwy3ab3YXg8NLEvbLnXy2wX6Wbxx2azYGpPT3/n2YbPGjWD4sfMc09fWFB7AQ+6oEC2HKezhQ==
X-Received: by 2002:a05:620a:896:: with SMTP id b22mr12855078qka.386.1573524773159;
        Mon, 11 Nov 2019 18:12:53 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id v54sm9150233qtc.77.2019.11.11.18.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:12:51 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Subject: [PATCH v3 0/9] staging: exfat: Clean up return codes
Date:   Mon, 11 Nov 2019 21:12:42 -0500
Message-Id: <20191112021242.42412-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the oddball return codes with Linux-standard values

Changes since v2:

Fixed the git miscue that left one patch fragment in the wrong commit
Dropped the patch that added EFSCORRUPTED to errno.h because that method
won't work on some architectures.
Rebased to today's staging-next tree.

Valdis Kletnieks (9):
  staging: exfat: Clean up return codes - FFS_FORMATERR
  staging: exfat: Clean up return codes - FFS_MEDIAERR
  staging: exfat: Clean up return codes - FFS_EOF
  staging: exfat: Clean up return codes - FFS_INVALIDFID
  staging: exfat: Clean up return codes - FFS_ERROR
  staging: exfat: Clean up return codes - remove unused codes
  staging: exfat: Clean up return codes - FFS_SUCCESS
  staging: exfat: Collapse redundant return code translations
  staging: exfat: Correct return code

 drivers/staging/exfat/exfat.h        |  16 +-
 drivers/staging/exfat/exfat_blkdev.c |  18 +-
 drivers/staging/exfat/exfat_cache.c  |   4 +-
 drivers/staging/exfat/exfat_core.c   | 202 +++++++++---------
 drivers/staging/exfat/exfat_super.c  | 293 +++++++++++----------------
 5 files changed, 229 insertions(+), 304 deletions(-)

-- 
2.24.0

