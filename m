Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E964315F87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 07:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhBJGel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 01:34:41 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35589 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhBJGeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612939619; x=1644475619;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IkbaYW098NgijQrYpS5hiaPt1PFRF6MIq9sHS+FVb5g=;
  b=OCTgH9suzsyL/W7unoX3K5rT/gTO/0v4QKc6bJVZjcAHPbtbFlSO/wtK
   MoFLBUyYe27oOiXoHBY/ElNdt0osaXVGQDmzVrQmo+5KAqNWlXlflvtoE
   q+fXx/ZSk+ZrtmLhwuQ8uQfZGpQxxzlUyQ2SG47iTYB5aMhBT/KdYubCn
   cTwZTlFKsf1ztaqApOTXEi/1VN4f4QtEYhyqfgoCfDdfEjkLQ0cNnQI1U
   qG7Jjx2Jo5+Rg5ATENRGCeaWn58+nh8+2kSlj8p1h2eXQMDLK6Qe4Z4Fi
   TLhcIKPo4Urzsx33bb4EtUCGYIl6qsUIPkxCCLoc2mEU7QmKLezULgFZR
   A==;
IronPort-SDR: +OabCUpeHLuEIHxaTTb4qaSPrR9tZoejP7VtW66YTjqlgOWTOZo5PPkjrLFvDlxNSTbqF4go/L
 SNhBRSx38/qPSvxs4KGhimM41pTloyTW3MNsWF/pBAYqsRgfCWeG2MZLl1YVSVePlcsOJBEme3
 CjQTqaJMZHHgqxWjM8sufDRSvullH8G1xbtSnd2al/PZpwgx8ewGmmUhTNTkJBz4JozglUzTxE
 DmutOaF4H6eOr5J8/iSLgO8htTwSu7RM1VFjJwtT577nPElwweSb+drDkG841SyYxmZvNhdKtZ
 V1g=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; 
   d="scan'208";a="263727768"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 14:45:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es65Wo6Oj5PJkARI63SCAgaMPeqrEGfIeHpKKLOeCzxMQFS9LjT+OOLwsVqMlSHEaUiFZxPL+Ic6vNQn0XaENQTm+6u3AZOOAVcLziRGxI2yaL9/0npn3vUujX+M1yO9p3XPCsutr3pUaHqQ9zin+38k6BsvnT7Xp8Z8sY/luIgmWE3ccIxCj3Nzomx40R1X0iBUD/L9e83PUCl4fqXqxMMBPV2DCOZqmFfUPwdOySpP59m+KCEDKe7O5cRHOkMpyIFHfydzHe4xg5Pp932rMv/vljcEi7HbQyHzeQ1evo7S03HJ+xvTBldb57JUSEPbcltLn74qsZk+vzW32ghJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf6xS758U8rn87koc8KVngOXKRxx3dXysuAJb02YvXk=;
 b=fpcYCi4wOe4+2EAzSkNNq8LxiqWfNBcUCjymVqUK08bJH6M3MJw5SFIaBBVXbMxef3Bv7d5utpJjgMSrgt2/AKCActboCoMgkPSwsqkuDAKZ02NySl6+6WKwqhEvPqnyks9sziOa4X0bk5TK0s0zt+tQ4NH3Zdi08G6ueHTxP09V2aF/HC5ze46NOVfkM/1HctFAttLbcCzEELvhiy/LKqaol02Y5bPGgXYJw+flCC5J8Zt0/qo7Tg9CcAOoffHRwLr/bxMJPC5iLjVoR/pl7ruDcurwpFHz8qaKHF3buyJtSzGqlKQRCiyel4zRlWab7qDkMMKvlp5l6q1OUDVqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf6xS758U8rn87koc8KVngOXKRxx3dXysuAJb02YvXk=;
 b=qOHB5bFDjGxQt6g72TfaqF+BGGJcbgYQE6F4vdG3G72VbTKveqEgjDxgxUQ08UZmncRc4QjFeljEKWJfSPY11hdfkTdBPVIDw9uYCVmHFqjtybqzboLx5ZslR0WjyxtZ3m4+0F+zN+kSq4uZfLnEIDDA3jyUZSOrKSwCnjMd9yg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4039.namprd04.prod.outlook.com (2603:10b6:a02:ab::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 10 Feb
 2021 06:33:24 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 06:33:24 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>
CC:     Boris Pismenny <borisp@mellanox.com>,
        Or Gerlitz <gerlitz.or@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 1/8] mm/highmem: Lift memcpy_[to|from]_page to core
