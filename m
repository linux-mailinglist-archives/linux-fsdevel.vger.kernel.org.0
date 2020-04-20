Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA581B11D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgDTQkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726640AbgDTQkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:40:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0748C02548A
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 09:29:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id u13so12978575wrp.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7w9nmNBGsjZ8g1AxOpY7S0OshnRpEqggc1V4tLkIMBE=;
        b=Lu423NaxJcOuv3tL9qo5zCo91sQCGKojRmKGPt5ASvT/+1z21bFxziGVKdJ1lHgqC0
         Xy+A4Dn7LEKPZ2eJiWMDqlklvuTPBgebuQmMuqSeCArvmUO7MtS2zsv8PLlrv3BDdVWU
         6a8w7IS2I3moR0lRjQhdc5iTncFpasLv8ZKSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7w9nmNBGsjZ8g1AxOpY7S0OshnRpEqggc1V4tLkIMBE=;
        b=l7TBUDG8QV7rtaVs3KVR075Rqa6IPEk2JEHalx4SDCQu1SLPdDYmq0LeEDm4q3FOE6
         9Aw7WOYHKApTCSqX1VnT1cVY39aqxs0WZrp/gNVgT6cSQUr0V7bxURgCe1ofTlpeLiJi
         QUUe5+t1cS4KH2miB9kkjrUjybQ932fXzF+gnjw7RGaUctfVgKjrsKAgBP2nuvAfTIzi
         t3crxvTPVRCI+rQG/Jph7AomKhFWGUf8bYPeMTtpTNjjQlcx/yb58gJ3aF2VQnQLGq6U
         ma/FFtyS+TNQYz7zLc4VGhH2rOKPUg/JCztd5j33wtNGVGRc+UsJeL6zd7uG6BQ/Q0d/
         lgHw==
X-Gm-Message-State: AGi0PuYfWBIgioNUblprUI4FZqea3l4EPo04pWOgU9vTrhNF6trC79Sy
        YLDjwCC1V2x9VtQOSUIyggsh/A==
X-Google-Smtp-Source: APiQypKPXicdNeBpGeejqBN55m76c7gdscTrrUzk+O2mrsEu1hvr1swh/4BLxL2SP5wH9fOGY+aP9w==
X-Received: by 2002:adf:bb84:: with SMTP id q4mr18506761wrg.141.1587400148536;
        Mon, 20 Apr 2020 09:29:08 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 36sm14882wrc.35.2020.04.20.09.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:29:07 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v3 7/7] MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
Date:   Mon, 20 Apr 2020 09:28:09 -0700
Message-Id: <20200420162809.17529-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420162809.17529-1-scott.branden@broadcom.com>
References: <20200420162809.17529-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add maintainer entry for new Broadcom VK Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..ca6a66c09db3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3610,6 +3610,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VK DRIVER
+M:	Scott Branden <scott.branden@broadcom.com>
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Supported
+F:	drivers/misc/bcm-vk/
+F:	include/uapi/linux/misc/bcm_vk.h
+
 BROCADE BFA FC SCSI DRIVER
 M:	Anil Gurumurthy <anil.gurumurthy@qlogic.com>
 M:	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
-- 
2.17.1

