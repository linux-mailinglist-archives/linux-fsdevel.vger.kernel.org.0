Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2BD557743
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 11:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiFWJ6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 05:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiFWJ6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:58:10 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF885F54;
        Thu, 23 Jun 2022 02:58:07 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id u9so24761399ybq.3;
        Thu, 23 Jun 2022 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZeGspWw1vye6pac9s6w/497q8ma6W6rlqTLSFeJT8gs=;
        b=grzSBAhI0jduNUJ9+2cpo7BJRoLi94CoDBjPQMBoU6GTYtG+lguB6B9m8ibDpLS9WN
         1+na+djFc5Pgv85PGvcVltvtA7WEHSZcBy5j6uSyMl4djKY7E/pGSn6VmHffPHHjlC5E
         OzJBEDB/+M3wi4E33UyKUVOSeCTDiukjbIWLh1b3fdh/keCZ8nPZiZDr29MELzQ2Gi5z
         1rp482ZtekzQ0GuoQjSQps41hCgMXImuXttWtxwevTzTVTHV68tSv0z6LpN/SI8Yl7vT
         Up18u6N5dpjNlurzt1Bbm0l/e4EPbd9vJ6McpAptJFi5hRJRmRQWfT6N2LcBJTVBqWRm
         WXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZeGspWw1vye6pac9s6w/497q8ma6W6rlqTLSFeJT8gs=;
        b=2dOLx06PAXNNMriGWCkflDorRhuK8RhkM341JtR1Ed6YVrnTkuamjovjIK+9/GuLHj
         O8LROH7BUn45bGDGt/k2wiRkaebCmoO+/txpFMmNcTVIjyKbFWe8MteWzsE/N3gWljJh
         AGOdwXnNhF9OgLjARWhEJ/vYNYmLiLwVUn05W8SQvGFBQfTD65gGk7pv1epNBo1pex3x
         sqLwnBsX+jy+RyK9BlSXO2G6fnPCbcz5+zsHE0RumKso3RyOmhqImsuIrMh4da2WkxjB
         xCUBEvYfgOlV7xAtA5W8eOU9Q/vKxYvBWGkIlcSL4t/2qt2Nn47PUxmOsus2dfSBQQDp
         Irqg==
X-Gm-Message-State: AJIora/Ms4lBqShuAvw/gQmiEFqOsWwqZOCxBIqV9cPXk7oi2Vwxn/HQ
        wr+vtI5LhIpoADSnx48s8YpFYzq49qnI6+5OkGRgOvMrOqY5
X-Google-Smtp-Source: AGRyM1sz6gRPcCXM02hk0EqlRMXw+uAPQphLu6qe68SYbq4vpjnAI69MEKDfRrgpmGQop2LZI+rHzoCJf2v4/Eyh0rw=
X-Received: by 2002:a05:6902:124a:b0:669:2154:aa15 with SMTP id
 t10-20020a056902124a00b006692154aa15mr8569924ybu.53.1655978287152; Thu, 23
 Jun 2022 02:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220622085146.444516-1-sunliming@kylinos.cn> <YrLwU27DNm0YWOvB@ZenIV>
 <CAJncD7RuTTLoRS_pzvn729_SX5Xsv6Pub44eCD_RbbANjn9joA@mail.gmail.com> <YrPinPcHHNfv3E3B@ZenIV>
In-Reply-To: <YrPinPcHHNfv3E3B@ZenIV>
From:   sunliming <kelulanainsley@gmail.com>
Date:   Thu, 23 Jun 2022 17:57:56 +0800
Message-ID: <CAJncD7SiqoXEKhT8D8OivNz96M4h=0NTs+jZtKF00gnFnrVxsw@mail.gmail.com>
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

Al Viro <viro@zeniv.linux.org.uk> =E4=BA=8E2022=E5=B9=B46=E6=9C=8823=E6=97=
=A5=E5=91=A8=E5=9B=9B 11:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 23, 2022 at 11:44:29AM +0800, sunliming wrote:
> > Al Viro <viro@zeniv.linux.org.uk> =E4=BA=8E2022=E5=B9=B46=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=89 18:35=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Jun 22, 2022 at 04:51:46PM +0800, sunliming wrote:
> > > > The inode variable is used as a parameter by the step_into function=
,
> > > > but is not assigned a value in the sub-lookup_slow branch path. So
> > > > get the inode in the sub-lookup_slow branch path.
> > >
> > > Take a good look at handle_mounts() and the things it does when
> > > *not* in RCU mode (i.e. LOOKUP_RCU is not set).  Specifically,
> > >                 *inode =3D d_backing_inode(path->dentry);
> > >                 *seqp =3D 0; /* out of RCU mode, so the value doesn't=
 matter */
> > > this part.
> > >
> > > IOW, the values passed to step_into() in inode/seq are overridden unl=
ess
> > > we stay in RCU mode.  And if we'd been through lookup_slow(), we'd be=
en
> > > out of RCU mode since before we called step_into().
> >
> > It might be more appropriate and easier to understand to do this
> > before parameter passing in the top-level  walk_component function=EF=
=BC=9F
>
> It's possible to fall out of RCU mode *inside* step_into(), so we need
> it done there anyway.  Unfortunately ;-/
Thanks for your explanation
