Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC54C2BBC14
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 03:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgKUCDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 21:03:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55444 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgKUCDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:03:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AL20cmG076800;
        Sat, 21 Nov 2020 02:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0UJfCyIxUW1jtzShXnnQ2bfG36cw6LE9qxJledb3hlo=;
 b=zqsLQU79wiZIOwaXbutWjsHTbHsYLGCoPliFplVEzBK6BiiFKA1NwlrQzMVmy+4uUqr5
 npJsc64BjSYpEFt99endXXT6YrkZsmd92wS2Lxcit2SoxfoKvFOshyzqzcj6TGQ3ENw9
 zFZ27GfVFH7FaP4NBBoK28XyF92/hpyZjpNSUdjOYsU6uxAo0SCYioxoHYkSgFoCtPi6
 caabwCbObQPfUQwyHpytiqfGaRyyrd6C36ekCFBhX7N2BEdzXtAYu+OmX9PpQfNmTjyF
 QLACGyrHMS9uU4DDR/jIidntTXY7OF5KUTC8oG6hmLib/7jxxO/pUewSf282xwHMTvSE fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34xrdag3gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 21 Nov 2020 02:03:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AL1xkMq120715;
        Sat, 21 Nov 2020 02:03:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34xrx8se7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Nov 2020 02:03:26 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AL23Jlk006772;
        Sat, 21 Nov 2020 02:03:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Nov 2020 18:03:19 -0800
Date:   Fri, 20 Nov 2020 18:03:18 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     XiaoLi Feng <xifeng@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        ira.weiny@intel.com, Xiaoli Feng <fengxiaoli0714@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs/stat: set attributes_mask for STATX_ATTR_DAX
Message-ID: <20201121011516.GD3837269@magnolia>
References: <20201121003331.21342-1-xifeng@redhat.com>
 <21890103-fce2-bb50-7fc2-6c6d509b982f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21890103-fce2-bb50-7fc2-6c6d509b982f@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011210013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9811 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=1 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011210013
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Adding fsdevel to cc since this is a filesystems question]

On Fri, Nov 20, 2020 at 04:58:09PM -0800, Randy Dunlap wrote:
> Hi,
> 
> I don't know this code, but:
> 
> On 11/20/20 4:33 PM, XiaoLi Feng wrote:
> > From: Xiaoli Feng <fengxiaoli0714@gmail.com>
> > 
> > keep attributes and attributes_mask are consistent for
> > STATX_ATTR_DAX.
> > ---
> >  fs/stat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/stat.c b/fs/stat.c
> > index dacecdda2e79..914a61d256b0 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -82,7 +82,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
> >  
> >  	if (IS_DAX(inode))
> >  		stat->attributes |= STATX_ATTR_DAX;
> > -
> > +	stat->attributes_mask |= STATX_ATTR_DAX;
> 
> Why shouldn't that be:
> 
> 	if (IS_DAX(inode))
> 		stat->attributes_mask |= STATX_ATTR_DAX;
> 
> or combine them, like this:
> 
> 	if (IS_DAX(inode)) {
> 		stat->attributes |= STATX_ATTR_DAX;
> 		stat->attributes_mask |= STATX_ATTR_DAX;
> 	}
> 
> 
> and no need to delete that blank line.

Some filesystems could support DAX but not have it enabled for this
particular file, so this won't work.

General question: should filesystems that are /capable/ of DAX signal
this by setting the DAX bit in the attributes mask?  Or is this a VFS
feature and hence here is the appropriate place to be setting the mask?

Extra question: should we only set this in the attributes mask if
CONFIG_FS_DAX=y ?

--D

> >  	if (inode->i_op->getattr)
> >  		return inode->i_op->getattr(path, stat, request_mask,
> >  					    query_flags);
> > 
> 
> thanks.
> -- 
> ~Randy
> 
