Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCD46EFF3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 04:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242868AbjD0CNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 22:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242874AbjD0CMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:12:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18EB44A5;
        Wed, 26 Apr 2023 19:11:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4eed764a10cso8479270e87.0;
        Wed, 26 Apr 2023 19:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682561516; x=1685153516;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hum//s9wp/d/vZQZ3TUzzOd236Vap8ceFppkKBF0ayg=;
        b=sRqdWmXFEZvDdeSxhb3VktQ169LxDzStTGy68Tl/0cqDrzgrP+y9bWUOASeUcFqbDZ
         zmUTOYvyxB1oUxg5lVjRnneIQfmspJt+Z4ponTA723KhiyOTe1BXb8Et1xeDrqRhCyx0
         D3gLhLsehqvgYtVNgHZhSt5e2ZDoO2Oy6wNb6KIkCH5CmqW0pf7gFvGfxHWN/8oJJR2t
         e7UG6BbVPPZs/AAq1AgbsneGlZ9+q6sXe4TlSoAdZGqyJMAJOo384BrfGAuiatNMbbmA
         SQ1CrCMzUGHQ+tLUsqWtIJghUOnXaYuOJDW3X108PoBZiI/u4ZYvrovIa0VH/D7G+hNd
         tSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682561516; x=1685153516;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hum//s9wp/d/vZQZ3TUzzOd236Vap8ceFppkKBF0ayg=;
        b=hI4OaomhMQhSMwd0t7lGZPAGMTZRmI8BCDmjFsF0FQa8P9xB6ejjbls0CRnQCsVsKQ
         8REpvFtDtQGcl9XXXt/HuIoE8DDu5k0M8FPUEEXaYWiRfQAmKNyfAFlJeTYthb6B+RfU
         J7CMLz5IQanWXIUbvh/q91KiRobnS3LTVdeq7u/EHZjanlKz6wrFIuh3FsWjH1pPpQOM
         XOOqC324qbVygMel0xGlpvgV06Tfi9eWtkF+YTGNneD7/ZUcqxXEHqU5JHZhwN35DBIt
         or3y8v7njAFZN692w91NkjW7SV0u7BjbPx2rw3e5Bug0RO8ZixlR2T++mOSNteQR4bN3
         FE+w==
X-Gm-Message-State: AC+VfDyGz02ZrS9pUuvX0Yii0rLhqqKox4Sw1gUY0556vBxj7jKjYlXa
        t71Ss6a07DtnNz5yLgvLeLyTj4BNSmSIb01CfGA=
X-Google-Smtp-Source: ACHHUZ47hunrOnjeuejaLhVQHd5z4Pf39tsm1w5eLJAk0uh2vZdVAqIbPHxk7NXjYwVMdaYYQCUZy6szRmWt5tsvbzE=
X-Received: by 2002:a19:f617:0:b0:4de:6973:82aa with SMTP id
 x23-20020a19f617000000b004de697382aamr13074lfe.68.1682561515881; Wed, 26 Apr
 2023 19:11:55 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 26 Apr 2023 21:11:44 -0500
Message-ID: <CAH2r5mtsYPer65Fjm7BFhsjKt-g4XMCtk8siYAZxXg4qpyRKXw@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please pull the following changes since commit
457391b0380335d5e9a5babdec90ac53928b23b4:

  Linux 6.3 (2023-04-23 12:02:52 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.4-rc-ksmbd-server-fixes

for you to fetch changes up to 74d7970febf7e9005375aeda0df821d2edffc9f7:

  ksmbd: fix racy issue from using ->d_parent and ->d_name (2023-04-24
00:09:20 -0500)

----------------------------------------------------------------
- three SMB3.1.1 negotiate context fixes and cleanup
- new lock_rename_child VFS helper
- ksmbd fix to avoid unlink race and to use the new VFS helper to
avoid rename race
----------------------------------------------------------------
Al Viro (1):
      fs: introduce lock_rename_child() helper

David Disseldorp (3):
      ksmbd: set NegotiateContextCount once instead of every inc
      ksmbd: avoid duplicate negotiate ctx offset increments
      ksmbd: remove unused compression negotiate ctx packing

Namjae Jeon (2):
      ksmbd: remove internal.h include
      ksmbd: fix racy issue from using ->d_parent and ->d_name

Steve French (1):
      Merge tag 'pull-lock_rename_child' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs into
ksmbd-for-next

 fs/internal.h         |   2 -
 fs/ksmbd/smb2pdu.c    | 203 ++++++++++++--------------------------------------
 fs/ksmbd/vfs.c        | 437
++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------
 fs/ksmbd/vfs.h        |  19 ++---
 fs/ksmbd/vfs_cache.c  |   5 +-
 fs/namei.c            | 125 +++++++++++++++++++++++++------
 include/linux/namei.h |   9 +++
 7 files changed, 357 insertions(+), 443 deletions(-)

-- 
Thanks,

Steve
