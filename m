Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0DAD192982
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 14:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCYNWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 09:22:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36498 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgCYNWE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:22:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so2066598qtb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6BqCxccxfCYt0s0B7B5Tq5f8zXMXUI8kTYEC1wL3LOA=;
        b=dLui0I7wqDgCnRAsbciTulvvaOb9VbQSkhfUF5xkxBmsG/OFh6/8s4wJxoJ1qCVwEA
         5ZBM0IpJiNJ6Dwbsn6t+ae9+7GhRREiC1ZhekIQBc0llXtx6iVWp/xqxDafD1/xBhCGK
         CXXq/z6TXXzzQkZjUXxHzBEYtj+vUr65KY3Cr+bAyLDyGjnjiDwx0tV760TPtBZASjPk
         5JXarGayW0M+vcdmovzt03eaduYIEUdWjrFpXL1cGpL6ADAHELS36dLbQ0ntuqADUFFZ
         eYR4KFIopBY0eGirgN0BBsq9iC4ll0+wJrzW/CbwNTPFvWxSiZJqL1iyftgRkbrkD17i
         scdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6BqCxccxfCYt0s0B7B5Tq5f8zXMXUI8kTYEC1wL3LOA=;
        b=ZxBB6rwrCv7lQEiT2r762alQw6sdDAdxQ0tOjAC2/NUdDTZpkDFTs3SjiHEIuy4I7u
         8hiQ7eUN/PO56IRwb4CoW0nI9LHRKM93XUM1ImPpsAY/P16tWyQzkVQF8GGZpmxztN6n
         ZoQdE2wHvhr7ni7UJ2Hd/N3T+LzV+aa2OFeh/BRmDwt0hW8nSoacfoq38Ouo34cwdMh/
         4ZozrhEvKB4FNIbgel2CE4rqeLUPdeZV1xX/CIhQpNRfaifSY/hIpVg0XRs/Yq5yokRP
         hZx3qjATmmscRhZfe6cvamkVdgcFPs9p2BmC8a3OBwwClrtbh3nGPI76M3netjm8pA7r
         U7aA==
X-Gm-Message-State: ANhLgQ0Lc874S+PN3raeleiCdwSp32X9J+IdWUkRvHH6VQqiNKpxx/78
        ixphCLno3HperBcM6wRqEYDW0SEJQfgOpw==
X-Google-Smtp-Source: ADFU+vuegRt8+orGLk337zyGYvIH1gOlRdv5e1meeLpZQG9/qCprfgsRFdInNkaQ6Q00aut4EQNizw==
X-Received: by 2002:ac8:6d31:: with SMTP id r17mr2911848qtu.68.1585142522727;
        Wed, 25 Mar 2020 06:22:02 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 2sm17715492qtp.33.2020.03.25.06.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 06:22:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200325040359.GK23230@ZenIV.linux.org.uk>
Date:   Wed, 25 Mar 2020 09:21:59 -0400
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1AE49C8-A33E-4991-88D5-803DE044C560@lca.pw>
References: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
 <20200324214637.GI23230@ZenIV.linux.org.uk>
 <A32DAE66-ADBA-46C7-BD26-F9BA8F12BC18@lca.pw>
 <20200325021327.GJ23230@ZenIV.linux.org.uk>
 <5281297D-B66E-4A4C-9B41-D2242F6B7AE7@lca.pw>
 <20200325040359.GK23230@ZenIV.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 25, 2020, at 12:03 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Tue, Mar 24, 2020 at 11:24:01PM -0400, Qian Cai wrote:
