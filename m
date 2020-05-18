Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CEF1D7B83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 16:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgEROmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 10:42:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35909 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 10:42:17 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jagy5-0006pE-JF; Mon, 18 May 2020 14:42:14 +0000
Date:   Mon, 18 May 2020 16:42:12 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     mtk.manpages@gmail.com, Miklos Szeredi <mszeredi@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: Setting mount propagation type in new mount API
Message-ID: <20200518144212.xpfjlajgwzwhlq7r@wittgenstein>
References: <CAKgNAkioH1z-pVimHziWP=ZtyBgCOwoC7ekWGFwzaZ1FPYg-tA@mail.gmail.com>
 <909768.1589812234@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <909768.1589812234@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 03:30:34PM +0100, David Howells wrote:
> Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> 
> > I've been looking at the new mount API (fsopen(), fsconfig(),
> > fsmount(), move_mount(), etc.) and among the details that remain
> > mysterious to me is this: how does one set the propagation type
> > (private/shared/slave/unbindable) of a new mount and change the
> > propagation type of an existing mount?
> 
> Christian said he was going to have a go at writing mount_setattr().  It's not
> trivial as it has to be able to handle AT_RECURSIVE.

Right, I've put this on my roadmap now. It's becoming more urgent for us
too since I've already switched over a few bits to the new mount api to
make use of detached/anonymous mounts.
I've planned to start working on a version early next week.

Christian
