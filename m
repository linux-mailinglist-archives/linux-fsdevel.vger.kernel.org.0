Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDF6119652
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 22:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfLJV0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 16:26:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59326 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfLJV0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:26:08 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBALP42H085099;
        Tue, 10 Dec 2019 21:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=LRKUalzriL5ok3aXCwAsAQdRDswfuxXEmRoEL5R3TtY=;
 b=qRuA9OX6Lqg8zmfw57L2wmzOrVMWgVD9OI0uuHugWGpz0CV8TJnGmoNqnr7/dGFNmQNu
 D9HL4m90Vv46Ux8ckl6W/e6ofx9mnh4Bp+m1QJFkI0UeVRqGHxh+WgN1sGEm1ytHIy6x
 JRbMFbaSmf/J5yNWFqMTuGH/TQT3/bAyWvgTJ4/CMqZNQVRo5bZqWTzXyUVIz7ALDB/u
 kY1BHyD0m4u/K+ZR/VNJlt5lL96+BSeuP2ajYHmmDZnDETCDcCH+pmD2Vxk4I7KQpiAR
 HaSbeRCCqkE8AdUzbW8kTLuHiUzPqtObUalrZZY3D8alSwPtjI1DXKtmGVsEnd8YOm0H MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wr41q8w2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 21:25:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBALLnFo141716;
        Tue, 10 Dec 2019 21:25:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wt6bdwp09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 21:25:53 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBALPrXC020312;
        Tue, 10 Dec 2019 21:25:53 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Dec 2019 13:25:53 -0800
Date:   Tue, 10 Dec 2019 13:25:52 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [PATCH] iomap: Export iomap_page_create and
 iomap_set_range_uptodate
Message-ID: <20191210212552.GC99875@magnolia>
References: <20191210102916.842-1-agruenba@redhat.com>
 <20191210203252.GA99875@magnolia>
 <CAHpGcMJMgttnXu48wHnP-WqdPkuXBaFd+COKV9XiRP6VrtRUVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMJMgttnXu48wHnP-WqdPkuXBaFd+COKV9XiRP6VrtRUVg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912100176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912100177
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:39:31PM +0100, Andreas Grünbacher wrote:
> Am Di., 10. Dez. 2019 um 21:33 Uhr schrieb Darrick J. Wong
> <darrick.wong@oracle.com>:
> > On Tue, Dec 10, 2019 at 11:29:16AM +0100, Andreas Gruenbacher wrote:
> > > These two functions are needed by filesystems for converting inline
> > > ("stuffed") inodes into non-inline inodes.
> > >
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> >
> > Looks fine to me... this is a 5.6 change, correct?
> 
> Yes, so there's still plenty of time to get things in place until
> then. I'd like to hear from Christoph if he has any objections. In any
> case, this patch isn't going to break anything.

By the way, the other symbols in fs/iomap/ are all EXPORT_SYMBOL_GPL.
Does gfs2/RH/anyone have a particular requirement for EXPORT_SYMBOL, or
could we make the new exports _GPL to match the rest?

--D

> Thanks,
> Andreas
