Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB42D1739
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 18:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgLGRLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 12:11:06 -0500
Received: from verein.lst.de ([213.95.11.211]:42822 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgLGRLF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:11:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DF62E68AFE; Mon,  7 Dec 2020 18:10:21 +0100 (CET)
Date:   Mon, 7 Dec 2020 18:10:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 05/40] fs: add attr_flags_to_mnt_flags helper
Message-ID: <20201207171021.GB13614@lst.de>
References: <20201203235736.3528991-1-christian.brauner@ubuntu.com> <20201203235736.3528991-6-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203235736.3528991-6-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -3450,6 +3450,28 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
>  	return ret;
>  }
>  
> +#define FSMOUNT_VALID_FLAGS                                                    \
> +	(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV |            \
> +	 MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME | MOUNT_ATTR_NODIRATIME)

Any good reason for aligning the \ using spaces all the way out?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
