Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1080E349E8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 02:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhCZBTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 21:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhCZBS6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:18:58 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DDAC06174A;
        Thu, 25 Mar 2021 18:18:58 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c4so3819336qkg.3;
        Thu, 25 Mar 2021 18:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9ym8r0Gg5NCFPpoqkZ9sBjTJOIm7e+1+WbcErWiDRQ=;
        b=KFTZQLPUnd/LXVPPtQvDn5lrbcdZwKflolz/gQzBDhnZqVbavaqVaHCF3vorzdUZgJ
         OOPEwZzGFNH74YqT9Qt0ZlIc0iI438BNoL5HzG/tf3sW1OqyeGlYaDY7sA9656h1ANk+
         hOPeyAE6QpEeXp5LIQZu+35elcwF91dqtOTNrhtwIhkSf3y8hTpHZqq7T6oZ4+fYAC1n
         q+6t1k9xUQ3O7WxQHoONgt7/L+xTVnoqAyLbqGJZXCUmcRpDAoeGXlDiD0bbIZHzrAsN
         e57RslgjdUu6LWWUAwD/Q9uu6kQACvekkBb56ERCskrjYANkoWCfJgSVKPEPi+I638tO
         ckEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9ym8r0Gg5NCFPpoqkZ9sBjTJOIm7e+1+WbcErWiDRQ=;
        b=iEhIB3GsYOvMZkzreLyb6rq4BAoPzQf8lK+7Oarc+jn/8W6eANc1F0ZAQJt0KhH0Rz
         W/qKNrD+AoDmE9sFLdOUIdErIrThS+MMGrSPwm+goEzY7FdX/D9jHbOplBknNkYd/GX5
         GfuxLlDikXVXbGIwTGBteAAGQ2D8baDMixCZw4sVCCxqmnHYgpAmT9llyylbVtsovue/
         4VtGWDRySLD7Q8Io1yv4VaetMCZGu2tpDXPB618eBQVWXCMoNfBRqPeHlsb4IsyitRMl
         ID0OGMddRHKL8kn8gHEA0gFpt1b2iPPqQiGC1pLUwlgR9EEyIabT61SqBNEcxlnRcF9M
         g3aA==
X-Gm-Message-State: AOAM533O8QijjbwEbPmsPW7E2/6d6Yb+o6Hh5piLH2F6OpVY1iLSLJ5O
        zBwSOt0LYwUe6vBfmOAp5Z8=
X-Google-Smtp-Source: ABdhPJxGlTn+aVm0Uo9sLBgLIjvEDlMdh1Zdme1sfuHApG+cbbDf7YgFGNd6ff7hkrjYFPaDUk2UqA==
X-Received: by 2002:ae9:e113:: with SMTP id g19mr10578866qkm.480.1616721537268;
        Thu, 25 Mar 2021 18:18:57 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id f8sm4760688qth.6.2021.03.25.18.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:18:56 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] fuse: Fix a typo
Date:   Fri, 26 Mar 2021 06:46:42 +0530
Message-Id: <20210326011642.22681-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


s/reponsible/responsible/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/fuse/fuse_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 63d97a15ffde..0871ed6328a8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -713,7 +713,7 @@ struct fuse_conn {
 	/** Use enhanced/automatic page cache invalidation. */
 	unsigned auto_inval_data:1;

-	/** Filesystem is fully reponsible for page cache invalidation. */
+	/** Filesystem is fully responsible for page cache invalidation. */
 	unsigned explicit_inval_data:1;

 	/** Does the filesystem support readdirplus? */
--
2.26.2

