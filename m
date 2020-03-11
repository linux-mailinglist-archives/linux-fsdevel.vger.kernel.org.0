Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D3B1810FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 07:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgCKGoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 02:44:17 -0400
Received: from verein.lst.de ([213.95.11.211]:57540 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKGoQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:44:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 65B7C68C65; Wed, 11 Mar 2020 07:44:12 +0100 (CET)
Date:   Wed, 11 Mar 2020 07:44:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations
 V5
Message-ID: <20200311064412.GA11819@lst.de>
References: <20200227052442.22524-1-ira.weiny@intel.com> <20200305155144.GA5598@lst.de> <20200309170437.GA271052@iweiny-DESK2.sc.intel.com> <20200311033614.GQ1752567@magnolia> <20200311063942.GE10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311063942.GE10776@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 05:39:42PM +1100, Dave Chinner wrote:
> IOWs, the dax_associate_page() related functionality probably needs
> to be a filesystem callout - part of the aops vector, I think, so
> that device dax can still use it. That way XFS can go it's own way,
> while ext4 and device dax can continue to use the existing mechanism
> mechanisn that is currently implemented....

s/XFS/XFS with rmap/, as most XFS file systems currently don't have
that enabled we'll also need to keep the legacy path around.
