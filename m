Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C8A3120C4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 02:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhBGBsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Feb 2021 20:48:00 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:55209 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhBGBr6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Feb 2021 20:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612663190; x=1644199190;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zQNUcIDqy5RxuXZLpLvXE43m0xmOQjt6Tq8a7R64F/I=;
  b=ojGEbxRpb9reuwAVcCOwMLcPk+lgjhxCucSAvz4CmZkrUPNbUjJnnBlP
   j8fR4x2RZQZwYvAhjGU5JdQWeQoq8HRXrcAPCmYxmNmiAJaZlWXRk6Iah
   cCgscvGUBI1jcgRUz5UjIF1p28EIjZGcmiJZmMThVQlWS3AJFSk9no/GR
   sdFSwO9ZmRidnEpKVrjm+9aGKIArS+x+tzmJqJ/LRFrR26WVrIhRj8dPe
   0qyw19nR0vKYnNIKNkPt+E4+B7wTt1MXTZagOVnGGvRO9Wa0JTJncj2eh
   UkxRBfF50JUXd/cPn4IxSGQzm9kluO4Gr7lgmVCYFgaCU//Z5itz8JQr1
   w==;
IronPort-SDR: r0pc8hC2uHxL4BlkhnQL1gt4boW/cGqDOCZlbm/QePcvE/ulYNH/LCRTYYtOIXOk8wR7GeooCN
 wRiA+S7PKk+yIT77rf0wilR4iBEOMmM1lCVnKiNWKTJzobbr2M0YRTZOei583MwhXhpsoEgVxv
 LMqU3qP8S4JE5/H0tIsS2Q+sM7p/abNyw0joi3D9vP6z4iQsd239cui9uj9wrjqAQuaDDWrmxg
 EMdXNpglQykp0+JZhJHmuoQ8ewCNekTPkHXq/gsK3N5aOq4/+8cgVnvpnZLPvNttzNepQYjkee
 v20=
X-IronPort-AV: E=Sophos;i="5.81,158,1610380800"; 
   d="scan'208";a="263466267"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2021 09:58:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TigP2vi1zVE+AU9Ya6EBnTCbBt5kkWRNZGMmxzx6Nhqps3rJf0CyQ7g6wzD8vMf1es+SEI3yvX8MH96D5yEH1FN0k/ze3ydVi0+t0i+yWI9Kp1cvfLrDKVlkdj098Elrjm+3+NM6vjW8Y3Y4fmzKhq6AH7RQx3YTOTbR5aujgJyoE6ggym/yXgwNJT1RjdyW1XhHdJl9gTRcRmxlbr8H/UR0zYaW6+A6YT80g6SsI9mptNOFpzvOOlGpV3vnBxyi5JSmHQ1GOljq3EMM7GkOJ/EttLslo/1bTVI6/1LVbGXsRN3wFa3L5RFXV1Y96MLWzgZ7EnV08dehwvyZTcoclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFNJVfRwYDm4NPXRoXoznWVQubq8wvutMclAecT3iXo=;
 b=dNKMTerzgFFtL34MaesRM+S4vxjAYUsER3JP9wFMSm/eVuQnrxRYxUv0lsNVKWE+E5ieHCC75R6C3SBLdU8SJVkaSTOjAe7sU4tWVEBIMInVLps38CyaEWYF+EMqBS9Gn3PZR/kjMx/zw++zRIZyyU8xisIh4rESvMLUAP6LFx5RdIby4MlkZPxSJuXBeKA0sLZLBTQSOTLouUxpXfhoWa+AfB+SRRnU4XncERCAwla4lte6rXbqQp2EYm4sKyhzD6K0qQxim55YJykghKeG7nNkpasLMi3/QByeARccYGcUt1t4BtMmgn2+RjmXrMSFbTcmb2f3gGs6uVt87Ti+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFNJVfRwYDm4NPXRoXoznWVQubq8wvutMclAecT3iXo=;
 b=WE7O3pJ4XdSj9ZpF4zWn6xQfTFLLCiizv0pXVQmDj6mt/WehdNHaC+m/q0WCAXss/xBEhGSnWW3/hSbsARrtb3L2bJEofFIYcsfsEibHn8aV68wV5cVT4tWsO40/zxxZY5rej7s9651sOAx5MROgnAzTVTkk7CT9Mw8HMRC0DUg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6753.namprd04.prod.outlook.com (2603:10b6:a03:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Sun, 7 Feb
 2021 01:46:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Sun, 7 Feb 2021
 01:46:48 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     Boris Pismenny <borisp@mellanox.com>,
        Or Gerlitz <gerlitz.or@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/4] mm/highmem: Lift memcpy_[to|from]_page to core
