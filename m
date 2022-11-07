Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8AC61F186
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 12:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiKGLJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 06:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiKGLJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:09:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C51A237;
        Mon,  7 Nov 2022 03:08:50 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h9so15685870wrt.0;
        Mon, 07 Nov 2022 03:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBeWKSuUmKmFn3ZQmaWb3K1FNR9mxLjZz/vQiATbFHg=;
        b=J2B0+AZMmfcW8H1mciRAq/WS1UoAZDBP2lnz9NbEnC8N2nmPX6lM8BqMD3bC2X5U09
         A6DgJQA2zVtcrvS9TmyUVgxTr/sy0Ca772Z6c3+WbXXCTizyT8ahucCcribdJfegbBWk
         pZO20Hu5bo6Yz0cnVO5Cqbd0oVy5MxLppO1+TMHHkB/MFbxrpEpMS3TURXCAtsIHkQLj
         o/NXWr2/17p1+AChkEAO/pZVe7nRb6y9HvIKzkBhweS65T+bsN1BokX3RtHKLdMoV63S
         YlB5ZetYywS0uG79VKrDahyoKIpYYvEoAAziLM5U1pHwNdcrrBgRYbXB3WhhDwlTaxdh
         i0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBeWKSuUmKmFn3ZQmaWb3K1FNR9mxLjZz/vQiATbFHg=;
        b=eQT3VT6Pgdq7m+/flq7Z2mrntZcSBP5WmNPQ9y7offO/i3v07hhpwYD10bvGE9tQ2O
         A7zI2wXe5tFJaGU1OYzyPGsNR7oDq44LNoiJEMelxk0p02d6r/dMCsoCBy16nc0QCGjg
         TsJVFYbMnbWH+to1DNu7OA3AZThfEKT80BR+ZZD1DuouC5s692eXsj+SpIQ1RvDUP+F4
         GEyKLYjqEbjQURcLO10d3goeY55TO+19qJ0jTPNOl4BFCqtrvEQA3tXvt0i4Gi139lQW
         pcZUDkzb4mRxg6tXCVgKnhbdIoQtFtkpU2nE9Y7eLZ66iRy5FNUL5GtIF/XnIAcmSWG2
         uGvw==
X-Gm-Message-State: ACrzQf2bgkMVoYDIsaiSc2zzIcYz9SmpmDc+Tl+hKbo7d4UYi6d9jOm4
        f7g9fWZuzFDUSOLonLxIaDQ=
X-Google-Smtp-Source: AMsMyM5+89oQ9eg5acWttsRAfr82SVh3XAUsJVni8qHvEA2docSbxKlKaNNySPNmt+E0OwjPB1arhw==
X-Received: by 2002:adf:e785:0:b0:236:5998:67a0 with SMTP id n5-20020adfe785000000b00236599867a0mr31650481wrm.414.1667819328598;
        Mon, 07 Nov 2022 03:08:48 -0800 (PST)
Received: from felia.fritz.box (200116b826b04a00c13f470e37e07cb6.dip.versatel-1u1.de. [2001:16b8:26b0:4a00:c13f:470e:37e0:7cb6])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c154a00b003a2f2bb72d5sm14947310wmg.45.2022.11.07.03.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 03:08:47 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] nsfs: repair kernel-doc for ns_match()
Date:   Mon,  7 Nov 2022 12:08:17 +0100
Message-Id: <20221107110817.26398-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 1e2328e76254 ("fs/nsfs.c: Added ns_match") adds the ns_match()
function with a kernel-doc comment, but the ns parameter was referred to
with ns_common.

Hence, ./scripts/kernel-doc -none fs/nsfs.c warns about it.

Adjust the kernel-doc comment for ns_match() for make W=1 happiness.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 fs/nsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 3506f6074288..f5b2a8a2f2c3 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -254,7 +254,7 @@ struct file *proc_ns_fget(int fd)
 
 /**
  * ns_match() - Returns true if current namespace matches dev/ino provided.
- * @ns_common: current ns
+ * @ns: current namespace
  * @dev: dev_t from nsfs that will be matched against current nsfs
  * @ino: ino_t from nsfs that will be matched against current nsfs
  *
-- 
2.17.1

