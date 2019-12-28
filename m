Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9133A12BCC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2019 06:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL1Ft0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Dec 2019 00:49:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33679 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfL1FtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Dec 2019 00:49:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so15723407pfk.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2019 21:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=OW/N/O+Dy1dEcIFwj8oUGTj0cKf/xbnol2l0eYV7G/Y=;
        b=erkecG08q1OL4/JHlafwKiUKdCXnUxrsMnfiIYOPInDpp6ePleNSdyKv4y/lZLlAro
         4bM26+e+Vu5LC0AMtFb89Bpn2BcZz5maVT2fiw0RmGBnN3CyIvv5ma6knHzcPuQmZLqQ
         V2rn3H5xIcN6KBfG9Wuz8207SHoyTE9UZXdznyZ1p/kax/bEaqtm29aKndCOEKqvkgnP
         gwcFYu5JrVpv6Jes0jKr5hh/DY0buQJtKwyhAF+nQaQ+u7qCdcB8skU/KX51EHRx56U5
         s6oTkRYEcQupBbOxuVyRxr7S+7QIkR3z0hrtuhiYTHJH+4jR8ci4ehyQBlaQUxN/027m
         sI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=OW/N/O+Dy1dEcIFwj8oUGTj0cKf/xbnol2l0eYV7G/Y=;
        b=Lh+zb+uf7CyQkFN0eRCW65gjldoH/CdimWAXfKgUKVVx+EGAwBWTdcT4xbsA6M7l8x
         6ssJbC++o1k5nTSnDNOba0aZFr8Ww1FueRPfAhOGyupOmUI17meculBajYdiM3Qi2jmu
         R2PTSK51RjURcVKl8VQcJaPIdcCoLICfGWY5MiJf4/4+LJ4WabDsM5jCARwXvUXyvc2z
         a1ZhYSrjjwd8tjrXj809eloXMDtGn+JDGlNNvbjbZmc8PnSwqIIIZJYrTJKCAsVwn0is
         s2yxXSvwheqHBDlliEbXDMTh+ZFg4xAATpnXBiM4Wbcn2NmQGGKRQ7B6x7Oy74Pv5nkA
         ZoVQ==
X-Gm-Message-State: APjAAAUrBK/l/+a9nsaESJ+Q5MEY2rsrotcwXMeaamEGGICqE8bdRC/l
        Oo6pJcYPXkd3isfrqNk3WUtW4sXrGeAohA==
X-Google-Smtp-Source: APXvYqx2BxvdOqAQeoY8PLNrAdruZ2UpCatYQVm/HFQzUDvJyAwOS4jOKUTm9ptWLPJN3c7wkOHyEQ==
X-Received: by 2002:a63:5a64:: with SMTP id k36mr60119987pgm.323.1577512165092;
        Fri, 27 Dec 2019 21:49:25 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id s15sm39437778pgq.4.2019.12.27.21.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 21:49:24 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BC68C02C-E6E5-4414-A1D2-D36D335738E2@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_421161AC-7AEB-4F46-B74F-685F54147CC1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 6/6] ovl: add ovl_fadvise()
Date:   Fri, 27 Dec 2019 22:49:22 -0700
In-Reply-To: <1535374564-8257-7-git-send-email-amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
To:     Amir Goldstein <amir73il@gmail.com>
References: <1535374564-8257-1-git-send-email-amir73il@gmail.com>
 <1535374564-8257-7-git-send-email-amir73il@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_421161AC-7AEB-4F46-B74F-685F54147CC1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Aug 27, 2018, at 6:56 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> Implement stacked fadvise to fix syscalls readahead(2) and fadvise64(2)
> on an overlayfs file.

I was just looking into the existence of the "new" fadvise() method in
the VFS being able to communicate application hints directly to the
filesystem to see if it could be used to address the word size issue in
https://bugzilla.kernel.org/show_bug.cgi?id=205957 without adding a new
syscall, and came across this patch and the 4/6 patch that adds the
vfs_fadvise() function itself (copied below for clarity).

It seems to me that this implementation is broken?  Only vfs_fadvise()
is called from the fadvise64() syscall, and it will call f_op->fadvise()
if the filesystem provides this method.  Only overlayfs provides the
.fadvise method today.  However, it looks that ovl_fadvise() calls back
into vfs_fadvise() again, in a seemingly endless loop?

It seems like generic_fadvise() should be EXPORT_SYMBOL() so that any
filesystem that implements its own .fadvise method can do its own thing,
and then call generic_fadvise() to handle the remaining MM-specific work.

Thoughts?

> +int vfs_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
> +{
> +	if (file->f_op->fadvise)
> +		return file->f_op->fadvise(file, offset, len, advice);
> +
> +	return generic_fadvise(file, offset, len, advice);
> +}
> +EXPORT_SYMBOL(vfs_fadvise);
> 
> +int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
> +{
> +	struct fd real;
> +	int ret;
> +
> +	ret = ovl_real_fdget(file, &real);
> +	if (ret)
> +		return ret;
> +
> +	/* XXX: do we need mounter credentials? */
> +	ret = vfs_fadvise(real.file, offset, len, advice);
> +
> +	fdput(real);
> +
> +	return ret;
> +}

Cheers, Andreas






--Apple-Mail=_421161AC-7AEB-4F46-B74F-685F54147CC1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4G7OIACgkQcqXauRfM
H+CjVxAAhKXjX5m11b4E2eMFMuEYZ5wxLrAnFTwzy3gJBvWmL6OhiqlEPuL/TlDp
9LAofpHJGYG1NV1cD7z+RsXoL6o7Qmek2WcebDreuW4SqWflXUa+WyVaQ2JO6Zed
V4aq09Q9Sa3EDFF0BZDzUUvgbLbSnxQ/hrds0P8jeX3yE4d/+KArxFbzYY2sDFHb
eo60Qj5gQGgW2K+brp9p+p+Ryt7SEUbEKnkwqcNZ3ulqy+pE9YJuKt7KSs+s/BJg
IJysWpg3KY3ZV6g/Uewn0rtJDedHn1C55zHHyTC9wN6FDgC8fiCvsIAs48Srfp/p
xHJJDUIVhlZj3fk9f9yE76X9m5H6jLMEOwH5x7m+mmlxuibc8oT+0GfgHrjF2CkW
ES5/9E7zXLyxIacHEy68Jfa2nnNxxW5ExX7R37rJmvvT1khAfuEsurld209WU4ZU
Jk7WHrryeCRVo+HUjWQvLDYDSAiCMmzHhWpmw7A9yOqGw6gzNeecI0lchZuQCFnD
O79AeQRSJoxw5RvJ2zQY9P58tZwTrbhvYuaePX4vCKii2NycDKQaUOtrljGfZAT0
hGyJQVo0cDupp5Wxcojl9Q3+9qcJHfEc5S5Ww5ipg9D0LmlknRaSBLMl8ezA0bq0
G9uihpfQj2igPXtN/EjbVy6GJpOYeDBh/JMh36zC2SfoZi9Xm+k=
=MTn5
-----END PGP SIGNATURE-----

--Apple-Mail=_421161AC-7AEB-4F46-B74F-685F54147CC1--
