Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E13C18FA46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 17:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCWQqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 12:46:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51306 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgCWQqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:46:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NGdco9186287;
        Mon, 23 Mar 2020 16:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=xIkVKKepSD4KNu1aqqoEYqEwnwnwCu2Wtd7BZmR8TdA=;
 b=iG9Z2fpTzkpqOgA3Pza40NnJ61/aY6kM4y61Qp/BtoXUhCg1A8XzdUG3y5ddIV6IyfgO
 Rv+FrEnEwqv1ImGStj0gjFHgk92BKL6/KsidBgzFCh2Y5H89xVkCeSNl1MPCA0uScdVu
 NK9IH9U/JAaYciUOYLxT1qf2+PDUt1fT31DXOVIvfm92J4VvgFTQXtgU2n04WCsFvyn4
 D5TKD+TlaghiGWe7BdhTqI09pJmBBlI3/B+LImOReSfnPhqb8zprp3170fE9IqtYtzcw
 EdT8LS6tD83UrR90FfZDPc4LHw/sS5xxaiXzUlguMrXuUFYWhzg50jr1XqEgapGDZVfb jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ywabqyrr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 16:46:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NGS03k161670;
        Mon, 23 Mar 2020 16:46:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2yxw7fv2sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 16:46:20 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02NGkIev015749;
        Mon, 23 Mar 2020 16:46:18 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 09:46:18 -0700
Date:   Mon, 23 Mar 2020 09:46:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-mm@kvack.org
Cc:     domenico.andreoli@linux.com, rafael@kernel.org,
        mkleinsoft@gmail.com, hch@lst.de, akpm@linux-foundation.org,
        len.brown@intel.com, pavel@ucw.cz
Subject: [ANNOUNCE] xfs-linux: vfs-for-next updated to 56939e014a6c
Message-ID: <20200323164617.GA29332@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9569 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230089
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The vfs-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  Granted, I'm only doing this to clean up after my own
bad patches. ;)

The new head of the vfs-for-next branch is commit:

56939e014a6c hibernate: Allow uswsusp to write to swap

New Commits:

Domenico Andreoli (1):
      [56939e014a6c] hibernate: Allow uswsusp to write to swap


Code Diffstat:

 fs/block_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
