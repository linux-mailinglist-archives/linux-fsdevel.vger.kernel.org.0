Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B23649D29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 12:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiLLLIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 06:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiLLLHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:07:24 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF311C09
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 02:56:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id gh17so26930619ejb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 02:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUJ5cvuCsGK8YGIL2fUMIgBzFaSAkYgBHiJvuOvGsag=;
        b=UzwWO/goR1hVNGn165QBf2OGcAY+wwDHNMH9vgOU7ZEDy0WMopnshPMZW5BWLKcZls
         zDx5YjKL3tqHm2U0ki5mvpUZUpEmAcl5WYNKWbLJ6E41F3l5JvTq8U7Mxebo9Kg1kDMh
         mfylwJ5mKFk/DcVAgwCVMSqsJvWMH802dmTZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUJ5cvuCsGK8YGIL2fUMIgBzFaSAkYgBHiJvuOvGsag=;
        b=QGtZZWZHGF1MgaI5me3YC7OcjVk5gIaE3KIx42upTEfOo+/zqVT1BHbVp+WHVjIno+
         Sw9QjLSJWOmMUEIbsqJtfaPajq3evL3JzcHfu4dMC+qEYvT++whb+omDWjFNEqP7arUS
         RTi0oCUbqS/E3m1kDZNlc8YxPwpZOGgdWdFTeKEQPmLE7aAfysBOLlnS4tPPOVSO0iH4
         KSmFcv4sWmzKmmKOt29YdOzi15I/2fB3PSSpcN+rBBUKRT64TUK1aBF2eaLCB5H7rQmu
         dtLDW3d6l5Q6A93/gf7wSI7uBoGl7LtpwBdPw7KkCRkU+Eg6Ibo8KDSLc1zDHelFkIzM
         cqqw==
X-Gm-Message-State: ANoB5pljsJDoBFDp9RXeF9O/8klLG6+VUoOiI0/6SutXiTJq0G/wTkYC
        jpW1hGa1D62DIDt0CDK9FlMK55SSc3rbsLW1
X-Google-Smtp-Source: AA0mqf6QIcYu5BUKcyXNA3ylKVdp/HuLErE5ZfNLmUTMoY4QP0E3qyfe4lWhXF+OkPxUAAlhXbiWHQ==
X-Received: by 2002:a17:906:71c2:b0:7ba:9c18:1205 with SMTP id i2-20020a17090671c200b007ba9c181205mr9922913ejk.50.1670842574188;
        Mon, 12 Dec 2022 02:56:14 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (193-226-215-206.pool.digikabel.hu. [193.226.215.206])
        by smtp.gmail.com with ESMTPSA id k4-20020a170906970400b007aea1dc1840sm3141236ejx.111.2022.12.12.02.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 02:56:13 -0800 (PST)
Date:   Mon, 12 Dec 2022 11:56:06 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 6.2
Message-ID: <Y5cIxrmoeQSCJMlQ@miu.piliscsaba.redhat.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-6.2

 - Fix a couple of bugs found by syzbot

 - Don't ingore some open flags set by fcntl(F_SETFL)

 - Fix failure to create a hard link in certain cases

 - Use type safe helpers for some mnt_userns transformations

 - Improve performance of mount

 - Misc cleanups

Thanks,
Miklos

---
Al Viro (1):
      ovl: update ->f_iocb_flags when ovl_change_flags() modifies ->f_flags

Amir Goldstein (2):
      ovl: do not reconnect upper index records in ovl_indexdir_cleanup()
      ovl: use plain list filler in indexdir and workdir cleanup

Chen Zhongjin (1):
      ovl: fix use inode directly in rcu-walk mode

Christian Brauner (1):
      ovl: port to vfs{g,u}id_t and associated helpers

Colin Ian King (1):
      ovl: Kconfig: Fix spelling mistake "undelying" -> "underlying"

Jiangshan Yi (1):
      ovl: fix comment typos

Kees Cook (1):
      ovl: Use "buf" flexible array for memcpy() destination

Miklos Szeredi (1):
      ovl: use inode instead of dentry where possible

Stanislav Goriainov (1):
      ovl: Add comment on upperredirect reassignment

Zhang Tianci (1):
      ovl: Use ovl mounter's fsuid and fsgid in ovl_link()

---
 fs/overlayfs/Kconfig     |  2 +-
 fs/overlayfs/dir.c       | 46 +++++++++++++++++++++++++-------------
 fs/overlayfs/export.c    |  8 +++----
 fs/overlayfs/file.c      |  3 ++-
 fs/overlayfs/namei.c     | 12 +++++++---
 fs/overlayfs/overlayfs.h | 11 ++++-----
 fs/overlayfs/readdir.c   | 58 ++++++++++++++++++++++--------------------------
 fs/overlayfs/super.c     |  7 +++++-
 fs/overlayfs/util.c      | 15 ++++++++-----
 9 files changed, 93 insertions(+), 69 deletions(-)
