Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24212315FC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhBJG6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:58:42 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34171 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhBJG6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612940318; x=1644476318;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=v97T+v669hDyeVN3RtlD46nLN4GqCjlMQBXoQvNt3SM=;
  b=I+ZHudyHJbjsz6tPdqnyA51NPiHor5xxRMpUf2YXbU81cUG6+Kmg3+u9
   Ll4gMMaXxASEszTpZs0Vde6n3exiWlJAUGC5Vtx4zfHQxgCU5GTgA9Cw5
   iQiy+nJ8DSU9z/iGLaab9mMGkqrHu2t8XXuaZYixgqB3hiptjHqN49Hhm
   D8+50xZwGiAsDb/aMM/QcvOfMKPyafQ+mGqG3Z62Z6cUhhWDP+hCPR5In
   n5u5oGB4J6yY3eJqV0bd/WPh3SzHp41rQdewtnIP8tLOXHvg3ZhCiMiUj
   oe1P92Yq5j1e5MHw68Wyw0jM+3dIxisaVagw3DxOVEPotk3hAoxZ1FyyV
   A==;
IronPort-SDR: ZZ96z6qMSYhvsFnRrXFWIOs4PmPtJuxE/HPq+HHGyhoDQxtjUtwWkmbF6G8VOK7pvlaPptBqG7
 IeXJKzFNscJks816MtVmCEzl0v4MKz10oEojUhyTNlTx3E81EZTrnnTk1Pwrv/SvvYKMuQw5J1
 B/fFw1mQezbvrPD/jMOm0QRPDuh9+nzEByRv9TMpfogimx6gbyRV3Rwrh60hlE4Nm3S27h1R27
 ZIIL8f/+43Uh1czzQHdFxgmP1I58xDVfOk79fMP8j21CT4UulMLMVmxUm6o5Y73iPc+hhXmeLp
 XBA=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; 
   d="scan'208";a="270084802"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 14:57:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChLmh1HQmdhChkpU6cUikHlRWiArvsRZOsVRLlDM0wpqnWJEcjyB7hM//4lRsV08dHF/0BKZ4CY1S5dH5cJiKUaxvuMrHilU4DINzIC26DYzMmsuYM2j388S1gOhDLQD5gZpmeR0oPvFsFwDGKZWtkmPsxHRZGnXzIiYDr9Nn2bGYSaT9a+jPe+P6k2q3Z8n47rkLBOR7P9tUPooxFyI/k1Oo9lmohOuljczLFhvxFTbbt+8Kq8ku7bWQ8IexPAmjcw/ruFsLMBEh5LkS8MLuiTWryEf8EwApIj7nMrewDDzKnZ9xRbabL+g7kxbGjZZaqeJYQieKtX6i17uvRA49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdJnDarxYKOPg84SwX+tQ7XJAyEc3x9Uhqnb+Tj3Tow=;
 b=atQl1QbQMjzBOEBIEQW4JpLlkXORbkFOyk8qePn0axHl3BOHYDDucjvy4CqUf3NzBJYEweT3r1gI2mbYJMy7VTx9B94AXFVqe9iXUFm7sJRw9m/v9imlk54AGq6IvIzRcxGzXZK3lpMys0nncJi+suX/id5sMXI2ySnU9HQ95Tcvpl+ioBAY1Ujp0wt4QWxsiF+JYlsAcHFvnxfHeXhvCHw99esmgSS4IxwGv95KInjjUza+UWb1p3YZUqYZhoB7sjxPftvIDyhJPB0+VurNlpXbgAsVJDwXX/HWOzsNtWO7aLQNIOiGZgwqwNwZyMEyxyOYRnL767/Cc8I5apDDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdJnDarxYKOPg84SwX+tQ7XJAyEc3x9Uhqnb+Tj3Tow=;
 b=mHWJWA9r9Cemu1Mk0H+OwGfQ/+D28dpORKeVb0/EnUJdbOqpcpv7BUovcK5DdOiHwTy3GwPX5RyeYVIoYYeusc3peADQ2pdT/EejQA45UYOZ5QMv4I03RhwJh+7p/IQjhWlkUCaXaEKc6EOGBAi2rMPMzHVHWNR9oqHaoBPhNBo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3960.namprd04.prod.outlook.com (2603:10b6:a02:ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Wed, 10 Feb
 2021 06:57:30 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 06:57:30 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Thread-Topic: [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Thread-Index: AQHW/3WAW9SwnELN/EW61EsEJOsRXA==
Date:   Wed, 10 Feb 2021 06:57:30 +0000
Message-ID: <BYAPR04MB4965E51F07F1AB084BC1FA84868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-5-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10aaf2b6-b7ed-416f-1b54-08d8cd9122a5
x-ms-traffictypediagnostic: BYAPR04MB3960:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB3960128404427D34AA6CE64E868D9@BYAPR04MB3960.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k1dLb0+8HLOLgzWGurmQC5mYLBQpey7LLZHZ8LUJeQgWL1mmm7trz43b1tvEaJFrwo8KFgd6vp5VoUErSHWoIhp2ewhSMaxlw9jBZ0DuFRLQwxt/95oGZ+IRBjIro8RWhQfgc+I5dBNwOW1SR0BT56fBkNhp6JGfIwKos4Z1t0dBtZkwIeLo+ZZqPoGbKuRP0CHmLtVnslhrMVqUyj1N321urqu9BHOWMUP9Vo/rN0sTwfIZejUC+XPHakEfed7+oo4Lhoe7sEg5lGGb7VdzqnV+i6Ql1+BhvshyKRs2jjJsSUij4xue3HDQ0BT8R8aGxrNzmm9dvjySIfioThvkdQW5CPQ4WnXbbnJ3nlq3/+gssl1prOSPVyl3ZYZlE0fVik3unqND0Ud9BI1NmY3QdyNVx3cx4S4feyrmWHdpjnda91MF8lueF8B0Gk+AlNmihwv/bcf9QF029u69A537R2jnQQKRKShpaF7pI/XmxA/iGHcQPjDbYqqbGNPKHK0WwaozPoRZEUM3EyzWJ8BM+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(86362001)(33656002)(5660300002)(66946007)(7696005)(52536014)(9686003)(54906003)(2906002)(186003)(26005)(316002)(8936002)(53546011)(4326008)(8676002)(478600001)(6506007)(110136005)(55016002)(76116006)(71200400001)(64756008)(66446008)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fNojOS+A10nK8pn7n/Z3wEYS/PC1tY9CSvKz/9BBbCj/112SLmViJuOLd9kW?=
 =?us-ascii?Q?rI6HUDm1mrxemrfGiFD/gkUiEqk1wARtLFLxplzpDhPBZACgH6mdMz8/7UnP?=
 =?us-ascii?Q?M7o07QIb/a14wiQVS+I5ftlSuBiwdTUz2mE+4wzLKB0myvioZBh13ezq2zHW?=
 =?us-ascii?Q?WZ80667oYtKt8JwqDT9mMEoTuC/EPZKDm0ywzxkQ/E7a89oqvKOu39f0F1/q?=
 =?us-ascii?Q?B5LDa8Td/pX9YeUCarzjZCveplFB1GGzp01yU+JyHmTqJzxENNuNq+yUUYP7?=
 =?us-ascii?Q?2r9vi+fmuwt7QtaPgO6VvFfasI4HmLaeGa5KKkxPJDa+4l7Elfw/iBxwqs6I?=
 =?us-ascii?Q?o9JMu21ooZR2cyYjqlVcDeg7kmhMPtiTRUcjsapoeK79SLxPEIdhno4RVF+x?=
 =?us-ascii?Q?z7LanU5etjaYM+q+8j97MlbCbxpsVd9gxc5Sr+uQMQiUBi+dEyxwkKqxTZ99?=
 =?us-ascii?Q?V3fl0aVxzn1uQIA15HwJTJ4PgmhItvKuTXK0LYCKiLM6efWYUtzdo+kbegt4?=
 =?us-ascii?Q?JD24z+9X1tEhK8JD+ynfbPO7qQruI0Uu/3d92ROenr9ByBE/hp+I2wtTfiuX?=
 =?us-ascii?Q?0y1CnIqWstmbjspsXjPbsTWz/kA8T25WajILczECq4KAYebplELAqlpoIRvT?=
 =?us-ascii?Q?nCf4HoUkKR/dJI5Bt1iXQ697L2SlKSYWu45KvhgSWxYmJBSRTCyg1BT5jUQZ?=
 =?us-ascii?Q?0aSQ9dqrJkasYWmCUAYhqsaMZObtA5RgBlwsN6wf8S0mBaiWWlbbzK551jy2?=
 =?us-ascii?Q?n/8ujK0Jro7ELiqxKMYDD0RsSox0MaQgPLM2WxdvLq5q8KYWLwIN5OQ31iLk?=
 =?us-ascii?Q?iRvqdEzCooJWqa00xha8DK/W68229GBGQTQaTG2o/Tl3FjzUbazyCvZvrsh2?=
 =?us-ascii?Q?/6nhoXUcvy21z77EGEH68V56OBiluhHqd7tlGYw2ZJ7Alx944IsR/m6cyHjV?=
 =?us-ascii?Q?IhXvh45Ir7BU8C1Ti7yTNPILGMQnAPwOiDpOwkLAoVBbypYMlt5EAjR7O8ma?=
 =?us-ascii?Q?qUMXc0zIJ6a0gUL5DjbRTLKaJqiiRMNodG+GP2gekQM215sbTi+m5xFLc8eu?=
 =?us-ascii?Q?sULcWkUsx0+7rlW+SJTbHSFwft6AsfMSjhrQWQE/iw8YtwtUKnAaLhvw7a+n?=
 =?us-ascii?Q?UcuvpY6M5aKVNWtqv6ElhDRSOahhQIvWpoMy+mD8cTkX7Y55L72pAJ3Bt1Q6?=
 =?us-ascii?Q?Lf73FgRiSUd/KOAOQc7Oh9gv8qnhuBPoAnEoT5Tn1GJO/t9rHhm/oGwwRlnF?=
 =?us-ascii?Q?JvkwC8e54aZqqO2li7tp6Lo4YZT4KrgXEMWzO3kwcW8bXiO6VcGD35mzWzEZ?=
 =?us-ascii?Q?CZ6A5iuPg7BuybdHkn74biRD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10aaf2b6-b7ed-416f-1b54-08d8cd9122a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 06:57:30.7133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +a4ABf5cZlJ6WVpEga1hc1+5sqT9xsZNXybRMNFRWJFUqhHn5q1ZruJbqoQdRGU+fK7hCesPOLiN62ByC28LTV9kc89AOyxxTHsw6HcP5is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3960
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 22:25, ira.weiny@intel.com wrote:=0A=
> From: Ira Weiny <ira.weiny@intel.com>=0A=
>=0A=
> Add VM_BUG_ON bounds checks to ensure the newly lifted and created page=
=0A=
> memory operations do not result in corrupted data in neighbor pages and=
=0A=
> to make them consistent with zero_user().[1][2]=0A=
>=0A=
I did not understand this, in my tree :-=0A=
=0A=
zero_user()=0A=
 -> zero_user_segments()=0A=
=0A=
which uses BUG_ON(), the commit log says add VM_BUG_ON(), isn't that=0A=
inconsistent withwhat is there in zero_user_segments() which uses BUG_ON() =
?=0A=
=0A=
Also, this patch uses BUG_ON() which doesn't match the commit log that says=
=0A=
ADD VM_BUG_ON(),=0A=
=0A=
Did I interpret the commit log wrong ?=0A=
=0A=
[1]=0A=
 void zero_user_segments(struct page *page, unsigned start1, unsigned end1,=
=0A=
365                 unsigned start2, unsigned end2)=0A=
366 {=0A=
367         unsigned int=0A=
i;                                                                         =
  =0A=
=0A=
368=0A=
369         BUG_ON(end1 > page_size(page) || end2 > page_size(page));=0A=
370=0A=
371         for (i =3D 0; i < compound_nr(page); i++) {=0A=
372                 void *kaddr =3D NULL;=0A=
373 =0A=
374                 if (start1 < PAGE_SIZE || start2 < PAGE_SIZE)=0A=
375                         kaddr =3D kmap_atomic(page + i);=0A=
376=0A=
377                 if (start1 >=3D PAGE_SIZE) {=0A=
378                         start1 -=3D PAGE_SIZE;=0A=
379                         end1 -=3D PAGE_SIZE;=0A=
380                 } else {=0A=
381                         unsigned this_end =3D min_t(unsigned, end1,=0A=
PAGE_SIZE);=0A=
382        =0A=
383                         if (end1 > start1)=0A=
384                                 memset(kaddr + start1, 0, this_end -=0A=
start1);=0A=
385                         end1 -=3D this_end;=0A=
386                         start1 =3D 0;=0A=
387                 }=0A=
388=0A=
389                 if (start2 >=3D PAGE_SIZE) {=0A=
390                         start2 -=3D PAGE_SIZE;=0A=
391                         end2 -=3D PAGE_SIZE;=0A=
392                 } else {=0A=
393                         unsigned this_end =3D min_t(unsigned, end2,=0A=
PAGE_SIZE);=0A=
394 =0A=
395                         if (end2 > start2)=0A=
396                                 memset(kaddr + start2, 0, this_end -=0A=
start2);=0A=
397                         end2 -=3D this_end;=0A=
398                         start2 =3D 0;=0A=
399                 }=0A=
400        =0A=
401                 if (kaddr) {=0A=
402                         kunmap_atomic(kaddr);=0A=
403                         flush_dcache_page(page + i);=0A=
404                 }=0A=
405        =0A=
406                 if (!end1 && !end2)=0A=
407                         break;=0A=
408         }=0A=
409        =0A=
410         BUG_ON((start1 | start2 | end1 | end2) !=3D 0);=0A=
411 }=0A=
412 EXPORT_SYMBOL(zero_user_segments);=0A=
=0A=
=0A=
=0A=
