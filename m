Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36980EDD2A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfKDK62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:58:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36732 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbfKDK61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:58:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4AtrM6192477;
        Mon, 4 Nov 2019 10:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=4Huoh6wIugbFZjm22QuBBMKrcUJPLMn8KTchxHNOYUs=;
 b=Us4rdO0EZAqnQE6q0ebNjGiLk/WCjwlneykewTNpgc7fSmdinOhKH/ZQeXpBmQOxxi7J
 51gnEg3dU75yEIGmH5ni4BnLMp5p2dNq0oyY6eqSyLUrBL7gc4XXdT3eKg65IQqgiNsl
 98ahwAuAyY8CqGaT4c+ITllsOKkqByJrJNr0yMTFTW4vGIBM+ezl/9Jl+ss9SwIIv7Ca
 30D6y0HsjcePt7sGVfu1Sv+TMS7GTmGSXFsqNW2ZfZDJQQFZx4Gu7/HX6tXyl7g6lIwZ
 H1GmnuusRDTQa4uRFSAiWkAzNBYYVClL7XOv2VD8KodLu/ZSPyWg3smrrldWf8AKcdiU uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w12eqxa8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 10:58:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4AssUd142627;
        Mon, 4 Nov 2019 10:56:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2w1kxd1qcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 10:56:20 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA4AuJ7s000754;
        Mon, 4 Nov 2019 10:56:19 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 02:56:19 -0800
Date:   Mon, 4 Nov 2019 13:56:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] staging: exfat: Clean up return codes -
 FFS_SUCCESS
Message-ID: <20191104105612.GG21796@kadam>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
 <20191104014510.102356-8-Valdis.Kletnieks@vt.edu>
 <20191104100413.GC10409@kadam>
 <128761.1572864835@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <128761.1572864835@turing-police>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040109
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 05:53:55AM -0500, Valdis Klētnieks wrote:
> On Mon, 04 Nov 2019 13:04:14 +0300, Dan Carpenter said:
> > On Sun, Nov 03, 2019 at 08:45:03PM -0500, Valdis Kletnieks wrote:
> > > -	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
> > > +	if (sector_read(sb, sec, &bp->buf_bh, 1) != 0) {
> >
> > It's better to just remove the "!= 0" double negative.  != 0 should be
> > used when we are talking about the number zero as in "cnt != 0" and for
> > "strcmp(foo, bar) != 0" where it means that "foo != bar".
> 
> "Fix up ==0 and !=0" is indeed on the to-do list.
> 
> This patch converted 82 uses of FFS_SUCCESS, of which 33 had the != idiom in
> use.  Meanwhile, overall there's 53 '!= 0' and 95 '== 0' uses.
> 
> In other words, even if I fixed all of those that were involved in this patch,
> there would *still* be more patching to do.

Very good.  Sounds like the plan.

regards,
dan carpenter

