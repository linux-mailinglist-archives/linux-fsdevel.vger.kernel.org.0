Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9495872E2C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 14:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbjFMMYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 08:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbjFMMYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E79EA;
        Tue, 13 Jun 2023 05:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2B286027E;
        Tue, 13 Jun 2023 12:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470C7C433A0;
        Tue, 13 Jun 2023 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686659068;
        bh=4O14pXFAEOuRod82KvY9p6z8saqR1V2psHNARfog/o0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=SYKfWO/2S5NxdjPRZ/cZAY0HqaEFiW7oMrr2Jt6L1hEcgxM8HAz9SfslMaTmXYaiL
         acvyPaf1kIm+6X5PGWNnLo6kLR2taDXHKDQWeayswB0iZbQckz+GAHthSXn/Z1MPE+
         f7QTTmxczncmuJqRZS7Ycu2aWveyMIYGXA/yTpbZnhGLrrVPDLQUxgg+CfQqpOwLYw
         bmTuajc0dSMY6jgAwyLYARLK2Z6z6cyH2Ko8ZgDJKQgPgb1MJRjSAmo29gKzbeM8iG
         QsFibapSnZEGifcy2lsxrQzEhOefbc0pmjr6QTkc1kPAo4WuUWSYfBGKB/xU2AY/4P
         3bITO1pNsIw0g==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-558cb7f201cso3209988eaf.2;
        Tue, 13 Jun 2023 05:24:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDxcjwxkgU1NC+Vh5qCge1ytWKjU4EnV3RDdoTZF3o0n28MiUiZw
        YQDTWmhY6T7t3xt7aYHSeJ8zMpBFsq6UBWJK0hw=
X-Google-Smtp-Source: ACHHUZ5pDAFYlvvkGF6XfaWhAbz3gVuYczYpYS2IzKIFn61jyqrzn9VxBGzb+N7wH1kxa5R/m83iO7WrnGhvIBOavtU=
X-Received: by 2002:a4a:d78a:0:b0:558:fd2b:8232 with SMTP id
 c10-20020a4ad78a000000b00558fd2b8232mr7108771oou.9.1686659067397; Tue, 13 Jun
 2023 05:24:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:774b:0:b0:4df:6fd3:a469 with HTTP; Tue, 13 Jun 2023
 05:24:26 -0700 (PDT)
In-Reply-To: <CAOQ4uxiSb659QB7J6S=FZWb-jDTBosYs_zM2tvJHwk4SNAh5Vw@mail.gmail.com>
References: <20230315223435.5139-1-linkinjeon@kernel.org> <CAOQ4uxiSb659QB7J6S=FZWb-jDTBosYs_zM2tvJHwk4SNAh5Vw@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 13 Jun 2023 21:24:26 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-uL2Es_28VqMD33ogzhWX65ZMg3wTc9UxhE91G0ULwdg@mail.gmail.com>
Message-ID: <CAKYAXd-uL2Es_28VqMD33ogzhWX65ZMg3wTc9UxhE91G0ULwdg@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] ksmbd patches included vfs changes
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, smfrench@gmail.com,
        senozhatsky@chromium.org, tom@talpey.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-06-13 19:57 GMT+09:00, Amir Goldstein <amir73il@gmail.com>:
> Hi Namjae,
Hi Amir,
>
> Maybe I am missing something, but I do not see any mnt_want_write()
> in ksmbd at all. Is it well hidden somewhere?
At a quick glance, We need to add it for ksmbd_vfs_unlink and ksmbd_vfs_ren=
ame.
I'll look further into where else should I add it.

Thanks for letting me know!
>
> Thanks,
> Amir.
>
> On Thu, Mar 16, 2023 at 12:37=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.o=
rg> wrote:
>>
>> v8:
>>   - Don't call vfs_path_lookup() to avoid repeat lookup, Instead, lookup
>>     last component after locking the parent that got from
>> vfs_path_parent_lookup
>>     helper.
>> v7:
>>   - constify struct path.
>>   - recreate patch-set base on recent Al's patches.
>> v6:
>>   - rename __lookup_hash() to lookup_one_qstr_excl and export.
>>   - change dget() to dget_parent() in unlink.
>>   - lock parent of open file in smb2_open() to make file_present
>>     worthable.
>> v5:
>>   - add lock_rename_child() helper.
>>   - remove d_is_symlink() check for new_path.dentry.
>>   - use lock_rename_child() helper instead of lock_rename().
>>   - use dget() instead of dget_parent().
>>   - check that old_child is still hashed.
>>   - directly check child->parent instead of using
>> take_dentry_name_snapshot().
>> v4:
>>    - switch the order of 3/4 and 4/4 patch.
>>    - fix vfs_path_parent_lookup() parameter description mismatch.
>> v3:
>>   - use dget_parent + take_dentry_name_snapshot() to check stability of
>> source
>>     rename in smb2_vfs_rename().
>> v2:
>>   - add filename_lock to avoid racy issue from fp->filename. (Sergey
>> Senozhatsky)
>>   - fix warning: variable 'old_dentry' is used uninitialized (kernel
>>     test robot)
>>
>> Al Viro (1):
>>   fs: introduce lock_rename_child() helper
>>
>> Namjae Jeon (2):
>>   ksmbd: remove internal.h include
>>   ksmbd: fix racy issue from using ->d_parent and ->d_name
>>
>>  fs/internal.h         |   2 -
>>  fs/ksmbd/smb2pdu.c    | 147 ++++----------
>>  fs/ksmbd/vfs.c        | 435 ++++++++++++++++++------------------------
>>  fs/ksmbd/vfs.h        |  19 +-
>>  fs/ksmbd/vfs_cache.c  |   5 +-
>>  fs/namei.c            | 125 +++++++++---
>>  include/linux/namei.h |   9 +
>>  7 files changed, 342 insertions(+), 400 deletions(-)
>>
>> --
>> 2.25.1
>>
>
