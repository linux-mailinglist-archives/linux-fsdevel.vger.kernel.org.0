Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DAF57AFCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 06:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiGTESz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 00:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGTESx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:18:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D56E2F2;
        Tue, 19 Jul 2022 21:18:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1CrBu015098;
        Wed, 20 Jul 2022 04:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eyMuPg+VB13hOOnpTH+4XMWui5HzmjVpfrgIbOeiLWM=;
 b=wKWXVZEEVFRZKIhSzGanJoywLUT/lNwybY067x23TJjeIobXuYBl+x4Af2JRQxerEnVP
 M1Lspc622R9+dRH95urvoUXWKNALYDpJp4oJAynGPt78RyNmniKWkBOmQkQ++Is14j1g
 xDHqO7WpqehaUsm4u1jVsaRDYX8c+L6AZhhc194T8UtgL8XfdMm6eCpqO0cKXtqY69Nc
 t0DSLSdqLXkIAR2BzUr/AIomKy1ED1txX8WEMhwDuEpZZHFSAgBKfK9fNoacIvovsU5C
 3b8NsXpXq+AmBY0lx4ivM/UueU6Bol1nY1OAJ2WfRmMwOhnomrwfrw5+s+rd7vb0CkYH uQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42g914-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 04:18:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K3kp5M039172;
        Wed, 20 Jul 2022 04:18:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k5arvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 04:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVAmEfcj62qov1Ou+xiFMTa4AshW1OKPvIGnpBNpXKwU6RMAM7QkA+p2bueqAcZHEr5jA062XWyWMJf7UKiDGI+Jl0eYvSHB6z6GKjFZUVMTlJf8n9Fjf2nDlnPPWcywXUywW4qyh6HqFwKcStGHUdoFW3+dbROUnGYvFFlgZJW8ylPLyhlmtZaP4I5IqfqXw19f3c3qA+eUsGCGaqYbV6OJa8SUR0APsp/RcODbnZR86Yhv9ifCBlUXgPkPLkTnsCT2uFIheZ3w3tonX1Aa+5eTNy5mbaqUE72Qclpv4WlQwyRYeQQViPc8hBw5bUPhh1r3DQD6sboYwPwwk9+K5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyMuPg+VB13hOOnpTH+4XMWui5HzmjVpfrgIbOeiLWM=;
 b=ZJtsjRnwyrxjZa7B97QqzJ1wBCmPGpPxjh6faIb7TUZ6QHcghElPkCwWm7Udn26KTx4Dc5KKl2PaWmk80V0PLnR8ALIriX1jpBI6d7h3LJUmS8t9xhx4AQ/B6P7ALIDJxIBrukp/gYizulvLgomvn+iZvCAKmHMVDFUI6WSU7hiOMrrSvQQBl+zWPb8nQyQSwNVcYDznNwoSeDkq2gBT8pXri1bqRBLkVvlXNDTEbcvrasuRyZd2k9FW/3MoKuhi/l/ZQA4bEgJgHHOg4HV3xQA27w94xZU7qdjKxQa31KMFneMrsz7k7RIisyme8rQbo4EGuPIy04yPq/1cxM1h5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyMuPg+VB13hOOnpTH+4XMWui5HzmjVpfrgIbOeiLWM=;
 b=FX45Q1LN3K50r2043KSW6hbHyDUENQb2rlOnTcYDvt36tZd1h/oqMUtDtYLgJvUmLrbui3GJZsnrH+J8nZMaRzy76yAmBCCxsPtehr2FXYQod+QL3wsbfuDyo9Uq+gLQMsqrbKXAVJGjbwg0TqPo3hgCgTHsasVQrmWOA7TMNQw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4423.namprd10.prod.outlook.com (2603:10b6:510:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Wed, 20 Jul
 2022 04:18:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 04:18:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Topic: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Index: AQHYmHrzYsqP79DW8UWdtY79IK5gxq1/y34AgAOLZACAAtl+AIAAIOUAgAAtKQCAABONAIAAHJ4A
Date:   Wed, 20 Jul 2022 04:18:36 +0000
Message-ID: <CD3CE5B3-1FB7-473A-8D45-EDF3704F10D7@oracle.com>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
 <20220719224434.GL3600936@dread.disaster.area>
 <CF981532-ADC0-43F9-A304-9760244A53D5@oracle.com>
 <20220720023610.GN3600936@dread.disaster.area>
In-Reply-To: <20220720023610.GN3600936@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2877f04-9c35-465f-e92b-08da6a06eadc
x-ms-traffictypediagnostic: PH0PR10MB4423:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qfmjnFXa5OsbrqtiCHM8T7DSFTJ5E7FSswDqFWFHKEFrvydNy8KzO8w8+AT4zgHysOYQO6Q/rp8phakX5aW2XuPOxbPCySrqrOzZJx/C4Gio2hFam5jUdZOBgzcMFRbM4GS6N3/FoLcs+4wDwKaOWLTO2rDqtvkuW922fU05tuVhu6dwk47mGWNt1XS7WSMn0QxiUadq2bRODeOlcfHx42ZjdtLGgHkEVIe2s4KaYDDJG18ZC6SWKgM4XPx5wquxBvFUT6JjPPEsLziqId0Kjy6fCn6asjWA8HrsY22JwecggPiukJtUTS0iRzhyN+jnZieCveQKrf8KEcbaBAHyR2LamneAmv0z6fj0SnhGWhIBG7KGnRkAh7qKHLtDC96piI6LzPH8rVb5BKBPAF8nR9J/l89vnf8LfHAfj98563/ksOaQrhb1HY/kGX0cuMr7QsV8oepbgA1YDWlstvkDT1Zd8WE4bSYgxOzyZRPFKJ45WDKW3Z4KnbTmlZ71YEHFZYeX7DzxbnnPXxoRD8IMRI4b69EZgaS3tdUdOR3x57GdQ2k6oE4dSin4QD3eBkOsWRzktWZ9Mci5RK3Pp0eHFv4Gfy56OjM/65+HdZWzCkrMdCfVFmTpuVfl5VBv5FdmYOz4ydQ34bKFVkmgj7N/0h5fGm3mqv6TKbNBe+VOY/W1VmffcRct50aq5hNNOOmOJT9jxKAKY3+v0eR90KtOv+7xZhN2cMz15HylMiKl2RtrWLjVgUpVEN3RhlKj+IjKpY6srGaaMpDkxFTl2Sl0qiY0nRPM3EnyDEi/IaIf60IGT28xHEShHfkGWV9ZdeVj70MjpNLDPKqJK/3+f3gGtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(396003)(366004)(346002)(4326008)(41300700001)(91956017)(6486002)(66946007)(478600001)(186003)(76116006)(83380400001)(71200400001)(2616005)(66446008)(38070700005)(6916009)(8676002)(64756008)(54906003)(66476007)(36756003)(316002)(5660300002)(86362001)(30864003)(8936002)(66556008)(2906002)(53546011)(6506007)(38100700002)(122000001)(6512007)(33656002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q1hVHh/cgmhwWF4/EFmgw6aLnEVnnatcqd5hz0zgTI2HfIyai3ps2hWRbKfI?=
 =?us-ascii?Q?zVX48vmLyl7ZZH0dMDMFMW2uKLE9zPFfKQEno8S1QtSxT0ERlo9DzHyZf0RD?=
 =?us-ascii?Q?qz1uEo10ueEatMWJzmwLtfjLFqaP2CTGbDIQimyIy/mTxoCWrz3lkVbZllZj?=
 =?us-ascii?Q?J4++/IKQHR4+LVvsmneE1cS+E+a1XrLwMIqWHzMRcFYzUstyQE3OeJ4F0yU+?=
 =?us-ascii?Q?Z7SsRZR4uRTpGGPJ+vDftMbh/EmzISc5mP/m6BjrXIy8wZIL4t9Z/nMuHwsU?=
 =?us-ascii?Q?ZAfXKdYmYojrRg7UFrVFlluScFHACtrJ5cockusO95Gk51Cs3IMbmQw5GqC+?=
 =?us-ascii?Q?k4dZ/N0lmlbi1iX96AFKlDlM4jlmEO4iJq+FTZwaMC/v78KeKLl/LXboNBVH?=
 =?us-ascii?Q?AgHvIiHHzAgVO4XD+IFGEhzfYzfXlMcUjRvdmMFLCcb9XyuOUK6WFxhBpKaN?=
 =?us-ascii?Q?sYhBk6AfCBP4S8+7n7807AkxFD90zd5zb6+CD7OYwVpNs8rBt9XvqetACR/G?=
 =?us-ascii?Q?VijVtqqblHKmitplYYHAtGMgsAtbXWV26jKO9VhRd6ShcU7WlO0GDzJOn0jQ?=
 =?us-ascii?Q?E2hQk7FPhQyJV1wJ1427e6QNA8n4H8kYFFlQU+QhtLqL/hSrK4vt3khC37eY?=
 =?us-ascii?Q?EFG4H8auQi4ROGNNMOYkoVEzfMnQ14JhJVJPBt3HpX9lS5+YaxFb/QXC1SGf?=
 =?us-ascii?Q?Z6IBfhWW/W/97lZETCK6vZbKftTFXsjy9u3svZzEj25KVAZtDqZJb2pBNdFG?=
 =?us-ascii?Q?zaebcFNuSuanpd0ToIiVM7yuz+rNATTNZF1O1s3GtFXDAfggTVytfCWJDS1K?=
 =?us-ascii?Q?CJDrHg2SZF2qGlA96cH8dxZ7XxaCn8NxosoK1fbtgctST0/zeukb2+/DT7GQ?=
 =?us-ascii?Q?ebmvJyS1NDAxBYDUNXpgW3+1mG6zzZeMlbGFHrc/IUGzQQ7d/IoO+3LqUoqw?=
 =?us-ascii?Q?sVg1bQQiE77/CV23hkPlJAql8Jxyrp15mDQ5LD1AqETjPfKvi3+kTmkEuaHO?=
 =?us-ascii?Q?vSxTTlfhVM9/C5j77bKIEu427pDW6xBpAayjXrkdmtPEgigt1k61bLaxE3hF?=
 =?us-ascii?Q?/VqH+uEbbVqHvubs5Nzjd+aVtYLg9AxKs/rHvtE1QnNXd3q9h/+/CPejcM8F?=
 =?us-ascii?Q?FallEJ2/ZYyq/dIf1pMqgSb6xpJpSamkGqee07FVgHSc5xb9FtcagrwaWzyX?=
 =?us-ascii?Q?Z1FJL9O5VU6XJ45O2D3NoO4W/ALNl0lqC/Y5vAsohui4HOubI9l6h0H/Fp5H?=
 =?us-ascii?Q?QPJTh7NPs9qmKjaIC7+aeW+nI6jGUmrccYaiYbmtl6bcxSANefYtdRYyfWHd?=
 =?us-ascii?Q?ZNSpZehoiVh5QGmz4/Tf3NlGvG6iDYy6Iu3+OgW9NQC8HT+B6h0cbhxkfMWs?=
 =?us-ascii?Q?XKKT/hB8xGh2A1dCbCEk0JFWAUFQtctUpkqitVMPG8zpf5AdNhc6MJGwR7Za?=
 =?us-ascii?Q?cCuX5Hz0mGtZINAAbWIC55+JTaKZt4TfOPaS1tE19UU08KLaQpL4GBjH1g6d?=
 =?us-ascii?Q?uo9zEJXxcbN3/8R3fZ+/LWjhSlYfbkJ+w+36xQbS3RIkxxpPSb5eLFfAH8wy?=
 =?us-ascii?Q?wENvTgxKqYEf42MXgtxsqQBp9wANqIJ/PhQ/WZcqO+eBDk6FhSEP9zLplgv+?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4AF8A2C593D8BA419C3C254CF3AF4D65@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2877f04-9c35-465f-e92b-08da6a06eadc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 04:18:36.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbfmbOE2bb1ougJvD5hPjC5O21n24smijEmjtHtN57C90xvtPcOhxUTwddNBkGnk2j5TjvYrG4SgkRvRlwu5vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_01,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200017
X-Proofpoint-ORIG-GUID: ZM1sk7wel4nHIbuoXfVmq6FKcP0Sb43A
X-Proofpoint-GUID: ZM1sk7wel4nHIbuoXfVmq6FKcP0Sb43A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 19, 2022, at 10:36 PM, Dave Chinner <david@fromorbit.com> wrote:
>=20
> On Wed, Jul 20, 2022 at 01:26:13AM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jul 19, 2022, at 6:44 PM, Dave Chinner <david@fromorbit.com> wrote:
>>>=20
>>> On Tue, Jul 19, 2022 at 04:46:50PM -0400, Anna Schumaker wrote:
>>>> On Sun, Jul 17, 2022 at 9:16 PM Dave Chinner <david@fromorbit.com> wro=
te:
>>>>>=20
>>>>> On Fri, Jul 15, 2022 at 07:08:13PM +0000, Chuck Lever III wrote:
>>>>>>> On Jul 15, 2022, at 2:44 PM, Anna Schumaker <anna@kernel.org> wrote=
:
>>>>>>>=20
>>>>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>>>>=20
>>>>>>> Rather than relying on the underlying filesystem to tell us where h=
ole
>>>>>>> and data segments are through vfs_llseek(), let's instead do the ho=
le
>>>>>>> compression ourselves. This has a few advantages over the old
>>>>>>> implementation:
>>>>>>>=20
>>>>>>> 1) A single call to the underlying filesystem through nfsd_readv() =
means
>>>>>>> the file can't change from underneath us in the middle of encoding.
>>>>>=20
>>>>> Hi Anna,
>>>>>=20
>>>>> I'm assuming you mean the vfs_llseek(SEEK_HOLE) call at the start
>>>>> of nfsd4_encode_read_plus_data() that is used to trim the data that
>>>>> has already been read out of the file?
>>>>=20
>>>> There is also the vfs_llseek(SEEK_DATA) call at the start of
>>>> nfsd4_encode_read_plus_hole(). They are used to determine the length
>>>> of the current hole or data segment.
>>>>=20
>>>>>=20
>>>>> What's the problem with racing with a hole punch here? All it does
>>>>> is shorten the read data returned to match the new hole, so all it's
>>>>> doing is making the returned data "more correct".
>>>>=20
>>>> The problem is we call vfs_llseek() potentially many times when
>>>> encoding a single reply to READ_PLUS. nfsd4_encode_read_plus() has a
>>>> loop where we alternate between hole and data segments until we've
>>>> encoded the requested number of bytes. My attempts at locking the file
>>>> have resulted in a deadlock since vfs_llseek() also locks the file, so
>>>> the file could change from underneath us during each iteration of the
>>>> loop.
>>>=20
>>> So the problem being solved is that the current encoding is not
>>> atomic, rather than trying to avoid any computational overhead of
>>> multiple vfs_llseek calls (which are largely just the same extent
>>> lookups as we do during the read call)?
>>=20
>> Reviewing [1] and [2] I don't find any remarks about atomicity
>> guarantees. If a client needs an uncontended view of a file's
>> data, it's expected to fence other accessors via a OPEN(deny)
>> or LOCK operation, or serialize the requests itself.
>=20
> You've got the wrong "atomicity" scope :)
>=20
> What I was talking about is the internal server side data operation
> atomicity. that is, what is returned from the read to the READ_PLUS
> code is not atomic w.r.t. the vfs_llseek() that are then used to
> determine where there holes in the data returned by the read are.
>=20
> Hence after the read has returned data to READ_PLUS, something else
> can modify the data in the file (e.g. filling a hole or punching a
> new one out) and then the ranges vfs_llseek() returns to READ_PLUS
> does not match the data that is has in it's local buffer.

Architecturally, with the NFS protocol, the client and the application
running there are responsible for stopping "something else [from]
modifying the data in the file." NFS operations in and of themselves
are not usually atomic in that respect.

A READ operation has the same issue as READ_PLUS: a hole punch can
remove data from a file while the server is constructing and
encoding a READ reply, unless the application on the client has
taken the trouble to block foreign file modifications.


> i.e. to do what the READ_PLUS operation is doing now, it would
> somehow need to ensure no modifications can be made between the read
> starting and the last vfs_llseek() call completing. IOWs, they need
> to be performed as an atomic operation, not as a set of
> independently locked (or unlocked!) operations as they are now.

There is nothing making that guarantee on the server, and as I
said, there is nothing I've found in the specs that require that
level of atomicity from a single READ or READ_PLUS operation.

Maybe I don't understand what you mean by "what the READ_PLUS
operation is doing now"?


>>> The implementation just seems backwards to me - rather than reading
>>> data and then trying to work out where the holes are, I suspect it
>>> should be working out where the holes are and then reading the data.
>>> This is how the IO path in filesystems work, so it would seem like a
>>> no-brainer to try to leverage the infrastructure we already have to
>>> do that.
>>>=20
>>> The information is there and we have infrastructure that exposes it
>>> to the IO path, it's just *underneath* the page cache and the page
>>> cache destroys the information that it used to build the data it
>>> returns to the NFSD.
>>>=20
>>> IOWs, it seems to me that what READ_PLUS really wants is a "sparse
>>> read operation" from the filesystem rather than the current "read
>>> that fills holes with zeroes". i.e. a read operation that sets an
>>> iocb flag like RWF_SPARSE_READ to tell the filesystem to trim the
>>> read to just the ranges that contain data.
>>>=20
>>> That way the read populates the page cache over a single contiguous
>>> range of data and returns with the {offset, len} that spans the
>>> range that is read and mapped. The caller can then read that region
>>> out of the page cache and mark all the non-data regions as holes in
>>> whatever manner they need to.
>>>=20
>>> The iomap infrastructure that XFS and other filesystems use provide
>>> this exact "map only what contains data" capability - an iomap tells
>>> the page cache exactly what underlies the data range (hole, data,
>>> unwritten extents, etc) in an efficient manner, so it wouldn't be a
>>> huge stretch just to limit read IO ranges to those that contain only
>>> DATA extents.
>>>=20
>>> At this point READ_PLUS then just needs to iterate doing sparse
>>> reads and recording the ranges that return data as vector of some
>>> kind that is then passes to the encoding function to encode it as
>>> a sparse READ_PLUS data range....
>>=20
>> The iomap approach
>=20
> Not actually what I proposed - I'm suggesting a new kiocb flag that
> changes what the read passed to the filesystem does. My comments
> about iomap are that this infrastructure already provides the extent
> range query mechanisms that allow us to efficiently perform such
> "restricted range" IO operations.
>=20
>> seems sensible to me and covers the two basic
>> usage scenarios:
>>=20
>> - Large sparse files, where we want to conserve both network
>>  bandwidth and client (and intermediate) cache occupancy.
>>  These are best served by exposing data and holes.
>=20
> *nod*
>=20
>> - Everyday files that are relatively small and generally will
>>  continue few, if any, holes. These are best served by using
>>  a splice read (where possible) -- that is, READ_PLUS in this
>>  case should work exactly like READ.
>=20
> *nod*
>=20
>> My impression of client implementations is that, a priori,
>> a client does not know whether a file contains holes or not,
>> but will probably always use READ_PLUS and let the server
>> make the choice for it.
>=20
> *nod*
>=20
>> Now how does the server make that choice? Is there an attribute
>> bit that indicates when a file should be treated as sparse? Can
>> we assume that immutable files (or compressed files) should
>> always be treated as sparse? Alternately, the server might use
>> the file's data : hole ratio.
>=20
> None of the above. The NFS server has no business knowing intimate
> details about how the filesystem has laid out the file. All it cares
> about ranges containing data and ranges that have no data (holes).

That would be the case if we want nothing more than impermeable
software layering. That's nice for software developers, but
maybe not of much benefit to average users.

I see no efficiency benefit, for example, if a 10MB object file
has 512 bytes of zeroes at a convenient offset and the server
returns that as DATA/HOLE/DATA. The amount of extra work it has
to do to make that happen results in the same latencies as
transmitting 512 extra bytes on GbE. It might be even worse on
faster network fabrics.

On fast networks, the less the server's host CPU has to be
involved in doing the READ, the better it scales. It's
better to set up the I/O and step out of the way; use zero
touch as much as possible.

Likewise on the client: it might receive a CONTENT_HOLE, but
then its CPU has to zero out that range, with all the memory
and cache activity that entails. For small holes, that's going
to be a lot of memset(0). If the server returns holes only
when they are large, then the client can use more efficient
techniques (like marking page cache pages or using ZERO_PAGE).

On networks with large bandwidth-latency products, however,
it makes sense to trade as much server and client CPU and
memory for transferred bytes as you can.


The mechanism that handles sparse files needs to be distinct
from the policy of when to return more than a single
CONTENT_DATA segment, since one of our goals is to ensure
that READ_PLUS performs and scales as well as READ on common
workloads (ie, not HPC / large sparse file workloads).


> If the filesystem can support a sparse read, it returns sparse
> ranges containing data to the NFS server. If the filesystem can't
> support it, or it's internal file layout doesn't allow for efficient
> hole/data discrimination, then it can just return the entire read
> range.
>=20
> Alternatively, in this latter case, the filesystem could call a
> generic "sparse read" implementation that runs memchr_inv() to find
> the first data range to return. Then the NFS server doesn't have to
> code things differently, filesystems don't need to advertise
> support for sparse reads, etc because every filesystem could
> support sparse reads.
>=20
> The only difference is that some filesystems will be much more
> efficient and faster at it than others. We already see that sort
> of thing with btrfs and seek hole/data on large cached files so I
> don't see "filesystems perform differently" as a problem here...

The problem with that approach is that will result in
performance regressions on NFSv4.2 with exports that reside
on underperforming filesystem types. We need READ_PLUS to
perform as well as READ so there is no regression between
NFSv4.2 without and with READ_PLUS, and no regression when
migrating from NFSv4.1 to NFSv4.2 with READ_PLUS enabled.


--
Chuck Lever



