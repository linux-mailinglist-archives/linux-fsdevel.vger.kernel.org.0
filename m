Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BEA2A6EB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbgKDU3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730965AbgKDU3Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:29:24 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6410320795;
        Wed,  4 Nov 2020 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604521763;
        bh=YsqwvDkysjqcelivUMh1EQTcXoiX5e6CH0oo7FC4XJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jj4d0tvrS66vd21+5PcYYN3ftlTVckqzHc2eMJR7eZLgQ77Nw1SLN/S/EnVFE+1lI
         ZkKaFNIiEDCRa3HXj+2QTaZSHm38ylYlJLq39T/N5sxOOOShV/lzxw3Q8NA/+Hf7V/
         EUVX1Yh8dKalypHhVd/J101q2LDcM5YR0SEr6U7s=
Date:   Wed, 4 Nov 2020 12:29:20 -0800
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
        nnk@google.com, jeffv@google.com, kernel-team@android.com
Subject: Re: [PATCH v10 0/3] SELinux support for anonymous inodes and UFFD
Message-ID: <20201104202920.GC1796392@gmail.com>
References: <20201011082936.4131726-1-lokeshgidra@google.com>
 <20201104200701.GA1796392@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104200701.GA1796392@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:07:16PM -0800, Eric Biggers wrote:
> On Sun, Oct 11, 2020 at 01:29:33AM -0700, Lokesh Gidra wrote:
> > Daniel Colascione (3):
> >   Add a new LSM-supporting anonymous inode interface
> >   Teach SELinux about anonymous inodes
> >   Use secure anon inodes for userfaultfd
> 
> Patches are supposed to have subsystem prefixes, e.g.
> 
> 	fs, security: add a new LSM-supporting anonymous inode interface
> 	selinux: implement init_security_anon()
> 	userfaultfd: use secure anon inodes
> 
> ... but that points to the fact that the first one is really both fs and
> security subsystem changes.  Patches should be one logical change only.  I
> suggest splitting it up into:
> 
> 	security: add init_security_anon() LSM hook
> 	fs: add anon_inode_getfd_secure()

Correction: it's "inode_init_security_anon()", not "init_security_anon()".

- Eric
