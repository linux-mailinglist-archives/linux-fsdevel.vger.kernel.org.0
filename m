Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3595976387D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjGZOIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjGZOIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:08:00 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3B42737
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:22 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7C5FC413C3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380441;
        bh=btgWKV3yveDSttvNeYwkzRRCd2/ECqsGtpVUjkBAwbI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=s/fAOXVu95yIJxY7ckyRZCn0IS2rBft7hIq/iNtznmy/Sp0/xeb313t0dDS7ZDbp1
         fLqaLVGB47sSpah90m5SoASUVw2w7IbOOebvsK9oWvOkyCUFsu2mDyqMlD8Kij75qZ
         9CLctDEvfcyFJOXCxz7naB7882wAhXUwcLfivVGaip/OdZN85np+7WEWY0ljZ/HTcv
         +OnrtuhWqxlhmIUe6CZUahSIH3J4exG9ZfYY9Cpx+uTagJLsBv2BEk94DsA43VGN7J
         DhLI26AkJgnlQrGxJtDWOga6LHO86aL9vpzC5cNd+pjksugX+xMNF6oc5s63yBw1OF
         9dGI87p0X7dEQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-997d069a914so450790766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380440; x=1690985240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btgWKV3yveDSttvNeYwkzRRCd2/ECqsGtpVUjkBAwbI=;
        b=NAuTSwx9QB7raKwPghgb2U/EYUXApHaS++B3ryeBSEhwzhb3a5GZ8IWVea+SR3EWhA
         fVF4+b9Ey23AzhFuxrt5GBG7QoTuth+nzijzBfLpNuze1TnXp0glegIGpHZVtXVpU4VW
         RHtz0JWTfgsuu9cy0XFuXecNY/dtw/lnXepAysvBjeUff3ToA92PKEgEMeibc56GIk7S
         ZZ2oHyvR1+O5yL5CBYnyGFYcFHSi0jhLc/fpf9ZVayi2hzp46YGu/vpbEssM24oXE1QM
         TQSLPH+PK+M28gvS87w/G0kS8xqrhwPEOKI7GX/v2KqUmbkbr7rJdb2jpQsYJYms1pUf
         F7Kw==
X-Gm-Message-State: ABy/qLZ9Yct0uBzVyajQfflaX5WZEXPgZtUwksyKdiRgamSl6OmMr3Ea
        rEyicexHHnC/lxf/7P7QH+9IZOt1Wv2yFScAYamv6GoP2/wBsZbgdoHxtwDrgBiPZ2X13RlNKky
        VLBYoUBCsb3ZdffsHPhApiPfuCzEsZNhVWHXPJpviXJiKSry0hWE=
X-Received: by 2002:a17:907:7605:b0:987:47b3:6e34 with SMTP id jx5-20020a170907760500b0098747b36e34mr1607088ejc.67.1690380440749;
        Wed, 26 Jul 2023 07:07:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlExCsRDrvUbE3SRwLx3SHaLn/8M347jNtc5jx6rBEJusYvPVCFOhtNa3qqPgO43KcCUyK5xwA==
X-Received: by 2002:a17:907:7605:b0:987:47b3:6e34 with SMTP id jx5-20020a170907760500b0098747b36e34mr1607080ejc.67.1690380440593;
        Wed, 26 Jul 2023 07:07:20 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm9572931ejd.164.2023.07.26.07.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:07:20 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 09/11] ceph/acl: allow idmapped set_acl inode op
Date:   Wed, 26 Jul 2023 16:06:47 +0200
Message-Id: <20230726140649.307158-10-aleksandr.mikhalitsyn@canonical.com>
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
index 89280c168acb..ffc6a1c02388 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -107,7 +107,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
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

