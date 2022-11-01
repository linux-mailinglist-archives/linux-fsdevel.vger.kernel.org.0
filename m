Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CE5614529
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 08:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKAHkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiKAHkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 03:40:42 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7014415704
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 00:40:38 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221101074033epoutp0132b0480842066990dc456d3f45b6b90d~jZf8lyhPp0784807848epoutp01Q
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 07:40:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221101074033epoutp0132b0480842066990dc456d3f45b6b90d~jZf8lyhPp0784807848epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667288433;
        bh=vUxG2x1LfvxNm6MR0UD7O+HYui3xU91KyYK7G/q4q8g=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=jLmgE5QVpiO8TUdGeMLkPUKddlc4AtnuFQ3xwYG9YXjfgh+KsNNGcI3HuI92iTzMB
         HnYXZXbCsRn+pnawdapATGXjN1xPsmCljLfnGR1lJu0Rp6Gh0hi2GNhwwAwkMJ2GcK
         rMLVVul1WnJQDr/uiUnsEYqdCSgrf5MwSxpyrz7k=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20221101074033epcas1p46bee2823e014ff5d9ec095138390ae81~jZf8RpOcq0920209202epcas1p47;
        Tue,  1 Nov 2022 07:40:33 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.224]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N1hl46CsTz4x9Px; Tue,  1 Nov
        2022 07:40:32 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.92.07691.F6DC0636; Tue,  1 Nov 2022 16:40:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221101074031epcas1p2f21ebf6cd55875cf020570f1c7134831~jZf6nXHS-1531715317epcas1p2X;
        Tue,  1 Nov 2022 07:40:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221101074031epsmtrp25fff4148442c356637fa5166992ab55d~jZf6mmiCr0223902239epsmtrp2A;
        Tue,  1 Nov 2022 07:40:31 +0000 (GMT)
X-AuditID: b6c32a38-31ffb70000021e0b-8f-6360cd6f3010
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.8F.14392.F6DC0636; Tue,  1 Nov 2022 16:40:31 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221101074031epsmtip22dd7233062011c55ac69c2728f9577f8~jZf6eiKSc2971029710epsmtip2e;
        Tue,  1 Nov 2022 07:40:31 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB63168196EA8FB4352871DD4881369@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1 2/2] exfat: hint the empty entry which at the end of
 cluster chain
