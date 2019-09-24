Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDBBFBC7C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfIXMTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 08:19:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40202 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfIXMTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:19:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so1267853pfb.7;
        Tue, 24 Sep 2019 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+5sR8QwSbelH07Sakdk8YenxqqWQUDtCpTgfPZQuv4k=;
        b=dQr9ye8XZLwMOxxQ9GG1g4dguj2pNJ5CSmPXp1uYpWiILcDSthtQZRhGHmkAiYlbc8
         Is+x2Jp2G28Zu5I27vWiuPYS9D5DkmTetwVUlZFYSZmvki1BzHAZg0ytlDHt9kj0uItl
         MPBnLo+mAOypGGRE8W7Kcw+/6XRvCQhxdWPvi7+dzBfIYCMXXJuthNx7dB6SZUDGi6A9
         ZYx5fJh+X9G8tZ7P2rtrGuCnY7Ek6k8nHBWpg0TZ7fSdJ6aPWnGI3PNlDlKtPHqMhylK
         6b8mAEDpA8MzRrbCvqlR4K3wG0YmaaekZ4GIkhCNOxuKeK6gpHpz2jrSyi4kFM61WbpO
         MO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+5sR8QwSbelH07Sakdk8YenxqqWQUDtCpTgfPZQuv4k=;
        b=N4wb8CQqPIBCMRw8L6+ybLpdGcPDaumzqjhYD32rEeyRZfjXFwVjPoSrVnixmSZHqA
         ck8PP9AHaEKME2nC404kbQGmId7hW0pLJjCwM5qz6y8WVXLel8VcN1Vl+8e75EjAQqCI
         OA/QYB8wfvKp0RodrICyjVQLTAjpvRoo36tuqn4rOGm871bT17BNsAePhlK6+iwfH64p
         YYDhOS2SCbs+DwDdsG9RyI3FGH+mEqYG/HMeCfQb1DqukRsQmonNFU0jbbXDcXmHrK13
         nKAWNmRlFsU4JDSOsZMuXfTyZOE0uEsL/cpbojddLJ7Uwoz7rkaiPCN1uLbRcPjtirOx
         M4jw==
X-Gm-Message-State: APjAAAWS8mhHBF+MtOWeApizWls9/AyebQeEtp5cBILKhcQB/vw6waY2
        8Z+IVzhZC+/0wkfpysuq420=
X-Google-Smtp-Source: APXvYqwh42CpUv1KlO3LdNt1jHk+eEwSSPesowB8pKujp61l4wjaF2JVxEUdbtBaWW2jsBhi7Xx7RA==
X-Received: by 2002:a63:3585:: with SMTP id c127mr2710435pga.93.1569327570971;
        Tue, 24 Sep 2019 05:19:30 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:537:7ff9:654f:9ca4:a1c9:4c8f])
        by smtp.gmail.com with ESMTPSA id u3sm2038412pfn.134.2019.09.24.05.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 05:19:30 -0700 (PDT)
Date:   Tue, 24 Sep 2019 17:49:25 +0530
From:   Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: direct-io: Fixed a Documentation build warn
Message-ID: <20190924121920.GA4593@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

warning: Excess function parameter 'offset' description in 
'dio_complete'.
This patch removes offset from the list of arguments from the function
header as it not an argument to the function. Adds the description about
offset within the code.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 fs/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index ae196784f487..a9cb770f0bc1 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -243,7 +243,6 @@ void dio_warn_stale_pagecache(struct file *filp)
 
 /**
  * dio_complete() - called when all DIO BIO I/O has been completed
- * @offset: the byte offset in the file of the completed operation
  *
  * This drops i_dio_count, lets interested parties know that a DIO operation
  * has completed, and calculates the resulting return code for the operation.
@@ -255,6 +254,7 @@ void dio_warn_stale_pagecache(struct file *filp)
  */
 static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 {
+	/* offset: the byte offset in the file of the completed operation */
 	loff_t offset = dio->iocb->ki_pos;
 	ssize_t transferred = 0;
 	int err;
-- 
2.17.1

