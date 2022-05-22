Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9353063E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 23:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiEVVgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 17:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351690AbiEVVgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 17:36:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96AA10545
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 14:36:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ds11so12405638pjb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=ANTuiG8sH1YQNazm/U6xOM/Aboo3pAO1E7wbIbAYufU=;
        b=THHUh48oqegFjDPVCH3dWAzbCbQeKFXHTiTX1X8qk2wd2JngW/AtGneSDbkJ7mOmuZ
         sFdaUDCRnzUN+FiwoNwssTh0mzsrf71mVQ0Vojtn3ice1nIxJx0Dipbd5fWFM9c2A6ko
         ZaxstHSBpv/b/mX3hT81lZWWolmbw7zfn5gMtlMB76Rl6kEHWsAW6VVlyM8civFY+C+C
         olJPNqQpODWZn3dakL1zat/yCk/sdTsMEl90QKEwewd+CYrBbpRrdkeX4Bp79VQA3AJV
         qTXdtWifln2Bw5rBGTOKOsCBx3oH0gy32T/f4vLoQrNlBzx5JyqXOQ22W/bfw/aR4Tl7
         Q0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=ANTuiG8sH1YQNazm/U6xOM/Aboo3pAO1E7wbIbAYufU=;
        b=CiVjd6e8XkNLZS+jSqnouLSfs3JiqLpCR0jz4nFeykDf4wOJbldgMsu/thyO20ov8c
         UYfSbvtH9f2ub0Ohdhl66F1F/97Urn0E9cFX1BfXJcFgK/92f9OE7AYOeDXTSXUytYVk
         7Vf/BsowdE+Fp3991AZFsQSzF6njprloPA2fqH/1SpeX5Lo5x/yFVS2WKiCgkqzxJXFg
         YP9JoDzq8covBIqQjj+Q6mMpUFFoL+Ft99HHpgd/c3L21jswd1V9okml89SupHtsgMCr
         dOY0cfW0re/U5msDU3ixHs8e601PhoKzhMJRrDJnV6xLWKurudICkeW6ISwHF5w2MnUP
         m3uA==
X-Gm-Message-State: AOAM532QSR6Qm+BpaYf1Exc5bFXQqBBOCzCcbbKgucEx9DUk1xexeHGx
        5XveqjN5Sddi37lD/Vg2cP1eYg==
X-Google-Smtp-Source: ABdhPJxBJogRkAGha6tWbdDTAU6DVDLdsD/RSjLAPaTJq/KO4Hn2SBQrDCTx1bwZw5cxg00+sFbBcg==
X-Received: by 2002:a17:902:8d83:b0:161:f4b3:6457 with SMTP id v3-20020a1709028d8300b00161f4b36457mr12857018plo.122.1653255368154;
        Sun, 22 May 2022 14:36:08 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id mp11-20020a17090b190b00b001d96bc27a57sm5540462pjb.54.2022.05.22.14.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 14:36:07 -0700 (PDT)
Message-ID: <f9ff32f1-3573-37bd-a9ab-1b9ed6cfadd9@kernel.dk>
Date:   Sun, 22 May 2022 15:36:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Writeback fix for 5.19-rc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

A single writeback fix that didn't belong in any other branch,
correcting the number of skipped pages.

Please pull!


The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.19/writeback-2022-05-22

for you to fetch changes up to 68f4c6eba70df70a720188bce95c85570ddfcc87:

  fs-writeback: writeback_sb_inodes：Recalculate 'wrote' according skipped pages (2022-05-19 06:29:41 -0600)

----------------------------------------------------------------
for-5.19/writeback-2022-05-22

----------------------------------------------------------------
Zhihao Cheng (1):
      fs-writeback: writeback_sb_inodes：Recalculate 'wrote' according skipped pages

 fs/fs-writeback.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
Jens Axboe

