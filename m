Return-Path: <linux-fsdevel+bounces-598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCA87CD8BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03D02813F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B50C18AE4;
	Wed, 18 Oct 2023 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv9ycBMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06518649
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 10:00:08 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E2DB0;
	Wed, 18 Oct 2023 03:00:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40838915cecso7654545e9.2;
        Wed, 18 Oct 2023 03:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697623206; x=1698228006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSUsPdrEDK7N4am6eycVRaEwUoir6ejGY8R+prw+wOs=;
        b=Vv9ycBMRi2HRfGLsZWq64/lms3qJ/Sxf1AstZyJWcAdCFZRUQ1kLVwjvhqp5S0kOvt
         sO5A+O3TkPkiJ/z8PuBfurzMUK34CB6gUbfs7xKkARtJJmFAhfhz8ananZbiVyVwrwjS
         W8yy+WJPPK7zfRIabfMygI9S0B/UnjXjVHeHPJhDIhwttT0/0VOamyK4IZQIGS80I4Gp
         7x7Ckx7ug3M5UT3RNmFhE58gNm0DPGbVqLgFXxj6/bFyIkDA7NXufx4EynC57MCCRYDM
         ZY7sLYrXtKaDmoU0m5r3RPz6CGULj9leW8f2GGaba4GprlUrePyryRAfOU0g+Z3SOyzH
         VFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697623206; x=1698228006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSUsPdrEDK7N4am6eycVRaEwUoir6ejGY8R+prw+wOs=;
        b=M18LArjG65X2SMoUhosAimNv9pA64KNMjA+TcQhQY4uVeVOlR/dHeqWSB6KJybrUZA
         VR8+0KRtb5d3gPAWVpGTxUDUh8FXb/QiYODiP+76QzgckmZLqIFyFfEh+sMgfKWELcZZ
         OdCURRRAi5DdLLn3yU2T1C1UY008AFWh54L28P6klAySe5ZTRIVJ6PNKrq6MmuRPWDIn
         yu+127Hd9kjnqbO8bfR0/rsz2gVy4md1Nz75EFk88lZbuuqZ7XXAtFq9zpBqdn8MjpHF
         Sttk09UfDRBmG5FADr2iF3Jh5msbt9kZvDMtYP1Vu5Ro0REqO1TaxRPNILIzWAFGGb6r
         kDQw==
X-Gm-Message-State: AOJu0YxF9GDWOrQmiXytfQVqffk9mNSRspQ5W5CP6HCKGg0OZcYDUYiX
	BytbJIQPsjCOBsztwCfMRsw=
X-Google-Smtp-Source: AGHT+IEgC+1w2SMJFe1IGOcv00vSJgNJzXySO/VeHU0D5IGDkHaEzUug4bL5zWBCW94lBtjMIC0azw==
X-Received: by 2002:a05:600c:4f85:b0:405:3a14:aa1a with SMTP id n5-20020a05600c4f8500b004053a14aa1amr3892121wmq.18.1697623205352;
        Wed, 18 Oct 2023 03:00:05 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id y34-20020a05600c342200b004063977eccesm1222017wmp.42.2023.10.18.03.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:00:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/5] Support more filesystems with FAN_REPORT_FID
Date: Wed, 18 Oct 2023 12:59:55 +0300
Message-Id: <20231018100000.2453965-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jan,

Following up on the plan laid out in this discussion, this patch set
implements the simpler and less controversial part of the plan to
enable AT_HANDLE_FID for all filesystems.

One filesystem that I tested which gained FAN_REPORT_FID support is 9p,
but there are many other filesystem for whom fanotify will become mostly
inotify drop-in replacement after this change.

Since the main goal of this change is to progress fanotify towards being
an inotify drop-in replacement, support for FAN_REPORT_FID with sb/mount
mark is at lower priority.

Because I think that support for FAN_REPORT_FID with sb/mount mark is
controversial with non-decodeable (AT_HANDLE_FID) file handles, I have
also disabled this feature that was added in v6.6-rc1 to ovelrayfs.

If you agree to this retroactive change, the path #1 should be fast
tracked into v6.6.

The rest of the changes should probably go in via the vfs tree after
review from you and nfsd maintainers.

Thanks,
Amir.

[1] https://lore.kernel.org/r/20230920110429.f4wkfuls73pd55pv@quack3/

Amir Goldstein (5):
  fanotify: limit reporting of event with non-decodeable file handles
  exportfs: add helpers to check if filesystem can encode/decode file
    handles
  exportfs: make ->encode_fh() a mandatory method for NFS export
  exportfs: define FILEID_INO64_GEN* file handle types
  exportfs: support encoding non-decodeable file handles by default

 Documentation/filesystems/nfs/exporting.rst |  7 +--
 Documentation/filesystems/porting.rst       |  9 ++++
 fs/affs/namei.c                             |  1 +
 fs/befs/linuxvfs.c                          |  1 +
 fs/efs/super.c                              |  1 +
 fs/erofs/super.c                            |  1 +
 fs/exportfs/expfs.c                         | 50 +++++++++++++++------
 fs/ext2/super.c                             |  1 +
 fs/ext4/super.c                             |  1 +
 fs/f2fs/super.c                             |  1 +
 fs/fat/nfs.c                                |  1 +
 fs/fhandle.c                                |  6 +--
 fs/fuse/inode.c                             |  7 +--
 fs/jffs2/super.c                            |  1 +
 fs/jfs/super.c                              |  1 +
 fs/nfsd/export.c                            |  3 +-
 fs/notify/fanotify/fanotify_user.c          | 25 +++++++----
 fs/ntfs/namei.c                             |  1 +
 fs/ntfs3/super.c                            |  1 +
 fs/overlayfs/util.c                         |  2 +-
 fs/smb/client/export.c                      |  9 ++--
 fs/squashfs/export.c                        |  1 +
 fs/ufs/super.c                              |  1 +
 include/linux/exportfs.h                    | 46 ++++++++++++++++++-
 24 files changed, 133 insertions(+), 45 deletions(-)

-- 
2.34.1


