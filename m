Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457261BCE43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 23:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgD1VMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 17:12:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53776 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgD1VMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:12:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SL3HKC120082;
        Tue, 28 Apr 2020 21:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VNVPJDAdbkMh1W9V8jsrS4bwFmxf64AOFnoK0lDjDlI=;
 b=X7/t914nYpwnSnpwlpwttxFpYHNn4A0MNbQ46lELupv4vZko0r6OSMFgwT77N3Ah5m//
 4Z7YQihcf1Ef2cxaskChraVi4cMUzRwzn7H5h57m08RZD9Lly/SwsFVWzEp0ZP8Vu0dX
 Ltau1HNBOWt7f6bquQKnvUiddwFIdzsm3y7v0zKYEZolvnQvI/QbWF5p4+g/SVfuI4T2
 hr2Azn6t/leLW1sHNj5iqUodcKxbzAj31ByWDYUMOh20u5ZJ4iIk8nNE5vp92VKVyjHy
 P54a/XulSYSEkMJBDWfykOpnoKwTb54kEWFV0J2eU7sjCLmr5SZx+5VVg3iVsu3i76Mz LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30p2p07tfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 21:12:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SL79RX054313;
        Tue, 28 Apr 2020 21:12:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30my0ed7ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 21:12:37 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03SLCYko023876;
        Tue, 28 Apr 2020 21:12:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 14:12:34 -0700
