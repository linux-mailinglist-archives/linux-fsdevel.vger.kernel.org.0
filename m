Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524A611DCD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbfLMEKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:10:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11856 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbfLMEKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210253; x=1607746253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0WeNiviBP14DuhLCsntNThKBR+o1UaBlFRIbWtyJ5/Y=;
  b=OjToC+dRaCHMfP2UOCPCeKjky01LfiPmdUxkJWal4uUFy6St7zgDvw7I
   84+EBS4LLXadtDAle7+GpesmjdWjrbwwnBllGa3QKxjriQdEAsE62Euhf
   JWMFofZo+8w+GSi6ssZgUkOMAJW6khzPkz8zY7OPbcys/vHt/Kg/IZ9oe
   iI8BK7YO7v5dTnfYReC3yxawfd0M8I+LwaFRphvo2IgwrbSSagQki5T4y
   x65P+PCWOo1lAhnzjHz0eXn4JEsCf8zfJPQRyYv3ESLRBIEh8Qv6tpczi
   jZZh8ZHbq9fs4s9svVhqWOaNGQ7yX7eC1goDNhuoeKVDLY6i1pbWeWPyE
   Q==;
IronPort-SDR: GuZvNoYK/g0AAHaJaeqWjGUHQE4l41rk/HIhKM6W6VIMRXUMR8QtKmtCi45kYHaNUDMKARqJwx
 a3ZFQYZgn3UUratAqZV814litA5eIc71RsrCz9VO1Ki+R2elxsMwvNLZG72YjpcHkWjsWkTQ1j
 e51jMRIlz56yEk4wpo8DPtwZZIr/Bx3ctrm9NV9MijDv7p+zyrBbBMi5TbS3wpxtY6g8T4KGgZ
 LIlaULCV63ac3MYLwR0IS9DhsreQMIxNFMbuUwPVRSXwk+TG5rxJ9ksWVqlgOAvuB2lkizX8Ef
 m1Y=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860115"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:10:53 +0800
IronPort-SDR: aE3MZMWUWlWZAsCHHt6nAQDugJMsh2f7KO/8yjoc6Q8F+/EbeZF3C5D7w5/YkRF7xVjXDW5gy3
 swr0XmZp73kd8aLt+UZH8K8p3ueDYsDszkBcDDzG/tx7vWnFy6R9mYBjL94k2qE/UFKniPpYQK
 sG6t+R3nf+oALWYsd6O+qKON9aaMMXUnf+pLRSmBQ0Ikyjad8bh6jTqMgeAgo3P7Cl+8YIClPN
 Di+GscARUhli7fCU9KQcbyS5hZv1KBtNQSa/pK8LHoaPrQqyE0Fky1n4jb6aLMSjid3RDMuPND
 /ihFjA1ljb84PnvvDPfBWiZE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:24 -0800
IronPort-SDR: r56pajcUqlwr8ChV1Dnb8IcDyHhOXKjFQKM2XQYxoSIOsZvwViwOdzR5Za06jKYvGfZHSrcTqU
 TIyLu4YQCnYOQmrJ5Ez978y6GWeCB3pggS51Qa808AbXGWHxUpDMeinW6SQLZExoYlmU2Cg329
 S+wLuEKHuHAffdGk8QjHZs3SKwZsSB3SxjB6EAvrrOH707bmXfEnUpLcJWy1FFPiwJVlsUxV24
 wg0rQQPataJYRWPZkWLtKNLlbwA/oaXsb1kkwfuqnIhT4nUpMkvjyvnBcsHJ7SK25S/fZsfteA
 jIg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:10:50 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 07/28] btrfs: disable fallocate in HMZONED mode
Date:   Fri, 13 Dec 2019 13:08:54 +0900
Message-Id: <20191213040915.3502922-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fallocate() is implemented by reserving actual extent instead of
reservations. This can result in exposing the sequential write constraint
of host-managed zoned block devices to the application, which would break
the POSIX semantic for the fallocated file.  To avoid this, report
fallocate() as not supported when in HMZONED mode for now.

In the future, we may be able to implement "in-memory" fallocate() in
HMZONED mode by utilizing space_info->bytes_may_use or so.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0cb43b682789..22373d00428b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3170,6 +3170,10 @@ static long btrfs_fallocate(struct file *file, int mode,
 	alloc_end = round_up(offset + len, blocksize);
 	cur_offset = alloc_start;
 
+	/* Do not allow fallocate in HMZONED mode */
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED))
+		return -EOPNOTSUPP;
+
 	/* Make sure we aren't being give some crap mode */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
-- 
2.24.0

