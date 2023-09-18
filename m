Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483BF7A526A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjIRS4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjIRS4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:56:47 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740F310F;
        Mon, 18 Sep 2023 11:56:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso437269b3a.0;
        Mon, 18 Sep 2023 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695063401; x=1695668201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIS1GFpqDB1c/94phXmILGCKn2z3UAnormHxhEj0fhM=;
        b=kCGGtxJYS0cl0quhd1wewLdefj4xTypoOcFKolWuxzbK9h4mXAtBuSZqWlOCr4jKMo
         er6o7YokfRZ/O0V1Cou2mMCSjQtmjQXEHV7bXOprn5To36BtEKAqP4WAhkUrxw79Crz8
         LEXPYrAN8Gy1ZoTe4s1LnrEZi1G8TXN+pcqUtmn7v7HGgGPxPRa+u8BPHyglZl+MWniX
         d4ShBj3E3NslqYnQG3Uan6uiWxqANSwudkc6Vec4HNZWl6sY2o7bSThqhnQQBzb24Ekd
         X0/89Mxpk4Xn3mrMXpkLnILDnJIC+M0JBMT7OCZeQRAsya/sXLZ0J7pgKsdlQT2C5zJV
         lzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063401; x=1695668201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIS1GFpqDB1c/94phXmILGCKn2z3UAnormHxhEj0fhM=;
        b=L7/8UOj6o35WqxQoS9wGf/n+ZS3mum4QDjb6evM2h7eAkyaeM1+BzD1fhhFohbolsh
         I7RFzwo77RpIzKIXBU/Vj6t9DR+dU+K7yWjX5hCgbEpbM2gEKSTX1dgNMjLNSh1l9xNU
         CUEPFzB7CA9Ez+7t/vJdnNaz9SGHO51AGwKu0veOXzvJN63WRN644nhKPKe4nH97VdTm
         DfUcjlA34XUJDszYZFLTlhwu2X2gxdz/dMxc0TahwVL8X8etDmD9o5fqpWd44TqdJU7N
         OGJtq0RAeBjq3rj2Xse96fwGqtqh9gND1LfPd8+yymZ2WkVsPEZRWIZCQKkYIWqJU4h7
         eCeQ==
X-Gm-Message-State: AOJu0YzIUfV3J1V3gUc4y3wcKW/8zDk49TApJbY7kUfd9G3BGq8DUizX
        hmEDWbd9lJIdsNAluhspyi8=
X-Google-Smtp-Source: AGHT+IERmhl0QL4j7dG4JO6RXuiu5Kh432AbWN83ydAdAa9lkQ9nKzGmWkFwx7AatWzvyDE0rjGeTg==
X-Received: by 2002:a05:6a00:309e:b0:68f:b769:9182 with SMTP id bh30-20020a056a00309e00b0068fb7699182mr483932pfb.9.1695063400803;
        Mon, 18 Sep 2023 11:56:40 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78043000000b0068c61848785sm7414772pfm.208.2023.09.18.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:56:40 -0700 (PDT)
Date:   Mon, 18 Sep 2023 11:56:36 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Jan Kara <jack@suse.cz>, Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
Message-ID: <ZQidZLUcrrITd3Vy@yury-ThinkPad>
References: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
 <20230918094116.2mgquyxhnxcawxfu@quack3>
 <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
 <20230918113840.h3mmnuyer44e5bc5@quack3>
 <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
 <ZQhlt/EbRf3Y+0jT@yury-ThinkPad>
 <20230918155403.ylhfdbscgw6yek6p@quack3>
 <cda628df-1933-cce8-86cd-23346541e3d8@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda628df-1933-cce8-86cd-23346541e3d8@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 06:28:07PM +0200, Mirsad Todorovac wrote:
