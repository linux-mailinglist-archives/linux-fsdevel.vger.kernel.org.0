Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77DBC14C45F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 02:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgA2BXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 20:23:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43938 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgA2BXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 20:23:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id p11so2071837plq.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 17:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=OWAxcFOKBXAriqMwzrWdcsP2KIkd6nuuZYq1Yza/tto=;
        b=ooa4C85ZQ8FPo+QFm/QWfW/xTXH8jw1h3yOJ5x2tgcpomQMTQrKPFAAEaMFdEJ1BK1
         6IKoGlVx23s5m9p6AhiUeOWEWFdVjaemZlWFEEgwrIaPwvsBLsrMrPKgIaqaX2V5s6jQ
         0S375riEutPcGensLCt9PVGLvO3reorOvVAIt7tK03gbqb8tTMRoFPVO8pL9uZ5+9MjU
         1q7c6HkiI8zLdxJD+204S9VE5RU1lk+Yzb/03ZhjhF5YGdW9B2zeZVvIFAuiVcuYb56W
         3Z2HiZqOTDbTo67FtCtzqZS22dURCiglm/P8Io4FXtUscetRoQQCYzI91FTJDXUP4Qx0
         e/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=OWAxcFOKBXAriqMwzrWdcsP2KIkd6nuuZYq1Yza/tto=;
        b=kUp23gFpxmbTXwBwRJqFyGmQQwhbjIxhNAlq6KBl3WZ2ZKTLg2BZHaacA97YkGPE4n
         leyytRDWkaM8lWd434FAzNaRa0jNFVgTiWjRMpSODmm58dVIgbYCE5eabWcwLkK8WJYR
         LWsql/pXQ8zanXGu9fPYH511gl3cidFCYpDD8JtPGEB8TtS185pp1Pv63Tum4Y7/MGt0
         m8uOgQeGPKNh0DUva+eziaADn+ZszP6ughsWrDHtCZ7rnmeVTpMUKErDsVvDMpUqXv/2
         uex8iJElq2s589nPAKA6K1AVXloVlDiqcP9OYfhJtsL5KVCYjhItVLxZNSLgDBFUaw74
         xE/A==
X-Gm-Message-State: APjAAAWuUYhShubVJP3L2FE2X3aLCso+rWR1TIt+cur3jmFhkQj/VsuB
        xKmhsWEP+EuCanIqi4hxGQfZGA==
X-Google-Smtp-Source: APXvYqyHXIGY1xrxh3yNLT+6YH6mDp3gZgaLYmhbQw82AS9R/wqsVHQgCEw8fbBl1mjbUKUxbvSqKg==
X-Received: by 2002:a17:90a:8a96:: with SMTP id x22mr7828716pjn.139.1580261002384;
        Tue, 28 Jan 2020 17:23:22 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id i3sm269758pfg.94.2020.01.28.17.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 17:23:21 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1901841E-AE43-4AE2-B8F0-8F745B00664F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_556AC574-6D04-4FEB-B995-A63AE986E6CC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
Date:   Tue, 28 Jan 2020 18:23:18 -0700
In-Reply-To: <20200128221112.GA30200@bombadil.infradead.org>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Chao Yu <yuchao0@huawei.com>,
        linux-fscrypt@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
References: <20200128221112.GA30200@bombadil.infradead.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_556AC574-6D04-4FEB-B995-A63AE986E6CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 28, 2020, at 3:11 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
>=20
> I've tried to get Ted's opinion on this a few times with radio =
silence.
> Or email is broken.  Anyone else care to offer an opinion?

Maybe I'm missing something, but I think the discussion of the len =3D=3D =
0
case is now moot, since PATCH v6 (which is the latest version that I can
find) is checking for "len >=3D 1" before accessing name[0]:

+static inline bool is_dot_or_dotdot(const unsigned char *name, size_t =
len)
+{
+	if (len >=3D 1 && unlikely(name[0] =3D=3D '.')) {
+		if (len =3D=3D 1 || (len =3D=3D 2 && name[1] =3D=3D =
'.'))
+			return true;
+	}
+
+	return false;
+}

This seems a tiny bit sub-optimal, as (len >=3D 1) is true for almost =
every
filename, so it doesn't allow failing the condition quickly.  Checking
for exactly (len =3D=3D 1) and (len =3D=3D 2) allows failing this =
condition for
most of the files immediately, which makes "unlikely()" actually useful,
and allows simplifying the inside condition.

static inline bool is_dot_or_dotdot(const unsigned char *name, size_t =
len)
{
	if (unlikely((len =3D=3D 1 || len =3D=3D 2) && name[0] =3D=3D =
'.')) {
		if (len =3D=3D 1 || name[1] =3D=3D '.')
			return true;
	}

	return false;
}

That said, this is at best micro-optimization so it isn't obvious this =
is
much of an improvement or not.

Cheers, Andreas