Date:   Tue, 28 Apr 2020 14:12:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V11 04/11] Documentation/dax: Update Usage section
Message-ID: <20200428211232.GI6733@magnolia>
References: <20200428002142.404144-1-ira.weiny@intel.com>
 <20200428002142.404144-5-ira.weiny@intel.com>
 <20200428202738.GE6742@magnolia>
 <20200428205309.GA406458@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428205309.GA406458@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280165
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 01:53:10PM -0700, Ira Weiny wrote:
> On Tue, Apr 28, 2020 at 01:27:38PM -0700, Darrick J. Wong wrote:
> > On Mon, Apr 27, 2020 at 05:21:35PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> 
> [snip]
> 
> > > +
> > > + 3. If the persistent FS_XFLAG_DAX flag is set on a directory, this flag will
> > > +    be inherited by all regular files and sub directories that are subsequently
> > 
> > Well, I'm at the level of minor edits: "...and subdirectories that..."
> 
> Done.
> 
> > 
> > > +    created in this directory. Files and subdirectories that exist at the time
> > > +    this flag is set or cleared on the parent directory are not modified by
> > > +    this modification of the parent directory.
> > > +
> > > + 4. There exists dax mount options which can override FS_XFLAG_DAX in the
> > > +    setting of the S_DAX flag.  Given underlying storage which supports DAX the
> > > +    following hold.
> > 
> > "hold:"
> 
> Dene.
> 
> > 
> > > +
> > > +    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> > > +
> > > +    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> > > +
> > > +    "-o dax=always" means "always set S_DAX ignore FS_XFLAG_DAX."
> > > +
> > > +    "-o dax"        is a legacy option which is an alias for "dax=always".
> > > +		    This may be removed in the future so "-o dax=always" is
> > > +		    the preferred method for specifying this behavior.
> > > +
> > > +    NOTE: Setting and inheritance affect FS_XFLAG_DAX at all times even when
> > > +    the file system is mounted with a dax option.
> > 
> > We can also clear the flag at any time no matter the mount option state.
> > Perhaps:
> > 
> > "NOTE: Modifications to and inheritance behavior of FS_XFLAG_DAX remain
> > the same even when the filesystem is mounted with a dax option."
> 
> Done.
> 
> > 
> > > +    However, in-core inode state
> > > +    (S_DAX) will be overridden until the file system is remounted with
> > > +    dax=inode and the inode is evicted from kernel memory.
> > > +
> > > + 5. The DAX policy can be changed via:
> > 
> > "The S_DAX policy".  I don't want people to get confused.
> 
> Done.
> 
> > 
> > > +
> > > +    a) Set the parent directory FS_XFLAG_DAX as needed before files are created
> > > +
> > > +    b) Set the appropriate dax="foo" mount option
> > > +
> > > +    c) Change the FS_XFLAG_DAX on existing regular files and directories. This
> > > +       has runtime constraints and limitations that are described in 6) below.
> > 
> > "Setting", and "Changing" at the front of these three bullet points?
> > 
> > Were you to put these together as full sentences, you'd want them to
> > read "The DAX policy can be changed via setting the parent directory
> > FS_XFLAG_DAX..."
> > 
> 
> Done.
> 
> > > +
> > > + 6. When changing the DAX policy via toggling the persistent FS_XFLAG_DAX flag,
> > 
> > "When changing the S_DAX policy..."
> 
> Done.
> 
> > 
> > > +    the change in behaviour for existing regular files may not occur
> > > +    immediately.  If the change must take effect immediately, the administrator
> > > +    needs to:
> > > +
> > > +    a) stop the application so there are no active references to the data set
> > > +       the policy change will affect
> > > +
> > > +    b) evict the data set from kernel caches so it will be re-instantiated when
> > > +       the application is restarted. This can be acheived by:
> > 
> > "achieved"
> 
> Done.
> 
> > 
> > > +
> > > +       i. drop-caches
> > > +       ii. a filesystem unmount and mount cycle
> > > +       iii. a system reboot
> > > +
> > > +
> > > +Details
> > > +-------
> > > +
> > > +There are 2 per-file dax flags.  One is a persistent inode setting (FS_XFLAG_DAX)
> > > +and the other is a volatile flag indicating the active state of the feature
> > > +(S_DAX).
> > > +
> > > +FS_XFLAG_DAX is preserved within the file system.  This persistent config
> > > +setting can be set, cleared and/or queried using the FS_IOC_FS[GS]ETXATTR ioctl
> > > +(see ioctl_xfs_fsgetxattr(2)) or an utility such as 'xfs_io'.
> > > +
> > > +New files and directories automatically inherit FS_XFLAG_DAX from
> > > +their parent directory _when_ _created_.  Therefore, setting FS_XFLAG_DAX at
> > > +directory creation time can be used to set a default behavior for an entire
> > > +sub-tree.
> > > +
> > > +To clarify inheritance here are 3 examples:
> > 
> > "...inheritance, here are..."
> 
> Done.
> 
> > 
> > > +
> > > +Example A:
> > > +
> > > +mkdir -p a/b/c
> > > +xfs_io -c 'chattr +x' a
> > > +mkdir a/b/c/d
> > > +mkdir a/e
> > > +
> > > +	dax: a,e
> > > +	no dax: b,c,d
> > > +
> > > +Example B:
> > > +
> > > +mkdir a
> > > +xfs_io -c 'chattr +x' a
> > > +mkdir -p a/b/c/d
> > > +
> > > +	dax: a,b,c,d
> > > +	no dax:
> > > +
> > > +Example C:
> > > +
> > > +mkdir -p a/b/c
> > > +xfs_io -c 'chattr +x' c
> > > +mkdir a/b/c/d
> > > +
> > > +	dax: c,d
> > > +	no dax: a,b
> > > +
> > > +
> > > +The current enabled state (S_DAX) is set when a file inode is instantiated in
> > > +memory by the kernel.  It is set based on the underlying media support, the
> > > +value of FS_XFLAG_DAX and the file systems dax mount option setting.
> > 
> > "...and the file system's dax mount option string."
> 
> No. I don't think string is the right word here.  It is the setting not the
> string which is controlling the behavior.  How about:
> 
> "...and the file system's dax mount option."

Oops.  I miscopied that; all I really wanted was the apostrophe-s after
"file system".

"...and the file system's dax mount option setting."

would have been fine.

--D

> 
> > 
> > > +
> > > +statx can be used to query S_DAX.  NOTE that a directory will never have S_DAX
> > 
> > "Note that only regular files will ever have S_DAX set..."?
> 
> Done.
> 
> Ira
> 
> > 
> > --D
> > 
> > > +set and therefore statx will never indicate that S_DAX is set on directories.
> > > +
> > > +Setting the FS_XFLAG_DAX (specifically or through inheritance) occurs even if
> > > +the underlying media does not support dax and/or the file system is overridden
> > > +with a mount option.
> > > +
> > >  
> > >  
> > >  Implementation Tips for Block Driver Writers
> > > -- 
> > > 2.25.1
> > > 
