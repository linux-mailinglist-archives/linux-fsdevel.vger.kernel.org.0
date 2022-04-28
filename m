Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C6351348D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbiD1NMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 09:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiD1NMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:12:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E2B0A67;
        Thu, 28 Apr 2022 06:09:35 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 960D31EC04A6;
        Thu, 28 Apr 2022 15:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651151370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AZZoBR+MifOMfzpc2UaQXWXUtdGp5oejb9lwzXknN14=;
        b=YnotU1aVf2LVp6eHrZ4SvHyz1x/qggcQnfrKqLeECCiZH98kafs2LrLeGP8gIPG32sELFY
        cmmTBHwZNLqFvIyTDwKc/7JM/FwafuvK2fxVlVClL8amkJjpxNRLFYAGTiyTonTquX1PKm
        nAilvE/+vpeRCp7bKBu9Nq0dkU3sJYw=
Date:   Thu, 28 Apr 2022 15:09:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, hch@infradead.org, dave.hansen@intel.com,
        peterz@infradead.org, luto@kernel.org, david@fromorbit.com,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com
Subject: Re: [PATCH v9 2/7] x86/mce: relocate set{clear}_mce_nospec()
 functions
Message-ID: <YmqSC9K10Jlm5VFG@zn.tnic>
References: <20220422224508.440670-1-jane.chu@oracle.com>
 <20220422224508.440670-3-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220422224508.440670-3-jane.chu@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:45:03PM -0600, Jane Chu wrote:
> Relocate the twin mce functions to arch/x86/mm/pat/set_memory.c
> file where they belong.
> 
> While at it, fixup a function name in a comment.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  arch/x86/include/asm/set_memory.h | 52 -------------------------------
>  arch/x86/mm/pat/set_memory.c      | 49 ++++++++++++++++++++++++++++-
>  include/linux/set_memory.h        |  8 ++---
>  3 files changed, 52 insertions(+), 57 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
