Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90592D1F89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 01:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgLHAwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 19:52:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39734 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgLHAwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:52:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B80ZG3r169794;
        Tue, 8 Dec 2020 00:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=dCCrolQTLlPTnGT/+ou/zgHAxrQA2Td9KFlQJ81GEaw=;
 b=HA/UNN1KdF+IWmJeLMxa+5V2tyEAkRq7qRpQNc1IIDJRMSFgt+PdZuxlZJKmCY/7juhm
 JZrUD275rgrHa48n41EitbcuKp3loecO0hbaot+Jc9ZaEIdoEegQeEIO2HmjSaaLVfS8
 e8EGDMUYZzD1oiqmpyXC4Hdwx3c8Zi/JPgGbFp2ZoVQNinucFwz5KumC/xSk/gmGisHA
 Hqe1Ftxl7IFuyjXrrs11jCsEgd7KcNnE1rdj6Rq9pmvRX6OnSH4kHY7Mk+dhg88IbAfG
 CaB2iM2MldtZEDGZafq6Gfvv9je+u67SF5nXOdAbIpGoeWa7SlN6ZNwG2Kq7Sbl1VSbs Mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35825m0avu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 00:51:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B80YjQn035129;
        Tue, 8 Dec 2020 00:51:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 358ksmw34k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 00:51:15 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B80pBst017354;
        Tue, 8 Dec 2020 00:51:11 GMT
Received: from localhost (/10.159.240.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 16:51:11 -0800
Date:   Mon, 7 Dec 2020 16:51:10 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 5/8] vfs: Include origin of the SB error notification
Message-ID: <20201208005110.GA106255@magnolia>
References: <20201208003117.342047-1-krisman@collabora.com>
 <20201208003117.342047-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208003117.342047-6-krisman@collabora.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:31:14PM -0300, Gabriel Krisman Bertazi wrote:
> When reporting a filesystem error, we really need to know where the
> error came from, therefore, include "function:line" information in the
> notification sent to userspace.  There is no current users of notify_sb
> in the kernel, so there are no callers to update.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  include/linux/fs.h               | 11 +++++++++--
>  include/uapi/linux/watch_queue.h |  3 +++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index df588edc0a34..864d86fcc68c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3514,14 +3514,17 @@ static inline void notify_sb(struct super_block *s,
>  /**
>   * notify_sb_error: Post superblock error notification.
>   * @s: The superblock the notification is about.
> + * @function: function name reported as source of the warning.
> + * @line: source code line reported as source of the warning.
>   * @error: The error number to be recorded.
>   * @inode: The inode the error refers to (if available, 0 otherwise)
>   * @block: The block the error refers to (if available, 0 otherwise)
>   * @fmt: Formating string for extra information appended to the notification
>   * @args: arguments for extra information string appended to the notification
>   */
> -static inline int notify_sb_error(struct super_block *s, int error,  u64 inode,
> -				  u64 block, const char *fmt, va_list *args)
> +static inline int notify_sb_error(struct super_block *s, const char *function, int line,
> +				  int error, u64 inode, u64 block,
> +				  const char *fmt, va_list *args)
>  {
>  #ifdef CONFIG_SB_NOTIFICATIONS
>  	if (unlikely(s->s_watchers)) {
> @@ -3534,8 +3537,12 @@ static inline int notify_sb_error(struct super_block *s, int error,  u64 inode,
>  			.error_cookie	= 0,
>  			.inode		= inode,
>  			.block		= block,
> +			.line		= line,
>  		};
>  
> +		memcpy(&n.function, function, SB_NOTIFICATION_FNAME_LEN);
> +		n.function[SB_NOTIFICATION_FNAME_LEN-1] = '\0';
> +
>  		post_sb_notification(s, &n.s, fmt, args);
>  	}
>  #endif
> diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
> index 937363d9f7b3..5fa5286c5cc7 100644
> --- a/include/uapi/linux/watch_queue.h
> +++ b/include/uapi/linux/watch_queue.h
> @@ -114,6 +114,7 @@ enum superblock_notification_type {
>  
>  #define NOTIFY_SUPERBLOCK_IS_NOW_RO	WATCH_INFO_FLAG_0 /* Superblock changed to R/O */
>  
> +#define SB_NOTIFICATION_FNAME_LEN 30
>  /*
>   * Superblock notification record.
>   * - watch.type = WATCH_TYPE_MOUNT_NOTIFY
> @@ -130,6 +131,8 @@ struct superblock_error_notification {
>  	__u32	error_cookie;
>  	__u64	inode;
>  	__u64	block;
> +	char	function[SB_NOTIFICATION_FNAME_LEN];
> +	__u16	line;

Er... this is enlarging a structure in the userspace ABI, right?  Which
will break userspace that latched on to the structure definition in the
previous patch, and therefore isn't expecting a function name here.

If you're gonna put a character string(?) at the end then I guess you
have to pre-pad the notification structure so that we can add things
later, or.... bump the type code every time you add a field?

(Maybe I misread that?  But this is include/uapi/...)

--D

>  	char	desc[0];
>  };
>  
> -- 
> 2.29.2
> 
