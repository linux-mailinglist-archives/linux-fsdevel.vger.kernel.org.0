Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D8D727429
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 03:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjFHBTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 21:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjFHBTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:19:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D226A6;
        Wed,  7 Jun 2023 18:19:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Lloto011754;
        Thu, 8 Jun 2023 01:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ZeTayBQmXEfkeiVK5cec74SvX2/0lEMAt3GDAZktehA=;
 b=v4/CXlJ/iBy22vMpAp7g20FImsP9uXza8CjxceCn+7u8u1SZeK+aS/1jsQFbvJQgTx23
 8cJmTZky/ScfZHWmcj5hOAnoEsN/Q1PyxPSPsl+entrheXNxcaXwnjzAQo4jKZOQp4bh
 phUnMCBmuc2LNvabK0cjYJoTEoDIfMpYtkiEMpt40pyggrFxsQhwWoC8ohhvoQLPp+SF
 FSBxFDCHr1v+sHSGp7O6+XJcdtfwuSg8BvDx/2vj6V8r7OrqwHQdzBaSnrlNfK2YRvaN
 zuoDWXwqKSHoEEWa8qt+Nocv72u4ID3DNB/6FEhii8OWE7Tli/dUZB9DJI/o9IRFey2z Hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uu5xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:18:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357N0Uj3036079;
        Thu, 8 Jun 2023 01:18:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6s83n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:18:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jossdO/qKI0U4ernIBKP50gSJiLmNi1TaOi/DdCytyo43vBJit+YZCgmBkO0/Ejumj5zmEBBUeF6H+WH0z4HqfFeFzwuVdbMzjzACxCFEZEMNoknoSkzvb0Qet6k+CRciDZROp3otB1tnqM0aD3PtMKwLEvnNSRLocxZtDAsTT47V66iGTTmtS7uKuXwE4EM3MJUpSFEY/U0JAZfXF2AbjP4XSHfTQZK3dFp7Anu3bM7Vikas1kjJ8U6q/qQT4PcgsdXY8BTg2374xPy8AlwjoaJLmXIOwcoCgsX2Y9yWWi0EXYOFlhP/wcy6ZkL1OHod6o+lBSx2DtmXoLQx260VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeTayBQmXEfkeiVK5cec74SvX2/0lEMAt3GDAZktehA=;
 b=IArL/SAKBFnAucN8gsldKQ9IhJ+thKsQ7quGGMbUjXYrWwiHxDJ4091cuNlkr3s+pzZ+SOMU0Ydgn4UqeNSXfEsqaqa/gmeejLM/PvX+lfvTAvNzbEsT+6+zozdE3cfftd7Y7xVsOkHHiWYdX5IMWXS5372o7zPb6RtMkTYJSUuYSDe1skUQHjKYwD29r4YBViyPuIhZvGlRCb5Vbd+cAyJdC8pKcNMqFilgRlxnHM3P42er6Fd+IqOZEmSAqUQ+RzonYdRJDWg+rPvcdaHBnDQKRx0dLzkm9srfB3FHKB1gjUyGulm1WcuomIZH1mSMDFAvQ/1Ky44bNkUEeQCmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeTayBQmXEfkeiVK5cec74SvX2/0lEMAt3GDAZktehA=;
 b=XnamG+cZow3vCiLBE47Klt7Bl8LKFa0t2auFId2oMR53kybnv4W9qaIix2fHyxfOLp2HzdKXUxJIiTZC35n1fN7D1HK4ZRCNrecpNAPRNLaMqDpAmWUcbqKAIHbXmShhJ+88xB78hWaiyicnEL7IfOsc78YrYGS8D3xNvpgEYrM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5178.namprd10.prod.outlook.com (2603:10b6:610:dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 01:17:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:17:44 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 20/31] scsi: replace the fmode_t argument to scsi_ioctl
 with a simple bool
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq1cz264us2.fsf@ca-mkp.ca.oracle.com>
References: <20230606073950.225178-1-hch@lst.de>
        <20230606073950.225178-21-hch@lst.de>
