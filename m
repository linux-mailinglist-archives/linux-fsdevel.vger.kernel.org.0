Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80850266A37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 23:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKVoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 17:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgIKVoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:44:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB072C061573;
        Fri, 11 Sep 2020 14:44:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so12806153wrt.3;
        Fri, 11 Sep 2020 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B3XM2IMEUoA4BWt/CnkRH8Vm87Yk8R89kUhhyI1qNUg=;
        b=t+IPuz1w+4NStRmF1sLVPsOIhc5bdI7fnGUmj49gQYVr4fSk43wt6iPMoD7m2pB6HJ
         7VKvqD5/cPz26JnUH9qSf+3c9DimlSstpsC7hFwnjOzSi2V+TPIb8+anbfLgFG+rTljj
         e3rye3EFif06Do/YsEep6DFNCxvzmZhzfrpmHZlMY7CqseGWeg1Fs4JH7NDvn+NBVtmZ
         qT2ssqDkAhUDfA6g0KJYLCSxa/uxGm38rA9+j864J5PFiP2mcSCd78zV0zs5o4Fl2lxK
         cSh6/KJt+pPIKv2mNUf9y2HqkUFgHCrek9S+Ur2nkqGYGyZjHO41joanvoP+lTgeZy13
         Frrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B3XM2IMEUoA4BWt/CnkRH8Vm87Yk8R89kUhhyI1qNUg=;
        b=BgIYFCv6oi6ak3No/Dh2ATMccDtSLzgQOwH9uzukEtcyo8vi5QiaoGNrCAUaIyP7jx
         zXsBDiu5NAM9JwSEF08dJ7169VNsvgDR4tjwMIWrRytLIxrPSIzVbfBQb3oCnpXWAGog
         WRaNxSkKWNGW+P5YQomK2OXWgpHe8whdw1wGdpU8IoqYIR9jKL8xmYFSCK5jPr1BkGwe
         SGioCBOPzrg5EU5ecqfN2ekZigz7Nhjr3X+Eb2qlUjuzLRLtt4z8SaihpPsVQJ5ZLg/Y
         aRRa3KDd5wtX+xeTS8kveFIwWEszEx8mbR48NBBcEvmiENU4Cdfa1yw++K9nlSxLCMOQ
         O8qg==
X-Gm-Message-State: AOAM532QaJIyn2+y4p94jIVQZa/gaFJqShs4Z2iYGOIHjGlaFaagNJBr
        wXM/SocJRvcu+7hU9b6gHhU=
X-Google-Smtp-Source: ABdhPJyomJN07bsB5vFddEpb819KxEJMio908W9x1XHjJEBXAbWdG/RWeeE46FWrhvuQfoXs6lNgLA==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr4284837wrp.340.1599860648574;
        Fri, 11 Sep 2020 14:44:08 -0700 (PDT)
Received: from localhost.localdomain (188.147.111.252.nat.umts.dynamic.t-mobile.pl. [188.147.111.252])
        by smtp.gmail.com with ESMTPSA id 185sm6917886wma.18.2020.09.11.14.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:44:07 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, bcrl@kvack.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH] fs/aio.c: clean code by removing unnecessary assignment
Date:   Fri, 11 Sep 2020 23:43:35 +0200
Message-Id: <20200911214335.18794-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Variable 'ret' is reassigned before used otherwise, so the assignment is
unnecessary and therefore can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 fs/aio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 42154e7c44cb..0a0e5cefa1c4 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1528,7 +1528,6 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	file = req->ki_filp;
 	if (unlikely(!(file->f_mode & FMODE_READ)))
 		return -EBADF;
-	ret = -EINVAL;
 	if (unlikely(!file->f_op->read_iter))
 		return -EINVAL;
 
-- 
2.20.1

