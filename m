Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE7070FD33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 19:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjEXRv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjEXRvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 13:51:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6911D3;
        Wed, 24 May 2023 10:51:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHiY3l009181;
        Wed, 24 May 2023 17:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fcdYr/zyE8equzt30DY/QPJYnIqP7C/8902mEXLnslI=;
 b=cNwCsgWFltqd59e20Lj+GaDipVmMB4Nz0tDf6QrHgZrQuFXGP+yNvQQ2Yn/YgqfA4S80
 cqDJx16RwAYXS4tvUdOnTrjZW5f1l9A/nImDrDs/+GbMfdkCqBD6IvSV1jePVYTghxAQ
 JgJzWzpHKH9/XmbkRa2pCeLm1SdTfaFPRlPYUi1SQCDHvIn3H71kTXcDeIy+FuFTkgzo
 LjgcJIDM4rvmNo7Wn/SI1KwwTTMLAsd5RcKc/KfdZn1L4W6V5jtWh5Ku3S1qo9apmGh8
 tzhUqAAerglJlRGueJqxT+tNLFlUmgnAdc26dctmHvKlQHOTqyJ+thW05QsbLogunROm ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsq8bg0d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 17:51:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHfGhC015828;
        Wed, 24 May 2023 17:51:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6m3gem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 17:51:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFq497+etiT/FuxTYJRxWfv7L4m+k6ObUNgZc2wIandN98hodNpYsxW6zf+ohkEPLH0EGLDrBzCh/Mg4Gb8Hv8v/WJib7PmzWrykT1AXhT3J7YuJep6cpTio5ZfjImFvwv2TeW2e3uLfSNhvdn1/p1ApziCzP65qyQZJERq7Td2IY05ZUAP/BlVXCSF6g/cpNmtCxBjcBj6IGLW2/wI8s1QOke6Z6sWbfKG3NIFosRU8ICk4M8/+huTtkbBuXIDcS4fEBkmXzbKQZL72B9hRLQKwEuBaeL3JUMWvTBzojjAbuH4VfysPAEnOtaSkN8q7bi7Ksm+S6YBGwrN497GYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcdYr/zyE8equzt30DY/QPJYnIqP7C/8902mEXLnslI=;
 b=IrK0kxpBQNb5qctCNPaJ/DtoBemTkoWF3chIaOZGTEWtjTAqYpFAXB7aNwpYrRz0kmpCvkB7rrnxhOhr43iobKOFHmlSqvBUVEubUtOU4rR2MjGWFBIF7E8pLhmZEbfRwnWVpGsVLgSMhFRsGZq/PwsECVwcwdu1MkoIIgrfm+EHlDJuCFIOWECcpcdQ8OUsYqNOQVqyWlCUO4b8cPajEqwMI5ZCbf91ugdaCyJx4vL2j50Xvb2h2ajFnVqW7HaRqAWlNYLljU4LgZiJ60bOLQanzWDiQAcxSPo0z0OmJqlYKJ6p3HBaqA8m1SPDjWcJsYaxhyM2LVZCj6ekkBRLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcdYr/zyE8equzt30DY/QPJYnIqP7C/8902mEXLnslI=;
 b=ygurbsgZgshBJ3qIF5aiMfb38nvyqDFrdMtOkLszCme2CbDP8wkxlRro7hfucJ4Xvli6gjDjuexQAdzrJa0tR3v9cgmWHS4wUw//kmOLyHuWvz26Rcbk+HXXtfBuP4Jas3h5dct1b2RtGbzYvlq4bhUllLA6ykySdQrVhSyosNI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7595.namprd10.prod.outlook.com (2603:10b6:806:388::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 17:51:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 17:51:16 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] NFSD: handle GETATTR conflict with write
 delegation
Thread-Topic: [PATCH v5 2/3] NFSD: handle GETATTR conflict with write
 delegation
Thread-Index: AQHZjQiHYb+9V1yj3kqcohFaOFOV+a9nJrQAgAA3oQCAAlg5gA==
Date:   Wed, 24 May 2023 17:51:15 +0000
Message-ID: <DF33B94C-0DC3-4588-B247-B09DD0CB7EF3@oracle.com>
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
 <1684799560-31663-3-git-send-email-dai.ngo@oracle.com>
 <ZGwoXtYZP0Z0JgAf@manet.1015granger.net>
 <4eda21d1-bc9c-ae1e-009b-c868dd18abce@oracle.com>
