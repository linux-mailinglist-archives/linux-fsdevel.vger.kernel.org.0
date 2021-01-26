Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05BE304C48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 23:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbhAZWgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395046AbhAZTHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:07:47 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB241C061793;
        Tue, 26 Jan 2021 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=+LdD4/VTbZAQ6DFaSKzwl0erv/Zz82bmpJz90Y/Ti+E=; b=lXdSsEG2toGD3XVnQM4rlf5HkO
        N4dAirEAHHqP0fEWBn6q+IphMYZIU+5ChKkDt4jkoAaGCtgMF4J/f7VUM0TBH1hZQ7N5E4CC0JKEs
        uSgLip0FeP/6aM+vYhO4o2DlfDMs0tpvf7OPzcnM0cmpPFVtFbM9ZhnJZD8BatvUXcvkyn1judml9
        zrzfVEDdKZ6J9UInWGr8KFjGcomFxBglZM0VZ0UQjlqD7DCgeK4uzRovhUn7YP9Jt211dt6JREiAA
        GFelQZlVe8bz6xRLgUvvM2jbtEXONaZBMUShDmjdvQlFcP6rdHHZCFQgaD3Y9GMmjgzsc8u6bkWio
        q3eJmiqQ==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4Tg7-00027N-Oz; Tue, 26 Jan 2021 19:07:04 +0000
Subject: Re: Getting a new fs in the kernel
To:     Amy Parker <enbyamy@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <767fac1c-3763-2991-37fb-2291246d5464@infradead.org>
Date:   Tue, 26 Jan 2021 11:06:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/21 8:23 AM, Amy Parker wrote:
> Kernel development newcomer here. I've begun creating a concept for a
> new filesystem, and ideally once it's completed, rich, and stable I'd
> try to get it into the kernel.

Ideally you would not wait until it's complete, rich, and stable.
RERO: release early, release often

> What would be the process for this? I'd assume a patch sequence, but
> they'd all be dependent on each other, and sending in tons of
> dependent patches doesn't sound like a great idea. I've seen requests
> for pulls, but since I'm new here I don't really know what to do.
> 
> Thank you for guidance!
> 
> Best regards,
> Amy Parker
> she/her/hers

-- 
~Randy
netiquette: https://people.kernel.org/tglx/notes-about-netiquette
