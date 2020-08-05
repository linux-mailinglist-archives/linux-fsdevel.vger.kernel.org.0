Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E053523D24C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 22:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgHEUL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 16:11:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54964 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgHEQ1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:27:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075GM4C9038919;
        Wed, 5 Aug 2020 16:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5XP8uLSK11AJnsAEQAxe44/0zKxbW/hwfIcqfufnmeE=;
 b=LJmwUcb4xXwAz+eZQ4bWBDX8nC3NpFcZDGJz9UsACTT1Buvih6AKdRste9P6dvdnpuz6
 gAXkAW+1S4jQxY+6OhBDH1RRPEhyttOeaAPeUlTQ2L81MD+5vgMhTwfdn3zaSVpPsONa
 8o48vxS1YNJo0ADSpu6hRU99WRTEeIF7hma0EOwE4o98DpxD0OuM4Gv8Ur3b6+TURRYI
 kGJKI1GW+M7Qnfj4k6HlkJlssx0YR7KmSkpePBVuOY6FkVpoxtU/Kafde+voK3yy/t6x
 7q4MMybU4E2EqJmXrvLK+Zo6BoZmq3u+ZgYx0/TsoF1lx3YNQlxL54esBlPSEYAsFni1 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32n11nb27j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 16:25:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075GHjwM074767;
        Wed, 5 Aug 2020 16:23:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32qyaa39tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 16:23:56 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 075GNq50031730;
        Wed, 5 Aug 2020 16:23:52 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 09:23:51 -0700
Date:   Wed, 5 Aug 2020 09:23:49 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] iomap: new code for 5.9-rc1
Message-ID: <20200805162349.GB6107@magnolia>
References: <20200805153214.GA6090@magnolia>
 <CAHc6FU6yMnuKdVsAXkWgwr2ViMSXJdBXksrQDvHwaaw4p8u0rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU6yMnuKdVsAXkWgwr2ViMSXJdBXksrQDvHwaaw4p8u0rQ@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=1
 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 05, 2020 at 05:54:31PM +0200, Andreas Gruenbacher wrote:
> Hi Darrick,
> 
> On Wed, Aug 5, 2020 at 5:40 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > ----------------------------------------------------------------
> > Andreas Gruenbacher (1):
> >       iomap: Make sure iomap_end is called after iomap_begin
> 
> that commit (d1b4f507d71de) contains the following garbage in the
> commit message:
> 
>     The message from this sender included one or more files
>     which could not be scanned for virus detection; do not
>     open these files unless you are certain of the sender's intent.
> 
>     ----------------------------------------------------------------------
> 
> How did it come to that?

I have no idea.  It's not in the email that I turned into a patch, but
golly roundtripping git patches through email and back to git sucks.

Oh well, I guess I have to rebase the whole branch now.

Linus: please ignore this pull request.

--D

> 
> Thanks,
> Andreas
> 
