Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C379C42B26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 17:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440095AbfFLPkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 11:40:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56276 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437271AbfFLPkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:40:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CFZRPK114856;
        Wed, 12 Jun 2019 15:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=u5elO/bXPC1RdZ8UtOnOiC+5X/GWxS1snIHsqCTaV9Y=;
 b=E8Ncj6tM8m3+Q+0dqK0Ye0e2p1cs0Rg+uhLXsS3Dm3O+qu4Ig/Kb33q8m0vKSPSrWhn5
 nYtrdxqC0Xobc1hH2IX0M9O+yLHdQCaSMeWM2YPDU3ogtcrbN+rBNAUBSvK2bswC+2vj
 c8rOBKARy+4xs+gRRp8xkaiSH/wvebBf5ucrL63/LYyDaAzGWj26zTu0Y4OVcuin3vXL
 O+yrGVf+wKVXPfEKPDu5xDilFOyJaLF7f7J6HYbj+aXSBX8iVCRX+rbxEi8aYAyxLcbI
 oQhCxZya1QLsscJ8uJyc+JrgepF22MtnLowBBAiVIoQ3g/jQo9leIuD2aOo9lXi6L8va Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t04etvdys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 15:40:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CFdJju165750;
        Wed, 12 Jun 2019 15:40:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t024v1xnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 15:40:02 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5CFe2Jn022063;
        Wed, 12 Jun 2019 15:40:02 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 08:40:01 -0700
Date:   Wed, 12 Jun 2019 08:40:01 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     xfs <linux-xfs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] xfs: claim maintainership of loose files
Message-ID: <20190612154001.GC3773859@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120104
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Claim maintainership over the miscellaneous files outside of fs/xfs/
that came from xfs.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..f0edb53b9dd3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17357,7 +17357,13 @@ W:	http://xfs.org/
 T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 S:	Supported
 F:	Documentation/filesystems/xfs.txt
+F:	Documentation/ABI/testing/sysfs-fs-xfs
+F:	Documentation/filesystems/xfs.txt
+F:	Documentation/filesystems/xfs-delayed-logging-design.txt
+F:	Documentation/filesystems/xfs-self-describing-metadata.txt
 F:	fs/xfs/
+F:	include/uapi/linux/dqblk_xfs.h
+F:	include/uapi/linux/fsmap.h
 
 XILINX AXI ETHERNET DRIVER
 M:	Anirudha Sarangi <anirudh@xilinx.com>
