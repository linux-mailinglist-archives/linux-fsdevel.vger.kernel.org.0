Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2290457942F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 09:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiGSHbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 03:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiGSHao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:30:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B93A462;
        Tue, 19 Jul 2022 00:30:42 -0700 (PDT)
Received: from mail-yb1-f173.google.com ([209.85.219.173]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MZSJa-1nynjT0R4I-00WTNq; Tue, 19 Jul 2022 09:30:41 +0200
Received: by mail-yb1-f173.google.com with SMTP id 7so7440049ybw.0;
        Tue, 19 Jul 2022 00:30:40 -0700 (PDT)
X-Gm-Message-State: AJIora99fmHdDpQsJ7aYjuQtDRojlNO1xoZ1jIqjR7bIJUw0CdF6CqWl
        aDgDaurdKbXDqIlwx/0TmGYgoFoia/oiwuOXnew=
X-Google-Smtp-Source: AGRyM1sHEXfILtf5H5AJb4f9qEwmY9K8xJMdOalIOxrMRjwDc3HrIrYqwxsR0DHpQKJKJVB+DVIPhKV4hB7h7T7Tne8=
X-Received: by 2002:a25:3b05:0:b0:66e:c216:4da3 with SMTP id
 i5-20020a253b05000000b0066ec2164da3mr32448471yba.550.1658215839747; Tue, 19
 Jul 2022 00:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220719065551.154132-1-bongiojp@gmail.com>
In-Reply-To: <20220719065551.154132-1-bongiojp@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 09:30:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a17LZNXDW9r3ixfMg_c-vtqqT51MCLEsyF4Loh8VfDw7w@mail.gmail.com>
Message-ID: <CAK8P3a17LZNXDW9r3ixfMg_c-vtqqT51MCLEsyF4Loh8VfDw7w@mail.gmail.com>
Subject: Re: [PATCH v3] Add ioctls to get/set the ext4 superblock uuid.
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7yDDja7MzXtbwTzu3ltKGVKwFnMeImaL6oj6VPhQkU8OkwkwuNu
 WJJsB3918ac7UkxjrVErU22DKf3EMWBVTxvEE7i3TVNQR5HuLPXk3V81uL2+9FWvSGyKeWF
 e2hNPWNAfvyd1Zi3AIQmlyZ8hFxXIFHJEgx30B2QLU8Ljobui3OP0nBKd28kEyZl8ijmrTS
 v63cfePC7TUEFm9BeN8ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iYbwrjC09OQ=:MGMurn+j4TOJKuclq9e/Wi
 U+FQKcgj+DjLTmlMJlxwFYovvyQ19KRgbQrRX22ibXYc7piJdj86KAFN3Z/p2PK7IXe5de2eO
 gsZwLgKBRJmDt77Mq/UuO7r5VO2mcVNmc479GLNrcrNSqsgo0HCeIk9bVRTI1LzT6zI6ZEKip
 y16EG/pv0aGhwI8XtArqzFHJZuwpl3ki12kvHyC6PZdDl7WT/grh2gwLKFNeBfZZ8Cj2RR+yy
 /IZ9imQA1MVe8jst5h4i/UnrOKFvgQsPgcWWWh4i6NFru5YZaTPFR0RE49XnDCIQCM2/C7q+0
 VnKP2O3DtxXqyNi+JvH79cN4E66trjNo2BlRR0ZJc/eOf8oNhAZW2D41JrWGzEmU5p8ByoBcx
 KkOdAC+YWblSIimdqBoNwBSWd6W0/AA/ptWxptG4R8E7oqXr7Xa5yBCJUNpkXRk9Cz1EOT5re
 oI0p1iOTPpQD+qlDwbSiuQnAv4nirL3FJhzlgsDKs008KHrtkgB/kmxfOOlf/LAtGUSfLlxc5
 Xuii+rF5SudJ9wvdvkmlVuEOfRyDRML541kr3HzNoM8SbntNbzXLRiItfPZYIXTJIiLB+ifx5
 VnBCa5/cDX5WBzeQiJRBTpUXs12rtOT4g78SIaua2rdgZkMdPKOiy3xANMAcLz+W9IuNxNjP1
 b6/U8qkJbXmMSItldHPXQ8BaHutbVpusPTgLn0E3OdyJlMAHZZGr3ncVwApnSr7ePCEETpPCx
 QhJKdDrKeIRgxrraNut6xr3ZlmqKUkBzGbn1gg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 19, 2022 at 8:55 AM Jeremy Bongio <bongiojp@gmail.com> wrote:
>
> This fixes a race between changing the ext4 superblock uuid and operations
> like mounting, resizing, changing features, etc.
>
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> ---
>
> This pair of ioctls may be implemented in more filesystems in the future,
> namely XFS.
>

> +++ b/fs/ext4/ext4.h
> @@ -724,6 +724,8 @@ enum {
>  #define EXT4_IOC_GETSTATE              _IOW('f', 41, __u32)
>  #define EXT4_IOC_GET_ES_CACHE          _IOWR('f', 42, struct fiemap)
>  #define EXT4_IOC_CHECKPOINT            _IOW('f', 43, __u32)
> +#define EXT4_IOC_GETFSUUID             _IOR('f', 44, struct fsuuid)
> +#define EXT4_IOC_SETFSUUID             _IOW('f', 44, struct fsuuid)

The implementation looks good to me, but maybe it should be defined in
the UAPI headers in a filesystem-independent way? Having it in a private
header means it will not be available to portable user programs, and will
be hidden from tools like strace that parse the uapi headers to find
ioctl definitions.

       Arnd
