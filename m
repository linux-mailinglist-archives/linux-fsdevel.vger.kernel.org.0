Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CBFF3D0B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 01:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfKHAsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 19:48:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60638 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKHAsi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:48:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA80dGWK173022;
        Fri, 8 Nov 2019 00:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=qCzBTULDiMobFm746wjs1oajkPZhfNQUtF4ENZEcn1w=;
 b=Scy8BtcjDBRW5XBvtpGEz2DRtoNA2JOY8Tco7w5Og/99OFUexQFaKKfq6x1rcRq0Sqg9
 Xxw4dYmicSsch/goEwUtXaBIHAw6mPfAb+wO5M1zPlUVIL0S4OXwUQTKE5yY+QK4GJeh
 EaqFZ88ILwrzsSv9BZa9NBkEP5+sYG9HrECVLrW9SI7bf04+RLDx97fpKFG2No8OJCWe
 Rb6kC07voC3YpMlq34QLJPkZVcvmL1cM1sKlkm+x1qmTKx3wm3H7ksMmFYG61U6bX8MB
 Q104R8ul6rr/aBvkVFXnrEkMN6Bzc9tlTn1LvIo0mhBOhd7s1kfUnxvup/hA/jWsVZr3 UQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w41w19xe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 00:47:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA80dEpU135124;
        Fri, 8 Nov 2019 00:47:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w41wg9u0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 00:47:02 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA80l13R014531;
        Fri, 8 Nov 2019 00:47:01 GMT
Received: from localhost (/10.145.179.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 16:47:01 -0800
Date:   Thu, 7 Nov 2019 16:47:00 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-man@vger.kernel.org, dhowells@redhat.com, jaegeuk@kernel.org,
        linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, victorhsieh@google.com
Subject: Re: [man-pages RFC PATCH] statx.2: document STATX_ATTR_VERITY
Message-ID: <20191108004700.GA6213@magnolia>
References: <20191107014420.GD15212@magnolia>
 <20191107220248.32025-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107220248.32025-1-ebiggers@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080005
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 07, 2019 at 02:02:48PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Document the verity attribute for statx().
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  man2/statx.2 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> RFC since the kernel patches are currently under review.
> The kernel patches can be found here:
> https://lkml.kernel.org/linux-fscrypt/20191029204141.145309-1-ebiggers@kernel.org/T/#u
> 
> diff --git a/man2/statx.2 b/man2/statx.2
> index d2f1b07b8..713bd1260 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -461,6 +461,10 @@ See
>  .TP
>  .B STATX_ATTR_ENCRYPTED
>  A key is required for the file to be encrypted by the filesystem.
> +.TP
> +.B STATX_ATTR_VERITY
> +The file has fs-verity enabled.  It cannot be written to, and all reads from it
> +will be verified against a Merkle tree.

mkerrisk might ask you to start the new sentence on a separate line, but
otherwise looks good to me. :)

--D

>  .SH RETURN VALUE
>  On success, zero is returned.
>  On error, \-1 is returned, and
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
