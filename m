Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBE73F0B20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 20:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhHRSgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 14:36:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44116 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229558AbhHRSgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:36:39 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IIXHtC005472;
        Wed, 18 Aug 2021 18:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=C7jJnCGqyn3PlMxa+WAR5gBtBAIecUjkIu8SeV5o2xI=;
 b=WoyTSoLyivkqrmAuaKYKST31jQmw7vWOD7I7yQC+7NJ4vqNG8+vTWTz5Ahz9d0ndRI8Q
 FyvfVz7gR9S5aLT2CH0p291cZ7mzNGX3DUGZl/1DTJ948bVFds8A3Ee2NO8AdLk7z63I
 iYTktoZcBH0evtuOiV4ENVN+1uh0Wsw3L9mbEWu3Cw8A35CWzMP1zSLHdSpR+hEHJ3zw
 tT+wlk9rieFEL9ZL+zWcBELZziX1z/58VWP5FNH/i3P/wpbrQ8mlxzhwBDwCRcJ1qc3t
 xCUewsZeSdRz+aTDtzZTUlEqDLCslMxPx3avfRkcwTPH7qPCCSw/TGyQXU4f1XwfpJ4J zg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=C7jJnCGqyn3PlMxa+WAR5gBtBAIecUjkIu8SeV5o2xI=;
 b=iTqwtKxdMpqLFwKO1enITLOICRE8kPBH585uPNhnMO5aGWigy1ZoFIGC2PxUi3AniE4+
 I8S1yGnt1Gq7qNfPOcBiPbpz3TEijm8BIMq8APeTpGV9CWXdeSwET3cHAvXo1519E0QA
 FnSOSoa78Ip2EJe+4ln+p3UjCc15Lid+IErZpyT7DtVL7VOxECqYoCn9cd47JnVkhsDy
 tszsJTjXXgn6ekXhG/4B0TfWtG8ybykeeLKW3uQ2F4QRfZuGlCHcFL47RjeHi/mSy24Z
 yYiA1A53Odk1qv8xEktBdX1LF7L/j0XWsA8Lg2lS99j9ATs8LTcJcDyxkeLzWw4oAnPK 6g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmhaua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 18:35:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17IIV8v3143978;
        Wed, 18 Aug 2021 18:35:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by userp3030.oracle.com with ESMTP id 3ae2y2q9y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Aug 2021 18:35:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkz6DrPPbo/zZDxXLH84b5iAeIisXwAUf9IJ2HGzE//MQt7gsJtEvX6IUfXKq3VO9QnJCl47bIIVtZ4UUWNF5QsAtLhEZwaqsV8/bCbV8OoMM8nAVOxwdjLOK9M2wiMiAe/E+KvzncQs3RgAAjC1Yy/6o+hUO0QqdjDrRQ8mMGgIPqKCe97DwoyI7wE/iEUO6r44TwEqw5nNwv3Ur2iXZdmGtZuSvZlu25ZoN9G8N35EPRrV74bHGbyvRmOpYlVWcbvXDNV9yAPg4JFrUi6ip5QsrTdarhEQwNDjXwRcude1H6Pyzj9MkPa1P12F4gWClfh0N3C3qvb/0zgRFiPIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7jJnCGqyn3PlMxa+WAR5gBtBAIecUjkIu8SeV5o2xI=;
 b=Qwnxvj21S4Z18g9asSPxY2X0Xn0wmA23SLW4Yaf1VshgRGuKdTOYiA6n+/aixRkQVyD4MBTab2wKl8GWcJVoCOaHN8PaUCksOaOvQ/qVYd3X+exxwzARasM4odrqdQrJi7b+Myr/JtA6cr02b3mOQICM96gr6tB2KYgdKsmQ6yJe4OOLHStlujuXxDQLFgfuF3EZlJTWPaI3TYhPRsou9ImvfYJTsidc8j1ax6WzzppDjMgw14LBVy8VAuhWkkub12623ICEHf8SRDe6PfcOPqww5Pqt6cIX+OdrbYRgbgMOcrt/Jyrl/bIoUa7pdeRMYRnPviV/F5EAS+peyHlfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7jJnCGqyn3PlMxa+WAR5gBtBAIecUjkIu8SeV5o2xI=;
 b=lrWxFDW2jy1+RPzKL2VGu4wohONMNEiQbkDdAxDtEsdxSotwk4zCVODxatRkGAstJdUYwjWVygcQI3+/avrtPjBZcH/S7PJvkVg9XFhEJckVj0dPbzFa5ozucN0DN9707xrxyizmL7xd1eyVU/qV9eTaHIb0H5Tb3fnLJO8MfJA=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5596.namprd10.prod.outlook.com (2603:10b6:510:f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Wed, 18 Aug
 2021 18:35:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc%6]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 18:35:26 +0000
