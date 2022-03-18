Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715F54DE3D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 22:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbiCRWAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 18:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbiCRWAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:00:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEB2FD6EA
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 14:59:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p17so8105616plo.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=eS/kbomdd3FHQNxJRBFlfO3AesqzVfWuApTQZGEYdDE=;
        b=rCNGvuQzUwwvwYrIGN0z8p3Buw6SLSonhM0QKzVC9MWJm7rfqtXni9UQ6provnrAFW
         tsdfkXiud9J4WmrFXQZnEp6apAiZH1I9n3BzzMS34X6v04wP81ayIRFQUpi8VeSyxJMy
         pqT6ZE7qNPIdCizQTxBtowCnUDEiJg9NNX2ULSJxjv2HVkJdVuR8T0zmeXck6vktGCEt
         5Gy1klRB5ehF8UZu54s51Z5A0BIPdDvn82gt6Fx3uQt4Rp+MiEq1xLf4xZ1WmWy66d8H
         hzd10jPeV6h5X+aCpLvOt1tuOtL1wm6Q9sglWjIDXHxul5BfTX7woynuFHWqYe0QhZDM
         SYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=eS/kbomdd3FHQNxJRBFlfO3AesqzVfWuApTQZGEYdDE=;
        b=4p7qsl0utJo7lv/rS+VrCV6VkfefDAIAt1LarK3k+hve5SpSIkf+JMDI38yWfLAXIe
         MuvwQMRzIKS8W8wPHUsNSJEJY39e7Px7TeSCeYucNK3ZEit2SlUDyekvISX5RMm+L+vU
         N5hwLYt8kQHBiHoE+LloG8k+dI2pJCuRO4wRNybin+lMeW6SqHKxycsU4+m6jPOlqnuQ
         Yb5MdNUNakysFPr8ufO+xvuz1+FYIC8IHyWHfjQUBDaJ7T1H1+QuAD19wegtsvBLVRK7
         eGu/60XisDld80bpoyOZM+cD9iboDQxoBHYYQN9H07Lc4bf8E8/nMuzbW8E+7aePCmAt
         oOzw==
X-Gm-Message-State: AOAM530Xsck+05ON9txOVjNWozCrMUt0cmBGCSKkvkZODcq0mT8Xpk7X
        2RGY5A25oFW72crv1BKuVkplBw==
X-Google-Smtp-Source: ABdhPJzsTiFamjP8XgLGt11h2jWXH3H9KCs31R9zz8GCmFw/Z/9PtG357vPuJhGp4zEoTiMfTPdp6Q==
X-Received: by 2002:a17:90a:aa84:b0:1c5:f4e3:c69d with SMTP id l4-20020a17090aaa8400b001c5f4e3c69dmr23956079pjq.169.1647640762825;
        Fri, 18 Mar 2022 14:59:22 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k14-20020a056a00134e00b004f83f05608esm10846735pfu.31.2022.03.18.14.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 14:59:22 -0700 (PDT)
Message-ID: <1fbbd612-79bd-8a7b-8021-b8d46c3b8ac7@kernel.dk>
Date:   Fri, 18 Mar 2022 15:59:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring statx fix for 5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On top of the main io_uring branch, this pull request is for ensuring
that the filename component of statx is stable after submit. That
requires a few VFS related changes.

Please pull!


The following changes since commit adc8682ec69012b68d5ab7123e246d2ad9a6f94b:

  io_uring: Add support for napi_busy_poll (2022-03-10 09:18:30 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.18/io_uring-statx-2022-03-18

for you to fetch changes up to 1b6fe6e0dfecf8c82a64fb87148ad9333fa2f62e:

  io-uring: Make statx API stable (2022-03-10 09:33:55 -0700)

----------------------------------------------------------------
for-5.18/io_uring-statx-2022-03-18

----------------------------------------------------------------
Stefan Roesch (1):
      io-uring: Make statx API stable

 fs/internal.h |  4 +++-
 fs/io_uring.c | 22 ++++++++++++++++++++--
 fs/stat.c     | 49 +++++++++++++++++++++++++++++++++++--------------
 3 files changed, 58 insertions(+), 17 deletions(-)

-- 
Jens Axboe

