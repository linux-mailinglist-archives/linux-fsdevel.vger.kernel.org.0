Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C056A1E897D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 23:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgE2VGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 17:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgE2VGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 17:06:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12499C03E969;
        Fri, 29 May 2020 14:06:50 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jemDI-0008PV-6I; Fri, 29 May 2020 21:06:48 +0000
Date:   Fri, 29 May 2020 22:06:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
Message-ID: <20200529210648.GJ23230@ZenIV.linux.org.uk>
References: <20200529000345.GV23230@ZenIV.linux.org.uk>
 <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk>
 <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
 <20200529014753.GZ23230@ZenIV.linux.org.uk>
 <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
 <20200529031036.GB23230@ZenIV.linux.org.uk>
 <CAHk-=wgM0KbsiYd+USqbiDgW8WyvAFMfLXMgebc7Z+-Q6WjZqQ@mail.gmail.com>
 <20200529204628.GI23230@ZenIV.linux.org.uk>
 <CAHk-=wj-pyJOf1GPCvusRtW1EzRC3KAhebGYijy4iqitCMEgWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj-pyJOf1GPCvusRtW1EzRC3KAhebGYijy4iqitCMEgWg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 01:57:36PM -0700, Linus Torvalds wrote:

> > All jokes aside, when had we (or anybody else, really) _not_ gotten
> > into trouble when passing structs across the kernel boundary?  Sure,
> > sometimes you have to (stat, for example), but just look at the amount
> > of PITA stat() has spawned...
> 
> I'd rather see the struct than some ugly manual address calculations
> and casts...
> 
> Because that's fundamentally what a struct _is_, after all.

Sure; the bad idea I was refering to had been to pass the arguments from
userland that way, not the syntax used for it.  And it's obviously cast
in stone by now - userland ABI and all such...
