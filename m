Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BAB6008C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJQIdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 04:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJQIdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:33:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4094040579
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 01:33:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r22so13037547ljn.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=azrjkTSUa/x73/5WnmuPzRdP/HPez6bDQxOpksGkhRA=;
        b=a/oDAz3xURgSlah+zDO2fzFzfvSFrEjmCsQ5CtmV5wpy8/L51Q77OK5k7mJq+LosYE
         RDJCxvRoEXZS65qMQOnrKu6I9wkhUaPEiyHo/NWSrMkHLiva7vvcuRRaZ3Z2Q44s3sfl
         EvRB3rWoOYqNbHfiOiSOLVn/sZa+2u6b7EbV7urnZXdD3prc0O/Ddpp0UNb8jMFdVh7H
         mNPXpUp5rjHVCeF1JbMiorLWQ+P8IWxh+Ro0RWHT2VHqIjGWHAQ/gveZL6ep25X6ZAnZ
         NBOvAMgMz/qIgTYTo0t2OtD4TIYyFuNUdp8KuqNGvdQuayInWZbNLoBWdlSiwE/zSHUc
         HgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azrjkTSUa/x73/5WnmuPzRdP/HPez6bDQxOpksGkhRA=;
        b=QpZd0lGJyp/n4cxzIYkQpdWHYFKYE746T8Rudc7g1TVRqnYwFOoOSlG768HTywm2Wd
         6IU1EDPKMTguaZY5uHS7Fq7boCAQZAXF+YdGcZc1N1UDtc1dHaeSz3w4W/VRXP1dW7uw
         sFl7qc8SDRetNbZQy8UIFsBzw1QvfJH9bIsjNfEY6r/RgR6jyKoxoo7oQi9Lz1Z+OUHm
         kbDCm328hG7D5aOGjZqa6ctKyDv0Bd/uVJsXjal84yMuIBi1MJ9udjggE6rfwnXhdSGe
         pRpUu1bHJXE1FFN0Yl1s3aSsTNsYtynYoflK5MSDomLKqY09s073l1/Tg98qoDTbGNGD
         3jdw==
X-Gm-Message-State: ACrzQf3NIhd269NVp8iTk6hQwVqzN7DKLRNZIjo9ldeii5wk2rwgnVrp
        RLmY+RMDmat+/lS3cPMeX/ufzzPCVt+IgL0ESJUKoA==
X-Google-Smtp-Source: AMsMyM5v5LDC0BBL5gYqehs/SqfSDyUe3Uxe1Ev3owdj68C4Qz8wqJvfTKXOJXJGGPXuN1JCNY46IEZom7aRnXaTplE=
X-Received: by 2002:a2e:978e:0:b0:26e:8ad6:6d5b with SMTP id
 y14-20020a2e978e000000b0026e8ad66d5bmr3880239lji.363.1665995580212; Mon, 17
 Oct 2022 01:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221014084837.1787196-1-hrkanabar@gmail.com> <20221014084837.1787196-6-hrkanabar@gmail.com>
 <Y0mD0LcNvu+QTlQ9@magnolia>
In-Reply-To: <Y0mD0LcNvu+QTlQ9@magnolia>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Oct 2022 10:32:48 +0200
Message-ID: <CACT4Y+aNuRX52u5j1vKpJKru-riSktugDMtDKchR0NLCuvXOQg@mail.gmail.com>
Subject: Re: [PATCH RFC 5/7] fs/xfs: support `DISABLE_FS_CSUM_VERIFICATION`
 config option
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Hrutvik Kanabar <hrkanabar@gmail.com>,
        Hrutvik Kanabar <hrutvik@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 14 Oct 2022 at 17:44, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, Oct 14, 2022 at 08:48:35AM +0000, Hrutvik Kanabar wrote:
> > From: Hrutvik Kanabar <hrutvik@google.com>
> >
> > When `DISABLE_FS_CSUM_VERIFICATION` is enabled, return truthy value for
> > `xfs_verify_cksum`, which is the key function implementing checksum
> > verification for XFS.
> >
> > Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>
>
> NAK, we're not going to break XFS for the sake of automated fuzz tools.

Hi Darrick,

What do you mean by "break"? If this config is not enabled the
behavior is not affected as far as I see.

> You'll have to adapt your fuzzing tools to rewrite the block header
> checksums, like the existing xfs fuzz testing framework does.  See
> the xfs_db 'fuzz -d' command and the relevant fstests.
>
> --D
>
> > ---
> >  fs/xfs/libxfs/xfs_cksum.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/xfs/libxfs/xfs_cksum.h b/fs/xfs/libxfs/xfs_cksum.h
> > index 999a290cfd72..ba55b1afa382 100644
> > --- a/fs/xfs/libxfs/xfs_cksum.h
> > +++ b/fs/xfs/libxfs/xfs_cksum.h
> > @@ -76,7 +76,10 @@ xfs_verify_cksum(char *buffer, size_t length, unsigned long cksum_offset)
> >  {
> >       uint32_t crc = xfs_start_cksum_safe(buffer, length, cksum_offset);
> >
> > -     return *(__le32 *)(buffer + cksum_offset) == xfs_end_cksum(crc);
> > +     if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION))
> > +             return 1;
> > +     else
> > +             return *(__le32 *)(buffer + cksum_offset) == xfs_end_cksum(crc);
> >  }
> >
> >  #endif /* _XFS_CKSUM_H */
> > --
> > 2.38.0.413.g74048e4d9e-goog
> >
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/Y0mD0LcNvu%2BQTlQ9%40magnolia.
