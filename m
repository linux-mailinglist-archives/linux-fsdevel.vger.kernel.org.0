Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA206E8947
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 06:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjDTEtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 00:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjDTEtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 00:49:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A84489;
        Wed, 19 Apr 2023 21:49:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JL46sk021768;
        Thu, 20 Apr 2023 04:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qefpC0mLGgtV+7qTrT0ob+cKNRQ1Hhnz/cnOpADnH4w=;
 b=FpdqH6HpgFCn7vZCxfRXAoGQChuCo5m3o/oh9q+DJ2p8mKJJLEOMBRDagoCTJVuFhF2v
 tB1U93z/v2bEWptiGqpdCuQTY54PXHysIYwxv4DtphE+w01J7DU/O87ls4T0Qa9WUjNo
 3Lk5L4IDHbnd9lbd77pJl/6E8Fh9dDPLSxERc/j4OA8sorcQsrMbsx/gLhFTZQUepeux
 jvEVGFdIvYiVo4k8Wwfd/BKgNIENHHvsz6Is3HjXyoZlbXLlsZ8Dx+f34aFMjzm4QI0o
 aoqU9lDDG5fh2g8/XFRhGmcxf2eDtTkvy2Pf4iCNtpzK6r7RgCP6HvJyhaY9WtqyjzZq WQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhu1ud8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 04:49:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33K3SSLw037233;
        Thu, 20 Apr 2023 04:49:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcdt427-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 04:49:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjeJQ1+XGWxPyNxKJ3EXK9d/qeyQPQ9NwgtYQNfguElPZcc0zHy6dZJFh1nNVPMHLgZ9wso8E5CzBRdI7iPP2jy00Pxbgzmh8HF7s0EIJkDxgGW/FPCZWh6BrlaKp/nTj+ZUgYxQuFqEI9bUduAyEzALp/ly5mpayoiyW15dkm6wPiFA2ab4UQOGCYw7FEle1JgDzi/GGuF38BfGRZfivbb1hRcr7y/WAfC5CK9GmypVa6IUAPJXBg3HbMv77zyn0CUZ0icL7wdQ5L9qxcY0rDWQaxDGiQmclEd0hX/Wy0SnbCrs4nTu3vIlLhepFJqVBQtzpa5NXoVHYFIUTs4XIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qefpC0mLGgtV+7qTrT0ob+cKNRQ1Hhnz/cnOpADnH4w=;
 b=HCjf3OrE9N9P9+yomZGcTN4RNNgHXP6RPootiMamyVmNyK9uhpzRPgjycjeVln/M+t1LkCP1untgigioWfK19jHSaBZXikMH7oqGGzrx2evVGHzLEEfcd5TLCqC3sKyy0G4hdP2pxgkpBB8q4XiAiwm4ozL/6m7Zpb1llsRnGkMkCqpRccAxLu19RE9OthqZxOcN7KA3qjAdezEjWWe2jzBDsnB5b/vkNvM/0b4tDTAzTY0457LD1FMoDhgwT9NEMTdilGAS1zVtK3T7r8+iKhL41MpyZBzuSYdBaDZkaE6F82fj+2y/lJlL2j/eIAOoxIQX4wgGqD+TwibbY9bJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qefpC0mLGgtV+7qTrT0ob+cKNRQ1Hhnz/cnOpADnH4w=;
 b=hlWYmROp9Js+PGpF1y6bNNho1QFJk3CL/+zITgaGEbcHguTCVJl+HoO7khj+DtP3rUVmxNUNUzr655EctdEihL3M0fnx2Bcu8TIngMScmmrPkMi2cZz8AGb3P+lJ5cMcOfWbnkCh8FSHivhwHApJhk74OJsDT/jRhefUY/2k5BU=
