Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED375FA63
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 16:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfGDO7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 10:59:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59516 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfGDO7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:59:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64EwxY3062120;
        Thu, 4 Jul 2019 14:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=Le06JK7+nzc6Y7OXujUns0KIW1l33RAV1JMx2lCuxbo=;
 b=dY058S+38/BtsHVSS2Y5UF6UaOSj6sflBgFnndvTD4TjIWeYQZcy26Ps83Jz+StcbjD0
 m+W048qZcvvjICBO9DpgEF9hAZVT7+luvLGPnoqkf/rEw3D7IZuJEqrdriNaHdcLI1V8
 xsSpPTwAwqg9Yr8t4RhHDMRRAhIn09nfX/8xfKRYPuDVYpqfIi39ktto16h6Ms3BQzS6
 eWaoOHDDYpmwjuFlzB8u2wSbMZoEHctGf+sHH78jU183eyVyRjT0DS5+T+QJoajVoQ8I
 6xRckgW2SbN1/1ODUQmykxbJHw6/IHso0sPKbvLKuJ7rZLo1ApF7ezb25pzIQP8LqnnE Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2te61q79sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 14:59:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64EwEW6124035;
        Thu, 4 Jul 2019 14:59:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2th5qm393v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 14:59:13 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x64Ex987009381;
        Thu, 4 Jul 2019 14:59:10 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jul 2019 07:59:09 -0700
Date:   Thu, 4 Jul 2019 07:59:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [ANNOUNCE RESEND] xfs-linux: iomap-5.3-merge updated to 36a7347de097
Message-ID: <20190704145907.GG1654093@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040189
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040189
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.3-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  This is pretty much it for the 5.3 merge window; I'm
resending this message because the previous one may have been eaten by
filters.

The new head of the iomap-5.3-merge branch is commit:

36a7347de097 iomap: fix page_done callback for short writes

New Commits:

Andreas Gruenbacher (2):
      [8d3e72a180b4] iomap: don't mark the inode dirty in iomap_write_end
      [36a7347de097] iomap: fix page_done callback for short writes

Christoph Hellwig (1):
      [8af54f291e5c] fs: fold __generic_write_end back into generic_write_end


Code Diffstat:

 fs/buffer.c           | 62 ++++++++++++++++++++++++---------------------------
 fs/gfs2/bmap.c        |  2 ++
 fs/internal.h         |  2 --
 fs/iomap.c            | 17 ++++++++++++--
 include/linux/iomap.h |  1 +
 5 files changed, 47 insertions(+), 37 deletions(-)
