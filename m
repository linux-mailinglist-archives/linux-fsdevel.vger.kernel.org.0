Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2447381D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjFUKBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 06:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjFUKAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:00:36 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F78EA
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 03:00:32 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EFDFF3F17D
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687341630;
        bh=AWRzGH6ZSf0xboDPPn0o1FV8eJ+EiIwoZtGC1w36Sx4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=npdxzj7yRqxkcgl236nPTF0E8q7Wj56W7l750S7EFGgtWVkNK6nf2eBSG9z5kL6rX
         FNf3bf16mxBr1TOOoRvpo9qBOcoKx5c80tbGFejuAxD7dFGJCzO/ySpo5U+j4rR9/C
         F02uVZ7uwz+5WvoL4WKihdImwfzIUDhhmXe3Sv/OluZ55XGtL5gbgj8xsy3b1xfh7/
         uAxD+54DPyJgsyLpXtFFASEukGWGjaxsYnpKIN/xx09aSnxoS+0nG3YprPjSuEiKi/
         m04a9rioB8Wf5t00diBe3g0jHqhFA0ZqOItZIFqJdHSXaXsreu6omKyGuDtfKEsO1m
         kFXg8wXb7s22g==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3113da8b778so1338110f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 03:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341630; x=1689933630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWRzGH6ZSf0xboDPPn0o1FV8eJ+EiIwoZtGC1w36Sx4=;
        b=OLrgCQRZZ4LI/iCRAIsVppY7CLCOYk21fs5fX/jUPM2rdnBwEKBsHEq0KPCoUCyl7c
         +uxhTN6+2gIx5eQyh31kv+YWNFcjj0XdsBsLTGT2HUupzp64ynsUUVENI5NHx7w1XNkS
         URIPTpXsvp+vL6zre5DHotlQvuiPoaASQVKCntpsQcckQpvTy3A3IncSveH4XKdHE9rT
         GBVaPePCcblkeiqEXMSzhHLO/HBvQUL69NYMcWW5qnPTxFdQBeRcQyH2429MttImB7AU
         08A40pIbg9HBkqNUIXz3eCESVPWGPn/V+SbSnn2ZISZAgJd+s4OHAilXHHINbzqwtuoN
         zD1A==
X-Gm-Message-State: AC+VfDwIQ2P6NFtNy5XlBH7skWJ6K6Zxek6JQiWc+I5Vn4uI0rKgQPbd
        QLOqEARzdPs7ivwdfbJVWd94pBDR7Bg9Px9lsIISZmRwgv04lkeebVmOq6AepyIewVBcM0QMk0H
        YjZ/VsceUU+m5KwObNlgbUfJJf9GmLZ7dNCvKGAs3Za8=
X-Received: by 2002:a5d:6ad1:0:b0:311:18ce:152b with SMTP id u17-20020a5d6ad1000000b0031118ce152bmr9508844wrw.61.1687341630630;
        Wed, 21 Jun 2023 03:00:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oq+fIPGFA+sWLn7jvMuxe5Lvalcwkqv7UzsK6f+Iq0Y+CIzxjFvRPS+Xk+lXhEcKckC55vw==
X-Received: by 2002:a5d:6ad1:0:b0:311:18ce:152b with SMTP id u17-20020a5d6ad1000000b0031118ce152bmr9508830wrw.61.1687341630348;
        Wed, 21 Jun 2023 03:00:30 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d58ca000000b003111fd2e33dsm4024427wrf.30.2023.06.21.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:00:29 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: filesystems: idmappings: clarify from where idmappings are taken
Date:   Wed, 21 Jun 2023 11:59:05 +0200
Message-Id: <20230621095905.31346-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
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

Let's clarify from where we take idmapping of each type:
- caller
- filesystem
- mount

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 Documentation/filesystems/idmappings.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/filesystems/idmappings.rst b/Documentation/filesystems/idmappings.rst
index ad6d21640576..c20382f8bbb0 100644
--- a/Documentation/filesystems/idmappings.rst
+++ b/Documentation/filesystems/idmappings.rst
@@ -373,6 +373,12 @@ kernel maps the caller's userspace id down into a kernel id according to the
 caller's idmapping and then maps that kernel id up according to the
 filesystem's idmapping.
 
+From the implementation point it's worth mentioning how idmappings are represented.
+All idmappings are taken from the corresponding user namespace.
+    - caller's idmapping (usually taken from ``current_user_ns()``)
+    - filesystem's idmapping (``sb->s_user_ns``)
+    - mount's idmapping (``mnt_idmap(vfsmnt)``)
+
 Let's see some examples with caller/filesystem idmapping but without mount
 idmappings. This will exhibit some problems we can hit. After that we will
 revisit/reconsider these examples, this time using mount idmappings, to see how
-- 
2.34.1

