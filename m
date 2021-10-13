Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2E442C951
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 21:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhJMTHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 15:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230313AbhJMTHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634151939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Eiv40w3h1hcVei6B4W9Y1LVqxQiJmLHN86qfNssdwM=;
        b=Qy/MziQgayqH+l0uGP9EP1DuU2JXIcSbRePwSybeZBS30+g6/TjDziLnREp34FNgtVSFeB
        i9HehentJWX90KjTbMr9DvTtVnxeYS/zKPtgCkzq75lBkjyyTrZsYKZiqjmHr3UaoalbkZ
        RXsOUdreW7Kg+XHnI9jN0K3HE+eZwuw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-D2OwmS5HO9CXwTz8BiW2-A-1; Wed, 13 Oct 2021 15:05:35 -0400
X-MC-Unique: D2OwmS5HO9CXwTz8BiW2-A-1
Received: by mail-ed1-f69.google.com with SMTP id e14-20020a056402088e00b003db6ebb9526so3054478edy.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 12:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Eiv40w3h1hcVei6B4W9Y1LVqxQiJmLHN86qfNssdwM=;
        b=0FO0u1HMA21aoOaZt5FedfA/Rz3esxSWWeZTVC/EkDIfW9Bop/XHQoykXFvp8eT7Iv
         UrxAoU9xI6pk0F2Z1CQYPt3Bck/BVQcN9FrizBHLh8gm2EEehnNQ6hcp9+bQYaEi5DEQ
         tb2mocew+34rHLfCRJPd0+y57KypYmX3HwSmAKpr1MZy79QtRXhjqXQI1xPBZxt4F/H/
         LZcmpGuNcVO2Iik3+gB5J+UX4i7hOnU71k/7E2kV3iWOPiB/QkEi1RPcNL7OHTnsspQH
         kG61VV0SikAOpvbS4cjFNWv2S5rjzdkZSgQ7iNWa7ddjJhp+O8B6Q/y9ZSSq6vLiUhhr
         f3Sg==
X-Gm-Message-State: AOAM532Cs75zNBrUSAuIMiuuv9820F1cRs+CsYss68qpjC2QwkPaSSBQ
        oZ5b9U/ZPrQA6r7MDEloDWZZGxOpTVCp5UPvch8b0LpQ0dAwzJR8BMCF4UskyfKSQC5KYVmV7je
        YQy/LH+hXT9lUPBWo6ZOG9+8JDQ==
X-Received: by 2002:a50:bf02:: with SMTP id f2mr1748877edk.226.1634151934610;
        Wed, 13 Oct 2021 12:05:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmcKV0CYPqwd/mDtR926wvJB++ZYNsP6Vx3CrliwDx64dKP6XU/wrZXnneZ49I7EzdutDhVQ==
X-Received: by 2002:a50:bf02:: with SMTP id f2mr1748397edk.226.1634151931214;
        Wed, 13 Oct 2021 12:05:31 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r22sm278778ejd.109.2021.10.13.12.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 12:05:30 -0700 (PDT)
Message-ID: <f430d53f-59cf-a658-a207-1f04adb32c56@redhat.com>
Date:   Wed, 13 Oct 2021 21:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: kvm crash in 5.14.1?
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Stephen <stephenackerman16@gmail.com>
Cc:     djwong@kernel.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, seanjc@google.com, rppt@kernel.org,
        James.Bottomley@hansenpartnership.com, akpm@linux-foundation.org,
        david@redhat.com, hagen@jauu.net
References: <85e40141-3c17-1dff-1ed0-b016c5d778b6@gmail.com>
 <2cd8af17-8631-44b5-8580-371527beeb38@gmail.com>
 <YWcs3XRLdrvyRz31@eldamar.lan>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YWcs3XRLdrvyRz31@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/10/21 21:00, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Sat, Oct 09, 2021 at 12:00:39PM -0700, Stephen wrote:
>>> I'll try to report back if I see a crash; or in roughly a week if the
>> system seems to have stabilized.
>>
>> Just wanted to provide a follow-up here and say that I've run on both
>> v5.14.8 and v5.14.9 with this patch and everything seems to be good; no
>> further crashes or problems.
> 
> In Debian we got a report as well related to this issue (cf.
> https://bugs.debian.org/996175). Do you know did the patch felt
> through the cracks?

Yeah, it's not a KVM patch so the mm maintainers didn't see it.  I'll 
handle it tomorrow.

Paolo

