Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E244957AD38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 03:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbiGTBgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 21:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241398AbiGTBga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:36:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BF28812A;
        Tue, 19 Jul 2022 18:26:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JKACxT002381;
        Wed, 20 Jul 2022 01:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NsgjzMz6RdcP99dsVtQPxT76NBseDGfsC7ZKtOM1JdA=;
 b=TGnTS0d8K0jFRD6oQQzIQonBQ6KojWRGhCYgmOFF3pG8/XQhP9s1UpUBZQfbog/wQJHL
 BT4/HduIa0qPnLtjBns3FhAl04YjEgSyUkuyivQb0QV14qVYhksTQe9Y1MudijNtcn1R
 S4+orvxaQfbqeZQlDpwNNHIAZ/RwKKxCtj0Z0hKA0alotdfPJ/caS35bu5IkVDgRdraj
 8gOdvWq0HCty/lrciFb2pSNrsixkMRELPrn+RdNN9kw2b8T98rhgQ71S1yi6ZVffhhby
 LZIqAsglF+3yHbTcU5b/cy5dElVKC4UDZBG6SKXep0J9HIf4qnauo5P/eKcLTcS0K0MV 1Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a7ynh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 01:26:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNoXEu002706;
        Wed, 20 Jul 2022 01:26:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbn6bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 01:26:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAzI2FCzzel03NTx11Cs2dNK6XCKY+/xNc2r2YLg4hoLevUANwSQOLrEvhuQFGG+xKAeDi74HprThKjpei0+PYaG2Yxok649jEnBKtnTgFsN5jAJiJ2KvmfWJpXIahuVEtK5l8jesQGe2unerhqfIzJh9nPrGe85tBlbfn7yFz2P5GL3QoCYCpMuBMzBRq9MFB2tkCRLaa6jG6qiaEXtumaIssYtFY/epWvpguRSKjH/oMDfDMqJUViSR2gaLBf+EgyrcI1Do0ZAot8xUutbCoL4as8snhQEXIIINLeqat19x9qp20Y4wv0ojYzmW9ynpokQq5WuP9J5lL1F32ERAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsgjzMz6RdcP99dsVtQPxT76NBseDGfsC7ZKtOM1JdA=;
 b=WzBRS7yk5W6++SxTkrVOCcN8As4r6rcClQoGT7/tpmGQIIob/T9ZMdDTszduG0XazLyUIi9TzTek1bo9xBW7G+S3dKFRRrTd628F5qcJCY44qonivbp9kqjcnkn0+Gq32PnVhRXwJVfrxhO+7/JCzNw++V3foDtnjOqvnRZm27+gJ9+WdtnMTq1uGu0awYIZmaYP1oV+tPHSz0Ib3PbUmThcqBLZgmXIrnHnpz7zUCgnw4AszYqFieU+TUaqPutQN5FRjx+kNMxXbd9Dz3AQLraIE4jOk7j1T/aWvm8izFam8qGy5l1y5SupGTNtXv+aSDHqZnj4Y8JH+AM0pXPe9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsgjzMz6RdcP99dsVtQPxT76NBseDGfsC7ZKtOM1JdA=;
 b=LBLs6A64wYqhd/BI3rCSDTl0nqd29rg7pZjySoTO3tqiGX4vQ96I8WuhYrMNjGwR0XbgPq1nAFUfITAH8pfiboaxrhBG8Osg2buL323hBsu+rm2okWTt1AYSCsXXnbSmrWr6kV4frZ9pvRWrrSt8vng+b2QvmyNApWts7diLiGs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6302.namprd10.prod.outlook.com (2603:10b6:a03:44e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Wed, 20 Jul
 2022 01:26:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 01:26:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Topic: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Index: AQHYmHrzYsqP79DW8UWdtY79IK5gxq1/y34AgAOLZACAAtl+AIAAIOUAgAAtKQA=
Date:   Wed, 20 Jul 2022 01:26:13 +0000
Message-ID: <CF981532-ADC0-43F9-A304-9760244A53D5@oracle.com>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
 <20220719224434.GL3600936@dread.disaster.area>
In-Reply-To: <20220719224434.GL3600936@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4eef12a-38a2-4cd3-569e-08da69eed579
x-ms-traffictypediagnostic: SJ0PR10MB6302:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 55imq3BZkoQ83vawzQ6pP6jgTsqj14vrLT6E5wlznJj7i0QEvwW5NQOp4UpmWOPB1qLMp3R+WmuYDMtC8nTk7uD9YQeTE417HUHQLYX+92pHyQfVGZ2N9+Sw4QCSPFXBGhjBSoUP8CfF1eMwXcWpNn1ts8cEzPWRBRbYXzUXvGeviodB3tHrJ0RYYWY0+qzYIo4igMIbWOP1IFvNMqYZ4tfOvm9te/93/NyOoAJisWobJHLk4+GYEDUTyI5QsyR6MPLMSjuMCjk5v/9GHMJcANh69wtMfeF5ZoBkfel0csP/q/Yj1It0SiUIx1bYug0LHZYuxQtz1pByO20hIqF0oAMlk7dMiNTOCvOvOBQCWhrp93ATXzlpKaFHRGmindJcIK/DeDiauiKjz5093BlaWiOMPRpdjDUZELag5sAZcx9T5qMaQEoQFe+yyHvCymbxJnLdMNG23TcVZwEGShKRGAsFpc1C6cacHgxRF3Na2bhXrFv3PbVpHsKJmKNtzzl7Mlgkre4gR46cG5zbDjAOgNPWlDJb/JkzxeIjr15HQ9RBShzcdFNTXZpXxgteTiEByWVAZEYG7zKU1CRcGfodLWcrDiZPU2L6JCqmQVrxUnCN0CV0WXAJNaV2T7l89j4jNIUhz/l7gG7p4pc0BC5Lt66/Nd8ZLuKpeEqY7YWXtgUbt/WBt5WVOYrMRhGe69dwivyRJy1x0kd7Y7NmuoXg4cxeEiv6S1jbvnj35p1C9P7FSOVndukRRlOqepvUrjOeECcmbHSCeREgEJO+mKXYrRJ+Y/AG6+uzlLXUyazLh2yoP9om57pxKFl6+7or49QHRO+dyXW1OrZ+07ChxmFmT6jGoUxHhDsI1x1+nfq5+Mn2ii3Eakqf7oL+zHiimYS73pLkbYluRK3VZYbsGMu+vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(39860400002)(376002)(5660300002)(2616005)(8936002)(4326008)(66946007)(66556008)(91956017)(316002)(66476007)(8676002)(122000001)(64756008)(33656002)(76116006)(38100700002)(36756003)(2906002)(6512007)(6486002)(38070700005)(478600001)(966005)(83380400001)(6506007)(41300700001)(53546011)(54906003)(66446008)(186003)(86362001)(6916009)(26005)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D02Fy0Y/X3bThhSNe6vkqcvquMAY15nWq5wPIMpRJgev1PZU/eaBmHbGPvH1?=
 =?us-ascii?Q?dfaOKFtGSXhh47cR+V3rVyhiNb5VblxsgE0uMBq2MBWxm06yiHIZXL3lS0Or?=
 =?us-ascii?Q?Q/KLuhEpqPAYaAqr901iSHxkNmZRrYhWGOSlE2n+jvkCaXhooxU2EJ6ZGjkv?=
 =?us-ascii?Q?pUk6OhL1K5Y7IdIQ6Xk7dtMUtqOpCk+iRxXC2r4/NZw97K5BGmqvdn7++A1r?=
 =?us-ascii?Q?PsVSkrxu/OjwygZTxxGRCu+aSuQq9slY+o9g0xjRgu5sDUCirYtUVSDhSEiG?=
 =?us-ascii?Q?H6O8KlAGQbHtyhkrmGaHOeVricTjfiO11IrGUxAA9PIUFg3GJz+FC1ur96y5?=
 =?us-ascii?Q?atJE26uWGVzpBwUfaFIu/X3mwZKe0CCgP2rEA3j0ipQayBiLkLR7ZZCECDkQ?=
 =?us-ascii?Q?2xpP8q5bW58+UEukAe6V4yUhdELHPXRDJpefT9QUYN/v04OrefJrq3HgOsOU?=
 =?us-ascii?Q?ZRXirFSQF8B0cv0rZtlxKSyBUweX7RjoHVdcczc1Z/ytmPyybeMdIJCCLGRN?=
 =?us-ascii?Q?ut/spsacUIqPOzS88kGiDkZm8J+2v6UYYuFRFU+EliWbMTdaJQBz/DMeZ/KO?=
 =?us-ascii?Q?Nis6X5uhHcQlo0fiOcYIYBxrSnOmxv7Xd3p+PoEMKVllqgCqgvaKv87XUP7c?=
 =?us-ascii?Q?NPUO2gglHSlR/E/mdVRQzrfQXQl7h7eWlUVCvsTssRgFFXOkx39SiSVABx+/?=
 =?us-ascii?Q?CZTJjV6NPlTchLqPeZ7pWvR+Ofa5hlZllvu32x7Ci423kZiugM/K+PItPXQ7?=
 =?us-ascii?Q?I1nSds4buTkm4oZ9dltLc+0QU3kOmr/oLwuVFp2GOFFnS8fDXJIgYflqFZ/p?=
 =?us-ascii?Q?oYTopVIGPx5P79lxhGRJROrI418pkZ10lx/ASXxLLmfopmqu4EIFA+kD+T13?=
 =?us-ascii?Q?KBoo6kcKvxKkIiOjHra3kF98ld4qllX6oxmy2sj0ENz+HfaKu4xWAe2z21iP?=
 =?us-ascii?Q?G5yIaYpn5urQVyq+eIegzCYY3KPdatur07gtAYkQFI97fcB71EqZa8Mozk6b?=
 =?us-ascii?Q?Cd3gqKRncwDGohp7p4d3+VIRpDGaRo66nnFPlWiY6UKiL7o8MCZ4TvKNNoQZ?=
 =?us-ascii?Q?dm5npBf9ZFowudCjGNbRc3I9NqauFOkQM9gsjjPj5GfJQuIyIJxXRv5JHCkJ?=
 =?us-ascii?Q?uHXdirXoS2xFECyGK20loWzdiWBKLeCbSsN/GzL2d9MAd6EavNC9AFESTrz2?=
 =?us-ascii?Q?BaJc9qywSfbjE+UtlPt5e3w17YaR0siUYtQm2Oy7VH/vTcOLSBzwOHztwA04?=
 =?us-ascii?Q?qZnBrdFdAUo4UYn5EQ0QoHtT1fpeTXN+npyIyj0funYjQU7NqN81Euve0FgJ?=
 =?us-ascii?Q?lkcyD6KO5PbwEcwE1ZFfRAok8sW9Tm2cruncZWTyVZsSN/EvRJQ/4NyynU2a?=
 =?us-ascii?Q?unT93PJpK3h6KQl8OgEa42XGPMRKSd/5bSjB6dKxRKwb65UgGjLg8ckuGOyl?=
 =?us-ascii?Q?XCOEIw6wLOgSooIbmNdrV1RKFGpQ/vtpD3vIXERQ5wta5o24L5d2+isWLrn2?=
 =?us-ascii?Q?73myKG5cpxdXCgE0oKhWNw5EieW9GL8zwUACphltWRGnHn9imZy/GmAZwGZ9?=
 =?us-ascii?Q?NIM30Du00T4chUVRFw2RDdnHyq5G14ngCgDKA/wjZTa4K3pIi3AdPxdhHMNn?=
 =?us-ascii?Q?rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66CDAB30CC8BE841983C69CD8A659C24@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4eef12a-38a2-4cd3-569e-08da69eed579
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 01:26:13.0509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETRYqtV12h1fcv4WCu2CFpAi75n872dR5KJutgJWoGy1KN+xNrcDRS5xEzq1AHw0oLHeZINH2UKVRnK292JCyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200003
X-Proofpoint-ORIG-GUID: qcQoEMLjrK8LaU1nXiU3vBVy-ZhH2FfD
X-Proofpoint-GUID: qcQoEMLjrK8LaU1nXiU3vBVy-ZhH2FfD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 19, 2022, at 6:44 PM, Dave Chinner <david@fromorbit.com> wrote:
>=20
> On Tue, Jul 19, 2022 at 04:46:50PM -0400, Anna Schumaker wrote:
>> On Sun, Jul 17, 2022 at 9:16 PM Dave Chinner <david@fromorbit.com> wrote=
:
>>>=20
>>> On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
>>>>> On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote:
>>>>>=20
>>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>=20
>>>>> Rather than relying on the underlying filesystem to tell us where hol=
e
>>>>> and data segments are through vfs_llseek(), let's instead do the hole
>>>>> compression ourselves. This has a few advantages over the old
>>>>> implementation:
>>>>>=20
>>>>> 1) A single call to the underlying filesystem through nfsd_readv() me=
ans
>>>>>  the file can't change from underneath us in the middle of encoding.
>>>=20
>>> Hi Anna,
>>>=20
>>> I'm assuming you mean the vfs_llseek(SEEK_HOLE) call at the start
>>> of nfsd4_encode_read_plus_data() that is used to trim the data that
>>> has already been read out of the file?
>>=20
>> There is also the vfs_llseek(SEEK_DATA) call at the start of
>> nfsd4_encode_read_plus_hole(). They are used to determine the length
>> of the current hole or data segment.
>>=20
>>>=20
>>> What's the problem with racing with a hole punch here? All it does
>>> is shorten the read data returned to match the new hole, so all it's
>>> doing is making the returned data "more correct".
>>=20
>> The problem is we call vfs_llseek() potentially many times when
>> encoding a single reply to READ_PLUS. nfsd4_encode_read_plus() has a
>> loop where we alternate between hole and data segments until we've
>> encoded the requested number of bytes. My attempts at locking the file
>> have resulted in a deadlock since vfs_llseek() also locks the file, so
>> the file could change from underneath us during each iteration of the
>> loop.
>=20
> So the problem being solved is that the current encoding is not
> atomic, rather than trying to avoid any computational overhead of
> multiple vfs_llseek calls (which are largely just the same extent
> lookups as we do during the read call)?

