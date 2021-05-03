Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2D23721F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 22:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhECUt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 16:49:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:39596 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhECUtx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 16:49:53 -0400
IronPort-SDR: SeOHntVE/X58g+nENwpB2fkjyiQXDKoU+D3vyeideNB0quUvcs79PIitK40Axa5CDj9wFoHl3p
 A97uWidVGqTQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197447247"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="197447247"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 13:48:58 -0700
IronPort-SDR: BQjeTToE2rfPr4JUdgiAiWfG0KdL3Yw6jgHuZVTSR2sUStHh/6WChZPpARgCwh6wpzhRjII/FB
 fq7BF66zOMZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="621302020"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2021 13:48:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 95A1F9A1; Mon,  3 May 2021 23:49:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 12/12] MAINTAINERS: Add myself as designated reviewer for generic string library
Date:   Mon,  3 May 2021 23:49:07 +0300
Message-Id: <20210503204907.34013-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
References: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself as designated reviewer for generic string library.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1783372a608a..2c5797fc462c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7650,6 +7650,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/touchscreen/resistive-adc-touch.c
 
+GENERIC STRING LIBRARY
+R:	Andy Shevchenko <andy@kernel.org>
+S:	Maintained
+F:	lib/string.c
+F:	lib/string_helpers.c
+F:	lib/test_string.c
+F:	lib/test-string_helpers.c
+
 GENERIC UIO DRIVER FOR PCI DEVICES
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	kvm@vger.kernel.org
-- 
2.30.2

