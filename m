Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523E33D85DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 04:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhG1CVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 22:21:41 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:40600 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhG1CVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 22:21:41 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8ZAI-004Ws7-G9; Wed, 28 Jul 2021 02:19:22 +0000
Date:   Wed, 28 Jul 2021 02:19:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <YQC+qiYVs3NZ7aa5@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:

> We can enhance nfsd to understand that some automounts can be managed.
> "internal mounts" where a filesystem provides an automount point and
> mounts its own directories, can be handled differently by nfsd.
> 
> This series addresses all these issues.  After a few enhancements to the
> VFS to provide needed support, they enhance exportfs and nfsd to cope
> with the concept of internal mounts, and then enhance btrfs to provide
> them.

I'm half asleep right now; will review and reply in detail tomorrow.
The first impression is that it's going to be brittle; properties of
mount really should not depend upon the nature of mountpoint - too many
ways for that to go wrong.

Anyway, tomorrow...