Date:   Tue, 1 Nov 2022 16:40:31 +0900
Message-ID: <34e401d8edc5$38109260$a831b720$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJbGVKlRTjGnAJr8oRiJ7knPGKj+wGohbknAXbHQ6wAlk5SbgIIQmXgAoTn59Ss4y/W8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmnm7+2YRkgyUXDC0mTlvKbLFn70kW
        i8u75rBZbPl3hNWBxWPTqk42j74tqxg9Pm+SC2COamC0SSxKzsgsS1VIzUvOT8nMS7dVCg1x
        07VQUsjILy6xVYo2NDTSMzQw1zMyMtIztoy1MjJVUshLzE21VarQhepVUihKLgCqza0sBhqQ
        k6oHFdcrTs1LccjKLwU5Ua84Mbe4NC9dLzk/V0mhLDGnFGiEkn7CN8aMlvPNzAVH3Cs+dS5m
        bWDcatLFyMkhIWAicXhxD1MXIxeHkMAORonNW+ZAOZ8YJfa/PsQM4XxjlJhy+z8bTEvXpz2s
        EIm9jBKTTsyFcl4ySsx4tZ0ZpIpNQFfiyY2fQDYHh4iAtsT9F+kgNcwCTYwSExpfsoDUcArE
        Siz4vQpsqrBAtMSGudtYQWwWARWJzbdaGUFsXgFLiamX37JA2IISJ2c+AbOZgWYuW/iaGeIi
        BYndn46C9YoIhElcnjWXHaJGRGJ2ZxvYCxICH9klbv65xwLR4CJxdeZEJghbWOLV8S3sELaU
        xOd3e6He7GaU+HOOF6J5AqNEy52zrBAJY4lPnz8zgnzGLKApsX6XPkRYUWLn77mMELagxOlr
        3cwQR/BJvPvawwpSLiHAK9HRJgRRoiLx/cNOlgmMyrOQvDYLyWuzkLwwC2HZAkaWVYxiqQXF
        uempxYYFJsgxvokRnEK1LHYwzn37Qe8QIxMH4yFGCQ5mJRHe+rPRyUK8KYmVValF+fFFpTmp
        xYcYk4GBPZFZSjQ5H5jE80riDU2MDQyMgAnR3NLcmAhhSwMTMyMTC2NLYzMlcd6GGVrJQgLp
        iSWp2ampBalFMFuYODilGpjcO3c99Si4dr1Vk129heGb7fVjz717X54+LM/LUTWJIUyteN5M
        K0cfh/7s+bbbPN9JrhSbkMRyzNn0lUz60XceKtE+SaGdBUZn+VfzOh9/tnvzudQQwbx5RxXS
        36y8aOXvd2nrShGnCzcb2q+r7ZYu37Ti6JbcRb96zj34qtDH+7OwdJrTl953Zl3n9r04ys3t
        tzlvRqNSebTMLKlTXdl3ril6vXjm+yWC665D+Op4LsuqXerZPmVsF5N3HUyc7MCbl+S3KSnv
        iY9QldeBvL4tygZfxL9E1Fy0+svx1K5wpfSaQ1mZYZuW9KU026el6DW5TZLY3MbUrVm/QlDt
        dpCa717XC3vLoydMsT1vq8RSnJFoqMVcVJwIABHi3HtYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvG7+2YRkg5t3JSwmTlvKbLFn70kW
        i8u75rBZbPl3hNWBxWPTqk42j74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4Mo4teo6Y8FM94rX
        zc/YGhgfGHcxcnJICJhIdH3aw9rFyMUhJLCbUWLOvG6WLkYOoISUxMF9mhCmsMThw8UQJc8Z
        Jc5172QE6WUT0JV4cuMnM0iNiIC2xP0X6SA1zAItjBINu04yQTQcZpY4OK+PDaSBUyBWYsHv
        VWC2sECkxNllv1lBbBYBFYnNt1rBhvIKWEpMvfyWBcIWlDg58wmYzQy04OnNp3D2soWvmSEe
        UJDY/eko2BwRgTCJy7PmskPUiEjM7mxjnsAoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OL
        DQsM81LL9YoTc4tL89L1kvNzNzGCY0NLcwfj9lUf9A4xMnEwHmKU4GBWEuGtPxudLMSbklhZ
        lVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOT1dWY9HUlbYH5DpaG
        4laLUt+6zXm2KseQu/XutowNdkZNinxT1GUWRz6aVN7zwPcNu4fuPzvzfqu/rEdv+miH501K
        ab+dyvrA+dXBikx72eOuR1bItzyrbmVwvPL4e+fmNsdjNxNybvLe0O5+oLrWfd7iRYru2/8s
        9I9b/0h/9VmBcy1v1ts7x2ZUnvOtVH0usFRC9bNvjsXxKxOWnN9yW/aMjMimZ/P7cwxyJQ9L
        9B9cnHbYpP4yl9BHF91ilikdFz/XfH/ov6spRnrhm+dKk6/ea2TMdbN9u3+Dgnvo1VmzlNLS
        J1WcWnTiwwMTNn25ZSIR4QF9gqFacZXCV6JuRl4ynOZ6deHdL7e3V05SYinOSDTUYi4qTgQA
        FZBFpPwCAAA=
X-CMS-MailID: 20221101074031epcas1p2f21ebf6cd55875cf020570f1c7134831
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221019072854epcas1p2a2b272458803045b4dfa95b17fb4f547
References: <CGME20221019072854epcas1p2a2b272458803045b4dfa95b17fb4f547@epcas1p2.samsung.com>
        <PUZPR04MB631604A0BBD29713D3F8DAB0812B9@PUZPR04MB6316.apcprd04.prod.outlook.com>
        <014c01d8ecf0$6e74bc80$4b5e3580$@samsung.com>
        <CAKYAXd9omiOTAaAWSnzE5jCQFDL8Nkok_wm_OAYwxVpgcCxykg@mail.gmail.com>
        <PUZPR04MB6316E0E22B1CAAAB25E02C3581379@PUZPR04MB6316.apcprd04.prod.outlook.com>
        <PUZPR04MB63168196EA8FB4352871DD4881369@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Yuezhang,

> At this stage, we can check this case in exfat_search_empty_slot() by
> removing the following if statement.
>=20
> -               if (num_entries <=3D hint_femp->count) =7B
> -                       hint_femp->eidx =3D EXFAT_HINT_NONE;
> -                       return dentry;
> -               =7D
>=20
> What do you think?

Are you planning to remove the code below as well?
+              /* All entries searched but not enough empty entries */
+               if (dentry + hint_femp->count =3D=3D p_dir->size * dentries=
_per_clu)
+                       return -ENOSPC;

Otherwise, with appropriate comments, it could be modified to:

