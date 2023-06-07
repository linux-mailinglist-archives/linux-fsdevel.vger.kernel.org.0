Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46819726801
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 20:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjFGSKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 14:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjFGSKj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:10:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB0E46
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 11:10:37 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C1DDD3F15E
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686161434;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=V4RoLqLpvWvRyWgMExg463FdE3RI+uBASD38HHg6uwrA7ZOgY4+k2MKMtWkoFM7jN
         cSkLtK3ODl8CWpP4Mr3QXzoU5z+/nVym7KPavg71pBWIfj8lFwZPd5H6dz+tg1+2vU
         wTqB5M4H3VMeX6CVOicdGZytrlqmSffbXUmM0YpHJRNU7mzNxIDR+RMVezGdG6fIJg
         3k+7Jnppkxl/h1Du8fmHsDE050x4N2bn5THvM7IuL3Duk2dr/mzzNR9xxQSsSDJD/6
         1SBmjN2LRWrP1HSV8vn6dmoggqtEEJEuTLoBIjX1/8LXnOEK7yHRrqJPCMgnVW+ocl
         EeCz2ypbdKCTA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-977d4b0d9e3so333719466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 11:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161432; x=1688753432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        b=Ub0htR/+vWKAqnYxIJrP7z7q4Lc2ViZTvto9MieRPWL0TGJzf5kv2GJV6IUHPytPJa
         aIF6LH9sMCW3MlduyR6vhdaZfJqyiEQ22MxDdoZMlBtl6yMA/lts4Wk5KlztarDLgTXf
         ub1ynPXGOYVVeECjj96VP4Rag+qCoirsN3BNimjyXfCJuLqHZGn5UE6tnNIPTYAmnewH
         x7/H2VzN/JckHa5P+NyZyKsnZtKpyEhUEkS6PjhU9x79ge9r0aIOSkqJGkg/m3KwhCSW
         n23mCOQDXayjoNI+2HUrPTtyUAR+Yj1FBzTM3UfLLhp4LpruVzC6PMNkyW5BLqpfbc7d
         hIHw==
X-Gm-Message-State: AC+VfDyjYRkkfF5xyRTyx4d1HdMa2w9rP0R9xYt7r7dpS9/RZIxhvl5A
        PTWIFoGcsC0DPUUIQKm6qSRPBQMsyBDo3d7VK5C/oONwqlqOcwUCZ0MY5zGzxSUCCZAPLP6ys1A
        ZQZEWcpOgYDonSxsZxdObuHtmAL3xoswuLV8gj/eZLVs=
X-Received: by 2002:a17:907:7288:b0:978:780e:4520 with SMTP id dt8-20020a170907728800b00978780e4520mr4046875ejc.20.1686161432028;
        Wed, 07 Jun 2023 11:10:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZP9o3lv7ue/D0pMtDWVMAHHrN0ZyVe2Ne6ODfTagyU0HLTQrviPvgnMgxn+cGqcxvHciHTA==
X-Received: by 2002:a17:907:7288:b0:978:780e:4520 with SMTP id dt8-20020a170907728800b00978780e4520mr4046862ejc.20.1686161431822;
        Wed, 07 Jun 2023 11:10:31 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm7170494ejb.45.2023.06.07.11.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:10:31 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/14] fs: export mnt_idmap_get/mnt_idmap_put
Date:   Wed,  7 Jun 2023 20:09:44 +0200
Message-Id: <20230607180958.645115-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
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

These helpers are required to support idmapped mounts in the Cephfs.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v3:
	- EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL as Christoph Hellwig suggested
---
 fs/mnt_idmapping.c            | 2 ++
 include/linux/mnt_idmapping.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 4905665c47d0..57d1dedf3f8f 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -256,6 +256,7 @@ struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
 
 	return idmap;
 }
+EXPORT_SYMBOL_GPL(mnt_idmap_get);
 
 /**
  * mnt_idmap_put - put a reference to an idmapping
@@ -271,3 +272,4 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
 		kfree(idmap);
 	}
 }
+EXPORT_SYMBOL_GPL(mnt_idmap_put);
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

