Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EF27BD03A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 23:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjJHVVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 17:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjJHVVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:21:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5771AC;
        Sun,  8 Oct 2023 14:21:35 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c63117a659so2205272a34.0;
        Sun, 08 Oct 2023 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696800095; x=1697404895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tFkgfW4cZbNG3g5YvrO+dBVaVKzGdwwIuQTmQTY0jc=;
        b=J2T6ECoZ2NQ6jQK317KDWj5GB1bRHagjHXju3Uj80aoxQ08+3krVPYJzsZFRDdKhgH
         brYhhqc2WkItqIha8tre4HCmBJo1LxFGvXpv8Ge9A5AkQ4gnbah8TbLX7MFMH0Nd/0fg
         0ucF7qCpbqZrQw3F/Z1pxfNaGnjWDFDeDzYfrgcFgVG9w5/ZvS9EAssP9hDYiEr3aSmD
         b6Cb8Bv3uMTULzBBXoowJyrlftVRdvQDWvGIajZ00xTjdoOyKPRayTKZ/njjW1UjIVIn
         XaL9M9xZxz12Mx8cexXc5XpeRm05Fbf8aEQgnpJbGH2DcDEec8EvxhDyTUkQ5ENlLPDw
         gOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696800095; x=1697404895;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tFkgfW4cZbNG3g5YvrO+dBVaVKzGdwwIuQTmQTY0jc=;
        b=GHFJCMhnhaveJrU479uVF93+QnRC8BAbHmPNwhdgrMVp1U9DTl1gX6OoQDR8PTWmkU
         V6RPNbCg3Ybb0hzaFlLHoaK6xVN/V7USZMEH87n0fXIcoKAm7n3POxJ4vPClmjgthynn
         47AegXE+duNJf62P+Hv0k5ouLmUJvkWO+3dccLhiXpEDR/n533zppl3zHsgZPwSF3o9p
         dGgyR9baANU1nYau4X08GemM0c201Xy2pAIy78j3QHpVSUfNBqEX7GGb4sLobRWppbsB
         cwHLpjK1W3LI6Blzb31JLzp7Ks7Sz9kZ2mMnP6+qEbQNDhfDgnNXOxWh8g29P8nx/hIr
         4NrQ==
X-Gm-Message-State: AOJu0YwhYshEUex9WpuZfY4KCGV3HCIbyAdceqWiemrJhAAFwOYHuJtv
        2tnTtqhEiBsrfXArlHPLwSQioW2mxOl4QJzkl44=
X-Google-Smtp-Source: AGHT+IG2X00Izsq8yJBHpE/SbCtPB2p4GnsaqwRMKU+ZKdCHKskj69ge6judSTj8+aIg/9Lz64Olraz14Kpd2Ju2OVY=
X-Received: by 2002:a9d:6d0d:0:b0:6c4:6aef:cd58 with SMTP id
 o13-20020a9d6d0d000000b006c46aefcd58mr12438764otp.8.1696800095162; Sun, 08
 Oct 2023 14:21:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5786:0:b0:4f0:1250:dd51 with HTTP; Sun, 8 Oct 2023
 14:21:34 -0700 (PDT)
In-Reply-To: <ZSMZkuJGgHyyqDWP@casper.infradead.org>
References: <20231007203543.1377452-1-willy@infradead.org> <20231007203543.1377452-6-willy@infradead.org>
 <CAGudoHEg7oWG8CuyivWRsWLZZtw51oY0=PjLPRzFZDDZf=kzGg@mail.gmail.com> <ZSMZkuJGgHyyqDWP@casper.infradead.org>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sun, 8 Oct 2023 23:21:34 +0200
Message-ID: <CAGudoHGVa2qjkOB25whVquRtgUN7sJtEuqUGDoVe_18RdYwSTw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fs: Add inode_assert_locked() and inode_assert_locked_excl()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/23, Matthew Wilcox <willy@infradead.org> wrote:
> On Sun, Oct 08, 2023 at 10:26:40PM +0200, Mateusz Guzik wrote:
>> On 10/7/23, Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
>> > +static inline void inode_assert_locked_excl(const struct inode *inode)
>> > +{
>> > +	rwsem_assert_held_write(&inode->i_rwsem);
>> > +}
>> > +
>> >  static inline void inode_lock_nested(struct inode *inode, unsigned
>> > subclass)
>> >  {
>> >  	down_write_nested(&inode->i_rwsem, subclass);
>>
>> Why "excl" instead of "write"? Apart from looking weird, it is
>> inconsistent with "prior art" in the file: i_mmap_assert_write_locked.
>
> Yes, but that pairs with i_mmap_lock_write() / i_mmap_lock_read().
>
> The problem is that we have inode_lock() / inode_lock_shared()
> inode_assert_locked_read/write doesn't make sense with them.  But
> inode_assert_locked() doesn't make sense as the assertion for
> inode_lock() because you'd expect it to assert whether the inode lock
> is held at all.  So I went with inode_assert_locked_excl().
>
> I wouldn't mind if we converted all the inode_lock()/shared to
> inode_lock_read() / inode_lock_write(), and then added
> inode_assert_read_locked() / inode_assert_write_locked().  That's
> a bit of a bigger job than I want to take on today.
>

I agree it is rather messy and I'm not going to spend time arguing as
it is not my call anyway.

Speaking of that, I just noticed the vfs folk are not CC'ed, which I'm
rectifying with this e-mail.

-- 
Mateusz Guzik <mjguzik gmail.com>
