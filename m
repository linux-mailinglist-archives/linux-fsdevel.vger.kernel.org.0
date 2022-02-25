Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837744C4624
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 14:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbiBYNYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 08:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbiBYNYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:24:10 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9245C1FEFAF;
        Fri, 25 Feb 2022 05:23:36 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 21PDN066019228;
        Fri, 25 Feb 2022 14:23:00 +0100
Date:   Fri, 25 Feb 2022 14:23:00 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Byron Stanoszek <gandalf@winds.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220225132300.GC18720@1wt.eu>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
 <20220222221614.GC3061737@dread.disaster.area>
 <3ce45c23-2721-af6e-6cd7-648dc399597@winds.org>
 <YhfzUc8afuoQkx/U@casper.infradead.org>
 <257dc4a9-dfa0-327e-f05a-71c0d9742e98@winds.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <257dc4a9-dfa0-327e-f05a-71c0d9742e98@winds.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:10:22AM -0500, Byron Stanoszek wrote:
> On Thu, 24 Feb 2022, Matthew Wilcox wrote:
> > On Wed, Feb 23, 2022 at 09:48:26AM -0500, Byron Stanoszek wrote:
> > > For what it's worth, I have a number of production servers still using
> > > Reiserfs, which I regularly maintain by upgrading to the latest Linux kernel
> > > annually (mostly to apply security patches). I figured this filesystem would
> > > still be available for several more years, since it's not quite y2038k yet.
> > 
> > Hey Byron, thanks for sharing your usage.
> > 
> > It's not entirely clear to me from your message whether you're aware
> > that our annual LTS release actually puts out new kernels every week (or
> > sometimes twice a week), and upgrades to the latest version are always
> > recommended.  Those LTS kernels typically get five years of support in
> > total; indeed we just retired the v4.4 series earlier this month which
> > was originally released in January 2016, so it got six years of support.
> > 
> > If we dropped reiserfs from the kernel today (and thanks to Edward, we
> > don't have to), you'd still be able to use a v5.15 based kernel with
> > regular updates until 2028.  If we drop it in two years, that should
> > take you through to 2030.  Is that enough for your usage?
> 
> I'm aware of the LTS releases, but I hadn't thought about them in relation to
> this issue. That's a good point, and so it sounds like I have nothing to worry
> about.

This just makes me think that instead of speaking about deprecation in
terms of version, speaking in terms of dates might be more suitable, as
it should help discouraging distros or products shipping LTS kernels
from enabling such deprecated features: when you're told the features
will disappear after, say, 5.20, some might think "OK 5.20 is the last
one and it happens to be LTS so I get the feature for 6 extra years
after it's EOL".

But if instead it's said "will not pass 2023", it's easier to understand
that it must not be shipped anymore even with todays kernels if the
intent is to place them in products for a long time.

Just my two cents,
Willy
