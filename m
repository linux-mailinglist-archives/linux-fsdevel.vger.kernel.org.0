Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF806178ECA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 11:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbgCDKr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 05:47:28 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38535 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387488AbgCDKr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:47:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id e25so1751036edq.5;
        Wed, 04 Mar 2020 02:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b6DQCUS0+Ug7UlNm5mZo2LZjk1wdwZ8PPHxJgscamZg=;
        b=drTJ2zTMj0NNTZz8bc6a7Qn9zT9Qkuo5l8l38x7+6y1beHr0FBGlK/Re5BDWKyeD+l
         kdVh3Jxm2m3t5SCQl24C/QuaCD9kjRZZ9oRTRI2tXAB+3DmjU4lQT6woIGKyDe8Dg1s2
         cjUAzathkzY7gd5/KxgEgwp8PmO/dHTFtkfE8NxeBhas24s+4DYimHvDe7KCCtfDHxE3
         6iYEXmG61vBibkXmvkAs8G7MoGCsS81jLRsF8joiK1TsFxb98cCO1H3X/FbnWzyRSx/R
         kXPKyoNnMfSowRHQBe2CMXfsNsjKSCIlHJ5L+eXmz1gUYIjqNlB3Bi/2uucf22iNzSmF
         Nbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b6DQCUS0+Ug7UlNm5mZo2LZjk1wdwZ8PPHxJgscamZg=;
        b=KNkB39CYXDpio5YDiNTIA+yBXmtSCWsD2STl6HT/J1WWFQUaJq44dwoCyGe/0S3gA8
         PMhmGzALCf+FeqP/nN4hkwYsltrJjaW714CmpPwGNYSPy4fEqef8EImnKrjisA2eXYxl
         EUvLNelCgg93Hp/kt9chAtz2ZxJC1IMkYRCHHo7wvlUAr7s8sLT6FkfUELa5n8jeJoNK
         oK+J1LDpreVloWMj3nzLzAvJebs++vCTuXNUfq7vl0TsWJGK0Kc4ebluuI8M4TV5uhNI
         LbVVyD0rEVvPz9oUUHbR35IgM90pLbtalMdqYks3x/sDY5c21GJR6n9d51PwHAcmByPZ
         Pygg==
X-Gm-Message-State: ANhLgQ3j/+njcs0+xgI5YH6BzqffLbCLS38l41fFxh+TTgARqlkxp+CR
        iNqZZSvcjXXO57VDkT53t3A4BJyC4x4=
X-Google-Smtp-Source: ADFU+vseIgFS3ZIL+3zyZq5qbs5LEoXF3Ie+FFY6418MPbDsbyXXQiJ4InDXicWMqYfHwlHZx0Rpxw==
X-Received: by 2002:a50:d0d0:: with SMTP id g16mr2114242edf.187.1583318845457;
        Wed, 04 Mar 2020 02:47:25 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d16:4100:3093:39f0:d3ca:23c6])
        by smtp.gmail.com with ESMTPSA id 29sm1122854ejb.4.2020.03.04.02.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:47:24 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-bluetooth@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        linux-wpan@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust to 6lowpan doc ReST conversion
Date:   Wed,  4 Mar 2020 11:47:17 +0100
Message-Id: <20200304104717.5841-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 107db7ec7838 ("docs: networking: convert 6lowpan.txt to ReST")
renamed 6lowpan.txt to 6lowpan.rst for the ReST conversion.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: Documentation/networking/6lowpan.txt

Adjust 6LOWPAN GENERIC (BTLE/IEEE 802.15.4) entry in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mauro, please ack.
Marcel, please pick for bluetooth-next.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e19b275f2ac2..d064049aad1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -176,7 +176,7 @@ L:	linux-wpan@vger.kernel.org
 S:	Maintained
 F:	net/6lowpan/
 F:	include/net/6lowpan.h
-F:	Documentation/networking/6lowpan.txt
+F:	Documentation/networking/6lowpan.rst
 
 6PACK NETWORK DRIVER FOR AX.25
 M:	Andreas Koensgen <ajk@comnets.uni-bremen.de>
-- 
2.17.1

