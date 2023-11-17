Return-Path: <linux-fsdevel+bounces-3041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721477EF63A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 17:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2A2281286
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40853A8D1;
	Fri, 17 Nov 2023 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B4194;
	Fri, 17 Nov 2023 08:30:21 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso3166312e87.1;
        Fri, 17 Nov 2023 08:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700238619; x=1700843419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gRGViebN5UIVPhYisJJilLXPh7pb0PWL5nNBzX21fU=;
        b=RZPXOws67z2e5hp7SWdr0xQ0KuOXD3fo7QMvQK16zgO4q73J/AhUJC+pKVa4kiyG1l
         Hh1aFEdMBnXyjCnPX88Gdg+7gfSCoIptBd8Zxgc+ekQ1UqfIVX5n+cZk8prLGKAsQnKU
         xI43Qo8jGAjxiXRTP81pvqfyB1VhGSt63MCdREZXaI8maWOy5YDSg2OmagszocmXbtxk
         hYmMRdSl+tRCvqMqOdWH5+GAzxbKMft4cWWGKT/Q2JqeaLT+X7ruQngTOtWFFOxuHGtJ
         ppNHbq2Ij1RcRmTAuf2te/OKmISCfIhNzsBpa6padnu52C2qOFJYmRnqfqOirNtaldh+
         EBpA==
X-Gm-Message-State: AOJu0YyCRinT4idW0znUDAX+PbUFu1WBZpZPodmMlxDlmWB5HqmrAd+G
	cpoMjEhdc4pxcKqAhXDvjaM4GItHPceXPg==
X-Google-Smtp-Source: AGHT+IFG4t5wn7qEp4+WvBQ9OsfM+jl4yc7TSzV8v9768oGnQU+KCdg0NY/gfoW4g/wKmIe854uCvg==
X-Received: by 2002:ac2:54b2:0:b0:507:975f:6ccb with SMTP id w18-20020ac254b2000000b00507975f6ccbmr70109lfk.2.1700238618904;
        Fri, 17 Nov 2023 08:30:18 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id bo1-20020a0564020b2100b005435d434a90sm853729edb.57.2023.11.17.08.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 08:30:18 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso3277314a12.1;
        Fri, 17 Nov 2023 08:30:18 -0800 (PST)
X-Received: by 2002:a17:906:748c:b0:9e1:a5eb:8cb4 with SMTP id
 e12-20020a170906748c00b009e1a5eb8cb4mr15087651ejl.58.1700238617911; Fri, 17
 Nov 2023 08:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116155312.156593-1-dhowells@redhat.com> <20231116155312.156593-3-dhowells@redhat.com>
In-Reply-To: <20231116155312.156593-3-dhowells@redhat.com>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Fri, 17 Nov 2023 12:30:06 -0400
X-Gmail-Original-Message-ID: <CAB9dFdtaWy_KOONZ_TLw8vnkDQp_2B1=vWfFrHv1K55M3AutKQ@mail.gmail.com>
Message-ID: <CAB9dFdtaWy_KOONZ_TLw8vnkDQp_2B1=vWfFrHv1K55M3AutKQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] afs: Make error on cell lookup failure consistent
 with OpenAFS
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Markus Suvanto <markus.suvanto@gmail.com>, linux-afs@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:53=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> When kafs tries to look up a cell in the DNS or the local config, it will
> translate a lookup failure into EDESTADDRREQ whereas OpenAFS translates i=
t
> into ENOENT.  Applications such as West expect the latter behaviour and
> fail if they see the former.
>
> This can be seen by trying to mount an unknown cell:
>
>    # mount -t afs %example.com:cell.root /mnt
>    mount: /mnt: mount(2) system call failed: Destination address required=
.
>
> Fixes: 4d673da14533 ("afs: Support the AFS dynamic root")
> Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216637
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/dynroot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
> index 4d04ef2d3ae7..1fa8cf23bd36 100644
> --- a/fs/afs/dynroot.c
> +++ b/fs/afs/dynroot.c
> @@ -132,8 +132,8 @@ static int afs_probe_cell_name(struct dentry *dentry)
>
>         ret =3D dns_query(net->net, "afsdb", name, len, "srv=3D1",
>                         NULL, NULL, false);
> -       if (ret =3D=3D -ENODATA)
> -               ret =3D -EDESTADDRREQ;
> +       if (ret =3D=3D -ENODATA || ret =3D=3D -ENOKEY)
> +               ret =3D -ENOENT;
>         return ret;
>  }

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc

