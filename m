Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D848F5B832
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 11:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfGAJlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 05:41:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54375 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbfGAJll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:41:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so15104200wme.4;
        Mon, 01 Jul 2019 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6mj1GNCBlm5Kzl/Gv47qDDxI924Jr5t8ezQS95HGAxE=;
        b=RMrB1vsX/2hK+on0/p7Z7GxznCyEy8+F457kddIrwKQwlCyrQQxmFpdyIB7KPTFSrI
         1UEEwV35Lu1CwDmb2s+W4OV+NkzstIuw8Cc63+MTmhAkrLOTiGJ1qG16J4JvqTAEsrSs
         uZnWKKrQgeqZdO/mh9YOy2EoWVT//ZMAZ8eHGu9m2sZo312GQ3vgDEcVGV8kekxPtJMN
         rv0CFJjViOmLgWPsk0vUPM+G4Qtu0X7i8ze6FzUMeBgTwPapqt1nU/op3JD7L/rym6eB
         LO9RSQlwXNBw4IS2pP/gIgz2ZEOQZYuk+kM5QZ6v7wLL6Ud/9JPtH+DTjO8Md5KsnlAx
         l+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6mj1GNCBlm5Kzl/Gv47qDDxI924Jr5t8ezQS95HGAxE=;
        b=CNtxuFG0C+fodwzzq5WlRxI4eXG8u4oWNxdMbtgVH9eqvjg3qGe5BECdPnlRUwQHOl
         5zPPffl0ZubCXhpFD+PP+biNgkSIrDyMEbgruvTLVtTQKAWiZplQgdS2dLMGR0KyHioL
         0TesIpiz0CRrh47EEDomi3WbSdX2FX5ruq2nNlJHdl08YwgoWwCQP/Xjl6R9L0h3aIDX
         rzzuHEZgXsEBXJCU2jnPN/HaiJK09JtABWgzPqi3JB/v4dD7z41EiAVtiNLRdbjr3c33
         YR3fM0RwSsJaBAo0gmjf0z9OjJ0ohc2OjqwkF8BCyZN91V2yIUKbsjb91pvV2Noo1KrB
         sCRA==
X-Gm-Message-State: APjAAAUPpI1RUfTiCL2xC0BUakC47MacJo+h/dgw7tjbfOFjPCYRshky
        BvC0niR5Pjy6mo1wcrJ6Wa0=
X-Google-Smtp-Source: APXvYqw1GiG2c1p4SOty1AL+8QolpaF03Qeti32qNeBWi0z+owqwU83+3Kt9KKC6JMz4wuXTHDVY/A==
X-Received: by 2002:a1c:3:: with SMTP id 3mr16735741wma.6.1561974098900;
        Mon, 01 Jul 2019 02:41:38 -0700 (PDT)
Received: from [172.22.36.64] (redhat-nat.vtp.fi.muni.cz. [78.128.215.6])
        by smtp.gmail.com with ESMTPSA id 5sm5860353wmi.22.2019.07.01.02.41.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 02:41:38 -0700 (PDT)
Subject: Re: [RFC PATCH v5 0/1] Add dm verity root hash pkcs7 sig validation.
To:     James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, scottsh@microsoft.com, mpatocka@redhat.com
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com>
 <20190628040041.GB673@sol.localdomain>
 <alpine.LRH.2.21.1906282040490.15624@namei.org>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <749ddf56-3cb6-42c8-9ccc-71e09558400f@gmail.com>
Date:   Mon, 1 Jul 2019 11:41:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1906282040490.15624@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/06/2019 06:01, James Morris wrote:
> On Thu, 27 Jun 2019, Eric Biggers wrote:
> 
>> I don't understand your justification for this feature.
>>
>> If userspace has already been pwned severely enough for the attacker to be
>> executing arbitrary code with CAP_SYS_ADMIN (which is what the device mapper
>> ioctls need), what good are restrictions on loading more binaries from disk?
>>
>> Please explain your security model.
> 
> Let's say the system has a policy where all code must be signed with a 
> valid key, and that one mechanism for enforcing this is via signed 
> dm-verity volumes. Validating the signature within the kernel provides 
> stronger assurance than userspace validation. The kernel validates and 
> executes the code, using kernel-resident keys, and does not need to rely 
> on validation which has occurred across a trust boundary.

Yes, but as it is implemented in this patch, a certificate is provided as
a binary blob by the (super)user that activates the dm-verity device.

Actually, I can put there anything that looks like a correct signature (self-signed
or so), and dm-verity code is happy because the root hash is now signed.

Maybe could this concept be extended to support in-kernel compiled certificates?

I like the idea of signed root hash, but the truth is that if you have access
to device activation, it brings nothing, you can just put any cert in the keyring
and use it.

Milan

> 
> You don't need arbitrary CAP_SYS_ADMIN code execution, you just need a 
> flaw in the app (or its dependent libraries, or configuration) which 
> allows signature validation to be bypassed.
> 
> The attacker now needs a kernel rather than a userspace vulnerability to 
> bypass the signed code policy.
> 
