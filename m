Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0514F77EE96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 03:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347467AbjHQBPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 21:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjHQBPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:15:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15AB1987;
        Wed, 16 Aug 2023 18:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qCicAS+g3vQtPfa9bypEn46nqXRIlzk6w9WcGt9/wvg=; b=fPC/3LdncyGeel3H+DM+pjHc/7
        0AInY2MdqNrb6zS2SmcFhro9/ZZGeSnl4A2wXREa/ZX1FOEWI0eWdMHxJF0li8QlnW/L3BO/PRLDt
        yOqd3pZQNNzNPJXU592I0nbhWnfFUcHCzVtAx1kOkBQvK1d2WDTIo9ZE7OSDb0e6nat5KMbiJEOQm
        LOzPA664UYBQAaLlWUlBWhHX6YGt6ioBOkLCHo60e7nKZGPFWOw2PC6qI8zF4OyHWHXIC0mUPXX6v
        7YrKOyf0lrAkmHNdLdM/3fdcZ0kLL4r6K2uVfEfOF3yTLKmWxFV/vrG9iXH/8CQDLFOJIYTjY8L/f
        THpPf8HA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qWRbf-005Htp-07;
        Thu, 17 Aug 2023 01:15:23 +0000
Date:   Wed, 16 Aug 2023 18:15:22 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, corbet@lwn.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, leah.rumancik@gmail.com, zlang@kernel.org,
        fstests@vger.kernel.org, willy@infradead.org,
        shirley.ma@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/3] docs: add maintainer entry profile for XFS
Message-ID: <ZN10qmDb8rFQKVkI@bombadil.infradead.org>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
 <20230812000456.GA2375177@frogsfrogsfrogs>
 <CAOQ4uxibnPqE5qG9R53JyaMY1bd6j9OH0pq2eQxYpxDwf3xnGw@mail.gmail.com>
 <ZNwQT80yoHYrjvn+@bombadil.infradead.org>
 <20230816001108.GA1348949@frogsfrogsfrogs>
 <20230816060405.u26tvypmh4tcovef@zlang-mailbox>
 <20230817003345.GV11377@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817003345.GV11377@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 05:33:45PM -0700, Darrick J. Wong wrote:
> However, I defined the testing lead (quoting from above):
> 
> "**Testing Lead**: This person is responsible for setting the test
> coverage goals of the project, negotiating with developers to decide
> on new tests for new features, and making sure that developers and
> release managers execute on the testing."

This I thought I could do.

> In my mind, that means the testing lead should be reviewing changes
> proposed for tests/xfs/* in fstests by XFS developers to make sure that
> new features are adequately covered; and checking that drive-by
> contributions from others fit well with what's already there.

This should be included in the description if that's part of the role.
This alone is a task and I'm afraid *that* does require much more time
commitment and experience I don't think I have with XFS yet. And so it
would seem to me a more experience developer on both fstests and XFS
would be required for this.

> > And a test lead might do more testing besides fstests. So I can't imagine
> > that I need to check another project to learn about who's in charge of the
> > current project I'm changing.
> 
> ...so the testing lead would be the person who you'd talk to directly
> about changes that you want to make.

I could certainly help try to set a high bar, but to actually ensure
correctness of XFS test patches, I do think that should require a more
seasoned XFS developer and with fstests.

  Luis
