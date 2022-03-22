Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A8A4E493F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 23:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbiCVWnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 18:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiCVWnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:43:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0DC5BD0B;
        Tue, 22 Mar 2022 15:41:36 -0700 (PDT)
Received: from zn.tnic (p200300ea971561dc329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61dc:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60BF61EC0528;
        Tue, 22 Mar 2022 23:41:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647988891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oxVBXEGRaZMxVsz03TdTeYV9J4EiFdcLGB4SPDXJ+Y0=;
        b=fu+uBFQHmi4ck26ugJBb44e35FYfvucppGnOJsqbbnRTp2g0SvWTDgLUTVnpZ3qDla8Ozp
        XGeU29dXH7vtua96FxWV8fN6hi2UnHOpluk7Jtxe4FAYK99hP40I5WAx0VgID2gXz0izov
        4uE/G8KDtp8txWZQDyidWmzGZx4qEZ4=
Date:   Tue, 22 Mar 2022 23:41:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 2/6] x86/mce: relocate set{clear}_mce_nospec()
 functions
Message-ID: <YjpQlmGCFFQueHS1@zn.tnic>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
 <20220319062833.3136528-3-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220319062833.3136528-3-jane.chu@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 19, 2022 at 12:28:29AM -0600, Jane Chu wrote:
> Relocate the twin mce functions to arch/x86/mm/pat/set_memory.c
> file where they belong.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  arch/x86/include/asm/set_memory.h | 52 -------------------------------
>  arch/x86/mm/pat/set_memory.c      | 48 ++++++++++++++++++++++++++++
>  include/linux/set_memory.h        |  9 +++---
>  3 files changed, 53 insertions(+), 56 deletions(-)

For the future, please use get_maintainers.pl so that you know who to Cc
on patches. In this particular case, patches touching arch/x86/ should
Cc x86@kernel.org

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
