Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F6E28C935
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390076AbgJMH1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 03:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390045AbgJMH1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602574039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U29b+DpSNEK8t7VlArhSyxRK4Bdvo64dhfMqIFz57jI=;
        b=ZtrkjNy8DBUDvLQXvoXMaWgKifnbn9T9A04znM8rxOuiTYQvCEfAmy9gyDi0cbNzv0Cof7
        ddn2hvlGpxDnnHx/JVPiVBN0B62kZIgu0GSLnqeuRCF1WzUdk95g7UqS0/MX2W/mJdHj2i
        BmaMmHDCh2ScWPlqHPAG6rKxVVU9YpM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-6j4ovxsANOi93uw1eveA8A-1; Tue, 13 Oct 2020 03:27:16 -0400
X-MC-Unique: 6j4ovxsANOi93uw1eveA8A-1
Received: by mail-wr1-f72.google.com with SMTP id f11so10447124wro.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2020 00:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U29b+DpSNEK8t7VlArhSyxRK4Bdvo64dhfMqIFz57jI=;
        b=bw/h6UKxQZY3OtUC4OEVSj0vPu8Z6FJ4PKQn+9aZf0cxFDIp5V9u2iKcBWUIZRaim6
         Syak0sHrecCEWekFfMmdcPl2P9jyAeG04hr2r6ti0g1xvN7eud5STsKFIfbAw9bQe4mm
         uxEs3EhLBVp1i+NJwcVXvStRKjH5Rj9Ee1xbAE7JqberLUiQCQStIr/zSi36E+nsldqK
         +r0xFJHsOkRzOvNHqu9oaW5bJMUyWIyu8/MYCeMP+etdl7P42IQORILdxUygcgV0nHC2
         ChttWZqXVsIfzjtSxEn7zQPwIZo+7QVkETV+S13wiaipe3tvSY3JwyScSZUehWO8CeTT
         mCwA==
X-Gm-Message-State: AOAM532Z/Ieaerwg6atnbkbmm6v6WD2AdnmYH0HQ576DXlG0g4cmeeft
        KgsHN9Clg1p8cMkaXxSmZC+8VBow+AcxhuZaL9f7XlhPpBmlzAe5JkBH27BqErVAxpSuGdm64dL
        nUcB9Q7R7gqjCDXKAbrv2CrDWrw==
X-Received: by 2002:adf:e78b:: with SMTP id n11mr35392302wrm.280.1602574035545;
        Tue, 13 Oct 2020 00:27:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQQxP8+9P0wsLZ02YH3DOZOSRsW9JaGdCw5AWhVTclsuWN0jiwlLQJrBd+Ygaz9BMFlz6mIg==
X-Received: by 2002:adf:e78b:: with SMTP id n11mr35392272wrm.280.1602574035354;
        Tue, 13 Oct 2020 00:27:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:61dd:85cb:23fc:fd54? ([2001:b07:6468:f312:61dd:85cb:23fc:fd54])
        by smtp.gmail.com with ESMTPSA id t124sm27268833wmg.31.2020.10.13.00.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 00:27:14 -0700 (PDT)
Subject: Re: [PATCH 04/35] dmem: let pat recognize dmem
To:     yulei.kernel@gmail.com, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <87e23dfbac6f4a68e61d91cddfdfe157163975c1.1602093760.git.yuleixzhang@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72f4ddeb-157a-808a-2846-dd9961a9c269@redhat.com>
Date:   Tue, 13 Oct 2020 09:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87e23dfbac6f4a68e61d91cddfdfe157163975c1.1602093760.git.yuleixzhang@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/10/20 09:53, yulei.kernel@gmail.com wrote:
> From: Yulei Zhang <yuleixzhang@tencent.com>
> 
> x86 pat uses 'struct page' by only checking if it's system ram,
> however it is not true if dmem is used, let's teach pat to
> recognize this case if it is ram but it is !pfn_valid()
> 
> We always use WB for dmem and any attempt to change this
> behavior will be rejected and WARN_ON is triggered
> 
> Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
> Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>

Hooks like these will make it very hard to merge this series.

I like the idea of struct page-backed memory, but this is a lot of code
and I wonder if it's worth adding all these complications.

One can already use mem= to remove the "struct page" cost for most of
the host memory, and manage the allocation of the remaining memory in
userspace with /dev/mem.  What is the advantage of doing this in the kernel?

Paolo

