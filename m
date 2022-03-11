Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80354D6873
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 19:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350911AbiCKSdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 13:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiCKSdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:33:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F11A2607
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 10:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xudai42Cp5jRl00qxrn9d2KlYL2/GMrj/hgYV6hkeFs=; b=NdYjXKOHubFp3Vb0xNDDCgpR6O
        CvCYJ2fV/6201RdSIKv12lltxDtOPAC7vSA4EA6LhT2NLdw64IOMSVYNw1mC4gWDHaXe+ycGmXehM
        OUo4BnisZ0T0LGHIsDnGO3+91VgAFRYOBxMak3DsagXZ6gw26rBMH3riv2DZQ1XZRo79njND/UpHo
        Yy6Un8sUEPbPcCssG4YpE16syffvRpMhXlsyXioOULVzJ0ahipnedHw8he3F/4vU0uVSoOj2LcllO
        t8+6ZiOm3pk75jZQvdyUpXboQ4D/Ffx8RbeRMdm1rgHHdGTwfVwC9G312sJQheS5mL2WtTFO0g/Yg
        f53FKNRQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSk3o-0001Yt-NY; Fri, 11 Mar 2022 18:32:20 +0000
Date:   Fri, 11 Mar 2022 10:32:20 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <YiuVtM232ye4tHde@bombadil.infradead.org>
References: <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
 <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
 <Yij2rqDn4TiN3kK9@localhost.localdomain>
 <Yij5YTD5+V2qpsSs@bombadil.infradead.org>
 <YikZ2Zy6CtdNQ7WQ@localhost.localdomain>
 <YilUPAGQBPwI0V3n@bombadil.infradead.org>
 <YipIqqiz91D39nMQ@localhost.localdomain>
 <Yip+mh0TY77XfPlc@bombadil.infradead.org>
 <20220311120935.ahn6i5a2dtuf4gos@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311120935.ahn6i5a2dtuf4gos@quack3.lan>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 01:09:35PM +0100, Jan Kara wrote:
> On Thu 10-03-22 14:41:30, Luis Chamberlain wrote:
> > On Thu, Mar 10, 2022 at 01:51:22PM -0500, Josef Bacik wrote:
> > > On Wed, Mar 09, 2022 at 05:28:28PM -0800, Luis Chamberlain wrote:
> > > > On Wed, Mar 09, 2022 at 04:19:21PM -0500, Josef Bacik wrote:
> > > > > On Wed, Mar 09, 2022 at 11:00:49AM -0800, Luis Chamberlain wrote:
> > > > 
> > > > That's great!
> > > > 
> > > > But although this runs nightly, it seems this runs fstest *once* to
> > > > ensure if there are no regressions. Is that right?
> > > > 
> > > 
> > > Yup once per config, so 8 full fstest runs.
> > 
> > From my experience that is not enough to capture all failures given
> > lower failure rates on tests other than 1/1, like 1/42 or
> > 1/300. So minimum I'd go for 500 loops of fstests per config.
> > This does mean this is not possible nightly though, yes. 5 days
> > on average. And so much more work is needed to bring this down
> > further.
> 
> Well, yes, 500 loops have better chance of detecting rare bugs. But if you
> did only say 100 loops, you are likely to detect the bug just 5 days later
> on average. Sure that makes finding the bug somewhat harder (you generally
> need to investigate larger time span to find the bug) but testing costs are
> lower... It is a tradeoff.

Crap sorry I had my numbers mixed, yes 100 takes about 5 days (for btrfs
or xfs running all confgurations in parallel), so indeed, 100 was
reasonable goal today. 500 would take almost a month and if that doesn't
give you much time to fix issues either if you have a kernel release per
month!

  Luis
