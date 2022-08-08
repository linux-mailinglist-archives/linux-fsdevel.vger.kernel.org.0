Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C612C58C869
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 14:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbiHHMfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 08:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiHHMfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:35:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5B41156
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Aug 2022 05:35:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso5084013wmc.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Aug 2022 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ES8OBBjivyd4YwLWvC24/nTpfKctkJfcHXHy4gAwKz4=;
        b=azhTbFjAOaDdLUunh9ud/ShoY0nESsBFNiSkF1V6CD2vQN2a0prBlOaAgu+OwP+spT
         nEf+NEbCzMoi9VLg+xTHKiKKy6it+BDqsHkM6C7I9VlVD9gkjvx/kLOfbupgHjKMIwHZ
         L7EIZleuptwFPb5u4mgu4DL5lLAyrmnB4MHIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ES8OBBjivyd4YwLWvC24/nTpfKctkJfcHXHy4gAwKz4=;
        b=Ffd4+1umEmkzM569eUmlyZXU4lR6bfEfE7l7jpnt6PFXoH7gd7Qx2sQvSd9yOM5Zcc
         wwQ4vwWHZ+rDk3+IE09IC21TG6YyckKY6M/OTv4fGFADqJNXoyZrBge0UZvyTWTVrS14
         KNRaxd+vjxMlryPeF6EO4cB2MTeztW91ycmrbKcL2Au1nIdcdGf0JA/G6u9HZ94Ry9tG
         Ad1ByloOkvDtI1GaUM+W0W8MMuKgSL1/ZsscaxtXdQhoUTOUpDFNZgD300u50xHFmy7/
         BSpwPbf/B+voZwrbQsi7yz/age95R/Ja80+HPTc+gR4hcyZ846Z4OC8Ruo9qCMtXQKqP
         VH2w==
X-Gm-Message-State: ACgBeo0Mo8q96PM6QM/x6V9j7BNv98dqpK/gwocH4pXv21yk+nzyEoWX
        8rinRjH1mIKauRinhfgV6CvDPw==
X-Google-Smtp-Source: AA6agR4aB+rHDSxtj9RQJWsUQNP+h1Gj3kh3C5OYh5wbKdNrkj+EB+S0KQNintPSWYYszy/wvmIM/Q==
X-Received: by 2002:a05:600c:4f95:b0:3a3:4612:6884 with SMTP id n21-20020a05600c4f9500b003a346126884mr17582239wmq.39.1659962139125;
        Mon, 08 Aug 2022 05:35:39 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (87-97-117-187.pool.digikabel.hu. [87.97.117.187])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b003a2d47d3051sm15192404wmr.41.2022.08.08.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:35:33 -0700 (PDT)
Date:   Mon, 8 Aug 2022 14:35:28 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 6.0
Message-ID: <YvEDEKQSOaDaFiWb@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.0

- Fix an issue with reusing the bdi in case of block based filesystems

- Allow root (in init namespace) to access fuse filesystems in user
  namespaces if expicitly enabled with a module param

- Misc fixes

Thanks,
Miklos

---
Daniil Lunev (2):
      vfs: function to prevent re-use of block-device-based superblocks
      fuse: retire block-device-based superblock on force unmount

Dave Marchevsky (1):
      fuse: Add module param for CAP_SYS_ADMIN access bypassing allow_other

Deming Wang (2):
      virtiofs: delete unused parameter for virtio_fs_cleanup_vqs
      virtio_fs: Modify format for virtio_fs_direct_access

Jeffle Xu (1):
      fuse: avoid unnecessary spinlock bump

Miklos Szeredi (4):
      fuse: write inode in fuse_release()
      fuse: fix deadlock between atomic O_TRUNC and page invalidation
      fuse: limit nsec
      fuse: ioctl: translate ENOSYS

Xie Yongji (1):
      fuse: Remove the control interface for virtio-fs

---
 Documentation/filesystems/fuse.rst | 29 +++++++++++++++++++++++-----
 fs/fuse/control.c                  |  4 ++--
 fs/fuse/dax.c                      |  2 +-
 fs/fuse/dir.c                      | 16 +++++++++++++++-
 fs/fuse/file.c                     | 39 +++++++++++++++++++++++++-------------
 fs/fuse/inode.c                    | 16 ++++++++++++++--
 fs/fuse/ioctl.c                    | 15 +++++++++++++--
 fs/fuse/virtio_fs.c                |  9 ++++-----
 fs/super.c                         | 33 ++++++++++++++++++++++++++++++--
 include/linux/fs.h                 |  2 ++
 10 files changed, 132 insertions(+), 33 deletions(-)
