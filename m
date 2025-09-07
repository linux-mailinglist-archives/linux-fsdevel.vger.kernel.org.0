Return-Path: <linux-fsdevel+bounces-60457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6600B47898
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 03:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B18A24E02F8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 01:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4619258E;
	Sun,  7 Sep 2025 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+CzCkM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE71078F
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757209458; cv=none; b=fTpzX+nq/H/rONSujiD64xGbc+i/DK1JgIOXxzDHvSPocb8NTebR3Hp6fTDt9V4NPrgReSKEqIDPUGpifZXcwYiZrZcTYT9nkGv2x/3uza8BhKTsctbXKbEthf8+Fr+9D2cmPlly0aJYRfaPGx3b9ArEbar2KoU7VVTVFocsMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757209458; c=relaxed/simple;
	bh=slsA3AoFQ8MJDsBCWbRmEEWJ1tU8e7v2VNnoFU+tPMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROLLdP0R16XIE7Dc2NBKVd+xK7qAmXtUtinW3LpKvBhELNISMgXXfFkyh+ceL006M6TSANo3/6bTqQRErHqenFzXgJ46YP8n0EyqDS84fHtKH6OMt7DdCJzaLt65R3owMcmYfZRlteD6+QkDLb8orQ91w9zZMVJ/U+DMeiLRiRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+CzCkM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C235C4CEF9
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 01:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757209457;
	bh=slsA3AoFQ8MJDsBCWbRmEEWJ1tU8e7v2VNnoFU+tPMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P+CzCkM4d3gHIw4/xx8rSurh39ZjwA+BXckHVHQvSvL9FUUuMwqnNR3HvmAkLsVtt
	 uSYQBWI/e2PQxTE2PMoZrY/WKWmejor2mVKA8U0w3VEil69+BtVRmfMB1D+HpVvLGt
	 3SCdFI9sXxrIIQg1xrzjjYkccn77lG4umBeoVBD+NUQD3mLk/5jSatBNRMe8HZrKGM
	 DIrJqV+n7/twjwdGpY6n2QHWLrqReYUIeT79iotgVSKNPQRvpfJfomuoRq+jzard3Y
	 refZUjPhkiO8NLNQ6y+P6MfUlXKiEGwiK3buCn4cQYlxNkO/edwx+uwAFwHy9qzUWt
	 fWW8aUoPTFysg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so5036901a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Sep 2025 18:44:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YwLk2W0IBhtRmjPDKQ1tKpo2Di7qm9SdrlCvxaB/QDPAP50XkWx
	QPREIYd8F3YuahllXNjoBhDJeDHivDNFZ4Yqqbkh+1GX4TCWxWbgGmzDshy7uY4gYssfLXGWZqL
	MRe9WjUB6wM4DxiD6WQ08VLukiPrAHUk=
X-Google-Smtp-Source: AGHT+IH+zmA7tfa8UkQeR4mCFpmFCVvNcZOoDWs89rLjyvXpv0ObpMeP4qJLMOl0L1EKpo8LcFrRZE2gXA0FgIal2S0=
X-Received: by 2002:a05:6402:1ed3:b0:61c:7a45:583a with SMTP id
 4fb4d7f45d1cf-6237b8740cfmr3343229a12.10.1757209456101; Sat, 06 Sep 2025
 18:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906090738.GA31600@ZenIV> <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-12-viro@zeniv.linux.org.uk>
In-Reply-To: <20250906091137.95554-12-viro@zeniv.linux.org.uk>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 7 Sep 2025 10:44:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-dNGH=EAH48HRR4JwA23csKnVHOFxoqaYue7xmKgCaUA@mail.gmail.com>
X-Gm-Features: AS18NWAZNyN8To_E6aTJKUFKNztqnO82DI7TYS7gM8hwDvOu5uI8iNwiSFwgIwo
Message-ID: <CAKYAXd-dNGH=EAH48HRR4JwA23csKnVHOFxoqaYue7xmKgCaUA@mail.gmail.com>
Subject: Re: [PATCH 12/21] ksmbd_vfs_inherit_posix_acl(): constify path argument
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	john@apparmor.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 6:11=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

