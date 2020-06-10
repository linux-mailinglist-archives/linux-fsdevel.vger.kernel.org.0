Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A061F5846
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgFJPuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:50:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44741 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbgFJPta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:49:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id 64so1260190pfv.11;
        Wed, 10 Jun 2020 08:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrxGEOGFjsdVHn3Jd9UDXtWDflxIQ5FEpiOYf5podJs=;
        b=K4vctIrodxtU656nnPd0chQXWRRECjOiTHcokQ3nwzufmTJH48yozHbRvOCQ0mTLJJ
         EAW/wqlgQC6svpjRJXD/iBd+JtHpxEoDFIFddPTD7nu7czb218EYL30ZZwnDdlrvPZMZ
         nkN/6xXB6y25bdJz3vybKfdQkWxz5Qwjeho3wGqDidMv+CGPw3POKKOg523eI5qtL7F0
         oJxTImI5/M5rt+mNxX3mrfj1KBI1Fzcq0ccG9pLpKsY2+PKF1WJySJa9siG3vUxH8Vhp
         c/a8bjp/5ij6LRNdPBQSgdzpnb3n1r4SBQAajDTGpslv/Yh3iHCKVnurtp4OyPlt0ZG3
         nzqg==
X-Gm-Message-State: AOAM531W96+PUtpPQt5YADLaZqYLW3WxLAgYAxzLatPnsAM2QKs4i5qt
        fGuXMZgB65p5ABWhJHc8G9Q=
X-Google-Smtp-Source: ABdhPJwXqgq7uS6Tcjx1SZx1Aww2/d5U2tI05GsSHHER7yozK95nSSwZLGkFi7ZnI4HAy3+k2OwCKQ==
X-Received: by 2002:a63:ce14:: with SMTP id y20mr3147465pgf.186.1591804168526;
        Wed, 10 Jun 2020 08:49:28 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c9sm302681pfp.100.2020.06.10.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:49:26 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4CCCE40ED5; Wed, 10 Jun 2020 15:49:25 +0000 (UTC)
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, jmorris@namei.org,
        serge@hallyn.com, christian.brauner@ubuntu.com
Cc:     slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org,
        josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/5] kmod: Remove redundant "be an" in the comment
Date:   Wed, 10 Jun 2020 15:49:20 +0000
Message-Id: <20200610154923.27510-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

There exists redundant "be an" in the comment, remove it.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/kmod.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/kmod.c b/kernel/kmod.c
index 37c3c4b97b8e..3cd075ce2a1e 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -36,9 +36,8 @@
  *
  * If you need less than 50 threads would mean we're dealing with systems
  * smaller than 3200 pages. This assumes you are capable of having ~13M memory,
- * and this would only be an be an upper limit, after which the OOM killer
- * would take effect. Systems like these are very unlikely if modules are
- * enabled.
+ * and this would only be an upper limit, after which the OOM killer would take
+ * effect. Systems like these are very unlikely if modules are enabled.
  */
 #define MAX_KMOD_CONCURRENT 50
 static atomic_t kmod_concurrent_max = ATOMIC_INIT(MAX_KMOD_CONCURRENT);
-- 
2.26.2

