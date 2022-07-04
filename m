Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14209565CB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 19:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiGDRRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 13:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiGDRRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:17:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F408FE030;
        Mon,  4 Jul 2022 10:17:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264H5Zxd001918;
        Mon, 4 Jul 2022 17:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9XAJBpbVy4wm2f8VlgV99EczSS8qn597uJ0PPZLJJBA=;
 b=EhmkKjwVTbM4CE7F3Sc68zhAQ4wApT4n9bZsVg8rmj0l4fvMMD8Sel2pRMKX0nusoHkB
 Zgnlj8XAJSx7QdHK8FffW2a7Gej6WZqVFAi9U8ZkyMOOiZcVXeg//vaB66hMyK8EO3NR
 gW6+GBkkOf/AGXfuGeMIBwpYbaFfft3VTwDogu/Yqi2ccft7O8N6LunmLJ8Zccs68KNI
 ZIEhePnXf7uHM7W7oGv706h6lkNdvgEH332hUHvF1XvSalVtN9/6Lj+22XLpjhgywWU9
 R/u7T0phGFX4BbTH8NLycPplRKfoIU7x6fOKz7p6WZHKlg5CuWuFYdyiCUQ8nxT+WS8t 6g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2cecbxgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 17:17:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264HBn51027543;
        Mon, 4 Jul 2022 17:17:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h2cf1r7ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 17:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzD/SgME874DdmGI1UfUh1NuCzzYcOuqIsV8rLe1NBEBirdAG5QL9/vD/aZJEhgo3/qZxIhUe0YDk4f0OF0lNEEZiT93S/7zmRbMqOz9dA7x+TxBBhaN+vM+BSYpNONXxowz9f5pSOJD58Oy+9slY0zbhSjFjQQ94Rqu8wjmUXVd6laQHUm6Fg1lc4fTq+8ZAUUGjxqt9IpZse74NHahge+fVVP98LrjzZav5WHvu4/+lK5yzA6oq5vUwmB3V/TI2vU43iRyZ3S4u7ecX3hHYb+dE2lge3I66RtCQvj8hi0wSIzcKwxlZ+xkB8oAs6PDXssh5TNFfcaEwbiLocUfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XAJBpbVy4wm2f8VlgV99EczSS8qn597uJ0PPZLJJBA=;
 b=K8jvQlIF29fteGNzlCKznaENyuU1DIv5gyzNE89/uqYRTQyU/NFkcnfm+lMEutnfTriyQjVOgrMe3w/KnFnoQ8oWClyVC/TZn1Cmf9PNiDl6dMIpJg+2OT5ZoA2ZRVkxdEOJITlg/YEw1XeSsDYgqYzmB1rQn+tViW1z6xPFrrfjGCqYh6ot4rKbNKPsu7XooV9M8fIh4Gdz2hcVdtNYAduCR1SBCo08o/FMJZ93b3KsKaoNAJlF9MDO6Hht7krI7NV9at62tcCJbOW6yiINuxH5Qz0ZHo4oU3hgfKADNcuyFtr7uW5vqI1thNW9OZS1ZJKEiEkoNnuamyAbZD3+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XAJBpbVy4wm2f8VlgV99EczSS8qn597uJ0PPZLJJBA=;
 b=rYzTZ/GtXol2hzhPErxL5GYGgZqXlv5z5Zda+NwAJzkRUcUbiXwvyCQMP73UMuy0tZDNfYsR4g9+gQaGSXmHo0Fg1Yxr+bLYAdA5gYMDSpl/9CQo+LRk5cTl01/Q9KgwyZ4qSSyhzEcVM3p7BF7MAIVdfiiqiY5Y9ctpu3vJE0U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 17:17:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 17:17:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/12] nfsd: allow parallel creates from nfsd
Thread-Topic: [PATCH 08/12] nfsd: allow parallel creates from nfsd
Thread-Index: AQHYf3xEYb3JC5iP2UakViwbS7bjd61lf+CAgAAJfQCACQt7AA==
Date:   Mon, 4 Jul 2022 17:17:16 +0000
Message-ID: <0A08512F-E081-4451-976F-498611D9365E@oracle.com>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
 <165516230200.21248.15108802355330895562.stgit@noble.brown>
 <CF45DA56-C7C7-434C-A985-A0FE08703F8D@oracle.com>
 <165645779028.15378.2009203210771986783@noble.neil.brown.name>
