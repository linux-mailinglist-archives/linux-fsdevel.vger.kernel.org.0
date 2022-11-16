Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A24C62B10E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 03:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiKPCKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 21:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKPCKQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:10:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FCC317DF;
        Tue, 15 Nov 2022 18:10:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so979735pjd.4;
        Tue, 15 Nov 2022 18:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xgVYad0b3VkkkVGbrLBOkGV7CIzlD/ERh5I/AWp2m3k=;
        b=hIqoW9RGKL14ijfujAHMoLC9VF7HPT10Y9eBT5xHlV48w7ZOwKXLbOUgUTQKaWOfWK
         IVuVj7zO+xNHtyhBogg1gvHnG12lLJnJIQHYEcLMUyXE/KHAYpfxtEez0p7vF/7Vwd5C
         cfwrbbcHXnK4ibVa2hHUiZkDQ0i15H+uXvB9f7uChacl0Ozzs+06/AmrNMfCrUroYKg8
         GU11/VDR11N9DHrW//WX++Euy0Bj+ikJsWL+d/X7kym0bXpMLP+JWTYs3wp8nXHid1w4
         rIzhVUgkjUCj7QmJnBeGTuptJ61eTVluqQPtZOiT9URJSuugfHmNB9+/KFoPITK6y5ts
         4ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgVYad0b3VkkkVGbrLBOkGV7CIzlD/ERh5I/AWp2m3k=;
        b=wXfueCjZyR71YJ6+eDm1GzfGeja86RH2eqXAmFeUd6p7l7lvp29OeMFwakVNguNcTS
         81RjtgSXGmUAyooQfiGUWkY6dREBucfa8y/SHvBIfWs/phMeUwe6muREVaYNs7TsaWEQ
         NbYg9vVNV/oCVIzUdvaKBqQHhCrm9OWo1JF5UhQ+TdP4Z/eClgPs49t/mcWKc3aiYpZZ
         qeYtE/2PwmUxVlDJvyaQOEw169KS+JsA5QVWkDhy3kVvGsAuFyCjThcppFqF8WL17/bV
         w7qTAq9zV09siCaeXEFbMfxF0UCw6srwmUZOfKvrakztJztT6Epxp0YS8uySDus8+zr9
         QeGQ==
X-Gm-Message-State: ANoB5pnMUUp/e7mJEuVCF9ofgAgtQZnDC99JhirU8DTomlmAnO9fLitT
        HHipBF+3pHV/Wi1vFdWPHGuI0DQA9y6lgg==
X-Google-Smtp-Source: AA0mqf7hhrGeJDOQZv4slw4VF6ULgR68eucYrrcqR7p7UXFCCoJjKmQKV0PoeKCvprt44ASEOJIivA==
X-Received: by 2002:a17:90a:7804:b0:211:2d90:321 with SMTP id w4-20020a17090a780400b002112d900321mr1352107pjk.84.1668564615228;
        Tue, 15 Nov 2022 18:10:15 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id e18-20020a17090301d200b0018691ce1696sm10782926plh.131.2022.11.15.18.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:10:14 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/4] Removing the try_to_release_page() wrapper
Date:   Tue, 15 Nov 2022 18:10:07 -0800
Message-Id: <20221116021011.54164-1-vishal.moola@gmail.com>
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

Vishal Moola (Oracle) (4):
  ext4: Convert move_extent_per_page() to use folios
  khugepage: Replace try_to_release_page() with filemap_release_folio()
  memory-failure: Convert truncate_error_page() to use folio
  folio-compat: Remove try_to_release_page()

 fs/ext4/move_extent.c   | 47 +++++++++++++++++++++++------------------
 include/linux/pagemap.h |  1 -
 mm/folio-compat.c       |  6 ------
 mm/khugepaged.c         | 23 ++++++++++----------
 mm/memory-failure.c     |  5 +++--
 5 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.38.1

