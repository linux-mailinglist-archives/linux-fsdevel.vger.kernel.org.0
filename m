Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C1C36C9AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbhD0QpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbhD0QpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:45:13 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33668C06175F;
        Tue, 27 Apr 2021 09:44:28 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 1so44609235qtb.0;
        Tue, 27 Apr 2021 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cCJHZajTitfvWhCX4/05gQJ9vbwlcHbuEcINXwgBWqg=;
        b=iqVn6s5xnbr12JOYlX387A+v/QNkcRlbikJs/1bl5uOACTBc+Z+GowFr8t5tZDpP02
         AhkBKawZTybIrUhaF1gg7OBap7JP8TcbooFukmKo2EO0mGMlFDJJcDaf+uN45aJQmgHO
         fHcy5L6bm6GvxljMyU4GSN0c8WHetkNIgbfkXZHYqbpdaeynd7ZChd4888Ve7ulMTwsm
         itiqjx9WJddZSrkzcPK2UJe1xqB1GAvfDpFyJC9WFR2qEkHEGXz2DE8xy2lJ8nlmEXV0
         QY1lIwGP/bQHXdgToBZCH6TBOkHPuDURFIQf9SOpFoclt7o/uu7SdLC09yNljNzkyxUs
         vGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cCJHZajTitfvWhCX4/05gQJ9vbwlcHbuEcINXwgBWqg=;
        b=IjvXj1TObh3TsB61nCQK+jUn/V9GoezjXmZdBDhqYpDgyQJIXqye1Aw68Mf7YiobY7
         C2RN9RtnFfXl/niUNnZdEITTRt94rLC/Y/EnKHJpoHCvXsk6UDTKmScTWjFjJJh9jaPO
         BQjYtDIHkz0gNyCs1mWnLowekEaQoUyIom6Biadajgj7zs4hEglxqI7vN/0pnNAU3eYT
         bAm/xXFoOKqwCO0GxtLXJoWyCplZpEqgFHwLotvwUcR61W326T7CKgNT1w7nc4etuk9A
         Gh+4RajamR1vUNzYHcHWCLcyjcU7rFb2lQNIVCklMNLdWvZbJTQewYRG7LqmkGZJ/i1s
         LaOw==
X-Gm-Message-State: AOAM530LovfCEsKCNi5JZhydZBejVDDRQRp7/ZXFkzTB1TRQOVS+0i4P
        DU6LKAWku8TNG728TsuptGPvdG3LPDqr
X-Google-Smtp-Source: ABdhPJzw0Dt08K0ehcYpLrJDhIW+6F3NCXZq8QC3TZsDcIf3v4AZhyMupSiV7/jIhYYYZTiiAaNCLA==
X-Received: by 2002:ac8:7b41:: with SMTP id m1mr22038154qtu.25.1619541867328;
        Tue, 27 Apr 2021 09:44:27 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id l71sm3149163qke.27.2021.04.27.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:44:27 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 2/3] Improved .gitignore
Date:   Tue, 27 Apr 2021 12:44:18 -0400
Message-Id: <20210427164419.3729180-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427164419.3729180-1-kent.overstreet@gmail.com>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 4cc9c80724..5a0e5206da 100644
--- a/.gitignore
+++ b/.gitignore
@@ -4,6 +4,9 @@
 .dep
 .libs
 .ltdep
+.*
+cscope.*
+tags
 
 /local.config
 /results
-- 
2.31.1

