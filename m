Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981942FFAD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 04:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbhAVDE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 22:04:28 -0500
Received: from namei.org ([65.99.196.166]:52460 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbhAVDEZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 22:04:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 054BEC92;
        Fri, 22 Jan 2021 03:02:52 +0000 (UTC)
Date:   Fri, 22 Jan 2021 14:02:51 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
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
        =?ISO-8859-15?Q?St=E9phane_Graber?= <stgraber@ubuntu.com>,
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
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 05/39] namei: make permission helpers idmapped mount
 aware
In-Reply-To: <20210121131959.646623-6-christian.brauner@ubuntu.com>
Message-ID: <f4b5102b-529-7e43-c35b-bf956359461a@namei.org>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com> <20210121131959.646623-6-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 21 Jan 2021, Christian Brauner wrote:

> The two helpers inode_permission() and generic_permission() are used by
> the vfs to perform basic permission checking by verifying that the
> caller is privileged over an inode. In order to handle idmapped mounts
> we extend the two helpers with an additional user namespace argument.
> On idmapped mounts the two helpers will make sure to map the inode
> according to the mount's user namespace and then peform identical
> permission checks to inode_permission() and generic_permission(). If the
> initial user namespace is passed nothing changes so non-idmapped mounts
> will see identical behavior as before.
> 
> Link: https://lore.kernel.org/r/20210112220124.837960-12-christian.brauner@ubuntu.com
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

