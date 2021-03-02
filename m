Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C876432A526
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443438AbhCBLrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:45 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44674 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837936AbhCBJOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614676476; x=1646212476;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pWho99CX8J/m+QKCgx9e31BS+yKKfXPSH+48+ad5uGE=;
  b=PA6Ww37fbmhjl4yxvNiOSjLMa37ZXPNrZqgl/xeV6wPwCbeXeasKfnRg
   2okgHOy4DyBRwiOYuKXNDCMLRB1pIfgaYJdwnLG2MjCvIxutX15t2Se5l
   nWST97IK98605NqIYoJQLJjcElo2ERmVN7iFv+49e3vsya4q05EMm8Hro
   zP6H33bD5fJ9rXUEUTWEXgbvAIbL8oktFprVAwiaghry53TBWTg4nEFrT
   K53GOX2VLk8Hns4/LX1wEr9qI9mHO2de3v3bOuBGr/JcABlyfVkI9mPib
   RzysVytPdixoI8Ty/r6oYLfDZ93pu1x1F+7UZ349QARAjQFrLLsn7CMEz
   Q==;
IronPort-SDR: BV5pPDCkyU6ZOzOEE9dzcq2K5sLJJxJEPxdJEtUpdDmrayUD8NNIxWfJN5GQv8zPuNtZ//TUiI
 dPmZBq9YCI49MYigXBuLxrrJRFnWUdHzBRRYepzik+sobeWSDfYxkasb7fnRr+GrO/lSCISSMS
 Xnm0uh/DLtVRO61rtf12IVPBP+in1cfgBTRhYEW18oDzB7ur3KJ8DnwHDN2CIG82V+C6iP9IRt
 S4XRbd+zubENvnY02jBZAIWGVhvzggAfvp6MsTzeTZ7O7qwP6iPDMzCg1s8w1DVkX0R/glT6n2
 WHc=
X-IronPort-AV: E=Sophos;i="5.81,216,1610380800"; 
   d="scan'208";a="165623455"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2021 17:13:13 +0800
IronPort-SDR: ypIhiug/dnybepMxppDQd2Tl4db4zSL51QjkZ5JUXZAqE8uwJHStMj9xAbCXC9+HBOKDLHakE+
 AwIKZu4kDxYtnLo2dzjk9/55tIGxyhMDSJ9aqevw4RoD4T2bqsPXXlSU41dH72XSX35win1PT+
 3RCM7582MJA2ZtlcspjqxlzcvdXRGKH2jojX458APVU1VK5NzcDXFTu6C8tpIybiLDqjhA1HC8
 QGezHVGk87Ak2mn8DYluL+dR2L0gREOW0eIDHb6Y5C8kto+WKMWMC2RROISCmJwJyDh5+sd9oN
 4tQ1ZCEDAy4Ony3aaK8USgrB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 00:54:29 -0800
IronPort-SDR: jtxGDu0vt0Qu3USRoL+MTat/Qiwdc7RWDCpfJffIkjBJW2A0oZW3fzrdzpjO7ckDI3fySmhh8b
 nNzztvOxl0xs28rwoyrtyCCvO18kiCqUlEtsRSyBNrJ6hMGKWyT+rKNS2zd2f02HzFI44vAap/
 A/khX6dVsxLfjZWqkNlcJYCpnx3IFXEjJYUBDsGmdH9orY6c9hXh1Tq6gs0fqm7WyhFJClbHSZ
 3NXfkZykTDcmuT0nCXYB6JB1AQDrRI6wyS4rttGC06ukORLXoV24V+CC4mdBBo96P/WZu0R8XI
 2JI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Mar 2021 01:13:14 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] fstests: two preperation patches for zoned device support
Date:   Tue,  2 Mar 2021 18:13:03 +0900
Message-Id: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As btrfs zoned device support was merged with 5.12 here are the 1st two
preparational patches for zoned device support in fstests.

The 1st patch adds missing checks for fallocate support to tests that are
lacking it and the second patch checks for discard support availability.

Johannes Thumshirn (1):
  btrfs: require discard functionality from scratch device

Naohiro Aota (1):
  fstests: add missing checks of fallocate feature

 common/rc         | 8 ++++++++
 tests/btrfs/013   | 1 +
 tests/btrfs/016   | 1 +
 tests/btrfs/025   | 1 +
 tests/btrfs/034   | 1 +
 tests/btrfs/037   | 1 +
 tests/btrfs/046   | 1 +
 tests/btrfs/107   | 1 +
 tests/btrfs/116   | 1 +
 tests/btrfs/156   | 1 +
 tests/ext4/001    | 1 +
 tests/f2fs/001    | 1 +
 tests/generic/456 | 1 +
 tests/xfs/042     | 1 +
 tests/xfs/114     | 1 +
 tests/xfs/118     | 1 +
 tests/xfs/331     | 1 +
 tests/xfs/341     | 1 +
 tests/xfs/342     | 1 +
 tests/xfs/423     | 1 +
 20 files changed, 27 insertions(+)

-- 
2.30.0

