Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A875C34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 02:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfGZAzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 20:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfGZAzg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:55:36 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8ED2238C;
        Fri, 26 Jul 2019 00:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564102535;
        bh=o4hVED1DnXPhi52FO0wtBGwbvoqHLkWraSNdRFbEhmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L5uUd3GhpWzXG8NZ5VAfPLAogGQnqmrSDtJ2WoGzo4kODsjexGjl2plEX8UF4CwuW
         oU0gaoBumTXP+a5Fx+/RYg+bzmTeV7Qn9p0BT20Auw6fp70moUvLzgdHDbXgB4eoWy
         x3mw2X6mVGMx2Db5jEYPWqqxyerg3w7sEzNMLtn4=
Date:   Thu, 25 Jul 2019 17:55:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH REBASE v4 11/14] mips: Adjust brk randomization offset
 to fit generic version
Message-Id: <20190725175533.f9fcc5139a9575560be7f679@linux-foundation.org>
In-Reply-To: <201907251259.09E0101@keescook>
References: <20190724055850.6232-1-alex@ghiti.fr>
        <20190724055850.6232-12-alex@ghiti.fr>
        <1ba4061a-c026-3b9e-cd91-3ed3a26fce1b@ghiti.fr>
        <201907251259.09E0101@keescook>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 25 Jul 2019 13:00:33 -0700 Kees Cook <keescook@chromium.org> wrote:

> > I have just noticed that this patch is wrong, do you want me to send
> > another version of the entire series or is the following diff enough ?
> > This mistake gets fixed anyway in patch 13/14 when it gets merged with the
> > generic version.
> 
> While I can't speak for Andrew, I'd say, since you've got Paul and
> Luis's Acks to add now, I'd say go ahead and respin with the fix and the
> Acks added.

Yes please.   After attending to Paul's questions on [14/14].
