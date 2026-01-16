Return-Path: <linux-fsdevel+bounces-74170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2626D33447
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 432F03020538
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CF133AD9C;
	Fri, 16 Jan 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUPthua1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2F224AF7
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578006; cv=pass; b=HQgMSimJ/Fu6jI+Vp3LYLzhYRsNv9lnDhBgFTM/VES7qoj7bk65YxiqECplCrk11MNDqluu9+4OwoDP23tPwjCiVBYsAKaMpQVWFU57aPztniYm9tScRAW++2vS3QmR1fTtMtGL6hE3ONkC8WuNIkmIg0Lur+tsUYPnAvey4coU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578006; c=relaxed/simple;
	bh=i9yJJmK6T6qLQXX5y7cSe0Eix6I4+Oii8WeKW+KAWwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+4BrFEaxoql+zQHOqe6sXbAliLakKeKdFW3tuI9lJZi6hqmlV20eSHairAXiAqeN/XngkaiuaA7G7czkVPJh+7fK03/7ThoVegVY+HEfATafBJbR01wm5z9jxpQ/pbzUUKtzixKVoMajEf0o/2eC/4GU+xzT0iAml9a3GtRVts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUPthua1; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so3669770a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 07:40:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768578003; cv=none;
        d=google.com; s=arc-20240605;
        b=lMAWlKEOqevpKd9e1DLB4By5OF43jll0BEHSw9X91rXjdkVKsuHz6lj+dWzCRbl0OH
         d6Um8gE3rKOp728r5dgGRtXJSveZFjF6jY8DNtJi1je9n7KXzvOM1a1QArozgNlH8Wu6
         MBEG34LTJ/7J0pVh3WHVCx0vOc3dDBw7m3v4xirQE2bH+9r4645j7cdoz1ivqfIxZAB5
         Dt1KnHYkj8h7aKvAtyTjhrl0vPGln/Rv6uxOZsG51yC42xSpk1maZ3Jx2BxrYxHTpWXG
         eUjlKdDDB/C9KhIHE6Tp6A0eru3NM5RupOkF/SvGlxiIz+GA/BWs7WdgpYYoNK7VQ3bz
         AjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YZWnGQKIxsu8QuGCbm2LR2pyh5ajgNhP4n0IUgCYIsw=;
        fh=7JMZ1LNBZqIe67rCZn9z37m2Jco+hPj5amU0vbhbZ8E=;
        b=a56ZwOfgG60+r0Q66dNVnenyhLbsNFGT8ZfynPYb2G6RMAF3EWiBGAt4IgJG+sqvxO
         QcpTCuT9NRfJP9NRxED7hNUqruiB6V/lQYY3z9GcQM7RxPfhDPYJ5I1vW/+phfdVKhxe
         46DI4RPr4jopmEc9bul2p6vsAhrHyrBSYf5yMoS3F8w1MO6vEtCdsnoqjRi7I1UlSyoq
         +x5d3qZ+2hl+tUhrr17zuAHxWrMkYpPqRl9zmP8OkNlXVg2Pu7tueDJxLjD2NOT1O6KM
         peLrCl54hej5je55MF1ekihBp8uVQZ8sbpa8qaScLaXpMy4qOi/IpGsxznP1A5ZeC9O4
         //Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768578003; x=1769182803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZWnGQKIxsu8QuGCbm2LR2pyh5ajgNhP4n0IUgCYIsw=;
        b=ZUPthua1cbkrP/neDIcZOHgsNKJdKMJ4XTm47Epf8R0GUm1lpZcKsSFzCJQfdqavGc
         9a8ppkn54acnnX7hCAQZHKdtiJbH5SvT6CtTeT8efYE4btkMM1Jfh9smnqB9mvYfq+xA
         1WMWbmX9jI+vlLF5kDgBZLou84vs2gwzhwtkUMKhQPt5L9usHdLcj4x+8vpCn+/zqsDi
         YglD42k92Bj5lLb+SZrTeDHmpIqg/YjDor+r6/xsAk1mGrfqLxmyNJQoS8kkBMgYVfPM
         i+0oKL8AWIiunQGbROErEmpwcQKKO43Pl8kTpi1PXpIfhqwgTGQCEo3gimuuyhE3oFCx
         Guxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578003; x=1769182803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YZWnGQKIxsu8QuGCbm2LR2pyh5ajgNhP4n0IUgCYIsw=;
        b=LBARyFNF6KmSbZQCYH5BisJdaDvRpoGi4dmSkI2zeIKCzd+VtRDvPYc/DSzpRUY7xK
         8ijJmuIEByqkkCBkT3AP2h7nrPGCMuTLVg6Pgc/GzHwEye5vgh6H9v20QRN+bcYGI5zb
         jITGVsXu6c1xUNklEZ/l2rpEN/B2OuMLv36GLp9X4GSRRsgHiG+xMpJmwB8O5vlrejk5
         Zls1lhu/b/N//muKjlCIx+vZmFZJx6qJOY1txaakSpwmqRl1/kLRH4Qqe8S2+L0vVGwS
         kafh4vTECd6tpm1A87yvqveu/Y4MWvHaZ08z0tulDXRsUrMj+MGKgz1s3Pse2Vg3F6VT
         892g==
