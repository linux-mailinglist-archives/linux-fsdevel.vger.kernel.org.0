Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E609CF24CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 03:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfKGCAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 21:00:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57874 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727751AbfKGCAX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:00:23 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D117335A3CCE2E0657A3;
        Thu,  7 Nov 2019 10:00:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 7 Nov 2019 10:00:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: vboxsf: Remove unused including <linux/version.h>
Date:   Thu, 7 Nov 2019 01:59:23 +0000
Message-ID: <20191107015923.100013-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/vboxsf/vfsmod.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vboxsf/vfsmod.h b/drivers/staging/vboxsf/vfsmod.h
index de650d65fbe4..18f95b00fc33 100644
--- a/drivers/staging/vboxsf/vfsmod.h
+++ b/drivers/staging/vboxsf/vfsmod.h
@@ -10,7 +10,6 @@
 
 #include <linux/backing-dev.h>
 #include <linux/idr.h>
-#include <linux/version.h>
 #include "shfl_hostintf.h"
 
 #define DIR_BUFFER_SIZE SZ_16K



