Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037112204F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGOG2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgGOG2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:28:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF494C061755;
        Tue, 14 Jul 2020 23:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pvO4ic3x1AyoT4qNI92vdeMOnJXAMHSBZQ7RBY+0sE0=; b=Tz7UqrAUHQyZfyJrdxR+5kr7A2
        75r73ERji5D37LsDIzj2PSfbzlkjdwQ0bfWt+87Z//LUyWH83Ao0/E2pwRD9m+OgP0HQVH88DhoEz
        XTIgAJZF/7g0p46Q775/HTeQXeg+3OP+9mbkXXMet6mLmNUHTJKyo0JOIBVAKZ+pBIgDtbnHWhrmV
        I3gKqOBZNdXfBuQ1yWEX24+q9qrVli66jaSYYPh4XwQjfqOcrii39Rzs0eyHM6UF3RQJEN522CoCY
        UT0uMWTaqR9Lr3xLTbyTi3KhW6bXX89jIFtWxCqTZSk8msKl7xgIgrtr+MpA0t5hdVPHLe1pKRMKU
        hFfKcJOQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvau4-0000YM-3A; Wed, 15 Jul 2020 06:28:28 +0000
Date:   Wed, 15 Jul 2020 07:28:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/7] exec: Remove unnecessary spaces from binfmts.h
Message-ID: <20200715062827.GA32470@infradead.org>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87v9iq6x9x.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9iq6x9x.fsf@x220.int.ebiederm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:28:42AM -0500, Eric W. Biederman wrote:
> 
> The general convention in the linux kernel is to define a pointer
> member as "type *name".  The declaration of struct linux_binprm has
> several pointer defined as "type * name".  Update them to the
> form of "type *name" for consistency.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
