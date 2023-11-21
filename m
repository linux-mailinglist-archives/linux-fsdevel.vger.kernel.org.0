Return-Path: <linux-fsdevel+bounces-3301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307637F2B73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 12:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C3A1C2176E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB00482F2;
	Tue, 21 Nov 2023 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB+jt0fH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F57A2;
	Tue, 21 Nov 2023 03:08:10 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41ea8debcdaso31593331cf.1;
        Tue, 21 Nov 2023 03:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700564890; x=1701169690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASFhtlsPEvttfypb4jVytG2dTOUbdI3TYi4J/KQpO18=;
        b=LB+jt0fHdJrInHZMo9B5+2YESkt8qdzA4D1BHeGXreSU7eCVlInBBGE+alIHZDkW8T
         ijrkFkaeSxxFCWDJtvymuHcRCJPXYvExoVw99WdqSn8ZpktOCEFX6pdIz++W2qI8+3zS
         btmZzqG7XRSdQzoqtp8U1svxu4xN4cBzMVfU3heFdc43LscTZmavFoXsvvKtY9fkupNg
         Klz3NGc0Zt7oOdAgFIUeB7nOZHXOnmNbL5EyrPycTj9Grshxk7V3DxgvniTbsJ7bX18/
         2Vkzl5ypAPe4Bx5H8gafQ6w1fmaBpm0Ivd5lW0RsPn6WbxXkmNSmdNR042FwP9aVDquZ
         eWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564890; x=1701169690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASFhtlsPEvttfypb4jVytG2dTOUbdI3TYi4J/KQpO18=;
        b=M1Ykm/V6+pewZfy5m1SMMl/Ksa+dFCt0vCpxpulqYpzO5ZLl1rGrs3YW21llGCKEJc
         cWbPS644u0N+jdmRCt0j6gR4KbeJHB436LQaOMV05+68UrM9ZK4ObQJcB1uYAzbohfqL
         foY6IOq5F8AJiSKN84wxNOEMi2Z/aHArOXDKWOgYQwzI9lgdAbN0eJ43qmy1tL12RyaL
         5rI5qZnR89fO/nQq7vFMQlmusz5Kfhhd/Uyi0ShHPVU9RELLL2omJQ4wnGKmXNq17OkV
         xMdlAvnY4vM76vQnzZypaTKXOLEnrFsSOzSgLWnrJarqu0WDEeElyOLay3lj8o5Pxaly
         TVyg==
X-Gm-Message-State: AOJu0YwMamHYrg/PqgwV1yuBOJKct8FsszLPLnJhUknQvju5KGmA3S1d
	djAEqQJCz5+dzpe4pN6OBtve8nC/ScJ04eoPsJo=
X-Google-Smtp-Source: AGHT+IHk1gP6iVFNZtGe3hnyHx1jw4fz6q/fYik2fOkYR0YitdFgNdTFIaGNUYjrBjJ3a2qhEJfCISBHIyKWKrs0ce8=
X-Received: by 2002:ac8:5d0c:0:b0:417:fd7e:2154 with SMTP id
 f12-20020ac85d0c000000b00417fd7e2154mr15582784qtx.9.1700564889974; Tue, 21
 Nov 2023 03:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114153254.1715969-1-amir73il@gmail.com> <20231117194443.GC1513185@perftesting>
 <CAOQ4uxjuDxSro+4qtXfodSf-EcAA8aUBGuWpaVn4+H8Ai=JcFg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjuDxSro+4qtXfodSf-EcAA8aUBGuWpaVn4+H8Ai=JcFg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Nov 2023 13:07:57 +0200
Message-ID: <CAOQ4uxh8GY=OwTWzkokDFq4O-1UVVYMEezBDQqEp=yP51zdbGg@mail.gmail.com>
Subject: Re: [PATCH 00/15] Tidy up file permission hooks
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 8:59=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Nov 17, 2023 at 9:44=E2=80=AFPM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > On Tue, Nov 14, 2023 at 05:32:39PM +0200, Amir Goldstein wrote:
> > > Hi Christian,
> > >
> > > I realize you won't have time to review this week, but wanted to get
> > > this series out for review for a wider audience soon.
> > >
> > > During my work on fanotify "pre content" events [1], Jan and I notice=
d
> > > some inconsistencies in the call sites of security_file_permission()
> > > hooks inside rw_verify_area() and remap_verify_area().
> > >
> > > The majority of call sites are before file_start_write(), which is ho=
w
> > > we want them to be for fanotify "pre content" events.
> > >
> > > For splice code, there are many duplicate calls to rw_verify_area()
> > > for the entire range as well as for partial ranges inside iterator.
> > >
> > > This cleanup series, mostly following Jan's suggestions, moves all
> > > the security_file_permission() hooks before file_start_write() and
> > > eliminates duplicate permission hook calls in the same call chain.
> > >
> > > The last 3 patches are helpers that I used in fanotify patches to
> > > assert that permission hooks are called with expected locking scope.
> > >
> > > My hope is to get this work reviewed and staged in the vfs tree
> > > for the 6.8 cycle, so that I can send Jan fanotify patches for
> > > "pre content" events based on a stable branch in the vfs tree.
> > >
> > > Thanks,
> > > Amir.
> >
> > Amir,
> >
> > The last 3 patches didn't make it onto lore for some reason, so I can't=
 review
> > the last 3.  Thanks,
> >
>
> Sorry for the mishap.
> The entire series was re-posted shortly after to fsdevel:
> https://lore.kernel.org/linux-fsdevel/20231114153321.1716028-1-amir73il@g=
mail.com/
>
> > You can add
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > to patches 1-11.
>

Christian,

Here is a status update on this patch set.

1. Patches 1-11 reviewed by Josef -
    if you can take a look and see they look fine before v2 that would be g=
reat
2. Patch 3 ACKed by Chuck [1]
3. Patch 9 should be preceded by this prep patch [2]
    that was ACKed by coda maintainer
4. Patch 12 is self NACKed by me. I am testing an alternative patch
5. Patches 13-15 (start_write assert helpers) have not been reviewed -
    they were posted to fsdevel [3] I'll appreciate if you or someone
could take a look

Once I get your feedback on patched 1-11,13-15
I can post v2 with the patch 9 prep patch and the alternative fix for patch=
 12.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/ZVObiRlwcKgT0e53@tissot.1015grang=
er.net/
[2] https://lore.kernel.org/linux-fsdevel/20231120095110.2199218-1-amir73il=
@gmail.com/
[3] https://lore.kernel.org/linux-fsdevel/20231114153321.1716028-1-amir73il=
@gmail.com/

