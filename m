Return-Path: <linux-fsdevel+bounces-3033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEB17EF5C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF741C20A64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B483C49F;
	Fri, 17 Nov 2023 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1690A5;
	Fri, 17 Nov 2023 07:57:46 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso3172775a12.1;
        Fri, 17 Nov 2023 07:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236665; x=1700841465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+N8Rkxs1VdZPQNYmn5RsQKxDMuZgXUMJtgtu8KsLn60=;
        b=epjJ1NHMn5+CoTBPqudJHiWFubTn4inB4G+QKnF4y4jJm6mFcLOVCY7Me8KcournOv
         Ffmfds7e5+9dWBKoId4URRAv+y2jW6rMA8mdBVWzYH87SjuZ9WpsNrMLKqy7AugEe1iE
         MKEa2YNhrJFY7oWUStB2xk9sgNnXOiqTpfPSN24Rw097BXAWEDWV/0CLZUxcDlJAG0dk
         99EgZTo6QvI22fCv1IdJSed55JE11yBh1GLE2Y0t2JZK0Xagrd9CFkH+oe7d3UnjRzS7
         1E45NbMVmgjVPkeP5hoRbeqSBWSBh13tGh6X5bN6t6gwqVfDpjxfpSsuaUWYh/v2HJPu
         GzVA==
X-Gm-Message-State: AOJu0YxQokOk/69P5SLpgZpMKyoeeJRnwOWnwHvcyMHYaBzHrR5hxn5K
	vflHFSmdrxfaS1/f6npIVlc5D4ad9hwybQ==
X-Google-Smtp-Source: AGHT+IHzfmp7wsrWkrW7vPT2jmpUi0Nr6N/beJL6XdXEDzanbwn9Hqzrp/FDoP4fBzF+8zONpFc25g==
X-Received: by 2002:a05:6402:42d0:b0:548:656b:629b with SMTP id i16-20020a05640242d000b00548656b629bmr51755edc.25.1700236664789;
        Fri, 17 Nov 2023 07:57:44 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id m21-20020aa7d355000000b00546dc1b5515sm831507edr.94.2023.11.17.07.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 07:57:44 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso302832066b.1;
        Fri, 17 Nov 2023 07:57:44 -0800 (PST)
X-Received: by 2002:a17:907:7819:b0:9c3:d356:ad0c with SMTP id
 la25-20020a170907781900b009c3d356ad0cmr13299716ejc.24.1700236664516; Fri, 17
 Nov 2023 07:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116155312.156593-1-dhowells@redhat.com> <20231116155312.156593-2-dhowells@redhat.com>
In-Reply-To: <20231116155312.156593-2-dhowells@redhat.com>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Fri, 17 Nov 2023 11:57:33 -0400
X-Gmail-Original-Message-ID: <CAB9dFdvRa7Z9_zSap721gsTXJziQkuwpu=N3mP+432vxFGj2AA@mail.gmail.com>
Message-ID: <CAB9dFdvRa7Z9_zSap721gsTXJziQkuwpu=N3mP+432vxFGj2AA@mail.gmail.com>
Subject: Re: [PATCH 1/5] afs: Fix afs_server_list to be cleaned up with RCU
To: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:53=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> afs_server_list is accessed with the rcu_read_lock() held from
> volume->servers, so it needs to be cleaned up correctly.
>
> Fix this by using kfree_rcu() instead of kfree().
>
> Fixes: 8a070a964877 ("afs: Detect cell aliases 1 - Cells with root volume=
s")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/internal.h    | 1 +
>  fs/afs/server_list.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index c9cef3782b4a..a812952be1c9 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -553,6 +553,7 @@ struct afs_server_entry {
>  };
>
>  struct afs_server_list {
> +       struct rcu_head         rcu;
>         afs_volid_t             vids[AFS_MAXTYPES]; /* Volume IDs */
>         refcount_t              usage;
>         unsigned char           nr_servers;
> diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
> index ed9056703505..b59896b1de0a 100644
> --- a/fs/afs/server_list.c
> +++ b/fs/afs/server_list.c
> @@ -17,7 +17,7 @@ void afs_put_serverlist(struct afs_net *net, struct afs=
_server_list *slist)
>                 for (i =3D 0; i < slist->nr_servers; i++)
>                         afs_unuse_server(net, slist->servers[i].server,
>                                          afs_server_trace_put_slist);
> -               kfree(slist);
> +               kfree_rcu(slist, rcu);
>         }
>  }

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc

