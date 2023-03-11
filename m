Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7633C6B5F5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 18:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCKRsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Mar 2023 12:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKRsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:48:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C20212F;
        Sat, 11 Mar 2023 09:48:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 857A4B8068D;
        Sat, 11 Mar 2023 17:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B6CC433D2;
        Sat, 11 Mar 2023 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678556895;
        bh=RSzduFQhyVUb6pZEQWktjDu19LGDEt6i7EZEYbVq/p0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZD9+2Z3l2NjBfca7dnoo0kBi4bqU/57IS/kOUcnJWl0OYlXusUtcxHeZTEkD/FQc
         OvbmJvOLgar+jaOgc7oNHgzay6vDXKPadWVai4XAgOW3uFeN9hKokAPCK9xKN8grcD
         JvZNsDkXOFlY9GavuDJ0xNm0EwBX20xoZkJdDHA2c3JqcC5NVj0L7bqBDSMCDAfy9h
         6kHUY4oq3pd9ANWasrxNhdjmHuI5EyGneRL4L7TvD0YvZolG4NDeY7k03DLDmxTJeA
         gnShaXmhx7As2wa6GHBlYcjed5dKJsiuOj7/V7AlX8fKkUI8gOPp3sEpon10en6bYn
         XYBc4hMAwFIoQ==
Date:   Sat, 11 Mar 2023 09:48:13 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Sasha Levin <sashal@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: AUTOSEL process
Message-ID: <ZAy+3f1/xfl6dWpI@sol.localdomain>
References: <Y/rufenGRpoJVXZr@sol.localdomain>
 <Y/ux9JLHQKDOzWHJ@sol.localdomain>
 <Y/y70zJj4kjOVfXa@sashalap>
 <Y/zswi91axMN8OsA@sol.localdomain>
 <Y/zxKOBTLXFjSVyI@sol.localdomain>
 <ZATC3djtr9/uPX+P@duo.ucw.cz>
 <ZAewdAql4PBUYOG5@gmail.com>
 <ZAwe95meyCiv6qc4@casper.infradead.org>
 <ZAyK0KM6JmVOvQWy@sashalap>
 <20230311161644.GH860405@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311161644.GH860405@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 11, 2023 at 11:16:44AM -0500, Theodore Ts'o wrote:
> On Sat, Mar 11, 2023 at 09:06:08AM -0500, Sasha Levin wrote:
> > 
> > I suppose that if I had a way to know if a certain a commit is part of a
> > series, I could either take all of it or none of it, but I don't think I
> > have a way of doing that by looking at a commit in Linus' tree
> > (suggestions welcome, I'm happy to implement them).
> 
> Well, this is why I think it is a good idea to have a link to the
> patch series in lore.  I know Linus doesn't like it, claiming it
> doesn't add any value, but I have to disagree.  It adds two bits of
> value.
> 

So, earlier I was going to go into more detail about some of my ideas, before
Sasha and Greg started stonewalling with "patches welcome" (i.e. "I'm refusing
to do my job") and various silly arguments about why nothing should be changed.
But I suppose the worst thing that can happen is that that just continues, so
here it goes:

One of the first things I would do if I was maintaining the stable kernels is to
set up a way to automatically run searches on the mailing lists, and then take
advantage of that in the stable process in various ways.  Not having that is the
root cause of a lot of the issues with the current process, IMO.

Now that lore exists, this might be trivial: it could be done just by hammering
lore.kernel.org with queries https://lore.kernel.org/linux-fsdevel/?q=query from
a Python script.

Of course, there's a chance that won't scale to multiple queries for each one of
thousands of stable commits, or at least won't be friendly to the kernel.org
admins.  In that case, what can be done is to download down all emails from all
lists, using lore's git mirrors or Atom feeds, and index them locally.  (Note:
if the complete history is inconveniently large, then just indexing the last
year or so would work nearly as well.)

Then once that is in place, that could be used in various ways.  For example,
given a git commit, it's possible to search by email subject to get to the
original patch, *even if the git commit does not have a Link tag*.  And it can
be automatically checked whether it's part of a patch series, and if so, whether
all the patches in the series are being backported or just some.

This could also be used to check for mentions of a commit on the mailing list
that potentially indicate a regression report, which is one of the issues we
discussed earlier.  I'm not sure what the optimal search criteria would be, but
one option would be something like "messages that contain the commit title or
commit ID and are dated to after the commit being committed".  There might need
to be some exclusions added to that.

This could also be used to automatically find the AUTOSEL email, if one exists,
and check whether it's been replied to or not.

The purpose of all these mailing list searches would be to generate a list of
potential issues with backporting each commit, which would then undergo brief
human review.  Once issues are reviewed, that state would be persisted, so that
if the script gets run again, it would only show *new* information based on new
mailing list emails that have not already been reviewed.  That's needed because
these issues need to be checked for when the patch is initially proposed for
stable as well as slightly later, before the actual release happens.

If the stable maintainers have no time for doing *any* human review themselves
(again, I do not know what their requirements are on how much time they can
spend per patch), then instead an email with the list of potential issues could
be generated and sent to stable@vger.kernel.org for review by others.

Anyway, that's my idea.  I know the response will be either "that won't work" or
"patches welcome", or a mix of both, but that's it.

- Eric
