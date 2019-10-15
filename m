Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F733D7C48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbfJOQtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 12:49:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59866 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfJOQtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:49:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FGctRZ039253;
        Tue, 15 Oct 2019 16:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=dMsf5RtB6vxQ3LZkfe1f47o7Uva/KHSz5Ae9vjAzzcs=;
 b=PevSynqO3wEizftOzPfMowA0akeis1xmawlTj6gi5N4EWPEat5VPIMHNkZQE9xzrGsL9
 hCVAXIe6ZBMRqtwk7Lra3TKaxuU/xhoVu4KMUr2mGipvoecRPHS+gwoAIO0z+8yN5+ld
 3Gb2IgxK9ZEHxs4+8ZILr+a7+Vw6BOHfwGZFlpb/CRGCbVN2TdtHE0KpPAFlKWotXnc2
 0i4ejVHGHE5MRxzpBPFNA9pUMx4bh7E4GLgv63V4FrHelwznNf02fCKgXZvThJqm9san
 qeNMAvcn1dfc5zbeG1g1whq0JCw6kZSHgkw2hldydqrmMiNiGQuRBBqn5M5c5F+XfXci Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vk68uheqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 16:49:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FGcQLE104487;
        Tue, 15 Oct 2019 16:49:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vn718mu9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 16:49:06 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9FGn3k0025393;
        Tue, 15 Oct 2019 16:49:05 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 16:49:03 +0000
Date:   Tue, 15 Oct 2019 09:49:01 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jan Kara <jack@suse.cz>, mbobrowski@mbobrowski.org
Subject: [ANNOUNCE] xfs-linux: iomap-5.5-merge updated to c9acd3aee077
Message-ID: <20191015164901.GF13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150145
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.5-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  The intent is to establish this as a stable branch for
everyone else's 5.5 development activities by the end of the week.

Note that this is an interim update, since I intend to review
Christoph's v5 iomap writeback series when I'm done sending these
announcements.

The new head of the iomap-5.5-merge branch is commit:

c9acd3aee077 xfs: Use iomap_dio_rw_wait()

New Commits:

Jan Kara (2):
      [13ef954445df] iomap: Allow forcing of waiting for running DIO in iomap_dio_rw()
      [c9acd3aee077] xfs: Use iomap_dio_rw_wait()


Code Diffstat:

 fs/gfs2/file.c        |  6 ++++--
 fs/iomap/direct-io.c  |  7 +++++--
 fs/xfs/xfs_file.c     | 13 +++++--------
 include/linux/iomap.h |  3 ++-
 4 files changed, 16 insertions(+), 13 deletions(-)
