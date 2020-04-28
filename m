Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0811BCDB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 22:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgD1UxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 16:53:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:57161 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgD1UxL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:53:11 -0400
IronPort-SDR: pKidk+fXUxGhY0IWObU7CJMIiY5L3bFAMWFZ/dLX+WmN6/1a4FP32D3sSdygQHO0k1q9OJtN4p
 hqASpawyvnAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 13:53:10 -0700
IronPort-SDR: 3snnw8BJK4V62Ig7Jx3J/jDuG99BD4Ekja5j/Y4K5vPfqKmkjy3PpeGktQ67+UJX+VBYDayF+O
 9jdJZLYYskLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="367613185"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2020 13:53:10 -0700
Date:   Tue, 28 Apr 2020 13:53:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V11 04/11] Documentation/dax: Update Usage section
Message-ID: <20200428205309.GA406458@iweiny-DESK2.sc.intel.com>
References: <20200428002142.404144-1-ira.weiny@intel.com>
 <20200428002142.404144-5-ira.weiny@intel.com>
 <20200428202738.GE6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428202738.GE6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 01:27:38PM -0700, Darrick J. Wong wrote:
> On Mon, Apr 27, 2020 at 05:21:35PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 

[snip]

> > +
> > + 3. If the persistent FS_XFLAG_DAX flag is set on a directory, this flag will
> > +    be inherited by all regular files and sub directories that are subsequently
> 
> Well, I'm at the level of minor edits: "...and subdirectories that..."

Done.

> 
> > +    created in this directory. Files and subdirectories that exist at the time
> > +    this flag is set or cleared on the parent directory are not modified by
> > +    this modification of the parent directory.
> > +
> > + 4. There exists dax mount options which can override FS_XFLAG_DAX in the
> > +    setting of the S_DAX flag.  Given underlying storage which supports DAX the
> > +    following hold.
> 
> "hold:"

Dene.

> 
> > +
> > +    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> > +
> > +    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> > +
> > +    "-o dax=always" means "always set S_DAX ignore FS_XFLAG_DAX."
> > +
> > +    "-o dax"        is a legacy option which is an alias for "dax=always".
> > +		    This may be removed in the future so "-o dax=always" is
> > +		    the preferred method for specifying this behavior.
> > +
> > +    NOTE: Setting and inheritance affect FS_XFLAG_DAX at all times even when
> > +    the file system is mounted with a dax option.
> 
> We can also clear the flag at any time no matter the mount option state.
> Perhaps:
> 
> "NOTE: Modifications to and inheritance behavior of FS_XFLAG_DAX remain
> the same even when the filesystem is mounted with a dax option."

Done.

> 
> > +    However, in-core inode state
> > +    (S_DAX) will be overridden until the file system is remounted with
> > +    dax=inode and the inode is evicted from kernel memory.
> > +
> > + 5. The DAX policy can be changed via:
> 
> "The S_DAX policy".  I don't want people to get confused.

Done.

> 
> > +
> > +    a) Set the parent directory FS_XFLAG_DAX as needed before files are created
> > +
> > +    b) Set the appropriate dax="foo" mount option
> > +
> > +    c) Change the FS_XFLAG_DAX on existing regular files and directories. This
> > +       has runtime constraints and limitations that are described in 6) below.
> 
> "Setting", and "Changing" at the front of these three bullet points?
> 
> Were you to put these together as full sentences, you'd want them to
> read "The DAX policy can be changed via setting the parent directory
> FS_XFLAG_DAX..."
> 

Done.

> > +
> > + 6. When changing the DAX policy via toggling the persistent FS_XFLAG_DAX flag,
> 
> "When changing the S_DAX policy..."

Done.

> 
> > +    the change in behaviour for existing regular files may not occur
> > +    immediately.  If the change must take effect immediately, the administrator
> > +    needs to:
> > +
> > +    a) stop the application so there are no active references to the data set
> > +       the policy change will affect
> > +
> > +    b) evict the data set from kernel caches so it will be re-instantiated when
> > +       the application is restarted. This can be acheived by:
> 
> "achieved"

Done.

> 
> > +
> > +       i. drop-caches
> > +       ii. a filesystem unmount and mount cycle
> > +       iii. a system reboot
> > +
> > +
> > +Details
> > +-------
> > +
> > +There are 2 per-file dax flags.  One is a persistent inode setting (FS_XFLAG_DAX)
> > +and the other is a volatile flag indicating the active state of the feature
> > +(S_DAX).
> > +
> > +FS_XFLAG_DAX is preserved within the file system.  This persistent config
> > +setting can be set, cleared and/or queried using the FS_IOC_FS[GS]ETXATTR ioctl
> > +(see ioctl_xfs_fsgetxattr(2)) or an utility such as 'xfs_io'.
> > +
> > +New files and directories automatically inherit FS_XFLAG_DAX from
> > +their parent directory _when_ _created_.  Therefore, setting FS_XFLAG_DAX at
> > +directory creation time can be used to set a default behavior for an entire
> > +sub-tree.
> > +
> > +To clarify inheritance here are 3 examples:
> 
> "...inheritance, here are..."

Done.

> 
> > +
> > +Example A:
> > +
> > +mkdir -p a/b/c
> > +xfs_io -c 'chattr +x' a
> > +mkdir a/b/c/d
> > +mkdir a/e
> > +
> > +	dax: a,e
> > +	no dax: b,c,d
> > +
> > +Example B:
> > +
> > +mkdir a
> > +xfs_io -c 'chattr +x' a
> > +mkdir -p a/b/c/d
> > +
> > +	dax: a,b,c,d
> > +	no dax:
> > +
> > +Example C:
> > +
> > +mkdir -p a/b/c
> > +xfs_io -c 'chattr +x' c
> > +mkdir a/b/c/d
> > +
> > +	dax: c,d
> > +	no dax: a,b
> > +
> > +
> > +The current enabled state (S_DAX) is set when a file inode is instantiated in
> > +memory by the kernel.  It is set based on the underlying media support, the
> > +value of FS_XFLAG_DAX and the file systems dax mount option setting.
> 
> "...and the file system's dax mount option string."

No. I don't think string is the right word here.  It is the setting not the
string which is controlling the behavior.  How about:

"...and the file system's dax mount option."

> 
> > +
> > +statx can be used to query S_DAX.  NOTE that a directory will never have S_DAX
> 
> "Note that only regular files will ever have S_DAX set..."?

Done.

Ira

> 
> --D
> 
> > +set and therefore statx will never indicate that S_DAX is set on directories.
> > +
> > +Setting the FS_XFLAG_DAX (specifically or through inheritance) occurs even if
> > +the underlying media does not support dax and/or the file system is overridden
> > +with a mount option.
> > +
> >  
> >  
> >  Implementation Tips for Block Driver Writers
> > -- 
> > 2.25.1
> > 
