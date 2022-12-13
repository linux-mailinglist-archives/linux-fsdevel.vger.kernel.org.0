Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC1A64B1F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 10:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiLMJNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 04:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiLMJMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C52DF61;
        Tue, 13 Dec 2022 01:09:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE4A361416;
        Tue, 13 Dec 2022 09:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC1AC433EF;
        Tue, 13 Dec 2022 09:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670922567;
        bh=8iAi5AH6DG/T/Z7FK7c4S8el98Lz7cVuoKlGLlfITsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgO/pqi0LO7KYxCxvDkwJ8sQqKBvU2YVRrhHQpFxknrxC8cLl1D4C3D23KGgpI0SV
         4FHX3jAXU9/B/G7g6iJ7JE3PuTBpg7XoOezfJVivQR5jw2vGSBwLnVJLtg8UymQ3Yc
         Jlr1+eNCGUyYYF6hXevc7u7UR8fhvfC7gUOIuy9Kwd8GFAD/TpBqscOaK3bzXBQqqU
         dz3+dSN0oxVnA18oGsozy8NFbYWVcv9x5+lFlGeOJAtPZF8fa0L2TVb/r42vZHl8TB
         bEqIEz4qzpn8paRisFkGSQ3tvsfWALUEKJlDafTJpj50wInsvBo8rugVYDfRL0wpd4
         61D7PjJK3mY3g==
Date:   Tue, 13 Dec 2022 10:09:22 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] acl updates for v6.2
Message-ID: <20221213090922.svty4cb4jmkaccgp@wittgenstein>
References: <20221212111919.98855-1-brauner@kernel.org>
 <CAHk-=witvjWrYOqbgURdeH7cv7bkVT5O2wd_HcoY6L-3_3yK8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=witvjWrYOqbgURdeH7cv7bkVT5O2wd_HcoY6L-3_3yK8A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 12, 2022 at 06:56:59PM -0800, Linus Torvalds wrote:
> On Mon, Dec 12, 2022 at 3:19 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> >    For a long and detailed
> > explanation for just some of the issues [1] provides a good summary.
> 
> There is no link [1].
> 
> > A few implementation details:
> >
> > * The series makes sure to retain exactly the same security and integrity module
> >   permission checks. See [2] for annotated callchains.
> 
> There is no link [2].
> 
> This was an extensive changelog for my merge commit, so it's all fine
> and I've pulled it, but it does look like some pieces were either
> missing, or there was a bit of a cut-and-paste from previous
> explanations without the links..

Bah, there was a single stray word "mainline" in the pr after the
/* Conflicts */ section because I copied it over a small (relatively
uninteresting) paragraph.

So the two missing links are:

[1]: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org
[2]: https://gist.github.com/brauner/12c795b93a05dc3b3056b1982549a633

they are also listed in the cover letter for the series.

I think I might need a script to look for missing links in the pull
request. I've had a missing link before. Hopefully I'll get around to
this.

About the cut-and-paste: What follows is just my personal
theory/preference but I think it helps to understand how the pr message
come together. If the series is a self-contained topic and not a
collection of a pile of commits than I aim for the description given in
the cover letter and the description given in the merge/pull request
message to be almost indistinguishable. So the cover letter I keep in
git edit --branch-description will morph into the merge/pull request
message.

So I often will try to write the cover letter in a form that is suitable
for the merge commit. Of course, the cover letter will often contain
additional technical information that might not be suitable for the
cover letter. Such sections will then be cut our or rewritten for the pr
message.

Christian
