Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119D61A7391
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 08:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405935AbgDNGYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 02:24:35 -0400
Received: from verein.lst.de ([213.95.11.211]:37617 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405926AbgDNGYe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 02:24:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C295B68BEB; Tue, 14 Apr 2020 08:24:31 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:24:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 4/9] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200414062431.GC23154@lst.de>
References: <20200413054046.1560106-1-ira.weiny@intel.com> <20200413054046.1560106-5-ira.weiny@intel.com> <20200413154619.GT6742@magnolia> <20200413192810.GB1649878@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413192810.GB1649878@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 12:28:11PM -0700, Ira Weiny wrote:
> > I think that the dax_param_enums table (and the unnamed enum defining
> > XFS_DAX_*) probably ought to be part of the VFS so that you don't have
> > to duplicate these two pieces whenever it's time to bring ext4 in line
> > with XFS.
> > 
> > That probably doesn't need to be done right away, though...
> 
> Ext4 has a very different param parsing mechanism which I've barely learned.
> I'm not really seeing how to use the enum strategy so I've just used a string
> option.  But I'm open to being corrected.
> 
> I am close to having the series working and hope to have that set (which builds
> on this one) out for review soon (today?).

ext4 still uses the legacy mount option parsing that XFS used until
recently.  It needs to be switched over to the new mount API anyway.
