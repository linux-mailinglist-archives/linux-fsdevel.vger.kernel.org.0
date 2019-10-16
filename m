Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB1D9D8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 23:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389216AbfJPVhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 17:37:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53180 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbfJPVhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:37:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GLTb7f112184;
        Wed, 16 Oct 2019 21:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=h0mQVvRLvQuNO3P9TCw3137fNadOQPjUeOAlM32MDP8=;
 b=dfusp1MLrRAtuM7nsuXIN3HzHxohQp9Kad6uGsN9aSLq//niP9kBtfJay7FBY7vSpWSL
 VEJa9IoSMNKgPSsPNm91VhKiwPab5kLpXEB4XFxiIWXrZcROJiBrPfWj11nM4uKKgtYJ
 qEau4vZnudVfWxwPfLXTP7AueROkg0zvYTljXRDm708KefZD/Zg6YF08DMutSTAubCVF
 mcdCuIoSiXItnFcHbrKQvkB5c1uSzDpPBaWW6BWnhIqaOrFQnDBjX/FFjK7XLi9Ywhxh
 LjxLr2r2ZWY+szFQKBbF2DdvUIIrStdJueywT80WTpqV4G0WoP2Lqm/1v+NOQHOEwkal pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vk7frhxtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 21:37:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GLYPCt193677;
        Wed, 16 Oct 2019 21:37:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vp70nn4u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 21:37:03 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9GLb1Zv024867;
        Wed, 16 Oct 2019 21:37:01 GMT
Received: from localhost (/10.145.178.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Oct 2019 21:37:00 +0000
Date:   Wed, 16 Oct 2019 14:37:00 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>
Subject: Re: [Project Quota]file owner could change its project ID?
Message-ID: <20191016213700.GH13108@magnolia>
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
 <20191013164124.GR13108@magnolia>
 <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910160177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910160177
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 07:51:15PM +0800, Wang Shilong wrote:
> On Mon, Oct 14, 2019 at 12:41 AM Darrick J. Wong
> <darrick.wong@oracle.com> wrote:
> >
> > On Sat, Oct 12, 2019 at 02:33:36PM +0800, Wang Shilong wrote:
> > > Steps to reproduce:
> > > [wangsl@localhost tmp]$ mkdir project
> > > [wangsl@localhost tmp]$ lsattr -p project -d
> > >     0 ------------------ project
> > > [wangsl@localhost tmp]$ chattr -p 1 project
> > > [wangsl@localhost tmp]$ lsattr -p -d project
> > >     1 ------------------ project
> > > [wangsl@localhost tmp]$ chattr -p 2 project
> > > [wangsl@localhost tmp]$ lsattr -p -d project
> > >     2 ------------------ project
> > > [wangsl@localhost tmp]$ df -Th .
> > > Filesystem     Type  Size  Used Avail Use% Mounted on
> > > /dev/sda3      xfs    36G  4.1G   32G  12% /
> > > [wangsl@localhost tmp]$ uname -r
> > > 5.4.0-rc2+
> > >
> > > As above you could see file owner could change project ID of file its self.
> > > As my understanding, we could set project ID and inherit attribute to account
> > > Directory usage, and implement a similar 'Directory Quota' based on this.
> >
> > So the problem here is that the admin sets up a project quota on a
> > directory, then non-container users change the project id and thereby
> > break quota enforcement?  Dave didn't sound at all enthusiastic, but I'm
> > still wondering what exactly you're trying to prevent.
> 
> Yup, we are trying to prevent no-root users to change their project ID.
> As we want to implement 'Directory Quota':
> 
> If non-root users could change their project ID, they could always try
> to change its project ID to steal space when EDQUOT returns.
> 
> Yup, if mount option could be introduced to make this case work,
> that will be nice.

Well then we had better discuss and write down the exact behaviors of
this new directory quota feature and how it differs from ye olde project
quota.  Here's the existing definition of project quotas in the
xfs_quota manpage:

       10.    XFS  supports  the notion of project quota, which can be
              used to implement a form of directory tree  quota  (i.e.
              to  restrict  a directory tree to only being able to use
              up a component of the filesystems  available  space;  or
              simply  to  keep  track  of the amount of space used, or
              number of inodes, within the tree).

First, we probably ought to add the following to that definition to
reflect a few pieces of current reality:

"Processes running inside runtime environments using mapped user or
group ids, such as container runtimes, are not allowed to change the
project id and project id inheritance flag of inodes."

What do you all think of this starting definition for directory quotas:

       11.    XFS supports the similar notion of directory quota.  The
	      key difference between project and directory quotas is the
	      additional restriction that only a system administrator
	      running outside of a mapped user or group id runtime
	      environment (such as a container runtime) can change the
	      project id and project id inheritenace flag.  This means
	      that unprivileged users are never allowed to manage their
              own directory quotas.

We'd probably enable this with a new 'dirquota' mount option that is
mutually exclusive with the old 'prjquota' option.

--D

> 
> 
> >
> > (Which is to say, maybe we introduce a mount option to prevent changing
> > projid if project quota *enforcement* is enabled?)
> >
> > --D
> >
