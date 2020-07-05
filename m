Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B727214A99
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 08:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgGEGcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 02:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgGEGcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:32:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2DAC061794
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2020 23:32:42 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ch3so507652pjb.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2020 23:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=WCQEsdCuQ9yFesPb0P6L21dKrxXpFZDsrMqQwx+GSTE=;
        b=ZkJkXi+4dQk/smjOS+gAMftw8iLt0lIoYUPMioM6cB75Cd2e+suQg7Z3PgVEn2jMKu
         L7W5ZbRNMy0LAiu+GVWQ3ABkYJlrIJGAmCwQcTInqg6Itj7nc0cDPLKv7bEto5F43R2O
         yx5Qa7aukHcTcJq/HgOpgyc+PbNivsP5yFJ685k4H7v4rrf31YrfC0zVKncgXt+kx2wk
         hE+UVW7xpWxJDAsXBA3nkO7Zq4oqz27mC3wb21zvqsAhWEQIrnQo7YATnlPPxwf8UG2F
         cfAeArQQBXead75eYpr3duXEKYFASiHwCdZQ3pVCEDjFj3o5VSg1HepNpoU7FXTtSXMX
         9+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=WCQEsdCuQ9yFesPb0P6L21dKrxXpFZDsrMqQwx+GSTE=;
        b=aPoWkV5oXJlLmdxVnsbWE+KE1rVCKx4telDhDy64iUvl2nXO4I3i4F+uJAWu8rcj/a
         TixaLgjXbUq85sJEvk+Q16xHEaByPh0Qcof6nmb3AJVYEVZr6h1VvcvXKP91saYZW4in
         nbDxlipTm95xLvVQpFYAcEsNwMUJvsbcrxcI7dDQdSaYGjALQKdQwnxdm8hZjRMqUeiI
         SGJGEn0E2BfA2IfxulZLSWJjsIOVJB+QwJM4uNs6rJwU9w4ztEVz3blIhJpDsjtzMKzS
         M3d9JRxMRFBjrc2PxiiCG5EyqvTQ2Qa4x7XJ3zjnsWOB7Irg3sdgKprLbzlZi+UTrNfv
         kcDw==
X-Gm-Message-State: AOAM533QZlwh88tlEgH1KKdIcpYqBSqT5ft63QsNBiemQVIolaMN2unM
        DhcfbaO0kJxk102v1Wai5X8mEg==
X-Google-Smtp-Source: ABdhPJwJkMLBJdpDYqM5AYWawg6/cZLfnUq+DQZ33ACOlcuCfixDJ35bJodagdEXHonrGw1k3Vhylw==
X-Received: by 2002:a17:90a:32cb:: with SMTP id l69mr41609009pjb.205.1593930761767;
        Sat, 04 Jul 2020 23:32:41 -0700 (PDT)
