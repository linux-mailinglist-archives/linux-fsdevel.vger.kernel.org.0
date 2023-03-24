Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3998F6C74A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 01:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjCXAmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 20:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCXAmM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:42:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65642CC55;
        Thu, 23 Mar 2023 17:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679618530; x=1711154530;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=AnfAZEwkzaV+MXfEzXGLd84me6iNy8c8SDgIW7uWzHs=;
  b=bLYXl7Ao7NWW9z6af7lkHBb+NePfMyCfWXPKrhJgQLmSmKD7DfuZjXiS
   2GTmGGc65A40Bt27fHGKfgHRcaYLGr0KCC5wKoj8mg+9i7n2DpaNI7g5S
   86VuypJ348MLKWSVAfZqsxY4VZSH1ATflLBCrVnAcz8DlXd8ZP2Z63j/x
   aTTUnSzo1saBr1fTpHNpz6ivPjDQrU0gDd+eOHzJS/DwJ6fC0bFtYy4d1
   ySqTY6y9pbV1IrpithpbEHOS+wSfhZnzG0zOT3SsOTv+R7WqgPYgMEMVq
   jUwkeo2AIvoj5dDCOO7LmAV9kyIobnimx7Ytsf5E2OO0/gWukrFLYIVXU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="404577358"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="404577358"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 17:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="684958656"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="684958656"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 17:42:08 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     dan.j.williams@intel.com, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com
Subject: Re: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
References: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
        <CGME20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3@epcas2p3.samsung.com>
        <20230323105105.145783-1-ks0204.kim@samsung.com>
Date:   Fri, 24 Mar 2023 08:41:02 +0800
In-Reply-To: <20230323105105.145783-1-ks0204.kim@samsung.com> (Kyungsan Kim's
        message of "Thu, 23 Mar 2023 19:51:05 +0900")
Message-ID: <87wn37q8v5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kyungsan Kim <ks0204.kim@samsung.com> writes:

> I appreciate dan for the careful advice.
>
>>Kyungsan Kim wrote:
>>[..]
>>> >In addition to CXL memory, we may have other kind of memory in the
>>> >system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
>>> >memory in GPU card, etc.  I guess that we need to consider them
>>> >together.  Do we need to add one zone type for each kind of memory?
>>> 
>>> We also don't think a new zone is needed for every single memory
>>> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
>>> manage multiple volatile memory devices due to the increased device
>>> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
>>> represent extended volatile memories that have different HW
>>> characteristics.
>>
>>Some advice for the LSF/MM discussion, the rationale will need to be
>>more than "we think the ZONE_EXMEM can be used to represent extended
>>volatile memories that have different HW characteristics". It needs to
>>be along the lines of "yes, to date Linux has been able to describe DDR
>>with NUMA effects, PMEM with high write overhead, and HBM with improved
>>bandwidth not necessarily latency, all without adding a new ZONE, but a
>>new ZONE is absolutely required now to enable use case FOO, or address
>>unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
>>maintainability concern of "fewer degress of freedom in the ZONE
>>dimension" starts to dominate.
>
> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.

Sorry, I don't get your idea.  You want the memory range

 1. can be hot-removed
 2. allow kernel context allocation

This appears impossible for me.  Why cannot you just use ZONE_MOVABLE?

Best Regards,
Huang, Ying

> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
>
> Kindly let me know any advice or comment on our thoughts.
