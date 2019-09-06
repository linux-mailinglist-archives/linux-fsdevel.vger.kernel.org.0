Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE5BAC022
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 21:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406228AbfIFTEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 15:04:52 -0400
Received: from namei.org ([65.99.196.166]:43022 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbfIFTEw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:04:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x86J3QSE019203;
        Fri, 6 Sep 2019 19:03:26 GMT
Date:   Fri, 6 Sep 2019 12:03:26 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Jeff Layton <jlayton@kernel.org>
cc:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Florian Weimer <fweimer@redhat.com>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?ISO-8859-15?Q?Philippe_Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
In-Reply-To: <5a59b309f9d0603d8481a483e16b5d12ecb77540.camel@kernel.org>
Message-ID: <alpine.LRH.2.21.1909061202070.18660@namei.org>
References: <20190906152455.22757-1-mic@digikod.net>  <20190906152455.22757-2-mic@digikod.net>  <87ef0te7v3.fsf@oldenburg2.str.redhat.com>  <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>  <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org> 
 <1fbf54f6-7597-3633-a76c-11c4b2481add@ssi.gouv.fr> <5a59b309f9d0603d8481a483e16b5d12ecb77540.camel@kernel.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 6 Sep 2019, Jeff Layton wrote:

> The fact that open and openat didn't vet unknown flags is really a bug.
> 
> Too late to fix it now, of course, and as Aleksa points out, we've
> worked around that in the past. Now though, we have a new openat2
> syscall on the horizon. There's little need to continue these sorts of
> hacks.
> 
> New open flags really have no place in the old syscalls, IMO.

Agree here. It's unfortunate but a reality and Linus will reject any such 
changes which break existing userspace.


-- 
James Morris
<jmorris@namei.org>

