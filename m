Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB05F6EE8D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 22:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjDYUKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 16:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbjDYUKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:10:11 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46711CC19
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 13:10:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b781c9787so1861312b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682453408; x=1685045408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXFWJn4u7/1+bAgDkIx/wTD3na4tL+1Z4g1Kyfnv5LQ=;
        b=yvB1KScn+EFF8c78qeutzszgVXxd6YG0QO26KxbVI80WlwrLAfzfYyjviLmxqavaF7
         tLxmQa2kEchUP6INuyDzoRdBSyEIZXRjmSSclOySCSSj/FYphlxXA6euTmS1zvLgtIiu
         r72mNDYv419i8DPPDjese1gvHyTOu72Te0gBVBVPcZ6tK2Si5Nbs/5iG9a9ZP480kU4t
         xGs5bcriLw0A02/+WVtEXriAGSK2Mfpm1KD6/AHXfTUKYenmHM57oRHNO+lzpuFRV8/D
         x7JIjAVkraEfaQJ16lqCmrpCtQ74h2eeANFSdEO1dDTZAe0ffAW7vtiYwdEBTaIXSz6A
         XZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682453408; x=1685045408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXFWJn4u7/1+bAgDkIx/wTD3na4tL+1Z4g1Kyfnv5LQ=;
        b=JJKJ01lFpNs19kqCuow9nwp53vCpKmz8k/Pr07GauRG5FaPgwA+RSwMTDeX2MTUxIw
         rIpza1exOjrGxWOiL3GQ4V7HY7Z0Aq/eLe3GWM7db/o1Jd3ECI8qo/eXIDDG6Fd/gzBF
         2GGm/BM0vskNSEgv927jqDGGpHjtYdTv+bogS6wPVDKc0qiI29MUSGfliVLWeWkmqiEZ
         L3QoL8SZOaJAW4BlOTsKRMPdLxbqar+xIEuYVvNAiqXtSKhlmD4RJ5JlCYTHEOuzvldX
         4c9MAFPu4JL0CZJpYumHZHks9DiZIhgfCV/vTQt35IOJcgeGr6YqwBvAim4jf7sqadTn
         Dbow==
X-Gm-Message-State: AC+VfDx/g9kq3356SN8Pfhy8Wg/IaDzbsG8HKn/mXaXL4CLIwtWp6UHm
        uivPc7Qi8RP4bL2EhJl7oKVIJQ==
X-Google-Smtp-Source: ACHHUZ6pl6b8LVWccx5YX5vT+zZHCTLXlMFV7OlxUx9iWVhtRFcnHiYL24Vmcxw0wXZLnrg4m7VBZQ==
X-Received: by 2002:a17:903:41d1:b0:1a9:8769:3697 with SMTP id u17-20020a17090341d100b001a987693697mr5495214ple.4.1682453407581;
        Tue, 25 Apr 2023 13:10:07 -0700 (PDT)
Received: from ?IPV6:2600:380:4b3d:7b0d:41df:c9d:a913:76eb? ([2600:380:4b3d:7b0d:41df:c9d:a913:76eb])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902bc4500b001a68d613ad9sm8659523plz.132.2023.04.25.13.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 13:10:07 -0700 (PDT)
Message-ID: <bdb6a832-a239-1ce4-d520-d024e0e710e7@kernel.dk>
Date:   Tue, 25 Apr 2023 14:10:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
 <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
 <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk>
 <69ec222c-1b75-cdc1-ac1b-0e9e504db6cb@kernel.dk>
 <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
 <CAHk-=wjSuGTLrmygUSNh==u81iWUtVzJ5GNSz0A-jbr4WGoZyw@mail.gmail.com>
 <20230425194910.GA1350354@hirez.programming.kicks-ass.net>
 <CAHk-=wjNfkT1oVLGbe2=Vymp66Ht=tk+YKa9gUL4T=_hA_JLjg@mail.gmail.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjNfkT1oVLGbe2=Vymp66Ht=tk+YKa9gUL4T=_hA_JLjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/25/23 1:58?PM, Linus Torvalds wrote:
> Jens - I don't think this actually matters for the f_mode value issue,
> since the only thing that might change is that FMODE_NOWAIT bit, but I
> was clearly wrong on READ_ONCE(). So that loop should have it, just to
> have the right pattern after all.

Noted, I'll update it so it's consistent with the other use cases.
Thanks!

-- 
Jens Axboe

