Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6245F3F16D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 11:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbhHSJ4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 05:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhHSJ4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:56:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14679C061575;
        Thu, 19 Aug 2021 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oIotVKt85Rb4zTbqb/WlmrAVapzeRtWFY/9pBR2nkhM=; b=KCUZCYiGDxEFK9dDcZ5QKZ8bho
        RMy0S/ROV6qOCIEOfE0tI+Td1tg2fq1UVCw4mJQFP3MO5TIgAl4+pgpQiWurXU5AMe38FMxZLBA6N
        akE0NycfmWpAniFPAt2d6OpT4G6TJFyWksA/qRNvncVBm9gEK0po7a5BpinSpT87nkiFz1w46U3KM
        jOTZAQ0XsTPq22JKVNPOo28l3qEoejUAS1U/1rb2Pwk/DMfmsr+qWjiXz8IkeO/Yj4gJ7I6FAzeqg
        lNwOEN78GvZAlBb9KGcP4L625TaSQVaKs8v1zGXZplsdSmmZfUgYAQ/wceqjbToyHb19QRVu6lhDW
        XQHPuWuw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGelR-004tzP-3k; Thu, 19 Aug 2021 09:55:23 +0000
Date:   Thu, 19 Aug 2021 10:55:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 04/12] powerpc/pseries/svm: Add a powerpc version of
 prot_guest_has()
Message-ID: <YR4qfZdkv+91zNZk@infradead.org>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <000f627ce20c6504dd8d118d85bd69e7717b752f.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f627ce20c6504dd8d118d85bd69e7717b752f.1628873970.git.thomas.lendacky@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 11:59:23AM -0500, Tom Lendacky wrote:
> +static inline bool prot_guest_has(unsigned int attr)

No reall need to have this inline.  In fact I'd suggest we havea the
prototype in a common header so that everyone must implement it out
of line.
