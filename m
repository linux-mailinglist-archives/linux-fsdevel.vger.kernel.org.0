Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C3537EBDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbhELTjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 15:39:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37724 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358813AbhELSuc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 14:50:32 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CIjvX1006443;
        Wed, 12 May 2021 18:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NhwVY7y1bG9It4IlggO1sX5H3wGNfypj5ulRtF2SJMo=;
 b=yylJ7vgMMR4C8ZjnoCSReNt6QXzdOiJeoor1GrsJXJOxfYlIM87ewQsy5FQYOYfVE9Vw
 JOaxROwssDXJaAnLu2bTOS7rGF4TaL6mMWtPuVuXvl/rQErwN7F2Em6jqfy3ypv42y5S
 Zzc/CQRmTvnGaW9ULXZmHCZJvStBykNLXfw3Cou47Kh8J2kwTwLjq4IflNzipq+qQtAF
 uGmQEylcU4+9K8i+Nuc52XHttJfQgw6XTtEqop2e/XleCnmoVtnPKV+OZjqj11wu645A
 DtCxnonVX1evoSXHCu7orEMaw5KK5ZiNQdM691yq/pJUTmD63Tjr158H+oyf/pIyX8UO Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38dg5bk446-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 18:48:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14CIik8E186150;
        Wed, 12 May 2021 18:48:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 38djfckhf3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 18:48:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQHK6vEH4C2RGNmxaj1nGUAI0yki+NufDPm56c7i8sP9SES39B9V90AcYorXG5WA14izLBVR5ddvbcwcU+cAdoLJyvFq4y33v80urph8rFsE9HwdXrXTs4cajDmCnLb9rhMUU2gDtN7tpEj7Rm7P7o97MXEgkJDM+YZpc4l9WBku/PlAuSEtoN8C/UyL88jWGaT46gZ52lTd+TOy0fumqJAKZpEUWU3+6XDeVRXJv07dOOHF+VDFY7CYqhCWdGcHeG9y1yUERCKyEHVptCQpAJiVHkxyVEoje9xmk03IZcU73kJpAFdtth09AHT3ZZUOn2hU2LVL57f1MSJ5RTl0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhwVY7y1bG9It4IlggO1sX5H3wGNfypj5ulRtF2SJMo=;
 b=byt+ff5xvePhYF7v+NQnEU9Wvec35Nwm7ctC/ki4kohOzIKM+Rd4i4gO9ZQYIh98IUMUI/xdMQgAqlhnkU0NtIGF4UF8EFebtMbk+i0LOFHaAxs0GdcMpprvgOoTDPaDG5O9IE1QhI2moziGtA5/9COKdUEjW2y0JyDlW1wScT0vP2xaCsYX3Ygaw7mqov9Hv7nnnz7YYf7KKf/5xqAMWOzn27ZX0TbpYxNRC5Wh4/AcP20GebAc0N6GsGt1Jl5DvnV+/Mz05Kv0zl1crSWKHv8J5gxzSlSYgyqGcQJI5xxss9SV4FEA5/C3DCy5ruCeB59jQ8jb+QjK9UkE6rCS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhwVY7y1bG9It4IlggO1sX5H3wGNfypj5ulRtF2SJMo=;
 b=gr7sZN5r7roOmod4T+HEQA2NfN8XeCCOv/XvqIsQJj5KbztirQUxv4MlHYWZ8GUH+dChD3Ku8tacc8O3XIYoETDrBujrlm2BGxHtH0A7sfMHomk7CLq2Tb6P6GT1Mh78eukKtDcdtai6jEFpEjHJgRNd1LbHP8Djg0CKjau8oHc=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 18:48:53 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 18:48:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 2/4] radix tree test suite: Add __must_be_array() support
