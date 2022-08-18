Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DCF598093
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 11:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiHRJJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239788AbiHRJJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:09:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825C877554;
        Thu, 18 Aug 2022 02:09:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id qn6so2045907ejc.11;
        Thu, 18 Aug 2022 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=OM28IoofemszvZBGCPnenf9hx1PitiC3j3mv8pJzzLY=;
        b=ij1yc1LQl9Wf3pW5R1RqykES0Aufpt68J+25lcVedl/CpmlFqJG/3XGLjyW2MHoLNc
         RATABqbitRRkNkbzTUPBN+b00N4M50Y7j/0ODEeCK4DJ1JxY6f4rpDPPWv/L1cl0a3G9
         sAXVvVEsJtSRSRthDDyQtU3BfZ7y/6/7XEt+z2ltD4pkwWTqhWOhuCsB62txeENhXVbe
         +mMm1pX2BJT/74i8I6amFdoHLlwihES/nKklvXI3VtoaDAYi9ugEu++7ZTBVUoALiTH9
         N3WC3/Fq94Hur7bPMP7JJwb2EwBBorftYgTT0A/a/fS4RdJtnmRaHQgCu7FbcBd3pI8j
         XqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=OM28IoofemszvZBGCPnenf9hx1PitiC3j3mv8pJzzLY=;
        b=Ur+Y5w8CIy2R+TI7ezdwfcFFtZ4jLiQEotfBsJDRmg/AeDHzwsE4lVmNt5ZvNeFURh
         VZDMXF5QglDz0nFe/MQYh4P379YwKCcZm56QTXMWhLNT8jotoHs+h/HPsrJ8mA6doT+W
         KypirXTBqp5eD9RyS3wtD27RRx/oDWQfNWVjB97GDFvwY7Q0LRhTWMX0EqpFCdreQuDe
         bY7u1/FpZXY9DWj8isgUhyoL2PlmNBTaW33NRlsnxAbKnPVmh2gDAIL92wp1MFogMuc9
         rWuzqwZY5Rh4jDeF3JifWsbusWQ5q7IOkFLUm0JhSpElYjHLWbMo8qClM6hfDIvgYWxR
         5rIg==
X-Gm-Message-State: ACgBeo0GoZFikspsPdGJUjmF/NpkilsqH4f3B5TF0fpn7BzOwRZHwY/q
        QBLSYOImrwE9BuvxdF4BOek=
X-Google-Smtp-Source: AA6agR7J/9/o1YBQevKgS2HfGCsS2gahP6q9ngCobHspK0yQln3/vemjVdtjZipLOMqNIx4sDBaa7Q==
X-Received: by 2002:a17:907:a057:b0:730:a2d8:d5ac with SMTP id gz23-20020a170907a05700b00730a2d8d5acmr1327595ejc.764.1660813795048;
        Thu, 18 Aug 2022 02:09:55 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id ck30-20020a0564021c1e00b00445d760fc69sm772722edb.50.2022.08.18.02.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 02:09:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <b13f84e2-d402-d686-a365-d13cd09b2a01@redhat.com>
Date:   Thu, 18 Aug 2022 11:09:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
 <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
 <20220817234120.mw2j3cgshmuyo2vw@box.shutemov.name>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220817234120.mw2j3cgshmuyo2vw@box.shutemov.name>
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

On 8/18/22 01:41, Kirill A. Shutemov wrote:
> Note, that userfaultfd is only relevant for shared memory as it requires
> VMA which we don't have for MFD_INACCESSIBLE.

Oh, you're right!  So yeah, looks like userfaultfd is not a problem.

Paolo
