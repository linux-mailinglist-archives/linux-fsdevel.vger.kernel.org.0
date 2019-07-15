Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B498969A28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 19:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfGORtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 13:49:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57880 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731731AbfGORtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:49:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHmmLU134133;
        Mon, 15 Jul 2019 17:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=B6htXR3znKx93gY7VoYtlgcbmPH0gXSazDVgPAlyFW0=;
 b=pxEvN7ltirRqHKQaXF/q1MS6UPJ4MrY2O7vNEdlIDjnPrCUi1BnzeosuYXWD/hJekwbC
 LQmecNeDr2EcTzwSEdMhZ151vJmL7UkBfIwhIK2yxrtSYjhpaYbfVzzObY2fVDWG4LJh
 msA1093tWWA+XD92cRM+qn7dsBeEURDwKtfCVl0hq1sTYcta1wKw4UkF4BYvlCn5itjh
 85KhHV2v212O8nHsLgsciIAA+ZqrJWyC8XoeIP0EgHQdQeT8F912lbEvE/OVwIu6DEe9
 Z5F4nFNVPu4aGyzPC8/pc4NkMVTP8dXX8Q3HW7gHNoD5Zb2su6djAolGPk4a0eOQb8B7 TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtg393-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 17:49:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHm1qB164151;
        Mon, 15 Jul 2019 17:49:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tq4dtev9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 17:49:46 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6FHnjlO004249;
        Mon, 15 Jul 2019 17:49:45 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 10:49:45 -0700
Date:   Mon, 15 Jul 2019 10:49:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] iomap: regroup code by functional area
Message-ID: <20190715174944.GC6147@magnolia>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
 <20190708184652.GB20670@infradead.org>
 <20190709164952.GT1404256@magnolia>
 <20190709181214.GA31130@infradead.org>
 <20190715164307.GA6176@magnolia>
 <20190715165012.GA32624@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715165012.GA32624@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=985
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150207
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 15, 2019 at 09:50:13AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 15, 2019 at 09:43:07AM -0700, Darrick J. Wong wrote:
> > On Tue, Jul 09, 2019 at 11:12:14AM -0700, Christoph Hellwig wrote:
> > > I looked over it and while some of the small files seem very tiny
> > > they are reasonably split.
> > > 
> > > What rather annoys me is the page.c/read.c/write.c split.  All these
> > > really belong mostly together, except maybe the super highlevel
> > > write code that then either calls into the buffer_head vs iomap_page
> > > based code.  By keeping them together we can eliminate most of
> > > iomap_internal.h and once the writeback code moves also keep
> > > iomap_page private to that bigger read.c file.
> > 
> > <nod> I think it makes sense to combine them into a single read_write.c
> > file or something.
> 
> page.c or buffered-io.c seems like sensible names to me.

buffered-io.c it is then.

> > >  - some of the copyrights for the small files seem totally wrong.
> > >    e.g. all the swapfile code was written by you, so it should not have
> > >    my or rh copyright notices on it
> > 
> > Will fix the swapfile code.
> 
> Please also look over the other files, a few of them should probably
> be just me (e.g. fiemap) and some have other authors (seek is mostly
> Andreas with a few later bits from me).

<nod> I'll edit the copyrights on fiemap.c.  I'm less sure about making
edits to seek.c because I don't know if Andreas has copyright ownership
or if RH slurped all that up -- the commits are from his @redhat.com
email.  I was about to resend the series so I'll cc him on it.

--D
