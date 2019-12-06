Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8DAD1158DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 22:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfLFVz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 16:55:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42184 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLFVz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:55:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id j22so1144874oij.9;
        Fri, 06 Dec 2019 13:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DdZJXBa8X+lOuFt5ge19ma+4D6+K1PG13a0GvX5ZzLg=;
        b=FUaoWLJKKkJSpa77IOgo3V4OXs4n1IdaHOpT0iuEPOG+ICjrwXYQEpsY3kXH2mIiTm
         0eqcGtygIhhMF8U1aplQElxlZChSQouNJQ9VBFvJduKRtb3qXS0CBQZnuvqh5pRPLdCg
         MGjGRsfub7WkrlOeDTt8jJ/KxHToQVxPi2siaZpfdS/G8X5EQohcTSTMMJqWUIDnjpW9
         ZlNh3Cblu7JBCJlI0dq3MvuupOJq6D0lmQ8cJ6Gt+wcVtwHOAdgVW3cnbap/yWLhdN3y
         H/bKMpVltEFMmu/RHCKJE7BW5467r0YLwbT7Y+TGoJ1vb2vdeVNgllIApVRXNc5e16MW
         DC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DdZJXBa8X+lOuFt5ge19ma+4D6+K1PG13a0GvX5ZzLg=;
        b=qJFobJHsyHdK/WXs+WOG4ixxG0u9iKMD30g29kyK7r67oThxMF0oCFygvEwFrqU2Iz
         4UV7J2GMz01gUxT/rSpEMY7BGxIFi7P2Q0+i7tzPfaDBbFesrEnLID6Ec7NbhS4HlOx5
         XDf3nimlXqZpB5aLacQuNwwkLLnOJALxZy+nUvpXuEAb85VIb2vKwd0qwiqCmPBZ2DQc
         HhUBhodmOr5Fepam7S80Xa30IzWVFjEBpr//BzkZCB0s7IIJymV2vfg57hujsnkRndHq
         xYyOI30Yk8bSih8gp+xiZnrK04gitCQZqErDmoEAQZdXPXPFUXpwsjziErgmXzATFDhC
         EtXg==
X-Gm-Message-State: APjAAAVtZ3z94Lq8Mkwt69v6LwvTcDpjJK47Cf+YeMQo/d8HOWNO90ar
        lhxjhWIaXA5V6HziBqLtI28Rg/V66Atw/JUKLtI=
X-Google-Smtp-Source: APXvYqzTZhKmcHIyaf7FmMdY6ofez0cdgtOTpkpMQT2fDMHMgm54dEMCiodxPiF/Wumie+M5Z+ZVkjqd/P69V8xs5HA=
X-Received: by 2002:a05:6808:98b:: with SMTP id a11mr14712513oic.62.1575669325938;
 Fri, 06 Dec 2019 13:55:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Fri, 6 Dec 2019 13:55:25 -0800 (PST)
In-Reply-To: <81423.1575627938@turing-police>
References: <20191125000326.24561-1-namjae.jeon@samsung.com>
 <CGME20191125000628epcas1p28c532d9b7f184945c40e019ce9ef0dd0@epcas1p2.samsung.com>
 <20191125000326.24561-3-namjae.jeon@samsung.com> <81423.1575627938@turing-police>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Sat, 7 Dec 2019 06:55:25 +0900
Message-ID: <CAKYAXd9yW2j+MqExyxJmN2-bTKMarwebrBKefBZgfj+HF+bpbg@mail.gmail.com>
Subject: Re: [PATCH v5 02/13] exfat: add super block operations
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, Markus.Elfring@web.de,
        sj1557.seo@samsung.com, dwagner@suse.de, nborisov@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> +{
>> +	struct exfat_sb_info *sbi = sb->s_fs_info;
>> +	struct exfat_mount_options *opts = &sbi->options;
>> +	struct inode *root_inode;
>> +	int err;
>> +
>> +	if (opts->allow_utime == -1)
>> +		opts->allow_utime = ~opts->fs_dmask & 0022;
>
> This throws a warning when building with W=1:
>
>   CC [M]  fs/exfat/super.o
> fs/exfat/super.c: In function 'exfat_fill_super':
> fs/exfat/super.c:552:24: warning: comparison is always false due to limited
> range of data type [-Wtype-limits]
>   552 |  if (opts->allow_utime == -1)
>       |                        ^~
Okay, I will fix it on next version.
Thanks for review!
