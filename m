Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A902434E50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 16:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhJTOzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 10:55:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTOzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:55:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E98501FD39;
        Wed, 20 Oct 2021 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634741601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O8bh/JNAXl0EbyJbdZo/SNAN5DDfXJOs+3Sv4Zhg3O0=;
        b=JNuzYGOdhvILbvr1KUKHON8SPNEtIYfQGJdkWNYg1JDgt0nR62uMVJsWzaoch0RR0SYaSI
        +sne66bRJbe3TmoUNFJipcrvIo7neOd2/V1lwq+pX1HQMCUxHBM3oEG7zQwUiet9EvgJzo
        ZYFX0rKorRDJlOGgEyXwlNpV98Smzj8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3E579A3B83;
        Wed, 20 Oct 2021 14:53:21 +0000 (UTC)
Date:   Wed, 20 Oct 2021 16:53:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YXAtYGLv/k+j6etV@dhcp22.suse.cz>
References: <20211018114712.9802-1-mhocko@kernel.org>
 <20211018114712.9802-3-mhocko@kernel.org>
 <20211019110649.GA1933@pc638.lan>
 <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
 <20211019194658.GA1787@pc638.lan>
 <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
 <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>
 <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>
 <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-10-21 16:29:14, Uladzislau Rezki wrote:
> On Wed, Oct 20, 2021 at 4:06 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > As I've said I am OK with either of the two. Do you or anybody have any
> > preference? Without any explicit event to wake up for neither of the two
> > is more than just an optimistic retry.
> >
> From power perspective it is better to have a delay, so i tend to say
> that delay is better.

I am a terrible random number generator. Can you give me a number
please?
-- 
Michal Hocko
SUSE Labs
