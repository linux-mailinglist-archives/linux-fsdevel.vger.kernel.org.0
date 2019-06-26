Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD34561DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 07:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfFZFsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 01:48:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46395 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfFZFsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:48:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so1100845wrw.13;
        Tue, 25 Jun 2019 22:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xQ4ce+x35rsYY2o9p5K+v8CMy5RJxb4zWb9mr9D1IXc=;
        b=EeftxwBtaYqbVh+JKbNLa0DToX40eFgJgREQDo/Uxz1oazpBRVViaNmD/bywZm2urd
         WyXsH6lMSKRlgEwW9IjwloSyLIc9sCvrtIXbkAMQqbWLDm10T8XZ7XyDg5C84HWAlcep
         zh30vyBFsSaFGGLC8KE50rO7+I7UXPD6gvIB3Jbl5jtU3uHqImETrewK4RvWjJIR60wg
         XmjT9UDoAPpSE5N718dNjh88hXhpUFG/Ab6tWgLsW5UxzfeY4xqwdH3/7qtp9CceuWnR
         HEk+afIHsLa6JCjHsx6l7gKtxLz86GLH1Gt0IgR741fovwBbCSb8el95mqNoC7+bxT6v
         RM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xQ4ce+x35rsYY2o9p5K+v8CMy5RJxb4zWb9mr9D1IXc=;
        b=i05syPX1KynMsSyn98A4AHjtan+pszLIgMFQNxC+vMRVQ1IxItzdBoKXNKwxf1FDuK
         hgD0IIQgyNLf2SVuHsFVLJskL/D5DdhZT3T2VeDTltmBMN61L3wsohqEEx0gCaveTuN0
         JWv4rlFdMFsFGHEU8ADPvkQJ5REr5yCJCl0KhIOcvfHRF0Wa2KXk00PXF2lMJtDcTNTJ
         Q7XNe5QYquUzjpqvGFVtEBF6Z9GWyJFrdZuc5WLiT7bFPVk848Ap79Co7XB4sU5CEi8e
         rPtx699+dsX8nrdIm894tB3y6ixUYtFTgjhXl1VWg10kL/zuvlSH5PT/L23PCNfCzRV3
         YNzw==
X-Gm-Message-State: APjAAAVZfTnrvgIod9xz8OJabRWqWzW3p0E7sGtkM1qdrLRIrqylF9KK
        gRfQKWyulIewl3GNt+25YZ4=
X-Google-Smtp-Source: APXvYqzs68nCVLNXdvBtvfphp2c5AsFtEftsuIxWnLsNfPVw3Cgm6bUXIpmze0HkCQry6olx6IzSag==
X-Received: by 2002:adf:c541:: with SMTP id s1mr1760212wrf.44.1561528131040;
        Tue, 25 Jun 2019 22:48:51 -0700 (PDT)
Received: from [10.43.17.24] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a84sm1236284wmf.29.2019.06.25.22.48.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 22:48:50 -0700 (PDT)
Subject: Re: [RFC PATCH v5 1/1] Add dm verity root hash pkcs7 sig validation.
To:     Mike Snitzer <snitzer@redhat.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, scottsh@microsoft.com,
        ebiggers@google.com, jmorris@namei.org, dm-devel@redhat.com,
        mpatocka@redhat.com, agk@redhat.com
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com>
 <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com>
 <20190625182004.GA32075@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <e0cb17cc-35f9-46e2-ca1a-1c942989ed20@gmail.com>
Date:   Wed, 26 Jun 2019 07:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625182004.GA32075@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/06/2019 20:20, Mike Snitzer wrote:
> On Wed, Jun 19 2019 at  3:10pm -0400,
> Jaskaran Khurana <jaskarankhurana@linux.microsoft.com> wrote:
> 
>> The verification is to support cases where the roothash is not secured by
>> Trusted Boot, UEFI Secureboot or similar technologies.
>> One of the use cases for this is for dm-verity volumes mounted after boot,
>> the root hash provided during the creation of the dm-verity volume has to
>> be secure and thus in-kernel validation implemented here will be used
>> before we trust the root hash and allow the block device to be created.
>>
>> The signature being provided for verification must verify the root hash and
>> must be trusted by the builtin keyring for verification to succeed.
>>
>> The hash is added as a key of type "user" and the description is passed to 
>> the kernel so it can look it up and use it for verification.
>>
>> Kernel commandline parameter will indicate whether to check (only if 
>> specified) or force (for all dm verity volumes) roothash signature 
>> verification.
>>
>> Kernel commandline: dm_verity.verify_sig=1 or 2 for check/force root hash
>> signature validation respectively.
>>
>> Signed-off-by: Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
> 
> Milan and/or others: could you please provide review and if you're OK
> with this patch respond accordingly?

Stand by please :)

I like the patch, I think all major problems were solved, but I still need to test it somehow.

Anyway, for the time being, I keep all ongoing patches that need some later
userspace support in my branch
https://git.kernel.org/pub/scm/linux/kernel/git/mbroz/linux.git/log/?h=dm-cryptsetup
so at least it get some automated testing.

Milan