Thread-Topic: [PATCH 2/4] radix tree test suite: Add __must_be_array() support
Thread-Index: AQHXR190eoWyOuXiYUWELoogebyZ1Q==
Date:   Wed, 12 May 2021 18:48:52 +0000
Message-ID: <20210512184850.3526677-2-Liam.Howlett@Oracle.com>
References: <20210512184850.3526677-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210512184850.3526677-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62557113-ccb2-4250-06bb-08d915769723
x-ms-traffictypediagnostic: CO1PR10MB4785:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4785C3CA823285CE722C5D83FD529@CO1PR10MB4785.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1O6W0EOV35Wa/cLb5+d+1rLhy6R2nobH6x08C+ouiHONMfV6dRdMu62iKyM41PiaIz5iaoIs4kUMKNF1V96JXetJBv/jFt9GKkyR7uGJU+F4yN0ecysrns20p4jden+ggoXzU6lg+Ljb0h1+aWptmg+iqJZJHdZNNqhz35F9Jpbyt4ke9tMtdHAkl/Ilca2rTVvIcPZM6N2v+IvFje8JZUujbUwnzkQucjM4iUrIeGxsE4twLyMYiwBshFnLnWMtfd3MRA1ul1/dZ92uEyeFj0gmRC1B9nVK/fQ97+ECH7mt8Zkb6vrZ9lXLMRff41p2CnAcl1V16hulu3SPJXC8x7l0QUI1Ae8lntP0PBnXqs+igm7icAVB9+VoTK0cLabN0IhwY+chFZTP7jEbuIwaS6BCvHs3BeGoKTZZ7rqo5Z8TF987P/+gUH5nCfrBFcyQuzsgWEnVFa9lyjh5EUd5cEJte2r82Mn2YESJKf13MVyVFboKp/0DO7DoU0kDsGTzfSwyqZ+G9ak1jG5dJR9nK8kG42QNNKiAEBpC/wW0XV8ooucIa8Mux7OKGbX70qTy8Aato1LhbRDigtHiyS2LiLxVKZ7I4UtKkK1fvOU0r9Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(36756003)(107886003)(122000001)(4326008)(38100700002)(186003)(86362001)(71200400001)(8676002)(5660300002)(44832011)(4744005)(110136005)(2616005)(1076003)(8936002)(6486002)(2906002)(6512007)(66476007)(76116006)(66946007)(66556008)(91956017)(64756008)(26005)(478600001)(316002)(66446008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?IlEkD3ISGvodtjM8LXcsSnZW0NwdsfnPGZAQj1SAHC4idEvw+FEx0Tor8U?=
 =?iso-8859-1?Q?MJaDYY7nctYGdPGuExq6X0jVpwqksQgiptG8jA1y58x1L9jTrBh1Ppeenn?=
 =?iso-8859-1?Q?76UzD9VQXFC4Kayd4wjyU8rWJ7PWRf9gf5jS977zXM6XU1YsJIrLfURPSl?=
 =?iso-8859-1?Q?00XAj0mglegy6Gj1hsqRgxSb1vxXtRDSSXlWI1GlVeXtZOFGAI1lAJN8+6?=
 =?iso-8859-1?Q?jEtBUzUQaEwxOsY0cudUQV+N8/QooijWyeEMjH2HeM8PQsiLdAnQLeqrAp?=
 =?iso-8859-1?Q?CuKm4BVg0MfUcjFXE5AtxjqN7E0yUDMvGGzgsHDTSGbjdZe6Bw0gdm5jai?=
 =?iso-8859-1?Q?baQ7AbHCgAvsTbuczmHS3rFw34p4jyRTbIYSDMPSXdWtC8TBTfGBgVBZJ+?=
 =?iso-8859-1?Q?52DxrdVoj/jPaSDCoqupmones0YdYN4oCNjRItV51tVzdjkcXcJTOBPT7M?=
 =?iso-8859-1?Q?IMLv4dfHsC+CiLybr2CWIy7hQCLGRW0ie3EDv8eQHiGzLWvYtrj9BvC8IT?=
 =?iso-8859-1?Q?jHsSoOGCq/NvgfpmMspuXoJO8JFxjUnGJ2ZiRYrNJluvHHPqSVs+NcDmZW?=
 =?iso-8859-1?Q?hsZtae0csZoQBewGuJEzV+ugGu0sG3MC1NBWQFfQ8mvMp4sXg7MXXETSEw?=
 =?iso-8859-1?Q?bty0Q0nE+f9AeIzByF0QdIpB3nv9wv1jZIrx8q7WkGbDlUhigqogKFKWy6?=
 =?iso-8859-1?Q?A27YGTPPeNGdVjlXisL8I+92OXgf70z3M/zjXirFfTxbP746RxZYbf4A49?=
 =?iso-8859-1?Q?DnK4s1O5weRkAgOBH3dNBlCTo9xO77eVwign1I0RSaK9uP6MEmPr4J82M/?=
 =?iso-8859-1?Q?VEBB8Vx0H0kcif9AFV6yHFqiAKXH5rStLoFtpn+Mv2zj0gC4kSnVlIoHAY?=
 =?iso-8859-1?Q?VEegaPsH1dm5m56lSRDcM6mRKs1VwWzCDHRiK5D3nZRX3N+EDeBbMYZw/A?=
 =?iso-8859-1?Q?VZqhs6EjPzb5YwQr/eFsW2BCZUfWXjgPB2VvykCdgF/VusLyxn48T04jw8?=
 =?iso-8859-1?Q?XXxsysFdAueuDiORGB1iHNc2VvuXmQLk+ww1k2nbvgFQOKEe+dP9RX8w6J?=
 =?iso-8859-1?Q?WaVAY0ShDwtgZ51H9FCbCsbie+hvDrNLomNWs76267JZ9rP+R7fwOXj01r?=
 =?iso-8859-1?Q?9CAk2R8BwIDuue29rf3SRjaBDGzr/bL+nGaBgFnhW2lH049rewPyinqT98?=
 =?iso-8859-1?Q?KIY0u269/reEmzcHleGlHAxHpb2J7un0aXCfcdD806xcQo3vBkIbBwOuTL?=
 =?iso-8859-1?Q?sc4su0F7TWD7HD4PuLfRxjrID2TXvI1lozxpUMKnxc4ITwrJWqrDtrgwhk?=
 =?iso-8859-1?Q?5/AXy2Oop5vsc0moWXndaeytvinunE98sEnlXS9xJHStTV4L51cbzeeuCZ?=
 =?iso-8859-1?Q?QPvVTaEzXh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62557113-ccb2-4250-06bb-08d915769723
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 18:48:52.7778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NSKiddYiqtjFVTdOF8H5q+RWOJjTSp5PfWcVN7eEbBs7dLS8AE0LDIO2Pk3ELHoDn4e2LtK/cbrwZCD+trC2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120121
X-Proofpoint-GUID: cjS1dQCz5yOQcc3fa94S8Bxco6JQJH88
X-Proofpoint-ORIG-GUID: cjS1dQCz5yOQcc3fa94S8Bxco6JQJH88
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120121
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Copy __must_be_array() define from include/linux/compiler.h for use in
the radix tree test suite userspace compiles.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux/kernel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index c400a27e544a..2c3771fff2c0 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -30,4 +30,6 @@
 # define fallthrough                    do {} while (0)  /* fallthrough */
 #endif /* __has_attribute */
=20
+#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+
 #endif /* _KERNEL_H */
--=20
2.30.2
