Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185041793DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 16:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbgCDPp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 10:45:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48602 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgCDPp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:45:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024Fcxht136784;
        Wed, 4 Mar 2020 15:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5R0S7uIbNZ//QmYKr6djkngdjgqrJsZKHvkfc8zEFoo=;
 b=HVNocEWcrpek7+5OjIjM1SQOqL1ZOdOl5/HF7VD/T479MNSOd0oCg5A9R5RasrBYGf03
 zCWfiKThvqT71ZleEvkydgqqrkwn5Ci7ntCaI26TKsjfGzZt6HgaSzV3Py+szSyKjbPZ
 avkYPUp9E+/S6KoNW9yIBSqR9xch+PsQrvV1WfYdMPF0zOqufFmJhZP4mfNuuUJgUPvW
 f7LoSowUWA5N5UMmhXh4M13pm9pfy1xr+U7dkmyYfi+zAAYZJOVyobwVd8xRqMioy+Vz
 Hf6ZXMB8AmoRtk9/bqBazkFk0kV+LG1jv4eZC+Q0pLQ32i2YPBhGJZuQAmJ475Fyl4n8 aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yghn3aw73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 15:45:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024Fgphw173547;
        Wed, 4 Mar 2020 15:45:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2yg1rrb65j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 15:45:31 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 024FjSWa014082;
        Wed, 4 Mar 2020 15:45:28 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 07:45:27 -0800
Date:   Wed, 4 Mar 2020 07:45:26 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hibernate: Allow uswsusp to write to swap
Message-ID: <20200304154526.GH8036@magnolia>
References: <20200229170825.GX8045@magnolia>
 <20200229180716.GA31323@dumbo>
 <20200229183820.GA8037@magnolia>
 <20200229200200.GA10970@dumbo>
 <CAJZ5v0iHaZyfuTnqJyM6u=UU=+W6yRuM_Q6iUvB2UudANuwfgA@mail.gmail.com>
 <20200303190212.GC8037@magnolia>
 <9E4A0457-39B1-45E2-AEA2-22C730BF2C4F@gmail.com>
 <20200304011840.GD1752567@magnolia>
 <20200304082327.GA14236@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304082327.GA14236@dumbo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040115
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:23:27AM +0100, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> It turns out that there is one use case for programs being able to
> write to swap devices, and that is the userspace hibernation code.

You might want to start a separate thread for this... :)

> Quick fix: disable the S_SWAPFILE check if hibernation is configured.
> 
> Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")

Also, this should be

Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")

since we still want to set S_SWAPFILE on active swap devices.

> Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Reported-by: Marian Klein <mkleinsoft@gmail.com>
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> ---
>  fs/block_dev.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: b/fs/block_dev.c
> ===================================================================
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -2001,7 +2001,8 @@ ssize_t blkdev_write_iter(struct kiocb *
>  	if (bdev_read_only(I_BDEV(bd_inode)))
>  		return -EPERM;
>  
> -	if (IS_SWAPFILE(bd_inode))
> +	/* uswsusp needs to write to the swap */
> +	if (IS_SWAPFILE(bd_inode) && !IS_ENABLED(CONFIG_HIBERNATION))

...&& hibernation_available() ?  That way we can configure this
dynamically.

Thanks for taking this on, I'll go self-NAK the revert patch I sent
yesterday.

--D

>  		return -ETXTBSY;
>  
>  	if (!iov_iter_count(from))
