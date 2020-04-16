Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79F71ACF48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437356AbgDPSCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 14:02:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50297 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727794AbgDPSCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:02:06 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03GI1hAl008861
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 14:01:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EA2DB42013D; Thu, 16 Apr 2020 14:01:42 -0400 (EDT)
Date:   Thu, 16 Apr 2020 14:01:42 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200416180142.GE5187@mit.edu>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-5-ira.weiny@intel.com>
 <20200415120846.GG6126@quack2.suse.cz>
 <20200415203924.GD2309605@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415203924.GD2309605@iweiny-DESK2.sc.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 01:39:25PM -0700, Ira Weiny wrote:
> 
> I'm on top of 5.6 released.  Did this get removed for 5.7?  I've heard there are
> some boot issues with 5.7-rc1 so I'm holding out for rc2.

Yes, it got removed in 5.7-rc1 in commit 4337ecd1fe99.

The boot issues with 5.7-rc1 is why ext4.git tree is now based off of
v5.7-rc1-35-g00086336a8d9: Merge tag 'efi-urgent-2020-04-15'....

You might want to see if 00086336a8d9 works for you (and if not, let
the x86 and/or efi folks know).

					- Ted
