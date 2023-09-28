Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A27B2303
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 18:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjI1Qze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 12:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1Qzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:55:33 -0400
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 09:55:31 PDT
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B392BF
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 09:55:31 -0700 (PDT)
Date:   Thu, 28 Sep 2023 09:47:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695919662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wveZV/OpMnfjYWiQaY9ODeOIzpESq4cgbicBnYivGwk=;
        b=AD+KxXFw3jS2YoHuX20ZNxTD8+hrALeFSW0wAeV6Vjor2bsIyDZYKI++uX1ccll5mauxTK
        3vNa+wMJFMgf7fC52qho8oaplJQ1YmKsx2wkjjIVQOibksmRnua8ruhBqfkhPU7zhxNTaH
        gu+EXU2wTEIgkokCVjRRcrZJyrWRncM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, nd@arm.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        maz@kernel.org, shuah@kernel.org, will@kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 06/20] KVM: arm64: Save/restore POE registers
Message-ID: <ZRWuJ9jses6b7Lmc@linux.dev>
References: <20230927140123.5283-1-joey.gouly@arm.com>
 <20230927140123.5283-7-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927140123.5283-7-joey.gouly@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Joey,

On Wed, Sep 27, 2023 at 03:01:09PM +0100, Joey Gouly wrote:
> Define the new system registers that POE introduces and context switch them.

I'm not seeing the latter part in the diff. I was anticipating that the
POE context switching hooks into __sysreg_{save,restore}_{el1,user}_state() like
we do for most other bits of sysreg context.

--
Thanks,
Oliver
