Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D19224BC4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 16:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgGROVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jul 2020 10:21:45 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43333 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726574AbgGROVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jul 2020 10:21:44 -0400
Received: (qmail 1180182 invoked by uid 1000); 18 Jul 2020 10:21:43 -0400
Date:   Sat, 18 Jul 2020 10:21:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200718142143.GB1179836@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717205340.GR7625@magnolia>
 <20200718005857.GB2183@sol.localdomain>
 <20200718012555.GA1168834@rowland.harvard.edu>
 <20200718020001.GO5369@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718020001.GO5369@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 18, 2020 at 12:00:01PM +1000, Dave Chinner wrote:
> Recipes are aimed at people who simply don't understand any of that
> goobledegook. This won't help them -write correct code-.

Indeed.	 Perhaps this writeup belongs in a different document (with a 
pointer	from the recipes file), and the actual recipe itself should
await the development of a general and robust API.

Alan Stern