Reviewing [1] and [2] I don't find any remarks about atomicity
guarantees. If a client needs an uncontended view of a file's
data, it's expected to fence other accessors via a OPEN(deny)
or LOCK operation, or serialize the requests itself.


> The implementation just seems backwards to me - rather than reading
> data and then trying to work out where the holes are, I suspect it
> should be working out where the holes are and then reading the data.
> This is how the IO path in filesystems work, so it would seem like a
> no-brainer to try to leverage the infrastructure we already have to
> do that.
>=20
> The information is there and we have infrastructure that exposes it
> to the IO path, it's just *underneath* the page cache and the page
> cache destroys the information that it used to build the data it
> returns to the NFSD.
>=20
> IOWs, it seems to me that what READ_PLUS really wants is a "sparse
> read operation" from the filesystem rather than the current "read
> that fills holes with zeroes". i.e. a read operation that sets an
> iocb flag like RWF_SPARSE_READ to tell the filesystem to trim the
> read to just the ranges that contain data.
>=20
> That way the read populates the page cache over a single contiguous
> range of data and returns with the {offset, len} that spans the
> range that is read and mapped. The caller can then read that region
> out of the page cache and mark all the non-data regions as holes in
> whatever manner they need to.
>=20
> The iomap infrastructure that XFS and other filesystems use provide
> this exact "map only what contains data" capability - an iomap tells
> the page cache exactly what underlies the data range (hole, data,
> unwritten extents, etc) in an efficient manner, so it wouldn't be a
> huge stretch just to limit read IO ranges to those that contain only
> DATA extents.
>=20
> At this point READ_PLUS then just needs to iterate doing sparse
> reads and recording the ranges that return data as vector of some
> kind that is then passes to the encoding function to encode it as
> a sparse READ_PLUS data range....

The iomap approach seems sensible to me and covers the two basic
usage scenarios:

- Large sparse files, where we want to conserve both network
  bandwidth and client (and intermediate) cache occupancy.
  These are best served by exposing data and holes.

- Everyday files that are relatively small and generally will
  continue few, if any, holes. These are best served by using
  a splice read (where possible) -- that is, READ_PLUS in this
  case should work exactly like READ.

My impression of client implementations is that, a priori,
a client does not know whether a file contains holes or not,
but will probably always use READ_PLUS and let the server
make the choice for it.

Now how does the server make that choice? Is there an attribute
bit that indicates when a file should be treated as sparse? Can
we assume that immutable files (or compressed files) should
always be treated as sparse? Alternately, the server might use
the file's data : hole ratio.


--
Chuck Lever

[1] https://datatracker.ietf.org/doc/html/rfc7862#section-6

[2] https://datatracker.ietf.org/doc/html/rfc5661#section-18.22

