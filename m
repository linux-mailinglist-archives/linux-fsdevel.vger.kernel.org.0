Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E652E828F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Dec 2020 23:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgLaWzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Dec 2020 17:55:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39192 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgLaWzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Dec 2020 17:55:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BVMinMH147486;
        Thu, 31 Dec 2020 22:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LznMnpCNiFWA6SSOpXbbyEDT68PqLsnnExwCxDloxGY=;
 b=QDEh8OemtgnBpKksmM6Lobu0URasWesGKPCTZpL1zupnq2fUxMEJCs3aCeHck39G37mn
 tQQQZ4gZHUdPZYdVeZ3qebDb4ewZAHnLUbIWW9+5mowBSYUMdVtfq+nADOSZTtGl7Rld
 esyRoN3TGXn1Al7faqqJSb55RUQwuOl6gFfW/362u2dqHGpAx3wWhC/tR/HXBuGFNLN4
 RazTl3oFhJf8EZz1EybZbDAonD44JnGjBqpnA71Hvi4Pl8MtobthpsmH4yGLgLfdyphh
 OLIMTGCVH+ZlOvzaxYJbpvP7soCM9jpGqCsjb0xqu5bhhNZyP5AUWC5+yEZ8Il9lwGHm 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35phm1jt8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Dec 2020 22:54:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BVMj4ob015891;
        Thu, 31 Dec 2020 22:52:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 35pf40pmqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Dec 2020 22:52:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BVMqNBd028771;
        Thu, 31 Dec 2020 22:52:23 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Dec 2020 14:52:22 -0800
Date:   Thu, 31 Dec 2020 14:52:21 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dmitrii Tcvetkov <me@demsh.org>
Cc:     djwong@kernel.org, david@fromorbit.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net,
        torvalds@linux-foundation.org
Subject: Re: [GIT PULL] xfs: new code for 5.11
Message-ID: <20201231225221.GJ6918@magnolia>
References: <20201218171242.GH6918@magnolia>
 <20201229104955.565423f9@note>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229104955.565423f9@note>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9851 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012310135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9851 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012310135
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 29, 2020 at 10:49:55AM +0300, Dmitrii Tcvetkov wrote:
> >Please pull the following branch containing all the new xfs code for
> >5.11.  In this release we add the ability to set a 'needsrepair' flag
> >indicating that we /know/ the filesystem requires xfs_repair, but other
> >than that, it's the usual strengthening of metadata validation and
> >miscellaneous cleanups.
> >...
> >New code for 5.11:
> >- Introduce a "needsrepair" "feature" to flag a filesystem as needing a
> >  pass through xfs_repair.  This is key to enabling filesystem upgrades
> >  (in xfs_db) that require xfs_repair to make minor adjustments to
> >metadata.
> 
> Hello.
> 
> Most likely I miss something obvious but according to xfs_repair(8):
> BUGS:
> The filesystem to be checked and repaired must have been unmounted
> cleanly  using  normal  system  administration  procedures (the
> umount(8)  command  or  system  shutdown),  not  as  a  result of a
> crash or system reset.  If the filesystem has not been unmounted
> cleanly, mount it and unmount it cleanly before running xfs_repair.
> 
> which is there since commit d321ceac "add libxlog directory"
> Date:   Wed Oct 17 11:00:32 2001 +0000 in xfsprogs-dev[1]. 
> 
> So will be there situation of uncleanly unmounted filesystem with
> "needsrepair" bit set?

No.  If we detect metadata corruption we stop writing metadata
and take the fs offline immediately.  We would not set needsrepair, for
exactly the reasons you outline.

--D

> Will one be able to mount and umount it before running xfs_repair in
> that case?
> 
> [1] git://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git
