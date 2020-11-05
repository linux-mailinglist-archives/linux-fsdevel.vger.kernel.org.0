Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C3D2A898B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 23:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbgKEWHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 17:07:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732517AbgKEWHt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:07:49 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 466352078E;
        Thu,  5 Nov 2020 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604614069;
        bh=178huzaFZ/hAY5sYLanFhkUTFNiQNJfZdx7VDjMneC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jNn8K5XKu30RZm07Z9rmMLpJnTPLp3iYQl7n6KByggBgD6eZc83m8qrNMdo2DKd5I
         WYq6t+0VFTFz3CbRrj/XbZ5bHumeWHXdz5ugvtxA/L8lFwt0fAQrULxT/HK2YwM/eP
         FRs44fyFm7R4UDIqefkUUCi3IxmH3d7AcwGltpgI=
Date:   Thu, 5 Nov 2020 14:07:45 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        hch@infradead.org
Subject: Re: [PATCH v11 1/4] security: add inode_init_security_anon() LSM hook
Message-ID: <20201105220745.GB2555324@gmail.com>
References: <20201105213324.3111570-1-lokeshgidra@google.com>
 <20201105213324.3111570-2-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105213324.3111570-2-lokeshgidra@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 05, 2020 at 01:33:21PM -0800, Lokesh Gidra wrote:
> This change adds a new LSM hook, inode_init_security_anon(), that
> will be used while creating secure anonymous inodes.

Will be used to do what?  To assign a security context to the inode and to
allow/deny creating it, right?

> 
> The new hook accepts an optional context_inode parameter that
> callers can use to provide additional contextual information to
> security modules for granting/denying permission to create an anon-
> inode of the same type.

It looks like the hook also uses the context_inode parameter to assign a
security context to the inode.  Is that correct?  It looks like that's what the
code does, so if you could get the commit messages in sync, that would be
helpful.  I'm actually still not completely sure I'm understanding the intent
here, given that different places say different things.

- Eric
