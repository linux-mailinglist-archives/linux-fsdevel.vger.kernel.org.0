Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC53763F9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 05:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfGJDXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 23:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfGJDXO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 23:23:14 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D914520693;
        Wed, 10 Jul 2019 03:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562728994;
        bh=6VM69cjMR62DOFam6wRJOf7DU+65RZThCwGfDpt5tl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cn0LZTICeh1nxbAizoAtW8xwe+ZUjm/iQei9c7Yi1sc3XOKFhjQlSed3gZm+z4i9p
         kgYKk/e/4TOnrk9yEZqHna0Rb6OG+Q5eDXjx8JhtKZcz2ZVi3pGqGY/MDt1DbfPhvB
         0xkEPwG1N+HTraHEGGVQ7hO6aXPG4IJcdTMejo4U=
Date:   Tue, 9 Jul 2019 20:23:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: 6 new syscalls without tests (was: [PATCH] vfs: move_mount: reject
 moving kernel internal mounts)
Message-ID: <20190710032312.GA2152@sol.localdomain>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <CACT4Y+ZN8CZq7L1GQANr25extEqPASRERGVh+sD4-55cvWPOSg@mail.gmail.com>
 <20190629202744.12396-1-ebiggers@kernel.org>
 <20190701164536.GA202431@gmail.com>
 <20190701182239.GA17978@ZenIV.linux.org.uk>
 <20190702182258.GB110306@gmail.com>
 <20190709194001.GG641@sol.localdomain>
 <20190709205424.GB17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709205424.GB17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:54:24PM +0100, Al Viro wrote:
> On Tue, Jul 09, 2019 at 12:40:01PM -0700, Eric Biggers wrote:
> > On Tue, Jul 02, 2019 at 11:22:59AM -0700, Eric Biggers wrote:
> > > 
> > > Sure, but the new mount syscalls still need tests.  Where are the tests?
> > > 
> > 
> > Still waiting for an answer to this question.
> 
> In samples/vfs/fsmount.c, IIRC, and that's not much of a test.

A sample program doesn't count.  There need to be tests that can be run
automatically as part of a well known test suite, such as LTP, kselftests, or
xfstests.  Why is this not mandatory for new syscalls to be accepted?  What if
they are broken and we don't know?  See what happened with copy_file_range():
https://lwn.net/Articles/774114/

- Eric
