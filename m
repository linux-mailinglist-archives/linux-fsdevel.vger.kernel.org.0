Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3213E27CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 11:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244733AbhHFJwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242756AbhHFJwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:52:33 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D8C061799;
        Fri,  6 Aug 2021 02:52:17 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c130so936117qkg.7;
        Fri, 06 Aug 2021 02:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fkNeqpNF5jRo/BI/tlSB7kvGxORHyjBjoaBmdA8dbl8=;
        b=mSgqOk5xrXiP+7KgsXvpGH/KV/+ch8Yl1hT2lHmA/1bl6zuSQjjTh6U9gKu9qHuqPR
         0TIeX0w1kc4lYP6hI6OCZuIFlZns8xXKcPPOTIRBY3c6JcXXb1KycI3odIN11Fk33AHr
         Kumx+KuN74BS6U74VDe23dPIyBhpyKchDKNJGQyeiGibfBod4zKYz/g5YQqOz+CcaIep
         LzDaCj7rwVS6Q5ljIgrLspcdh+Bo3iPu8yHZ4rqJN+b+bXR6DryvHgn4+GKUCQat3XeE
         VB9EmbjIVWSFZffAOveJf1ZTJA1QlCWsj+xkNioxjr/6O603THzaxKUfdm7WX3vZm1tk
         +oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fkNeqpNF5jRo/BI/tlSB7kvGxORHyjBjoaBmdA8dbl8=;
        b=ryUfvfU5l90vM8jL82fPjbWz7c7plaJkefdcTeVr0fksUbg0A5Q0RisVhIzd6iistO
         4hwY1T+a6dqVzEDz3r7WAwUwcyq1aU4VEBYFbpFC46AC4UtNhWLm+lnT3rrgxDz7hTST
         BN8zIXOgNq9+9ODgEGDw8snc1mbYRZpd1Yhm1koxUHiG6pi0HnAnRXTDiBmILIxAER33
         P7A/fJ5WRUIhxsefJo41XTI3Vz/FTFUJ9Dm/0X4zSMelO2mvQHdrPtqeJPNXHmBbo5yJ
         U5WmFp8dEQ4oCPH9JtBAMK0hx0QspVfrh5NokHVlVF83Wn8flvRR3rqMNPyxh5BDloC2
         iwxA==
X-Gm-Message-State: AOAM533dZIIOTbnt6lpiMrUy/wngdMsSF5ohBTNX0570UfLm8eAUeoHP
        F5CpeYwpu+aE4TW4CTDJF6A=
X-Google-Smtp-Source: ABdhPJxXhnPB2PZjfQlVlu8XQeA93JPqeH4IZUQ8g2nUjUzpDWq9chilNp7gyB3Xtqo4865m7hXUDw==
X-Received: by 2002:a05:620a:158c:: with SMTP id d12mr9271433qkk.391.1628243537041;
        Fri, 06 Aug 2021 02:52:17 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id s3sm3296915qtn.4.2021.08.06.02.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 02:52:16 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, rdunlap@infradead.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        willy@infradead.org, linux-damon@amazon.com
Subject: [PATCH 2/2] mm/damon/Kconfig: Remove unnecessary PAGE_EXTENSION setup
Date:   Fri,  6 Aug 2021 09:51:53 +0000
Message-Id: <20210806095153.6444-2-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210806095153.6444-1-sj38.park@gmail.com>
References: <20210806092246.30301-1-sjpark@amazon.de>
 <20210806095153.6444-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit 13d49dbd0123 ("mm/damon: implement primitives for the virtual
memory address spaces") of linux-mm[1] makes DAMON_VADDR to set
PAGE_IDLE_FLAG.  PAGE_IDLE_FLAG sets PAGE_EXTENSION if !64BIT.  However,
DAMON_VADDR do the same work again.  This commit removes the unnecessary
duplicate.

[1] https://github.com/hnaz/linux-mm/commit/13d49dbd0123

Fixes: 13d49dbd0123 ("mm/damon: implement primitives for the virtual memory address spaces")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 455995152697..37024798a97c 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -27,7 +27,6 @@ config DAMON_KUNIT_TEST
 config DAMON_VADDR
 	bool "Data access monitoring primitives for virtual address spaces"
 	depends on DAMON && MMU
-	select PAGE_EXTENSION if !64BIT
 	select PAGE_IDLE_FLAG
 	help
 	  This builds the default data access monitoring primitives for DAMON
-- 
2.17.1

