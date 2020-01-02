Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6042B12EB31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 22:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgABVTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 16:19:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38685 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABVTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 16:19:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so40639096wrh.5;
        Thu, 02 Jan 2020 13:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Q7ILQ6vE+vwpRyA2bKiM3+nO07Ltd687WzjuuO8GNN0=;
        b=ppGZNFVayH2pDy0fY9yk4nY8GKytJUuZIp3fKFfCVW1xRiYW60rKO1ulce/XD+XFcF
         vKPUNYdoIB3qp2EZBgnWdW9ZOCAM2yMoGR4KpX7E8NgR9FhKlhQJl3NioHJ4nqqRpakc
         52kynZvAMUTX2gqxzc/ZqVxflW5YURkiSA3nuPIe0NP81QWDQwyca/wH6Bt3HlzW9iJE
         rp440YEzd77UYFRDcBybosTAFlTCQDdLcOGbrkKyzJssjn67/VIY7W5eHBwY3v7MjA3x
         bU9mVfz8xZ8pYJNGY2zN+e3946p1aM3r6VFDgGB6M9rD+yWo0lcFTDOWtcxZcAXJlgNK
         Cnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Q7ILQ6vE+vwpRyA2bKiM3+nO07Ltd687WzjuuO8GNN0=;
        b=FiwPIIrSAxUaMDBHwzyDAikeyAokqjIXMVB98iJ19PcGeH1HHKDWWRbFS8bYzrNR+/
         Ndj5LlXCmN2/relTYGqZ6oc/7mwY5DYFda9AqGDhRQJ9VwwrV2MfScb35QR9WvBSDCDL
         QN5pFq4oXXPYwkHNNQuSkovAESDW3NUgk96s/sMfd28zhU/JPapW8TwdeOCBHDv4aW2+
         sYMuTgAOvRrXJOlozUxeldeH8pMP993y0sCNgQc2D4fYNnubHSJ2uhvogZmfhxC9OQMl
         u0WqcexRp8085C0vXwnPNEN1ycFgWu15KBa+3E7YEbxrtDItHt+zNSk5UR+0YWBUOcj8
         WX4A==
X-Gm-Message-State: APjAAAX//4CXow3Nhp59wYhZO66uA0ANh3yjaO62jR8ZdfI8NTuaHOnY
        K8Ko7QtuVARTy7oFRbjPhxZC9OqpwD4=
X-Google-Smtp-Source: APXvYqwEUdeL8z2rIw9tFIjYESsxWr3A8E/lAIAoIkXSadr8DwfuLip02FMQem52XKT8Y4GoK4ATvg==
X-Received: by 2002:a05:6000:367:: with SMTP id f7mr81873888wrf.174.1577999937679;
        Thu, 02 Jan 2020 13:18:57 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id p15sm9618677wma.40.2020.01.02.13.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 13:18:56 -0800 (PST)
Date:   Thu, 2 Jan 2020 22:18:55 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Jan Kara <jack@suse.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Sandeen <sandeen@redhat.com>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: Unification of filesystem encoding options
Message-ID: <20200102211855.gg62r7jshp742d6i@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yemvk4r42345xvlb"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--yemvk4r42345xvlb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

While I was reading a new patch series for exfat filesystem driver I
saw how is proposed implementation for converting exfat's UTF-16LE
filenames to userspace and so I decided to investigate what filesystems
which are already part of Linux kernel are doing.

I looked at filesystems supported by Linux kernel which do not store
filenames as sequence of octets, but rather expect that on-disk format
of filenames is according to some encoding.

Below is list of these filesystems with its native encoding:

befs     UTF-8
cifs     UTF-16LE
msdos    unspecified OEM codepage
vfat     unspecified OEM codepage or UTF-16LE
hfs      octets
hfsplus  UTF-16BE-NFD-Apple
isofs    octets or UTF-16BE
jfs      UTF-16LE
ntfs     UTF-16LE
udf      Latin1 or UTF-16BE

Filesystems msdos, vfat, hfs and isofs are bogus as their filesystem
structure does not say in which encoding is filename stored. For vfat
and isofs there is information if it is UTF-16LE or some unspecified
encoding. User who access such filesystem must know under which encoding
he stored data on it. For this purpose there is for vfat and hfs mount
option codepage=3D<codepage>.

All other filesystems stores in their structures encoding of filenames.
Either implicitly (hfsplus is always in UTF-16BE with modified Apple's
NFD normalization) or explicitly (in UDF is byte which says if filename
is in Latin1 or in UTF-16BE).


