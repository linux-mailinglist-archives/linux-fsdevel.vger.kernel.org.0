Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E335B421091
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 15:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbhJDNr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 09:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbhJDNr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:47:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48910C0D943E
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Oct 2021 06:07:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g10so5411477edj.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Oct 2021 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3xhITpFaVUHg+5EZbnzqRDgQ6Md69G0yDI6FlhB0FOw=;
        b=F09w7RiqYBXkBGwnr5At93zYHtIIKiPh9AH8Nske5mly8osqqUGbxfHK6/LPXY/IiT
         pp+L1qFfadseFfdgpRGkE6oYl0AuMP99FYtFEg7h6CGYyJiC3RnKG+dpKOe8l8LFu/6K
         /whJFAdnSpWimFCLDY1wpG4cb/JHnLybJqc/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3xhITpFaVUHg+5EZbnzqRDgQ6Md69G0yDI6FlhB0FOw=;
        b=BgGj2Ho4no9GujMrOadNlyrUrnQb/vr2FZ1suB1JlHpKIGg4yyo5G+fBdfrB+DgV6h
         byMO+5U0g6XJ+8i+Xestkcg6rKtZqvzr8Hb6CiqLhpNVBWaQFCwcSp54/0xqW4mYRYsJ
         KtAKKjGMKcxuD2EeA+QsBPaF//mAcwZRHmRw8lmxxvzqEMUNHWYRU5BEPK7xg5xXApQ4
         Rt2Cyzppsonp+OgLMElYBHI1gRig2iVrvjrC02IrHwKnC7JOczPrWn0oPcAIzmalYh3W
         lb1UeFR8MP1RquDWWCQt4rltF9ZQuPIvkqGFTj/1R9iCAwDiMWBdSgBz8LoF2zX8eGc5
         X+Wg==
X-Gm-Message-State: AOAM533v4sXm/Abarm70OudOreiR3MVDaucD8GwXu7u8KNqUjqN1TeaT
        BRVaaAwI0znYkuWd+77zMU5hTg==
X-Google-Smtp-Source: ABdhPJzmLt8RhT6JUaun/XGi1pRU4pNkGD1tiuHSoPjE5/52CHX5cEIi0LfauFOPb6Eos79FMQH7uw==
X-Received: by 2002:a50:d84c:: with SMTP id v12mr17688714edj.203.1633352839921;
        Mon, 04 Oct 2021 06:07:19 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id d17sm2957548edv.58.2021.10.04.06.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:07:17 -0700 (PDT)
Date:   Mon, 4 Oct 2021 15:07:14 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.15-rc5
Message-ID: <YVr8grJWnLDcBZFJ@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.15-rc5

Fix two bugs, both of them corner cases not affecting most users.

Thanks,
Miklos

---
Miklos Szeredi (1):
      ovl: fix IOCB_DIRECT if underlying fs doesn't support direct IO

Zheng Liang (1):
      ovl: fix missing negative dentry check in ovl_rename()

---
 fs/overlayfs/dir.c  | 10 +++++++---
 fs/overlayfs/file.c | 15 ++++++++++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)
