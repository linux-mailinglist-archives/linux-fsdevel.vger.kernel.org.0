Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA43132CD6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgAGRS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:18:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgAGRS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:18:57 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007Gxtts134905;
        Tue, 7 Jan 2020 17:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=J/aWbXI7+1tu6v/9ZJMe438bJAM6SkA9FvxHoZrTmmE=;
 b=RqbcW2IG/3cDLDKj3tJ4pf/1RsghsEkoVTa22ZKD73NeWdZHjuWLeCBl7vUj+yydBGlx
 QAK/KCXiz8P787x0vG2NFfpvHKVpVy5dH+jXsCs5h8pv7daR+0m3VSbMF1x5SYnLhYF6
 WUbrH+v75OJ18SC03Pbtiv4W8qxKbJ5kqbQJHip15W7u4ljPZOGoop+BxljzEON30Y9r
 vNFumHvitiwAxKhV1vvCv+KkqHOz+yc38ix1dmJ33CxX+7ZEcg5T8sILItqQehApGkoh
 e0deV/qeODRNJpE05TZ8oI+jlfOZqfW/P7ikX3qkq/DVTVZQw0a61Vnxcm+czxRtzkbI KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xaj4ty3td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 17:18:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007GxxRo166828;
        Tue, 7 Jan 2020 17:18:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xcjvdknxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 17:18:49 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 007HImBA031593;
        Tue, 7 Jan 2020 17:18:48 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 09:18:47 -0800
Date:   Tue, 7 Jan 2020 09:18:46 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Sitsofe Wheeler <sitsofe@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, drh@sqlite.org
Subject: Re: Questions about filesystems from SQLite author presentation
Message-ID: <20200107171846.GB472641@magnolia>
References: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
 <20200106101518.GI23195@dread.disaster.area>
 <CALjAwxgzsZTBBCQYqCBoMeYtMs3jHSqGMBPQ32KrmaQr50dPAg@mail.gmail.com>
 <20200107085506.GB26849@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107085506.GB26849@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070137
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 09:55:06AM +0100, Jan Kara wrote:
> On Tue 07-01-20 08:40:00, Sitsofe Wheeler wrote:
> > On Mon, 6 Jan 2020 at 10:16, Dave Chinner <david@fromorbit.com> wrote:
> > > > today) and even if you wanted to use something like TRIM it wouldn't
> > > > be worth it unless you were trimming a large (gigabytes) amount of
> > > > data (https://youtu.be/-oP2BOsMpdo?t=6330 ).
> > >
> > > Punch the space out, then run a periodic background fstrim so the
> > > filesystem can issue efficient TRIM commands over free space...
> > 
> > Jan mentions this over on https://youtu.be/-oP2BOsMpdo?t=6268 .
> > Basically he advises against hole punching if you're going to write to
> > that area again because it fragments the file, hurts future
> > performance etc. But I guess if you were using FALLOC_FL_ZERO_RANGE no
> > hole is punched (so no fragmentation) and you likely get faster reads
> > of that area until the data is rewritten too.
> 
> Yes, no fragmentation in this case (well, there's still the fact that
> the extent tree needs to record that a particular range is marked as
> unwritten so that will get fragmented but it is merged again as soon as the
> range is written).
> 
> > Are areas that have had
> > FALLOC_FL_ZERO_RANGE run on them eligible for trimming if someone goes
> > on to do a background trim (Jan - doesn't this sound like the best of
> > both both worlds)?
> 
> No, these areas are still allocated for the file and thus background trim
> will not touch them. Concievably, we could use trim for such areas but
> technically this is going to be too expensive to discover them (you'd need
> to read all the inodes and their extent trees to discover them) at least
> for ext4 and I belive for xfs as well.
> 
> > My question is what happens if you call FALLOC_FL_ZERO_RANGE and your
> > filesystem is too dumb to mark extents unwritten - will it literally
> > go away and write a bunch of zeros over that region and your disk is a
> > slow HDD or will that call just fail? It's almost like you need
> > something that can tell you if FALLOC_FL_ZERO_RANGE is efficient...
> 
> It is upto the filesystem how it implements the operation but so far we
> managed to maintain a situation that FALLOC_FL_ZERO_RANGE returns error if
> it is not efficient.

The manpage says "...the specified range will not be physically zeroed
out on the device (except for partial blocks at the either end of the
range), and I/O is (otherwise) required only to update metadata."

I think that should be sufficient to hold the fs authors to
"FALLOC_FL_ZERO_RANGE must be efficient".

Though I've also wondered if that means fs is free to call
blkdev_issue_zeroout with NOFALLBACK in lieu of using unwritten extents?

--D

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
