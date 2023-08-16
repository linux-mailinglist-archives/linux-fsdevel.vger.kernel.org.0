Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89E577D6F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 02:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbjHPALO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 20:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbjHPALL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194ED1FFF;
        Tue, 15 Aug 2023 17:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB81461DF8;
        Wed, 16 Aug 2023 00:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAD9C433C7;
        Wed, 16 Aug 2023 00:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692144669;
        bh=EzRSGDgzZ8gErsTCdapRiM/o1Hhbl51iCT+MuOD6284=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tl9PXV1XtLet2XdnCXQm7qGWTd4KMWdyPu6GqQU9ARmLIav931qLeZmKeJJMZ4583
         hrG0fle5qMee2KqyZF+GM3/XuCVJfTlHr5VsGJT+JLN4nJ77sljJ31IqNXieYUDz/6
         +RTJ6WlynMZZrIcZTMbi71+iJ5F93voO9dBgKsREHSyEOu/M/RJx8F0lNI12lMC5VK
         9IMyf1RCsL7JCcUGcvDGFjwDUR016vIriX5o2Md3hLt4aPWyd8j9+cNmD0ixQJk6dU
         FqKbYmEq7SpJPLl/79QE5RTbmi/VEN4lCHgFm5hT+TDIRpQZWCEiX3w9SPqvW6Jdwl
         SKZYcxz6FVWcg==
Date:   Tue, 15 Aug 2023 17:11:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, corbet@lwn.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, leah.rumancik@gmail.com, zlang@kernel.org,
        fstests@vger.kernel.org, willy@infradead.org,
        shirley.ma@oracle.com, konrad.wilk@oracle.com,
        Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH 1/3] docs: add maintainer entry profile for XFS
Message-ID: <20230816001108.GA1348949@frogsfrogsfrogs>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
 <20230812000456.GA2375177@frogsfrogsfrogs>
 <CAOQ4uxibnPqE5qG9R53JyaMY1bd6j9OH0pq2eQxYpxDwf3xnGw@mail.gmail.com>
 <ZNwQT80yoHYrjvn+@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNwQT80yoHYrjvn+@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:54:55PM -0700, Luis Chamberlain wrote:
> On Sat, Aug 12, 2023 at 12:05:33PM +0300, Amir Goldstein wrote:
> > On Sat, Aug 12, 2023 at 3:04 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Fri, Aug 11, 2023 at 12:31:18PM -0700, Luis Chamberlain wrote:
> > > > On Tue, Aug 01, 2023 at 12:58:21PM -0700, Darrick J. Wong wrote:
> > > > > +Roles
> > > > > +-----
> > > > > +There are seven key roles in the XFS project.
> > > > > +- **Testing Lead**: This person is responsible for setting the test
> > > > > +  coverage goals of the project, negotiating with developers to decide
> > > > > +  on new tests for new features, and making sure that developers and
> > > > > +  release managers execute on the testing.
> > > > > +
> > > > > +  The testing lead should identify themselves with an ``M:`` entry in
> > > > > +  the XFS section of the fstests MAINTAINERS file.

                                    ^^^^^^^^^^^^^^^^^^^
> > > >
> > > > I think breaking responsibility down is very sensible, and should hopefully
> > > > allow you to not burn out. Given I realize how difficult it is to do all
> > > > the tasks, and since I'm already doing quite a bit of testing of XFS
> > > > on linux-next I can volunteer to help with this task of testing lead
> > > > if folks also think it may be useful to the community.
> > > >
> > > > The only thing is I'd like to also ask if Amir would join me on the
> > > > role to avoid conflicts of interest when and if it comes down to testing
> > > > features I'm involved in somehow.
> > >
> > > Good question.  Amir?
> > >
> > 
> > I am more than happy to help, but I don't believe that I currently perform
> > or that I will have time to perform the official duties of **Testing
> > Lead** role.
> > 
> > I fully support the nomination of Luis and I think the **Release Manager**
> > should be able to resolve any conflict of interests of the **Testing Lead**
> > as feature developer should any such conflicts arise :)
> 
> Fair enough.
> 
> Darrick, I suppose just one thing then, using M for Testing Lead seems
> likely to implicate the 'Testing Lead' getting Cc'd on every single new
> patch. As much as I could help review, I don't think I can commit to
> that, and I think that's the point of the current split. To let us split
> roles to help scale stuff.

Note that we're talking about "M:" entries in the *fstests* MAINTAINERS
file, not the kernel...

> So how about a separate new prefix, TL: ? Adding Linus in case he has
> a stronger preference to only keep us at one character fist index on
> MAINTAINERS.

...so I'm cc'ing Zorro since he's the owner of the relevant git repo.
Hey Zorro, do you have any opinions about how to record who's
responsible for each filesystem adding tests for new code and whatnot?

--D

> 
>   Luis
