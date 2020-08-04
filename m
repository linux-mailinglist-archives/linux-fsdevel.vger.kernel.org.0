Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED9823B9BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 13:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgHDLja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 07:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgHDLja (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:39:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C746CC06174A;
        Tue,  4 Aug 2020 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5OKEk1yWwcMO9ZVm/taDjKTVOPCijpI1p0Hz0hqrp+Q=; b=iEq+1ERpd+GE1p0qiEtDJ0bjT4
        mfgfHEUQJpA+k5PjU3BjVGnSPYXNjcQ21giFQybngMmajxGiQh91IzyJ93TUqrQl7idka8aHDE4aw
        Tq9jsWWcADNb4jzBByeKkw3cNjl6I19DjvbQkDTvzqP2btS/f9BN2ZdO0zZSDgEAgywWOOEUVO8RS
        TNNxCcKXRY96cBXFcitkAkmv6p0PSEEWTlUm79aBYsJFl9G1Z6bAZzYbJyhAElRcKYhGa6+qB6Y+q
        2HQBUKZW6/0HrhMjez038a2huu2HTJbEoiwAz4W0KAfxY/Iiexl5H+DrJ7jGanGTFXGOfpn6R2b0/
        j+IgZ2Wg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2vHz-0005eW-8m; Tue, 04 Aug 2020 11:39:27 +0000
Date:   Tue, 4 Aug 2020 12:39:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     nirinA raseliarison <nirina.raseliarison@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/inode.c:531!
Message-ID: <20200804113927.GF23808@casper.infradead.org>
References: <CANsGL8PFnEvBcfLV7eKZQCONoork3EQ7x_RdtkFPXuWZQbK=qg@mail.gmail.com>
 <20200804111913.GA15856@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804111913.GA15856@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 04, 2020 at 01:19:13PM +0200, Jan Kara wrote:
> Hello!
> 
> On Wed 27-05-20 21:05:55, nirinA raseliarison wrote:
> > i hit again this bug with:
> > 
> > $ cat /proc/version
> > Linux version 5.7.0-rc7.20200525 (nirina@supernova.org) (gcc version
> > 10.1.0 (GCC), GNU ld version 2.33.1-slack15) #1 SMP Mon May 25
> > 02:49:28 EAT 2020
> 
> Thanks for report! I see this didn't get any reply. Can you still hit this
> issue with 5.8? If yes, what workload do you run on the machine to trigger
> this? Can you send contents of /proc/mounts please? Thanks!

Also, do you have CONFIG_READ_ONLY_THP_FOR_FS set?