In-Reply-To: <4eda21d1-bc9c-ae1e-009b-c868dd18abce@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7595:EE_
x-ms-office365-filtering-correlation-id: e1239dd0-0abb-40c1-3ebe-08db5c7f78b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jTdT9qwkJ+OFiN3a72Oc8WNcHoaZW0kPKr65nmdUvmTGoPk/XvUTT0plGSVoKOZwOtLmvtEcMunauOCNhY6oKFUSU5vn/kffUC83dmzSJqtWHi8VjA+4HMhAZFiCthtZmCpEO2uoKOYP4DHBfrPIyj/ChkE9GCARHIcoxe8gmoSJQ9Qr5/Bj9yBPSN7hDBzH1Aka8vd4WzKg5HlpqOH0myJiewIsiMDG8H2mk7V4FJTpzlD8iLgZtNZRT/NykRZDJfY6UGHOncIqySByTC3yV6rAtCPVY1GrVN1VJ2rctirUqtg1ma/0EJxygwLOAU03EbYfNeKytA3iKfC3X1K6uWuEiN38hXox5yMbk3N4A2L7/i3wZfQ016dpeSthpDKb6QzJ1QXSedUVXsIeCoLmIVBvLb537EtPlyKByYcFgQVUGMKUxK/VtUKuG8h19TZmJxOUgDAedvyDQ9vu8cUw/FHRnTPjB4c/HhifnaMhxi7SJtpbQDRZD3DitUL3C6URdNWwYzuQ75fnawfszHUAobqVsZEvNAZcdMGncHDJrIlkkCh2xOEt5fuPy5zjQLAAoDvxn0PnHsMVsZtH97DYR3AMCd8paFWeIJXCvn9VKqNTQ52C8GLKJkoWFjCSEL0UH+1FVDdEHl8uYYQmz727MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(478600001)(64756008)(66946007)(66476007)(6636002)(66556008)(66446008)(76116006)(4326008)(91956017)(37006003)(6486002)(41300700001)(54906003)(316002)(71200400001)(5660300002)(8676002)(6862004)(8936002)(38070700005)(86362001)(38100700002)(122000001)(33656002)(6512007)(6506007)(26005)(186003)(53546011)(83380400001)(2906002)(4744005)(2616005)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4XfCpoNRVmilNBOIFw4i9XhBy91DGauHFwsbSvcvNpRJaTAGQwbr/8ABFXno?=
 =?us-ascii?Q?gpD8hATjEfiz7AoQZ2Vsgl/90EnZAGGmEtM1QRATjuXv+rNG48OFAZPMmS4/?=
 =?us-ascii?Q?XKuQvcA1kAPDyxH5coKi928VKAQTUjJc9WuAinFP59SOchxBsXoi2XQjhaUV?=
 =?us-ascii?Q?hX43qhL2c2cedrkW/8Ia488hOMV3XIDBb28l3hUd8t9hQhRJDRD7z59JZ7w1?=
 =?us-ascii?Q?t35L8Br4zQbtuRmCoABNBXxZzwYaLLlmlgG+fsaHiEZH7zXr5iuFbsHITUqi?=
 =?us-ascii?Q?cH7sEHjgMgp6ZRvZLRjPzDNcTRPm7ttWw3toKHuMjj7pQayY+UdkzQ/9iUXT?=
 =?us-ascii?Q?XWjOVOL7dyAIqpFEghVjjM/y4JJMu7YchY+zDR2/IBLavjFP9vLFT5T6zM24?=
 =?us-ascii?Q?+MwdTSkOmjJI1t1x1HYnmQVVF4z2TgpENdF1bpyzrbjgXBMnQbqp23KCN2rL?=
 =?us-ascii?Q?yCHMDS8FWqoJGUlvTGrWVD1lwbopKxWvJTkSLwDJmSlDofb4qfSVPxik1ncE?=
 =?us-ascii?Q?tRCfBqobr4a8xiWQ3fieu3yDVL6sQ/oRzKuuFVo5i+QFW/NuSLgYFHdLyKoy?=
 =?us-ascii?Q?oIJHBWOnu6cpd3d5dvTDNy2xjvmdn6n9Kt+dFroH41zCefa92ZZP9y1tXM18?=
 =?us-ascii?Q?AA3nGt9mygIYxkTjQqPjK3HQYMQrsLojGaZC3g3/ZZhDbdkt4rMix9zvWbAG?=
 =?us-ascii?Q?dm32GSR/VvglXBWi2OTWe6DX7Pwwo2uBMX7xvUhRiqEpHCx0jmNRrkeAu9cd?=
 =?us-ascii?Q?OD/1fJGxTgxifkwEpKaync8kX/YKTq/7sh97kqXQV5JV+tHqyPPd4Na7gMCw?=
 =?us-ascii?Q?zqqI8dubHBh7sSpzeVmP01AHFdX9x+V0Hte+jX0SZWDgNFyk0QEzlahTGW1G?=
 =?us-ascii?Q?El16ZgPtIwxwlsZIH4OVvKU50ifdq3qmD9W9an8SdWBhw2HxdTvag3HBjQic?=
 =?us-ascii?Q?IjZCPsZXFiz+OhSUmgSTkl7BrszRI/MfFDiLUEKfZMz6NOaU1q+1bzQzk+fH?=
 =?us-ascii?Q?9ZR8phDzGycHn3VDN5sBWi7RHujOSCxUBb1OqrL8stFbvuaTPCtibB+UEHDh?=
 =?us-ascii?Q?I9zhDt9/sIfQriRoHlTILjZOQgvzLUPOlBJu1KHhZNwt/8aVBNaQFcxBbbso?=
 =?us-ascii?Q?mBlRSaIT8N7zwdLXmvawAfUU2RUcFw5x2lMPJ/5/9EfFL25Lpk9qQsBbpuYq?=
 =?us-ascii?Q?8mohIrPAw0AwsYTIfM8dxb6nwn6bSwEBcnKiKJp/e0OCwmc1SUMoBM/1SM3w?=
 =?us-ascii?Q?nfVvB/dTWM09721OzjrfnM5N9c+NmVtcZvnsUSCYun11Ywe/q8m+XYa33nVG?=
 =?us-ascii?Q?iV2ra2ydYzOj/j1/R5UHdCpDKDvGuAtOob2WZ7Vybjsac7WOMksDE4u88rvq?=
 =?us-ascii?Q?oARF7W6GF3j1J8uoQ31Vp+fcDPCVC3cS5f+98ghiKX2EkcITlk2KqAuKjwYd?=
 =?us-ascii?Q?6Ej3BuENigy8lbmeyNpo+6jwumO545YJ0Dcn+01tCgLYttFzaxsAVxby/OrO?=
 =?us-ascii?Q?JZRYOZrxD7wA7WV034OsibCIt7OLu2sz3RU1SvbtrFFt+r4uEBVb1XX4Gd59?=
 =?us-ascii?Q?qg9i8O2ktfX0jo4a25Yi5xyRsya0Y2JBVMDh6LODb9gjG8cuEZMVE8Lbyvi/?=
 =?us-ascii?Q?3A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73C7208364E22B478210EC38E81F57EC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hh9nAjWZo17jRNFwxaREAl2aRyYUP9pSb/61DluN9DCpiVaRiqOgvokpbAtbTAUwApJPN4tDK8mnSWgkYukGW0VphaVqBGR0au1J0zAhLo8IS1CYH28EXG2sXDF4QvflGbYufuTPytGfdqTSf90FzHZt9p4iDL8qbMQ/8ukEEGTRQZcLsTKoQPj6dQWhw4xuFKbOv/yyvT1/N4b16txLzIL1okvht2ZbLdUmIqE1X7wRCg/KHaEbVizPBNov9PdUl3tcg7X4+l7B9HSb9c37DFApeewhkuzlaAB39lyK+fpZrEi79pvyJzKXdcfhH3RLiIMHCq31eV+HrsyPkGBzsA1nZ5IJzhteS6486HpgiD+Po16Zvrg1cSCmwNVXs9PfXxx6cd5mScpTuJYkCY+XxoHG0in+SJmxcdPwqH3NFtgyVjeTRoFTF5R6F9nRNMhbsllk3esChe/s0Tn/Inj7/TIRrgI53/EvPQpfVSs04hkFNQqECoseYie/HGtBnrFLmSbEbIWoX7m4h5rVNaleDm4OqzwWysLVMsWZKIWeAqE2hIGbCN3dYjeNbW3oBDqZx4zDHSUrXEY/1HucE7ufTt4cwqod61Ov0EgdOgIS64EfsKTcQEIjtMbNtB7I63QPb7JSsNGfOYIn83zyXpxzdxQUmDAvRFIr53KuUyaFrJ/ri+4oLyMSn0eVNqhaa5DbvLZOxHk9NRy4/54LyPma8QKAu0TKZ57OJUUQ22UYpKQQoCf0p+fm9DZJgauKes9dMai9UpYEk28b7s/FfKP89fY6nsZbCExkM9ou4Y6u+4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1239dd0-0abb-40c1-3ebe-08db5c7f78b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 17:51:15.8442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3FWE2hGozwMPr1Z/Q0+nR9hlgfvFVpNLIz0bbIpfl46uK6j0hCWQCy5+KauO4cJyxBvbupxc58lHjucrnvpGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_13,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=799 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240147
X-Proofpoint-ORIG-GUID: 0J6zOp5SNPs8W29DR6Uh-flCxkYA8NQu
X-Proofpoint-GUID: 0J6zOp5SNPs8W29DR6Uh-flCxkYA8NQu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 23, 2023, at 2:02 AM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 5/22/23 7:43 PM, Chuck Lever wrote:
>> On Mon, May 22, 2023 at 04:52:39PM -0700, Dai Ngo wrote:
>>> If the GETATTR request on a file that has write delegation in effect
>>> and the request attributes include the change info and size attribute
>>> then the write delegation is recalled and NFS4ERR_DELAY is returned
>>> for the GETATTR.
>> Isn't this yet another case where the server should send the
>> CB_RECALL and wait for it briefly, before resorting to
>> NFS4ERR_DELAY?
>=20
> Think about this more, I don't think we even need to recall the
> delegation at all. The Linux client does not flush the dirty file
> data before returning the delegation so the GETATTR still get stale
> attributes at the server. And the spec is not explicitly requires
> the delegation to be recalled.

I'm trying to get some feedback from other server implementers
about this. I'm willing to consider dropping this patch for now.


--
Chuck Lever


