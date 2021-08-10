Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D885A3E7BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbhHJPEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242556AbhHJPEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:04:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6507C0613D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:04:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hs10so36138883ejc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0kGkCVXi9LMetkI7vjpLy4IPYSR246cc36MeCJtVGWY=;
        b=Vg3szelyZHeSc/dqdJwfjdyaNeVjX91LJTqrkmxo+eXKbQy5/j20lTRJpUcGxCvdtD
         jDOjwa3ZvEhSpKq9bVkeUwKlPtBxTcuLzIajGDGO3UXcNnY09bajB/YMlav5D/eRMa3N
         jPBiJhm/g9mnPytSQD2TI00r1An39xj/YQIJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0kGkCVXi9LMetkI7vjpLy4IPYSR246cc36MeCJtVGWY=;
        b=JlYn7uG/+y+wsZbJPijNb+vXlbqILG0CwzDlFYQmNelZsOQXpL4iMHHaP7ylEXQW0A
         M3M1W8OsVb5azthzafrw+WW8CI9gMoPnaL1WQXXrNi/7Z7VWtg6o3M7xdUQwntt4AdPL
         8YE1Pa06M+G39jUG3war8LBZzim9AnZd1zR7HNIuxUH1mAtMYD5WokExRjhdDFKClcME
         V6Zf4rpMZa3u0HM/JSuQLoFx0ngox8zv4H2GIG4Qs8C7O0JRNZ6AdU9Khr0cC/wxi3H6
         EHOyv7B2YItWfKiQ1H9IWe4zd1QteO8o7fHvkWNAglzXzGkxceL5V771154bL6TV/hTL
         EL+A==
X-Gm-Message-State: AOAM531JXZNmw9zBdOxpF/229RdvI57MStN+YlT1qVB1FijgWBo7k/VH
        1TOGQxZ/JLVM64nqibznMLbQmfbNCXn7dA==
X-Google-Smtp-Source: ABdhPJxnq5BxlTa14rXURztYnwXAxPN8xl+/yaEV1Jt6ftczGTmT9LR5FamQjUkA/MlE9sSBl2vqDA==
X-Received: by 2002:a17:906:9c84:: with SMTP id fj4mr27408543ejc.264.1628607847156;
        Tue, 10 Aug 2021 08:04:07 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id c16sm2536466ejm.125.2021.08.10.08.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:04:06 -0700 (PDT)
Date:   Tue, 10 Aug 2021 17:04:03 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL v2] overlayfs fixes for 5.14-rc6
Message-ID: <YRKVYyeAUqJSJ5rk@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.14-rc6-v2

Fix several bugs in overlayfs.

Fixes have been in linux-next for a fair amount of time, the recent commit
timestamps are due to moving these fixes to the front of the patch queue.

v2: drop mmap denywrite fix.

Thanks,
Miklos

---
Amir Goldstein (1):
      ovl: skip stale entries in merge dir cache iteration

Miklos Szeredi (3):
      ovl: fix deadlock in splice write
      ovl: fix uninitialized pointer read in ovl_lookup_real_one()
      ovl: prevent private clone if bind mount is not allowed

---
 fs/namespace.c         | 42 ++++++++++++++++++++++++++++--------------
 fs/overlayfs/export.c  |  2 +-
 fs/overlayfs/file.c    | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/overlayfs/readdir.c |  5 +++++
 4 files changed, 80 insertions(+), 16 deletions(-)
