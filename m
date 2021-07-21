Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD43D1190
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbhGUOB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 10:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhGUOBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:01:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190DFC061575;
        Wed, 21 Jul 2021 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gYtnqfL5mi01AypapuUeV0QNO83R6S+yM6GrYpNlxlQ=; b=YdkN7hT42xh2IyHLdQeeLSC10Y
        kdXYaAzGnB9fSomoALgFPcW6c30lkQWKOW0gIyj1splapRI4SwQ7+4+Qxxa9/TDXTKNtMYz8sCEEa
        eJkMpNB7ai1U/lH5QEOdUzhJv7QN3Z2p0YfmKXdGkjXdFpV+ff3ELE//wcqCZCVmxQtDu24haMi8z
        51wKLVS0LXbvikpsaLGmjVRr0+yjFJKsMbwpAJS+79Lo1qE2vwYcbJbdjcqSRx1uRHui7L33e3h3e
        A9ghmrL9cTeUbD2XcfwPVZbi4Bjb86J+sMUXgG3cs3a4P0P0EtFOjbNPbo0DT1Qq0n7BGj+6+R08X
        1+hCkJ8w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6DQI-009IMi-3a; Wed, 21 Jul 2021 14:42:16 +0000
Date:   Wed, 21 Jul 2021 15:42:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
Message-ID: <YPgyQsG7PFLL8yE3@infradead.org>
References: <20210721135926.602840-1-nborisov@suse.com>
 <YPgwATAQBfU2eeOk@infradead.org>
 <b1fdda4c-5f2a-a86a-0407-1591229bb241@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1fdda4c-5f2a-a86a-0407-1591229bb241@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 05:35:42PM +0300, Nikolay Borisov wrote:
> 
> 
> On 21.07.21 ??. 17:32, Christoph Hellwig wrote:
> > This seems to have lost the copyright notices from glibc.
> > 
> 
> I copied over only the code, what else needs to be brought up:
> 
>  Copyright (C) 1991-2021 Free Software Foundation, Inc.
>    This file is part of the GNU C Library.
>    Contributed by Torbjorn Granlund (tege@sics.se).
> 
> The rest is the generic GPL license txt ?

Last time I checked glibc is under LGPL.
