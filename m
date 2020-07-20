Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7598A226842
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbgGTQMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:12:38 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44871 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2387992AbgGTQMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:12:37 -0400
Received: (qmail 1236056 invoked by uid 1000); 20 Jul 2020 12:12:36 -0400
Date:   Mon, 20 Jul 2020 12:12:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200720161236.GF1228057@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200718014204.GN5369@dread.disaster.area>
 <20200718140811.GA1179836@rowland.harvard.edu>
 <20200720013320.GP5369@dread.disaster.area>
 <20200720145211.GC1228057@rowland.harvard.edu>
 <20200720153911.GX12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720153911.GX12769@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 04:39:11PM +0100, Matthew Wilcox wrote:
> Honestly, even the term "release semantics" trips me up _every_ time.
> It's a barrier to understanding because I have to translate it into "Oh,
> he means it's like an unlock".  Why can't you just say "unlock semantics"?

It's not as bad as all that; people do talk about acquiring and 
releasing locks, and presumably you don't have any trouble understanding 
those terms.  In fact this usage is quite common -- and I believe it's 
where the names "acquire semantics" and "release semantics" came from 
originally.

Alan Stern
