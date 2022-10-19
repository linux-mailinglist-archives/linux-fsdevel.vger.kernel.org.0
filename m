Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A1B604FB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 20:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJSSdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 14:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJSSdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:33:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989FA1D0649
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 11:33:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so29584467lfb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Oct 2022 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VPr6UAOpmN1/gMX0ewomaOCJg5YtZQmOBncflHxMDjk=;
        b=LwRPgs44Xx9fZBCWVguQMsygec+a76lxS9ASG3VWi6VBR4o+JOMKkdn5tTnapNhNbx
         FCagxAT3CfEM6YSuiTVMbPHaJojgG9FhVAFnQbxsBultlVUY0pF/BJ7Pb1rCsoLbQEMZ
         Tsz/eakulZFZMoaUwgMl+Q1Q2Mo6Ja/eO1XGRRJI1TLh6z4IE3uaaC2a1iSmaS0U4Sg7
         StbFJsC36uGNihltZfZ/naEuTHBMd0aKRn0MseX2AD4OY2VEwCn3xL3Np44L+mr8bSRa
         xewHLuoL2hqyU3VemdfwUsM41M+NZMYII6+iUpJITWhnfKF5ZBr0cRMrYzrFp5Hl4kbC
         lg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPr6UAOpmN1/gMX0ewomaOCJg5YtZQmOBncflHxMDjk=;
        b=R0AvFHI60thG2SBFbpxMJYLZsn5kn/a/e/a1Z5TdZaKh+1YP7nzSTb9I+CBnbbeN+d
         m+JJJu7oQITnvGoZMG3j7/6NqWl3SluHCXRGZVK+juzl43pXMSgmPH1aBv+iObQjcMvu
         +F7330Vf9+KmLC6ktQyTeV+IXEihqhDxKhRW7rEJXjw6nrUcGLLs7YHjs4g2C4TC/54m
         PzbVKCrx6vasvT7lHGm7QTh/dUMWliOVkwSX2IELU3pvfCHyw9rtRtc4bMiq3T9urCxC
         MqSd48124IPpKJ0tr9bAgFW4ImnPN2xTdxQxwAPpcdd0wzU0zyaRsMOmM19AOfM7EW1P
         dtSQ==
X-Gm-Message-State: ACrzQf2kWug7B+gY/mDYdymFqMIBmS2NhQV4/REow1l2CMcsdm3K7UQz
        NeiGqfH6jSscG76f2jq/ypsWOdcHsd05nBJvtmghQA==
X-Google-Smtp-Source: AMsMyM4EBV5NPiqUSsGoH76d60Oj4XtTNKzmBM3XB8zcFOXHmexalPNeyd2MnHJenC/4Cf4QA3Wt+/yC+VCqwQatWHo=
X-Received: by 2002:a05:6512:3119:b0:4a2:d749:ff82 with SMTP id
 n25-20020a056512311900b004a2d749ff82mr3531001lfb.637.1666204378020; Wed, 19
 Oct 2022 11:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-6-chao.p.peng@linux.intel.com> <CA+EHjTxukqBfaN6D+rPOiX83zkGknHEQ16J0k6GQSdL_-e9C6g@mail.gmail.com>
 <20221012023516.GA3218049@chaop.bj.intel.com> <CA+EHjTyGyGL+ox81=jdtoHERtHPV=P7wJub=3j7chdijyq-AgA@mail.gmail.com>
 <Y03UiYYioV+FQIpx@google.com> <20221019132308.GA3496045@chaop.bj.intel.com>
 <CA+EHjTytCEup0m-nhnVHsuQ1xjaCxXNHO_Oxe+QbpwqaewpfKQ@mail.gmail.com> <Y1AhP0dlRSgTCObX@google.com>
In-Reply-To: <Y1AhP0dlRSgTCObX@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Wed, 19 Oct 2022 19:32:21 +0100
Message-ID: <CA+EHjTzR6DwU950gud1opEGCNqCfiEvA4-JFtyJ0NBgTD-uHNg@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] KVM: Register/unregister the guest private memory regions
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:09 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Oct 19, 2022, Fuad Tabba wrote:
> > > > > This sounds good. Thank you.
> > > >
> > > > I like the idea of a separate Kconfig, e.g. CONFIG_KVM_GENERIC_PRIVATE_MEM or
> > > > something.  I highly doubt there will be any non-x86 users for multiple years,
> > > > if ever, but it would allow testing the private memory stuff on ARM (and any other
> > > > non-x86 arch) without needing full pKVM support and with only minor KVM
> > > > modifications, e.g. the x86 support[*] to test UPM without TDX is shaping up to be
> > > > trivial.
> > >
> > > CONFIG_KVM_GENERIC_PRIVATE_MEM looks good to me.
> >
> > That sounds good to me, and just keeping the xarray isn't really an
> > issue for pKVM.
>
> The xarray won't exist for pKVM if the #ifdefs in this patch are changed from
> CONFIG_HAVE_KVM_PRIVATE_MEM => CONFIG_KVM_GENERIC_PRIVATE_MEM.
>
> > We could end up using it instead of some of the other
> > structures we use for tracking.
>
> I don't think pKVM should hijack the xarray for other purposes.  At best, it will
> be confusing, at worst we'll end up with a mess if ARM ever supports the "generic"
> implementation.

Definitely wasn't referring to hijacking it for other purposes, which
is the main reason I wanted to clarify the documentation and the
naming of private_fd. Anyway, I'm glad to see that we're in agreement.
Once I've tightened the screws, I'll share the pKVM port as an RFC as
well.

Cheers,
/fuad
