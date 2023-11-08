Return-Path: <linux-fsdevel+bounces-2413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB87E5E31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24A32815E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58C36B1A;
	Wed,  8 Nov 2023 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pkjoDkeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E811358B4
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:09:15 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F0F210A
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 11:09:15 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-da41e70e334so41556276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Nov 2023 11:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470554; x=1700075354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iUyZnOjJjsmbC01W/BiV4K6usM0tPRe0taxMLlODapo=;
        b=pkjoDkeY0AgTHb1WCAseTQFj3XE0f1y6N8xL0PZjjP5NJoHVQvct4yz6dnUuT7n/fd
         4D8ynP7ZQa8q5xiDG4Yu0f63IxPGzdAUDT33nspU2B/9Jnhie+7pUnqeDqq0RH0zsPIO
         TTKs6mO6k6SapWs/T7D1Pc6tcE0y5egdo2G25ofktvQ1hpT8/f9TK+p85kgp18IywO4T
         EfHCfAZCYvHubmBNK6AyLG0PaCqGsLARjJag+4HGylKdD2rinmWJRJNR03MU9GrNDzgA
         JTaKVLQUycPfbtQX7Yo+59aat/cdWdLzwqAPhQSqxkf5uCu+S/Imqed2otulu4j17rbr
         msUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470554; x=1700075354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUyZnOjJjsmbC01W/BiV4K6usM0tPRe0taxMLlODapo=;
        b=qrAeGuKtYSAiTjAsitNM9YjlMarEn9mrvMH7vvkWEmxTnh55Q+Rdtl75YpgMIkVQ5W
         NlASECxwRbSK9P1JcBUUHpxVWa6Usim8EUdXNlyoCs9gbtPfu+RU6CtFr+dnPG6T9Yoo
         ocZF0+KdiujqKY5SUGGFGdN2/uz+Jx8kfFx6f1zSkrLTOd3bq4wm/vhahaH2OSgBI5Yj
         8CLoDty7EOmgCSBh4XjtW9VkFhNDOqxQ8wSOlh11fqgHjbIVqw7rHiM92bbXeRF6F55h
         rqi94TBUPVScRar/EMSjonZuPNGBbrTYHKMrcPf20zE6JwLfWp7plTUtcBv82X+XmyTd
         rNig==
X-Gm-Message-State: AOJu0YyiN4MrI9paWDq7q/GZDAYtoI1RAnauEIs7uNcn9uLGnfeyUDRy
	c49hyB63ucOdy7/pZ8/WNpXvCg==
X-Google-Smtp-Source: AGHT+IGe9bhzz0CbMGYg6WVlHryz/4bG4PED2D0pn+K78rjG5d11rPnM296Y2+SbRoxG8aLyB3TpBg==
X-Received: by 2002:a25:458:0:b0:da0:cec3:b62e with SMTP id 85-20020a250458000000b00da0cec3b62emr2600387ybe.37.1699470554186;
        Wed, 08 Nov 2023 11:09:14 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id mg3-20020a056214560300b0067266b7b903sm1375657qvb.5.2023.11.08.11.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 00/18] btrfs: convert to the new mount API
Date: Wed,  8 Nov 2023 14:08:35 -0500
Message-ID: <cover.1699470345.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1->v2:
- Fixed up some nits and paste errors.
- Fixed build failure with !ZONED.
- Fixed accidentally dropping BINARY_MOUNTDATA flag.
- Added Reviewed-by's collected up to this point.

These have run through our CI a few times, they haven't introduced any
regressions.

--- Original email ---
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

 fs/btrfs/disk-io.c |   76 +-
 fs/btrfs/disk-io.h |    1 -
 fs/btrfs/fs.h      |   15 +-
 fs/btrfs/super.c   | 2421 +++++++++++++++++++++++---------------------
 fs/btrfs/super.h   |    5 +-
 fs/btrfs/zoned.c   |   16 +-
 fs/btrfs/zoned.h   |    6 +-
 fs/namespace.c     |   11 +
 8 files changed, 1317 insertions(+), 1234 deletions(-)

-- 
2.41.0


