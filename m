Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEAD726429
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbjFGPWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbjFGPVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:21:42 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B850A2109
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:28 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2B2963F168
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151287;
        bh=Kha5urw9d/Gxl+fDAhQsj/xIrm9C8WieP3+ZFJ0DVAQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Z4nM2l6roavrRp7LNgZr74sYn1qoEcWSi+PYUkI5Jgn2QQxytOKgHrlBgsYnDyjeE
         j9732iKDmdj47bobcfV2m8X4a6EXmbGbIdkGO466CsApLxvRPHXyq/QPtePCvBXIow
         0KzMTL0Pe1VjED/KJqT+75DAKSK7wjy37i3yrLkzsZKSIcMGahD4vqjbtasMXDN4nV
         bX0Us9H4+3m/4lnCtu0JFQmPlDNEzWkg6lLZqMtrOX2t8YkRpM+ogesOe16JGjIIPn
         k/v/NRAXS5epRxcRrN3CxM+uX90A+0fWmb7KKwGf2E3FKs4fqIaZomrSNYIna3mvlv
         C4En/QePT6G5g==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso557958566b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151287; x=1688743287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kha5urw9d/Gxl+fDAhQsj/xIrm9C8WieP3+ZFJ0DVAQ=;
        b=HiRpvjXuOiYqvvFuEoOU2DYGi5hz81laL6u/on1xem+owJF/fYl7D5aksoAs+0QEtm
         fHQy39m9/xJpylz7nEi3OCqHk5HDnuAlAN3pdLEOoHiGAED8435Q3g+xzQ7Fh/n315aw
         G1R6LdN00ZGG2ojUevJpZ2R/rIOPz5LG0cdTBce94jJnYSICNpICQxsYNOz8ldY47S6S
         eXaaIYR8kYVVVwwgKIvWXuwRM/W4cuHP7GFb5P5SxGW/sqfKinBmBL3J5JQ+rZ4UsCOz
         NMuphcKEp8i4Y3XoZHk9s/EvEdlIY37EyNhhRuUPmQ6uZByO5xqmmtA0hC/fdT0EEkr9
         rFGQ==
X-Gm-Message-State: AC+VfDzGWbL4C30Bu4Lf9ENyOcTfNVVfIqJDONQpDX65FG2TXbSqgqs7
        PsT4UOHeIXpS8KJyvJHr9L4BYhQSyE2XkhyXMBgNFyWuYkshDyrEWczoQxZj+LEzQawyIO5+qq/
        t89/eDeWyINoIpdRQOu4diPbfljBst+oKVzvLlbkrhXg=
X-Received: by 2002:a17:907:a42c:b0:977:c406:f8cf with SMTP id sg44-20020a170907a42c00b00977c406f8cfmr6913168ejc.73.1686151286898;
        Wed, 07 Jun 2023 08:21:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4opZd+c+tXbZyIBoUugLdIZSxNDRO0vi7mdyAqK7TwwXhagKxrhh6oqHquRATGTLAT44fPPg==
X-Received: by 2002:a17:907:a42c:b0:977:c406:f8cf with SMTP id sg44-20020a170907a42c00b00977c406f8cfmr6913155ejc.73.1686151286736;
        Wed, 07 Jun 2023 08:21:26 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:26 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/14] ceph: allow idmapped mkdir inode op
Date:   Wed,  7 Jun 2023 17:20:30 +0200
Message-Id: <20230607152038.469739-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_mkdir() to handle idmapped mounts. This is just a matter of
passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 3996572060da..a4b1ee5ce6b6 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1024,6 +1024,7 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
 	req->r_args.mkdir.mode = cpu_to_le32(mode);
+	req->r_mnt_idmap = idmap;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
 	if (as_ctx.pagelist) {
-- 
2.34.1

