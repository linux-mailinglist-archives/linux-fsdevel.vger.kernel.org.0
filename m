Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C527A62EBBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 03:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbiKRCOT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 21:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKRCOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:14:17 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C68716F6;
        Thu, 17 Nov 2022 18:14:16 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jn7so1482591plb.13;
        Thu, 17 Nov 2022 18:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lmlhhz9XWW2prk4Er2Fwu9L/09w+F/AZLFvKDDdZ2xU=;
        b=BhOnf5hYASJ1k2jQ21g03u/O+C5W23GUPfIwZCBYEBwxScirM9HJ+cg9Oxn82HlX+8
         f69ADnIVv/iQqU+p96aqD6CD5SUmA8BQZMTA5W/CFDaAjSwMDRUC+XGXbcHJpK3Eez4M
         UrmsJYQsEFG8g7RaO3PcI5gpeFk8VHfNZecc8YrRtI0iBzUTf4iQsWB40D2GFnXJoaSU
         Pomp9Al/MsmlE7h8/JmAqEr7a7BLL1IwDlxioQos3OOkoB32ZqmiQDgGR4DzPrAvOkFJ
         9C9jPCw//bCFrh46PhpFvooVeNdosjFT//vFpJKzcez7Qri96ZeKHCbZOb7K3ayPT6zD
         mMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmlhhz9XWW2prk4Er2Fwu9L/09w+F/AZLFvKDDdZ2xU=;
        b=lG3jPWE8CFE07tNg76MmnDYUjDe2sBsFoDc3MgppxNOvgfuK6lPytJH2KNk1R+fZ3B
         o7FGjrXpor2Mua9R9VzVJ9/CBtxw1ly0x+9zmaWulhiQRqeyxMg8TvsgK/x0qOx5uRZT
         1g9TnaIoQuc/QWgN3PBROOqLKPfSuNtmgiPVfELH59wpPvCCHobkwB52aFOLfwqFY8YT
         k+pFlWdU2VF9dz2yyDTnUjTuI7GCHSt+rAMgiabDBWYCLKPOnKBlIxAzGCrnRnkxTQhY
         Re+j2N30Kcq0Xf2zNgyjFHd46qENuGE6Zy3Y3kSCiwP6OE4+BUKiluwoZ14WknVh3AW3
         RaQg==
X-Gm-Message-State: ANoB5plZzITOLo5FYswxNiPF+WkN8d4HDDdcr3RrEyRggHhkuHsiQQcJ
        vix8OOeCuns7lIFLVoIV8AY=
X-Google-Smtp-Source: AA0mqf4IC2hbgO2nlSc/4ATp2d0mvpUbpw/QK0PiKmXONmT9F1FejLlPYTjF7bJJsUTaRws1f3hSIw==
X-Received: by 2002:a17:90a:d50c:b0:218:722e:cac7 with SMTP id t12-20020a17090ad50c00b00218722ecac7mr5587586pju.47.1668737656225;
        Thu, 17 Nov 2022 18:14:16 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id ip13-20020a17090b314d00b00212cf2fe8c3sm10678445pjb.1.2022.11.17.18.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 18:14:15 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 0/4] Removing the try_to_release_page() wrapper
Date:   Thu, 17 Nov 2022 18:14:06 -0800
Message-Id: <20221118021410.24420-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset replaces the remaining calls of try_to_release_page() with
the folio equivalent: filemap_release_folio(). This allows us to remove
the wrapper.

The set passes fstests on ext4 and xfs.

---
v2:
  Added VM_BUG_ON_FOLIO to ext4 for catching future data corruption

Vishal Moola (Oracle) (4):
  ext4: Convert move_extent_per_page() to use folios
  khugepage: Replace try_to_release_page() with filemap_release_folio()
  memory-failure: Convert truncate_error_page() to use folio
  folio-compat: Remove try_to_release_page()

 fs/ext4/move_extent.c   | 52 ++++++++++++++++++++++++-----------------
 include/linux/pagemap.h |  1 -
 mm/folio-compat.c       |  6 -----
 mm/khugepaged.c         | 23 +++++++++---------
 mm/memory-failure.c     |  5 ++--
 5 files changed, 46 insertions(+), 41 deletions(-)

-- 
2.38.1

