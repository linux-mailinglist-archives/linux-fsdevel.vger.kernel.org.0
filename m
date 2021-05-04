Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9485372F76
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhEDSJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 14:09:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:41081 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232286AbhEDSJG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 14:09:06 -0400
IronPort-SDR: xt4R20iKklfn+UN88ubuUX3TkOtz1VjODboRKDSFH55jdh7QPue4W53AzAh9iRv6asPdKifc1A
 WNSj4kua+F/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="261993802"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="261993802"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 11:08:11 -0700
IronPort-SDR: DvOmjqsFX3DiL+jZvB6kmSBzISvZE+VtSnslgISxcDhuFmYjqSA3jCEK7r7IufzlrGUk9PEgen
 4jc36wd6d4ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="458141116"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 04 May 2021 11:08:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0E595934; Tue,  4 May 2021 21:08:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 10/15] MAINTAINERS: Add myself as designated reviewer for generic string library
Date:   Tue,  4 May 2021 21:08:14 +0300
Message-Id: <20210504180819.73127-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
References: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
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

