Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4728178C6F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjH2OKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjH2OKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:10:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26068C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 07:09:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 009A668B05; Tue, 29 Aug 2023 16:09:53 +0200 (CEST)
Date:   Tue, 29 Aug 2023 16:09:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: mtd
Message-ID: <20230829140953.GA31558@lst.de>
References: <20230829-weitab-lauwarm-49c40fc85863@brauner> <20230829125118.GA24767@lst.de> <20230829-erzeugen-verruf-6c06640844b0@brauner> <20230829-abkassieren-pizzen-c34ca3731a5c@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829-abkassieren-pizzen-c34ca3731a5c@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:41:04PM +0200, Christian Brauner wrote:
> On Tue, Aug 29, 2023 at 02:57:02PM +0200, Christian Brauner wrote:
> > On Tue, Aug 29, 2023 at 02:51:18PM +0200, Christoph Hellwig wrote:
> > > On Tue, Aug 29, 2023 at 01:46:20PM +0200, Christian Brauner wrote:
> > > > Something like the following might already be enough (IT'S A DRAFT, AND
> > > > UNTESTED, AND PROBABLY BROKEN)?
> > > 
> > > It's probably the right thing conceptually, but it will also need
> > > the SB_I_RETIRED from test_bdev_super_fc or even just reuse
> > > test_bdev_super_fc after that's been renamed to be more generic.
> > 
> > I'll rename it and use it. Let me send a patch.
> 
> Hmkay, how does that look? I think this is a fairly acceptable change
> and looks better than the mtd special-test/set-sauce we currently have:

Looks sensibe to me, but please run it past the MTD maintainers.

