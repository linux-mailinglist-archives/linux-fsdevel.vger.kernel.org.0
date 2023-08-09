Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D848776530
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 18:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjHIQfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjHIQfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:35:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C961986
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 09:35:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so9713498a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Aug 2023 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691598952; x=1692203752;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aW6X+kqxK2WhRRQqAkMQGV3GEmMFJ09ePpN8gKobw+I=;
        b=nORzh6Q+t4E/zHbudaPjebARJgN2by2WFBmRC5L/hej7PtlySRf8o11AVZvmexp//C
         mYt0AW5pZnSRsDfwrcwG0Ou67W6ugZc0PH4ZOEn2JnjhRfXN8UH81CgP0K6qsL36qqEQ
         EUjvvSQ8JWa8TpljimvtaQc4D/FQanthQysFqr0dU+yu/P/sS5g1gH6f59HnuUSIJ+qm
         Rgfcv9ofN97oCDHyufzV0yKUee2ycbb+X+MFfwXodGQ6ORkW/gCyyM6ZbaRTbZLu/rwv
         rzL4K5Fn500godmdxCDI448M77yvxDW6HWEaDK455v+GK9JsWiyoKKMu4pufHS8DVzhZ
         R94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691598952; x=1692203752;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aW6X+kqxK2WhRRQqAkMQGV3GEmMFJ09ePpN8gKobw+I=;
        b=hCsZIm8ES5uGNP8oN59GHdh7DXncWBkuOrPMh8mCOl+F/UPouKCAOqETgOYUInpKh/
         E4rdSG/CdL9kqxVIPMkT1AVP/2n1UY7FWZ7lbCXm5XSl+MHMsWh16jrkHYV6htXHoaX3
         mvzOAH/ruVVgicENMKpNnkkaaG6RPH14vGs7LFY6og2MVqavOAgKPFscK/mVIfCkZe2x
         mMe6UAy4u5EZiOqldLKeIE/RlO9phjlSM+EBJJx3mEhtdiEYP0Q88u9ESlZ+1H/hJmpp
         DkiNarnYEJBywzZv0V0HvKOQC5oJLQ5XwJG9KNCrvBWn6UpvYZaySK6ZrfINq8QYZyjG
         Y6kQ==
X-Gm-Message-State: AOJu0YypbI+i+wP75G5anKUBEAFOgZ4mTYBChwZK9Wyye+KTSMej0lBM
        lommsepdpCqfDKTd+0XUVhut7FIQew==
X-Google-Smtp-Source: AGHT+IGTWccy7M3LmRNDY25ppc2VXdjj2wZ1sDz+ZSNIXL8qoGDREC4U2IdfEjyvPHER9pQzsjNOag==
X-Received: by 2002:a50:fb81:0:b0:51d:95f2:ee76 with SMTP id e1-20020a50fb81000000b0051d95f2ee76mr2441270edq.27.1691598951475;
        Wed, 09 Aug 2023 09:35:51 -0700 (PDT)
Received: from p183 ([46.53.253.54])
        by smtp.gmail.com with ESMTPSA id b20-20020a056402139400b00522d53bff56sm8037814edv.65.2023.08.09.09.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:35:51 -0700 (PDT)
Date:   Wed, 9 Aug 2023 19:35:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] adfs: delete unused "union adfs_dirtail" definition
Message-ID: <43b0a4c8-a7cf-4ab1-98f7-0f65c096f9e8@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

union adfs_dirtail::new stands in the way if Linux++ project:
"new" can't be used as member's name because it is a keyword in C++.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/adfs/dir_f.h |    5 -----
 1 file changed, 5 deletions(-)

--- a/fs/adfs/dir_f.h
+++ b/fs/adfs/dir_f.h
@@ -58,9 +58,4 @@ struct adfs_newdirtail {
 	__u8 dircheckbyte;
 } __attribute__((packed));
 
-union adfs_dirtail {
-	struct adfs_olddirtail old;
-	struct adfs_newdirtail new;
-};
-
 #endif
