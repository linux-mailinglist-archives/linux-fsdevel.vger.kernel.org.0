Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B6D4198D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 02:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392176AbfFLAgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 20:36:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51566 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391522AbfFLAgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 20:36:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C0U2aL172563;
        Wed, 12 Jun 2019 00:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=9gKawnpnm3eYTlbJSmpS31BgWCZu6yO6zvRDwLNExMc=;
 b=vHQc7RiwFlRopnBcV6yXscL30ZNdwN/v/B17eINRtpQHvUvgM6epdVedyPbAKdmcBBV3
 cpQKUJvANpmF9rest4EECBPlFj+c/6FFyA1MB+Y7QHfaviX1SgktsC/OuLuEeHTjfJfn
 IHVrIivC0Er8GlXskbXJ6t5OZcUHTAMhyEJ0O8MOVdKDEgKTHfWtz59o9kiNq/kqTY6E
 4hAomBRtHJLX3EPEAvdgUe3wJJHguniVZBFYytUSwIeEiPqdsoMO2S6x/RCI4kCCEC8X
 5tzrNpCpeUTAjMu2i0Q0axAMVtIdwT/+kMGJyGR6ACAIOztQv/pzRx3K8FTZ+teYFImj 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t04etrany-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 00:35:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C0YsTE041414;
        Wed, 12 Jun 2019 00:35:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2t1jphr047-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jun 2019 00:35:50 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5C0Zn8q043221;
        Wed, 12 Jun 2019 00:35:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t1jphr042-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 00:35:49 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5C0ZfCm005680;
        Wed, 12 Jun 2019 00:35:41 GMT
Received: from localhost (/10.145.179.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 17:35:41 -0700
Date:   Tue, 11 Jun 2019 17:35:38 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        shaggy@kernel.org, ard.biesheuvel@linaro.org, josef@toxicpanda.com,
        clm@fb.com, adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        linux-xfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Jfs-discussion] [PATCH 1/4] vfs: create a generic checking
 function for FS_IOC_SETFLAGS
Message-ID: <20190612003538.GW1871505@magnolia>
References: <156022833285.3227089.11990489625041926920.stgit@magnolia>
 <156022834076.3227089.14763553158562888103.stgit@magnolia>
 <fb974a33-2192-30ab-9f31-885c3796360b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb974a33-2192-30ab-9f31-885c3796360b@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:41:06AM -0500, Dave Kleikamp wrote:
> On 6/10/19 11:45 PM, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Create a generic checking function for the incoming FS_IOC_SETFLAGS flag
> > values so that we can standardize the implementations that follow ext4's
> > flag values.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
>  -- clip --
> 
> > diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
> > index ba34dae8bd9f..c8446d2cd0c7 100644
> > --- a/fs/jfs/ioctl.c
> > +++ b/fs/jfs/ioctl.c
> > @@ -98,6 +98,12 @@ long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  		/* Lock against other parallel changes of flags */
> >  		inode_lock(inode);
> >  
> > +		oldflags = jfs_map_ext2(jfs_inode->mode2 & JFS_FL_USER_VISIBLE,
> > +					0);
> > +		err = vfs_ioc_setflags_check(inode, oldflags, flags);
> > +		if (err)
> > +			goto setflags_out;
> 
> inode_unlock(inode) is not called on the error path.
> 
> > +
> >  		oldflags = jfs_inode->mode2;
> >  
> >  		/*
> 
> This patch leaves jfs's open-coded version of the same check.

Heh, thanks for pointing that out.  I'll fix both of those things.

--D

> Thanks,
> Shaggy
