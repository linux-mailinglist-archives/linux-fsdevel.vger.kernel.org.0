Return-Path: <linux-fsdevel+bounces-2824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71A67EB3B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8927D28118B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AAE41762;
	Tue, 14 Nov 2023 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAJ5+QCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB644175A
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:28 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C557ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d9d8284abso3684444f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976005; x=1700580805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7nqa9o4c+gpu0UWvrG+3y9dNQVSnLE0jJX9P0bwTtOI=;
        b=cAJ5+QCzM2y9i3YiPN/NTcGH00QL/3unxyRcxNxHSQktzGA5nV4YWBwPCr9YTZXCRj
         lgSGuAX/gUDLuIvNvywe6AU9kaGNobKVQUJtif7fZpJKgKLYD4XB5z2gUq8pxH+KXHwQ
         Mer3uFQlVGz4ZwkQ61Z1WpyBlUmj3NBCDRplMNcctjHvoC/Qi/jcVPe1VOWxPzYh0BSB
         vcn/mwPpYMNY2bIE0TCIgYD7IWD2eS5KPEaorWYeJo0CdKSQbQU9RzXOJl+Ax50bg9Xn
         D6bAXXfRXhyNgXpHIlwfp+3rczeFJYRHLHtuJJXOhrCPjuug6mEnOOBxA5oUBJjNMPg2
         kXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976005; x=1700580805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nqa9o4c+gpu0UWvrG+3y9dNQVSnLE0jJX9P0bwTtOI=;
        b=hckTwrrh2l3DpA5HqUZzB96iMynVMBa4LQP/h+En33ZLsxkHFXpmHh+KWhAHbNhGeH
         uZUAemahyL+Y+IAX4M/8k5y0Nmr9fAeDPbEzqk/wL8IoQNT1d005tCHnOK12aezlPro7
         /vEasRj+eVqcf2ASQzkE/PKp9OEg+xJGWQPBwNvw+Rlo8uYgTG8h1RBrWqgg4p3cPAeZ
         5sTzD27vCiwowcFw0kv4pXk/Kx3BlOq6Zm7h7/Ah2WMnlNaRQY5TFvu7c9JiulNtjkHY
         ABZ5cwU89NkeCPVED1hqrxjmw+y0T0arJ9jevG2ct1jhIl5qRPT5lIHWpb2tv0LDVIPa
         gOaA==
X-Gm-Message-State: AOJu0YwMsAYQqPYc4m0HR0JOd54+WZar5cEVepXtUYzwDRdHESYoGuAs
	iZWYUZADoloTlJiV+E0CjvQ=
X-Google-Smtp-Source: AGHT+IGgiijUQ12guOXWhTZx+LfsYbjjI7Jtqd7GQEhtFyENCth5eG8mXm9Hdg28ybjYwaQchR8WZQ==
X-Received: by 2002:adf:e588:0:b0:32d:96dd:704d with SMTP id l8-20020adfe588000000b0032d96dd704dmr6572118wrm.18.1699976005541;
        Tue, 14 Nov 2023 07:33:25 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:25 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/15] Tidy up file permission hooks
Date: Tue, 14 Nov 2023 17:33:06 +0200
Message-Id: <20231114153321.1716028-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

I realize you won't have time to review this week, but wanted to get
this series out for review for a wider audience soon.

During my work on fanotify "pre content" events [1], Jan and I noticed
some inconsistencies in the call sites of security_file_permission()
hooks inside rw_verify_area() and remap_verify_area().

The majority of call sites are before file_start_write(), which is how
we want them to be for fanotify "pre content" events.

For splice code, there are many duplicate calls to rw_verify_area()
for the entire range as well as for partial ranges inside iterator.

This cleanup series, mostly following Jan's suggestions, moves all
the security_file_permission() hooks before file_start_write() and
eliminates duplicate permission hook calls in the same call chain.

The last 3 patches are helpers that I used in fanotify patches to
assert that permission hooks are called with expected locking scope.

My hope is to get this work reviewed and staged in the vfs tree
for the 6.8 cycle, so that I can send Jan fanotify patches for
"pre content" events based on a stable branch in the vfs tree.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fan_pre_content

Amir Goldstein (15):
  ovl: add permission hooks outside of do_splice_direct()
  splice: remove permission hook from do_splice_direct()
  splice: move permission hook out of splice_direct_to_actor()
  splice: move permission hook out of splice_file_to_pipe()
  splice: remove permission hook from iter_file_splice_write()
  remap_range: move permission hooks out of do_clone_file_range()
  remap_range: move file_start_write() to after permission hook
  btrfs: move file_start_write() to after permission hook
  fs: move file_start_write() into vfs_iter_write()
  fs: move permission hook out of do_iter_write()
  fs: move permission hook out of do_iter_read()
  fs: move kiocb_start_write() into vfs_iocb_iter_write()
  fs: create __sb_write_started() helper
  fs: create file_write_started() helper
  fs: create {sb,file}_write_not_started() helpers

 drivers/block/loop.c   |   2 -
 fs/btrfs/ioctl.c       |  12 +--
 fs/cachefiles/io.c     |   2 -
 fs/coda/file.c         |   4 +-
 fs/internal.h          |   8 +-
 fs/nfsd/vfs.c          |   7 +-
 fs/overlayfs/copy_up.c |  26 ++++++-
 fs/overlayfs/file.c    |   3 -
 fs/read_write.c        | 164 +++++++++++++++++++++++++++--------------
 fs/remap_range.c       |  48 ++++++------
 fs/splice.c            |  78 ++++++++++++--------
 include/linux/fs.h     |  62 +++++++++++++++-
 12 files changed, 279 insertions(+), 137 deletions(-)

-- 
2.34.1