> On Mon, Dec 30, 2019 at 06:13:03AM -0800, Matthew Wilcox wrote:
>>=20
>> Didn't see a response from you on this.  Can you confirm the three
>> cases in ext4 mentioned below should be converted to return =
-EUNCLEAN?
>>=20
>> ----- Forwarded message from Matthew Wilcox <willy@infradead.org> =
-----
>>=20
>> Date: Thu, 12 Dec 2019 10:13:02 -0800
>> From: Matthew Wilcox <willy@infradead.org>
>> To: Eric Biggers <ebiggers@kernel.org>
>> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexander Viro
>> 	<viro@zeniv.linux.org.uk>, "Theodore Y. Ts'o" <tytso@mit.edu>, =
Jaegeuk
>> 	Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, Tyler =
Hicks
>> 	<tyhicks@canonical.com>, linux-fsdevel@vger.kernel.org,
>> 	ecryptfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
>> 	linux-f2fs-devel@lists.sourceforge.net, =
linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for =
cleanup
>> User-Agent: Mutt/1.12.1 (2019-06-15)
>>=20
>> On Tue, Dec 10, 2019 at 11:19:13AM -0800, Eric Biggers wrote:
>>>> +static inline bool is_dot_or_dotdot(const unsigned char *name, =
size_t len)
>>>> +{
>>>> +	if (unlikely(name[0] =3D=3D '.')) {
>>>> +		if (len < 2 || (len =3D=3D 2 && name[1] =3D=3D '.'))
>>>> +			return true;
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>=20
>>> This doesn't handle the len=3D0 case.  Did you check that none of =
the users pass
>>> in zero-length names?  It looks like fscrypt_fname_disk_to_usr() =
can, if the
>>> directory entry on-disk has a zero-length name.  Currently it will =
return
>>> -EUCLEAN in that case, but with this patch it may think it's the =
name ".".
>>=20
>> Trying to wrench this back on track ...
>>=20
>> fscrypt_fname_disk_to_usr is called by:
>>=20
>> fscrypt_get_symlink():
>>       if (cstr.len =3D=3D 0)
>>                return ERR_PTR(-EUCLEAN);
>> ext4_readdir():
>> 	Does not currently check de->name_len.  I believe this check =
should
>> 	be added to __ext4_check_dir_entry() because a zero-length =
directory
>> 	entry can affect both encrypted and non-encrypted directory =
entries.
>> dx_show_leaf():
>> 	Same as ext4_readdir().  Should probably call =
ext4_check_dir_entry()?
>> htree_dirblock_to_tree():
>> 	Would be covered by a fix to ext4_check_dir_entry().
>> f2fs_fill_dentries():
>> 	if (de->name_len =3D=3D 0) {
>> 		...
>> ubifs_readdir():
>> 	Does not currently check de->name_len.  Also affects =
non-encrypted
>> 	directory entries.
>>=20
>> So of the six callers, two of them already check the dirent length =
for
>> being zero, and four of them ought to anyway, but don't.  I think =
they
>> should be fixed, but clearly we don't historically check for this =
kind
>> of data corruption (strangely), so I don't think that's a reason to =
hold
>> up this patch until the individual filesystems are fixed.
>>=20
>> ----- End forwarded message -----
>=20
> ----- End forwarded message -----


Cheers, Andreas






--Apple-Mail=_556AC574-6D04-4FEB-B995-A63AE986E6CC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4w3oYACgkQcqXauRfM
H+Cy4BAAgjZzTvqnA89hmf0Vu/rBzTCcqIoJRFkg/D6oj6LAJl56iFlIq6G7fenW
1FvCaCuVR9SGE2f5uQIzwJKEDoZlEsErIv1EY2N2w9kxx3zHEq9YIgIzAfdLSIGC
xyv+m+seTi48PqYzLRL+PJt0wWFlti2L8YEUMWWiNZFfhIvqZ/+LNi3l+h5QwJV6
7DSw0hMoEfYWsPiOeKfRGlyIXIB83aRI7Rps5FhflYFOcQWXfl5EVAQnqaxmI0uQ
3WTCKVmxY2M/SSsSJx+0Vdya9DjMlmBmC0pQPIFSw9sr/x9qlkZXIk8K+t/uEhMu
IuCxa4hXVzVb2IgiHMxzuL7fJPLiQW2/rq9p2LcPjgy9vnr0DQxOF+naLLYM2lGY
zR+NGqvHCXqCgXRL1Zwi5xgGg0l82YG2q/oxdP6dtfHQd7J9O0BbXfNlhJamxLoP
rgh84j+/08jZSidcAlQM5tpzJvgucBO/nAfmwMEHHkFc1H67K9C4ujTQ5j92eZZT
EtYpAbWcD2EAvS/UPQLwlZUE7J23X7AkewcEOlLAe24+MGCcuWP4J0w3qXWb8Jt+
it3bvnU8DjYkn8YaOATM7tvf+TzSONKKxX17j5vsdIAaqDugFrgef8XCwS0H4JaT
NI9GhR6ldE0wNgtKxgyVSx+pEPj4dVMroilsbs41aWvYeTvEHo4=
=NN5a
-----END PGP SIGNATURE-----

--Apple-Mail=_556AC574-6D04-4FEB-B995-A63AE986E6CC--
