Return-Path: <linux-fsdevel+bounces-3458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650EC7F502C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924F21C20B92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A272B5C900;
	Wed, 22 Nov 2023 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98258C1;
	Wed, 22 Nov 2023 11:04:49 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so142266a12.2;
        Wed, 22 Nov 2023 11:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700679888; x=1701284688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4BLUL3BSINFdyUiN4R8Mw4Lo5v7Phq9BLwNT7+Hs90=;
        b=WTGlk0muN5ueWcLGapVWtrNdJy3BsvVuFresBoXQMoxyxl2Vje2JP0NkPLUJfk6CoT
         bE5TVG7yhjJdV7QHbYucTxdUxQNeoxZJjBAJDSwwlIkx4Jq95IhIOmZ5mWLRTmsUTdIn
         PvVmhd2Zfz8KnfrEnJ6khxycgpAuXSEpm19pFHWdDUEQCWTMVVJbSzVryr14uSLdDj9q
         C/OsuKKoYjSF5ZR4AD2UbKmADUgeqw7Jt0NoYFdfoe8+bvV+tvUiPJQemcG5JaMO7Z4W
         RfvhUbcRCoHu9FczUmoqmGXKNPEtzxCizwvoOM1oFUCj3498t5YGvYZI8vRnhMxocWcD
         hwVQ==
X-Gm-Message-State: AOJu0YxgSkYlnrKtKgpwoqX2Je0uj7pq2is70eGu+oy0TYUNT8cdRD9i
	k0dfX+GiBYU3cZE9DKokKQVJzxLWn+x2MQ==
X-Google-Smtp-Source: AGHT+IHH1jLiaof0Lm7ter01M+kaRWPESZFSfze1Bz0HnsspmCg47dOVDpcpg04jEE7FFMbuVkPyEg==
X-Received: by 2002:aa7:d343:0:b0:548:657c:5ef9 with SMTP id m3-20020aa7d343000000b00548657c5ef9mr2970263edr.8.1700679887667;
        Wed, 22 Nov 2023 11:04:47 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id t7-20020aa7d707000000b005488fca3b38sm97019edq.31.2023.11.22.11.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 11:04:47 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso140781a12.3;
        Wed, 22 Nov 2023 11:04:47 -0800 (PST)
X-Received: by 2002:a17:906:209:b0:a00:2686:6b42 with SMTP id
 9-20020a170906020900b00a0026866b42mr2490093ejd.10.1700679887260; Wed, 22 Nov
 2023 11:04:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116155312.156593-1-dhowells@redhat.com> <20231116155312.156593-4-dhowells@redhat.com>
In-Reply-To: <20231116155312.156593-4-dhowells@redhat.com>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Wed, 22 Nov 2023 15:04:35 -0400
X-Gmail-Original-Message-ID: <CAB9dFdsOR9nMrvn635_RjRbxa1XkRHrUXn7pra-KksV6cuYb1w@mail.gmail.com>
Message-ID: <CAB9dFdsOR9nMrvn635_RjRbxa1XkRHrUXn7pra-KksV6cuYb1w@mail.gmail.com>
Subject: Re: [PATCH 3/5] afs: Return ENOENT if no cell DNS record can be found
To: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Markus Suvanto <markus.suvanto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:53=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Make AFS return error ENOENT if no cell SRV or AFSDB DNS record (or
> cellservdb config file record) can be found rather than returning
> EDESTADDRREQ.
>
> Also add cell name lookup info to the cursor dump.
>
> Fixes: d5c32c89b208 ("afs: Fix cell DNS lookup")
> Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216637
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/vl_rotate.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
> index 488e58490b16..eb415ce56360 100644
> --- a/fs/afs/vl_rotate.c
> +++ b/fs/afs/vl_rotate.c
> @@ -58,6 +58,12 @@ static bool afs_start_vl_iteration(struct afs_vl_curso=
r *vc)
>                 }
>
>                 /* Status load is ordered after lookup counter load */
> +               if (cell->dns_status =3D=3D DNS_LOOKUP_GOT_NOT_FOUND) {
> +                       pr_warn("No record of cell %s\n", cell->name);
> +                       vc->error =3D -ENOENT;
> +                       return false;
> +               }
> +
>                 if (cell->dns_source =3D=3D DNS_RECORD_UNAVAILABLE) {
>                         vc->error =3D -EDESTADDRREQ;
>                         return false;
> @@ -285,6 +291,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
>   */
>  static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
>  {
> +       struct afs_cell *cell =3D vc->cell;
>         static int count;
>         int i;
>
> @@ -294,6 +301,9 @@ static void afs_vl_dump_edestaddrreq(const struct afs=
_vl_cursor *vc)
>
>         rcu_read_lock();
>         pr_notice("EDESTADDR occurred\n");
> +       pr_notice("CELL: %s err=3D%d\n", cell->name, cell->error);
> +       pr_notice("DNS: src=3D%u st=3D%u lc=3D%x\n",
> +                 cell->dns_source, cell->dns_status, cell->dns_lookup_co=
unt);
>         pr_notice("VC: ut=3D%lx ix=3D%u ni=3D%hu fl=3D%hx err=3D%hd\n",
>                   vc->untried, vc->index, vc->nr_iterations, vc->flags, v=
c->error);

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc

