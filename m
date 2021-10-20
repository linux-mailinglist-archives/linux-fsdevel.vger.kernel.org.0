Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A95643515E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 19:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhJTRho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhJTRho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:37:44 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5CC061749
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 10:35:29 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so7051294otb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3qdkGS6nWGa6DIGxTkS5kzwbPgDeOBsvHVNSW721MxI=;
        b=48WLfHxpTQLpT0tUgWuSt4zXgmR64ij3Ikm8xUySS4voFZjXDqH/9AA3kqxblwubZa
         OLPsOO2SoGU+5CX+ksD6RkcZhFyMBejnYWIP/4t+clIqrnD/rWsK2UrsqcevALsA5yF4
         Gjee61YE6DP7+kQG48wPdg0EDzZwNaDVIUQROJd2pCP2w5H2olWdul2nZAYLzd51dor2
         xxlfFI4Kf9EJ/0HcBfZOZ9t4GcwolTJNgBDo2Xi1n2aE5UpzpJh7wnF/gkrQfvR41Hks
         9QO+FqYnlm4ugw7sL37KMWtpORpTul7W+y1fk0J/9IGqgka1sAMLFCgk+NulkK2jOBdH
         Yawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3qdkGS6nWGa6DIGxTkS5kzwbPgDeOBsvHVNSW721MxI=;
        b=DwzB/Bu3ybhsQhox3yftlnL1z3MhtiuaYyTXbZUJyyH3dH6a/2Yb5MxxyVQ5Ag6j5N
         J86AOx3/THPxjtqlmNMOLwjkNDqteEyYsBByjx+nMnarj8y0eRiFP/l7yjY9Sxy8ocgr
         5NVX9dpSTFuKQSRpP1ozTElDXTdIJP8kn1/Tz5jS/fVEMxgT6giJjPsSf4pOsWhDh0g/
         PWrGhCbJ3/NkApMnDqEablTITTpeqNfxzl5Q2obxXtKJgdO2MqIHfMoo2BatqhukkMeG
         Zkm4q2NrUdwGrrx6Edwvn1wBq2kHwsE1KyFN2YjLKWCTe0U8smRTTDxEmEHCcaw/fqJ3
         tGhQ==
X-Gm-Message-State: AOAM5329ngVDjuWytIPjpmXewVX7Ek7zCifE6V5kKszlfa7Q4WYgCnH2
        0/zjLKLwhpk+CRKSjZMq8l8e6w==
X-Google-Smtp-Source: ABdhPJwZhE5aOVEBJg+B29uGYRLol/63NjjBsjTMQYekIxgCxYCQsJoWJUZ4yRJhVp+j2vsNKAx3MQ==
X-Received: by 2002:a9d:424:: with SMTP id 33mr512439otc.340.1634751329074;
        Wed, 20 Oct 2021 10:35:29 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id ay42sm566290oib.22.2021.10.20.10.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 10:35:28 -0700 (PDT)
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
 <YXBSLweOk1he8DTO@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe54edc2-da83-6dbb-cfb9-ad3a7fbe3780@kernel.dk>
Date:   Wed, 20 Oct 2021 11:35:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXBSLweOk1he8DTO@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/20/21 11:30 AM, Christoph Hellwig wrote:
> On Wed, Oct 20, 2021 at 10:49:07AM -0600, Jens Axboe wrote:
>> It's not used for anything, and we're wasting time passing in zeroes
>> where we could just ignore it instead. Update all ki_complete users in
>> the kernel to drop that last argument.
>>
>> The exception is the USB gadget code, which passes in non-zero. But
>> since nobody every looks at ret2, it's still pointless.
> 
> Yes, the USB gadget passes non-zero, and aio passes that on to
> userspace.  So this is an ABI change.  Does it actually matter?
> I don't know, but you could CC the relevant maintainers and list
> to try to figure that out.

True, guess it does go out to userspace. Greg, is anyone using
it on the userspace side?

-- 
Jens Axboe

