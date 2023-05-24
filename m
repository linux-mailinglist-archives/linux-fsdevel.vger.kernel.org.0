Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7E170FA59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbjEXPfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjEXPfH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:35:07 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B64AE76
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 08:34:45 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 623AC41D59
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942449;
        bh=VOsvDeo72Li4A+MGz8y/FXCiDvmbWTjb5uUMq09Z+GE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=eUyv6wj9YRbGlm0XZARdd+9s/DZ8n4uXxS3i7uscHKQ8O/ezRtabSmAQbmezCBAmY
         aHw/WF1O1dbvInYms1WbDJaGGL1stawT9bM0nBUj3YB9qSbiQUUM1kn4kAZRAwP+Pj
         +XyJbE2sK2xHFWGIjpby8/RtmUH0iQwMxVoejM5hRiryeZoNqnJpsMZjk1OZITAkeK
         eZgDHEe6SM3ay5Q9zxQIpko2Yckj8QHd6Fomlzz6+mT21LYu0yGnvu63aWBV/HuPzq
         eD20XTgrLsMPCeu2kQm8ZSC8aeoqS2SgCHbdU5DgY9BJ76cC7DvGBP+iiaXCQ3Ba/q
         obQO2TYEHjkpA==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5126da599dcso1385487a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 08:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942444; x=1687534444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOsvDeo72Li4A+MGz8y/FXCiDvmbWTjb5uUMq09Z+GE=;
        b=kc2Qup/GH72AW5af9kZ+QTid45l1F/T11ek0eTE7d2kvg8m0WKQel+VUqV2KMj5Cqv
         SO2FmPRl8s8LnQZCGD3ZF1KbGHA8htjpKMSrPRFtP6CLQyl6JlDb3+bEELpB8NpOKDWB
         Y99srWBAVmQVVLUC8SUPoHxo17Vmw5dv+dBhOalWZCT1oALms1zpOhPdy3IFaT50oYPJ
         EWQhTYkm/n7SgodqW0qSrKYILoTtAA3B0ACd/oeuYBGJtDTbIE589Ah9iu+PixnYY+TH
         UyTrXx96t5V7XrHIHhZsSu7OsYjX4nFpsj6ZlVLW00hjv6Ye2QnS4QfFEHy1Coarc3zG
         l6YQ==
X-Gm-Message-State: AC+VfDxhyW2erOgQbAOiNMLE3RryWQ3wpzXoQ/4zEpFiEn+HjgxMwEMy
        Rml/Q801ytc7hB2akoxM3vaUOFpQrj9RTbyWQoz9GIVNy4kaIbazEG8pe8siZMKZMCZkfTUhOdh
        Ai/AGXg5na+6ibm7vH8hDl6bSwVhAy30xREISbdMCUzU=
X-Received: by 2002:a17:906:5044:b0:96a:63d4:24c5 with SMTP id e4-20020a170906504400b0096a63d424c5mr16834954ejk.77.1684942444423;
        Wed, 24 May 2023 08:34:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7gBpqHitu+lLhIckipr6Iw+ZMNPeoZej+/zA1KHtSCkxGa9OwcqI2J/tv0ifrYtmEPsQMuyg==
X-Received: by 2002:a17:906:5044:b0:96a:63d4:24c5 with SMTP id e4-20020a170906504400b0096a63d424c5mr16834933ejk.77.1684942444258;
        Wed, 24 May 2023 08:34:04 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:34:03 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] ceph: allow idmapped symlink inode op
Date:   Wed, 24 May 2023 17:33:07 +0200
Message-Id: <20230524153316.476973-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_symlink() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

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

