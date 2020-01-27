Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F1714A18C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgA0KOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:14:23 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:52561 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgA0KOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:14:23 -0500
Received: by mail-pj1-f45.google.com with SMTP id a6so2766352pjh.2;
        Mon, 27 Jan 2020 02:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rjuMryPmuzxZLUVwYOvSS2lNQu9Hy6NwM2Wa5WwZ6xE=;
        b=aIaT3JXImsy3aXbKYi0Fcxeg5tlE90D5qQ+/NZKcO4TVgWecuPHqGJsUbrSmKtDgGB
         GetCxUnOH3jlCLK4X3IZVxO2+rwAljH3wYN8claKhhKoEfKvyQ2kgliBNpVQN7TYV2JV
         xrxKK+jQhyRHl8kZ+CIjgyS/RorI4GS22dGYldq66JErRq5/IZAm4PRPL0OpGKT+JDQm
         a+eMP1kKjByOma4Qmcqgz19PYqNT+KUhiuZOESUYJ8hV+yFDASSNLRToNzMo4DV1w0eT
         G4h2KrrFInoOG33Zs5vYQlHLDUIdllq8ub6NbvbqgCVVllVA1H3JUNf7ecxYslItKpvL
         89YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rjuMryPmuzxZLUVwYOvSS2lNQu9Hy6NwM2Wa5WwZ6xE=;
        b=e1WkJu6qx2ipnbIMdmJgrbmJva6wb7tT0nfmA2LD3tzF6j/gKOvJXDl2c9RbFuYBw7
         R5sLEHwXf75kQRYugkts1xRKNeyB5Z6kwmNdUu0l9U8hmY40K6VnHhKjpBn0BE2G8it/
         4Hb6U4d8YlpCtWF1HxQzvvJlA2MZDCib+GMRTMaKICJnnwC+qgII8C8dA1gwayAIkSAm
         89zB/AhbQC4IV29Y9bwsdomi9i/hlorBTWXs1Cl6hUYDlvs+zvRiYfVj1mWN7XMoYtHJ
         jeQp85+tfOZ0CYsbCYEjym8H7j36edYIBIvUQMDJ56/93mukgIRnALIn2IiJpY2F70VF
         LKdw==
X-Gm-Message-State: APjAAAWe9PkOKrhy9zFKL9iR4XvmETzHCFNZVMQcyE5CKdPMYmjlU8DA
        O46qYTvLnU4ewi3qnZi8Vm4=
X-Google-Smtp-Source: APXvYqz6f38Z1esCAAN37J4nFDTF0Db9fcFJcPrHXU/kX5lJJbqNF/Kia27iIdRvwyJKHx5omIfHsQ==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr17289956plo.282.1580120062576;
        Mon, 27 Jan 2020 02:14:22 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:14:21 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 00/22] staging: exfat: Fix checkpatch warning: Avoid
Date:   Mon, 27 Jan 2020 15:43:21 +0530
Message-Id: <20200127101343.20415-1-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This patchset renames following twenty-two variables declared in exfat.h
Fix checkpatch warning: Avoid CamelCase.
 -Year->year
 -Month->month
 -Day->day
 -Hour->hour
 -Minute->minute
 -Second->second
 -MilliSecond->milli_secnod
 -Offset->offset
 -Size->size
 -SecSize->sec_size
 -FatType->fat_type
 -ClusterSize->cluster_size
 -NumClusters->num_clusters
 -FreeClusters->free_clusters
 -UsedClusters->used_clusters
 -Name->name
 -ShortName->short_name
 -Attr->attr
 -NumSubdirs->num_subdirs
 -CreateTimestamp->create_timestamp
 -ModifyTimestamp->modify_timestamp
 -AccessTimestamp->access_timestamp


Pragat Pandya (22):
  staging: exfat: Rename variable "Year" to "year"
  staging: exfat: Rename variable "Month" to "mont"h
  staging: exfat: Rename variable "Day" to "day"
  staging: exfat: Rename variable "Hour" to "hour"
  staging: exfat: Rename variable "Minute" to "minute"
  staging: exfat: Rename variable "Second" to "second"
  staging: exfat: Rename variable "MilliSecond" to "milli_second"
  staging: exfat: Rename variable "Offset" to "offset"
  staging: exfat: Rename variable "Size" to "size"
  staging: exfat: Rename variable "SecSize" to "sec_size"
  staging: exfat: Rename variable "FatType" to "fat_type"
  staging: exfat: Rename variable "ClusterSize" to "cluster_size"
  staging: exfat: Rename variable "NumClusters" to "num_clusters"
  staging: exfat: Rename variable "FreeClusters" to "free_clusters"
  staging: exfat: Rename variable "UsedClusters" to "used_clusters"
  staging: exfat: Rename variable "Name" to "name"
  staging: exfat: Rename variable "ShortName" to "short_name"
  staging: exfat: Rename variable "Attr" to "attr"
  staging: exfat: Rename variabel "NumSubdirs" to "num_subdirs"
  staging: exfat: Rename variabel "CreateTimestamp" to
    "create_timestamp"
  staging: exfat: Rename variable "ModifyTimestamp" to
    "modify_timestamp"
  staging: exfat: Rename variable  "AccessTimestamp" to
    "access_timestamp"

 drivers/staging/exfat/exfat.h       |  44 +++---
 drivers/staging/exfat/exfat_super.c | 232 ++++++++++++++--------------
 2 files changed, 138 insertions(+), 138 deletions(-)

-- 
2.17.1

