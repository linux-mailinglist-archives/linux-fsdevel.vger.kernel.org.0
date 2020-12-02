Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1F2CBD7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 13:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbgLBMx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 07:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388780AbgLBMxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:53:25 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24624C0613CF;
        Wed,  2 Dec 2020 04:52:45 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w187so1189173pfd.5;
        Wed, 02 Dec 2020 04:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6oyGlRAiLZTFqH07C7Gme2MIKkmp+8Uf0D4I/ntEuUI=;
        b=h6UcLnYrFrrRltzmp1KRvQGmW4KOoqQ4MGbYFqokAfV2FrguqMQnPXnCFReyI5ZAdh
         Apx+qmlUrIl8VlSu+xCsByf98w+wcAyhJFoCdRJOHUk3t1+lZgkKzJ5EO9+h8DDuVzn8
         ENVnAPdQirD8JIJPMTfGYz68VDEXaxiv5DNQNvBxNkswf6klPoJR6cRlIR/Mn1cfVypp
         EUAG9QnFydJWnVjMuvjNFRMyJCfddSM6t3ygDbRWuydCFHV4h+JeV9NdBjljpQPPw0eG
         ulYeGat08CyXL5aHlSDSJwVVAaXya2EVyhAtbyirz/cxwwQzOl2TEeoYWaQHNWdyX1gW
         E3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6oyGlRAiLZTFqH07C7Gme2MIKkmp+8Uf0D4I/ntEuUI=;
        b=VWnlydVyq5B2KSH1IHG6bM7q7efwTrQ1XmhkR0tSBrL53DWgSivNwBntBucUaE1a3K
         JM9S2hud2UMu1nwY1o2sKb5byyvAWeiA+/uKsGD4Uw84oHzPPvHbjdXj4DffOS8H+UFo
         KCBqAN7GFzsKT/CHT4SP4XwMPwpQCaiGmDAA3Rr4jm6Ok3sZfsoqAnfV370za6dvcnbo
         Oum9iHQSyz5wBVFWHAHv9ZjOv6vKs3P37B5aVDkIrJG6WggzW9AJkS+h6YvY3T9LfnAM
         uoispc5TmZBFxf5j47i7lZxy3V3mWBlXsOnJHCo9Xm7+ovaqw+YFuDvogXylCCaZXSy6
         sNQA==
X-Gm-Message-State: AOAM532WfwIl2iY4vxusM3mlz4yS/ck5k/d7xHWTTeJhmgkXf8Ksw8E1
        Gza/TUaPASBkkIdc3bn/4HcEYu158n30ZQ==
X-Google-Smtp-Source: ABdhPJzJi+gXNUd2AVpF3L6pDjLE0H3yB6BrBc+1rqJgUVjQK0tRNdxxq4dlEdsuI9QO3UkP40ymCA==
X-Received: by 2002:a63:1959:: with SMTP id 25mr2504933pgz.201.1606913564566;
        Wed, 02 Dec 2020 04:52:44 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id w2sm1840256pjb.22.2020.12.02.04.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:52:44 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] vfs: remove comment for deleted argument 'cred'
Date:   Wed,  2 Dec 2020 21:52:32 +0900
Message-Id: <20201202125232.19278-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Removed credential argument comment with no functional changes.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 fs/open.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..85a532af0946 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -923,7 +923,6 @@ EXPORT_SYMBOL(file_path);
  * vfs_open - open the file at the given path
  * @path: path to open
  * @file: newly allocated file with f_flag initialized
- * @cred: credentials to use
  */
 int vfs_open(const struct path *path, struct file *file)
 {
-- 
2.17.1

