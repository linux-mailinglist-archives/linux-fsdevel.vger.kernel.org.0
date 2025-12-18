Return-Path: <linux-fsdevel+bounces-71678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9A6CCCCD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 17:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F8D3016357
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E62248F4E;
	Thu, 18 Dec 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d80aXgte"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F8214A9B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074933; cv=none; b=PAxaJ0y16hJWQWguBBAneIUo8fBvMUGZThcNqSJEDX/gyvrP2cL9oxXT8vwPAivIDygpJ7uP4mOQpkAtw5ni5wEC07VR+JigPy+AbAyWHKy/G0RmWTt/d50h+4I12v6Mf0gxuAt5D9flhElxtKhje8WFPAOu8Gx+uDEmgqhvTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074933; c=relaxed/simple;
	bh=1KjwagivxN6bJH97+BBZrIikBoJ3jm4kvAJ19GSKhDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udPL5Bi5TaVTzlEFSUB0tWGp/EbKxMaLv6JDe/wzyitwqs66BVlse4Ee3+1pbBdowkW6sz2QjzEpj+MlvN37O6Oidd10dXOgk39oV47pLvP0/nWbha/epHCUSah2rt3Vb5v7MQ/Mc5MHSyjNIXGwz2KdnpJ1pA97U0iCqQo25SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d80aXgte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903E2C19421
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 16:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766074932;
	bh=1KjwagivxN6bJH97+BBZrIikBoJ3jm4kvAJ19GSKhDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d80aXgte8O18MK3XAVadRFml9P8BTAaVh2gmcwkf8E0ijsjhVGXQGIA/WSvWc0ypL
	 iWMGmQ2lywVxN7b3OFOjSzVtPx75iCuad8r6mhqCpS2bvc+VsE3G+SqikkdMXS8MP6
	 1IHAIlWb2RRsgkDk4+/2QxG//EYRbnIVHOJasnoEpTuQVJySjYsxkoz17ZD1yKKGVu
	 OKPBl9gexYK3862X7jpH4LskKzglol4lT7yRZuy23O6sknHsIBUAFv6CTYPE+/UPLn
	 83JygMsBwVcNlm4iCJ4wP01QUlxK14jd2+6j29emlBX1Q3XnCTW/uLIVVYg46jaQik
	 7XvmIO60bYY2g==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so919661a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:22:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIrFguTWf91LaPj7611Imq8sMsQW848btlcegJVaTCSP7JbIwTdKRmRcQ24nBpRcWjB7AFgWRe3suu9omR@vger.kernel.org
X-Gm-Message-State: AOJu0YwjlEWSKYrleNkOuK1fZ7uW3wG/RfHtgEQp+fzNN6XttDh0J03F
	LAeCSFy7lVFIuTP2iiZEJPEwSeG6GMKtvR6YaOXA4ZtiIv9UqvCenI50MhfpIpLFMwl7pv4S3j1
	MOaSwn9ziwyUxhkl3bFXngjXdXJCAgDU=
X-Google-Smtp-Source: AGHT+IFU3E1sjZarnpPoMTz9FMi/bbnUASHMb9ds5I3lpt7FiJsflopghXP0cIBEk8sAM+WmRsyl1jl0mQ5J7Qk3oi4=
X-Received: by 2002:a05:6402:40c7:b0:64b:83cb:d943 with SMTP id
 4fb4d7f45d1cf-64b83cbdc15mr712275a12.6.1766074931208; Thu, 18 Dec 2025
 08:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <712257.1766069339@warthog.procyon.org.uk>
