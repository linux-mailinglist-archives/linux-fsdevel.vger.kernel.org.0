Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF774158EA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgBKMkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:40:20 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:38572 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgBKMkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:40:19 -0500
Received: by mail-pf1-f178.google.com with SMTP id x185so5455087pfc.5;
        Tue, 11 Feb 2020 04:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yA+BWfC41v7sN7/FMQVxmCc56IvmN2Onydier90xRBM=;
        b=AlZ44Cp4EzAxC2mEOY/YZHa3XOpAJLbuIfGtgIWpvcF6J6Ed06XGvOKNAg+HmDfEb1
         qUNtu3CuK7ekpsHnvbJ/EKmMkYE3dd6Qyilg4++kHOZa6yX4vsq80LhXrVA9Hrgv+WwT
         hmiweLgrtE36m/JxfHudCMLI8DkJParLFafOqEVjd45z8UoGY/DzyHAl5UaC2sdpeg9u
         nQXKDH6a2KI29Z0+SUEKcMeRBvztYJpYY88lXBOIhoSg6+jKPbQ3S1S58uPhtMZ2qyy1
         2LEJ7J5sXeb22E4gMDVYcDZpav8MkkdRjorrTrz+UC+YoqAa+SwcQt83Hcr5Ggk1SgNP
         80yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yA+BWfC41v7sN7/FMQVxmCc56IvmN2Onydier90xRBM=;
        b=jD5YgO0riUbX8XCjdDjnif3W9KIpp8RZccfCAvGLYDxrukdcZDrGkvrKHV47kZefwn
         NHLtY2RD3Ja7f0Y331tiiyNT+n5lB4A4R049RFOfrCLzwSFOxevMd1T9fKqJu6OPL3bI
         vifcoZSvH8MFcVYD3w8erlNdnuTnv83sA0KZntLnAp4mvalZ8xa2GV8fKQIX50hvyy8p
         d1UAPHcJuYyR61Jnssixc+MxjHqsPSwoKRE1NA92w0Xo/VPTyRqhTvykGu7PdsNCFPsM
         jfdXSJnfiiPTfVW5GRcqcvabbBau+Jd1qVOOBM9wX/cEx1C3uXrjQ3j1l+KL9BzOkMzA
         QXAA==
X-Gm-Message-State: APjAAAXj+k3qdoxgUv/15MjOmXbxHlzRm+zKIEoMl1MDIgqXjzKz9a0s
        3nfDXrYjBdwZlvs0r2pKFZ0=
X-Google-Smtp-Source: APXvYqyjoLPV52xzZXhOjrAFGK0sL31ZJwLKBgzsG7aHUr7465yvu6d8LIlHbK/SEBvE4Ee5t1FJmw==
X-Received: by 2002:aa7:8755:: with SMTP id g21mr6303821pfo.36.1581424819139;
        Tue, 11 Feb 2020 04:40:19 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:40:18 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 00/18] Rename some identifier and functions.
Date:   Tue, 11 Feb 2020 18:08:41 +0530
Message-Id: <20200211123859.10429-1-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset renames following variable and fucntions in source
Fix checkpatch warning: Avoid CamelCase
 -ffsUmountVol->ffs_umount_vol
 -ffsGetVolInfo->ffs_get_vol_info
 -ffsSyncVol->ffs_sync_vol
 -ffsLookupFile->ffs_lookup_file
 -ffsCreateFile->ffs_create_file
 -ffsReadFile->ffs_read_file
 -LogSector->log_sector
 -ffsWriteFile->ffs_write_file
 -ffsTruncateFile->ffs_truncate_file
 -ffsMoveFile->ffs_move_file
 -ffsRemoveFile->ffs_remove_file
 -ffsMountVol->ffs_mount_vol
 -ffsReadStat->ffs_read_stat
 -ffsWriteStat->ffs_write_stat
 -ffsMapCluster->ffs_map_cluster
 -ffsCreateDir->ffs_create_dir
 -ffsReadDir->ffs_read_dir
 -ffsRemoveDir->ffs_remove_dir

Pragat Pandya (18):
  staging: exfat: Rename function "ffsUmountVol" to "ffs_umount_vol"
  staging: exfat: Rename function "ffsGetVolInfo" to "ffs_get_vol_info"
  staging: exfat: Rename function "ffsSyncVol" to "ffs_sync_vol"
  staging: exfat: Rename function "ffsLookupFile" to "ffs_lookup_file"
  staging: exfat: Rename function "ffsCreateFile" to "ffs_create_file"
  staging: exfat: Rename function "ffsReadFile" to "ffs_read_file"
  staging: exfat: Rename variable "LogSector" to "log_sector"
  staging: exfat: Rename function "ffsWriteFile" to "ffs_write_file"
  staging: exfat: Rename function "ffsTruncateFile" to
    "ffs_truncate_file"
  staging: exfat: Rename function "ffsMoveFile" to "ffs_move_file"
  staging: exfat: Rename function "ffsRemoveFile" to "ffs_remove_file"
  staging: exfat: Rename function "ffsMountVol" to "ffs_mount_vol"
  staging: exfat: Rename function "ffsReadStat" to "ffs_read_stat"
  staging: exfat: Rename function "ffsWriteStat" to "ffs_write_stat"
  staging: exfat: Rename function "ffsMapCluster" to "ffs_map_cluster"
  staging: exfat: Rename function "ffsCreateDir" to "ffs_create_dir"
  staging: exfat: Rename function "ffsReadDir" to "ffs_read_dir"
  staging: exfat: Rename function "ffsRemoveDir" to "ffs_remove_dir"

 drivers/staging/exfat/exfat_super.c | 114 ++++++++++++++--------------
 1 file changed, 57 insertions(+), 57 deletions(-)

-- 
2.17.1

