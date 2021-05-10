Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BA2379A7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 01:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhEJXP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 19:15:57 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:57754 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhEJXP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 19:15:56 -0400
Received: from dread.disaster.area (pa49-179-143-157.pa.nsw.optusnet.com.au [49.179.143.157])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 5E1B766F4E;
        Tue, 11 May 2021 09:14:48 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lgF6s-00CyeC-E3; Tue, 11 May 2021 09:14:46 +1000
Date:   Tue, 11 May 2021 09:14:46 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 0/3] bcachefs support
Message-ID: <20210510231446.GO1872259@dread.disaster.area>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <YJfvtvBCqA4zU0xf@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJfvtvBCqA4zU0xf@desktop>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=I9rzhn+0hBG9LkCzAun3+g==:117 a=I9rzhn+0hBG9LkCzAun3+g==:17
        a=kj9zAlcOel0A:10 a=5FLXtPjwQuUA:10 a=7-415B0cAAAA:8
        a=JOqBJgaB0zyXXk2ek_AA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 09, 2021 at 10:20:38PM +0800, Eryu Guan wrote:
> On Tue, Apr 27, 2021 at 12:44:16PM -0400, Kent Overstreet wrote:
> > A small patch adding bcachefs support, and two other patches for consideration:
> 
> As bcachefs is not upstream yet, I think we should re-visit bcachefs
> support after it's in upstream.

I disagree completely. I've been waiting for this to land for some
time so I can actually run fstests against bcachefs easily to
evaluate it's current state of stability and support.  The plans are
to get bcachefs merged upstream, and so having support already in
fstests makes it much easier for reviewers and developers to
actually run tests and find problems prior to merging.

As an upstream developer and someone who will be reviewing bcachefs
when it is next proposed for merge,  I would much prefer to see
extensive and long term fstests coverage *before* the code is even
merged upstream. Given that filesystems take years to develop to the
point where they are stable and ready for merge, saying "can't
enable the test environment until it is merged upstream" is not very
helpful.

As a general principle, we want developers of new filesystems to
start using fstests early in the development process of their
filesystem. We should be encouraging new filesystems to be added to
fstests, not saying "we only support upstream filesystems". If the
filesystem plans to be merged upstream, then fstests support for
that filesystem should be there long before the filesytsem is even
proposed for merge.  We need to help people get new filesystems
upstream, not place arbitrary "not upstream so not supported"
catch-22s in their way...

Hence I ask that you merge bcachefs support to help the process of
getting bcachefs suport upstream.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
