Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5154310447
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 06:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhBEFBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 00:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhBEFBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:01:06 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24229C0613D6;
        Thu,  4 Feb 2021 21:00:26 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id d20so6251943oiw.10;
        Thu, 04 Feb 2021 21:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tg/3V2Rv5u2M2MO9kx/o0aGJFOc9i6LQtuKId3ENj5I=;
        b=uXhJzcHjOmYDk6sr+fbRmJzVQvC7RxzhUyNM5pjhKG4F3eidLTI2T0JsCoLO5QMUYB
         dtGMbs2266oVsZ6LcqtC1sjoaihMAppUwtOj/rUJiokh4qhlKzWaDZKAryIfhmMT6jZ7
         Bb7zJzjFkjfAPYcJ/tuVYq5C5GR9+SvK44F1y8gikWo/STkJ2CqqF4YBclwzIa5dMEpm
         N+o9vHaBM16dMQQKG4EJU5yYgE8uu3dYfTRWj7TLeWlJJ8i2ZQPW1lskcRh9q1FyHfvc
         tJq9l0cqh9aZaeoZWYqFWbkTLdan/u04B83ExoNPUyhvUgAz2a/JsF+3SqRyK7FQUj2S
         b78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tg/3V2Rv5u2M2MO9kx/o0aGJFOc9i6LQtuKId3ENj5I=;
        b=oySPErqEBzNaLj48bHZoFYNN6IFJLngT1kro56SFDiKsHH2lIn18yiZtQewDtDlP87
         YGBka20MspvHyaNjF664eiATFbY6iIx3M4g9wierMlb/J6Xnxot9eXD+c3QJijXzEid6
         t8UBt921mnlsU7YUnFPggESmNR7mKquAPuNlGVXNMaPcylOb1wvFdRAKF+NSFfW5NYMt
         JSh1RuvOgLN632ZnU0eA691MlTF4sg5mss30BPlvLZMnorqzidTYVIzHCuQcXAsEHvV+
         xEw+n8/d0cSL+YrhUS2VKhh/fa5HDp+ejYYnhZ33tIjcHWAgHWd6aPCgJWYKOhdiAyhZ
         eBzA==
X-Gm-Message-State: AOAM531WpjP+Y1e8fKXWU7tBp4cTy0QakHyhbFpTF/DdXNIBvO97VfWc
        i/9wjzdPNuZOoUFI0tbESVgSgEEs/OSXiOngsW5zDrfF1E8=
X-Google-Smtp-Source: ABdhPJz2HS/2ghZA+VjmpDjaWHIvATcBN2qLgB2LjIgxpnUAFop7lParWMlXwL3gHSftsxkTYWU9reherQQbozWXmc8=
X-Received: by 2002:a54:458f:: with SMTP id z15mr2043195oib.139.1612501225504;
 Thu, 04 Feb 2021 21:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20210205045217.552927-1-enbyamy@gmail.com> <20210205045217.552927-2-enbyamy@gmail.com>
 <DM6PR04MB4972E287DED6DA5D4435986286B29@DM6PR04MB4972.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB4972E287DED6DA5D4435986286B29@DM6PR04MB4972.namprd04.prod.outlook.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Thu, 4 Feb 2021 21:00:14 -0800
Message-ID: <CAE1WUT7BHwyL600Zx_3JrG4CGUgCTdufr8Hyy0ObYALqHO_OoQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs/efs: Use correct brace styling for statements
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 4, 2021 at 8:57 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 2/4/21 20:55, Amy Parker wrote:
> > Many single-line statements have unnecessary braces, and some statement=
 pairs have mismatched braces. This is a clear violation of the kernel styl=
e guide, which mandates that single line statements have no braces and that=
 pairs with at least one multi-line block maintain their braces.
> >
> > This patch fixes these style violations. Single-line statements that ha=
ve braces have had their braces stripped. Pair single-line statements have =
been formatted per the style guide. Pair mixed-line statements have had the=
ir braces updated to conform.
> >
> > Signed-off-by: Amy Parker <enbyamy@gmail.com>
> Commit message is too long. Follow the style present in the tree.

Are you referring to the per-line length? That was supposed to have
been broken up, my apologies. Or is it the overall length that is the
issue?

   -Amy IP
