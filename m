Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A89A000
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 21:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbfHVT00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 15:26:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34439 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404389AbfHVTZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:25:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so4033551plr.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cvNFosYfslBR/6BVIMWexVcAL5TsK7108rSnZMZd4X4=;
        b=LqfcfkmpyJUSc2aXfZWs3W0xMRRcheys90Q7EO54mjpiPWnL9sBnbv8XMLomSSx8O9
         9ktpA4rZhdplpQ4ro5QS7HE4S//9qBDE3luw1BnSeewiMlF5fftt+LT15Sit1z7GBMmo
         yaCcSKkt+tggxjuspHuFaMogtb3SCbr2pE7Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cvNFosYfslBR/6BVIMWexVcAL5TsK7108rSnZMZd4X4=;
        b=UEfQj4WsBRM2vycNScEP8AoEdcm93Kk77sM5vfwTbyX80R6c4oV54/w6bQ70gmmYMO
         EPYdNXcoRPam8lVTPKCcQnPLdEST686RQskH8EPs4bBMrBixaZp2EHrp+t9dpMjIYXpT
         +N7N+xJQ2ItXQ4l5Cz00748em+jNS567lADjLLDnYE/dqdAKA66WwEoNGYPXEHm6GU8S
         Cj4sHLeO20IKmEnco2yuo0W+QY8E4vm7rjfcbg1A+NNNKAVpBKI3vZHk/2irjeRKo8NZ
         UFmyvjHSIiNPw/8j0ebRU4LyYprzFP2Szd5Rkb5n52sILnwglbh8CC8LAdwK++YcTLiZ
         BPtQ==
X-Gm-Message-State: APjAAAXKKE/d7JIiIq30w6M3a8NcX/nw1ijN62Vbbmij2N9rZ9+7WiIJ
        uHtHz+c9Hhh65nDLiyINGdR2sg==
X-Google-Smtp-Source: APXvYqxTvONL03yjcaj7MsrmAUaBSFUgWDAcWsFUDtXLuMO0GvKeUtS496WfXIlpijUGpqlrHgo0FQ==
X-Received: by 2002:a17:902:ba81:: with SMTP id k1mr441791pls.213.1566501924580;
        Thu, 22 Aug 2019 12:25:24 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c12sm198018pfc.22.2019.08.22.12.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:25:24 -0700 (PDT)
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
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 7/7] MAINTAINERS: bcm-vk: Add maintainer for Broadcom Valkyrie Driver
Date:   Thu, 22 Aug 2019 12:24:51 -0700
Message-Id: <20190822192451.5983-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822192451.5983-1-scott.branden@broadcom.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add maintainer entry for new Broadcom Valkyrie Driver

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08176d64eed5..6eb2e3accf1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3456,6 +3456,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/broadcom/tg3.*
 
+BROADCOM VALKYRIE DRIVER
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

