Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFDC25DDB6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgIDP3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 11:29:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44860 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgIDP33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:29:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084FJ3ud092788;
        Fri, 4 Sep 2020 15:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Tk4tbbqyVRkvGSO4mL/Hi2jZowdwVdLkhoirCpA1QPA=;
 b=Ti6tR0Jzzk2C0WfJSDeaGi0LdwoW+quZ+hv12c7WLqDKOb5tN/xWLAWi8VXMEyXdXs/3
 fFmTa8eQwy0bo/6D1cPTB0HH/UbmEg/HiCcXDq8ABR/WzoF+ppiolYikKVK54VPP/3/D
 qjXV4BJumhzmm52K0d+l2kXeDbJql3o54A5txCSvKO8FgtOxgKAWNR9bmL9GnCFnHrHn
 ok9vgmIhaoDnqWVItt5xS2EkZxeO7THDBZpHctEozFi5N2uOP5hJwkJ/MB+vHQvH4BoB
 PxZ4z9+EIR5M7yaP1iYLmWonZ2XvlJ2dljR7iyvPcdfsHW99iWFYnMk9JDKjUXCnXLAX Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eerf5vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 15:29:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084FLMTc041016;
        Fri, 4 Sep 2020 15:29:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3380ktmxjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 15:29:23 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084FTMI6002962;
        Fri, 4 Sep 2020 15:29:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 08:29:22 -0700
Date:   Fri, 4 Sep 2020 08:29:22 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] quota: widen timestamps for the fs_disk_quota structure
Message-ID: <20200904152922.GC6096@magnolia>
References: <20200904053931.GB6096@magnolia>
 <20200904083123.GE2867@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904083123.GE2867@quack2.suse.cz>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 10:31:23AM +0200, Jan Kara wrote:
> On Thu 03-09-20 22:39:31, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Widen the timestamp fields in struct fs_disk_quota to handle quota grace
> > expiration times beyond 2038.  Since the only filesystem that's going to
> > use this (XFS) only supports unsigned 34-bit quantities, adding an extra
> > 5 bits here should work fine.  We can rev the structure again in 350
> > years.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Some comments below...
> 
> > @@ -588,10 +600,27 @@ static int quota_setxquota(struct super_block *sb, int type, qid_t id,
> >  	return sb->s_qcop->set_dqblk(sb, qid, &qdq);
> >  }
> >  
> > +static inline __s8 copy_to_xfs_dqblk_ts(const struct fs_disk_quota *d,
> > +		__s32 *timer_lo, s64 timer)
> > +{
> > +	*timer_lo = timer;
> > +	if (d->d_fieldmask & FS_DQ_BIGTIME)
> > +		return timer >> 32;
> > +	return 0;
> > +}
> 
> Hum, this function API looks a bit strange to me - directly store timer_lo
> and just return timer_hi... Why not having timer_hi as another function
> argument?

You can't pass pointers to a bitset. :)

> > @@ -606,6 +635,10 @@ static void copy_to_xfs_dqblk(struct fs_disk_quota *dst, struct qc_dqblk *src,
> >  	dst->d_ino_softlimit = src->d_ino_softlimit;
> >  	dst->d_bcount = quota_btobb(src->d_space);
> >  	dst->d_icount = src->d_ino_count;
> > +	dst->d_itimer_hi = copy_to_xfs_dqblk_ts(dst, &dst->d_itimer,
> > +						src->d_ino_timer);
> > +	dst->d_btimer_hi = copy_to_xfs_dqblk_ts(dst, &dst->d_btimer,
> > +						src->d_spc_timer);
> >  	dst->d_itimer = src->d_ino_timer;
> >  	dst->d_btimer = src->d_spc_timer;
> 
> Also it seems pointless (if not outright buggy due to sign-extension rules)
> to store to say d_itimer when copy_to_xfs_dqblk_ts() already did it...

Oops.  That was a straight up bug. :(

> >  	dst->d_iwarns = src->d_ino_warns;
> > @@ -613,7 +646,8 @@ static void copy_to_xfs_dqblk(struct fs_disk_quota *dst, struct qc_dqblk *src,
> >  	dst->d_rtb_hardlimit = quota_btobb(src->d_rt_spc_hardlimit);
> >  	dst->d_rtb_softlimit = quota_btobb(src->d_rt_spc_softlimit);
> >  	dst->d_rtbcount = quota_btobb(src->d_rt_space);
> > -	dst->d_rtbtimer = src->d_rt_spc_timer;
> > +	dst->d_rtbtimer_hi = copy_to_xfs_dqblk_ts(dst, &dst->d_rtbtimer,
> > +						  src->d_rt_spc_timer);
> >  	dst->d_rtbwarns = src->d_rt_spc_warns;
> >  }
> >  
> > diff --git a/include/uapi/linux/dqblk_xfs.h b/include/uapi/linux/dqblk_xfs.h
> > index 03d890b80ebc..a684f64d9cc0 100644
> > --- a/include/uapi/linux/dqblk_xfs.h
> > +++ b/include/uapi/linux/dqblk_xfs.h
> > @@ -71,8 +71,11 @@ typedef struct fs_disk_quota {
> >  	__u64		d_rtb_softlimit;/* preferred limit on RT disk blks */
> >  	__u64		d_rtbcount;	/* # realtime blocks owned */
> >  	__s32		d_rtbtimer;	/* similar to above; for RT disk blks */
> > -	__u16	  	d_rtbwarns;     /* # warnings issued wrt RT disk blks */
> > -	__s16		d_padding3;	/* padding3 - for future use */	
> > +	__u16		d_rtbwarns;     /* # warnings issued wrt RT disk blks */
> > +	__s8		d_itimer_hi:5;	/* upper 5 bits of timers */
> > +	__s8		d_btimer_hi:5;
> > +	__s8		d_rtbtimer_hi:5;
> > +	__u8		d_padding3:1;	/* padding3 - for future use */
> >  	char		d_padding4[8];	/* yet more padding */
> >  } fs_disk_quota_t;
> 
> I'm a bit nervous about passing bitfields through kernel-userspace
> interface. It *should* work OK but I'm not sure rules for bitfield packing
> between different compilers are always compatible. E.g. in this case will
> the compiler emit three 1-byte fields (as __s8 kind of suggests), just
> masking 5-bits out of each or will it use 16-bit wide memory location with
> all four fields packed together? And if this is even defined? I didn't find
> anything definitive. Also I've found some notes that the order of bit
> fields in a word is implementation defined...
> 
> So to save us some headaches, I'd prefer to use just three times __s8 for
> the _hi fields and then check whether userspace didn't pass too big values
> (more than 5 significant bits) when copying from userspace.

Ok.  I was trying to leave the u32 and u64 paddings, but I'll pick
something to burn down.  __s8[3] it is. :)

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
