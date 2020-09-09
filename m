Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E722634A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 19:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgIIR3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 13:29:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34344 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbgIIR3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:29:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089HJxrM181571;
        Wed, 9 Sep 2020 17:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LxNdXQlDnnKhDrCUtkHBqBqttPCCpCQObD3x3ZPxDp8=;
 b=0Rkhi2WVsMAl7UhEIJejHAKD/waCV+knsQvMGfr5LPP5SkTaUH290+1lz0hWyqmvDD0E
 hQiImcpz8l/mUWX2wGE5vefOvhkWu1xF1Mp1AH5xiKM+s7EFPCRoMwkzaSkURd4zfmoJ
 DusCvAOlmrt3c8XmMNkFKMIvWGHYn6jlA0/FrZv38eVjglAe9FO5vjDNe/85mWOPwSJ9
 jRNMCGmhuAD9dj45JHCvFqtgjZ/snyrEBxTgQcoji04Kw9XY5dKgbCjCQKmh19W6LmRG
 4vA4ZDCzXfazyrXgktGp7gyZdVxpWJ6eGKEL2HsOBNoI6kVoR/niUr72yi6xiD5Q+MpP Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33c3an34ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 17:29:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089HP6s3016316;
        Wed, 9 Sep 2020 17:27:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33cmk73e73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 17:27:04 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 089HR3Tx011540;
        Wed, 9 Sep 2020 17:27:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Sep 2020 10:27:03 -0700
Date:   Wed, 9 Sep 2020 10:27:01 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, hch@lst.de
Subject: Re: [PATCH v3] quota: widen timestamps for the fs_disk_quota
 structure
Message-ID: <20200909172701.GK7955@magnolia>
References: <20200909013251.GG7955@magnolia>
 <20200909014933.GC6583@casper.infradead.org>
 <20200909022909.GI7955@magnolia>
 <20200909105133.GC24207@quack2.suse.cz>
 <20200909124252.GE6583@casper.infradead.org>
 <20200909135645.GB29150@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909135645.GB29150@quack2.suse.cz>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=1 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090155
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 09, 2020 at 03:56:45PM +0200, Jan Kara wrote:
> On Wed 09-09-20 13:42:52, Matthew Wilcox wrote:
> > On Wed, Sep 09, 2020 at 12:51:33PM +0200, Jan Kara wrote:
> > > On Tue 08-09-20 19:29:09, Darrick J. Wong wrote:
> > > > On Wed, Sep 09, 2020 at 02:49:33AM +0100, Matthew Wilcox wrote:
> > > > > On Tue, Sep 08, 2020 at 06:32:51PM -0700, Darrick J. Wong wrote:
> > > > > > +static inline void copy_to_xfs_dqblk_ts(const struct fs_disk_quota *d,
> > > > > > +		__s32 *timer_lo, __s8 *timer_hi, s64 timer)
> > > > > > +{
> > > > > > +	*timer_lo = timer;
> > > > > > +	if (d->d_fieldmask & FS_DQ_BIGTIME)
> > > > > > +		*timer_hi = timer >> 32;
> > > > > > +	else
> > > > > > +		*timer_hi = 0;
> > > > > > +}
> > > > > 
> > > > > I'm still confused by this.  What breaks if you just do:
> > > > > 
> > > > > 	*timer_lo = timer;
> > > > > 	*timer_hi = timer >> 32;
> > > > 
> > > > "I don't know."
> > > > 
> > > > The manpage for quotactl doesn't actually specify the behavior of the
> > > > padding fields.  The /implementation/ is careful enough to zero
> > > > everything, but the interface specification doesn't explicitly require
> > > > software to do so.
> > > > 
> > > > Because the contents of the padding fields aren't defined by the
> > > > documentation, the kernel cannot simply start using the d_padding2 field
> > > > because there could be an old kernel that doesn't zero the padding,
> > > > which would lead to confusion if the new userspace were mated to such a
> > > > kernel.
> > > > 
> > > > Therefore, we have to add a flag that states explicitly that we are
> > > > using the timer_hi fields.  This is also the only way that an old
> > > > program can detect that it's being fed a structure that it might not
> > > > recognise.
> > > 
> > > Well, this is in the direction from kernel to userspace and what Matthew
> > > suggests would just make kernel posssibly store non-zero value in *timer_hi
> > > without setting FS_DQ_BIGTIME flag (for negative values of timer). I don't
> > > think it would break anything but I agree the complication isn't big so
> > > let's be careful and only set *timer_hi to non-zero if FS_DQ_BIGTIME is
> > > set.
> > 
> > OK, thanks.  I must admit, I'd completely forgotten about the negative
> > values ... and the manpage (quotactl(2)) could be clearer:
> > 
> >                       int32_t  d_itimer;    /* Zero if within inode limits */
> >                                             /* If not, we refuse service */
> >                       int32_t  d_btimer;    /* Similar to above; for
> >                                                disk blocks */
> > 
> > I can't tell if this is a relative time or seconds since 1970 since we
> > exceeded the quota.
> 
> In fact, it is time (in seconds since epoch) when softlimit becomes
> enforced (i.e. when you cannot write any more blocks/inodes if you are
> still over softlimit). I agree the comment incomplete at best. Something
> like attached patch?
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

> From 3e3260a337ff444e3a1396834b20da63d7b87ccb Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Wed, 9 Sep 2020 15:54:46 +0200
> Subject: [PATCH] quota: Expand comment describing d_itimer
> 
> Expand comment describing d_itimer in struct fs_disk_quota.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/uapi/linux/dqblk_xfs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/dqblk_xfs.h b/include/uapi/linux/dqblk_xfs.h
> index 16d73f54376d..e4b3fd7f0a50 100644
> --- a/include/uapi/linux/dqblk_xfs.h
> +++ b/include/uapi/linux/dqblk_xfs.h
> @@ -62,7 +62,8 @@ typedef struct fs_disk_quota {
>  	__u64		d_bcount;	/* # disk blocks owned by the user */
>  	__u64		d_icount;	/* # inodes owned by the user */
>  	__s32		d_itimer;	/* zero if within inode limits */
> -					/* if not, we refuse service */
> +					/* if not, we refuse service at this
> +					 * time (in seconds since epoch) */

"since Unix epoch"?

Otherwise looks fine to me...

--D

>  	__s32		d_btimer;	/* similar to above; for disk blocks */
>  	__u16	  	d_iwarns;       /* # warnings issued wrt num inodes */
>  	__u16	  	d_bwarns;       /* # warnings issued wrt disk blocks */
> -- 
> 2.16.4
> 

