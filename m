Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BC03FA5B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhH1Mtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 08:49:50 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38248 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhH1Mts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 08:49:48 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 950851C0B80; Sat, 28 Aug 2021 14:48:52 +0200 (CEST)
Date:   Sat, 28 Aug 2021 14:48:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, songmuchun@bytedance.com,
        viresh.kumar@linaro.org, thomascedeno@google.com,
        sashal@kernel.org, cxfcosmos@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com
Subject: Re: [PATCH v8 0/3] Anonymous VMA naming patches
Message-ID: <20210828124852.GA12580@duo.ucw.cz>
References: <20210827191858.2037087-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20210827191858.2037087-1-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>  Documentation/filesystems/proc.rst |   2 +

Documentation for the setting part would be welcome, too.

Best regards,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYSowtAAKCRAw5/Bqldv6
8jSvAKCxJZznmRcj1IaqbSg4leIEDn+cXgCfeS9zT/HzkA5sLB+xnKVjT1Id/A0=
=X0pp
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
