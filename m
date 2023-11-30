Return-Path: <linux-fsdevel+bounces-4406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C977FF248
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1582284A60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B045100B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLKZxx9R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3FB83
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:16:30 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b54261534so8349185e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701353789; x=1701958589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xVtaW4O+Lj2QiYnGcxjEnUEyEc4cPIcDNiZYKXETYQ=;
        b=KLKZxx9RqoQEBi3JonXgtM+gdJSnaAFjUC7ArSSYckwOVa7RRz9Gk9C/CTGozRjY8z
         wONJxEHqq9FPQyUVD8l1aowdUXlOJPxKbrV5xzCKjbv8pqrtj3D8AM0ZziQgmihmU2Dl
         fkFkV668POgi3OL1T81qBh8aAXD2rSZlPeIka76YMRtny19fSN1AYD27CfHoyLtpI2Wf
         T4z8dUOp1X2WSeNIC0w7QHcZPSp265ksm4Z1NcPu83DA9SZ8BKJYyXK2+enPP0i36erX
         LHnVZb15TFKnH/PJtLUGEqsFmTYTBPKaDI4zGktPiE7D4dBaiSevJ7b+h4lXADjZb3q+
         hRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353789; x=1701958589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xVtaW4O+Lj2QiYnGcxjEnUEyEc4cPIcDNiZYKXETYQ=;
        b=N6/qb2cFPi2g+OUtY5r2KqUbXOjcaPDmxjq3FN1fI+r1Eacq9fHE9EW9M/g85Zist0
         21sOGw15f/xNM+9d7J7AghN1+y852N27R+TT8ZJMTFIafok/nfFs5rlsLV+frtI3Ndoy
         0jIYiN0WwVZJw0bGe556BQwUaPJ9bf0sFjd/a4Lz23oPiqqpY1m/yW5gxbpiL6JqwFcs
         JK+sBF0pTJwzqkNFHTJhjonxhHmV6/NwmpB4wtbyuxlfpirkLtyHrFj1+wIfw3WfpB0c
         shElctmZRSKlRfgda585FURv1/mgktFmZVV2mZEMaazaGEFDJ8WPTd0pGpURBdHuUeOE
         2QeQ==
X-Gm-Message-State: AOJu0Yy7vhlPRxoeyRcG2m7SXuxplX9iHaGu1DDt1GgjQY0HWTSv3t+Y
	vI690pcwDbC25IH2jdKxSQE=
X-Google-Smtp-Source: AGHT+IG1dU7ttuXYeXJh54W525e0L3u5hSBNzH9f/aTPLDY3pAtN6d0ESJ6iBtC/wmo20+SuXVrkJQ==
X-Received: by 2002:a05:600c:1d05:b0:40b:3faa:c964 with SMTP id l5-20020a05600c1d0500b0040b3faac964mr12146216wms.27.1701353789047;
        Thu, 30 Nov 2023 06:16:29 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm2170966wmq.14.2023.11.30.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:16:28 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/3] Avert possible deadlock with splice() and fanotify
Date: Thu, 30 Nov 2023 16:16:21 +0200
Message-Id: <20231130141624.3338942-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian,

Josef has helped me see the light and figure out how to avoid the
possible deadlock, which involves:
- splice() from source file in a loop mounted fs to dest file in
  a host fs, where the loop image file is
- fsfreeze on host fs
- write to host fs in context of fanotify permission event handler
  (FAN_ACCESS_PERM) on the splice source file

The first patch should not be changing any logic.
I only build tested the ceph patch, so hoping to get an
Acked-by/Tested-by from Jeff.

The following patches rids us of the deadlock by not holding
file_start_write() while reading from splice source file in the
cases where source and destination can be on different arbitrary
filesystems.

The patches apply and tested on top of vfs.rw branch.

Thanks,
Amir.

Changes since v1:
- Add patch to deal with nfsd/ksmbd server-side-copy
- Shorten helper name to splice_file_range()
- Added assertion for flags value in generic_copy_file_range()
- Added RVB from Jan

Amir Goldstein (3):
  fs: fork splice_file_range() from do_splice_direct()
  fs: move file_start_write() into direct_splice_actor()
  fs: use do_splice_direct() for nfsd/ksmbd server-side-copy

 fs/ceph/file.c         |  9 +++--
 fs/overlayfs/copy_up.c |  2 -
 fs/read_write.c        | 42 +++++++++++---------
 fs/splice.c            | 88 +++++++++++++++++++++++++++++++-----------
 include/linux/fs.h     |  2 -
 include/linux/splice.h | 13 ++++---
 6 files changed, 103 insertions(+), 53 deletions(-)

-- 
2.34.1


