Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9A2A05F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 23:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404263AbfEXV1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 17:27:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53174 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404163AbfEXV1p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 17:27:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so10709951wmm.2;
        Fri, 24 May 2019 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y9ux/6s5mqKpo3SGmaASVq5a3/znJngTKz9dxsY6Ors=;
        b=omEJrnMwXjBomP4BtaaCk/eahP4koX6r9N/1FRZFbAIeIEejhvE2xj11PA1ZGUmirI
         P1LAT+/s4Rfq71eZQ/EX0iXP+V8Hfrs6mDbooVcuextI7ReAKBae9Lyw6fmipHr3iZ8F
         Yn+jYqg8fnQuHMF/YhMnjgUZShVc/DqDuWGyAUcK0XNIzO/aSTv4Pc+QlK2PDBllUX1+
         Sk1tbDsdU87eYGD6n6E9jIQJdoR8X3BZsx1owMCdIv5cj8CCZbMEJoL47ABToHMmYDV9
         W6fLBNA/j+oOorGBbQtIBrMiI+yCs90gT/VlKkPj+2gz0PuF/aQf/R7AGGTM4eEJGEFQ
         8Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y9ux/6s5mqKpo3SGmaASVq5a3/znJngTKz9dxsY6Ors=;
        b=ib+5oKIPNfbxUApWGsnXQo+LuFf9JgQlv+E6JLlvFdPHD3nvtUoAofiuKZl+P77inY
         heCdJALOK/kWv7IqxPgKGTDtZKAaxyoL9gZ5hxO7o1t+kTiozLUR32a2RtUnZMgwzHt1
         pPM1iCZXhYiXgh5FXXSlJPsk6mXTiOEJxzTcp2lqrPuCh0MRPK7erMMXric/JTL39GRK
         BpMsvs7bBsI3ey6LlMusR0Upf0zWswLLoSn2/J6ZfJRPnDSX5DdFcskQpDOmcovrTNkV
         mUrnFscTtMa5phl3RkrQGAm/hcmfqhrUbh0WZZUSNSbb+wpcPp71oEq2f6xdKIYM0ACU
         9snw==
X-Gm-Message-State: APjAAAX7fckNvEw3TzLwIb5eQ1OOKYmUHjKlIPLTdWdJAZPoRYaSPCRr
        +i4M1xmPRGAi94kQmP4UNq5PEzs=
X-Google-Smtp-Source: APXvYqyK2ayCbgVB5WtHhnVxNe6zHQgykGJ0C9c2YZvQtzxbgh+2+uSTMs+0rCT1FVbeCl9VyZ9/UA==
X-Received: by 2002:a05:600c:2289:: with SMTP id 9mr18657802wmf.106.1558733263578;
        Fri, 24 May 2019 14:27:43 -0700 (PDT)
Received: from avx2 ([46.53.253.112])
        by smtp.gmail.com with ESMTPSA id b2sm3371534wrt.20.2019.05.24.14.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 14:27:42 -0700 (PDT)
Date:   Sat, 25 May 2019 00:27:40 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] close_range()
Message-ID: <20190524212740.GA7165@avx2>
References: <20190523182152.GA6875@avx2>
 <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
 <20190524183903.GB2658@avx2>
 <CAHk-=wjaCygWXyGP-D2=ER0x8UbwdvyifH2Jfnf1KHUwR3sedw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjaCygWXyGP-D2=ER0x8UbwdvyifH2Jfnf1KHUwR3sedw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 24, 2019 at 11:55:44AM -0700, Linus Torvalds wrote:
> On Fri, May 24, 2019 at 11:39 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > > Would there ever be any other reason to traverse unknown open files
> > > than to close them?
> >
> > This is what lsof(1) does:
> 
> I repeat: Would there ever be any other reason to traverse unknown
> open files than to close them?
> 
> lsof is not AT ALL a relevant argument.
> 
> lsof fundamentally wants /proc, because lsof looks at *other*
> processes. That has absolutely zero to do with fdmap. lsof does *not*
> want fdmap at all. It wants "list other processes files". Which is
> very much what /proc is all about.
> 
> So your argument that "fdmap is more generic" is bogus.
> 
> fdmap is entirely pointless unless you can show a real and relevant
> (to performance) use of it.
> 
> When you would *possibly* have a "let me get a list of all the file
> descriptors I have open, because I didn't track them myself"
> situation?  That makes no sense. Particularly from a performance
> standpoint.
> 
> In contrast, "close_range()" makes sense as an operation.

What about orthogonality of interfaces?

	fdmap()
	bulk_close()

Now fdmap() can be reused for lsof/criu and it is only 2 system calls
for close-everything usecase which is OK because readdir is 4(!) minimum:

	open
	getdents
	getdents() = 0
	close

Writing all of this I understood how fdmap can be made more faster which
neither getdents() nor even read() have the luxury of: it can return
a flag if more data is available so that application would do next fdmap()
only if truly necessary.

> I can
> explain exactly when it would be used, and I can easily see a
> situation where "I've opened a ton of files, now I want to release
> them" is a valid model of operation. And it's a valid optimization to
> do a bulk operation like that.
> 
> IOW, close_range() makes sense as an operation even if you could just
> say "ok, I know exactly what files I have open". But it also makes
> sense as an operation for the case of "I don't even care what files I
> have open, I just want to close them".
> 
> In contrast, the "I have opened a ton of files, and I don't even know
> what the hell I did, so can you list them for me" makes no sense.
> 
> Because outside of "close them", there's no bulk operation that makes
> sense on random file handles that you don't know what they are. Unless
> you iterate over them and do the stat thing or whatever to figure it
> out - which is lsof, but as mentioned, it's about *other* peoples
> files.

What you're doing is making exactly one usecase take exactly one system
call and leaving everything else deal with /proc. Stracing lsof shows
very clearly how stupid and how wasteful it is. Especially now that
we're post-meltdown era caring about system call costs (yeah suure).

I'm suggesting make close-universe usecase take only 2 system calls.
which is still better than anything /proc can offer.