>=20
>>> On Mar 24, 2020, at 10:13 PM, Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>>>=20
>>> On Tue, Mar 24, 2020 at 09:49:48PM -0400, Qian Cai wrote:
>>>=20
>>>> It does not catch anything at all with the patch,
>>>=20
>>> You mean, oops happens, but neither WARN_ON() is triggered?
>>> Lovely...  Just to make sure: could you slap the same couple
>>> of lines just before
>>>               if (unlikely(!d_can_lookup(nd->path.dentry))) {
>>> in link_path_walk(), just to check if I have misread the trace
>>> you've got?
>>>=20
>>> Does that (+ other two inserts) end up with
>>> 	1) some of these WARN_ON() triggered when oops happens or
>>> 	2) oops is happening, but neither WARN_ON() triggers or
>>> 	3) oops not happening / becoming harder to hit?
>>=20
>> Only the one just before
>> if (unlikely(!d_can_lookup(nd->path.dentry))) {
>> In link_path_walk() will trigger.
>=20
>> [  245.767202][ T5020] pathname =3D /var/run/nscd/socket
>=20
> Lovely.  So
> 	* we really do get NULL nd->path.dentry there; I've not misread =
the
> trace.
> 	* on the entry into link_path_walk() nd->path.dentry is =
non-NULL.
> 	* *ALL* components should've been LAST_NORM ones
> 	* not a single symlink in sight, unless the setup is rather =
unusual
> 	* possibly not even a single mountpoint along the way (depending
> upon the userland used)
>=20
> And in the same loop we have
>                if (likely(type =3D=3D LAST_NORM)) {
>                        struct dentry *parent =3D nd->path.dentry;
>                        nd->flags &=3D ~LOOKUP_JUMPED;
>                        if (unlikely(parent->d_flags & DCACHE_OP_HASH)) =
{
>                                struct qstr this =3D { { .hash_len =3D =
hash_len }, .name =3D name };
>                                err =3D parent->d_op->d_hash(parent, =
&this);
>                                if (err < 0)
>                                        return err;
>                                hash_len =3D this.hash_len;
>                                name =3D this.name;
>                        }
>                }
> upstream of that thing.  So NULL nd->path.dentry *there* would've =
oopsed.
> IOW, what we are hitting is walk_component() with non-NULL =
nd->path.dentry
> when we enter it, NULL being returned and nd->path.dentry becoming =
NULL
> by the time we return from walk_component().
>=20
> Could you post the results of
> 	stat / /var /var/run /var/run/nscd /var/run/nscd/socket

The file is gone after a successful boot,

#  stat / /var /var/run /var/run/nscd /var/run/nscd/socket
  File: /
  Size: 244       	Blocks: 0          IO Block: 65536  directory
Device: fe00h/65024d	Inode: 128         Links: 17
Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2020-03-24 14:21:27.112559236 -0400
Modify: 2020-03-24 14:21:25.840486593 -0400
Change: 2020-03-24 14:21:25.840486593 -0400
 Birth: -
  File: /var
  Size: 4096      	Blocks: 8          IO Block: 65536  directory
Device: fe00h/65024d	Inode: 133         Links: 21
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2018-08-12 05:57:57.000000000 -0400
Modify: 2020-03-23 21:29:31.087264900 -0400
Change: 2020-03-23 21:29:31.087264900 -0400
 Birth: -
  File: /var/run -> ../run
  Size: 6         	Blocks: 0          IO Block: 65536  symbolic =
link
Device: fe00h/65024d	Inode: 143         Links: 1
Access: (0777/lrwxrwxrwx)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2020-03-24 17:34:11.865030724 -0400
Modify: 2020-03-23 17:16:40.573974805 -0400
Change: 2020-03-23 17:16:40.573974805 -0400
 Birth: -
stat: cannot stat '/var/run/nscd': No such file or directory
stat: cannot stat '/var/run/nscd/socket': No such file or directory

> after the boot with working kernel?  Also, is that "hit on every boot" =
or
> stochastic?  If it's the latter, I'd like to see the output of the =
same
> thing on a successful boot of the same kernel, if possible...

It does not hit every time, so I used a cron job,

@reboot sleep 180; systemctl reboot

It has always hit it within a hour so far.

