Return-Path: <linux-fsdevel+bounces-48643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B7CAB1ADE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 18:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202BCA21323
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F05238151;
	Fri,  9 May 2025 16:49:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976FC215175;
	Fri,  9 May 2025 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809352; cv=none; b=YExvOaLiIUD6UOQcnG+cDkDeVRcIbB5pt4I8EiAoobG1wMyqbJICv3WwZ3gBX1FUDG8m707IeG/nhNAElLDOh2chesaw7t9rdFhs/1dbqvzS9pgo4fmKKLH0e07E5whro43SxxU6sH30pbDB0mO8O1lP1606S50yXZjUBlaF/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809352; c=relaxed/simple;
	bh=Di562fRz1OvExNqlAtAa54+s7WlTDxKq+Rfaxv4PFbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkhWEsUF1it65fhFtQ9XB0WwErYHkqOO2OX0gRAXMVOa/ExDJA1tE57BscxXs+HqtMKqYgEic+QQDIAMkqCmkFAdpTiGvQVZWBDGq9Ll/kPWSfK9oObOGjc5w854vePiYDl2E5b9sfiuxu5s2AC4De8MXHbKW/mQQgnV3mpBGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d81cba18e1so17764895ab.3;
        Fri, 09 May 2025 09:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746809349; x=1747414149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1jGam034RLLI89DszcNU83DPB5ZENGVlOfv4Pt5+Fo=;
        b=m5kfhIwG4Gue00Y8Hk1Dw56NnX158gG8Y0GqNhPfsu+lLtvVYP457gxfs55/1uxYKp
         Ae20K9VrDrH3cpYqKJ6tpBEFMir1WfB3iD1zQW/HpWkQ43v/ahrV4bGQaMH6spkNI/94
         ge8uAp65m9kbQG9FOZuCPCiKpTq/243OoxcwAw4lxy6zUT12zARCJWi6Ldqj5UiDsuci
         yUZWMsVTHXnRTVppzSiw/N+q+DvcBN07XY6HhU2kCuII3hjd/wX9KAAs0wW1YMbTz4wV
         /TU7392MDNqsXjOjauv/+88Z+NKOjQ8IfscvC6Gl2Tj34tg5WzM9R2dZzUdjS9BubhS9
         AkyA==
X-Forwarded-Encrypted: i=1; AJvYcCVZTJLNNrUVie/iDDv4OQe9MJ+xCJrrJ6YyhYQusBIVnFIbeHKNv1lcja+s4Ypewjl+q2BAb4DZQpbRifLfSnIAqQiPG7dP@vger.kernel.org, AJvYcCVd1oMh/jGo0uv0kcxgClOzTKEWqIs/CqSNv2NezXps110EDnnTQZFeJ1MBv90SkVO+kfFjA9GrDhr4qC8=@vger.kernel.org, AJvYcCWul2eQ2Z+avxXy7xJDuxnFk2MzKKo2UO2gpfCIMFo7ErvbY6Ze1J1FAcgpFciDLh5LvCzoW2wn@vger.kernel.org
X-Gm-Message-State: AOJu0YzoRrbspMw6AkNQ7Hs53qh72cC2xt13ljA29w30/iZxvmtxay1m
	cFD4a1ddIDEmekbez9NS5Cv9Z5kcy7Qd0q8rHLShX7CZZCAmTUUxP7p8TbMaOa0=
X-Gm-Gg: ASbGnct1oM5dKZcW6eTKaR7m2yrQkV7/E0GIyS6qYC6Vwnbv+HnTRWJmsiIsivU18Vw
	DDCzti38QgIYtkGHkyq0MpQBoIjT4va5UJEpQHW13hvT7pYbZuj01vbe5ULuUN+2akrVVnI6ibh
	ywh3W9NR+//iFxgQaPtv2DPGNXfcUweQ4oVuWiPVzTtPjSwVK3N54sHwuzNOjK2QUmTE1Q3Oog7
	stBQRccSQzaTMLbZFZXzqGEyFQAzqtcS3lXxwcqYWoH7P20BS5u0WCE/6iD2VnBw9ieiWm9c8tH
	20sp4Q2+mKheW1RhoLrWSuuHso/yO1wf28YNGVAe2VWp/sutVBetqC/nwUEkp1KiTNAVcvw1jgQ
	+21XZ01Mr
