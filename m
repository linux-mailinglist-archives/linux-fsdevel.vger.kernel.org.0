Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC391154F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 17:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFQSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 11:18:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:38540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbfLFQSs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:18:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D39FDB250;
        Fri,  6 Dec 2019 16:18:47 +0000 (UTC)
Date:   Fri, 6 Dec 2019 17:18:46 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it, linux-fsdevel@vger.kernel.org
Subject: Re: [LTP] [PATCH] syscalls/newmount: new test case for new mount API
Message-ID: <20191206161846.GC729@rei.lan>
References: <20191128173532.6468-1-zlang@redhat.com>
 <20191203130339.GF2844@rei>
 <20191206162332.GH4601@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206162332.GH4601@dhcp-12-102.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> Sorry I can't be 100% sure what you mean at here. Do you mean as this:
> --
> TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
> if (TST_RET < 0) {
> 	tst_brk(TFAIL | TTERRNO,
> 		"fsopen %s", tst_device->fs_type);
> }
> sfd = TST_RET;
> tst_res(TPASS, "fsopen %s", tst_device->fs_type);

Yes, indeed. The tst_brk() calls exit() so it never returns back to the
caller.

-- 
Cyril Hrubis
chrubis@suse.cz
