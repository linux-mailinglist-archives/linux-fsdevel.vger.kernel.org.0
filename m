Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59D3B8FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391447AbfFJQGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 12:06:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33126 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391391AbfFJQGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:06:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AFwmFb177659;
        Mon, 10 Jun 2019 16:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=35LE6B7Ini09DnT9GNQejfwmIbE+MCFl54VICp/cirA=;
 b=owgyJa1wup+uAazy8RUcYMrChbFFDhjRhho3UzbMVEJEfn9rSnKg03aGD3vXu0bkoqOU
 AwkRKi05kvdOnWynhxnmn7Egdbc91P76GlQXNIbqJKXNO0Gv3PmJwGg0eEi9OfjAPexN
 cCRVexyzp0ku2oNMKmsaM71g3XtYbCGrMBSCMRsy8MbYptyIeotY08lQmVHDhz8/DQ7j
 BYugAmZkgPms2SE9qjvaV6jIBuyVyq+VQkAY7xnZVdf5n0PD6bhEJeMfSXRoMR/IxREO
 jl75W66yLmeQI0/dStWt7WMi3QCiqdC1OrvHMTAY3MpPHrKwZIUkTQXkb/lwWPHkES+c 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t04etfv7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 16:06:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AG67iX143155;
        Mon, 10 Jun 2019 16:06:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t0p9qt3w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 16:06:26 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5AG6PdH022913;
        Mon, 10 Jun 2019 16:06:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 09:06:25 -0700
Date:   Mon, 10 Jun 2019 09:06:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     xfs <linux-xfs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        olga.kornievskaia@gmail.com, amir73il@gmail.com,
        "Theodore Ts'o" <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfs-linux: copy-file-range-fixes updated to fe0da9c09b2d
Message-ID: <20190610160624.GG1871505@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=988
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100109
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The copy-file-range-fixes branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.  This is a common branch from which everyone else
can create their own copy-file-range fix branches for 5.3.  When you
send your pull request to Linus please let him know that the fixes
stream out from here like some kind of hydra. :)

FWIW these patches are the fixes for the problems that have been
reported in generic/553 and generic/554.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-fsdevel@vger.kernel.org so they can be picked up
in the next update.

The new head of the copy-file-range-fixes branch is commit:

fe0da9c09b2d fuse: copy_file_range needs to strip setuid bits and update timestamps

New Commits:

Amir Goldstein (7):
      [a31713517dac] vfs: introduce generic_file_rw_checks()
      [646955cd5425] vfs: remove redundant checks from generic_remap_checks()
      [96e6e8f4a68d] vfs: add missing checks to copy_file_range
      [e38f7f53c352] vfs: introduce file_modified() helper
      [8c3f406c097b] xfs: use file_modified() helper
      [5dae222a5ff0] vfs: allow copy_file_range to copy across devices
      [fe0da9c09b2d] fuse: copy_file_range needs to strip setuid bits and update timestamps

Dave Chinner (2):
      [f16acc9d9b37] vfs: introduce generic_copy_file_range()
      [64bf5ff58dff] vfs: no fallback for ->copy_file_range


Code Diffstat:

 fs/ceph/file.c     |  23 ++++++++--
 fs/cifs/cifsfs.c   |   4 ++
 fs/fuse/file.c     |  29 +++++++++++--
 fs/inode.c         |  20 +++++++++
 fs/nfs/nfs4file.c  |  23 ++++++++--
 fs/read_write.c    | 124 +++++++++++++++++++++++++++++------------------------
 fs/xfs/xfs_file.c  |  15 +------
 include/linux/fs.h |   9 ++++
 mm/filemap.c       | 110 ++++++++++++++++++++++++++++++++++++++---------
 9 files changed, 257 insertions(+), 100 deletions(-)
