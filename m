Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6F1E5528
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 06:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgE1EnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 00:43:04 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:26349 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgE1EnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 00:43:03 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200528044301epoutp028c7366e2169c90ec181aa204be8aa35b~TF4twb90Y2562425624epoutp02P
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 04:43:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200528044301epoutp028c7366e2169c90ec181aa204be8aa35b~TF4twb90Y2562425624epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590640981;
        bh=Ifl6upRPYldFInrD+MnQOAMq5IXbw4SSBWckwLPYgA4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=U3Tsc1uJ34LahG/N9pHCOdVH3/LwudF+QfoqENKsB10fD7MZKP6pneM7LIiZnRNHo
         m9f6KlXOT0gqvB4AgQUw6MpawX5vADuCM21LkPRkJnteFpVzKWLYJyh10D2An6kMLy
         FVE2CMPPiP21ewipRkEvJBZYmbP/XpVsj1vCKw70=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200528044300epcas1p22579ec3b77e60304827bf31084b2dfae~TF4tXTpGj1659616596epcas1p2g;
        Thu, 28 May 2020 04:43:00 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49XZnb2KvNzMqYkV; Thu, 28 May
        2020 04:42:59 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.38.04392.2514FCE5; Thu, 28 May 2020 13:42:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200528044257epcas1p29993d86ddc9e7880fc3e024eb28a818e~TF4qcJmYc0783007830epcas1p2K;
        Thu, 28 May 2020 04:42:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200528044257epsmtrp12933f7bfad9c1eaa8ef1f5ff315f52dd~TF4qbZj6S0434504345epsmtrp10;
        Thu, 28 May 2020 04:42:57 +0000 (GMT)
X-AuditID: b6c32a37-cabff70000001128-7e-5ecf4152bdaf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.D5.08303.1514FCE5; Thu, 28 May 2020 13:42:57 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200528044257epsmtip1a2c27d2ba70913a4ac42381210a8d27f~TF4qK-x4K1265112651epsmtip1S;
        Thu, 28 May 2020 04:42:57 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Tetsuhiro Kohada'" <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     <mori.takahiro@ab.mitsubishielectric.co.jp>,
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520075641.32441-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
Subject: RE: [PATCH] exfat: optimize dir-cache
Date:   Thu, 28 May 2020 13:42:57 +0900
Message-ID: <015001d634aa$7588c2b0$609a4810$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIppg9uhSXp+fpSRiclI8Xh/geTfAMD/7F2p/3na3A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmrm6Q4/k4g97f3BZvTk5lsdiz9ySL
        xeVdc9gsLv//xGKx7MtkFost/46wOrB5fJlznN2jbfI/do/mYyvZPPq2rGL0+LxJLoA1Kscm
        IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gCJYWyxJxS
        oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BoUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsac
        Fb/YCp6xVPxdcoa5gbGVpYuRk0NCwETiTNd5ti5GLg4hgR2MEl+vLmOGcD4xSlzvnswC4Xxm
        lPj9/RMrXEv7QiaIxC5Gied3H7FDOC8ZJeZ8u84IUsUmoCvx789+NhBbRMBdYsfCA2CjmAXO
        M0os3twAluAUCJJYc2EOWIOwgJ7Ex28vgcZycLAIqErsPFEOEuYVsJS4c/sgM4QtKHFy5hOw
        w5kF5CW2v53DDHGRgsTPp8tYIXZZSZx6OoERokZEYnZnG9g/EgITOSSWf7wI9bWLxMr1+6Fs
        YYlXx7ewQ9hSEi/729hBbpAQqJb4uB9qfgejxIvvthC2scTN9RtYQUqYBTQl1u/ShwgrSuz8
        PRdqLZ/Eu689rBBTeCU62oQgSlQl+i4dZoKwpSW62j+wT2BUmoXksVlIHpuF5IFZCMsWMLKs
        YhRLLSjOTU8tNiwwRo7sTYzg1KllvoNxwzmfQ4wCHIxKPLwGHufihFgTy4orcw8xSnAwK4nw
        Op09HSfEm5JYWZValB9fVJqTWnyI0RQY7BOZpUST84FpPa8k3tDUyNjY2MLEzNzM1FhJnHf+
        jzNxQgLpiSWp2ampBalFMH1MHJxSDYyFwaeywj5FWsb77StiZzEIerw5drPcNe+bfDcrrwfF
        HgywX/U0ZIIP/60lD/eyPtst8DZ1t+2M+a3rSz/tavzwZrm/Y1H7LM0L38z1//QF5mi/ffOu
        sc3jk3T9vvUTf+TxzuV586zF9e62r98SdPROVKQzHDDyY78+Vepz58THiQtnt7dPt16lxFKc
        kWioxVxUnAgAZHUI2LMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnG6g4/k4g08XRSzenJzKYrFn70kW
        i8u75rBZXP7/icVi2ZfJLBZb/h1hdWDz+DLnOLtH2+R/7B7Nx1ayefRtWcXo8XmTXABrFJdN
        SmpOZllqkb5dAlfGnBW/2AqesVT8XXKGuYGxlaWLkZNDQsBE4kz7QqYuRi4OIYEdjBLvplyB
        SkhLHDtxhrmLkQPIFpY4fLgYouY5o0RP21lmkBo2AV2Jf3/2s4HYIgLuEjsWHmABKWIWuMgo
        sW3PSnaIjsWMEn+mLgHr4BQIklhzYQ4jiC0soCfx8dtLJpANLAKqEjtPlIOEeQUsJe7cPsgM
        YQtKnJz5hAWkhBmovG0jWCezgLzE9rdzmCHuVJD4+XQZK8QNVhKnnk6AqhGRmN3ZxjyBUXgW
        kkmzECbNQjJpFpKOBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgiNIS2sH455V
        H/QOMTJxMB5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQozQHi5I479dZC+OEBNITS1Kz
        U1MLUotgskwcnFINTAYGDoqHTwauPrPs35HuRJYmUyfDEPdWub1lLw4d0xORPbvj8qOqeM8/
        /buNGc7aTVZhtr8clsa0sbt0wYHnnnc1lD9d3n1KWfSOTmPnTyur247v6hQ39P2PTPj0YIao
        9L6WkqLUX3OEm8rmeNx7qnyjsu6AzzYhSbOZnLF6OqxW8i/bdH+cjvkfxTn9TeoVbv/Kg8wO
        6t0VB4sdP5SV3GN2e/nmlI+i7kf91XIffNx2+n5lf6PIOt3mtZPclZINz0STA3sKW3mUJMJW
        NLScN7z8RWV64JWOf5ICpxv2H3d/1rT909QKIev/m//czu9nnRxsu1UgOmbrsU0Hw+qzeYs3
        uWh725/ep9jQJHhDiaU4I9FQi7moOBEAhLZZTw8DAAA=
X-CMS-MailID: 20200528044257epcas1p29993d86ddc9e7880fc3e024eb28a818e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200520075735epcas1p482c10e2ea2e5af1af36894677691cbc8
References: <CGME20200520075735epcas1p482c10e2ea2e5af1af36894677691cbc8@epcas1p4.samsung.com>
        <20200520075641.32441-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +struct exfat_dentry *exfat_get_dentry_cached(
> +	struct exfat_entry_set_cache *es, int num);
You used a single tab for the continuing line of the prototype here.
We usually use two tabs for this.
>  struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
> -		struct exfat_chain *p_dir, int entry, unsigned int type,
> -		struct exfat_dentry **file_ep);
> +		struct exfat_chain *p_dir, int entry, unsigned int type); void
> +exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync);
>  int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir);
> 