Received: from SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:22b::9)
 by DM4PR10MB6693.namprd10.prod.outlook.com (2603:10b6:8:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 04:49:30 +0000
Received: from SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::1827:534d:7d96:20f1]) by SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::1827:534d:7d96:20f1%3]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 04:49:30 +0000
References: <Y/5ovz6HI2Z47jbk@magnolia>
 <CAOQ4uxj6mNbGQBSpg-KpSiDa2UugBFXki4HhM4DPvXeAQMnRWg@mail.gmail.com>
 <20230418044641.GD360881@frogsfrogsfrogs>
 <CAOQ4uxgUOuR80jsAE2DkZhMPVNT_WwnsSX8-GSkZO4=k3VbCsw@mail.gmail.com>
 <20230419021146.GE360889@frogsfrogsfrogs>
 <CAOQ4uxjmTBi9B=0mMKf6i8usLJ2GrAp88RhxFcQcGFK1LjQ_Lw@mail.gmail.com>
 <875y9st2lk.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20230420043214.GF360881@frogsfrogsfrogs>
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] online repair of filesystems: what next?
Date:   Thu, 20 Apr 2023 10:17:02 +0530
In-reply-to: <20230420043214.GF360881@frogsfrogsfrogs>
Message-ID: <87pm7zqhtc.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TYCP286CA0197.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::11) To SA1PR10MB5867.namprd10.prod.outlook.com
 (2603:10b6:806:22b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5867:EE_|DM4PR10MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4bc136-68f6-4637-5e7a-08db415aa0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXMt1UhR28OXbAr86u3AO/gVUYhCggKZzsZjwKIKLfNqd9OrNEGv4oV72T3Gk7FV58Q7rSUktdVpnDtjuNP3ZchLxnS/zPYb9/zS8ZRVc+ZVJM37NgZb5KVYrZbsit8ljYavzo7VJQbAsFTp4TwxR19EvNpfjQgObJjX9mS21d6lm31/mW9qzhh1Gzw6h8A2mjGONwVLDKt6R+fZJrN77mdYY/ickW3wsxC4D7uqtbVH14Njp8UT0jPRdBqCSerZT1MhAkkE7zeyQu6Fcngm1fvL9x/oF3auUby/nN1uPR+6oUlMshfvwUws3xMeJgGffjFt4pDPELaGJ4LFmWskZZH7AZDX59eHl18dYT8hNgkvVc70v6xPXqjhWglRCpeoZ+7KgSINcAEeoqnFpYIDKWMj9o3g+Y6i+3vpfzBBYgnHdgqPNPFO60KOlhYGKWPlQkw6GTpfx6IK7NxTi5ZaWp1v0Oc0X2bAgVzGCe0IBVB22rPsKUlHy5TQxATYXgfw74hHg23ZIV6wGbzs5xsux+HFbTInEpiy/5eVay2uEQbl6W87FdrfHBFsOB77ptA2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5867.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(186003)(6916009)(54906003)(316002)(4326008)(66476007)(66946007)(66556008)(41300700001)(6486002)(478600001)(6666004)(5660300002)(8676002)(8936002)(33716001)(2906002)(86362001)(38100700002)(6512007)(53546011)(107886003)(9686003)(6506007)(26005)(83380400001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0s1anpOODNNeVA5SDFGZjFBaVoxY29uVW4xdmg4WlpFTVdCbGxyeGVrbHA1?=
 =?utf-8?B?L3dETFpDNzlvMFRmWDFHdFk4ejZTb1EwREVRcEFUck9ZKy9KMm5LTjZSd3JP?=
 =?utf-8?B?S3dyQjlaKzQyWmV6RWVzYy95cjdqZVBlNFBubk84dFViNXpkR0FWRitDZjFn?=
 =?utf-8?B?b29MdFhJNmxHTkJ2Y0YybEdMOXFKMTAyYjM2eEZoTTNHOWRsa2lGUmJUbXJy?=
 =?utf-8?B?dUhDeW8ySURVWmlVdFM5KyszMkdoUlJmeDdRSDFMM1kraGYzbGtULy92UXE1?=
 =?utf-8?B?c2QyUGJhWC82RldESEJnRkoyc3RxanloSndEazdwajE4ZEZYNm5OcVJzSXht?=
 =?utf-8?B?Ri9VS3JqdVZ6a3hlSy9FN0p1ZXR0ZVFYZWpXKzZ4cElVbVV2US9qallxQlpz?=
 =?utf-8?B?WmdQTzUraUlmKzR0cW95MWZ6bGljNUUvNFJVUXNOWm5nSVRMcCtFaEUrYUhY?=
 =?utf-8?B?WlcwN1NOd0hWcU5QNTBjNWZ4TWtnem9EMm92ZWRZVU9kcGt6djlUd2RoamN6?=
 =?utf-8?B?Q1IvREhVT2prTVAyb1JoV3MwZ24yL0dQZkExMlN0blRaUS9zblVpTHpWRmtv?=
 =?utf-8?B?bjZMeVQrU2RyWnVvWm5zYlp5RkZyY2hRM3g1YitoZ0ZncUR6SDRHNXc5NGRX?=
 =?utf-8?B?K0dubnRqSTRDMXdEQmFmNnl5SVMwWUc1S1gvYy9hOVowK3QyREp6Vm5OcUly?=
 =?utf-8?B?UXUrZXhERE9KWjg5OFZuYTBxZ2FPZk5iRC9ldzBCcHlXak43U09xVk9DdGhs?=
 =?utf-8?B?bFNyeVdicmVSMEpUNUNOMWV2RVRvYk1UUnhpcDhZU0QyRWNEanZSbTVzUE1n?=
 =?utf-8?B?OVMvb1dwSkZ3ZWhwTU43TFpWV0JOODVMT0FqVjdWYWxPN0RVL2FYWVVXQm5n?=
 =?utf-8?B?YllrYjBvM1NiWm9MTFlkTjliZWpIeWRCWjByOERSWVNtSnBFSHlFZ3ZJSzl6?=
 =?utf-8?B?YURYaC9TV3F5dEpabG5FNWY4ZkJpb0ErT0RlUnJIdE14dGYxc3FiUEd1RWd1?=
 =?utf-8?B?c3RtMXFoNFE1Tlk5SG9yZy90SnZUU0hCektIWEg4YkZQQWphTXJzT3d0dmJq?=
 =?utf-8?B?Q3h6cXpBeXJwQnMxUDdmdzNtU1RSQzVqUTd3MS9kM3RXYXAyZVV1cFV1Ri9x?=
 =?utf-8?B?S1RuRHVHc3ZpSFpKQXAvcmNyZXNLd0k2bGVYZTU2YnljZ09tL1NBSjdKaUdr?=
 =?utf-8?B?RGpFblgwcEJhc1U3MmpwT3JicDJXQjJLL1hRbWtjQWh4cUFmVE5BWkxDWkFZ?=
 =?utf-8?B?UjZNV0JGL29XTGtFcU1rWTdscGdYbnhndC8yUDQrMndrK0tmazd5TnB2QmM2?=
 =?utf-8?B?dFNWSE1TNnFsVjBuWTdYRlRJVituazZ1OGY4RmtqSGVkT0gzY1RHM0J3N3hm?=
 =?utf-8?B?bU9nMCtKbVo3OEtpRTdISDduRXRQcENrWEp4Wk9Tdk82ZE1CNTNKcTM3MUhY?=
 =?utf-8?B?bmMyRkRFbXR6c3ZIU1JaYklKb01obTNRdHRoMEN3Ky9zQ3hzSmY3Ry9zbkRR?=
 =?utf-8?B?bnFxeHRnZ3NEcU9Zd0Z0UjYramdXWm4vTzVrbG9LKzRxTGlKL01OVG5zYjFC?=
 =?utf-8?B?NmdHL204a2NPRnYyaHgyREJLTEsvQWdDd0hXSWNvTUZtOUpLRXVTZWlJeE9X?=
 =?utf-8?B?Z2pZR0sySVZWWFp6QnNBV3E3R1hJOU9ZY0xnNk51L285dWVBQ2JwL2NuajNV?=
 =?utf-8?B?b2tOMFN2eWxtUE9sTnh2cTNxNy83cVI5Y0NyZGNTNnZiTnRlT0FuRWVZTlBt?=
 =?utf-8?B?YllJN0pkUTdITXk1NitDZmcwS2xwT0g0aVFaMzU4a2lWb0FXOWZCdzlnNGhE?=
 =?utf-8?B?N0xWSitJZGcwVDlzdDE4NVhQY3pEbU1VbStCcFlWWXBGdnFFV1I4R1VoUkVE?=
 =?utf-8?B?VitaZlVEQ09GdEhKM2NjWUpKbUdHczNHMDVGWTA5dVgrN0p6UGtTUTFDejRF?=
 =?utf-8?B?ZHFVL0REeXV1d0J2T0RjSXNreWtYZDhUVzVuS0JyajlMd09qWmkxa3NrVzdz?=
 =?utf-8?B?OVI3N1NmckRFT0twSzNSQm51L09jMnh0NjdwTUJpN2hod3EvR2wzOWFFK0g0?=
 =?utf-8?B?SHNXNWlWTXU3M2htYk5CaFRmenVEYW5LZnJwdnVRZFpGUkNhdmp1STB2MS8r?=
 =?utf-8?Q?Ls8oAfR9L19GYbVgadDjgGiei?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e+B5b0S22IVmL5La3YJ457lvhfmP2DtXbfYDrpbqu0OnfoyYtLaWrbIUuWc3YLN0NqF3HvOiewfb21UPSQWQ7QNgoLvTipcc9hEIcr774TEcc73wAVz4qRjf8pDLMDTMDqu3d48NihN3etgyNuP3KFXMmgt19N2jbclAEGCZ/xFdqSDDqCgawhO18h2ugTFcXOx3WdaVe7O7turWBkwVJzfVV/oX365+OteblaEudZB9WcYhPoa3t36ymtyFsp6SelbwBm6zBcLc4p4E89rZX0E30+4s9ZAumBQQt62f/PfWjABeR9rL0b68e+cZUZ1pSMv6BOWzPHORsTWwPp8Gv7CypfbP2/w2dIn7xrASRBuE2LUoSwV6w3KnBEKkLL/80qDekYikrHTNFB7e0BgHg6s4iw5OyjLg/I2NuzL/KLO7KKjwb2VxUeIBprm82/H19QVVeHE1Irt2RHcYU6R4rMok1uZXWI1c7MoRTY/zr79QtI17GknMrzKaHBM/r6AFgZ+Co3zxCp3DvedibLF/nRhGQMQVx0FMdOpwmWRM8kuVFmZMjzulYjWj8FpeH6/9Iqb7Q2aqZzxsZiXiC7Sb4NvoT/1p3wKAMdNefKXrDf1/EISXEDk/oC3nkncL8sbsWcGT7u7IxSfNFj0KrHkVI+jPSe2wkr7B0HOtPXubch2JtPaDT/KCD1tCs/ydLShnAXyEBM1C1Ka3JU9o1HLnyhDMuR1AM3/NFuENCNLi0MNuqTSC45OLZ8uLhyv3aKzA1yyyb4SSisrE0iVe6GXPaXQ98Zu+s4U4zcvSYnSlyk1+friOQI0C1+3E4+Hqv0CNFtSh9KtZCp8XTtfGsmRHVoJ7rxaK3Kvm7Al5MSeuNFAQzmb98l466zzSHsJYB+ijj7xPGZuH/v9zAfH6RhBUxQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4bc136-68f6-4637-5e7a-08db415aa0a9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5867.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 04:49:30.4487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mx8DriiQoHgpTKmciwxHhZ8F0pbk76JQfVR8qnkRw+IQRczoddioDXo7aVQJeCLIAu7zOHloqWkaGAO/dYjUsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_02,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304200038
X-Proofpoint-GUID: jkx9VlmKJ2f5gwUB8YsvYYJaeeoHkukX
X-Proofpoint-ORIG-GUID: jkx9VlmKJ2f5gwUB8YsvYYJaeeoHkukX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 09:32:14 PM -0700, Darrick J. Wong wrote:
> On Wed, Apr 19, 2023 at 04:28:48PM +0530, Chandan Babu R wrote:
>> On Wed, Apr 19, 2023 at 07:06:58 AM +0300, Amir Goldstein wrote:
>> > On Wed, Apr 19, 2023 at 5:11=E2=80=AFAM Darrick J. Wong <djwong@kernel=
.org> wrote:
>> >>
>> >> On Tue, Apr 18, 2023 at 10:46:32AM +0300, Amir Goldstein wrote:
>> >> > On Tue, Apr 18, 2023 at 7:46=E2=80=AFAM Darrick J. Wong <djwong@ker=
nel.org> wrote:
>> >> > >
>> >> > > On Sat, Apr 15, 2023 at 03:18:05PM +0300, Amir Goldstein wrote:
>> >> > > > On Tue, Feb 28, 2023 at 10:49=E2=80=AFPM Darrick J. Wong <djwon=
g@kernel.org> wrote:
>> >> > ...
>> >> > > > Darrick,
>> >> > > >
>> >> > > > Quick question.
>> >> > > > You indicated that you would like to discuss the topics:
>> >> > > > Atomic file contents exchange
>> >> > > > Atomic directio writes
>> >> > >
>> >> > > This one ^^^^^^^^ topic should still get its own session, ideally=
 with
>> >> > > Martin Petersen and John Garry running it.  A few cloud vendors'
>> >> > > software defined storage stacks can support multi-lba atomic writ=
es, and
>> >> > > some database software could take advantage of that to reduce nes=
ted WAL
>> >> > > overhead.
>> >> > >
>> >> >
>> >> > CC Martin.
>> >> > If you want to lead this session, please schedule it.
>> >> >
>> >> > > > Are those intended to be in a separate session from online fsck=
?
>> >> > > > Both in the same session?
>> >> > > >
>> >> > > > I know you posted patches for FIEXCHANGE_RANGE [1],
>> >> > > > but they were hiding inside a huge DELUGE and people
>> >> > > > were on New Years holidays, so nobody commented.
>> >> > >
>> >> > > After 3 years of sparse review comments, I decided to withdraw
>> >> > > FIEXCHANGE_RANGE from general consideration after realizing that =
very
>> >> > > few filesystems actually have the infrastructure to support atomi=
c file
>> >> > > contents exchange, hence there's little to be gained from underta=
king
>> >> > > fsdevel bikeshedding.
>> >> > >
>> >> > > > Perhaps you should consider posting an uptodate
>> >> > > > topic suggestion to let people have an opportunity to
>> >> > > > start a discussion before LSFMM.
>> >> > >
>> >> > > TBH, most of my fs complaints these days are managerial problems =
(Are we
>> >> > > spending too much time on LTS?  How on earth do we prioritize pro=
jects
>> >> > > with all these drive by bots??  Why can't we support large engine=
ering
>> >> > > efforts better???) than technical.
>> >> >
>> >> > I penciled one session for "FS stable backporting (and other LTS wo=
es)".
>> >> > I made it a cross FS/IO session so we can have this session in the =
big room
>> >> > and you are welcome to pull this discussion to any direction you wa=
nt.
>> >>
>> >> Ok, thank you.  Hopefully we can get all the folks who do backports i=
nto
>> >> this one.  That might be a big ask for Chandan, depending on when you
>> >> schedule it.
>> >>
>> >> (Unless it's schedule for 7pm :P)
>> >>
>> >
>> > Oh thanks for reminding me!
>> > I moved it to Wed 9am, so it is more convenient for Chandan.
>>=20
>> This maps to 9:30 AM for me. Thanks for selecting a time which is conven=
ient
>> for me.
>
> Er... doesn't 9:30am for Chandan map to 9:00*pm* the previous evening
> for those of us in Vancouver?
>
> (Or I guess 9:30pm for Chandan if we actually are having a morning
> session?)

Sorry, you are right. I mixed up AM/PM. It will indeed be 9:30 PM for me an=
d I am
fine with the time schedule.

>
> Chandan: I'll ask Shirley to cancel our staff meeting so you don't have
> a crazy(er) meeting schedule during LSF.

Sure. Thank you.

--=20
chandan
