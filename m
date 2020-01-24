Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBCD148D61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 19:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391115AbgAXSDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 13:03:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389561AbgAXSDZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:03:25 -0500
Received: from localhost (unknown [104.132.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B63C12072C;
        Fri, 24 Jan 2020 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579889004;
        bh=oVdt0AydXA7suK5u7WiRV7oRH1hbokRTp4g30Tso34Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eddd49ULHT0W1wmLkSOIMvil+ujKKTFlRcVAfjMPQcjsT7l1KLA2XAeLL6KtpxyS8
         E04n69szM0GdhIJa+C/ao5LfM72pj5ZooXvUx3kmi3mIBIFw78I5IgGHOQGnbl2fdG
         Q3JmMARP4WMTfkLhFDVvVLHhiLRcLftsVnO6M46k=
Date:   Fri, 24 Jan 2020 10:03:23 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: oopsably broken case-insensitive support in ext4 and f2fs (Re:
 vfat: Broken case-insensitive support for UTF-8)
Message-ID: <20200124180323.GA33470@jaegeuk-macbookpro.roam.corp.google.com>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120073040.GZ8904@ZenIV.linux.org.uk>
 <20200120074558.GA8904@ZenIV.linux.org.uk>
 <20200120080721.GB8904@ZenIV.linux.org.uk>
 <20200120193558.GD8904@ZenIV.linux.org.uk>
 <20200124042953.GA832@sol.localdomain>
 <CAHk-=wgwFMW09uz0HLUuQFMpi_UYtKAUvcCJ-oxyVqybry1=Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgwFMW09uz0HLUuQFMpi_UYtKAUvcCJ-oxyVqybry1=Ng@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/24, Linus Torvalds wrote:
> On Thu, Jan 23, 2020 at 8:29 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Thanks Al.  I sent out fixes for this:
> 
> How did that f2fs_d_compare() function ever work? It was doing the
> memcmp on completely the wrong thing.

Urg.. my bad. I didn't do enough stress test on casefolding case which
is only activated given "mkfs -C utf8:strict". And Android hasn't enabled
it yet.

> 
>               Linus
