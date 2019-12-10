Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD7E119504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 22:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfLJVR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 16:17:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39698 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfLJVR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:17:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so452301pfx.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 13:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=SNHRjxlt4NMKZWGs5+fLhbXaGfPvIrXQizFGAzAlZ+g=;
        b=SbHMXvI6+O3O60qAIY03nJll+pzu0rLlcfldiVHU+TJmVERy6lmDacoZZ+CT3xsKsw
         HStRhiisMFhtxJCkZYwGoziZ0ai/0JodxRUrkIyJ9qFldkKFqGWikjH4Y9zlAuDEjIyO
         u472vXyXms+aqiluLwiPA2aSZx/dGElfT5PvRDxxpmFc4I1lTYoG5YEhjvYzreIBUASi
         +LAHfgUjEcdNTg0kV4g1Q+w/lAiG60Q6nkToXU5s1fNXv7IU7HhdkhudY92TdDzQVvaZ
         d/VvLj6VDAHeTw89pDgiXnq+OOaMfiKo0ZfBm6A36wTdDMMml980lQziexL/B6b/tfws
         wmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=SNHRjxlt4NMKZWGs5+fLhbXaGfPvIrXQizFGAzAlZ+g=;
        b=KBMRvO5QnX6Go2YmG78rmyLmVqFBObxlk0U9FST12CHlhaj5qoowezpG6SFiHw1gPg
         dzKzZvwis5Vuidvsr5QkcO/+JQrJr0cnFeqNyaCQKhCejdSTA7meFMQw+rC+3KuARAU+
         psX5VVoAaTJIa2KrHw99o2jAaI2/TLd+JSlaLazc+agSGwueWpLDJkx4RagStW29/XJE
         LlbD7dosHsGHlEs7pk6S2Kf7nYIoFT6VURR4SwklKH26vT4gPRHolyeMfOxQ8cHRYKAU
         4EKUa/iYhfhsfyUlO7pw9BMbnVq1Q3RewLPsCcbBmpUy128fLxxAf4IXqDfOLVbnO26V
         4AnA==
X-Gm-Message-State: APjAAAVGfHIcAEgZ7Bn5BmgtSIUDo0AuwuLGLN1k/pyVnLX5tNgIzmu8
        X43mOlunNd2wuRAePGJkn1w2IQ==
X-Google-Smtp-Source: APXvYqwVD6DdvohGonltgCv42mx7mDiWfAb88x0SbR41yv/ZcwuoadPn0ddG2IuNMH0SYYnWCQ8skQ==
X-Received: by 2002:aa7:8155:: with SMTP id d21mr35927217pfn.26.1576012675170;
        Tue, 10 Dec 2019 13:17:55 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id q11sm4600684pff.111.2019.12.10.13.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 13:17:54 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7727519C-01BE-43E8-A1BD-579CF6BD26B2@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_60556B62-F3B5-4602-887C-70C079591153";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCHSET 0/5] Support for RWF_UNCACHED
Date:   Tue, 10 Dec 2019 14:17:51 -0700
In-Reply-To: <20191210162454.8608-1-axboe@kernel.dk>
Cc:     linux-mm <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
References: <20191210162454.8608-1-axboe@kernel.dk>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_60556B62-F3B5-4602-887C-70C079591153
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Dec 10, 2019, at 9:24 AM, Jens Axboe <axboe@kernel.dk> wrote:
> 
> Recently someone asked me how io_uring buffered IO compares to mmaped
> IO in terms of performance. So I ran some tests with buffered IO, and
> found the experience to be somewhat painful. The test case is pretty
> basic, random reads over a dataset that's 10x the size of RAM.
> Performance starts out fine, and then the page cache fills up and we
> hit a throughput cliff. CPU usage of the IO threads go up, and we have
> kswapd spending 100% of a core trying to keep up. Seeing that, I was
> reminded of the many complaints I here about buffered IO, and the fact
> that most of the folks complaining will ultimately bite the bullet and
> move to O_DIRECT to just get the kernel out of the way.
> 
> But I don't think it needs to be like that. Switching to O_DIRECT isn't
> always easily doable. The buffers have different life times, size and
> alignment constraints, etc. On top of that, mixing buffered and O_DIRECT
> can be painful.
> 
> Seems to me that we have an opportunity to provide something that sits
> somewhere in between buffered and O_DIRECT, and this is where
> RWF_UNCACHED enters the picture. If this flag is set on IO, we get the
> following behavior:
> 
> - If the data is in cache, it remains in cache and the copy (in or out)
>  is served to/from that.
> 
> - If the data is NOT in cache, we add it while performing the IO. When
>  the IO is done, we remove it again.
> 
> With this, I can do 100% smooth buffered reads or writes without pushing
> the kernel to the state where kswapd is sweating bullets. In fact it
> doesn't even register.
> 
> Comments appreciated!

