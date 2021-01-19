Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0AA2FC278
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 22:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389687AbhASRt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 12:49:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35725 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbhASO6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:58:24 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l1sRR-0006A4-Nk; Tue, 19 Jan 2021 14:57:09 +0000
Date:   Tue, 19 Jan 2021 15:57:05 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Seth Forshee <seth.forshee@canonical.com>,
        St??phane Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 23/42] open: handle idmapped mounts
Message-ID: <20210119145705.g2je6ec3lq42fffd@wittgenstein>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
 <20210112220124.837960-24-christian.brauner@ubuntu.com>
 <20210119093848.GH3364550@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119093848.GH3364550@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 09:38:48AM +0000, Christoph Hellwig wrote:
> I think path_permission() and file_persmission() helpers would reduce
> the clutter a lot here.

Done.
