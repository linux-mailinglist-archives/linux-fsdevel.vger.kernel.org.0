Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B8C2C47BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 19:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbgKYSgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 13:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732968AbgKYSgz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:36:55 -0500
Received: from gaia (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B04A2065D;
        Wed, 25 Nov 2020 18:36:47 +0000 (UTC)
Date:   Wed, 25 Nov 2020 18:36:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v12 04/10] set_memory: allow querying whether
 set_direct_map_*() is actually enabled
Message-ID: <20201125183645.GB16801@gaia>
References: <20201125092208.12544-1-rppt@kernel.org>
 <20201125092208.12544-5-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125092208.12544-5-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 11:22:02AM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> On arm64, set_direct_map_*() functions may return 0 without actually
> changing the linear map. This behaviour can be controlled using kernel
> parameters, so we need a way to determine at runtime whether calls to
> set_direct_map_invalid_noflush() and set_direct_map_default_noflush() have
> any effect.
> 
> Extend set_memory API with can_set_direct_map() function that allows
> checking if calling set_direct_map_*() will actually change the page table,
> replace several occurrences of open coded checks in arm64 with the new
> function and provide a generic stub for architectures that always modify
> page tables upon calls to set_direct_map APIs.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
