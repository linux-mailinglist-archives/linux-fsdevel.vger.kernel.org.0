Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4F797D49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbjIGUPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjIGUPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:15:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDF61FD9;
        Thu,  7 Sep 2023 13:15:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387KEPhm006932;
        Thu, 7 Sep 2023 20:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Vyr0XFwEsTXL2aczHSMUTeYji2kHxh4f/khHzYkISFw=;
 b=Xp0sSC+YypOtsaSzPj/3e0Uy45x2MvSYWUytleNOBkuvq9kpBihEgtor9bxvMV1AwHRk
 MaUxVKJficR6mjomB7WXPF23iWYUJLrw4c5ipC20QxVFq5YNZIKCBLKWzjRHx/XqPNle
 hNDZvZFoJ8u8mf6D/hdRPscwnLKMgQsETAxXH1wvwKVOsHVC0MqJDsSROK/BsViDla0r
 DRJdyMaBtE7rhq40ZxO0jzXD172OXRBK8goioRI3O9oo6nLIc/JJPA42dgdZ5MPgthzx
 bsNwkckzUgopcOFRXAjsBwp1blCej9oPqr2FAIg0ymHrbcMOOWp8wrkwBDezEhnz7l8C Sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3synae00as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:14:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387J85XY009378;
        Thu, 7 Sep 2023 20:14:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3syfy0e6q3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 20:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1wiktsufC8moyZFtBk9URdwtOAySc6O9f9ym8e68I2u9tgYSJzj7n8qEolq0m70Rov/Df9uA4KiUKtZq1fVxTflRzP4UT6lwtnwhScHnEd1B4SGhS8MP+l42BvkoPqAYMgKV9Fh+EP6nPOuaI6kuyVO1hde4n6Sud6d8QLbeK8DC/FBta7N4licA5Lp1Y3J/tgbcvzY6rE0jjk9hbeB82tQOtkMlQuN7O9KNWpIiVRHcZu9x2B2oJWktXWT7UY33p+3sO3fQpx3FpiGwku1JA9SUFk3X1RhY5W+Rq+yuNxwrYg1vWMHyXxB0m/m1LKLn6T94umtfSF7DKuATuXttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vyr0XFwEsTXL2aczHSMUTeYji2kHxh4f/khHzYkISFw=;
 b=f3vKzStGJQoVM69Aaho7TYq9h1vy+4gofaZTrenfpsthMOhHb9JabtpLlGPmwcTi5sURS1ipatWWsHCClIY2/QXTqMnY8F9XGIFANm+t67wt0pLDLd06Ig9LVozgMo3CvJj2hshGgwMT9NLcKGsKXmE9X82VEuFIxurnNSEGYfaJkUZe5JsuR+O8K4L0A/742m65Fzyaea23KhGzQsNjdRRFmpN1VHbOUHxd90qYeAuXI8YvKLxwRTWuAyfr2d7II3ySgj77QKgs/W/Z88FXmZK6az5FobkazcNZPE25aD43Imi1/J1NoDSL/Hepyi1WJZRjCbRCWAD3HnwmANQUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vyr0XFwEsTXL2aczHSMUTeYji2kHxh4f/khHzYkISFw=;
 b=Pz7FmlivtGO5QcITsy3Bg+7WvFD7rvWFjq7AVXb1swzkeE5LBfl7qjs1C2Zm/yivVDCpZTyZqp9ePHzNXVVf6J1T77r0FMf+5SNGNDluQVuAcGqy+DgnB7UzPOEnCM6MXqYlWEtTkO3tslED9XQEBVOVzYtKdt9MU3ErTSc/fqg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 20:14:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 20:14:17 +0000
