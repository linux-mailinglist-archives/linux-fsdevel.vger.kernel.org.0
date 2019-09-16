Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3179B3F80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 19:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfIPRQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 13:16:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59650 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfIPRQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:16:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9ube-0001uZ-DH; Mon, 16 Sep 2019 17:16:06 +0000
Date:   Mon, 16 Sep 2019 18:16:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>, LKP <lkp@01.org>
Subject: Re: 266a9a8b41: WARNING:possible_recursive_locking_detected
Message-ID: <20190916171606.GA1131@ZenIV.linux.org.uk>
References: <20190914161622.GS1131@ZenIV.linux.org.uk>
 <20190916020434.tutzwipgs4f6o3di@inn2.lkp.intel.com>
 <20190916025827.GY1131@ZenIV.linux.org.uk>
 <20190916030355.GZ1131@ZenIV.linux.org.uk>
 <CAHk-=wii2apAb9WHCaOt8vnQjk8yXAHnMEC6im0f0YiEF4PwOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wii2apAb9WHCaOt8vnQjk8yXAHnMEC6im0f0YiEF4PwOA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 15, 2019 at 08:44:05PM -0700, Linus Torvalds wrote:
> On Sun, Sep 15, 2019 at 8:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Perhaps lockref_get_nested(struct lockref *lockref, unsigned int subclass)?
> > With s/spin_lock/spin_lock_nested/ in the body...
> 
> Sure. Under the usual CONFIG_DEBUG_LOCK_ALLOC, with the non-debug case
> just turning into a regular lockref_get().
> 
> Sounds fine to me.

Done and force-pushed into vfs.git#fixes
