Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33490193146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 20:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgCYTnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 15:43:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36232 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYTnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:43:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id m33so3305475qtb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WhXRLeHWCC3uLvHj6QkFXcigLiU7sl1EvrP+2UphyIo=;
        b=WxeYWiQYlJp7FXNnqc3T8fkMKogqDooYJGlv91eChixvfStUViUK80270XGj/bGCLf
         HI9T3lP9cwzOsLdMAEoon5oG3vlIeHqL4doT/2TqzYLaTas04SYUZqKDVqxNufI/lVRW
         mEEumNvV7TFtN/p0l4Nv27iemj3gT+W9igrngkSZpJzcROzCUEElz7FPJs2w8ef0HaTv
         sOwNHZf9uEjIE8QMm0w0mkywjagE1Z7SZTvG0PCg/EsIT/PfAiiCi9MPv5/lhuqQ5ZR8
         W9AVneYAVCQTXMWcvBFptWaGUAqeP1ycKNzCRSwBjsMbuSFcTqbwMJIzi4Q093T3PFnx
         wBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WhXRLeHWCC3uLvHj6QkFXcigLiU7sl1EvrP+2UphyIo=;
        b=tCPMyxpN9C9bcpbZ4RwEpaCbz57Bp9rj0O2vclRr1F6JWmoVSuYG12LSeVqH0CJQbb
         I7lIqt9xBVdchHLuhCzI1csi0gIWqqYN5dRcVuuCIG3MkBrgYKcztwTXdbn6EDRlYRMW
         t6nMnQKhsIxmL8Z4CSAdJvCEeGFAM0PRkzp1fNJm+Fn5++LONzXR0Th1jH2ae5iHOoaN
         7yxTDJq7mRxanegVsdzOiyV1J90AXKh/LqyKPE280HxHkaoXdePLOu7qegmUMZYTQrvd
         almMLMI3t0GcOAIodhd/8uNoFYgt8FKHKd2JE/SMij4juBZGKeUCPoxm+Z94RY8Dvsjj
         i7Jw==
X-Gm-Message-State: ANhLgQ0+UWXGzWAXZZqQJgtc1sCN7m/m2ySPIO8fyz2WK2frimJCpzdM
        /iGd7gM9WUDzpb/qMSCcEnZAnSUeG+MMcQ==
X-Google-Smtp-Source: ADFU+vv7zuv6fuqpv4PKPxn/GujcUf/QIwRy+o0HN8sc9H5K2J573zl7iknDBQphPntRkIUaNv/7Jg==
X-Received: by 2002:aed:2ee1:: with SMTP id k88mr4831835qtd.268.1585165388512;
        Wed, 25 Mar 2020 12:43:08 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g3sm15894644qke.89.2020.03.25.12.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 12:43:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200325055830.GL23230@ZenIV.linux.org.uk>
Date:   Wed, 25 Mar 2020 15:43:06 -0400
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2554121-109E-450A-965F-B8DFE2B0E528@lca.pw>
References: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
 <20200324214637.GI23230@ZenIV.linux.org.uk>
 <A32DAE66-ADBA-46C7-BD26-F9BA8F12BC18@lca.pw>
 <20200325021327.GJ23230@ZenIV.linux.org.uk>
 <5281297D-B66E-4A4C-9B41-D2242F6B7AE7@lca.pw>
 <20200325040359.GK23230@ZenIV.linux.org.uk>
 <20200325055830.GL23230@ZenIV.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 25, 2020, at 1:58 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Wed, Mar 25, 2020 at 04:03:59AM +0000, Al Viro wrote:
>=20
>> Lovely.  So
>> 	* we really do get NULL nd->path.dentry there; I've not misread =
the
>> trace.
>> 	* on the entry into link_path_walk() nd->path.dentry is =
non-NULL.
>> 	* *ALL* components should've been LAST_NORM ones
>> 	* not a single symlink in sight, unless the setup is rather =
unusual
>> 	* possibly not even a single mountpoint along the way (depending
>> upon the userland used)
>=20
> OK, I see one place where that could occur, but I really don't see how =
that
> could be triggered on this pathname, short of very odd symlink layout =
in
> the filesystem on the testbox.  Does the following fix your =
reproducer?
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 311e33dbac63..4082b70f32ff 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1805,6 +1805,8 @@ static const char *handle_dots(struct nameidata =
*nd, int type)
> 			error =3D step_into(nd, WALK_NOFOLLOW,
> 					 parent, inode, seq);
> 		}
> +		if (unlikely(error))
> +			return ERR_PTR(error);
>=20
> 		if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
> 			/*

Since that one has a compilation warning, I have tested this patch and =
seen no crash so far.

diff --git a/fs/namei.c b/fs/namei.c
index 311e33dbac63..73851acdbf3a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1806,6 +1806,9 @@ static const char *handle_dots(struct nameidata =
*nd, int type)
                                         parent, inode, seq);
                }
=20
+               if (unlikely(error))
+                       return error;
+
                if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
                        /*
                         * If there was a racing rename or mount along =
our=
