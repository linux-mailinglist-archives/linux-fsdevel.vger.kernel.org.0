Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47824678E8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjAXCuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjAXCuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:50:01 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46093526B;
        Mon, 23 Jan 2023 18:49:59 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 66012C009; Tue, 24 Jan 2023 03:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1674528616; bh=sNo2M+vMXVNnmuHmMi9fNsU/T1dxnbKBZtBfGYFBJqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=auR2LTgbqUESWdQFsOH6G6jdyJZNuEsdbqwj0802ggjGubDemBBcTW19oJHdwERf1
         KLTj92n6Ak9FVEbsnYXQJ2xOrszyVoz885izMPPYWA4oSwJVyiaj/y9X4ALultB3W9
         a5wVG0+4SHzuFnT2zpV9ABro5E0Cr+nB1AYh5SYPRJLDEripVC72CTjKLhGtKRdiE+
         SKBGNpWjdJ1Kb35YzaHH25NuDRGLMjxCchxUiStvUlsTWB3n1kQDG6IeHR5RZjTKFX
         ZrbYTjf4/pd/KEE5zY0OVsoHcgmJP0Bm8W6jSS0sfjgm9eY+brz/leDX18Q2EfS61o
         fYShBUznNpRdg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id AF6ECC009;
        Tue, 24 Jan 2023 03:50:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1674528615; bh=sNo2M+vMXVNnmuHmMi9fNsU/T1dxnbKBZtBfGYFBJqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i16EJ9kBh9jIXmYnudf4BDTdOfKbpABLFv4Ox9v/rl7CDDxWuA6w4A2Icyc6BCcZ9
         eIPAloZCWtNKPJdUJfn1QNaKdsmGGGtr0mEd4dZCm+vLeb64KnRJuYH2dFVdzbvQlN
         r2q/wUfbbiKCYCH5iXg85p4zDne3Y++NbNE4IL9I/bMNMW4e9ZtUbB066vcnpHYVqr
         2ce5q4DuR0WWaAZ1EprZIwszrDXLO8+0T0DKciuigt8VzdjoD8Uwqur1OkXgGO2ryp
         3fHBgz0PbYy+tONgQqjZuAO7/nEzNJYaZxLTp/9rei9lKyi2IBH3tL7vT7lEA4p3TR
         l217FDv+lrQfA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 3239948c;
        Tue, 24 Jan 2023 02:49:52 +0000 (UTC)
Date:   Tue, 24 Jan 2023 11:49:37 +0900
From:   asmadeus@codewreck.org
To:     evanhensbergen@icloud.com
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Zhengchao Shao via V9fs-developer 
        <v9fs-developer@lists.sourceforge.net>,
        Ron Minnich <rminnich@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Performance fixes for 9p filesystem
Message-ID: <Y89HQXu90ea6Ed4r@codewreck.org>
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <4478705.9R3AOq7agI@silver>
 <CEE93F4D-7C11-4FE3-BB70-A9C865BE5BC2@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CEE93F4D-7C11-4FE3-BB70-A9C865BE5BC2@icloud.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

evanhensbergen@icloud.com wrote on Mon, Jan 23, 2023 at 08:33:46PM -0600:
> I’m fine with funneling these through Dominique since he’s currently
> the active maintainer, but I’ve also re-established kernel.org
> <http://kernel.org/> credentials so I can field the pull-request if
> desired.

I'm happy either way; I've had a (too quick to really call review) look
at the code itself and it mostly makes sense to me, and as you pointed
out some would warrant a Cc stable@ and not waiting if I had time to do
this seriously, but I'm not sure I'll make it if this needs to wait for
me.

Do you also have a tree that goes in -next ? I think I asked before but
lost your reply, sorry.
If not it'll probably be easier for me to pick it up this cycle, but
that's about the only reason I'd see for me to take the patches as
things stand.

-- 
Dominique
