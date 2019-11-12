Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A9EF9694
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 18:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKLRFb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 12:05:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:41387 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfKLRFa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:05:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 09:05:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="287602412"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga001.jf.intel.com with ESMTP; 12 Nov 2019 09:05:28 -0800
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 Nov 2019 09:05:28 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.94]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.168]) with mapi id 14.03.0439.000;
 Tue, 12 Nov 2019 11:05:26 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Subject: RE: [PATCH 2/2] fs: Move swap_[de]activate to file_operations
Thread-Topic: [PATCH 2/2] fs: Move swap_[de]activate to file_operations
Thread-Index: AQHVmPEJn03RPDacYEWb7WKbk7sMtKeHFw8AgACtkeA=
Date:   Tue, 12 Nov 2019 17:05:25 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E92BB4EBE@CRSMSX101.amr.corp.intel.com>
References: <20191112003452.4756-1-ira.weiny@intel.com>
        <20191112003452.4756-3-ira.weiny@intel.com>
 <20191111164320.80f814161469055b14f27045@linux-foundation.org>
In-Reply-To: <20191111164320.80f814161469055b14f27045@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTM4NDllYjMtZWQxZS00MTQ3LWIzNzgtMTdmZmQwOTcxOGVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN3FwcGdWcUNHd0IrWmkwYnd0YWZoTHNTTmx4OTNaaklldUZFb05tZWQ0aHJ1UlwvRktzb1RlV3JGRUNlZFBqNGMifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> On Mon, 11 Nov 2019 16:34:52 -0800 ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > swap_activate() and swap_deactivate() have nothing to do with address
> > spaces.  We want to eventually make the address space operations
> > dynamic to switch inode flags on the fly.
> 
> What does this mean?
> 
> >  So to simplify this code as
> > well as properly track these operations we move these functions to the
> > file_operations vector.
> >
> > This has been tested with XFS but not NFS, f2fs, or btrfs.
> >
> > Also note f2fs and xfs have simple moves of their functions to
> > facilitate compilation.  No functional changes are contained within
> > those functions.
> >
> > ...
> >
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -11002,6 +11002,8 @@ static const struct file_operations
> > btrfs_dir_file_operations = {  #endif
> >  	.release        = btrfs_release_file,
> >  	.fsync		= btrfs_sync_file,
> > +	.swap_activate	= btrfs_swap_activate,
> > +	.swap_deactivate = btrfs_swap_deactivate,
> >  };
> 
> Shouldn't this be btrfs_file_operations?
> 

Shoot...  yes it should and I even thought that as I was moving it and must have still made the mistake...

Sorry, I'll update.
Ira
