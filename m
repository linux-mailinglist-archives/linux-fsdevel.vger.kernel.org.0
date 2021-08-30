Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A303FB1B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 09:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhH3HMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 03:12:39 -0400
Received: from mx1.emlix.com ([136.243.223.33]:39232 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233501AbhH3HMi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:12:38 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Aug 2021 03:12:38 EDT
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id AD3BD5F830;
        Mon, 30 Aug 2021 09:03:42 +0200 (CEST)
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
        legion@kernel.org, songmuchun@bytedance.com,
        viresh.kumar@linaro.org, thomascedeno@google.com,
        sashal@kernel.org, cxfcosmos@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, surenb@google.com
Subject: Re: [PATCH v8 3/3] mm: add anonymous vma name refcounting
Date:   Mon, 30 Aug 2021 09:03:37 +0200
Message-ID: <15537178.k4V9gYNSIy@devpool47>
Organization: emlix GmbH
In-Reply-To: <20210827191858.2037087-4-surenb@google.com>
References: <20210827191858.2037087-1-surenb@google.com> <20210827191858.2037087-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7924556.MAaWd901kX"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--nextPart7924556.MAaWd901kX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: akpm@linux-foundation.org, Suren Baghdasaryan <surenb@google.com>
Cc: ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org, kirill.shutemov@linux.intel.com, vbabka@suse.cz, hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk, rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com, rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com, vincenzo.frascino@arm.com, chinwen.chang@mediatek.com, axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com, apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com, will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com, hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com, tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com, pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk, legion@kernel.org, songmuchun@bytedance.com, viresh.kumar@linaro.org, thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com, linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com, surenb@google.com
Subject: Re: [PATCH v8 3/3] mm: add anonymous vma name refcounting
Date: Mon, 30 Aug 2021 09:03:37 +0200
Message-ID: <15537178.k4V9gYNSIy@devpool47>
Organization: emlix GmbH
In-Reply-To: <20210827191858.2037087-4-surenb@google.com>
References: <20210827191858.2037087-1-surenb@google.com> <20210827191858.2037087-4-surenb@google.com>

Am Freitag, 27. August 2021, 21:18:58 CEST schrieb Suren Baghdasaryan:
> While forking a process with high number (64K) of named anonymous vmas the
> overhead caused by strdup() is noticeable. Experiments with ARM64 Android
> device show up to 40% performance regression when forking a process with
> 64k unpopulated anonymous vmas using the max name lengths vs the same
> process with the same number of anonymous vmas having no name.
> Introduce anon_vma_name refcounted structure to avoid the overhead of
> copying vma names during fork() and when splitting named anonymous vmas.
> When a vma is duplicated, instead of copying the name we increment the
> refcount of this structure. Multiple vmas can point to the same
> anon_vma_name as long as they increment the refcount. The name member of
> anon_vma_name structure is assigned at structure allocation time and is
> never changed. If vma name changes then the refcount of the original
> structure is dropped, a new anon_vma_name structure is allocated
> to hold the new name and the vma pointer is updated to point to the new
> structure.
> With this approach the fork() performance regressions is reduced 3-4x
> times and with usecases using more reasonable number of VMAs (a few
> thousand) the regressions is not measurable.
>=20
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm_types.h |  9 ++++++++-
>  mm/madvise.c             | 42 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 43 insertions(+), 8 deletions(-)
>=20
> diff --git a/mm/madvise.c b/mm/madvise.c
> index bc029f3fca6a..32ac5dc5ebf3 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -63,6 +63,27 @@ static int madvise_need_mmap_write(int behavior)
>  	}
>  }
>=20
> +static struct anon_vma_name *anon_vma_name_alloc(const char *name)
> +{
> +	struct anon_vma_name *anon_name;
> +	size_t len =3D strlen(name);
> +
> +	/* Add 1 for NUL terminator at the end of the anon_name->name */
> +	anon_name =3D kzalloc(sizeof(*anon_name) + len + 1,
> +			    GFP_KERNEL);
> +	kref_init(&anon_name->kref);
> +	strcpy(anon_name->name, name);
> +
> +	return anon_name;
> +}

Given that you overwrite anything in that struct anyway this could be reduc=
ed=20
to kmalloc(), no? And it definitely needs a NULL check.

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart7924556.MAaWd901kX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYSyCyQAKCRCr5FH7Xu2t
/NTBA/4w0Kyux1kZmQldKJbME0UYvkgufssyGT64trylJ9vimg5BqpnDovDsqJ95
kkdFhKDf92sGd40RHaODdfH3ibw/VLG1mwXA1qYB00oGJLKu+Mp6RJqUrWiQoLSf
9ejd24XMNMD0bdqxOCgb7uSm87o1PRDAfP8u6l6dgeyvk5mAgw==
=fael
-----END PGP SIGNATURE-----

--nextPart7924556.MAaWd901kX--



