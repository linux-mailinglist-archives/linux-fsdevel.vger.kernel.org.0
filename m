Return-Path: <linux-fsdevel+bounces-4004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C73457FADD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 23:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA60E1C20DD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 22:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFDA495CC;
	Mon, 27 Nov 2023 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="olHFnGdh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PBy5mbJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EDE19D;
	Mon, 27 Nov 2023 14:59:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARLcnff029469;
	Mon, 27 Nov 2023 22:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=oa69YDWid9LTAGiIOdZrogMfLG/x8rk4etcc2Wu/h0E=;
 b=olHFnGdhXKsfnq85VXb7FCHzpBiTByADmlgDjXZDoYFoI3HfrG86EGpifskjGOQScSZ9
 lSph1ffPdEqLxHOu+k+9KBKsDdal14+ihTYg2+5elzZBGxzpTcFSNUD31QCY+vIJBJyJ
 0+4Kwkj6YBG8HdXuFztQXMOJKmqursVqlP0tV9d6n9wTGkQKQQ/yfSAEMq3GTmfR0vC5
 Yw7PEJjV3/vpcwPNauWuaFqney2eaEtOcf7om0O1h+1mI6IEJEMNx3XFl7beE5yGPBAq
 F2fUofp4ljx7zWEUzTcnX1af21OyL5AMd0hZfLO/NW8z3zg951wepFDICYAwMzUYAaYp Ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7q44cud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 22:59:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARMoZWG009231;
	Mon, 27 Nov 2023 22:59:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c5sbnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 22:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6uLyenPxFiYkHEvbUpLAsa5h7lHQ287MyogC/QtMs3eVCxSpp490ZC/g3dw18Xh3vTGhcV0rL2Z9+5WPF7AhNAsCq3JroqLfywreIxo/2dkPC7NBvbW6IIZBqHnB0/ZurdTH30KZzVNE7E6koux5ZG4RVdVxaepDW5S+Zn+CnHMjOQeWPQYQkMhNmyOLbg3t/YLAfk4sVVQ1arcRurSkFDbGareFgMHDqKisTGrQQX0xBLmNJmVwxm4/+0LC55pMAGVDgWVmPp3WB8MKW/BMHn05jytF94N8gGuUeBKrxSmFBDm6OsJWsTVW2qBySUrY+eqL6bGc30TNIx/9aBNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa69YDWid9LTAGiIOdZrogMfLG/x8rk4etcc2Wu/h0E=;
 b=b3RnTRDf5+o0HGEciBVUv6m9k6C85u3fCPG7Du83BDAFevznI7PNDrImlNoyDnnjDLQQdJVYDKQGLxVyk7EDsCDQCV7qWoCotLAhahvK4bI4990+HzBXxxGDIynwbojfTZe1KMinNOFKzmZuhUaKjoTZIQnCT7THE719BF2JciIoLhsw6sLUX5Q2Zb9VcfHaxgjd7kWSgEJHaukUW8EDSJD4gQhl1a52pW26X23WX61TBG1/pCd4PVejixyLHS8ZQcG00fZvUoenhlkX/AovvjjmNmYK5wbbpxpwjh9mypUrX45MjVt1e5STw+HvnOyZh0WBZBtY610pSYZjEugb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa69YDWid9LTAGiIOdZrogMfLG/x8rk4etcc2Wu/h0E=;
 b=PBy5mbJy7X9b3YfWVn1rLy/RjqXfu2eqsOul2lL94RssjWfsP5vb4YgE3MvGX41OThEx19UsGh6k5mZPzuc5ghN+lDlUFrc7HE5ycfg7cK/vUXS5D7BduWdTfhi8vzepCa+3kHduXFVBHWheuFjp8TF2yqILLlT6Ih7N99Wqn50=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7653.namprd10.prod.outlook.com (2603:10b6:a03:542::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 22:59:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 22:59:06 +0000
Date: Mon, 27 Nov 2023 17:59:03 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6b4765-e0bf-4c1c-3c39-08dbef9c7546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	esIAFHjXVljZVMDADDr/RRoFtuAx/cPLd4AoIjNqRSKGOQ7BteV5dnClE9v2EwTOzreNPm6XmYwoRYlk2jlz3KUJq4iQavF6d74SrNr1DTQCCM3F3M/yX/JOHn5qDl5PyPnWu2kz/fx8tyBHYDnhIFCBwoR/dlPKDJcnDxMnsuUJolqXGLucsNLdfmoswf/Wvj9GfJdEz7pxf6y36iIC94ggEwWAdqZutVAoPJOxB/+2JQYWTvGk+8NTUxYjY09jPN4a6NEDCmxaY2UFGJwumUnREXG988lc2wW5Eaxo/4rlQttNajWKWLwkuYWRONCgCuUUxipshHERCf9c6Yy+I1eIDAKfUiq3dgruWnt5zfZ/eIt2Oph4tahArtiEkXvtyAjj+x9+zbl2N/apSShCm0PbIF6cjXXgKBepj8AN2hKYhcSSbTWbdji1UZxRyZh4jDfiXfyXS14c7YXXibUu+gkMWtIhKfXwu0HIjPDf1vbCX30ipdLCFhMhN8RAKhETtEqMWfFA/fH24rOfe18A8e5ul0AYX0WCCAufm6LZbLU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(86362001)(6666004)(5660300002)(2906002)(7416002)(6506007)(83380400001)(8936002)(44832011)(4326008)(8676002)(66556008)(66946007)(54906003)(66476007)(6916009)(966005)(6486002)(478600001)(316002)(26005)(6512007)(9686003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?w0soJZ+QWqLGygvGiYJ0S9N+H3T+tBUaFkvnmuUX7MCS4Jb4qqa3vjfE+19k?=
 =?us-ascii?Q?1EuG+sCibze2aDEY93hPu6vQd9KGQ+XzZgiPRbIdnxTZ9x1i0LntThV96fMx?=
 =?us-ascii?Q?x0x8wDzFn1l008ZWwChsf120EFfjrPFPorB67KdCb3+1VX2WbtwlF7wByU6w?=
 =?us-ascii?Q?jEgHqhtsxRxyh7nb5Yo4NDXtGmEBwy5ljE2LSkOZQKvWbNfv+PuLZpSNdXQS?=
 =?us-ascii?Q?SrvWkXggfHXkMJB91AO/3iqv1iHYww/THHsNDliZM6e+6iUCntcuU53NvDT9?=
 =?us-ascii?Q?MFNWXnADorI/oGqbQxejKvTy68+M/VHOotgl2Gbe4Orr4+ZOpA5BivEKEbFc?=
 =?us-ascii?Q?mMuiEUm8jYbuAHbgthItWvaa69Udpz32H07IcKt0jUc8Y1BTrWtgralkjlfr?=
 =?us-ascii?Q?YJnVn9wHbrlmAMhfKm2Tl7/Jhp9wWpvPdR+jfaSsDJlVPhuaalPdAypszq1w?=
 =?us-ascii?Q?JWeB7RplZLc60whP+Ybt6U2VSq49sWhI7vGf6dirQwmyCaCJcSZ0siePPWR5?=
 =?us-ascii?Q?nzU06hUGD/4h+2Zjrfh+01B2qkWM+OyEF6ynnU2iTtfqUuRdsG9KkmemtZSl?=
 =?us-ascii?Q?BkYcZcCDZar+4KI2izeXeRbKij2MrYro2pncHBJRrDk47CJpTEtS4Fe26Ucm?=
 =?us-ascii?Q?yQcc/DyhnbqKIdP7LcnkgQGTYZI9b5QcBXXC87gHDWH1h4jC2cMJo3O+3GHL?=
 =?us-ascii?Q?h4iaVG60BcNVlyswK8vxyj+XPgKfgEDDzRNHLwfj9k30Y1wjgSQDgXIqoGCK?=
 =?us-ascii?Q?sqCyekPiA9nVEeKV4Up+suI2Shzb/EAUgEeTxFFzseYPYVmPbuAIp9co1os8?=
 =?us-ascii?Q?Ctail1N3w96hk/bXTBFCet/OBoUhVhvH+tilzbt34+PzHigxiXcKGv6WdINS?=
 =?us-ascii?Q?sOdR/Uhd/DbDGKwRbqZKHB1XniTIQxv5+r6Uh9a+RgUr2iVVsGIEPvPdSlUj?=
 =?us-ascii?Q?dbu+ud5U8FENblnelG3akMMhDyJ5Z09y07A923AzlJNNNAfFfntv3PXc+4FV?=
 =?us-ascii?Q?ITR8crNdD1FcAX/XNWA3AnuUQJvMh+IwLnlD80aaxW66VT3Sck4Vvr15x/nA?=
 =?us-ascii?Q?Bucu0RAOT9uAjWZyajFxlk9QTKgiSjmlO6TDUs6SVVHjbceiJWd8Fd5yE6Y1?=
 =?us-ascii?Q?KXHE65AOrvJMww4DLGN9sSAwIDvfdVNDJW8reIcQ/3mXVvuf/Er9+GMgp877?=
 =?us-ascii?Q?X+ukVhZHqOptu/f3F4/sSkzsdAgrRXWZTMzdlK5Zib0rivHO+rTlL0QMI+os?=
 =?us-ascii?Q?ZE8LRSiKdjehRv1XyaVH2aOymPVNU8bzAv4ITarMdJkWhPELVyRtjZn5GGl/?=
 =?us-ascii?Q?k1V/Sf+4z1G0sb6W6/x54KgmhTMKZ9p6lS3q+bYzARL6TLSr74MkmwTvc3r1?=
 =?us-ascii?Q?UzZuvrpw7s+4M/cUCyNdd82TexzgZOJ8cfCrkuh1K3URDU2YYcHFCX/PcG/Z?=
 =?us-ascii?Q?6GdQ+zF05WfLTEjq2ZaxFere0z+6QZFbwPLKBb4oDR/00p2YqnUlOevTLz2p?=
 =?us-ascii?Q?TV7lwn/w12yoAIz7e3wNtiu4eL7LngwJre3pytD96Kk31WFD543XRxTycQ+z?=
 =?us-ascii?Q?QoqAFGCM6eX6+wf2VVvnH+ExfD3qac49/bYghBEPm+g5JVOnheYfggedFFy8?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?Va3FTr3HmAJ/+gT7anRo3bCl+suDftBkl8s3ATcDSJ9/6HFR+cSMlX+9IZ8O?=
 =?us-ascii?Q?uk2yqd205qVg6XbAW/1YQH41zanWdTUv5Sz0JQW3Q8Wnu3NJUpaU12fBcCvN?=
 =?us-ascii?Q?pXov94vQjchjyS124qIDwYo49vXH5J7MUh91IXQDXYqwzSOnPLZzLPxiApYN?=
 =?us-ascii?Q?5VWsa42LcRcOyYiddBCejMx4amr17J7s5VNx1dkW5xftJetxQYUrt9iIhtYh?=
 =?us-ascii?Q?CfUr5H0MO6dUleMhvjAArnJXCsyj/9LFRRvNjZgQ+bc0O2WhgKYtdBoTzbur?=
 =?us-ascii?Q?eJ6wwd6habC4oiOWvhPSc1qA+2kX+sGiY9DvaQuxCAfwNWfGzWkoRPitpJ7m?=
 =?us-ascii?Q?swMaSlEAZU6O8VHZab6wka21a91rjFIZPP9r6sp9TpCYae1Yio3cMJpenO9q?=
 =?us-ascii?Q?YDfr/RMurG74uJLXHJryJU/jXB7UKdEBRD9ZexUTxKA2pqkZTkrewFGzsw88?=
 =?us-ascii?Q?4EvD0ffLMDv7Q51aD6Lop3glxrKTTFIJPPGLq8FgvjMWX+bOHOPKTcbrgp/B?=
 =?us-ascii?Q?gT6KXvXsUacNQaWEKmo4K0Zp6PiNToC7N3fzev9z3DgSwpycTloW30mCrpef?=
 =?us-ascii?Q?aC5KaBcUJEic/TIqMyrI/92GAPWTxA0Nxks4J7MUTegFsCHoKY7W57YKVBwx?=
 =?us-ascii?Q?fJ5TKFu+b4k4qA35CZJHhIRz/vexXlIX3HTXUKTPLtiqYbXhc8U8PEe9ZxKz?=
 =?us-ascii?Q?W+Nak1+Vq0maKVdvEMUw2ZoumYtBMYNCuMpoWCf+QdbF4uMeV4JcHdi8Nq1u?=
 =?us-ascii?Q?b5tSwRuZcWnxCZPYqwLdcFoiLEXc7C+eFJIntiOzLLtIprAaR8mQZF5sQ7Mb?=
 =?us-ascii?Q?G9D8VNN2qiDZTwTL0HvUpVy4SdwTvtJDXRG0yyVC4oB4yv+4zizi8hxZ2Dd6?=
 =?us-ascii?Q?85MBTHOtZpBpkBgpulKP6FHWdfdMyMIw9QnN4l2zPmMl0uuCgHGHb1wKNoga?=
 =?us-ascii?Q?qcWgwWvK4bXBEaVKyT52uECZ+alu1ei1r/IycRvYSL4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6b4765-e0bf-4c1c-3c39-08dbef9c7546
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:59:06.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUEK+kIS+XWBvDmWK5poXehUkM0llw5GJgUkcPVMY3fPVB1hxhB3mGQJgivcdz+ybCde905x5PH4J69CZYvnbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=467 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270160
X-Proofpoint-ORIG-GUID: dm-I-2u4crHpjHR6ZuvsjKwoefiMXwZn
X-Proofpoint-GUID: dm-I-2u4crHpjHR6ZuvsjKwoefiMXwZn

On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
> 
> I have evidence from a customer site of 256 nfsd threads adding files to
> delayed_fput_lists nearly twice as fast they are retired by a single
> work-queue thread running delayed_fput().  As you might imagine this
> does not end well (20 million files in the queue at the time a snapshot
> was taken for analysis).
> 
> While this might point to a problem with the filesystem not handling the
> final close efficiently, such problems should only hurt throughput, not
> lead to memory exhaustion.

I have this patch queued for v6.8:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-next&id=c42661ffa58acfeaf73b932dec1e6f04ce8a98c0


> For normal threads, the thread that closes the file also calls the
> final fput so there is natural rate limiting preventing excessive growth
> in the list of delayed fputs.  For kernel threads, and particularly for
> nfsd, delayed in the final fput do not impose any throttling to prevent
> the thread from closing more files.

I don't think we want to block nfsd threads waiting for files to
close. Won't that be a potential denial of service?


> A simple way to fix this is to treat nfsd threads like normal processes
> for task_work.  Thus the pending files are queued for the thread, and
> the same thread finishes the work.
> 
> Currently KTHREADs are assumed never to call task_work_run().  With this
> patch that it still the default but it is implemented by storing the
> magic value TASK_WORKS_DISABLED in ->task_works.  If a kthread, such as
> nfsd, will call task_work_run() periodically, it sets ->task_works
> to NULL to indicate this.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
> I wonder which tree this should go through assuming everyone likes it.
> VFS maybe??
> 
> Thanks.
> 
>  fs/file_table.c           | 2 +-
>  fs/nfsd/nfssvc.c          | 4 ++++
>  include/linux/sched.h     | 1 +
>  include/linux/task_work.h | 4 +++-
>  kernel/fork.c             | 2 +-
>  kernel/task_work.c        | 7 ++++---
>  6 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index de4a2915bfd4..e79351df22be 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -445,7 +445,7 @@ void fput(struct file *file)
>  	if (atomic_long_dec_and_test(&file->f_count)) {
>  		struct task_struct *task = current;
>  
> -		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> +		if (likely(!in_interrupt())) {
>  			init_task_work(&file->f_rcuhead, ____fput);
>  			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
>  				return;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 66ca50b38b27..c047961262ca 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -13,6 +13,7 @@
>  #include <linux/fs_struct.h>
>  #include <linux/swap.h>
>  #include <linux/siphash.h>
> +#include <linux/task_work.h>
>  
>  #include <linux/sunrpc/stats.h>
>  #include <linux/sunrpc/svcsock.h>
> @@ -941,6 +942,7 @@ nfsd(void *vrqstp)
>  	}
>  
>  	current->fs->umask = 0;
> +	current->task_works = NULL; /* Declare that I will call task_work_run() */
>  
>  	atomic_inc(&nfsdstats.th_cnt);
>  
> @@ -955,6 +957,8 @@ nfsd(void *vrqstp)
>  
>  		svc_recv(rqstp);
>  		validate_process_creds();
> +		if (task_work_pending(current))
> +			task_work_run();
>  	}
>  
>  	atomic_dec(&nfsdstats.th_cnt);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 292c31697248..c63c2bedbf71 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1117,6 +1117,7 @@ struct task_struct {
>  	unsigned int			sas_ss_flags;
>  
>  	struct callback_head		*task_works;
> +#define	TASK_WORKS_DISABLED	((void*)1)
>  
>  #ifdef CONFIG_AUDIT
>  #ifdef CONFIG_AUDITSYSCALL
> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
> index 795ef5a68429..3c74e3de81ed 100644
> --- a/include/linux/task_work.h
> +++ b/include/linux/task_work.h
> @@ -22,7 +22,9 @@ enum task_work_notify_mode {
>  
>  static inline bool task_work_pending(struct task_struct *task)
>  {
> -	return READ_ONCE(task->task_works);
> +	struct callback_head *works = READ_ONCE(task->task_works);
> +
> +	return works && works != TASK_WORKS_DISABLED;
>  }
>  
>  int task_work_add(struct task_struct *task, struct callback_head *twork,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10917c3e1f03..903b29804fe1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2577,7 +2577,7 @@ __latent_entropy struct task_struct *copy_process(
>  	p->dirty_paused_when = 0;
>  
>  	p->pdeath_signal = 0;
> -	p->task_works = NULL;
> +	p->task_works = args->kthread ? TASK_WORKS_DISABLED : NULL;
>  	clear_posix_cputimers_work(p);
>  
>  #ifdef CONFIG_KRETPROBES
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 95a7e1b7f1da..ffdf4b0d7a0e 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -49,7 +49,8 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>  
>  	head = READ_ONCE(task->task_works);
>  	do {
> -		if (unlikely(head == &work_exited))
> +		if (unlikely(head == &work_exited ||
> +			     head == TASK_WORKS_DISABLED))
>  			return -ESRCH;
>  		work->next = head;
>  	} while (!try_cmpxchg(&task->task_works, &head, work));
> @@ -157,7 +158,7 @@ void task_work_run(void)
>  		work = READ_ONCE(task->task_works);
>  		do {
>  			head = NULL;
> -			if (!work) {
> +			if (!work || work == TASK_WORKS_DISABLED) {
>  				if (task->flags & PF_EXITING)
>  					head = &work_exited;
>  				else
> @@ -165,7 +166,7 @@ void task_work_run(void)
>  			}
>  		} while (!try_cmpxchg(&task->task_works, &work, head));
>  
> -		if (!work)
> +		if (!work || work == TASK_WORKS_DISABLED)
>  			break;
>  		/*
>  		 * Synchronize with task_work_cancel(). It can not remove
> -- 
> 2.42.1
> 

-- 
Chuck Lever

