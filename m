Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 045281A5E6A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 14:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgDLMCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Apr 2020 08:02:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:49832 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDLMCG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Apr 2020 08:02:06 -0400
IronPort-SDR: BeFWcnceOgQp/qiVsz7axudNI1ZMy7phbknUYShQSjzceAIA2w5Io2h4klAIV8FZeC+2QSqntX
 C8rj0KJmL3Ow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 05:02:06 -0700
IronPort-SDR: LKar3uLgQX0Xg5HI3wPOirQyvgQOLuEoU6vNaNB3C4yH9W3V1+QVFr0WTVJSEvzBz7t6dm+5fF
 LZQOUVfwGQ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="243318990"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Apr 2020 05:02:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jNbJM-000Due-HI; Sun, 12 Apr 2020 20:02:04 +0800
Date:   Sun, 12 Apr 2020 20:01:51 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [RFC PATCH] unicode: ucd_init() can be static
Message-ID: <20200412120149.GA19219@97594fc72ec1>
References: <20200411235823.2967193-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411235823.2967193-1-krisman@collabora.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Signed-off-by: kbuild test robot <lkp@intel.com>
---
 utf8-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 7e02827074356..b48e13e823a5a 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -250,7 +250,7 @@ static const struct attribute_group ucd_attr_group = {
 };
 static struct kobject *ucd_root;
 
-int __init ucd_init(void)
+static int __init ucd_init(void)
 {
 	int ret;
 
@@ -268,7 +268,7 @@ int __init ucd_init(void)
 	return 0;
 }
 
-void __exit ucd_exit(void)
+static void __exit ucd_exit(void)
 {
 	kobject_put(ucd_root);
 }