X-Forwarded-Encrypted: i=1; AJvYcCXebNXAW1cEM3RjSyKkqBbZH/gA5lcRkQiZWMC5VFLJejKeMjGh4FdaHyy2Enq7jyVTSmVKwws0qnI0s67f@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bBg8MRxbcD1LIieOeFqcQ6Yfv/w0bnFRg0OzMj4qu0EzZHwy
	OZHYfZYbRh2zgUvrymYxcbjbgwYWhBdqakjAIUdIsqoc19JEVAyI0UPO3tTdNgbtlhe0FYMtlaR
	SxGQ7QhbTs+IwlFUeZh6FSl/STYaJhXU=
X-Gm-Gg: AY/fxX4nIuCn+9ru91KF/adawXME+Pn3IgwQBXKvDnpeu7rneRBksmTuRJWXRzs5DHo
	0eoQzZFiodHY4RbMxKY0kyCMUTK9cSvkTkLcZN31K4B2qLk5dKjvNeSZc4VIK4mtbJryqqhih0g
	lukA5LHCrgxFE6bOxFcnRBp1de+SzJf1nazMvqZP8CNdqxlA6g0blKpKd/tStiQEetQHGsF6gBG
	JADVGItQI6yVvFlPXpktdnFHcwceC5Otj56hhzXjW45tlmxKhUExEUzH/oWdwjHqKbnT4VhDlbz
	hJHARwocTKkglLkk7KO/6pTqZ6hLvg==
X-Received: by 2002:a05:6402:35c7:b0:64b:7dd2:6bc2 with SMTP id
 4fb4d7f45d1cf-654b945b386mr2178841a12.7.1768578003267; Fri, 16 Jan 2026
 07:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116142845.422-1-luochunsheng@ustc.edu> <20260116142845.422-2-luochunsheng@ustc.edu>
In-Reply-To: <20260116142845.422-2-luochunsheng@ustc.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Jan 2026 16:39:51 +0100
X-Gm-Features: AZwV_Qhteoj5SC-ZJ-zOzwvIXyodNbkTr8RSesiznKV56c26UXHLd-cTuM4eriY
Message-ID: <CAOQ4uxg13jAJyG8b3CpjKE8FXn3ce=yUCzw+Qc=k29si=FtXaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: add ioctl to cleanup all backing files
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 3:28=E2=80=AFPM Chunsheng Luo <luochunsheng@ustc.ed=
u> wrote:
>
> To simplify crash recovery and reduce performance impact, backing_ids
> are not persisted across daemon restarts. After crash recovery, this
> may lead to resource leaks if backing file resources are not properly
> cleaned up.
>
> Add FUSE_DEV_IOC_BACKING_CLOSE_ALL ioctl to release all backing_ids
> and put backing files. When the FUSE daemon restarts, it can use this
> ioctl to cleanup all backing file resources.
>
> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> ---
>  fs/fuse/backing.c         | 19 +++++++++++++++++++
>  fs/fuse/dev.c             | 16 ++++++++++++++++
>  fs/fuse/fuse_i.h          |  1 +
>  include/uapi/linux/fuse.h |  1 +
>  4 files changed, 37 insertions(+)
>
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 4afda419dd14..e93d797a2cde 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -166,6 +166,25 @@ int fuse_backing_close(struct fuse_conn *fc, int bac=
king_id)
>         return err;
>  }
>
> +static int fuse_backing_close_one(int id, void *p, void *data)
> +{
> +       struct fuse_conn *fc =3D data;
> +
> +       fuse_backing_close(fc, id);
> +
> +       return 0;
> +}
> +
> +int fuse_backing_close_all(struct fuse_conn *fc)
> +{
> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       idr_for_each(&fc->backing_files_map, fuse_backing_close_one, fc);
> +
> +       return 0;
> +}
> +

This is not safe and not efficient.
For safety from racing with _open/_close, iteration needs at least
rcu_read_lock(),
but I think it will be much more efficient to zap the entire map with
fuse_backing_files_free()/fuse_backing_files_init().

This of course needs to be synchronized with concurrent _open/_close/_looku=
p.
This could be done by making c->backing_files_map a struct idr __rcu *
and replace the old and new backing_files_map under spin_lock(&fc->lock);

Then you can call fuse_backing_files_free() on the old backing_files_map
without a lock.

As a side note, fuse_backing_files_free() iteration looks like it may need
cond_resched() if there are a LOT of backing ids, but I am not sure and
this is orthogonal to your change.

Thanks,
Amir.

