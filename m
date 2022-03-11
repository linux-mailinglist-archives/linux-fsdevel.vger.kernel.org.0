Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B934D613C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 13:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiCKMKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 07:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiCKMKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:10:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF669CA71A
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 04:09:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7B2CA210FD;
        Fri, 11 Mar 2022 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647000576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vdV3DuHqMBTtAbK1TqcwTCPXIqDocGGLtoVyAoGrJts=;
        b=exUHZeibHWUHyc1eHnSjRf+ITP00RoJFTBG5C1N+I/0ilFpN5pJAt/qjzyB3bCIk4ApBeV
        /YLI6ZTRPitPxjv9BRTCYTYHYoEbZOeYWjuc8B9M42PwOR0eC3Fg4Go/Z54NIzOrDRoCCm
        v9MBqPHEVuTjIRRYYJblPs1hglc4azA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647000576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vdV3DuHqMBTtAbK1TqcwTCPXIqDocGGLtoVyAoGrJts=;
        b=ifdgwwDzdJTBW3oPoOvifAqK33RiKpF5FDGHpd4Kj0MEEzq9aZkWAjbCSA0g/Y8Di5j0tX
        +A1lIiBSpvHTVIBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4770CA3B8A;
        Fri, 11 Mar 2022 12:09:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C06FCA0611; Fri, 11 Mar 2022 13:09:35 +0100 (CET)
Date:   Fri, 11 Mar 2022 13:09:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20220311120935.ahn6i5a2dtuf4gos@quack3.lan>
References: <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
 <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
 <Yij2rqDn4TiN3kK9@localhost.localdomain>
 <Yij5YTD5+V2qpsSs@bombadil.infradead.org>
 <YikZ2Zy6CtdNQ7WQ@localhost.localdomain>
 <YilUPAGQBPwI0V3n@bombadil.infradead.org>
 <YipIqqiz91D39nMQ@localhost.localdomain>
 <Yip+mh0TY77XfPlc@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yip+mh0TY77XfPlc@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-03-22 14:41:30, Luis Chamberlain wrote:
> On Thu, Mar 10, 2022 at 01:51:22PM -0500, Josef Bacik wrote:
> > On Wed, Mar 09, 2022 at 05:28:28PM -0800, Luis Chamberlain wrote:
> > > On Wed, Mar 09, 2022 at 04:19:21PM -0500, Josef Bacik wrote:
> > > > On Wed, Mar 09, 2022 at 11:00:49AM -0800, Luis Chamberlain wrote:
> > > 
> > > That's great!
> > > 
> > > But although this runs nightly, it seems this runs fstest *once* to
> > > ensure if there are no regressions. Is that right?
> > > 
> > 
> > Yup once per config, so 8 full fstest runs.
> 
> From my experience that is not enough to capture all failures given
> lower failure rates on tests other than 1/1, like 1/42 or
> 1/300. So minimum I'd go for 500 loops of fstests per config.
> This does mean this is not possible nightly though, yes. 5 days
> on average. And so much more work is needed to bring this down
> further.

Well, yes, 500 loops have better chance of detecting rare bugs. But if you
did only say 100 loops, you are likely to detect the bug just 5 days later
on average. Sure that makes finding the bug somewhat harder (you generally
need to investigate larger time span to find the bug) but testing costs are
lower... It is a tradeoff.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