> 
> 
> On 9/18/23 17:54, Jan Kara wrote:
> > On Mon 18-09-23 07:59:03, Yury Norov wrote:
> > > On Mon, Sep 18, 2023 at 02:46:02PM +0200, Mirsad Todorovac wrote:
> > > > --------------------------------------------------------
> > > >   lib/find_bit.c | 33 +++++++++++++++++----------------
> > > >   1 file changed, 17 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/lib/find_bit.c b/lib/find_bit.c
> > > > index 32f99e9a670e..56244e4f744e 100644
> > > > --- a/lib/find_bit.c
> > > > +++ b/lib/find_bit.c
> > > > @@ -18,6 +18,7 @@
> > > >   #include <linux/math.h>
> > > >   #include <linux/minmax.h>
> > > >   #include <linux/swab.h>
> > > > +#include <asm/rwonce.h>
> > > >   /*
> > > >    * Common helper for find_bit() function family
> > > > @@ -98,7 +99,7 @@ out:                                                                          \
> > > >    */
> > > >   unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
> > > >   {
> > > > -       return FIND_FIRST_BIT(addr[idx], /* nop */, size);
> > > > +       return FIND_FIRST_BIT(READ_ONCE(addr[idx]), /* nop */, size);
> > > >   }
> > > >   EXPORT_SYMBOL(_find_first_bit);
> > > >   #endif
> > > 
> > > ...
> > > 
> > > That doesn't look correct. READ_ONCE() implies that there's another
> > > thread modifying the bitmap concurrently. This is not the true for
> > > vast majority of bitmap API users, and I expect that forcing
> > > READ_ONCE() would affect performance for them.
> > > 
> > > Bitmap functions, with a few rare exceptions like set_bit(), are not
> > > thread-safe and require users to perform locking/synchronization where
> > > needed.
> > 
> > Well, for xarray the write side is synchronized with a spinlock but the read
> > side is not (only RCU protected).
> > 
> > > If you really need READ_ONCE, I think it's better to implement a new
> > > flavor of the function(s) separately, like:
> > >          find_first_bit_read_once()
> > 
> > So yes, xarray really needs READ_ONCE(). And I don't think READ_ONCE()
> > imposes any real perfomance overhead in this particular case because for
> > any sane compiler the generated assembly with & without READ_ONCE() will be
> > exactly the same. For example I've checked disassembly of _find_next_bit()
> > using READ_ONCE(). The main loop is:
> > 
> >     0xffffffff815a2b6d <+77>:	inc    %r8
> >     0xffffffff815a2b70 <+80>:	add    $0x8,%rdx
> >     0xffffffff815a2b74 <+84>:	mov    %r8,%rcx
> >     0xffffffff815a2b77 <+87>:	shl    $0x6,%rcx
> >     0xffffffff815a2b7b <+91>:	cmp    %rcx,%rax
> >     0xffffffff815a2b7e <+94>:	jbe    0xffffffff815a2b9b <_find_next_bit+123>
> >     0xffffffff815a2b80 <+96>:	mov    (%rdx),%rcx
> >     0xffffffff815a2b83 <+99>:	test   %rcx,%rcx
> >     0xffffffff815a2b86 <+102>:	je     0xffffffff815a2b6d <_find_next_bit+77>
> >     0xffffffff815a2b88 <+104>:	shl    $0x6,%r8
> >     0xffffffff815a2b8c <+108>:	tzcnt  %rcx,%rcx
> > 
> > So you can see the value we work with is copied from the address (rdx) into
> > a register (rcx) and the test and __ffs() happens on a register value and
> > thus READ_ONCE() has no practical effect. It just prevents the compiler
> > from doing some stupid de-optimization.
> > 
> > 								Honza
> 
> If I may also add, centralised READ_ONCE() version had fixed a couple of hundred of
> the instances of KCSAN data-races in dmesg.
> 
> _find_*_bit() functions and/or macros cause quite a number of KCSAN BUG warnings:
> 
>  95 _find_first_and_bit (lib/find_bit.c:114 (discriminator 10))
>  31 _find_first_zero_bit (lib/find_bit.c:125 (discriminator 10))
> 173 _find_next_and_bit (lib/find_bit.c:171 (discriminator 2))
> 655 _find_next_bit (lib/find_bit.c:133 (discriminator 2))
>   5 _find_next_zero_bit
> 
> Finding each one find_bit_*() function and replacing it with find_bit_*_read_once()
> could be time-consuming and challenging.
> 
> However, I will do both versions so you could compare, if you'd like.
> 
> Note, in the PoC version I have only implemented find_next_bit_read_once() ATM to see if
> this works.
> 
> Regards,
> Mirsad

Guys, I lost the track of the conversation. In the other email Mirsad
said:
        Which was the basic reason in the first place for all this, because something changed
        data from underneath our fingers ..

It sounds clearly to me that this is a bug in xarray, *revealed* by
find_next_bit() function. But later in discussion you're trying to 'fix'
find_*_bit(), like if find_bit() corrupted the bitmap, but it's not.

In previous email Jan said:
        for any sane compiler the generated assembly with & without READ_ONCE()
        will be exactly the same.

If the code generated with and without READ_ONCE() is the same, the
behavior would be the same, right? If you see the difference, the code
should differ.

You say that READ_ONCE() in find_bit() 'fixes' 200 KCSAN BUG warnings. To
me it sounds like hiding the problems instead of fixing. If there's a race
between writing and reading bitmaps, it should be fixed properly by
adding an appropriate serialization mechanism. Shutting Kcsan up with
READ_ONCE() here and there is exactly the opposite path to the right direction.

Every READ_ONCE must be paired with WRITE_ONCE, just like atomic
reads/writes or spin locks/unlocks. Having that in mind, adding
READ_ONCE() in find_bit() requires adding it to every bitmap function
out there. And this is, as I said before, would be an overhead for
most users.
