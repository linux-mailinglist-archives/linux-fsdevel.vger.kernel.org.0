Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570624624E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhK2Wc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhK2Wcu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:32:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A1AC06FD44;
        Mon, 29 Nov 2021 12:15:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c4so39386255wrd.9;
        Mon, 29 Nov 2021 12:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUyW9/bu808KughF8jMY+xgu/5CCJPBOxJx/5UdnFQU=;
        b=K2z+8261JxjPHqFAkOmRN0j0FdyCPUSiJCUVsRsymL2kYzmr9Yask0TMrCIFWnfgUi
         58CqxJED0ch+/kVyn1vxCtUSL3CAYhYucVLTSS/CXhmdZZlSX2NB8ZPM85ErG86GAr/3
         wPdA00828OqtqsiTy0We4U2gxxhmlNDmY6TFDXRLsJmWIZXp8i9pcJNLV4zAGHeC/S18
         fLTn31mvE5fE+4yV6T/QfZZ/1/QwOSjReGa/xHMwyAjkor+u9VEJYMnMwM1e3nK444Gz
         hPKiST+v22nEYGm3hNQP1TGH0sOpL57Yasp9dnCXymOM7OsoP1d/oX+xlRYfAIKCy5Je
         M/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AUyW9/bu808KughF8jMY+xgu/5CCJPBOxJx/5UdnFQU=;
        b=q6uWfy36SdolaxtMVQpFwdtA3kgw9SeWn1yKXMlbjIqjdanWqGle+YkoNeW1oYJW8L
         vLrUS07OOAIsNE7CR0t4p1iduoqMiHZESDDwya4GliOT5cGXthgEYdhiRNe2KBcORtx2
         maMn1r6fF16MFGarS5TVLK5GoYY3SPSNZEZaEQ1ZvWNEHdxU7rapzs10s2X7WskbRebU
         NEnV8XWCKQsgftjeMbsdywNrx+0dQuCcziYBmXcgZA08iC1baeLuQp6rZE8IhMA6aLAj
         1s+W5Cb5VmaGrgK7l57Is9d6iAGXkICcKDjCzhbQx4oL5r3lAAaadJPraoHAuIN84QaG
         U42A==
X-Gm-Message-State: AOAM532noFB+zI9EuaZ6LEsHuvlSx3TIp33mzjCS2xQAB+ZZsV5iXzI9
        jFolS13v2jyv4sSeDDtVUVc=
X-Google-Smtp-Source: ABdhPJxZ2XN8R27xeLEJD+fBlb83DwJg2jEoZGuojOJWyPaArj18t0RXp5sEmO5wsbEPJtH0sBCovg==
X-Received: by 2002:a5d:54cf:: with SMTP id x15mr37985959wrv.30.1638216940391;
        Mon, 29 Nov 2021 12:15:40 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id m14sm19791830wrp.28.2021.11.29.12.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:15:39 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 00/11] Extend fanotify dirent events
Date:   Mon, 29 Nov 2021 22:15:26 +0200
Message-Id: <20211129201537.1932819-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

This is the 3rd version of patches to add FAN_REPORT_TARGET_FID group
flag and FAN_RENAME event.

Patches [1] LTP test [2] and man page draft [3] are available on my
github.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fan_rename-v3
[2] https://github.com/amir73il/ltp/commits/fan_rename
[2] https://github.com/amir73il/man-pages/commits/fan_rename

Changes since v2:
- Rebase on v5.16-rc3
- Separate mark iterator type from object type enum
- Use dedicated iter type for 2nd dir
- Use iter type report mask to indicate if old and/or new
  dir are watching FAN_RENAME

Amir Goldstein (11):
  fsnotify: clarify object type argument
  fsnotify: separate mark iterator type from object type enum
  fanotify: introduce group flag FAN_REPORT_TARGET_FID
  fsnotify: generate FS_RENAME event with rich information
  fanotify: use macros to get the offset to fanotify_info buffer
  fanotify: use helpers to parcel fanotify_info buffer
  fanotify: support secondary dir fh and name in fanotify_info
  fanotify: record old and new parent and name in FAN_RENAME event
  fanotify: record either old name new name or both for FAN_RENAME
  fanotify: report old and/or new parent+name in FAN_RENAME event
  fanotify: wire up FAN_RENAME event

 fs/notify/dnotify/dnotify.c        |   2 +-
 fs/notify/fanotify/fanotify.c      | 213 ++++++++++++++++++++++-------
 fs/notify/fanotify/fanotify.h      | 142 +++++++++++++++++--
 fs/notify/fanotify/fanotify_user.c |  82 +++++++++--
 fs/notify/fsnotify.c               |  53 ++++---
 fs/notify/group.c                  |   2 +-
 fs/notify/mark.c                   |  31 +++--
 include/linux/dnotify.h            |   2 +-
 include/linux/fanotify.h           |   5 +-
 include/linux/fsnotify.h           |   9 +-
 include/linux/fsnotify_backend.h   |  74 +++++-----
 include/uapi/linux/fanotify.h      |  12 ++
 12 files changed, 485 insertions(+), 142 deletions(-)

-- 
2.33.1

