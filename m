Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644E37283F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbjFHPoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 11:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbjFHPoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:44:08 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72E52719
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 08:43:43 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 290E63F484
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686239018;
        bh=U9FNme5iBEpufhowdmn6D6u4P9E81AUlwyvYSH4GMyo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=wWHKaoh/RNyVXAzoobWzATmKOm4ymDKvayp8+/5tjEQEIB9ubRslQF0NIVEcWARc5
         IRpHCXu4zGJdr/EmqdJcdUMbXqsY7+BtjfW7oPRC7KD133Q0+mWmQ2MdOD9V6Pl6pv
         BlRNwpRPQNK4ayhLQm4bVMnv50Ku2aUrlI+zaXCHYy2UK0c92vdj/SemkYyLpLLkx6
         ZkZ/4jNJ1gYqqiVO8YmLzr90TzFwSDAMlq8GDoraebaj4+9XXY0oqgPEDb9/0E/1c7
         hC9VbldKiv6qjzDjWjpDqNAmTQXQwMlZZ2b3aRD++3w8iclv97aFIq3u8V8ylyJc3V
         7OcP2bf6GO9CQ==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51495d51e0fso754591a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239014; x=1688831014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9FNme5iBEpufhowdmn6D6u4P9E81AUlwyvYSH4GMyo=;
        b=IRskYGIcS6jGLDIh16HyFGz33IctHFocE8Wmx8WT0NemtYa9RSGxzhwTW9rameb6E4
         yrlCICrhqV/XHp20KgKZchlr6urqJiJv2FapCWUpUzBiAcJljQzeS/g91W5698305BUy
         /H9n/Oz73czAgI3TScSeQNA+eV1HGKvFFcwBRLODJRoqFh8QXexpJbSqZNl8zoyHqq3H
         dIvv79pmb1ar5na27qr+b7LqCCHS+svnoE2fR9b9tQ0S+gDLtv+1/LSPVyfbB451r1Lu
         gl/JC9szO5/9Nr+fXcJXBhkDWfedI0ED6LIxPbZPvogz7EEBwxQBdGZeMbfpLaoc3gYS
         BsEg==
X-Gm-Message-State: AC+VfDwS/oklSH0eABlP4i8fUClQyNidvNvZCC9HBz5e/n1BWWYihfQu
        oSqJzi+AwahyjzQ/+wC0b/mdOIIkL9CxqDNp7vslxg2/+1Fau1aEs66RN34eZoDSV5iW+TA4IhI
        WmAn3T6LuV6LvbkNW3YJESN72YJkowlX1XcFbaBxoRyl8UhRRmFM=
X-Received: by 2002:a05:6402:147:b0:514:9c05:819e with SMTP id s7-20020a056402014700b005149c05819emr7681643edu.0.1686239013828;
        Thu, 08 Jun 2023 08:43:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ735DyjETywLYDs+jXXCutddOvsHT2twFvkzH160wtul6aVFuOgt/4u3yyoBsAtPQpaf211Jg==
X-Received: by 2002:a05:6402:147:b0:514:9c05:819e with SMTP id s7-20020a056402014700b005149c05819emr7681635edu.0.1686239013667;
        Thu, 08 Jun 2023 08:43:33 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:33 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/14] ceph: allow idmapped getattr inode op
Date:   Thu,  8 Jun 2023 17:42:46 +0200
Message-Id: <20230608154256.562906-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_getattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8e5f41d45283..2e988612ed6c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2465,7 +2465,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 			return err;
 	}
 
-	generic_fillattr(&nop_mnt_idmap, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	stat->ino = ceph_present_inode(inode);
 
 	/*
-- 
2.34.1

