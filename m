Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881151F3378
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 07:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFIFau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 01:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgFIFau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:30:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55C0C03E969
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2020 22:30:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b7so675043pju.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2020 22:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kIrmKQrbYSfaaEG0+Y3c9jjueQj4TTBL9AuFMhedR6w=;
        b=ghyp7EJt0H4rbskRiU7qVVUIcCb0OohqOhN6Hi9dluX1jgtA2x6gz3QIY1fC0IsYsD
         10Me+M9KvfRipXG2/CyNFepL29ToS0tXqlW4F6o9XLMX5QJkR+DUh9EDpdcvYIKq24Wy
         0tXI3PUjQM+QpDKBCrKsI2SqlG3JcQuVv8CrjwQe9g/RDqh6KzXzIezmMAULCcL8ywAi
         xvSwOq3zfIhVtEzrOE6BUyL3OHUcoWCluJuCGbPJ0QUq+WrYKSDwLeGGUzPN3UBkC7ix
         J2y8TSh7KmAQOMEzqTTE1S0sIMAUCYmSbJkf4R/PkXaiFEdHYQK6cFZsKAh4NuueIBgW
         I0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kIrmKQrbYSfaaEG0+Y3c9jjueQj4TTBL9AuFMhedR6w=;
        b=PkqRJmzGAFEVkouVsbZQQY1ZhpxpD5jmSM9qP9bM1Ip0sBkTH89fM969EsRnmljAGY
         89+W3zCGRR88AvULZB5ecSVYjGaHgGjcumdVTZU7zUVOWBoZB85EZnM8UMczXZbiMwQE
         RGx8H7XJgB8qWRaTQnxHbQRlxPAh1LGMXJFew7LU3PA5xixX2KhG+Rv8zb9qb2BlSFg4
         KIoQC9CGt37fYQNpCalXFYqxzfFr9gQSKPdBq6Iz+vzBen0c4bhkec5NNWacIvSJIw8r
         PxrSHeiu0SDAf8xCXC978jixwI6DdmMZ6iy3Qh283LCdS2WId59mlNkLTwkk0KEYrmXz
         9q5g==
X-Gm-Message-State: AOAM532QZUGUjIq46q0WjKtti8BkY4Iy6AiCY9HDVb4e7Zku0x8hpJgv
        jH3MwAnILweDgnbAbEM72V0=
X-Google-Smtp-Source: ABdhPJw8LB4gmmGrDvoSNJPo/DnOi3JZ+VZY3NNmP9SGkCR940x/3i9aAIAQHXQ77bvE8XREHs4mzg==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6mr1782557plb.338.1591680649546;
        Mon, 08 Jun 2020 22:30:49 -0700 (PDT)
Received: from localhost.localdomain ([125.186.151.199])
        by smtp.gmail.com with ESMTPSA id m18sm8559127pfo.173.2020.06.08.22.30.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 22:30:49 -0700 (PDT)
From:   "Hyeongseok.Kim" <hyeongseok@gmail.com>
X-Google-Original-From: "Hyeongseok.Kim" <Hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org,
        "Hyeongseok.Kim" <Hyeongseok@gmail.com>
Subject: [PATCH v2] exfat: Set the unused characters of FileName field to the value 0000h
Date:   Tue,  9 Jun 2020 14:30:44 +0900
Message-Id: <1591680644-8378-1-git-send-email-Hyeongseok@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some fsck tool complain that padding part of the FileName field
is not set to the value 0000h. So let's maintain filesystem cleaner,
as exfat's spec. recommendation.

Signe-off-by: Hyeongseok.Kim <Hyeongseok@gmail.com>
---
 fs/exfat/dir.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index de43534..8e775bd 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -425,10 +425,12 @@ static void exfat_init_name_entry(struct exfat_dentry *ep,
 	ep->dentry.name.flags = 0x0;
 
 	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
-		ep->dentry.name.unicode_0_14[i] = cpu_to_le16(*uniname);
-		if (*uniname == 0x0)
-			break;
-		uniname++;
+		if (*uniname != 0x0) {
+			ep->dentry.name.unicode_0_14[i] = cpu_to_le16(*uniname);
+			uniname++;
+		} else {
+			ep->dentry.name.unicode_0_14[i] = 0x0;
+		}
 	}
 }
 
-- 
2.7.4

