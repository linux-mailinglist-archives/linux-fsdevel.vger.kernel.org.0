Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5924222053B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 08:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgGOGiS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 02:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgGOGiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:38:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FF8C061755;
        Tue, 14 Jul 2020 23:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JjVa0h4uFSr2pzBmFgAMpiW1sZBe7zjYlnhnjdkNvjg=; b=Nrld92niBIg4BKo4cgE4ZelgP1
        innve4muRc5oAjEgDb57YCbrEE7Qhj1OHEYntVm8RUPhrwuYfkfwbJi9Oyr0v+kS5H7cWJ28EIcDu
        eBk4EMFXio/feaPCuFfNKiqK+oK+b0sReMiV39yvKE2ck5BsAgomojcLfYg+EbPZQnR8VozRs8Qo4
        y9prd7gaPANubKbwYqofAG9GYDcftRZz0Je5yJrlzZWJaApD/582jp3jEOcLN3eR96aQjAnzeKb1B
        s90pKPMZye8LhKiBd14Zdj/Fk2Z02lLSAYHqzJ3lsDft+djoqBJF0ov6Tq61SvUg2t9zpoSQQ0RxM
        9XqazZHA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvb3Y-00010O-1N; Wed, 15 Jul 2020 06:38:16 +0000
Date:   Wed, 15 Jul 2020 07:38:15 +0100
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
Subject: Re: [PATCH 6/7] exec: Factor bprm_stack_limits out of
 prepare_arg_pages
Message-ID: <20200715063815.GF32470@infradead.org>
Reply-To: Iha@infradead.org
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87365u6x60.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87365u6x60.fsf@x220.int.ebiederm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:31:03AM -0500, Eric W. Biederman wrote:
> 
> In preparation for implementiong kernel_execve (which will take kernel
> pointers not userspace pointers) factor out bprm_stack_limits out of
> prepare_arg_pages.  This separates the counting which depends upon the
> getting data from userspace from the calculations of the stack limits
> which is usable in kernel_execve.
> 
> The remove prepare_args_pages and compute bprm->argc and bprm->envc
> directly in do_execveat_common, before bprm_stack_limits is called.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

This looks basically identical to my "exec: split prepare_arg_pages".
I slightly prefer the version I had, but this looks ok as well:

Reviewed-by: Christoph Hellwig <hch@lst.de>
