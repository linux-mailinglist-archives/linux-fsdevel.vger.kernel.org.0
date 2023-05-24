Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C306770FA43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjEXPe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbjEXPej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:34:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A9E4C
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 08:34:20 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9CDC53F195
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942433;
        bh=tSdP/T4XpDdXngtRP7H8sm4qPchKBIP/6AL5g4/r8eE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YybhPqr1t+uFMEwWnQHkE2Y0XP0zHprPUUttrIMDqGLEJe5FrnKrvQZZKA/XlBqoJ
         wM2f0lDc2U8gdxXVwqMkCQBkxDgoVpH+B4tifpHkLXb0FkqgenPxpiPNZYbHbkdbYv
         +hSpp9CMoY1mts96gwhCzWlax81ERcuFAUXL0WXQ2OBUvx08feYmflbq3ojrj6dDZj
         FesDPKnbfpD2hsKXQELFQpQoW2viB+RnCwTz53MiNPCsOvUmWBCslRVl7lVXy9p1le
         xfH9DfGsBRR0V1yGy91vhFldykfSV2dQkLJc9iGpTsYHvuG0XQsMZIzq8Rzk3sTrOL
         VL4vXhatFimVA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-96fe603151eso121917266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 08:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942431; x=1687534431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSdP/T4XpDdXngtRP7H8sm4qPchKBIP/6AL5g4/r8eE=;
        b=FG+zYjFnAEeNcrs+U7w7J/RXCzAGD19k/oyR4i40Clwbe0u/3IEDdFjo7fiotyAHXP
         T2sSqSJtiuLNDbLNCrBnFh8Dim8RQLzCzfSnBIZuQW2Irxe4fRz89r+X0qsxg9Z2Muz/
         B3DwuX9ykCTHCo11hdKXgdSj1KQo2kvplSzGf7jyJCE9YwILzMo+wQnfh+ewhsKBKnCx
         6UusFB+fx43M/Zhaxbd1GjlLDle0l1NZB5W20FifmwFkyAmbbsiKnqngjapVYlJozlwi
         leEpraUpUmjTICp7GoeHrbbKpKnC/aYvnoRo9+a81+MDl8TFfgn0nfIz1VxIl02YXD6P
         R1ow==
X-Gm-Message-State: AC+VfDwA2XE8XKfKLMFtY/ewyGGD7nY6XZtT+OT5Ls+GuHOl3qKV5SSY
        ixqfRY1B237TMZ/Y+WnR5dIhDE/wTcfCjRHR+ah1wKaoyD4KLA8eEKBf4w9N4HYshKvp8/ashs3
        OZAkSdDG1r9t9FAOzaWzVGWjLicGim/YAvw8lkFEyMXc=
X-Received: by 2002:a17:907:1606:b0:96f:d154:54f7 with SMTP id hb6-20020a170907160600b0096fd15454f7mr12266659ejc.42.1684942431692;
        Wed, 24 May 2023 08:33:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5owA1z5kBY01k6fQMnJ+aOqpvSenWRt3xIxcA2Af18CPctBSVmxRFbXwpWIr+T1mt2M3MY8w==
X-Received: by 2002:a17:907:1606:b0:96f:d154:54f7 with SMTP id hb6-20020a170907160600b0096fd15454f7mr12266633ejc.42.1684942431448;
        Wed, 24 May 2023 08:33:51 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:33:50 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/13] fs: export mnt_idmap_get/mnt_idmap_put
Date:   Wed, 24 May 2023 17:33:03 +0200
Message-Id: <20230524153316.476973-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These helpers are required to support idmapped mounts in the Cephfs.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/mnt_idmapping.c            | 2 ++
 include/linux/mnt_idmapping.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 4905665c47d0..5a579e809bcf 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -256,6 +256,7 @@ struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
 
 	return idmap;
 }
+EXPORT_SYMBOL(mnt_idmap_get);
 
 /**
  * mnt_idmap_put - put a reference to an idmapping
@@ -271,3 +272,4 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
 		kfree(idmap);
 	}
 }
+EXPORT_SYMBOL(mnt_idmap_put);
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 057c89867aa2..b8da2db4ecd2 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -115,6 +115,9 @@ static inline bool vfsgid_eq_kgid(vfsgid_t vfsgid, kgid_t kgid)
 
 int vfsgid_in_group_p(vfsgid_t vfsgid);
 
+struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
+void mnt_idmap_put(struct mnt_idmap *idmap);
+
 vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
 		     struct user_namespace *fs_userns, kuid_t kuid);
 
-- 
2.34.1

