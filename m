Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D4233D5E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 15:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhCPOhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhCPOha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:37:30 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C2C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 07:37:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p7so61229275eju.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vlOwQB4wqa5CjFenq2TYl+SsUWKaiBeLfLRxnljtshU=;
        b=XiQj4kcEgeCJU9sYgoHLb8P4TrUdBoskbtUo+tuHtEFPFYRqb4MTQCpWt88XcHnyRu
         lVJiGa54TNCd01TPR3JmbSv2/ISseu5P3+vrBOG1SDIcvXtGztKekqN54zlCDSN+MMwE
         5pJSxHcjsDiYyS4yNAgkVDZWlzkEhaNcWn3rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vlOwQB4wqa5CjFenq2TYl+SsUWKaiBeLfLRxnljtshU=;
        b=UJGfP3H9D2vIms8IVbcQD+3QDYpZA37Y49xLOfQk7GYrU/v2xSSA1JhihuK7nTmM/Q
         L05joH+K3Rg3TthhmmCEdUojfQkII6Q2Z8N+9aRbJhpa36hwI6nUkVDwLJVszECCc3V4
         +cJzid1OjKHfc4s9mrG2E+htYPGH9IFyISMoTiw8NiUjM+JpNdzbG9CZsp0tsxZsi8rz
         eFwXmANuAxLrUEjHvuQ8XeiFWm6vLNLmpe+rhe4lfHdRJ+JmwGM1QUdZGyvI5LUSgMrL
         NVkdlIVnrwPfSQG55Bx6FGyVJeZDTbX+v3B622Z8X+FhBxMA1Woke6RBPzP+svZoFpyK
         qpAg==
X-Gm-Message-State: AOAM532AsMagGUWi5wxpKfIsauVVKg4vhJBAJ+0gS/0BIb6WqOdBp4/f
        uY9oQySyem5EpKUzeD91mkWDRA==
X-Google-Smtp-Source: ABdhPJyK6hG2YpjGagEk34eBscWDEErR9feMY+tifSxG0L1bK9y/Ryr7t3KXXyo6VJp22KqwE6M9hQ==
X-Received: by 2002:a17:907:94cc:: with SMTP id dn12mr29976930ejc.177.1615905448624;
        Tue, 16 Mar 2021 07:37:28 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id i10sm9666945ejv.106.2021.03.16.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 07:37:28 -0700 (PDT)
Date:   Tue, 16 Mar 2021 15:37:21 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.12-rc4
Message-ID: <20210316143435.GC1208880@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.12-rc4

Fix a deadlock and a couple of other bugs.

Thanks,
Miklos

----------------------------------------------------------------
Alessio Balsini (1):
      fuse: 32-bit user space ioctl compat for fuse device

Amir Goldstein (1):
      fuse: fix live lock in fuse_iget()

Vivek Goyal (1):
      virtiofs: Fail dax mount if device does not support it

---
 fs/fuse/dev.c             | 26 ++++++++++++++++----------
 fs/fuse/fuse_i.h          |  1 +
 fs/fuse/virtio_fs.c       |  9 ++++++++-
 include/uapi/linux/fuse.h |  3 ++-
 4 files changed, 27 insertions(+), 12 deletions(-)
