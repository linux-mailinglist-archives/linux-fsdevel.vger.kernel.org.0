Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34004A6E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfFRQ31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 12:29:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54484 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfFRQ30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:29:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IGTP6O025845;
        Tue, 18 Jun 2019 16:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=l1dTzqN9G2QJV0pMIlba24yIaHI9Yrth9VNnpv2KwpQ=;
 b=bmWWNVqZuZui0/P61PL/xi7cZGcEvqFnocuRDTDjWmBgNstyjEzN0u2zv1b5kh5ilQdG
 4j7xtdcEGBcAbQjIRAPfsIZcOdVzmcsIGcIBAepb7EpUrAtKQ+K/LxISJmRdoAlFtaJu
 FciE0uH4At0IorYHZcu0ZQwXMFnUy3q6q9jnFac7U6US4B22JHU4PwQujLmNJc25awx0
 RKe/xPRP/XaCvzwtJgI1gqbEpo7WBuxGJwt1Lgz4jimxMu+3kWn5jV8gOOedU6FUTOQZ
 +EN67kP2/sEGGTJQyLCWGwN3ojInDWsrN0oL5TPAF4tYFwz4zNExUYCOygPTulxxeneT YA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t4saqdjmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 16:29:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IGR7lb184857;
        Tue, 18 Jun 2019 16:27:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2t5h5tub9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 16:27:24 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5IGROMo016054;
        Tue, 18 Jun 2019 16:27:24 GMT
Received: from localhost (/10.159.230.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 09:27:23 -0700
Date:   Tue, 18 Jun 2019 09:27:22 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     xfs <linux-xfs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] xfs: claim maintainership of loose files
Message-ID: <20190618162722.GC5387@magnolia>
References: <20190612154001.GC3773859@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612154001.GC3773859@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906180130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906180131
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping?

On Wed, Jun 12, 2019 at 08:40:01AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Claim maintainership over the miscellaneous files outside of fs/xfs/
> that came from xfs.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  MAINTAINERS |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57f496cff999..f0edb53b9dd3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17357,7 +17357,13 @@ W:	http://xfs.org/
>  T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>  S:	Supported
>  F:	Documentation/filesystems/xfs.txt
> +F:	Documentation/ABI/testing/sysfs-fs-xfs
> +F:	Documentation/filesystems/xfs.txt
> +F:	Documentation/filesystems/xfs-delayed-logging-design.txt
> +F:	Documentation/filesystems/xfs-self-describing-metadata.txt
>  F:	fs/xfs/
> +F:	include/uapi/linux/dqblk_xfs.h
> +F:	include/uapi/linux/fsmap.h
>  
>  XILINX AXI ETHERNET DRIVER
>  M:	Anirudha Sarangi <anirudh@xilinx.com>