+                /*
+                 * If hint_femp->count is enough, it is needed to check if
+                 * there are actual empty entries.
+                 * Otherwise, and if =22dentry + hint_famp->count=22 is al=
so equal
+                 * to =22p_dir->size * dentries_per_clu=22, it means ENOSP=
C.
+                 */
+                if ((num_entries > hint_femp->count) &&
+                     (dentry + hint_femp->count =3D=3D
+                      p_dir->size * dentries_per_clu))
+                        return -ENOSPC;

As of now, it seems like the simplest and the best way.

>=20
> > -----Original Message-----
> > From: Mo, Yuezhang
> > Sent: Monday, October 31, 2022 7:05 PM
> > To: Namjae Jeon <linkinjeon=40kernel.org>; Sungjong Seo
> > <sj1557.seo=40samsung.com>
> > Cc: linux-fsdevel <linux-fsdevel=40vger.kernel.org>; linux-kernel
> > <linux-kernel=40vger.kernel.org>
> > Subject: RE: =5BPATCH v1 2/2=5D exfat: hint the empty entry which at th=
e
> > end of cluster chain
> >
> > > > This seems like a very good approach. Perhaps the key fix that
> > > > improved performance seems to be the handling of cases where empty
> > > > space was not found and ended with TYPE_UNUSED.
> > > >
> > > > However, there are concerns about trusting and using the number of
> > > > free entries after TYPE_UNUSED calculated based on directory size.
> > > > This is because, unlike exFAT Spec., in the real world, unexpected
> > > > TYPE_UNUSED entries may exist. :( That's why
> > > > exfat_search_empty_slot() checks if there is any valid entry after
> > > > TYPE_UNUSED. In my experience, they can be caused by a wrong FS
> > > > driver and H/W defects, and the probability of occurrence is not lo=
w.
> > > >
> > > > Therefore, when the lookup ends with TYPE_UNUSED, if there are no
> > > > empty entries found yet, it would be better to set the last empty
> > > > entry to hint_femp.eidx and set hint_femp.count to 0.
> > > > If so, even if the lookup ends with TYPE_UNUSED,
> > > > exfat_search_empty_slot() can start searching from the position of
> > > > the last empty entry and check whether there are actually empty
> > > > entries as many as the required num_entries as now.
> > > >
> > > > what do you think?
> >
> > We plan to add a new helper exfat_get_empty_dentry_set(), this helper
> > is called before setting the entry type, it caches and then checks for
> > empty entries(Check-on-write is safer than checking when looking for
> > empty directory entries).
> >
> >        for (i =3D 0; i < es->num_entries; i++) =7B
> >                ep =3D exfat_get_dentry_cached(es, i);
> >                type =3D exfat_get_entry_type(ep);
> >                if (type =3D=3D TYPE_UNUSED)
> >                        unused_hit =3D true;
> >                else if (type =3D=3D TYPE_DELETED) =7B
> >                        if (unused_hit)
> >                                goto error;
> >                =7D else
> >                        goto error;
> >        =7D
> >
> > This code is not ready, we are testing and internal reviewing.
> >
> > > -----Original Message-----
> > > From: Namjae Jeon <linkinjeon=40kernel.org>
> > > Sent: Monday, October 31, 2022 2:32 PM
> > > To: Sungjong Seo <sj1557.seo=40samsung.com>; Mo, Yuezhang
> > > <Yuezhang.Mo=40sony.com>
> > > Cc: linux-fsdevel <linux-fsdevel=40vger.kernel.org>; linux-kernel
> > > <linux-kernel=40vger.kernel.org>
> > > Subject: Re: =5BPATCH v1 2/2=5D exfat: hint the empty entry which at =
the
> > > end of cluster chain
> > >
> > > Add missing Cc: Yuezhang Mo.
> > >
> > > 2022-10-31 15:17 GMT+09:00, Sungjong Seo <sj1557.seo=40samsung.com>:
> > > > Hi, Yuezhang Mo,
> > > >
> > > >> After traversing all directory entries, hint the empty directory
> > > >> entry no matter whether or not there are enough empty directory
> > > >> entries.
> > > >>
> > > >> After this commit, hint the empty directory entries like this:
> > > >>
> > > >> 1. Hint the deleted directory entries if enough; 2. Hint the
> > > >> deleted and unused directory entries which at the
> > > >>    end of the cluster chain no matter whether enough or not(Add
> > > >>    by this commit);
> > > >> 3. If no any empty directory entries, hint the empty directory
> > > >>    entries in the new cluster(Add by this commit).
> > > >>
> > > >> This avoids repeated traversal of directory entries, reduces CPU
> > > >> usage, and improves the performance of creating files and
> > > >> directories(especially on low-performance CPUs).
> > > >>
> > > >> Test create 5000 files in a class 4 SD card on imx6q-sabrelite
> > > >> with:
> > > >>
> > > >> for ((i=3D0;i<5;i++)); do
> > > >>    sync
> > > >>    time (for ((j=3D1;j<=3D1000;j++)); do touch file=24((i*1000+j))=
;
> > > >> done) done
> > > >>
> > > >> The more files, the more performance improvements.
> > > >>
> > > >>             Before   After    Improvement
> > > >>    1=7E1000   25.360s  22.168s  14.40%
> > > >> 1001=7E2000   38.242s  28.72ss  33.15%
> > > >> 2001=7E3000   49.134s  35.037s  40.23%
> > > >> 3001=7E4000   62.042s  41.624s  49.05%
> > > >> 4001=7E5000   73.629s  46.772s  57.42%
> > > >>
> > > >> Signed-off-by: Yuezhang Mo <Yuezhang.Mo=40sony.com>
> > > >> Reviewed-by: Andy Wu <Andy.Wu=40sony.com>
> > > >> Reviewed-by: Aoyama Wataru <wataru.aoyama=40sony.com>
> > > >> ---
> > > >>  fs/exfat/dir.c   =7C 26 ++++++++++++++++++++++----
> > > >>  fs/exfat/namei.c =7C 22 ++++++++++++++--------
> > > >>  2 files changed, 36 insertions(+), 12 deletions(-)
> > > >>
> > > >> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> > > >> a569f285f4fd..7600f3521246 100644
> > > >> --- a/fs/exfat/dir.c
> > > >> +++ b/fs/exfat/dir.c
> > > >> =40=40 -936,18 +936,25 =40=40 struct exfat_entry_set_cache
> > > >> *exfat_get_dentry_set(struct super_block *sb,
> > > >>
> > > >>  static inline void exfat_hint_empty_entry(struct exfat_inode_info
> *ei,
> > > >>  		struct exfat_hint_femp *candi_empty, struct
> exfat_chain *clu,
> > > >> -		int dentry, int num_entries)
> > > >> +		int dentry, int num_entries, int entry_type)
> > > >>  =7B
> > > >>  	if (ei->hint_femp.eidx =3D=3D EXFAT_HINT_NONE =7C=7C
> > > >>  	    ei->hint_femp.count < num_entries =7C=7C
> > > >>  	    ei->hint_femp.eidx > dentry) =7B
> > > >> +		int total_entries =3D EXFAT_B_TO_DEN(i_size_read(&ei-
> > > >> >vfs_inode));
> > > >> +
> > > >>  		if (candi_empty->count =3D=3D 0) =7B
> > > >>  			candi_empty->cur =3D *clu;
> > > >>  			candi_empty->eidx =3D dentry;
> > > >>  		=7D
> > > >>
> > > >> -		candi_empty->count++;
> > > >> -		if (candi_empty->count =3D=3D num_entries)
> > > >> +		if (entry_type =3D=3D TYPE_UNUSED)
> > > >> +			candi_empty->count +=3D total_entries - dentry;
> > > >
> > > > This seems like a very good approach. Perhaps the key fix that
> > > > improved performance seems to be the handling of cases where empty
> > > > space was not found and ended with TYPE_UNUSED.
> > > >
> > > > However, there are concerns about trusting and using the number of
> > > > free entries after TYPE_UNUSED calculated based on directory size.
> > > > This is because, unlike exFAT Spec., in the real world, unexpected
> > > > TYPE_UNUSED entries may exist. :( That's why
> > > > exfat_search_empty_slot() checks if there is any valid entry after
> > > > TYPE_UNUSED. In my experience, they can be caused by a wrong FS
> > > > driver and H/W defects, and the probability of occurrence is not lo=
w.
> > > >
> > > > Therefore, when the lookup ends with TYPE_UNUSED, if there are no
> > > > empty entries found yet, it would be better to set the last empty
> > > > entry to hint_femp.eidx and set hint_femp.count to 0.
> > > > If so, even if the lookup ends with TYPE_UNUSED,
> > > > exfat_search_empty_slot() can start searching from the position of
> > > > the last empty entry and check whether there are actually empty
> > > > entries as many as the required num_entries as now.
> > > >
> > > > what do you think?
> > > >
> > > >> +		else
> > > >> +			candi_empty->count++;
> > > >> +
> > > >> +		if (candi_empty->count =3D=3D num_entries =7C=7C
> > > >> +		    candi_empty->count + candi_empty->eidx =3D=3D
> total_entries)
> > > >>  			ei->hint_femp =3D *candi_empty;
> > > >>  	=7D
> > > >>  =7D
> > > > =5Bsnip=5D
> > > >> --
> > > >> 2.25.1
> > > >
> > > >

