Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA01472E037
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbjFMK57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 06:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbjFMK56 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:57:58 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D76210D4;
        Tue, 13 Jun 2023 03:57:57 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-43b4056391dso329161137.1;
        Tue, 13 Jun 2023 03:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686653876; x=1689245876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkJyX76qu6aYOcJa4ZGJI28Z9qxfZsO3+MZbPZRlHOY=;
        b=USsYM2yWuXXirQlcInGV8fqwMJEnZzl6h1nNG1oIWucAMXXyPPSjmVVKI1VwoOds40
         vwQ8t9XUlbfTQPcp6IJkM0uAUMoWHoH2Ov0CqUq9uZr9YJMLwIVCX5o8GJdknkGzStLi
         f3msZcWkEPaPlwT1QLpQle5hsJ/WPBNMejHbp8weCg+mFqMUPeSnlD12bhXBFDql0HBw
         IvFiTacA5iCNOZMt5c2WC7qz9Zt56JSdD7CwZtLqjvyPhh4dgc+ICD1RQEfR8kYsJHu9
         0WlLxzGXLV6MwG0mUbemUHQlEcpvrfr76LDeOHY7coEZ8adwNGgIIwBQneIlK+j/PXzy
         cKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686653876; x=1689245876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkJyX76qu6aYOcJa4ZGJI28Z9qxfZsO3+MZbPZRlHOY=;
        b=EXtx44FzhXlP1V3pEyzJfAH2SomFVdKnJ9zbgLpD9ApGecSl3bpji1Bv4eD6v0ZoKa
         miu9wR395Xwx7pX03Sy7zkFp/vJtRAnMH03k2JdzkFYxpBx+a8MSI6CDteHbFzz/Jypz
         dQpw1WAbyf63+ZUKo9NUV/ks4nzbR6pmjnujIZTAc9COOjmhDDSJC8ZbMvpC5pLy5lbl
         8D8Vm+JfMN5X7AuIeQb16MufxUHZru9Ryui1veYm4K37ExymM6nU/XGFsDMdNQYp4nwR
         logIXZx4Pp+qqKdAYh0AmidCghlK5ajQYH7+nDPbeD7onHT8zxY1dWytS/k27bMMc6X8
         gTzA==
X-Gm-Message-State: AC+VfDxak0qeR7HwmvWLUUxzq7Hu/bxz28kXOUAfit9BguujTnNKhEy1
        kc3h5LWvwgdIq1OIeyxOYGR0OAoNQAwHk4jcK3s=
X-Google-Smtp-Source: ACHHUZ4Xx3HB7+iEtKrLZLfn42n6OK5EbeHfOBzjEsFcEdnH+WiEn7zYcKoFMIaw0vBX8c0BJ+1jDHfHpgjiY37LAiY=
X-Received: by 2002:a67:f787:0:b0:43b:2a44:7554 with SMTP id
 j7-20020a67f787000000b0043b2a447554mr5041188vso.6.1686653876082; Tue, 13 Jun
 2023 03:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230315223435.5139-1-linkinjeon@kernel.org>
In-Reply-To: <20230315223435.5139-1-linkinjeon@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 13 Jun 2023 13:57:45 +0300
Message-ID: <CAOQ4uxiSb659QB7J6S=FZWb-jDTBosYs_zM2tvJHwk4SNAh5Vw@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] ksmbd patches included vfs changes
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, smfrench@gmail.com,
        senozhatsky@chromium.org, tom@talpey.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Namjae,

Maybe I am missing something, but I do not see any mnt_want_write()
in ksmbd at all. Is it well hidden somewhere?

Thanks,
Amir.

On Thu, Mar 16, 2023 at 12:37=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.org=
> wrote:
>
> v8:
>   - Don't call vfs_path_lookup() to avoid repeat lookup, Instead, lookup
>     last component after locking the parent that got from vfs_path_parent=
_lookup
>     helper.
> v7:
>   - constify struct path.
>   - recreate patch-set base on recent Al's patches.
> v6:
>   - rename __lookup_hash() to lookup_one_qstr_excl and export.
>   - change dget() to dget_parent() in unlink.
>   - lock parent of open file in smb2_open() to make file_present
>     worthable.
> v5:
>   - add lock_rename_child() helper.
>   - remove d_is_symlink() check for new_path.dentry.
>   - use lock_rename_child() helper instead of lock_rename().
>   - use dget() instead of dget_parent().
>   - check that old_child is still hashed.
>   - directly check child->parent instead of using take_dentry_name_snapsh=
ot().
> v4:
>    - switch the order of 3/4 and 4/4 patch.
>    - fix vfs_path_parent_lookup() parameter description mismatch.
> v3:
>   - use dget_parent + take_dentry_name_snapshot() to check stability of s=
ource
>     rename in smb2_vfs_rename().
> v2:
>   - add filename_lock to avoid racy issue from fp->filename. (Sergey Seno=
zhatsky)
>   - fix warning: variable 'old_dentry' is used uninitialized (kernel
>     test robot)
>
> Al Viro (1):
>   fs: introduce lock_rename_child() helper
>
> Namjae Jeon (2):
>   ksmbd: remove internal.h include
>   ksmbd: fix racy issue from using ->d_parent and ->d_name
>
>  fs/internal.h         |   2 -
>  fs/ksmbd/smb2pdu.c    | 147 ++++----------
>  fs/ksmbd/vfs.c        | 435 ++++++++++++++++++------------------------
>  fs/ksmbd/vfs.h        |  19 +-
>  fs/ksmbd/vfs_cache.c  |   5 +-
>  fs/namei.c            | 125 +++++++++---
>  include/linux/namei.h |   9 +
>  7 files changed, 342 insertions(+), 400 deletions(-)
>
> --
> 2.25.1
>
