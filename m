Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997491C429
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 09:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfENHvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 03:51:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51224 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfENHvq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 03:51:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id o189so1733595wmb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=o2QrQ5MNnq1cgP4oiv+YPRRhyT5fmlVNWM93IrsnoBE=;
        b=na4L8GTvwX3E/LspfijFBcyq+JAEBsE0fBRMg5K2igjXXcyQHYgMxkRcJUPY9ZHJWI
         W65nVU9XFlg1BIQqhsB8wkAsWk0FRBsf0YLyOXdSvnYSkeOuDKq9dyojMZnTfkv5nYjw
         XHNzAy0urMon+03CuuLmPY/Hpo9R93yByZ1ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o2QrQ5MNnq1cgP4oiv+YPRRhyT5fmlVNWM93IrsnoBE=;
        b=dqVK8CbdZYekC6QIiVfuvXdbRCQkXkFoV/Wo1yVT0PfDKLkL3Ut1057Irmkmp0pseu
         7kR89lcOUYZkH+PKJXRwFzNRtwwzU4XfcT5AoIReGGsp3GBNR60OtKqkmfv/qCQTvamo
         Us88W74QwMouV77xXyTVRlT3P5Hua/EB4upDmDpQJbu/kW8FT0Zl0VA2spF8+8HZ4BO0
         aLQhX44TJPGwP02z8xsGaWdJG1N6rjyZa+g1/si1GrS1UKERN06OHipSIKS54JpBRNVe
         2CUIqjlR/D5QquPJE6fXcQ3MfnlsbY4gJlXMjFbsJLC/+yZv7QAaaE3xxgF9gDEuIxpu
         H6PA==
X-Gm-Message-State: APjAAAUMuvan0/rdr8aLeBCn87Riivrb0aB7hFiSyFkUm3i1hxmc3q/L
        8Y8tlhm/g+gFQ4P2yydyf72rTkTsqsk=
X-Google-Smtp-Source: APXvYqzm0Fhyc/9vjwd4b7jS4AfGOI/rolMAEaQqKPCXi/4mpEGUes7Qj1u8NCCnxzwZi/pdiI6LAA==
X-Received: by 2002:a1c:ab0b:: with SMTP id u11mr18271669wme.26.1557820304213;
        Tue, 14 May 2019 00:51:44 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (217-197-180-204.pool.digikabel.hu. [217.197.180.204])
        by smtp.gmail.com with ESMTPSA id c130sm6197113wmf.47.2019.05.14.00.51.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 00:51:43 -0700 (PDT)
Date:   Tue, 14 May 2019 09:51:36 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.2
Message-ID: <20190514075136.GA7850@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.2

Add more caching controls for userspace filesystems to use, as well as bug
fixes and cleanups.

Thanks,
Miklos

---
Alan Somers (3):
      fuse: document fuse_fsync_in.fsync_flags
      fuse: fix changelog entry for protocol 7.12
      fuse: fix changelog entry for protocol 7.9

David Howells (1):
      fuse: Convert fusectl to use the new mount API

Ian Abbott (1):
      fuse: Add ioctl flag for x32 compat ioctl

Kirill Smelkov (5):
      fuse: convert printk -> pr_*
      fuse: allow filesystems to have precise control over data cache
      fuse: retrieve: cap requested size to negotiated max_write
      fuse: require /dev/fuse reads to have enough buffer capacity
      fuse: Add FOPEN_STREAM to use stream_open()

Liu Bo (1):
      fuse: honor RLIMIT_FSIZE in fuse_file_fallocate

Miklos Szeredi (1):
      fuse: fix writepages on 32bit

zhangliguang (1):
      fuse: clean up fuse_alloc_inode

---
 fs/fuse/control.c         | 20 +++++++++++++++-----
 fs/fuse/cuse.c            | 13 +++++++------
 fs/fuse/dev.c             | 16 +++++++++++++---
 fs/fuse/file.c            | 22 ++++++++++++++++++----
 fs/fuse/fuse_i.h          |  7 +++++++
 fs/fuse/inode.c           | 23 ++++++++++++-----------
 include/uapi/linux/fuse.h | 22 ++++++++++++++++++++--
 7 files changed, 92 insertions(+), 31 deletions(-)
