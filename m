Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247684C525B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 01:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbiBZABX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 19:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiBZABW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:01:22 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8BD1FED87;
        Fri, 25 Feb 2022 16:00:48 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21Q0093w027074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 19:00:10 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9E38515C0038; Fri, 25 Feb 2022 19:00:09 -0500 (EST)
Date:   Fri, 25 Feb 2022 19:00:09 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Willy Tarreau <w@1wt.eu>, Byron Stanoszek <gandalf@winds.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <YhltiUy/WtA0Dz5g@mit.edu>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
 <20220222221614.GC3061737@dread.disaster.area>
 <3ce45c23-2721-af6e-6cd7-648dc399597@winds.org>
 <YhfzUc8afuoQkx/U@casper.infradead.org>
 <257dc4a9-dfa0-327e-f05a-71c0d9742e98@winds.org>
 <20220225132300.GC18720@1wt.eu>
 <20220225225600.GO3061737@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225225600.GO3061737@dread.disaster.area>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 26, 2022 at 09:56:00AM +1100, Dave Chinner wrote:
> 
> Hence we have to acknowledge that fact that once upstream has
> deprecated a feature, it's up to distros to decide how they want to
> handle long term support for that feature. The upstream LTS kernel
> maintainers are going to have to decide on their own policy, too,
> because we cannot bind upstream maintenance decisions on random
> individual downstream support constraints. Downstream has to choose
> for itself how it handles upstream deprecation notices but, that
> said, upstream developers also need to listen to downstream distro
> support and deprecation requirements...

This is as it should be.  It might not make a difference for reiserfs,
where the development efforts is largely dead already, but once
upstream deprecates a feature, the distributions can no longer rely on
upstream developers to fix a critical stability or security bug in
upstream, so it can be backported into an LTS or stable distro kernel.
They are on their own.

The bug might even be fixed in one enterprise distro's kernel product,
but an isolated patch might not be available; only a megapatch of all
of the distro's changes afgainst an upstrema kernel as a single
un-broken-out-and-GPL-compliant patch.  So a critical bugfix present
in one distro release might not be so easily carried over to another
distro.

So that's an important thing to remember; an LTS kernel as a whole
might be "supported" by a stable kernel team from a backports
perspective for years, but that doesn't mean that a deprecated feature
or subsystem is going to be receiving upstream support, and it's fair
that this be advertised so that users and distributions can make their
own decisions about how long they want to use or support a deprecated
feature or subsystem on a downstream basis.

						- Ted
