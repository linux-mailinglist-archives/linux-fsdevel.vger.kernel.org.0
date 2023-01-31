Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C051768384B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 22:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjAaVHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 16:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjAaVHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:07:07 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D22E2D71
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 13:07:05 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 15D173F194
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 21:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675199224;
        bh=MFyADogCLoHAjmWl9fQjaKPy+Q/5eurtLP5ZWAdBaH0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=XIF5TC5D3ho3Me9RhR4WrkpWqlQG3gvZawjE8zYElaaLotDOugI1g8u5QEXEcyVw6
         /CsS7ay3rZqylC5caNfwm5Uz5JVprNgHmW6e1crcyJToPxRZRpD6b0NIpZnKNjIfvL
         7y3NH7IcBpNZmY+AF/fjYfFPMsdtHnVQOwxyg8xh0QOb2ytXhSO+VpWfvnrLfjLo94
         Z1TaOavOXVCRylA4UTagsm0F35Xqdh36ie78IIN6F5PC6GuU6NG5gsRCPs/j2PJGLI
         l2bVs6nyi7yLmdggtN3ub8xdicWWfk8swItdoCiOM2DzTsyHFSp/aBtL71qUucuP8T
         5oAmyK+3U7C3A==
Received: by mail-ej1-f71.google.com with SMTP id hq7-20020a1709073f0700b0086fe36ed3d0so10413595ejc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 13:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFyADogCLoHAjmWl9fQjaKPy+Q/5eurtLP5ZWAdBaH0=;
        b=IjK2BWQXq/+c1uChaWai5pGGsPdocEslGH2U6FYr9Kbi4xL7vGYtzY1aodpgovQaMT
         W4e/nX+sAwft6SgYIk3TgXgbvD7Fimb4G8QSGMK2cIpSwTSr8Q9H3tgsonoOfjPmmxc4
         vcasoYbur+HWVqgsbj6kcOUO3htADKRMUL4kNtHjn8BCD+KsaCVHpSnNi5tOHenE0t31
         KBLLMTGjOBxgAok+5u0MZoouDMwu+aH29bWYMS/mYIt3/3+z+vAIlhCgzcHNYq27qXqd
         Ngq10AcKU1vy/LYUkg7Byo++nUEkKuFqce8FtcnJJUQdxtXIAraFQOpnGwN/Cw/Gix62
         dO0A==
X-Gm-Message-State: AO0yUKUcDhvSJf5Qn0v4I0PDSEerakbSa5gRafnufditHzGp5Zf6LFSH
        40lNOvDbH1uBpVYV05LOThfb7gXIaHmHNb567o4lwc3GUwhHO/3xoll3oQEhhed9CMfzuSxyU+B
        L1QhXI3573wGkZoW7Cl9yk/VAFc+gqhvQtdscs9ZwS24=
X-Received: by 2002:a17:906:5cb:b0:87a:daee:70b8 with SMTP id t11-20020a17090605cb00b0087adaee70b8mr16493763ejt.24.1675199223799;
        Tue, 31 Jan 2023 13:07:03 -0800 (PST)
X-Google-Smtp-Source: AK7set8FEqPdFt+xqukpr8ueMlR3yyoUm6bxh6Y/DFC/MewUnyfP7TM7eEhXGfLwm9l4+bJxncaq2A==
X-Received: by 2002:a17:906:5cb:b0:87a:daee:70b8 with SMTP id t11-20020a17090605cb00b0087adaee70b8mr16493741ejt.24.1675199223490;
        Tue, 31 Jan 2023 13:07:03 -0800 (PST)
Received: from amikhalitsyn.. (ip5f5bf399.dynamic.kabel-deutschland.de. [95.91.243.153])
        by smtp.gmail.com with ESMTPSA id ja3-20020a170907988300b008818d9e0bfesm6231172ejc.117.2023.01.31.13.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 13:07:03 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     corbet@lwn.net
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/2] docs: actualize file_system_type and super_operations descriptions
Date:   Tue, 31 Jan 2023 22:06:49 +0100
Message-Id: <20230131210651.715327-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current descriptions are from 2.6.* times, let's update them.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org

Alexander Mikhalitsyn (2):
  docs: filesystems: vfs: actualize struct file_system_type description
  docs: filesystems: vfs: actualize struct super_operations description

 Documentation/filesystems/vfs.rst | 105 ++++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 19 deletions(-)

-- 
2.34.1

