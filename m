Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58687B6EE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbjJCQqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjJCQqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:46:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7643A1;
        Tue,  3 Oct 2023 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696351610; x=1727887610;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nN2KPp3CaN2kwskRxd/Tu+L9S923Q8/Pb0VWg57BRPA=;
  b=D+cI4mDw9iJuYcCNSaG2cOfrX4MGqeKnGomCspJCjcYmenjM/fuD/NTy
   ppYm3y1StCa3wb2Q7zxVWeudb/G+g9BUStVe5h0Wc+aeOlitxf1vb9jGx
   6QTZuVA2+I436cq711Vr1lzqrDb8o7VwNOSOT3VbN/KRMWhY/d9hdweVP
   46BC2hciBXrAgUd/VLAeTkNqORfK8nZUABanNGvlg3E7wQaFIgOK+hy8A
   O53SgoJyTET6wjtVPlnGQa+YI3g/rEvuZntBdNRXv16rLAs3TyYYllyqn
   dMCfG7Cx0FePW916JIJtI8hAG3/l9KhsxMKew6sEchtYy2HZM5snzm1VA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="380198934"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="380198934"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:46:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841423262"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="841423262"
Received: from ddiaz-mobl4.amr.corp.intel.com (HELO [10.209.57.36]) ([10.209.57.36])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:46:49 -0700
Message-ID: <36c9a903-eb48-f262-9d39-c58ff7fb8052@intel.com>
Date:   Tue, 3 Oct 2023 09:46:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 19/20] selftests: mm: move fpregs printing
Content-Language: en-US
To:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        maz@kernel.org, oliver.upton@linux.dev, shuah@kernel.org,
        will@kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230927140123.5283-1-joey.gouly@arm.com>
 <20230927140123.5283-20-joey.gouly@arm.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230927140123.5283-20-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/23 07:01, Joey Gouly wrote:
> arm64's fpregs are not at a constant offset from sigcontext. Since this is
> not an important part of the test, don't print the fpregs pointer on arm64.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
