Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EED702ABE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbjEOKky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 06:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbjEOKkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 06:40:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F71A4;
        Mon, 15 May 2023 03:40:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64388cf3263so8893332b3a.3;
        Mon, 15 May 2023 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684147251; x=1686739251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/tcfcYbVhMWjGdBg+XhfuZ0JW0y/kbnZ3DVCBQLQ5Q=;
        b=HUlYK00S5a5YltYcgVoVgQn6Q7Pxu/g7SgIt5nHV8QZhdDEvAmepSjg3VfCeaBwLeO
         qAbDcaJ3D7O6MNlTMKHw86sJv9YeismagYhnJDAujYYoMMKroDbAcIYS2qoNlP5IeRfD
         TPkHzjPr5EitUv3LZ4YEAbzFDZwBmiW1+/D0oMOHgjMpqOLVfhnok7EGNyrxKAMgcR+o
         +GWzsvTqark5SeUtHoTlxP+Udoj4Ga4fth1HS45ajPmjqzFkVPho3c3+l+VQrJmz0H6R
         GB3VGc0e0O6/Lc8zK4sFZx4HqJjOlvAw7lYFo5Pb/qu/bkZB8jIjMVFJdPW2vP3JL2mR
         +v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684147251; x=1686739251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/tcfcYbVhMWjGdBg+XhfuZ0JW0y/kbnZ3DVCBQLQ5Q=;
        b=VAYTsYjNExjSiYBd1FqcHBx203TVXe3gjisA01UZKlYTIeuj0ec9eFQvfMiGW4dGMV
         kEKnmEA6Ht5bfncUw2zSry6+WMKQlmxaOwoNh80fpOjMAnfpNvk4m5BV+bPqzb4eblPU
         hIAA6e8c6eTVaOLY3BB4boMZX/gpyW6vA8nJmmRe6TaL1nq80bdX0BIIK7a0fHtpWE4O
         UGLmtb4wSflAAgpcS3Zs0FbTmY0t6yk0WLq5AS4phjpMtIRZMaF0LfV7sqaBPKa+wa79
         ZOFSHha+GzS1/TWrE9TVt3Lm54Uvo0zxdrHebj9viDOHYZ+EUwPVKW6qPkngTKyMyyr3
         w6ng==
X-Gm-Message-State: AC+VfDzvNmnx67h6Jkg+NzaPjrUhAqG4HfEwVNsQrE27hk+5FiOhfZGM
        Az9XzIrfvWYqmPp/JNz96WYNNdaf3d4=
X-Google-Smtp-Source: ACHHUZ4P9Wi/dotsyz1jBUDhTSNNjrEtslHCqt3upegW0pX//fpjehNXdEFxUZARccXiuML1eI/IEg==
X-Received: by 2002:a05:6a00:1703:b0:644:c365:50d5 with SMTP id h3-20020a056a00170300b00644c36550d5mr41213971pfc.6.1684147251296;
        Mon, 15 May 2023 03:40:51 -0700 (PDT)
Received: from rh-tp.c4p-in.ibmmobiledemo.com ([129.41.58.18])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7900e000000b006466d70a30esm11867078pfo.91.2023.05.15.03.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 03:40:50 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 0/5] ext4: misc left over folio changes
Date:   Mon, 15 May 2023 16:10:39 +0530
Message-Id: <cover.1684122756.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Hello,

Please find v2 of the left over folio conversion changes.
It would be nice if you could also review Patch-2 and Patch-4.

v1 -> v2
=========
1. Added Patch-2 which removes PAGE_SIZE assumption from mpage_submit_folio.
   (IMO, this was a missed left over from previous conversion).
2. Addressed a small review comment from Matthew in the tracepoint patch to take
   (inode, folio).
3. Added Reviewed-by from Matthew.

Testing
========
I haven't found any new failures in my fstests testing with "-g auto" with
default config.

Ritesh Harjani (IBM) (5):
  ext4: kill unused function ext4_journalled_write_inline_data
  ext4: Remove PAGE_SIZE assumption of folio from mpage_submit_folio
  ext4: Change remaining tracepoints to use folio
  ext4: Make mpage_journal_page_buffers use folio
  ext4: Make ext4_write_inline_data_end() use folio

 fs/ext4/ext4.h              | 10 ++-----
 fs/ext4/inline.c            | 27 +----------------
 fs/ext4/inode.c             | 60 ++++++++++++++++++++-----------------
 include/trace/events/ext4.h | 26 ++++++++--------
 4 files changed, 48 insertions(+), 75 deletions(-)

--
2.40.1

