Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FBF225E89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgGTM3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 08:29:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47819 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgGTM3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595248150; x=1626784150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KALZF4NqHXC9qoy6I4teMnQITGGpyunub/V7H6Pi3g4=;
  b=m3mMb4O9e5p5RhTTFArF9oGUJlPz7N6bmqCf1wXUdMUjsD4JCKEZPJV1
   db2ua8cN2l4LXMCBzrEAucTsTdheY4ZJogySRIyNMTxIMnXJdLXN0tkQY
   uJ8ZhS/u5slab7lg8s6bgrf3ekzY/2I9CQfIjltzTrO/6D3fUJaKYz+ry
   K7BCPXSzFfqz0rv1ataST825/J3EUER/8XMsZYZoFQOJjlsm2O8d8r6gl
   BpVL/DAMSPo5RUpS8XM7Cm9tHMcPEYA0f9xMFeYwy7GYT8or/0LheZwb+
   jVHDT3FiEQB+61Y+A9iAhYNmrFVVqPDB6+cStTLiFUiLloN+IaPq+5Co8
   A==;
IronPort-SDR: ysLKdv55lkTtM7uVFYa7pmHRobtuvvLyOqbMRkqyEN/YatGuFGePVgUe1nNoioMwDyqlDQsrhk
 jOW61GPSC0a9/30/BABBQdfBITwva0H3kuMQili/qxfRlpOTrgJDSz75EPDvCWwYf6oIHm8CPy
 XQ5EhUzJwXC6DhzcdXqjqBAfcarsz5563vtpiPoRYD7KeF6GsozpDRgeWeaQA28qhpD3HIQ+m2
 aI4DI7sJ1y7OFXXvN6X1dG3AvbRwDUpvojjEnnSGrhKlwL6mju3g5dIfYPt+K/kWBJyvq7wAJ9
 o1w=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="142913129"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 20:29:09 +0800
IronPort-SDR: +CsYFt85CjRPFRV+ptHgKg5uOAfWS7nJea/7vpgep3AVkbfjg5dZKj3QMXjtiA4FQzQ/kUKJg7
 xypfmVuQrH0hS9iW4Latl84xG0fXD0HpA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 05:16:54 -0700
IronPort-SDR: n0mcHTyQF/59/L5ewSTPj3Sv7RdOcQbhduPOsyji3kaLK3HXKaBzYmo7m77I8a3mhCtKkURXiQ
 U8ddecWjW0Dg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jul 2020 05:29:09 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 2/2] zonefs: update documentation to reflect zone size vs capacity
Date:   Mon, 20 Jul 2020 21:29:03 +0900
Message-Id: <20200720122903.6221-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720122903.6221-1-johannes.thumshirn@wdc.com>
References: <20200720122903.6221-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update the zonefs documentation to reflect the difference between a zone's
size and it's capacity.

The maximum file size in zonefs is the zones capacity, for ZBC and ZAC
based devices, which do not have a separate zone capacity, the zone
capacity is equal to the zone size.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 Documentation/filesystems/zonefs.rst | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/zonefs.rst b/Documentation/filesystems/zonefs.rst
index 71d845c6a700..6c18bc8ce332 100644
--- a/Documentation/filesystems/zonefs.rst
+++ b/Documentation/filesystems/zonefs.rst
@@ -110,14 +110,14 @@ contain files named "0", "1", "2", ... The file numbers also represent
 increasing zone start sector on the device.
 
 All read and write operations to zone files are not allowed beyond the file
-maximum size, that is, beyond the zone size. Any access exceeding the zone
-size is failed with the -EFBIG error.
+maximum size, that is, beyond the zone capacity. Any access exceeding the zone
+capacity is failed with the -EFBIG error.
 
 Creating, deleting, renaming or modifying any attribute of files and
 sub-directories is not allowed.
 
 The number of blocks of a file as reported by stat() and fstat() indicates the
-size of the file zone, or in other words, the maximum file size.
+capacity of the zone file, or in other words, the maximum file size.
 
 Conventional zone files
 -----------------------
@@ -156,8 +156,8 @@ all accepted.
 
 Truncating sequential zone files is allowed only down to 0, in which case, the
 zone is reset to rewind the file zone write pointer position to the start of
-the zone, or up to the zone size, in which case the file's zone is transitioned
-to the FULL state (finish zone operation).
+the zone, or up to the zone capacity, in which case the file's zone is
+transitioned to the FULL state (finish zone operation).
 
 Format options
 --------------
@@ -324,7 +324,7 @@ file size set to 0. This is necessary as the write pointer of read-only zones
 is defined as invalib by the ZBC and ZAC standards, making it impossible to
 discover the amount of data that has been written to the zone. In the case of a
 read-only zone discovered at run-time, as indicated in the previous section.
-the size of the zone file is left unchanged from its last updated value.
+The size of the zone file is left unchanged from its last updated value.
 
 Zonefs User Space Tools
 =======================
@@ -401,8 +401,9 @@ append-writes to the file::
     # ls -l /mnt/seq/0
     -rw-r----- 1 root root 0 Nov 25 13:49 /mnt/seq/0
 
-Since files are statically mapped to zones on the disk, the number of blocks of
-a file as reported by stat() and fstat() indicates the size of the file zone::
+Since files are statically mapped to zones on the disk, the number of blocks
+of a file as reported by stat() and fstat() indicates the capacity of the file
+zone::
 
     # stat /mnt/seq/0
     File: /mnt/seq/0
@@ -416,5 +417,6 @@ a file as reported by stat() and fstat() indicates the size of the file zone::
 
 The number of blocks of the file ("Blocks") in units of 512B blocks gives the
 maximum file size of 524288 * 512 B = 256 MB, corresponding to the device zone
-size in this example. Of note is that the "IO block" field always indicates the
-minimum I/O size for writes and corresponds to the device physical sector size.
+capacity in this example. Of note is that the "IO block" field always
+indicates the minimum I/O size for writes and corresponds to the device
+physical sector size.
-- 
2.26.2

