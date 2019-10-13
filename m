Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCBBD56D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 18:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfJMQlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 12:41:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37364 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfJMQlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 12:41:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9DGdYc6031586;
        Sun, 13 Oct 2019 16:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=OPvDoFNhpdDqTJICy1n9atZ2eTMPxQs1GILfHJKGOjY=;
 b=Gl3zj2kuuy5Snan7UUvoOusIEPlbZbnHN4J6nIoCQH9wLyTr5BfPOnYimAW0koKa54CU
 QwgV+4FlYu+YyNcNOatAt9LAS13hZGgqJB+9an4P9FFVNVkMPmQkZLlfofnjMuNP5vfV
 kFnLtf4IYg3i28FBmJqAfVEfjmjU9y5CmY8vX2+ex8qxwtDLbdvbSaQbtxOsaWwPNadX
 cIUWdWrWUEo8kBY7303fOV8dN26UNLb1wGssbWQjfSviYdrxZqJ8wVCRF7cWbAi+D7DQ
 OOhzP4kuEjMiq813yD7j7oxltkErHDRu1Krsu/uhKpRM4p2WDOBGFuumXPl7GrL2dEca iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vk6sq4gcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Oct 2019 16:41:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9DGcMdO072186;
        Sun, 13 Oct 2019 16:41:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vkr9ut2nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Oct 2019 16:41:27 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9DGfP4d012181;
        Sun, 13 Oct 2019 16:41:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 13 Oct 2019 09:41:25 -0700
Date:   Sun, 13 Oct 2019 09:41:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>
Subject: Re: [Project Quota]file owner could change its project ID?
Message-ID: <20191013164124.GR13108@magnolia>
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910130167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910130167
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 12, 2019 at 02:33:36PM +0800, Wang Shilong wrote:
> Steps to reproduce:
> [wangsl@localhost tmp]$ mkdir project
> [wangsl@localhost tmp]$ lsattr -p project -d
>     0 ------------------ project
> [wangsl@localhost tmp]$ chattr -p 1 project
> [wangsl@localhost tmp]$ lsattr -p -d project
>     1 ------------------ project
> [wangsl@localhost tmp]$ chattr -p 2 project
> [wangsl@localhost tmp]$ lsattr -p -d project
>     2 ------------------ project
> [wangsl@localhost tmp]$ df -Th .
> Filesystem     Type  Size  Used Avail Use% Mounted on
> /dev/sda3      xfs    36G  4.1G   32G  12% /
> [wangsl@localhost tmp]$ uname -r
> 5.4.0-rc2+
> 
> As above you could see file owner could change project ID of file its self.
> As my understanding, we could set project ID and inherit attribute to account
> Directory usage, and implement a similar 'Directory Quota' based on this.

So the problem here is that the admin sets up a project quota on a
directory, then non-container users change the project id and thereby
break quota enforcement?  Dave didn't sound at all enthusiastic, but I'm
still wondering what exactly you're trying to prevent.

(Which is to say, maybe we introduce a mount option to prevent changing
projid if project quota *enforcement* is enabled?)

--D

> But Directories could easily break this limit by change its file to
> other project ID.
> 
> And we used vfs_ioc_fssetxattr_check() to only allow init userspace to
> change project quota:
> 
>         /*
> 
>          * Project Quota ID state is only allowed to change from within the init
> 
>          * namespace. Enforce that restriction only if we are trying to change
> 
>          * the quota ID state. Everything else is allowed in user namespaces.
> 
>          */
> 
>         if (current_user_ns() != &init_user_ns) {
> 
>                 if (old_fa->fsx_projid != fa->fsx_projid)
> 
>                         return -EINVAL;
> 
>                 if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
> 
>                                 FS_XFLAG_PROJINHERIT)
> 
>                         return -EINVAL;
> 
>         }
> 
> Shall we have something like following to limit admin change for
> Project state too?
> 
> diff --git a/fs/inode.c b/fs/inode.c
> 
> index fef457a42882..3e324931ee84 100644
> 
> --- a/fs/inode.c
> 
> +++ b/fs/inode.c
> 
> @@ -2273,7 +2273,7 @@ int vfs_ioc_fssetxattr_check(struct inode
> *inode, const struct fsxattr *old_fa,
> 
>          * namespace. Enforce that restriction only if we are trying to change
> 
>          * the quota ID state. Everything else is allowed in user namespaces.
> 
>          */
> 
> -       if (current_user_ns() != &init_user_ns) {
> 
> +       if (current_user_ns() != &init_user_ns || !capable(CAP_SYS_ADMIN)){
> 
>                 if (old_fa->fsx_projid != fa->fsx_projid)
> 
>                         return -EINVAL;
> 
>                 if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
