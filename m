Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDCE577382
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jul 2022 04:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiGQC6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jul 2022 22:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGQC6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:58:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835E02678;
        Sat, 16 Jul 2022 19:58:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8rrI005737;
        Sun, 17 Jul 2022 02:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WpRIaDTL7WdDdW0+v0o2csFLFH7YzuYOXnZy6df9UwU=;
 b=xU7r3qrbjIID3dFXFoNvICmrKIykUSND5pihHOKf9kvgchsDAy3GDhnxUZmsFiCDbaiF
 NnxkP+EhecP3kVtVnU1ryMRjCfKxDxZynpPjGMEyKtBwZea7Jm0p1ZxCnfw81Xww998+
 SQ7LBm2/vfo3nIiGXXIQF3a1PL/AYPLWbJF7LfdTzb0JEIM9rDNxmsafQrY/2de4hL/U
 qNFezrKullCGjPnHP9KAUHqldxucZcRbFmpLGGRH/9twGeZDPAoMCU/5T9MsvzT0pRN4
 AzZDBl5Ycs7maA+4BZm+y0dyo+wXL/CwM25xXpDrXQXCyQL+cwM14Ql497GvJQp4u8hy fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:57:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMXfEF012235;
        Sun, 17 Jul 2022 02:57:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hq5p2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:57:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXNqRB5ncccwawJUjdYlM7/XxC1TildkeNfNGZFgTaxgGrdcrw2jGxwHTPNKjpl7qzexu7xNPG9BG8eRF5wUrk+nhaxL0TYJFLgleAvHli3N321Wu91XzlBluYgisoPz30sUivuUh8rxXsEK3XMABUG8zICF5KMhzfZ9TH8e5O8/5w8OD2ok1d98/re87g0mHoxhRZqZjsmnF/oOu7Wm30EsgxjC5/hBizCC3VyJnA74WtseHv4DuLu6r+R0OPBfWoedXMMQsr/CuHkpl9dDiXP6A9JKnunfPiCAZkRwXOtPfKPx/VGjwzpRdw5MZOiaV8V/f6cnz3T6iNqGsiUgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpRIaDTL7WdDdW0+v0o2csFLFH7YzuYOXnZy6df9UwU=;
 b=AsoZ/h7jUDiugLvnT+Mf73ffK6vCkNQEehmLNxwguw14YrKKEp3bP6L3WpWXDl7zkKKoUr8yIK5qUBANkG+GrZsNm9T24XlQ27Vf7DcpEj0iTcpVOnR9dNTXStF/Sr+U3dP4oeUjr6G4IrKKOfo2aq+tT8JUME3/EkrnqZcGrpycwgJQ9AO6tmMxz6avqWDfiawjU2kBbakpHes3bxFkWXW03FSHEEkry7S885yYVd2LmQWoM274X6ES5dowgWqQlp6naxrvPfyLgCf81vBUU8V0z9ufX2u6BHA5Cz20FNo8nwuoqAWFDuyFh/jAW+BqVCwM15qiZ0vB3oO3VuyR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpRIaDTL7WdDdW0+v0o2csFLFH7YzuYOXnZy6df9UwU=;
 b=TAK7s0/Fh0eMO0/sgpoVtwl6L/BJi2P1M6dKA9zbIxscEfiZy1RLS2++lMWJDv1SE6nOWEQSqgSPK5injFXsXsOERHTq6Ve0a3rdwWJhAK9PkP3LiKrVC/zpfsgk8jDaQPRlT/vAW5ot1jgMlbaCY1PAde8ZJLTe0bvdOzIZZ6o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2392.namprd10.prod.outlook.com (2603:10b6:910:43::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:57:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:57:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     kernel test robot <lkp@intel.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 4662b7adea50bb62e993a67f611f3be625d3df0d
Thread-Topic: [linux-next:master] BUILD REGRESSION
 4662b7adea50bb62e993a67f611f3be625d3df0d
Thread-Index: AQHYlyUDdSiWUfumoUGI7ehqsq7Up62Bw7eAgAAfx4A=
Date:   Sun, 17 Jul 2022 02:57:10 +0000
Message-ID: <20220717025703.pcrf6bseaigsq22r@revolver>
References: <62cf77c3.3T/sxYUjJq0ImGp4%lkp@intel.com>
 <20220716180319.dcb09d8ce9519368695c1108@linux-foundation.org>
In-Reply-To: <20220716180319.dcb09d8ce9519368695c1108@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b516d715-c6fe-4b0c-4700-08da67a00add
x-ms-traffictypediagnostic: CY4PR1001MB2392:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kJ2z+xk9pam4YGwI0qNGrTsvtpeFiCROPxbdD9JbfbFl4PcDZPnsc4PeYhsMKxaF0C33QJI3ku3i3qWagNMlnx7U9EUFGJWvkLHUynPtv3QPzdQddPR4xM7YeMaFw2r6B/V3ZfqNhHyhOyS9doFJ6qgQTX8K8wcEGtpwJzw4ENOBITv7zmkIswMKuTpNjNbjVXnK+vp3DdQxjwhzDyGYoIjv4elAAS5F6V6vEci9srpe365t0i0zdz1msDy9HthdQ/p36j2EFt416nViWNQZDBLOg/uZph4QnqOaIyHw62kGTO9iUhX83x1DHcKtAEGm8+8Eo6Ed2s/ycM5RdCfzFQ6wN7kNX8PNfxYonrc4YfGPNQfQhz+MYjo/UUWN2pSlrG85YMPoV6hcEByWkd+nFNFpp4otXZHi4u+o+rqUqi1jKd3x6b4PLE4FW1DH44uzHRJr/fg+eGmBlvZPnZO/6frcQuMqgGAWUId862evw++j193iWImDJtj71v6DrZuc9os3+Zd+FcVAktzSZpcCQ9+UUdQwWsNtEFKmAjbfFQCQcDcOKheEpv0Ok7c9dHLhtf1pJCKQ2YYb8ngG7Ls+VDjkx+I8jqxNizI9pHIKcNVRuo8cdEc0tXaEiOF8o0yXN//RvEwnwm9U5guGFXNnkVwsmwYLeDBsdRw0uUp/Usb+MFgtfOzZXZ4B74hFYZymsWH6qfeD6iTTOYiILe0X7M68Oo+i3r63POgSwhYIJ3F+59DBBwioUvQHVUjsXH/vcjG7KMr3gFxRE2mz2wPXpdmIRsc+2mV+wPxO/5vMbn7JtMSduxAC1iXj4zeSeSCuvTWoBt3pleuiwUhG36cisg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(136003)(39860400002)(396003)(376002)(8676002)(64756008)(66446008)(7416002)(66556008)(44832011)(4326008)(66476007)(5660300002)(38100700002)(8936002)(66946007)(33716001)(2906002)(122000001)(86362001)(38070700005)(91956017)(83380400001)(71200400001)(6486002)(478600001)(186003)(316002)(1076003)(76116006)(6512007)(54906003)(6916009)(9686003)(6506007)(41300700001)(26005)(98903001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W3Kc4kJ8sGFg4YQ5gom5K7Krq+jZrrW3KKk1mqTowr45IKLr5La3XLEPTwqr?=
 =?us-ascii?Q?xXizN9luv2HYDiktM4lKrQeeGxQnDjFxfUiIVik0RiXRgrhY/yLXNL8qtwjM?=
 =?us-ascii?Q?KYqlq+ukRyyC0L2AfwY0Ty/ItcX24418HmBD0Z6PU6nbUXHRXgmyF86U/sVu?=
 =?us-ascii?Q?FzbQTJHtI1sMpIHeJL/sNoQvevK5gzUCZxEM5roXH/RIbwUvt6B2UfYuLQRv?=
 =?us-ascii?Q?6ne7rfpCjzE5SvO6dziqtKjQ6aIOg+2NVJVh/iL6srbjYXx6zf5CGxRNJjjU?=
 =?us-ascii?Q?39MWfpEjR/E8F/91QuKOdKHhoF92HnT1DKlMTno/FojFLqfpNWEQbYdghXjT?=
 =?us-ascii?Q?I3mi5Zjl+jL4uKaiga3bEigKV7jkVG8yBCyzfQWMeyotm5gwE4zhaHC5BIfj?=
 =?us-ascii?Q?FS/9/sqqB+i3Wb4Kx/OMn4GNm+VCqyRFeMXXXFjjXT5eJ56EjsQT7ccW6MNq?=
 =?us-ascii?Q?IT5ew7QrLOemCvIOqrFziaB21WZKWsrsNCIDbAqmYlwqCvHdwnOjEJss7h7Y?=
 =?us-ascii?Q?cpGcpKKr3viz2Oo+5140OpDuCLE0jT2K2c9HSXUmxvDIL1UWyB34JSnAnbc3?=
 =?us-ascii?Q?nVpo7fYKTAW4dFrE/eXCfggi7SsrhbkVgS9RezofqanM0STENldwdynW364w?=
 =?us-ascii?Q?CoLr3e2T+Ko+OWpFjqJkTGv6kREAJuo1QOnkViWsy2p/aoiSQE6xk2n8C/ic?=
 =?us-ascii?Q?rGC/7eOnr/ObN7OxiQpXbD4hJl/QbWShCO6wfhLCddEcEuvRElv2BXyB1Vk5?=
 =?us-ascii?Q?InbsMCwaBxW1Li6zE67wVW01qI0kVlJsy/xe6GKzhKts7V2X3mb1Ykq77oka?=
 =?us-ascii?Q?CT4l9JLxc87AXbpg4KLM93hRGnaWcXoRMzwIWI0ghMay4Coptlp56MedpHEF?=
 =?us-ascii?Q?SltPYAb8njYLsukTqrJCyb9BBjfBNKin0siKJEAxNM33qs2u6vtLELWXn4p/?=
 =?us-ascii?Q?hs8xOBtsGjAeITrzPzWQ1VceykMgnT0gXtlLdpj5MFpeIpf2+oP8KIs1NSl2?=
 =?us-ascii?Q?jaoDgBDgS1DjAF2JUvoZQfCnp781gMXKPP0Jkha5VFxfykphWzq+/tluwj+O?=
 =?us-ascii?Q?sQ98CRgReGkqa6Yf8JFodbcs06zGgxDrhm9N9I5kyN4sC3USyTa0aCDPHOno?=
 =?us-ascii?Q?1g9+TN9VYtZ7fESx4S4i8OY3XFKgChCZZhM7KUqy+5S24hr9qv43juMl1BuE?=
 =?us-ascii?Q?omEeGaefO6vZt1mliHr9Faunqoj4uBtf1Ll5GWHX8EghvCitfHCuoVHVcMla?=
 =?us-ascii?Q?USXcrSYOVPF6u8sf2JjaVPR7V1BFD6FGWNQQbspLWKe6paHgF5SJevjclv87?=
 =?us-ascii?Q?ulIL650U8nZsHAVmkHuzU2gpccdmYmTTAhtd8rVG/DAyt/vVHlVthCIGJ8y5?=
 =?us-ascii?Q?SUVrYJcmqOERS/hU1CCmWleMsXoVHMM6VDcm3hYdSEbfNP+mtKr499Uw2K9F?=
 =?us-ascii?Q?+llp289+ZHvlfPGjdEAMQbS/P4EgXgEzAjNE4iOlpEiyKvs+pbZZBUI8Hwp+?=
 =?us-ascii?Q?eJ0+nQk6UjagTUgguRX4yxSwVe97egPtk3ntK6SoHNMudA4m+f7W9qKc8ktL?=
 =?us-ascii?Q?JoDBdWVErsZwmLeyAdGboy8z3ZtLxZ2sNBcQPXFoLlTAOw8tVXL3SSSuxjmE?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <572655C75669F94180B10D0E29F0611D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b516d715-c6fe-4b0c-4700-08da67a00add
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:57:10.0423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4kh0MsSnG1NtI0AtvqBSFdvLYPvEZHwPCXjSuYopZA64sFdgeC++i9i73L7KW6YrnxuYx458LMXZoj66LVXHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170011
X-Proofpoint-ORIG-GUID: Ehx6OR2scH8w4c4u33Au8X904hk0spbz
X-Proofpoint-GUID: Ehx6OR2scH8w4c4u33Au8X904hk0spbz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220716 21:03]:
> On Thu, 14 Jul 2022 09:56:19 +0800 kernel test robot <lkp@intel.com> wrot=
e:
>=20
> > lib/maple_tree.c:1522:52: warning: Parameter 'gaps' can be declared wit=
h const [constParameter]
> > lib/maple_tree.c:1871:21: warning: Array index 'split' is used before l=
imits check. [arrayIndexThenCheck]
> > lib/maple_tree.c:2033:55: warning: Parameter 'mas' can be declared with=
 const [constParameter]
