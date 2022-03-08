Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085A44D170F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 13:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346631AbiCHMSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 07:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346780AbiCHMSD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:18:03 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A711E43EEC;
        Tue,  8 Mar 2022 04:17:06 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qa43so38708312ejc.12;
        Tue, 08 Mar 2022 04:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OFA2/eM8lwGnQdw8L8HYozWRTs8bN4HRmWhwr7+OpfQ=;
        b=dZxiz91cR9d8+CC4dJkv0i2jFfJ9CP0b3NlEsXD6TPHMGYacNdhru2mSELTl8O+6T+
         FkPBsspyt6yrQV1UNk0fLDyvuyTBbsyYl6/T/V6x+ZilvnI0NzYTKb6PgY7cnu5zGc3W
         z8u6cgybLElr2aEZQqTCU+yd3hjzgyX32dfmIm7l1uFqFRVNXPWDahWbmtxQMKSxUF6t
         mDip2hxkD1fj4trIskXiu0dLQGix1y5LAmHMsfX0r/TW2pyZZX5NoWOICWOAFwOo7IeO
         jpGsIE8IKRoh4awk7E5UsjXtaPmC6jPN5sC8oetFJ5PMyH0bpwZVfBbDUpiUazI2kL/w
         rFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OFA2/eM8lwGnQdw8L8HYozWRTs8bN4HRmWhwr7+OpfQ=;
        b=r0OKZEy++X04LXgPuvGLZAV+xqgFCxlzL6HlMYMJf6JxxF04BeYhNVTU8XzJHIO8nk
         aZgZUXbLfjkjWXfxH8IlCdmW8F8TnOqVjczIF+iVuePU9vbwwSF244Ehvr/8uEROWI/L
         P+Cd8Nsi/7iE8uXREHzZFilsz4L3KlOesSuHvQhesdBNtpx7VQMZNMwdMTfYdQicBXBz
         EUO+8pqg1gLmbpI0OA1F7lwBkgmKDdyQ4tSZwzq0S2WmActedAslT1sAlmVkAOe0LTUz
         3C0PbKqfPbYDP/HCR9xoMprgKFlwBbdR3Bgj8eIRx2J7NOMLyNmL5ySKWRzTneFvIZOc
         AYJg==
X-Gm-Message-State: AOAM533xcSInz+ARxj+U1EvNpk0EEFQc8bJvKhJSrgEVCyMbHaV0G2kT
        Bo/trlK3AEy8vNwwSdMvW1/W9qLbtgY=
X-Google-Smtp-Source: ABdhPJwE9PU5xJ81uImIisWcDcAXQ3ECFtBqwX9p5ItDnR0zlR5H81k8PeGbgOyJEUFk90ZFZol5QQ==
X-Received: by 2002:a17:907:97cc:b0:6da:a8fb:d1db with SMTP id js12-20020a17090797cc00b006daa8fbd1dbmr13315004ejc.267.1646741825187;
        Tue, 08 Mar 2022 04:17:05 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id r19-20020a17090638d300b006d6e4fc047bsm5886872ejd.11.2022.03.08.04.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 04:17:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <800a68f8-fbe0-5980-4290-bdc0ed4d05bd@redhat.com>
Date:   Tue, 8 Mar 2022 13:17:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 01/12] mm/shmem: Introduce F_SEAL_INACCESSIBLE
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Linux API <linux-api@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-2-chao.p.peng@linux.intel.com>
 <619547ad-de96-1be9-036b-a7b4e99b09a6@kernel.org>
 <20220217130631.GB32679@chaop.bj.intel.com>
 <2ca78dcb-61d9-4c9d-baa9-955b6f4298bb@www.fastmail.com>
 <20220223114935.GA53733@chaop.bj.intel.com>
 <71a06402-6743-bfd2-bbd4-997f8e256554@arm.com>
 <7cc65bbd-e323-eabb-c576-b5656a3355ac@kernel.org>
 <20220307132602.GA58690@chaop.bj.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220307132602.GA58690@chaop.bj.intel.com>
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

On 3/7/22 14:26, Chao Peng wrote:
>> In pseudo-Rust, this is the difference between:
>>
>> fn convert_to_private(in: &mut Memfd)
>>
>> and
>>
>> fn convert_to_private(in: Memfd) -> PrivateMemoryFd
>>
>> This doesn't map particularly nicely to the kernel, though.
> I understand this Rust semantics and the difficulty to handle races.
> Probably we should not expose F_SEAL_INACCESSIBLE to userspace, instead
> we can use a new in-kernel flag to indicate the same thing. That flag
> should be set only when the memfd is created with MFD_INACCESSIBLE.

Yes, I like this.

Paolo

