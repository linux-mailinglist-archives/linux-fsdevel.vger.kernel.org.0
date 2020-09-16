Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0747E26CAEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgIPUTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 16:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgIPUSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:18:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F87C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 13:18:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b12so7982019edz.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=p1kPmSHf+ngJa59WBAiQHanufKi/olIRQcTOaRjv2BY=;
        b=o1enCl+gl7+AvgMfzhsJZd4H1LcPChyDZWvltVzpi4cNG3wjS6Q+u3G88wvtkAb009
         1UxkaJjguttyeX1Uds5ZpO/q2XTB0nBL66u4uyJAnP+utxIx9tVxLmSQbQa/ymgDJRZp
         hIvRDqNYTQCIvvWH5pi7o9vV7MjiQ7p28TMJWYSS+VufWTKt+SZYzA5VUDXcNV0clOZ8
         mj/QP++g9m64YsYYrL9p90LAStrlDRk+qPnZvinbWPpyO53UbONICL+MYmcEfblrtOpZ
         DjNssdOuZq5Xx+gP2wwe+7lzd5w4JuT4CcnGzuUXILMXDhSLxhp9MSZYjEkEL72hWjT7
         nMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=p1kPmSHf+ngJa59WBAiQHanufKi/olIRQcTOaRjv2BY=;
        b=ap+Ebe1QAVKdZkjhiMW895AS7keMIjICm7iFJwKLY/YD1K75zOlKyMszdEevjoinNr
         iNnnAqgn/7kWTpZsV4trevhg50uJRQsKmxqUcUzPcPBBSuqFl8no0iIFTznAxyNbna31
         Ol4d1y3exQjdcA0plQzDllXRXr9azTlcEKSolZT90H7ybnDOkgMy1QgD8pLJ/Bs3WnwV
         FOs6FuNi1VlpW4mU1Hdagim0S9MHIAiMRTOP1tOgYsv/7i0Ep7rhgHh6BTi4zkjx1mGa
         Qo2TnX3/wVzknafc80rMeWpEehYvNUZKqKISGuMuff+npjnL1ndSGlAss8cgOZpfPD0o
         tGvA==
X-Gm-Message-State: AOAM530yUbCZPLmTC+ENTByEgJzGI7WeTfWfEOCKkZpgmyHfphNzxc7/
        Loh4KsC1U4m7q6w2ZQHVag==
X-Google-Smtp-Source: ABdhPJyk0MO+DfwL7h6h1Q/0Ct2k8kRh/ufVeYlStUojb6Op262OU/qjcwp3Z7+kHgrbA4mBvPgpgA==
X-Received: by 2002:a50:8306:: with SMTP id 6mr28420485edh.340.1600287525626;
        Wed, 16 Sep 2020 13:18:45 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.169])
        by smtp.gmail.com with ESMTPSA id f17sm14919665eds.45.2020.09.16.13.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 13:18:44 -0700 (PDT)
Date:   Wed, 16 Sep 2020 23:18:43 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: fix cast in fsparam_u32hex() macro
Message-ID: <20200916201843.GA802551@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/fs_parser.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -120,7 +120,7 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_u32oct(NAME, OPT) \
 			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
 #define fsparam_u32hex(NAME, OPT) \
-			__fsparam(fs_param_is_u32_hex, NAME, OPT, 0, (void *16))
+			__fsparam(fs_param_is_u32_hex, NAME, OPT, 0, (void *)16)
 #define fsparam_s32(NAME, OPT)	__fsparam(fs_param_is_s32, NAME, OPT, 0, NULL)
 #define fsparam_u64(NAME, OPT)	__fsparam(fs_param_is_u64, NAME, OPT, 0, NULL)
 #define fsparam_enum(NAME, OPT, array)	__fsparam(fs_param_is_enum, NAME, OPT, 0, array)
