Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 323BDBE616
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 22:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389165AbfIYUGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 16:06:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37723 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfIYUGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:06:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id u20so75798plq.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nZZy1Tmz/s7X5733+dB0Xgf1jqMh390pv2qPQtsdqc0=;
        b=pIDhA0jg5h6EmUTZagDcIKhZS+7W5BaA1xihxMvmLNXwc1BmZ6Qoi+rIsdsxN+/Pag
         S9i2chjl2/MtZwN9GLzfd2wpB+5Xcof0SVQvErJtoM49o3rt8XoS1QnaHjHMiczGit4v
         nmaF1UH1zu0JL1crn4k1IlprBAAYp4QYoTwydUR8WazbFp0EEfjCIiBt9JCuTVGn/5+2
         jyZjU+gOV0q1Kf9/ukIEfPBW9JZkU9XJQJV8i33gous4qH0D4I8cmrn8uQPLNA6dDGv9
         H+QPgdrCu/MkMB4zXRo+EapL+i9vJCWm3DZbOP/7bQYwgEMbunou2WC3+GzcN0qEUZPa
         bx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nZZy1Tmz/s7X5733+dB0Xgf1jqMh390pv2qPQtsdqc0=;
        b=J2azq0sq6q5E0VKM3CeOyumFET7itqoMbgBwM2HFBNUU+mX9schRSuArhJMLbS7H+T
         Hw/cc0qAwmYEjsQWQ9WHZ6Nncqy1lbGZQrpeQBpQf2EkN59wCQJ7846dw5iaQNE83fx2
         5YrP0AnA93FcEFUfYl3RE/QipE2HDoTDp5Ica1j0PWdH+XAo1T1NhGZqs2I8D5sMW1j4
         En6M8rsUA3GhrVNLI2gBCf8r9WvnfY5mPRKm2p2B1/38Yol+eMAp5jSUbomvgaDks+qT
         GR4UiPL5WYePeNVs4j7RPqGPoDynJX+UkqZCFsp8yAIB9boPaG3UxxSlsEodSLUMYKIJ
         Ya/g==
X-Gm-Message-State: APjAAAVVTixYGg5JgEYT2A9j/iEiwWfkCtnb+cBapVFnrGwQBKGJDopp
        0UVqybdX13WjZl1Cr/0psE4/Z3rY9t0=
X-Google-Smtp-Source: APXvYqypiO9lHojJWgIFz7XYYkqtrLdJum1ZZEqf84cYBAzSUuKEBHW/kctFlMpFONGKvLCyCFms0Q==
X-Received: by 2002:a17:902:a704:: with SMTP id w4mr10825882plq.177.1569442013889;
        Wed, 25 Sep 2019 13:06:53 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([42.109.145.108])
        by smtp.gmail.com with ESMTPSA id e1sm363241pgd.21.2019.09.25.13.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 13:06:53 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:36:18 +0530
From:   Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: direct-io: Fixed a Documentation build warn
Message-ID: <20190925200614.GA30749@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch fixes the warning: Excess function parameter 'offset'
description in 'dio_complete'.
Removes offset from the list of arguments in the function
header as it not an argument to the function.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 fs/direct-io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index ae196784f487..636a61036ffe 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -243,7 +243,6 @@ void dio_warn_stale_pagecache(struct file *filp)
 
 /**
  * dio_complete() - called when all DIO BIO I/O has been completed
- * @offset: the byte offset in the file of the completed operation
  *
  * This drops i_dio_count, lets interested parties know that a DIO operation
  * has completed, and calculates the resulting return code for the operation.
-- 
2.17.1

