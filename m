Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793B22A9B23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 18:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgKFRp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 12:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbgKFRp1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:45:27 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B542151B;
        Fri,  6 Nov 2020 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604684726;
        bh=Mtx+hFU31M02TKQ5DcxfpDTcYIT2hQlVQVC2Rv/oUjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeMsm1QArTp3WPXKj6cD8UKxfEv3ll2IOnu+E/CEDxXb4peyc+IRWt+ObJWzc1LOT
         xVmVdTaRA22CYhRAbExV0Kpl1RhlfFP/+Z9eJ53hfGA140BTmHfxJ47SPNNjLNixcw
         WzE0buNDHeTOolCkwwlAedj2IeeTK5YzhIpH2Me8=
Date:   Fri, 6 Nov 2020 09:45:22 -0800
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
Subject: Re: [PATCH v12 1/4] security: add inode_init_security_anon() LSM hook
Message-ID: <20201106174522.GB845@sol.localdomain>
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-2-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106155626.3395468-2-lokeshgidra@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 06, 2020 at 07:56:23AM -0800, Lokesh Gidra wrote:
> This change adds a new LSM hook, inode_init_security_anon(), that will
> be used while creating secure anonymous inodes. The hook allows/denies
> its creation and assigns a security context to the inode.
> 
> The new hook accepts an optional context_inode parameter that callers
> can use to provide additional contextual information to security modules
> for granting/denying permission to create an anon-inode of the same type.
> This context_inode's security_context can also be used to initialize the
> newly created anon-inode's security_context.
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Reviewed-by: Eric Biggers <ebiggers@google.com>
