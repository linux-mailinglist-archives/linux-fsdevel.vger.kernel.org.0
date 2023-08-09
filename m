Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA26A774FC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 02:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjHIAYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHIAYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:24:01 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541E31982;
        Tue,  8 Aug 2023 17:24:00 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1bbf7f7b000so3719077fac.2;
        Tue, 08 Aug 2023 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691540639; x=1692145439;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xoQh6qmcdY0t8o1dNUoYcbjZ4nnYnJlA1xateEndBZg=;
        b=Qecb81asdsJY1AvZ+uK7mMjtMqsvPEWlUJK1b3zIqFUvDUaVkHj2u2bRYYKRhIDWir
         51Ms8CfqCMoDHlbmpQQb14JsFt5PlP7QH52KciC+i/XMQ/ViS9dnEBpkmlvMvRB46TIZ
         LAfMdkb5tbO5yuS6BJT1RF80/dcgorFIJSJc+VlZcrwk0vxp1a7DZFXPA82Dcjb+1O1X
         Hh/+/fhngsf9qUKPJbnG0TpLYLFMyV2p+kbB1NVXLeJzzDxIXr25S/yLqUQvXdadOfj9
         OYZcfxSjrw/UB0C0peItlE3EyZrgvt9YgWvAWYJfuvrizEjKz0z6xjMZAFuOx1kWV36l
         nvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691540639; x=1692145439;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoQh6qmcdY0t8o1dNUoYcbjZ4nnYnJlA1xateEndBZg=;
        b=btEZjKLyUSLdpUnsVO0JsXs7PB049dXUeLL37rxB0LWg9pe99z1gMcBZGlwpmKL0L8
         1BgadU/bODtiaH1NSgTEgT85IbbIJy70tNni9CPaj+iSvE073ifl+9c3wL9o96bb4QKJ
         Wy4Ajc4aItDAKjeo1zbkrAFrX83GdcH8eLy/ceZ5G5vvIiIsb/aZ+9IX9PXzUnTO8Iht
         bgp6H9YOzfiqWcbQ9mb08Oe8vWhDDJnyi2Nt3aN300KHg8MkdRBc4EwXhMvG8qloUo6l
         9tlhCGnPxEybNeRX+aZS07h16eIE2F4w1Epk9KKHF75qm3sD6sm1rbc/RWQckSRtAv4r
         sCHg==
X-Gm-Message-State: AOJu0Ywo+AISqUfsL6/tLQ87UUgGb4D/i6SLBIKuEHeiE2BgbY1g6Tk/
        YXxOmCiP7E0TPPz8396T8+ayeqeVJVQaHFMx4EM=
X-Google-Smtp-Source: AGHT+IFHzRvNBWRdltO1hUGEKMzEcw73o/dnWl8keenIydsNCFbD8sFAg/G8+ePBunH1s6LQYcvjENVzgZK7bDB6O5o=
X-Received: by 2002:a05:6870:1682:b0:1be:fd4e:e369 with SMTP id
 j2-20020a056870168200b001befd4ee369mr1307556oae.42.1691540639554; Tue, 08 Aug
 2023 17:23:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:129a:0:b0:4f0:1250:dd51 with HTTP; Tue, 8 Aug 2023
 17:23:59 -0700 (PDT)
In-Reply-To: <ZNLMpgrCOQXFQnDk@dread.disaster.area>
References: <CAGudoHF_Y0shcU+AMRRdN5RQgs9L_HHvBH8D4K=7_0X72kYy2g@mail.gmail.com>
 <ZNLMpgrCOQXFQnDk@dread.disaster.area>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 9 Aug 2023 02:23:59 +0200