As passing UTF-16(LE|BE) buffers is not possible via null term strings
for any VFS sycall, Linux kernel translates these Unicode filenames to
some charset. It is done by various mount options. I looked which mount
options are understood by our Linux filesystems implementations. In all
next paragraphs by filesystem I would mean Linux driver implementation
(and not structure on disk), so do not be confused.

Below is table:

befs     iocharset=3D<charset>
cifs     iocharset=3D<charset>
msdos    (unsupported)
vfat     utf8=3D0|no|false|1|yes|true OR utf8 OR iocharset=3D<charset>
hfs      iocharset=3D<charset>
hfsplus  nls=3D<charset>
isofs    iocharset=3D<charset> OR utf8
jfs      iocharset=3D<charset>
ntfs     nls=3D<charset> OR iochrset=3D<charset> OR utf8
udf      utf8 OR iocharset=3D<charset>

Filesystem msdos does not support specifying OEM codepage encoding. It
passthrough 8bit buffer to userspace and expects that userspace
understand correct OEM codepage. There is no support for reencoding it
to UTF-8 (or any other charset). Same applies for isofs when Joliet
structure is not stored on filesystem.

Filesystem vfat has the most obscure way how to specifying charset.
Details are in mount(8) manual page. What is important: option
iocharset=3Dutf8 is buggy and may break filesystem consistency (it allows
to create two directory entries which would differ only in case
sensitivity which is not allowed by FAT specification). Due to this
problem there is a fix, mount option utf8=3D1 (or utf8=3Dyes or utf8=3Dtrue=
 or
just utf8) which do what you have would expect from iocharset=3Dutf8 if it
was not buggy.

Filesystem ntfs has option iocharset=3D<charset> which is just alias for
nls=3D<charset> and says that iocharset=3D is deprecated. Same applies for
option utf8 which is just alias for nls=3Dutf8.

Filesystems isofs and udf have two ways how to specify UTF-8 encoding.
First way is via utf8 mount option and second one via iocharset=3Dutf8
option. Looks like that difference is only one, iocharset=3Dutf8 supports
only Uncicode code points up to the U+FFFF (limited to 3 byte long UTF-8
sequences, like utf8/utf8mb3 encoding in MySQL/MariaDB) and utf8 option
supports also code points above U+FFFF, so full Unicode and not just
limited subset.

Filesystem cifs in UTF-8 mode (via iocharset=3Dutf8) always supports code
points above U+FFFF. But remaining filesystems befs, hfs, hfsplus, jfs
and ntfs seems to supports only Unicode code points up to the U+FFFF. So
effectively they do not support UTF-16, but effectively just UCS-2. This
limitation comes from Kernel NLS table framework/API which is limited to
16bit integers and therefore maximal Unicode code point is U+FFFF.
Filesystems cifs, isofs, udf and vfat has own special code to work with
surrogate pairs and do not use limited NLS table functions. There are
also functions utf8s_to_utf16s() and utf16s_to_utf8s() for this purpose.


And here I see these improvements for all above filesystems:


1) Unify mount options for specifying charset.

Currently all filesystems except msdos and hfsplus have mount option
iocharset=3D<charset>. hfsplus has nls=3D<charset> and msdos does not
implement re-encoding support. Plus vfat, udf and isofs have broken
iocharset=3Dutf8 option (but working utf8 option) And ntfs has deprecated
iocharset=3D<charset> option.

I would suggest following changes for unification:

* Add a new alias iocharset=3D for hfsplus which would do same as nls=3D
* Make iocharset=3Dutf8 option for vfat, udf and isofs to do same as utf8
* Un-deprecate iocharset=3D<charset> option for ntfs

This would cause that all filesystems would have iocharset=3D<charset>
option which would work for any charset, including iocharset=3Dutf8.
And it would fix also broken iocharset=3Dutf8 for vfat, udf and isofs.


2) Add support for Unicode code points above U+FFFF for filesystems
befs, hfs, hfsplus, jfs and ntfs, so iocharset=3Dutf8 option would work
also with filenames in userspace which would be 4 bytes long UTF-8.


3) Add support for iocharset=3D and codepage=3D options for msdos
filesystem. It shares lot of pars of code with vfat driver.


What do you think about these improvements? First improvement should be
relatively simple and if we agree that this unification of mount option
iocharset=3D make sense, I could do it.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--yemvk4r42345xvlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXg5eNQAKCRCL8Mk9A+RD
UiLNAJoDSF9XHS0h4NVhiAJxSkMkLyvosQCcCOV2ieT4teXX72Iv7nd4IsdCVuU=
=e0M9
-----END PGP SIGNATURE-----

--yemvk4r42345xvlb--
