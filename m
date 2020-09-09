Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2702A262534
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 04:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgIICbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 22:31:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54616 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgIICbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 22:31:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892SmHd134273;
        Wed, 9 Sep 2020 02:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9BVSnmJab7cVTmNBPJK3oqzxG6hfrV/pZ+5OttTkAn8=;
 b=AE5A94daEENG4B+m0yoJuz7pkpl/x16iXcZ24hruc2FL7lSIb1j+FxLYGlSxwL71qZcz
 zLryyAYD+1EY2+evqyH9ArQAair1mHlgeL02aieUMKBJ6Tz6vkdwRKHvS9g6aC7KggV0
 n5mCD8onCpS+mnUweo44Zr50DoRcstQSDVyZqyLBZswfmbTms/dQZyZ7inTchJinCLYZ
 iE797rLv6rOemZDd8jf+CghDPX7+d24IGBpbTSyx/BKhXB5xXKAOdM9fWv23HEFU+xmd
 wTc+EU8HbRNUCnl8hqoPmQ+nWPkB+FceEjBIczt722eBsxbluUItyAc1qPlyVQkdhnyi tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33c2mkxxa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 02:31:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892QKFv053465;
        Wed, 9 Sep 2020 02:29:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33cmkwx38a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 02:29:12 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0892TAKx013629;
        Wed, 9 Sep 2020 02:29:11 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 19:29:10 -0700
Date:   Tue, 8 Sep 2020 19:29:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, hch@lst.de
Subject: Re: [PATCH v3] quota: widen timestamps for the fs_disk_quota
 structure
Message-ID: <20200909022909.GI7955@magnolia>
References: <20200909013251.GG7955@magnolia>
 <20200909014933.GC6583@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909014933.GC6583@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=1
 spamscore=0 mlxlogscore=893 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=912
 malwarescore=0 suspectscore=1 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090022
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 09, 2020 at 02:49:33AM +0100, Matthew Wilcox wrote:
> On Tue, Sep 08, 2020 at 06:32:51PM -0700, Darrick J. Wong wrote:
> > +static inline void copy_to_xfs_dqblk_ts(const struct fs_disk_quota *d,
> > +		__s32 *timer_lo, __s8 *timer_hi, s64 timer)
> > +{
> > +	*timer_lo = timer;
> > +	if (d->d_fieldmask & FS_DQ_BIGTIME)
> > +		*timer_hi = timer >> 32;
> > +	else
> > +		*timer_hi = 0;
> > +}
> 
> I'm still confused by this.  What breaks if you just do:
> 
> 	*timer_lo = timer;
> 	*timer_hi = timer >> 32;

"I don't know."

The manpage for quotactl doesn't actually specify the behavior of the
padding fields.  The /implementation/ is careful enough to zero
everything, but the interface specification doesn't explicitly require
software to do so.

Because the contents of the padding fields aren't defined by the
documentation, the kernel cannot simply start using the d_padding2 field
because there could be an old kernel that doesn't zero the padding,
which would lead to confusion if the new userspace were mated to such a
kernel.

Therefore, we have to add a flag that states explicitly that we are
using the timer_hi fields.  This is also the only way that an old
program can detect that it's being fed a structure that it might not
recognise.

Keep in mind that if @timer is negative (i.e. before the unix epoch)
then technically timer_hi has to be all ones if FS_DQ_BIGTIME is set.
The only user doesn't support that, but that's no excuse for sloppiness.

> >  	memset(dst, 0, sizeof(*dst));
> > +	if (want_bigtime(src->d_ino_timer) || want_bigtime(src->d_spc_timer) ||
> > +	    want_bigtime(src->d_rt_spc_timer))
> > +		dst->d_fieldmask |= FS_DQ_BIGTIME;
> 
> You still need this (I guess?  In case somebody's written to the
> d_padding2 field?)

Yes.

--D

