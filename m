Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E6A2C9F1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 11:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgLAKZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 05:25:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51073 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgLAKZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:25:33 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kk2q0-0007Wx-58; Tue, 01 Dec 2020 10:24:48 +0000
Date:   Tue, 1 Dec 2020 11:24:46 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mauricio =?utf-8?Q?V=C3=A1squez?= Bernal <mauricio@kinvolk.io>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        containers@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, smbarber@chromium.org,
        linux-ext4@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, selinux@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Theodore Tso <tytso@mit.edu>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        fstests@vger.kernel.org, linux-security-module@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alban Crequy <alban@kinvolk.io>,
        linux-integrity@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 32/38] fat: handle idmapped mounts
Message-ID: <20201201102446.qjmzdhu7bktxtnby@wittgenstein>
References: <20201128213527.2669807-1-christian.brauner@ubuntu.com>
 <20201128213527.2669807-33-christian.brauner@ubuntu.com>
 <CAHap4zu3wjCqjbxaXbsPqz2Q_oNRm0Q=xQMudPStwN8h92Stcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHap4zu3wjCqjbxaXbsPqz2Q_oNRm0Q=xQMudPStwN8h92Stcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 05:50:08PM -0500, Mauricio Vásquez Bernal wrote:
> >
> > mount2 --idmap both:1000:1001:1
> >
> 
> Nit: missing arguments to mount2.

Thanks, fixed!
Christian
