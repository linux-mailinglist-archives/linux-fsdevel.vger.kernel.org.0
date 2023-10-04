Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99397B7E0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 13:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbjJDLTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 07:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjJDLTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:19:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439F3A1;
        Wed,  4 Oct 2023 04:19:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31f71b25a99so1959238f8f.2;
        Wed, 04 Oct 2023 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696418369; x=1697023169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cmj92m3VSDcIBkVdpo+tHysv/QluG8SFGC/Fea1aUWc=;
        b=M+kHf8ux3fisnVRI9SN2Pb5NEX8g0itaQU7bebHA5XVf0lGm2SiCUD+tfXk2nld0fE
         Y7qKy4p3I9xo/Mird9aRRDw5RYyppmZ6uPLGup632LMJZ7i/6/ADVbf4Ia0gaEdCm7E4
         ZCnxeN1WGfLLi3NPioCtBGty/6Mxwwt5yW3GhFRv1oCssUqYKTuY8xi3GnPoyfycVyuc
         Ugp1yrY8uY/kAJlANdkErDII4hEyPvy7xY5DynT5Qi9JO1Sv3z4CV4q1oRuLA86xFKaw
         SZnajXndHyxaI7SKqR97zQXhaimxqk+4ECtOOdpHEH6y2KwOx0OVvf6/ZkA1SDu+7AIJ
         drnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696418369; x=1697023169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmj92m3VSDcIBkVdpo+tHysv/QluG8SFGC/Fea1aUWc=;
        b=Tx8jVSMgGnJjWLWFW7kz03j3r2U4584jftUFclyHjlvy497p8mnrWxxiJvIaDRhCIT
         j4eFCdEVD/vethGIoikru/bkz9wtrnVr3Tjm1/m2DK7CH/xqzND+wu76HFYt2VzCrtIL
         1EaTbQFMy/LioBP3nvn/RQRq0eikJT0NwffDnaTN/xgumfd1lg5ot9KuBJM2hcE0ZK6m
         NipKoeLVynNRm3myEcY6G4eTjX36XkUxMCZXIufe5qVJz05eO3Y63MoOQ3HNU0oAAhs8
         r3hikYb3AKrBosrnIoTve/hdCvpt1uegda+Kv8fzFqle+3cl856kvgFIuyWkza50L9D0
         le6w==
X-Gm-Message-State: AOJu0YyNsyu/xC5z21+FlvzK4MXK2tX5jnprD0GZjZFGUUcSHIttnvAR
        Qspl/C34pVWuM77YM0lOZePFEdbrhzg=
X-Google-Smtp-Source: AGHT+IHXe0XJBPwlc552tQX6dG0ZgZnuAODJdyzcHbrgwDH5BGo31a/cuX27YdgMmf9pImoh8x2viw==
X-Received: by 2002:adf:e6c5:0:b0:31d:3669:1c55 with SMTP id y5-20020adfe6c5000000b0031d36691c55mr1653797wrm.65.1696418368459;
        Wed, 04 Oct 2023 04:19:28 -0700 (PDT)
Received: from f.. (cst-prg-67-191.cust.vodafone.cz. [46.135.67.191])
        by smtp.gmail.com with ESMTPSA id o16-20020adfead0000000b003266ece0fe2sm3761527wrn.98.2023.10.04.04.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:19:27 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     brauner@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 0/2] 2 cosmetic changes
Date:   Wed,  4 Oct 2023 13:19:14 +0200
Message-Id: <20231004111916.728135-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

both were annoying me for some time, so I'm pushing them out

These patches don't warrant arguing nor pinging in case of no response,
so if you don't like them that's it for the patchset. :)

cheers

Mateusz Guzik (2):
  vfs: predict the error in retry_estale as unlikely
  vfs: stop counting on gcc not messing with mnt_expiry_mark if not
    asked

 fs/namespace.c        | 4 ++--
 include/linux/namei.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.39.2