Received: from cabot.hitronhub.home (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id br9sm14470529pjb.56.2020.07.04.23.32.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jul 2020 23:32:41 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <37170CC1-C132-40BE-8ABA-B14E3419975C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_293BF5D1-B121-42C0-8357-294F8B72126D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Date:   Sun, 5 Jul 2020 00:32:38 -0600
In-Reply-To: <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, gregkh@linuxfoundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        shuah@kernel.org, viro@zeniv.linux.org.uk
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org>
 <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_293BF5D1-B121-42C0-8357-294F8B72126D
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jul 4, 2020, at 8:46 PM, Jan Ziak <0xe2.0x9a.0x9b@gmail.com> wrote:
> 
> On Sun, Jul 5, 2020 at 4:16 AM Matthew Wilcox <willy@infradead.org> wrote:
>> 
>> On Sun, Jul 05, 2020 at 04:06:22AM +0200, Jan Ziak wrote:
>>> Hello
>>> 
>>> At first, I thought that the proposed system call is capable of
>>> reading *multiple* small files using a single system call - which
>>> would help increase HDD/SSD queue utilization and increase IOPS (I/O
>>> operations per second) - but that isn't the case and the proposed
>>> system call can read just a single file.
>>> 
>>> Without the ability to read multiple small files using a single system
>>> call, it is impossible to increase IOPS (unless an application is
>>> using multiple reader threads or somehow instructs the kernel to
>>> prefetch multiple files into memory).
>> 
>> What API would you use for this?
>> 
>> ssize_t readfiles(int dfd, char **files, void **bufs, size_t *lens);
>> 
>> I pretty much hate this interface, so I hope you have something better
>> in mind.
> 
> I am proposing the following:
> 
> struct readfile_t {
>  int dirfd;
>  const char *pathname;
>  void *buf;
>  size_t count;
>  int flags;
>  ssize_t retval; // set by kernel
>  int reserved; // not used by kernel
> };

If you are going to pass a struct from userspace to the kernel, it
should not mix int and pointer types (which may be 64-bit values,
so that there are not structure packing issues, like:

struct readfile {
	int	dirfd;
	int	flags;
	const char *pathname;
	void	*buf;
	size_t	count;
	ssize_t retval;
};

It would be better if "retval" was returned in "count", so that
the structure fits nicely into 32 bytes on a 64-bit system, instead
of being 40 bytes per entry, which adds up over many entries, like.

struct readfile {
	int	dirfd;
	int	flags;
	const char *pathname;
	void	*buf;
	ssize_t count;	/* input: bytes requested, output: bytes read or -errno */
};


However, there is still an issue with passing pointers from userspace,
since they may be 32-bit userspace pointers on a 64-bit kernel.

> int readfiles(struct readfile_t *requests, size_t count);

It's not clear why count is a "size_t" since it is not a size.
An unsigned int is fine here, since it should never be negative.

> Returns zero if all requests succeeded, otherwise the returned value
> is non-zero (glibc wrapper: -1) and user-space is expected to check
> which requests have succeeded and which have failed. retval in
> readfile_t is set to what the single-file readfile syscall would
> return if it was called with the contents of the corresponding
> readfile_t struct.
> 
> The glibc library wrapper of this system call is expected to store the
> errno in the "reserved" field. Thus, a programmer using glibc sees:
> 
> struct readfile_t {
>  int dirfd;
>  const char *pathname;
>  void *buf;
>  size_t count;
>  int flags;
>  ssize_t retval; // set by glibc (-1 on error)
>  int errno; // set by glibc if retval is -1
> };

Why not just return the errno directly in "retval", or in "count" as
proposed?  That avoids further bloating the structure by another field.

> retval and errno in glibc's readfile_t are set to what the single-file
> glibc readfile would return (retval) and set (errno) if it was called
> with the contents of the corresponding readfile_t struct. In case of
> an error, glibc will pick one readfile_t which failed (such as: the
> 1st failed one) and use it to set glibc's errno.


Cheers, Andreas






--Apple-Mail=_293BF5D1-B121-42C0-8357-294F8B72126D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8BdAYACgkQcqXauRfM
H+Ct9hAAvj7/hD4n/PIbh60MFpaeOapkuMHxCnYr65O3YXwd4uVcU++4K1ZgTZ2o
I3Q5YBjjX3qNSUbCR98tJV22Fe0wCTaicCLT9u1g205mAiswMOt+dTIRysmJ2gLr
L3SUz3NLzJKYSSuLE9ItKwTD6gp/7jAukDc+0dbMd8YPIfG79woUVapwV4me3Lxh
swvwCRkS18c/TC5/w8jAAiiCBoMc6Q0HcDUUKeG/FfrAI8pQVk46pZ9EEGVaDRsp
cnoudMACfe/hgEzhRT+tSlNF6dq9myIStYkKG/B4X2cP1JPpw2IN05oZfM8TDH4Y
vpoaj1iw/gOC8KT/fHWmH8ESBDFolihLUY0H1ka6/YW16cb4SzwKUuhzWJMi/mZ8
UyYQeXUGwOgYDWGkPNf9gTmNKVH1243NRxiciunN4C19n53TiowvsUyixMlFBgwc
qvjRvZc9PYZSSGKWgEQR7fAihtNcPzbRfnLmRJZSI61CrWsV6AmUchr4hgm6da0H
pAO1dpPIZAKwVph9N/Cf7JXdErHGHO4BTP8r+BGYmxE1IWtdMjhq4eqVQJ2b5DZd
hDPk4hnA7peOXC3NJ52+quST3kvnkJ4CFKfi3iPQYmj9Cq+0XVAr7aXedlG68qdP
oI8Wp7rbxzqAt5JQWy5t6sPFjMs4Y0Okp5AMpn2/yrdPKtTcBZc=
=v31i
-----END PGP SIGNATURE-----

--Apple-Mail=_293BF5D1-B121-42C0-8357-294F8B72126D--
