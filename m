Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB3A1A8BB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 21:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505321AbgDNT6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 15:58:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53384 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505237AbgDNT6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:58:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EJrX81023001;
        Tue, 14 Apr 2020 19:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=QClYHgr+9BhJGdZR+Dsv1ZrmLXwWc1xNA/wZJVLWvKU=;
 b=yl/1AbADQUscbGwLHYu8U9vzcZLQ7NEWedTYV2gzcaaDjiLwUKpQztyrdeh220Mvc/xn
 Y4bvFD0l5bxqeMdrdU/wmMkxzxYjSwgFV8ueQi5ksrtDOqpRDila4ZN0CQ3VAjOfeS+V
 BXjeqJKbxztVSsFq/n1yGb5QKCndrqLi+T6x33qYrxBSMqYTAgoQjAk/zmj4kll1w1Tv
 SRgfAuwO+83FDqPv3V2mYB9OBrOeuomCzaFuilNtu5hWD4NOVtEOTsb9BQogOJWZcJJ6
 NbAKj7HaAT9YX6nvOAgJuSRQcAg5cZx3cToEwvGn1PmNdn8ekPV/tP0/O1A6zNVjEwqS QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30b6hpq0qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 19:57:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EJvlKT014315;
        Tue, 14 Apr 2020 19:57:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30bqcjnyy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 19:57:58 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03EJvu3Q026932;
        Tue, 14 Apr 2020 19:57:56 GMT
Received: from localhost (/10.159.239.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 12:57:55 -0700
Date:   Tue, 14 Apr 2020 12:57:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V7 9/9] Documentation/dax: Update Usage section
Message-ID: <20200414195754.GH6742@magnolia>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-10-ira.weiny@intel.com>
 <CAPcyv4g1gGWUuzVyOgOtkRTxzoSKOjVpAOmW-UDtmud9a3CUUA@mail.gmail.com>
 <20200414161509.GF6742@magnolia>
 <CAPcyv4hr+NKbpAU4UhKcmHfvDq1+GTM+y+K28XGbkDYBP=Kaag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hr+NKbpAU4UhKcmHfvDq1+GTM+y+K28XGbkDYBP=Kaag@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140139
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:04:57PM -0700, Dan Williams wrote:
> On Tue, Apr 14, 2020 at 9:15 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Mon, Apr 13, 2020 at 10:21:26PM -0700, Dan Williams wrote:
> > > On Sun, Apr 12, 2020 at 10:41 PM <ira.weiny@intel.com> wrote:
> > > >
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > >
> > > > Update the Usage section to reflect the new individual dax selection
> > > > functionality.
> > > >
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > >
> > > > ---
> > > > Changes from V6:
> > > >         Update to allow setting FS_XFLAG_DAX any time.
> > > >         Update with list of behaviors from Darrick
> > > >         https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
> > > >
> > > > Changes from V5:
> > > >         Update to reflect the agreed upon semantics
> > > >         https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> > > > ---
> > > >  Documentation/filesystems/dax.txt | 166 +++++++++++++++++++++++++++++-
> > > >  1 file changed, 163 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> > > > index 679729442fd2..af14c1b330a9 100644
> > > > --- a/Documentation/filesystems/dax.txt
> > > > +++ b/Documentation/filesystems/dax.txt
> > > > @@ -17,11 +17,171 @@ For file mappings, the storage device is mapped directly into userspace.
> > > >  Usage
> > > >  -----
> > > >
> > > > -If you have a block device which supports DAX, you can make a filesystem
> > > > +If you have a block device which supports DAX, you can make a file system
> > > >  on it as usual.  The DAX code currently only supports files with a block
> > > >  size equal to your kernel's PAGE_SIZE, so you may need to specify a block
> > > > -size when creating the filesystem.  When mounting it, use the "-o dax"
> > > > -option on the command line or add 'dax' to the options in /etc/fstab.
> > > > +size when creating the file system.
> > > > +
> > > > +Currently 2 filesystems support DAX, ext4 and xfs.  Enabling DAX on them is
> > > > +different at this time.
> > > > +
> > > > +Enabling DAX on ext4
> > > > +--------------------
> > > > +
> > > > +When mounting the filesystem, use the "-o dax" option on the command line or
> > > > +add 'dax' to the options in /etc/fstab.
> > > > +
> > > > +
> > > > +Enabling DAX on xfs
> > > > +-------------------
> > > > +
> > > > +Summary
> > > > +-------
> > > > +
> > > > + 1. There exists an in-kernel access mode flag S_DAX that is set when
> > > > +    file accesses go directly to persistent memory, bypassing the page
> > > > +    cache.
> > >
> > > I had reserved some quibbling with this wording, but now that this is
> > > being proposed as documentation I'll let my quibbling fly. "dax" may
> > > imply, but does not require persistent memory nor does it necessarily
> > > "bypass page cache". For example on configurations that support dax,
> > > but turn off MAP_SYNC (like virtio-pmem), a software flush is
> > > required. Instead, if we're going to define "dax" here I'd prefer it
> > > be a #include of the man page definition that is careful (IIRC) to
> > > only talk about semantics and not backend implementation details. In
> > > other words, dax is to page-cache as direct-io is to page cache,
> > > effectively not there, but dig a bit deeper and you may find it.
> >
> > Uh, which manpage?  Are you talking about the MAP_SYNC documentation?
> 
> No, I was referring to the proposed wording for STATX_ATTR_DAX.
> There's no reason for this description to say anything divergent from
> that description.

Ahh, ok.  Something like this, then:

 1. There exists an in-kernel access mode flag S_DAX.  When set, the
    file is in the DAX (cpu direct access) state.  DAX state attempts to
    minimize software cache effects for both I/O and memory mappings of
    this file.  The S_DAX state is exposed to userspace via the
    STATX_ATTR_DAX statx flag.

    See the STATX_ATTR_DAX in the statx(2) manpage for more information.

--D
