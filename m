Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1103869944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfGOQnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 12:43:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfGOQnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:43:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FGdHrr079312;
        Mon, 15 Jul 2019 16:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=IVx/xEWz7GgOU3eFfBBG1TknAwbkAj33qdl4vdez7no=;
 b=gZYTNao82cGgNY1FN53TG+7GrMGSd4rjyd+kk8vOTNzg2hch1FOtjGVLIHGMwA1XBXCy
 kQ30ehsfcobWcVAyxr/SdsOpyvaRoj/GrDbkUWGN3EVi7rmbBls7kST5jltuBHIfJe5m
 nK4xATwDUcVeSPxVqOipcinjt46sd/UDtDcHxrUzW9FxxZb7pR4y0zJQd6ovBEjXcPcl
 B+cb2tpNyMKXfACDd07Y9Jdu3IZAcfW+Ql8M1YSyt7af+0JKGwpBnx2DE/qctv44YauR
 LgrsfZjW+94tyXrC2vo1gBn7SFfCZbTuJLvzCfgHg3Ctl+McA6nV37NMuEtFbageR+lW 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xqqkdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 16:43:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FGgjpg097620;
        Mon, 15 Jul 2019 16:43:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tq6mmcmwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 16:43:13 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6FGh8kr018475;
        Mon, 15 Jul 2019 16:43:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 09:43:08 -0700
Date:   Mon, 15 Jul 2019 09:43:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] iomap: regroup code by functional area
Message-ID: <20190715164307.GA6176@magnolia>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
 <20190708184652.GB20670@infradead.org>
 <20190709164952.GT1404256@magnolia>
 <20190709181214.GA31130@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709181214.GA31130@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=899
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150195
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=949 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150194
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 09, 2019 at 11:12:14AM -0700, Christoph Hellwig wrote:
> I looked over it and while some of the small files seem very tiny
> they are reasonably split.
> 
> What rather annoys me is the page.c/read.c/write.c split.  All these
> really belong mostly together, except maybe the super highlevel
> write code that then either calls into the buffer_head vs iomap_page
> based code.  By keeping them together we can eliminate most of
> iomap_internal.h and once the writeback code moves also keep
> iomap_page private to that bigger read.c file.

<nod> I think it makes sense to combine them into a single read_write.c
file or something.

> 
> A few other minor notes:
> 
>  - I think iomap_sector() should move to linux/iomap.h as an inline
>    helper.

So long as you're ok with including blkdev.h from iomap.h. :)

>  - iomap_actor_t / iomap_apply should probaby just move to linux/iomap.h
>    as well, which would avoid needing the awkward subdir include in
>    dax.c

I'd also like to fix the opencoded iomap_apply() in fs/dax.c, but
cleaning all that up looks stressful enough to defer for 5.4.

>  - some of the copyrights for the small files seem totally wrong.
>    e.g. all the swapfile code was written by you, so it should not have
>    my or rh copyright notices on it

Will fix the swapfile code.

--D
