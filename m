Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D18E187646
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 00:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbgCPXix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 19:38:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39562 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732965AbgCPXix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:38:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id f7so19990543wml.4;
        Mon, 16 Mar 2020 16:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JcxuHAW37OjzFVtEwmZsPENLIkG+JBjq5NGDlYypiIs=;
        b=lqCtwXg4k9EIMoRFMa4jK+CVdo7cegfkYQw7gQR2bwcAQmd0cwdiIBt9BSk6BREbt5
         ztOJ1NHIFEbjDyA70yPF90EvV5w+zW/k9Th0v9tTKz2FpEQSfhFhowC508V0NXH/DVVN
         ELoZGii4qePdtcZap0eopPL7Ec6Rgc85mNwHBvyR4ax0Jr1DXaK8aWrsnTxOin+cEoGB
         9r5gGg3cRuR9yJ/OdSFKKRYJotKHCd5LsML4ObieSQO9Ol0+pq0NH+NB+LohOp8H8ipv
         5XOdJWc6FxOLqYVWHaqCndYHCd0GgEDuZPrtHg5uWvrkIAT8clwMN+Qk9IFXRTkmoWhT
         9npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JcxuHAW37OjzFVtEwmZsPENLIkG+JBjq5NGDlYypiIs=;
        b=WPbbGqts8fsOSLk5jL/DjvsC4DQDyFetFEkgum9CoYranyq3bMOkRnHyBubtRae7Ct
         f8BSYWtJFmR7TxuilLFzC8KRWBq8sRCBSuOxVDjP8GzsrFjhZKjAUs8tsbyD2eCVTrDj
         1GxE7x1feGy1Zitq0QK7bomDIZVmgMQ+3gmBmDPtRItseYnsFyZo/BVCTlUx0KofwNKb
         JxXkIRpszRfLvNR/X6rmg8o75BTZKs6K3VuVTuEQo7JQZzJn8KKZenAjN5FtjUFTLIlk
         +DeYAXO9TPm9n9ahFyju9H4TlsI7z1cMN0urjv6bMEzdwGEjbSQ70rBhITXwlHLfjr74
         7ciw==
X-Gm-Message-State: ANhLgQ3KMBN9xsw8sWH6JL9DNF6wJ0tqZTksb03PLtYgEX+LeOIpHgHB
        Lt9eQHGH6Sr+gj83Bcwx5c0QfwzsCw==
X-Google-Smtp-Source: ADFU+vvis1ODa/CKkRIv31JR7FGkm14YQKSbtQ37CZWE4yMC/00Q54t9tG7NHErPFCj3IpHvIsK73w==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr1539453wmi.129.1584401931297;
        Mon, 16 Mar 2020 16:38:51 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.googlemail.com with ESMTPSA id i9sm1510495wmd.37.2020.03.16.16.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 16:38:50 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4/6] fs/fs-writeback.c: Add missing annotation for wbc_attach_and_unlock_inode()
Date:   Mon, 16 Mar 2020 23:38:02 +0000
Message-Id: <20200316233804.96657-5-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316233804.96657-1-jbi.octave@gmail.com>
References: <0/6>
 <20200316233804.96657-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sparse reports a warning at wbc_attach_and_unlock_inode()

warning: context imbalance in wbc_attach_and_unlock_inode() - unexpected unlock

The root cause is the missing annotation at wbc_attach_and_unlock_inode()
Add the missing __releases(&inode->i_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/fs-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 76ac9c7d32ec..008e572faf32 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -556,6 +556,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
  */
 void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
 				 struct inode *inode)
+	__releases(&inode->i_lock)
 {
 	if (!inode_cgwb_enabled(inode)) {
 		spin_unlock(&inode->i_lock);
-- 
2.24.1

