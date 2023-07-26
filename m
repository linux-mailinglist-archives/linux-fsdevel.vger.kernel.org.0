Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372E5763CE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGZQrq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjGZQrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:47:45 -0400
Received: from aer-iport-6.cisco.com (aer-iport-6.cisco.com [173.38.203.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA8270B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=576; q=dns/txt; s=iport;
  t=1690390036; x=1691599636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UnLNYfFO6tQLV/Mk+1rvunpJiCcagHvFt3GyP/A8BGs=;
  b=cdaKo1kajLAMXci1HocfMc1X5g7exk5+UWekseQBiTRQGipbEdTAHUpg
   u9QM806Z1Y3QwIln6+spUexZ88Rvk7EVWEHeNE3LIojbXMgWXGeAr2hCm
   rjhhyK3MVd8eGKTc+E1nRzj6mPRhwi2EK9nIZc2RvlIMcgV0eRYm/JyIA
   g=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="6049462"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:46:11 +0000
Received: from archlinux-cisco.cisco.com (dhcp-10-61-98-211.cisco.com [10.61.98.211])
        (authenticated bits=0)
        by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 36QGjqTs022602
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 16:46:10 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v2 02/10] kernel: configs: enable rust samples in rust.config
Date:   Wed, 26 Jul 2023 19:45:26 +0300
Message-ID: <20230726164535.230515-3-amiculas@cisco.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726164535.230515-1-amiculas@cisco.com>
References: <20230726164535.230515-1-amiculas@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas
X-Outbound-SMTP-Client: 10.61.98.211, dhcp-10-61-98-211.cisco.com
X-Outbound-Node: aer-core-7.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 kernel/configs/rust.config | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/configs/rust.config b/kernel/configs/rust.config
index 38a7c5362c9c..63798ae5f3a5 100644
--- a/kernel/configs/rust.config
+++ b/kernel/configs/rust.config
@@ -1 +1,11 @@
 CONFIG_RUST=y
+
+CONFIG_MODULES=y
+CONFIG_SAMPLES=y
+CONFIG_SAMPLES_RUST=y
+CONFIG_SAMPLE_RUST_MINIMAL=m
+CONFIG_SAMPLE_RUST_PRINT=m
+CONFIG_SAMPLE_RUST_FS=m
+CONFIG_SAMPLE_PUZZLEFS=y
+CONFIG_SAMPLE_RUST_HOSTPROGS=y
+
-- 
2.41.0

