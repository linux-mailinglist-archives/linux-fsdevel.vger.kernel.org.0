Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B570FCD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 19:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjEXRlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjEXRlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 13:41:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD8F122;
        Wed, 24 May 2023 10:41:21 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHdsEk007602;
        Wed, 24 May 2023 17:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NbGGPUEi3uXAHGKEUE33YbN43wN6XRGgvTKHB/JHXtM=;
 b=U9KBgt+aEjiHRKv8GgT7nPcUf6/6RX56PlseWiM+pHAOBC3lNhOI30/LlYF48x6Qy4vE
 +FRCwN4vs1+UMYbY0bdNvdr/VoU7KBBDgpGC4sAIixyN1tQdQU4AN+8PODeFNEQOz1yn
 9Ag0iihq0ubs2U1FWXOGt8qwm01WbQ5LXQ2msZAAYMIRcRXfS5sa+2QPIn2/66FWIur7
 Bz7QW64E/mJ3ekWJ0qbBtaWZxqyLX8wJQ9EOjhrYG/pHI1uLA2/dUTico9W8m1e8LucB
 xfDqgRFR7QZNhVFPWA03artOIC8o8wDW3Wf3noRS1sWew5lQNGKxQh1d4N5U9wHFAhRD qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsq62g03p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 17:41:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHebYv023878;
        Wed, 24 May 2023 17:41:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8w3560-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 17:41:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEYworBGCQKyWkz1M1pH9iOAwclC+GD1G2dtE/iFJEKs/eHk0HCXVp1c9uiKL72z5g1PE5M09UcIuIDZWV3xZ0RoX0nTVxxx2F+CO2DeHqsB5f6Av6bghZIQDC/t0N+mPv8z/1tGNFPL66zYr/yHdWKeHtPLOTbjdpY8tRg2oqtdbBapHKNo32KYKwcne/EN5V+MaBgYxyMwNc2493JQrbHfQclKg581ZGVpuo/IWiZNsObCDSHebE4CMjK9ivNpFahBgOKZBgSxVrv5k82/jgLsAiv9XCYFx/s3s0JExZiAPHtPlfsEIlUbU9chMOBbf3fLjQ6YV7PISTVif4jjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbGGPUEi3uXAHGKEUE33YbN43wN6XRGgvTKHB/JHXtM=;
 b=H/r0HLqt4PQNEzkIKNXSR3qpA4HWF17EKRr9suOkZ8K+gX14hLvsyPRska0j2go57S0qPFEgnAWlqX5XlUFSq95R6F8KtWLqVUloYyAE3WZKTUEo+XXYaOEtM48JpRmKOREPoU/UpYXp7Hh7jv3Au5KwTswb0HyGqxxzlQcWrR50UvMTIhA35fv6ryK4CqTOVg9wpQMzR9dDAGzV5PBs+fX+P2EenA2AOhG8AnE3mqlD93BtyOwcieQ4KtI5I3ioGaViD/U3kHdEkGrTDuroENg4nBOKqaxva5jtHO9rMP59qucs3armlkYMxT1ArfAkqMmPu+fuuoQd1FaiDiIoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbGGPUEi3uXAHGKEUE33YbN43wN6XRGgvTKHB/JHXtM=;
 b=ncEBg7RTJaLfd44vNMAVFPtjIl3MX/0BNDv3FaHa0RyaxmxEd1qwozJOZqC1KavGZaZYCAKq/RpDwDtlczGUheYfeC3ky5NB4WdHf/hANQ/xg17HkCotSqcxWmYxS+H1O7xB25Qi5KHdz9CzZkyBddzsy6vmcKM3fWhFoeBYNgM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB6093.namprd10.prod.outlook.com (2603:10b6:930:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 17:41:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 17:41:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] locks: allow support for write delegation