Thread-Topic: [PATCH V2 1/8] mm/highmem: Lift memcpy_[to|from]_page to core
Thread-Index: AQHW/3WAdYNjj6ILr021d+mWvVgb4g==
Date:   Wed, 10 Feb 2021 06:33:24 +0000
Message-ID: <BYAPR04MB49655E6A3BD935B15DCC468B868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-2-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb1ee856-1f03-4c30-27ff-08d8cd8dc4bc
x-ms-traffictypediagnostic: BYAPR04MB4039:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB403970366737C3EB1A543120868D9@BYAPR04MB4039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zUxrZrX0Unmo3WWXypo1oIIgzV/iq9Fh4YdrZXKgBqSuT0EfkucU9SQ1KIad9AYG8MPZLYZC2UOhlR8XeI68C4fnLCDABfidd25glg2bKpWctInLMigEQ0YtNA7rhsqQbiyNGZKRwjgq/u2/9IZoUG8QzDuwGhh1ZwDCkMIs8hsYuowZgLz2ZSKTCVQKBmHlbv5U28XogyqFFH6nmYrKIFCT/rFIKqy/Hc1J+EkgF1bCdilpk0wmHKVGzmTwNbncIAJNWqEu0parg6hignkl6Ds7/sCG0KOPn+XAFW3pj+P8BB8DWcAKHUpA+NMmsDxZDwI9zFK3kxjD9LsS9nf5Watds0iDNlRc84RlemNeIaAmtarBHG4GFYKg1U0HQptaK3ulkhfpLimjPWp1O/sOKD+n7XAcD1f7N7zv+GLGLv1KwrZkltXGgN8U2Rq6kq44sWzRcr2R+7UOxTAgQ0zoeMfZ/R1MlIIqZklFg+7F4db3GdxjDnJLoirqo85ni4SWTZ19DtoMKFgKdh8yES9zJVN3Z1Rj7/Q2QmBmsRJfiX/uccVvPnaP+iXpVp3/tqeY+IUfcQck6RXTiwbgC3AOyPxPL6ED5Z8H28A0sPlTX9w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(136003)(376002)(396003)(186003)(53546011)(6506007)(66946007)(86362001)(71200400001)(52536014)(8676002)(54906003)(316002)(26005)(7696005)(110136005)(966005)(4326008)(7416002)(33656002)(478600001)(5660300002)(8936002)(64756008)(2906002)(66446008)(55016002)(9686003)(66556008)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?L8wcvVcJg4PX9GjC2iEmD/6gKkMgo75kMQyiPgQ1MNEvyhyMXxG/ZhLhGHE9?=
 =?us-ascii?Q?1ig3e2pmjNgStT1/3CD4G30Iy/QGf4F/otslBJblfESyyUeS36LvOv2RpT8B?=
 =?us-ascii?Q?prFP5+JXXKMSJFYITezVtJErbLtHzEHJqmj413LHhLcWlsQ7uGI7/UcwjYfs?=
 =?us-ascii?Q?vJQLFmDWFynOh9HrCtswoQp8h+DuxKug1/fA94yphWU+y1KvzcZM7SARmJzF?=
 =?us-ascii?Q?inuWogPGy7qck+oHrHCJG5rbXgGdgfIMXCxYSchNydJZz/gJk4Qn+HOHsfGF?=
 =?us-ascii?Q?x5i4fhu9Kw4dcmRadtud2Cz9L9ZGLf0XpFJaKX416WZ40GBGdMG0Taa/xDiV?=
 =?us-ascii?Q?YdJQUcEvRjLZcZP7np+1eo5QsIPLY7Q5mS1aIWyfjlL4p79uaerLf61+5Mjc?=
 =?us-ascii?Q?k6BbpxcyQIwgR3oya/T4QUiN2bWkj7jqsJqqKMcY3OcWlEFLVYqzDL9Q+pEW?=
 =?us-ascii?Q?fFd8curwO58FnaqfSNWxjJFIOD7w+H54bOTPErpt/LFSuZz2ArA93lBXwIQv?=
 =?us-ascii?Q?T6IWubvzySS7DqZ0tk+EpG6Y2PK5XcetbKxoZIm57NtWwF/NlWbDfuajsqCG?=
 =?us-ascii?Q?U1Y5oqqqWQMn7jDrhTED6bRsZzmEiFRfN9yIJeyWPLz6cGozTcRoqAYCgYSJ?=
 =?us-ascii?Q?1whlqYctaOx3/oAiHiJKnhQ6e7PUi1giXowwG3JtqWHpGFyxLTZ/mPPF0OZU?=
 =?us-ascii?Q?VcKe4XVL6iH3a2q+iOk86POA3L0VEGOpI98B0uVCr0A9tMxrCoXlp4M0tBI6?=
 =?us-ascii?Q?bEqRg8Ieaf/2fqm4HuHvaB2rRmQ80uiL+2X1tlnuHOJV4bsq1a8UmOaO+3pj?=
 =?us-ascii?Q?RC8Jf7W5+k1WuEq5P5VhOjNitERDSl4p/28xj8vLCSRcOdz1LN7D/zzcc8wO?=
 =?us-ascii?Q?AZm5rsI+qpDL3KU6IXHAPiOJHokyWvFCLpLOukW92TYrQbbJHVN0OD9dSmh0?=
 =?us-ascii?Q?6IK17NquqT/2Gc36zJxK2LNt9t1uZRu8hS4sJ8nwg2+J3ek8bUPIHQRD/kV7?=
 =?us-ascii?Q?J2oCrFdGFp60PKHTfpL+HFTd/1S42UXueNkD6nxVI1Z+Mkfqn5PW/PAreeoD?=
 =?us-ascii?Q?t2eC68aY1CQKIz8lG69JWwkIMZF48LmRpGpeDA/dMGvZMxlJksMiI0TnozJe?=
 =?us-ascii?Q?LnOnzm3CQknjhTK+6cwIETs2RRJQiUyi75vrD+OIVnE80qyzVPmCQkkIudfZ?=
 =?us-ascii?Q?iidsgzWtefXRKxInQYw/XK4fRuHhf7T2GrhpAhVllnj1HjXHto5yOrcCeNxg?=
 =?us-ascii?Q?+fT59bUfbFbBVcJThkjAtE/vCWAifEPyFEKAzrjcXHPZE3Kny6bV6HugT0oq?=
 =?us-ascii?Q?v0+CgT1eJMWwxnVQHsmChAuP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1ee856-1f03-4c30-27ff-08d8cd8dc4bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 06:33:24.6274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2EPrzhQXpsQrP6C41uBXaeraAtYQlaCVprN7zfL9Xt4k9tVJ6xDeYPAHVxxnuUX9kjU3abUKhLK6CZoQujmWL9k0AtptnFSUDveLdNarvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4039
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 22:25, ira.weiny@intel.com wrote:=0A=
> From: Ira Weiny <ira.weiny@intel.com>=0A=
>=0A=
> Working through a conversion to a call kmap_local_page() instead of=0A=
> kmap() revealed many places where the pattern kmap/memcpy/kunmap=0A=
> occurred.=0A=
>=0A=
> Eric Biggers, Matthew Wilcox, Christoph Hellwig, Dan Williams, and Al=0A=
> Viro all suggested putting this code into helper functions.  Al Viro=0A=
> further pointed out that these functions already existed in the iov_iter=
=0A=
> code.[1]=0A=
>=0A=
> Various locations for the lifted functions were considered.=0A=
>=0A=
> Headers like mm.h or string.h seem ok but don't really portray the=0A=
> functionality well.  pagemap.h made some sense but is for page cache=0A=
> functionality.[2]=0A=
>=0A=
> Another alternative would be to create a new header for the promoted=0A=
> memcpy functions, but it masks the fact that these are designed to copy=
=0A=
> to/from pages using the kernel direct mappings and complicates matters=0A=
> with a new header.=0A=
>=0A=
> Placing these functions in 'highmem.h' is suboptimal especially with the=
=0A=
> changes being proposed in the functionality of kmap.  From a caller=0A=
> perspective including/using 'highmem.h' implies that the functions=0A=
> defined in that header are only required when highmem is in use which is=
=0A=
> increasingly not the case with modern processors.  However, highmem.h is=
=0A=
> where all the current functions like this reside (zero_user(),=0A=
> clear_highpage(), clear_user_highpage(), copy_user_highpage(), and=0A=
> copy_highpage()).  So it makes the most sense even though it is=0A=
> distasteful for some.[3]=0A=
>=0A=
> Lift memcpy_to_page() and memcpy_from_page() to pagemap.h.=0A=
>=0A=
> [1] https://lore.kernel.org/lkml/20201013200149.GI3576660@ZenIV.linux.org=
.uk/=0A=
>     https://lore.kernel.org/lkml/20201013112544.GA5249@infradead.org/=0A=
>=0A=
> [2] https://lore.kernel.org/lkml/20201208122316.GH7338@casper.infradead.o=
rg/=0A=
>=0A=
> [3] https://lore.kernel.org/lkml/20201013200149.GI3576660@ZenIV.linux.org=
.uk/#t=0A=
>     https://lore.kernel.org/lkml/20201208163814.GN1563847@iweiny-DESK2.sc=
.intel.com/=0A=
>=0A=
> Cc: Boris Pismenny <borisp@mellanox.com>=0A=
> Cc: Or Gerlitz <gerlitz.or@gmail.com>=0A=
> Cc: Dave Hansen <dave.hansen@intel.com>=0A=
> Suggested-by: Matthew Wilcox <willy@infradead.org>=0A=
> Suggested-by: Christoph Hellwig <hch@infradead.org>=0A=
> Suggested-by: Dan Williams <dan.j.williams@intel.com>=0A=
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>=0A=
> Suggested-by: Eric Biggers <ebiggers@kernel.org>=0A=
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>=0A=
=0A=
Thanks for adding a new line in the new calls after variable declaration.=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
