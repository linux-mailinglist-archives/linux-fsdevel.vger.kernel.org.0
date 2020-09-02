Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE2225AFE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgIBPrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:47:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:33298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbgIBPrA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:47:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A86E6AC5E;
        Wed,  2 Sep 2020 15:46:59 +0000 (UTC)
Date:   Wed, 02 Sep 2020 17:46:58 +0200
Message-ID: <s5hv9gw89l9.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     maz@kernel.org, alsa-devel@alsa-project.org,
        dan.carpenter@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, o-takashi@sakamocchi.jp,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Subject: Re: general protection fault in snd_ctl_release
In-Reply-To: <20200902153530.GK1236603@ZenIV.linux.org.uk>
References: <000000000000c15ee205ae4f2531@google.com>
        <s5h36409pbb.wl-tiwai@suse.de>
        <20200902153530.GK1236603@ZenIV.linux.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 02 Sep 2020 17:35:30 +0200,
Al Viro wrote:
> 
> On Wed, Sep 02, 2020 at 05:22:00PM +0200, Takashi Iwai wrote:
> 
> > Marc, Al, could you guys check this bug?
> 
> That's racy; the first one should be get_file_rcu() instead of
> file_count()+get_file(), the second is not needed at all (we
> have the file pinned down by the caller).

Yeah, that wasn't meant as a fix, of course :)


> See vfs.git#work.epoll
> for fix

Thanks!  I'll try to run with this fix.


Takashi