In-Reply-To: <165645779028.15378.2009203210771986783@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6e513d0-4b59-4031-0fc3-08da5de10b8f
x-ms-traffictypediagnostic: CY5PR10MB6216:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tql629GEcLxdfnjKVlBso/RWuKT6GY6faWE/SNvFqJSAdndqLR11HbK3BjVDwnMP5QpQueQprzCgDrDCTUJejH4MpauuTPsiSe0GIirf8ztdk9yBxPK80GqQY9h9e+UZpskSwmo4065FVVsgfiSBbi8djjp0K6hbvvBf0NQBmgStM8P1gjPnD8lw26xU0kLL9MNS7AuhiKO5qcdreq1LytGCAcpLkaQ/oJOiyuMh+PCT1J7y/F7j8YvDPgdM+qVKMIOaf8QUP91M20LKuHRnlzGsLubvJIUVxMvbE7hbg39Dp+2YUQKN/nJio3rItD/xNo8wLY5tDeeNnagprMtsiwuhlW/z8u4E0JEuWsS+fUtqlzo77sR84oA6RV9fa29ooh4tIUeH9KuggxVIK/bDZS4fBoIQoxfZwsdaiq9fjLxPoISodlpBByb3kx0bwGLCXDileXQ39mPlVZ71DBhTIRVnXRMyp4twxoZBIOPPSeOjZPsAcvWSamTGEpNRN80qMauedDxrPurJQ/O25Vq5D6wl0rjw2a3Jf/z+l7zG6yD70W/5Tfih6dd0PEatAdfSmgg62vJMU5PeaJa3f3tc5y6Q1ViQ/CtuWeVfUfmSQeDMDqEDDDde5xFqV2sTIPGPHYZHrOWqswh1Lkin1C1Xp20bnKND8oU97t8QBGp3vZweOwgr0b4IAry3zW8xk+QP5Edfo8AT9fZRGs29whcTQQLSQOYrv2Txt/TzpMnQtv4aOP9k23LdJvYrbUNvzk7FuMnmuQeoyr11X7ByHM7TgSlsxA+dMxYTpFy/elzIUbxsvJY7wnkM7MAV2P3RfeTLmmoApr2/Wljynn5DxaurAdbzKWHTlmiUiO+B1CUnSkzdon1NUZRee3QW3trSwRLm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(396003)(376002)(366004)(38100700002)(54906003)(966005)(91956017)(6486002)(8676002)(2616005)(76116006)(66476007)(6916009)(186003)(38070700005)(86362001)(316002)(36756003)(66446008)(66556008)(26005)(64756008)(66946007)(6506007)(71200400001)(2906002)(5660300002)(41300700001)(83380400001)(53546011)(122000001)(8936002)(33656002)(478600001)(4326008)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C/N2v4xUWW/a0OkMoOldcXN5k5Uvd2cJiiP7h9w0KJFy6Lt2Ltz+t/4+lqvV?=
 =?us-ascii?Q?YXDZwgscWfvigA4aBwZyDbbDsWhrQN435+EcjNPB8RmSjY0iTpZfZM0Knkyn?=
 =?us-ascii?Q?S3jt3VzmGZafQGAKvEJjD1UeNbXg2grxRksMJpQJJAjPaTN+pQrFDpTlt+Sd?=
 =?us-ascii?Q?3LPTCwKf9DLYcvsYuVfOVSK9oPh1aAFxXu2hY0zlL7n9GZ1sbXaPvWw+tSz9?=
 =?us-ascii?Q?gPmCa4q5oBgmPCflepQ1X8ikzqrRMf5NxQ9Ku7Du40YUb+Fe0v2xLbNL0XAE?=
 =?us-ascii?Q?71DEZfbZlfcF7RJ/nDt3PkIkYk9t0mOFgcQmY3c4jM08dj2DCpOsCyiPubdX?=
 =?us-ascii?Q?5V6+h4ZBglWaKRpTdgK4X2Bsarfe31z64IMw/exDESEvvG/HSk+ZkU9AGpcC?=
 =?us-ascii?Q?SHXe0IpdUm2N7uhL87rrb8AJFlPgNG3fIB1nibLmIH6nBap4q24jIzCd7yas?=
 =?us-ascii?Q?PlRx4JHUaCcJKhxSjMpnwal39x3rB9NmKYnAmzDfVBvISfpwGEp/K0SkCkir?=
 =?us-ascii?Q?VAagZJb6a+8ZA8JmuvQfTxEqH+7/CIv6TSA/hMapmkkAtcskIYG0Cj+R7eZX?=
 =?us-ascii?Q?4MdNntvYXmEtLvGiiuIuvks5NKgS1yPAUyCbYaAYaD22lE5OP4NPVq0W3Aa5?=
 =?us-ascii?Q?rI1P2Nt3dUIUqvjgOB4ZSWZtXmfe+jeQwpGiZvxy1bM95K7olc3xTUZXrErb?=
 =?us-ascii?Q?kXaaABEp/mIwwbfIWpLPzU11xEUyOE8GehPSWOMlt4Bkl03KTkfZCjohrXM3?=
 =?us-ascii?Q?n/RIUBR+MEFxqaKQTFBzevNHm9VexIduaK5kkvFkuTG+3wSYcb9GDzdgYM5j?=
 =?us-ascii?Q?LtnxCxVA3Uw15NDnuRvMZNzwb0SbTZHhuN9czC+q90ph24wxrVuFFeePzJGB?=
 =?us-ascii?Q?gTorhCpusITTyQWcbNeRkyO/a84GTQv7T+CRg7siY0BVTHU2bwEbr7o9QAiX?=
 =?us-ascii?Q?yhaIxhra966+13K6/bRxBWXlJHO+6inBmpLUXkc2cZJ4Z6x4tnhVYwAi4M6S?=
 =?us-ascii?Q?qf5vjWje7Xa8vg7XFkN8ZR6pdFUC+IktfnhaGFFrdvSOsWJm3En2/O9R5/vz?=
 =?us-ascii?Q?pV2sjRwnF2n99mVyLaUYU9t1b6CHQOrQ39JfW95XOM7zPSTUTPfcbQcV1Q5V?=
 =?us-ascii?Q?3QlQyYQYGMRnonNdYCvl0rDYBNd83vlqyNe7qVgWUF43cGpw2h2ZiXcw33sd?=
 =?us-ascii?Q?Koc2wy0Jgrpr+X9fbLuqGVuTxehQdlKhviAr9FNjiAPoVYJ2fh0LRo6gYWYu?=
 =?us-ascii?Q?J2KT2VyifZZKorRYGqIX8ISSPVne/I7AgcG6EgzT7DbKhofoWvuy9MGZGzpz?=
 =?us-ascii?Q?lFRYK0NEx6Nzrt4kwfZxwCHrcw/4bvKcaPMoFle412Rp0aUeFOHdvTAANjdO?=
 =?us-ascii?Q?+qBqoHoiyeW/kUuXLDmBp5/YWwE9dKnLPN+RcLSL74Ozl2oaaj9FPMXIvmsH?=
 =?us-ascii?Q?jrja1J1wxdhyT1qdnOHYsZYWhke3iNsm2H/Fimq8CDTkjKe3dBDlxAdPjfPs?=
 =?us-ascii?Q?QjMaGfMPiJ4Q1nBCUjt3TiRGLmrpWT+pmEVv9sl177bGZiZs22YSYMx2MUB2?=
 =?us-ascii?Q?5x7+vBVK8uosexlsb+60cCqIck+T7+9JtFz7CCuA8Y4Clq4drDe722DlYUpR?=
 =?us-ascii?Q?mQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E6A8D2A7577D54F81BEFA31A45EDDBF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e513d0-4b59-4031-0fc3-08da5de10b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 17:17:16.9140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjKLJi6AifKMeEfKCTBXoeT6RN6dAbdUwmxmo9SFKzxhPze8SUD5cdn2nTjNIyotIWnGy32ZOWCywFELSjzgyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6216
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-04_16:2022-06-28,2022-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207040075
X-Proofpoint-GUID: Qyh3khehpj7vfKIin_X7SaMh_kxRuxuq
X-Proofpoint-ORIG-GUID: Qyh3khehpj7vfKIin_X7SaMh_kxRuxuq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 28, 2022, at 7:09 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 29 Jun 2022, Chuck Lever III wrote:
>>=20
>>> On Jun 13, 2022, at 7:18 PM, NeilBrown <neilb@suse.de> wrote:
>>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>>> index c29baa03dfaf..a50db688c60d 100644
>>> --- a/fs/nfsd/nfsfh.c
>>> +++ b/fs/nfsd/nfsfh.c
>>> @@ -616,7 +616,7 @@ fh_update(struct svc_fh *fhp)
>>> * @fhp: file handle to be updated
>>> *
>>> */
>>> -void fh_fill_pre_attrs(struct svc_fh *fhp)
>>> +void fh_fill_pre_attrs(struct svc_fh *fhp, bool atomic)
>>=20
>> Hi Neil, just noticed this:
>>=20
>>  CC [M]  fs/nfsd/nfsfh.o
>>  CHECK   /home/cel/src/linux/linux/fs/nfsd/nfsfh.c
>> /home/cel/src/linux/linux/fs/nfsd/nfsfh.c:621: warning: Function paramet=
er or member 'atomic' not described in 'fh_fill_pre_attrs'
>=20
> Thanks.  I"ll address that, and also the other issues that you raised in
> your patch-by-patch review.  Thanks for those.
>=20
>>=20
>> And... do you intend to repost this series with the supplemental
>> fixes applied?
>=20
> I've been a bit distracted this week, but my current plan is to
> reorganise the patches to put as many of the NFS and NFSD patches as
> possible before the VFS patches.  There should then just be one each for
> NFS and NFSD after the VFS changes.  I hope to post that series early
> next week.
>=20
>>=20
>> Should we come up with a plan to merge these during the next
>> window, or do you feel more work is needed?
>=20
> I think it would be reasonable to merge the preliminary NFS and NFSD
> patches in the next window.  I'd really like to hear from Al before
> pushing the rest too hard.  Probably after rc1 I'll post the remainder
> of the series and include Linus if we haven't heard from Al.  I'd be
> perfectly happy if the main content of the series landed in the
> subsequent merge window.

Please base your patches on the "for-next" branch in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Thanks!


--
Chuck Lever



