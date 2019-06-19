Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8175E4BEFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 18:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfFSQv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 12:51:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45347 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSQvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:51:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so4112280wre.12;
        Wed, 19 Jun 2019 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=d82qDML1JA/MsLn7s2RV9sIijgAIxE5dulqVjXnesQY=;
        b=p0W6xTt5EdcFYkplXGGD9oYJDGCxw6MgIC+w0LLGDj31vR0HhGb4CoIqN1cskafOXl
         IgjH29j6bL5PJ2TVwoERc+Of3E9AXfG9iZcFUVkZGH09+ru4nTFMymkzCwqIs15Kmz5E
         5khgtbOaT/kDP0XEG+uwzThuoUCZwJkrP/FDFUYX/Mqpe4pEhMnvMElSYPAZ2hmGdmWe
         xEtpYPfaSrlsSnZYnwzZTVvE1u9sfsUR6AcVwYtO5HPgy3fHxAYmc3aq8lJqxKLIokNH
         RIz6OnyVUHlcJMh/f1dZxtLPZODa0zy2FwbxaeS3u0u4gkciRBh1nnfmh52op6Z1j5f/
         tJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=d82qDML1JA/MsLn7s2RV9sIijgAIxE5dulqVjXnesQY=;
        b=R1IZokAtbqEAc5HvFXvTRJevshcfYCBQiQQeMI5LYiHWj8thmVCKpLRZPCMPWApEwJ
         V8Xm1oi+6Y0c+W3rgb7mwsfyqLkLva01MDPC6W9ACptJlfajm7wBAkT7Rv5CqBLtsPcq
         RrGiuV+8A7+o/TzLNHX9hPR+rtk6nTD0XKAs++JgnZVXnlDJckvOXWPh2eL5jExX65Dq
         xbWzMBA5T24MuVijetzjHOb9trwEaJWDNONyQAjnnImSS+qvnpJbQESGmcUV3o1dKZtD
         1mjPnLzyVUSphqb5YT7bhyLdnQppsP3G6tGnryjCyUzZiq9fk7tcnkqMAOrzRqTS/95c
         UgMQ==
X-Gm-Message-State: APjAAAUVUaAKmnkRPi2lKkpGVPmYy9HwCE2iKNtVoq8LaYI9A06jIMmY
        tnGDNEbsrnJfD3Bdbn51nOp9bnxl/kSbzQ==
X-Google-Smtp-Source: APXvYqz8bw7rB3nV006SCJ+Cjms0ZCokxU/bM6fA5B+fwqAFzlxprwYK/b7Fde2L+HxBu4KKz6d0mA==
X-Received: by 2002:adf:a509:: with SMTP id i9mr78699832wrb.269.1560963113077;
        Wed, 19 Jun 2019 09:51:53 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id w185sm2852807wma.39.2019.06.19.09.51.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 09:51:52 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: =?iso-8859-1?Q?d=5Flookup:_Unable_to_handle_kernel_paging_request?=
Date:   Wed, 19 Jun 2019 18:51:51 +0200
MIME-Version: 1.0
Message-ID: <bc774f6b-711e-4a20-ad85-c282f9761392@gmail.com>
In-Reply-To: <20190619162802.GF17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
 <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
 <20190618183548.GB17978@ZenIV.linux.org.uk>
 <bf2b3aa6-bda1-43f1-9a01-e4ad3df81c0b@gmail.com>
 <20190619162802.GF17978@ZenIV.linux.org.uk>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, June 19, 2019 6:28:02 PM CEST, Al Viro wrote:
> [arm64 maintainers Cc'd; I'm not adding a Cc to moderated list,
> sorry]
>
> On Wed, Jun 19, 2019 at 02:42:16PM +0200, Vicente Bergas wrote:
>
>> Hi Al,
>> i have been running the distro-provided kernel the last few weeks
>> and had no issues at all.
>> https://archlinuxarm.org/packages/aarch64/linux-aarch64
>> It is from the v5.1 branch and is compiled with gcc 8.3.
>>=20
>> IIRC, i also tested
>> https://archlinuxarm.org/packages/aarch64/linux-aarch64-rc
>> v5.2-rc1 and v5.2-rc2 (which at that time where compiled with
>> gcc 8.2) with no issues.
>>=20
>> This week tested v5.2-rc4 and v5.2-rc5 from archlinuxarm but
>> there are regressions unrelated to d_lookup.
>>=20
>> At this point i was convinced it was a gcc 9.1 issue and had
>> nothing to do with the kernel, but anyways i gave your patch a try.
>> The tested kernel is v5.2-rc5-224-gbed3c0d84e7e and
>> it has been compiled with gcc 8.3.
>> The sentinel you put there has triggered!
>> So, it is not a gcc 9.1 issue.
>>=20
>> In any case, i have no idea if those addresses are arm64-specific
>> in any way.
>
> Cute...  So *all* of those are in dentry_hashtable itself.  IOW, we have
> these two values (1<<24 and (1<<24)|(0x88L<<40)) cropping up in
> dentry_hashtable[...].first on that config.
>
> That, at least, removes the possibility of corrupted forward pointer in
> the middle of a chain, with several pointers traversed before we run
> into something unmapped - the crap is in the very beginning.
>
> I don't get it.  The only things modifying these pointers should be:
>
> static void ___d_drop(struct dentry *dentry)
> {
>         struct hlist_bl_head *b;
>         /*
>          * Hashed dentries are normally on the dentry hashtable,
>          * with the exception of those newly allocated by
>          * d_obtain_root, which are always IS_ROOT:
>          */
>         if (unlikely(IS_ROOT(dentry)))
>                 b =3D &dentry->d_sb->s_roots;
>         else  =20
>                 b =3D d_hash(dentry->d_name.hash);
>
>         hlist_bl_lock(b);
>         __hlist_bl_del(&dentry->d_hash);
>         hlist_bl_unlock(b);
> }
>
> and
>
> static void __d_rehash(struct dentry *entry)
> {
>         struct hlist_bl_head *b =3D d_hash(entry->d_name.hash);
>
>         hlist_bl_lock(b);
>         hlist_bl_add_head_rcu(&entry->d_hash, b);
>         hlist_bl_unlock(b);
> }
>
> The latter sets that pointer to (unsigned long)&entry->d_hash |=20
> LIST_BL_LOCKMASK),
> having dereferenced entry->d_hash prior to that.  It can't be=20
> the source of those
> values, or we would've oopsed right there.
>
> The former...  __hlist_bl_del() does
>         /* pprev may be `first`, so be careful not to lose the lock bit */
>         WRITE_ONCE(*pprev,
>                    (struct hlist_bl_node *)
>                         ((unsigned long)next |
>                          ((unsigned long)*pprev & LIST_BL_LOCKMASK)));
>         if (next)
>                 next->pprev =3D pprev;
> so to end up with that garbage in the list head we'd have to had next
> the same bogus pointer (modulo bit 0, possibly).  And since it's non-NULL,
> we would've immediately oopsed on trying to set next->pprev.
>
> There shouldn't be any pointers to hashtable elements other=20
> than ->d_hash.pprev
> of various dentries.  And ->d_hash is not a part of anon unions in struct
> dentry, so it can't be mistaken access through the aliasing member.
>
> Of course, there's always a possibility of something stomping=20
> on random places
> in memory and shitting those values all over, with the hashtable being the
> hottest place on the loads where it happens...  Hell knows...
>
> What's your config, BTW?  SMP and DEBUG_SPINLOCK, specifically...

Hi Al,
here it is:
https://paste.debian.net/1088517

Regards,
  Vicen=C3=A7.

