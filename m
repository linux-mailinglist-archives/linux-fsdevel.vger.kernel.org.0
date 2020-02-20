Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3986016631E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 17:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgBTQcs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 11:32:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52348 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgBTQcr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:32:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KGVCT0098925;
        Thu, 20 Feb 2020 16:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=FTYI2rf57qFKmy9u3jBDlYnYqczz/CLz4OVjzu82Z1E=;
 b=LO7Fmk/KDnVN3ezdVZMqw61sik/zOyBD+Q5GGp6z5mx54GWjGnXQBfkrPfcQzrUM3os3
 kDOBco/J6q6W87q6xFsEins9Ap3PtCV10MU3HLanN3R6Mu21VX82pZZGug0oBStuzjgV
 o71gtPldYGrgrge7bf+EKi7OZHdCfT1EWbe7Sc5J61djjukDVSZLPzHgGKKrxWP3ssku
 R2fJAi8tlJbFBUtdxXMLuSKg4+hsnoWuEB6tXgAvZbFYHZu9+FyDE/qarwejainY955R
 Vmu9km9IlyL6ZSL3uLWrJOhmTlEMdVKVpL2/ZS2wrHacWL/Sp1CGMR7Jhsr13u8deyh+ BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y8uddaxjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 16:32:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KGS1rc079568;
        Thu, 20 Feb 2020 16:30:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2y8ud6df1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 16:30:28 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01KGUQvD018268;
        Thu, 20 Feb 2020 16:30:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 08:30:26 -0800
Date:   Thu, 20 Feb 2020 08:30:24 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
Message-ID: <20200220163024.GV9506@magnolia>
References: <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
 <20200214200607.GA18593@iweiny-DESK2.sc.intel.com>
 <x4936bcdfso.fsf@segfault.boston.devel.redhat.com>
 <20200214215759.GA20548@iweiny-DESK2.sc.intel.com>
 <x49y2t4bz8t.fsf@segfault.boston.devel.redhat.com>
 <x49tv3sbwu5.fsf@segfault.boston.devel.redhat.com>
 <20200218023535.GA14509@iweiny-DESK2.sc.intel.com>
 <x49zhdgasal.fsf@segfault.boston.devel.redhat.com>
 <20200218235429.GB14509@iweiny-DESK2.sc.intel.com>
 <20200220162027.GA20772@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220162027.GA20772@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 08:20:28AM -0800, Ira Weiny wrote:
> On Tue, Feb 18, 2020 at 03:54:30PM -0800, 'Ira Weiny' wrote:
> > On Tue, Feb 18, 2020 at 09:22:58AM -0500, Jeff Moyer wrote:
> > > Ira Weiny <ira.weiny@intel.com> writes:
> > > > If my disassembly of read_pages is correct it looks like readpage is null which
> > > > makes sense because all files should be IS_DAX() == true due to the mount option...
> > > >
> > > > But tracing code indicates that the patch:
> > > >
> > > > 	fs: remove unneeded IS_DAX() check
> > > >
> > > > ... may be the culprit and the following fix may work...
> > > >
> > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > index 3a7863ba51b9..7eaf74a2a39b 100644
> > > > --- a/mm/filemap.c
> > > > +++ b/mm/filemap.c
> > > > @@ -2257,7 +2257,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> > > >         if (!count)
> > > >                 goto out; /* skip atime */
> > > >  
> > > > -       if (iocb->ki_flags & IOCB_DIRECT) {
> > > > +       if (iocb->ki_flags & IOCB_DIRECT || IS_DAX(inode)) {
> > > >                 struct file *file = iocb->ki_filp;
> > > >                 struct address_space *mapping = file->f_mapping;
> > > >                 struct inode *inode = mapping->host;
> > > 
> > > Well, you'll have to up-level the inode variable instantiation,
> > > obviously.  That solves this particular issue.
> > 
> > Well...  This seems to be a random issue.  I've had BMC issues with
> > my server most of the day...  But even with this patch I still get the failure
> > in read_pages().  :-/
> > 
> > And I have gotten it to both succeed and fail with qemu...  :-/
> 
> ... here is the fix.  I made the change in xfs_diflags_to_linux() early on with
> out factoring in the flag logic changes we have agreed upon...
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 62d9f622bad1..d592949ad396 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1123,11 +1123,11 @@ xfs_diflags_to_linux(
>                 inode->i_flags |= S_NOATIME;
>         else
>                 inode->i_flags &= ~S_NOATIME;
> -       if (xflags & FS_XFLAG_DAX)
> +
> +       if (xfs_inode_enable_dax(ip))
>                 inode->i_flags |= S_DAX;
>         else
>                 inode->i_flags &= ~S_DAX;
> -
>  }
> 
> But the one thing which tripped me up, and concerns me, is we have 2 functions
> which set the inode flags.
> 
> xfs_diflags_to_iflags()
> xfs_diflags_to_linux()
> 
> xfs_diflags_to_iflags() is geared toward initialization but logically they do
> the same thing.  I see no reason to keep them separate.  Does anyone?
> 
> Based on this find, the discussion on behavior in this thread, and the comments
> from Dave I'm reworking the series because the flag check/set functions have
> all changed and I really want to be as clear as possible with both the patches
> and the resulting code.[*]  So v4 should be out today including attempting to
> document what we have discussed here and being as clear as possible on the
> behavior.  :-D
> 
> Thanks so much for testing this!
> 
> Ira
> 
> [*] I will probably throw in a patch to remove xfs_diflags_to_iflags() as I
> really don't see a reason to keep it.
> 

I prefer you keep the one in xfs_iops.c since ioctls are a higher level
function than general inode operations.

--D
