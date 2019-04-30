Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1038F210
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 10:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfD3Ic2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 04:32:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55014 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfD3Ic2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:32:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U8JsQt158710;
        Tue, 30 Apr 2019 08:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yWR9MTfmutWwKIN9OJ1tFhcDDCjFC5vqWJwkYOA89/4=;
 b=YKGy5m/GkNSaOWuhhhU1lZANzX7gdYTSvMMyT4V5YBgrFWmrFeXkZGZhdHPW6RpDkFlL
 jkT+RTDok4lMOD6Z+WDW1cYOpqkTFqCB+5w/NYs/E1U1Dma3/HKmbf6OkiOW0EzVjwb4
 ou4mqosGOrG99dRZd5lM6+wN0Bc6HzOaAMqm50w80r/AjYJZJaVjDlgZXxXDVVGMEQom
 nU4c3XcqhwwrdLl4x2C3JsfNlk+NkfNdpISxkUCZs6HymnXUZ3vnw/ef4sX8ALdSlnIc
 hdEWxl8o/4CVmwOOFKULD40ZD3Kj8B6oCx3PFgfbg1PdH/uA71nQuGoPmHKVR/TMio93 gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2s4fqq2wmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 08:32:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U8UjFs079719;
        Tue, 30 Apr 2019 08:32:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2s4ew142ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 08:32:21 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3U8WJkX025399;
        Tue, 30 Apr 2019 08:32:19 GMT
Received: from kadam (/196.97.65.153)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 01:32:19 -0700
Date:   Tue, 30 Apr 2019 11:32:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] chardev: set variable ret to -EBUSY before
 checking minor range overlap
Message-ID: <20190430083206.GA2239@kadam>
References: <20190426073837.23086-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426073837.23086-1-cgxu519@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300057
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300057
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please don't say RESEND, say [PATCH v2].  RESEND is for when we ignored
your patch.  (Maybe we made a mistake or maybe the mailing list tagged
it as spam and deleted it or something).  Use [PATCH v2] instead.

On Fri, Apr 26, 2019 at 03:38:37PM +0800, Chengguang Xu wrote:
> When allocating dynamic major, the minor range overlap check
> in __register_chrdev_region() will not fail, so actually
> there is no real case to passing non negative error code to
> caller. However, set variable ret to -EBUSY before chekcking
> minor range overlap will avoid false-positive warning from
> code analyzing tool(like Smatch) and also make the code more
> easy to understand.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---

Then here under the --- cut off line put:

v2: rebase against the latest linux-next

That way we will remember why the patch was sent twice and what changed.

>  fs/char_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

regards,
dan carpenter
