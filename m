Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16089164761
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 15:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBSOqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 09:46:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33595 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgBSOqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:46:21 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j4QcA-0003Zb-Gm; Wed, 19 Feb 2020 14:46:14 +0000
Date:   Wed, 19 Feb 2020 15:46:13 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] VFS: Filesystem information and notifications [ver
 #16]
Message-ID: <20200219144613.lc5y2jgzipynas5l@wittgenstein>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:04:55PM +0000, David Howells wrote:
> 
> Here are a set of patches that adds system calls, that (a) allow
> information about the VFS, mount topology, superblock and files to be
> retrieved and (b) allow for notifications of mount topology rearrangement
> events, mount and superblock attribute changes and other superblock events,
> such as errors.
> 
> ============================
> FILESYSTEM INFORMATION QUERY
> ============================
> 
> The first system call, fsinfo(), allows information about the filesystem at
> a particular path point to be queried as a set of attributes, some of which
> may have more than one value.
> 
> Attribute values are of four basic types:
> 
>  (1) Version dependent-length structure (size defined by type).
> 
>  (2) Variable-length string (up to 4096, including NUL).
> 
>  (3) List of structures (up to INT_MAX size).
> 
>  (4) Opaque blob (up to INT_MAX size).

I mainly have an organizational question. :) This is a huge patchset
with lots and lots of (good) features. Wouldn't it make sense to make
the fsinfo() syscall a completely separate patchset from the
watch_mount() and watch_sb() syscalls? It seems that they don't need to
depend on each other at all. This would make reviewing this so much
nicer and likely would mean that fsinfo() could proceed a little faster.

Christian
