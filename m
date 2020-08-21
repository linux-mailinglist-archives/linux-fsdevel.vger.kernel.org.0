Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2797624D2F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 12:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHUKls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 06:41:48 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:17868 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgHUKlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:41:44 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200821104141epoutp01a3f5300dd5a5f35ba7fe4a3762d5b399~tQnI3edN82815828158epoutp01d
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 10:41:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200821104141epoutp01a3f5300dd5a5f35ba7fe4a3762d5b399~tQnI3edN82815828158epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598006501;
        bh=poLqY9EGLDKa8yvvVcvs6rM02nT8sG+hx4knJ1wOJIc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rb7ioqUpcGuqdl2XcK8l+g3zFzSgjMshKGhk3VpdeOiZ4K19Z6O8vBrWKGLveFHNo
         pVsFVfbiVIwF+oXRWWIDFRntNBAdbM65MYcNfUErYgamwDVkkHoTe8ltoF2x6lLUvL
         bD4qkXoL7w5e0//JuKZZhgnSoeY/NN7TijB/U1W4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200821104140epcas1p398acf15bc5bdd5c3315afadec9c9304d~tQnIKiSnX2619326193epcas1p3n;
        Fri, 21 Aug 2020 10:41:40 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BXykC3JJzzMqYkX; Fri, 21 Aug
        2020 10:41:39 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.4F.29173.3E4AF3F5; Fri, 21 Aug 2020 19:41:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200821104138epcas1p1a5f057285008936d47dc102f4d0a54a7~tQnG1O0gB1520915209epcas1p1v;
        Fri, 21 Aug 2020 10:41:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200821104138epsmtrp2f37da7a4fc948fa10ae18024ac84416c~tQnG0jTTh0400204002epsmtrp2E;
        Fri, 21 Aug 2020 10:41:38 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-b2-5f3fa4e3d03c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.D6.08382.2E4AF3F5; Fri, 21 Aug 2020 19:41:38 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821104138epsmtip2362e1b0f5cb6e83053c86123d18aeac2~tQnGlr9y70316903169epsmtip2V;
        Fri, 21 Aug 2020 10:41:38 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.t2@gmail.com>
Cc:     <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>,
        <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Namjae Jeon'" <namjae.jeon@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <bbd9355c-cd48-b961-0a91-771a702c03df@gmail.com>
Subject: RE: [PATCH 2/2] exfat: unify name extraction
Date:   Fri, 21 Aug 2020 19:41:38 +0900
Message-ID: <860b01d677a7$a62bf230$f283d690$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGp1IjqD1H8gBd2v567dvdPOf7sigI0j+eiAeStLz0CAMGsqwHAcDY2qVzA3FA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmru7jJfbxBks7JS1+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi8qxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2Vo
        YGBkClSZkJNxY04fS8F9sYp5jYeYGhiPC3YxcnJICJhI3O97zdjFyMUhJLCDUeLMgdUsEM4n
        Rom5+z5BOd8YJXqO/WaBabn6bSNUy15GibeT9kBVvWSU2D3rGTtIFZuArsSTGz+ZQWwRAT2J
        kyevs4HYzAKNTBInXmaD2JwCthLzd94HiwsLmEpM3v4IzGYRUJVYtPo7I4jNK2ApcfLCEzYI
        W1Di5MwnLBBztCWWLXzNDHGRgsTuT0dZIXb5SfyePYMZokZEYnZnGzPIcRICczkkfk/9B/WC
        i8S31WsZIWxhiVfHt7BD2FISn9/tZYOw6yX+z1/LDtHcwijx8NM2pi5GDiDHXuL9JQsQk1lA
        U2L9Ln2IckWJnb/nMkLs5ZN497WHFaKaV6KjTQiiREXi+4edLDCbrvy4yjSBUWkWks9mIfls
        FpIPZiEsW8DIsopRLLWgODc9tdiwwBg5tjcxgtOplvkOxmlvP+gdYmTiYDzEKMHBrCTC27vX
        Ol6INyWxsiq1KD++qDQntfgQoykwrCcyS4km5wMTel5JvKGpkbGxsYWJmbmZqbGSOO/DWwrx
        QgLpiSWp2ampBalFMH1MHJxSDUzr7Dt5jXWe7xJ9kBZcOa+xPfxV9qKVG+/H1lkUWPyrcbe7
        +tzmdYtJT+Hn+YcmqqiLlNYdrUmVOddjN8d4++stXXndTgm2n1QOtQVZbms6nVft17zX9JQI
        Q0Mn55+zwvErDqYd3C/fUtb4btahn7otfa2M1XfmWrunZuZ6pqX41s9P///e/gl/qaevzY3/
        CmVzOl8vlbtu7cqg95XnAvfUOjlt3ZfFc2fcrn30j1ffZ+4RXVNhpZ6rO4QX3/zqdXZ3wnKO
        cB1xXQf1jtKV9rN6Y4wrU5JXv9o9v+zpkrtXxJTF+1znCjfb3VwfktA7X1IwRKI/IJD/bc1J
        ccPf9m8YUoLXrnmoqbqRe0aMEktxRqKhFnNRcSIABimHJjAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXvfREvt4g62H9Sx+zL3NYvHm5FQW
        iz17T7JYXN41h83i8v9PLBbLvkxmsfgxvd6B3ePLnOPsHm2T/7F7NB9byeaxc9Zddo++LasY
        PT5vkgtgi+KySUnNySxLLdK3S+DKmLTJqGCzWMWHr2dYGxinC3YxcnJICJhIXP22kbGLkYtD
        SGA3o8TnZ4vYuhg5gBJSEgf3aUKYwhKHDxdDlDxnlLjz5iMjSC+bgK7Ekxs/mUFsEQE9iZMn
        r7OBFDELNDNJtH5pZoLomMIksW7tM7AqTgFbifk777OB2MICphKTtz8Cs1kEVCUWrf4ONpVX
        wFLi5IUnbBC2oMTJmU9YQGxmAW2JpzefwtnLFr5mhvhAQWL3p6OsEFf4SfyePYMZokZEYnZn
        G/MERuFZSEbNQjJqFpJRs5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERxV
        Wpo7GLev+qB3iJGJg/EQowQHs5IIb+9e63gh3pTEyqrUovz4otKc1OJDjNIcLErivDcKF8YJ
        CaQnlqRmp6YWpBbBZJk4OKUamA78PnL6sO5L/4MTbzy5+9FzAscaqYU9QrN+LZaftPTOkd8i
        bLZ2m5krbK7cn8b7RTvFP17/8e+nC3MndDZ9tzilLbM9WUfUdJ2n3MTyT0eWGFo3F6xcP4/t
        aPe9qqWlFw+eNazgvx1ysffMfvGU/BMpuu8eTjc5a3hv/72DRSJ7VumJPPG8MOsC/93C3JN+
        E52nf1x0IP5SD8cJhcLmopXe7KkXNtwOMnrFr5Jdxa61qruM/Y5Ts7u04B+9xuWv1EMOTPWP
        YXIMbLOTnLztZY3Zoh85nG+U4g8em2bx+dLP2dPOVOf6f8jfZOpfabwq1Y/hiZmeaP3hyPuJ
        4QURWw7MkGo+JP752QMNt50WLhFKLMUZiYZazEXFiQDwkI9yGQMAAA==
