Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3ED214F82
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 22:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgGEUow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 16:44:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:51794 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgGEUov (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:44:51 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CB3FB2E4;
        Sun,  5 Jul 2020 20:44:50 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:44:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 00/10] Documentation: filesystems: eliminate duplicated
 words
Message-ID: <20200705144449.5cf9c163@lwn.net>
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  3 Jul 2020 14:43:15 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Fix doubled words in filesystems files.
> 
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Ian Kent <raven@themaw.net>
> Cc: autofs@vger.kernel.org
> Cc: David Howells <dhowells@redhat.com>
> Cc: linux-cachefs@redhat.com
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Theodore Y. Ts'o <tytso@mit.edu>
> Cc: linux-fscrypt@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: linux-unionfs@vger.kernel.org
> 
> 
>  Documentation/filesystems/autofs-mount-control.rst |    6 +++---
>  Documentation/filesystems/caching/operations.rst   |    2 +-
>  Documentation/filesystems/configfs.rst             |    2 +-
>  Documentation/filesystems/directory-locking.rst    |    4 ++--
>  Documentation/filesystems/fsverity.rst             |    2 +-
>  Documentation/filesystems/mount_api.rst            |    4 ++--
>  Documentation/filesystems/overlayfs.rst            |    2 +-
>  Documentation/filesystems/path-lookup.rst          |    2 +-
>  Documentation/filesystems/sysfs-tagging.rst        |    2 +-
>  Documentation/filesystems/vfs.rst                  |    4 ++--
>  10 files changed, 15 insertions(+), 15 deletions(-)
> 
Applied, thanks.

jon
