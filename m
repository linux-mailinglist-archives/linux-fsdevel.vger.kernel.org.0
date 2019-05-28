Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD782C549
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 13:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE1LU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 07:20:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:47178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfE1LU1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 07:20:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC855AE3F;
        Tue, 28 May 2019 11:20:24 +0000 (UTC)
Date:   Tue, 28 May 2019 13:20:23 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] [RFC] Remove bdflush syscall stub
Message-ID: <20190528112022.GA16683@rei>
References: <20190528101012.11402-1-chrubis@suse.cz>
 <mvmr28idgfu.fsf@linux-m68k.org>
 <20190528104017.GA11969@rei>
 <87ftoyg7t3.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftoyg7t3.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> >> > I've tested the patch on i386. Before the patch calling bdflush() with
> >> > attempt to tune a variable returned 0 and after the patch the syscall
> >> > fails with EINVAL.
> >> 
> >> Should be ENOSYS, doesn't it?
> >
> > My bad, the LTP syscall wrapper handles ENOSYS and produces skipped
> > results based on that.
> >
> > EINVAL is what you get for not yet implemented syscalls, i.e. new
> > syscall on old kernel.
> 
> EINVAL?  Is that a bdflush-specific thing, test-specific, or is itmore
> general?
> 
> glibc has fallback paths that test for ENOSYS only.  EINVAL will be
> passed to the application, skipping fallback.  For missing system calls,
> this is not what we want.

The syscall returns ENOSYS after this change, sorry for the confusion.

-- 
Cyril Hrubis
chrubis@suse.cz
