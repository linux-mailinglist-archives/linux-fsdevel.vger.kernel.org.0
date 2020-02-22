Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D625416906E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 17:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgBVQpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 11:45:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:5654 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgBVQpX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:45:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2020 08:45:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,472,1574150400"; 
   d="scan'208";a="283989618"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Feb 2020 08:45:17 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j5Xu0-0001QN-DO; Sun, 23 Feb 2020 00:45:16 +0800
Date:   Sun, 23 Feb 2020 00:44:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     kbuild-all@lists.01.org, Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [RFC PATCH] misc: bcm-vk: image_tab[] can be static
Message-ID: <20200222164450.GA660@e50d7db646c3>
References: <20200220004825.23372-7-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220004825.23372-7-scott.branden@broadcom.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Fixes: b6354450d21b ("misc: bcm-vk: add Broadcom VK driver")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 bcm_vk_dev.c |    2 +-
 bcm_vk_msg.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index d8f59e898ca8a..24cdab04c8703 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -31,7 +31,7 @@ enum soc_idx {
 };
 
 #define NUM_BOOT_STAGES 2
-const struct load_image_tab image_tab[][NUM_BOOT_STAGES] = {
+static const struct load_image_tab image_tab[][NUM_BOOT_STAGES] = {
 	[VALKYRIE] = {
 		{VK_IMAGE_TYPE_BOOT1, VK_BOOT1_DEF_VALKYRIE_FILENAME},
 		{VK_IMAGE_TYPE_BOOT2, VK_BOOT2_DEF_VALKYRIE_FILENAME}
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index 651fba2149e28..9247d4bc50288 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -99,8 +99,8 @@ static void bcm_vk_h2vk_verify_blk
 #define BCM_VK_QSTATS_ACC_CNT 20000
 #endif
 
-void bcm_vk_update_qstats(struct bcm_vk *vk, const char *tag,
-			  struct bcm_vk_qstats *qstats, uint32_t occupancy)
+static void bcm_vk_update_qstats(struct bcm_vk *vk, const char *tag,
+				 struct bcm_vk_qstats *qstats, uint32_t occupancy)
 {
 	struct bcm_vk_qs_cnts *qcnts = &qstats->qcnts;
 
@@ -731,7 +731,7 @@ int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, uint32_t shut_type,
 	return rc;
 }
 
-int bcm_vk_handle_last_sess(struct bcm_vk *vk, struct task_struct *ppid)
+static int bcm_vk_handle_last_sess(struct bcm_vk *vk, struct task_struct *ppid)
 {
 	int rc = 0;
 	pid_t pid = task_pid_nr(ppid);
