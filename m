Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08AC729584
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbjFIJi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 05:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbjFIJhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:37:42 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E1D7AB3
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 02:32:50 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A5BA33F363
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303119;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=bDs0oUKY7vUzjUomCHbVjx3YR+ivI5FZooz/1y3g/Jsg2y0lHGRi/pJCaAyt3kJyb
         eFW6A3UBmCIMG6MHZIryRDrIpnkODkhoxliwA0NMUpuJD9HTmyXtxG5tHWC+LH7VMi
         gwdkDS1ui28+A4GMZ/louD90qi8IbRCoCZSxI+mCX0chhPXx90M5oxPRCWQfA5WLUi
         H3tPvXkvwM1oTpMvUfnT6W6QuiOtldfQ9En1MyRLEchivDW0Gaj7s7peSM0B4TXmt2
         L2KLY5S8C6SLoUgwbPlr/J5EfU1zGE9x48tWh+T8YuYC8V/5FQG8hoMoZEfU+QrseI
         +99te75F6OXSQ==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-977c8170b52so183992066b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 02:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303119; x=1688895119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        b=LgJUqBsrnQw1i1nHCEb8FeCqyBPpBHTCQ6rrC+jogBBdOM2GOnZ+MyQf2vMVQSITSN
         saLH5LrBXQ1KYGauQMFJLwW875sahEYo81zH6Lp+MEt/Z/K2w+uqO6o+n/Z1KnduqYdt
         1l0momO1P0HDvh/40t7IAGcTpTUdOahm7oEJajmkwNYBgzp41eBybcDAAYsTGwfvpNXM
         JE5IINLQlhtcQIpZz45iMdMuHqbvXCE50cCyreF62etDwuQrnVn5HVSvCpHBrOweuzur
         DWWup7o56L56FwP2Siwh7/YZKJ0Bbj3WRaZOu8Kj0qjutahZ/8YUHxjV9/QkZChNQRvT
         zhKw==
X-Gm-Message-State: AC+VfDz1IDpo+w5tSL6S6Y3Xk8yO1VLUXb3k9jnyL1HHRhob/S0eS2oJ
        SQMMiZJFUM/xI4x1KnZDnUiiTrlieDEvV1GqLaknEZ3hjWhPit2GsNRBGKFOgqBLylKgbMmyiDF
        HN0E+4VECvTPtxYlywIJlrpc47+UMEE/n43EW9KBxATI=
X-Received: by 2002:a17:907:70a:b0:96f:a935:8997 with SMTP id xb10-20020a170907070a00b0096fa9358997mr1328425ejb.12.1686303119326;
        Fri, 09 Jun 2023 02:31:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KTDPE0tV+H7gY9GZ34++hd2WgdCfXpbS52PAeja+APzcvyP7PE8xa61fw03DjcBadMICTyA==
X-Received: by 2002:a17:907:70a:b0:96f:a935:8997 with SMTP id xb10-20020a170907070a00b0096fa9358997mr1328411ejb.12.1686303119167;
        Fri, 09 Jun 2023 02:31:59 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:31:58 -0700 (PDT)
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
Subject: [PATCH v6 01/15] fs: export mnt_idmap_get/mnt_idmap_put
Date:   Fri,  9 Jun 2023 11:31:11 +0200
Message-Id: <20230609093125.252186-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
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

