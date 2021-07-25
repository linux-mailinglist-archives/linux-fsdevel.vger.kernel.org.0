Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207B63D4F5F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jul 2021 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGYRUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jul 2021 13:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGYRUu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jul 2021 13:20:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4717F60F23;
        Sun, 25 Jul 2021 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627236080;
        bh=DtWHvujPpIyKQBeKaHt8GyF9Ra/WfsnZ9uWNGMPtLUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLXAqHurm5qcA+X+pkwFg3SdcE9mo8AZnLFp/x1TEtMMB7CRs82OJYR8nk5X0eMpN
         vYq1pgwvaeoxLtWkhaPOsgm9Oq/t6lRShpGpj/86vxkuI6uecFj0kRBMIYLLo3iPoy
         ES/OVOsudcH5LV+RYseLdWuFJ9wtnCI4YMW0McEEyAhm/LdQLqgylPvMHCAi41a6Nm
         Yrso8PW82FDu6UOiEbNuU/J0397yakkLlE0iBqumuzNObmaB0NOQrG/aRsuvOe2VVy
         U5V2VN2v07qy5FuXQSnFA7fAGWsVSrtqBoNXeIVv0FGOLZ047WS7kYT+B4TzpU9hSv
         ml+hBuh1zqhsw==
Date:   Sun, 25 Jul 2021 11:01:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
Message-ID: <YP2m7lSqvenvxYIY@sol.localdomain>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
 <YP2Ew57ptGgYsD1Y@google.com>
 <YP2Hp5RcZfhKipfG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP2Hp5RcZfhKipfG@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 25, 2021 at 08:47:51AM -0700, Jaegeuk Kim wrote:
> On 07/25, Jaegeuk Kim wrote:
> > Note that, this patch is failing generic/250.
> 
> correction: it's failing in 4.14 and 4.19 after simple cherry-pick, but
> giving no failure on 5.4, 5.10, and mainline.
> 

For me, generic/250 fails on both mainline and f2fs/dev without my changes.
So it isn't a regression.

- Eric
