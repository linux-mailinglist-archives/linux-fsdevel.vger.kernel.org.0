Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C4E390779
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 19:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhEYR0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 13:26:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:64419 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233843AbhEYR0F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 13:26:05 -0400
IronPort-SDR: yQXy72p4RhOsRFvPtEPUXo1Qv8FhMGbRx+2dh8zwCi9yMkqs+FldGFz74kpuTL/Ip0I1R0Cp3Z
 SD0XreOdPNHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="263455898"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="263455898"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 10:24:31 -0700
IronPort-SDR: phfggWgNLR+OEITYNCKR+FSU1N+igJaimCfyyQRnn6BU4aGXy6eHEKgMktaWLux9JUXTuzCUC2
 sUGLMEVaQUeg==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="476514285"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 10:24:31 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] DAX Small clean ups
Date:   Tue, 25 May 2021 10:24:25 -0700
Message-Id: <20210525172428.3634316-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The following are 3 unrelated small clean ups in the dax area.  They were found
while working on PMEM stray write protection.

Ira Weiny (3):
  fs/fuse: Remove unneeded kaddr parameter
  fs/dax: Clarify nr_pages to dax_direct_access()
  dax: Ensure errno is returned from dax_direct_access

 drivers/dax/super.c | 2 +-
 fs/dax.c            | 2 +-
 fs/fuse/dax.c       | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

