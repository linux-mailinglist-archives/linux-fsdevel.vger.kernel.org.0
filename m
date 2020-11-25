Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BBC2C474D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 19:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbgKYSLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 13:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732412AbgKYSLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:11:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF8C0613D4;
        Wed, 25 Nov 2020 10:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1CkjoPPcNHYHWb6gR85isyRuo3IJhmytJlGs/qonqoo=; b=RzoY5IZIV/03rxcDYeZhkh/y8p
        4saU71nEnKmCA+HzHYC3JVg9mdPoihJd8zsuDEpz1YEu50etilsQqKhWvil+oxAWit+vmEca5irjj
        W/kQLKd00dbvLyZA3+1MBmD8sywSFHW+r21iUnLIMPzMb8pTMe1YHvp1NnwxjiU3bXoF8aWqCdnRS
        3YLhe7paif5TuYq10B4b8RSdh/haVKtgh/GEj4C34tz5qHprkcSGtVSafl9LH0L9gfcyodfHuBHLs
        AKqGQCrZ2VQnPp4S+MSnurWy1wGkrS3zt/XQ5qLgQlZKeBKT14z5LT7iv131my+b/31k1HF17DYg0
        O3zRxqwQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khzGL-0001Fj-Jm; Wed, 25 Nov 2020 18:11:29 +0000
Date:   Wed, 25 Nov 2020 18:11:29 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] drm/ttm: don't set page->mapping
Message-ID: <20201125181129.GA1858@infradead.org>
References: <20201125162532.1299794-1-daniel.vetter@ffwll.ch>
 <20201125162532.1299794-5-daniel.vetter@ffwll.ch>
 <CAKMK7uGXfqaPUtnX=VgA3tFn3S+Gt9GV+kPguakZ6FF_n8LKuA@mail.gmail.com>
 <20201125180606.GQ5487@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125180606.GQ5487@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 02:06:06PM -0400, Jason Gunthorpe wrote:
> It uses a empty 'cover-letter' commit and automatically transforms it
> into exactly the right stuff. Keeps track of everything you send in
> git, and there is a little tool to auto-run git range-diff to help
> build change logs..
> 
> https://github.com/jgunthorpe/Kernel-Maintainer-Tools/blob/master/gj_tools/cmd_send_patches.py
> 
> I've been occasionaly wondering if I should suggest Konstantin add a
> sending side to b4, maybe using some of those ideas..
> 
> (careful if you run it, it does autosend without prompting)

The looks pretty fancy.  Here is my trivial patchbomb.sh script

----------------------- snip -----------------------
#!/bin/sh

COVERLETTER=$1
PATCHES=$2

git send-email --annotate --to-cover --cc-cover $1 $2
----------------------- snip -----------------------

still needs the git basecommit..endcommit notation, but it fires
up the series for review.
