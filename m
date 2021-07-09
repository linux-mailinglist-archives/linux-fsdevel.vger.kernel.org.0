Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EBB3C2A6F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 22:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhGIUjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 16:39:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45661 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229506AbhGIUjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 16:39:55 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 169KaXOm025930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jul 2021 16:36:41 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 320F815C3C9E; Fri,  9 Jul 2021 16:36:33 -0400 (EDT)
Date:   Fri, 9 Jul 2021 16:36:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        miklos@szeredi.hu, gscrivan@redhat.com, jack@suse.cz,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
Message-ID: <YOizURuWJO9DYGGk@mit.edu>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 09, 2021 at 08:34:41AM -0700, Casey Schaufler wrote:
> >> One question, do all filesystem supporting xattrs deal with setting them
> >> on symlinks/device files correctly?
> > Wrote a simple bash script to do setfattr/getfattr user.foo xattr on
> > symlink and device node on ext4, xfs and btrfs and it works fine.
> 
> How about nfs, tmpfs, overlayfs and/or some of the other less conventional
> filesystems?

As a suggestion, perhaps you could take your bash script and turn it
into an xfstests test so we can more easily test various file systems,
both now and once the commit is accepted, to look for regressions?

Cheers,

					- Ted
