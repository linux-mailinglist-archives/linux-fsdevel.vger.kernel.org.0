Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6319E6188DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 20:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKCTmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 15:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKCTmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:42:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F4D1838E
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 12:42:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so4065291wma.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRYxb4HxSe/H2S0/XF16a2dYRLnk8CKZOp+6s9XR0QM=;
        b=GSX5r9j9xjMNC05nMC/IW12yTFJEzEst+zX8OAopLc95mH5dPU6v8M2jnY7WW0oDxv
         s1J/8xY+m51ETXihc7x5ENUmqtbDi0c6epmxt63MbLmuOHZEpCkJYzrYe/M2u7W1/2T5
         omTxhrrNdQYUKUR8ilryBvEpQ7ia0+2A2yS5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRYxb4HxSe/H2S0/XF16a2dYRLnk8CKZOp+6s9XR0QM=;
        b=GNO/9+sR7qXbbRcv2bwFqfGAKzwA+8KwwE5CP6DS7oW20MVfy+lueBNm3L2Hv4nKb9
         sQ1yULJQMuqChj7x930+318Il4H35dDbrVo56PIUMpFIVROjarE9yKitfWBTGBM4y89r
         sk5LXbxBTtT+b5gqvjsVVVdhXRqGHt8/IfRu/tHryakiG9NmtN64eyWyBvyhleMFOtwd
         6vR8zLls6sn9/D9iTGjAzMcCzQDWZ3PLrcgIRSGB4FElYXr5gpJUQxUqLtTgFbeT9Mv2
         kLHAJBxIW834mUEOVhrFYiIcIah+nbRdAKixBsOddY6/BNS0eJdGEWGkI+jiEubdLp7w
         Rpiw==
X-Gm-Message-State: ACrzQf0cXwhNkFIrTP/v4L494VTQ77OYH5mHVxsb2rAzF76l6MIKGTrE
        bnpHEBaDF2+l/aATODNJmHYUNpP09+/9Cw==
X-Google-Smtp-Source: AMsMyM4UcA2jE6rW8WYRF+qK/QdO74Xo/8o916SenFeLFJqqNitgrpW4KEwMr/D+3hBp04JfYxNOCg==
X-Received: by 2002:a05:600c:1f11:b0:3cf:73f0:b753 with SMTP id bd17-20020a05600c1f1100b003cf73f0b753mr14539199wmb.100.1667504551636;
        Thu, 03 Nov 2022 12:42:31 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (87-97-117-189.pool.digikabel.hu. [87.97.117.189])
        by smtp.gmail.com with ESMTPSA id bv7-20020a0560001f0700b0023657e1b980sm1673118wrb.53.2022.11.03.12.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:42:31 -0700 (PDT)
Date:   Thu, 3 Nov 2022 20:42:29 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 6.1-rc4
Message-ID: <Y2QZpV0sTSK1UViK@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.17-rc8

Fix two rarely triggered but long-standing issues.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (2):
      fuse: fix readdir cache race
      fuse: add file_modified() to fallocate

---
 fs/fuse/file.c    |  4 ++++
 fs/fuse/readdir.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)
