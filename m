Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A955264A99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 19:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgIJRFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 13:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgIJREh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:04:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F84C061573;
        Thu, 10 Sep 2020 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OyXzjCB63mYRe0BvSmc1T78HrhzEXzQ566vkrNeunqA=; b=PNzhRz1iWp6AsZIRd/72enP4n6
        0cGLlHpItHhRrb4V65JwvV3zyrBFvKYVo7bXAjFWgtvpAGHhyayXpGt/uOkz4CdqT81VeYf3/wKF0
        dXdbNkOXmfBwjUe/8WbUJI+7Vk5iQf0emhN7GpuPd3c1HZw1T/xWQ/usVNovNbEbO3dRSZMv8JA9H
        OKXxTeHazmHVvtSSMEOViFLnER1ZFjPDzrdQwYHy6uhKo7rXrBo2NV67Q4zlWAafMgPlX0XLrLhKw
        SbjsUxcCvBG1XQYoYuuVkZSevrSXz3Hxd8Tl2n4dv5NKRrECTXUzBKQ5zFpZ27FcC/z0JgqFihe9Z
        QR+thY4g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGPzk-000804-44; Thu, 10 Sep 2020 17:04:24 +0000
Date:   Thu, 10 Sep 2020 18:04:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v9 0/3] Add introspect_access(2) (was O_MAYEXEC)
Message-ID: <20200910170424.GU6583@casper.infradead.org>
References: <20200910164612.114215-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200910164612.114215-1-mic@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 06:46:09PM +0200, Mickaël Salaün wrote:
> This ninth patch series rework the previous AT_INTERPRETED and O_MAYEXEC
> series with a new syscall: introspect_access(2) .  Access check are now
> only possible on a file descriptor, which enable to avoid possible race
> conditions in user space.

But introspection is about examining _yourself_.  This isn't about
doing that.  It's about doing ... something ... to a script that you're
going to execute.  If the script were going to call the syscall, then
it might be introspection.  Or if the interpreter were measuring itself,
that would be introspection.  But neither of those would be useful things
to do, because an attacker could simply avoid doing them.

So, bad name.  What might be better?  sys_security_check()?
sys_measure()?  sys_verify_fd()?  I don't know.

