Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5EF2B754
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfE0OM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 10:12:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42906 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfE0OMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 10:12:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4RE42rW174023;
        Mon, 27 May 2019 14:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=qrSLHq5l67KqXHwHH5JZoEqm27Q5vubRy/g+MwfUmWQ=;
 b=Z4GzkJ16bsxc9hFFbZurqUQJspZqKJ1jD3v3Nv5BBjRyUksPO8UGenakViMCVa0BY8I8
 XTTf/WAfNOuXEiXK8MNQuieTcQtuMNJNdyEyXITTsNNFceJHMWhBIkyb3r2l/ddWdIXr
 m/miNy3tMowWm4HNyqPR80e5qyqEv0b2jjKExutQ5FaaavjWS7YvAOtLvE5uoH6FDHvi
 HQ1wkyvvCDL6q5+TjEqES/ugQY/n9BkUr81WWEgXoJdaomqjLrEFJhIKp5YcYaMAarJa
 YqWPTlGF5LL4XhqQPkS6rY9j2eIy6Uj2RZMMZnJwfBTfLLvx4vSeLLVcRneTV/hxol2w 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2spu7d6qbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 14:12:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4RE9n0b036338;
        Mon, 27 May 2019 14:10:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2srbdwcp26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 14:10:22 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4REAKhd004090;
        Mon, 27 May 2019 14:10:20 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 May 2019 07:10:19 -0700
Date:   Mon, 27 May 2019 17:10:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] io_uring: add support for sqe links
Message-ID: <20190527141014.GI24680@kadam>
References: <20190527100808.GA31410@mwanda>
 <e46527f2-44f9-499d-3de9-510fc8f08feb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e46527f2-44f9-499d-3de9-510fc8f08feb@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905270100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905270100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 27, 2019 at 07:36:22AM -0600, Jens Axboe wrote:
> On 5/27/19 4:08 AM, Dan Carpenter wrote:
> > Hello Jens Axboe,
> > 
> > The patch f3fafe4103bd: "io_uring: add support for sqe links" from
> > May 10, 2019, leads to the following static checker warning:
> > 
> > 	fs/io_uring.c:623 io_req_link_next()
> > 	error: potential NULL dereference 'nxt'.
> > 
> > fs/io_uring.c
> >     614  static void io_req_link_next(struct io_kiocb *req)
> >     615  {
> >     616          struct io_kiocb *nxt;
> >     617
> >     618          nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
                                                    ^^^^^^^^^^^^^^^
If this list is empty then "nxt" is NULL.

> >     619          list_del(&nxt->list);
> >                            ^^^^^^^^^
> > The warning is a false positive but this is a NULL dereference.
> > 
> >     620          if (!list_empty(&req->link_list)) {
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We're checking for list_empty() here.

> >     621                  INIT_LIST_HEAD(&nxt->link_list);
> >                                          ^^^^^
> > False positive.
> 
> Both of them are false positives. I can work around them though, as it
> probably makes it a bit cleaner, too.
> 
> > 
> >     622                  list_splice(&req->link_list, &nxt->link_list);
> >     623                  nxt->flags |= REQ_F_LINK;
> >     624          }
> >     625
> >     626          INIT_WORK(&nxt->work, io_sq_wq_submit_work);
> >                            ^^^^^^^^^^
> >     627          queue_work(req->ctx->sqo_wq, &nxt->work);
> >                                               ^^^^^^^^^^
> > Other bugs.
> 
> Not sure what that means?

All these dereferences outside the if not empty check are a problem.

regards,
dan carpenter

