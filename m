Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571446BE98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfGQOxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 10:53:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45322 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfGQOxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:53:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HEmXxX110166;
        Wed, 17 Jul 2019 14:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=rQToKErxdISy1yEIPgia5XAgF79sMHgn43tT5BHtQ10=;
 b=3aiWB2HNx3TZ4d8vH8shlTphOD4rB4+bgzt24Riokh2d5s6fkpKmHPgbj4UtFZ31g6kT
 CG9EDFl7cW8hpnqHROJbvqewpHxQHxm19FeghK/yO2KEP7DclIr6H+YW9pWwWqqhUSa2
 VCUJI3ylE8k3mwctmVgHAwD6GccEpb2sMQIItIYhb9iFU+hfJwjZaNXEvDtggJjc42nV
 48Zg7MrA50y1/B2gjtMNrjP1GPVU1TAG7u6B80wmLjmpY1ZZ31nYPav10459vKasLE2F
 O4pqYUTmmcuLXj3mlJzPzuB+Lg7taZmdToUsd2E823ReJJlj2sC/73fS6B93ZZ9DMweh gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tq7xr3a9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 14:53:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HEmUCf053469;
        Wed, 17 Jul 2019 14:53:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tq4dujrt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 14:53:19 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6HErIFf008936;
        Wed, 17 Jul 2019 14:53:18 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 14:53:18 +0000
Date:   Wed, 17 Jul 2019 07:53:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        agruenba@redhat.com
Subject: Re: [PATCH 8/8] iomap: move internal declarations into fs/iomap/
Message-ID: <20190717145317.GC7093@magnolia>
References: <156334313527.360395.511547592522547578.stgit@magnolia>
 <156334318826.360395.9686513875631453909.stgit@magnolia>
 <20190717062231.GB27285@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717062231.GB27285@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=908
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=977 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170174
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:22:31PM -0700, Christoph Hellwig wrote:
> On Tue, Jul 16, 2019 at 10:59:48PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Move internal function declarations out of fs/internal.h into
> > include/linux/iomap.h so that our transition is complete.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Didn't I ack this earlier?
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

<urk> Yep, sorry, it was late.  Fixed. :/

--D
