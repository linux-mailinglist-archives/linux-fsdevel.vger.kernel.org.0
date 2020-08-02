Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F78235603
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 10:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgHBIfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgHBIfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 04:35:37 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A4FC06174A;
        Sun,  2 Aug 2020 01:35:37 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n2so25146418edr.5;
        Sun, 02 Aug 2020 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HcEorL6RdbpAx3JOgtt0ANHG2Mw6V5cDmG7jSZXjErQ=;
        b=rsRxv5ktA2uYPu/J3dkvpEK88PatuQkRwwgZPtKAW/FUTU1QUxVKa41oxdtLtHF4ed
         Kixc7ev1j3dC9+yaAnrTlN8kWGDE6hkZ6S69pS7Sws6vef6HpP2KzZr9n+m7pK14DWci
         MJOIBXOMV0bFyf4n8ez1EHsfyS6HmD3b00sxJetHokydTWFK5GO9doUIYDmDKmwppPZ4
         dH1ZCkK1kRptjJllr34+GZK0VmoKLj4iQyXwkRdnfyj2GuIypVym51gfGnf16AFym3Ch
         4y0qJ9ebimgXCGlcadgx5fgDz506CloblNtISjFYZ2dxKqL8A1GUjhI/M9wYxLjRW15B
         jYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HcEorL6RdbpAx3JOgtt0ANHG2Mw6V5cDmG7jSZXjErQ=;
        b=jDbEkbFOCXy6Exr0AnANWWIor+5FylErjR9x1GjhiEVx4HI/ylVXlIo2SiOXdnTd78
         vVS2WgXB3mXCU3+aE3aomDAJhXlw6NgvilhqjrVzlm/h9kOa2vM5dOpu4xF+lPDHkM4u
         vWmxbDtxyKVhS0QFYyXSNUw8o+jwFe1CTt6zATWS517eBzJ9u/lITiewSHFTlSf6Pn3Y
         f2KPeMTPupsCLUwo1vJT+ODnHEwbtul/9N07vHF32LogLqsjDIj40cCmJZF40T26phk5
         XBkackg+zNlgsckrXRQ8D6IJT87PG7J6F2sXqHPheVzsUePvTwUcp9xAHA2rmbuPFPzf
         NDyA==
X-Gm-Message-State: AOAM5330pMy7oWf9WeTxh1P+s3G0GXelVyxWnlKU5/9mfS/Jh/qIZCfY
        INO/7Jm7rEKb5g1Sb0bUrAzHrL4v
X-Google-Smtp-Source: ABdhPJxKuWXbDH6KBzOF4BPx7lNPtYkTPWK2gUaJoKmE69CE031jHoQhDJKryobCtWTg0HjncN/e+g==
X-Received: by 2002:a05:6402:1c07:: with SMTP id ck7mr2646288edb.84.1596357336113;
        Sun, 02 Aug 2020 01:35:36 -0700 (PDT)
Received: from [192.168.43.215] ([5.100.193.69])
        by smtp.gmail.com with ESMTPSA id u13sm12757925ejc.72.2020.08.02.01.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 01:35:35 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e523f51f59ad6ecdad4ad22c560cb9c913e96e1a.1596277420.git.asml.silence@gmail.com>
 <20200801153711.GV23808@casper.infradead.org>
 <debd12e1-8ba5-723d-75ad-47af99db05a0@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] fs: optimise kiocb_set_rw_flags()
Message-ID: <48d1c305-6302-daaf-9153-8cdc85911a88@gmail.com>
Date:   Sun, 2 Aug 2020 11:33:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <debd12e1-8ba5-723d-75ad-47af99db05a0@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/08/2020 20:01, Jens Axboe wrote:
> On 8/1/20 9:37 AM, Matthew Wilcox wrote:
>> On Sat, Aug 01, 2020 at 01:36:33PM +0300, Pavel Begunkov wrote:
>>> Use a local var to collect flags in kiocb_set_rw_flags(). That spares
>>> some memory writes and allows to replace most of the jumps with MOVEcc.
>>>
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>
>> If you want to improve the codegen here further, I would suggest that
>> renumbering the IOCB flags to match the RWF flags would lead to better
>> codegen (can't do it the other way around; RWF flags are userspace ABI,
>> IOCB flags are not).  iocb_flags() probably doesn't get any worse because
>> the IOCB_ flags don't have the same numbers as the O_ bits (which differ
>> by arch anyway).
> 
> Yeah that's not a bad idea, would kill a lot of branches.

Is that common here to do so? I've done this for io_uring flags a while
ago, but left RWF alone at the time, reluctant to check for possible
complications (e.g. bit magic).

-- 
Pavel Begunkov
