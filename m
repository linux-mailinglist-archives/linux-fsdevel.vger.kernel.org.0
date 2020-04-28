Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E21BCE8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 23:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgD1VVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 17:21:44 -0400
Received: from albireo.enyo.de ([37.24.231.21]:52356 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgD1VVo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:21:44 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jTXfa-0000qq-1U; Tue, 28 Apr 2020 21:21:34 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jTXeO-000142-Bl; Tue, 28 Apr 2020 23:20:20 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Jann Horn <jannh@google.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala?= =?iso-8859-1?Q?=FCn?= 
        <mickael.salaun@ssi.gouv.fr>, Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Add support for RESOLVE_MAYEXEC
References: <20200428175129.634352-1-mic@digikod.net>
        <CAG48ez1bKzh1YvbD_Lcg0AbMCH_cdZmrRRumU7UCJL=qPwNFpQ@mail.gmail.com>
Date:   Tue, 28 Apr 2020 23:20:20 +0200
In-Reply-To: <CAG48ez1bKzh1YvbD_Lcg0AbMCH_cdZmrRRumU7UCJL=qPwNFpQ@mail.gmail.com>
        (Jann Horn's message of "Tue, 28 Apr 2020 21:21:48 +0200")
Message-ID: <87blnb48a3.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jann Horn:

> Just as a comment: You'd probably also have to use RESOLVE_MAYEXEC in
> the dynamic linker.

Absolutely.  In typical configurations, the kernel does not enforce
that executable mappings must be backed by files which are executable.
It's most obvious with using an explicit loader invocation to run
executables on noexec mounts.  RESOLVE_MAYEXEC is much more useful
than trying to reimplement the kernel permission checks (or what some
believe they should be) in userspace.
