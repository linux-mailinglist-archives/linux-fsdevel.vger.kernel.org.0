Return-Path: <linux-fsdevel+bounces-3787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778697F8643
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 23:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985881C21082
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 22:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E0B3C471;
	Fri, 24 Nov 2023 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CEucnaNI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u34fbq7i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF910F7;
	Fri, 24 Nov 2023 14:46:53 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOGINba017463;
	Fri, 24 Nov 2023 22:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=GCgLIRft19qRWBKmo/pXIXQBYE4F0WHwrKKotEHmJTg=;
 b=CEucnaNITYNVc2NEcGG+OAaPbBZ04mWN1zNq7lOGsHpf67qxwWdauFsPbpwutVQ7hb4U
 +USkOeEDzy19H6K6RqwmOZ8JBgJ9dbRsQZ4V3qk9FPArFLPOhCn0HisS37Fo4LBcqsm0
 U0beLimRcT40MOzLIf4QQnIs0z3/epeR6umJp6l+gsTXGuQgRijBdpBoInmniK5gRNNI
 QDILHEKmdmP5FaxUIgyk6E3VP5GzoBZig02XK53aW6Ap19ERpEkA+WInLzlITpn2Qwiv
 OR6gZaLzFLGuSwhjM4O4VRcuZPHgypB2U0qoip0kSLf645tymGPfdZOvZuHAEp6TukOQ oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uen5bksx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 22:46:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOJwC5M022969;
	Fri, 24 Nov 2023 22:46:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uj3y77nkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 22:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnxtL8qFaK+QgvTHvrA/cZrXQKIYUsbUYBK+7/hc7luM+mgyHHkH4HWq9dMd1vnfbKZZqB2e786pH7jEWRdStkeVG9g6s6MfXgVy12nR5CjAm5/PLfbj9Ec5VkSzY3xqu+/WLAX4ujqcdujnDpZPtCyk8cAf49YLOteG9XgdcUxvOHR1YQiDZLSa5Z7AaxqUYGwHY9l7ENTnv9xYk0adldXeXq/uohl4+AMaSAevTPn7pT7AZRuvcFIqhg5UDQG+bLd4vSGwb4G/YgLh+dXmSIMIeF0U4hAv1NR1DNWszL6rQ5g1qtK/mssuBozR2qzpoVfCN2h4doRBeKyrXQ3izg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCgLIRft19qRWBKmo/pXIXQBYE4F0WHwrKKotEHmJTg=;
 b=YO84ydN9GcdMnVnAGV8aRsGxS0M6qJDxuHdlmhCOuD9T4Wo9sXlCKW1Xklm5Vfq5DHArvVdDpIt3dBddAzdTjwKgxnr41m9d2ZT+YE+f7VLi9ZO0tTMl4oDq+j8Wnx+e4e8TL7lNKTvlA1CrZIPJiQI2GF3PojRGaZfuTEsMi2q0wzWFIB4RuQ4wlT9pNeevDlGdvQPAXtnl9Ej2h5EttIT9w0oWSzhQCPcRG2bMwASWlB4V2jCeYUu9wuP2QlgUtEX1P6Vch28bF0W1SoI7rUGR3F8rattlKqZkzIqK/IgdfRWTHThAHcWjTixGTU2ZRsf7H5C3NPip3/dMaVZ3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCgLIRft19qRWBKmo/pXIXQBYE4F0WHwrKKotEHmJTg=;
 b=u34fbq7iwBuFMpPTBbF5gbN1EwH268ehCDJNEOT+d0MulpiUVeh9bzz8FNBErFHNmHxSgk2s5zqbbHaKt81HG54xrCYdldEto6MVi7A21sMjgBYI3YzwwQ0167CwXtowEoRHX5huCjboK7UIhrFZVSc9BKN/4aPQhd/wr4R9Xn0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4601.namprd10.prod.outlook.com (2603:10b6:806:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 22:46:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 22:46:30 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara
 <jack@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        David Howells
 <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Al Viro
 <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] scsi: target: core: add missing file_{start,end}_write()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq134wuwz1c.fsf@ca-mkp.ca.oracle.com>
References: <20231123092000.2665902-1-amir73il@gmail.com>
	<2f3bf38b-a803-43e5-a9b9-54a88f837125@kernel.dk>
	<CAOQ4uxj6BBSgGKWQn=2ocsL_rd-PbjPAiK2w9rsqnxpNamxr9g@mail.gmail.com>
	<20231124-zanken-ammoniak-0d5a19006645@brauner>
