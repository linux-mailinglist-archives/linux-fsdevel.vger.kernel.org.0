Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ADC300A2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbhAVRl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:41:59 -0500
Received: from verein.lst.de ([213.95.11.211]:37560 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbhAVRfY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:35:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C3BC68BFE; Fri, 22 Jan 2021 18:34:40 +0100 (CET)
Date:   Fri, 22 Jan 2021 18:34:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
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
        Mauricio =?iso-8859-1?Q?V=E1squez?= Bernal 
        <mauricio@kinvolk.io>
Subject: Re: [PATCH v6 35/40] fs: introduce MOUNT_ATTR_IDMAP
Message-ID: <20210122173440.GA20821@lst.de>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com> <20210121131959.646623-36-christian.brauner@ubuntu.com> <20210122173340.GA20658@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122173340.GA20658@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 06:33:40PM +0100, Christoph Hellwig wrote:
> >  /*
> >   * mount_setattr()
> > @@ -127,9 +128,10 @@ struct mount_attr {
> >  	__u64 attr_set;
> >  	__u64 attr_clr;
> >  	__u64 propagation;
> > +	__u64 userns_fd;
> >  };
> >  
> >  /* List of all mount_attr versions. */
> > -#define MOUNT_ATTR_SIZE_VER0	24 /* sizeof first published struct */
> > +#define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
> 
> I think this hunk needs to go into the patch adding the structure.

But except for that the patch looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
