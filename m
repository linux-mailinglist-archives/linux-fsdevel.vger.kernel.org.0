Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D67F7A054D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 15:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbjINNQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbjINNQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:16:55 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF71FE9;
        Thu, 14 Sep 2023 06:16:51 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1d643db2c98so137446fac.0;
        Thu, 14 Sep 2023 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694697411; x=1695302211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f/fIfnv43Rgci7QQDHXQs3jElfPN1XhQroFdJ1qxmS8=;
        b=qVbP/IADbBqX1sp7mRcdolsR9Y+v94GBTj0Mh3a8emauxAn+QqbdQBSe47jEjQs0cS
         wS4SfDgLYaRMgPl2PrGrZtUFMeSoxqLAxXdpC4yNNrI0OXIEwnach76sgQS3yMoyexnX
         8snIveRelfaLfn31P+TiFgFoMUjEJK91gQFyp605xKmt7dkxjFwS+v5YwqyoAYu8imIn
         4Cag32wWM4W8mZa5yDAbR1QDYAw2BGYfPRm96F02ph8C7D50BrPnVwzh3uvTjrZazlOi
         SFb+us9K/gAOKt6wtSA0yfrebwDUibWH8HXzUx9d3vlhp2I4aaLS0ofF0NSHJmVeL5G/
         L4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694697411; x=1695302211;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/fIfnv43Rgci7QQDHXQs3jElfPN1XhQroFdJ1qxmS8=;
        b=PohO7nMxSqzN6/js3iS0VY7ZgVQNcv4gEWOwyJyF49r1BoZui5zFBYZdZKUU0DH2oN
         D3pRYDupeUO1828CsGFOTYww+05zOVNXQc2rt6Z71aPVPwookiT3cZUxiQVKXN8pXKBz
         PEvTighlS5y7NEcgjkU0Y7nA0f+RvPX5IVA+0xEjiMgZ7wVSI3k9W/3xQUW7QotHCEgd
         ZEpHYM1CopQIT2yJdALwZ+3u6i8EO7xw3Y0Ag7EPVqDOO5tIk8wkCxU6+uLclbo94Jdg
         8EXHQVP7Q/sSsMH7jM0m4IhqDZBb8lLL0TvVjCW2g7aaRrBAcdv+kZvwIg4kLcJT1/Vh
         Lbmw==
X-Gm-Message-State: AOJu0YyO3DLEGbpVMdNWPl3HDcZGg8NS7hkyX7oQBtSRl4A67MM0MWyc
        ZTzm4SWi9xQBJNPSyMDeniXhYlji6bWP4GmWW1U=
X-Google-Smtp-Source: AGHT+IHNYwELBDMzcLHxw3+hGVqgtkHcXkz2FpJ3EibiFTijfqtTbg2quw5V21c6G32fdBK+HfDXUgP9r8y+5mdC6Wo=
X-Received: by 2002:a05:6870:472c:b0:1c8:c2df:a927 with SMTP id
 b44-20020a056870472c00b001c8c2dfa927mr6519993oaq.53.1694697411059; Thu, 14
 Sep 2023 06:16:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5750:0:b0:4f0:1250:dd51 with HTTP; Thu, 14 Sep 2023
 06:16:50 -0700 (PDT)
In-Reply-To: <ZPiaYjcTMyuM0JL5@casper.infradead.org>
References: <20230831151414.2714750-1-mjguzik@gmail.com> <ZPiYp+t6JTUscc81@casper.infradead.org>
 <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm> <ZPiaYjcTMyuM0JL5@casper.infradead.org>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 14 Sep 2023 15:16:50 +0200
Message-ID: <CAGudoHGU0=BhHzzGrkzt22J0iC5YCcujY-koL+Eq7Uiga6Lh9g@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/23, Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Sep 06, 2023 at 05:23:42PM +0200, Bernd Schubert wrote:
>>
>>
>> On 9/6/23 17:20, Matthew Wilcox wrote:
>> > On Thu, Aug 31, 2023 at 05:14:14PM +0200, Mateusz Guzik wrote:
>> > > +++ b/include/linux/fs.h
>> > > @@ -842,6 +842,16 @@ static inline void
>> > > inode_lock_shared_nested(struct inode *inode, unsigned subcla
>> > >   	down_read_nested(&inode->i_rwsem, subclass);
>> > >   }
>> > > +static inline void inode_assert_locked(struct inode *inode)
>> > > +{
>> > > +	lockdep_assert_held(&inode->i_rwsem);
>> > > +}
>> > > +
>> > > +static inline void inode_assert_write_locked(struct inode *inode)
>> > > +{
>> > > +	lockdep_assert_held_write(&inode->i_rwsem);
>> > > +}
>> >
>> > This mirrors what we have in mm, but it's only going to trigger on
>> > builds that have lockdep enabled.  Lockdep is very expensive; it
>> > easily doubles the time it takes to run xfstests on my laptop, so
>> > I don't generally enable it.  So what we also have in MM is:
>> >
>> > static inline void mmap_assert_write_locked(struct mm_struct *mm)
>> > {
>> >          lockdep_assert_held_write(&mm->mmap_lock);
>> >          VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>> > }
>> >
>> > Now if you have lockdep enabled, you get the lockdep check which
>> > gives you all the lovely lockdep information, but if you don't, you
>> > at least get the cheap check that someone is holding the lock at all.
>> >
>> > ie I would make this:
>> >
>> > +static inline void inode_assert_write_locked(struct inode *inode)
>> > +{
>> > +	lockdep_assert_held_write(&inode->i_rwsem);
>> > +	WARN_ON_ONCE(!inode_is_locked(inode));
>> > +}
>> >
>> > Maybe the locking people could give us a rwsem_is_write_locked()
>> > predicate, but until then, this is the best solution we came up with.
>>
>>
>> Which is exactly what I had suggested in the other thread :)
>
> Yes, but apparently comments in that thread don't count :eyeroll:
>

Pretty weird reaction mate, they very much *do* count which is why I'm
confused why you resent an e-mail with the bogus is_locked check
(which I explicitly pointed out).

Since you posted a separate patch to add write-locking check to rwsem
I'm going to wait for that bit to get sorted out (unless it stalls for
a long time).

fwiw I'm confused what's up with people making kernel changes without
running lockdep. If it adds too much overhead for use in normal
development someone(tm) should have fixed that aspect long time ago.

-- 
Mateusz Guzik <mjguzik gmail.com>
