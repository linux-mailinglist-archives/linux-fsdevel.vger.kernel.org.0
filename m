Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8A43624C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhJUNDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 09:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230374AbhJUNCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634821213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FfLpJ3QKCtDn5mfQ0p/F6XAIE90YCmZunG7Z1kcvIk4=;
        b=Qbyzui3WjDKdWFvsIKdTPkPi3VC24q9EDlYsSe83ymJ66xr8rFS6cQGdML0zlCA1ab620R
        kA1zbAKjXg2hZpA1ASQdcsKnu1hX8uEfLFI/1H9Mqj+Z0DvxAI6BGGi2Am0hUUtaa2R0s+
        Wcr7/fdXAbiNEnUm6DxNvEp+sTbH+P8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-Op4imp6ANfa3PrPy9ymeDw-1; Thu, 21 Oct 2021 09:00:12 -0400
X-MC-Unique: Op4imp6ANfa3PrPy9ymeDw-1
Received: by mail-wm1-f70.google.com with SMTP id v10-20020a1cf70a000000b00318203a6bd1so290477wmh.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 06:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=FfLpJ3QKCtDn5mfQ0p/F6XAIE90YCmZunG7Z1kcvIk4=;
        b=NGw02h8G+F8Hu7WPuXQ/Zz9prqze33RTE3QLrgfyD1hM8ZJVgsINA+yzCeQmI3oKPb
         ECYhSyJyX/wUQoA47JT456bP46EJnVKxasANgk+uULLBd+sz193NCO40MlTNYaAdFASb
         OEBxsBgMs8M8KYXevH0F4CJnAKpUmVVPET2nOAt3zciaLkLEQnQ4priHPI4S9rilmgzu
         RkoA8QFakjPksYNE5f/+DFcbYfMfuSW3l2rVzQQy6y7YX6lBaCutA0REkdc2JYu/C+4l
         j9hQeTz8RZxoUVgZ7ONOpV1CmmUQXBFDjldzZ+VH76VTFVatQ9VcPfvyaU7Q8oW+FGJ8
         kDMA==
X-Gm-Message-State: AOAM532vWwzrneympvZDxJlxApmW0gNUbfuwD1hTIkoK8MjeWtDgqrQq
        qWCvJCoK04Yl3vGyuL1wmW+uRwplDgL56bPk7g3E6z7lop7mYakoz56usMIM30qkT2Cm9EPJTM3
        RBKpSMQkmpYw78fyJXa8wGs2Fag==
X-Received: by 2002:a7b:c31a:: with SMTP id k26mr5899044wmj.187.1634821211039;
        Thu, 21 Oct 2021 06:00:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyg5aN7cYuw3+jxkmmX4w+oTRT02XFiIXsD9OlC+wd2uOLfvbi5+VSLG7UhWvkO/zaT9gJXkA==
X-Received: by 2002:a7b:c31a:: with SMTP id k26mr5898985wmj.187.1634821210632;
        Thu, 21 Oct 2021 06:00:10 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aba.dip0.t-ipconnect.de. [79.242.58.186])
        by smtp.gmail.com with ESMTPSA id w2sm4851031wrt.31.2021.10.21.06.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 06:00:10 -0700 (PDT)
Message-ID: <90909355-43cd-e680-bb73-777d485ee532@redhat.com>
Date:   Thu, 21 Oct 2021 15:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
References: <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <996b3ac4-1536-2152-f947-aad6074b046a@redhat.com>
 <YXBRPSjPUYnoQU+M@casper.infradead.org>
 <436a9f9c-d5af-7d12-b7d2-568e45ffe0a0@redhat.com>
 <YXEOCIWKEcUOvVtv@infradead.org>
 <f31af20e-245d-a8f1-49fa-e368de9fa95c@redhat.com>
 <YXFXGeYlGFsuHz/T@moria.home.lan>
 <2fc2c5da-c0e9-b954-ba48-e258b88e3271@redhat.com>
 <YXFfRbPUpWUACVm3@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
In-Reply-To: <YXFfRbPUpWUACVm3@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21.10.21 14:38, Christoph Hellwig wrote:
> On Thu, Oct 21, 2021 at 02:35:32PM +0200, David Hildenbrand wrote:
>> My opinion after all the discussions: use a dedicate type with a clear
>> name to solve the immediate filemap API issue. Leave the remainder alone
>> for now. Less code to touch, less subsystems to involve (well, still a
>> lot), less people to upset, less discussions to have, faster review,
>> faster upstream, faster progress. A small but reasonable step.
> 
> I don't get it.  I mean I'm not the MM expert, I've only been touching
> most areas of it occasionally for the last 20 years, but anon and file
> pages have way more in common both in terms of use cases and

You most certainly have way more MM expertise than me ;) I'm just a
random MM developer, so everybody can feel free to just ignore what I'm
saying here. I didn't NACK anything, I just consider a lot of things
that Johannes raised reasonable.

> implementation than what is different (unlike some of the other (ab)uses
> of struct page).  What is the point of splitting it now when there are
> tons of use cases where they are used absolutely interchangable both
> in consumers of the API and the implementation?
I guess in an ideal world, we'd have multiple abstractions. We could
clearly express for a function what type it expects. We'd have a type
for something passed on the filemap API. We'd have a type for anon THP
(or even just an anon page). We'd have a type that abstracts both.

With that in mind, and not planning with what we'll actually end up
with, to me it makes perfect sense to teach the filemap API to consume
the expected type first. And I am not convinced that the folio as is
("not a tail page") is the right abstraction we actually want to pass
around in places where we expect either anon or file pages -- or only
anon pages or only file pages.

Again, my 2 cents.

-- 
Thanks,

David / dhildenb

