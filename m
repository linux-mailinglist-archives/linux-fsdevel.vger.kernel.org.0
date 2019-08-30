Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 682E3A35A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 13:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfH3L1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 07:27:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34428 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfH3L1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:27:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UBOcKr117889;
        Fri, 30 Aug 2019 11:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=msziLnocdvHcufQhecf1ndPoXYQpydYItB5DtxtqBys=;
 b=jpaA2SoCphPWyU2CtodN9hN9WGduAr03wluKxWZAhPa/t+mEzgqMOyQbmOzz+80mxBJW
 y+IbGti9rwDwrEpfNkjGQJnWMc96d5xzm/2WKKel5+PotG0xXF3Cn7OdY6dyHZYlKx75
 ZMyUFrRiOx/IexSmRGFi9fkx+X76nkpfVPUWZVTKFiOoLk+iMaW08PtN0i7wCpKe9qKb
 sn365sGpV9w0E39NUx1bI5rdyYmBY+Th/M9GpcTk6K8CJY/p7gHjCjXVbCsc+pQDp9sJ
 lp3++0CzVnYqUFIyWaqAwBY79e0VE2cEV0H1UTcfIDxp4C1z+DrA167sr6ochQ71PrXu /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uq2w580df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 11:26:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UBNZ7j091929;
        Fri, 30 Aug 2019 11:26:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2upc8xbmce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 11:26:46 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7UBQhS3007665;
        Fri, 30 Aug 2019 11:26:43 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 04:26:43 -0700
Date:   Fri, 30 Aug 2019 14:26:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190830112612.GF8372@kadam>
References: <20190829095019.GA13557@kroah.com>
 <20190829103749.GA13661@infradead.org>
 <20190829111810.GA23393@kroah.com>
 <20190829151144.GJ23584@kadam>
 <20190829152757.GA125003@architecture4>
 <20190829154346.GK23584@kadam>
 <20190829155127.GA136563@architecture4>
 <20190829160441.GA141079@architecture4>
 <20190830083445.GL23584@kadam>
 <20190830084333.GA193084@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830084333.GA193084@architecture4>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908300124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300124
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 30, 2019 at 04:43:33PM +0800, Gao Xiang wrote:
> Hi Dan,
> 
> On Fri, Aug 30, 2019 at 11:34:45AM +0300, Dan Carpenter wrote:
> > On Fri, Aug 30, 2019 at 12:04:41AM +0800, Gao Xiang wrote:
> > > Anyway, I'm fine to delete them all if you like, but I think majority of these
> > > are meaningful.
> > > 
> > > data.c-		/* page is already locked */
> > > data.c-		DBG_BUGON(PageUptodate(page));
> > > data.c-
> > > data.c:		if (unlikely(err))
> > > data.c-			SetPageError(page);
> > > data.c-		else
> > > data.c-			SetPageUptodate(page);
> > 
> > If we cared about speed here then we would delete the DBG_BUGON() check
> > because that's going to be expensive.  The likely/unlikely annotations
> > should be used in places a reasonable person thinks it will make a
> > difference to benchmarks.
> 
> DBG_BUGON will be a no-op ((void)x) in non-debugging mode,

It expands to:

	((void)PageUptodate(page));

Calling PageUptodate() doesn't do anything, but it isn't free.  The
time it takes to do that function call completely negates any speed up
from using likely/unlikely.

I'm really not trying to be a jerk...

regards,
dan carpenter