Date:   Wed, 07 Jun 2023 21:17:42 -0400
In-Reply-To: <20230606073950.225178-21-hch@lst.de> (Christoph Hellwig's
        message of "Tue, 6 Jun 2023 09:39:39 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:806:27::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 95149025-f1a7-426d-5eca-08db67be29b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHr4PJiuBdxPkU+OkzIAheyPTcqFitLPfvdWpQAPX/xwAPXlVgIyJjoZqWFlnLW47nPPNXbrMw83vWrqYalQC7QOzRq2Tbev7tYdrJF4ZGTepFsjeUQUAjHNFldGGFSuX8NLyd09MSYtWPD5Rpz596+VpOkIoA17M4xevcO27/wet6iY62jA2enc3JiWyTy/ip5WBeL0BO+YR37DEdN5FV+Qm+taJEFu5SdvNYv39ctv1euSp9m2TpgewtC6JTCPM1pFbo9URgBiFhbX3yIj3JjXqamBI5MInSUCxm8zIvQXL86pbFWJCrvPHK/BIZDuuAnPf8KwBUM61Igo5UqySk8Km5xd50Bb3A4H4xo50NCjXSSUmeyaZSqsWmaqm+OS7Y7SZoX4sI4+wk5GVVeU9W7mtgUfTFXO0Uv9STRIE3P/yGl3XHySiaa5TvwvdaYj+shY5hqkIph9ozwzBmOcqhDyMZYP0hBy2uwaMaaByMkXFNDjhu4STr9zx3PEP6hlVzqmPEPVYVaoZmshAM3jlUggw5Zoxxe6PtO38pBE18s3bBFJd4mE5odterfZrUj5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(478600001)(2906002)(36916002)(6486002)(558084003)(186003)(6506007)(86362001)(26005)(38100700002)(6512007)(5660300002)(316002)(7416002)(41300700001)(8676002)(8936002)(66946007)(66556008)(4326008)(66476007)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JFSrfnvMt6xtK974k+LwP5tyFPC3wC6YzgzlMi67OnWxTLx7C4K2uNMcf7VJ?=
 =?us-ascii?Q?WZKJ75h3GJFw2h/EEfQm4UrPwu5chTiaUo9wWkyL2adXM8OXpQ0uYYtdE6a9?=
 =?us-ascii?Q?365WWl8bbkO7BlvQ4Bitzex6P+9/NNTwgKIQKpGsrRSY9uwMN8rljwkpUSE4?=
 =?us-ascii?Q?4eTc9Q7/DSChV220aN17o15PmVLcpIxUf7Uztc3GNTORLsh9+e6rTd81U4u7?=
 =?us-ascii?Q?fJb4MfBYB6yJ4GwghPyR71f5hepENfxemGugXJiX4mtwkFYEOcGGZL21nvEM?=
 =?us-ascii?Q?Bu7ImSwZhK4KYPxs3Ad+NYZSob8AYCiWEEj90LHKJShD8lra82DIeYTZ1ZaM?=
 =?us-ascii?Q?hs/rbpVPKkxSX/ENRq7bqNq1BnRnpw1WmnaAbVDZGRH0ghr4bUFlU7soMnfq?=
 =?us-ascii?Q?eOXHS8JE88Rc8FpJwOaure1Ut+/egnWZEq0chyMvG87oM4OMT+w3uZbIil+m?=
 =?us-ascii?Q?c7cyah9tiUqGJYDmpA8sireuAWJxAfVsme41TYVTZXiolsuH/jca821n++fE?=
 =?us-ascii?Q?L0GekIoWLk/frqga8rDBWKvCXoIJKz2SR+VXsotb+iA7bJRNvKl5lD5MHODZ?=
 =?us-ascii?Q?IKilkGevqB4IGNDZTKBtfgUrjeBeeLo6OxpWqSXe3Rrk1vOl5f7HmIvPmtXB?=
 =?us-ascii?Q?Rla5aPO+gi7l948ZfVtm1BmH6ARoZKEuQhoU6DKhnwrJkI/ZWWAFXUe3cAwS?=
 =?us-ascii?Q?1aW9KxB8U7bG5eP6fz9//1j0nvtdO5YaY+6oPgNYcx3nDY3vAImR/m2JznQ6?=
 =?us-ascii?Q?OcgEqMMzkGQg72zrqdVDIMwM/DparQa8aRUvMm19brAkNDoQ8KTwfcFRk+vY?=
 =?us-ascii?Q?ApPGFfcSY2DHds6xuzOHb1c7TBx7o4W5bakuPd/1iO78AWSql8Q3OlAMSAON?=
 =?us-ascii?Q?06pJODJpVoDF18jzml8a6GoGKSWaNAU2IWg9iAJ+9Sw8/EcfsFgurEjq5WwW?=
 =?us-ascii?Q?EDAM1b/OZRjGiV2z6YWvZpMFwXzq+GpkEqzwslkTtZse+2OCxSYzVgf0i1NZ?=
 =?us-ascii?Q?6gETrQQnMZSLff9l7ynHaJP8bbJyylp4pg5ykSij+fg/2d0KU/NSfh9SDnU1?=
 =?us-ascii?Q?LN33VErOtYTvxk6lRxEWhkC9rfRdr8bwn1CArVccHZcIgsuL1j621uM6vo/l?=
 =?us-ascii?Q?um2RGRCyETePGk4H8sqO1PV8m9qoYNwxmNYQy1h7dFxn9cMTB9Olc/CM+CNP?=
 =?us-ascii?Q?VpqmZUZQiuD0kDv/SDK0sQfAdDDAEa9hGYEiUoV3xOUUMkVPsU82O2/qxhTG?=
 =?us-ascii?Q?RPaA14l+wiaQpJVbuHSXG3EHGVCALOO0UEV4s6IEN5GeBjI+EMe0qoH4VITN?=
 =?us-ascii?Q?3n28kujZlPaNAb4drVEF8ChRksrg57LMZ1AijZXNYaj3X6jvxPlYm0lYpda4?=
 =?us-ascii?Q?GPU0TGc4yzV5yyE2uF44HMDK9agSonkyyjafIGmxdsN4KtbcqnlGanRabj/0?=
 =?us-ascii?Q?uZhP4btkEVNSDJdSs3czDXO/fuzneudN8bmrGtK/8uiDqZd133gN8X3FeLym?=
 =?us-ascii?Q?rtLa28tvCQTugRb00Yri3p8trw/LsFfLOZh8CBezlWzpQYro5HQM1wuVZW9V?=
 =?us-ascii?Q?6E+ekTZb+Y39oWyvEBjDvVJ4CQhlA+0WQT6QvT4Ntg7qlp7xBbNO3rI+1qDr?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dw4hluqD2V8xMKI6LKukaymKi+p3IDc6NiDDLg4/c18PR88Jl+u5rJGA54DY?=
 =?us-ascii?Q?aaH3SLNbl5CKbYMF0kKLhp8x2Ro+R3l1ti82sYOIYSRjvvQ/Ugz1FZ356mSE?=
 =?us-ascii?Q?jCiTPkVX2frcxbIKnManZqCDft/OVotTKLDvjx00x9KJXGBOwLeLiUcrLsAU?=
 =?us-ascii?Q?VAas5FSTZQNKVQAkBSy4/oK/Th278tT4CanxCh8IDrCfVZkNx8ycBPP3LtYX?=
 =?us-ascii?Q?DiBAsBap+TGcdbaQbgdhnY3fDf8p8U+mRwFTkiXX7jZosWFqOdyEMcUU7TyO?=
 =?us-ascii?Q?sHxBonwHwhDr8J8TEgcIwpwuiv0RCdni7Mp33qnzqpupLZ6pE1Dm+MTw6tVW?=
 =?us-ascii?Q?XOT/VD2gIHL1eOmwyExM44mMETYs0i8N9n+Cp0a+dyx5AuSXBTcnDJxwxLio?=
 =?us-ascii?Q?Qa+6bmPMB1X0YLNYBBUlY1wLSGeSEpDgpuNuLAskl6Sc2HTRieVvLzK46iFu?=
 =?us-ascii?Q?mMCknZQiOIPg2yYSKB0u3TKVVuelyxvF2+9wTINEW21BS+hKhD1azsKXJ1Mc?=
 =?us-ascii?Q?SSiS5HzXK9ug3fq9yDTKfEiTK7sptXKBYlVxzJzhRvZxxTn7babK2nfo10Cp?=
 =?us-ascii?Q?e3ekLGrkoJ7TyV1tOXhNYJhOr1TvdY83yGNNwwnE0dEYjfYRO36QGAbT1JxQ?=
 =?us-ascii?Q?ez/mUgetTHaxgyHck6xHcWseROZv9BqadFK0dssjrJ7gVSjnRKrGonXddi1k?=
 =?us-ascii?Q?Oyzg+6HUcsT+O21phcEOfRmFK9UKwbJNLEnIUgBLAIWdPdYk3dPxVNxOq7Ye?=
 =?us-ascii?Q?VH89lzaccFHqDQNnnGbGboNi8YieOA3dBUuJXYKH25+wNAX56iFEEeAjyDoU?=
 =?us-ascii?Q?FbpZVwXB2iJd2DdRf0dcnl5+nRs+dZaSnFmSjFdAjPxdhe6TpleL2VTZoTD6?=
 =?us-ascii?Q?NWBF8t/hYGr1L5SogX4nt6azJeYICMQ5u83CRrRPCgTG5WIHiZI6jRvmK/yI?=
 =?us-ascii?Q?1zcPC0+YJ1hYz6ky35OJPxzt3cEqx7oAuU7StG7mDdUpbVd1l3CQ5GrvNMzM?=
 =?us-ascii?Q?iaLxfR/DrM5IDOQVPS2Ti/F4aluTqXZ3qynghoVy09jdgo3Y9ybS/QuekfuU?=
 =?us-ascii?Q?HxwXHCIjsUtIY2gFA9Uv8PM6sl0mPfgmu1006vYGh4L5bl8jBCaAUboMJRuo?=
 =?us-ascii?Q?6w9G4H9Cu4yUITnEa0vQal2CaPBONlfAdgK3iSC4nRSaNzdkg/jMgITDMAmS?=
 =?us-ascii?Q?b3y6oz9ezU0oukv309kCWBy0qMvqOSv3GkBXuYwuJIFPOrjd9IALaBMkA1fy?=
 =?us-ascii?Q?gGgV/Sl0iwjkMk+a7CsVNIqWtxXnYVRFDPkm/eOt+g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95149025-f1a7-426d-5eca-08db67be29b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:17:44.5464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/mBxl4kAC7K03arlpZbXvYy5yPOH9URQqnF8oecWfVJtqKGxlFVN4Bx2shSbNg8xfedhgcEJ7xsH8HpiUy+rnVbVHHV5LviWdwEFkhgI2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=586
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080008
X-Proofpoint-GUID: t5Sxa2kcG8KtrIuHyhU0JT1gZ4EqPu78
X-Proofpoint-ORIG-GUID: t5Sxa2kcG8KtrIuHyhU0JT1gZ4EqPu78
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> Instead of passing a fmode_t and only checking it for FMODE_WRITE, pass
> a bool open_for_write to prepare for callers that won't have the fmode_t.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
