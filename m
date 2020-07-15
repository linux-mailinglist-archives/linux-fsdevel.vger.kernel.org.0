Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A1C22142C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGOSVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgGOSVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:21:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CBDC061755;
        Wed, 15 Jul 2020 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/PGzMxiRs3LntzWdZ9BnnwhzRWaZLNAopFC1UTRKht4=; b=n386cJ2xX5uIHAjX8MFywK56Cj
        pEKViQSpn12oXPq+h8K3cwBZdII+6juPIXizsdN0DLdJ4Rc1NyN592FdP5uqCk+B/xYa2yhYae9cT
        +0JnimG086wSG0LSReTbBoW4ePpClWtyrlGO5FDh3oY5xRiddhoKYaF3ifM6HcOCIyKcTeCxf1oWU
        OHFEvG1qnhnWp3FwkmcJ8/lakxMfoKo9R/XX34BEDiEy9UhTONH3wJ9yW6YdgOxeuUHJzU48+HKNw
        bi2lOezBfZ2/Srt2KpxfXCeQk8TME8Vhf22lkWNDDSi2xh5BPfBHe100mnJPi5X+nOp+x0e/rjolf
        NFdarelA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvm1W-0005BZ-1A; Wed, 15 Jul 2020 18:20:54 +0000
Date:   Wed, 15 Jul 2020 19:20:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
Message-ID: <20200715182053.GA18278@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87wo365ikj.fsf@x220.int.ebiederm.org>
 <202007141446.A72A4437C@keescook>
 <20200715064248.GH32470@infradead.org>
 <202007150758.3D1597C6D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007150758.3D1597C6D@keescook>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 08:00:16AM -0700, Kees Cook wrote:
> Heh, yes please. :) (Which branch is this from?

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/exec-cleanup

> Are yours and Eric's
> tree going to collide?)

Yes, badly.
