Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3608484294
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 14:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiADNgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 08:36:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229841AbiADNgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641303406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KzTPGW2JymMzrDS1j8vpaZmq1mjrtuWjLdCBriVQUJ8=;
        b=NNhZsLraAT+ZC8RXGIip0dpih8S2p7Wu0F8CSno3gqQu3Dlus/BCFMDTpIx8dEuwkSfvCp
        0m0RjVvot+JEFDzzLpmPI7UWC76HLaVCat9a7pqqXoiQCxYnPmCyIiVhs/3UMXYGqfT+JH
        ZjnoB5OBNSyS45en38WItMpx482yrdo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-XKED4PWpNPKdmhH9m88iaQ-1; Tue, 04 Jan 2022 08:36:45 -0500
X-MC-Unique: XKED4PWpNPKdmhH9m88iaQ-1
Received: by mail-qv1-f69.google.com with SMTP id j8-20020a05621419c800b004115bbe358cso29832730qvc.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jan 2022 05:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KzTPGW2JymMzrDS1j8vpaZmq1mjrtuWjLdCBriVQUJ8=;
        b=SVTh0tQiNwrflHKkQvAhps14qSM1RuQZUhHRiYBNmD4XfcyL7hGA3++THXwKXD1JJY
         ePZB2ygml4CfZzsYnhVwQ4j0WAjEVrWEEy2AM/p+QfegBFIRU/6FwW8oR+8PiSen2XIw
         GDeOG1weXgsRvpl0ByHVFiHkZgxrcUZ+K2miROojY6N+T4pYoNwyjnLKnVHMORqv4lg0
         Ks1OFwx0hG2TjIUTp9uIs82M+DQkEDF2HjjBBmo7+47g7vhrfqF2+Sya+QeCYBgiyReL
         1XjE+/wVdqGJZd8ltsZavAP69qjbKhrSRq4rUdphDgImnLlusJWDZugEpODaOjXbuuCp
         v/AA==
X-Gm-Message-State: AOAM531RfzAHpZSIYs6jeBKBrbno+JFACuWOAGQkfJxPxcSTuMTwn8fX
        Hqg/rwq85Qk9wiXR6fxvn75ZsQJbvUkbCbZJeX1VWkjgCMfm/fiqNhz5PCZ0rEpvA3ti/vyy0pd
        8K/Doi0UJb+uhwVMcsVqxgFCfcQ==
X-Received: by 2002:a37:a716:: with SMTP id q22mr35188714qke.249.1641303405038;
        Tue, 04 Jan 2022 05:36:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzr3X6E0Hb2ZXIDS/jRCm7BkGNJvh1DTGyzsgltkU4PR76XM32hvopdA+7cQ3D59BZXMHh/Ow==
X-Received: by 2002:a37:a716:: with SMTP id q22mr35188706qke.249.1641303404844;
        Tue, 04 Jan 2022 05:36:44 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id 8sm33838927qtz.28.2022.01.04.05.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 05:36:44 -0800 (PST)
Date:   Tue, 4 Jan 2022 08:36:42 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Message-ID: <YdRNasL3WFugVe8c@bfoster>
References: <20211230193522.55520-1-trondmy@kernel.org>
 <Yc5f/C1I+N8MPHcd@casper.infradead.org>
 <6f746786a3928844fbe644e7e409008b4f50c239.camel@hammerspace.com>
 <20220101035516.GE945095@dread.disaster.area>
 <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb964769132eb01ed4e8b67d6972d50ee3387e24.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 01, 2022 at 05:39:45PM +0000, Trond Myklebust wrote:
...
> 
> Fair enough. As long as someone is working on a solution, then I'm
> happy. Just a couple of things:
> 
> Firstly, we've verified that the cond_resched() in the bio loop does
> suffice to resolve the issue with XFS, which would tend to confirm what
> you're saying above about the underlying issue being the ioend chain
> length.
> 
> Secondly, note that we've tested this issue with a variety of older
> kernels, including 4.18.x, 5.1.x and 5.15.x, so please bear in mind
> that it would be useful for any fix to be backward portable through the
> stable mechanism.
> 

I've sent a couple or so different variants of this in the past. The
last I believe was here [1], but still never seemed to go anywhere
(despite having reviews on the first couple patches). That one was
essentially a sequence of adding a cond_resched() call in the iomap code
to address the soft lockup warning followed by capping the ioend size
for latency reasons.

Brian

[1] https://lore.kernel.org/linux-xfs/20210517171722.1266878-1-bfoster@redhat.com/

> 
> Thanks, and Happy New Year!
> 
>   Trond
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 

