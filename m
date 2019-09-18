Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F07B67CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 18:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfIRQMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 12:12:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35658 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbfIRQMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:12:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IFxlIN194013;
        Wed, 18 Sep 2019 16:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=KFj9Myn6CrdG1AbZ70KLmzxEk2Lf+hQSDxGbFEKpTUE=;
 b=VnxTGb4Q3s8Li1JAsQfhZNDcCjIpGHjP04D3OLQAFGkK6olHLPyjjxF9o6omQdM/qobs
 gE2u6Zwzk0m5ArHuEe+UyfMEF+PYhh2rV70+5jiVKrFWXmOcz2t3DC1/qxA3XwcZA0Gj
 jnZGzhCrqzLTEKSAWA4yhYu1U+dM1Oh/Ojoi/uSIYwAcAgGGbYj43+iH0wqOLYCt316Q
 9XbUf0j9BnK8ORTpHxCFZ4XrLJjM8/o4cqrF3pmPaMcjP4aDLHBhYAXtW+6gC5iv0sM4
 FXa5Z4aLiVN770CcKWKaVOpcG1vaqQlyLSxlCc2Ae7MGTPvaq0ZQy3KyddcQjz+B2FVh 8w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v385dw19m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 16:12:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IFwZQ7032043;
        Wed, 18 Sep 2019 16:12:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2v37mn8yrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 16:12:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8IGChTW014799;
        Wed, 18 Sep 2019 16:12:43 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 09:12:43 -0700
Date:   Wed, 18 Sep 2019 09:12:41 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 9/9] xfs: Get rid of ->bmap
Message-ID: <20190918161241.GW2229799@magnolia>
References: <20190911134315.27380-1-cmaiolino@redhat.com>
 <20190911134315.27380-10-cmaiolino@redhat.com>
 <20190916175049.GD2229799@magnolia>
 <20190918081303.zwnxr7pvtotr7cnt@pegasus.maiolino.io>
 <20190918132436.GA16210@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918132436.GA16210@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=876
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=956 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180154
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 03:24:36PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 18, 2019 at 10:13:04AM +0200, Carlos Maiolino wrote:
> > All checks are now made in the caller, bmap_fiemap() based on the filesystem's
> > returned flags in the fiemap structure. So, it will decide to pass the result
> > back, or just return -EINVAL.
> > 
> > Well, there is no way for iomap (or bmap_fiemap now) detect the block is in a
> > realtime device, since we have no flags for that.
> > 
> > Following Christoph's line of thought here, maybe we can add a new IOMAP_F_* so
> > the filesystem can notify iomap the extent is in a different device? I don't
> > know, just a thought.
> > 
> > This would still keep the consistency of leaving bmap_fiemap() with the decision
> > of passing or not.
> 
> I think this actually is a problem with FIEMAP as well, as it
> doesn't report that things are on a different device.  So I guess for
> now we should fail FIEMAP on the RT device as well.

Or enhance FIEMAP to report some kind of device id like I suggested a
while back...

--D
