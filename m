Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC87365504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhDTJNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 05:13:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:42996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhDTJNH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:13:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618909955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P/BmEPBKTeOFguvQ2qBlwcHcEEfovS+ifTPNFePUZCk=;
        b=R5GsHcSJibcbHlBRzrzGN94SKJ7cYaMlDSfB2NhAQZy1yVY6Sam2aaojFN8kuuVAmMeJvr
        MmqcwgqtHPe6i8jwmzp+WFbXpe+rwEkxBMmXP6nsLS80NKGRfSKxoHoA5B8kpg0wS40pT4
        AUy/xXjVA7r3cstTCTWGotHbxkta9rM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEF61B4A6;
        Tue, 20 Apr 2021 09:12:34 +0000 (UTC)
Date:   Tue, 20 Apr 2021 11:12:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter.Enderborg@sony.com
Cc:     christian.koenig@amd.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sumit.semwal@linaro.org,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        neilb@suse.de, samitolvanen@google.com, rppt@kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, willy@infradead.org
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <YH6bASnaRIV4DGpI@dhcp22.suse.cz>
References: <c3f0da9c-d127-5edf-dd21-50fd5298acef@sony.com>
 <YH2a9YfRBlfNnF+u@dhcp22.suse.cz>
 <23aa041b-0e7c-6f82-5655-836899973d66@sony.com>
 <d70efba0-c63d-b55a-c234-eb6d82ae813f@amd.com>
 <YH2ru642wYfqK5ne@dhcp22.suse.cz>
 <07ed1421-89f8-8845-b254-21730207c185@amd.com>
 <YH59E15ztpTTUKqS@dhcp22.suse.cz>
 <b89c84da-65d2-35df-7249-ea8edc0bee9b@amd.com>
 <YH6GyThr2mPrM6h5@dhcp22.suse.cz>
 <5efa2b11-850b-ad89-b518-b776247748a4@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5efa2b11-850b-ad89-b518-b776247748a4@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-04-21 09:02:57, Peter.Enderborg@sony.com wrote:
> 
> >> But that isn't really system memory at all, it's just allocated device
> >> memory.
> > OK, that was not really clear to me. So this is not really accounted to
> > MemTotal? If that is really the case then reporting it into the oom
> > report is completely pointless and I am not even sure /proc/meminfo is
> > the right interface either. It would just add more confusion I am
> > afraid.
> >  
> 
> Why is it confusing? Documentation is quite clear:

Because a single counter without a wider context cannot be put into any
reasonable context. There is no notion of the total amount of device
memory usable for dma-buf. As Christian explained some of it can be RAM
based. So a single number is rather pointless on its own in many cases.

Or let me just ask. What can you tell from dma-bud: $FOO kB in its
current form?
-- 
Michal Hocko
SUSE Labs
