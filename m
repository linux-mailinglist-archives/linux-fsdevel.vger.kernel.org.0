Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023D725EF40
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Sep 2020 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgIFRMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 13:12:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41792 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIFRMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 13:12:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 086H4Lkl109607;
        Sun, 6 Sep 2020 17:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Lx7/I1jqph1rKTWu9/vOsiiFtqyYPTpUVfvYUZowWew=;
 b=emkmwcbtLUaSmIcqLZscltx1g1X0SI31NdLIz5pvoERj5kv9k/mnZcagJrcI2JnSlJbg
 n8SDhLBLskikK7v9klcCdzjC+Kljpo6oiwVC7TOmsT89Ilrv6V3eRaUAdcF8bFxVCpPy
 uZGAOWU14flBKkcdrOXdp8J8pZ7G4oFKTBIcf6BQ+W+txIckIoK8g29fpqJ0BAJ4wgac
 9LvWsy/ZvodTkkbiDGTpiroLK5QsgwgYuljgmlqpukE7Kl2yNasefqEPdIj6HVD12oKh
 g7BoEUOGaajt0PM233WzqJm1vaUz2GLxFhvhRmzTt8tivWz1gp2M7GVzacgksFKltaf6 xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mkkf83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 06 Sep 2020 17:12:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 086H52Hr020827;
        Sun, 6 Sep 2020 17:10:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33cmjxaq0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Sep 2020 17:10:06 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 086H9wE9020496;
        Sun, 6 Sep 2020 17:09:59 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 06 Sep 2020 10:09:58 -0700
Date:   Sun, 6 Sep 2020 10:09:57 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] quota: widen timestamps for the fs_disk_quota
 structure
Message-ID: <20200906170957.GE7955@magnolia>
References: <20200905164703.GC7955@magnolia>
 <20200905220231.GB16750@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905220231.GB16750@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009060174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=1 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009060174
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 05, 2020 at 11:02:31PM +0100, Matthew Wilcox wrote:
> On Sat, Sep 05, 2020 at 09:47:03AM -0700, Darrick J. Wong wrote:
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
> Is that actually the right thing to do?  If FS_DQ_BIGTIME is not set,
> I would expect us to avoid writing to timer_hi at all.  Alternatively, if
> we do want to write to timer_hi, why not write to it unconditionally?

If the flag isn't set, then the space used by timer_hi is a zero-filled
padding field.  Therefore, I made this function zero timer_hi if the
bigtime flag isn't set.  It's redundant with the memset five lines up
from the call site, but I don't like leaving logic bombs in case this
function ever gets exported elsewhere.

--D
