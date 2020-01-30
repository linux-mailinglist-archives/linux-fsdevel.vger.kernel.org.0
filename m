Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715C414D859
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 10:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgA3JmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 04:42:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34032 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgA3JmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 04:42:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00U9cBCP038371;
        Thu, 30 Jan 2020 09:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=0og+jrYQCRlDYW/CzD3/8NfXAB9kciV4BQAj0SPLmyE=;
 b=fJHuLhhhBycwkIdNvXPucQQ+4rV5a6sXyoxMX/WhNDvRFDd037vSWRZz/zVIDQ75WV2O
 4dAhNTfVC8BBCKIjcYLgrUj0kL4gKQrXzwylSKLsAmE2E2MygWS3Cf38WkGZuW6IbMag
 POCzoEzwLtWU02STufIsFJG0lInDDeNtpUD4Bg+DB6tlRJbITjr752kCZNg1f3UCvB+Q
 93DMh63MTCrjuWP77LXHJFW/3GJilUiueT+OvZyXddze/dm4Dqj1o8vrWo/Y2QoGMPe1
 s1+MciY1sVDIzpj9yhkdyOxlzRYeuQBMFFpqk7+5Aly1oqPUFe6KZCyJ4XAB93WIX5ZE mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xrearjpn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 09:42:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00U9dBqu105945;
        Thu, 30 Jan 2020 09:42:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xu8e8aec3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 09:41:59 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00U9fqMW014053;
        Thu, 30 Jan 2020 09:41:52 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 01:41:51 -0800
Date:   Thu, 30 Jan 2020 12:41:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp
Subject: Re: [PATCH v2] staging: exfat: remove 'vol_type' variable.
Message-ID: <20200130094142.GC1778@kadam>
References: <20200130070614.11999-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130070614.11999-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9515 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001300068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9515 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001300068
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 04:06:13PM +0900, Tetsuhiro Kohada wrote:
> remove 'vol_type' variable.
> 
> The following issues are described in exfat's TODO.
> > clean up the remaining vol_type checks, which are of two types:
> > some are ?: operators with magic numbers, and the rest are places
> > where we're doing stuff with '.' and '..'.
> 
> The vol_type variable is always set to 'EXFAT'.
> The variable checks are unnessesary, so remove unused code.
> 
> Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
> Reviewed-by: Mori Takahiro <Mori.Takahiro@ab.MitsubishiElectric.co.jp>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Changes in v2:
> - Remove wrong check in exfat_readdir(), as suggested by Dan Carpenter.

We wouldn't normally give a Suggested-by tag for this, but no one counts
Suggested-by tags anyway so it doesn't matter.

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

