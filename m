Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE01F76C700
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 09:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjHBHgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 03:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjHBHgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:36:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B6211B
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 00:35:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcf2de59cso1002059466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690961733; x=1691566533;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6qdd5l4sb0NofKO0/tBv3WOfZ7if+sJeiyN7XJripk=;
        b=auV+MH/wzTe0hfhNtnHP1A67q30Z7P+ib0k7q722U1leJZ7birUvKtToECHshGOzuJ
         g9ybCmd+n6xJBItb/kpL101VdAOvSlFQwQd6yh5VjwhtMXy207AwU0dFhwrAEtvGIFPP
         FcGlBhC5enwV+YoXlHlDlsOfpXnQXZRM94MUhOairU+bT5RKsiqUTKPB1VaoMROZideM
         5fNyOJxPmVllY72HA9ypB37pyEeymfhYyfBlrvDvok2cLWUfc2yMbSAP42syi5jWZ9p1
         puUdN6WCk+p53f1oVPk52wc1F6xZWyt573wSe8AcYZzUET7RXFA8r7OkADmYNKsnh+Gn
         E8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690961733; x=1691566533;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6qdd5l4sb0NofKO0/tBv3WOfZ7if+sJeiyN7XJripk=;
        b=gVRXIiDT/OK32U71f5ZOGdjDmAtcUZa3jFidmnQwGFG50Sre83YeScz5pSozl+I6bm
         DDt4ncInAQDC28HdQsbA1ukfuvvALdSuogDygaDMwIJW0Nh2uUv0DFhVk7dhLAlQ2/RC
         7/AW/k7DZxYBQD01dPBRcbfB/WacONbqJx9bwA2Y63WM3riEhdrQyWGfTu4Oi8Beqd6t
         PlM8ckR9nUm02K0b4xUBu5zC49VIWMB1QP2EOG1V4L6WhXiuESqwq5ZcT+lU2qfpUTd8
         QT2I0H3XtcZJaFB+CuXLofHBmPCnZvky9WMdvyZBWYRcH6LqL+XWqi8JdvcNLY7X//Ee
         X4cg==
X-Gm-Message-State: ABy/qLZE7JJdbwaY1wdmb6v3xy0+sr+DwSdGVjLotxkX8EgFL3MAAp1r
        NDvk7227myR+LhKMG2AAkf4A0A==
X-Google-Smtp-Source: APBJJlECWLdgBNl4i7XPc4E06/2xVD2H7a3cKaK/4iyV5wnBIecY1CZ/+PzlolUM2lfe70tvfhr53w==
X-Received: by 2002:a17:907:75f2:b0:99c:2535:372d with SMTP id jz18-20020a17090775f200b0099c2535372dmr4684873ejc.33.1690961733722;
        Wed, 02 Aug 2023 00:35:33 -0700 (PDT)
Received: from localhost (h3221.n1.ips.mtn.co.ug. [41.210.178.33])
        by smtp.gmail.com with ESMTPSA id gy26-20020a170906f25a00b00993470682e5sm8658784ejb.32.2023.08.02.00.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:35:33 -0700 (PDT)
Date:   Wed, 2 Aug 2023 09:53:54 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     cem@kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] shmem: quota support
Message-ID: <ffd7ca34-7f2a-44ee-b05d-b54d920ce076@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Carlos Maiolino,

The patch 9a9f8f590f6d: "shmem: quota support" from Jul 25, 2023
(linux-next), leads to the following Smatch static checker warning:

	fs/quota/dquot.c:1271 flush_warnings()
	warn: sleeping in atomic context

fs/quota/dquot.c
    1261 static void flush_warnings(struct dquot_warn *warn)
    1262 {
    1263         int i;
    1264 
    1265         for (i = 0; i < MAXQUOTAS; i++) {
    1266                 if (warn[i].w_type == QUOTA_NL_NOWARN)
    1267                         continue;
    1268 #ifdef CONFIG_PRINT_QUOTA_WARNING
    1269                 print_warning(&warn[i]);
    1270 #endif
--> 1271                 quota_send_warning(warn[i].w_dq_id,
    1272                                    warn[i].w_sb->s_dev, warn[i].w_type);

The quota_send_warning() function does GFP_NOFS allocations, which don't
touch the fs but can still sleep.  GFP_ATOMIC or GFP_NOWAIT don't sleep.

    1273         }
    1274 }

The call trees that Smatch is worried about are listed.  The "disables
preempt" functions take the spin_lock_irq(&info->lock) before calling
shmem_recalc_inode().

shmem_charge() <- disables preempt
shmem_uncharge() <- disables preempt
shmem_undo_range() <- disables preempt
shmem_getattr() <- disables preempt
shmem_writepage() <- disables preempt
shmem_set_folio_swapin_error() <- disables preempt
shmem_swapin_folio() <- disables preempt
shmem_get_folio_gfp() <- disables preempt
-> shmem_recalc_inode()
   -> shmem_inode_unacct_blocks()
      -> dquot_free_block_nodirty()
         -> dquot_free_space_nodirty()
            -> __dquot_free_space()
               -> flush_warnings()

regards,
dan carpenter
