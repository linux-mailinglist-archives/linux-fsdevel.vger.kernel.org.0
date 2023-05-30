Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C1A716981
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjE3QbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 12:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjE3Qag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 12:30:36 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AD5196;
        Tue, 30 May 2023 09:30:14 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565c9109167so30948787b3.2;
        Tue, 30 May 2023 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685464141; x=1688056141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RaH6YlQLj82X1bK0066HcpgE2an8J/ytXi93zQbg3cQ=;
        b=NiGox1WIIjth2AXTGOrzWLBf8ocEgyj8zWCgZoMezoWh8FD6QM/0tPrXmn7BSHEMyV
         Ghm66GNFV6l4CebnGoiMKEapSzx+VaH1b1A2mUJFdz+2xaOtAl1yB5Icir/ErZt0wGE6
         JyIAjLMoPWWC1k2Syer1b/bsqCeXF0silPz2ctpTMt7r/Pe2/FPQqlFLc/FIsalEMmU0
         0w7JItwNex+0rTcHsMg5mpbjpH4F87ZpEr8WqrSaTOrABPnnwpPxhhgSlDHzM8bBeAwN
         Ly8AT2ssLYkRFmnOP4FAjUZVKbnfYBM/gqE1la3gTV/SVnnUQpN83OuEYSN/T8L9ktYv
         mZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464141; x=1688056141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RaH6YlQLj82X1bK0066HcpgE2an8J/ytXi93zQbg3cQ=;
        b=eA1jXlrzwY0gZQcaT+hA5UQIOpmZyYpfenqvyO9OXUzVn9aZjRJbZ2dPdmDv2ePWIa
         eToZ+LDmLzf1VV4Z62XBU6ZGAT+sZtFuqOAijPKxgrhaj/XpMwVvVkiV58o4chHkSr2G
         ctHzt6HOs6n0GevIbczPEAyZgLt6Cez30mKqMc63U8WrzSuoyWjYLc62oMKYBE9c6SGd
         Ii8H4UH8Nc5YPogy2tM5GTy3qV4ZqrJQuAydasiAyz0R/4uRV94sQ5kme+oKZi6pBaN/
         NHmkhNY1zdHhViXE3sm/XnE9qzK+BcYUUaxi9FeeTsAjgABIIrm6ZcMWIvvTG6P1qRnJ
         qJfg==
X-Gm-Message-State: AC+VfDxgR9GxfVpCGS6OvZrH/KoQIqPbSsCONFhhAikyv1Rjd4pvzmW3
        NNLjfljH4aNbzUvngfKq406ZbdWOb220MS3dK6A=
X-Google-Smtp-Source: ACHHUZ7pu7vphBMBZ8mAXs/tfRsKu1hhZ0D0tIefznTvYwXkKqBLlWSLtS0FFFsJK9fj4GTt5i9js4ELTS/MwImZplc=
X-Received: by 2002:a81:778b:0:b0:55d:cf78:ed20 with SMTP id
 s133-20020a81778b000000b0055dcf78ed20mr2741306ywc.42.1685464141132; Tue, 30
 May 2023 09:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685449706.git.ojaswin@linux.ibm.com> <ddcae9658e46880dfec2fb0aa61d01fb3353d202.1685449706.git.ojaswin@linux.ibm.com>
In-Reply-To: <ddcae9658e46880dfec2fb0aa61d01fb3353d202.1685449706.git.ojaswin@linux.ibm.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 30 May 2023 18:28:22 +0200
Message-ID: <CA+icZUXDFbxRvx8-pvEwsZAu+-28bX4VDTj6ZTPtvn4gWqGnCg@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] Revert "ext4: remove ac->ac_found >
 sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits"
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
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

On Tue, May 30, 2023 at 3:25=E2=80=AFPM Ojaswin Mujoo <ojaswin@linux.ibm.co=
m> wrote:
>
> This reverts commit 32c0869370194ae5ac9f9f501953ef693040f6a1.
>
> The reverted commit was intended to remove a dead check however it was ob=
served
> that this check was actually being used to exit early instead of looping
> sbi->s_mb_max_to_scan times when we are able to find a free extent bigger=
 than
> the goal extent. Due to this, a my performance tests (fsmark, parallel fi=
le
> writes in a highly fragmented FS) were seeing a 2x-3x regression.
>
> Example, the default value of the following variables is:
>
> sbi->s_mb_max_to_scan =3D 200
> sbi->s_mb_min_to_scan =3D 10
>
> In ext4_mb_check_limits() if we find an extent smaller than goal, then we=
 return
> early and try again. This loop will go on until we have processed
> sbi->s_mb_max_to_scan(=3D200) number of free extents at which point we ex=
it and
> just use whatever we have even if it is smaller than goal extent.
>
> Now, the regression comes when we find an extent bigger than goal. Earlie=
r, in
> this case we would loop only sbi->s_mb_min_to_scan(=3D10) times and then =
just use
> the bigger extent. However with commit 32c08693 that check was removed an=
d hence
> we would loop sbi->s_mb_max_to_scan(=3D200) times even though we have a b=
ig enough
> free extent to satisfy the request. The only time we would exit early wou=
ld be
> when the free extent is *exactly* the size of our goal, which is pretty u=
ncommon
> occurrence and so we would almost always end up looping 200 times.
>
> Hence, revert the commit by adding the check back to fix the regression. =
Also
> add a comment to outline this policy.
>

Hi,

I applied this single patch of your series v2 on top of Linux v6.4-rc4.

So, if this is a regression I ask myself if this is material for Linux 6.4?

Can you comment on this, please?

Thanks.

Regards,
-Sedat-


> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d4b6a2c1881d..7ac6d3524f29 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2063,7 +2063,7 @@ static void ext4_mb_check_limits(struct ext4_alloca=
tion_context *ac,
>         if (bex->fe_len < gex->fe_len)
>                 return;
>
> -       if (finish_group)
> +       if (finish_group || ac->ac_found > sbi->s_mb_min_to_scan)
>                 ext4_mb_use_best_found(ac, e4b);
>  }
>
> @@ -2075,6 +2075,20 @@ static void ext4_mb_check_limits(struct ext4_alloc=
ation_context *ac,
>   * in the context. Later, the best found extent will be used, if
>   * mballoc can't find good enough extent.
>   *
> + * The algorithm used is roughly as follows:
> + *
> + * * If free extent found is exactly as big as goal, then
> + *   stop the scan and use it immediately
> + *
> + * * If free extent found is smaller than goal, then keep retrying
> + *   upto a max of sbi->s_mb_max_to_scan times (default 200). After
> + *   that stop scanning and use whatever we have.
> + *
> + * * If free extent found is bigger than goal, then keep retrying
> + *   upto a max of sbi->s_mb_min_to_scan times (default 10) before
> + *   stopping the scan and using the extent.
> + *
> + *
>   * FIXME: real allocation policy is to be designed yet!
>   */
>  static void ext4_mb_measure_extent(struct ext4_allocation_context *ac,
> --
> 2.31.1
>
