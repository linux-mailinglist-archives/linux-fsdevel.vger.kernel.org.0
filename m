Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4044A6830
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 23:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiBAWsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 17:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiBAWsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:48:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D178EC061714;
        Tue,  1 Feb 2022 14:48:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82777CE1AEA;
        Tue,  1 Feb 2022 22:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8300AC340EB;
        Tue,  1 Feb 2022 22:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643755697;
        bh=6VuQf9TIZTK1f+3lkmlRD8xm4paGNLM5msg4bP90rnM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QLZ9jv1p1aTh2q4B+bk0sRH/K8JZbAauWeMSaNqysWmWNeIBkGPeDQI6rxCKd4tMa
         jodUckzxV9Tw/w5LzFqxVZgxgGzulASHrj4s7t7eTpL1IdbQdWJErMd7KD9+Eetyqp
         qc9Fj5pcgKCw7n8br/CEAig5o0sSctFwAMWgfPDk=
Date:   Tue, 1 Feb 2022 14:48:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Magnus =?ISO-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-Id: <20220201144816.f84bafcf45c21d01fbc3880a@linux-foundation.org>
In-Reply-To: <202201281347.F36AEA5B61@keescook>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
        <202201260845.FCBC0B5A06@keescook>
        <202201262230.E16DF58B@keescook>
        <YfOooXQ2ScpZLhmD@fractal.localdomain>
        <202201281347.F36AEA5B61@keescook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 Jan 2022 14:30:12 -0800 Kees Cook <keescook@chromium.org> wrote:

> Andrew, can you update elf-fix-overflow-in-total-mapping-size-calculation.patch
> to include:
> 
> Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
> Cc: stable@vger.kernel.org
> Acked-by: Kees Cook <keescook@chromium.org>

Done.

I'm taking it that we can omit this patch ("elf: Relax assumptions
about vaddr ordering") and that Alexey's "ELF: fix overflow in total
mapping size calculation" will suffice?

