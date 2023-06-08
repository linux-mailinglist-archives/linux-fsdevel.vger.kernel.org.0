Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F047283FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbjFHPop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 11:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbjFHPo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:44:27 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9504235A0
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 08:43:58 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D8A813F56F
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686239026;
        bh=/It8VSgZDTEKktJxHTMOOJHpvqL0RXNtakCJDr6cWYA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZhAFBfheINB8eE2BwI9zeoKJZLRNin5AAEkC7I74PxVXoNXw2gxoGhD3ddTXopxEv
         PbgOnXBh8osyvi109qX6yC4dhGv5hUEbBkta3fnlUNuuQLolI3chfK8THaFUOo2ywR
         Ryda4hye1cUOA1TLVeAZ8Ff9qdRAFAPgYd22p325I+xj9mtuPDuXK358YngLOpZBVR
         GkWLzNc7PYq+WVk96hCDE5w+RP2OV3NH09EY9u5zkL71SC1XMcufUjkBq/PXhemQVi
         zl2MGilLnXAQtVWFGacifoojo+3m7MS80zvlc8XES7sRuBNelluZKdZdkxd2XXJj8z
         57OxDV6KtDTCg==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5149385acd0so825218a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239024; x=1688831024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/It8VSgZDTEKktJxHTMOOJHpvqL0RXNtakCJDr6cWYA=;
        b=kK2p7Sjwytu64J3s80yNtgVukMhg9BWICwzsP23mxTMv/kAsdBPyaSWw7vKxZrariO
         FhiKbBIVt2AWifDWOKgzAuDRrguN3Oy23s+ePsnBjUxY+bUfRJnVVUMnKlV0JR6DpXTB
         4tEEEZpqW3dP+aZ2L6tuEqb5xlTIp8meMjFS2hbiYQHxi7VIKkq/hm28+mg6yzntsWDZ
         2wvAxSoNUDAl5Mr5KhLj7xRMNWxFtoPF73bFE83JyIHm+8rlk9iAOdCskWMyDmvAE7tS
         Rq7i+rCX7lOIiyLkZKlnQyL2b45bmp4WpUPTHLv5CHqzlAvr5xv1mM1C48Ul4TzNgPAR
         hzvQ==
X-Gm-Message-State: AC+VfDweNLJ8YnJR17ppsSvpjazeUVlvbNie2x7p9IgOh1zd0ZAV+3mU
        jxWEXGMCmiGW9RQnoQWtCLaz8j9kcwFgWYgPyjtDSqiqFZxvfIeX/w3k3G1jX7aAUu9zAkykLzn
        BLd6hxr6cZBpZfdC6FwkKK9N439uYYPo3C8etBItrZGM=
X-Received: by 2002:aa7:d88a:0:b0:50c:cde7:285b with SMTP id u10-20020aa7d88a000000b0050ccde7285bmr7205756edq.29.1686239024658;
        Thu, 08 Jun 2023 08:43:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5tT5xavWGRWqFP+Xk984KHDRSysXvYgAU9oqoxCsm4e3n0WS1ECv+yEbe0VUIEcNDMbW8raA==
X-Received: by 2002:aa7:d88a:0:b0:50c:cde7:285b with SMTP id u10-20020aa7d88a000000b0050ccde7285bmr7205750edq.29.1686239024530;
        Thu, 08 Jun 2023 08:43:44 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:43 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/14] ceph/acl: allow idmapped set_acl inode op
Date:   Thu,  8 Jun 2023 17:42:50 +0200
Message-Id: <20230608154256.562906-10-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

