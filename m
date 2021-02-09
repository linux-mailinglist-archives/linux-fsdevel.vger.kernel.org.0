Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E91314692
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 03:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBICnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 21:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBICnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:43:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1206C061788
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 18:42:32 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cl8so735822pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 18:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tA3NkU7/ZdOeyh4OgJY88cyaW+ePcQQoqdXxwUHc2g0=;
        b=i9PJSBwzTbDZuxA3G0oFraxAmIc9Q+OcH/i6djntpmLkrbYz3Mn9W5HaRFXt/4dtMf
         nZUeJH2F7jrAOxBq+LfjexEH9E7rQ1drsuPKlBaHY6tT2rTCTPExvHQh4joi7SBi9eJT
         RbC46xObuPO4+p/ZLsLWFLhoecrWyWoUkSXV2e+zG1e4ttL1XPIjjY0f42yvCpnK3pD5
         Q4v9l3IfdyZpuxnUwMCWqc/zS58+JqEvPh3WrcEH3MEEUzcrCI2FIX3yliUAWdbQsB7k
         P7w9IzYEpHP/KPHXgZVGLYAsSIe/69YGd55ELeTJOgQhnv1v+c+LJerN75YWVR3jXtBG
         Akdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tA3NkU7/ZdOeyh4OgJY88cyaW+ePcQQoqdXxwUHc2g0=;
        b=rqV4MwkI66NlZlxxYbzpFq/+0/VN5bFpIxJTVR5ScqzaqajN82IVVrnnYv0mOQ2bCq
         pO54IDY9KGqlYzQY9HGL1oK2+PWWaODQm1us7bgEmzpjkmdllu5Ea/iB8NAqNCUvpA0e
         FL3mMQtKrf1cFBSpky9gZfqKTVKSQMHDVNPpqO3a/OVlba/Fg+gZupP9x5w6e7+wCra2
         50giWZYAyeEDdR//VyiQWLI7vzQMGRNyZ9/TAbTCUfFFtKxFhPhN/pKriOHzfhNZeCwW
         Ajmt58EuteFmV/kMfCudI+9X8QS8dHRtR+cCX3+3k4MnZ4Ur6FeelMCJtQFRBNr+29c6
         4G4A==
X-Gm-Message-State: AOAM530QsEWPlplQ1goBU8ycp/4ILD5c4/uz8HDR8JZi0xPwYy5mzZhb
        WOFdzFQXH0WGVOm/1FvZ6UmNlQ==
X-Google-Smtp-Source: ABdhPJxtPXnBWIRRunn95nq37MIc/77qYGEHxQk2gdMt3spElLIQtBpYtk8yKNRD8RhX2T6sm9QBEA==
X-Received: by 2002:a17:90b:1c0d:: with SMTP id oc13mr1853885pjb.156.1612838552301;
        Mon, 08 Feb 2021 18:42:32 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id m4sm19428755pgu.4.2021.02.08.18.42.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 18:42:31 -0800 (PST)
From:   zangchunxin@bytedance.com
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chunxin Zang <zangchunxin@bytedance.com>
Subject: [PATCH] fs/io_uring.c: fix typo in comment
Date:   Tue,  9 Feb 2021 10:42:24 +0800
Message-Id: <20210209024224.84122-1-zangchunxin@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chunxin Zang <zangchunxin@bytedance.com>

Change "sane" to "same" in a comment in io_uring.c

Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1f68105a41ed..da86440130f9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -9519,7 +9519,7 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	struct io_rings *rings;
 	size_t size, sq_array_offset;
 
-	/* make sure these are sane, as we already accounted them */
+	/* make sure these are same, as we already accounted them */
 	ctx->sq_entries = p->sq_entries;
 	ctx->cq_entries = p->cq_entries;
 
-- 
2.11.0

