Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5E781D91
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Aug 2023 13:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjHTLYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Aug 2023 07:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjHTLYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Aug 2023 07:24:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B90E35EEB3;
        Sat, 19 Aug 2023 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YVNU3JEoILpXRFdkjR3RfhopjQs0TLxwme2qMOpLlio=; b=ZYPKJXBd83RVQNZu4S8LNGT2wa
        4trfooghVWuF/75CpVfKOum1ZI8cXbJ+HKkUpQsJkZ8as40+7QoV3wlpny4bCltJEpNvcJs3cjjw7
        UhS4uUCQuUaogr4aXTT/Fk6uDntJ4DyPGRokW6UfFnGrPI2hVe7E+mQMBixnTIGfnczU9HFg6yjnj
        8ei6YRwLntMZZUrNwDuvSmxQroU5kCYLMDwJSYtQCRd+s1iIQMslcIiBRHp8jqCHRnY4uDQiSXZRB
        3lf0P8gW4BP52r58al9ad7zGhlL9YgTkIKkCipaKzmhnV5/CQ8+cT0QnR21BziMU24MSBHYb12Grd
        IOQV+pwQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qXRIA-00B7vZ-0g;
        Sat, 19 Aug 2023 19:07:22 +0000
Date:   Sat, 19 Aug 2023 12:07:22 -0700
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
Message-ID: <ZOES6qmHVHuiz2ek@bombadil.infradead.org>
References: <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
 <20230812000456.GA2375177@frogsfrogsfrogs>
 <CAOQ4uxibnPqE5qG9R53JyaMY1bd6j9OH0pq2eQxYpxDwf3xnGw@mail.gmail.com>
 <ZNwQT80yoHYrjvn+@bombadil.infradead.org>
 <20230816001108.GA1348949@frogsfrogsfrogs>
 <20230816060405.u26tvypmh4tcovef@zlang-mailbox>
 <20230817003345.GV11377@frogsfrogsfrogs>
 <ZN10qmDb8rFQKVkI@bombadil.infradead.org>
 <20230819020736.GS11340@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819020736.GS11340@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 07:07:36PM -0700, Darrick J. Wong wrote:
> On Wed, Aug 16, 2023 at 06:15:22PM -0700, Luis Chamberlain wrote:
> > On Wed, Aug 16, 2023 at 05:33:45PM -0700, Darrick J. Wong wrote:
> > > However, I defined the testing lead (quoting from above):
> > > 
> > > "**Testing Lead**: This person is responsible for setting the test
> > > coverage goals of the project, negotiating with developers to decide
> > > on new tests for new features, and making sure that developers and
> > > release managers execute on the testing."
> > 
> > This I thought I could do.
> 
> Well I certainly invite you to try! :)

OK I don't need a documented tag to try that, so will chug on to try to
help with that.

> > > In my mind, that means the testing lead should be reviewing changes
> > > proposed for tests/xfs/* in fstests by XFS developers to make sure that
> > > new features are adequately covered; and checking that drive-by
> > > contributions from others fit well with what's already there.
> > 
> > This should be included in the description if that's part of the role.
> > This alone is a task and I'm afraid *that* does require much more time
> > commitment and experience I don't think I have with XFS yet. And so it
> > would seem to me a more experience developer on both fstests and XFS
> > would be required for this.

<-- QA stuff -->

FWIW I never have worked with a QA team other than to ask what they do, the
work I do simply is designed to be used by kernel developers for kernel
developers. Why? Because I don't want to disrupt a QA team. If they want
to use it, then great.

> (As for testcase review: is that the job of the code reviewer?  or the
> test maintainer?  I don't know...)
> 
> At this time, our testing is so ... uneven ... that "someone who feels
> totally comfortable with calling bs on obviously inadequate testing and
> people will listen to" is probably qualification enough. :)

OK best I can do is just try, specially in light of "burnout", so to try to
help as communal effort.

I think it helps to quantify the work required, so to ensure I can also
commit and don't break my own responsibilities elsewhere, breaking it
down just for XFS specific tests:

git log --pretty=oneline --since="2023-01-01" --until="2023-02-01" tests/xfs/ | wc -l
17
git log --pretty=oneline --since="2023-02-01" --until="2023-03-01" tests/xfs/ | wc -l
26
git log --pretty=oneline --since="2023-03-01" --until="2023-04-01" tests/xfs/ | wc -l
10
git log --pretty=oneline --since="2023-04-01" --until="2023-05-01" tests/xfs/ | wc -l
1
git log --pretty=oneline --since="2023-05-01" --until="2023-06-01" tests/xfs/ | wc -l
4
git log --pretty=oneline --since="2023-06-01" --until="2023-07-01" tests/xfs/ | wc -l
5
git log --pretty=oneline --since="2023-07-01" --until="2023-08-01" tests/xfs/ | wc -l
5

Lemme just try...

> > > > And a test lead might do more testing besides fstests. So I can't imagine
> > > > that I need to check another project to learn about who's in charge of the
> > > > current project I'm changing.
> > > 
> > > ...so the testing lead would be the person who you'd talk to directly
> > > about changes that you want to make.
> > 
> > I could certainly help try to set a high bar, but to actually ensure
> > correctness of XFS test patches, I do think that should require a more
> > seasoned XFS developer and with fstests.
> 
> <shrug> Maybe we should chat more directly about this? :)
> I'll look you up in #kdevops (the irc) next week.

Sure.

  Luis
