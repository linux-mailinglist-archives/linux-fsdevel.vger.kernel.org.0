Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEE364E4AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 00:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLOXa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 18:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLOXav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:30:51 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2512251D
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 15:30:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gt4so773309pjb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 15:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzY+tBphGrKVYDEjcY0BJ7N2Vzc4aYAbJghO6/Dj0Ew=;
        b=ANB1oJWrSFG9Cq9YbfSu5FK3UHRQfjVBfpm97HJvWMMkD+j0DGS9O1wVzh6Wh0Oree
         b5cHhH9i4OwAu6sBo9PSt1xXeo2u+k6Y1bI5ZGY/wRvs1FrxSOpr5l0QsROv8GP7B2EI
         k1rvUb3npghaUY6Bm5GfLi+fkwQ4epLHC9n0ZnxoHSUlX5rRLitkSQm6rw6KwBiLtlIF
         QxELHPkfJi5cPuWicQPQZQnu/ERQ9ePIU/HkEQF7uWQMFgnuAAZvxh8PTcKQEdwIMVqE
         WTeGvL11yd9pI9LhfoJCltcwwosgip/fD9tE6gTqwlbUtG96BwtO2hEIZnHDwM5a5sMS
         g3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jzY+tBphGrKVYDEjcY0BJ7N2Vzc4aYAbJghO6/Dj0Ew=;
        b=kuP2VjS9h+pUrO19qtvb1koRbT/wqWWq8Z6QovjKzGJxW04StIvzbxC82Qy0vrXNaP
         Dy7K3TsaQ+OT3ujdHYtiEJ2V7VFT/+a6/YoWkMbqTUtIHQaZvVFFFNAH/9ENUmLVESvb
         nexc98UAWimfaj34AU2WF892jSrkxSdQYSUb+IczWkD/6Lodsn4LHVWxyviz2sLBCFBm
         /fN/5dp3k5BbNwTFdfKInzI2FJt4Od2wdpoW3C+G8UpbJ4Z+ec3JiFuySFLHyQ5HGM0g
         O2tfDNQ9bNPmwmSVsKu+NV8J55uZjgXjSIznAfp49zUyE4t9SRnPKPpho7erQLb0UbRp
         ccgQ==
X-Gm-Message-State: ANoB5pnVli16EjbZkc2vex2vuGlJ8riZxWvwMyTL7nh/YTUdALfecE3L
        K3s40oQN2SaEOTwevsimN7Ma2DxcNAAVTxIlmX4=
X-Google-Smtp-Source: AA0mqf5+g5ETJavbVdEUvFCDMg7PM4nyywgtYCuPOSuKBn6aN62gyRRBzy0pcPpz0/UvGVi6yVxVag==
X-Received: by 2002:a17:90b:1914:b0:219:3e05:64b7 with SMTP id mp20-20020a17090b191400b002193e0564b7mr6888956pjb.0.1671147048529;
        Thu, 15 Dec 2022 15:30:48 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090abf8500b002192db1f8e8sm178575pjs.23.2022.12.15.15.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 15:30:47 -0800 (PST)
Message-ID: <7d6731de-b583-9552-24e3-601fbdae6a1b@kernel.dk>
Date:   Thu, 15 Dec 2022 16:30:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Writeback fixes for 6.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Let's try this again, now correctly labeled for 6.2-rc1 and with an
improved commit message for Jan's patch.

Here are a few writeback fixes that should go into this release, in
particular:

- Sanity check adding freed inodes to lists (Jan)

- Removal of an old unused define (Miaohe)

Please pull!


The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.2/writeback-2022-12-12

for you to fetch changes up to 23e188a16423a6e65290abf39dd427ff047e6843:

  writeback: remove obsolete macro EXPIRE_DIRTY_ATIME (2022-12-12 13:08:42 -0700)

----------------------------------------------------------------
for-6.2/writeback-2022-12-12

----------------------------------------------------------------
Jan Kara (1):
      writeback: Add asserts for adding freed inode to lists

Miaohe Lin (1):
      writeback: remove obsolete macro EXPIRE_DIRTY_ATIME

 fs/fs-writeback.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
Jens Axboe

