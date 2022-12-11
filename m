Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A4764967B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 22:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiLKVbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 16:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKVbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 16:31:22 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC178BC99;
        Sun, 11 Dec 2022 13:31:19 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so3671253wma.1;
        Sun, 11 Dec 2022 13:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5FG9XFAhH1aAKNSCD7KXenAoQ7QCTJVpi7jZDxdnhI0=;
        b=OC9FRQ5bdKmv3sGgoo1ZJg56K0vI4WY55htBKLsFGzk9o84vSEI5/l7nQi1LQ8Y9DI
         h9uxsFWD7cqUr7Mq/8K4p+o4GN6cu7f5w2Uztm1feVVXrXD7ikwr/+KyoFvWfWaq+IPm
         VVy4rkih1SoVMvYIwF/E/ID551LMhkPf2CutaMfzrefL+sGeuU24EB2sgCU2vLzAWCyQ
         0rEHv+/E8UFMF1kbbRg976lsWYQ0fpLkADUr7jAbaZ5Nsg0Lbg4jgTnwomURdModQfpN
         oJphnSwkiX7U3EqmpQX89N65d0HJmWfU+BnjS7+yDopegOF3zkclfr+jxbYLVni8NGk3
         CFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FG9XFAhH1aAKNSCD7KXenAoQ7QCTJVpi7jZDxdnhI0=;
        b=7oxMFvtpLa1hZ6PrQ0XnLzhwnBv0Cyg+z75XJH0+ZkXduSN1bzFzAiTePxr0ruP6m3
         4MWSMZIYsQljpV90IfSi/sflzDTr8e96xJRJmuor74QMsO6EO4qEh8yqhCpbJWr8UHhq
         cWhdqiwvSoVTE9ALeBljd1VhOKLbazGBl0+sJesVw3N57ABJJn2jFY+13tgn1O4W0Z+/
         42CFKvX9TUak+rDjCbUU4QhrEKosCMgt9ZAquVH63nZJxOaKRqH1iWRATPkWuMuL7mOZ
         5xCA/Ap/V1VG015bqMcYCqWGUHH8UJnI00pwAbXfuSEoRQzqC5DAJsmUw2dh1HZlzB9h
         k6xw==
X-Gm-Message-State: ANoB5pl/1eoRF98Fvkl7jiqJO2ulE7QNpI6/EhT1OTATV1V7VnFyady3
        /FKTi7fg+jmARyp6vOomgIaFd9GkNR0=
X-Google-Smtp-Source: AA0mqf7WUdx4Cm7Ae0JDat+14OBRjlMLKUwnBQpLWULqMx/qMiOpgVxSMm05AG8y3yz4qJxmL4/HbA==
X-Received: by 2002:a05:600c:991:b0:3cf:aa48:23d4 with SMTP id w17-20020a05600c099100b003cfaa4823d4mr10965839wmp.25.1670794278133;
        Sun, 11 Dec 2022 13:31:18 -0800 (PST)
Received: from localhost.localdomain (host-95-247-100-134.retail.telecomitalia.it. [95.247.100.134])
        by smtp.gmail.com with ESMTPSA id m127-20020a1c2685000000b003d1d5a83b2esm6866350wmm.35.2022.12.11.13.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 13:31:17 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Fabio M . De Francesco" <fmdrefrancesco@gmail.com>
Subject: [PATCH 0/3] fs/ufs: replace kmap() with kmap_local_page()
Date:   Sun, 11 Dec 2022 22:31:08 +0100
Message-Id: <20221211213111.30085-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/ufs is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/ufs. kunmap_local()
requires the mapping address, so return that address from ufs_get_page()
to be used in ufs_put_page().

This series could have not been ever made because nothing prevented the
previous patch from working properly but Al Viro made a long series of
very appreciated comments about how many unnecessary and redundant lines
of code I could have removed. He could see things I was entirely unable
to notice. Furthermore, he also provided solutions and details about how
I could decompose a single patch into a small series of three
independent units.[1][2][3]

I want to thank him so much for the patience, kindness and the time he
decided to spend to provide those analysis and write three messages full
of interesting insights. I hope to have not misunderstood too many
things, however I'm pretty sure that I made many mistakes due to my
scarce knowledge of filesystem and, above all, lack of experience :-)

I decided to get rid of the previous numbers and start from scratch
(i.e., version 1) because this series has too little to share with the
design of the previous patch.[4]

[1] https://lore.kernel.org/lkml/Y4E++JERgUMoqfjG@ZenIV/
[2] https://lore.kernel.org/lkml/Y4FG0O7VWTTng5yh@ZenIV/
[3] https://lore.kernel.org/lkml/Y4ONIFJatIGsVNpf@ZenIV/
[4] https://lore.kernel.org/lkml/20221016163855.8173-1-fmdefrancesco@gmail.com/

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdrefrancesco@gmail.com>

Fabio M. De Francesco (3):
  fs/ufs: Use the offset_in_page() helper
  fs/ufs: Change the signature of ufs_get_page()
  fs/ufs: Replace kmap() with kmap_local_page()

 fs/ufs/dir.c | 140 +++++++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 67 deletions(-)

-- 
2.38.1

