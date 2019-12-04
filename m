Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A16E01126A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 10:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLDJLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 04:11:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43193 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfLDJLE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:11:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so2939739wre.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 01:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Sdir8t22Whp6d5zfU/aglTF8nH6hZfnd2WBrWb4Hzmk=;
        b=iQ3NLwjAkMqPVUWrDPgMWFEJlCQWOIiJQX1XjeKSOseCyF0pFdXM3San8C5vT5vlCL
         k/oVy8qj//oSFJ4vePk0dOmR0tQ5BCxIkmUlP4YdFbdIBw/YRC7EbLWd85QmuqB9B1k7
         Ywg4c4Q1ZCXfV4I1wKUHfQ1r8WW7T9bwMYqUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Sdir8t22Whp6d5zfU/aglTF8nH6hZfnd2WBrWb4Hzmk=;
        b=OZPycA/b8GuM89XoXLkWqb4G9ROAw0aL87CSYHSymBJuD+bXgFCAYj69R0CtvxDP0H
         V8QKs0wk5bv/tWE5ihDMnNwgc/QNxD3d2+fuAC2FyQGOyw3vwJyyNANXZF2nrjH7maU+
         2MItJIbwh4mdrg3ItmDwWO7BMcEm9hHEfMcmrH2vLxVkt+/VBjwV9OVI7taNhkT/n13B
         OdPB4j5MTUIQ3T4K7hy2KWVZPMXdFvnytW6sABUxFd0DODMVX3aWnjqunxvkPq3+R+nn
         L8JkMDl1a29RdKxsFFDa456MxmxB0Z1+Z/JpZGcKCvYPkdUb+aC3WbGb6JG6nrj7LbW6
         j/dw==
X-Gm-Message-State: APjAAAUPIr1SNdr0PsmZ9yZa4e5m+30vqh6pMbpbeHLKrSSRZlwlQqNE
        TrpLQkYiCC2SY4xGdLFjlbWWjg==
X-Google-Smtp-Source: APXvYqzkytORTQVPCACG5wYyyNFLEHO0L1v4wuq/QMOmPny/ytkdK4OTVqMTey4+mYHt68oxFWHylA==
X-Received: by 2002:adf:ef10:: with SMTP id e16mr2630023wro.336.1575450662345;
        Wed, 04 Dec 2019 01:11:02 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t13sm6193517wmt.23.2019.12.04.01.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 01:11:01 -0800 (PST)
Date:   Wed, 4 Dec 2019 10:10:59 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.5
Message-ID: <20191204091059.GB16668@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.5

 - Fix a regression introduced in the last release.

 - Fix a number of issues with validating data coming from userspace.

 - Some cleanups in virtiofs.

Thanks,
Miklos

---
Krzysztof Kozlowski (1):
      fuse: fix Kconfig indentation

Miklos Szeredi (4):
      fuse: verify attributes
      fuse: verify write return
      fuse: verify nlink
      fuse: fix leak of fuse_io_priv

Vivek Goyal (3):
      virtiofs: Use a common function to send forget
      virtiofs: Do not send forget request "struct list_head" element
      virtiofs: Use completions while waiting for queue to be drained

YueHaibing (1):
      virtiofs: Fix old-style declaration

---
 fs/fuse/Kconfig     |   4 +-
 fs/fuse/dir.c       |  25 +++++--
 fs/fuse/file.c      |   6 +-
 fs/fuse/fuse_i.h    |   2 +
 fs/fuse/readdir.c   |   2 +-
 fs/fuse/virtio_fs.c | 210 ++++++++++++++++++++++++++--------------------------
 6 files changed, 134 insertions(+), 115 deletions(-)
