Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F824DA367
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 03:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390139AbfJQBr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 21:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfJQBr5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:47:57 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF0820854;
        Thu, 17 Oct 2019 01:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571276876;
        bh=Bj6PbMkOEWn9QUa6k3iFedlOuXbKcM5250I2nBSp67o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ir7ngdOqhiJz3NTtmaOmn3xa+J2uzoKwXIbPUViyXiqku47l7kGoSZOx9UeyBqIZc
         I9cfE2AD0W7O+4DNVAzlMaPasxXt0H8QUYSw8tgIN3Yu4t4Jvxi9PP/QBFFYzxQ2Wd
         tWJdXqurmSnpZN0QJxyfssuwP6g98d7J08OT6VQo=
Date:   Wed, 16 Oct 2019 18:47:55 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+76a43f2b4d34cfc53548@syzkaller.appspotmail.com>
Cc:     akpm@osdl.org, deepa.kernel@gmail.com, hch@infradead.org,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        syzkaller-bugs@googlegroups.com, tklauser@nuerscht.ch,
        trond.myklebust@fys.uio.no, viro@zeniv.linux.org.uk
Subject: Re: KASAN: use-after-free Read in mnt_warn_timestamp_expiry
Message-ID: <20191017014755.GA1552@sol.localdomain>
Mail-Followup-To: syzbot <syzbot+76a43f2b4d34cfc53548@syzkaller.appspotmail.com>,
        akpm@osdl.org, deepa.kernel@gmail.com, hch@infradead.org,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        syzkaller-bugs@googlegroups.com, tklauser@nuerscht.ch,
        trond.myklebust@fys.uio.no, viro@zeniv.linux.org.uk
References: <0000000000007f489b0595115374@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007f489b0595115374@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 06:42:11PM -0700, syzbot wrote:
> ==================================================================
> BUG: KASAN: use-after-free in mnt_warn_timestamp_expiry+0x4a/0x250
> fs/namespace.c:2471
> Read of size 8 at addr ffff888099937328 by task syz-executor.1/18510
> 

Looks like a duplicate of this:

#syz dup: KASAN: use-after-free Read in do_mount

See the existing thread and proposed fix here:
https://lkml.kernel.org/linux-fsdevel/000000000000805e5505945a234b@google.com/T/#u

- Eric
