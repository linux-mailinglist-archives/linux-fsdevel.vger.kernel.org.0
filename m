Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D72C26CF99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 01:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIPX2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 19:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgIPX2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 19:28:19 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E701CC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 16:28:18 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIgqO-0003ce-NC; Wed, 16 Sep 2020 23:28:08 +0000
Date:   Thu, 17 Sep 2020 00:28:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] fs: Remove duplicated flag O_NDELAY occurring twice
 in VALID_OPEN_FLAGS
Message-ID: <20200916232808.GN3421308@ZenIV.linux.org.uk>
References: <20200906223949.62771-1-kw@linux.com>
 <20200916193500.GA25498@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200916193500.GA25498@rocinante>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:35:00PM +0200, Krzysztof Wilczyński wrote:
> [+CC Andrew]
> 
> Hello,
> 
> Thank you Matthew and Jens for review!
> 
> Andrew, do you think this trivial patch is something that could be
> included?
> 
> I run Coccinelle on a regular basis as part of my build and test process
> when working and this warning shows up there all the time.  I thought,
> it would be nice to put it to rest.

In #work.misc, will be in -next shortly.
