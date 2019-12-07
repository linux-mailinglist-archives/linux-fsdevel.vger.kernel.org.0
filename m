Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD3115ED5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 22:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfLGVuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 16:50:07 -0500
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:40956
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfLGVuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 16:50:07 -0500
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <lnx-linux-fsdevel@m.gmane.org>)
        id 1idhxi-000wS2-SV
        for linux-fsdevel@vger.kernel.org; Sat, 07 Dec 2019 22:50:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-fsdevel@vger.kernel.org
From:   Akemi Yagi <toracat@elrepo.org>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
Date:   Sat, 7 Dec 2019 13:31:13 -0800
Message-ID: <qsh5n2$3pu9$1@blaine.gmane.org>
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz>
 <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
 <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
 <CAHk-=wj9pprDUeoJd5EeN-2x7+GXdSsm44mSv1y9f5e7MrTZ2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
In-Reply-To: <CAHk-=wj9pprDUeoJd5EeN-2x7+GXdSsm44mSv1y9f5e7MrTZ2A@mail.gmail.com>
Content-Language: en-US
Cc:     linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/6/19 10:59 AM, Linus Torvalds wrote:
> Hmm. I think I just saw this same bug with a plain kernel compile.
> 
> My "make -j32" suddenly came to a crawl, and seems to be entirely
> single-threaded.
> 
> And that's almost certainly because the way 'make' handles load
> distribution is with a network of pipes that has a token passed to the
> sub-makes.
> 
> So there's most definitely something wrong with the new pipe rework.
> Well, I can't _guarantee_ the pipes are the cause of this, but it does
> smell like it.
> 
>                Linus
> 

We encountered what seems to be the same problem when building a kernel
under RHEL 8.

As it turned out, this was due to a bug in make (make-4.2.1-9.el8) and
a patch is available. Details are found in this Red Hat bugzilla report:

https://bugzilla.redhat.com/show_bug.cgi?id=1774790

Akemi

