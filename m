Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7122F2D0AE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 07:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgLGGrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 01:47:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:5500 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgLGGrg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 01:47:36 -0500
IronPort-SDR: MXgJcQ9SXg5mkoAeGjE0M5N+EFxs9YIXFuk6CjaAJQtWaBFvVO2FMiRKZdRclL8xJ7wb6Wz5rG
 HYIBxLtQuEVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="161422300"
X-IronPort-AV: E=Sophos;i="5.78,398,1599548400"; 
   d="scan'208";a="161422300"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2020 22:46:56 -0800
IronPort-SDR: 4FH3/Y817ld6sm+54ad8aUJ+RAw5sbHDpwqTAM/MP0pI8maX3Aytstx5sdbZIFZ/+Z7xloG9ro
 fd9YOjOFvrjQ==
X-IronPort-AV: E=Sophos;i="5.78,398,1599548400"; 
   d="scan'208";a="363003127"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2020 22:46:55 -0800
Date:   Sun, 6 Dec 2020 22:46:55 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 03/17] drivers/gpu: Convert to mem*_page()
Message-ID: <20201207064655.GK1563847@iweiny-DESK2.sc.intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
 <20201124060755.1405602-4-ira.weiny@intel.com>
 <160648211578.10416.3269409785516897908@jlahtine-mobl.ger.corp.intel.com>
 <20201204160504.GH1563847@iweiny-DESK2.sc.intel.com>
 <878sad9p7f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sad9p7f.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:33:08PM +0100, Thomas Gleixner wrote:
> On Fri, Dec 04 2020 at 08:05, Ira Weiny wrote:
> > So I think I'm going to submit the base patch to Andrew today (with some
> > cleanups per the comments in this thread).
> 
> Could you please base that on tip core/mm where the kmap_local() muck is
> and use kmap_local() right away?

Sure.  Would that mean it should go through you and not Andrew?

Ira

> 
> Thanks,
> 
>         tglx
