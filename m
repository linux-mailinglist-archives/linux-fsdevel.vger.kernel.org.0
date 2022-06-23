Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D2455724A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 06:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiFWEn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 00:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242500AbiFWDoq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:44:46 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7143F38BEA;
        Wed, 22 Jun 2022 20:44:45 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-3176d94c236so182190667b3.3;
        Wed, 22 Jun 2022 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=87+jqdc/swXM39LR3YrT/Es6B7pcswSF3qdCNbDWq7A=;
        b=b4xE/R+DYlSKO8+dNve958FxZBZUlIgYpsivvBKmOjH2uG/XkZyL5obCInFUR87cPw
         xOTAx5qd4ptFLqRFf8HgiwSg1IeuQcpj3SnbBtcwneYXaNxjuD26kP3gJKwaSkIU5kDH
         gubJVj5FAlMxu+HxxgEWFPL9hC7Pr6u4CGOKLC0OCrLNdl95xrD6YImbovykzdaPahki
         JBk77KuNTSR35R5CddxaiNW0u/q3m/Oy2Uii5HQ0yMpAVeL62fltTQq4BEHyRiBRUTWP
         5X16Q8NdvcdZZwxLaCZhWPhgLIS5TqWNLUiwZkmhtohHNdHOvoUd9q6GAvRwF+PUg6lC
         hlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=87+jqdc/swXM39LR3YrT/Es6B7pcswSF3qdCNbDWq7A=;
        b=ZKpsoLD8u9xezGk7ANWG5DzthZT5UihopMvQLGvSeNHJHc05qX4lWsfotgyXdXBAtC
         Xtb2tkCFovujD/7EfiK7L1w6Oz9jkSwHntiJ2RoywCSHbNvq/oD82Ql0V8iocBXbs46F
         BpQFp7G4r1P2UZw8rk6tMFGzj019FNU2FR6sNWiSnQTQxbftwWRKIGn6eFt22st60kUC
         wFvgkbn9HovvkL2iqJV9jwFyBTLPYyCrQBDdcVVoOvLDTtM32aNtcvrBuMLgrQ4+9+1q
         XDhIsJaiMB53dmWEaKmZR6y3Mv30Our3cDl/2l8dBqLLlJE2WjAg4jfx6vL8OuHA3Z8f
         oihw==
X-Gm-Message-State: AJIora9CXH0Uh9iMTiCV1Gw7eS3t81fkQH+i7cy99HQo7NIyfeX/7InC
        oH5oYtOaBQgGTCGcapauyCAc2da8XRHG27QDMarMzCK8WA==
X-Google-Smtp-Source: AGRyM1uyqSObM5djsfE5PLDD65Jl8onD8RTBriLFddJHv6e+wkdSDAMk4iMnMvKA97WWkBxT9lu+9RJNjymiNNUWYgg=
X-Received: by 2002:a81:4857:0:b0:318:48dd:4165 with SMTP id
 v84-20020a814857000000b0031848dd4165mr6599997ywa.481.1655955884782; Wed, 22
 Jun 2022 20:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220622085146.444516-1-sunliming@kylinos.cn> <YrLwU27DNm0YWOvB@ZenIV>
In-Reply-To: <YrLwU27DNm0YWOvB@ZenIV>
From:   sunliming <kelulanainsley@gmail.com>
Date:   Thu, 23 Jun 2022 11:44:29 +0800
Message-ID: <CAJncD7RuTTLoRS_pzvn729_SX5Xsv6Pub44eCD_RbbANjn9joA@mail.gmail.com>
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

It might be more appropriate and easier to understand to do this
before parameter passing in the top-level  walk_component function=EF=BC=9F
