Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780C4365497
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 10:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhDTIvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 04:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhDTIvo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:51:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0621D60FEE;
        Tue, 20 Apr 2021 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618908673;
        bh=5d/i9+HgBPPIbeM5Ncltph3uy36+LjfabKTydziTuzI=;
        h=From:To:Cc:Subject:Date:From;
        b=K1GZLg5BNfcud3M+O+d48O4++/eNqXZTd0y+x+sDL+0hutPGtDnOzKPZ8ynHgIbte
         rVkB0R4hTvb9ID6UpoLeIItj8UMTiY7/aZJcbH09TZ1n/8mUhdDRfV2Jca4EYp6Uwp
         07xQQiCr4w6952ejc3HYS/3F+xNMXj8aSdLVjpaQHM1ro93Hr2FD4uTPStnswJGa0F
         y4vAWNs+v0UT/VxbWqIp2R1ivdRRI8TcIxHuqYt0J6K6LbWoL5gahUST344zq95mBZ
         wkmyYb52fGW51+1OrOyL6I1VCgH8rWg+Gg76sQB29YS5fkFKZ5kNwTWSLbBklYG3kS
         vEPoCpExdLHrA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] docs: proc.rst: meminfo: briefly describe gaps in memory accounting
Date:   Tue, 20 Apr 2021 11:51:05 +0300
Message-Id: <20210420085105.1156640-1-rppt@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 Documentation/filesystems/proc.rst | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 48fbfc336ebf..bf245151645b 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -929,8 +929,15 @@ meminfo
 ~~~~~~~
 
 Provides information about distribution and utilization of memory.  This
-varies by architecture and compile options.  The following is from a
-16GB PIII, which has highmem enabled.  You may not have all of these fields.
+varies by architecture and compile options. Please note that is may happen
+that the memory accounted here does not add up to the overall memory usage
+and the difference for some workloads can be substantial. In many cases
+there are other means to find out additional memory using subsystem
+specific interfaces, for instance /proc/net/sockstat for networking
+buffers.
+
+The following is from a 16GB PIII, which has highmem enabled.
+You may not have all of these fields.
 
 ::
 
-- 
2.29.2