Thread-Topic: [PATCH 1/4] mm/highmem: Lift memcpy_[to|from]_page to core
Thread-Index: AQHW/DCr64Y1yB8xakqJU9Z0zyt3KQ==
Date:   Sun, 7 Feb 2021 01:46:47 +0000
Message-ID: <BYAPR04MB49655E5BDB24A108FEFFE9C486B09@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
 <20210205232304.1670522-2-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07444eaf-a066-48c3-bfec-08d8cb0a3b76
x-ms-traffictypediagnostic: BY5PR04MB6753:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BY5PR04MB675357A91F05AC22F25D33CE86B09@BY5PR04MB6753.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bm6DiKWqK3+i5FRBrBRjh3ddPzCLFrOWbGek9L+jKIv6AiQsAnpqi1/V8fe3yB4HyWcg7bXeMMHL3F760jGLQYruQQLqIjJhDaq0rMXHicVnZhO6KGZ4PazyPyQgksGBRZzp1t8QV9q22bSaTjCzuThoeC81D4X71TeThP5M+o+BjcYDFACELHSNTCK6Q5clQrIHxiAtLjkHBf3Gk7+0Q2wrVG4wmOxfVKNwzb7XiVNyk8a+bX7wYFKRfbH6ytRWqrUIGgOGoSLXouoyylB58RNGYdqKmcdaGU7n8v3+jk0SKtQ+3WUhzARHU/j6lX0QdbwkWlo3zCy9ERcJXYRSjJHm6Xe+FjaIEPqKM5bSgnURLOMDCuZOyk4M42Q1N7Otk5G4ZvDOD3jkQ5GMNz0w9Ala3dlNZJDHyr9M0CG4CG+yz+LYs9Dz/p6NzZvAXxOBUB/IQwH+yM2so/V59oJiAzAfBWd94zR+PJNKScjyMya7Ritk7dMT5cOwh7TALCGPuVGn5INn0YCIoAhqhY2dFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(8936002)(54906003)(5660300002)(110136005)(7696005)(8676002)(7416002)(2906002)(316002)(9686003)(52536014)(33656002)(55016002)(4326008)(478600001)(66446008)(26005)(71200400001)(186003)(86362001)(66476007)(64756008)(66556008)(6506007)(53546011)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1LVuACJuqPKhOZOMxcdszO1TOB+tI7B7yz1aVAtR1WwlGEc5xbu4D8qi6sIQ?=
 =?us-ascii?Q?R7gtkD2Q1XabtthqXb90H7XUjrE/DxgL0V+beQYAIVa9SutYGW05+6p5wb4g?=
 =?us-ascii?Q?KKngsfBOPh5U2ep2mS7Yzu72a4hukRRTQpRSTJ5AaKy0iBQ0B5BSbnNAIEuo?=
 =?us-ascii?Q?SYMgyle1mzgDAGmzKvPq/pCJpVL5hErrcj1HgyVND5age0IbYJzalu7VCGJU?=
 =?us-ascii?Q?M7T2HTdjnaCeCT2XVLlqlbbynTcR9VYsnoA2l4RJfzfRxfq9GPwP1RLIeRLq?=
 =?us-ascii?Q?3QCEmSzI1kLuOefZdImVxuWX+MUkGY3FnpKyHqzqRu/EwAZ11Zmt2+vTn99U?=
 =?us-ascii?Q?LPOX7S0yL/3XiP4Kq7pKvYzGZzn4xzlP2UtLOs/YRWY1XYz2yjvNK8Rxqc+R?=
 =?us-ascii?Q?Z71CcrBkyt59+csi4pmHlqY52XJl6sJb4GuK446acGGJ4Tol6QeS4tz22md2?=
 =?us-ascii?Q?zZWHrK6JL9mcRsvD6WPAkynu7Rnfa3w55ZOhwpJxOxlWi1aL2LR5PLorvw5i?=
 =?us-ascii?Q?WiCeIboyniYAci0e/eY3l9CcX40jz4ZgLFu6koWEHwYDwZh32OMzYkb8tLXE?=
 =?us-ascii?Q?xj3X5hW//tW5GvJ+h6P8hN8ADtbeZrgyvQSb4KoZR77bvmTrSDvTfHcsk82D?=
 =?us-ascii?Q?cGQwqN9A8uf9Wq93Wyvvy27ggjYmaCxaf5NtlB4f1GVTkYraNgdP87sDvK+P?=
 =?us-ascii?Q?zuIvKx4Mj56wSmKM35mMUZtL4m/Wu42YYqfeHiDmJBf7KBNXvQlgcSolGasv?=
 =?us-ascii?Q?TglK+6D3M83wdtkE36rguVRgWY/a1Y5h3so82F2uBR1j9lJFiHu2k/REOVEE?=
 =?us-ascii?Q?ql0LrE2vTvI2LCG34fVXom14etN9F9XgCGzX2Yrl8//9HQk4luYzBCWI8VE1?=
 =?us-ascii?Q?nz6F7WwfRI1Tx8YzKIHhJ5SX4D0cNhrxHuTjMEYix8ZSxDksY7V5BrQiOwTB?=
 =?us-ascii?Q?jtuKyJ+90ehYbs5/5Q5tstDCBoSG93VCePjvLKLeP5jJACOyO4kH/+u53LcA?=
 =?us-ascii?Q?3T1p/FI/YlYPh2ohTxc48dJZhMtSfm0Urm7W2p0qX5zfsugH8y/G36jCdSIo?=
 =?us-ascii?Q?cochSm73BVDHApDnvinu/9reEQzFB4s2K3Jv+0kFnuk6MCQvxqrhTH3Gb+mG?=
 =?us-ascii?Q?iLQT0X08NKlFRhCQldQfBuxesvaP1NtWyyhkN6hMx/blGWDKfavXZG0qS6H4?=
 =?us-ascii?Q?WGKw2nS/MJorONvTCEEw0j2TSDG0RYbTyT2tgDyjJJcnfhga2u4a4JZu8wev?=
 =?us-ascii?Q?U4WDR3RLXkt6I7ZWjoxhkEXx6/KcYTwuxARnwIBp16OWg1CKHdytWaSagyof?=
 =?us-ascii?Q?qdhCR4PXq5TcJz4UQhKfjisn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07444eaf-a066-48c3-bfec-08d8cb0a3b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 01:46:47.9315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apQXQ8iYsdcKbU1ueKnMLsOD3FW3ivzUdzfUyicIXo4YQHsAmr0ZDsguIF2mFK4GJiy4M4MnoTvhp84KkW5oYqyV5aGY7br99OJsSySC8zQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6753
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/5/21 18:35, ira.weiny@intel.com wrote:=0A=
> +static inline void memmove_page(struct page *dst_page, size_t dst_off,=
=0A=
> +			       struct page *src_page, size_t src_off,=0A=
> +			       size_t len)=0A=
> +{=0A=
> +	char *dst =3D kmap_local_page(dst_page);=0A=
> +	char *src =3D kmap_local_page(src_page);=0A=
> +=0A=
> +	BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);=0A=
> +	memmove(dst + dst_off, src + src_off, len);=0A=
> +	kunmap_local(src);=0A=
> +	kunmap_local(dst);=0A=
> +}=0A=
> +=0A=
> +static inline void memcpy_from_page(char *to, struct page *page, size_t =
offset, size_t len)=0A=
How about following ?=0A=
static inline void memcpy_from_page(char *to, struct page *page, size_t=0A=
offset,=0A=
                                    size_t len)  =0A=
