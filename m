Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCEE2BBF56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 14:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgKUN5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 08:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbgKUN5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 08:57:41 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ACEC0613CF;
        Sat, 21 Nov 2020 05:57:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p19so10129718wmg.0;
        Sat, 21 Nov 2020 05:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sSLrsoCThKdI+jQb1wr01jtEa88ERuqCuG535g+VAeE=;
        b=XDUotY2JEZUuLkRkfUbd+1zKQpplBY56xA350EHbJkjU10D1xxNvjciuuFHGhhdp7f
         CMKhSWw6WJ/WSQz5Uz8dKYKmVBH8vi2ey7tf67BLaISIZTczHsBvXdgn7u16ShBd5qJd
         4NWFmhEtywTeG3ItNOQaD3bJOlzvhxXzqvD2I5O0zDAVfKQr8fkLlGsWbqdWDecj+3Nr
         M2xxwXCuhvPoPFSG9gcnH4yCIJ//rn+p0KpNI9J7dvwRAGfCqYZMyLezl3RqwbGoSbc0
         0Nr2g8MI98W7ZAa+YhbWeloAeOtHUscmWIOGdi5wd4yGmLaRWcoV0otL6eN6oGVoQVCH
         KZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sSLrsoCThKdI+jQb1wr01jtEa88ERuqCuG535g+VAeE=;
        b=bvc+yjhisjmZk87d0bk9e7H9NecHXwbQ7pipm/begBLboi6OHUwFs+Eoztw3RYzz2z
         mB/PtEdDP5cQjIxzbQN5b4OaO5TSToibX8iorXCNTrd9ssxxiv+ilKHSCAtPuK7Wk/LJ
         YB+g2oI1PT4Txah0XAw/GR8dddmBo5LPPygAyy45o7oFzz+PNAMh+ZZYfM8M7xhSKSxw
         4kSq+SUas4er23swiN7biFVNtr2Qg/vo8cGtnFBYFwbzyLcRewVuCBErmpPAIIIBX3Wi
         OMr0mm0k9qsTrvEFkS0BxIrbybuL1Gpy5qzlNT8/hksekzhASJWrg0oU8Fb6kbpl0sL3
         6MfQ==
X-Gm-Message-State: AOAM530t5wLX0fGDwZAMDCEks4g4eHiNdDeSsDRM98N3kc0+xHxoypzf
        qsPsc87NcD8JXNiuoWfAv3k=
X-Google-Smtp-Source: ABdhPJzSFNGBZD9AEYsZCnLvsraSV4jfM5xWf8fbrVy68h2ZvPdubbTnmutI65/Wmni65zUaLOU8lg==
X-Received: by 2002:a1c:9cc9:: with SMTP id f192mr15210864wme.143.1605967060223;
        Sat, 21 Nov 2020 05:57:40 -0800 (PST)
Received: from localhost.localdomain ([170.253.49.0])
        by smtp.googlemail.com with ESMTPSA id 17sm41689951wma.3.2020.11.21.05.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 05:57:39 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Cosmetic
Date:   Sat, 21 Nov 2020 14:57:32 +0100
Message-Id: <20201121135736.295705-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Alexander,

I passed chackpatch.pl to these files,
and found many things to fix.

I splitted the changes into a few different patches,
to make it easier for review.

Cheers,

Alex


Alejandro Colomar (4):
  fs/anon_inodes.c: Use "%s" + __func__ instead of hardcoding function
    name
  fs/anon_inodes.c, fs/attr.c, fs/bad_inode.c, fs/binfmt_aout.c,
    fs/binfmt_elf.c: Cosmetic
  fs/attr.c, fs/bad_inode.c, fs/binfmt_aout.c, fs/binfmt_elf.c: Cosmetic
  fs/binfmt_elf.c: Cosmetic

 fs/anon_inodes.c |   5 +-
 fs/attr.c        |  12 +--
 fs/bad_inode.c   |  55 +++++-----
 fs/binfmt_aout.c |  95 +++++++++--------
 fs/binfmt_elf.c  | 268 ++++++++++++++++++++++++-----------------------
 5 files changed, 225 insertions(+), 210 deletions(-)

-- 
2.28.0

