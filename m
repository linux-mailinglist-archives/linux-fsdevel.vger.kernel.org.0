Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB7F1BC3DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 17:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgD1PkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 11:40:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41278 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgD1PkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:40:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFcjSa155813;
        Tue, 28 Apr 2020 15:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=dfXvM4xuNIeZaJFuK3qt5Sc+zWA9hEOGGKCO2odjOlY=;
 b=Qyi1DXhpYDb15soPsP+xFNjmBvH+QlXLmb2FA+WsRcY4d07OZOPz/2Kypv7HtI/zpmhr
 By2uzixHj+6ZgJiWW99kEjLGcLiS2hu1TISIxg6RuYesVDTd8NFg+K+TOL0CgNVptzXW
 PKTZOR/HU1xWAb0ctQ8+LX1X6pFYAn0pYlPfUTxYDMp5YdoXPh9vz1x/ZjSoVQWvy5AV
 Lg7ajSujOQkyVcBhlARH7gRr7l7qA5jB9Gs01AaPpjKrz4I3YGmpShh4Z+KbnanoTlKC
 A9eDlU05ZCQM+BJVV7iObWZJmybX/ZgYwHAT8yc/6f/2/rw6QElREC8AR5gCZkfywTD6 tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30nucg0rgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:39:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFahHn180974;
        Tue, 28 Apr 2020 15:37:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30mxpga2ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:37:38 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SFbYAT031620;
        Tue, 28 Apr 2020 15:37:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:37:34 -0700
Date:   Tue, 28 Apr 2020 08:37:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "Qi, Fuli" <qi.fuli@fujitsu.com>,
        "Gotou, Yasunori" <y-goto@fujitsu.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZQ==?= =?utf-8?Q?=3A?= [RFC PATCH 0/8]
 dax: Add a dax-rmap tree to support reflink
Message-ID: <20200428153732.GZ6742@magnolia>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <259fe633-e1ff-b279-cd8c-1a81eaa40941@cn.fujitsu.com>
 <20200428111636.GK29705@bombadil.infradead.org>
 <20200428112441.GH2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428112441.GH2040@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280122
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:24:41PM +1000, Dave Chinner wrote:
> On Tue, Apr 28, 2020 at 04:16:36AM -0700, Matthew Wilcox wrote:
> > On Tue, Apr 28, 2020 at 05:32:41PM +0800, Ruan Shiyang wrote:
> > > On 2020/4/28 下午2:43, Dave Chinner wrote:
> > > > On Tue, Apr 28, 2020 at 06:09:47AM +0000, Ruan, Shiyang wrote:
> > > > > 在 2020/4/27 20:28:36, "Matthew Wilcox" <willy@infradead.org> 写道:
> > > > > > On Mon, Apr 27, 2020 at 04:47:42PM +0800, Shiyang Ruan wrote:
> > > > > > >   This patchset is a try to resolve the shared 'page cache' problem for
> > > > > > >   fsdax.
> > > > > > > 
> > > > > > >   In order to track multiple mappings and indexes on one page, I
> > > > > > >   introduced a dax-rmap rb-tree to manage the relationship.  A dax entry
> > > > > > >   will be associated more than once if is shared.  At the second time we
> > > > > > >   associate this entry, we create this rb-tree and store its root in
> > > > > > >   page->private(not used in fsdax).  Insert (->mapping, ->index) when
> > > > > > >   dax_associate_entry() and delete it when dax_disassociate_entry().
> > > > > > 
> > > > > > Do we really want to track all of this on a per-page basis?  I would
> > > > > > have thought a per-extent basis was more useful.  Essentially, create
> > > > > > a new address_space for each shared extent.  Per page just seems like
> > > > > > a huge overhead.
> > > > > > 
> > > > > Per-extent tracking is a nice idea for me.  I haven't thought of it
> > > > > yet...
> > > > > 
> > > > > But the extent info is maintained by filesystem.  I think we need a way
> > > > > to obtain this info from FS when associating a page.  May be a bit
> > > > > complicated.  Let me think about it...
> > > > 
> > > > That's why I want the -user of this association- to do a filesystem
> > > > callout instead of keeping it's own naive tracking infrastructure.
> > > > The filesystem can do an efficient, on-demand reverse mapping lookup
> > > > from it's own extent tracking infrastructure, and there's zero
> > > > runtime overhead when there are no errors present.
> > > > 
> > > > At the moment, this "dax association" is used to "report" a storage
> > > > media error directly to userspace. I say "report" because what it
> > > > does is kill userspace processes dead. The storage media error
> > > > actually needs to be reported to the owner of the storage media,
> > > > which in the case of FS-DAX is the filesytem.
> > > 
> > > Understood.
> > > 
> > > BTW, this is the usage in memory-failure, so what about rmap?  I have not
> > > found how to use this tracking in rmap.  Do you have any ideas?
> > > 
> > > > 
> > > > That way the filesystem can then look up all the owners of that bad
> > > > media range (i.e. the filesystem block it corresponds to) and take
> > > > appropriate action. e.g.
> > > 
> > > I tried writing a function to look up all the owners' info of one block in
> > > xfs for memory-failure use.  It was dropped in this patchset because I found
> > > out that this lookup function needs 'rmapbt' to be enabled when mkfs.  But
> > > by default, rmapbt is disabled.  I am not sure if it matters...
> > 
> > I'm pretty sure you can't have shared extents on an XFS filesystem if you
> > _don't_ have the rmapbt feature enabled.  I mean, that's why it exists.
> 
> You're confusing reflink with rmap. :)
> 
> rmapbt does all the reverse mapping tracking, reflink just does the
> shared data extent tracking.
> 
> But given that anyone who wants to use DAX with reflink is going to
> have to mkfs their filesystem anyway (to turn on reflink) requiring
> that rmapbt is also turned on is not a big deal. Especially as we
> can check it at mount time in the kernel...

Are we going to turn on rmap by default?  The last I checked, it did
have a 10-20% performance cost on extreme metadata-heavy workloads.
Or do we only enable it by default if mkfs detects a pmem device?

(Admittedly, most people do not run fsx as a productivity app; the
normal hit is usually 3-5% which might not be such a big deal since you
also get (half of) online fsck. :P)

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
