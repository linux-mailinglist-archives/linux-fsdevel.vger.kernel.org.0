Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695973BC8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbfFJTOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:14:35 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46015 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389188AbfFJTOe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:34 -0400
Received: by mail-vs1-f68.google.com with SMTP id n21so6199403vsp.12;
        Mon, 10 Jun 2019 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukvpJfRydaYPuTfjLdUYlRJkIRyXfryPz7hZQ9HXoow=;
        b=TumAj4TdvB74km6c9YeX0VRaQTSYfO74uvAcBv8rQ1GqyLhE5WllFwZE9P7cHvhdr3
         YHdMY/ngPDORefWvUQj+mriprD70MyIfythZdNb/9rwIgWNb0vioc+XWh/L/Ln1yYtYc
         IA5t3nEqX/695bZCbCC15/a+pH4LrhfgWQ+QtjQtP6gU8JbiiQbviWbxnIFJW9tmlH5U
         cb3uTr1qzpz90tJAuvTy2QaK9w7cMlXqEFKmLX9XvzRn25SGomANMlqnAfZzazhbkX08
         qh9GGIVFq7PdUkYq/Wz5we2FALX41OgavhksUmswN8k6TUtICmgX34eBAA5sJCF6M0su
         LU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukvpJfRydaYPuTfjLdUYlRJkIRyXfryPz7hZQ9HXoow=;
        b=ZnQB6bhTEL2wzbn7VRvv2zFPqJZC50XZPSKCn49W19CCXLf9lVM1X/mJCF5tFvoTVj
         LAWCJMthWmlGfw8kDX1PywMjQFW4Dr1ZFceGnJIwxJAjoMsSbSB6Tt88V2NnzjOhSR6X
         s2spyPPTdTeJIAEw50/WB2fZNoQXPUHAK5eQ/potG0T9HS7wPpSVAGZUPGrTGbWPBfhK
         EajyFHwO4G7W3HaPQC0S6mE2bVrd1w1g42CduFIf+TD15X09pql3ghjKbVILqwCN5V0m
         8WEyVxIW2EG1eESxmvTg49DZ0zlf9ADatj/DQnDoHWMFmumi9pGq0Qk/Ob8C/GXmQWoH
         23iA==
X-Gm-Message-State: APjAAAUX9EAdr49exivOuY31wbHvvk4gCUtQwCL/zFAYLr7Zq44vDfu7
        cRP/EKxyhYo4IzRhePA1PulkpY7oaw==
X-Google-Smtp-Source: APXvYqxsHup84wBEkb0l4BUQGxeUm+1yBh79JR2Agcc/L3RBjwdqTTbsi3z7rNbZGTE03Pf/3whhwg==
X-Received: by 2002:a67:63c2:: with SMTP id x185mr38240896vsb.166.1560194073159;
        Mon, 10 Jun 2019 12:14:33 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:32 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 04/12] mm: export find_get_pages()
Date:   Mon, 10 Jun 2019 15:14:12 -0400
Message-Id: <20190610191420.27007-5-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Needed for bcachefs

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 93d7e0e686..617168474e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1899,6 +1899,7 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 
 	return ret;
 }
+EXPORT_SYMBOL(find_get_pages_range);
 
 /**
  * find_get_pages_contig - gang contiguous pagecache lookup
-- 
2.20.1

