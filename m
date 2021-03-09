Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D25331D98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 04:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCIDce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 22:32:34 -0500
Received: from foss.arm.com ([217.140.110.172]:46402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhCIDc2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 22:32:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D5F731B;
        Mon,  8 Mar 2021 19:32:27 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33EE63F71B;
        Mon,  8 Mar 2021 19:32:22 -0800 (PST)
Subject: Re: [PATCH 0/6] mm: some config cleanups
To:     linux-mm@kvack.org
Cc:     x86@kernel.org, linux-ia64@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1615185706-24342-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <af8d16b3-aff7-6f17-a777-2ce4a264227d@arm.com>
Date:   Tue, 9 Mar 2021 09:02:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1615185706-24342-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/8/21 12:11 PM, Anshuman Khandual wrote:
> This series contains config cleanup patches which reduces code duplication
> across platforms and also improves maintainability. There is no functional
> change intended with this series. This has been boot tested on arm64 but
> only build tested on some other platforms.
> 
> This applies on 5.12-rc2
> 
> Cc: x86@kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (6):
>   mm: Generalize ARCH_HAS_CACHE_LINE_SIZE
>   mm: Generalize SYS_SUPPORTS_HUGETLBFS (rename as ARCH_SUPPORTS_HUGETLBFS)
>   mm: Generalize ARCH_ENABLE_MEMORY_[HOTPLUG|HOTREMOVE]
>   mm: Drop redundant ARCH_ENABLE_[HUGEPAGE|THP]_MIGRATION
>   mm: Drop redundant ARCH_ENABLE_SPLIT_PMD_PTLOCK
>   mm: Drop redundant HAVE_ARCH_TRANSPARENT_HUGEPAGE

Seems like there was a problem during the email because some patches
might not have hit the mailing list. Although git send-email never
really reported any problem. Not sure what happened here.

https://patchwork.kernel.org/project/linux-mm/list/?series=443619
https://lore.kernel.org/linux-mm/1615185706-24342-1-git-send-email-anshuman.khandual@arm.com/

Will probably resend the series.

- Anshuman
