Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1183C19A018
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 22:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgCaUrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 16:47:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34758 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730907AbgCaUrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:47:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id 65so27845712wrl.1;
        Tue, 31 Mar 2020 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvASRPgCaC5pl51Xj9DP4Wxeu7mG/1HPSOpzyUZ53rM=;
        b=nxjeR2sq/OMueEcNnfyf3sqemFIQ9tRGoOtZdGieEPWtcApjY+OYjIb31E2gmLTNM8
         CUgd9dtowCAqqqpgEeXxGXP1D9306b8uQ6lUh9pQXYKRU7WvJU8MQ1nGyJ/bhl6HsE2d
         fO2vXmVQXXxe50iieIYpECUT7t5+Ev5FmIp1Xpfg7vdj1j8J000+k7us0PlYNhwJYXIY
         MzDUSKMifaHmFQ+yDQL4XS3Lwq1sa/8X6GdduXBnXeLrntd/uoK0JQRBpfQWbtWDBTR6
         dfIDTmL6zER//TR+/mZXKqqlQkO2iYsQhmYX591wZ7mZiS7ZSyB+prpkut0lW687tY4z
         MlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvASRPgCaC5pl51Xj9DP4Wxeu7mG/1HPSOpzyUZ53rM=;
        b=GSyQLIhjulL+Y5SJY0qYGJp8k691F73kYAqaulfc79Fd7loTNUO3NTjhgjtk5aSKVi
         4wvdFfNObmI8LWHX6iErBuD1o/Hz5M378Q9h1L2isvg1EHTpJYBT/0hlfdbA/w45LFjQ
         F3y1q0ayjmI2oDmqMtnHa5Dv4X+F8hBVg5KN0+zp35qHf9hZiRS3GoU7xt4ybIRCkSJA
         2mh2oQUoq5yLqAfHHssI2KzhPzo5p9mAIWJrWEjQzYHUyJ/2QIJXdhrS2VcX7w+ldN8c
         +EafBPo1uTlCkbroQxOdQ5+OJLyICRAy4R6dlpzDKd2oV+l64iWROh5LIU6yvZ851xxe
         W7Sg==
X-Gm-Message-State: ANhLgQ3oC/O88pMlnwYHUK6xW4fTDonrH1VEqRicYNcGdlDo1drp9kpz
        eFNKQOO/TBmvV7IvB/G4Ee677Suc3Q==
X-Google-Smtp-Source: ADFU+vteECjsDAZ2xVHVsEm663gf11mvqdgWJ7byHpmU5MP+FnkJj06hcikww+/wXxKq9e7VFm3Sqw==
X-Received: by 2002:a5d:4290:: with SMTP id k16mr21990816wrq.406.1585687633570;
        Tue, 31 Mar 2020 13:47:13 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id o9sm28335491wrx.48.2020.03.31.13.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:47:13 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        linux-nvdimm@lists.01.org (open list:FILESYSTEM DIRECT ACCESS (DAX))
Subject: [PATCH 3/7] dax: Add missing annotation for wait_entry_unlocked()
Date:   Tue, 31 Mar 2020 21:46:39 +0100
Message-Id: <20200331204643.11262-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331204643.11262-1-jbi.octave@gmail.com>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sparse reports a warning at wait_entry_unlocked()

warning: context imbalance in wait_entry_unlocked()
	- unexpected unlock

The root cause is the missing annotation at wait_entry_unlocked()
Add the missing __releases(xa) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/dax.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dax.c b/fs/dax.c
index 1f1f0201cad1..adcd2a57fbad 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -244,6 +244,7 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
  * After we call xas_unlock_irq(), we cannot touch xas->xa.
  */
 static void wait_entry_unlocked(struct xa_state *xas, void *entry)
+	__releases(xa)
 {
 	struct wait_exceptional_entry_queue ewait;
 	wait_queue_head_t *wq;
-- 
2.24.1

