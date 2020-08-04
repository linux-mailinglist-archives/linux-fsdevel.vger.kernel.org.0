Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8444223BD52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgHDPjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 11:39:52 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51856 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727038AbgHDPjt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:39:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9ACC18EE19F;
        Tue,  4 Aug 2020 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1596555587;
        bh=ubA7UgAjztHk4GVyHjlFRj5OwpgCUgVMlAu9TLOG2Po=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mCiJhDrQYtjSKfKCoc+zcXJw20GOjtM2YdZhPriO5Hpid2hhKtxkt8+OGJwn2AR3k
         /FzvI51x/wnSixkOpn44wsemSD62wUTee772UZzM6yfGamb8lw4JDlhYCqImJp8k0g
         hmxDKw2bpbC2GIaRZMiNMW3KnidEG+hyy2eB6oS4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bg9YfVLl3_vu; Tue,  4 Aug 2020 08:39:47 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 939768EE0E4;
        Tue,  4 Aug 2020 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1596555586;
        bh=ubA7UgAjztHk4GVyHjlFRj5OwpgCUgVMlAu9TLOG2Po=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bmKnsvG0vWB3ZUCvyzNR7rWc4eZ9+ZsNbdyYPV9VoolPcD7XlGUzdRm1c07fHjqT1
         qmu1PsFAW7gpFD+aA+3WSAkibprMkfYJ8qYBN+PYTXiY0qbHHzX8qwXsshnmHzmyD6
         Q9O+aU2LAAvWaja75qo/xTXfUs/5DETrYxxrcOpI=
Message-ID: <1596555579.10158.23.camel@HansenPartnership.com>
Subject: Re: [PATCH 00/18] VFS: Filesystem information [ver #21]
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Eric Biggers <ebiggers@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, linux-ext4@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, kzak@redhat.com, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Aug 2020 08:39:39 -0700
In-Reply-To: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-03 at 14:36 +0100, David Howells wrote:
> Here's a set of patches that adds a system call, fsinfo(), that
> allows information about the VFS, mount topology, superblock and
> files to be retrieved.
> 
> The patchset is based on top of the notifications patchset and allows
> event counters implemented in the latter to be retrieved to allow
> overruns to be efficiently managed.

Could I repeat the question I asked about six months back that never
got answered:

https://lore.kernel.org/linux-api/1582316494.3376.45.camel@HansenPartnership.com/

It sort of petered out into a long winding thread about why not use
sysfs instead, which really doesn't look like a good idea to me.

I'll repeat the information for those who want to quote it easily on
reply without having to use a web interface:

---
Could I make a suggestion about how this should be done in a way that
doesn't actually require the fsinfo syscall at all: it could just be
done with fsconfig.  The idea is based on something I've wanted to do
for configfd but couldn't because otherwise it wouldn't substitute for
fsconfig, but Christian made me think it was actually essential to the
ability of the seccomp and other verifier tools in the critique of
configfd and I belive the same critique applies here.

Instead of making fsconfig functionally configure ... as in you pass
the attribute name, type and parameters down into the fs specific
handler and the handler does a string match and then verifies the
parameters and then acts on them, make it table configured, so what
each fstype does is register a table of attributes which can be got and
optionally set (with each attribute having a get and optional set
function).  We'd have multiple tables per fstype, so the generic VFS
can register a table of attributes it understands for every fstype
(things like name, uuid and the like) and then each fs type would
register a table of fs specific attributes following the same pattern. 
The system would examine the fs specific table before the generic one,
allowing overrides.  fsconfig would have the ability to both get and
set attributes, permitting retrieval as well as setting (which is how I
get rid of the fsinfo syscall), we'd have a global parameter, which
would retrieve the entire table by name and type so the whole thing is
introspectable because the upper layer knows a-priori all the
attributes which can be set for a given fs type and what type they are
(so we can make more of the parsing generic).  Any attribute which
doesn't have a set routine would be read only and all attributes would
have to have a get routine meaning everything is queryable.

I think I know how to code this up in a way that would be fully
transparent to the existing syscalls.
---

James



