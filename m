Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8241E284188
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 22:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgJEUj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 16:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJEUj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:39:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2766C0613CE;
        Mon,  5 Oct 2020 13:39:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e17so2363978wru.12;
        Mon, 05 Oct 2020 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s6iDC9dUHJsp946AwvB4HqOpH0+Gyt+ZQFRpxT0XcVA=;
        b=K7DTrK0GdYHxog7SsY1N3+Kxz2lpMsx9Ntecvkbxy7EnP7KNodDTxm4vg9KgPVRrkp
         oERbErfELiAWgBC7sy+G9vkMbUhcOd/3Ouop8+32yTbCP+lW4XfInqX6YQsvm1jxvDw5
         IlTOcH0P09hkLrPat1IgfcU3HXAfRyBbCAFmBWyd2y7bVPo7HwubzU0tGB2Mt6JG8PfR
         VEAB9TSw4ahUGoA4exHQmC2laANryX350/O3xDEPJXKo3Qb+88SDbgu0swk12fDoUZv2
         cMeCfDKbOsaKyI5Lyfw48BjpviW5aDNKQMVIkHffZYTSXAD/JchcIrEkgR4eiNCJhODJ
         GrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s6iDC9dUHJsp946AwvB4HqOpH0+Gyt+ZQFRpxT0XcVA=;
        b=S2+8FIBOEejYm1o6KAZsASBnqJvjljcPlFko4dVaqOll3qqKTxdJtUJlhho9iK6erM
         pSzQoC9qEk0UNg3gvZ6j/IhhdK1LHqRajaH2VuXUzAO46EwNq62q0uCIHPA0DkN/zKWa
         7ZhaL27TM29pT+UvY0W1GcjWecZSbCbByhwbG5QUlcsaEZM352ICc7JKAD31TQtJjxKR
         1alE6CReDN6S7O6p6ro3VcmQiDbumdEIj+c4QYR+FQ1xQAhm/mDXECeqpoys5FHGSOWf
         og4Sl7KLpHoXqDm36Bd83TXFFLktVaQicfdyQFmrx7Zub2V7t3Rf3+8SChYIyJBQU/3q
         1xSw==
X-Gm-Message-State: AOAM531ITzdCEBMZLtvh+Mghz2EhOyy3rMtNMzUfiNl5xTnzdeKtBgcB
        Opu6BsZvkXmTPeGsotVWTGIgJTS2cshang==
X-Google-Smtp-Source: ABdhPJzFSr8+CEKAseUSNhBRTaD/bhR4pMFdNpvhT9e1yKN0zIQNhueuD86vXnYgCViRRH7kKSF7Tg==
X-Received: by 2002:adf:9504:: with SMTP id 4mr1207472wrs.27.1601930397364;
        Mon, 05 Oct 2020 13:39:57 -0700 (PDT)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id t13sm882079wmj.15.2020.10.05.13.39.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 13:39:56 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-fsdevel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] kernel/sysctl.c: drop unneeded assignment in proc_do_large_bitmap()
Date:   Mon,  5 Oct 2020 21:37:49 +0100
Message-Id: <20201005203749.28083-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The variable 'first' is assigned 0 inside the while loop in the if block
but it is not used in the if block and is only used in the else block.
So, remove the unneeded assignment.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

The resultant binary stayed same after this change. Verified with
md5sum which remained same with and without this change.

$ md5sum kernel/sysctl.o 
e9e97adbfd3f0b32f83dd35d100c0e4e  kernel/sysctl.o

 kernel/sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ce75c67572b9..b51ebfd1ba6e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1508,7 +1508,6 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 			}
 
 			bitmap_set(tmp_bitmap, val_a, val_b - val_a + 1);
-			first = 0;
 			proc_skip_char(&p, &left, '\n');
 		}
 		left += skipped;
-- 
2.11.0

