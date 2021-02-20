Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E53320794
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 00:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBTXDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 18:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhBTXDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 18:03:09 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B992BC061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 15:02:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id c19so5879854pjq.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 15:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zV/zw5La8U3xJZZG8tv4AZYTeBQe18ySz8+OhOD5gZ4=;
        b=YPyD3K4mppLdxQl9wmSUIAjFt/R407AErBjQ/NrshpP93xVVU3l+77eXD9ddBqM2wa
         ab1okMyY081nljcNxh3OzA07rQyPgf1zKzcuHNAhrG7DCW6ZvQxyLz/bN2gMxtvVVWKx
         IeUf/zNuEozKPt3/jkW5xG2IVIlbcar6kjRVjvhERKdjO7vjBohpI4X4p8/pnI0jam4q
         M4gqD6U9fnc58W513SP51gmY60GbXNz2mPKxb4trb5PbqIQF8+5Vr/jwlZRF1VKFhlkC
         Zr43LDuRhkYvEoGFMBjyXmBOC9cq5QMtB/nZQ3QzWE8dNZfoVDwcvsDtKSev1vO9eUtN
         voqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zV/zw5La8U3xJZZG8tv4AZYTeBQe18ySz8+OhOD5gZ4=;
        b=ErNJvlIHz4Fy9f6hUN9k2/2bInqT8FMCwYyhEfcyr1BfZfxm1db/3N7eo2QWducEON
         uYL11nbq3txbGkskKeuymVJxrS11DqFliExDJVvoVvw/cjpjMBndMjPd4pD5Q6DUu4bH
         oTm9VolBdYvMI9DiQ53ZDYvPxBIlKy382OzIAzx79nagfeWhcPSo6UOVJ2h8sdiBhcVw
         AFVOgQuhiyhkgXiDk+NjyFxvyNhmMKP0AcYCUhQpVtuFHgS/PdEU3F0qSGEq2tFHiOgd
         peJwE7/6VY1eFLhPAa5cmOq3x9y6YH+QlJktUNah1umu9hBBYZkSdCUWPOMCJGfNWiOx
         zGtA==
X-Gm-Message-State: AOAM530aNqo2LLfgK0vUHrI0GokSU+seANiQkwx2juGJRlTzMhc08cSa
        1YVXbghXpirnZZ32CuIvgNa2jA==
X-Google-Smtp-Source: ABdhPJwgq+o/Aduf30e5inIM9BrbtyKwNCFWoPTC4kaIRSQ0CVRWFHzYHS3RUVasSfNtnQ3Vu417Xw==
X-Received: by 2002:a17:90a:ae12:: with SMTP id t18mr15958251pjq.92.1613862148230;
        Sat, 20 Feb 2021 15:02:28 -0800 (PST)
Received: from [10.64.183.147] (static-198-54-131-136.cust.tzulo.com. [198.54.131.136])
        by smtp.gmail.com with ESMTPSA id u18sm13152709pfn.11.2021.02.20.15.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Feb 2021 15:02:27 -0800 (PST)
Subject: Re: page->index limitation on 32bit system?
To:     Matthew Wilcox <willy@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
 <20210218133954.GR2858050@casper.infradead.org>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Message-ID: <b3e40749-a30d-521a-904f-8182c6d0e258@rkjnsn.net>
Date:   Sat, 20 Feb 2021 15:02:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218133954.GR2858050@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/18/21 5:39 AM, Matthew Wilcox wrote:
> On Thu, Feb 18, 2021 at 08:42:14PM +0800, Qu Wenruo wrote:
>> [...]
>> BTW, what would be the extra cost by converting page::index to u64?
>> I know tons of printk() would cause warning, but most 64bit systems
>> should not be affected anyway.
> 
> No effect for 64-bit systems, other than the churn.
> 
> For 32-bit systems, it'd have some pretty horrible overhead.  You don't
> just have to touch the page cache, you have to convert the XArray.
> It's doable (I mean, it's been done), but it's very costly for all the
> 32-bit systems which don't use a humongous filesystem.  And we could
> minimise that overhead with a typedef, but then the source code gets
> harder to work with.

Out of curiosity, would it be at all feasible to use 64-bits for the 
page offset *without* changing XArray, perhaps by indexing by the lower 
32-bits, and evicting the page that's there if the top bits don't match 
(vaguely like how the CPU cache works)? Or, if there are cases where a 
page can't be evicted (I don't know if this can ever happen), use chaining?

I would expect index contention to be extremely uncommon, and it could 
only happen for inodes larger than 16 TiB, which can't be used at all 
today. I don't know how many data structures store page offsets today, 
but it seems like this should significantly reduce the performance 
impact versus upping XArray to 64-bit indexes.
