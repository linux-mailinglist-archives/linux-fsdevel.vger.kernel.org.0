Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDA85FE5B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 00:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiJMW6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 18:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiJMW57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:57:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C00F164BD9;
        Thu, 13 Oct 2022 15:57:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso6251395pjf.2;
        Thu, 13 Oct 2022 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=im+EFOaVf40VxAsoOXFLr7F3yCNaLvihTEshtimgLMg=;
        b=K8T6XcUKsWGlWxfEwBBRyJVoiQrRv4ZdmvW2rGVCVwv56rTj277O3thfomZeAxxoz7
         utNmPVwtcI3/BKdWDz1U+3XxmHL04do/Rlfmb6R9q3isLPcwu9Mj5+3fH8+CdhzyjKtF
         YVxVsvBVlvgbmyW/a8rVB3MI+Teb7NkEdp9GJ7q3PSpJgcGh4JeU/Yt8lE1nVWIS1clr
         irH7XLPa+PnQAfHR+Zttj2cZnIADb22qpvNbRiVmOklO750gtgJhrinWY7R4HdrSslfV
         D2zI8Gumk8nb5dxTv+b4H3Du6+ZDcuR8FfnBnlq2rXhTI4+U5b5xWSLOa4xWJfTrRswL
         yamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=im+EFOaVf40VxAsoOXFLr7F3yCNaLvihTEshtimgLMg=;
        b=BYIFV1oFG8HhkbMBfO6P+IqjVekAnbBX+zEGw4FEqDTwCp85g8+JODIbjwO1pBoe/w
         5xFnAi9eOWPbER1S8LnoWhG3BfOCF5yjfyZNtFtEQ3y0XGEKpo7N4Tx5bOf5WfVcXgfP
         wL45k7zorBz78w558ZTxwpW5j9sigwrmdCzEW3QW5gsAJyEspzpNroUqIpwsc2T6IDya
         w3zLGgUg23AHirZ5BPMOIe0QrDr2ln2MaC2Pl85Kkzi+XFapj9BfjlNJvqhKPQ1iEwmA
         r7vjaMO0OX+fuQnTbxJMOyWI/xqiC44j2cHAz0Dtqp6GgCmNwgEoeP/9P/vRWKjnnUuq
         6jvQ==
X-Gm-Message-State: ACrzQf2uvBRFJMaJh3ve1R5RXZnMnYwESL3y2IrvQB3YaKbx6yD0CCYE
        Bq+Y6psk6PvXTI2ENlQCFjkdTHFZT0unOA==
X-Google-Smtp-Source: AMsMyM6XgYfLVibNZDRsU+a+L3JHrLUNk6SCmNHRw98/nhGdS9JHOVGEBvaJNCrJAMZpZs16bxW5/Q==
X-Received: by 2002:a17:902:dad2:b0:179:ee21:22a8 with SMTP id q18-20020a170902dad200b00179ee2122a8mr2022153plx.70.1665701848063;
        Thu, 13 Oct 2022 15:57:28 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id lx4-20020a17090b4b0400b001fde655225fsm7480269pjb.2.2022.10.13.15.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:57:26 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 0/2] Rework find_get_entries() and find_lock_entries()
Date:   Thu, 13 Oct 2022 15:57:06 -0700
Message-Id: <20221013225708.1879-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Originally the callers of find_get_entries() and find_lock_entries()
were keeping track of the start index themselves as
they traverse the search range.

This resulted in hacky code such as in shmem_undo_range():

			index = folio->index + folio_nr_pages(folio) - 1;

where the - 1 is only present to stay in the right spot after
incrementing index later. This sort of calculation was also being done
on every folio despite not even using index later within that function.

These patches change find_get_entries() and find_lock_entries() to calculate
the new index instead of leaving it to the callers so we can avoid all
these complications.

---
v2:
  Fixed an issue when handling shadow entries
  Dropped patches removing the indices array; it is required for value
entries

Vishal Moola (Oracle) (2):
  filemap: find_lock_entries() now updates start offset
  filemap: find_get_entries() now updates start offset

 mm/filemap.c  | 32 +++++++++++++++++++++++++-------
 mm/internal.h |  4 ++--
 mm/shmem.c    | 19 ++++++-------------
 mm/truncate.c | 30 ++++++++++--------------------
 4 files changed, 43 insertions(+), 42 deletions(-)

-- 
2.36.1

