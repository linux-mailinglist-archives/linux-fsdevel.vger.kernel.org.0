Return-Path: <linux-fsdevel+bounces-7262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3881582372A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29183B24B36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2C1D6AF;
	Wed,  3 Jan 2024 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2xdHhwi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D41DA4F;
	Wed,  3 Jan 2024 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9bc8939d0so2988002b3a.0;
        Wed, 03 Jan 2024 13:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704317671; x=1704922471; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cVjY5Pt++Oml7k46uXFJ0gcfn/CPEiqKh/TxTDxjTQ=;
        b=C2xdHhwi3WIhl6+q9SmtcsJD9RNe1So9YmjKwEWZx/JQdjnijrvwldRnfmzWYhF2YX
         Os7LiKVBx4+r1k+P10a6LN3R9SLa3oOaD1YxQ/TxwfHKyiiYZuX8BH12MSmpRjWF00oT
         oE8iAQPAA6aq/bypusIErbFUvW1h5JIli4nYUrEJKar7lbQUAvG4MO+NiTg/oh0U9Yox
         6Q/45BbFMhQ/J/BAzQPoZVNpflR0XrOKhV2rDHjvnJP5rYMI+qIvyU+deGu6MGvaGiba
         nKAbG8G3vnN/KwHd747QNuTlJdkMQK1njV+cEUb75+qA42e9CnfIoRIg1TaXYvgwK8GT
         R0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704317671; x=1704922471;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cVjY5Pt++Oml7k46uXFJ0gcfn/CPEiqKh/TxTDxjTQ=;
        b=Nn1L4nKZb6jufd2K0+68Ur8kh1IUH+rtgnMitfTraatL9NPqsgWznCmweRj5IJ/Qea
         O+Ou+uo6N0z+JLID2/6k1ct73TeDQKN8hIVnNc0mf0qOFz7IUe7YPa12fRAu7HpfMxXJ
         v19wU9zIJAh7gjWqSB7F9ZOh2J1XlvYhQQuhAg3ja/fTLBs7Oc1j5xBLaxn6egFEpP/a
         3Rs4PP1Ia7dAXaOr3ZSf1G2CZJNwnhw+kOTzyG05tY8kGoONtery6kk0EPb7WkZpL6H9
         tKGAwTOxFpIH7JyweetyLo8hFZ1RD+KWoTYWWudwRIZMHC6uCUUKMy/v838yNXsExuG/
         y14Q==
X-Gm-Message-State: AOJu0YxSYhr+X1WIjdgYpGYBnMuahtQ9ig+zSdx4pxbzO62vsS+I1J3i
	9OyDvy+EfZx4kko/ExvktoWJYrkVYVk=
X-Google-Smtp-Source: AGHT+IH9nZVFLiGQx1dtVzf7cyH5HQ9gCnfyFQQwfiAq1rIgzN39tHS6Ync8unOzhVg7BWamte8Adg==
X-Received: by 2002:a05:6a20:72ac:b0:197:587:aecd with SMTP id o44-20020a056a2072ac00b001970587aecdmr2916093pzk.7.1704317671128;
        Wed, 03 Jan 2024 13:34:31 -0800 (PST)
Received: from [192.168.1.135] ([103.77.5.247])
        by smtp.gmail.com with ESMTPSA id le6-20020a056a004fc600b006da0f15b31csm12649452pfb.97.2024.01.03.13.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 13:34:30 -0800 (PST)
Date: Thu, 04 Jan 2024 10:34:14 +1300
From: Oliver Giles <ohw.giles@gmail.com>
Subject: Re: [PATCH v2 08/11] tty: splice_read: disable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Ahelenia =?iso-8859-2?q?Ziemia=F1ska?=
	<nabijaczleweli@nabijaczleweli.xyz>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Message-Id: <2XFP6S.GINKQ8IKAA1W1@gmail.com>
In-Reply-To: <CAHk-=wgLZXULo7pg=nwUMFLsKNUe+1_X=Fk7+f-J0735Oir97w@mail.gmail.com>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
	<4dec932dcd027aa5836d70a6d6bedd55914c84c2.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
	<6c3fc5e9-f8cf-4b42-9317-8ce9669160c2@kernel.org>
	<CAHk-=wgLZXULo7pg=nwUMFLsKNUe+1_X=Fk7+f-J0735Oir97w@mail.gmail.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed


On Wed, Jan 3 2024 at 11:14:59 -08:00:00, Linus Torvalds 
<torvalds@linux-foundation.org> wrote:
> 
> It's some annoying SSL VPN thing that splices to pppd:
> 
>    https://lore.kernel.org/all/C8KER7U60WXE.25UFD8RE6QZQK@oguc/

I'm happy to report that that particular SSL VPN tool is no longer 
around.
And it had anyway grown a fall-back-to-read/write in case splice() 
fails.
So at least from my perspective, no objections to splice-to-tty going 
away
altogether.

> and I'd be happy to try to limit splice to tty's to maybe just the one
> case that pppd uses.

To be exact, pppd is just providing a pty with which other (now all 
extinct?)
applications can do nefarious things.

> Maybe that VPN thing already has the pty in non-blocking mode, for
> example, and we could make the tty splicing fail for any blocking op?

FWIW, the SSL VPN tool did indeed have the pty in non-blocking mode.

Oliver