X-CMS-MailID: 20200821104138epcas1p1a5f057285008936d47dc102f4d0a54a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200806055726epcas1p2f36810983abf14d3aa27f8a102bbbc4d
References: <20200806055653.9329-1-kohada.t2@gmail.com>
        <CGME20200806055726epcas1p2f36810983abf14d3aa27f8a102bbbc4d@epcas1p2.samsung.com>
        <20200806055653.9329-2-kohada.t2@gmail.com>
        <000201d66da8$07a2c750$16e855f0$@samsung.com>
        <bbd9355c-cd48-b961-0a91-771a702c03df@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Thanks for your reply.
>=20
> On 2020/08/09 2:19, Sungjong Seo wrote:
> > =5Bsnip=5D
> >> =40=40 -963,80 +942,38 =40=40 int exfat_find_dir_entry(struct super_bl=
ock
> >> *sb, struct exfat_inode_info *ei,
> >>   			num_empty =3D 0;
> >>   			candi_empty.eidx =3D EXFAT_HINT_NONE;
> >>
> > =5Bsnip=5D
> >>
> >> -			if (entry_type &
> >> -					(TYPE_CRITICAL_SEC =7C
> > TYPE_BENIGN_SEC)) =7B
> >> -				if (step =3D=3D DIRENT_STEP_SECD) =7B
> >> -					if (++order =3D=3D num_ext)
> >> -						goto found;
> >> -					continue;
> >> -				=7D
> >> +			exfat_get_uniname_from_name_entries(es, &uni_name);
> >
> > It is needed to check a return value.
>=20
> I'll fix it in v2.
>=20
>=20
> >> +			exfat_free_dentry_set(es, false);
> >> +
> >> +			if (=21exfat_uniname_ncmp(sb,
> >> +						p_uniname->name,
> >> +						uni_name.name,
> >> +						name_len)) =7B
> >> +				/* set the last used position as hint */
> >> +				hint_stat->clu =3D clu.dir;
> >> +				hint_stat->eidx =3D dentry;
> >
> > eidx and clu of hint_stat should have one for the next entry we'll
> > start looking for.
> > Did you intentionally change the concept?
>=20
> Yes, this is intentional.
> Essentially, the =22Hint=22 concept is to reduce the next seek cost with
> minimal cost.
> There is a difference in the position of the hint, but the concept is the
> same.
> As you can see, the patched code strategy doesn't move from current
> position.
> Basically, the original code strategy is advancing only one dentry.(It's
> the =22minimum cost=22) However, when it reaches the cluster boundary, it=
 gets
> the next cluster and error handling.

I didn't get exactly what =22original code=22 is.
Do you mean whole code lines for exfat_find_dir_entry()?
Or just only for handling the hint in it?

The strategy of original code for hint is advancing not one dentry but one =
dentry_set.
If a hint position is not moved to next like the patched code,
caller have to start at old dentry_set that could be already loaded on dent=
ry cache.

Let's think the case of searching through all files sequentially.
The patched code should check twice per a file.
No better than the original policy.

> Getting the next cluster The error handling already exists at the end of
> the while loop, so the code is duplicated.
> These costs should be paid next time and are no longer the =22minimum cos=
t=22.

I agree with your words, =22These costs should be paid next time=22.
If so, how about moving the cluster handling for a hint dentry to
the beginning of the function while keeping the original policy?

BTW, this patch is not related to the hint code.
I think it would be better to keep the original code in this patch and impr=
ove it with a separate patch.

> Should I add this to the commit-message?
>=20
>=20
> BR
> ---
> Tetsuhiro Kohada <kohada.t2=40gmail.com>

