Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1B1763875
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjGZOIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjGZOHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:38 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45BF2D64
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:06 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 47F86413C2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380425;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=SfqbKCoZBGx2wtCacLq9In3u95LPdD5N54Wb+HuezuzetTVRqfMMJj0tDHWSuNYKS
         GEV1uK6bxCVBo0WvDKTczaLmFIAziUJZq9uiuKRnGCekTPusOeW+4K59N0FEgeStkq
         4Ofz2mxkzfCD5BSsxFMhJbs6VYrGxVWyHa5TTJ+DUAndlgEeLn9RRiFl6+5bblH/53
         +7QF7FKGTZo9UupUuuG/9AGjJj57GJxDbMHfQLfYg9oq6vTV/B4Yk5slZJXxGgFBbl
         UPmy98sVvbXWu0SrUJ9Z8+TBHpYvuEfqHJBUf6iCAquZ6LGkvD+wT0mHCUNuDFB9ae
         c2Ai4UeBhqInQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bcfdaaa52so13448266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380424; x=1690985224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        b=b/FAmlk68Ic8Vh7iD44X2KIJ5gOz80Yt3InUDO5M9pkxT5S4SHf9M5MyBhmaTFU7e8
         Ck1Gy5ixzVBKQc96atk6nqNIs8y+xnoPXjqPdJWTib4cTeiXalXyMaPk21FE2teYmJSx
         j1VqvaYE6ckuIYMgr43RfCYt5ddKZNGDTjrKPv5vPtGxrtaXvr2jR+EEKRNZvcg8VeF0
         V0Egi1RJQA8yPI3TnXGTwi2yfqbDtEkEU7rPc6vjYRxJk5RzkkdKY0GE1K5UrY28Q9jW
         7lmWU4DcNvVewPtPi47jZhMPy0tgByQxCg38KwJeXCHXrynHKo2+SviWFcyJDbvbliS3
         ZZkQ==
X-Gm-Message-State: ABy/qLbemnzuhQtVs2QqMfT80X6LmbUvTvsjjaiQ2NWXbgrzXFhQP2ST
        DXUL9U0eDC3GGLCck9OoUm6l1kjU04fVCWG4uQ3EG3hHl0gAR7i5nudP8/kwkjCglyyq8lRdaRX
        pUJst2eqErRKVS9e23a38ZgJZeuT9gix0sXaq6mkYg+yvWufrDzI=
X-Received: by 2002:a17:906:51d3:b0:992:b020:ce4 with SMTP id v19-20020a17090651d300b00992b0200ce4mr1873458ejk.51.1690380424304;
        Wed, 26 Jul 2023 07:07:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEcZbZZ8IAVaxjty3/XyPES0bnaQmHePqNUvQ/jsj9yQpTL4uAh2EOFetDdFCwm/b+xOa38zA==
X-Received: by 2002:a17:906:51d3:b0:992:b020:ce4 with SMTP id v19-20020a17090651d300b00992b0200ce4mr1873437ejk.51.1690380424044;
        Wed, 26 Jul 2023 07:07:04 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm9572931ejd.164.2023.07.26.07.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:07:03 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 01/11] fs: export mnt_idmap_get/mnt_idmap_put
Date:   Wed, 26 Jul 2023 16:06:39 +0200
Message-Id: <20230726140649.307158-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726140649.307158-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726140649.307158-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

