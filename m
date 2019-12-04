Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1E113851
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 00:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfLDXlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 18:41:18 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52555 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728011AbfLDXlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:41:18 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xB4Nf7k9030083
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Dec 2019 18:41:08 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E0197421A48; Wed,  4 Dec 2019 18:41:06 -0500 (EST)
Date:   Wed, 4 Dec 2019 18:41:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Daniel Phillips <daniel@phunq.net>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
Message-ID: <20191204234106.GC5641@mit.edu>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
 <3b5f28e5-2b88-47bb-1b32-5c2fed989f0b@phunq.net>
 <20191130175046.GA6655@mit.edu>
 <76ddbdba-55ba-3426-2e29-0fa17db9b6d8@phunq.net>
 <23F33101-065E-445A-AE5C-D05E35E2B78B@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23F33101-065E-445A-AE5C-D05E35E2B78B@dilger.ca>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 11:31:50AM -0700, Andreas Dilger wrote:
> One important use case that we have for Lustre that is not yet in the
> upstream ext4[*] is the ability to do parallel directory operations.
> This means we can create, lookup, and/or unlink entries in the same
> directory concurrently, to increase parallelism for large directories.
> 
> 
> [*] we've tried to submit the pdirops patch a couple of times, but the
> main blocker is that the VFS has a single directory mutex and couldn't
> use the added functionality without significant VFS changes.
> Patch at https://git.whamcloud.com/?p=fs/lustre-release.git;f=ldiskfs/kernel_patches/patches/rhel8/ext4-pdirop.patch;hb=HEAD
>

The XFS folks recently added support for parallel directory operations
into the VFS, for the benefit of XFS has this feature.  So it should
be possible adjust the patch so it will work with the upstream kernel
now.

Cheers,

					- Ted


