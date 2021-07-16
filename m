Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071EE3CB1AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 06:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhGPErp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 00:47:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:64169 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhGPErp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 00:47:45 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210716044449epoutp03ea8d78dd17577cc5a59f4d9e637bf716~SK_eeiR3m0345003450epoutp031
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 04:44:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210716044449epoutp03ea8d78dd17577cc5a59f4d9e637bf716~SK_eeiR3m0345003450epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626410689;
        bh=HmJ5EKQDG64xx1P9gbCCe8ze1OrEXT2hywk3rNibFzY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=UUBfgfLPn5iqyH0rfEemRAhBq9fROiuSgKdQuNyCQa7LB01enq1nYMJT8ZTHssELR
         KVms1Y4izxOq+423cut2jJ0IqdFrKTai2tKCX1eGKT67HlR3nMSXjqkOUMv+vwPZI2
         W4IdmzpzeTBHHWqD0sPZ2I+ugBI0MVNhdlrMhhPU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210716044448epcas1p4226143a9bbfe5b80bad7b76da208ba10~SK_eCaOY-2809328093epcas1p4X;
        Fri, 16 Jul 2021 04:44:48 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GQzDb5Y4pz4x9QH; Fri, 16 Jul
        2021 04:44:47 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.8A.09952.FBE01F06; Fri, 16 Jul 2021 13:44:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210716044447epcas1p18ca5699551993248e0432dea5219063d~SK_cvPkDa0574205742epcas1p1P;
        Fri, 16 Jul 2021 04:44:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210716044447epsmtrp1d74c87f5b090f8b036980d0197a6e1a2~SK_cuhTMt2238222382epsmtrp1o;
        Fri, 16 Jul 2021 04:44:47 +0000 (GMT)
