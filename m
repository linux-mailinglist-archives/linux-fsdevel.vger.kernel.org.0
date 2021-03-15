Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9833AA24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 04:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCODtd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Mar 2021 23:49:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29592 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCODtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615780180; x=1647316180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WbfHYkpK1Dek9W07jiOtlFKrqQVOub8bMeNjGa478pQ=;
  b=alOdvrF55kdfJyANAWdp9MfWkhX89M/dROKxqdXZiaFJxRZiRJ/x6YjU
   UhqL0sJ+hPhQljWelcn/S4fh5fvkSn8xuGWg4vgmHEDS0q/309XHAHudL
   4VfeXMHYcnljl18+kW4H0OBq8odLXJlhRH73tCCeeqzrtZaZwNfuYAjT8
   7C8wKNtiNOo+X2EZX4KKmYMzdU+Z5fJb7Sp7zYKhN0YAxz+yvDfU/Hzw9
   keTy1doyBRashBQbM02+nU0Hvfs7E6NVDt4KiXLFDM5Fx9B4ULOjMUPdx
   alx6kHJManspTncu4laVgHemtZ8Cc5SR8jDwIbF86ndXlETGvmJoVqvEa
   w==;
IronPort-SDR: AhUJZnc8KuIvfqi/eW/NWhuM3jcN4BvOPKnjRc5LjWaMa9bkC7q6l3JfGtR4pIQLPTNfmspQuX
 KSPNKkQTTkSxD+IprXMH2QgxZBFbyn2/mQbcIwrIjecUv+Yg9z83EAl5P3J8T936cH4kGstDMJ
 nMWIVp2eUaT2jViBXhjgPRbJF1kWDrG41LsZeE33EKF4SaaLeBnB90igK+XHGcRyGlFUtttFo4
 h7E21M28R61y1I2ok7Hln58frpb082mg8nYjqXC2LjOFYvCdQr1FiQ43aWYX1F18uflQETJkq8
 bZw=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="266509449"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 11:49:39 +0800
IronPort-SDR: PxqJrvgYEc1fnrHFpLqXsiWF9DYRrYcjfRoTZv0WzfMq+UhOAOC3/BmHhJvKPFc6VgL60C6Xtz
 74673KW227FRHOBEWPd6wsg0NTyG0Jsut8YFNfHw+mONWcJwtgDkrMazKhDhB7MwlZfZ1pzdjx
 Z9Q50XgeGnepPSSd0YowpNHc45Ogp4wELFcIL0RLQbZKS16Khfy4qq4YxA9byPuHymkK1lbJ8W
 qL6BQz0H/BGcZs8HyZwoMz710tM14kiRkhX7EcgDNHDPn6duNa/s1LV9wQMUa8KrhUsel6BPQU
 E1cHzk6SS1J/Rp+50saEzAfg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 20:31:50 -0700
IronPort-SDR: DdTYgbLNyoGGildsRfknsch4YV7/T9Y9ZHzGi+qj5fVXM03/bR37q2jPaD9KEDvnxJ3dEy/7EW
 nLl9ObbLGRRO6outu2kr8qLssgXX/mC84O0EvtXLUmPH9zE9RR4eZIrA/CLzM9iKIScuAV23c6
 wgdt3SjS95/k28Pijt3DmONFG4LgsRNup0ddFcZf1o3qADuCXDfuSwj/YEOdRuwn26d9UcOi0+
 hYSu94LS/MxnOyiyIZ3ZmwCDzR6fHMY4GjS564Rsb0utL9DCimy6OSKPrGjFbUnTgqHSsCNNjR
 GAs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Mar 2021 20:49:20 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] zonefs fixes
Date:   Mon, 15 Mar 2021 12:49:17 +0900
Message-Id: <20210315034919.87980-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A couple of fixes:
- prevent use of sequerntial zone files as swap files
- Fix write offset initialization of asynchronous append write operation
  (for sequential files open with O_APPEND or aio writes issued with
  RWF_APPEND)

Damien Le Moal (2):
  zonefs: prevent use of seq files as swap file
  zonefs: Fix O_APPEND async write handling

 fs/zonefs/super.c | 92 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 10 deletions(-)

-- 
2.30.2

