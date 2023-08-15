Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F73377D6D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 01:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbjHOXz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 19:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240740AbjHOXy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:54:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090FB10C0;
        Tue, 15 Aug 2023 16:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=53pnc2yxcXc+KXV/I55bxJTx7WBn5pAtSVIlkFV8mUY=; b=XHCV/ZpwDk4u+jLTpN5cJHDKIb
        zDZVMms3bBbxGtGuO+996Ki7HTCWr0RzeWXmSuNsbnloszKo5LXDDIP7YCdIbN4zetjMFMmdXXUxU
        /ZhDfMOwoAwGq4mC4WHFYJ+a810jM6d9BfIrN6TwnL0d2Sxkif+OOzrFcEKAZKt4R5iuTmUVRdRo0
        xj01gwSNZunPXTuiQnFfQcJ5HOJmYPwX4pGjPstYRP2WydAWvVLBJqBdJpPWiURAUyHOLQZN0tRIK
        V6CjrD2mXxpd9xpCY+EqdB1MVvZW4jO4C+osa0pkUd463tdz9IpOC2n6Hnm1vy6qwyQWJeN15gq6G
        A4pomI8A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qW3sF-002pjP-0R;
        Tue, 15 Aug 2023 23:54:55 +0000
Date:   Tue, 15 Aug 2023 16:54:55 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     corbet@lwn.net, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, cem@kernel.org,
        sandeen@sandeen.net, chandan.babu@oracle.com,
        leah.rumancik@gmail.com, zlang@kernel.org, fstests@vger.kernel.org,
        willy@infradead.org, shirley.ma@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/3] docs: add maintainer entry profile for XFS
Message-ID: <ZNwQT80yoHYrjvn+@bombadil.infradead.org>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
 <20230812000456.GA2375177@frogsfrogsfrogs>
 <CAOQ4uxibnPqE5qG9R53JyaMY1bd6j9OH0pq2eQxYpxDwf3xnGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxibnPqE5qG9R53JyaMY1bd6j9OH0pq2eQxYpxDwf3xnGw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 12, 2023 at 12:05:33PM +0300, Amir Goldstein wrote:
> On Sat, Aug 12, 2023 at 3:04 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, Aug 11, 2023 at 12:31:18PM -0700, Luis Chamberlain wrote:
> > > On Tue, Aug 01, 2023 at 12:58:21PM -0700, Darrick J. Wong wrote:
> > > > +Roles
> > > > +-----
> > > > +There are seven key roles in the XFS project.
> > > > +- **Testing Lead**: This person is responsible for setting the test
> > > > +  coverage goals of the project, negotiating with developers to decide
> > > > +  on new tests for new features, and making sure that developers and
> > > > +  release managers execute on the testing.
> > > > +
> > > > +  The testing lead should identify themselves with an ``M:`` entry in
> > > > +  the XFS section of the fstests MAINTAINERS file.
> > >
> > > I think breaking responsibility down is very sensible, and should hopefully
> > > allow you to not burn out. Given I realize how difficult it is to do all
> > > the tasks, and since I'm already doing quite a bit of testing of XFS
> > > on linux-next I can volunteer to help with this task of testing lead
> > > if folks also think it may be useful to the community.
> > >
> > > The only thing is I'd like to also ask if Amir would join me on the
> > > role to avoid conflicts of interest when and if it comes down to testing
> > > features I'm involved in somehow.
> >
> > Good question.  Amir?
> >
> 
> I am more than happy to help, but I don't believe that I currently perform
> or that I will have time to perform the official duties of **Testing
> Lead** role.
> 
> I fully support the nomination of Luis and I think the **Release Manager**
> should be able to resolve any conflict of interests of the **Testing Lead**
> as feature developer should any such conflicts arise :)

Fair enough.

Darrick, I suppose just one thing then, using M for Testing Lead seems
likely to implicate the 'Testing Lead' getting Cc'd on every single new
patch. As much as I could help review, I don't think I can commit to
that, and I think that's the point of the current split. To let us split
roles to help scale stuff.

So how about a separate new prefix, TL: ? Adding Linus in case he has
a stronger preference to only keep us at one character fist index on
MAINTAINERS.

  Luis