X-AuditID: b6c32a35-45dff700000026e0-74-60f10ebfbcd5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.AC.08289.FBE01F06; Fri, 16 Jul 2021 13:44:47 +0900 (KST)
Received: from namjaejeon01 (unknown [10.89.31.77]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210716044447epsmtip24234b564fb24eea1ad155a9ed5d84bb4~SK_cje2yX2146721467epsmtip29;
        Fri, 16 Jul 2021 04:44:47 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     <flrncrmr@gmail.com>, <linux-fsdevel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
In-Reply-To: <OSBPR01MB45357B200F44AF64D446D42790129@OSBPR01MB4535.jpnprd01.prod.outlook.com>
Subject: RE: [PATCH] exfat: handle wrong stream entry size in
 exfat_readdir()
Date:   Fri, 16 Jul 2021 13:44:47 +0900
Message-ID: <000001d779fd$4e12ca20$ea385e60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHtYa6HDZ3zKB0Tzc4hP4i9K19tVAGye6HqAdd9DMKq/OcFAA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTQHc/38cEg7fzNC161y5gs3hzciqL
        xZ69J1kstvw7wurA4tF8bCWbx85Zd9k9+rasYvT4vEkugCUqxyYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEnY9ItzYIzHBWT/h5mbmD8y9bF
        yMkhIWAisXLRB/YuRi4OIYEdjBLXPp9mg3A+MUpM39THDOF8ZpSYvOUaE0zL59P3WCESuxgl
        nn05xwThvGCUePnnIjNIFZuArsS/P/uBZnFwiAgYSTw9WQgSZhZIk3izYyI7iM0pECux6fJy
        sDuEBfwljrw+zwhiswioSnR/2scI0sorYCmx+lgASJhXQFDi5MwnLBBj5CW2v53DDHGPgsTP
        p8tYQWwRASeJlq/f2SBqRCRmd7aBPSAh8JddYsHu/VA/u0gsW7UE6hlhiVfHt7BD2FISL/vb
        oOxyiRMnf0HV1EhsmLePHeQeCQFjiZ4XJSAms4CmxPpd+hAVihI7f89lhFjLJ/Huaw8rRDWv
        REebEESJqkTfpcNQA6Uluto/sE9gVJqF5LFZSB6bheSBWQjLFjCyrGIUSy0ozk1PLTYsMESO
        6U2M4LSoZbqDceLbD3qHGJk4GA8xSnAwK4nwLjV6myDEm5JYWZValB9fVJqTWnyI0RQY0hOZ
        pUST84GJOa8k3tDUyNjY2MLEzNzM1FhJnHcn26EEIYH0xJLU7NTUgtQimD4mDk6pBqbHX4My
        E+W3MDUvO9XFMXfL6ZYtT9OVVy5MjHBXSRKPzzg3i9vCRHHviZOX0t/xJ/o33T3qut93xtL4
        ydUvTKfVLu9srS04XFEzIfDklpTp5uKxl+s8a1ZffHd/w/7HIf1vivXT99tIKM10PbR3xza7
        b5sXznabv79R1iepdg+TA8MrrbXrNgfXubxeuPpXd6Fp86lwyR3c/ceMnX9EehyoNv1zWK5G
        +DyXV3ZupdvrG7L3N8pwe649XcnyuVPXJqgh5mVtm+OHbS5rlQ7cOqTCYjXFgO1ds9Ot9Vaz
        m79LJmdKq01jNeE9YzFZY9fZoKc7Hux9cJjxrtCsiEsvRe+XZtWd+veYYV7etfdZoY+UWIoz
        Eg21mIuKEwFLOBNkFAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvO5+vo8JBqdfCFj0rl3AZvHm5FQW
        iz17T7JYbPl3hNWBxaP52Eo2j52z7rJ79G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8akW5oF
        ZzgqJv09zNzA+Jeti5GTQ0LAROLz6XusXYxcHEICOxgldjzcxwSRkJY4duIMcxcjB5AtLHH4
        cDFEzTNGiXOz74PVsAnoSvz7s58NpEZEwEji6clCkDCzQIbEjd072CHq7zFKTDq3jhEkwSkQ
        K7Hp8nKwxcICvhKPTn4Di7MIqEp0f9rHCDKHV8BSYvWxAJAwr4CgxMmZT1hAwswCehJtGxkh
        xstLbH87hxniSgWJn0+XsYLYIgJOEi1fv7NB1IhIzO5sY57AKDwLyaRZCJNmIZk0C0nHAkaW
        VYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwdGhpbWDcc+qD3qHGJk4GA8xSnAwK4nw
        LjV6myDEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDkxTz
        ew6HrSqXSvj1m3WK7EQTp6yvXrR0Wmbstk07fk+xvCm05PjKo+kt71UO/93Bd3eZ+2Xda/wO
        SyPv+7iziz7VKzzzf0/knZ8dT7N95Sa3hT5/d0/i1ZSFtlFFgrq7Zxvs2epzxFjUJ8PzTxRH
        V40gO8u33kAxp/aCBHO9E6L7JTp6XljkGk/4/97tb8uiu1lR9api/DrfY5smlV4R+DE1I3HH
        su7fzYr/pB2fqM38tK2ZN/lDacqeenWxuwee8DFx7s76eKxnu6eqBn+IIGuQX1IEn4beJodH
        dpIfIu09jnCuinvF82DtS14/hc5NL6q3uvqHNzeUH5kwzU31wZ20tR5vV2r/yV2mFluoxFKc
        kWioxVxUnAgAgJ0aVv0CAAA=
X-CMS-MailID: 20210716044447epcas1p18ca5699551993248e0432dea5219063d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210611004956epcas1p262dc7907165782173692d7cf9e571dfe
References: <CGME20210611004956epcas1p262dc7907165782173692d7cf9e571dfe@epcas1p2.samsung.com>,<20210611004024.2925-1-namjae.jeon@samsung.com>
        <OSBPR01MB45357B200F44AF64D446D42790129@OSBPR01MB4535.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > This patch check DataLength in stream
> > entry only if the type is ALLOC_NO_FAT_CHAIN and add the check ensure
> > that dentry offset does not exceed max dentries size(256 MB) to avoid
> > the circular FAT chain issue.
> 
> I think it's preferable to add a 256MB check during dir-scan.(as I said in the previous) If you want
> to solve "the circular FAT chain issue", you should add it to other dir-scan loops.
> (exfat_search_empty_slot, exfat_check_dir_empty, exfat_count_dir_entries, etc ...).
> 
> Also, the dir-scan loop may not terminate when TYPE_UNUSED is detected.
> Even if TYPE_UNUSED is detected, just break the inner for-loop will continue the outer while-loop, so
> the next cluster will be accessed.
> If we can't use DataLength for checking, we should check the contents more strictly instead.
> 
> The current implementation has several similar dir-scan loops.
> These are similar logics and should be abstracted, if possible.
Can you send me the patch instead of just talking?

> 
> BR
> Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>