Date:   Thu, 7 Sep 2023 16:14:14 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
Message-ID: <20230907201414.dagnqxfnu7f7qzxd@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, avagin@gmail.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
 <20230830125654.21257-7-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830125654.21257-7-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0001.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::14)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 8580170e-d73b-4548-ed6b-08dbafdf03a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9o4LZei1lcdHBRzw4gG7a6r0Wvi+Bju+aAYuMvcdvKm+EAayIIa7KTuukMZIUUljsUhDmkQn4xQKYgFXHzkd3MxQ1dN9kOCFpQUX0XMXFAmTvh/Jn6zYoEWovmHCAyS0VdrTlQh7FxuwyuYZVE2In87mLYQGvbhI6rFOWOXqF3vte2AzVfxScVFsztLXfKtT+ujILatOaBoXr5P3+8Gu5/XFKWiIFE5jMOP4SjlReQLC0hwKgJGYnl/vE9TvudPQdMzK9eED/BArGdsuch9zAQxaMdsKdlN8odnf2tYOymFt7P5daOHnVrmELnGqEDcFUSLnbIeHRhLzL4X0FN61JDICrCVJoNABfg51BROi84g/0yzHNfHPz/Fx+/REzvV6PP+ZFKb4S/GLv9XnlzJ705RL1/zgyJhgrJRqKGWwsfHt7q15mEcJ/an2jmgU1H3I4VaEdKNBDXp0BmlORIsk5zT0rbWLKBzseuXE+/49OhmCe38FQWw8diHxczkFOsZ3SRtlpiDlE5TeMbST+zGvKK+R8/IFx393PtwzlSaa2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(366004)(39860400002)(376002)(1800799009)(186009)(451199024)(33716001)(2906002)(5660300002)(41300700001)(86362001)(7416002)(40140700001)(38100700002)(8676002)(8936002)(83380400001)(4326008)(26005)(1076003)(9686003)(6506007)(6512007)(316002)(6486002)(66476007)(6666004)(966005)(478600001)(66946007)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4CyRwBv8oeSzxna99hFssWFkXQWpkzHHgYniL6wQI0r8K7FKl5A0UOLD82xA?=
 =?us-ascii?Q?RgeC707gcqsxXJURBno31WzS3/nmXdeN8JnaYJ3JEoafxN/IqVBJSPcPEBEz?=
 =?us-ascii?Q?AR3Upzmgu2LEgjbz88tub61wLWfdipHTVtRVDNeNJKxCo7NFGIdZl8lt54+f?=
 =?us-ascii?Q?KZ6PYWzwHchyIJOEVIEGKniHFA92nzDf6/2apbRg1aUWG70uLVwgOFG3CUfQ?=
 =?us-ascii?Q?QRAqKC1r0czYR6FRAKKsF5Y5JIfhPba7PGOeo3zUxdoTMbsMZ9eQFsLv5IK7?=
 =?us-ascii?Q?2U8Raia1Hf0XFYZaMzjJaANY4urvGux4k7Jqt3IZ/aNuBN0ehaG8tJfBDUjA?=
 =?us-ascii?Q?uvevU75uS+77RGItpPqgWt//j2X16jJp8CG7dT3z6mPnevKBTxqPMEctYl97?=
 =?us-ascii?Q?SGsiL3gfdhdOk2kCUj7xtFzSTUBoa+kIycqc5KRMvhzeUqVgXvrX+IiBJWYC?=
 =?us-ascii?Q?l88dCZR9+f7517i+ySM+iCczK0K7ZWDVBFWxUZtLQ00srsAK2p5b9ggx2NRL?=
 =?us-ascii?Q?REvY3hKPGq34vBPPYAnHQ8MSbfW6iWgR4ifryDyGXJcYgiCByrPIiHcPZ93R?=
 =?us-ascii?Q?MwHv5l9brepNDYq1Yqj6ZcVyVIpG0rv+YsGdYCD+q3AUyI7KaDryaEnpLOkY?=
 =?us-ascii?Q?ZYeyTPh+w5Z8vUMnSCppo8FCxZ/vrQjU198w+cypUPfK8CL+m5mmm3xGeRBx?=
 =?us-ascii?Q?TAZGGO9AqjY9SF1GKtiFX6eKp3qKigc2eHlapmT+KTsFqbggm49W3uajYo1d?=
 =?us-ascii?Q?8fadUGztKGn5TbFrfo87Im7N1l5LIwvz3UOni1JW/PrbT4lD2lgJ2m/FuSpg?=
 =?us-ascii?Q?9e/ftfn3zzhD81sbokyAvb0mdmuLwufgAO/AEPycEg4DrU9+jtk4TxkH4LB9?=
 =?us-ascii?Q?Y/lu2MVSOsLzHRWh5v5c3oW1ckV8YUBWZG9RpeSgOMXVKkYlA/13k/BlrP75?=
 =?us-ascii?Q?4d0xYFIRPbU3XdYAEiIT9JcHi46y/8JlWWGPkbKcxFYk2TgBp9kVkluSE9X8?=
 =?us-ascii?Q?ZOtbs0IKqSnYlEYGOHMuviWtBcSF4h4H22+iN/Q/W/1eKRdO0z9EYf7FZbIQ?=
 =?us-ascii?Q?P31FZPT8WfB2P7dtLP4qgLSy1ojMWqf5akfLgLTglhHT2n9Jyb+nO9gwro4R?=
 =?us-ascii?Q?9qaPr8sbRGyCXFLpU+e80FfJIFXUJnCu1TAcoOJYqSqVv2VCi2CGReb0Cv1h?=
 =?us-ascii?Q?oYK5HJJwnB5DFukVq1ZSn0PLXWVTU6RL1H0c6AV8t0p9JwKF8apL75Ync4s6?=
 =?us-ascii?Q?eKofhafpjSVJBsjrHPjN/CttxMkkHpcx+tHgj2nk/KGe3vup6cy4W0X3wSVI?=
 =?us-ascii?Q?mMWYgrBKG5rpWY60BNsA+FpQX7DpGONjbXwtOPDr4edrr+3i+Rc/K23MaSaW?=
 =?us-ascii?Q?WRpbL2TPeQTqmvQU9Urf2Jux2PzHLtADtmR73JWjOSCHK+Q/g4Tw9zycEHFi?=
 =?us-ascii?Q?uiLC1Mgy7s4dpn3MdrpwC0BHeFiPv5zwrriUTZyEzwN44Asg5fVSsAtiJxQb?=
 =?us-ascii?Q?wCLLY11Y0lbFrqEivBQDyaAztVFO4VzNF3ZejjFWqyVhjYx4ZQBwBk4Anp9Y?=
 =?us-ascii?Q?GGSsq9FzC2zjMXTbzulMA7qmDG6Y2FFJIV84VlVwZ03O2qKwQAi/16lunO2J?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?77nBZy12Yf/YCuqthOjUsALaO+U/D0mlqgv23Hp35jke9BGgpEtoGALqUFoK?=
 =?us-ascii?Q?vAEHq2BReDesJFe+4iSqnCqgk6S3TtX0P05IDzwx2sQmqHFmyV3rCscpkhOp?=
 =?us-ascii?Q?IgBTVLFkaY4K2zS/jL4KegLa0EsUYQaMXh+wwSH1ZS3ftIMX0tL9cSFEPagh?=
 =?us-ascii?Q?7zYqnb8st9nnGJIr2FTkCfuhWeEDcuWEZUmgM7oWQ09XgRCrL3MK97/jlaS0?=
 =?us-ascii?Q?R9y1bZU7TUwxChkXm9qCRXqaU2+qAI4WQxSaJQ9ifzXETUv/WryIEfxDaW6k?=
 =?us-ascii?Q?xmfFczkWwvaOVBEtCWqeBkMD+HXBBdGijM9Yody7Ao5G4K7RS8/C5p0M0tS8?=
 =?us-ascii?Q?/Nj0cFNXvXIymseo58HkybFciM0Xt87ZRYHxTtmJtJR7f4mgm4L0EjS/x/N5?=
 =?us-ascii?Q?NvzslcC85fyBEktWwEed9rec85/guJnCN1aI4pWRx+d8aRJU9oVp+7TNl01b?=
 =?us-ascii?Q?4WVoQ90MohmL4G+ozR3s/qNmMW25UgsPPqNw4eoSeg176qGDeF0DdpqHRYSc?=
 =?us-ascii?Q?GBYUee8KV145u/GNvpiHAVavD13QFa8AEBmI3RlRsqYWmPX3B+SA5kgjozty?=
 =?us-ascii?Q?YN9u+XX+Sda+PfGABBpr8oDx38koj0rorX0MQTw6u07GoRCkfW5WP9Exv2FZ?=
 =?us-ascii?Q?L5OB4wIkcfindcryn7qBvWQLUblfMN4wpbevfXSOa8Ne3yF7z2bXgnWklmfF?=
 =?us-ascii?Q?KEfPk4FqF8UOk0L5Z9r2WBW0z/z1sKSGDXl/SNRfjsZ2eVoyNVjH5wkiNssO?=
 =?us-ascii?Q?B+IRL7q05Cy8HFwn4zRqe5AXGR/3SjaYIbIOp+sLNslWyNwWIur/CbX6CeeA?=
 =?us-ascii?Q?RLYRrmLfKs87krwfJAFAm8Wts7bb0KAdEI7qw3qkdipls96Swev3GVDSB4zb?=
 =?us-ascii?Q?WUuf6u6CDXvt8HZr4GTcruJ5ivWb9pIyMRcrSTEpxRleUe76cZFCqX05wIzO?=
 =?us-ascii?Q?SYZbXf+kTCs4cxZz56me94z5YNbNm+ln0pxhYtoopiAI1DXRD2+OyRXIzRr4?=
 =?us-ascii?Q?bRVUW3zcwavh+sskgkLcDs2OTIo4/gFLCGYgAN9kfy/vcpVIpIdGybOJltyL?=
 =?us-ascii?Q?xwRuHZ/e?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8580170e-d73b-4548-ed6b-08dbafdf03a3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:14:17.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxEMPRc/gTyS8znd4ngCtFMKShVc1plDePaWvhD6qHsAx3epe4V6fybFs/K4qEPC+gM61TPpRGl8K/qGj97TNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070179
