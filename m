Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F12C7783F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 01:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjHJXHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 19:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHJXHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:07:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E913271B;
        Thu, 10 Aug 2023 16:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9lKsDXdQkaifRDZZ7RHCHDSY4pKO2AXqLM+1ArWC1zY=; b=lxHDnQ6nS/aTsmSIZJ7UWsHvZt
        J1z2xH9c0hgVB4OPu/q8/MAK5CBeBxZlftZwMwE3gfHxBsUiJ1f0CuAnzJe0FY76ygLxdEFsrdPG2
        lc5b0qnOlN4tG3rwwkULhSxn0dBvr/662//9kLBJ55IOmAex3XMsMFWSdCPyx0v+7ZhpAJRJZY8NZ
        k6bl2+49pOyNkZZq8lXBeDSYOctl+AaZjsc54AR5hgkGk9pNw7FMlHwJp5KN2F6YklvAb+/nKZcrg
        B+Jp5B3q5ZJVW2wN//ieU17WwTuhVkhNR+2OWIkk9AX5oiXTu2AenowRwL3REdjdazWUCvHMXghpv
        Xbj+Anxw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUEkc-00FETn-Eo; Thu, 10 Aug 2023 23:07:30 +0000
Date:   Fri, 11 Aug 2023 00:07:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, djwong@kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, josef@toxicpanda.com,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org, axboe@kernel.dk
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZNVtsp4UU9wOa5aI@casper.infradead.org>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:54:53AM -0400, Kent Overstreet wrote:
> Matthew was planning on sending the iov_iter patch to you - right around
> now, I believe, as a bugfix, since right now
> copy_page_from_iter_atomic() silently does crazy things if you pass it a
> compound page.

That's currently sitting in Darrick's iomap tree, commit 908a1ad89466
"iov_iter: Handle compound highmem pages in copy_page_from_iter_atomic()"

It's based on 6.5-rc3, so it would be entirely possible for Darrick
to send Linus a pull request for 908a1ad89466 ... or you could pull
in 908a1ad89466.  I'll talk to Darrick tomorrow.

