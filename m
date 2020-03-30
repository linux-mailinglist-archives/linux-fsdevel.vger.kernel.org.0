Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD0C197BFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 14:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgC3MhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 08:37:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39022 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730206AbgC3MhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:37:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so21412052wrt.6;
        Mon, 30 Mar 2020 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6yL3vQimJJlRACDKO70C6ge2VfoDCDzeccNUoYIrLu0=;
        b=UIGyUMWOfWopGHtMiHUHoRXwEvshaVH/qh34Q0W2SGjJxEiKNzmxA6lzyrhW6jxGLd
         oAcKTOyac8S0fySwFnS/RPa6VS8TrgmuWECrAvooklYMMGc2GZKZrRP/7MR9bICyk3D9
         Z/w6BTplG6cUskv/VVwp3fFD2WZ+M+2hz+TlpkBW1QB+AC9M1rqJS3TYggnyg6TqIT9N
         C7DXv+4RoT6rHP9cQlVrI3tfdAs2po/gdq7G9Fh5dBoOspJMJuTWL3hkPKVX4udOxc7q
         NgYv7CGwpUxmdX5420J/J4PzPha4bBrtvzUOO+4qdiBNnB9dAV85vpSwLtWbL8QCuKLr
         8U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6yL3vQimJJlRACDKO70C6ge2VfoDCDzeccNUoYIrLu0=;
        b=E/lUITvdxFCI/AnpA/7bEuX86cip6YqnaS5GmZg5lsFpF0IUZ7LF6VHDQaCVeCs4x/
         CFHP1gTsZNooEMFnnRQvOOB7eb69asJJe+i4LxdSeSJIGPSlXAjtJLKleXmibjsTzKuc
         Ct+dmtbNm8kZMyYl38vDSrBA4eyQHw7VQoAj0TBl5MrAD2caBfTDRbVzbr4SEZbaG3gI
         q5T3/54cdmOsfvzz0+SvS0tGwe1jPshjKAvKQRWzWG7wT6wscJ1bM1/Mi8y1CerPwtfv
         zdTBAF8kxi9zhd36s61+IclCXEwDNgDfRKL5P6q1HFgJzfonF3KDzkHBIIqjedll/jrj
         R2uw==
X-Gm-Message-State: ANhLgQ0i+HB8W7lkMojpq18qc0/ocjZQShHJ+LBsW7lZnUMv0CfXXxR9
        FS2vAEy2nIB0CU3/XhwPzm9pgXwu
X-Google-Smtp-Source: ADFU+vsLDG1FmwEn4kf00O4g/ZdbCw9zoYcKXCKl7/7U/6Tb/oeo9vgw7OPLjyFV37KcSszQW/fzfg==
X-Received: by 2002:adf:e584:: with SMTP id l4mr13461215wrm.388.1585571830633;
        Mon, 30 Mar 2020 05:37:10 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u16sm22574806wro.23.2020.03.30.05.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:37:10 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/9] XArray: fix comment on Zero/Retry entry
Date:   Mon, 30 Mar 2020 12:36:35 +0000
Message-Id: <20200330123643.17120-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200330123643.17120-1-richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Correct the comment according to definition.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/xarray.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index f73e1775ded0..a491653d8882 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -32,8 +32,8 @@
  * The following internal entries have a special meaning:
  *
  * 0-62: Sibling entries
- * 256: Zero entry
- * 257: Retry entry
+ * 256: Retry entry
+ * 257: Zero entry
  *
  * Errors are also represented as internal entries, but use the negative
  * space (-4094 to -2).  They're never stored in the slots array; only
-- 
2.23.0