> > lib/maple_tree.c:2426:8: warning: Redundant initialization for 'r_tmp'.=
 The initialized value is overwritten before it is read. [redundantInitiali=
zation]
> > lib/maple_tree.c:2427:8: warning: Redundant initialization for 'l_tmp'.=
 The initialized value is overwritten before it is read. [redundantInitiali=
zation]
> > lib/maple_tree.c:3160:22: warning: Found suspicious operator ',' [const=
Statement]
> > lib/maple_tree.c:3208:11: warning: Size of pointer 'pivs' used instead =
of size of its data. [pointerSize]
> > lib/maple_tree.c:326:2: warning: Assignment of function parameter has n=
o effect outside the function. Did you forget dereferencing it? [uselessAss=
ignmentPtrArg]
> > lib/maple_tree.c:4266:15: warning: The if condition is the same as the =
previous if condition [duplicateCondition]
> > lib/maple_tree.c:4302:23: warning: Boolean result is used in bitwise op=
eration. Clarify expression with parentheses. [clarifyCondition]
> > lib/maple_tree.c:694:59: warning: Parameter 'pivots' can be declared wi=
th const [constParameter]
> > lib/test_printf.c:415:11: warning: Local variable 'addr' shadows outer =
function [shadowFunction]
> > mm/highmem.c:737:13: warning: Uninitialized variable: pam->page [uninit=
var]
> > mm/migrate.c:355:53: warning: Parameter 'mapping' can be declared with =
const [constParameter]
> > mm/migrate.c:875:7: warning: Redundant initialization for 'rc'. The ini=
tialized value is overwritten before it is read. [redundantInitialization]
> > mm/mlock.c:230:20: warning: Using pointer that is a temporary. [danglin=
gTemporaryLifetime]
> > mm/slab.c:1635:24: warning: Uninitialized variables: slab.__page_flags,=
 slab.__unused_1, slab.freelist, slab.units, slab.__unused_2, slab.__page_r=
efcount [uninitvar]
> > mm/slab.c:3289:7: warning: Redundant assignment of 'objp' to itself. [s=
elfAssignment]
> > mm/slab.c:3509:8: warning: Redundant assignment of 'p[i]' to itself. [s=
elfAssignment]
> > mm/slab.c:405:9: warning: Local variable 'slab_size' shadows outer func=
tion [shadowFunction]
> > mm/vmstat.c:1409:53: warning: Parameter 'pos' can be declared with cons=
t [constParameter]
> > mm/vmstat.c:1650:68: warning: Parameter 'zone' can be declared with con=
st [constParameter]
> > mm/zsmalloc.c:2019:15: warning: Uninitialized variables: zspage.huge, z=
spage.fullness, zspage.class, zspage.isolated, zspage.magic, zspage.inuse, =
zspage.freeobj, zspage.first_page, zspage.lock [uninitvar]
> > mm/zsmalloc.c:2060:16: warning: Local variable 'obj_allocated' shadows =
outer function [shadowFunction]
>=20
> urgh, thanks, lots of stuff to go through here.
>=20
> Liam, I suggest we worry about the mapletree things at a later time ;)

Thanks.  I'll dig into them on top of v11, which I just sent out.