X-Google-Smtp-Source: AGHT+IHdg/R/QrVZLR+WXIOgB7KjmmeIfv68t+B7smmef4Z6fMnXeo5csmcYo+9r/+iYCD8wo3luKQ==
X-Received: by 2002:a05:6e02:1a27:b0:3d8:1d7c:e192 with SMTP id e9e14a558f8ab-3da7e1e305bmr57365965ab.7.1746809349474;
        Fri, 09 May 2025 09:49:09 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa2249ef8asm488408173.5.2025.05.09.09.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 09:49:09 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85e46f5c50fso198628139f.3;
        Fri, 09 May 2025 09:49:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUM8zkbMrx0RsUxxTRXFru70RxLRYPKCeLyBETm0aRCK2JVyFxt1/Vz899GmbFUivWooyYLdfFEE8Pgf9DsWolhgEAb6tyS@vger.kernel.org, AJvYcCVMEqwlTflQrYHERZe+BfsyWfth4kz7OcsL8iLhPQRpyaD4VaKtdrz8CxcjTxc40IquaqumTgZ3@vger.kernel.org, AJvYcCXmEO3/21V9e67t+nbj0rL5ixgIc806uVs/1JJad5Fo7Nfz7XgC+yybCPtfqj77dnNPChQl5i6khEucDVI=@vger.kernel.org
X-Received: by 2002:a05:6902:2204:b0:e78:7b0c:db8e with SMTP id
 3f1490d57ef6-e78fdd2e11bmr5146920276.30.1746808864760; Fri, 09 May 2025
 09:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org>
 <20250509-work-coredump-socket-v5-4-23c5b14df1bc@kernel.org> <20250509-querschnitt-fotokopien-6ae91dfdac45@brauner>
In-Reply-To: <20250509-querschnitt-fotokopien-6ae91dfdac45@brauner>
From: Luca Boccassi <bluca@debian.org>
Date: Fri, 9 May 2025 17:40:53 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnQJ6wxz76+30jmPO=DD6_fufxO0qEU2jrP+jhMQWUYDKQ@mail.gmail.com>
X-Gm-Features: ATxdqUHtnACv76Evvurm-jfNa0b2HAMH4VT6zOSLDIbIKwAAAJW5b477sDWlbeU
Message-ID: <CAMw=ZnQJ6wxz76+30jmPO=DD6_fufxO0qEU2jrP+jhMQWUYDKQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] coredump: add coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 16:40, Christian Brauner <brauner@kernel.org> wrote:
>
> > Userspace can set /proc/sys/kernel/core_pattern to:
> >
> >         @linuxafsk/coredump_socket
>
> I have one other proposal that:
>
> - avoids reserving a specific address
> - doesn't require bpf or lsm to be safe
> - allows for safe restart and crashes of the coredump sever
>
> To set up a coredump socket the coredump server must allocate a socket
> cookie for the listening socket via SO_COOKIE. The socket cookie must be
> used as the prefix in the abstract address for the coredump socket. It
> can be followed by a \0 byte and then followed by whatever the coredump
> server wants. For example:
>
> 12345678\0coredump.socket
>
> When a task crashes and generates a coredump it will find the provided
> address but also compare the prefixed SO_COOKIE value with the socket
> cookie of the socket listening at that address. If they don't match it
> will refuse to connect.
>
> So even if the coredump server restarts or crashes and unprivileged
> userspace recycles the socket address for an attack the crashing process
> will detect this as the new listening socket will have gotten either a
> new or no SO_COOKIE and the crashing process will not connect.
>
> The coredump server just sets /proc/sys/kernel/core_pattern to:
>
>         @SO_COOKIE/whatever
>
> The "@" at the beginning indicates to the kernel that the abstract
> AF_UNIX coredump socket will be used to process coredumps and the
> indicating the end of the SO_COOKIE and the rest of the name.
>
> Appended what that would look like.

We set the core pattern via sysctl, so personally I'd prefer if it
remained fixed rather than being dynamic and have to be set at
runtime, so that it doesn't require anything to run and it continues
to be activated on triggers only

