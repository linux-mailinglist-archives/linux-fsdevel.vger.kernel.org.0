Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC62E63AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2019 16:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfJ0PTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Oct 2019 11:19:52 -0400
Received: from verein.lst.de ([213.95.11.211]:58485 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfJ0PTw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Oct 2019 11:19:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4BED68B05; Sun, 27 Oct 2019 16:19:49 +0100 (CET)
Date:   Sun, 27 Oct 2019 16:19:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: add generic UNRESVSP and ZERO_RANGE ioctl
 handlers
Message-ID: <20191027151949.GB6199@lst.de>
References: <20191025023609.22295-1-hch@lst.de> <20191025023609.22295-3-hch@lst.de> <20191025054452.GF913374@magnolia> <20191025095005.GA9613@lst.de> <20191026205609.GJ4614@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026205609.GJ4614@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 27, 2019 at 07:56:09AM +1100, Dave Chinner wrote:
> We should plan to deprecate and remove ALLOCSP/FREESP - they just
> aren't useful APIs anymore, and nobody has used them in preference
> to the RESVSP/UNRESVSP ioctls since they were introduced in ~1998
> with unwritten extents. We probably should have deprecated then 10
> years ago....

I vaguely remember an actually reported bug beeing fixed in the code
just a few years ago, which suggests actual users.  That being said
I'm all for throwing in a deprecation warnings and then see if anyone
screams.  With this series the code becomes more self-contained, and
I have another patch that moves the IOC_RESVP / fallocate implementation
over to use iomap, at which point it is entirely standalone.
