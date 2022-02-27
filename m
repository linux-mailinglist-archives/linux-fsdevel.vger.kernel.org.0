Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3D24C5E15
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 19:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiB0S2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 13:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiB0S2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:28:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5605A6319;
        Sun, 27 Feb 2022 10:28:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d10so20598335eje.10;
        Sun, 27 Feb 2022 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=if4Fre52/w2KJvlhq2Fh0w9ZPnSn2eaHXlg8jB08NKE=;
        b=LMjDPtWjqobgSKHRsOsUWPOvbU42FVKWl88Qz3dUU1cv7rDQSEg/b6TgcI0XLKHy18
         EQP6iq/Z7XRXur9ijiYNWOOemFo+Tx71SCwEeGcz6jERwch7WCLAZ/FNn1UAS9QsQTqc
         G1JAwC9TX7bkpA/3AQsrU2pyy5TZcGHNei57SvEBdpWMo+ECB18IWbh8bW6bBvR9ao6C
         zCvn4FCmk8P9rOkzoXGJkInDSfgSMm6Tp5W/RYtLTVjkoQUn8CwE9deA7MDIZhvCvKTI
         12qBGQ+esv1pqyVqlTFE/NkYwjzQAqJrvyiHpxOZ+eTMd2wgZcPtboQVqQjABNkSMM2P
         1/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=if4Fre52/w2KJvlhq2Fh0w9ZPnSn2eaHXlg8jB08NKE=;
        b=1hN148s5pZ3tq7p29mg3GRdaN9r59zuNZrRkqc3rULDGoQq1V994c0Dens6ui0QP8s
         cx9RmUjFTc1y2Gy2eVaUAFN0+xwFOT6mNzj0389jVG7khWRuhOQrsCpxWI0cw1YCGnen
         ubGvQVIVv5L/mpSJgwp5FwC2usl/Hc0BULbA+egfebNI7anVNUjxqUIx2z3tEg3RE0VD
         b6Xewv8uArS4HN05WNhEfXx6hmAnrKJTXYJ7vcNlqhIFSD6tVyyB7YFGVQALG3tj2/5t
         w6SOmeGsp8ImF/GUjem7AngsHKmU+9xqNosUL0/OoipIi1UhhgmP41OQDLTSWlsJ7fpW
         8Ykg==
X-Gm-Message-State: AOAM533yV5AJ95oBORFVmmXx6dQigXDpR5whMqs1nX6uD8/lL4L3OBaP
        7D8FLEGWjnMPIgv0OTCEF36cgeW2AYpxIR9qNE2SClL1
X-Google-Smtp-Source: ABdhPJwbJgpJOI9EugajVR/mYoWiY1yIhqIr+QW5dep+mQNnvd6+haCVQXEJHZo4gUhuO6EzscGhGcJtD76Q5iUsa8s=
X-Received: by 2002:a17:906:3650:b0:6ce:a6e0:3e97 with SMTP id
 r16-20020a170906365000b006cea6e03e97mr13357842ejb.15.1645986485655; Sun, 27
 Feb 2022 10:28:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645558375.git.riteshh@linux.ibm.com> <a1e9902e84595a2088bcf4882691a8330640246b.1645558375.git.riteshh@linux.ibm.com>
 <20220223093713.fw7c54xmllxrmmld@quack3.lan>
In-Reply-To: <20220223093713.fw7c54xmllxrmmld@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 27 Feb 2022 10:27:54 -0800
Message-ID: <CAD+ocbwweF5vZh3AHRFnCQJCUC045KgoY+F2Z1aOHyxdrcxK5A@mail.gmail.com>
Subject: Re: [RFC 1/9] ext4: Remove unused enum EXT4_FC_COMMIT_FAILED
To:     Jan Kara <jack@suse.cz>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

- Harshad

On Wed, 23 Feb 2022 at 01:37, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 23-02-22 02:04:09, Ritesh Harjani wrote:
> > Below commit removed all references of EXT4_FC_COMMIT_FAILED.
> > commit 0915e464cb274 ("ext4: simplify updating of fast commit stats")
> >
> > Just remove it since it is not used anymore.
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> Sure. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>                                                                         Honza
>
> > ---
> >  fs/ext4/fast_commit.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> > index 02afa52e8e41..80414dcba6e1 100644
> > --- a/fs/ext4/fast_commit.h
> > +++ b/fs/ext4/fast_commit.h
> > @@ -93,7 +93,6 @@ enum {
> >       EXT4_FC_REASON_RENAME_DIR,
> >       EXT4_FC_REASON_FALLOC_RANGE,
> >       EXT4_FC_REASON_INODE_JOURNAL_DATA,
> > -     EXT4_FC_COMMIT_FAILED,
> >       EXT4_FC_REASON_MAX
> >  };
> >
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