I think this is a definite win for e.g. NVMe/Optane devices where the
underlying storage is fast enough to avoid the need for page cache.

In our testing of Lustre on NVMe, it was faster to avoid the page cache
entirely - just inserting and removing the pages from cache took a
considerable amount of CPU for workloads where we knew it was not
beneficial (e.g. IO that was large enough that the storage was as fast
as the network).

This also makes it easier to keep other data in cache (e.g. filesystem
metadata, small IOs, etc.).

Cheers, Andreas

> Patches are against current git (ish), and can also be found here:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=buffered-uncached
> 
> fs/ceph/file.c          |   2 +-
> fs/dax.c                |   2 +-
> fs/ext4/file.c          |   2 +-
> fs/iomap/apply.c        |   2 +-
> fs/iomap/buffered-io.c  |  75 +++++++++++++++++------
> fs/iomap/direct-io.c    |   3 +-
> fs/iomap/fiemap.c       |   5 +-
> fs/iomap/seek.c         |   6 +-
> fs/iomap/swapfile.c     |   2 +-
> fs/nfs/file.c           |   2 +-
> include/linux/fs.h      |   9 ++-
> include/linux/iomap.h   |   6 +-
> include/uapi/linux/fs.h |   5 +-
> mm/filemap.c            | 132 ++++++++++++++++++++++++++++++++++++----
> 14 files changed, 208 insertions(+), 45 deletions(-)
> 
> --
> Jens Axboe
> 
> 


Cheers, Andreas






--Apple-Mail=_60556B62-F3B5-4602-887C-70C079591153
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3wC38ACgkQcqXauRfM
H+DFpw/8DTmZaC298o4r8tHrjy8XfinKmh3XbASTP0bVqA/8hWkFLgn578wJbsUw
4DWdENTkc0seeIRCmSfNGhNvyrNVGwUjs8z3li9z+kXYZXNEZZ7ww22ES0OWecrm
7vuFNXCTfnxIEkjco358QXEr2jDTPeJIp45mqmzVRBkNu5ulfyjrm/fIMrwN+L6R
s4Et7MVxaPddc+IK13B0tQKDSAMW3xVlMQYd+2Q1OL5wfU7Vuz8dEPs+SYTUXaXZ
lOwP7Q5T6TWbwDQBBuLRuhvItPrnEfTUQhSPjDh0sbrq1c6oLEkm6ulm5L30XbtP
AqCmEnFOvY3gMl+opqlOsq1cuMX9OF65dFLJmZxKhrEMaieDj9FlSuyVKq8dLc/9
Qe3m7deyc+nJIRGTzGlciKrPLVhMo0U4+dKo+Hum9K6Pe5++c6aZsO0hy8oIiF87
80LWJGb9kYZ1fVXUglYQtw2Bnumj5jGtdxct5t1V3f9XdEW3e4YcmH9R7PYd/8ZW
GaYdn9Uc67fuQGMJ0UdFK9TIwCsqy1LFCWYn5w/yYdamLH2xY6KFCDjXVwFJSnJe
E2KnzRCy7Qj61CbXnEFNz7U9TOEr18J0ZPWbcTWYpSXnUWxYXZR0wYFtsrGUmVKN
SRZ0an+rdqmCkwBRtKlV9tU7TSgQCD7P3O2zGp6h0R+WUMBS9wE=
=oG6P
-----END PGP SIGNATURE-----

--Apple-Mail=_60556B62-F3B5-4602-887C-70C079591153--
