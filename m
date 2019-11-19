Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACBDB10194F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 07:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKSGWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 01:22:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33616 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKSGWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:22:33 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ69GPn164783;
        Tue, 19 Nov 2019 06:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=wy+lF6MYsnlvt3ZFLCMryc3CssDPfdNSh6CIREwmXoY=;
 b=SpsxFGdpVfY67u71UbRQ99zRWPdoBJH/1+t27vsdZA6o7KqmA5dB+4ceDK2jyrRBE9nu
 /l4bvHNZVgjFiwYbrLk2L77UBWpMhEtB+3sy7xrHv1KTqkrFOJ60MnNTXDpb4CmoSfW9
 kcnUcf8+BB1fseU8Wp2wQ+Th37JZvm9UnuGOjHi9+kdS9FOX8LIdnUDxXGji0qYVhMWD
 7yoU0aoiRJx09TzYtN+FGzAh7S82KfpiRahzFK3W7ntpMtJe7Yj/PQKIcI1UVZV9j0/g
 DsMOPASnV02zxaioYF2MOnqgivq3ibz8qadhP9OiQ9PvHJooRJEfqlATxNMXET9ZRq6u 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wa8htmtqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:22:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ68iYj034560;
        Tue, 19 Nov 2019 06:22:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wc0afu0w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:22:26 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJ6MPsM026518;
        Tue, 19 Nov 2019 06:22:25 GMT
Received: from kili.mountain (/41.210.141.188)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 22:22:25 -0800
Date:   Tue, 19 Nov 2019 09:22:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] io-wq: remove extra space characters
Message-ID: <20191119062216.qhxmnrt2rdioirja@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=987
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190057
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These lines are indented an extra space character.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
We often see this where the lines after a comment are indented one
space extra.  I don't know if it's an editor thing maybe?

 fs/io-wq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index fcb6c74209da..6d8f5e6c8167 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -333,9 +333,9 @@ static void __io_worker_busy(struct io_wqe *wqe, struct io_worker *worker,
 	 * If worker is moving from bound to unbound (or vice versa), then
 	 * ensure we update the running accounting.
 	 */
-	 worker_bound = (worker->flags & IO_WORKER_F_BOUND) != 0;
-	 work_bound = (work->flags & IO_WQ_WORK_UNBOUND) == 0;
-	 if (worker_bound != work_bound) {
+	worker_bound = (worker->flags & IO_WORKER_F_BOUND) != 0;
+	work_bound = (work->flags & IO_WQ_WORK_UNBOUND) == 0;
+	if (worker_bound != work_bound) {
 		io_wqe_dec_running(wqe, worker);
 		if (work_bound) {
 			worker->flags |= IO_WORKER_F_BOUND;
-- 
2.11.0

