Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA254101CF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 01:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhIQXgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 19:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhIQXgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:36:47 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D248DC061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 16:35:24 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b64so22637009qkg.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 16:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F8L4H42y086vt8flssxKjNTo0yHfea8YjCpw371YNIc=;
        b=Oc4fx4eeKMreiumWXSObAgriDTvCSAG97eOw5W8tQkgLlrfzqJOcE3CxQiO6dtrkH6
         DYiMdJcdXItfgNJGvKzwMMDGHH8yJ1g8ZwQcZnk51KPjWFgaV/We8MkeYF67r+okOhLK
         hILzWNuHlWVvNS3G49r0Pz3d4alFFzCHzLZpDeRQRzRWAu+DGD9WuZdyxiLRzBtQf8sq
         hWuEqkoSarISEO589xuyIzgaluEycFf0En3/vwgG+BX7n+1H5TTYxYsETpX8Bp2b4QhG
         3+vnRPXh5txp8x1246P8j9PeOpgGEHvXKuyBFFxvSwnECHserUX8mzp9Hx5v4dLSivFO
         omXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F8L4H42y086vt8flssxKjNTo0yHfea8YjCpw371YNIc=;
        b=rZFUp0DNF2jzWSOd5MGrJoJ8qeERJLrpWoVcUTtuWSFWUWGkyWLzBSY8OYH1STIDoK
         CVqtfiCoMdZBsptfB4aJcPEeDpoda5hQlMpzj6npn8HrNDf8GjCsthjoTWsF1EpRVs/l
         PEEV/wyv41KIwC94JSuEuSs4YpBnwI7ta7GhNCGhKM1l1YoN1MvOC+nHGZjgfFlJ9QaB
         Q/KvS5pLjDRFLxkObLSMiVYIbWDW+PoZ9FikbboGm+Q3uJ6/gvXptjrjSjx3sTJkfXO6
         s3SHLQIJEAP+jN2wFjVPDYwaw/HZgYSZJWfCIMozcT9+cfKxDnF4Lih8/8Sx6ZCGJswK
         YZ5g==
X-Gm-Message-State: AOAM533pff10dJDYpPIbemUo0dOj6uwzy75OMqGLuzqTqaiu2CPq3qlh
        z9vM7A1wYdzK0jt5a2cpDQSApA==
X-Google-Smtp-Source: ABdhPJzRPIlfZL3nyByyaMFw8dYegtxhwV0JXYBKliwKQ91GIrI5zSOZPKgkdSEAxb7XW5BeLnZDng==
X-Received: by 2002:a05:620a:214f:: with SMTP id m15mr12984134qkm.59.1631921723552;
        Fri, 17 Sep 2021 16:35:23 -0700 (PDT)
Received: from [192.168.1.211] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l1sm2239686qti.94.2021.09.17.16.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 16:35:22 -0700 (PDT)
Message-ID: <654f9679-8734-3830-2e29-f531eb9aeb0a@toxicpanda.com>
Date:   Fri, 17 Sep 2021 19:35:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: Folio discussion recap
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan> <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia> <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area> <YUTC6O0w3j7i8iDm@cmpxchg.org>
 <YUUE5qB9CW9qiAcN@moria.home.lan> <YUUV3uHhh/PCqXsK@mit.edu>
From:   Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <YUUV3uHhh/PCqXsK@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/17/21 6:25 PM, Theodore Ts'o wrote:
> On Fri, Sep 17, 2021 at 05:13:10PM -0400, Kent Overstreet wrote:
>> Also: it's become pretty clear to me that we have crappy
>> communications between MM developers and filesystem
>> developers.
> 
> I think one of the challenges has been the lack of an LSF/MM since
> 2019.  And it may be that having *some* kind of ad hoc technical
> discussion given that LSF/MM in 2021 is not happening might be a good
> thing.  I'm sure if we asked nicely, we could use the LPC
> infrasutrcture to set up something, assuming we can find a mutually
> agreeable day or dates.
> 

We have a slot for this in the FS MC, first slot actually, so hopefully 
we can get things hashed out there.  Thanks,

Josef
