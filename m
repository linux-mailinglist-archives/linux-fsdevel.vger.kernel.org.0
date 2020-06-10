Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F951F5849
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgFJPt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:49:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46080 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgFJPt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:49:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id n2so1091036pld.13;
        Wed, 10 Jun 2020 08:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VaG7u6/oJsTeb5TEDlgcUeH6UZPnr3RsvPE6NVTbAOU=;
        b=LONDURJ+m34Rxt1zTQe26+zWI6iaGPKGUxgdfRPEybeVavviQUFyqeE3i56mvhOQCe
         dsyIkhS2WvRfkbIhtpyDJ+pshgtxrMFb+annPnC30/wNc81XpPA1fSZHycni4/DOIbmX
         2eKf3ETss9jPM0WMumqHK/5efJVLrlLC2/S1HMN7mQEpmHuuAjTaw6oF9JUdYPiURw9/
         t/h87jaU9/ZkyhpIcejulLPiWtGqO8gedYFjQdndyUx110UCQo50XaiLS7KJeWAsGFMI
         cQJ1y0F0arwIsTwRFX2INy+l3PZunoRN/5CVHAYwkGxAGnyosx7XNrHh3sn/IUn1bfrr
         UlrQ==
X-Gm-Message-State: AOAM530qnyKN5H2P0PmV+ujZTW25xpAXAmyVtX+dYKbVTNR0Xlrqdo30
        e5doaI8Z9A25Tr0DcfMqJqg=
X-Google-Smtp-Source: ABdhPJzZoTl6eBSN8rqRCZozE//xcl2A2KM4BNx2Ocdpgf10NDUQ83ejBj8RMkeBJS9LOY1t52eKiw==
X-Received: by 2002:a17:90a:21a2:: with SMTP id q31mr3700686pjc.230.1591804166854;
        Wed, 10 Jun 2020 08:49:26 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p31sm252812pgb.46.2020.06.10.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:49:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3872940B24; Wed, 10 Jun 2020 15:49:25 +0000 (UTC)
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, jmorris@namei.org,
        serge@hallyn.com, christian.brauner@ubuntu.com
Cc:     slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org,
        josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/5] selftests: kmod: Use variable NAME in kmod_test_0001()
Date:   Wed, 10 Jun 2020 15:49:19 +0000
Message-Id: <20200610154923.27510-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

Use the variable NAME instead of "\000" directly in kmod_test_0001().

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/selftests/kmod/kmod.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 3702dbcc90a7..da60c3bd4f23 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -341,7 +341,7 @@ kmod_test_0001_driver()
 
 	kmod_defaults_driver
 	config_num_threads 1
-	printf '\000' >"$DIR"/config_test_driver
+	printf $NAME >"$DIR"/config_test_driver
 	config_trigger ${FUNCNAME[0]}
 	config_expect_result ${FUNCNAME[0]} MODULE_NOT_FOUND
 }
@@ -352,7 +352,7 @@ kmod_test_0001_fs()
 
 	kmod_defaults_fs
 	config_num_threads 1
-	printf '\000' >"$DIR"/config_test_fs
+	printf $NAME >"$DIR"/config_test_fs
 	config_trigger ${FUNCNAME[0]}
 	config_expect_result ${FUNCNAME[0]} -EINVAL
 }
-- 
2.26.2

