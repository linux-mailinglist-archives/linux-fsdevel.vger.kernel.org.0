Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FCF72643E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbjFGPWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbjFGPWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:22:22 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E283126BC
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:47 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6EA883F22F
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151304;
        bh=/It8VSgZDTEKktJxHTMOOJHpvqL0RXNtakCJDr6cWYA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=hCeDkvYGU6xRGsrOc4Ic18ox0BtMFY8zZe5WlDqxyG8GcVMxhi/WdLlGCyQYSFXuy
         cId2c7agbk7mt2yV5m+NNOwSInC92Q8WNq2ba+phoXgtslBYEJYqYupNrhpxlpRPFP
         NMdi0FXAc+bfwg/3ygoxRaOZuEMAWmNZerSYNU5XR8VDpw8eJ0W2FJEivtCj70zHoA
         5CfemDq4047lYEZhgsna1e/z3A+ZTN5WZ0E0aROmXw+b6qk+VlphcoyYlv9SARgGHO
         vFi04VDsSY8lPSHEN6IqKyfeqUgwZtm6jYpI18YHfOS6bAEqLyKT1nRO/urWWx/DjE
         794s8gBfbOJjw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-514a1501b0eso834566a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151303; x=1688743303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/It8VSgZDTEKktJxHTMOOJHpvqL0RXNtakCJDr6cWYA=;
        b=I+iWSSeeDqtGXy3fXKvgWxshiLk1E1MiTY7hJnX08MwQ+vK2Ug2tQdYQhwGKRJye8R
         u6b3L8HyN3QoC8c88hk1jm42gfcTMedzF2SWDHtV/UgnDzWUBHdnxTQCPXrQKPOcNYvJ
         m3kpp/IMW2fivF8CWvLmokMcWGsMWCVXddUI05LscCd+hbv25GDN1wDlQd+uqraWr1lB
         qNDEi+0LXQfUPp48ZzI9vDwGbH4A7BErpPefQLVitEQ9J/ohPVhxuFVbWhg2aguk3s+F
         FOUingTxZfW2F3ijWVQYuDVNQ8p1uuasfo4AomLt3HdMuBfMvVSSC6AX9Pqo0dTPAjcj
         XISg==
X-Gm-Message-State: AC+VfDz3Vbl2RHNYt3C5HXrgGZim6iQ3Jxz7FKGS6S5wwD0QEh00ciGO
        YOJFDRs/JEp6zMGW74Xg/yUFLAVyKjdE6O+l2GLs0E1HM/MoglI9suPU6mTB8eU4L37dF3VsKJX
        vUkDYffLezNZHoWqEOvtpNPASk++IlQp9yRRajrUcH84=
X-Received: by 2002:aa7:d6d1:0:b0:514:9b64:e16b with SMTP id x17-20020aa7d6d1000000b005149b64e16bmr4291081edr.35.1686151303273;
        Wed, 07 Jun 2023 08:21:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ549H6QwL6/dPEtGgtxmi5qPiQgs+YkY6irYHiRo8gsOZQw2QXXW6qBLDYK5KPmgsOY3/heBg==
X-Received: by 2002:aa7:d6d1:0:b0:514:9b64:e16b with SMTP id x17-20020aa7d6d1000000b005149b64e16bmr4291070edr.35.1686151303150;
        Wed, 07 Jun 2023 08:21:43 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:42 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/14] ceph/acl: allow idmapped set_acl inode op
Date:   Wed,  7 Jun 2023 17:20:36 +0200
Message-Id: <20230607152038.469739-13-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_set_acl() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 51ffef848429..d0ca5a0060d8 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -105,7 +105,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	case ACL_TYPE_ACCESS:
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
 		if (acl) {
-			ret = posix_acl_update_mode(&nop_mnt_idmap, inode,
+			ret = posix_acl_update_mode(idmap, inode,
 						    &new_mode, &acl);
 			if (ret)
 				goto out;
-- 
2.34.1

