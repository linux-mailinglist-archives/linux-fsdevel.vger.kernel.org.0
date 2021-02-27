Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869BD326E62
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 18:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhB0RXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 12:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhB0RTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 12:19:55 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A85AC06174A;
        Sat, 27 Feb 2021 09:19:02 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lG3Ex-001QwC-As; Sat, 27 Feb 2021 17:18:51 +0000
Date:   Sat, 27 Feb 2021 17:18:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [git pull] vfs.git misc stuff
Message-ID: <YDp++xQkiawy2z2r@zeniv-ca.linux.org.uk>
References: <YDnf/cY4c0uOIcVd@zeniv-ca.linux.org.uk>
 <CAHk-=whHCLK=_h27zMi8A=sn-GO=C+JOAX4nb7QjuGRbLebgbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whHCLK=_h27zMi8A=sn-GO=C+JOAX4nb7QjuGRbLebgbQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 27, 2021 at 08:21:55AM -0800, Linus Torvalds wrote:
> On Fri, Feb 26, 2021 at 10:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Al Viro (3):
> >       9p: fix misuse of sscanf() in v9fs_stat2inode()
> 
> Hmm. Technically this changes some of the rules. It used to check that
> i tall fit in 32 bytes. Now there could be arbitrary spaces in there
> that pushes it over the limit.
> 
> I don't think we care, but..

	I doubt that something was sending "HARDLINKCOUNT                 123"
*and* relying upon the truncation to have that parsed as 1 rather than 123...
