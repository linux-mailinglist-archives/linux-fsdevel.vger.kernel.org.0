Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F0F142EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 16:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgATPUN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 10:20:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39968 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATPUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:20:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so15081457wmi.5;
        Mon, 20 Jan 2020 07:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RzNA/B1zWOp+s3c1S4KTFzaLREFyMoeK9blIPOWv0tg=;
        b=qz2BL8DdvCQ0lG9BBDK/zr1PYABbh7SfEbmME2/1/QZ1ZMh9WlmjZ4N+kA7rFvKSQh
         l6aObfsqeoS/IlgFFfkuQIa4wRYBB+PmcfUyo9GVawd4ItTj+uw5t9rYcpvUx10KAE5D
         kI56+DFVH3sD28X+1FGa2YuSSvF6Rb5bWauAhaAJbAOqk/j7RCxWza4qxSDTKi1KH55Y
         pIyjEvGRtZ5TEZK+SMK/lW2nkzuGrdPGjT/byPkhRa9z9e5uCQR2dfEWstcDDOT2TzA6
         4drnG18gmIF4pYBqcLw68n81ibecINJ6ZxWR5kKVxkj4dIC/LyLqsq+KRcIW0uKgohyS
         +VeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RzNA/B1zWOp+s3c1S4KTFzaLREFyMoeK9blIPOWv0tg=;
        b=XSfzJv9ZF8ZIjH1YweZosLuJnkIqKRE7q0wKJs+nz6EhySeGauHAIfi6nQF70VyvuW
         tb5dsGDWVeHZ+gO5fDJaBNWaUJqeZ6INqs1gpgYlWZwMmoOriDC9wPR3ua+6sG/IIMnX
         xB73FohCpBTzu9irIw4BfaTuWMJUbWyPu2L4VN7YwVKHAiNpL6Pn7HlHV52r/pXjKE+7
         Lz9FE7dr0tyY82/IzXCYYK3VynffVJCB4tf0aMUx4uP64fe5TM40w55u7F4/mBMjF9Kt
         dplJ7xWQXq53Z7CigUGt/iy4oix9sgefa+ijpPk4kqeMuIpaRJr2nAYy29w8nhFN0rjp
         8tvA==
X-Gm-Message-State: APjAAAVSyPmFT/WOiAlSgi6ElH0FctRcGwWJoERSo1BtAQAye5S5buMW
        6CyvTzHFOwKT9/eQwhVnsJs=
X-Google-Smtp-Source: APXvYqxuTtfIMonsoUg4b+46IkEJGhK7vgKCjB4XTVegDc2CQzTQK2TeycP83DPFhew+ky1gbZw1IQ==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr18584278wmj.7.1579533611655;
        Mon, 20 Jan 2020 07:20:11 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a1sm23528152wmj.40.2020.01.20.07.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 07:20:10 -0800 (PST)
Date:   Mon, 20 Jan 2020 16:20:09 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120152009.5vbemgmvhke4qupq@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <89eba9906011446f8441090f496278d2@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89eba9906011446f8441090f496278d2@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 20 January 2020 15:07:20 David Laight wrote:
> From: Pali Rohár
> > Sent: 20 January 2020 11:05
> > On Monday 20 January 2020 13:04:42 OGAWA Hirofumi wrote:
> > > Pali Rohár <pali.rohar@gmail.com> writes:
> > >
> > > > Which means that fat_name_match(), vfat_hashi() and vfat_cmpi() are
> > > > broken for vfat in UTF-8 mode.
> > >
> > > Right. It is a known issue.
> > 
> > Could be this issue better documented? E.g. in mount(8) manpage where
> > are written mount options for vfat? I think that people should be aware
> > of this issue when they use "utf8=1" mount option.
> 
> What happens if the filesystem has filenames that invalid UTF8 sequences

Could you please describe what you mean by this question?


VFAT filesystem stores file names in UTF-16. Therefore you cannot have
UTF-8 on FS (and therefore also you cannot have invalid UTF-8).

Ehm... UTF-16 is not fully truth, MS FAT32 implementations allows half
of UTF-16 surrogate pair stored in FS.

Therefore practically, on VFAT you can store any uint16_t[] sequence as
filename, there is no invalid sequence (except those characters like
:<>?... which are invalid in MS-DOS).



If by "the filesystem has filenames" you do not mean filesystem file
names, but rather Linux VFS file names (e.g. you call creat() call with
invalid UTF-8 sequence) then function utf8s_to_utf16s() (called in
namei_vfat.c) fails and returns error. Which should be propagated to
open() / creat() call that it is not possible to create filename with
such UTF-8 sequence.

> or multiple filenames that decode from UTF8 to the same 'wchar' value.

This is not possible. There is 1:1 mapping between UTF-8 sequence and
Unicode code point. wchar_t in kernel represent either one Unicode code
point (limited up to U+FFFF in NLS framework functions) or 2bytes in
UTF-16 sequence (only in utf8s_to_utf16s() and utf16s_to_utf8s()
functions).

> Never mind ones that are just case-differences for the same filename.
> 
> UTF8 is just so broken it should never have been allowed to become
> a standard.

Well, UTF-16 is worse then UTF-8... incompatible with ASCII, variable
length and space consuming.

-- 
Pali Rohár
pali.rohar@gmail.com
