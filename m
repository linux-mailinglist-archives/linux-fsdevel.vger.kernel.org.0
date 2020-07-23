Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8D122B14C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 16:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgGWO1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 10:27:39 -0400
Received: from verein.lst.de ([213.95.11.211]:60460 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgGWO1i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:27:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 146E468AFE; Thu, 23 Jul 2020 16:27:35 +0200 (CEST)
Date:   Thu, 23 Jul 2020 16:27:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 16/23] initramfs: simplify clean_rootfs
Message-ID: <20200723142734.GA11080@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-17-hch@lst.de> <CGME20200717205549eucas1p13fca9a8496836faa71df515524743648@eucas1p1.samsung.com> <7f37802c-d8d9-18cd-7394-df51fa785988@samsung.com> <20200718100035.GA8856@lst.de> <20200723092200.GA19922@lst.de> <dleftjblk6b95t.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dleftjblk6b95t.fsf%l.stelmach@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 23, 2020 at 04:25:34PM +0200, Lukasz Stelmach wrote:
> >> Can you comment out the call to d_genocide?  It seems like for your
> >> the fact that clean_rootfs didn't actually clean up was a feature and
> >> not a bug.
> >> 
> >> I guess the old, pre-2008 code also wouldn't have worked for you in
> >> that case.
> >
> > Did you get a chance to try this?
> 
> Indeed, commenting out d_genocide() helps.

So given that people have relied on at least the basic device nodes
like /dev/console to not go away since 2008, I wonder if we should just
remove clean_rootfs entirely

Linus, Al?
