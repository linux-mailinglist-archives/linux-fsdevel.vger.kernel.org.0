Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25C044586D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 18:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhKDRg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 13:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233867AbhKDRg4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:36:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C09B961168;
        Thu,  4 Nov 2021 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636047257;
        bh=AR8NcrNj5hyA3HWt9nLXt5h1bS993/cghgbNSGVz0kI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxlU4yVvWXPKAVgMlcKtQCmxXE/TikimATxyIFd8unO637JRzA9xVEGorhtbue1Al
         eAjNGYaYn/WxnzE1oojAaGA4jsOHFJledlnSyk5GXBYjtaYzo6Vrc7SNp5YLO8KXm5
         GnXLyjMFRczpgqpxzikwuszii7B+smdLRFlqr6ePyrQtkdaWhWxNadYJyLsd2jgbpP
         Rc+pttEDLYdgyZbTpx0NqCCj/YwPUR6PiF/crWlSmxacWLyoEpUGMiWV6we2w37+Rm
         T+p9bgJyo3VrNLtooKl07eXMQfg5tpv2X7xvy3irecWZ0ZYekQFGKTDVcUnLqQe3vh
         uWg8NUeRjeEXg==
Date:   Thu, 4 Nov 2021 10:34:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: futher decouple DAX from block devices
Message-ID: <20211104173417.GJ2237511@magnolia>
References: <20211018044054.1779424-1-hch@lst.de>
 <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
 <20211104081740.GA23111@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104081740.GA23111@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 04, 2021 at 09:17:40AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 03, 2021 at 12:59:31PM -0500, Eric Sandeen wrote:
> > Christoph, can I ask what the end game looks like, here? If dax is completely
> > decoupled from block devices, are there user-visible changes?
> 
> Yes.
> 
> > If I want to
> > run fs-dax on a pmem device - what do I point mkfs at, if not a block device?
> 
> The rough plan is to use the device dax character devices.  I'll hopefully
> have a draft version in the next days.

/me wonders, are block devices going away?  Will mkfs.xfs have to learn
how to talk to certain chardevs?  I guess jffs2 and others already do
that kind of thing... but I suppose I can wait for the real draft to
show up to ramble further. ;)

--D
