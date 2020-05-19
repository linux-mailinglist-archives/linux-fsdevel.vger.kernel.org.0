Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5D21DA3A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 23:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgESVbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 17:31:09 -0400
Received: from namei.org ([65.99.196.166]:38314 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESVbJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 17:31:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 04JLUrgf029102;
        Tue, 19 May 2020 21:30:53 GMT
Date:   Wed, 20 May 2020 07:30:53 +1000 (AEST)
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
Subject: Re: [PATCH v2 5/8] exec: Move the call of prepare_binprm into
 search_binary_handler
In-Reply-To: <87d070zrvx.fsf_-_@x220.int.ebiederm.org>
Message-ID: <alpine.LRH.2.21.2005200730270.6670@namei.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org> <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org> <87d070zrvx.fsf_-_@x220.int.ebiederm.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 May 2020, Eric W. Biederman wrote:

> 
> The code in prepare_binary_handler needs to be run every time
> search_binary_handler is called so move the call into search_binary_handler
> itself to make the code simpler and easier to understand.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Nice cleanup.

Reviewed-by: James Morris <jamorris@linux.microsoft.com>

-- 
James Morris
<jmorris@namei.org>

