Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E821A320235
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 01:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBTAZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 19:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhBTAZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 19:25:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE3C061574;
        Fri, 19 Feb 2021 16:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=uma69cueETKJpXxHyTVpJUqvNM+Kdy9gT7lHBqE4VnI=; b=my1Mh/+IoZqy3ycJddjtcMEN5/
        aOp9a0+fTS7rXej3UGHh7tiNUT6+kMLEelDWkvdbTQibWo665UgdCE09LIR3NcXGtzB0VeBOEqStY
        tq+h009hpU4Rh+y37tdyc3fjvA1AVbfi+QCcwScyP00ALcs3pIhZgfz7Cm/K0SlrePMwRVPJQVeVB
        VpMs+tiYNC8BFwR+wxNR2rmaaIMvLtqpAUFUJU8lEla1Uav5bvNOjSlIh0Y+C5WZDter5k3QwEBcs
        ypNOEAFuKiJkXI/I8dbxlZwDHbI5dSmVI8e54NCWeBGexNyJoxWJCL2SDElThaAgSBQ8E7cIw2Nii
        ryONexLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDG3z-003REW-79; Sat, 20 Feb 2021 00:24:13 +0000
Date:   Sat, 20 Feb 2021 00:23:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <20210220002359.GY2858050@casper.infradead.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
 <20210218133954.GR2858050@casper.infradead.org>
 <e0faf229-ce7f-70b8-8998-ed7870c702a5@gmx.com>
 <YC/jYW/K9krbfnfl@mit.edu>
 <df225e6c-b70d-fb2d-347c-55efa910cfdd@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df225e6c-b70d-fb2d-347c-55efa910cfdd@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 07:10:14AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/2/20 上午12:12, Theodore Ts'o wrote:
> > On Fri, Feb 19, 2021 at 08:37:30AM +0800, Qu Wenruo wrote:
> > > So it means the 32bit archs are already 2nd tier targets for at least
> > > upstream linux kernel?
> > 
> > At least as far as btrfs is concerned, anyway....
> 
> I'm afraid that would be the case.

btrfs already treats 32-bit arches as second class citizens.
I found a1fbc6750e212c5675a4e48d7f51d44607eb8756 by code inspection,
so clearly it hasn't been tested in five years.  I wouldn't recommend
that anybody use btrfs with a 32-bit kernel.

