Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0486B1CD56B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 11:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgEKJhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 05:37:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39108 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729461AbgEKJhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 05:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589189829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/z8oJy0DrW82NKQzFo0pYOXFvWx+Vn3ieQ420AJ3lc=;
        b=LV3aqOKXrIBDNQmH/4ZuuN9W9zJhhJ5qz4GoLbFt3wB1dfBUjt79oxRz3GYJJb56Aa9cpO
        wJpm+cZFd/R4EErdTft57lByhXQHsoJUOqWkT2W0uPk1nRNJJBc80XufeAC4QQ4rLclk7W
        d0EHDzXEDsfKWuNgI1e4ubpBD0uKq8Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-ur59L0jXMSK0ia6dWrgtEA-1; Mon, 11 May 2020 05:37:05 -0400
X-MC-Unique: ur59L0jXMSK0ia6dWrgtEA-1
Received: by mail-wr1-f72.google.com with SMTP id y7so4957161wrd.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 02:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9/z8oJy0DrW82NKQzFo0pYOXFvWx+Vn3ieQ420AJ3lc=;
        b=nbrmzQH0jbJU/WZKKRE0viMHe3IkDosxaKvRhTGNTBUYkOrqxsnXDVZuDGx5qrnIXp
         XI95N2AbXF/oF4ZAoX7Waj4ZjrvV15+0IDduUthdJ0qLBOFMz2ui/JMhG6NLsGzWfJpP
         /z9qBQYbIks6NxklVEmTBFhHoy/LIECm3UyZ9k1VomisRJ5VKRn6GOnQXhS9mlL3S8Dk
         0QqvXH7FaK+sLCQSSRL+hb/AZOkYpZMlfIG67vnwV0KavIxhDYXuUPjUp0fixeqwevHl
         1pzUiDW5M+vjNFAmyQ0vhmvXW3EfYNTHWdWkzwOOdUuoUvzryX3nHyt0uufBx4vZbI8t
         YLoA==
X-Gm-Message-State: AGi0PuZWheyfA4URUhhnG+xAgQqTdFKOZepYjQw4eHm62iop3rLcRwuC
        Y339ap76tNAEA7szexSG6m6qqpFYu5lMgYRSfbY/SeKRAF03ZvH3knyaQvbA0d+xjPpXH4kFiaE
        MU+SciTS9ajPZm6GOSKy4hmLPcg==
X-Received: by 2002:adf:9447:: with SMTP id 65mr18006259wrq.331.1589189824502;
        Mon, 11 May 2020 02:37:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypLgXJL2J4QG833y891iupVzJ12ZpeHXWlbbAPxxD6jgWVlOjQHWoAXK6Z1hUwl6JqLwXHJL/w==
X-Received: by 2002:adf:9447:: with SMTP id 65mr18006221wrq.331.1589189824311;
        Mon, 11 May 2020 02:37:04 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.159])
        by smtp.gmail.com with ESMTPSA id r14sm1636537wmb.2.2020.05.11.02.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 02:37:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Adams <jwadams@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>
References: <20200504110344.17560-1-eesposit@redhat.com>
 <CA+VK+GN=iDhDV2ZDJbBsxrjZ3Qoyotk_L0DvsbwDVvqrpFZ8fQ@mail.gmail.com>
 <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <20c45f7b-3daa-c300-a8e7-0fd26664080b@redhat.com>
Date:   Mon, 11 May 2020 11:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/8/20 11:44 AM, Paolo Bonzini wrote:
> So in general I'd say the sources/values model holds up.  We certainly
> want to:
> 
> - switch immediately to callbacks instead of the type constants (so that
> core statsfs code only does signed/unsigned)
> 
> - add a field to distinguish cumulative and floating properties (and use
> it to determine the default file mode)
> 
> - add a new argument to statsfs_create_source and statsfs_create_values
> that makes it not create directories and files respectively
> 
> - add a new API to look for a statsfs_value recursively in all the
> subordinate sources, and pass the source/value pair to a callback
> function; and reimplement recursive aggregation and clear in terms of
> this function.

Ok I will apply this, thank you for all the suggestions. 
I will post the v3 patchset in the next few weeks. 

In the meanwhile, I wrote the documentation you asked (even though it's 
going to change in v3), you can find it here:

https://github.com/esposem/linux/commit/dfa92f270f1aed73d5f3b7f12640b2a1635c711f

Thank you,
Emanuele