Thread-Topic: [PATCH v5 3/3] locks: allow support for write delegation
Thread-Index: AQHZjQiIht0IszKu60KDnHp/yj6+RK9piRmAgAAAVACAAB2mgIAADK8A
Date:   Wed, 24 May 2023 17:41:14 +0000
Message-ID: <CDB5013B-A8D2-4035-9210-B0854B1EE729@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
 <1684799560-31663-4-git-send-email-dai.ngo@oracle.com>
 <32e880c5f66ce8a6f343c01416fcc8b791cc1302.camel@kernel.org>
 <D8739068-BCAD-4E47-A2E2-1467F9DC32ED@oracle.com>
 <bc960c7251781f912d2d0d4271702d15f19fb34a.camel@kernel.org>
In-Reply-To: <bc960c7251781f912d2d0d4271702d15f19fb34a.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB6093:EE_
x-ms-office365-filtering-correlation-id: 249adefd-b13f-419e-1aa7-08db5c7e1242
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jA5uIcgQ39C9BAWrSLAXzwEZ6/yGZSmuFkhw5lGTnBcY6Or0XtuCTyy4ZuZ/xT5XvI6u4gJvnUP/9egNZZ1izl2c4wDAh0O+HvED593ZS9/OeQ5+RmRv09z/Ne213ypdsF3+7IhITjNvbZcDZ0zy2VeZCafae4+L6DV7DbvTFX5DnqIJBGcQ/x0YOECVPsDUcJ7OlviwZn+gWuPCDVRhCqRBWoD9+uO7tvIBbWCQVpt3TurMvLVeyv8X5goGt1csmqbaORzgWoGGEdK8Ol+xbM3F/Mlld9hnDRnlu4I3u6fpNxMJN34xqvIwCWK9doGz+SLlIvB80GncZ3W1RxUVExGim97Dj28sxGf66u2W+3tfvhkAkneRibqtHJYWgC3ojUtm6HB/7vMKI9b9AoN+1vWKz9WaE3WUP+/51qQNiIh9oS/Aw4eAf3++P49WDUdgHrCDQVxSQPdHFztVZDo62EUGYCDqKtar7NJzQN65ltbwg1xYnfc7Mywh3GMm4F11jwBDNpiBG23zDylh0TkN0mb7JuuGje+ikg+Dm5J9W0cKKMEsE5DzWCdvyQewXxv6GgjCVS5ZbcEXRkKAdVgF6iSPhOpIPaUemNkRqwId1Vc+zHFwlvxb3bl3Ewm2Q73ByVC2eGe1j1hnuqKMBVxF4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(2906002)(54906003)(5660300002)(8676002)(8936002)(6486002)(66446008)(478600001)(41300700001)(316002)(66476007)(76116006)(66946007)(64756008)(36756003)(6916009)(4326008)(71200400001)(33656002)(66556008)(91956017)(6506007)(53546011)(122000001)(86362001)(2616005)(6512007)(26005)(38100700002)(186003)(38070700005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JZ3FumjOUe5XTh+ssUPMeKDbAAoKhCZk2Z0a464iDx05Nnqq26GdaiglmFEV?=
 =?us-ascii?Q?DAsUxWo76XLG3dvESBCWALyUEgQL5sugDcANul2zOjY3QpGlkp70NWH4EvTw?=
 =?us-ascii?Q?CCJz61NY2+VmppYsaffWddDA/NV8eQdcqsXJu2VeZkW1HpSI9PCFDtcRFf1k?=
 =?us-ascii?Q?hnlPyEdX1WQoRabSVbyMSVegENRWAHIRWvwJnOAy6QnP4VPOw2m7UFGQ81CB?=
 =?us-ascii?Q?8cblrlurxTlVozx3LRLHlRPTWO8SMb+wGqrNBuEqZPbeXOSuCHeWpdEsIVsp?=
 =?us-ascii?Q?K5tPWvQfNwERPKeUYY835b/+j3LIRgBdz8gVuHTsVN9gzwvDHCSXzsO2F7Gk?=
 =?us-ascii?Q?mNAzGdM0TzEZMetIEs5iT9J2mUVR8oNBLJ2GMqRpCVkMU7ZdynGvd78ATTzG?=
 =?us-ascii?Q?Sj17PIhS3a28dbylhe4joAa7jRYaha4aJb0eqKW567AlnKGO3Pk8pxSStWKa?=
 =?us-ascii?Q?CF5uc70C+Omll++eok7LhW9zbJy3a5O3WIHrwXePGef75OqVUqH1rwiIUXXs?=
 =?us-ascii?Q?ozKqYGvfwivQ+uDMWWPF/iEhFMNSdkhhg27WUMfkQGYjewQnHSTLJLZv+0fC?=
 =?us-ascii?Q?tGtLBhZxPY8waHBD5Xv5Ti0irRiDTxlE8N2XDw7OKsxsTIKtEZBpEZIYR9BX?=
 =?us-ascii?Q?lv1Vc6MZeuHQSWj4EajlgA0NPpE309kQ5w9dgYSiwlaPV2aqmn2mJn2NIA+e?=
 =?us-ascii?Q?qgbR0pbIJXjTm3qHPe1CiwaaAhg4FpAf8cGmQmKqGXGDwxgwxvMVyQoTr3in?=
 =?us-ascii?Q?pOEGJyzFmkVUbtILCJ/ftZWm21sinxBIk1NSxf+VFfxitITwBxlPa9laWLIE?=
 =?us-ascii?Q?19xUBDa0tNdEw3qtO4D4MuHiQJaCnNisQV3qsBUcr7Ggk6jZ4C/HmlgfrM1M?=
 =?us-ascii?Q?9SHURuOx4YV1Pt5ym5oyc8AsU5Zn2XC3UYHxnILUzGsz2g3YlTyGBRXEiHHY?=
 =?us-ascii?Q?Q1U8yBy9SvXKfou8YX792aeok/XIr4QRAq7+E422zM8kCIzNuYhBLVqcoaxT?=
 =?us-ascii?Q?HidVEjMbkrRphIMKhLRCVzVjDTz9sZG3VpDESxnqZr3LUnWTPRJsjcVGEMqQ?=
 =?us-ascii?Q?+z86Rcsm8CfgDTw+eAhLZbgnFX2EBHdCBv5OUC7mXrlWQjYaMme391NQGC+l?=
 =?us-ascii?Q?KPOAEM3LpCHeSm8V6hGUEHpnH6RirwGUXr51M4h/56FZI1Z4+EUjUwolKSLU?=
 =?us-ascii?Q?EhqVWm3AMFEV18fZAzxtZlsTztk2jaWuOcCAgPsLEZzfOqncxuQFmmlEQguN?=
 =?us-ascii?Q?Pa23C/woG4gykTe9Auqyvkgg1qP9etCkwTlcpRv+Wni5OaZQbiPlMF4Se1Lo?=
 =?us-ascii?Q?yZLTViK8U0P09hPoGi55UU3ZyP7LQPOdmDXsjF6peaBgU9+B12fBJx++gPlm?=
 =?us-ascii?Q?UEYW11xDOIj6Ol62DOg5Wy8BYd8j6AM/v/oe7uRP6pvdgj5MqYvr6u+FCukE?=
 =?us-ascii?Q?hSN13y11ZCJf3eBU6xEBAwu4Nbdh33tLzjb/qf486J+10GFWrZYUoL5STjyY?=
 =?us-ascii?Q?rYWLmWekSBXp335Cz78dCmwffYzbmAtzaScGOSdrZvw+xpqYXoDaG1c1uRcV?=
 =?us-ascii?Q?y4tt2JObwmaA5tOspKY42orNXriRDPS0Yh8vM4R+HG3mqoY8n21nUP/EtFPk?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6DF1D4800519554AB54E331F6EF0095E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ROYvZsdn98nofcWEhjQDHLIXF0LpHLx5YgceaoGoKx/bzAfQ+da6/TTht7N33RViRHFA9gvgJ+57hn/B1NRpJIFPrG/HHbunqQ1SyLUKeIjbyou8cmJszcLZwmpIu3G89m4ulUqIyA0qrzXc38sOvihYO5JR5gqK3jTGhuP2xiLBOsPEm7MFsaOX4vRWllXTjg499TEhBJKWM481JSK48znHfoqV8KAJ7hH8KCzN5B/b5Nc2gjZ9w0rPd1PnwoWHOEcG6gSHHSGAUjGUhGxr7XXxZFLIYG5zKivA/ZW/mwOz4ufMvBfb7I9TdyEq75f+XG5BD7HtdTOXnMe4ehgjx6fTzeTykMYLgeX3eHBZ3m9W6hK9jLqcrf7zF0b8mBQxNSe0agbE3njPNoMJtn8q1Z2rd3wX29elilVdqyLQp9UjGPJ/8qFs3hmK79wqqoPyOZaJ9LBnFVU6GKfpF70AifEzc5ciy6/74/xsBmoqq8cGFUKcFL5ne0acIZ4AGCvNy0YmSurISlTbKdgp4b8qh4bVk/gm/vb0pI54HF1hwXuYc4nWU4QFP52G7/TvKm324BDkU1m+y3CYoog6EjD6zANH7f+THMRpGDjEDXY1YRk8yse7S5GpkpAZB6bJ5CbHt8jMCeRRHr3y4NGGVpN+KhCKMVaVbQR1ogd+VVAXgfsyn6h33Noi+xs3FVdH/dOe9U9u7Z0WTS97c/KbYLV9w9432Pu8deRyaAGQWCNfW18OhFv+hJoDOPwWilcu8QccBQ90pz0iNaO990Juxtt2BgKS98NcXj/OHR31Tr4ScVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249adefd-b13f-419e-1aa7-08db5c7e1242
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 17:41:14.4808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzbTGt/n04WO81GisG5nO39ymbXAWYFnkgnaI9GQ/ncmHVb1XAvvoLcnAgaUl2Kr2b9NFxXRoCtELNBD2mVG9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_11,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240145
X-Proofpoint-GUID: At9faHsTNPAmMXPQ6h3sub2kXtBJyzFh
X-Proofpoint-ORIG-GUID: At9faHsTNPAmMXPQ6h3sub2kXtBJyzFh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 24, 2023, at 12:55 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Wed, 2023-05-24 at 15:09 +0000, Chuck Lever III wrote:
>>=20
>>> On May 24, 2023, at 11:08 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
>>>> Remove the check for F_WRLCK in generic_add_lease to allow file_lock
>>>> to be used for write delegation.
>>>>=20
>>>> First consumer is NFSD.
>>>>=20
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>> fs/locks.c | 7 -------
>>>> 1 file changed, 7 deletions(-)
>>>>=20
>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>> index df8b26a42524..08fb0b4fd4f8 100644
>>>> --- a/fs/locks.c
>>>> +++ b/fs/locks.c
>>>> @@ -1729,13 +1729,6 @@ generic_add_lease(struct file *filp, long arg, =
struct file_lock **flp, void **pr
>>>> if (is_deleg && !inode_trylock(inode))
>>>> return -EAGAIN;
>>>>=20
>>>> - if (is_deleg && arg =3D=3D F_WRLCK) {
>>>> - /* Write delegations are not currently supported: */
>>>> - inode_unlock(inode);
>>>> - WARN_ON_ONCE(1);
>>>> - return -EINVAL;
>>>> - }
>>>> -
>>>> percpu_down_read(&file_rwsem);
>>>> spin_lock(&ctx->flc_lock);
>>>> time_out_leases(inode, &dispose);
>>>=20
>>> I'd probably move this back to the first patch in the series.
>>>=20
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>=20
>> I asked him to move it to the end. Is it safe to take out this
>> check before write delegation is actually implemented?
>>=20
>=20
> I think so, but it don't think it doesn't make much difference either
> way. The only real downside of putting it at the end is that you might
> have to contend with a WARN_ON_ONCE if you're bisecting.

My main concern is in fact preventing problems during bisection.
I can apply 3/3 and then 1/3, if you're good with that.


--
Chuck Lever


