Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC4647D14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 05:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiLIExD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 23:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLIExB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 23:53:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5332BB2B;
        Thu,  8 Dec 2022 20:52:55 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8MIvrY020772;
        Fri, 9 Dec 2022 04:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=4/b5EWQrVk4gYJveQ2sl5jeJXBMIKJH8qATtff6Tzx0=;
 b=gpADOXmL8Z6mIuoLSg+8fG4Noe9JG5JCAJpWFq6jbnRTY28KlZWDtUQNelXHt35lh773
 bwNM+iWDByXA+REuBRJ6LzUBQqgGNfplAIIiFI9oj1PoFwDD+IBJSqROHY2Y04IZetUt
 a83TpY1UYvB/CgV6weJNulXYGQLYxDz61DIQnL4nfYHRItZnu2+Fl9BT17Yn+rmT92iN
 LjAjxYZTNE8n35Wu4zMXwbSsoVAPlOpw2YC3nt2FAqytCnLB8/DRu2Sg/hsBPAcRSa++
 nw6KeJKjOnS4C67yShgQ7Ng0+Ab9L1havVJLEEDrl+PcePIrSsHnPwv2mcgreCtetrnk Hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maxeyumf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 04:52:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B92Z6t5034517;
        Fri, 9 Dec 2022 04:52:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa4t549c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 04:52:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbVhjkQRtPLeOtFO4CcIgs/uZTQlVau2oBBLQmfOgLMiguDL0DLluBQ8ffFvypw/FKBiAhJxqc30TJkKRZ+UWgWHd5EjyU4tG1RWRvSl+KtowcXNRFDeyzAQGRTfDPUuxujCOZKMhK0ujY0NOM0o6Orxi4IaxXHks3vp9N8qfINAI6k1GUpexmNJyRjSAPK5jeFqboX4+TLTdzpFuQw1C0/PsHt1ytqDQDWmC639wgWUxu1T1QIn2VDgD6IFgApo2H47Uw5oeQUAB8UftqM2wss4XnPoWZpCvj7gZIbqsFo7mATlM3ETlhDcbQcTRyzvTwVc8yMGpkn/GrdPr91Nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/b5EWQrVk4gYJveQ2sl5jeJXBMIKJH8qATtff6Tzx0=;
 b=fQVh/XyZ2QGUtn3jXSXkBsFPvhXnaZMPpiFaoFERfbaUT+ONRUZ6R+wJdpTa26ir4eo4aimy3s9ztK1mzJTtIPmkk8YSLY+uSZMSkOl7CRtNl7seUPCS2rxuSsQu1nNlGoP0aWMKthgGgj7OdLX8H9Ycwmat/3PvlN0Mvdx/gTcO+2ZDkLcWJANNq42CQst/xVNpfNYOCbu7cMNh1g2JhNiBlnK/t901FcOIlSayXsZfH7nBYYp6q8roEriQ98KovrDZeUXNYmVPiNFdaOFkFiBzj1Vocb64uwOT49kvhVqVU9l5neEyI8DtEcchc8VOB+wm9o2pQ6o8LXaO271ihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/b5EWQrVk4gYJveQ2sl5jeJXBMIKJH8qATtff6Tzx0=;
 b=R6ufyKwNt2VxXvs/5CLU3ULLAeBLgxVpDTfH+VBR84det6ykI/x0bjeIFy1+4GpGBcJflz8uuTmbkOWhFrLT93vKpKh/7UfC9F2pnpVebkMNPsuXT1wqNDJ67vpVZUg15wlXjnozyX+GTiF7oZbclJSW/lUtAlOsOwXO5vXmeIY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4519.namprd10.prod.outlook.com (2603:10b6:510:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 04:52:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 04:52:04 +0000
To:     Clay Mayers <Clay.Mayers@kioxia.com>
Cc:     Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14ju5gvfh.fsf@ca-mkp.ca.oracle.com>
References: <20220630091406.19624-1-kch@nvidia.com>
        <YsXJdXnXsMtaC8DJ@casper.infradead.org>
        <d14fe396-b39b-6b3e-ae74-eb6a8b64e379@nvidia.com>
        <Y4kC9NIXevPlji+j@casper.infradead.org>
        <72a51a83-c25a-ef52-55fb-2b73aec70305@suse.de>
        <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
        <f68009b7cc744c02ad69d68fd7e61751@kioxia.com>
Date:   Thu, 08 Dec 2022 23:52:01 -0500
In-Reply-To: <f68009b7cc744c02ad69d68fd7e61751@kioxia.com> (Clay Mayers's
        message of "Fri, 2 Dec 2022 17:33:33 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH0PR10MB4519:EE_
X-MS-Office365-Filtering-Correlation-Id: b75e1dea-fc72-4d48-366e-08dad9a11ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6TEzoLR59NioAre16EA2P8x5pYFcTSa1KtmN0Nwe5oeGFAlmZG4PLn5uov1uJRed7Z0H1uhrolkBcg64x9mdnpFT0DAwdlyNngmGRBDBYXzw/1JuSShr9pqgraT94CWAMqTkytwot4CtXvAxCS0JnTju1e1MV+/B+EfhhO0go4ledRTo/05UdqAhMg+J+xVolMA7k1kaPDgc7qflU7w4hYQ4otUa3+a68XZo4HLGwr4Mnr+I0GoEbqaZ8WkgyOYXecydqYntPYRbM0ayMdsEt4nw/HBJ2vcwVceA2a8rliDcyygDgh/7qlWMBPQxwrPS6CkOuwtXZ1oQT23FiejYHuV1MC0mhpW6bqrSCrf3PJcUMS01wfnhNsL8c9JI6HjkXuOkwpYoK0ZJ+sNJ48w97SAwqtkif3ur9P8I8sIssVAfUXq2oMni+jWd9AWaImTGymjbJD7XFTyT1RyrzjgJE1qFzyoFwuyK3VKOHo66y9dk7bP4MxvmXDQevrs3aC/VhQFuWz0J9VdmRTD614DPtz/t4PGJoEqO33Tr+JsfmQyKLtKGoU6BsCk0/hJu/aE+xrTvFpPFM7gguOUa6fwKiFVO6bAYYdZH9KUyhf1U3qIPII+ijCgOe2hfeS2RoJRyH4+eySI8Sfvq6ynEh9swg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(6512007)(186003)(26005)(5660300002)(83380400001)(7416002)(2906002)(6666004)(6506007)(38100700002)(8936002)(86362001)(36916002)(478600001)(6486002)(316002)(66946007)(4326008)(8676002)(66476007)(66556008)(41300700001)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X09Y8iyzGLywYlR59AoP8hZUEgM8ss9oYON9TW2BxxGjTXrS2b5rBRApus0E?=
 =?us-ascii?Q?oRxQTCPtYjuHuPI3rZ4HY2x1xyyhrtMGwA7BZcrYRA0vMvvZKO4inw5puJUA?=
 =?us-ascii?Q?p9XQEGl8Bm3wzT8kiyw0Ywv4H+OZBQ6JRl27X8o5ATsDLwqYpr4f3iL3X42V?=
 =?us-ascii?Q?i3/KkgvQM81zuHDxTaYUoXeCRd52tyRi3vGWHDMxfPP0n+3Vf7jBE7VhQljL?=
 =?us-ascii?Q?cu4YxneJkb+OuBYhfdfOlKtMQQ2o3WK/m9+wL/thTmIskS2+40oEaVmFcRms?=
 =?us-ascii?Q?2uQ596x/ljudGAnWo9ALSXnOYAob0yZ1BzYHtSYmPYdFao3jzUxE1cmVtXgs?=
 =?us-ascii?Q?+Cy/x59W5W63XocqO0eVu06b6oZZiDySBp6RLZRe9m7iFKFFIvoY31/AYuTF?=
 =?us-ascii?Q?U03l4DM0VCd+i+xzdJ+I8uMrOtpxhgJKm4LJcaFuSPhTl4z9jZyMq0nLEA5M?=
 =?us-ascii?Q?D1CLLFewAdjGvHfIih1cNtn3/KPI1LLc5DWqtTRrtrI4TKD8F7zB5QxkBuss?=
 =?us-ascii?Q?x8NUUysnCk64C3csOpwu4ZlLMut02UrzDWpl2W3DcIam44aTu4gsnpfCb1hN?=
 =?us-ascii?Q?sppZknVDn+G7/IMYSpeEpmMazHg4obWm9sYiUpzM5jg6XMTLzU7H1l/630sL?=
 =?us-ascii?Q?JEXUKzSqFjXya5A43qt90jGBVbTF34MxWQFxdd5IRJC2bfSvGYHZKqo0qTpw?=
 =?us-ascii?Q?/rSmuX9y9mF/ru8D2NY2gaqbQu9b/Fp4EG1VJmuxuf+ki2YLr2P8zmsh/eJ/?=
 =?us-ascii?Q?Upgdc+cUncr7e+il1/h1Sd/7+LtJd3bPGJwPxMXYdxZP01PSIULwd9XScy7z?=
 =?us-ascii?Q?C2aGlv00e0H+5ODyKklaH02pMFMXooXiiH7RAJ4HV8fSsGoQvipNpRiAJ5lz?=
 =?us-ascii?Q?SHwnHNbV8oFu4wz5h7m81DXccrTNqftpml7aCdJ5bhN5kXsJb1dJ1dMmbI3y?=
 =?us-ascii?Q?2a6zLqqh0MMJ4do8Kl4M4y5NRbOgpAVxHrk0OHtAlS68t2rpilEZgUSEyJHD?=
 =?us-ascii?Q?PyfdHWFbbPLlI+8Hx2iRqz4Ew3+ajwDFYICJQpEpuFNKBzQwyCq7pO59Y6vg?=
 =?us-ascii?Q?pwLN6NqTHzT/XZt2GN2JTBnnmKo7bjgWc8FMTzD2F7Xrdvj5TN3MfzlCmaSN?=
 =?us-ascii?Q?Yk/FxoW9DNVmDUBVS7sX8GcqtD2Vdy17Lqyu1UOtLZonzSSq8HzB3AwqjZZT?=
 =?us-ascii?Q?e5oIxjBWc4GfNk9Y6SdIOmWgATDI6SRndmSlrb05zeKvUZRU5bhRiE46V041?=
 =?us-ascii?Q?gBnuiYFf6Np4Jw7ZVbe078ty1RYw/TSihZ7qQGznAFemsTp/fcojmoyoBOHu?=
 =?us-ascii?Q?54xs6buflVBn/60cD6Fi2VZE/hisl69z1pq8whsiLJR5tAjYVwmi19Qh1pqQ?=
 =?us-ascii?Q?rlb40hks9/OrveeOtv5wjKqfzAl4pCi+fjZ4Iv/y8e03LVduDcSTqBBuXglk?=
 =?us-ascii?Q?GnmP3javHF3pI1yADDjVKF91W+JqZHpfmfzLtF8JGe1Ka1gYTsJHo8LLnJvO?=
 =?us-ascii?Q?JVh6WhdwQyBpERre/tCzmJgnOuVMyPLyTM5BxeDY4LvOkRHkgPrMFEIAswaW?=
 =?us-ascii?Q?h520ckSUNoQEtFBlvu3R1QCucYXvl86aQQ3IY0QXtt9vrDXKRL9nzKqx01T3?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75e1dea-fc72-4d48-366e-08dad9a11ddd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 04:52:04.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8b46e/xukhgjrwRkpxWsyC6qc8XL6Dl4eRvN54Wk6/MF+euOvlAoj2CaFbzqGsLj8EriPn+EHIT8NobpQdzStKGvdiSafI8DhI9oqpzMIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_02,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090040
X-Proofpoint-GUID: OUUAHpqYMdFKZGqvAU8MU01A32J-IfMl
X-Proofpoint-ORIG-GUID: OUUAHpqYMdFKZGqvAU8MU01A32J-IfMl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> My guess, if true, is it's rationalized with the device is already
> doing patrols in the background - why verify when it's already
> been recently patrolled?

The original SCSI VERIFY operation allowed RAID array firmware to do
background scrubs before disk drives developed anything resembling
sophisticated media management. If verification of a block failed, the
array firmware could go ahead and reconstruct the data from the rest of
the stripe in the background. This substantially reduced the risk of
having to perform block reconstruction in the hot path. And verification
did not have to burden the already slow array CPU/memory/DMA combo with
transferring every block on every attached drive.

I suspect that these days it is very hard to find a storage device that
doesn't do media management internally in the background. So from the
perspective of physically exercising the media, VERIFY is probably not
terribly useful anymore.

In that light, having to run VERIFY over the full block range of a
device to identify unreadable blocks seems like a fairly clunky
mechanism. Querying the device for a list of unrecoverable blocks
already identified by the firmware seems like a better interface.

I am not sure I understand this whole "proof that the drive did
something" requirement. If a device lies and implements VERIFY as a noop
it just means you'll get the error during a future READ operation
instead.

No matter what, a successful VERIFY is obviously no guarantee that a
future READ on a given block will be possible. But it doesn't matter
because the useful outcome of a verify operation is the failure, not the
success. It's the verification failure scenario which allows you to take
a corrective action.

If you really want to verify device VERIFY implementation, we do have
WRITE UNCORRECTABLE commands in both SCSI and NVMe which allow you to do
that. But I think device validation is a secondary issue. The more
pertinent question is whether we have use cases in the kernel (MD,
btrfs) which would benefit from being able to preemptively identify
unreadable blocks?

-- 
Martin K. Petersen	Oracle Linux Engineering
