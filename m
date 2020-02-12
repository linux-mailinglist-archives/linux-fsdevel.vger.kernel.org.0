Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E5715A655
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 11:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgBLK3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 05:29:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43175 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgBLK3R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:29:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so1525282wrq.10;
        Wed, 12 Feb 2020 02:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/a19wkw5zcAUXXARw7C4Q+g5Zk5wzezKFPbsaOb+NUQ=;
        b=UfDri8LbvztPbTDcHA+Zi+Uj0sTIpaqy55Kppxj0FpCOAAtVxDSjDYmk0SGos18Bo+
         YAEPsFN0LwqYTSC24Y7spRmt7K3a+qNcCEtOPoH8Ab8fFbuGIjssthutA4JINZ0Xk8uK
         F7h9tChSZl6y5Y2J7qGRbTofvcqyY3FKqxLBMWfxwpWnWMPKcCj/N91b6TXxoon1ZaEV
         q67VnO66YoCbuviGa3G6BAGfdsafgqSrNaP4J5Co1k+KpyJelhHYmedo/EldAIvQoxtl
         If2j6vYmdZlK0w6s83dN1cQJa+yGBkJNoyjFtmPFCOHckZd4nEiLquKu9Rx5LPoNiyrP
         ndfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/a19wkw5zcAUXXARw7C4Q+g5Zk5wzezKFPbsaOb+NUQ=;
        b=Lmfag5DMvceNmsZIzYtEin+/KhO9dmKWJogLWJkVnvAZL3+QeCOqVIl9x4VJZqtERW
         wDGWt3I7jHY2nDk0HELkSjAm1+Z5+7dQMco0PG0mTd7P3xjtD7Jo2f7oaWXwBFWnrcmp
         9MDGlpTXmKDGywwcnvA5rwtQecDQs3IcUpIpjFlaBEgZ1Ug4Nn2tioYdIL1PtZ37hXj6
         g6zQR32Lih1yHsPpsVTfNP4HwQeqTK0HF3pIS1l5fetqxFv5sM+u5LssBnq671kQUnyv
         mXh6N3NqlG12JBPBbzcdjDsmSmg7eV5Zhy/Wbhw3rf7yZOlaDkbqdJgnQlcrURc45qDl
         DZIw==
X-Gm-Message-State: APjAAAXlpBWGct19bvnuwKcFa8Be3c2WsJ+MWq89boH9huZHdjXHTa1J
        dvDWvsLCtFNpektCtwWmMTWZxxsKC2qfwA==
X-Google-Smtp-Source: APXvYqxpuZLPw68k9p6/ZtX2wMIGZBzLwo30raerKBjVddvIqtIKF6Z0rPJOrkjwCt6B4lDtlfEVuQ==
X-Received: by 2002:adf:f787:: with SMTP id q7mr14445406wrp.297.1581503355024;
        Wed, 12 Feb 2020 02:29:15 -0800 (PST)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id f65sm137374wmf.29.2020.02.12.02.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 02:29:14 -0800 (PST)
Date:   Wed, 12 Feb 2020 10:29:12 +0000
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Avi Kivity <avi@scylladb.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC] eventfd: add EFD_AUTORESET flag
Message-ID: <20200212102912.GA464050@stefanha-x1.localdomain>
References: <20200129172010.162215-1-stefanha@redhat.com>
 <66566792-58a4-bf65-6723-7d2887c84160@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <66566792-58a4-bf65-6723-7d2887c84160@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 09:31:32AM +0100, Paolo Bonzini wrote:
> On 29/01/20 18:20, Stefan Hajnoczi wrote:
> > +	/* Semaphore semantics don't make sense when autoreset is enabled */
> > +	if ((flags & EFD_SEMAPHORE) && (flags & EFD_AUTORESET))
> > +		return -EINVAL;
> > +
>=20
> I think they do, you just want to subtract 1 instead of setting the
> count to 0.  This way, writing 1 would be the post operation on the
> semaphore, while poll() would be the wait operation.

True!  Then EFD_AUTORESET is not a fitting name.  EFD_AUTOREAD or
EFD_POLL_READS?

Stefan

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5D03gACgkQnKSrs4Gr
c8iXugf+J/YVpTHlkSA/Kk71x6qq43BnfiE9Yr7zaoyLZXe/OLqZOPuFh9W1Zd7p
vL7xjXxzNfZj+h2rQtmvQTzioivvhfYERHsiyYwgFbdC1Ju9oB4gDOsOrHF9bk8n
nj13JoaUBvzFdWlOW1Rml++wH6gJSZUGkerjuchEF8nFmE2HOip+tcRWlt4iB0Ym
X6Fj02m4EO6Jyj5q+2AyhiNqzkCpOzgAN0VerGQoKT81K1rWIjMPgxjAuv70vFza
YolBmujVzhmKdGScHQ2rOBQlVc0sJc0RNzciojGdw9NqkSXl/3jwoEoeD8nkfUFC
NegsoHXoW0Afqg27Tp6bdKfR/p0m2w==
=XDwI
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
