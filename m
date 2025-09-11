Return-Path: <linux-fsdevel+bounces-60890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438FBB5286F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 08:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9021C24EFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 06:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E740F253F11;
	Thu, 11 Sep 2025 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMytPd+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47720178372;
	Thu, 11 Sep 2025 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570553; cv=none; b=baJLKw4asR/mTDsw2CbjpIU6ycPKRrtrOP22ZSqg5iowe52XVfTM2ThkGum0xYcEO4ntOd8Z2H1frK+xKRGCyiKYW1VBjJDPigvKF8KHuTEWHm/oUWlg/QOKdUux34yIxISpgu1iNBnfLYm+Bn1sTKrLtEI1VG8Z+VKqZ89lBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570553; c=relaxed/simple;
	bh=J1lOESDOB8dHkm7b/lcGK9RucmfoE/R0WCsDu1V6JiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qV4cVWuiwmUOsd5Aif1GWiTDdh51wjkKSUEy/RkETFBFtSdwkxgfO+JTetcqnerXVJ2YcPYAYut7qHG9J6esy6of6EFLA+yjuH0SqzrwtXgJXU2qgIJQn482n1QU4JyALCuZJV1kDd95Rij8HCO14zwprKOIr/Nl0xCEMFlc43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMytPd+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD10C4CEF1;
	Thu, 11 Sep 2025 06:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757570552;
	bh=J1lOESDOB8dHkm7b/lcGK9RucmfoE/R0WCsDu1V6JiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WMytPd+j9ZjWO3gE+5ZymfQ80LgZAPFS2dfMYgiYPYfXYlGus0Y9C5mLoUjrmkmOs
	 WurAnWTesE+dW6JAs653246up8Dm/V9kO7c8/aflpEZhy03gpS5tjpa3IpNP3DPXOQ
	 yQjI7wv03O5Oee8/r1uhcSOL7dFjSXve9y88lpEuTJEOdbS5bZS8WTMVaSGl5y7E4U
	 ichblzjMckfLxipaONwD95FH9itAZe8tYv6sedec7YF0FGoONiSSs1laJZSG7TgNzt
	 hlnm9RSYbCHNKszjA+aGGx+riNBy7/sEOyUK9xvu9x0GHZxRzk9OKafdAzTYW9i5Mv
	 lbch7WCgdI68g==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so560274a12.3;
        Wed, 10 Sep 2025 23:02:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUltDUdAvgTZikaUfKGCTI2P9Nw3P6TPHzTix4EbkrtiHOABSLaykOA4Qg/UkZft2wujPQ05szvUihuqpgYOnPhE4d8In8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywusgri2kqWnxO0DH04D8jpX1bX+D8U+8cjKcbViUnpKWCFVq8U
	xGoyMXxNW5ZAW404LyHbxTzyzUaBVasQ3DZ9uIFudOxSIPFyuxqzS9mMInmYtAoO1R0XcJM5C6J
	C/alZ4vc8xIHbEtqYSCO1tfz1gZsfXac=
X-Google-Smtp-Source: AGHT+IESgfl3xlVxiXcg8lMqiujwP8LY8vfEryJhfm2noZ3SmXwQOcAS10pSuprzu6dYVMLjQ/aqPajlFmHL1eCELlw=
X-Received: by 2002:a05:6402:348e:b0:62d:91fe:7053 with SMTP id
 4fb4d7f45d1cf-62d91fe798cmr3821520a12.37.1757570551446; Wed, 10 Sep 2025
 23:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911050149.GW31600@ZenIV> <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
 <20250911050534.3116491-2-viro@zeniv.linux.org.uk>
In-Reply-To: <20250911050534.3116491-2-viro@zeniv.linux.org.uk>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 11 Sep 2025 15:02:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9=gPiUg4saX7-bJn=hPzrfuFRKvT0nZwWZUT=W6KfWhQ@mail.gmail.com>
X-Gm-Features: AS18NWC7V-UWEy3-9MLREXfRhFwXz4aFH_K-rJY20tk9S1tDjbxG5sAGsJUFzvo
Message-ID: <CAKYAXd9=gPiUg4saX7-bJn=hPzrfuFRKvT0nZwWZUT=W6KfWhQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] exfat_find(): constify qstr argument
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, neil@brown.name, 
	linux-security-module@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:05=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Nothing outside of fs/dcache.c has any business modifying
> dentry names; passing &dentry->d_name as an argument should
> have that argument declared as a const pointer.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

