Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404CB116FB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 15:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLIOz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 09:55:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:41426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfLIOz1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:55:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 010EEAC52;
        Mon,  9 Dec 2019 14:55:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 85054DA783; Mon,  9 Dec 2019 15:55:14 +0100 (CET)
Date:   Mon, 9 Dec 2019 15:55:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
Message-ID: <20191209145512.GH2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz>
 <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 06, 2019 at 01:04:01PM -0800, Linus Torvalds wrote:
> On Fri, Dec 6, 2019 at 12:28 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I think I found it.
> >
> > TOTALLY UNTESTED patch appended. It's whitespace-damaged and may be
> > completely wrong. And might not fix it.
> 
> Well, it compiles, and it's obviously correct, so I've committed it.

Thanks for the fix, works for me too.
