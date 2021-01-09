Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B7F2EFE34
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 07:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbhAIGq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 01:46:58 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40234 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIGq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 01:46:58 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1096aJ9F096704;
        Sat, 9 Jan 2021 06:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=qIFd+RbzzgUGRU/sSe0gzSQh1PgZQ2pc8EtqH2VrKxs=;
 b=y9/oB+OWRQ9Yx5BDbIHQ5OJ4IRrbhckasDzrR/JwInYIO7ptb6NcGnO82+yjBvvb5tl4
 1iPbLyyGY0YT6iJmIZs14PvWv6rLS+i0TB45nYGeblrtUFMcEkqTnIEGcSAnt0ZSYl67
 R+hjTjT/uTblYajCGWnFgHalrLOGan9ajx69cxCN742KYqe5NeALgVyB+nOV0aZvF+XC
 P0zDfuaFk/a32ApjyewBz5jgXM2sGsNWKWpCoz/8qdwJVw5dSpt984IxezVdjF6dfIsY
 gWfpXYvGLCZ3pbGKMdg6jGspP2Ar5iCZZtM9s/6WKCOaUfvryInSgKTqUJ6yg+604XF0 Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35y20agevb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 09 Jan 2021 06:46:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1096Yw6a080686;
        Sat, 9 Jan 2021 06:46:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 35y49yuuyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Jan 2021 06:46:08 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1096k38q004357;
        Sat, 9 Jan 2021 06:46:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 09 Jan 2021 06:46:03 +0000
Date:   Fri, 8 Jan 2021 22:46:02 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] maintainers: update my email address
Message-ID: <20210109064602.GU6918@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101090041
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101090041
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Change my email contact ahead of a likely painful eleven-month migration
to a certain cobalt enteprisey groupware cloud product that will totally
break my workflow.  Some day I may get used to having to email being
sequestered behind both claret and cerulean oath2+sms 2fa layers, but
for now I'll stick with keying in one password to receive an email vs.
the required four.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 MAINTAINERS |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..9ed3ec2aa1aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9273,7 +9273,7 @@ F:	drivers/net/ethernet/sgi/ioc3-eth.c
 
 IOMAP FILESYSTEM LIBRARY
 M:	Christoph Hellwig <hch@infradead.org>
-M:	Darrick J. Wong <darrick.wong@oracle.com>
+M:	Darrick J. Wong <djwong@kernel.org>
 M:	linux-xfs@vger.kernel.org
 M:	linux-fsdevel@vger.kernel.org
 L:	linux-xfs@vger.kernel.org
@@ -19505,7 +19505,7 @@ F:	arch/x86/xen/*swiotlb*
 F:	drivers/xen/*swiotlb*
 
 XFS FILESYSTEM
-M:	Darrick J. Wong <darrick.wong@oracle.com>
+M:	Darrick J. Wong <djwong@kernel.org>
 M:	linux-xfs@vger.kernel.org
 L:	linux-xfs@vger.kernel.org
 S:	Supported
