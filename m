Return-Path: <linux-fsdevel+bounces-4001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A07FADA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 23:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6A21C20C3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 22:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B148CE8;
	Mon, 27 Nov 2023 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ID45RUGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E48136;
	Mon, 27 Nov 2023 14:43:43 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50baa1ca01cso3471956e87.2;
        Mon, 27 Nov 2023 14:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701125021; x=1701729821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foiBk/ZA1mkomKbuyODxXA1fCwhGzz9IZsGMizOPkiU=;
        b=ID45RUGiAP9CsqTJQ6PG3qEofa1Jm1dGaNypCaqKwK3FOP993WYQgCsYw65D0vhuxR
         a22pSzZjFvil5KdRsu+0skwLLHsGVqIxQluWYcKEr2axHGfFFaPZs/qhv1WPidcahWcK
         JI0W1tMG8mR0jwO16//7+AV/BjvbvXwciraS6TnW4Z04eSY8yt1mUupb1lF7uOGaMmgZ
         0IDVMS7UaoW+vscxPWa+r6pXirmqKyZR6ya2OvD44TGmJCda2WfcXFe9psv+Ow1/V8/j
         iwMulrjJHKJGRHjACeZLa72ExNf0fPBzJ56PwqdWkBEyujDIIkSPl4j/RbIWccZdd63o
         cFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701125021; x=1701729821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foiBk/ZA1mkomKbuyODxXA1fCwhGzz9IZsGMizOPkiU=;
        b=BqDom476G4kakuQunDU1zwmxS5rxMHgE10iMLxM3JNbVJ+Yk+NJXRDSdJBnJxMdDvK
         P6sLMvtoKscRk0iuoz516GP0iF95GncwjnIaajUyQO6/IsZU7uxayrYI3tDdbpmrwQYA
         uKGKwaaJ/kTwTl4MEXGrZhILQKr21sFp1x/qENwtCUeYNZIyuiSR3ICTKhg/X30D9UOr
         /CEv970QcC6/p6oLq0qopoFy2m4nBniEyz25Pi7vtGlp4Jai4lhh/g1TvDSBCQ2GiksN
         t/3qA3g6epwac2CacSJy4jebxdwCdyKLoX5sjxtMxUfnnr2YiTLoBuZratUAtVzCVrkz
         Wq9A==
X-Gm-Message-State: AOJu0YxfUL8u57VPWGZlWwinoxScTpkVeFvvitvQ3Iek3/7FvyBK585v
	5aZFq5RZBdwSdUFJ919KiBr4Y3LKkoPEpYaxVRY=
X-Google-Smtp-Source: AGHT+IHmKb1gb9jA3n4dwJiAK1+CB/eZJpIxFw9Q9aAnrqj2qZiA88GwtrrQcHlpzJ/KjU7jlNfUvL7JildP+Eayilk=
X-Received: by 2002:ac2:4c4b:0:b0:507:a9e1:5a3b with SMTP id
 o11-20020ac24c4b000000b00507a9e15a3bmr7415709lfk.0.1701125021321; Mon, 27 Nov
 2023 14:43:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ8C1XPdyVKuq=cL4CqOi2+ag-=tEbaC=0a3Zro9ZZU5Xw1cjw@mail.gmail.com>
 <ZVxUXZrlIaRJKghT@archie.me> <CAKYAXd_WFKXt1GqzFyfrJo6KHf6iaDwp-n3Qb1Hu63wokNhO9g@mail.gmail.com>
In-Reply-To: <CAKYAXd_WFKXt1GqzFyfrJo6KHf6iaDwp-n3Qb1Hu63wokNhO9g@mail.gmail.com>
From: Seamus de Mora <seamusdemora@gmail.com>
Date: Mon, 27 Nov 2023 16:43:05 -0600
Message-ID: <CAJ8C1XOzdscAUGCBh9Mbu9cm-oAqRA4mBoGjSFCxydJSCkzkUw@mail.gmail.com>
Subject: Re: Add sub-topic on 'exFAT' in man mount
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linux Manual Pages <linux-man@vger.kernel.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Alejandro Colomar <alx@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 5:59=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> 2023-11-21 15:55 GMT+09:00, Bagas Sanjaya <bagasdotme@gmail.com>:
> > On Mon, Nov 20, 2023 at 04:55:18PM -0600, Seamus de Mora wrote:
> >> I'd like to volunteer to add some information to the mount manual.
> >>
> >> I'm told that exFAT was added to the kernel about 4 years ago, but
> >> last I checked, there was nothing about it in man mount.  I feel this
> >> could be addressed best by adding a sub-topic on exFAT under the topic
> >> `FILESYSTEM-SPECIFIC MOUNT OPTIONS`.
> >>
> >> If my application is of interest, please let me know what steps I need
> >> to take - or how to approach this task.
> >>
> >
> > I'm adding from Alejandro's reply.
> >
> > You can start reading the source in fs/exfat in linux.git tree [1].
> > Then you can write the documentation for exfat in Documentation/exfat.r=
st
> > (currently doesn't exist yet), at the same time of your manpage
> > contribution.
> >
> > Cc'ing exfat maintainers for better treatment.
> Thanks Bagas for forwarding this to us!
>
> Hi Seamus,
>
> Some of mount options are same with fatfs's ones. You can refer the
> descriptions of fatfs
> documentation(Documentation/filesystems/vfat.rst).
> If you have any questions about other options or documentation for
> exfat, please give an email me.
>
> Thanks!
> >
> > Thanks.
> >
> > [1]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/exfat

Thanks for the offer Namjae; I'm sure I'll take you up on that when I
get ready to actually produce something. For now, I am reading and
trying to get myself up to speed to tackle this. So far, the going has
been a bit slow as I have a couple of commitments I need to finish.

Rgds,
~S

