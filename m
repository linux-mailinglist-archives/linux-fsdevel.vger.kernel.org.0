Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2628604AB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiJSPKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiJSPJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:09:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BF5367BE
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 08:03:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g1so28568102lfu.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8uws4B5WgtxEQQPonRBN7dDm57mj+TMYZwg9NWMF6uE=;
        b=GNoRQIq9JKVsi3NBMOHtxRxaA+HyiSRxEbQwKROCIdQN7YeQVvkeCL/tBfTJ0rFShS
         wLv+OMed6GKtlzQERAvDIH0fS9RwWNLH1iDzg8iIFUBsQUCTCUR56HEIdBHp5w6KeZ+i
         ed0p1SeRI6LjurmDyBxbuv8clbnocReb3YyBgtI/ebogw01dMtsK7A/KD1lbcyPsqtH5
         TaWyyc8eNama/1dRhNwUMQO8P85tBb+QCcPLfYt81cuF60S21NuSTt9ENjFqtPiqHbYW
         QbAZcIWW265YqQ7fQmjB0etPPuYGAVxyYuBBwAInvDjayuW/S/xhDX/aqG8lWy7/HjYu
         bNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uws4B5WgtxEQQPonRBN7dDm57mj+TMYZwg9NWMF6uE=;
        b=aCdZ9d81HBj+WJiagE0ly1RBh4Q+TahhCnmykcPoIg54sFj4sZLtsJtQymPk7eX3jG
         EIF4Mzrswk/q0+Mo96Z3iPLuzvuMNbfl4OYwMYjA26DJ4nsAt4f/J7Vc5uZCstuod+He
         +Qdapl32NEaDGzBEvNoI41tg+A7CktC7iX2U+5F27qq5Cb0zfpTeo2dvbOGI+F4bwUzi
         kd9g67yGW/e18zN3IOzgRRlsyA2+ANPirPGDUgWTZ/OmfdboCa9WwCPl4jFJz3f9xb5Y
         bJlJRakPQuK9wO49ALkn4tjGhDyS3DsHacWzhAoj/zLD94jHtFal+8dSJ9jZ4AXMeqj9
         trsQ==
X-Gm-Message-State: ACrzQf0B5znozEzl6L1jiu59Oq7GYdGqAe1jYyRc2MD+K2YoewMLGlqd
        BoiFoutJey4QKDgn3nV9md5Qbed2MIIf5ErWEYk0pw==
X-Google-Smtp-Source: AMsMyM73/Iz2UA6hD6VnKREmVWKox8T+CDDwCUSlKn0rjft7dc92r9M4EXDXMPFumhxI7Ld+a4+gjwQViVOGvFn4W+A=
X-Received: by 2002:a05:6512:4cb:b0:4a2:25b6:9e73 with SMTP id
 w11-20020a05651204cb00b004a225b69e73mr3205357lfq.30.1666191778897; Wed, 19
 Oct 2022 08:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-6-chao.p.peng@linux.intel.com> <CA+EHjTxukqBfaN6D+rPOiX83zkGknHEQ16J0k6GQSdL_-e9C6g@mail.gmail.com>
 <20221012023516.GA3218049@chaop.bj.intel.com> <CA+EHjTyGyGL+ox81=jdtoHERtHPV=P7wJub=3j7chdijyq-AgA@mail.gmail.com>
 <Y03UiYYioV+FQIpx@google.com> <20221019132308.GA3496045@chaop.bj.intel.com>
In-Reply-To: <20221019132308.GA3496045@chaop.bj.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Wed, 19 Oct 2022 16:02:22 +0100
Message-ID: <CA+EHjTytCEup0m-nhnVHsuQ1xjaCxXNHO_Oxe+QbpwqaewpfKQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] KVM: Register/unregister the guest private memory regions
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > This sounds good. Thank you.
> >
> > I like the idea of a separate Kconfig, e.g. CONFIG_KVM_GENERIC_PRIVATE_MEM or
> > something.  I highly doubt there will be any non-x86 users for multiple years,
> > if ever, but it would allow testing the private memory stuff on ARM (and any other
> > non-x86 arch) without needing full pKVM support and with only minor KVM
> > modifications, e.g. the x86 support[*] to test UPM without TDX is shaping up to be
> > trivial.
>
> CONFIG_KVM_GENERIC_PRIVATE_MEM looks good to me.

That sounds good to me, and just keeping the xarray isn't really an
issue for pKVM. We could end up using it instead of some of the other
structures we use for tracking.

Cheers,
/fuad

> Thanks,
> Chao
> >
> > [*] https://lore.kernel.org/all/Y0mu1FKugNQG5T8K@google.com
