Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A559FA42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiHXMrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 08:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiHXMp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:45:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D58282763;
        Wed, 24 Aug 2022 05:45:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x14-20020a17090a8a8e00b001fb61a71d99so1486318pjn.2;
        Wed, 24 Aug 2022 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=npkVAu12heSnhWpZ/kqn1O6KxNiWQg5rXFWETXNDdpQ=;
        b=JEmdoabGg54J4AFzVurih/EmRU/NoImnRdE7BEKra956TuOyIZMfkRjtuKG4Z/HaLF
         MvGMAeN7DF5uLGNnrgmqq5rSe76CPKJ0WEPGNf5uTIGI7n+ggN9nuHmQ3e8kXE8C1Jjg
         A1vUh6lWrZAwUmevgszqInzj24bw5Qab+4062kJxACRZ380Z28VugcrD2J+h8s/rGRwy
         ZOGqWKJPbpCj8J3hnWU58N7LSYfJBp8pZL3OVTyxjrCyxEKPT/EFv2/VQnhJlQUMf+bT
         rTQKaLeGO7KcFnMwFDY82UqNkxA+S88yAYQvHGJTXAJas4C/29DW7MDSQSMYkVP2niYS
         wqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=npkVAu12heSnhWpZ/kqn1O6KxNiWQg5rXFWETXNDdpQ=;
        b=six/W8Q7ZOUKD8vFn+aAgqLPS9y4RHIrQ8RqDF0+VT6KkP/n10GmioOTQCN/LjXjKa
         qg1TGm5XTbiJl6QgWQ6EgrzZFTGXA7wP4TgwkDrsf4fGHdw3juscBYvneZNBXuWhVmY8
         LyLmJx1+XpQr33o2Ygy3zl8pI9K/LxA4kpEuznJiCboyeFyoCIUIY5MxSelcCgyZFb0v
         7ImRtThtPBWAeeMiMoNzf1uLC2yBXrL+cuEylWzFR9/mZpKS/VCWYsGB31m0L+DQktng
         OkCJKuWm3l+CiSjN8vSu8Rj7zp16glzoT+ZqWP5X+2aQUTOUxFMr0aarvPfFbXwXbsB5
         o8Uw==
X-Gm-Message-State: ACgBeo0d7GE0Yf9YMmEHsb17zccnME4rXaGr2k8EAXMrUJmcJ+9bbQbZ
        FMEwK/Q+6kIWob4QqSzxkGXUNJzBD+o=
X-Google-Smtp-Source: AA6agR7WbywfKhv+0+fOFkH5LzjhLQ8WMt5bRzvxYk5REp6tBZh3/aI1ExtS/zGoFZWWKTTUZXLQNw==
X-Received: by 2002:a17:902:b68f:b0:173:188f:5fa1 with SMTP id c15-20020a170902b68f00b00173188f5fa1mr1329100pls.155.1661345120887;
        Wed, 24 Aug 2022 05:45:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x63-20020a623142000000b00528c066678csm12970714pfx.72.2022.08.24.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:45:20 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     bagasdotme@gmail.com, adobriyan@gmail.com, willy@infradead.org,
        hughd@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH v4 0/2] ksm: count allocated rmap_items and update documentation
Date:   Wed, 24 Aug 2022 12:45:12 +0000
Message-Id: <20220824124512.223103-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KSM can save memory by merging identical pages, but also can consume
additional memory, because it needs to generate rmap_items to save
each scanned page's brief rmap information.

To determine how beneficial the ksm-policy (like madvise), they are using
brings, so we add a new interface /proc/<pid>/ksm_alloced_items for each
process to indicate the total allocated ksm rmap_items of this process.

The detailed description can be seen in the following patches' commit message.


-----------
v3->v4:
Fix the wrong writing format and some misspellings of the related documentaion.

v2->v3:
remake the patches based on the latest linux-next branch.

v1->v2:
Add documentation for the new item.



*** BLURB HERE ***

xu xin (2):
  ksm: count allocated ksm rmap_items for each process
  ksm: add profit monitoring documentation

 Documentation/admin-guide/mm/ksm.rst | 36 ++++++++++++++++++++++++++++
 fs/proc/base.c                       | 15 ++++++++++++
 include/linux/mm_types.h             |  5 ++++
 mm/ksm.c                             |  2 ++
 4 files changed, 58 insertions(+)


base-commit: 68a00424bf69036970ced7930f9e4d709b4a6423
-- 
2.25.1

