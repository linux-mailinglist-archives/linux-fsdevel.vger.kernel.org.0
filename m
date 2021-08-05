Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCDF3E15B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 15:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbhHENcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 09:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231162AbhHENcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628170315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFeFt1ww8WzoDvTA8B4ID/THa1sBrEwi6JiSRoox5oM=;
        b=UYNe/jicwMop7jWFr8j3AEnGB1jlLJmLNLel8lHczjZGBudnlDBRcMMaLJ5BdrSYphVBad
        coEPIY1VjClyve620cm55Ufb5xdLNlqrK3uimJA1tPcXt9DoXYFPuvbWJXNB5SRnvj6W0H
        AWFnokaf0gfNVaPDr8W0y3cNWuIuvvA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-HeKGuc0xNo2nZLNMjrmpZw-1; Thu, 05 Aug 2021 09:31:54 -0400
X-MC-Unique: HeKGuc0xNo2nZLNMjrmpZw-1
Received: by mail-pj1-f72.google.com with SMTP id z17-20020a17090ad791b029017763b6fe71so5706374pju.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Aug 2021 06:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KFeFt1ww8WzoDvTA8B4ID/THa1sBrEwi6JiSRoox5oM=;
        b=RCzTNQpyAN0rTgkdW0EEMZSFKhPku5kxHckbYjpYz9KBX9GlU7j7FWFl+ykj1a3bir
         F0YfKwTJ1H0HIxgJn2SS+MuLyjkbvzb8cpGw8GdI5Gj7bEvGiHfQjaTHoeBYFPi34CB8
         8O9sjc7LdJapgYFUmist/YjtRKh/P76+wlTd1gvaiY4dg8EpfySbb2aKJWHJ5fZNAtyB
         6SjkxOCcfESGtfDEHhD6sUT12pKs+FsZbdCvBS9bg4zabdArvN9zOoXNOL/vM5NGjJDJ
         lq6AZyMwwMMXxJGVBY1ztjjjhaKRMJMP6P9qsVjx0imVw+ATKgYY10bjjQRvyBiucDvo
         OhCw==
X-Gm-Message-State: AOAM530wENTq24JwpC0lSfAo5sxa/uw+M+2G6Gp/jEctmQlgR33iCljH
        tLzqb1OiYfLGKIiDpWhCYLXzryT3ctucLq0uZ+cDDgF1kdcfWUYXeui79xxXVpsL7ZxghgWiYff
        CPSK628jYPwXs4A4Q/N0neynWmg==
X-Received: by 2002:a65:610c:: with SMTP id z12mr612916pgu.453.1628170312974;
        Thu, 05 Aug 2021 06:31:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweBq6SSyDD2nP+XrrpaLsd2Knf9rcBqrsnAXcXPB8geZ/AllW4llVpLKWNfVfqwtMjCV4ZTA==
X-Received: by 2002:a65:610c:: with SMTP id z12mr612875pgu.453.1628170312586;
        Thu, 05 Aug 2021 06:31:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y67sm6867035pfg.218.2021.08.05.06.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 06:31:52 -0700 (PDT)
Subject: Re: [PATCH v10 01/17] iova: Export alloc_iova_fast() and
 free_iova_fast()
To:     Yongji Xie <xieyongji@bytedance.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Joe Perches <joe@perches.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
        He Zhe <zhe.he@windriver.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, bcrl@kvack.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-2-xieyongji@bytedance.com>
 <43d88942-1cd3-c840-6fec-4155fd544d80@redhat.com>
 <CACycT3vcpwyA3xjD29f1hGnYALyAd=-XcWp8+wJiwSqpqUu00w@mail.gmail.com>
 <6e05e25e-e569-402e-d81b-8ac2cff1c0e8@arm.com>
 <CACycT3sm2r8NMMUPy1k1PuSZZ3nM9aic-O4AhdmRRCwgmwGj4Q@mail.gmail.com>
 <417ce5af-4deb-5319-78ce-b74fb4dd0582@arm.com>
 <CACycT3vARzvd4-dkZhDHqUkeYoSxTa2ty0z0ivE1znGti+n1-g@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8c381d3d-9bbd-73d6-9733-0f0b15c40820@redhat.com>
Date:   Thu, 5 Aug 2021 21:31:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vARzvd4-dkZhDHqUkeYoSxTa2ty0z0ivE1znGti+n1-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/8/5 下午8:34, Yongji Xie 写道:
>> My main point, though, is that if you've already got something else
>> keeping track of the actual addresses, then the way you're using an
>> iova_domain appears to be something you could do with a trivial bitmap
>> allocator. That's why I don't buy the efficiency argument. The main
>> design points of the IOVA allocator are to manage large address spaces
>> while trying to maximise spatial locality to minimise the underlying
>> pagetable usage, and allocating with a flexible limit to support
>> multiple devices with different addressing capabilities in the same
>> address space. If none of those aspects are relevant to the use-case -
>> which AFAICS appears to be true here - then as a general-purpose
>> resource allocator it's rubbish and has an unreasonably massive memory
>> overhead and there are many, many better choices.
>>
> OK, I get your point. Actually we used the genpool allocator in the
> early version. Maybe we can fall back to using it.


I think maybe you can share some perf numbers to see how much 
alloc_iova_fast() can help.

Thanks


>

