Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE545027E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 12:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352099AbiDOKFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 06:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352091AbiDOKFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:05:46 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331F7BB0AA;
        Fri, 15 Apr 2022 03:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650016996; i=@fujitsu.com;
        bh=umWvxw61hLIrbg/P5jUPIscneWN2fsBQmpr2GWuMT1w=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=N9X5mnLhce+1t4S94dAZ23gA4neRsLoDqT9V4/dqE0sRcq8/eHi5rAcr/5ELDTNc6
         tEYc5RwuuWPa8QbtTopuztzK6/zHn2Odf+CYNzzuBJN/jM8yvrdVTBva/eqCFbtxaC
         f+dEZVLXYEta9KFRIS84+DDgn/H0++ZIJMzbjv9B4UD9q+0loLgekmAqpJK88ZFML1
         j2O0rimxUTCt4dDGYNqPyOfQZK/jOfXW9PAbSVmjk4TqFoiVJx6x/KiDs01jIMK8Qg
         Jvql/fFjm/QgsmrFTABbcWK10SojGQobVwryppeZIFrgrhbWi/qj/RGiLA057J0ZrN
         yBeehB+HU3Alg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsViZ8MRovvYKTL
  J4GKDnsXrw58YLT7cnMRkseXYPUaLy0/4LH4uW8VusWfvSRaLCwdOs1rs+rOD3eL83+OsDpwe
  pxZJeGxa1cnm8XmTnMemJ2+ZAliiWDPzkvIrElgzHqx8zFbQy1Ex8dZstgbG32xdjFwcQgKvG
  SUeXj/GBOHsYZTY//EhSxcjJwebgKbEs84FzCC2iICLxMIJ6xlBipgFXjFKTN87A6xIWMBc4v
  Caf2A2i4CqxJ/jK9lAbF4BT4ndD2+wgtgSAgoSUx6+BxrEwcEp4CXx/2wtSFgIqGTqpMtQ5YI
  SJ2c+ARvDLCAhcfDFC2aIVkWJSx3fGCHsColZs9qYJjDyz0LSMgtJywJGplWMVklFmekZJbmJ
  mTm6hgYGuoaGprpA0tREL7FKN1EvtVS3PLW4RNdQL7G8WC+1uFivuDI3OSdFLy+1ZBMjMPhTi
  hlm7WCc1fdT7xCjJAeTkijvW9HIJCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvH/tgXKCRanpqR
  VpmTnASIRJS3DwKInwhloDpXmLCxJzizPTIVKnGBWlxHmFgfErJACSyCjNg2uDRf8lRlkpYV5
  GBgYGIZ6C1KLczBJU+VeM4hyMSsK8xiBTeDLzSuCmA+MG6GYR3m+rQkEWlyQipKQamM6rKDAF
  hLh4M8/Lq7tfF5cns3GR0XXdNRomP15x7Jz69et2sXMmCtlpSo0/X63snpv2sbDF6On9fyLe0
  7gfhpo9uio5wbT47PKvBfrV/37oz1n9nUO59Me1C3+kuZy620QXbE11LS4S3LAyL/zy4ZLuzE
  gLY6sbq3szlx/Nj/uwOC42M1CR64LlbJ+uh5Lvzog3Ku6d/KwwwXEJH9uS7qeyfGXfF/FnPdH
  j+1vqJXDpy2HGXftuS+RkPvN18dvbwtwT8MLGrFP86rsjR7L37tNUij5/44ipbZb2Zn+Lp2cc
  Pmc6HfV/xnbb3Frg75SkmfXmWgXGofwSGxmTrDbyFGTo5ixX+bUsq4Bz6dGvSizFGYmGWsxFx
  YkAQ7iXxHkDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-587.messagelabs.com!1650016995!55935!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16905 invoked from network); 15 Apr 2022 10:03:15 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-12.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Apr 2022 10:03:15 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23FA3Fer019126
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 15 Apr 2022 11:03:15 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 15 Apr 2022 11:03:10 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 5/7] fs: Add new helper prepare_mode
Date:   Fri, 15 Apr 2022 19:02:21 +0800
Message-ID: <1650020543-24908-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Christian Brauner suggested, add a new helper calls inode_sgid_strip()
and does the umask stripping as well and then call it in all these places.

This api is introduced to support strip file's S_ISGID mode on vfs instead
of on underlying filesystem.

Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/linux/fs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4a617aaab6f6..8c2f4cde974b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3458,6 +3458,15 @@ static inline bool dir_relax_shared(struct inode *inode)
 	return !IS_DEADDIR(inode);
 }
 
+static inline void prepare_mode(struct user_namespace *mnt_userns,
+				const struct inode *dir, umode_t *mode)
+{
+	inode_sgid_strip(mnt_userns, dir, mode);
+
+	if (!IS_POSIXACL(dir))
+		*mode &= ~current_umask();
+}
+
 extern bool path_noexec(const struct path *path);
 extern void inode_nohighmem(struct inode *inode);
 
-- 
2.27.0

