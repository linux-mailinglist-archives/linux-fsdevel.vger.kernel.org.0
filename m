Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C43504A5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 03:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiDRBPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 21:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiDRBOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:14:54 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9211E13E99
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650244337; x=1681780337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fuEz/yS5Uj5qb4Eh1zAo17+VVdsf2qNASubyRaV5x1A=;
  b=DjjyNNoTpv6xAucdJcpyLvyLW9TO/Mz8rKEgmKB+7vF5UfIDrsQqQg4d
   T70B25X0RwIoPf5wPQE8aBEPi1cfpHYEI6B1c8+W5s3n7mTOdhssD27CA
   Eh/Wu21imURl24DSx2bu4CeVG7OGr8pz4qmGD0tGpiMtkPjGM2RiX4XJy
   rUXewvLj8ulmOr76dCyfzer9+vzTtL3EDb5XREOrP5g4Jcux89TrMhT43
   X9O2va352q2NAA3CNDYulkL39/8OlAwowEka+4x72mbRHira0TbrDFa5a
   hpCiE7sc72YDLJmNV1Y8NRQW3/K1ZBv8wOqrdgLRQvWOU4pe8Yz1f0+yx
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,267,1643644800"; 
   d="scan'208";a="302313776"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 09:12:16 +0800
IronPort-SDR: yBxOFAEHckt31LBt1W7/l9kanOvHE0bT5VN2I+0L0r6/ThjhnDfRCcD0NIHmXSbCuuMUA39bUy
 WFpq11eEoQpKC02dLjr3IoXYuJi8GDFZjZ5dmKgZlpL4hgJUR06Jo1WBV337iIV8rULGCRfcDV
 +yo8pug01cf1Vu6TqsMGdpWgEYDMcnmBjGCUS09+3DZWfQw/oS75VPdHj1dvMELGJrWabJL/OP
 0MvvJv5MKLnpr4mYbsRH7nvrPD09F9EN1hN4NGgFrR3Gj0l3J3Uu8LiwKcYlwXnVa85XPinWg4
 YnmikLpgDPcHYhsPNIxyAyxs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 17:42:37 -0700
IronPort-SDR: VBDJDTGhbKRUA+6Pr1IColaqwF7M8Oa0se0s6w3eu5j4Pk3MJpqzlD+Hkh1SJX3f02HSfRDK7E
 DzngDDCsfwUxjXJsmm3JO0zgNphmeRU0WsngApMwOEp29Oq4ZPB+WAIVCjLBPkTMW0D6XSz+oy
 YL5eevTPb3cCk6SMb3hv0Q7LAJ+xPUpng5J+Jf+4H6GPA1nYEpgYXpvotrTWgphlo8dauqcstT
 EZDxAA0L9mUqBFabLdWkb6l6kMDHG9hJJmMpiddDHec6zIoWdS2hbiVL6HuFjV1BshRTTuJLsD
 jaw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 18:12:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhTS00RYzz1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Apr 2022 18:12:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650244335; x=1652836336; bh=fuEz/yS5Uj5qb4Eh1z
        Ao17+VVdsf2qNASubyRaV5x1A=; b=URKWSoxIAt11lNoGH6xT1L1uJOtvOE/jZZ
        a589hvQZAsXCjXgzjefcvvWAabWiECXgRi1jwkZEeFoIgytgV/UPZ2jgtFkZ6+fa
        APWVsg/dtxRAXcW9zR+iDfTeTZ3iarC0rheQWDGUahBgj2esg5PCpHIf0RCs5uAm
        hppL90S91uaE7kOwIIEYev7cJawzClfQTwhNlKYm3+qTg8LV9eWS6itMxRMr8Dpq
        XujJUDnY5CdfS8NYsQNe0w5EyMftJ0NHmQchd12VskOIIKuGTe6If0pbcYbOkopi
        jERk6mD1j0iHTChZKef3vAlv96KrJhJiaaHXhcnAKE4560Fb9gpA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dP6cHdJ01v2v for <linux-fsdevel@vger.kernel.org>;
        Sun, 17 Apr 2022 18:12:15 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhTRz2DMPz1Rvlx;
        Sun, 17 Apr 2022 18:12:15 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 8/8] documentation: zonefs: Document sysfs attributes
Date:   Mon, 18 Apr 2022 10:12:07 +0900
Message-Id: <20220418011207.2385416-9-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document the max_wro_seq_files, nr_wro_seq_files, max_active_seq_files
and nr_active_seq_files sysfs attributes.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 Documentation/filesystems/zonefs.rst | 38 ++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/filesystems/zonefs.rst b/Documentation/filesys=
tems/zonefs.rst
index 72d4baba0b6a..394b9f15dce0 100644
--- a/Documentation/filesystems/zonefs.rst
+++ b/Documentation/filesystems/zonefs.rst
@@ -351,6 +351,44 @@ guaranteed that write requests can be processed. Con=
versely, the
 to the device on the last close() of a zone file if the zone is not full=
 nor
 empty.
=20
+Runtime sysfs attributes
+------------------------
+
+zonefs defines several sysfs attributes for mounted devices.  All attrib=
utes
+are user readable and can be found in the directory /sys/fs/zonefs/<dev>=
/,
+where <dev> is the name of the mounted zoned block device.
+
+The attributes defined are as follows.
+
+* **max_wro_seq_files**:  This attribute reports the maximum number of
+  sequential zone files that can be open for writing.  This number corre=
sponds
+  to the maximum number of explicitly or implicitly open zones that the =
device
+  supports.  A value of 0 means that the device has no limit and that an=
y zone
+  (any file) can be open for writing and written at any time, regardless=
 of the
+  state of other zones.  When the *explicit-open* mount option is used, =
zonefs
+  will fail any open() system call requesting to open a sequential zone =
file for
+  writing when the number of sequential zone files already open for writ=
ing has
+  reached the *max_wro_seq_files* limit.
+* **nr_wro_seq_files**:  This attribute reports the current number of se=
quential
+  zone files open for writing.  When the "explicit-open" mount option is=
 used,
+  this number can never exceed *max_wro_seq_files*.  If the *explicit-op=
en*
+  mount option is not used, the reported number can be greater than
+  *max_wro_seq_files*.  In such case, it is the responsibility of the
+  application to not write simultaneously more than *max_wro_seq_files*
+  sequential zone files.  Failure to do so can result in write errors.
+* **max_active_seq_files**:  This attribute reports the maximum number o=
f
+  sequential zone files that are in an active state, that is, sequential=
 zone
+  files that are partially writen (not empty nor full) or that have a zo=
ne that
+  is explicitly open (which happens only if the *explicit-open* mount op=
tion is
+  used).  This number is always equal to the maximum number of active zo=
nes that
+  the device supports.  A value of 0 means that the mounted device has n=
o limit
+  on the number of sequential zone files that can be active.
+* **nr_active_seq_files**:  This attributes reports the current number o=
f
+  sequential zone files that are active. If *max_active_seq_files* is no=
t 0,
+  then the value of *nr_active_seq_files* can never exceed the value of
+  *nr_active_seq_files*, regardless of the use of the *explicit-open* mo=
unt
+  option.
+
 Zonefs User Space Tools
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.35.1

