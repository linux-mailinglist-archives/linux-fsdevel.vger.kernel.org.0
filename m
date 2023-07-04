Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF748747747
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 18:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjGDQyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjGDQx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:53:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6827173C;
        Tue,  4 Jul 2023 09:53:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc244d386so63778145e9.2;
        Tue, 04 Jul 2023 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688489590; x=1691081590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6X46p/v45YXoW3BdBBZYISaaAyjIN+YgHZ7H48FuHJU=;
        b=rVZrx+uc46MV8vFmTkQUHOsSfj+Ea/gfLcAoDgFVIk83t+9NVj0WJrQPHSND5i2KIe
         UPuAV15kHCCV5yqfThsBoRdBssG+oLuPAnLKdaQpX+H25oipwzrnxovRJYQQryiNL5Oc
         NE3n2ZA9YmgNbjtPEL4xCg1HNhPtxidkciM4HPrOSzPbCojM6uzZpyQo0ntt0KHOZGgi
         Qoi5hkbeNGKgcQYAc0rZD8yEEf06YlSge2XIMPQbZYgqHmzIb+91lAvA4LMDEiZendyO
         iNdqzJENofxteqIVG0vioT0+MIR6+byxXradrUiCc5E0bVeju+406nSnm62jvGUHe1fm
         IE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489590; x=1691081590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6X46p/v45YXoW3BdBBZYISaaAyjIN+YgHZ7H48FuHJU=;
        b=CdlOihSZaY79MGsy0j43LHVJeCYop6KDAeIB1E6cV6IlKvmnZm4FXx2KbUCFljz4BV
         +J46aDd8PC+f04L86pvvQGLRmcaenyiXyYeyloccfRPKFCNpumkOl9K7aMj4L24FGwHg
         rmX9nlIcU3KojXhZ/FkWXEfE+aIQpx+nhdk64yBljQUe7H3jCbvDlHGmwgz0eixKJKbC
         n87V74hb+MAd0XKaBMTdprwVuyi6VXz6txNCELKh5j0QIeCFJDFzOeZLgSDb0eRX3f2h
         hZtj3yoRFzVRRKuAZF0F0AKvDOXM9kna/SRjmHVE5E1GO7mFKvPnUTZ+JXdLzeSFIhbs
         9cHw==
X-Gm-Message-State: ABy/qLbT+/nMGQh8B7mDDxxE1TtbB5AhikVQjDkEQsK0WUUZDq23sAVC
        DryWmC7ebZOQG4gG3yRdfzlB78D7zck=
X-Google-Smtp-Source: APBJJlEYOXGRphrO4SkMWru9BIX7s+yP6/RWwOXYhBB8ipdXBjtCRmjHjaYI/qnu+WwTlQOSzPPjwQ==
X-Received: by 2002:a1c:f713:0:b0:3fb:d60f:8a8e with SMTP id v19-20020a1cf713000000b003fbd60f8a8emr6486901wmh.31.1688489589960;
        Tue, 04 Jul 2023 09:53:09 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fb225d414fsm24216421wma.21.2023.07.04.09.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:53:09 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 6.5 - part 2
Date:   Tue,  4 Jul 2023 19:53:04 +0300
Message-Id: <20230704165304.658275-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Linus,

This is a small "move code around" followup by Christian to his
work on porting overlayfs to the new mount api for 6.5.

This branch merges cleanly with master and passes the usual tests.
It has been sitting in linux-next for a few days and yesterday
it was updated with a build warning fix reported by Arnd [1].

It is not strictly necessary to have this merged for rc1, but it will
make things a bit cleaner and simpler for the next development cycle
when I hand overlayfs over to Miklos.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/CAOQ4uxj5v=zTsiXvHGD70nMcKSvTVwM2G0raCDePY64gofu+AQ@mail.gmail.com/

The following changes since commit a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451:

  Merge tag 'iomap-6.5-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2023-07-02 11:14:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.5-2

for you to fetch changes up to 7fb7998b599a2e1f3744fbd34a3e7145da841ed1:

  ovl: move all parameter handling into params.{c,h} (2023-07-03 16:08:17 +0300)

----------------------------------------------------------------
overlayfs update for 6.5 - part 2

----------------------------------------------------------------
Christian Brauner (1):
      ovl: move all parameter handling into params.{c,h}

 fs/overlayfs/overlayfs.h |  41 +---
 fs/overlayfs/params.c    | 532 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/overlayfs/params.h    |  42 ++++
 fs/overlayfs/super.c     | 530 +---------------------------------------------
 4 files changed, 581 insertions(+), 564 deletions(-)
 create mode 100644 fs/overlayfs/params.h
