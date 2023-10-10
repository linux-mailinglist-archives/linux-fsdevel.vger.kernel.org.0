Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44D37BF7EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 11:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjJJJyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjJJJyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:54:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAC7493;
        Tue, 10 Oct 2023 02:54:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 344C01FB;
        Tue, 10 Oct 2023 02:55:16 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96DBF3F762;
        Tue, 10 Oct 2023 02:54:28 -0700 (PDT)
Date:   Tue, 10 Oct 2023 10:54:23 +0100
From:   Joey Gouly <joey.gouly@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, nd@arm.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        maz@kernel.org, oliver.upton@linux.dev, shuah@kernel.org,
        will@kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 05/20] arm64: context switch POR_EL0 register
Message-ID: <20231010095423.GA2098677@e124191.cambridge.arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
 <20230927140123.5283-6-joey.gouly@arm.com>
 <b1e43c42-111f-43e3-9e24-89ddef76fedc@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e43c42-111f-43e3-9e24-89ddef76fedc@sirena.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mark,

On Thu, Oct 05, 2023 at 03:14:50PM +0100, Mark Brown wrote:
> On Wed, Sep 27, 2023 at 03:01:08PM +0100, Joey Gouly wrote:
> 
> > +/* Initial value for Permission Overlay Extension for EL0 */
> > +#define POR_EL0_INIT	UL(0x7)
> 
> Might be useful to explain why this is the default (and possibly also
> define in terms of the constants for POR values)?
> 
> > +static void permission_overlay_switch(struct task_struct *next)
> > +{
> > +	if (alternative_has_cap_unlikely(ARM64_HAS_S1POE)) {
> 
> Why the _unlikely here?

The only options are alternative_has_cap_{likely,unlikely}().
I went with unlikely as currently it is unlikely!

Thanks,
Joey

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

