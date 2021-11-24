Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D1045B26A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 04:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhKXDI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 22:08:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhKXDIZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:08:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3682660F55;
        Wed, 24 Nov 2021 03:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637723116;
        bh=8E5AHzN+aCpIUyy/IKItQsgBCFz9QjxdNsnf6Wc8sLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRaLXp2DQNpRDi5NBlLIrHYp1YQ84fyWovscy9PbvHAt/ymlk5DiV6yDdEv5cQWZr
         jLpg2wIKqTZyI1ywqwak+JmUmQSdDiGbC/0EDBVNmzr8LgDHb5y1ocPXF2R6jYxhnN
         GN5ZvGVK69U1jII2tRqWVd7zBvVEF9NGxPhMG0So+jx7Z6OnHCYoRXokbFrI/Qp6wI
         kbYSpUTNH7LbVZaurhYL8mcXBu98rgITDU24/fEvl1Doo9kGD/X0YwHhmZrb9tueYZ
         d/7VoK/rTTLlDbMhSGJNN93DH71+f/oSLnH2gBKrosvzkrffMmGkKX9KhJ/nEPm2kt
         Y0OPUm6XnKtFg==
Date:   Tue, 23 Nov 2021 19:05:15 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 21/29] xfs: move dax device handling into
 xfs_{alloc,free}_buftarg
Message-ID: <20211124030515.GC266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-22-hch@lst.de>
 <CAPcyv4hY4g82PrjMPO=1kiM5sL=3=yR66r6LeG8RS3Ha2k1eUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hY4g82PrjMPO=1kiM5sL=3=yR66r6LeG8RS3Ha2k1eUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 06:40:47PM -0800, Dan Williams wrote:
> On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hide the DAX device lookup from the xfs_super.c code.
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> That's an interesting spelling of "Signed-off-by", but patch looks
> good to me too. I would have expected a robot to complain about
> missing sign-off?

Nah, they only like to do that /after/ you've pushed a branch to
kernel.org and emailed the lists about it. ;)

--D

> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
