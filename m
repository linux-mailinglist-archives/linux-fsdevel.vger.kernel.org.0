Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594B041A387
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 01:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbhI0XEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 19:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237749AbhI0XEi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:04:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDCB360F4B;
        Mon, 27 Sep 2021 23:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632783780;
        bh=m4CZ5SM/3Qe9npDzyoiZPMjdnYvUrswyvrv4xJRdJwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rck63blrH3dnahpfUQn5aCjZLE08Spckvlybrg14peuT1SKw/GXRu0ghBe0/WOvqF
         HAs4pzhS+r7kYaIJPlalkHKjyq82CxkZ27Nd2JVvUi+7bJPLqabzfsnCLq3x+KLQgG
         x/55GmsR33EcXB/pE3O0ts+6MjSAg9YjYS+MR740rFsrrSkiuT7lr+7WtctQ+w5XqY
         oTbuGo8zzCx3kQNyJjxB9t2+BPelAg6k1Liz4AoWhbWslMKz4L0wTwRShOJcv8j0lB
         6xVWKViP444gej7HEw8FrtX1eH5QW0ONhTWMWzHTRaeY1M7S0xpmMrUtMWEP4nwxmc
         XYMdJGJ4FFciw==
Date:   Mon, 27 Sep 2021 16:02:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [regression] fs dax xfstests panic
Message-ID: <20210927230259.GA2706839@magnolia>
References: <20210927061747.rijhtovxafsot32z@xzhoux.usersys.redhat.com>
 <20210927115116.GB23909@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927115116.GB23909@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 01:51:16PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 27, 2021 at 02:17:47PM +0800, Murphy Zhou wrote:
> > Hi folks,
> > 
> > Since this commit:
> > 
> > commit edb0872f44ec9976ea6d052cb4b93cd2d23ac2ba
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Mon Aug 9 16:17:43 2021 +0200
> > 
> >     block: move the bdi from the request_queue to the gendisk
> > 
> > 
> > Looping xfstests generic/108 or xfs/279 on mountpoints with fsdax
> > enabled can lead to panic like this:
> 
> Does this still happen with this series:
> 
> https://lore.kernel.org/linux-block/20210922172222.2453343-1-hch@lst.de/T/#m8dc646a4dfc40f443227da6bb1c77d9daec524db
> 
> ?

My test machinse all hit this when writeback throttling is enabled, so

Tested-by: Darrick J. Wong <djwong@kernel.org>

--D

