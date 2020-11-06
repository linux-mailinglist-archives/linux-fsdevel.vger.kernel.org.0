Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7972A9B2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 18:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgKFRqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 12:46:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKFRqu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:46:50 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A4B2151B;
        Fri,  6 Nov 2020 17:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604684810;
        bh=4o77fqFuBZvPiDYAW30olp6av5R3X4/iv+z7vMt50bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQIkI1axVORa3PbPPE/4evBmU3xr79YrxNJvILQKc/9EgpD9wzoUDOapCBTSofz8d
         QTqdPdkByflxlpoDy7egZoLU3F+pdjtbXKtt1GrCGC8o6QSm1KNHnghF5FZ0wdAksW
         zEtsWWIH2jOZoshKVrojhTsdCy2J+fHU63gXVUz0=
Date:   Fri, 6 Nov 2020 09:46:47 -0800
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
        hch@infradead.org, Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v12 2/4] fs: add LSM-supporting anon-inode interface
Message-ID: <20201106174647.GC845@sol.localdomain>
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-3-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106155626.3395468-3-lokeshgidra@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 06, 2020 at 07:56:24AM -0800, Lokesh Gidra wrote:
> +/**
> + * Like anon_inode_getfd(), but creates a new !S_PRIVATE anon inode rather than
> + * reuse the singleton anon inode, and call the anon_init_security_anon() LSM
> + * hook. This allows the inode to have its own security context and for a LSM

"call the anon_init_security_anon() LSM hook" =>
"calls the inode_init_security_anon() LSM hook".

Otherwise this patch looks okay.  Feel free to add:

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