X-Proofpoint-GUID: yizr-NR0jKZCz3w0Xm_eO0qpb5S0Ftz1
X-Proofpoint-ORIG-GUID: yizr-NR0jKZCz3w0Xm_eO0qpb5S0Ftz1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230830 08:58]:
> Use __mt_dup() to duplicate the old maple tree in dup_mmap(), and then
> directly modify the entries of VMAs in the new maple tree, which can
> get better performance. The optimization effect is proportional to the
> number of VMAs.
> 
> There is a "spawn" in byte-unixbench[1], which can be used to test the
> performance of fork(). I modified it slightly to make it work with
> different number of VMAs.
> 
> Below are the test numbers. There are 21 VMAs by default. The first row
> indicates the number of added VMAs. The following two lines are the
> number of fork() calls every 10 seconds. These numbers are different
> from the test results in v1 because this time the benchmark is bound to
> a CPU. This way the numbers are more stable.
> 
>   Increment of VMAs: 0      100     200     400     800     1600    3200    6400
> 6.5.0-next-20230829: 111878 75531   53683   35282   20741   11317   6110    3158
> Apply this patchset: 114531 85420   64541   44592   28660   16371   9038    4831
>                      +2.37% +13.09% +20.23% +26.39% +38.18% +44.66% +47.92% +52.98%

