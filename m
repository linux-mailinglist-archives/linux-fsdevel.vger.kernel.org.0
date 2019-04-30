Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C49DEEDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 04:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfD3CvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 22:51:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60282 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfD3CvG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:51:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U2hrVn113580;
        Tue, 30 Apr 2019 02:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7f8at92urxBnhxmK5RisQak2n2RS9MsVx744PF44sMk=;
 b=tEOHWepsllY8/YH2O39+c80pQXQZormVpmCTu6IN1mkJdkXLA4j9hQfcJj3BkSMIO5pb
 z+0zYJD4l84BmJDCrvvvmdkcduQR6n6wAnUjgiAchCrTbtPE2GuOfxPP+0LqJ+3LaUO7
 cgmMpp+EKqCtDQZsZ508qywYwdOY8DaD5lf3vOfzoziE7QOTj5UYPWahChumAzhcYOX1
 xrDyrKV/KJ0rBD2DAso8InNIlQFwqLrsiPEcsAMe4PPrvaw36c4RMrpNsSwVAfUVmp9i
 tobttfcBOUbFm6eFpQWVdhr8bt1sGfZIxu/a66N1MYqq33HwVfzxgwpWhT9ZvkaavTdX HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2s4fqq1r0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 02:50:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U2mjab127419;
        Tue, 30 Apr 2019 02:50:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2s4d4a8xuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 02:50:34 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3U2oUIM027571;
        Tue, 30 Apr 2019 02:50:30 GMT
Received: from localhost (/10.159.138.192)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 19:50:30 -0700
Date:   Mon, 29 Apr 2019 19:50:28 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 0/5] iomap and gfs2 fixes
Message-ID: <20190430025028.GA5200@magnolia>
References: <20190429220934.10415-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429220934.10415-1-agruenba@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300017
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300017
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:09:29AM +0200, Andreas Gruenbacher wrote:
> Here's another update of this patch queue, hopefully with all wrinkles
> ironed out now.
> 
> Darrick, I think Linus would be unhappy seeing the first four patches in
> the gfs2 tree; could you put them into the xfs tree instead like we did
> some time ago already?

Sure.  When I'm done reviewing them I'll put them in the iomap tree,
though, since we now have a separate one. :)

--D

> Thanks,
> Andreas
> 
> Andreas Gruenbacher (4):
>   fs: Turn __generic_write_end into a void function
>   iomap: Fix use-after-free error in page_done callback
>   iomap: Add a page_prepare callback
>   gfs2: Fix iomap write page reclaim deadlock
> 
> Christoph Hellwig (1):
>   iomap: Clean up __generic_write_end calling
> 
>  fs/buffer.c           |   8 ++--
>  fs/gfs2/aops.c        |  14 ++++--
>  fs/gfs2/bmap.c        | 101 ++++++++++++++++++++++++------------------
>  fs/internal.h         |   2 +-
>  fs/iomap.c            |  55 ++++++++++++++---------
>  include/linux/iomap.h |  22 ++++++---
>  6 files changed, 124 insertions(+), 78 deletions(-)
> 
> -- 
> 2.20.1
> 
