Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A491F339C57
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 07:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhCMGPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 01:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhCMGPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 01:15:03 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070FFC061574;
        Fri, 12 Mar 2021 22:15:02 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id m186so10083960qke.12;
        Fri, 12 Mar 2021 22:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=jcrVFWg84RC62xjrwFEo5iVvgM2fZfUa6gwgg72AsMQ=;
        b=k9GY0U9Bz7GNu+IZCD60CvgOs9y7yBKSLCq3J00HuS6tz90XLuMvg6UEI5h7DkO+MQ
         hVbBjYlH0nAS/hgtXqLAbfqBmoQwcJyKK9ExnS9AMETUbkINTOyjhHBZ1o3nsH1gHgqh
         Rgb66KBTJG4NQ9S2HdWfiLL8TWxLRKoiVe0cS41mKNmzL/P7hYIB+w/9WZ2nUZavTFM6
         BEivSz0h321KtVf3vsl4PtvnKO1csMBVBm8gts/mWp/WHm9SHSlkJmgmP/PVe/+I22Pm
         qtWTyr9H0+HpQx2k34FIlOCb/vfSnBzvVOtPu7CKTkS04MEL3wEHTPvwyAKLJWW/WbO8
         X70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=jcrVFWg84RC62xjrwFEo5iVvgM2fZfUa6gwgg72AsMQ=;
        b=JJFVwVO5+uPVoD1PVbpY0oE/oX8jLVjJq0Fjp2BTMSVlRhREJ/scnRbLd8SCAVt41Y
         z9rMd8wPHYvVoR3A/2nZiL3g0RPbxtxg3jPws73OCQYDqJ3rHiZa+msQ4kLlCQFlbnur
         2ZZbYoR1jVsUFuy0g9vn00Py/t3ftgPBiof0vG/oS79zR9EomMtW7yMq7TaB+k2TyKQd
         4uNspEPtYa/PDPqRqr9ZUViXHwA9tDHn4+mqnI05q4yPughc9QmfVrQWGh58WQiY8pzY
         iTdMyaNGy6h2/Z/S6rMO6wHOX2bzsIbGKHTdh9u+9zTzIYz8W6und8DyMfyvF2/X7V8z
         iEjA==
X-Gm-Message-State: AOAM531BjgKybfrRS6rd8TPZ8rGU4tf/jhWGmyaF2SrT2JBXQyDrcKdl
        xat9XSAJK4952EBuUvCtEfk=
X-Google-Smtp-Source: ABdhPJzZ1HQ5wH/TgxzCld1fyRbpveUkQF6HtX5R3aiJ6iLY/Og5LVz3lsPB4ne2dpz4rvINynl0Uw==
X-Received: by 2002:a37:98f:: with SMTP id 137mr4960146qkj.357.1615616102234;
        Fri, 12 Mar 2021 22:15:02 -0800 (PST)
Received: from Gentoo ([37.19.198.104])
        by smtp.gmail.com with ESMTPSA id a9sm5348876qtx.96.2021.03.12.22.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 22:15:01 -0800 (PST)
Date:   Sat, 13 Mar 2021 11:44:53 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] include: linux: Fix a typo in the file fs.h
Message-ID: <YExYXfZKXrwJ5gdX@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Tom Saeger <tom.saeger@oracle.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210313051955.18343-1-unixbhaskar@gmail.com>
 <20210313060622.dwfiejfxz5bpembl@brm-x62-17.us.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SQ/Y2YHkW0S1Njds"
Content-Disposition: inline
In-Reply-To: <20210313060622.dwfiejfxz5bpembl@brm-x62-17.us.oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--SQ/Y2YHkW0S1Njds
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 23:06 Fri 12 Mar 2021, Tom Saeger wrote:
>On Sat, Mar 13, 2021 at 10:49:55AM +0530, Bhaskar Chowdhury wrote:
>> s/varous/various/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  include/linux/fs.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index ec8f3ddf4a6a..c37a17c32d74 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1051,7 +1051,7 @@ bool opens_in_grace(struct net *);
>>   * FIXME: should we create a separate "struct lock_request" to help distinguish
>>   * these two uses?
>>   *
>> - * The varous i_flctx lists are ordered by:
>> + * The various i_flctx lists are ordered by:
>>   *
>>   * 1) lock owner
>>   * 2) lock range start
>> --
>> 2.26.2
>>
>
>How about a few more?
>
>found by running:
>codespell -w -i 3 include/linux/fs.h
>
Never bother to use that tool...not sure ...

>'specialy' could be 'special' or 'specialty'
>it can be dropped altogether IMO, so I did.
>
>--Tom
>
>diff --git a/include/linux/fs.h b/include/linux/fs.h
>index c37a17c32d74..9ffea695a059 100644
>--- a/include/linux/fs.h
>+++ b/include/linux/fs.h
>@@ -126,7 +126,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
> /* File is opened with O_EXCL (only set for block devices) */
> #define FMODE_EXCL             ((__force fmode_t)0x80)
> /* File is opened using open(.., 3, ..) and is writeable only for ioctls
>-   (specialy hack for floppy.c) */
>+   (hack for floppy.c) */
> #define FMODE_WRITE_IOCTL      ((__force fmode_t)0x100)
> /* 32bit hashes as llseek() offset (for directories) */
> #define FMODE_32BITHASH         ((__force fmode_t)0x200)
>@@ -819,7 +819,7 @@ void lock_two_nondirectories(struct inode *, struct inode*);
> void unlock_two_nondirectories(struct inode *, struct inode*);
>
> /*
>- * NOTE: in a 32bit arch with a preemptable kernel and
>+ * NOTE: in a 32bit arch with a preemptible kernel and
>  * an UP compile the i_size_read/write must be atomic
>  * with respect to the local cpu (unlike with preempt disabled),
>  * but they don't need to be atomic with respect to other cpus like in

--SQ/Y2YHkW0S1Njds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBMWFUACgkQsjqdtxFL
KRXBcwf+OmtN4w7z4GxtIYG/CkfJJ+LYX/mR78T8HuTqsrQ8NRZj7n7y/1CIZC0D
q336KnJyoBpPkFRPp5GwgiYqp4OJYwrRbsKFOYHxlFa/XoLK6KwhsAvk6MaNUxF+
yG2F1Yh2EfvhC6LwqZFhcld9v69vdZdK7+MSMx65ubjjtrZLsvZQ75XPLPAJnWzq
Neg7umsf+XrFUHabwWdjdGCVL0SLDdJmaAW5nRnD9ZMNzu6G3PTtMeFBoG36GwOV
0HrWmm7DmPgK/Zgv3k6BP9v0MYsU2hVEBMTJLwQ6YZcUJx7+bTf3TkNgR2HlKFEd
J/MeAbolZueoiQONq7Am3a7DvEUF2Q==
=nQUC
-----END PGP SIGNATURE-----

--SQ/Y2YHkW0S1Njds--
