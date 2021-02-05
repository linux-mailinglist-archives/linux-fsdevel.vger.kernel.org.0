Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C032D310433
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 05:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhBEExL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 23:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhBEExC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 23:53:02 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7B5C0613D6;
        Thu,  4 Feb 2021 20:52:22 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i63so3538116pfg.7;
        Thu, 04 Feb 2021 20:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TiNwgvNg9wTQcaeQffbjRo8MeaMhlwRcSNfHHJcW5R0=;
        b=BAItrihCnOoe0wDb56WNdzmcJM2b441L7LED+lFT9Lhb0GidXMJy1G3oL7MgS3JQH+
         WNIdHK0lpuNuMDQfjPLxmuJz/vHLtbV+2g5iwp2OkCXoZrzG/VZDlwGYImoYvCp56yJg
         uPcYjtm8gt/bb+JqLJvo5yLp4Z0nUAC7BK4zOsfH4Hu1uFokirM+2AErC7hGZfZPbZWo
         oy5fEGPBDUGEZM71dr3qB4hZFEJ2LgB2iCVuVE6uZ67EQWow41jKwgg7q6p1LWOCkxgE
         C40nxyXY+eDEd52wpJZ831MneIywEraKmHA8+xwv9mMFesxXqWI/cQMMOm9YddyCG0cm
         WnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TiNwgvNg9wTQcaeQffbjRo8MeaMhlwRcSNfHHJcW5R0=;
        b=MFzV0R/oROuOD2m1TsdPCrCY/htfWZjx5MzxGL939o2f6DmN3fSD0RufWcbTuNHArk
         jFAbx4jXnU6GhRMxpi3At/ln6AGY/0mHif/m6MiVMxZ310Jc26UiuC1qkw1bSsT4/+3W
         KEDNGeEQk2tYhwqsIrosFzRYZMIj7kNPyZF9t1J9qQ0/e+Q+lOZpU2pZuIOXzBc8Fzwy
         3RR3OrLp8C/Ue0o6P5rb8LieBNhFKTyptJxFhVPms9iEQmPkFcL1q34mJA0WXE7s0wXC
         InX3Mf0csyLynJh5bqDQp6PJvMUKtN0qZMOFeLpP41bF6baEhTd2Ha2NPonSQVvKCpvT
         RXxw==
X-Gm-Message-State: AOAM531L7qIKJtpbywv482ZzPe1w+5JciqabhpTThCaRAAjOQftsTt3a
        qHooGSEPrBOejQBNm+BHa70jDWpcwvHilw==
X-Google-Smtp-Source: ABdhPJzhklPpfLn28lRihPdetGiXWdHS92RLyjlQfbVQJZNJ9vyXbe/wliWu7Oj/YxiCIGB1Bw5vpQ==
X-Received: by 2002:a63:2746:: with SMTP id n67mr2471461pgn.54.1612500742180;
        Thu, 04 Feb 2021 20:52:22 -0800 (PST)
Received: from amypc-samantha.home ([47.145.126.51])
        by smtp.gmail.com with ESMTPSA id s1sm6972440pjg.17.2021.02.04.20.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 20:52:21 -0800 (PST)
From:   Amy Parker <enbyamy@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Amy Parker <enbyamy@gmail.com>
Subject: [PATCH 0/3] fs/efs: Follow kernel style guide
Date:   Thu,  4 Feb 2021 20:52:14 -0800
Message-Id: <20210205045217.552927-1-enbyamy@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As the EFS driver is old and non-maintained, many kernel style guide
rules have not been followed, and their violations have not been
noticed. This patchset corrects those violations.

Amy Parker (3):
  fs/efs: Use correct brace styling for statements
  fs/efs: Correct spacing after C keywords
  fs/efs: Fix line breakage for C keywords

 fs/efs/inode.c | 36 ++++++++++++++++++++++--------------
 fs/efs/namei.c |  2 +-
 fs/efs/super.c | 25 +++++++++++--------------
 3 files changed, 34 insertions(+), 29 deletions(-)

-- 
2.29.2