In-Reply-To: <712257.1766069339@warthog.procyon.org.uk>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 19 Dec 2025 01:21:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Yjc_ByJdbx6N++G6DT02WTXnPpw2rqW=cZgvoCns=Tw@mail.gmail.com>
X-Gm-Features: AQt7F2pMQm-q3FOu8j6FHMifBarCz04C8N2xggbWupXnzfihE7S88r26UN3qQN0
Message-ID: <CAKYAXd_Yjc_ByJdbx6N++G6DT02WTXnPpw2rqW=cZgvoCns=Tw@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: Fix to handle removal of rfc1002 header from smb_hdr
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Paulo Alcantara <pc@manguebit.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 11:49=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Hi Namjae,
Hi David,
>
> Does this (untested) patch fix the problem for you?
I sent the v2 patch to the list now.  I have tested it with cifs.ko
and windows clients.
Thanks!
>
> David
> ---
> The commit that removed the RFC1002 header from struct smb_hdr didn't als=
o
> fix the places in ksmbd that use it in order to provide graceful rejectio=
n
> of SMB1 protocol requests.
>
> Fixes: 83bfbd0bb902 ("cifs: Remove the RFC1002 header from smb_hdr")
> Reported-by: Namjae Jeon <linkinjeon@kernel.org>
> Link: https://lore.kernel.org/r/CAKYAXd9Ju4MFkkH5Jxfi1mO0AWEr=3DR35M3vQ_X=
a7Yw34JoNZ0A@mail.gmail.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> cc: Tom Talpey <tom@talpey.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/server/server.c     |    2 +-
>  fs/smb/server/smb_common.c |   10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
> index 3cea16050e4f..bedc8390b6db 100644
> --- a/fs/smb/server/server.c
> +++ b/fs/smb/server/server.c
> @@ -95,7 +95,7 @@ static inline int check_conn_state(struct ksmbd_work *w=
ork)
>
>         if (ksmbd_conn_exiting(work->conn) ||
>             ksmbd_conn_need_reconnect(work->conn)) {
> -               rsp_hdr =3D work->response_buf;
> +               rsp_hdr =3D smb2_get_msg(work->response_buf);
>                 rsp_hdr->Status.CifsError =3D STATUS_CONNECTION_DISCONNEC=
TED;
>                 return 1;
>         }
> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
> index b23203a1c286..d6084580b59d 100644
> --- a/fs/smb/server/smb_common.c
> +++ b/fs/smb/server/smb_common.c
> @@ -140,7 +140,7 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
>         if (smb2_hdr->ProtocolId =3D=3D SMB2_PROTO_NUMBER)
>                 return ksmbd_smb2_check_message(work);
>
> -       hdr =3D work->request_buf;
> +       hdr =3D smb2_get_msg(work->request_buf);
>         if (*(__le32 *)hdr->Protocol =3D=3D SMB1_PROTO_NUMBER &&
>             hdr->Command =3D=3D SMB_COM_NEGOTIATE) {
>                 work->conn->outstanding_credits++;
> @@ -278,7 +278,6 @@ static int ksmbd_negotiate_smb_dialect(void *buf)
>                                                   req->DialectCount);
>         }
>
> -       proto =3D *(__le32 *)((struct smb_hdr *)buf)->Protocol;
>         if (proto =3D=3D SMB1_PROTO_NUMBER) {
>                 struct smb_negotiate_req *req;
>
> @@ -320,8 +319,8 @@ static u16 get_smb1_cmd_val(struct ksmbd_work *work)
>   */
>  static int init_smb1_rsp_hdr(struct ksmbd_work *work)
>  {
> -       struct smb_hdr *rsp_hdr =3D (struct smb_hdr *)work->response_buf;
> -       struct smb_hdr *rcv_hdr =3D (struct smb_hdr *)work->request_buf;
> +       struct smb_hdr *rsp_hdr =3D (struct smb_hdr *)smb2_get_msg(work->=
response_buf);
> +       struct smb_hdr *rcv_hdr =3D (struct smb_hdr *)smb2_get_msg(work->=
request_buf);
>
>         rsp_hdr->Command =3D SMB_COM_NEGOTIATE;
>         *(__le32 *)rsp_hdr->Protocol =3D SMB1_PROTO_NUMBER;
> @@ -412,9 +411,10 @@ static int init_smb1_server(struct ksmbd_conn *conn)
>
>  int ksmbd_init_smb_server(struct ksmbd_conn *conn)
>  {
> +       struct smb_hdr *rcv_hdr =3D (struct smb_hdr *)smb2_get_msg(conn->=
request_buf);
>         __le32 proto;
>
> -       proto =3D *(__le32 *)((struct smb_hdr *)conn->request_buf)->Proto=
col;
> +       proto =3D *(__le32 *)rcv_hdr->Protocol;
>         if (conn->need_neg =3D=3D false) {
>                 if (proto =3D=3D SMB1_PROTO_NUMBER)
>                         return -EINVAL;
>

