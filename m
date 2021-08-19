Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052223F2133
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhHST63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:58:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:65242 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233995AbhHST62 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:58:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216366474"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="216366474"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 12:57:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="532641597"
Received: from kfrangia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.58.216])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 12:57:50 -0700
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Christoph Hellwig <hch@infradead.org>
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
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
 <YR4p9TqKTLdN1A96@infradead.org>
 <4272eaf5-b654-2669-62ac-ba768acd6b91@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <90316f17-e853-fd23-2ec2-4d03cf283b0b@linux.intel.com>
Date:   Thu, 19 Aug 2021 12:57:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4272eaf5-b654-2669-62ac-ba768acd6b91@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/19/21 11:33 AM, Tom Lendacky wrote:
> There was some talk about this on the mailing list where TDX and SEV may
> need to be differentiated, so we wanted to reserve a range of values per
> technology. I guess I can remove them until they are actually needed.

In TDX also we have similar requirements and we need some flags for
TDX specific checks. So I think it is fine to leave some space for vendor
flags.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
