Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503181C5E44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbgEERCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 13:02:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49591 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730601AbgEERCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 13:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588698161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wA5G//ZMwKX3KXqf3Mv3pq9KAcUMr/otngiqdWE/rQ=;
        b=f4hBZdIT0fUnLr5YIdT3hLEZeAoQrnGo6S+77a3aO79CES/aHHUeGTvBWQrfFvtQYTVTdy
        wc9yr6tDjCKhTzWXaR69f4t4T4CgkwQck7aQr2QX9ozqModWk8pSOQDvSBRWhJODBJkh5W
        e0byfBrLLt4Vh6gywoGnMV4wXiUAmMQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-CDRgv7ZEP0ujQvuwBceb1A-1; Tue, 05 May 2020 13:02:38 -0400
X-MC-Unique: CDRgv7ZEP0ujQvuwBceb1A-1
Received: by mail-wr1-f70.google.com with SMTP id a3so1534231wro.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 10:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5wA5G//ZMwKX3KXqf3Mv3pq9KAcUMr/otngiqdWE/rQ=;
        b=auA41zqnmXqO2eXpC8fX9DmhDDnjAWAcC5VUprVG3xu1iOimcz/ssSmWM2MZCAUc45
         ZyhMpB/ay//RJa+FnFvQfO5I+JiZMt+6/TJM07V1ropXm7y/gZ70Tb/lJAHIrnlc0Rwt
         rjggZIHlS0icjJejwGJYAHXXQhe12sd/tRvr4dasP+7spezIrgq39lQgc55SDBcsWJgQ
         I55D5Ls1Q/wyMx4Kd6Z97FcFpJkj3ZZPNXpz+RDzIwMjPaYrUvnhRmsc+ziKZcJ2vpex
         j3LpSK09VBZHm5q5tMQn7kyAzAF+R94Wy6/uc6JDL+ch8e0CF/SF5uMqXV5pOpd70og9
         wQ6Q==
X-Gm-Message-State: AGi0PuZ7Mkt1rM21zYeXaf6Fvc3MrIIoRMQYPNFZnjm2ZSHrTg9hrAPu
        6eOFpHD4qqrtZt3f85xu6502RyITzUYGa45o6a0viy4/z1vQNFc5RbjL+gcB6ya3g6rAo9+dGVx
        HEuL6O55+8e7W4NzuOiNA/9reww==
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr5096759wrh.410.1588698156838;
        Tue, 05 May 2020 10:02:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypJLNwomNOVHwIvpSDnSwZmv6Omr127dtUlNqUvacYqezIg5AT62IcLqVfdIy2Hep5WWyqsAoA==
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr5096701wrh.410.1588698156541;
        Tue, 05 May 2020 10:02:36 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id g24sm1632241wrb.35.2020.05.05.10.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 10:02:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     Jim Mattson <jmattson@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>,
        kvm list <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20200504110344.17560-1-eesposit@redhat.com>
 <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com>
 <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com>
 <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d12f846-bf89-7b0a-5c71-e61d83b1a36f@redhat.com>
Date:   Tue, 5 May 2020 19:02:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/05/20 18:53, Jim Mattson wrote:
>>> Since this is becoming a generic API (good!!), maybe we can discuss
>>> possible ways to optimize gathering of stats in mass?
>> Sure, the idea of a binary format was considered from the beginning in
>> [1], and it can be done either together with the current filesystem, or
>> as a replacement via different mount options.
> 
> ASCII stats are not scalable. A binary format is definitely the way to go.

I am totally in favor of having a binary format, but it should be
introduced as a separate series on top of this one---and preferably by
someone who has already put some thought into the problem (which
Emanuele and I have not, beyond ensuring that the statsfs concept and
API is flexible enough).

ASCII stats are necessary for quick userspace consumption and for
backwards compatibility with KVM debugfs (which is not an ABI, but it's
damn useful and should not be dropped without providing something as
handy), so this is what this series starts from.

Paolo