> +{=0A=
> +	char *from =3D kmap_local_page(page);=0A=
> +=0A=
> +	BUG_ON(offset + len > PAGE_SIZE);=0A=
> +	memcpy(to, from + offset, len);=0A=
> +	kunmap_local(from);=0A=
> +}=0A=
> +=0A=
> +static inline void memcpy_to_page(struct page *page, size_t offset, cons=
t char *from, size_t len)=0A=
How about following ?=0A=
static inline void memcpy_to_page(struct page *page, size_t offset,=0A=
                                  const char *from, size_t len)=0A=
> +{=0A=
> +	char *to =3D kmap_local_page(page);=0A=
> +=0A=
> +	BUG_ON(offset + len > PAGE_SIZE);=0A=
> +	memcpy(to + offset, from, len);=0A=
> +	kunmap_local(to);=0A=
> +}=0A=
> +=0A=
> +static inline void memset_page(struct page *page, size_t offset, int val=
, size_t len)=0A=
How about following ?=0A=
static inline void memset_page(struct page *page, size_t offset, int val,=
=0A=
                               size_t len)  =0A=
> +{=0A=
> +	char *addr =3D kmap_local_page(page);=0A=
> +=0A=
> +	BUG_ON(offset + len > PAGE_SIZE);=0A=
> +	memset(addr + offset, val, len);=0A=
> +	kunmap_local(addr);=0A=
> +}=0A=
> +=0A=
