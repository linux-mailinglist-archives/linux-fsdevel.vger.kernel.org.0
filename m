Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFE5E761C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 10:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiIWIpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 04:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiIWIps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:45:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535F1FFA52;
        Fri, 23 Sep 2022 01:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CFAAB80CB8;
        Fri, 23 Sep 2022 08:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30503C43145;
        Fri, 23 Sep 2022 08:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663922744;
        bh=VOeV0Bwix53e9PcTJ/28Rd0x7ixxeEzA1kmKTwpUcqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmLbn6TwgnLT13CkMX9Wc+c2qkJCWdOSwuPUpW4SlcSMk36qoCzUtorg8PGjZfmLG
         b9e84XCnsS6+WyNCI46ikNItJouIS9S9tD/K6EkrgXAmWNP4Az+IHxzseqvPZIjvUL
         X6Nrg9iNqgKJ8BM4xozc89hG/Jc35CTv94/zBzeC4rC+OJDxa8cy3bU4OmPESFZShr
         YTGDcsSwSGFRZq2YwvqHRJXMm4si7W3CY5xk/mQLaJo5etUtEeopQeHjo/tzTFpJqo
         /NXtnsZrkNfnfHMZNokJd8Wbox4rs1Sun3DTTJJm5WHdC2JsUckuVNbLuB0CWVyT72
         AcqQEfvFIV2Zg==
Date:   Fri, 23 Sep 2022 10:45:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
Message-ID: <20220923084539.vazq4eiceovoclcf@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
 <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:57:38AM -0700, Linus Torvalds wrote:
> On Thu, Sep 22, 2022 at 9:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > Could we please see the entire patch set on the LSM list?
> 
> While I don't think that's necessarily wrong, I would like to point
> out that the gitweb interface actually does make it fairly easy to
> just see the whole patch-set.
> 
> IOW, that
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.acl.rework
> 
> that Christian pointed to is not a horrible way to see it all. Go to
> the top-most commit, and it's easy to follow the parent links.
> 
> It's a bit more work to see them in another order, but I find the
> easiest way is actually to just follow the parent links to get the
> overview of what is going on (reading just the commit messages), and
> then after that you "reverse course" and use the browser back button
> to just go the other way while looking at the details of the patches.
> 
> And I suspect a lot of people are happier *without* large patch-sets
> being posted to the mailing lists when most patches aren't necessarily
> at all relevant to that mailing list except as context.

The problem is also that it's impossible to please both parties here.

A good portion of people doesn't like being flooded with patches they
don't really care about and the other portion gets worked up when they
only see a single patch.

So honestly I just always make a judgement call based on the series. But
b4 makes it so so easy to just retrieve the whole series. So even if I
only receive a single patch and am curious then I just use b4.

I've even got it integrated into mutt directly:

# Pipe message to b4 to download patches and threads
macro index,pager A "<pipe-message>b4 am --apply-cover-trailers --sloppy-trailers --add-my-sob --guess-base --check-newer-revisions --no-cache --quilt-ready <enter>"
macro index,pager M "<pipe-message>b4 mbox <enter>"


