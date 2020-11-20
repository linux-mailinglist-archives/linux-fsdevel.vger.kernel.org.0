Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227842BA9B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 12:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgKTL64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 06:58:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45815 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgKTL6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 06:58:55 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kg53v-0000wK-0F; Fri, 20 Nov 2020 11:58:47 +0000
Date:   Fri, 20 Nov 2020 12:58:44 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20201120115844.h732hi5p3ullzfvs@wittgenstein>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201120023309.GH9685@magnolia>
 <20201120091044.ofkzgiwoyru23vc4@wittgenstein>
 <20201120091247.GA14894@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120091247.GA14894@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:12:47AM +0000, Christoph Hellwig wrote:
> On Fri, Nov 20, 2020 at 10:10:44AM +0100, Christian Brauner wrote:
> > Maybe you didn't see this or you're referring to xfstests but this
> > series contains a >=4000 lines long test-suite that validates all core
> > features with and without idmapped mounts. It's the last patch in this
> > version of the series and it's located in:
> > tools/testing/selftests/idmap_mounts.
> > 
> > Everytime a filesystem is added this test-suite will be updated. We
> > would perfer if this test would be shipped with the kernel itself and
> > not in a separate test-suite such as xfstests. But we're happy to add
> > patches for the latter at some point too.
> 
> selftests is a complete pain to use, partialy because it is not
> integrated with the framework we file system developers use (xfstests)
> and partially because having the test suite in the kernel tree really
> breaks a lot of the typical use cases.  So I think we'll need to wire
> this up in the proper place instead.

Ok, I think I can basically port the test-suite at the end of this patch
series so that it can be carried in xfstests/src/idmapped_mounts.c

I'll start doing that now.
It would make it a bit easier if we could carry it as a single file for
now.

Christian
