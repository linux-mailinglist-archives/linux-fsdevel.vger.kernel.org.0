Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C8A1DA424
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 23:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgESVxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 17:53:01 -0400
Received: from namei.org ([65.99.196.166]:38346 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgESVxA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 17:53:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 04JLqgRE031922;
        Tue, 19 May 2020 21:52:42 GMT
Date:   Wed, 20 May 2020 07:52:42 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 3/8] exec: Convert security_bprm_set_creds into
 security_bprm_repopulate_creds
In-Reply-To: <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
Message-ID: <alpine.LRH.2.21.2005200750490.30843@namei.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org> <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org> <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 May 2020, Eric W. Biederman wrote:

> diff --git a/fs/exec.c b/fs/exec.c
> index 9e70da47f8d9..8e3b93d51d31 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1366,7 +1366,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	 * the final state of setuid/setgid/fscaps can be merged into the
>  	 * secureexec flag.
>  	 */
> -	bprm->secureexec |= bprm->cap_elevated;
> +	bprm->secureexec |= bprm->active_secureexec;

Which kernel tree are these patches for? Seems like begin_new_exec() is 
from a prerequisite patchset.


-- 
James Morris
<jmorris@namei.org>

