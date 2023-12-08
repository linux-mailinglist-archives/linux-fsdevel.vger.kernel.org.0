Return-Path: <linux-fsdevel+bounces-5389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A66680AFD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 23:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D8F1F213FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 22:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7D59B77;
	Fri,  8 Dec 2023 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bm9iP9vn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852C7171F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 14:43:42 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db539ab8e02so2950947276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 14:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702075421; x=1702680221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YtvPSFjodu+ZgraE7QhIaNyDdff0Uneik8gDZ6S5Lo=;
        b=bm9iP9vnIfZm1eOEoqYXZl63iLPc2k72WSKL9MJwsjpZ1os51/QbXbMJ9cadWxz6Am
         CckXn5glIT76wVA3ifXSky61kMGMk4Ex31pBnwtCy5BQd+VFi9xAtQGAfBtekIQTuHyz
         4LjyzcIirIf0FT2kbD9P7IIchieiptLuiYrXtenofP8hSvCrYI0jFhi9mDkWC6JHn/lE
         XKP6iVoDAkeRU5MBxityrE3op7pv/Xjz1m8Pm3CnGD2ThGMHZzyKTpDSdwJAF/J9ubco
         SuX+fZFm7hnlCZ98mOXoVC2b0LU8YCCD71qjPzYGlnA8d27KbNSxoHhSvMH+m6QO4QQK
         H4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702075421; x=1702680221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YtvPSFjodu+ZgraE7QhIaNyDdff0Uneik8gDZ6S5Lo=;
        b=CTJoJRLRoDw3uSGYeEug8Peyr2IrGounDOsVr1nfiOpNPj5Q4YImS686ravI1sriNR
         WUVDVmlOUnmgMQqlPVP6FYQXUMdA6ddLE88po3I8HTrED3zEH5OH08HLkgKdwpLpUWk/
         A2rH4j9ByZ978B05quqAKUaM7hJTplIsK/0etdz2OyCAdM3X7oib5wDFmaghGs9uN0FW
         w3v9jQjjgx4yh/t5Mj4sKYI0O2U4/ovHaIH4l6L9xBJWPBIEH/LEGvyTzfRAeJdZM72Z
         Pj3ZY46+ArdsJaaj2BrM42G4kX5OQLtvrTQV+x7lT80QmFRThPXlPZ9fpsFrgj6aOphk
         66jA==
X-Gm-Message-State: AOJu0Yx3hfGYnwFBp/LFaj11YESoY3jD0pm8K50az0V0DnYXD9vIxRjs
	Q/GV07HE7f9y7PAhkffR9Ocl5hGinAyuIKydXxAd
X-Google-Smtp-Source: AGHT+IF9tjmLAyUmVUsZYC10muP3I76/RHeidBltFtIH7wYUsGHZIib9uJNx8Z3A7Unf+g5whxu1AgvucF0VPR71ABA=
X-Received: by 2002:a05:6902:150:b0:db7:dacf:ed8b with SMTP id
 p16-20020a056902015000b00db7dacfed8bmr673305ybh.108.1702075421706; Fri, 08
 Dec 2023 14:43:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
 <20231208021433.1662438-1-kamatam@amazon.com>
In-Reply-To: <20231208021433.1662438-1-kamatam@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 17:43:30 -0500
Message-ID: <CAHC9VhRRdaUWYP3S91D6MrD8xBMR+zYB3SpGKV+60YkmLwr7Sg@mail.gmail.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
To: Munehisa Kamata <kamatam@amazon.com>
Cc: adobriyan@gmail.com, akpm@linux-foundation.org, casey@schaufler-ca.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 9:14=E2=80=AFPM Munehisa Kamata <kamatam@amazon.com>=
 wrote:
> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:

...

> > I think my thoughts are neatly summarized by Andrew's "yuk!" comment
> > at the top.  However, before we go too much further on this, can we
> > get clarification that Casey was able to reproduce this on a stock
> > upstream kernel?  Last I read in the other thread Casey wasn't seeing
> > this problem on Linux v6.5.
> >
> > However, for the moment I'm going to assume this is a real problem, is
> > there some reason why the existing pid_revalidate() code is not being
> > called in the bind mount case?  From what I can see in the original
> > problem report, the path walk seems to work okay when the file is
> > accessed directly from /proc, but fails when done on the bind mount.
> > Is there some problem with revalidating dentrys on bind mounts?
>
> Hi Paul,
>
> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linux.o=
rg.uk/
>
> After reading this thread, I have doubt about solving this in VFS.
> Honestly, however, I'm not sure if it's entirely relevant today.

Have you tried simply mounting proc a second time instead of using a bind m=
ount?

 % mount -t proc non /new/location/for/proc

I ask because from your description it appears that proc does the
right thing with respect to revalidation, it only becomes an issue
when accessing proc through a bind mount.  Or did I misunderstand the
problem?

--
paul-moore.com

