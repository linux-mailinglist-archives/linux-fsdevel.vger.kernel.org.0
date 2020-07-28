Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2922FF62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 04:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgG1COn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 22:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgG1COm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:14:42 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB4FC061794;
        Mon, 27 Jul 2020 19:14:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BG0cJ1s3sz9sRW;
        Tue, 28 Jul 2020 12:14:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595902480;
        bh=QaZcW7Jf9qMD1DalrmrMmBPYCGe8Qf5ICJMH13G62F0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=abJarT5kJDtHga9hjAWUYG52TZqXJLClWI4fOx2RT9SsXt/slEG2hMhwGUo6oYTdC
         Y7W149ht+EYYf/yqQ/B5OCKyB47GDZPs3Ly9dDe3ZOx2RsVWrEgRw/S049dy0IVngA
         s4kWOy+MzWR9JiekTYKk1mDXskwW5lmHQDPUl+yd3avgIrU6gbv3VRpTqdFnnf56pb
         2thGtZITa4LsEeH0ES3zQuW9pxwKatwgYEJZZom+CWiTcM0CDbMslnPB9EeCJpasaD
         dy4VpdN5FO7cwFetvssNy8tzAQhHXPeEB3hXIuf3fSj9jyHkt3xIcc3c94K8ujcmqz
         +zBcGVIKknW1A==
Date:   Tue, 28 Jul 2020 12:14:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2020-07-27-18-18 uploaded
Message-ID: <20200728121439.6a40591d@canb.auug.org.au>
In-Reply-To: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
References: <20200723211432.b31831a0df3bc2cbdae31b40@linux-foundation.org>
        <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G9hTn9gO9HlIukNdNnh9dpw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/G9hTn9gO9HlIukNdNnh9dpw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 27 Jul 2020 18:19:14 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> * mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting=
-api-fix-2.patch

These syscall patches have been a pain, sorry.  I have corrected the above =
to this:

From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 28 Jul 2020 11:29:27 +1000
Subject:=20
 mm-madvise-introduce-process_madvise-syscall-an-external-memory-hinting-ap=
i-fix-2

fix include/uapi/asm-generic/unistd.h whoops

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Daniel Colascione <dancol@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: John Dias <joaodias@google.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: <linux-man@vger.kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Oleksandr Natalenko <oleksandr@redhat.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Sonny Rao <sonnyrao@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tim Murray <timmurray@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/u=
nistd.h
index 4d8044ca1bd5..c0b5f8b609eb 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -861,13 +861,13 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_watch_mount 440
 __SYSCALL(__NR_watch_mount, sys_watch_mount)
-#define __NR_fsinfo 442
+#define __NR_fsinfo 441
 __SYSCALL(__NR_fsinfo, sys_fsinfo)
-#define __NR_fsinfo 443
+#define __NR_process_madvise 442
 __SC_COMP(__NR_process_madvise, sys_process_madvise, compat_sys_process_ma=
dvise)
=20
 #undef __NR_syscalls
-#define __NR_syscalls 444
+#define __NR_syscalls 443
=20
 /*
  * 32 bit systems traditionally used different

--=20
Cheers,
Stephen Rothwell

--Sig_/G9hTn9gO9HlIukNdNnh9dpw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8fig8ACgkQAVBC80lX
0Gz9VQf9G5l+YOY+DnzdmF1UsIt9om60cj4VdrD7gkVghJH599yOYm8REZxC/1YQ
UuVrbWaXBAOoeIuT4EaYKn+8qyxO8i52uLf+zEucW8uLnRIsVtaVuKtFOjnPuXJP
9dSTJX9zMWSd4aQI/vhYOW2ECzfyLLjXgp7JRr9UUVqiNSEVu8vALvFZh0EHnXg3
YF3mzGh+K3PAvYUpMv7p0Mymgy6hgPLu4tcolHy/1az32FF5GqPLwK8Od6oScl0W
Pb4oGJpkElwJcW5sNioV8R0p7azwgzFjm3An5UH0KLryhMMbkSMHlywJVnhCY0b6
dPH0eOCYz+vy6LIN8ekOPhOVORw9dA==
=oyMQ
-----END PGP SIGNATURE-----

--Sig_/G9hTn9gO9HlIukNdNnh9dpw--
