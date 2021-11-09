Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429AE44AA20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 10:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbhKIJK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 04:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbhKIJK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:10:58 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A60C061766
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 01:08:12 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v11so71466757edc.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Nov 2021 01:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VCMCayoiw6jiN14Vy0tGeBad8uf3NfKNTuH/91IaUr0=;
        b=aYVR3ufOsfMnHBKR9k4Bz0hUl0Kwq/e26/d6he0GM1iUrLEzS3CI5K4ItPWyUJQodh
         An6ypM1RoUHf7tu6yyKULI98UJUbSfA4NEBEXGMd5ckR8Cioz2N2Z5C0tOTJTh2OfW0z
         VBS3nFtzRfEPINJeKOGESEauvQ0NYW1XGXC/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VCMCayoiw6jiN14Vy0tGeBad8uf3NfKNTuH/91IaUr0=;
        b=WnSLqcPyrQPS6mOOywu54ctT/3uSM9T5ZGYjRnU/5j4XCQoVDO3zqTzOcsKCxYnXpc
         7SDky1U4v3yZiZ/wMTOq9m6VRn7Tvo91DrnK3Vc0GnAA5OaqCGElF+T0jM+fRg9l8Q0L
         XD2C3kAupQ6szor/o4iasoW7+1zck6RiVylVbPR3N+YgQwzck1lUX1FmITZkZc/xyjfc
         dKskCr4pBIHWbgMVIGOHgWj0IK9tyzwP0o0n41daby/BHItIaiydvZd///51zOlfpi28
         baM0npAp4Y8A8nJTmGLusPIbmN2wvgKynVj/C+EfmGKexICHYybfgp2d4TMkuQlWl8Ge
         Z/Sg==
X-Gm-Message-State: AOAM531xwc30LCVZ4JiZbp/ZHEbDExMOqfR/S56JwbgUYqE400invWNS
        v8+FpwMexzq399EzsEonXg7lLg==
X-Google-Smtp-Source: ABdhPJz9XrzSOmC4qjtJNbN2RuGiDKIgMwsJ3jk+9wtl12QNXF3iWJ3Zor39pSp4HstnYT3SrZD5wg==
X-Received: by 2002:a17:906:6a0f:: with SMTP id qw15mr7382844ejc.463.1636448890742;
        Tue, 09 Nov 2021 01:08:10 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.broadband.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id nd36sm9292965ejc.17.2021.11.09.01.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 01:08:10 -0800 (PST)
Date:   Tue, 9 Nov 2021 10:08:08 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 5.16
Message-ID: <YYo6eHUbXJXQkogn@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.16

 - Fix a regression introduced in the last cycle.

 - Fix a use-after-free in the AIO path.

 - Fix a bogus warning reported by syzbot.


Thanks,
Miklos

---
Miklos Szeredi (2):
      ovl: fix warning in ovl_create_real()
      ovl: fix filattr copy-up failure

yangerkun (1):
      ovl: fix use after free in struct ovl_aio_req

---
 fs/overlayfs/copy_up.c   | 23 ++++++++++++++++++-----
 fs/overlayfs/dir.c       |  3 +--
 fs/overlayfs/file.c      | 16 ++++++++++++++--
 fs/overlayfs/inode.c     |  5 ++++-
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/super.c     | 12 ++++++++----
 6 files changed, 46 insertions(+), 14 deletions(-)
