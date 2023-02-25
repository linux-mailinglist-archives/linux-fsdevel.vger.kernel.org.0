Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E26A270F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 04:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBYDpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 22:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBYDpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:45:10 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E9012BE8;
        Fri, 24 Feb 2023 19:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uc3f7MDWgd9pQwc3G0+8MoEdfDhcHT7tsaqX4kovyng=; b=J8IMhgU2pv4QE22gSGyxtHWGKG
        A9Qay07wm+6Y8oilP1VAOZHlemKdFVVzPnazS4wdBnuApAlPjnJndziyfL2a71T+FbKKGOkW0T/pV
        mnJRwTPmIJDVlYZj5uXbKpk0/wIpbbMeYm/y6Kusz6R3qOjtDRFevHuxlcyQVaQ/HxNHlKHoNcUoH
        i3wPZZim+RGWrHOSeOrJC/tjTBhNO6hFsWhoaezZixcb7yuKi30u74CszESqlMycGfwC6NEwpmuDT
        cvg/TX5RIQuGjtjRZkiGQToy9fXe9Yr43JiUzIrtp/1VCYPZWmm77CGYnN2XJaQqTNo7JlX/nnpn8
        6OaukTEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pVlUg-00CApw-09;
        Sat, 25 Feb 2023 03:45:06 +0000
Date:   Sat, 25 Feb 2023 03:45:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git misc bits
Message-ID: <Y/mEQUfLqf8m2s/G@ZenIV>
References: <Y/gxyQA+yKJECwyp@ZenIV>
 <CAHk-=wiPHkYmiFY_O=7MK-vbWtLEiRP90ufugj1H1QFeiLPoVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPHkYmiFY_O=7MK-vbWtLEiRP90ufugj1H1QFeiLPoVw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 24, 2023 at 07:33:12PM -0800, Linus Torvalds wrote:
> On Thu, Feb 23, 2023 at 7:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > That should cover the rest of what I had in -next; I'd been sick for
> > several weeks, so a lot of pending stuff I hoped to put into -next
> > is going to miss this window ;-/
> 
> Does that include the uaccess fixes for weird architectures?
> 
> I was hoping that was coming...

Missed -next; I'll look for tested-by/reviewed-by/etc. and put the same
patches into #fixes; we have a week until the end of merge window, and
those are fixes, after all...
