Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDCDB692D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 19:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfIRRcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 13:32:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50310 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfIRRcN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:32:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHO8Wd088210;
        Wed, 18 Sep 2019 17:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=VelpOwG6kFDwS0ztXibieLp8imbQJzrwL35i6zLQnWw=;
 b=emubDfPTnFoNw+I7623yjzlaruJeyaeDl2RxTO+JHVSI8WreqJ4ztfVQFgr6AV9kDyVZ
 lWJ3H8nb2RRlOGH/YLzeQNy+TupR/Uo46wTeSiUWWoSzDzgAFLGQ5AX5VaOzCBe7n+Ul
 jbzZTuxITXil+o8g6S0UaFDGXmAlYXHCQrS8RD44JTkjvnN20ow98oqvDMxbcaBHC/Cf
 DICxvIFXZ7tyhxj+4uedBLgKraxaFVkYVWGbap7q4QtplXNdKa0Uru0yE3sBZeGos7qZ
 902b3JOlEmNMEn8xnT+7rc9WgQvJ+/29MnwXZk9CIPWpjtWFglylT56fmTD0uLi4j81u mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v385dwem0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:32:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHMfjY086629;
        Wed, 18 Sep 2019 17:32:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2v37ma0hcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:32:07 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8IHW5Hp006049;
        Wed, 18 Sep 2019 17:32:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 10:32:05 -0700
Date:   Wed, 18 Sep 2019 10:31:59 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/19] xfs: remove xfs_reflink_dirty_extents
Message-ID: <20190918173159.GD2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-10-hch@lst.de>
 <20190918171733.GA2229799@magnolia>
 <20190918172545.GA19884@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918172545.GA19884@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180159
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 07:25:45PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 18, 2019 at 10:17:33AM -0700, Darrick J. Wong wrote:
> > >  /*
> > >   * Pre-COW all shared blocks within a given byte range of a file and turn off
> > >   * the reflink flag if we unshare all of the file's blocks.
> > > + *
> > > + * Let iomap iterate all extents to see which are shared and not unwritten or
> > > + * delalloc and read them into the page cache, dirty them, fsync them back out,
> > > + * and then we can update the inode flag.  What happens if we run out of
> > > + * memory? :)
> > 
> > I don't know, what /does/ happen? :)
> > 
> > It /should/ be fine, right?  Writeback will start pushing the dirty
> > cache pages to disk, and since writeback only takes the ILOCK, it should
> > be able to perform the COW even while the unshare process sits on the
> > IOLOCK/MMAPLOCK.  True, the unshare process and writeback will both be
> > contending on the ILOCK, but that shouldn't be a problem...
> > 
> > ...unless I'm missing something?  It sure does look nice to drain all
> > this other code out.
> 
> No idea.  This is your old code just moved down to this function.  But
> yes, the comment looks rather confusing and maybe we should just remove
> it.

I know.  I remember testing it way back in 4.9 when we first merged it
to make sure it really did work that way, and I think the locking model
hasn't changed so it should be fine.  But just wanted another set of
eyes to make sure things haven't subtlely shifted since then. :)

--D
