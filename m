Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE31850CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 22:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCMVQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 17:16:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33937 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMVQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:16:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id z15so13857454wrl.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RybIaAfwi42rMEkdDuMaPC6Ik8KsuIdgCBAZyLZRGtI=;
        b=Vs5qpx/x/9mxLreknEJDK/qKbsOrTJnfTgQMWs2P519evhcjsoxm6sZfYuVJpipmUA
         4AerZDGhlbpAhGYH6xqVpGrh4FHUIzbYKo6GAcPVF3HqSo2cLUmgWtn9z+RcKOhtabYn
         a93iwjsQXRR7ABmZs/2E/86fNrgPA2Wb+ptqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RybIaAfwi42rMEkdDuMaPC6Ik8KsuIdgCBAZyLZRGtI=;
        b=T5JeriGUF0/iW21rn+MAfbu5v0LC10gJQSHgoCv/jUlhk2l+gZD05vLLxKFjGPOlu6
         44c9mUo6j0i3S9KTNzEExUHMGEs2H1nstHv6drgesIi9HQmcJLfSKGEYM5TCgS2jMC0+
         gGTOeZzdgEpap2H4Gz4gf0gh0QFGbUt56YxMdnvzzenVgewSGW4FfxyvW8ciy83tiDOm
         0RW+b7ijwTs71RJ9MfPG09Ljln32CX6GjqZS1lNxzoGOWcjPOKBs2m3RYjHsGx5edlkG
         UbaWxJmNmNkbz32Kwnwgqxukh0CXI6lflVM8BYI6kedQbSW3k6UIyv75ctpOyBSavHe9
         KBkw==
X-Gm-Message-State: ANhLgQ2apJquOJlcse6z2sJ+jpD7oVSkly5PUFaFjiSJGhGu6S7qa1Yj
        ypWCE++ET70kKjkSPVO9g+T33g==
X-Google-Smtp-Source: ADFU+vugL6WKsIhIgeibrHLUO8PqfqQCSSG+PKiEL3An3Gd+kXB7lBjGshynRzcAs7uiEYsYIm0+nw==
X-Received: by 2002:adf:f285:: with SMTP id k5mr5319352wro.175.1584134187646;
        Fri, 13 Mar 2020 14:16:27 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id f17sm73907565wrj.28.2020.03.13.14.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:16:27 -0700 (PDT)
Date:   Fri, 13 Mar 2020 22:16:24 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.6-rc6
Message-ID: <20200313211624.GC28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.6-rc6

Fix three bugs introduced in this cycle.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: fix lock in ovl_llseek()
      ovl: fix some xino configurations

Miklos Szeredi (1):
      ovl: fix lockdep warning for async write

---
 fs/overlayfs/Kconfig     | 1 +
 fs/overlayfs/file.c      | 6 ++++++
 fs/overlayfs/overlayfs.h | 7 ++++++-
 fs/overlayfs/super.c     | 9 ++++++++-
 fs/overlayfs/util.c      | 4 ++--
 5 files changed, 23 insertions(+), 4 deletions(-)
