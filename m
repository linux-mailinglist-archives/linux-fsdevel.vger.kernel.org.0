Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236F64250D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 12:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbhJGKRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 06:17:24 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53276 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJGKRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:17:23 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4515F1C0B87; Thu,  7 Oct 2021 12:15:28 +0200 (CEST)
Date:   Thu, 7 Oct 2021 12:15:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Message-ID: <20211007101527.GA26288@duo.ucw.cz>
References: <20211005200411.GB19804@duo.ucw.cz>
 <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com>
 <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
 <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <20211006175821.GA1941@duo.ucw.cz>
 <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz>
 <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Hmm, so the suggestion is to have some directory which contains files
> >> representing IDs, each containing the string name of the associated
> >> vma? Then let's say we are creating a new VMA and want to name it. We
> >> would have to scan that directory, check all files and see if any of
> >> them contain the name we want to reuse the same ID.
> >=20
> > I believe Pavel meant something as simple as
> > $ YOUR_FILE=3D$YOUR_IDS_DIR/my_string_name
> > $ touch $YOUR_FILE
> > $ stat -c %i $YOUR_FILE
>=20
> So in terms of syscall overhead, that would be open(..., O_CREAT |
> O_CLOEXEC), fstat(), close() - or one could optimistically start by

You could get to two if you used mkdir instead of open.

> > YOUR_IDS_DIR can live on a tmpfs and you can even implement a policy on
> > top of that (who can generate new ids, gurantee uniqness etc...).
> >=20
> > The above is certainly not for free of course but if you really need a
> > system wide consistency when using names then you need some sort of
> > central authority. How you implement that is not all that important
> > but I do not think we want to handle that in the kernel.
>=20
> IDK. If the whole thing could be put behind a CONFIG_ knob, with _zero_
> overhead when not enabled (and I'm a bit worried about all the functions
> that grow an extra argument that gets passed around), I don't mind the
> string interface. But I don't really have a say either way.

If this is ever useful outside of Android, eventually distros will
have it enabled.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYV7IvwAKCRAw5/Bqldv6
8ij3AKCob2c0ihsUF0OGRBWpcwK/HrL/WwCfUjg8l8NuDcUriv7uo2C8eR0uTy8=
=1GxR
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
