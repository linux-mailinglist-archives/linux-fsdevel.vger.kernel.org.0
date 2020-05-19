Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC791DA390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 23:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgESV3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 17:29:01 -0400
Received: from namei.org ([65.99.196.166]:38282 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESV3B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 17:29:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 04JLSVQr028873;
        Tue, 19 May 2020 21:28:31 GMT
Date:   Wed, 20 May 2020 07:28:31 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
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
Subject: Re: [PATCH v2 2/8] exec: Factor security_bprm_creds_for_exec out of
 security_bprm_set_creds
In-Reply-To: <202005191108.7A6E97831@keescook>
Message-ID: <alpine.LRH.2.21.2005200728110.6670@namei.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org> <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org> <87v9kszrzh.fsf_-_@x220.int.ebiederm.org> <202005191108.7A6E97831@keescook>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 May 2020, Kees Cook wrote:

> >  	/* SELinux context only depends on initial program or script and not
> >  	 * the script interpreter */
> > -	if (bprm->called_set_creds)
> > -		return 0;
> >  
> >  	old_tsec = selinux_cred(current_cred());
> >  	new_tsec = selinux_cred(bprm->cred);
> 
> As you've done in the other LSMs, I think this comment can be removed
> (or moved to the top of the function) too.

I'd prefer moved to top of the function.

-- 
James Morris
<jmorris@namei.org>

