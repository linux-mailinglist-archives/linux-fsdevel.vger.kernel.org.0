Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63B8215E07
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 20:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgGFSK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 14:10:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38194 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgGFSK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:10:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066I6nbF088795;
        Mon, 6 Jul 2020 18:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=5T7dTXioAzbYOiIl5A/DrEFn8a4oDLa1jF9+FRzNVQE=;
 b=XEt3gI8xMtNYX4IHNnW8WTyzariYXA4A14VuBro4X8ETzUdF8Tvcv6S6b8xETpRmmlcu
 U2FLNueI9pfRYdP2yK7ytcJoV5bzdrhPQbmpFWQAsuE3HEncVN0mTQLgzG1ybMNF7LFE
 PpOvCGnv5r3tm1LtGYxYpIyC2UDcTiFe3pVrtjJNohV9/mmgVkIpMJgVXcPOzW41lShr
 7n9ppuw79Q9PEZsCe4ItzWzT4nIdAkDPrOGwYdD0l9G7o4QTVMHbfgvXIN3JrrPe6DOV
 UEfWd80yOfkkp84C5aocPzE+S5Cuxwp11gDIMl+okVlvM/wBHrQNcklUzLXcqHfb06Jf Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 323sxxma77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 06 Jul 2020 18:10:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066I95VZ065440;
        Mon, 6 Jul 2020 18:10:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3233p0grse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jul 2020 18:10:14 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 066IABqb004822;
        Mon, 6 Jul 2020 18:10:11 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jul 2020 11:10:11 -0700
Date:   Mon, 6 Jul 2020 11:10:10 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-5.9-merge updated to d1b4f507d71d
Message-ID: <20200706181010.GA7597@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9673 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9673 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 adultscore=0 cotscore=-2147483648 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=2 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.9-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-5.9-merge branch is commit:

d1b4f507d71d iomap: Make sure iomap_end is called after iomap_begin

New Commits:

Andreas Gruenbacher (1):
      [d1b4f507d71d] iomap: Make sure iomap_end is called after iomap_begin


Code Diffstat:

 fs/iomap/apply.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)
