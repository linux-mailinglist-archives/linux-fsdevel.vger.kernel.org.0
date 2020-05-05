Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA11C53A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 12:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgEEKu1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 06:50:27 -0400
Received: from verein.lst.de ([213.95.11.211]:34662 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEEKu0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 06:50:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 64EB968C4E; Tue,  5 May 2020 12:50:23 +0200 (CEST)
Date:   Tue, 5 May 2020 12:50:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 3/5] coredump: Refactor page range dumping into
 common helper
Message-ID: <20200505105023.GB17400@lst.de>
References: <20200429214954.44866-1-jannh@google.com> <20200429214954.44866-4-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429214954.44866-4-jannh@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:49:52PM +0200, Jann Horn wrote:
> Both fs/binfmt_elf.c and fs/binfmt_elf_fdpic.c need to dump ranges of pages
> into the coredump file. Extract that logic into a common helper.
> 
> Any other binfmt that actually wants to create coredumps will probably need
> the same function; so stop making get_dump_page() depend on
> CONFIG_ELF_CORE.

Why is the #ifdef CONFIG_ELF_CORE in gup.c removed when the only
remaining caller is under the same ifdef?

Otherwise this looks fine to me.
