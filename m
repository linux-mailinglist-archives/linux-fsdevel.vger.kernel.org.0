Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455252BA5A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgKTJNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgKTJND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:13:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E24C0613CF;
        Fri, 20 Nov 2020 01:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mNLnU8cl44VoAwmtF3N/cVr4YIhMWVFWr0ATljQRTes=; b=TTIb8ohQ+PwDq74N++0bgk2zll
        V4Tj1uTEh1nLpZA5CWmWqyId5ggC5fFNgj0pboCtHDqY3L67GCyZNuDKPhIyDglg/E86QFfp03+bI
        wGOy+rZdGneSYckkAgLWS4Lquu6jKns1/3RDzJtgxPXaG/cApFOXbxrjmFwxID+CMkn8bfg2ariPD
        q8PRJnZIyL/pF1pJzmkrZOIsiNWxi9EqbnrSKptOWKTutDymxTvJ3MTHzpDBEzdVC/iFZdmds1m9/
        d0Edw6QH1c1pHG3bkB/sYhvaimIvfkENpPeia3BDp903NdAOst0DSmCRA3GxWKsouD7etMiOrv1DU
        Mvs7rk4A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg2TH-0003xV-Ap; Fri, 20 Nov 2020 09:12:47 +0000
Date:   Fri, 20 Nov 2020 09:12:47 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        St??phane Graber <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 00/39] fs: idmapped mounts
Message-ID: <20201120091247.GA14894@infradead.org>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201120023309.GH9685@magnolia>
 <20201120091044.ofkzgiwoyru23vc4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120091044.ofkzgiwoyru23vc4@wittgenstein>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:10:44AM +0100, Christian Brauner wrote:
> Maybe you didn't see this or you're referring to xfstests but this
> series contains a >=4000 lines long test-suite that validates all core
> features with and without idmapped mounts. It's the last patch in this
> version of the series and it's located in:
> tools/testing/selftests/idmap_mounts.
> 
> Everytime a filesystem is added this test-suite will be updated. We
> would perfer if this test would be shipped with the kernel itself and
> not in a separate test-suite such as xfstests. But we're happy to add
> patches for the latter at some point too.

selftests is a complete pain to use, partialy because it is not
integrated with the framework we file system developers use (xfstests)
and partially because having the test suite in the kernel tree really
breaks a lot of the typical use cases.  So I think we'll need to wire
this up in the proper place instead.
