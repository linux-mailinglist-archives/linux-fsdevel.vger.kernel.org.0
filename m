Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A066466EF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 02:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhLCBLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 20:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhLCBLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:11:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65B4C06174A;
        Thu,  2 Dec 2021 17:08:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6C29B823BC;
        Fri,  3 Dec 2021 01:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80DAC00446;
        Fri,  3 Dec 2021 01:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638493699;
        bh=GgJPejWHjB1hO23ZneIa2/JVxaKv5F32MA6/BnqDTaQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mDPTRUte24dhMbvhYFICRGrHBprMS5iBPUmuKQp9y0yZLj7JSJLl9cKa135lOqdZI
         7JMd6VR1H0RJMCcityYODsMs3xqyTmpQ2w1ga7d5u6C2YgqYaK9qOBEqIOt50xg2R6
         bdy8sMyG1cMe+P7NKykT1HJXw23ujt9DhsVvchdu1F0EVSB5e091Ko3PBXbFtS/A5l
         ojnLUhEwSnPqireq9bSfbRnUfukDUQh2+S4kuidHuYVhhEkKcnmbMzM1dSvcWl/9uy
         YYMvqhk0IQyCsEwMK/86Y+JYN+Pv48XBxaI6Uda549qxuY/USvoklOq4tePWLmEZtT
         MfzVXzzz+Mzzg==
Message-ID: <34ffef96-a4d4-d16c-37a5-3c732f0a7a20@kernel.org>
Date:   Thu, 2 Dec 2021 17:08:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 PATCH 00/13] KVM: mm: fd-based approach for supporting
 KVM guest private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        john.ji@intel.com, susie.li@intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, ak@linux.intel.com, david@redhat.com
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/19/21 05:47, Chao Peng wrote:
> This RFC series try to implement the fd-based KVM guest private memory
> proposal described at [1] and an improved 'New Proposal' described at [2].

I generally like this.  Thanks!
