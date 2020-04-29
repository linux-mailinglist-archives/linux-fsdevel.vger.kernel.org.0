Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AC51BD9B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD2Kfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 06:35:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48893 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2Kfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588156549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7I38cezud3jcFe2VilVY6KvrLd0TQyKG8EvGPUzd8WM=;
        b=UkChOQFdX8u2Fix6ICgwf5Z2CI809vBG5oRQpY4Y/hqQXqol+Cuc46DRv1i5WHv0JYuAqA
        eLEmPonUT3ml/R5HEt8yGVKbFkVFoA6MhG/deUvPy2eZBkvMW/H0HWOD0Iy9JIPPY26ndR
        VrlaqS9CUFC9pcIguEdx2ZqwlmqrdQs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-64EkgNFAMsiVSU9ycl5nVA-1; Wed, 29 Apr 2020 06:35:43 -0400
X-MC-Unique: 64EkgNFAMsiVSU9ycl5nVA-1
Received: by mail-wr1-f71.google.com with SMTP id r17so1495652wrg.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 03:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7I38cezud3jcFe2VilVY6KvrLd0TQyKG8EvGPUzd8WM=;
        b=MbLLeyzKVlLPRLoTG8Gg+iIcT01w9FVGK/Cnn5JiEjU8mogiIDzc1J2781hcc4Olp2
         Hcx6R/1UhIwzny++I9OyhbsrKfGxpyE0dBR1iN0Z+RM9CUQJTokHLhhwZ+HM7CptiKx4
         7QDkDkfBq81ZkGBPnTb1elcDR0I4zCJ/5EtvcM9c8qKyZ4JjktIqkGGRK6YUhKTWjZwE
         7QiLr3RxOnU8SRAZMevCzVNGgD2+CyCVh9OHvdS4YKtokiHZsDuT/tRsX/QxxwPam/cx
         h5avWX2oShUPyI3GYAA1uZ/s2p1HpAoRidWwb0xh0l0FmvtgbDSuv1S+JzU+TE/A6YzW
         EDug==
X-Gm-Message-State: AGi0PubSqoQ+WZz8HIqN44PjwwDOMtK8/Dm3cVuewxPW2DmDDcQ75PKE
        V0CqZSUWiOWeLkXr7GrEp/T+7F3RjtW4K0GfWTFDc4TKAmHIuTHsASxCLUl2vQIJg3JA3tGqhBf
        tZW1MCijXgzMl2qKsYQaD2dqVNA==
X-Received: by 2002:a7b:c927:: with SMTP id h7mr2478540wml.122.1588156542618;
        Wed, 29 Apr 2020 03:35:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKhPa4YOpJ3QAu7oJS5CwDm4v5IZPmdcbPvhgtaB3/fsszG5m6vHj7DV+yRiljDbhI57Kjrrw==
X-Received: by 2002:a7b:c927:: with SMTP id h7mr2478525wml.122.1588156542422;
        Wed, 29 Apr 2020 03:35:42 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id h16sm32873454wrw.36.2020.04.29.03.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 03:35:41 -0700 (PDT)
Subject: Re: [RFC PATCH 5/5] kvm_main: replace debugfs with statsfs
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>, kvm@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mst@redhat.com,
        borntraeger@de.ibm.com
References: <20200427141816.16703-1-eesposit@redhat.com>
 <20200427141816.16703-6-eesposit@redhat.com>
 <2bb5bb1d-deb8-d6cd-498b-8948bae6d848@infradead.org>
 <48259504-7644-43cf-45a2-219981e59a49@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b19a319-1f79-ef06-6aa3-968a6013835f@redhat.com>
Date:   Wed, 29 Apr 2020 12:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <48259504-7644-43cf-45a2-219981e59a49@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/04/20 12:34, Emanuele Giuseppe Esposito wrote:
>>
>>
>> You might want to select STATS_FS here (or depend on it if it is
>> required),
>> or you could provide stubs in <linux/statsfs.h> for the cases of STATS_FS
>> is not set/enabled.
> 
> Currently debugfs is not present in the kvm Kconfig, but implements
> empty stubs as you suggested. I guess it would be a good idea to do the
> same for statsfs.
> 
> Paolo, what do you think?
> 
> Regarding the other suggestions, you are right, I will apply them in v2.

I replied in v2 - basically "imply" STATS_FS here instead of "selecting" it.

Paolo

