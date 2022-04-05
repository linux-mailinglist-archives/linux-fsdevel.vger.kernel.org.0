Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330D94F4D3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581760AbiDEXkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455100AbiDEP7h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:59:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718421EC620;
        Tue,  5 Apr 2022 08:10:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C418F68AFE; Tue,  5 Apr 2022 17:09:56 +0200 (CEST)
Date:   Tue, 5 Apr 2022 17:09:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: cleanup btrfs bio handling, part 1
Message-ID: <20220405150956.GA16714@lst.de>
References: <20220404044528.71167-1-hch@lst.de> <20220405145626.GY15609@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405145626.GY15609@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:56:26PM +0200, David Sterba wrote:
> On Mon, Apr 04, 2022 at 06:45:16AM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series  moves btrfs to use the new as of 5.18 bio interface and
> > cleans up a few close by areas.  Larger cleanups focussed around
> > the btrfs_bio will follow as a next step.
> 
> I've looked at the previous batch of 40 patches which was doing some
> things I did not like (eg. removing the worker) but this subset are just
> cleanups and all seem to be fine. I'll add the series as topic branch to
> for-next and move misc-next. Thanks.

If it helps can rebase.  And it would be really helpful to start
a discussion on the things you did not like on the patches already
on the list if you have a little time to spare.