Date: Fri, 24 Nov 2023 17:46:28 -0500
In-Reply-To: <20231124-zanken-ammoniak-0d5a19006645@brauner> (Christian
	Brauner's message of "Fri, 24 Nov 2023 09:24:35 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0386.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA2PR10MB4601:EE_
X-MS-Office365-Filtering-Correlation-Id: 89640b7c-61e6-445d-bf8d-08dbed3f3349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Tv6T/ZWd23okT9oT7w3Bmj09ZTzd3+rnwEhrpt8GQ3+M4rPxPSUyokghc4sNrLl9fFfi5kKT8+xKx8Usl5XSJ7knzQpRP6+4Kk+O3nWz18HhqGQ40jw48c9v8vXGTmo05/bxWOvvqUVT5vWklYD9JB15gIOeYVuUK1rbGlpx3sXj47Qk4w0yJya302e473XOY+AXYZ4EDseffjc2VmzI9gHFJfORJXATpzvQTvNQZfZPvhOd+xeP8x+/F0a6OKHnK8bPVA9vjkxyTxQ2WGM1lEqe990gSezyiLOLfUqJAB6+y/bblN+s/JWBqOQUH9/h7uD0wa9GztQjn2Uo7b59ko1eERv0SZJCvQzPKeKi0PHxlr5MrUHxtqSFkEcbCnXiCcsL5E+XU1v720mvwbUP8o/LFMUdjnm/JFt05wHUguNk5t2vj20g+ZIOffVecEPM9wekzA0v8+cDO+tsqAwICDajvx0eSauLEsha1OMUHIXC2dDZQhMEZA5GkW78TYHcCyMhLZfQKFLaWL5e4ENwbleUZx41L2Rvx5174ZHedkfzEEG60uFrn61m61kojYKt
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(6486002)(36916002)(6512007)(6506007)(316002)(6916009)(66556008)(66476007)(66946007)(54906003)(4326008)(8676002)(8936002)(2906002)(41300700001)(38100700002)(558084003)(86362001)(26005)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tfDlh4X4DOu1X5OycIXYY0z0yvj77rkufjpRXEzQj901tGxRkdZP6T1EyPIl?=
 =?us-ascii?Q?ZEmGnu+fyfx522WyS+h4QB/wa9Wpo/ntoP0GBlMUvlxPqqSp052cEIvsIdCm?=
 =?us-ascii?Q?DSe+7aPcEGv/79B9TqtS7gcZjsQ3x4MIi696h2XDttaDj/Ewa6phuTlHA3Yb?=
 =?us-ascii?Q?HBIwT+g62jZa59lMdeZseFbjCs8TOYPBRuWcCwdnzYoqWq1/Bvn2i952NSNP?=
 =?us-ascii?Q?kLUCS2h9n6GPBdrgBayUUn8lcFkNmlytjnrp+7jVS7bhZFbvUqQTtr2AZ+1Q?=
 =?us-ascii?Q?yPl/WLohQHTpYiwsGni4yTKaQqM5S6q1lKrHK/FWBsbh4Dzq8LjTg1qr1vPw?=
 =?us-ascii?Q?VNyx9epsieXZPNxrm7yNCLWz+Bg0+Upky6+Fky7deXbXqGCIAkogGH7RBmbN?=
 =?us-ascii?Q?h0mTyeF83pVWy61gG3b4gXoH0jhMsntMg0oiXySx0S6US5uUTrfKrpEgkmZ4?=
 =?us-ascii?Q?LRpySJBaFLD4dOep1MeUBTKEx6TATDcXVVU3dWDrBVNAO4ynJJU9K0INp9bj?=
 =?us-ascii?Q?/XSvHOto0Rc1mCXqdkv3vh5KkhvYgBrQfL768u9/2v2GlCDSM5hV7DNYEL17?=
 =?us-ascii?Q?rrrZjcoMm+88icYoCRa8ZOIIF97TRXIuAnsXvzsCcTor6WhZ6kbkPD4R68UZ?=
 =?us-ascii?Q?/814T/G2klvWCq6dR1qwomBH+WVtGbH9nGNmmsZHIpI0Xo6d/BypgeBI2AqG?=
 =?us-ascii?Q?Azl0Vn3sJnBWgc+u8iSKDydK2oTTSwbOvns7vZT6K3YXuG6XZhGHDiRE99cp?=
 =?us-ascii?Q?Xf4NSaWymZG8WvORNhvEfPE4Bj/Fx9/aQxywfxNP5yqC+t2l1lOtMfhfvpEB?=
 =?us-ascii?Q?8o+JSrxU+MMHlJNnk3M0IZduoPZIwgbr5QegTUBzArNO8iaPFYnyrueob0gd?=
 =?us-ascii?Q?bcWPL0CKFOMiCxuyQAKnjOyBHN88epp7y9zKtekKiEb/gdyE+v277M6ZFzW/?=
 =?us-ascii?Q?OZ+zFpprSIGXeuor5zTIAhn4yDMDrCxRagkGVZJLrwX3Q+ebQIfGtPj4/Emu?=
 =?us-ascii?Q?tvYVHLZR4XxhIurNP7wF8+gZBm0TYQBBmVE2kYQrIsGRUzgZ9RjLzmix7HHd?=
 =?us-ascii?Q?QEsaOv+l9y/LJlcWvIxIbuVvDKVsiqSiBK9jyBIa0L4A1DSzJ8GQK+o1i6fN?=
 =?us-ascii?Q?5An5bRxan7Om3eLdk1wIOTRXN0Vgw6jDUqR874kzQF52rErWNFQo+km+L+TE?=
 =?us-ascii?Q?e6/7HjkZ2oyvbMi98jQvNAN71xx1AGN+gMe2H3eXENEfkeQvt7JLGCzRhTgU?=
 =?us-ascii?Q?62++XshzkWNr9ahuSqdzZfqKBAnvVhQyUtsN9ZhGt+sHlTDFCxYkH7xPjGz+?=
 =?us-ascii?Q?5GVlHyDskcdXCs8vLMTLFt66MiUcSzdFfX+G/RiYZYxZ6j+9ZiDSul5Iy5gU?=
 =?us-ascii?Q?UfbOBtj0CRuI7kJUReWZrSmOh76ytdS2Q9b37IFVqFcAYZ8yB8SX/+3hKAQJ?=
 =?us-ascii?Q?zW2Yw1Fhd0adcp2cWxSuaWmXzcaigKeN76rI4+eEZbN9m08f3/pNbfezXW5f?=
 =?us-ascii?Q?uIx4q8ZZNmVV8et+VrEWrTlWhanPHP34R9u0bJkucg6LgaOyCjMZWm7pv2Vp?=
 =?us-ascii?Q?AbLbBk+4T+5M6En5nzFoZVMlZDSQp2TNAgGw7eE3yHRwwuR7QNxlfgUgnzyU?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?q6a1Z+YhDft/4BlUUU+y0EBmcUcCAGBHq4WR647SIY0M4m8RxXagBjzaVT7u?=
 =?us-ascii?Q?k/cC/aadgGqR4BS64RUYY3RKXMHW11Cl5lcQYtJeQzmUkb562gKucHDq/UeW?=
 =?us-ascii?Q?joIonHlbUyYjBPOtiJVoeJWbPOUu/mBsrXgZ810VGTflZl/Gd3t7dugY1jFD?=
 =?us-ascii?Q?FtZZS+eLlpuUChh9m11FKqHXUFuOzArguKB6l22+UOkl9HguHVNWSx8QjVuq?=
 =?us-ascii?Q?+F+v45s0R0CMA0ovLTiG9FFSf+DXLpO65Hl2DtXjvsBHe3PExJE3S3RNVy4s?=
 =?us-ascii?Q?n1ueliR14ze5KbxeLM1bFjjLmblxUB5emqNEgmnqNvDjXuvHjjITZtNi9wZw?=
 =?us-ascii?Q?zZ0gxe9LSFEf3O+fGA+41Up3tk6Xf1ulUg1uz8YyffChMYoXtZCiW+icb5VN?=
 =?us-ascii?Q?BkqbvN6+mnkBK2gf4Jk46R/pqVwIgsZmDIROrzW/08K+1CuW6NXhGRkI1yOx?=
 =?us-ascii?Q?iTiDG0f8Vg2O31iHaNHtZIuD9upgSTDU9D2wa4UiqFkzBx/JmQZXb7miY25S?=
 =?us-ascii?Q?HlQRJ+77wd6xKjgMg3GfFkiwV9bZMSbg8gyirhhYLi9c2YBBflBH3ZXT6s55?=
 =?us-ascii?Q?u8m9gKDNGPt1AV5fOx5crUKzj0zF9erF+jKw51PiXyRro4goo7JTPSXbHHhx?=
 =?us-ascii?Q?BhzkLe29tBFQjTt8Vn+W9Yc7nkcQZiR2Zt0DbB/m1Q/VP9P+z1USVkDTQC9S?=
 =?us-ascii?Q?lzk4R2Q0xNxD5I3H2U/ui5X9nmpnFxdvogthCmC59EgwXyOmv11ecjSRdxD4?=
 =?us-ascii?Q?w9XUO6WiE8QHkBJ/JtT9zxCmfHIClJRWoOZGqqQey8GetxSwDY0wTk4txQIM?=
 =?us-ascii?Q?w71mTkSML93UoCWXBWi0hAKigsBypChvbmDTVXG3nI7O4r/cRjfSBCKza+NR?=
 =?us-ascii?Q?bI+5sW+kJejLtg8KEHMFhxGKoNSeHWWFG4CzQeruU6pFwVkmVfX5WFhr47TB?=
 =?us-ascii?Q?zBAjllhXdiFLpVWE2jbJvUJyn5yyRbm5Bzvdl09VD5wwedWLHVUb/wBKE4aC?=
 =?us-ascii?Q?yTL59C0pLfnXQqGbZW9Ubl8lKwoorxX1znKs3mL8Xk202d4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89640b7c-61e6-445d-bf8d-08dbed3f3349
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 22:46:30.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Et6f7gH7OxpG0wacSuFJPTScIfUugrs3fpc3KFTQv2cI3KlWOYyYVVZddAXUFG4Bfg4tTsdDmDDAMmpMXRi8m+k2O/RT4O1B+/uXiQrLtzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240177
X-Proofpoint-GUID: GcNJHZbZCrtcRLXIo9UxhoIqKbAPQgdO
X-Proofpoint-ORIG-GUID: GcNJHZbZCrtcRLXIo9UxhoIqKbAPQgdO


Christian,

>> If Martin decides to expedite it, we can alway rebase vfs.rw
>> once the fix is merged to master.
>
> It's now the first commit on that branch.

That's fine.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

