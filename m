Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD817041D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBZQR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:17:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZQR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:17:58 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QFvf0S033348;
        Wed, 26 Feb 2020 16:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WKDZDiIYwkHJ2rTuDV4wlnpR6BBfh5Fu3+ipePDTfXQ=;
 b=zCYArvRaXJmqXBidy/Q5qenDhKRVmcVzrktrvGTdPBebl7sI5xagcFXYUgC2ZTho07tX
 8THf6oPBRBGDEimP3iO3azzyM8eFBSqhsmbQck3Xo9cvFeTLs8rxZH5Gs7qCs2bqBwep
 kDW0tlB18T7ZAWetfkGwd8DjYJE/ODI8GfgyauamE+0ynyOly7JgozmFqhfZYTLu8Voi
 ZhCEe385XKiZTK+ckxaYG3+QLbPUNsejpIf5y/VwD+yqAsgQdcIAiygRRlOkipSVLX47
 d+GvnJFJeLM5RBiaNxuCxHgL2QL6lTNHVcaDMdu8B9C8eH8Gfs9Irt/KJGDjeL68Z09I Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ydcsrmqqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:17:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QGELGG110521;
        Wed, 26 Feb 2020 16:17:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ydcs2fs6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:17:45 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01QGHiaR030245;
        Wed, 26 Feb 2020 16:17:44 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Feb 2020 08:17:43 -0800
Date:   Wed, 26 Feb 2020 08:17:42 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, jack@suse.cz,
        tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [PATCHv3 6/6] Documentation: Correct the description of
 FIEMAP_EXTENT_LAST
Message-ID: <20200226161742.GB8036@magnolia>
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <279638c6939b1f6ef3ab32912cb51da1a967cf8e.1582702694.git.riteshh@linux.ibm.com>
 <20200226130503.GY24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226130503.GY24185@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260111
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 05:05:03AM -0800, Matthew Wilcox wrote:
> On Wed, Feb 26, 2020 at 03:27:08PM +0530, Ritesh Harjani wrote:
> > Currently FIEMAP_EXTENT_LAST is not working consistently across
> > different filesystem's fiemap implementations and thus this feature
> > may be broken. So fix the documentation about this flag to meet the
> > right expectations.
> 
> Are you saying filesystems have both false positives and false negatives?
> I can understand how a filesystem might fail to set FIEMAP_EXTENT_LAST,
> but not how a filesystem might set it when there's actually another
> extent beyond this one.
> 
> >  * FIEMAP_EXTENT_LAST
> > -This is the last extent in the file. A mapping attempt past this
> > -extent will return nothing.
> > +This is generally the last extent in the file. A mapping attempt past this
> > +extent may return nothing. But the user must still confirm by trying to map
> > +past this extent, since different filesystems implement this differently.

"This flag means nothing and can be set arbitrarily by the fs for the lulz."

Yuck.  I was really hoping for "This is set on the last extent record in
the dataset generated by the query parameters", particularly becaue
that's how e2fsprogs utilties interpret that flag.

--D
