Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19785557228
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 06:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiFWEoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 00:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbiFWD0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:26:55 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C7C32EF9;
        Wed, 22 Jun 2022 20:26:54 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-317741c86fdso179918427b3.2;
        Wed, 22 Jun 2022 20:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JNybckUxm5otNEbFw60yQ2dMtFPY6hEGSuWHqLz60QM=;
        b=oJvhpXy33TJnMmAM9XmiHDngCvJn1nhnVe7FD+U8sWRhMtNkAkqEEv+s6eM3sjC9nQ
         SP4/oKyZzFIcSvzVcZcJRkpqNU2l+p4u/EsCSTuDAENNJvUk2Rm/IwCJcU/xA5kJVkR5
         0WnCrZf0DYztoO4VnAkTeJMZexhQu998QlhHncdmOP6wK1nAs8foWL5ohlo6buCBOGMf
         CV+EmroH/AE3KWZJghzatzlV0/6fAbP73/BurcAl5NN9OI104wbc/N4kX8/PDwQEWhOI
         Uu2nIqO3fW4KrnXf3F8Hylzi3Rn/t/t6xCeuACuevBIZPJu9eEesMdS2mNoDsROenGq1
         FDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JNybckUxm5otNEbFw60yQ2dMtFPY6hEGSuWHqLz60QM=;
        b=Imax4TBeBP3K+buGcXLL8156GcnAHBt/1jOkEfTMN5Amim0LMkHsCf1T2Q830m5OJt
         sOC2AKIbLuHvOAapo7lNDRc/UejaPOdyanz1yDCoTuGCSFznLhTySOtfoeB9TzJTtwYt
         vixJnr9fnfYODcCO+DnbKsznWZhhoEjHAH8ZM1ymAPY59bsjMrUOVLX4yxvZzrZB7dSv
         3EfGpo+92ABys7eYuOSaC/4lR1vrak8eXNuk0gzuXiyzyKexaVRqKFgMX0nFDssLjqL0
         qxddCo0P61Zywn6X2tqEXXoBVxNMKeioXoWI1a6Q6dprJPZr3aaeL2u6d2aw+4LG7GGF
         bidA==
X-Gm-Message-State: AJIora8WTeQt5v1eXW52ePf2X1//UYjkmJXKdtfaZmDTj/Q2giKY8yqb
        DDrlhipvInBMasGEpy4KJWMiepENFztCyng7Rib3/5Y=
X-Google-Smtp-Source: AGRyM1viAbCUWVPQ/NGv98H+Ta6yzR+JD0FHQ26J99CPudTae7UzU1vo507V0OpaWVB3wSaUkDUfo9G0LwP/MyfnqgQ=
X-Received: by 2002:a81:106:0:b0:2d0:e682:8a7a with SMTP id
 6-20020a810106000000b002d0e6828a7amr8156975ywb.257.1655954813053; Wed, 22 Jun
 2022 20:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220622085146.444516-1-sunliming@kylinos.cn> <YrLwU27DNm0YWOvB@ZenIV>
In-Reply-To: <YrLwU27DNm0YWOvB@ZenIV>
From:   sunliming <kelulanainsley@gmail.com>
Date:   Thu, 23 Jun 2022 11:26:38 +0800
Message-ID: <CAJncD7S6inm90TEsUS6GpSiAdHHE95Q2qz08TmojN2uhhHA0Zw@mail.gmail.com>
Subject: Re: [PATCH] walk_component(): get inode in lookup_slow branch
 statement block
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sunliming@kylino.cn
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

Al Viro <viro@zeniv.linux.org.uk> =E4=BA=8E2022=E5=B9=B46=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=B8=89 18:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jun 22, 2022 at 04:51:46PM +0800, sunliming wrote:
> > The inode variable is used as a parameter by the step_into function,
> > but is not assigned a value in the sub-lookup_slow branch path. So
> > get the inode in the sub-lookup_slow branch path.
>
> Take a good look at handle_mounts() and the things it does when
> *not* in RCU mode (i.e. LOOKUP_RCU is not set).  Specifically,
>                 *inode =3D d_backing_inode(path->dentry);
>                 *seqp =3D 0; /* out of RCU mode, so the value doesn't mat=
ter */
> this part.
>
> IOW, the values passed to step_into() in inode/seq are overridden unless
> we stay in RCU mode.  And if we'd been through lookup_slow(), we'd been
> out of RCU mode since before we called step_into().
OK=EF=BC=8CI got it.
