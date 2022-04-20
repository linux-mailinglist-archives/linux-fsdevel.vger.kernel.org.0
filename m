Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8005E507EE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 04:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358973AbiDTCit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 22:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiDTCij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:38:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0363237D7
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650422154; x=1681958154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wAZQid4lKgOomKfXSEInjQihIYH+92Z3DRwKfcBoFxM=;
  b=ZuHVya6Z3WcrntU2O1q/G5GXshk1aw2S9HWU7S/HXzfKxosmAmAjl4Ba
   q0xP4cda/bHpQpgP9SNGKkF2X1wVqhLbx7BCEYTFx6dAgLGIhmqvE4Nv3
   +tkWFxVwJyYUYy3Nqg58yKNsT3ssQZPlXi0dT8nJvFsnfOhG5c2mfQaqM
   gkRVQGu0JEw6xHZ2gym7oxnOysKqCtPqvxVrRMYqj6iu8UARlF4/VgqpI
   sXfAxruII/oAEgIcbuOCzeH1uOkTpLC/HIatSFwHKXnld02oVy754RXVf
   M6q9hQWX6CELWvOM8bli+ELTHzv5tzJvF/mEuB6shrlGI+WuiIcSb5cm4
   w==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="197177979"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 10:35:53 +0800
IronPort-SDR: /XFeC6KLJcNkBWeagHvs4Ss//QQFTsNrrzy5IoR0qa9ZfNCoZJeDSnCbvYhzlSc4H9RiaChtwd
 XDsBt8E9nFaismbCvlCH8/bBLTTpp1mWc1muGsHIP9BCW1M0yGwPjS4mPx2WA7Pdc3v+WdXqai
 tzEfNItgEY3IvPL/q1OWtYYQiZ9OfV3TVKkA4kN6P8dGsxAQAfB1KMKddMJ2kJx5+2Bgws9g/i
 crHLYecb9KQWEmfbeC+9bd12iJtl0J0+Be6Iw1u28U5dG+Z9ytKKXRv8oCaF/MvUJ4o/XXP6Xn
 /mRlU+Nm4Ev4U0zzkwTqTgRY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:06:12 -0700
IronPort-SDR: HmtMvP0zFCsShf2V2Ol8c9l7K/MwSN/s0U84GKskcTWE5fKcIA/adruDuxYzuWgdB5MsqVvokI
 TyaYED6DO7XMTU6J8xE7p6RL1STEQdkFMz3YrtgupqiGFBLnHvEtco/6zxt1Az5e7OOL7mCf19
 mOB6FNQFgls6jTOollzricp/BBkMb27w4rUpEZAF6zhEThHNRJzROueBxi5EWwJRQiYZ3FML2j
 cuc96r/vEjEBJ559ylGqcThMrSZEnXKpJAw85C89NQxrGeTC4gglU8WfLbn5sfr5Rqy6h8lz8R
 880=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 19:35:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjlCY39nqz1Rvlx
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 19:35:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650422153; x=1653014154; bh=wAZQid4lKgOomKfXSE
        InjQihIYH+92Z3DRwKfcBoFxM=; b=C+hZIf0si14o6yBEk3QHJY5t/Gsyq5sGnr
        mhn/kBPEUIZlhab5bzyQOE9W212cAnSjFa0UQRS/iL/Q5STr3R2v4kgbMxP0prtr
        tj3zDwD8X9c2DnHVfEo8+1KiPbmkDanbGCqT611dFii2hk+Gw6aJfWk7Y3cTtmCr
        BQBcBM5wAXSpr3ajemHTMmORBeu93DbniixV9w0RGa+RD8pMGvsdU9mHZOU4NsOA
        doZcV8tdHzR8JXCSCFDmsXGBViyMfrn/Xbbz8K0sYNmXL8zTEzrQ3snbt5MUrgk3
        RzBWE97dmbtAdFruzZEU6/9YUj5WIqoB/82N4/eb37oowmoCu3tw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SSIkeMqKbrEw for <linux-fsdevel@vger.kernel.org>;
        Tue, 19 Apr 2022 19:35:53 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjlCX4tmDz1Rwrw;
        Tue, 19 Apr 2022 19:35:52 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 8/8] documentation: zonefs: Document sysfs attributes
Date:   Wed, 20 Apr 2022 11:35:45 +0900
Message-Id: <20220420023545.3814998-9-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document the max_wro_seq_files, nr_wro_seq_files, max_active_seq_files
and nr_active_seq_files sysfs attributes.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

