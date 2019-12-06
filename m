Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25CE91157E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 20:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLFToG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 14:44:06 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36904 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfLFToG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:44:06 -0500
Received: by mail-ua1-f65.google.com with SMTP id f9so2997918ual.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 11:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=AXjdd1ziV9Br3LYY5TJqLYvVgqNaefSAPWdW46UBnho=;
        b=cpaoaPhlZgEFkU7NDeqMh5akHc6Ir32RqJUyAA0zG0yu882dRcQsTYvRR+XGBd69SD
         DeIxVGbTLNVTSDdI6zRz6tryFLFYJ6ahMbHAsUBRNulKr53t5+W1U+LoAmwGb+MQpa9/
         GHSAaBJ7dT5JZuFlKze9Nxr0XIgI06iwl+LzXJakOIXU5T73rKyzTfgd1zGpUNch8scm
         Ixt+DW/jdjPX7oRfgVZLCof94mRmAVxT07By2iuUMEsBbaCDqe1icm4py3JFQ6FSsykO
         Z5myv7ONSg7VA4V0IdFqOpI3EJgFOPPkqwdKU7nrYOEClMbzJpBVuhVz1D+JKDUC0Vcx
         kq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AXjdd1ziV9Br3LYY5TJqLYvVgqNaefSAPWdW46UBnho=;
        b=rkhyHpRN+L/AMT87Q2lQRXgKVx39qH87WuXu34vi227Afq7VqZnG80jNFqJYoSbnGN
         XinWgkwowzFcos98D6r4u3++MWC9UmowNCH+5qWD97EQ02mxsu8eiQ1NYamJa60HsRJA
         O6Kfl4Xjk8YQuU876QTGGi4Yirwtp6auFBtwUT3ZmqU9Lkef5oMXL64owXB6BJD/QMHM
         9Xm2sc0/Vy2N+yRW7+Hvnti4Q0zDrLQ37GOlA59eDVIniI9daKx/qCGdNepojsv70jOl
         wMKhu1jsy/TO7bwtg7qx3ITSu6lBE1nLmoWvvpkwk4G27QOsiPLhCIxSISm+s0C/XBEh
         Gfog==
X-Gm-Message-State: APjAAAWzmgngCkCf+0Dl2oaRwYoJYdo7XtZEaBPYgWV5VV+9MsxkvDH5
        mvUFNOPuybQqMo/8jsxC0oAKCbIB9/ysKPdyOR9mQg==
X-Google-Smtp-Source: APXvYqzH0rT5LHkKYfVahANiUyuD9qsXyiHLt95Sj1B7mk+DAjYbTrws7HeqjRXykH2/qkUJXmMOcVD3ozS75sIGwaQ=
X-Received: by 2002:ab0:6448:: with SMTP id j8mr12919705uap.19.1575661444568;
 Fri, 06 Dec 2019 11:44:04 -0800 (PST)
MIME-Version: 1.0
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 6 Dec 2019 14:43:53 -0500
Message-ID: <CAOg9mSS6daFQWvxUeFpGzC6U9D5ddH-iazskoOgGLML781p5xg@mail.gmail.com>
Subject: [GIT PULL] orangefs: posix open
To:     Linus Torvalds <linus971@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-5.5-ofs1

for you to fetch changes up to f9bbb68233aa5bd5ef238bd3532fddf92fa1b53c:

  orangefs: posix open permission checking... (2019-12-04 08:52:55 -0500)

----------------------------------------------------------------
orangefs: posix open permission checking...

Orangefs has no open, and orangefs checks file permissions
on each file access. Posix requires that file permissions
be checked on open and nowhere else. Orangefs-through-the-kernel
needs to seem posix compliant.

The VFS opens files, even if the filesystem provides no
method. We can see if a file was successfully opened for
read and or for write by looking at file->f_mode.

When writes are flowing from the page cache, file is no
longer available. We can trust the VFS to have checked
file->f_mode before writing to the page cache.

The mode of a file might change between when it is opened
and IO commences, or it might be created with an arbitrary mode.

We'll make sure we don't hit EACCES during the IO stage by
using UID 0.

----------------------------------------------------------------
Mike Marshall (1):
      orangefs: posix open permission checking...

 fs/orangefs/file.c            | 39 +++++++++++++++++++++++++++++++++++++--
 fs/orangefs/inode.c           |  8 ++++----
 fs/orangefs/orangefs-kernel.h |  3 ++-
 3 files changed, 43 insertions(+), 7 deletions(-)
