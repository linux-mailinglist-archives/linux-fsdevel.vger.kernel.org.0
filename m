Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F570FA73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbjEXPhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbjEXPgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:36:12 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0721610E0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 08:35:11 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 26ADB423AA
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942453;
        bh=nR9/+ewIyyw/jy6drOGZEF0QPlfa9Zf5mm9/nFwa0HI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lLSZB1MLefikaTBugXnexNAbwJsg3wzvKCqyR0eF/6I9SfCTH2bvwl+ygZV4Hm5yr
         bsiQHIbOoKVZbNyOn/In4C8hn8SdqJjsauXQX/b84H4nc99TmHwXzi4I1o0c3NTrRS
         HAw0wNH04XnVeA2ngKLCczOLhoEPKgpVkexlD7H4X5ONAbqspIegejn4K3B38MCtfV
         Ft7/moXeSsB6qyXWBwXahJrwlC4a2FRgEXIsjdLxoSUsZvvzYnFhE/usO7ij14l3xZ
         xSESqEW8LD36xA/z38ECMjWoQ6UTPSRnsuQzi7jj+cHP1fXFyuBlSpoKfjIUYlp0c8
         tDBK1sg6uPuZg==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-96fd3757bd1so132743266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 08:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942453; x=1687534453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR9/+ewIyyw/jy6drOGZEF0QPlfa9Zf5mm9/nFwa0HI=;
        b=euU8s/ze819i3XUMhAt4MaluvMJZtiYs/hyVzo2+7QS3KPBf5uVVwRlURnqs9bPjQQ
         IdhKG2Kag10NnTwnl4J6PaWOkPYmDSAFRcx3rNnkv6gg1nmf75/9NwLkIgbpnTwZmRry
         ipwg/SkIcbh/wZVp6J2aOhL57skavw6x+5qHPX9MqJhVIloH7e4qObWrSFgCGB5DMHe4
         K2SGvqCKlTwqwXPATd0N3vCjAZ8KpwLdZHdqMP/qjLGb2tQebKPgbLRBi8d/b8PhuT8x
         KE8BRO1V4K9SvSWJ6TVioVWzbIytwIq6r1+z2PcNNQeIo1EDzrTtjCM1xfTu1EcUb8KM
         Z+Wg==
X-Gm-Message-State: AC+VfDyic8H/yoU0CiZ0dBWpjaEzy6Oeb/mT3dnlELmsTFDymqpHM4pQ
        K8a2+TizwMwWs12W9+Yk7oY7bv+GllqhHu3BwkB3BOiKoRJfs84E+0FpXs8zFxOPgoyMzVD+QM9
        xzM5PGDDkJmuZ1Fi07YWqNkTfZpMwSpueuIpuvKvToKM=
X-Received: by 2002:a17:907:928c:b0:94a:7da2:d339 with SMTP id bw12-20020a170907928c00b0094a7da2d339mr19734521ejc.26.1684942452945;
        Wed, 24 May 2023 08:34:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VrLveeCMu2ys0lUPF7qZva7g6gOB0NcoxUq6lKjQX0cOjszplX5lU3+A9k/0AIpZbnoUuKA==
X-Received: by 2002:a17:907:928c:b0:94a:7da2:d339 with SMTP id bw12-20020a170907928c00b0094a7da2d339mr19734509ejc.26.1684942452777;
        Wed, 24 May 2023 08:34:12 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:34:12 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] ceph: allow idmapped permission inode op
Date:   Wed, 24 May 2023 17:33:11 +0200
Message-Id: <20230524153316.476973-10-aleksandr.mikhalitsyn@canonical.com>
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

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_permission() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 2e988612ed6c..37e1cbfc7c89 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2408,7 +2408,7 @@ int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 	return err;
 }
 
-- 
2.34.1

