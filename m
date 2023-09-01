Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC78E78FC99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 13:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjIALrd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 07:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244791AbjIALrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:47:32 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED0E7F;
        Fri,  1 Sep 2023 04:47:12 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5733789a44cso1129587eaf.2;
        Fri, 01 Sep 2023 04:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693568831; x=1694173631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X7rwU6W8HFnjKISyGj3B7ytmQWd+an0LBOawg8tqKhY=;
        b=M8IF/FoB7q/jVP2hF5xNppqUARJ5kqqvLeXl6CxWPROfjx1p+XQ8KPg4yT4kzU+i3z
         hzJGhdz0dKYf3Y2zEhWXFnf4JlwpbXhIzr4Ag3kbQOHAUHMDnt2K3AoFZoPHjwJB3yzk
         ByQApXMQoQKORI6B7EgS94RdPomZezj0QLtqelWNv4eJtxX9fim7fdlmRFNstMFHV47P
         9G/zCdOwSBYcnYR6JfBHmoRjd3j/TeRrqKYNp2f80pN+oXbNGLl/0vMTA5wETZSUwhdX
         ftFn9KtuS5nMUba0I9U5hU/XYn2QDO6DtoMa9iRn2YDG2DQE0CTdyNvQasa1/Buev2E5
         LYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693568831; x=1694173631;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7rwU6W8HFnjKISyGj3B7ytmQWd+an0LBOawg8tqKhY=;
        b=UQnj7EluB/+VmjOStJlipAUI48DweqcS7hKFiCahW3z5G2PTzGenR1QCRJRRuuF3dt
         HH0SaQ5TJnzysdT5QSlzIYuSHoxEPwlzyzSp/jFzAaRTBvo1iZOkNDdJ4IhxuU2y6yl7
         /gNJoD5a4Y9yqgdY1gVLzhrXFyvWjdm5srcxTYak4IVTt7YJKbLi3yEZEa/KVZKqFMpG
         3+qL20S0fIZGuYSK0mIv2uXYdH4i3iGltk7zC34Yt9MdiufU9ZZkN3ar8xvXHOzuzJlJ
         6bnPycFFz2o+jasmvcrplx0mFUIUJRmvXYzwC3vFnvr+R3bYMT4QEfcHdAoVjl1evYmO
         vBTA==
X-Gm-Message-State: AOJu0Yz7UYcvPDaZR65XoaUuAZR9ay7F6OjhRsG9jjGhv/Ertu6qs6PN
        h6ZSEuJb98t2AALsd+8Oo+Qv+o5m7dSbc5GN+WutmsqJAI0=
X-Google-Smtp-Source: AGHT+IELXRtKYBQn4J8XqDeAm93P0ZsCOh1TRy/ACXXKqbQNn1kjYnPBgYC25bPJUMPU/j8iRlLVF7q0KdDYV4iAk4M=
X-Received: by 2002:a4a:2b42:0:b0:571:2b86:2050 with SMTP id
 y2-20020a4a2b42000000b005712b862050mr2074351ooe.7.1693568831213; Fri, 01 Sep
 2023 04:47:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1141:0:b0:4f0:1250:dd51 with HTTP; Fri, 1 Sep 2023
 04:47:10 -0700 (PDT)
In-Reply-To: <ZPHNJVU+T79oVGY9@casper.infradead.org>
References: <20230830181519.2964941-1-bschubert@ddn.com> <20230831101824.qdko4daizgh7phav@f>
 <ZPHNJVU+T79oVGY9@casper.infradead.org>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 1 Sep 2023 13:47:10 +0200
Message-ID: <CAGudoHE6LVCFU6w6+4WHY=Bx7SSTCggzO+CihWeaRgWRy+EXtg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Use exclusive lock for file_remove_privs
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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

On 9/1/23, Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Aug 31, 2023 at 12:18:24PM +0200, Mateusz Guzik wrote:
>> So I figured an assert should be there on the write lock held, then the
>> issue would have been automagically reported.
>>
>> Turns out notify_change has the following:
>>         WARN_ON_ONCE(!inode_is_locked(inode));
>>
>> Which expands to:
>> static inline int rwsem_is_locked(struct rw_semaphore *sem)
>> {
>>         return atomic_long_read(&sem->count) != 0;
>> }
>>
>> So it does check the lock, except it passes *any* locked state,
>> including just readers.
>>
>> According to git blame this regressed from commit 5955102c9984
>> ("wrappers for ->i_mutex access") by Al -- a bunch of mutex_is_locked
>> were replaced with inode_is_locked, which unintentionally provides
>> weaker guarantees.
>>
>> I don't see a rwsem helper for wlock check and I don't think it is all
>> that beneficial to add. Instead, how about a bunch of lockdep, like so:
>> diff --git a/fs/attr.c b/fs/attr.c
>> index a8ae5f6d9b16..f47e718766d1 100644
>> --- a/fs/attr.c
>> +++ b/fs/attr.c
>> @@ -387,7 +387,7 @@ int notify_change(struct mnt_idmap *idmap, struct
>> dentry *dentry,
>>         struct timespec64 now;
>>         unsigned int ia_valid = attr->ia_valid;
>>
>> -       WARN_ON_ONCE(!inode_is_locked(inode));
>> +       lockdep_assert_held_write(&inode->i_rwsem);
>>
>>         error = may_setattr(idmap, inode, ia_valid);
>>         if (error)
>>
>> Alternatively hide it behind inode_assert_is_wlocked() or whatever other
>> name.
>
> Better to do it like mmap_lock:
>
> static inline void mmap_assert_write_locked(struct mm_struct *mm)
> {
>         lockdep_assert_held_write(&mm->mmap_lock);
>         VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> }
>

May I suggest continuing this with responses to the patch I sent? ;)
[RFC PATCH] vfs: add inode lockdep assertions on -fsdevel

I made it line up with asserts for i_mmap_rwsem.

btw your non-lockdep check suffers the very problem I'm trying to fix
here -- checking for *any* locked state.

-- 
Mateusz Guzik <mjguzik gmail.com>
