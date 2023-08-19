Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1778168E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 04:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbjHSCH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 22:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243544AbjHSCHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:07:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771C1421F;
        Fri, 18 Aug 2023 19:07:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA4762BAA;
        Sat, 19 Aug 2023 02:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFBBC433C7;
        Sat, 19 Aug 2023 02:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692410857;
        bh=8pcZHtB6DHhPFhFZ/nMj7g3so9AlrY/3Rallqgu9qGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXDVi9Ve8X2lh8APyGpqdQOiprIMgy/NxESGC8XCgZsHGSbEyG+W/sUkGveXL2AmD
         dpgBplfDQPZEx0ywq13uqH23pG1i92YhRohNPz/AW+4OW9kqPp2At0Z7iZglpPDcoy
         W9pvOw3bSpanEaCK7NV2axE3Kp8z309EgwmSSQT+ZVDLs/r3yda4fISYNlTNyBT00I
         TANd1KDhE0HEJiJsGKisewDaVbgGDB2C1rf3u8uwQ1sofjA9CkO+N5J8j9oK3pfxI1
         K+rDql8UJABBULXnzzRX08BcfJbPZoO4YSE2NVh/0HxYAZTPuHcY70NkSEy+dIWjIb
         FNCjFyOThHUlg==
Date:   Fri, 18 Aug 2023 19:07:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, corbet@lwn.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, leah.rumancik@gmail.com, zlang@kernel.org,
        fstests@vger.kernel.org, willy@infradead.org,
        shirley.ma@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/3] docs: add maintainer entry profile for XFS
Message-ID: <20230819020736.GS11340@frogsfrogsfrogs>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
 <20230812000456.GA2375177@frogsfrogsfrogs>
 <CAOQ4uxibnPqE5qG9R53JyaMY1bd6j9OH0pq2eQxYpxDwf3xnGw@mail.gmail.com>
 <ZNwQT80yoHYrjvn+@bombadil.infradead.org>
 <20230816001108.GA1348949@frogsfrogsfrogs>
 <20230816060405.u26tvypmh4tcovef@zlang-mailbox>
 <20230817003345.GV11377@frogsfrogsfrogs>
 <ZN10qmDb8rFQKVkI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN10qmDb8rFQKVkI@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 06:15:22PM -0700, Luis Chamberlain wrote:
> On Wed, Aug 16, 2023 at 05:33:45PM -0700, Darrick J. Wong wrote:
> > However, I defined the testing lead (quoting from above):
> > 
> > "**Testing Lead**: This person is responsible for setting the test
> > coverage goals of the project, negotiating with developers to decide
> > on new tests for new features, and making sure that developers and
> > release managers execute on the testing."
> 
> This I thought I could do.

Well I certainly invite you to try! :)

> > In my mind, that means the testing lead should be reviewing changes
> > proposed for tests/xfs/* in fstests by XFS developers to make sure that
> > new features are adequately covered; and checking that drive-by
> > contributions from others fit well with what's already there.
> 
> This should be included in the description if that's part of the role.
> This alone is a task and I'm afraid *that* does require much more time
> commitment and experience I don't think I have with XFS yet. And so it
> would seem to me a more experience developer on both fstests and XFS
> would be required for this.

<shrug> I think someone familiar with running a QA organization would
know exactly the sorts of things that need testing and how to make a
reasonably thorough test plan.  They wouldn't necessarily need to know
all that much about the xfs codebase per se, though obviously they'd
need to be familiar with C and all of its marvelous footguns.

(As for testcase review: is that the job of the code reviewer?  or the
test maintainer?  I don't know...)

At this time, our testing is so ... uneven ... that "someone who feels
totally comfortable with calling bs on obviously inadequate testing and
people will listen to" is probably qualification enough. :)

> > > And a test lead might do more testing besides fstests. So I can't imagine
> > > that I need to check another project to learn about who's in charge of the
> > > current project I'm changing.
> > 
> > ...so the testing lead would be the person who you'd talk to directly
> > about changes that you want to make.
> 
> I could certainly help try to set a high bar, but to actually ensure
> correctness of XFS test patches, I do think that should require a more
> seasoned XFS developer and with fstests.

<shrug> Maybe we should chat more directly about this? :)
I'll look you up in #kdevops (the irc) next week.

--D

>   Luis