To:     SelvaKumar S <selvakuma.s1@samsung.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
        snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com,
        nitheshshetty@gmail.com, joshi.k@samsung.com,
        javier.gonz@samsung.com
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfz6loh9.fsf@ca-mkp.ca.oracle.com>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
        <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
        <20210817101423.12367-4-selvakuma.s1@samsung.com>
Date:   Wed, 18 Aug 2021 14:35:22 -0400
In-Reply-To: <20210817101423.12367-4-selvakuma.s1@samsung.com> (SelvaKumar
        S.'s message of "Tue, 17 Aug 2021 15:44:19 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:806:d0::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SA0PR11CA0037.namprd11.prod.outlook.com (2603:10b6:806:d0::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 18:35:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21382182-2547-4135-b6a1-08d96276f229
X-MS-TrafficTypeDiagnostic: PH0PR10MB5596:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB559692EBC6B94420CF645D318EFF9@PH0PR10MB5596.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BGYh6qIQriDldauWLY68jn7Z351Qu1YIrT6esraEf5ehwLYscyk1nFrwtbsPWI70QV16i8gGFuMrNONB74W3JiaOBSjhTD6nynBIhE2VuLE+xXNdWQHGEFkqgBSUTx8ycMAX3dV+MJxA3UG0BBTwPIKyOg+2vI16Sk0X+Ih9jYynrtIlPtJU8CMw4CMVr4FQOqfstBGL/0msySmfCJ0DP1VzWOKUJr/IsTh2HZlbDLxfBJQ/Hf+D4HxKwoFPFgYJ4eB69ov0HyWvcy1f0LS5lqtoeAZbsDNWciT63OJVqcPGZMKWlNH8ViQj8dHzyBD/Qlfrfp88GIqTTwGHJi55CV2E2mW8Co6l9RIbiqRHTLQ+BXTDeRH1tABG+3nQ9QR2jkFSiZ2K0YGoyX4X38GsFh1XyhxPDE0SXNHmAN5k93cwo5CUxVU1aHF7iJ6tttXME7ZL2qlnmCQBKwx06WU0dEH5kAMxdxQvaHKTV6ysdFX9no38q4917DK5zFbUDx+oYZX6ZQeNScwnJiWHZYdoTYxNgdYHPSpI6gTu5I3JMLxVpk4OeBbgUVLJd6pMHWqZVQrrw3E5h3QLsUBucoMIpIbsTEE4uPh/cvNYq/mcUdq13ON9ipAeG6UFy7QhLgzk7Z2cDFMCU0f2a+JAnCwv6ifw2vlLg2a1eAOAvVPLQAJPe8RIIvl8ZoKONx3xQzqdiilmLjP3CosUf57m5Y8Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(376002)(136003)(346002)(5660300002)(8676002)(956004)(478600001)(8936002)(6916009)(316002)(83380400001)(36916002)(55016002)(38350700002)(4326008)(7696005)(38100700002)(52116002)(86362001)(66946007)(66476007)(186003)(66556008)(26005)(6666004)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mSBNHsRPLAWUjMfUvinAyt2Mo/LFD4pwqpequnVfpH4z+aneMKLobh5a0DSH?=
 =?us-ascii?Q?sweoGK7btq7HFQCJH7NnL1/YDg+b1bbUDhnIvcjR8maTNohvfEV9kd3LKT12?=
 =?us-ascii?Q?dg6FDrSkRutxSkLOHeOs7RL1DztJyG/OMC0Hyurkpkz4cq2O2yP4/r016wXD?=
 =?us-ascii?Q?iP1l90U542/mU8pc8Uiya4ZBVJlG7wITR2YCbLDqwuafaf67jreOgHlcnydC?=
 =?us-ascii?Q?kzCoag10anTUbF7ZwSR6xeI7iFd/M06JN08vjVx98rnx3RPVZsltzc+8jqAK?=
 =?us-ascii?Q?47/Us+IDhYY7uf99aGUYdNRxN+RzZHkjuO1VrPC8snbJ6H3xHKAglJ3nUSHU?=
 =?us-ascii?Q?Cw7QJD1gYI4rz9UeAs4OnFBJM8S0n2A8gy6W/JR4PVTtDMzmjMkoXjzDZy9q?=
 =?us-ascii?Q?t7609kz7yT8+XcLaVkXIbzxyC6ExLuqY9tPswVV2R/hUGStc/QPhWIEU8ESh?=
 =?us-ascii?Q?z5MQSYoJulZ9GJju9CZjxNGjx9Hy91RNs3ZFoeQZvoxwVRalSA1YGXFsMeCv?=
 =?us-ascii?Q?5u2zrw3wP7Q3Zw0N+HmqAEiAI0fECYNEWBp690bIJng+HSjqaBR0/L/zU/0a?=
 =?us-ascii?Q?Cj8E2IZWGTjOpl/dr6DfC10VZRn4+DoOPUNMN+QeEjEhjh2F26W6B0aFij+H?=
 =?us-ascii?Q?pjate4YsBF78z0ro05cApQldALNwmxFHmYIIzda4aGnQJS0MPaGIhK3VvQCj?=
 =?us-ascii?Q?8ldJ6V2hQbahMdlgWTnKCitE5sTsY6v2U2a6I3k6bMGgkj0JJQ/K9ykMF8Xg?=
 =?us-ascii?Q?fLTf+jmOuQ7I5ymaPFomPQ3qi1yndkLPULj+IqjqHXcJN7WdWvijA8gl8mrf?=
 =?us-ascii?Q?c0vjTl1FzsEn44Y9oyonv+qFzFuPAXUmRqseItzv8+e16k0kUhn+vytdxCUX?=
 =?us-ascii?Q?n79WzEIyRTh0LpSfxARWFQrsk+zaRCleldoUK/AeWxW3cTkI4pNEJccv7M7+?=
 =?us-ascii?Q?E46dlttx2AgqH6TbXwu9dHACXDEXDdNYDulGQaiHDy6O+UVhFn7ovMQmI/OD?=
 =?us-ascii?Q?3WN1lG1JS3bC7JhcmBbtJmtzUlx01A92NXuf3eODYFKxXNQr6Va/u4fNmph4?=
 =?us-ascii?Q?I8JXJhhclvk7UmdQSKQFJ308Xe8KMO/Eep8AXJjP/n56R9Fbiu0Yx9rhcAD+?=
 =?us-ascii?Q?+IwtVoJ8QGgLXjiFZzhJtHw32yfeQaZ1uNa1lv4rpKjiBaQw/WnkAqznCkmL?=
 =?us-ascii?Q?XJiP2F70aSf9yQY0eBocgtaH5OIPHK3dyaWPHtXsRUyv8rv7VxKyExksFqb7?=
 =?us-ascii?Q?QcI3XVVQnoV1xYYmUiAt57QyJCyAb9JYZ879s+n1jkF+QgRCsZMY0zU76w3R?=
 =?us-ascii?Q?6RIHzmGJ6t0N5X82qsaACFE2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21382182-2547-4135-b6a1-08d96276f229
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 18:35:25.9353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHc7u94W/QHGM8lD5GSzUg8LnI23KY3HOiVOsjEunBzshuYSU/MokY1lkrBxRTCzHwZ4yYrobeVN1Lh49WdsnHRcvmUFnpSqLMKXSC/V+ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5596
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=780 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108180116
X-Proofpoint-ORIG-GUID: Gyd2TjD4-4FMg1vGcvo3PBu7--Qoh0SD
X-Proofpoint-GUID: Gyd2TjD4-4FMg1vGcvo3PBu7--Qoh0SD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> Native copy offload is not supported for stacked devices.

One of the main reasons that the historic attempts at supporting copy
offload did not get merged was that the ubiquitous deployment scenario,
stacked block devices, was not handled well.

Pitfalls surrounding stacking has been brought up several times in
response to your series. It is critically important that both kernel
plumbing and user-facing interfaces are defined in a way that works for
the most common use cases. This includes copying between block devices
and handling block device stacking. Stacking being one of the most
fundamental operating principles of the Linux block layer!

Proposing a brand new interface that out of the gate is incompatible
with both stacking and the copy offload capability widely implemented in
shipping hardware makes little sense. While NVMe currently only supports
copy operations inside a single namespace, it is surely only a matter of
time before that restriction is lifted.

Changing existing interfaces is painful, especially when these are
exposed to userland. We obviously can't predict every field or feature
that may be needed in the future. But we should at the very least build
the infrastructure around what already exists. And that's where the
proposed design falls short...

-- 
Martin K. Petersen	Oracle Linux Engineering
