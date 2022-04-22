Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA750B5E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 13:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447006AbiDVLJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 07:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiDVLJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:09:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4BA56231;
        Fri, 22 Apr 2022 04:06:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d6so4892288ede.8;
        Fri, 22 Apr 2022 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3oAXziqhWecaTicJ1TJAzNJot2O+F74s+fvWsJ5jiW0=;
        b=Z3UhoC2SUhjVWlGPrlQSCEy7Q2VUy1KM4Eawia1E0+bVsrQRDiAdB6aIu4tDq2rs+W
         l9URZMyEh1mlY2HNOo0fbW8C4oce1X3bqvloH5MOIvkgz3r2jqhRYvjTsifFBwC26dWz
         5u/OY2dcl/pTD5xnO1Ni/MGueOugkU/ZLsAfbDYl7NqXeIQgGYKNTCcaQywEZyd7ps8i
         bPdq5KKW1neU+1Bd7F3mozZg+0jDg3J3+YRy5LENlRrOK8obiW4Z2YyZ2F6IKRhopHVL
         s1vBPqS9vZo27+goT+fgxRzTty8QEX+Y/XPWBFQacTwOcOmSKZgZtV1qMUX4xQ0CcbVI
         Pjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3oAXziqhWecaTicJ1TJAzNJot2O+F74s+fvWsJ5jiW0=;
        b=35WW3JEk0Ch9VCUkSX+2XJQii8ikhjnI0fNPOHdIkBAw6itnemaVH7P/L3uP9kOHqb
         a4U0KRJI/E24FF+0vVwuSzd9ImjO2CpfRFdt0bv4DEv1st5+dl05W/MLZkouYfRs2w0r
         Gml70pAxkg6b7hmOUKMT110KfbVeryTqtOZn1wLVBrmmTktVt0uCaXblklbrws5WthAf
         17wmxEBXhOT1fJoxC6V1gTQdFFC29jnErJ4A7T6tI6dGhZmWO223BAWVv5PXyyloKuus
         1TUQ7Niy/3UIe54Lhw6J5S6VXx6FlScywVacvz6w3EeTHvQUYaF/7bI7wlRpzFeFjgVr
         VioA==
X-Gm-Message-State: AOAM532YLN8L6k03+p2LxPk2D/PPEDDgJeZiq1fHjIrMg1fN5/nz9RMb
        PeHon/QAgNi0N7Gx8SuSOQo=
X-Google-Smtp-Source: ABdhPJwM5GvWcrt60tN0WmgY/AWsqlmKQqrmRmCB40Mt12b/qqhMcJz2Oau7CJ0N11yndzI6Kklg6g==
X-Received: by 2002:a05:6402:1385:b0:413:2bc6:4400 with SMTP id b5-20020a056402138500b004132bc64400mr4272735edv.94.1650625595094;
        Fri, 22 Apr 2022 04:06:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id x19-20020a05640226d300b004228faf83desm808347edd.12.2022.04.22.04.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 04:06:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <ae7c9c7a-ecda-8c80-751f-f05dbc6489d7@redhat.com>
Date:   Fri, 22 Apr 2022 13:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Quentin Perret <qperret@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Price <steven.price@arm.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
References: <YkQzfjgTQaDd2E2T@google.com> <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com> <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com> <YkyEaYiL0BrDYcZv@google.com>
 <20220422105612.GB61987@chaop.bj.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220422105612.GB61987@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/22/22 12:56, Chao Peng wrote:
>          /* memfile notifier flags */
>          #define MFN_F_USER_INACCESSIBLE   0x0001  /* memory allocated in the file is inaccessible from userspace (e.g. read/write/mmap) */
>          #define MFN_F_UNMOVABLE           0x0002  /* memory allocated in the file is unmovable */
>          #define MFN_F_UNRECLAIMABLE       0x0003  /* memory allocated in the file is unreclaimable (e.g. via kswapd or any other pathes) */

You probably mean BIT(0/1/2) here.

Paolo

>      When memfile_notifier is being registered, memfile_register_notifier will
>      need check these flags. E.g. for MFN_F_USER_INACCESSIBLE, it fails when
>      previous mmap-ed mapping exists on the fd (I'm still unclear on how to do
>      this). When multiple consumers are supported it also need check all
>      registered consumers to see if any conflict (e.g. all consumers should have
>      MFN_F_USER_INACCESSIBLE set). Only when the register succeeds, the fd is
>      converted into a private fd, before that, the fd is just a normal (shared)
>      one. During this conversion, the previous data is preserved so you can put
>      some initial data in guest pages (whether the architecture allows this is
>      architecture-specific and out of the scope of this patch).

