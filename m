Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC06420660
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 09:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhJDHFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 03:05:34 -0400
Received: from mx1.emlix.com ([136.243.223.33]:34098 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhJDHFd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:05:33 -0400
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 7C8BF63E34;
        Mon,  4 Oct 2021 09:03:43 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     akpm@linux-foundation.org, Suren Baghdasaryan <surenb@google.com>
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
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
        legion@kernel.org, gorcunov@gmail.com, pavel@ucw.cz,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com, surenb@google.com,
        Pekka Enberg <penberg@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Jan Glauber <jan.glauber@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Rob Landley <rob@landley.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Serge E. Hallyn" <serge.hallyn@ubuntu.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, Shaohua Li <shli@fusionio.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v10 1/3] mm: rearrange madvise code to allow for reuse
Date:   Mon, 04 Oct 2021 09:03:39 +0200
Message-ID: <5358242.RVGM2oBbkg@devpool47>
Organization: emlix GmbH
In-Reply-To: <20211001205657.815551-1-surenb@google.com>
References: <20211001205657.815551-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2567157.CJKnFOJxUo"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--nextPart2567157.CJKnFOJxUo
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: akpm@linux-foundation.org, Suren Baghdasaryan <surenb@google.com>
Cc: ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org, kirill.shutemov@linux.intel.com, vbabka@suse.cz, hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk, rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com, rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com, vincenzo.frascino@arm.com, chinwen.chang@mediatek.com, axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com, apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com, will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com, hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com, tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com, pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk, legion@kernel.org, gorcunov@gmail.com, pavel@ucw.cz, songmuchun@bytedance.com, viresh.kumar@linaro.org, thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com, linux@rasmusvillemoes
 .dk, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com, surenb@google.com, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Jan Glauber <jan.glauber@gmail.com>, John Stultz <john.stultz@linaro.org>, Rob Landley <rob@landley.net>, Cyrill Gorcunov <gorcunov@openvz.org>, "Serge E. Hallyn" <serge.hallyn@ubuntu.com>, David Rientjes <rientjes@google.com>, Mel Gorman <mgorman@suse.de>, Shaohua Li <shli@fusionio.com>, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v10 1/3] mm: rearrange madvise code to allow for reuse
Date: Mon, 04 Oct 2021 09:03:39 +0200
Message-ID: <5358242.RVGM2oBbkg@devpool47>
Organization: emlix GmbH
In-Reply-To: <20211001205657.815551-1-surenb@google.com>
References: <20211001205657.815551-1-surenb@google.com>

> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -63,76 +63,20 @@ static int madvise_need_mmap_write(int behavior)
>  }
>=20
>  /*
> - * We can potentially split a vm area into separate
> - * areas, each area with its own behavior.
> + * Update the vm_flags on regiion of a vma, splitting it or merging it as
                                ^^

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart2567157.CJKnFOJxUo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYVqnSwAKCRCr5FH7Xu2t
/DXAA/45e3inTpV9UvYBfqbI5whOue50TJ20vKPlUYD4NSr0VIn+CQk0EaGTSNFk
16kBYCh9FnV2uZZNTxekIao1ry3QEnGWE09+1ogyaoA/+WdhQ8fSF5cgW4HFUKXu
q6RdIWyfG+bJhFGd49SOdhQR9MSKqels7Os+nsqIrl6EO3NaTw==
=L487
-----END PGP SIGNATURE-----

--nextPart2567157.CJKnFOJxUo--



