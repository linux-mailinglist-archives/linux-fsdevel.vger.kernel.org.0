Return-Path: <linux-fsdevel+bounces-2164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457397E2F73
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DEC280D8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970102D048;
	Mon,  6 Nov 2023 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oKrfei+Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A18A2EAFD
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:37 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D97710A
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:36 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7789a4c01easo319647485a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308515; x=1699913315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4v6mhXlBssXeK8gC3//q54ke4CUoVIyIXdnlt0Fb/8=;
        b=oKrfei+QD1+rvFIbLMzOQvH9qNH7VjurJE7oHtp/kYrUgdj7f4WOv+6qIzJlFc8RrT
         +i1MC65kJqJSLMtLzgvIehgm1Xi7Lgm1QWo1FQ5TZAnpQIjZhlNrX1AC3Tc4z3po4hrS
         pA34CVmavRUlsYVBqKHHyp8SqVt1UQi4BSwwkX8GGHC9DTRlMr7Ne4iU/d+n9ZFQpAyn
         cee5UtS/0MYTS+FF3seCV5Ds9/EfqfqFY+nyxwxhyTSWcE/xHbIC9BrnKMckxM7RzDfR
         3sGG/O74L1hgoLaTlz2xrNgihci4Rh5NQWMDAM/s6lu1kOpywT5uPzlmJvUb1TpPUV+g
         pHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308515; x=1699913315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4v6mhXlBssXeK8gC3//q54ke4CUoVIyIXdnlt0Fb/8=;
        b=iWpIdIPLMcENtpm4DVjslrZt/d4xo7AU35Emds97/b//g9nNmQCKpc5TUbe1Whrsmr
         FiU7F4zp8ugu5gWFhJjpOwqKzfOkc0qVd57dfpm5VmqsGtQ+QMq+lFlRgT3gPMDyPDAo
         DguPbNQgzU+6HqulWIye5Th21L57yXbZIHKavVwx3Kve02NBC/lFf8JTeTogGpiDmQ/0
         zzU2GfedgQYoJPM84LBt3MOpSmhaMtRKcuMV8E2bpjjGOpRWM71Zl9IwRxwGyGGNwu2+
         Cv5NJi0dA10TBMznu737tsijt1bylc3HLqaLGFwCQ7e0G+INn2OWDmdtHvndayw9GuGW
         BhTw==
X-Gm-Message-State: AOJu0YzIPLcIqTmqsH25xJN/Dn8JyxELgb7d0etiCn6BQsnYuKVCaEOQ
	XeU95c4mo+vkZRCnJ2BKY76l5w==
X-Google-Smtp-Source: AGHT+IEejiGAh1aSp3Ki2s2Y/JOESrL7dmQTrLwlC0dssEByaEH5WHNCfHFzOcDp7ImWEAPIwwnv9A==
X-Received: by 2002:a05:620a:199a:b0:779:eb01:8390 with SMTP id bm26-20020a05620a199a00b00779eb018390mr36637337qkb.49.1699308515386;
        Mon, 06 Nov 2023 14:08:35 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a022d00b0077a02cf7949sm3677406qkm.32.2023.11.06.14.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:35 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 00/18] btrfs: convert to the new mount API
Date: Mon,  6 Nov 2023 17:08:08 -0500
Message-ID: <cover.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

These patches convert us to use the new mount API.  Christian tried to do this a
few months ago, but ran afoul of our preference to have a bunch of small
changes.  I started this series before I knew he had tried to convert us, so
there's a fair bit that's different, but I did copy his approach for the remount
bit.  I've linked to the original patch where I took inspiration, Christian let
me know if you want some other annotation for credit, I wasn't really sure the
best way to do that.

There are a few preparatory patches in the beginning, and then cleanups at the
end.  I took each call back one at a time to try and make it as small as
possible.  The resulting code is less, but the diffstat shows more insertions
that deletions.  This is because there are some big comment blocks around some
of the more subtle things that we're doing to hopefully make it more clear.

This is currently running through our CI.  I thought it was fine last week but
we had a bunch of new failures when I finished up the remount behavior.  However
today I discovered this was a regression in btrfs-progs, and I'm re-running the
tests with the fixes.  If anything major breaks in the CI I'll resend with
fixes, but I'm pretty sure these patches will pass without issue.

I utilized __maybe_unused liberally to make sure everything compiled while
applied.  The only "big" patch is where I went and removed the old API.  If
requested I can break that up a bit more, but I didn't think it was necessary.
I did make sure to keep it in its own patch, so the switch to the new mount API
path only has things we need to support the new mount API, and then the next
patch removes the old code.  Thanks,

Josef

Christian Brauner (1):
  fs: indicate request originates from old mount api

Josef Bacik (17):
  btrfs: split out the mount option validation code into its own helper
  btrfs: set default compress type at btrfs_init_fs_info time
  btrfs: move space cache settings into open_ctree
  btrfs: do not allow free space tree rebuild on extent tree v2
  btrfs: split out ro->rw and rw->ro helpers into their own functions
  btrfs: add a NOSPACECACHE mount option flag
  btrfs: add fs_parameter definitions
  btrfs: add parse_param callback for the new mount api
  btrfs: add fs context handling functions
  btrfs: add reconfigure callback for fs_context
  btrfs: add get_tree callback for new mount API
  btrfs: handle the ro->rw transition for mounting different subovls
  btrfs: switch to the new mount API
  btrfs: move the device specific mount options to super.c
  btrfs: remove old mount API code
  btrfs: move one shot mount option clearing to super.c
  btrfs: set clear_cache if we use usebackuproot

 fs/btrfs/disk-io.c          |   76 +-
 fs/btrfs/disk-io.h          |    1 -
 fs/btrfs/free-space-cache.h |    1 +
 fs/btrfs/fs.h               |   15 +-
 fs/btrfs/super.c            | 2421 ++++++++++++++++++-----------------
 fs/btrfs/super.h            |    5 +-
 fs/btrfs/zoned.c            |   16 +-
 fs/btrfs/zoned.h            |    3 +-
 fs/namespace.c              |   11 +
 9 files changed, 1316 insertions(+), 1233 deletions(-)

-- 
2.41.0


