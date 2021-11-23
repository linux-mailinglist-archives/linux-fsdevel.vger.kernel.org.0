Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F8D45A625
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 16:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbhKWPEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 10:04:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:3048 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhKWPEc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:04:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="321266870"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="321266870"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 07:01:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="509438278"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 07:01:13 -0800
Date:   Tue, 23 Nov 2021 23:00:28 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Wanpeng Li <wanpengli@tencent.com>, jun.nakajima@intel.com,
        kvm@vger.kernel.org, david@redhat.com, qemu-devel@nongnu.org,
        "J . Bruce Fields" <bfields@fieldses.org>, dave.hansen@intel.com,
        "H . Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Mattson <jmattson@google.com>, linux-mm@kvack.org,
        Sean Christopherson <seanjc@google.com>, susie.li@intel.com,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        john.ji@intel.com, Yu Zhang <yu.c.zhang@linux.intel.com>,
        linux-fsdevel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC v2 PATCH 13/13] KVM: Enable memfd based page
 invalidation/fallocate
Message-ID: <20211123150028.GE32088@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-14-chao.p.peng@linux.intel.com>
 <20211122141647.3pcsywilrzcoqvbf@box.shutemov.name>
 <20211123010639.GA32088@chaop.bj.intel.com>
 <2f3e9d7e-ce15-e47b-54c6-3ca3d7195d70@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f3e9d7e-ce15-e47b-54c6-3ca3d7195d70@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:09:28AM +0100, Paolo Bonzini wrote:
> On 11/23/21 02:06, Chao Peng wrote:
> > > Maybe the kvm has to be tagged with a sequential id that incremented every
> > > allocation. This id can be checked here.
> > Sounds like a sequential id will be needed, no existing fields in struct
> > kvm can work for this.
> 
> There's no need to new concepts when there's a perfectly usable reference
> count. :)

Indeed, thanks.

> 
> Paolo
