Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA5B578479
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 15:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiGRN4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 09:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiGRN4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:56:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC72E2613E;
        Mon, 18 Jul 2022 06:56:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IDZbqL002346;
        Mon, 18 Jul 2022 13:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RvS5hul98tCd4mNgpOJTIfV3bzlup0M44UU+HZy24CE=;
 b=DFDq36sEK0QD+vDBO21VljnF0i7ivIDNZRML5Qx7EZZgqkJzep+YhIQTZwIzSDcvBYnk
 2w8qX2Q6pZZIDGgUO4yUQn7aGtk2vI1cbiSos5c6nM9HDnla01WnajE8Rv76DYlipEgq
 ujxtgXqJ3VCPm0YLMQr4pYT9ZcVz0wnvwldUmgJJbfO3O4E2rBuWuA/TQoef9jWmz0uh
 bTi01/k0mJV/6ecqnBIbxLb5Mztu/woWqs4SWx7olW3ZcIcFhdjcnBoVwZr8z/vSsxlx
 oRgSvzbZC7AgC437fP7vmnKChIiEfeON7Eb8lUruLWOVURKZCkiJbKo4r4WTCEmc7ul1 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs3amn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:55:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26ICOOtZ007940;
        Mon, 18 Jul 2022 13:55:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ekm6f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:55:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxKut76m3plFvlS6drllRczO1M2lcnun5LFpnPpiOltsaReJeWHP6xgj6lRB+v5lmjzX6IYxi+GXmsbR0bH+56cmpq6alNIbZFIohjSHkH8LV9fxmnYtLSyh6rYV7vReou8nF/P0kK8olj47D2pkImMEUy2hg4BWxwnD7MkzsQqxBtESCwPNJnqQpNynCsUsM8v0uaXX4GLUWG9knZsI4K3ixYcL7kuXMzyWexATNH7oiKa14SARDEp2WUYKRJxmm07qgHxl3HZNi58xfAQD5VkdmhPyKa/huD4ZVQwf25U4VcJBGvKf8IbOaYBI0PDw4lbmE+1giPOzG8P6eTsi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvS5hul98tCd4mNgpOJTIfV3bzlup0M44UU+HZy24CE=;
 b=Qe65DxXYo6QnRCM6xHi4t9gqgMFAxblQk/T9DQmk6w/r/rbVw89sqQQ6yirjTJEFq7FXZrD4S/WU5dWg7f0XnGdXUFhgTXsehX1omVSMm8TAI6+Pi4PSPOFjvLW0rKsoJUM5VhVyz+6zVetm3D4fXDuOUU6LxYRc2HKtOOxuDzxiBKYnEod5LRgzKUA6IaG4g46HAQ7Ob2gdTjztrkDiffEjTeIhGlycwcNrgpVO8ctzRXAOXwhvb+0efN6VZH71GJ5LiqTib11pVwmNylHo7xukGws/3N0IW2/BTOTOG33c/lyfYc0Z9a8F4/JpY2DugZYjbLK8U7maEofAneKG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvS5hul98tCd4mNgpOJTIfV3bzlup0M44UU+HZy24CE=;
 b=zMlZihTtobeETVN2cFYLNZyxkW+12KkuLn1K6WlN/SpiqBG4reASRbRqRZVSuC+fjhPEdKyyrDJc+WFFQfVyI1rVpfEUJm69J48P0WIelAx0UY5ecuZdcOw060SbIxA2fYNV3buCZjKTIafnxGo+5kFSgVqpGzBb2MaL63KV4vE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3581.namprd10.prod.outlook.com (2603:10b6:208:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Mon, 18 Jul
 2022 13:55:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:55:22 +0000
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
Thread-Index: AQHYlyUDdSiWUfumoUGI7ehqsq7Up62Bw7eAgAJqAoA=
Date:   Mon, 18 Jul 2022 13:55:22 +0000
Message-ID: <20220718135515.vyuy6rozchf755hq@revolver>
References: <62cf77c3.3T/sxYUjJq0ImGp4%lkp@intel.com>
 <20220716180319.dcb09d8ce9519368695c1108@linux-foundation.org>
In-Reply-To: <20220716180319.dcb09d8ce9519368695c1108@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4211cfab-e53d-47e8-6c87-08da68c5288b
x-ms-traffictypediagnostic: MN2PR10MB3581:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0eeakOT8BXcpEA9l07jS+zUSpcwP/R2ECBmNZyoqb0L5Dyy2YGk/5fwH3d2fKPj+l0HhnLaNW7M9uyhWtF0JveRXCC1ShAf7nLSAZzZM2wvG6OPZOSlzK0JpsovN9puOyk7Btj6YIpRJ6Q5+SPFHoZCuTMFJIbtNqh9RyNBUjmVdNEzutDOMFDr4MqwWSjuWewz1hcMrY6DhLqkDJRQx2TSfv02qyzSdkY5WuNg1XGf7nTrpxoL+ghNZMiJ+chLGR62sCwGo8gskDb81gZhcctEhsV6goCYriw7WWpWdr72skH81ab0ojIq3KOw/KUG6ayMpcesBRlJHEWnn7e0MPeT9/T1cTUYJWUytv6BmvbvRvHaK4Ry0GuQ30vd2iMaPn/8Np0ZiiJDv8ZTrN0wMPsxmo0V30lNcevWE7mcPkHVTzIzOAcyfnf7us1G3SvSTdFi9HZGAtV9Qhuz7cn1SwdBhtNs7BMd5ibIWKmGiTDmd2fCznly4VWbJuMfeRk4tuMSJc+gu9i9d6fKawMedhNfU6EpGa8cOTTscg5w2PfTYGNZaKFgwEoUzW4Yo4YPFEn/ALi4dyzLa0ZvSHCsOf1OnPed/DagMWgL1SskcQG1QAJuruvlh5lY7hdv6LeBSc8rW2F+IJqG/TBTXO9hjE/9Y/EKw7sbgjy8SkhXyTvMOiBhJ6+ncHI4W6B6kYpehttQbdarBTW+8W2iNFvteGrBB55dh3IYjWbZhrm9roDmdolysAfBHGt0AVazXIiHEBQAO8k5IsI3abhiWBopsAOp1ynHHSH3a1OVr5ONltnFw4dd7ZdGxW1exRkFPxz4HxQEQjHv4wqyfLKv3dMb0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(366004)(136003)(376002)(39860400002)(86362001)(8936002)(8676002)(38100700002)(66476007)(4326008)(64756008)(66946007)(66446008)(66556008)(76116006)(91956017)(6506007)(6916009)(54906003)(316002)(38070700005)(26005)(6512007)(44832011)(83380400001)(41300700001)(33716001)(9686003)(1076003)(186003)(478600001)(71200400001)(7416002)(6486002)(2906002)(5660300002)(122000001)(98903001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t6WGEh5HneKUaN5BrFM2Wr1HAs5PZCD/bO0HjhXNoql5+WrrjT3KskRgBMNP?=
 =?us-ascii?Q?zgVCcJwxleU1HSmC0pPeJZZ4oTP6eIi1bU9TqibseqclkM8dkMae8kLjZvic?=
 =?us-ascii?Q?k+37RC6lhknU8l+yCAZDF2GBllQUcofXtnXtYL3qbiz8u7/hzkKCb83iBewE?=
 =?us-ascii?Q?eydtdRvdOgBJUcHWq3ZTQ7GaaCMPs+5lvA6PZZsbSM2G0Dt4qeRWpSgxmr5T?=
 =?us-ascii?Q?z+NLmtSRGSUtb52KIhD5xJKcAKxXwHUTZOtLqoUtmj4/6Fg4SkMtz0f3nuPw?=
 =?us-ascii?Q?ALCdVnwGObMEpWtxjlfB5jQcXoKbko4HtvxqMWzk5F6GeSZ5Mq8MpBuNcsdc?=
 =?us-ascii?Q?ovZBQ5sIsXhiHrtJOeyLGwCx+YsE+8BOsKUg+Ybr6ZPSBm1DdqHw/BRJ/0d5?=
 =?us-ascii?Q?t+D07YJjXrqgChYBcU4JdEhuFx+ueWPmpqYVYXeIsqWyj4DzGQrmf5IXaGtm?=
 =?us-ascii?Q?xQatyYd74q9TawOiAivlet/lx59cladOzW6UZnCeAZ2NmYd09wvZhdwKdPUs?=
 =?us-ascii?Q?DY9KF1W6Qd9dhtZ64/ayCTPRz5qPeTaxHko14DBbXsPKv2tc7p20W9X5XK7d?=
 =?us-ascii?Q?nPyRRn1HNn2B4j0toAmdmeS9wLa21o+McyGv8hvA7zeCFPSLPsraradCR1z0?=
 =?us-ascii?Q?QmKq/4vBPSE9XHhXUGQHgsuY4nR0IvKtPkvC5YhGvjeL6nCHftHuxa9e67g2?=
 =?us-ascii?Q?l8caDC+/zU2Z7vAqWbCzTNp/iEx/aVHoGXXEkH6Fyy6fqGuUbD4W/ktSsCBn?=
 =?us-ascii?Q?moFcQiDZ/O89eBGMie/2MPDvPfRc3gcRT8L72RMOniKrOrynzd+aVIilXSHE?=
 =?us-ascii?Q?N3ogJ3hGOzZgSWhXoJZ3zW1UKP167oBlC0r8Qw/EsPEBb079HQYCBCy+wSpQ?=
 =?us-ascii?Q?OsWg47EIGSz4DmoarFMIZLZSnOAPXmCVkxTZi/ix0fE0jWd+QXKRf4KM+ZF6?=
 =?us-ascii?Q?/Okp8/wRsAa5pCicFILanTDf9oBmg1jHDqJzaflzNAXaKDg1qsWVn2YKP8X8?=
 =?us-ascii?Q?La5DyPTR24W3lPDGjyOGEZtakQxwZlf6CCo4qhdpk2v/MeXA/ZCKMq4Fl5N3?=
 =?us-ascii?Q?9jp/dMhNmoMeHZYfME4vatruZlfnH44otHKLZIaY9ZeTM4dqMfbA4+rE5hLp?=
 =?us-ascii?Q?t44tVmuIgvkbZwbGU4aCAP1J6f4MDGpT/SjEfJseI3xXYZK4J/YXU6jmLFq3?=
 =?us-ascii?Q?xuZp7HWjPgUa58t9OGDpiIyBLATa89Q8qnvJ+ptvnfL3gXw/XGR0NCmJv1zN?=
 =?us-ascii?Q?vOzmhcjpIGXV2OX4X+pQ0QiAK2bwjP19YLw/BfHV63BId2vVwGb4LOrqqg1S?=
 =?us-ascii?Q?Bnr3S4CC3Xrljw/lTJSeaCBLhQW/oJseA/gu9+r1I3+rDyMiP24e2ciC5xm3?=
 =?us-ascii?Q?jT6U32+GmRCBfoNa0fWUcY06Q8RvFviTDQzAQ/WGQcyL64edKT/PK1eEwQY9?=
 =?us-ascii?Q?CZ+oF1yPTl7tHnj9VFGJZXAACC47GREUqZTnOfUdoCPeDMED+jndE4lwPTKi?=
 =?us-ascii?Q?KBkbg8sgwaiXPm1Oaw6tf8+XjRq36zExhx/bmkCGckKIiAGRRxpUWNx7bVR6?=
 =?us-ascii?Q?sU/P9ZufL0Pwj6/bggRjalD7u18aYmkzgh2/QPkS5NdKwC3IrhCxR0S9YGX9?=
 =?us-ascii?Q?lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B31AC944B775F44BA58FDEE1E7CA339D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4211cfab-e53d-47e8-6c87-08da68c5288b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 13:55:22.3949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlZwmy65Jkutb8OGo1ZyN9CgPFm4EiXee1SOWUNhWOYzSc1HJXXtYt0FMEBJQJ/2V3kf+4JakjwF2bCzcNrRUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_13,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180060
X-Proofpoint-GUID: 1cVo0n8fMlqeseSSBnE6rIrlqU4J4-8p
X-Proofpoint-ORIG-GUID: 1cVo0n8fMlqeseSSBnE6rIrlqU4J4-8p
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

I'm not sure where we stand with all that goings on here with an rc8 and
the concerns raised by Hugh, but I can produce a fix for these issues if
you'd like?
