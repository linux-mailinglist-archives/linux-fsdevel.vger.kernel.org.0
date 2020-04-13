Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4C1A698A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 18:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbgDMQNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 12:13:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgDMQNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:13:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DG9KIE074193;
        Mon, 13 Apr 2020 16:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=pRlzUa2jPSF0xbUlpi8T8m4jAqIOXlsYcpu3wjGQeSE=;
 b=K+8h+hxSxg6CohR39pL50YxsgUbvKJc/wS2qj1BEr32dY0GevVJqvjxyUxSh3w/lBUAl
 CdACgHHyvu/nZaWvGTFl3OUsEy64txnWxJ+cLAGaiZYJ0NslmBXaiW+QmDB9DTlFlKfP
 3UZDqlUayGqfbq+13b9krDlykPbRcBGj6uIH+ig1MStNBbZsgG2x+GB5yqHNZfS+tIYK
 2CyxRbNdHDAGkQiHa+fCTtCoO299kKjuK8nd6DG5uB+mPrNcqpIYLuELiaJ7VP7EHUPS
 MDtyGGIgO5h934bEmWt4pgM1MjNHbaOkwZpKk2RNVpL50PMnBJZRjiPPSoAmVN7F17XY /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30b6hpfd8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:13:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DG7nRH046589;
        Mon, 13 Apr 2020 16:13:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30bqceh4kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:13:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03DGD7O1018514;
        Mon, 13 Apr 2020 16:13:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 09:13:07 -0700
Date:   Mon, 13 Apr 2020 09:13:06 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 7/9] fs: Define I_DONTCACNE in VFS layer
Message-ID: <20200413161306.GY6742@magnolia>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-8-ira.weiny@intel.com>
 <20200413160929.GW6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413160929.GW6742@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=3
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130123
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 09:09:29AM -0700, Darrick J. Wong wrote:
> > Subject: [PATCH V7 7/9] fs: Define I_DONTCACNE in VFS layer
> 
> CACNE -> CACHE.
> 
> On Sun, Apr 12, 2020 at 10:40:44PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DAX effective mode changes (setting of S_DAX) require inode eviction.
> > 
> > Define a flag which can be set to inform the VFS layer that inodes
> > should not be cached.  This will expedite the eviction of those nodes
> > requiring reload.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  include/linux/fs.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index a818ced22961..e2db71d150c3 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2151,6 +2151,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
> >   *
> >   * I_CREATING		New object's inode in the middle of setting up.
> >   *
> > + * I_DONTCACHE		Do not cache the inode
> 
> "Do not cache" is a bit vague, how about:
> 
> "Evict the inode when the last reference is dropped.
> Do not put it on the LRU list."
> 
> Also, shouldn't xfs_ioctl_setattr be setting I_DONTCACHE if someone
> changes FS_XFLAG_DAX (and there are no mount option overrides)?  I don't
> see any user of I_DONTCACHE in this series.

Oops, brain fart, ignore this question ^^^^.

--D

> (Also also, please convert XFS_IDONTCACHE, since it's a straightforward
> conversion...)
> 
> --D
> 
> > + *
> >   * Q: What is the difference between I_WILL_FREE and I_FREEING?
> >   */
> >  #define I_DIRTY_SYNC		(1 << 0)
> > @@ -2173,6 +2175,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
> >  #define I_WB_SWITCH		(1 << 13)
> >  #define I_OVL_INUSE		(1 << 14)
> >  #define I_CREATING		(1 << 15)
> > +#define I_DONTCACHE		(1 << 16)
> >  
> >  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> >  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> > @@ -3042,7 +3045,8 @@ extern int inode_needs_sync(struct inode *inode);
> >  extern int generic_delete_inode(struct inode *inode);
> >  static inline int generic_drop_inode(struct inode *inode)
> >  {
> > -	return !inode->i_nlink || inode_unhashed(inode);
> > +	return !inode->i_nlink || inode_unhashed(inode) ||
> > +		(inode->i_state & I_DONTCACHE);
> >  }
> >  
> >  extern struct inode *ilookup5_nowait(struct super_block *sb,
> > -- 
> > 2.25.1
> > 
