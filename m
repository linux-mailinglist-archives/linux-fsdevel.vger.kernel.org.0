Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F21E65AB15
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jan 2023 20:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjAATDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Jan 2023 14:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjAATDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Jan 2023 14:03:05 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAABA21AB;
        Sun,  1 Jan 2023 11:03:04 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a16so21042640qtw.10;
        Sun, 01 Jan 2023 11:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6wDacrJSpTsknmwskfhwVqCZnFzjzGGKQ7wij8Me7s=;
        b=JYpgYJtj9Hf6o8YTLmD3rHArOVoJmFrJ6u5c6HYihE/nhdCx4v+XxbS8XWVFwYqU87
         DtmGlswL37AWuB8dcw4kKsq8DT3CSISXO2YbMG//wktN5DPcyKiNv05e4Wn6dWwp9Bjc
         HVmMsTBpLn00gVFnw9ub1O/TgqqZEv7XKxcY0NvpoI+AnBkKhP6rgOJvqxQY/HnpRVZI
         9fSPwe8l7eRcCjHWT+Dsaiczh8KLBNKzfmmiyr52cokws91kkk3wzmd+hcjjlqOF3RE7
         f4oWoohjdkV/tfTT7V7y/C26MGJ9BEf3OE/JA5F9OKnMIlvwcCAAYsTGUhWleZ9RT6ih
         II0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6wDacrJSpTsknmwskfhwVqCZnFzjzGGKQ7wij8Me7s=;
        b=p2Jt56SUp02nYpH2jda8xPPDBqhjmTi7ePUW25v5eFnnxJXTnt3EH7hgANdBD3Ji7F
         y4+/OudqT+LX9BvGFFkbm3UwluMKI35TBuLQzHXL/VF4zGwG5Vo9yM/bCc3IjinlPTwP
         +4ORbor4kNdsdYf83RmFyU2SU11/GObDdahAIZTpfJBQa6FsHBlLTJQjm9xpNMd6GESW
         EdmYgvlwazepsaw3KHja0DUOAB/b0by2udiNx+U7A4iL4Dwu+LNgEmqmVeEUzL9C8+kK
         +8T3xjopG9Yji18XVb2NxBJ/A0Vwa+UKYaG+KWDySCXrcVWvwFYX6GljCLudtGZoZPSI
         /D4g==
X-Gm-Message-State: AFqh2kqwZlJLOqidNT0SwGMsnUieZZSPz5UMb664nsEUMg5J/aayU88k
        3wf8huK+OUeVdX9V9pqcwedG6a28KM12trwkkZ73UrHSdhs=
X-Google-Smtp-Source: AMrXdXuoiamQbXK7XE/uZbmqtrBwujG4kbI3KZqiZKdeo3cQQ8je0TmPLv64BPmoh1zb7un0yK6BgICnAPZiakd/JSA=
X-Received: by 2002:ac8:4913:0:b0:3ab:88cb:97cb with SMTP id
 e19-20020ac84913000000b003ab88cb97cbmr773944qtq.436.1672599783803; Sun, 01
 Jan 2023 11:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20221226142150.13324-1-pali@kernel.org> <20221226142150.13324-4-pali@kernel.org>
In-Reply-To: <20221226142150.13324-4-pali@kernel.org>
From:   Kari Argillander <kari.argillander@gmail.com>
Date:   Sun, 1 Jan 2023 21:02:46 +0200
Message-ID: <CAC=eVgS7weRq7S16MpTyx9eZm=2s+OZhm6Ko75Z6bmjsHH-7Yw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/18] ntfs: Undeprecate iocharset= mount option
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

26.12.2022 klo 16.22 Pali Roh=C3=A1r (pali@kernel.org) wrote:
>
> Other fs drivers are using iocharset=3D mount option for specifying chars=
et.
> So mark iocharset=3D mount option as preferred and deprecate nls=3D mount
> option.

snip.

> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c

snip.

> @@ -218,10 +213,10 @@ static bool parse_options(ntfs_volume *vol, char *o=
pt)
>                 } else if (!strcmp(p, "utf8")) {
>                         bool val =3D false;
>                         ntfs_warning(vol->sb, "Option utf8 is no longer "
> -                                  "supported, using option nls=3Dutf8. P=
lease "
> -                                  "use option nls=3Dutf8 in the future a=
nd "
> -                                  "make sure utf8 is compiled either as =
a "
> -                                  "module or into the kernel.");
> +                                  "supported, using option iocharset=3Du=
tf8. "
> +                                  "Please use option iocharset=3Dutf8 in=
 the "
> +                                  "future and make sure utf8 is compiled=
 "
> +                                  "either as a module or into the kernel=
.");

We do not have to make sure utf8 is compiled anymore as it "always is" righ=
t?

>                         if (!v || !*v)
>                                 val =3D true;
>                         else if (!simple_getbool(v, &val))
