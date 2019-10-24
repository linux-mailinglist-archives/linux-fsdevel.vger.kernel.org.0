Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D86DE3709
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409780AbfJXPxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:53:48 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54006 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409777AbfJXPxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:53:48 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFrlCF026245
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:53:47 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFrfIi002516
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:53:47 -0400
Received: by mail-qt1-f198.google.com with SMTP id j18so17903870qtp.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Xhl3yPOVTS2L2RYtPzBM49DHpAh9fTsOmofvxnsaE1A=;
        b=LHD1CtD5L5bPUZVf1l6xtk4W1ktyJ9+EP7r/2V+SlqWhWC+Tk8g0FZ8ZIycZezPNkq
         iAYQxegjIcZ4rC2rH+T0SjDXkqOLXjg+9rIv/4PyA1l96QfoaW+1T1JtZc1LrRIthxc+
         HfUzABTSDNeiFygE8PmozMhIaEvuuW4bJbab9Bsm4L5YrBsYK8sEm3cNpFdck9fSeoKv
         o94DdZc5nr0Zd8vxNEFU0/PT2w7kf95FzPunH8qXFyhE6zwwvkYxIMI0NE33rqRKWElf
         O3TbqyHgTTeHBBP2/9KYkvCwdP6knjrneJXQmTFl+FUB98NicRRRtR0Ok+EcOYYxLoRS
         Xd/w==
X-Gm-Message-State: APjAAAXzStvQ8KJOMXVhDBNLGZ26YB0GvVdx7smYz3xGBL5XjKoDCE8H
        TBgRCHsNgfYeeVf3302AJUNekNb93i6qHShHL08KDXeKTvX/2dV6FmLcbnQyC2tDsCQHXW4p73Y
        o77mh2nbQxKLG0PXO4tgBayptKe6F8H/rfET7
X-Received: by 2002:a37:2d45:: with SMTP id t66mr14451075qkh.259.1571932421736;
        Thu, 24 Oct 2019 08:53:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUv24uQguHXg4C03DgpvZQ5tzq4FGlK1SUvQChOMriwm2Q3/z3HIw7lT52ZNonLIB5QOV5vg==
X-Received: by 2002:a37:2d45:: with SMTP id t66mr14451045qkh.259.1571932421394;
        Thu, 24 Oct 2019 08:53:41 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:53:40 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] staging: exfat: Clean up return codes
Date:   Thu, 24 Oct 2019 11:53:11 -0400
Message-Id: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The code had its own non-standard FFS_FOO return codes. Go through
and convert them all the kernel standard -EFOO codes.

Valdis Kletnieks (15):
  staging: exfat: Clean up return codes - FFS_FULL
  staging: exfat: Clean up return codes - FFS_NOTFOUND
  staging: exfat: Clean up return codes - FFS_DIRBUSY
  staging: exfat: Clean up return codes - FFS_PERMISSIONERR
  staging: exfat: Clean up return codes - FFS_NAMETOOLONG
  staging: exfat: Clean up return codes - FFS_FILEEXIST
  staging: exfat: Clean up return codes - FFS_INVALIDPATH
  staging: exfat: Clean up return code - FFS_MEMORYERR
  staging: exfat: Clean up return codes - FFS_FORMATERR
  staging: exfat: Clean up return codes - FFS_MEDIAERR
  staging: exfat: Clean up return codes - FFS_EOF
  staging: exfat: Clean up return codes - FFS_INVALIDFID
  staging: exfat: Clean up return codes - FFS_ERROR
  staging: exfat: Clean up return codes - remove unused codes
  staging: exfat: Clean up return codes - FFS_SUCCESS

 drivers/staging/exfat/exfat.h        |  24 +--
 drivers/staging/exfat/exfat_blkdev.c |  18 +-
 drivers/staging/exfat/exfat_cache.c  |   4 +-
 drivers/staging/exfat/exfat_core.c   | 202 ++++++++++----------
 drivers/staging/exfat/exfat_super.c  | 269 ++++++++++++++-------------
 5 files changed, 249 insertions(+), 268 deletions(-)

-- 
2.23.0

