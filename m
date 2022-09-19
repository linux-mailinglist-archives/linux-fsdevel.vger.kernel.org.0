Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247F55BD391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiISRYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 13:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiISRYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:24:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F374D12741;
        Mon, 19 Sep 2022 10:24:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d24so5359192pls.4;
        Mon, 19 Sep 2022 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yLXbhdZTFJDz1Eruum+B2eKRMi+oFeTFSm6260p2MLc=;
        b=CLcyONO1tRPGjoZAaIYtpv+BQUg6p73mrNktcLcwmrzTHqJzD2K7NR1GfWPSCBGPxE
         Yu2F92jKgBwkknxARDrGTifPH6MQk386kI0Sw7CZHJdP07ZR75qOh2W14DeRRgakdUNR
         nF3ibbpOsfMGK52NKZ0rwKUS2aAELJihMdlQ89i1XsXj7HqtU5/QYt5ETDqhUqRWVbFq
         UaDax9f6skaAn+5zG+0Tcq/K/IbZ5LemJiiSqoQxvnP9sAZ8NoZ41jC8Aw1ldsY98lkA
         Y2sEvfDJAtYboaLm00hKcoCpOi7+rvCaHRpeZmD820MlkgG1eYb5KrMTIbFAU5Rw8Xk2
         /1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yLXbhdZTFJDz1Eruum+B2eKRMi+oFeTFSm6260p2MLc=;
        b=eSrt3RXlvXNIjZM/hvTHYdeDE9nYW8Y7OH4NscBZ8wqj9Y6/Bc7PwCsvxPXfMIZb+u
         huwarC4UJ/4ghjHLUChHwkedTbAEw3hjVubYmY/zjmUl6WHf4+5tMqzLEdR50OLXsMpn
         RWbJER7e00EROZiDwu3pNgG/a5QcM6JHoVEY+2siIt2GaMwSL2Q3ajKyyrMMA46zkOkO
         JO0esQaObPbIoOyr0lfL3+fMir7Ul6slubexQAI8T0RZY+RNb4uhwhAGQqRAqqduJNFo
         cTcjB1G3O9KX6Eq7ixyWLfqY207MXYVDTZv+3vU9XksvhHPdJXSEM4k1vdLTyD6qJop5
         DR6A==
X-Gm-Message-State: ACrzQf0+03JA2krE/QWOechyfJyqEfrJGeUMK60eKG6y9cp4bdqKeb0o
        SQG/wxqk7xhd8EaHGDLwgmuqMIjHXdQ=
X-Google-Smtp-Source: AMsMyM6VM/BivqDfuJDvVl6ZNbzXY/5NA1f7mD4YYRuIqm7xUhTzEi114h9ynNOaChL++gsvhYqEiw==
X-Received: by 2002:a17:902:e94f:b0:16d:847b:3343 with SMTP id b15-20020a170902e94f00b0016d847b3343mr774637pll.103.1663608290154;
        Mon, 19 Sep 2022 10:24:50 -0700 (PDT)
Received: from localhost.localdomain (KD027092233113.ppp-bb.dion.ne.jp. [27.92.233.113])
        by smtp.gmail.com with ESMTPSA id h7-20020aa796c7000000b0053f2505318asm21226480pfq.142.2022.09.19.10.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:24:49 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net, david@redhat.com,
        osalvador@suse.de, shuah@kernel.org,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        akpm@linux-foundation.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 0/3] fix error when writing negative value to simple attribute files
Date:   Tue, 20 Sep 2022 02:24:15 +0900
Message-Id: <20220919172418.45257-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The simple attribute files do not accept a negative value since the
commit 488dac0c9237 ("libfs: fix error cast of negative value in
simple_attr_write()"), but some attribute files want to accept
a negative value.

Akinobu Mita (3):
  libfs: add DEFINE_SIMPLE_ATTRIBUTE_SIGNED for signed value
  lib/notifier-error-inject: fix error when writing -errno to debugfs
    file
  debugfs: fix error when writing negative value to atomic_t debugfs
    file

 .../fault-injection/fault-injection.rst       | 10 +++----
 fs/debugfs/file.c                             | 28 +++++++++++++++----
 fs/libfs.c                                    | 22 +++++++++++++--
 include/linux/debugfs.h                       | 19 +++++++++++--
 include/linux/fs.h                            | 12 ++++++--
 lib/notifier-error-inject.c                   |  2 +-
 6 files changed, 73 insertions(+), 20 deletions(-)

-- 
2.34.1

