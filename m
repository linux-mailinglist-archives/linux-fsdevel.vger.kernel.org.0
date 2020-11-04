Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601232A5CB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 03:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgKDCax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 21:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbgKDCax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 21:30:53 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AACDC061A4D;
        Tue,  3 Nov 2020 18:30:53 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 13so16048094pfy.4;
        Tue, 03 Nov 2020 18:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ptosR5vhEbiMhlxkFVcBuL1a0n21eSL1TE17XqRrfvM=;
        b=ZfXXQrNLKoLHI7wCDCxp/1qrH8BqQKhUw3VSrGjD+GcGyXRzNyaI6Avu/IEWVdvb5m
         lEjvYqW+fhfR253pqXdEo6fqzR+viCnYfHn2Nygm9QHdNL5v3eLCX9Qc+cJ+gsPIYL3K
         8qVQrGFUYIZ6h74WkK6HNP1TspNB6yI4WafJsYpFlvhkiGnyBTzoQckE7+0FoyDENTr9
         JZIY8xAdT19cUgfI5Bn+9tJk+zGHe5bRTlpfAGhOf89PZmNCZ3bfSqv0RQVKXrHtig/B
         WDwRVQkb8PH3yd97nTtWfc/2m+SqNxOzIPGyKZdDHA0wVKUpQdgAXPXO3EM9nCdYB8H4
         6Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ptosR5vhEbiMhlxkFVcBuL1a0n21eSL1TE17XqRrfvM=;
        b=YXqxVA+GePS0s1UEvLDovQr1adpnva/bZE5ke8fP2nTb/ppqWoGhg4jFEaJI5QntJ5
         2zjnXRoCkiVMitOlsPEU1H93uOo2NWmNrqsnZGgKskpHNHkBoZiYigcd5i6DclABwh9d
         LgIwRA3OkM/ePS4GZ7UlnR4K5c4yb1VqfMYlVEmTHDgDJgJEfRMP8jxpsNKyrHLvdsQY
         0BvhuMA7/s6kIlrj0lbV/oOJyunYu/OlZgy/PT8WEKrSLX3Y+MH/1ALwVu7y95mudiTK
         4oTQgG05eXSMBQk3o0OWeXO7r0MY0kXZByo5aXCL3Hq6/Lr+JEDF+udH/hca9S/FhsOw
         /g9Q==
X-Gm-Message-State: AOAM532Arr0slwPNiEY0rMiJus7fd1h5PYCTPq6Lo8Woc40gkWSKJB8t
        1J/HuySH4ZBB01+gAYd9zbs=
X-Google-Smtp-Source: ABdhPJztQmFCoSN+ZE4wdVkghQDsGxz/6uszo82h6dL5MOgdDyIrA2WEVGWvqQ9HhcertOcNac5yYg==
X-Received: by 2002:aa7:9245:0:b029:156:552a:1275 with SMTP id 5-20020aa792450000b0290156552a1275mr28647930pfp.12.1604457052866;
        Tue, 03 Nov 2020 18:30:52 -0800 (PST)
Received: from ZB-PF11LQ25.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id j19sm443238pfn.107.2020.11.03.18.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 18:30:52 -0800 (PST)
From:   "xiaofeng.yan" <xiaofeng.yan2012@gmail.com>
To:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        oulijun@huawei.com, yanxiaofeng7@jd.com, xiaofeng.yan2012@gmail.com
Subject: [PATCH 2/2] infiniband: Modify the reference to xa_store_irq()  because the parameter of this function  has changed
Date:   Wed,  4 Nov 2020 10:32:13 +0800
Message-Id: <20201104023213.760-2-xiaofeng.yan2012@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104023213.760-1-xiaofeng.yan2012@gmail.com>
References: <20201104023213.760-1-xiaofeng.yan2012@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "xiaofeng.yan" <yanxiaofeng7@jd.com>

function xa_store_irq() has three parameters because of removing
patameter "gfp_t gfp"

Signed-off-by: xiaofeng.yan <yanxiaofeng7@jd.com>
---
 drivers/infiniband/core/cm.c            | 2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c | 2 +-
 drivers/infiniband/hw/mlx5/srq_cmd.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 5740d1ba3568..afcb5711270b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -879,7 +879,7 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
 static void cm_finalize_id(struct cm_id_private *cm_id_priv)
 {
 	xa_store_irq(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
-		     cm_id_priv, GFP_KERNEL);
+		     cm_id_priv);
 }
 
 struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6c081dd985fc..1876a51f9e08 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -237,7 +237,7 @@ static int hns_roce_qp_store(struct hns_roce_dev *hr_dev,
 	if (!hr_qp->qpn)
 		return -EINVAL;
 
-	ret = xa_err(xa_store_irq(xa, hr_qp->qpn, hr_qp, GFP_KERNEL));
+	ret = xa_err(xa_store_irq(xa, hr_qp->qpn, hr_qp));
 	if (ret)
 		dev_err(hr_dev->dev, "Failed to xa store for QPC\n");
 	else
diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
index db889ec3fd48..f277e264ceab 100644
--- a/drivers/infiniband/hw/mlx5/srq_cmd.c
+++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
@@ -578,7 +578,7 @@ int mlx5_cmd_create_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 	refcount_set(&srq->common.refcount, 1);
 	init_completion(&srq->common.free);
 
-	err = xa_err(xa_store_irq(&table->array, srq->srqn, srq, GFP_KERNEL));
+	err = xa_err(xa_store_irq(&table->array, srq->srqn, srq));
 	if (err)
 		goto err_destroy_srq_split;
 
-- 
2.17.1

