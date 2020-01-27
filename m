Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE61014A35C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 12:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgA0L6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 06:58:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35576 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgA0L6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:58:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RBu5Mb010757;
        Mon, 27 Jan 2020 11:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=UXJmR9dagqK7OzmLDkJv/x/mCP+S4hwFTL55xJ1vPQA=;
 b=SiPqxa/kwoSMtB6STifIOL7CNZFSQ5eI+76m5/YWWvZGnJtIY+YKRaLDOCQMdLVHdrug
 AuS6t8kkW7lgtngs9rGXaSKvepjFjquG3KBWdC9R2ZQnfOGUO6gMNXmMmzaUZcZf02PA
 kQ4ZMFbPKeO1ZB8ldAIC8tn9T2bZSvg7/uiZbnvyQ9UkU8klf9AODw4hMhB526dQFOyA
 u6j9NPrRQtLKLdGfdHCZGuAN+1LGclgNsaxWljK7+CSEurwO9GFNv2MGq5JvOyA6i1zh
 c5ozezHGZ/YUIoe4HROFYRXo8qQ2tQr59uBhjxdWoNfa5KaLq8vmm1NBfExeODoevZlN KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xreaqxr9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 11:57:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RBsNoJ087452;
        Mon, 27 Jan 2020 11:57:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xry4u7659-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 11:57:58 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00RBvv6U028196;
        Mon, 27 Jan 2020 11:57:58 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 03:57:57 -0800
Date:   Mon, 27 Jan 2020 14:57:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 09/22] staging: exfat: Rename variable "Size" to "size"
Message-ID: <20200127115741.GA1847@kadam>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
 <20200127101343.20415-10-pragat.pandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127101343.20415-10-pragat.pandya@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270102
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 03:43:30PM +0530, Pragat Pandya wrote:
> Change all the occurences of "Size" to "size" in exfat.
> 
> Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
> ---
>  drivers/staging/exfat/exfat.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
> index 52f314d50b91..a228350acdb4 100644
> --- a/drivers/staging/exfat/exfat.h
> +++ b/drivers/staging/exfat/exfat.h
> @@ -233,7 +233,7 @@ struct date_time_t {
>  
>  struct part_info_t {
>  	u32      offset;    /* start sector number of the partition */
> -	u32      Size;      /* in sectors */
> +	u32      size;      /* in sectors */
>  };

We just renamed all the struct members of this without changing any
users.  Which suggests that this is unused and can be deleted.

regards,
dan carpenter

