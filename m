Return-Path: <linux-fsdevel+bounces-3663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E027F6F3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 10:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEF2281AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A18C18;
	Fri, 24 Nov 2023 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxT4ZJZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5775FD5A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 01:14:50 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-da37522a363so1588493276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 01:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700817289; x=1701422089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kq/NgLRfu9C8qpe+5mI022kHLrjDBWJ2gjS52Qi+B0=;
        b=mxT4ZJZjfth7IRhE7oOItgSbzebU9YAy8fddSKWGSW9SDqUUlisF+U73pGaYRu+FJb
         V7lObNSXbDyzq+zHRHsZr07zFLar5xdxSPwnBeLGqz8XspMXXbuJg4RcDv5dTD5Hgno7
         f/VktwgdgzmPwrMf18s4dgNhafIqACXQGFgy/CqEqI5V+8SzFa3ikTlh1Nt+ulWYmeAD
         kNQ+cEa7Tebipe+aRjzKTkI52H5gmMwhajx2/a5kPf/EZJ8FGxgckx5vPRd2Hgm+6Ycn
         sEvWU/i2m0kmpNgPmySPwA2/mGcDfYMw/hBBaHiazplH9VSSrj8EnX2sxKWuIfqdBo/V
         Mcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700817289; x=1701422089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kq/NgLRfu9C8qpe+5mI022kHLrjDBWJ2gjS52Qi+B0=;
        b=fhhqa9zyMvNcFHw0HAgN0ImTf0CmSnoQI19rfptHuQ90ik1g1AwSYVJug5LQu3SfyX
         tirQm0OIfhxCVjJ78GV6WcWLYstXklAz//BdzbUTal9no3Myxjptln7jZNJSs8yH+5G2
         k8c1uNSUG3VVkuSMAyHqsaF1jBeSs62tyMgOdcDP2DqfsDKyOSM5+ZVKUNG9M4+78GmJ
         h/7Kr49jrIIuA7TlCc9ri0IQMH+0GLnpDkiMfass/kqKwCCh3e//wUZB7ST0YsyXpJA1
         aQDbQaHU7ptr8Z2a6koThM4hl7lxB/cyuxinKH5BCJQU+W1ycJeeNRwHH015c8OTUKPL
         N/Rg==
X-Gm-Message-State: AOJu0Ywv9WTTmNHf4jd1U/jvGhrIVWkcVozHOUMLHpvQW7DJL2voOVaU
	6dqbH9K0X1u5Yiz5/0Gk6DfR9QYAjEiEMCAcsgU=
X-Google-Smtp-Source: AGHT+IFzn1FRtulo+/AufBVweW4mrCJxXjBbDv01DpjDHTDz5aYBeSWZFzXHOK3Pw6lJqzLI+49UoaePvINFbpqLk3I=
X-Received: by 2002:a05:6902:100a:b0:db0:1239:aa7f with SMTP id
 w10-20020a056902100a00b00db01239aa7fmr1882197ybt.50.1700817289458; Fri, 24
 Nov 2023 01:14:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122122715.2561213-1-amir73il@gmail.com> <20231122122715.2561213-15-amir73il@gmail.com>
In-Reply-To: <20231122122715.2561213-15-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Nov 2023 11:14:38 +0200
Message-ID: <CAOQ4uxjb0C5kPkV4A5X-=A1NrExzHcV0Kq87Pep2qxKa3teQ+w@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] fs: create __sb_write_started() helper
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 2:27=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Similar to sb_write_started() for use by other sb freeze levels.
>
> Unlike the boolean sb_write_started(), this helper returns a tristate
> to distiguish the cases of lockdep disabled or unknown lock state.
>
> This is needed for fanotify "pre content" events.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  include/linux/fs.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98b7a7a8c42e..e8aa48797bf4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1645,9 +1645,22 @@ static inline bool __sb_start_write_trylock(struct=
 super_block *sb, int level)
>  #define __sb_writers_release(sb, lev)  \
>         percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_I=
P_)
>
> +/**
> + * __sb_write_started - check if sb freeze level is held
> + * @sb: the super we write to

Missing Kerneldoc of arg:
+ * @level: the freeze level

> + *
> + * > 0 sb freeze level is held
> + *   0 sb freeze level is not held
> + * < 0 !CONFIG_LOCKDEP/LOCK_STATE_UNKNOWN
> + */
> +static inline int __sb_write_started(const struct super_block *sb, int l=
evel)
> +{
> +       return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
> +}
> +
>  static inline bool sb_write_started(const struct super_block *sb)
>  {
> -       return lockdep_is_held_type(sb->s_writers.rw_sem + SB_FREEZE_WRIT=
E - 1, 1);
> +       return __sb_write_started(sb, SB_FREEZE_WRITE);
>  }
>
>  /**
> --
> 2.34.1
>

