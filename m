Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0BE639B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 18:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfGIQuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 12:50:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60904 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIQuK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:50:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69GnQaj070323;
        Tue, 9 Jul 2019 16:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=SA6dzMCTWrij2CwnL3CHgy3imU10Tg6y0fcMO9yW8QI=;
 b=MjgoVDIchlhL2HArHYeA7DeBhr5PflqMmSEb4iZHjBBBUtJZU3dEhACjSRDp69Ui4iZK
 uTS8ne32PSgCGiCBbGuNni0FjRJu9HwsxrZyo5FGTWEuh1ZpYKoTOYp/MvySWpfZXRZb
 w9XuQDoN0U2ASAnJxW0nfiDTIDQKjFYE9hzfrJSxE96PmF0qZpeIPaIA5AxAJSM3hl1g
 yWQnnOuBqfPghMoyiO+eCL1DNyfYA/v7UPkT/RttbsRx28lbBfvi0Ao6sYG0BdD3Ll8i
 lkOMeVEkbMLB573BsRUV06uAOnKp0Ntf+ObSIKFPZok1fM6FW+g5tjq6d7rP5cbWFWr/ Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tjk2tnk53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 16:49:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69GmA9x088051;
        Tue, 9 Jul 2019 16:49:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tjgru7c2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 16:49:55 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x69GnrDo026589;
        Tue, 9 Jul 2019 16:49:53 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jul 2019 09:49:53 -0700
Date:   Tue, 9 Jul 2019 09:49:52 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] iomap: regroup code by functional area
Message-ID: <20190709164952.GT1404256@magnolia>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
 <20190708184652.GB20670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708184652.GB20670@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907090198
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907090198
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 08, 2019 at 11:46:52AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 01, 2019 at 10:01:59AM -0700, Darrick J. Wong wrote:
> > Hi all,
> > 
> > This series breaks up fs/iomap.c by grouping the functions by major
> > functional area (swapfiles, fiemap, seek hole/data, directio, buffered
> > writes, buffered reads, page management, and page migration) in separate
> > source code files under fs/iomap/.  No functional changes have been
> > made.
> > 
> > Note that this is not the final format of the patches, because I intend
> > to pick a point towards the end of the merge window (after everyone
> > else's merges have landed), rebase this series atop that, and push it
> > back to Linus.  The RFC is posted so that everyone can provide feedback
> > on the grouping strategy, not line-specific code movements.
> > 
> > This has been lightly tested with fstests.  Enjoy!
> > Comments and questions are, as always, welcome.
> 
> Do you have a branch somewhere for the layout?

I sent it out to for-next to see what it would collide with:

https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/log/?h=iomap-5.3-merge

Though I'll probably rebase it after the mm and block merges (which
might have already happened).

> To me it seems to be a little too fine grained and creates tons of tiny
> files, which make hacking the code painful.

It's nine files and now code is grouped by functional area which makes
it easier to keep track of which functions go with the publicly exposed
iomap apis.  I don't think we're going to more than a half dozen more
files ever.

--D
