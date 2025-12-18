Return-Path: <linux-fsdevel+bounces-71661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07FCCBC22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 13:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 350A63032D94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C60932E759;
	Thu, 18 Dec 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbrfPhe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826932E120
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060237; cv=none; b=MNaXEM6fg02NXOTK/zhE5SBctEUWBMUPXvQXsy2T/oLdZu1eO6zy8U5plmrAvxE0WujO0YC+NczYMVHeplMhznxTPXmkRiNJL/jYS+enNRq049z3XfvnDgnRoJoFdLMs74FU8ZO56l22r+Bdc0Gz38XF3STpw0WkHo/zWk7SpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060237; c=relaxed/simple;
	bh=dkChyETlcZhrFDBPJRmvpXzRX3gZ50QCuEBOJeSe/po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sqhqe5L21c9NTmOrqmyVFCvt/joBE1nrNqAr9jz9KQRxHdQcBYiladFLv9kvXK7J+24OmWCBreW1CUqLbIJ5C5vXVLDT+4VluJa8IH2cDOzNNCWQo61LVO9OGc9L25dVrcZ25PdYQdgkSrPhAES84n2qMLJeVnxngrkkuOCu7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbrfPhe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFA9C4CEFB
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 12:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766060237;
	bh=dkChyETlcZhrFDBPJRmvpXzRX3gZ50QCuEBOJeSe/po=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WbrfPhe9WgaQRbsThXzinSrJC2KYlNOFnc9ApKHrDqic67fxKTjVJQJhdWn68eIUU
	 rAkxR9dRIs8AI6eu+fZs0YFE4KFw2o84gqRAlJubssJHPk9bgdGugOBkzOkI0mwosk
	 wUa41sRCR97GBA1UkaAoTFoZnc0lxhjj7GXxd50iFKAzDoNcF+bTZxzIizIp3veqtW
	 yCO6A6qRKuKk33zw9icdkS7fv1KvT0gzRT9HNHA2GyjsGTooohLxIbVynFowC4Xveq
	 o6nZ+RwDUtbhglx2IxlnrBNgPNPy6frrYj8JodMtXY1yWpbX82nSJBTqhtX3plZWh1
	 di+zIjzX6BhsA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so74406a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 04:17:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWw3dagl3FH9+zM+uJlCNYuAWt13J0hd7/EGGNKaow/DPQdclrD9AP4WzhPaPIzw/xSqqo8vDo2wrsN9iPO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EZUKVzNCsQSr0BeGVi40dtI7sgLuaO8RK6Hu6OuHOmV2izyK
	wz4Sw+wXTBopUOdjbUpaKDCxrDFOi5HYqBZAMTm9zObEvWapQm9w1+EhIoleA8HxPTRw5/xgCDg
	Yr+kaNd3jPxOGzzcGVmautlg67Q2+ozA=
X-Google-Smtp-Source: AGHT+IHDOWVjbgHLIL4jEWKQxBnU76CgglFgVCnHRW+sXZWG0jfkRtLkxiK9lS+eTRq6oGBUvUdcXBGf8uFGhsMyh68=
X-Received: by 2002:a05:6402:3551:b0:64b:74fc:f3ae with SMTP id
 4fb4d7f45d1cf-64b74fcf63fmr937520a12.11.1766060235713; Thu, 18 Dec 2025
 04:17:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201225732.1520128-1-dhowells@redhat.com> <20251201225732.1520128-2-dhowells@redhat.com>
In-Reply-To: <20251201225732.1520128-2-dhowells@redhat.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 18 Dec 2025 21:17:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9Ju4MFkkH5Jxfi1mO0AWEr=R35M3vQ_Xa7Yw34JoNZ0A@mail.gmail.com>
X-Gm-Features: AQt7F2oeVhj3nHKH5AL60FiFdSfdiZRas48Ab2aCr263S7pBwTkVrVNAvekyAdI
Message-ID: <CAKYAXd9Ju4MFkkH5Jxfi1mO0AWEr=R35M3vQ_Xa7Yw34JoNZ0A@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] cifs: Remove the RFC1002 header from smb_hdr
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, Stefan Metzmacher <metze@samba.org>, Tom Talpey <tom@talpey.com>, 
	linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 7:59=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Remove the RFC1002 header from struct smb_hdr as used for SMB-1.0.  This
> simplifies the SMB-1.0 code by simplifying a lot of places that have to a=
dd
> or subtract 4 to work around the fact that the RFC1002 header isn't reall=
y
> part of the message and the base for various offsets within the message i=
s
> from the base of the smb_hdr, not the RFC1002 header.
>
> Further, clean up a bunch of places that require an extra kvec struct
> specifically pointing to the RFC1002 header, such that kvec[0].iov_base
> must be exactly 4 bytes before kvec[1].iov_base.
>
> This allows the header preamble size stuff to be removed too.
>
> The size of the request and response message are then handed around eithe=
r
> directly or by summing the size of all the iov_len members in the kvec
> array for which we have a count.
>
> Also, this simplifies and cleans up the common transmission and receive
> paths for SMB1 and SMB2/3 as there no longer needs to be special handling
> casing for SMB1 messages as the RFC1002 header is now generated on the fl=
y
> for SMB1 as it is for SMB2/3.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Tom Talpey <tom@talpey.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/cifs_debug.c    |  10 +-
>  fs/smb/client/cifs_debug.h    |   6 +-
>  fs/smb/client/cifsencrypt.c   |  36 +-
>  fs/smb/client/cifsglob.h      |  23 +-
>  fs/smb/client/cifspdu.h       |   2 +-
>  fs/smb/client/cifsproto.h     |  51 ++-
>  fs/smb/client/cifssmb.c       | 735 +++++++++++++++++++---------------
>  fs/smb/client/cifstransport.c | 208 ++++------
>  fs/smb/client/connect.c       |  36 +-
>  fs/smb/client/misc.c          |  34 +-
>  fs/smb/client/sess.c          |   8 +-
>  fs/smb/client/smb1ops.c       |  21 +-
>  fs/smb/client/smb2misc.c      |   3 +-
>  fs/smb/client/smb2ops.c       |  11 +-
>  fs/smb/client/smb2proto.h     |   2 +-
>  fs/smb/client/transport.c     |  80 ++--
>  fs/smb/common/smb2pdu.h       |   3 -
>  fs/smb/common/smbglob.h       |   1 -
>  18 files changed, 645 insertions(+), 625 deletions(-)
Why did you only change smb client after changing smb_hdr structure in
smb/common? smb server also uses smb_hdr structure to handle smb1
negotiate request. Also, Why didn't you cc me on the patch that
updates smb/common?

