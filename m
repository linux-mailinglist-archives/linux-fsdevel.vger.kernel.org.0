Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF2121E503
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 03:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGNBSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 21:18:17 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:39415 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726364AbgGNBSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 21:18:17 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 6B5E41AC951;
        Tue, 14 Jul 2020 11:18:12 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jv9aF-0001WB-Jg; Tue, 14 Jul 2020 11:18:11 +1000
Date:   Tue, 14 Jul 2020 11:18:11 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: define inode flags using bit numbers
Message-ID: <20200714011811.GJ5369@dread.disaster.area>
References: <20200713030952.192348-1-ebiggers@kernel.org>
 <20200713115947.GX12769@casper.infradead.org>
 <20200713160259.GB1696@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713160259.GB1696@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=7-415B0cAAAA:8
        a=JlbMLqFAMyT0txKuEy8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 09:02:59AM -0700, Eric Biggers wrote:
> On Mon, Jul 13, 2020 at 12:59:47PM +0100, Matthew Wilcox wrote:
> > On Sun, Jul 12, 2020 at 08:09:52PM -0700, Eric Biggers wrote:
> > > Define the VFS inode flags using bit numbers instead of hardcoding
> > > powers of 2, which has become unwieldy now that we're up to 65536.
> > 
> > If you're going to change these, why not use the BIT() macro?
> > 
> 
> Either way would be fine with me, but I've seen people complain about BIT()
> before and say they prefer just (1 << n).

Yup, BIT() is just another layer of largely useless macro
obfuscation that forces readers to do yet another lookup to find out
what it means.  Please don't use it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
