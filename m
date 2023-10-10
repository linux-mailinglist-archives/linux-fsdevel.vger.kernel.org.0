Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1451B7BF80B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 11:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjJJJ6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 05:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJJJ6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:58:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7EA8AC;
        Tue, 10 Oct 2023 02:58:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1959E1FB;
        Tue, 10 Oct 2023 02:58:47 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 839493F762;
        Tue, 10 Oct 2023 02:58:04 -0700 (PDT)
Date:   Tue, 10 Oct 2023 10:58:02 +0100
From:   Joey Gouly <joey.gouly@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, nd@arm.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        maz@kernel.org, oliver.upton@linux.dev, shuah@kernel.org,
        will@kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 15/20] arm64: add POE signal support
Message-ID: <20231010095802.GC2098677@e124191.cambridge.arm.com>
References: <20230927140123.5283-1-joey.gouly@arm.com>
 <20230927140123.5283-16-joey.gouly@arm.com>
 <a6e6c8a3-15b1-48e3-84fa-810ce575c09a@sirena.org.uk>
 <9fd11f36-3987-4f45-94be-7cf89a05ad04@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fd11f36-3987-4f45-94be-7cf89a05ad04@sirena.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mark,

On Mon, Oct 09, 2023 at 03:49:29PM +0100, Mark Brown wrote:
> On Thu, Oct 05, 2023 at 03:34:29PM +0100, Mark Brown wrote:
> > On Wed, Sep 27, 2023 at 03:01:18PM +0100, Joey Gouly wrote:
> > > Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.
> 
> > It'd be nice to have at least a basic test that validates that we
> > generate a POE signal frame when expected, though that should be a very
> > minor thing which is unlikely to ever actually spot anything.
> 
> Actually, now I think about it we at least need an update to the frame
> parser in userspace so it knows about the new frame.  Without that it'll
> warn whenver it parses the signal context on any system that has POE
> enabled.

Do you mean in libc?

Thanks,
Joey
