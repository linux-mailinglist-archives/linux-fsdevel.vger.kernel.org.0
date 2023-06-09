Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238CD72965A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbjFIKKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 06:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbjFIKKQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:10:16 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED528689
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 02:59:14 -0700 (PDT)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C30563F56C
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 09:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303165;
        bh=/3eW+11n/4iCvn/s3430tPb8fe2pR8+LzRYCxQYjku8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=hsc/0qFxiAJd+6xMaE6G7qfBnVl+jGWuthrN9UowzskuZyMKiqGGQfIsp9g69q8DN
         P/doNxFdycjyKCY4jmzhRiqmnAkoYGlqMqkzriZP3mk7QpIZU7Mkkp4Jp64DFj51qC
         nH1zfho8IfT12OX77MupyANCEbFCATI30yP19wAGQmdXrINXdnQkHZrHxe5LpWOFQq
         X5wmSYoJmhySdEysylXtIV2fetyt+gWw9nEuCU9V0HjkOZOBux7pqsDfqxCZZUbDkN
         Up3tlEqvMLR+q0hDd77xsu+MsDIHNR9G8h168iUWNyNjjNUhOMVxLQKsmY7Do6zoUh
         2YREtS9VmF1TA==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b1c60977e3so12490411fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 02:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303164; x=1688895164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3eW+11n/4iCvn/s3430tPb8fe2pR8+LzRYCxQYjku8=;
        b=Ke5gaMyKneZlnR8QfqV4sjFBboKcwC8i05GJW5diF0z7jayHFJEvSvjhFxJd02Cmht
         sT97mnVbZs3GIBAPIk/IsAbcNnzZDulqwYKJHxKgSxHWIfTwNKjWQdmLKCdmfSwsZ6S4
         3UdB+oWh8s2Kh3o6iypjSDyHpmZdV+IkpywROYmsWnj8mAMaZhRo0tBYvHZfqU2tHCvx
         Ur4BTwRHpSNbgIqs3KTfnLzdaWrCtfyoL6oBUpNXg9uM4CY7rXrcZEKHJ1AjS2p9HcZo
         lQaCZXEyfof6YymNY9tZfiEQ/o9a3Ue08rXUx8RNBB6oUgIU7DG0taxK+4XZhRoiSCO7
         73nA==
X-Gm-Message-State: AC+VfDxoZDZe/yv10UCuB+2glOAb+ErheYrYj+ZPik8if5KQHNJcvXs4
        OTRkANYt8+vLBpzsQrHWu4uVQp/R5gV6jN2SEX53ndEujG+maCzIbI3ov3URYCO+ewahsgTcbcY
        PQcxPjeWbUP418Njc2677LVCYTCkt4Rhy7G6NgQRsdIo=
X-Received: by 2002:a2e:8659:0:b0:2b2:3a4:4ebe with SMTP id i25-20020a2e8659000000b002b203a44ebemr802391ljj.48.1686303164552;
        Fri, 09 Jun 2023 02:32:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Xp6K9xKO9YEjHS2qWVmuHEJbD+pzRh3X4TI7BNImhUPEhsy5RO+Z9y84aSm4a3Lt8GGRPiw==
X-Received: by 2002:a2e:8659:0:b0:2b2:3a4:4ebe with SMTP id i25-20020a2e8659000000b002b203a44ebemr802382ljj.48.1686303164306;
        Fri, 09 Jun 2023 02:32:44 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:32:43 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/15] ceph: allow idmapped getattr inode op
Date:   Fri,  9 Jun 2023 11:31:16 +0200
Message-Id: <20230609093125.252186-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_getattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fe8adb9d67a6..533349fe542f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2979,7 +2979,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 			return err;
 	}
 
-	generic_fillattr(&nop_mnt_idmap, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	stat->ino = ceph_present_inode(inode);
 
 	/*
-- 
2.34.1

