Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79245373C31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 15:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhEENSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 09:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231265AbhEENSy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 09:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620220677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtrXxKUiAvmqmB6yyp++vsOaAc/bZaOc4BH5ZWRKiJg=;
        b=cvmkcuvDFybGFr8kCaBP7OyAsXx6GxLLeEPPFx5NqvE90X4NXOnwJQjmYDYdIq0kYrXklr
        QcUvHGaBwQCrf5LkxWj9yRTcTfk4knbXHbYoPYhXCbQVANWAaDUenr/eHo3xPuqdXQ/jYi
        H/1vqS/UGo9c0KCb26PA4WwWvaOAE6k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-PBCMS1qON1apIJk7SGEF4g-1; Wed, 05 May 2021 09:17:56 -0400
X-MC-Unique: PBCMS1qON1apIJk7SGEF4g-1
Received: by mail-wm1-f70.google.com with SMTP id j136-20020a1c238e0000b029014675462236so546712wmj.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 May 2021 06:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QtrXxKUiAvmqmB6yyp++vsOaAc/bZaOc4BH5ZWRKiJg=;
        b=Yy0twF2FsIExTtB80XgdAolejvdn8fWQRw80btz6LEqAOnkIGULxxP0UaGbQHWQ8vM
         WYzvMdNUDk2yIBz5gAID5aGwa1L8lL+NrW0n9GwIUZcmPjblfh5Nn7jTWzUB6sKTC/jG
         JY6ivOZV7N+sol1OgfJmf0ZLfrEl8icagwCwEglvnv+Jpq1kKP9SDTLPlc9fn4thKwlP
         6eqx5kQUrnFKwJfn4souYOBM/tiwbrHIO2W5ExAnt8paFDhGdPMdImuIlE6KrMb/Lg+Q
         q7g/xK5tcx3kYirDbP66VSkJRlYdFNBkiEgtg8+3fJ7SQGdpgchDStKhmbS4qetyowOH
         OM9w==
X-Gm-Message-State: AOAM530OPIB0LUzjBdpRNeLXDiY0VB1Rqawd+uE3EzqULxeeqElWVaDU
        OaFTkFsQ/TAzMtpxY9GTsKVROy1awuoucgbXP1vWriLHPYfh4c/U98IfGfN6vIxF6t8MGR2ytVO
        Ig/BAFJWDRziBV8FGo53yqmgxsQ==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr32277698wmk.25.1620220674944;
        Wed, 05 May 2021 06:17:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznzW0sfSsf6GMPNX1ppZVMk3nl9+IxB31SmKuXCFiIEFbzLjLS3W1tcOolWD10Wc36ulvXeg==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr32277671wmk.25.1620220674718;
        Wed, 05 May 2021 06:17:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63bc.dip0.t-ipconnect.de. [91.12.99.188])
        by smtp.gmail.com with ESMTPSA id v13sm20005354wrt.65.2021.05.05.06.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 06:17:54 -0700 (PDT)
Subject: Re: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-4-david@redhat.com> <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
Date:   Wed, 5 May 2021 15:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.05.21 15:13, Michal Hocko wrote:
> On Thu 29-04-21 14:25:15, David Hildenbrand wrote:
>> Commit d3378e86d182 ("mm/gup: check page posion status for coredump.")
>> introduced page_is_poisoned(), however, v5 [1] of the patch used
>> "page_is_hwpoison()" and something went wrong while upstreaming. Rename the
>> function and move it to page-flags.h, from where it can be used in other
>> -- kcore -- context.
>>
>> Move the comment to the place where it belongs and simplify.
>>
>> [1] https://lkml.kernel.org/r/20210322193318.377c9ce9@alex-virtual-machine
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> I do agree that being explicit about hwpoison is much better. Poisoned
> page can be also an unitialized one and I believe this is the reason why
> you are bringing that up.

I'm bringing it up because I want to reuse that function as state above :)

> 
> But you've made me look at d3378e86d182 and I am wondering whether this
> is really a valid patch. First of all it can leak a reference count
> AFAICS. Moreover it doesn't really fix anything because the page can be
> marked hwpoison right after the check is done. I do not think the race
> is feasible to be closed. So shouldn't we rather revert it?

I am not sure if we really care about races here that much here? I mean, 
essentially we are racing with HW breaking asynchronously. Just because 
we would be synchronizing with SetPageHWPoison() wouldn't mean we can 
stop HW from breaking.

Long story short, this should be good enough for the cases we actually 
can handle? What am I missing?

-- 
Thanks,

David / dhildenb

