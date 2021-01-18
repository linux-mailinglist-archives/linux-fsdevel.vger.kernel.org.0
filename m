Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147252F9D8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 12:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbhARLGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 06:06:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:33220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388407AbhARLFn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:05:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56EB9AB7A;
        Mon, 18 Jan 2021 11:04:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9B4401E0816; Mon, 18 Jan 2021 12:04:56 +0100 (CET)
Date:   Mon, 18 Jan 2021 12:04:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [GIT PULL] Fs & udf fixes for v5.11-rc4
Message-ID: <20210118110456.GA19606@quack2.suse.cz>
References: <20210115163917.GH27380@quack2.suse.cz>
 <CAHk-=whTVhOYX5C4TWFrRdAz=QygD0uPDzhLD6sbv2yZfq8+gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTVhOYX5C4TWFrRdAz=QygD0uPDzhLD6sbv2yZfq8+gw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 15-01-21 14:50:25, Linus Torvalds wrote:
> On Fri, Jan 15, 2021 at 8:39 AM Jan Kara <jack@suse.cz> wrote:
> > lianzhi chang (1):
> >       udf: fix the problem that the disc content is not displayed
> 
> What? Hell no.
> 
> This garbage doesn't even build, has never built, and is unbelievable shit.
> 
> Clearly entirely untested, there's an extraneous left-over close
> parens in there.

Bah, sorry. I had more commits in the original branch, then decided to push
only first few. And accidentally a fixup for the bug you've spotted got
mistakenly amended into a later fix that I've decided not to push at this
moment. I'll fix it up.

								Honza 

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