Thanks!

Can you include 21 in this table since it's the default?

> 
> [1] https://github.com/kdlucas/byte-unixbench/tree/master
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  kernel/fork.c | 34 ++++++++++++++++++++++++++--------
>  mm/mmap.c     | 14 ++++++++++++--
>  2 files changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3b6d20dfb9a8..e6299adefbd8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	int retval;
>  	unsigned long charge = 0;
>  	LIST_HEAD(uf);
> -	VMA_ITERATOR(old_vmi, oldmm, 0);
>  	VMA_ITERATOR(vmi, mm, 0);
>  
>  	uprobe_start_dup_mmap();
> @@ -678,17 +677,39 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		goto out;
>  	khugepaged_fork(mm, oldmm);
>  
> -	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
> -	if (retval)
> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_NOWAIT | __GFP_NOWARN);

Apparently the flags should be GFP_KERNEL here so that compaction can
run.

> +	if (unlikely(retval))
>  		goto out;
>  
>  	mt_clear_in_rcu(vmi.mas.tree);
> -	for_each_vma(old_vmi, mpnt) {
> +	for_each_vma(vmi, mpnt) {
>  		struct file *file;
>  
>  		vma_start_write(mpnt);
>  		if (mpnt->vm_flags & VM_DONTCOPY) {
>  			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
> +
> +			/*
> +			 * Since the new tree is exactly the same as the old one,
> +			 * we need to remove the unneeded VMAs.
> +			 */
> +			mas_store(&vmi.mas, NULL);
> +
> +			/*
> +			 * Even removing an entry may require memory allocation,
> +			 * and if removal fails, we use XA_ZERO_ENTRY to mark
> +			 * from which VMA it failed. The case of encountering
> +			 * XA_ZERO_ENTRY will be handled in exit_mmap().
> +			 */
> +			if (unlikely(mas_is_err(&vmi.mas))) {
> +				retval = xa_err(vmi.mas.node);
> +				mas_reset(&vmi.mas);
> +				if (mas_find(&vmi.mas, ULONG_MAX))
> +					mas_store(&vmi.mas, XA_ZERO_ENTRY);
> +				goto loop_out;
> +			}
> +

Storing NULL may need extra space as you noted, so we need to be careful
what happens if we don't have that space.  We should have a testcase to
test this scenario.

mas_store_gfp() should be used with GFP_KERNEL.  The VMAs use GFP_KERNEL
in this function, see vm_area_dup().

Don't use the exit_mmap() path to undo a failed fork.  You've added
checks and complications to the exit path for all tasks in the very
unlikely event that we run out of memory when we hit a very unlikely
VM_DONTCOPY flag.

I see the issue with having a portion of the tree with new VMAs that are
accounted and a portion of the tree that has old VMAs that should not be
looked at.  It was clever to use the XA_ZERO_ENTRY as a stop point, but
we cannot add that complication to the exit path and then there is the
OOM race to worry about (maybe, I am not sure since this MM isn't
active yet).

Using what is done in exit_mmap() and do_vmi_align_munmap() as a
prototype, we can do something like the *untested* code below:

if (unlikely(mas_is_err(&vmi.mas))) {
	unsigned long max = vmi.index;

	retval = xa_err(vmi.mas.node);
	mas_set(&vmi.mas, 0);
	tmp = mas_find(&vmi.mas, ULONG_MAX);
	if (tmp) { /* Not the first VMA failed */
		unsigned long nr_accounted = 0;

		unmap_region(mm, &vmi.mas, vma, NULL, mpnt, 0, max, max,
				true);
		do {
			if (vma->vm_flags & VM_ACCOUNT)
				nr_accounted += vma_pages(vma);
			remove_vma(vma, true);
			cond_resched();
			vma = mas_find(&vmi.mas, max - 1);
		} while (vma != NULL);

		vm_unacct_memory(nr_accounted);
	}
	__mt_destroy(&mm->mm_mt);
	goto loop_out;
}

Once exit_mmap() is called, the check for OOM (no vma) will catch that
nothing is left to do.

It might be worth making an inline function to do this to keep the fork
code clean.  We should test this by detecting a specific task name and
returning a failure at a given interval:

if (!strcmp(current->comm, "fork_test") {
...
}


>  			continue;
>  		}
>  		charge = 0;
> @@ -750,8 +771,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  			hugetlb_dup_vma_private(tmp);
>  
>  		/* Link the vma into the MT */
> -		if (vma_iter_bulk_store(&vmi, tmp))
> -			goto fail_nomem_vmi_store;
> +		mas_store(&vmi.mas, tmp);
>  
>  		mm->map_count++;
>  		if (!(tmp->vm_flags & VM_WIPEONFORK))
> @@ -778,8 +798,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	uprobe_end_dup_mmap();
>  	return retval;
>  
> -fail_nomem_vmi_store:
> -	unlink_anon_vmas(tmp);
>  fail_nomem_anon_vma_fork:
>  	mpol_put(vma_policy(tmp));
>  fail_nomem_policy:
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b56a7f0c9f85..dfc6881be81c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3196,7 +3196,11 @@ void exit_mmap(struct mm_struct *mm)
>  	arch_exit_mmap(mm);
>  
>  	vma = mas_find(&mas, ULONG_MAX);
> -	if (!vma) {
> +	/*
> +	 * If dup_mmap() fails to remove a VMA marked VM_DONTCOPY,
> +	 * xa_is_zero(vma) may be true.
> +	 */
> +	if (!vma || xa_is_zero(vma)) {
>  		/* Can happen if dup_mmap() received an OOM */
>  		mmap_read_unlock(mm);
>  		return;
> @@ -3234,7 +3238,13 @@ void exit_mmap(struct mm_struct *mm)
>  		remove_vma(vma, true);
>  		count++;
>  		cond_resched();
> -	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
> +		vma = mas_find(&mas, ULONG_MAX);
> +		/*
> +		 * If xa_is_zero(vma) is true, it means that subsequent VMAs
> +		 * donot need to be removed. Can happen if dup_mmap() fails to
> +		 * remove a VMA marked VM_DONTCOPY.
> +		 */
> +	} while (vma != NULL && !xa_is_zero(vma));
>  
>  	BUG_ON(count != mm->map_count);
>  
> -- 
> 2.20.1
> 
