Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8980F72642B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbjFGPWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241330AbjFGPVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:21:41 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886432105
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:28 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5C8F33F15E
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151285;
        bh=E1ad9bQ1aGlayjQkBmzknmBzpwDvRLF1iaTT0A2Zyj8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZwSXdLpL0mrWFzrQMp+z7rIb0KqAFx8thlU8sx8/lN4Dk9lPSXrhNjIXWhU1LrlCk
         +KFnpGBKovYgBJEpVnvSUe2N8ufeQCPJ1MofgT7jOp9f7hiyRFyW5hYyJOLaWRumZS
         AmxjYwjZvSJCsSrp+dWblaYEkDR1/ApznOtN+2oglt9SLGMH4HzYzI/ndIc1WZmVU7
         sAUluamgc20ReUa3wmIWz6wrXXUky2y2OfnSs1ylsokw2osaX6GJOsWKB9H7lNrzoy
         yHjuoFKKG8WQaZvNdSke6y0URRTY7oilZXw1r4y3cyj8ni2iAJDoPc6Dk5/GbZHapu
         K7YOFd4NtcL8g==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5128dcbdfc1so919987a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151283; x=1688743283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1ad9bQ1aGlayjQkBmzknmBzpwDvRLF1iaTT0A2Zyj8=;
        b=YIMbKw+ME7gDe7b1SIXllOPvwcBATHaCcUAgybEqSKI7l29SgvjlrJd5yN7Vv0K696
         d49QBgozASpaCbET8C0tRzp2qocx7Tbk9v0Xdzv/XTQjrTsn3gsa/eJJg1xa0CUFG9Tq
         41HgwU7NMei92pq39nmzRmZ/aDo5ETSEjT/iyC+Rc63Ls6TfF82t+LlCpb5zGlFIhaOU
         B0Z591ZNn7Ii7JQb05IwvSzDE0J5mPPnizElQ8q+bmo7svy310DgCKfEHNPEWCFR4Yd3
         YEC8s3GdGnlu+Jmt6+TSFMzmLfopbpmY3Waw+iLlwnq4ZrN2fTEpmdTfRcIaOTV0y+TG
         h/Wg==
X-Gm-Message-State: AC+VfDzuxtGjdo1sxwfVhUsBKaAaahkyyZrXKXrQ64Adjxka7UDMbyCl
        muQhqb6/glYn6coM6Sp116REWdDeLM1s2a/zaD5r4+Tz1yNUyvkG3fh0acsp1E90uMKHEPRn3AA
        5fY/svuS1De9RmPWJo7KNaIcbLY5klGfcolKmTvZHbcg=
X-Received: by 2002:aa7:d450:0:b0:50d:dba8:c64a with SMTP id q16-20020aa7d450000000b0050ddba8c64amr4485734edr.18.1686151283817;
        Wed, 07 Jun 2023 08:21:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FsbB/VMu7FXOSfXOBHP9tswUg4dyT9SVSoTyTpn3BCc8/hYEvTcd57G89c35Nc13dQtyncg==
X-Received: by 2002:aa7:d450:0:b0:50d:dba8:c64a with SMTP id q16-20020aa7d450000000b0050ddba8c64amr4485727edr.18.1686151283632;
        Wed, 07 Jun 2023 08:21:23 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:23 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/14] ceph: allow idmapped symlink inode op
Date:   Wed,  7 Jun 2023 17:20:29 +0200
Message-Id: <20230607152038.469739-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_symlink() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8d3fedb3629b..3996572060da 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -956,6 +956,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_num_caps = 2;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+	req->r_mnt_idmap = idmap;
 	if (as_ctx.pagelist) {
 		req->r_pagelist = as_ctx.pagelist;
 		as_ctx.pagelist = NULL;
-- 
2.34.1

