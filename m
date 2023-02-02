Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29838688A7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 00:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjBBXJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 18:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjBBXJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:09:05 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831657E075
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Feb 2023 15:09:02 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z1so3490368plg.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Feb 2023 15:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqUjNnlLe9QrrnNqYH4vz9I08V1g+NAtbBxDawrBf84=;
        b=tiXwB/YFL3/UVZmPjd1ZEHaio2kX0wKkQg/TK4XDyG5MggLDGQDJfWKEahDjvcVnDG
         6olYuokRsSvkdJTx6NLxKE1iynQEBqIsubNzoIAZ81PLPSyV8X6yyr5yf3t+HAgsR9TU
         AkeudAKrJPQJfqwzuJGdQqCsR3q6FfySNI5pTmzmZFWjadchc/wgnWagVWIb7KKRU9yP
         amAQDGUyxDWKtYtYMMneMgVNvubuRf7HPQiN6fejbHo63bkHRKG9WFiiWUaHTiqv9lMF
         In7o7qTQiJGykaRwM0RWpUxVPpcJTQ8wFN83IMVfu7hdpzyHzadr6ilm+dGarBCmTPsQ
         Mh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqUjNnlLe9QrrnNqYH4vz9I08V1g+NAtbBxDawrBf84=;
        b=jxMkvpEzbcOnVb49s35IasNu3qvawqKP1BN6Zlm4WT3En0kbA8WMLk2zjU1IVgepKP
         K6XQ3GLQIPpIZvQHr9rPcQ2Q1YLS/2PwGxCGThJmX4f1pTPPTMNYNnjemXTZFgT1KY4i
         r7PYezYJefsjGw5F7w3L95HNlYG4Nou5WApeSfdr+jH6fFUe46ewZI8k3z1w1NXGrbz1
         vcBQLj7BLyPMtKYBksWX1jA+Sco1HmPZakTEj2/lDTsEbEFTxlQeSg3JxO44mMlESX6Q
         xWRKqtb0QkgVUdr+x3DZWN8xMT+MGAM4N8zmdIrWcW1StEuG5Q+oDRAmuuKoslo1+HET
         9UnA==
X-Gm-Message-State: AO0yUKUSxd8+HCVmKYwTysZt51VwWsN8N2m4env5orHW2Jmya0uHHZeq
        FdQGeL+yTgNyFm55whx/uh830Q==
X-Google-Smtp-Source: AK7set945rckBnElMZ3rf+zcsuttJnQ5VSAsDV2YHSLk1UFGwfYjX3yosnFoI7MQkt1MREnq7QE/VA==
X-Received: by 2002:a05:6a21:1586:b0:bd:b061:9527 with SMTP id nr6-20020a056a21158600b000bdb0619527mr7590449pzb.4.1675379341884;
        Thu, 02 Feb 2023 15:09:01 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id o6-20020a637306000000b004d346876d37sm300348pgc.45.2023.02.02.15.09.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2023 15:09:01 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <DCEDB8BB-8D10-4E17-9C27-AE48718CB82F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8DFD1D9F-16F3-4D17-914C-8298AD90A8D5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/5] Fix a minor POSIX conformance problem
Date:   Thu, 2 Feb 2023 16:08:49 -0700
In-Reply-To: <20230202204428.3267832-1-willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org, fstests@vger.kernel.org
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20230202204428.3267832-1-willy@infradead.org>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_8DFD1D9F-16F3-4D17-914C-8298AD90A8D5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 2, 2023, at 1:44 PM, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> POSIX requires that on ftruncate() expansion, the new bytes must read
> as zeroes.  If someone's mmap()ed the file and stored past EOF, for
> most filesystems the bytes in that page will be not-zero.  It's a
> pretty minor violation; someone could race you and write to the file
> between the ftruncate() call and you reading from it, but it's a bit
> of a QOI violation.

Is it possible to have mmap return SIGBUS for the writes beyond EOF?
On the one hand, that might indicate incorrect behavior of the =
application,
and on the other hand, it seems possible that the application doesn't
know it is writing beyond EOF and expects that data to be read back OK?

What happens if it is writing beyond EOF, but the block hasn't even been
allocated because PAGE_SIZE > blocksize?

IMHO, this seems better to stop the root of the problem (mmap() allowing
bad writes), rather than trying to fix it after the fact.

Cheers, Andreas

> I've tested xfs (passes before & after), ext4 and tmpfs (both fail
> before, pass after).  Testing from other FS developers appreciated.
> fstest to follow; not sure how to persuade git-send-email to work on
> multiple repositories
>=20
> Matthew Wilcox (Oracle) (5):
>  truncate: Zero bytes after 'oldsize' if we're expanding the file
>  ext4: Zero bytes after 'oldsize' if we're expanding the file
>  tmpfs: Zero bytes after 'oldsize' if we're expanding the file
>  afs: Zero bytes after 'oldsize' if we're expanding the file
>  btrfs: Zero bytes after 'oldsize' if we're expanding the file
>=20
> fs/afs/inode.c   | 2 ++
> fs/btrfs/inode.c | 1 +
> fs/ext4/inode.c  | 1 +
> mm/shmem.c       | 2 ++
> mm/truncate.c    | 7 +++++--
> 5 files changed, 11 insertions(+), 2 deletions(-)
>=20
> --
> 2.35.1
>=20


Cheers, Andreas






--Apple-Mail=_8DFD1D9F-16F3-4D17-914C-8298AD90A8D5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmPcQoIACgkQcqXauRfM
H+CNdBAAhriBgXO1g+TzG5HbJSljgcpvSaRMy+yNpMbCc6Fp/C3J3xQPJReOJDee
5YOaqYEwU2ap/xwIjl+OtXpEy/zq8qwO9LCofufBtMH4akhS26i8lfWoXzeo8MzH
+ibRkNMk7vamH8PT46gwMLNldqk5pt7Dxwu/XarWsDg98JxZVQvvmPJIcXtgsETA
GLFrhm+SudzQVCeBGJS0I4ZU4eDNpJxiExlCpkR04wgHE3GvvQT2ehVjcQXasqwg
z2u9r0VwflncAmvkgIpylxOXmSX44jwpnahJwk3dAP/DmdYRf3kQVooglndm5sAF
aAj6kT/mVNKdg+GJSIHjnTJjCM7BFkyFxi06xKVWjSpfYvgA5PoY8egV20kHpA3i
wRbxnoS3u5fxEx1KHj3HVnn7vhBnRsSC3AnZjLlTvtuqp7xKNMt5S5JnADLGZ6Ud
wNrl27/8LceOvSG7E/9yOmzLUvbrzZoWSRRYIymwF/6H5g0Ki4voGImZ0l+Yn4OW
sbgwcyJ1pq5Py4PgKY+iBPK61Gtk+sTOsfC3I2KWUy+7mAfQ23pfGMjY3EUNB5eC
EXuEnYw1ePIXt2MSN9yPJLz5r882eLrdbkp0nD1jx85OJFFgJvlcZ0rmPyGpBrT7
ZPq3/kKDUTwYJXO4cW+EuNV1rcTu2YttzPLBWzECgMhmXpdz0vI=
=TgpS
-----END PGP SIGNATURE-----

--Apple-Mail=_8DFD1D9F-16F3-4D17-914C-8298AD90A8D5--
