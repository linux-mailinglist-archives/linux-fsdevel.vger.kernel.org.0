Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581C3214867
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGDTaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 15:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDTaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 15:30:46 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE122C061794;
        Sat,  4 Jul 2020 12:30:45 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrns0-005NRw-HY; Sat, 04 Jul 2020 19:30:40 +0000
Date:   Sat, 4 Jul 2020 20:30:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200704193040.GC2786714@ZenIV.linux.org.uk>
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704140250.423345-1-gregkh@linuxfoundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 04, 2020 at 04:02:46PM +0200, Greg Kroah-Hartman wrote:
> Here is a tiny new syscall, readfile, that makes it simpler to read
> small/medium sized files all in one shot, no need to do open/read/close.
> This is especially helpful for tools that poke around in procfs or
> sysfs, making a little bit of a less system load than before, especially
> as syscall overheads go up over time due to various CPU bugs being
> addressed.

Nice series, but you are 3 months late with it...  Next AFD, perhaps?

Seriously, the rationale is bollocks.  If the overhead of 2 extra
syscalls is anywhere near the costs of the real work being done by
that thing, we have already lost and the best thing to do is to
throw the system away and start with saner hardware.
