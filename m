Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A452B85D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfE0PX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 11:23:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfE0PX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 11:23:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4RFIXAb024562;
        Mon, 27 May 2019 15:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Zcovkmdt49gtmPgW7Q9LuGnoLfdazVdyyvR/BwyXYOo=;
 b=lip9POTCzkcZEQuXaQzrzrFylJxilyNMXTKqF5PlVNR8D+d3OwFvOICjZ4BcBBWwmEXJ
 1hHC2Oh/5vRrB8Rmhuc6sAtqeGHR2QlYUgJ2soXGZcdj1VRLWk2CV4RbWGWjIohWRrAo
 J5p7VybJxJvQfU9V1yQot3m0t/XMxA7ajHR05sALWl+AmbMG3pjMxABI2dFdOdhs2PeC
 dqaajxiaodfVOOcfhY8XqvUQoG0v9Y1D/ailzEwAU18zmwYkDe8w7d/+q8ZJ9qB1RQLh
 9d904jxSRq66tjj47YQnFMeYsXOqLWnkRmLK7zrYJmAGiOzmvBQhq7CqQuX+WhjX6W1Q 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2spxbpxnur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 15:23:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4RFLkmB184731;
        Mon, 27 May 2019 15:23:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2srbdwdgxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 15:23:23 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4RFNMqM016912;
        Mon, 27 May 2019 15:23:22 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 May 2019 08:23:22 -0700
Date:   Mon, 27 May 2019 18:23:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] io_uring: add support for sqe links
Message-ID: <20190527152316.GJ24680@kadam>
References: <20190527100808.GA31410@mwanda>
 <e46527f2-44f9-499d-3de9-510fc8f08feb@kernel.dk>
 <20190527141014.GI24680@kadam>
 <9b7b794b-26ed-7525-5f81-93cb60e1a005@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b7b794b-26ed-7525-5f81-93cb60e1a005@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905270108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905270108
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 27, 2019 at 08:34:18AM -0600, Jens Axboe wrote:
> On 5/27/19 8:10 AM, Dan Carpenter wrote:
> > On Mon, May 27, 2019 at 07:36:22AM -0600, Jens Axboe wrote:
> >> On 5/27/19 4:08 AM, Dan Carpenter wrote:
> >>> Hello Jens Axboe,
> >>>
> >>> The patch f3fafe4103bd: "io_uring: add support for sqe links" from
> >>> May 10, 2019, leads to the following static checker warning:
> >>>
> >>> 	fs/io_uring.c:623 io_req_link_next()
> >>> 	error: potential NULL dereference 'nxt'.
> >>>
> >>> fs/io_uring.c
> >>>      614  static void io_req_link_next(struct io_kiocb *req)
> >>>      615  {
> >>>      616          struct io_kiocb *nxt;
> >>>      617
> >>>      618          nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
> >                                                      ^^^^^^^^^^^^^^^
> > If this list is empty then "nxt" is NULL.
> 
> Right...
> 
> >>>      619          list_del(&nxt->list);
> >>>                             ^^^^^^^^^
> >>> The warning is a false positive but this is a NULL dereference.
> >>>
> >>>      620          if (!list_empty(&req->link_list)) {
> >                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > We're checking for list_empty() here.
> 
> After deleting an entry from it.
> 

Ah...  Right.  Sorry.

regards,
dan carpenter

