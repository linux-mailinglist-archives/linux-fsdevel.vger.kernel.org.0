Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6203555BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 19:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfFYRSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 13:18:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51904 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfFYRSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:18:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PHDjnK112356;
        Tue, 25 Jun 2019 17:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=8YOHqT1H5m87NYapYKi5uOloFdOjAQsayzwyn6FBGsU=;
 b=kRLzMzcD4dDTxKKrIatPNQ8UbCC6dJVjee0v4WI+ASaqAGwEtXxAYgVRxpW7bi2F0kdN
 +8BkhOTIe/oZhPnAYc1tUS8V4kAmfxQ6VRRo827Ml89rmcehwrL0IvipIkWsyxIORYzM
 dFZwu3TFJ2jAetMYP79ISwOmGkO6y3D31aAPNJXhXBih2Gr5GYQy3VEltfIlToeYcYTA
 OPEtp5J5s9kqXfLt+XUPAuzKiT8ERVsbjZlleEopgqvRqrrBmDlDLaWMStCqCoAydaCU
 P+tj3IggCOnLZs/3nlNDQyjq5pVdz1NFvQtV5k0sEbhsON1T5kYdVRGZQlOdlAbybMLW JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brt5t2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 17:16:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PHFVC3141059;
        Tue, 25 Jun 2019 17:16:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2t9acc7vvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jun 2019 17:16:23 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5PHGMB9143216;
        Tue, 25 Jun 2019 17:16:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9acc7vvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 17:16:22 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5PHGJxo007776;
        Tue, 25 Jun 2019 17:16:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 10:16:19 -0700
Date:   Tue, 25 Jun 2019 10:16:16 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        shaggy@kernel.org, ard.biesheuvel@linaro.org, josef@toxicpanda.com,
        clm@fb.com, adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] vfs: create a generic checking function for
 FS_IOC_FSSETXATTR
Message-ID: <20190625171616.GB2230847@magnolia>
References: <156116136742.1664814.17093419199766834123.stgit@magnolia>
 <156116138952.1664814.16552129914959122837.stgit@magnolia>
 <20190625105725.GB26085@infradead.org>
 <20190625170248.GS8917@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625170248.GS8917@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250130
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:02:48PM +0200, David Sterba wrote:
> On Tue, Jun 25, 2019 at 03:57:25AM -0700, Christoph Hellwig wrote:
> > On Fri, Jun 21, 2019 at 04:56:29PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > 
> > > Create a generic checking function for the incoming FS_IOC_FSSETXATTR
> > > fsxattr values so that we can standardize some of the implementation
> > > behaviors.
> > > 
> > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/btrfs/ioctl.c   |   21 +++++++++-------
> > >  fs/ext4/ioctl.c    |   27 ++++++++++++++------
> > >  fs/f2fs/file.c     |   26 ++++++++++++++-----
> > >  fs/inode.c         |   17 +++++++++++++
> > >  fs/xfs/xfs_ioctl.c |   70 ++++++++++++++++++++++++++++++----------------------
> > >  include/linux/fs.h |    3 ++
> > >  6 files changed, 111 insertions(+), 53 deletions(-)
> > > 
> > > 
> > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > index f408aa93b0cf..7ddda5b4b6a6 100644
> > > --- a/fs/btrfs/ioctl.c
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -366,6 +366,13 @@ static int check_xflags(unsigned int flags)
> > >  	return 0;
> > >  }
> > >  
> > > +static void __btrfs_ioctl_fsgetxattr(struct btrfs_inode *binode,
> > > +				     struct fsxattr *fa)
> > > +{
> > > +	memset(fa, 0, sizeof(*fa));
> > > +	fa->fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags);
> > 
> > Is there really much of a point in this helper? Epeciall as
> > the zeroing could easily be done in the variable declaration
> > line using
> > 
> > 	struct fsxattr fa = { };
> 
> Agreed, not counting the initialization the wrapper is merely another
> name for btrfs_inode_flags_to_xflags. I also find it slightly confusing
> that __btrfs_ioctl_fsgetxattr name is too close to the ioctl callback
> implementation btrfs_ioctl_fsgetxattr but only does some initialization.

Ok; it's easily enough changed to:

	struct fsxattr old_fa = {
		.fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags),
	};

--D
