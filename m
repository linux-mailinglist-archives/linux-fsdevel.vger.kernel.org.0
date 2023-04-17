Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E601C6E4C4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjDQPBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjDQPBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:01:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B6A5F1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 08:01:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 84-20020a251457000000b00b8f59a09e1fso10106183ybu.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681743691; x=1684335691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3vFLlBa5cMlD9b7ag9UYfdTMx74Bbs3yMKPPX9I4GwM=;
        b=OGK68FoyuQQ0kL2O5HxgRSHt2QbHDboc5hKMwP4bRlcKJMMQAqRIjlauG70g4aXaoI
         RCwv7FXMFfNLqRJZOBy613A+w5XRRmN2H2zNWfDKzF5SD1tHfZhrbVuBk4E+E75tEqrF
         tTw3g4U6dgFgiOat04BE8cBNJSCGB9Eo6i59NNQJ7dGQyIov0yYTuF8P3+jFvyWWxfrn
         0j0To2/U3XsPrjlbsK4GxsP+6fqJeqao+Umk0Hyn6UYVUGH6nHHmq6l0xMVKwPTxX5p+
         rKay54diEn82iZ0UmBZY1V+E+USumHcN/suI4FJwOO5iMGVBjQ3QbXWAt22U12qkos0n
         8hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743691; x=1684335691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vFLlBa5cMlD9b7ag9UYfdTMx74Bbs3yMKPPX9I4GwM=;
        b=NwDKJlg/xLgEm6tQUDMkPHDPkHDFe2FAuzQQ1IQCcTqH1122wPIukO5FIqZnUP1cfv
         XGar89CfVvhqKXYC50soutszrJNqv70PomxkR1yviEAyJTCtju29AavRgmQkwgonuMnc
         AVqf0FKqdusfrm1ntdoiW7C7CVxfsK31iwrP8fGXh6rZf4ZsbqN7vNQF0uKJMn2H7nPM
         5QuqeOg7esPQgmjf/63JYjDHR8Wo6yYd5WMGNoFql8mlatk53mIMdmmgv7uOlwzqKLMJ
         Phti2rTJKBvdZjEg8mCsTeE+3UqSxfE7UJxAK5PC0xcnsHZ6voC1+Y35dPJxi/fG/WwJ
         84dA==
X-Gm-Message-State: AAQBX9fwt4qdQI4CclL0aI/Ua6hWG1gjA8vdWpmtHbLJUODE4BTpWEUE
        TKt2u4J93qOEXh93t30gEXzNEO2BeYE=
X-Google-Smtp-Source: AKy350b5nQcMgF9tvDaCScAgDkBQIzDDMu1+GFlUDC4dCSeKOYxYJW/fQSKubGNo1KBFDrJt/MuCx/ozRD0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ef02:0:b0:545:883a:544d with SMTP id
 o2-20020a81ef02000000b00545883a544dmr9382205ywm.9.1681743691396; Mon, 17 Apr
 2023 08:01:31 -0700 (PDT)
Date:   Mon, 17 Apr 2023 08:01:30 -0700
In-Reply-To: <20230417143747.GA3639898@chaop.bj.intel.com>
Mime-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com> <20230119111308.GC2976263@ls.amr.corp.intel.com>
 <Y8lg1G2lRIrI/hld@google.com> <20230119223704.GD2976263@ls.amr.corp.intel.com>
 <Y880FiYF7YCtsw/i@google.com> <20230417143747.GA3639898@chaop.bj.intel.com>
Message-ID: <ZD1fSl/LT6oBOOmg@google.com>
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023, Chao Peng wrote:
> In case you started working on the code again, I have a branch [1]
> originally planned as v11 candidate which I believe I addressed all the
> discussions we had for v10 except the very latest one [2] and integrated
> all the newly added selftests from Ackerley and myself. The branch was
> based on your original upm_base_support and then rebased to your
> kvm-x86/mmu head. Feel free to take anything you think useful( most of
> them are trivial things but also some fixes for bugs).

Nice!  I am going to work on splicing together the various series this week, I'll
make sure to grab your work.

Thanks much! 
