Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23422A6EE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgKDUgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:36:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgKDUgf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:36:35 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 313D9204EF;
        Wed,  4 Nov 2020 20:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604522194;
        bh=gdHLBewM29xjdysVQ8k+xSAiNUOH+jGJ/NlCzBTnS5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mjbu9PJOOA1g+sP+WoGDsZOisFRCL6Bz49sDkHg5Q51d8QnC/ezomCXxjBfASWFpS
         8HbWnCFyy53x9+hMyhljnxrXpjyrEsSuGBeYrESOR9KMRfbsnF8ByzS2zZQfHASiDl
         O4MrwwWMDwbZc56kmz7ZYnmEsySsj0pyebWkr0yo=
Date:   Wed, 4 Nov 2020 12:36:31 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v10 3/3] Use secure anon inodes for userfaultfd
Message-ID: <20201104203631.GD1796392@gmail.com>
References: <20201011082936.4131726-1-lokeshgidra@google.com>
 <20201011082936.4131726-4-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011082936.4131726-4-lokeshgidra@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 11, 2020 at 01:29:36AM -0700, Lokesh Gidra wrote:
> From: Daniel Colascione <dancol@google.com>
> 
> This change gives userfaultfd file descriptors a real security
> context, allowing policy to act on them.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>
> 
> [Remove owner inode from userfaultfd_ctx]
> [Use anon_inode_getfd_secure() instead of anon_inode_getfile_secure()
>  in userfaultfd syscall]
> [Use inode of file in userfaultfd_read() in resolve_userfault_fork()]
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---

I'm not an expert in userfaultfd or SELinux, but I don't see any issues with
this patch, and the comments I made earlier were resolved (except for the patch
title which I just pointed out -- it should have "userfaultfd:" prefix).

So feel free to add:

Reviewed-by: Eric Biggers <ebiggers@google.com>
