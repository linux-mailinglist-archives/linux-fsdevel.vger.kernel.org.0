Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65A1EE6F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgFDOvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 10:51:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55026 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbgFDOvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:51:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054EmRN1006694;
        Thu, 4 Jun 2020 14:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=yZ/+ZJnzGnmR7xhhJsmwnbo92NBRhvNckmqD86Sq/yw=;
 b=Y3gp9V2VSFZ5CQzf0bwJEoNtW2VsYWuDv10PHG4vOY9tJtXkCuZY0UNWqXph/Ymwlm+m
 VTK+37yFHeqNgd7lXN81KtlfGdj5Fnj5JT9SSD4VAx+quVwNrrplZAvnX1QTPNpyCYhc
 uEKm48/mrUCaq3oeFnxYZVz8JehshmL+Lta/nYK2AYVt9TqaH5t0m66cWXFdkTy0YX2k
 4mJAkH0Xhqgdv4qBoIMWyIV9hxaj6y7J7x5cl/KL3P48WOnCRnXPLH0LHukU2X5+Ohqg
 vFXpSG/9HMgYO9PjeGzLCcJ00CrnGJSXf/UamHDxXpzqFNUg1f7TpgpHwdV9jQrbqNOq Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31evvn1ygm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 14:51:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054Em3vE111522;
        Thu, 4 Jun 2020 14:51:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25vffjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 14:51:15 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 054Ep9Dr003969;
        Thu, 4 Jun 2020 14:51:09 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 07:51:09 -0700
Date:   Thu, 4 Jun 2020 07:51:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20200604145107.GA1334206@magnolia>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <153e13e6-8685-fb0d-6bd3-bb553c06bf51@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153e13e6-8685-fb0d-6bd3-bb553c06bf51@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=1 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 suspectscore=1
 phishscore=0 clxscore=1011 malwarescore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040102
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 04, 2020 at 03:37:42PM +0800, Ruan Shiyang wrote:
> 
> 
> On 2020/4/28 下午2:43, Dave Chinner wrote:
> > On Tue, Apr 28, 2020 at 06:09:47AM +0000, Ruan, Shiyang wrote:
> > > 
> > > 在 2020/4/27 20:28:36, "Matthew Wilcox" <willy@infradead.org> 写道:
> > > 
> > > > On Mon, Apr 27, 2020 at 04:47:42PM +0800, Shiyang Ruan wrote:
> > > > >   This patchset is a try to resolve the shared 'page cache' problem for
> > > > >   fsdax.
> > > > > 
> > > > >   In order to track multiple mappings and indexes on one page, I
> > > > >   introduced a dax-rmap rb-tree to manage the relationship.  A dax entry
> > > > >   will be associated more than once if is shared.  At the second time we
> > > > >   associate this entry, we create this rb-tree and store its root in
> > > > >   page->private(not used in fsdax).  Insert (->mapping, ->index) when
> > > > >   dax_associate_entry() and delete it when dax_disassociate_entry().
> > > > 
> > > > Do we really want to track all of this on a per-page basis?  I would
> > > > have thought a per-extent basis was more useful.  Essentially, create
> > > > a new address_space for each shared extent.  Per page just seems like
> > > > a huge overhead.
> > > > 
> > > Per-extent tracking is a nice idea for me.  I haven't thought of it
> > > yet...
> > > 
> > > But the extent info is maintained by filesystem.  I think we need a way
> > > to obtain this info from FS when associating a page.  May be a bit
> > > complicated.  Let me think about it...
> > 
> > That's why I want the -user of this association- to do a filesystem
> > callout instead of keeping it's own naive tracking infrastructure.
> > The filesystem can do an efficient, on-demand reverse mapping lookup
> > from it's own extent tracking infrastructure, and there's zero
> > runtime overhead when there are no errors present.
> 
> Hi Dave,
> 
> I ran into some difficulties when trying to implement the per-extent rmap
> tracking.  So, I re-read your comments and found that I was misunderstanding
> what you described here.
> 
> I think what you mean is: we don't need the in-memory dax-rmap tracking now.
> Just ask the FS for the owner's information that associate with one page
> when memory-failure.  So, the per-page (even per-extent) dax-rmap is
> needless in this case.  Is this right?

Right.  XFS already has its own rmap tree.

> Based on this, we only need to store the extent information of a fsdax page
> in its ->mapping (by searching from FS).  Then obtain the owners of this
> page (also by searching from FS) when memory-failure or other rmap case
> occurs.

I don't even think you need that much.  All you need is the "physical"
offset of that page within the pmem device (e.g. 'this is the 307th 4k
page == offset 1257472 since the start of /dev/pmem0') and xfs can look
up the owner of that range of physical storage and deal with it as
needed.

> So, a fsdax page is no longer associated with a specific file, but with a
> FS(or the pmem device).  I think it's easier to understand and implement.

Yes.  I also suspect this will be necessary to support reflink...

--D

> 
> --
> Thanks,
> Ruan Shiyang.
> > 
> > At the moment, this "dax association" is used to "report" a storage
> > media error directly to userspace. I say "report" because what it
> > does is kill userspace processes dead. The storage media error
> > actually needs to be reported to the owner of the storage media,
> > which in the case of FS-DAX is the filesytem.
> > 
> > That way the filesystem can then look up all the owners of that bad
> > media range (i.e. the filesystem block it corresponds to) and take
> > appropriate action. e.g.
> > 
> > - if it falls in filesytem metadata, shutdown the filesystem
> > - if it falls in user data, call the "kill userspace dead" routines
> >    for each mapping/index tuple the filesystem finds for the given
> >    LBA address that the media error occurred.
> > 
> > Right now if the media error is in filesystem metadata, the
> > filesystem isn't even told about it. The filesystem can't even shut
> > down - the error is just dropped on the floor and it won't be until
> > the filesystem next tries to reference that metadata that we notice
> > there is an issue.
> > 
> > Cheers,
> > 
> > Dave.
> > 
> 
> 
