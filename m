Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283572856FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 05:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgJGDUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 23:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgJGDUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:20:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB576C061755;
        Tue,  6 Oct 2020 20:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3lLD0zvE4MJ6obA1X6t1ltm+Ls0OGSfFYsuDvjn+1S8=; b=MFsCGRvpNGRCh6eLvXW6qRDO6U
        G6brFP4dYd07RmCnkYA3fdM35fYCPeiKMMESZIx9O57f4aY5UNVSW6K24NAR2Xn/mj0zmCP+dI286
        EpCC1FbhsCFYKQI0vz1pjzwR3gv/NZS8msguVo1g9yxnYqZy89Y5JNJRScdUyUiUk0+lnvcvifs7/
        rb47ggI0zem2nvCvPMnSkCz2L19v0sKDFLUSM+bCUxO+rIcb275xOYiD3yFFcYy27sAzyffQlpRgN
        U4dNouLq2u8MEXdEQlIbeAp+P3DeNM9KYlenMPc18NUgV6yr2EVy4NFF8GaTakhdK+mlDea/lqYPI
        99wlsaqw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPzzx-0005dE-Db; Wed, 07 Oct 2020 03:20:13 +0000
Date:   Wed, 7 Oct 2020 04:20:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     jglisse@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 00/14] Small step toward KSM for file back page.
Message-ID: <20201007032013.GS20115@casper.infradead.org>
References: <20201007010603.3452458-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007010603.3452458-1-jglisse@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 06, 2020 at 09:05:49PM -0400, jglisse@redhat.com wrote:
> The present patchset just add mapping argument to the various vfs call-
> backs. It does not make use of that new parameter to avoid regression.
> I am posting this whole things as small contain patchset as it is rather
> big and i would like to make progress step by step.

Well, that's the problem.  This patch set is gigantic and unreviewable.
And it has no benefits.  The idea you present here was discussed at
LSFMM in Utah and I recall absolutely nobody being in favour of it.
You claim many wonderful features will be unlocked by this, but I think
they can all be achieved without doing any of this very disruptive work.

>  118 files changed, 722 insertions(+), 385 deletions(-)

mmm.