Message-ID: <CAGudoHG0Rp2Ku1mRRQnksDZFemUBzfhwyK3LJidEFgvmUfsfsQ@mail.gmail.com>
Subject: Re: new_inode_pseudo vs locked inode->i_state = 0
To:     Dave Chinner <david@fromorbit.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On 8/9/23, Dave Chinner <david@fromorbit.com> wrote:
> On Tue, Aug 08, 2023 at 06:05:33PM +0200, Mateusz Guzik wrote:
>> Hello,
>>
>> new_inode_pseudo is:
>>         struct inode *inode = alloc_inode(sb);
>>
>> 	if (inode) {
>> 		spin_lock(&inode->i_lock);
>> 		inode->i_state = 0;
>> 		spin_unlock(&inode->i_lock);
>> 	}
>>
>> I'm trying to understand:
>> 1. why is it zeroing i_state (as opposed to have it happen in
>> inode_init_always)
>> 2. why is zeroing taking place with i_lock held
>>
>> The inode is freshly allocated, not yet added to the hash -- I would
>> expect that nobody else can see it.
>
> Maybe not at this point, but as soon as the function returns with
> the new inode, it could be published in some list that can be
> accessed concurrently and then the i_state visible on other CPUs
> better be correct.
>
> I'll come back to this, because the answer lies in this code:
>
>> Moreover, another consumer of alloc_inode zeroes without bothering to
>> lock -- see iget5_locked:
>> [snip]
>> 	struct inode *new = alloc_inode(sb);
>>
>> 		if (new) {
>> 			new->i_state = 0;
>> [/snip]
>
> Yes, that one is fine because the inode has not been published yet.
> The actual i_state serialisation needed to publish the inode happens
> in the function called in the very next line - inode_insert5().
>
> That does:
>
> 	spin_lock(&inode_hash_lock);
>
> 	.....
>         /*
>          * Return the locked inode with I_NEW set, the
>          * caller is responsible for filling in the contents
>          */
>         spin_lock(&inode->i_lock);
>         inode->i_state |= I_NEW;
>         hlist_add_head_rcu(&inode->i_hash, head);
>         spin_unlock(&inode->i_lock);
> 	.....
>
> 	spin_unlock(&inode_hash_lock);
>
> The i_lock is held across the inode state initialisation and hash
> list insert so that if anything finds the inode in the hash
> immediately after insert, they should set an initialised value.
>
> Don't be fooled by the inode_hash_lock here. We have
> find_inode_rcu() which walks hash lists without holding the hash
> lock, hence if anything needs to do a state check on the found
> inode, they are guaranteed to see I_NEW after grabbing the i_lock....
>
> Further, inode_insert5() adds the inode to the superblock inode
> list, which means concurrent sb inode list walkers can also see this
> inode whilst the inode_hash_lock is still held by inode_insert5().
> Those inode list walkers *must* see I_NEW at this point, and they
> are guaranteed to do so by taking i_lock before checking i_state....
>
> IOWs, the initialisation of inode->i_state for normal inodes must be
> done under i_lock so that lookups that occur after hash/sb list
> insert are guaranteed to see the correct value.
>
> If we now go back to new_inode_pseudo(), we see one of the callers
> is new_inode(), and it does this:
>
> struct inode *new_inode(struct super_block *sb)
> {
>         struct inode *inode;
>
>         spin_lock_prefetch(&sb->s_inode_list_lock);
>
>         inode = new_inode_pseudo(sb);
>         if (inode)
>                 inode_sb_list_add(inode);
>         return inode;
> }
>
> IOWs, the inode is immediately published on the superblock inode
> list, and so inode list walkers can see it immediately. As per
> inode_insert5(), this requires the inode state to be fully
> initialised and memory barriers in place such that any walker will
> see the correct value of i_state. The simplest, safest way to do
> this is to initialise i_state under the i_lock....
>

Thanks for the detailed answer, I do think you have a valid point but
I don't think it works with the given example. ;)

inode_sb_list_add is:
        spin_lock(&inode->i_sb->s_inode_list_lock);
        list_add(&inode->i_sb_list, &inode->i_sb->s_inodes);
        spin_unlock(&inode->i_sb->s_inode_list_lock);

... thus i_state is published by the time it unlocks.

According to my grep all iterations over the list hold the
s_inode_list_lock, thus they are guaranteed to see the update, making
the release fence in new_inode_pseudo redundant for this case.

With this in mind I'm assuming the fence was there as a safety
measure, for consumers which would maybe need it.

Then the code can:
        struct inode *inode = alloc_inode(sb);

        if (inode) {
                inode->i_state = 0;
                /* make sure i_state update will be visible before we insert
                 * the inode anywhere */
                smp_wmb();
        }

Upshots:
- replaces 2 atomics with a mere release fence, which is way cheaper
to do everywhere and virtually free on x86-64
- people reading the code don't wonder who on earth are we locking against

All that said, if the (possibly redundant) fence is literally the only
reason for the lock trip, I would once more propose zeroing in
inode_init_always:
diff --git a/fs/inode.c b/fs/inode.c
index 8fefb69e1f84..ce9664c4efe9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -232,6 +232,13 @@ int inode_init_always(struct super_block *sb,
struct inode *inode)
                return -ENOMEM;
        this_cpu_inc(nr_inodes);

+       inode->i_state = 0;
+       /*
+        * Make sure i_state update is visible before this inode gets inserted
+        * anywhere.
+        */
+       smp_wmb();
+
        return 0;
 }
 EXPORT_SYMBOL(inode_init_always);

This is more in the spirit of making sure everybody has published
i_state = 0 and facilitates cleanup.
- new_inode_pseudo is now just alloc_inode
- confusing unlocked/unfenced i_state = 0 disappears from iget5_locked

And probably some more tidyups.

Now, I'm not going to flame with anyone over doing smp_wmb instead of
the lock trip (looks like a no-brainer to me, but I got flamed for
another one earlier today ;>).

I am however going to /strongly suggest/ that a comment explaining
what's going on is added there, if the current state is to remain.

As far as I'm concerned *locking* when a mere smp_wmb would sufficne
is heavily misleading and should be whacked if only for that reason.

Cheers,
-- 
Mateusz Guzik <mjguzik gmail.com>
