Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E643914CEC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 17:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgA2Q64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 11:58:56 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:42674 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgA2Q6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:58:55 -0500
Received: by mail-pg1-f176.google.com with SMTP id s64so55367pgb.9;
        Wed, 29 Jan 2020 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eD+vRWY6gNxHaAV067ybERz640J/iRSAZ6Igbxb8aJA=;
        b=LzePr+ho2mkMe7rrNfWRFX+CZgPIUeo9UTtw7QPUjt74C05Xi6AAXoWzxFDL2OQfPp
         XE2FnCXuNWtEkD/9MhuOc0BEN8hJQVcJSk0VoOav/PF4eEwSLVcoaxWJx6WMjSwDBfh7
         biWGjzQFxbwgYH1YlpeSbMZ510lZq8uTMreaXWXUfG/QwipOfChGjk4lc3CX929NjZ8Y
         JJ7yLtWJb94bl2oW/deQvXy+zQbzP2C/lULG6lAE3iD9OUOyeqZ6EC1iegdxOTKyl0xh
         qpbnFODvHEN0BVVdDv3/cBdVL64i/V26f+QaUYHB9aVHPaC2TAo0B9kqXR0nNkOK8MaU
         76+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eD+vRWY6gNxHaAV067ybERz640J/iRSAZ6Igbxb8aJA=;
        b=gjSU4e1TDS3uyzT4XXriKQyj5JVlSpOzT5xhMKfvwMOto0nSN1HHDK+2aLI978aVGO
         +S9pAskH24xdGe2tO3mpu/BRXbJ4XR0sHeeKQSGQWIU4nS0XCG4aUSZGhekrefO7sHIq
         HjKHCA+ae8c9KELsuFAyPsI5k18Qek6WHX/XTU02OFyanHtDYgQcYbDiBSbPv8+MslYv
         R1fQtYK4oxPJ9VvYRy0v/WTa3Q3ZKpu03llULj36kWi2jLxRBpGsx6L56klrYBtrafVc
         5GPGHyyTtuYU731RSlRbFUp5sYgdKWFwDhE6lR7yVy0VwQny9TWpybmEK6LeDKcO40zW
         hJLQ==
X-Gm-Message-State: APjAAAXMF62vBmdQBuX6OVK8SBL5wdQan0cRMGkcdVKw+iqwWvYzWkDq
        yMs/dotoQ/yyhoeOpjQKhKc=
X-Google-Smtp-Source: APXvYqxs/Jl7PMhYtjwLBwzCSSLuYsfivJj3Uv7KEyLY8Gtm/XNRdAwennWZZ0/+2Dr0Yhxg6rPsYg==
X-Received: by 2002:a65:66c4:: with SMTP id c4mr32175251pgw.429.1580317134361;
        Wed, 29 Jan 2020 08:58:54 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.08.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:58:53 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 00/19] Renaming some identifiers
Date:   Wed, 29 Jan 2020 22:28:13 +0530
Message-Id: <20200129165832.10574-1-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset renames following nineteen variables in exfat.h
Fix checkpatch warning: Avoid CamelCase
 -Year->year
 -Day->day
 -Hour->hour
 -Minute->minute
 -Second->second
 -Millisecond->millisecond
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

v2:
 -Correct misplaced quatation character in subject line(s).
 -Remove unnecessary '_'(underscore) character in renaming of identifier
  MilliSecond.
 -Drop commits renaming unused struct members.
 

Pragat Pandya (19):
  staging: exfat: Rename variable 'Year' to 'year'
  staging: exfat: Rename variable 'Month' to 'month'
  staging: exfat: Rename variable 'Day' to 'day'
  staging: exfat: Rename variable 'Hour' to 'hour'
  staging: exfat: Rename variable 'Minute' to 'minute'
  staging: exfat: Rename variable 'Second' to 'second'
  staging: exfat: Rename variable 'MilliSecond' to 'millisecond'
  staging: exfat: Rename variable 'FatType' to 'fat_type'
  staging: exfat: Rename variable 'ClusterSize' to 'cluster_size'
  staging: exfat: Rename variable 'NumClusters' to 'num_cluster'
  staging: exfat: Rename variable 'FreeClusters' to 'free_clusters'
  staging: exfat: Rename variable 'UsedClusters' to 'used_clusters'
  staging: exfat: Rename variable 'Name' to 'name'
  staging: exfat: Rename variable 'ShortName' to 'short_name'
  staging: exfat: Rename variable 'Attr' to 'attr'
  staging: exfat: Rename variable 'NumSubdirs' to 'num_subdirs'
  staging: exfat: Rename variable 'CreateTimestamp' to
    'create_timestamp'
  staging: exfat: Rename variable 'ModifyTimestamp' to
    'modify_timestamp'
  staging: exfat: Rename variable 'AccessTimestamp' to
    'access_timestamp'

 drivers/staging/exfat/exfat.h       |  38 ++---
 drivers/staging/exfat/exfat_super.c | 232 ++++++++++++++--------------
 2 files changed, 135 insertions(+), 135 deletions(-)

-- 
2.17.1

