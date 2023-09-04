Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A916D791DB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 21:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjIDTfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 15:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjIDTfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:35:39 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E3710F8
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 12:35:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcfdadd149so29777371fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693856126; x=1694460926; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmVJg26kQVI7rcVMBxLxYyL4HofNave2y6ZRpu/Wk/k=;
        b=pp6PSdXvlTrqEaHIZBeisNGocQNFbQXPHYz33X8CtIpp1idHl4tvBKB1XXA8bzwB4x
         /Ss8EiMwgb7wC04tZ0copPyGZod/srVvjThBNI+oI5+wCO+s0xOaRrqpU7GUZuO7G9jJ
         HZlFxBzW7WQ9Elpkh7qu74C34XCgSEoTfEo1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693856126; x=1694460926;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmVJg26kQVI7rcVMBxLxYyL4HofNave2y6ZRpu/Wk/k=;
        b=FBX1hfzE3plzxjx42eUtLElg7zDaVMtG6OnrLkp/P0MeiLSwa8eWvyqaaQAOS5XAZO
         LfOcbzyjkfEusY08w8oo57/Z7nmKFjYwNtt6/wcvmnbN3r0foYhCj2LYihf6hfJhLKuY
         GYtwb4xcuvaZr2Gvp18qtT5bi4kKpMEoEcX84Riot5AKk54CikYhl7habXE4OF5C2VPE
         0sd0+o+bSlpGdfEKHTFrxWWNryz2IX9MkztoiWyp6U5OB3xhS14CE8zM8x9lps0gI9Jt
         ai1h3qHdwVyC/m25drqRyBIP6V1GDd5DBGaPShGD0D8ppctGJOjMhnJw8WuZaNQj7kES
         2hRw==
X-Gm-Message-State: AOJu0YztHZCeIDwPkJ/JmRaNj2YFnLLjtax9rl+qeiC4nQSTxi6wSAOb
        IqyPMkVdmytScFKWg2VPJXEGV4ZPMVEwGbdF3v4=
X-Google-Smtp-Source: AGHT+IG5KWkuLC0OwiTx1g9mkMv7tJVha96Z+8O2jXCH+u2eaDYmJzGbg7PaNW6Pw2jB7ZxsbpDgmg==
X-Received: by 2002:a05:6512:b9a:b0:500:b678:5836 with SMTP id b26-20020a0565120b9a00b00500b6785836mr8452417lfv.67.1693856126098;
        Mon, 04 Sep 2023 12:35:26 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-54-29.pool.digikabel.hu. [176.241.54.29])
        by smtp.gmail.com with ESMTPSA id qw17-20020a170906fcb100b0099d798a6bb5sm6605068ejb.67.2023.09.04.12.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 12:35:25 -0700 (PDT)
Date:   Mon, 4 Sep 2023 21:35:19 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 6.6
Message-ID: <ZPYxd0g9S4og17QN@maszat.piliscsaba.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.6

- Revert non-waiting FLUSH due to a regression

- Fix a lookup counter leak in readdirplus

- Add an option to allow shared mmaps in no-cache mode

- Add btime support and statx intrastructure to the protocol

- Invalidate positive/negative dentry on failed create/delete


Thanks,
Miklos

---
Bernd Schubert (1):
      fuse: conditionally fill kstat in fuse_do_statx()

Hao Xu (3):
      fuse: invalidate page cache pages before direct write
      fuse: add a new fuse init flag to relax restrictions in no cache mode
      fuse: write back dirty pages before direct write in direct_io_relax mode

Jiachen Zhang (1):
      fuse: invalidate dentry on EEXIST creates or ENOENT deletes

Miklos Szeredi (6):
      Revert "fuse: in fuse_flush only wait if someone wants the return code"
      fuse: handle empty request_mask in statx
      fuse: add STATX request
      fuse: add ATTR_TIMEOUT macro
      fuse: implement statx
      fuse: cache btime

ruanmeisi (1):
      fuse: nlookup missing decrement in fuse_direntplus_link

---
 fs/fuse/dir.c             | 159 +++++++++++++++++++++++++++++++++++++---------
 fs/fuse/file.c            | 115 ++++++++++++++-------------------
 fs/fuse/fuse_i.h          |  18 +++++-
 fs/fuse/inode.c           |  34 ++++++++--
 fs/fuse/readdir.c         |  16 +++--
 include/uapi/linux/fuse.h |  60 ++++++++++++++++-
 6 files changed, 296 insertions(+), 106 deletions(-)
