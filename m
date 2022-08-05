Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC558B08E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 21:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbiHETyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 15:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiHETyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:54:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D2E10FFB;
        Fri,  5 Aug 2022 12:54:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id tl27so6800338ejc.1;
        Fri, 05 Aug 2022 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uNNCMzM6wGgvKylIcV8lYZcNxMUBwXushcdpJCRFwXA=;
        b=e6zKPWvo6IkiM49qZMgVKOQWfbZ4SrSe6FffLSmDWP8fLIdlY1yC8OE/wQSvLo7meO
         H+G1B1j8KGTDWa3VYpZ9mL+EiFelSvWjLwXE7DG8n8DQ+D5rzmDidw5gGMSxEtzBTYay
         CLtkEm9skbWSrqajt3PPDuzophplCTD2rEc2ozvNuGxaWnQx2yPBCEFUqeaSi77JFMf/
         Lw2RNp9XxDE8YMazE5oWBsI9D+FoaBUwg1aWZoHlGg3LGNcIATEAW1twLhw3HNGCMwn7
         vwJyZXFiNu98nw+DG5ql1wkGSRaTKJ8FnxsEEAQxBwk2IlQrhE2vSCh672yBPBlGzRGv
         RtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uNNCMzM6wGgvKylIcV8lYZcNxMUBwXushcdpJCRFwXA=;
        b=0RjUpMCrVyar1nwWqr9Ws+duYx/0HXjYpl9Gj+cHR8FF0sGcMPNSQojNtf3pK70SFA
         qUqmfGosMBcTfQX2abSfGkgwx6BfejzYqep4JuGHA2nNREckc5FgtXReQYPvXS0Rprpi
         hjh5/X1mY2DALri16RMatRMSQqhiM1W1yALcAiSCEfUDgOQmK1oKYS3YuSr0StSA/DzV
         fzPh7axUsMX/B61swxVJlULayT+NGaVbO2OZFAmkP3cMtEBZSG9rH3WXGbT0T/AEOa/U
         h4KpqHaH9nDrRB9KyRln2RS0VCX7l3b/8mWRi+rtFnk8qKPv2eOR60BMsOCB2Yj0+Fzh
         nfkw==
X-Gm-Message-State: ACgBeo07GdJoqRg7dh+8WskaxfZe6Nj9naSGF454IgCZEgZZ4KTO8heJ
        7Rb/CIR3ReR+TT2aY3Q++vc=
X-Google-Smtp-Source: AA6agR69gHdIOk66u3DOAUGxbgd3W9IYbjKGJ4TRriMkRlw9SK3I2HFpGUjJDA71iNteqeGQVxRwjg==
X-Received: by 2002:a17:907:2719:b0:730:a5e7:9da7 with SMTP id w25-20020a170907271900b00730a5e79da7mr6558802ejk.26.1659729279246;
        Fri, 05 Aug 2022 12:54:39 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id 2-20020a170906200200b0073100dfa7b0sm947743ejo.8.2022.08.05.12.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 12:54:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <ec3fe997-37d8-22b5-65f1-72f08a16474f@redhat.com>
Date:   Fri, 5 Aug 2022 21:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 08/14] KVM: Rename mmu_notifier_*
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
 <YuQutJAhKWcsrrYl@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YuQutJAhKWcsrrYl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/29/22 21:02, Sean Christopherson wrote:
> If we really want a different name, I'd vote for nomenclature that captures the
> invalidation aspect, which is really what the variables are all trackng, e.g.
> 
>    mmu_invalidate_seq
>    mmu_invalidate_in_progress
>    mmu_invalidate_range_start
>    mmu_invalidate_range_end
> 

Agreed, and this can of course be committed separately if Chao Peng 
sends it outside this series.

Paolo
