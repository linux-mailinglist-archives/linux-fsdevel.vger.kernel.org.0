Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5B325FCAE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 17:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgIGPKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 11:10:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38034 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbgIGPDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:03:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 087F0h2i029616;
        Mon, 7 Sep 2020 15:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=dSlqqtgC66uF5bIMzNT6zvaga1HiU1qWA6WLZ4nGzHE=;
 b=ZfqJWxdcUEXuIYeEMQzU7VB0xi0ba2a4U3WfrEm41N+oPLNsdnYCuPHajVfG+WPGuOf2
 TJLy6e7Dk8SIypr5OZbN8PfoG9DcENqn103e2qcPa/ORxdDyvSTWHfu+hKKD95xGLIk8
 N+mdHGxaBryxy8d6lBqFNC9HcwUrApO8Fa0nWhemDlhIupLw8qHSQX87LDsnooEy4WNJ
 3BbEJuUYNE6mfD+c9xjKRTHxf2iw0Pmw7k5AhEP5jTEMFdcc5Qkf0aPv9sJ2YD4CshAr
 LgZLf5C7V7GSTxZ82agupcAEOCHiphfxBgaHgPF6x+ZUYU6F5P4r6q9oMj78/B5duZLD nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33c2mkq2u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Sep 2020 15:03:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 087ExTfr123300;
        Mon, 7 Sep 2020 15:01:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33dacgrm3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Sep 2020 15:01:05 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 087F14oc006505;
        Mon, 7 Sep 2020 15:01:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Sep 2020 08:01:04 -0700
Date:   Mon, 7 Sep 2020 08:01:04 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] quota: widen timestamps for the fs_disk_quota
 structure
Message-ID: <20200907150104.GF7955@magnolia>
References: <20200905164703.GC7955@magnolia>
 <20200907100218.GA18556@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907100218.GA18556@quack2.suse.cz>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9737 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070149
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:02:18PM +0200, Jan Kara wrote:
> On Sat 05-09-20 09:47:03, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Soon, XFS will support quota grace period expiration timestamps beyond
> > the year 2038, widen the timestamp fields to handle the extra time bits.
> > Internally, XFS now stores unsigned 34-bit quantities, so the extra 8
> > bits here should work fine.  (Note that XFS is the only user of this
> > structure.)
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Looks good to me. Just one question below:
> 
> > diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> > index 5444d3c4d93f..eefac57c52fd 100644
> > --- a/fs/quota/quota.c
> > +++ b/fs/quota/quota.c
> > @@ -481,6 +481,14 @@ static inline u64 quota_btobb(u64 bytes)
> >  	return (bytes + (1 << XFS_BB_SHIFT) - 1) >> XFS_BB_SHIFT;
> >  }
> >  
> > +static inline s64 copy_from_xfs_dqblk_ts(const struct fs_disk_quota *d,
> > +		__s32 timer, __s8 timer_hi)
> > +{
> > +	if (d->d_fieldmask & FS_DQ_BIGTIME)
> > +		return (u32)timer | (s64)timer_hi << 32;
> > +	return timer;
> > +}
> > +
> 
> So this doesn't do any checks that the resulting time fits into 34-bits you
> speak about in the changelog. So how will XFS react if malicious / buggy
> userspace will pass too big timestamp? I suppose xfs_fs_set_dqblk() should
> return EFBIG or EINVAL or something like that which I'm not sure it does...
> 
> For record I've checked VFS quota implementation and it doesn't need any
> checks because VFS in memory structures and on-disk format use 64-bit
> timestamps. The ancient quota format uses 32-bit timestamps for 32-bit
> archs so these would get silently truncated when stored on disk but
> honestly I don't think I care (that format was deprecated some 20 years
> ago).

XFS will clamp any out-of-bounds value to the nearest representable
number.  For example, if you tried to extend a quota's grace expiration
to the year 2600, it set the expiration to 2486, similar to what the vfs
does for timestamps now.  If you try to set the default grace period to,
say, 100 years, it will clamp that to 68 years (2^31-1).

(I doubt anyone cares to set a 60+ year grace period, but as some
apparently immortal person claims to be playing a 600-year musical
score[1] perhaps we will need to revisit that...)

--D

[1] https://en.wikipedia.org/wiki/As_Slow_as_Possible

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
