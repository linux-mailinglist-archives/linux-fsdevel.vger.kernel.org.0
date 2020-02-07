Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED846155A42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 16:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBGPCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 10:02:42 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38460 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGPCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581087782; x=1612623782;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QBmqK2hyrPjWSUot57VLilJic6MFv9RxkAql0uiJdCI=;
  b=rg4MRj0GYhnk8DGlSdjKVmJ4YhktBFBqfnxF4vpSSwztcJfXChBNA/GL
   KR0NJQhWxXEyO36g+fGv76YKzW8LBc0MFtVqZuInG2wLK2za49MBB9c7g
   epIwzFxLq6gnU2K2DM9KI681jcsZp8OGOXSy1PhptQpUL+i9/Ju7sA9cO
   HaXmw2sxC+tqSTb5CRu0Uik77X0VKNlS6tnBiLBbgm7AgwP/9xR5/LDqO
   1pMUgoHAZ1PdFYYRh0f0F8S3W0X4U8mMkC14+VoyF5rfjm1yWWa3WfWFl
   bta7Vahw+PEIF5vLd+PLss786WqQTveUFRhggkw/Zsmvyv2CmvcPTgmRw
   Q==;
IronPort-SDR: 39FJecUJquQzy0wMu/FtrGnyf22gz5/SUfuVFiahNPjBXOtCo9YFGQx9ZZ64kYjJTOljZJ356Q
 ddNYaYEj8LjcRdzk3sUTZRU6EBcJCH20lNq1CdKNdqWn2Z2EEIbiJbkUuz0laFd2ME3V4GroA+
 IofAcfxqGVSNYWfwEp3DRYjsbGh00I/36N6wD8oDRSbyUVlTos9fRr0k/Ic0d0D0RzulX+IvKo
 Mcf2Wk19t3lOVpZ/c1jVmpoX0WPKrluwpSK8wfi6qzJViGPJ0OwfNcY00LwHVAJlNabT8kBCuQ
 TFA=
X-IronPort-AV: E=Sophos;i="5.70,413,1574092800"; 
   d="scan'208";a="231121353"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 23:03:01 +0800
IronPort-SDR: 1TATuoZvowSkMJe0Mjha74okqJgM+4O4li0OzJKr+i/Ymji/7uTunfdvgERarGBhRYyqwrt0y2
 BhOiDCLuM6HLbPabm236ytvAMtM4Sx80VXv3MXygbz3ISaQh4lusb+js8tmXGu/CV58TAz30B0
 pMhE0h3iO2W8WfN9N2fpQQselCa3iegsJlBj5FIxXFtGq04lj5X7j+CcWUMZTuMD8+jc8wozP3
 dUFU0REuwguovhwW7efKrlBrrxfkuL7nODPCFRO1gxZN2XUNZIeb/uVqU1WOWQ8xVOhX4Ey5Co
 LY2BgQecv/F8ibktMoDchZ08
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 06:55:38 -0800
IronPort-SDR: 7eA1ie392Lcte+/6ZPFOwctwO3j8F7JxO/Dji0HmJLsH4xvr6Go6bUS5Kt1MV5am3dk8fjDiEJ
 Wohtpk+5mM4bLjrTEcr/WMHRPigY5zcH3PdTGb4LJcQ1UehucIlarcNon4bUChAbVDZByxs2ZJ
 7li1SywOcx7tHhupuWnmMDpBIsTcVSSv2e76Jp0rWIYkxYwtbyKN2923XhaMF7fbVVmStWGy2I
 pRjYvCc2MP0EBpgpPrSglr4YW3vCo81UJ2t6eTp19uGc9UZrSSCmAbZv4VfOnli9t7eZxSKgh/
 ego=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2020 07:02:41 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] New zonefs file system for 5.6-rc1
Date:   Sat,  8 Feb 2020 00:02:39 +0900
Message-Id: <20200207150239.685712-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Here is a pull request for the new zonefs file system (described briefly
below). Please consider it for addition to kernel 5.6.

The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:

  Linux 5.5 (2020-01-26 16:23:03 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git/ tags/zonefs-5.6-rc1

for you to fetch changes up to fcb9c24bef3d1d0942c50fb25fbb8ab45c7c3753:

  zonefs: Add documentation (2020-02-07 14:40:13 +0900)

----------------------------------------------------------------
fs: New zonefs file system

Zonefs is a very simple file system exposing each zone of a zoned block
device as a file.

Unlike a regular file system with native zoned block device support
(e.g. f2fs or the on-going btrfs effort), zonefs does not hide the
sequential write constraint of zoned block devices to the user. As a
result, zonefs is not a POSIX compliant file system. Its goal is to
simplify the implementation of zoned block devices support in
applications by replacing raw block device file accesses with a richer
file based API, avoiding relying on direct block device file ioctls
which may be more obscure to developers.

One example of this approach is the implementation of LSM
(log-structured merge) tree structures (such as used in RocksDB and
LevelDB) on zoned block devices by allowing SSTables to be stored in a
zone file similarly to a regular file system rather than as a range of
sectors of a zoned device. The introduction of the higher level
construct "one file is one zone" can help reducing the amount of changes
needed in the application while at the same time allowing the use of
zoned block devices with various programming languages other than C.

Zonefs IO management implementation uses the new iomap generic code.
Zonefs has been successfully tested using a functional test suite
(available with zonefs userland format tool on github) and a prototype
implementation of LevelDB on top of zonefs.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

----------------------------------------------------------------
Damien Le Moal (2):
      fs: New zonefs file system
      zonefs: Add documentation

 Documentation/filesystems/zonefs.txt |  404 ++++++++++
 MAINTAINERS                          |   10 +
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/zonefs/Kconfig                    |    9 +
 fs/zonefs/Makefile                   |    4 +
 fs/zonefs/super.c                    | 1439 ++++++++++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  189 +++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 2058 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h
