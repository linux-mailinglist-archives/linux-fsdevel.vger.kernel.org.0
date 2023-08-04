Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE9A76FC74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 10:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjHDIt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 04:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHDItd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:49:33 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EFC49F0
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:32 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3CD62417BB
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138970;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZdFh0yafbC1h4o4Creja86XLjlgPqIw/8g5zh1Q0AtHR/4uzszzMuJlGO4lyCf9Be
         jAhiXOyM/aRWrGH4Wx4sz4dt2tv3ArPqt+n7+IBT9Hlu568dxViaJFyj8kVDclsdTP
         q0ymyzearB/6eY2LF7LBhFC8uf73UVi/L1+2REXLtLOpA/0lQfWcq9G9Av3NZp2vWg
         dujJ8ovwsNtYcbi0pXOtwLKH6Oq7XBVqHG0ywFvD8CnFTeOkPIgct944T2/cIXmZte
         Bo6TqW76euy/qTRxSWNM/Ha6fy6zBQQ/PjI+q/RKaMOaN3FS6JIoZ9TJv6HEpyXo48
         Z8SWEK4uH/9mA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bcf6ae8e1so122978666b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138969; x=1691743769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        b=WlEYznstUTvlQ8EwGVMfqFFakX1ytPu/gncn1Tnk1b9aHSHxiz5ypBHiFmUPOJwaWz
         3zWXDSMAaCjaK/cuBv2qNu6k+WcwsCoYuGOtkW5qSdveyDTv7JubPZNVPrDbVTfgua0K
         OXXvoLBEUZd7Rmsnuhrs6lHJmj6RXbN1bk5R1BesaGHSSAKUDe2vc9x7c0bBzOf0722v
         /y3ODl7Tc0cV9cQPA2NCU1Eb38KVsUjOOBs8uDtOhJTg8lD+ddXZmlciMdPO9/qEHnjc
         bqkqq4acKGck4JsyzlcWS99eA3cNloPp+wEYD/wlKqbLz61V4xmPfNtYtJXwWiV5psnj
         VpOA==
X-Gm-Message-State: AOJu0Yy0m5pIh1UPGsYHgwBU9Frqvii6nhkPGzDD3r5bmNFo4Bz/NaMO
        1+Ts96130GECEE2ElxnZTUPTIeSyWK6+Claq5giRI7EjImV1EMenZUlYYVhXi46eQDPRzbq3lz3
        psEIg24pWN5SUjiRr3/P/DTLdagpWV1WTvUXffYH6y7g=
X-Received: by 2002:a17:907:75c9:b0:98e:26ae:9b07 with SMTP id jl9-20020a17090775c900b0098e26ae9b07mr856008ejc.35.1691138969807;
        Fri, 04 Aug 2023 01:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzJvUEdQ1szBS20TzLv4pF+D/kH4bm1Trv3iQThRWbQMHWUfpqSKG2LY+85emIKvwXfeMoXA==
X-Received: by 2002:a17:907:75c9:b0:98e:26ae:9b07 with SMTP id jl9-20020a17090775c900b0098e26ae9b07mr856001ejc.35.1691138969650;
        Fri, 04 Aug 2023 01:49:29 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:29 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 01/12] fs: export mnt_idmap_get/mnt_idmap_put
Date:   Fri,  4 Aug 2023 10:48:47 +0200
Message-Id: <20230804084858.126104-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

