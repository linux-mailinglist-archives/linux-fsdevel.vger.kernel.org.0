Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0208049B93A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 17:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1585941AbiAYQuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 11:50:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1586339AbiAYQs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:48:59 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PF4BGi000357;
        Tue, 25 Jan 2022 16:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=AMeUWw9QE5S+iubtCjgVF4UNwJUctJS/odXW19bAR58=;
 b=L5vQnd5mr+RwR5kDLUc7Gu1Y7zid5tj+xUnhc9WDF4bIHsoaqG6w8Ywt8tAyjZeVidFz
 9EwZRVydlfAAT8BQU652Y2bWwQ2r1BwGBe2/KsLZA4g55gKZQUHzb6rDIvNARqEva/4s
 Xvvn9W1WkI8AcbSyOcVta4Y3tO5X7v9PuOADZOiivWApm/EHXb3mwA48dh1B1zpSGwWW
 LZgA9Ze6GWMZQ4gMQS47T38CeMCYuOyTpnEHaz4kYGWI+MIQZu194k5euKGgNtQAofaF
 q2uMAiQtd1shzrerS7bg0Kg1dQ89DDgZpjTovmBkCWoLYODatIInmQboN6sIhGXHwaC3 yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtjcxvwj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 16:48:59 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PFtiFZ002040;
        Tue, 25 Jan 2022 16:48:58 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtjcxvwhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 16:48:58 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PGlS6T017888;
        Tue, 25 Jan 2022 16:48:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3dr9j988kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 16:48:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PGmsB223396794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 16:48:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFB10A4060;
        Tue, 25 Jan 2022 16:48:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F498A405B;
        Tue, 25 Jan 2022 16:48:53 +0000 (GMT)
Received: from localhost (unknown [9.43.56.228])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 16:48:52 +0000 (GMT)
Date:   Tue, 25 Jan 2022 22:18:51 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] bad_inode: add missing i_op initializers for
 fileattr_get/_set
Message-ID: <20220125164851.m2p3glqlsdpnvdjg@riteshh-domain>
References: <4bdc14fd6bf5cbe17bebeea2165840a2af6c4cf8.1642002262.git.riteshh@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bdc14fd6bf5cbe17bebeea2165840a2af6c4cf8.1642002262.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kMJ33tApT7rCzvGNnahs5B09sBOtVuCn
X-Proofpoint-ORIG-GUID: 5N6lm9wCoexO0XZ2SJvgNg5_YVaIVheh
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_03,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250105
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gentle Ping!!

On 22/01/12 09:20PM, Ritesh Harjani wrote:
> Let's bring inode_operations in sync for bad_inode_ops.
> Some of the reasons are listed here [1]. But mostly it is
> just for completeness sake I think.
>
> This patch also removes some of the whitespaces at the end of line
> which is due to my editor config settings for kernel work.
>
> [1]: https://lore.kernel.org/lkml/1473708559-12714-2-git-send-email-mszeredi@redhat.com/
>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/bad_inode.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/fs/bad_inode.c b/fs/bad_inode.c
> index 12b8fdcc445b..08d5e44316cc 100644
> --- a/fs/bad_inode.c
> +++ b/fs/bad_inode.c
> @@ -160,6 +160,17 @@ static int bad_inode_set_acl(struct user_namespace *mnt_userns,
>  	return -EIO;
>  }
>
> +static int bad_inode_fileattr_set(struct user_namespace *mnt_userns,
> +			struct dentry *dentry, struct fileattr *fa)
> +{
> +	return -EIO;
> +}
> +
> +static int bad_inode_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> +{
> +	return -EIO;
> +}
> +
>  static const struct inode_operations bad_inode_ops =
>  {
>  	.create		= bad_inode_create,
> @@ -183,18 +194,19 @@ static const struct inode_operations bad_inode_ops =
>  	.atomic_open	= bad_inode_atomic_open,
>  	.tmpfile	= bad_inode_tmpfile,
>  	.set_acl	= bad_inode_set_acl,
> +	.fileattr_set	= bad_inode_fileattr_set,
> +	.fileattr_get	= bad_inode_fileattr_get,
>  };
>
> -
>  /*
>   * When a filesystem is unable to read an inode due to an I/O error in
>   * its read_inode() function, it can call make_bad_inode() to return a
> - * set of stubs which will return EIO errors as required.
> + * set of stubs which will return EIO errors as required.
>   *
>   * We only need to do limited initialisation: all other fields are
>   * preinitialised to zero automatically.
>   */
> -
> +
>  /**
>   *	make_bad_inode - mark an inode bad due to an I/O error
>   *	@inode: Inode to mark bad
> @@ -203,7 +215,7 @@ static const struct inode_operations bad_inode_ops =
>   *	failure this function makes the inode "bad" and causes I/O operations
>   *	on it to fail from this point on.
>   */
> -
> +
>  void make_bad_inode(struct inode *inode)
>  {
>  	remove_inode_hash(inode);
> @@ -211,9 +223,9 @@ void make_bad_inode(struct inode *inode)
>  	inode->i_mode = S_IFREG;
>  	inode->i_atime = inode->i_mtime = inode->i_ctime =
>  		current_time(inode);
> -	inode->i_op = &bad_inode_ops;
> +	inode->i_op = &bad_inode_ops;
>  	inode->i_opflags &= ~IOP_XATTR;
> -	inode->i_fop = &bad_file_ops;
> +	inode->i_fop = &bad_file_ops;
>  }
>  EXPORT_SYMBOL(make_bad_inode);
>
> @@ -222,17 +234,17 @@ EXPORT_SYMBOL(make_bad_inode);
>   * &bad_inode_ops to cover the case of invalidated inodes as well as
>   * those created by make_bad_inode() above.
>   */
> -
> +
>  /**
>   *	is_bad_inode - is an inode errored
>   *	@inode: inode to test
>   *
>   *	Returns true if the inode in question has been marked as bad.
>   */
> -
> +
>  bool is_bad_inode(struct inode *inode)
>  {
> -	return (inode->i_op == &bad_inode_ops);
> +	return (inode->i_op == &bad_inode_ops);
>  }
>
>  EXPORT_SYMBOL(is_bad_inode);
> --
> 2.31.1
>
