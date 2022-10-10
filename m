Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB4F5F9DD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiJJLqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 07:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiJJLqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:46:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441FD57E2C;
        Mon, 10 Oct 2022 04:46:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r13so16603684wrj.11;
        Mon, 10 Oct 2022 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NsnSeVEjMZcjnL6/NlJDc2TDG47KOTr9/3jGBVyFfu4=;
        b=V4koQH5PfgZ4cfQzB+jfdUrdh2P5AxTeXhG0JeIMZtmhW6ST47raSZ4v6hBWyakPNp
         jFNSeAVYH8dgzTUJT1T67SRGndIeKurUd6PDIhJ5iMyP8zIsyEWtYFHrAn1jH9zne6vI
         rDg4S+hg6vaRrJUoNNM6+zHQikWQ7nQZHpUIJAmOHwZG5wNFP4624lYUgN9xUM5C93gx
         xAkepZHstu0yPmjx5KmQNLi543GMYwLjinaG1Tv8l/6vNZfyno465u0vdTEIthf6rTHy
         3muBYw61N+X4tny8LZ6dFG9SOFP2JudrkcAnmwxsWTHPobocKwNeJENq6NGpxKFltYIl
         yZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsnSeVEjMZcjnL6/NlJDc2TDG47KOTr9/3jGBVyFfu4=;
        b=NXUt4+/QDAQrbcgfxpvCAUL/5Yurjj74JZJPZsyC9ty2NCk/BHSaQIvZ4Aj0kx12/n
         cSDrQR1R+kfr9NKuQjsKP/YV0YHWtmmOb+RLy5FwgWG2r3K+yrHRuxPWiff85GpwA+NQ
         sLpUg6C+fCTDZHkWHdFXJXq2bsF5gdeUh9ycHJxEf8dsXyvEN9aKEWmILXE3XZ+jfHhr
         Ibt/THB75NSiB1QW0WOLvpYUEQ5ZMtcwrkpFE94s3Ojf5mviXEYcZ6sUBtc1nX8d9ecC
         g1rspcpnCBdwTVu042d5Qpn4Qm1GYeB1yiZzExaS2LRSCtXKAfkE4GujzhY1YeiXawZk
         vlyQ==
X-Gm-Message-State: ACrzQf3nRTcd9JYRIyORSyYNzAn6sjV46DVqvcpyPynQlfeAXybLocOq
        5H+Rc2xwHrEB6Q66HUk1j7wK4p2EgwY=
X-Google-Smtp-Source: AMsMyM4WZX71Z8e4s4reevWN6BC4ev4WUdvCd7/gogkoF7ELZ7KnKY7RCatXSa7DbyX05e43x8a9dQ==
X-Received: by 2002:a5d:4f10:0:b0:231:1c7b:e42 with SMTP id c16-20020a5d4f10000000b002311c7b0e42mr432011wru.568.1665402373719;
        Mon, 10 Oct 2022 04:46:13 -0700 (PDT)
Received: from [192.168.42.102] (sm4-84-91-228-85.netvisao.pt. [84.91.228.85])
        by smtp.gmail.com with ESMTPSA id k13-20020adff28d000000b0022ac672654dsm8500759wro.58.2022.10.10.04.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:46:13 -0700 (PDT)
Message-ID: <54400493-6179-c702-90b4-665b7e93467f@gmail.com>
Date:   Mon, 10 Oct 2022 12:46:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: [PATCH v2 2/2] fs/ntfs3: document system.ntfs_attrib_be extended
 attribute
Content-Language: pt-PT
From:   Daniel Pinto <danielpinto52@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <c9b467dd-9294-232b-b808-48f62c3c2186@gmail.com>
In-Reply-To: <c9b467dd-9294-232b-b808-48f62c3c2186@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add documentation for system.ntfs_attrib_be extended attribute.

Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
---
 Documentation/filesystems/ntfs3.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
index d67ccd22c63b..fa6ca1babc60 100644
--- a/Documentation/filesystems/ntfs3.rst
+++ b/Documentation/filesystems/ntfs3.rst
@@ -25,6 +25,11 @@ versions up to 3.1. File system type to use on mount is *ntfs3*.
 	  Note: Applied to empty files, this allows to switch type between
 	  sparse(0x200), compressed(0x800) and normal.
 
+	- *system.ntfs_attrib_be* gets/sets ntfs file/dir attributes.
+
+	  Same value as system.ntfs_attrib but always represent as big-endian
+	  (endianness of system.ntfs_attrib is the same as of the CPU).
+
 Mount Options
 =============
