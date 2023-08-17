Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFE677EE5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 02:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347294AbjHQAgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 20:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347467AbjHQAf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 20:35:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6F93581;
        Wed, 16 Aug 2023 17:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F6A563F79;
        Thu, 17 Aug 2023 00:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE06C433C8;
        Thu, 17 Aug 2023 00:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692232426;
        bh=btZI9n4a0YsXk7u3kMhkwvs0HUIAiqOAZNg313OcXDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aawE7pqryZ9BBhpupatyesPLzbWYmAQU9FPzgC3GDUsztKYzOX3UwAGT/chDd1Qua
         BCJgCVvlr5skrHQCCVthR84Azq5JHjn3ufwcdfa3RvRgdwN66axzggCAnlHARnZT7m
         6bfLMHZNvwqezCx0s1Uvj9w+/smajgKHOUxUFiEmJOr7qGWCcOT8XbKDJSRKPglffr
         2JLwxKHmOmKdA6YfiIOevszv/j0DE9DkHPW8LhtkRNbETnqgpfps215kxSxIAuRxK7
         bP8CtIV1A94ZnNhrHXb6jarXmmPPjPo97cuQzy1mc9iH3ZJGHH0Ds7A+Fl+8HXONn/
         ia99eOI2grK/w==
Date:   Wed, 16 Aug 2023 17:33:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, corbet@lwn.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, leah.rumancik@gmail.com, zlang@kernel.org,
        fstests@vger.kernel.org, willy@infradead.org,
        shirley.ma@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/3] docs: add maintainer entry profile for XFS
Message-ID: <20230817003345.GV11377@frogsfrogsfrogs>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
 <20230812000456.GA2375177@frogsfrogsfrogs>
 <CAOQ4uxibnPqE5qG9R53JyaMY1bd6j9OH0pq2eQxYpxDwf3xnGw@mail.gmail.com>
 <ZNwQT80yoHYrjvn+@bombadil.infradead.org>
 <20230816001108.GA1348949@frogsfrogsfrogs>
 <20230816060405.u26tvypmh4tcovef@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816060405.u26tvypmh4tcovef@zlang-mailbox>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:04:05PM +0800, Zorro Lang wrote:
> On Tue, Aug 15, 2023 at 05:11:08PM -0700, Darrick J. Wong wrote:
> > On Tue, Aug 15, 2023 at 04:54:55PM -0700, Luis Chamberlain wrote:
> > > On Sat, Aug 12, 2023 at 12:05:33PM +0300, Amir Goldstein wrote:
> > > > On Sat, Aug 12, 2023 at 3:04 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > >
> > > > > On Fri, Aug 11, 2023 at 12:31:18PM -0700, Luis Chamberlain wrote:
> > > > > > On Tue, Aug 01, 2023 at 12:58:21PM -0700, Darrick J. Wong wrote:
> > > > > > > +Roles
> > > > > > > +-----
> > > > > > > +There are seven key roles in the XFS project.
> > > > > > > +- **Testing Lead**: This person is responsible for setting the test
> > > > > > > +  coverage goals of the project, negotiating with developers to decide
> > > > > > > +  on new tests for new features, and making sure that developers and
> > > > > > > +  release managers execute on the testing.
> > > > > > > +
> > > > > > > +  The testing lead should identify themselves with an ``M:`` entry in
> > > > > > > +  the XFS section of the fstests MAINTAINERS file.
> > 
> >                                     ^^^^^^^^^^^^^^^^^^^
> > > > > >
> > > > > > I think breaking responsibility down is very sensible, and should hopefully
> > > > > > allow you to not burn out. Given I realize how difficult it is to do all
> > > > > > the tasks, and since I'm already doing quite a bit of testing of XFS
> > > > > > on linux-next I can volunteer to help with this task of testing lead
> > > > > > if folks also think it may be useful to the community.
> > > > > >
> > > > > > The only thing is I'd like to also ask if Amir would join me on the
> > > > > > role to avoid conflicts of interest when and if it comes down to testing
> > > > > > features I'm involved in somehow.
> > > > >
> > > > > Good question.  Amir?
> > > > >
> > > > 
> > > > I am more than happy to help, but I don't believe that I currently perform
> > > > or that I will have time to perform the official duties of **Testing
> > > > Lead** role.
> > > > 
> > > > I fully support the nomination of Luis and I think the **Release Manager**
> > > > should be able to resolve any conflict of interests of the **Testing Lead**
> > > > as feature developer should any such conflicts arise :)
> > > 
> > > Fair enough.
> > > 
> > > Darrick, I suppose just one thing then, using M for Testing Lead seems
> > > likely to implicate the 'Testing Lead' getting Cc'd on every single new
> 
> Do you hope to get CC address/list ...
> 
> > > patch. As much as I could help review, I don't think I can commit to
> > > that, and I think that's the point of the current split. To let us split
> > > roles to help scale stuff.
> > 
> > Note that we're talking about "M:" entries in the *fstests* MAINTAINERS
> > file, not the kernel...
> 
> ... from fstests project, for a patch on a linux-$FSTYP project?
> 
> That's weird to me. 

Not for the kernel, no.  Just the contributions to fstests.

For example, if I were sending a patch deluge, the online fsck testing
patches would be cc'd to you; to whomever's listed as M: under XFS in
fstests MAINTAINERS; and fstests@ and linux-xfs@.

The kernel patches would be cc'd to linux-xfs, and to whomever steps up
to review the code (who are we kidding, dchinner).

xfsprogs patches for online fsck would be cc'd to linux-xfs and Carlos.

> 
> > 
> > > So how about a separate new prefix, TL: ? Adding Linus in case he has
> > > a stronger preference to only keep us at one character fist index on
> > > MAINTAINERS.
> > 
> > ...so I'm cc'ing Zorro since he's the owner of the relevant git repo.
> > Hey Zorro, do you have any opinions about how to record who's
> > responsible for each filesystem adding tests for new code and whatnot?
> 
> I think a specific fs test lead is a contributer for that fs project more,
> not for fstests. The test lead need to report test results to that fs
> project, not necessary to report to fstests.

I disagree -- yes, /developers/ (and the release manager) should be
running tests and reporting those results to that fs project.

However, I defined the testing lead (quoting from above):

"**Testing Lead**: This person is responsible for setting the test
coverage goals of the project, negotiating with developers to decide
on new tests for new features, and making sure that developers and
release managers execute on the testing."

In my mind, that means the testing lead should be reviewing changes
proposed for tests/xfs/* in fstests by XFS developers to make sure that
new features are adequately covered; and checking that drive-by
contributions from others fit well with what's already there.

(That's what I thought you wanted out from the people mentioned in the
fstests MAINTAINERS file...)

> And a test lead might do more testing besides fstests. So I can't imagine
> that I need to check another project to learn about who's in charge of the
> current project I'm changing.

...so the testing lead would be the person who you'd talk to directly
about changes that you want to make.

(Wait, who is "I" here?  You, Zorro?  Or were you paraphrasing a
developer?)

--D

> (If I understood anything wrong, please correct me:)
> 
> Thanks,
> Zorro
> 
> > 
> > --D
> > 
> > > 
> > >   Luis
> > 
> 
