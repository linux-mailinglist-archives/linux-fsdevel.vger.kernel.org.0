Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B26726444
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbjFGPXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241077AbjFGPWm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:22:42 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27AA2724
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:54 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 96BF13F160
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151311;
        bh=sitF6aKufbc7DklTCjus/+uMnJoHcKEt7G8gHEJda3g=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gXxaEYo9XDdXvT0eOneywVFsSzrWPGAD1iO6HtSMLBInRX8i0rldTOPC9DMygDJFE
         j1R2b+s4EO48DB8gcXDKo7fm1DeZCiY/MCtnrnIMqGOpEbuCx9uOFO/AgscFZm6yw7
         GOa/Glu4kzrdgqWjgH3Ul8Mz3EjFfENi38Eq3GAXvO6+AnVbSDEIcWw6qqunYxG5yc
         609SXo5AvfPCV2Uk4wB+yE4ExFZp+D16IJcMIO+rHXVPuThyuid1VdSviD8wIBhhiQ
         Hh1gcCGJkQUNWLDhfqOiAFyCjOei9FXsz673kEZGVxURKFp0od1F785NvKCKqL9k6m
         Gtu7LWRHx1b8A==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-50daa85e940so1121290a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151308; x=1688743308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sitF6aKufbc7DklTCjus/+uMnJoHcKEt7G8gHEJda3g=;
        b=kWBvisKZRI6P7YHap+FelRaDdnGP982bpAf3NTKkHpSgQQTFHJh7fCNKINbqNLPhWL
         TG8Nl/eYT/8ZYNmRKiqeYZicZJwA0Lhg1bX2LN2gVskXjeRD/ETiTkbXqjuPvkUnSAij
         rDy2onBl+H0LH1Zg7rIZL/41lV7/rMKu92/3d53CnAU03quypiCPBMq5j08CQ0Pe4rO2
         DlgLCQQFtqqTA64UoCrzywRNpjaFoJEQJXXNV8DGR7NAVtHDDFPMziNwoufDFxzKk6aM
         maG+8TWb0+eREQyr+MsdySvZ5UE5fk7pxcQS9MvH5kSzIPsOYNplpom3moI9pExrVFPe
         19Bg==
X-Gm-Message-State: AC+VfDwGo4U9cVHUZxLllnZ6AL810Yu6im39HmkHl1R3Rp1EfId+z4LN
        RG7v7zWKsJDhA3oF6QJedYVSnPXTGnABRTOW+RB6+q2jEfCJkmF0Opz35m2TUDaHge6vaptuneg
        zoXgGKg4/d0r7E2VfgMVNXmFJMdabUUf4sizN1v2t620=
X-Received: by 2002:a05:6402:31e5:b0:514:9422:37dc with SMTP id dy5-20020a05640231e500b00514942237dcmr4479647edb.6.1686151308084;
        Wed, 07 Jun 2023 08:21:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RVi6/fukZeNZcvZRzUwSUGXDPAwHYX90ZNHPzdh9z1jOlvF2lCQ3DOS9NFUQhNAtgVCXjxQ==
X-Received: by 2002:a05:6402:31e5:b0:514:9422:37dc with SMTP id dy5-20020a05640231e500b00514942237dcmr4479639edb.6.1686151307933;
        Wed, 07 Jun 2023 08:21:47 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:47 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/14] ceph: allow idmapped mounts
Date:   Wed,  7 Jun 2023 17:20:38 +0200
Message-Id: <20230607152038.469739-15-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
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

From: Christian Brauner <christian.brauner@ubuntu.com>

Now that we converted cephfs internally to account for idmapped mounts
allow the creation of idmapped mounts on by setting the FS_ALLOW_IDMAP
flag.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 3fc48b43cab0..4f6e6d57f3f1 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1389,7 +1389,7 @@ static struct file_system_type ceph_fs_type = {
 	.name		= "ceph",
 	.init_fs_context = ceph_init_fs_context,
 	.kill_sb	= ceph_kill_sb,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("ceph");
 
-- 
2.34.1

