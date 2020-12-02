Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56A12CB857
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 10:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbgLBJOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 04:14:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34179 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387797AbgLBJOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:14:51 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkOD7-0001NW-VZ; Wed, 02 Dec 2020 09:14:06 +0000
Date:   Wed, 2 Dec 2020 10:14:03 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org, fstests@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH v3 03/38] namespace: only take read lock in
 do_reconfigure_mnt()
Message-ID: <20201202091403.jdip5k5jyf6o6pqw@wittgenstein>
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
 <20201128213527.2669807-4-christian.brauner@ubuntu.com>
 <20201201103224.GC27730@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201103224.GC27730@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:32:24AM +0100, Christoph Hellwig wrote:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!
Christian
