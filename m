Return-Path: <linux-fsdevel+bounces-4881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFCF80576D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 15:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5297281C7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354865EC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MSaZbOaF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vfiZ0dap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F8CA;
	Tue,  5 Dec 2023 06:23:43 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5CsIhO001460;
	Tue, 5 Dec 2023 14:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=M0M+et6T/ButQnoWJ9WXxBwRS4RsHyngONwRGzvYb5A=;
 b=MSaZbOaFaLUhNFiV2BDC8lyGQ5/4loOqYCbjKVkYkVu2GZz8em0PLccjbWUHJ8XDaSZe
 15GpY/jhSqrU6Ai2vHzwlXFZckoDpM0Jn9iPItLNQoCyOaITJXnbqSGRvWI5dINfntAU
 twpwlZFPhZU2/mQF2zyHfD5wKiWCg7IhjPKv2mG+yTllThaUh77DZZpeOfwTCh39buLJ
 2snWiudLYuwdsXUDVNuYR4qRTJo/SKjxNFM4izN5lESP0yxvkv84A6/dL9XUQ4psVTJF
 QLLgsm5q7gS6U8Ku0pG5voR6Wz6ZJEiJcx8LIBtW8LM6O715IojlQHRz7jEFMWP6hpfP Jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut0qh0pc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Dec 2023 14:23:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5DDrU1018467;
	Tue, 5 Dec 2023 14:23:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu17gmqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Dec 2023 14:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJtiCXtTA/vj15xqmJWhMgNwy8gdI/fJWA82lTBTZM2QLS9t73THPACLzpBWx4vaR3t2zZLcWWvLrsrBhDnpryO45jqBWusSaWO0GxdMfeCLyF5AhSLveqCx1sm29jbCElL3PLCbEIEqHjNkjqFY6Q7vr1rgPZDq43QdjibcnTsOw7GXdIp3XBM/IjdMRRlsN5pBaH7Ubd91RehKg8eePeimSH+/WZ1Q/xy5QkGV1W1jKh6tTUGf+RucuesJJeNrISYNQxcv4VzfDjXSQ+k1emmrZ4DZjWH/T8cMc2bzAKTLgkeFyW45qPVdW4gSGGuNpGPOS6JNsZXPRzdbjhrevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0M+et6T/ButQnoWJ9WXxBwRS4RsHyngONwRGzvYb5A=;
 b=KA29RZ8vau4Mj3wInDm7YuCp10PGWXXi6X5z2sLde4NGGN15NSyPA3HfHR5jv/x4WAMN+atsYe+suvhYLEF4x95WHCDSxT02Gpdy18y7V/HpzSdfnRWSiy5n4axbL5eeAFhBt+BspaAux1xywEppHEaNHe8f1D1H24JCDPhD7wW2Rg8PHGUe+mlKsN51bwe7xwdnKpm73Mc6V8sHR7pWaeEYJymjbJ7NeCCkqiGu9hmWqdRmG7ruRxtAp1StU/DyNmVKBUUXrAQdxOCAp86k1LpTydnl68ORUKgGusciWurMsbrQ8GI68CMeDYitpCuw+kFO0y6hRp6ybBO291n+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0M+et6T/ButQnoWJ9WXxBwRS4RsHyngONwRGzvYb5A=;
 b=vfiZ0dapRfzr8zOk+imIeGogcm13NskBoawyfTWpZGXHJI8F1DNB8xO+y+GAo3ORUpa+dlAJCeXhJQic7KlSCDGQxzqKepZQwRDFgX26bNO2gsZ16gGQWewpClwDW3Au9Q1m4hhHUQrJysXj/sf+1WJs5Y0gQr6+XvSpoFNo1aE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4377.namprd10.prod.outlook.com (2603:10b6:5:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 14:23:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:23:04 +0000
Date: Tue, 5 Dec 2023 09:23:01 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <ZW8yRckYhUZ6wfZ2@tissot.1015granger.net>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <20231205-simpel-anfragen-71ac550a80fe@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-simpel-anfragen-71ac550a80fe@brauner>
X-ClientProxiedBy: CH0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:610:cc::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7775b1-5011-4b11-dfd3-08dbf59db1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CMid6ZQLcqPO7nCPcpBTgwPkFslbNwH7jGFRncBno1hBKbFkwhNIJRauXBjnWmqP8P4EMDTaXpp7b6DgToaurUcdC3G/KZzY+xpFfiJUAehWYAA/vjxgjVyGnuOyXBfEdrGGHqFJhq3ItJ4DbY4OdAUA8piju1OsVcVPfZX9+M/9JlmK1A/CvF70oCvxRtu48OWcx+PKoQs9jKT8JS4o1IEoncOYgm96yANulKmWmVJvFJdPD4zAhDvq0jBXax2jiS5ZJWcSqlVyyLNEoOi7QC74p3UDbLjQTbndhy2IjxmG4A1/G7cEk4JYDpIOWuJVZEORwIGjDS5rQhv+rhSbUq9tWZbTnw2eXpbK8ivlAmVBzmRZHR2CaRw0yfAKmvG9wJ6kjjo0KWt3ftf+Blntkg4CoqFSOfxV8dq2tqepddB2coDjRbNXWFFV0TAIHbbJNcCiL1ARJptcWj0sZXIcPCtUSk4muc8tRJTdbBEEDjTS8oHqlNYsA7OcXWASYzE0sgKJZFDD8KFACBEcCaPo8KMxl4tTr7FB/Pjn2sRiY3vv4bz/gaMmDF7hgXaZMH/j
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6512007)(9686003)(26005)(38100700002)(83380400001)(6506007)(6666004)(478600001)(6486002)(66899024)(66946007)(66556008)(66476007)(6916009)(54906003)(316002)(8676002)(8936002)(4326008)(2906002)(41300700001)(44832011)(86362001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I2dcg7hUaULzKCiZwMpqRBC9zp2vfkWUT7/mdCUHfzKZO88dun41+qjPlwbZ?=
 =?us-ascii?Q?9CvKWsKD67yAMt8AvVr3eliZwzETgwPZKKP77IS/KvKGQd7FcwRyqe1IkZ6X?=
 =?us-ascii?Q?hyXhDRDtM859hS+DHF8xiwRPDif6kj4MkahP9ZTTtC92weAa8DowUSxX8Hun?=
 =?us-ascii?Q?F6bmGyWpG26I7n3l6UPu0Rws8Fw5wZx29Zc67WwtvO5cksbPMUQNNl+9yeBk?=
 =?us-ascii?Q?k4lTC5X4vS6AGKVK6Dynt4OoR+nndWGL9ahcJJ7QBU8zd+2lalUcu/5vJ+/a?=
 =?us-ascii?Q?CKkxx2ZQCprErPShB7dk/ZP2Tqf1CMOSih4K/kCm24I6p0VO+lC8AxKwOIUR?=
 =?us-ascii?Q?jZg4HjW1dd5OIm7UzgXlCOAHYcH0RC8ysNRkwqRFZzZAxnuxZhLs/jlvtYUK?=
 =?us-ascii?Q?Fy6gFhDpHhGDVcJzr1YnCEJEkrra9FH0av94NEB6uMhO9wy9Pcs9eDfBZOMG?=
 =?us-ascii?Q?e3yrgEDvB2UbQvE1833A9ksHMezY2SdYvyH5zBK//o9dimsW+KHwGY6iqBa4?=
 =?us-ascii?Q?J4udRFGZuBTKtDyHDsTygle8ZSmhe1JkjvJ4c4hCV07nh00FMTfNl2qI3szo?=
 =?us-ascii?Q?uT2X6QGof+o7s+g80yhoD2sCrwy9Sy2LxCtx+NCr+bQRleqnsTDxhAV/egDe?=
 =?us-ascii?Q?g5erEXiB7z5M7tVp0cqgPudZjmKT/y8QWcQG/NKoax8tbhak9NXWFhngN39y?=
 =?us-ascii?Q?d/IyJzv1BpvH76SR1AG7Kjev1kDfxY9PoGU251NsLMXcMIYgda3PO1AiEblh?=
 =?us-ascii?Q?Ezo/t1rTll9NBd78MyNNX+a3rqABW88ErPRI7eWJ/aaTWreeZwe/GB7iclFX?=
 =?us-ascii?Q?YjKY8AECbNWf2nXQGRfo9WZcYbSFfZRrvukXabvY0YPC3Esoozn4l++1tW6R?=
 =?us-ascii?Q?Y831Q/qTO2VHqJgqFl5IoloqE1n03fpxLxzyXVMzkZCE0vLIF553unZa4dPF?=
 =?us-ascii?Q?2BSK3ByRrHEcg9MU4WMB/+PJQ0qXSGFOZFGYkCTkAwkBMCDykiGDS8uQb/MS?=
 =?us-ascii?Q?I33q/GleIgRE6cVNr+UuWN5z3t0qp7dtHamnDMIQ9xzJnL9L1fw97MZk/9bL?=
 =?us-ascii?Q?0Frt4G7AsdMJIYLokYrOwDM70VNUkhY/6DFUS0tBSuNjStfhddxpukppXOJ/?=
 =?us-ascii?Q?KolMuREqM32PhN3qXY7lPmGC3q8tQX9r2naiflaEAZqR6AGpH3rDnqXhMtzX?=
 =?us-ascii?Q?DH4kNuTpbw7cmlqMsT/qkoajzMQWtVfpmiOseFqZF8N5qI4VSxrtH6h+jckg?=
 =?us-ascii?Q?gLIvdgafEfZnZ5CvQIoHeMTKmRj6kV71PErN63ck26TGuDfrDanBqUEdgOT0?=
 =?us-ascii?Q?MJiwnn7WhGQAGC7M16QS1ow0xneHK3nkfGUUypBPTuROytliNjxzOGIf6FI6?=
 =?us-ascii?Q?Le07L0/VcNTu0p8vMgtB9qL7vGXH/Tly8PJXxWZIFOsYlxCRV4XMbWpicCjB?=
 =?us-ascii?Q?2hkUZg/K8ou23Y9XHzG6BSQ57DDH85nJpdBFDFL6c38rnyiDfHSz6hbSdcg+?=
 =?us-ascii?Q?x0/9SOIvIonmNEKadD1jvCvHhEWarPAQZMXwe51bIxVNpfG3G/iMls8nblxz?=
 =?us-ascii?Q?qqM8cjjSc8X/ZwxBlb7AJFBrc3ULno0i7LKMOWdVNkldWIR407haeJPlIcqC?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?ia8yzZD9npleWmsF4X5T1brYYQO3RrryAJCVv9kKtYj+52RLj6DR22fI1scg?=
 =?us-ascii?Q?Uex1KbYg49M59hBTofgY55ljjQFaUOxqKpsl4xopYheqicX6KmFrc8hhawH6?=
 =?us-ascii?Q?GloZmn7ea/eJY6I9DiShMhop3QV2LtUkYE1jVm5dbRqdR1yUTfogbCv/ceMN?=
 =?us-ascii?Q?ZV6TcJxww8C8lcIrTB8qYUpllXxvu2dww2VAnFHprx8PQHq4YElbb+zuaw6F?=
 =?us-ascii?Q?pWru9ikDa7iIoHuj5jQv2+kRZSxZ2dLOsgQbNI4cJhFoKJKUFU94lIGsXWR4?=
 =?us-ascii?Q?o0kMXnLJDCZLuqq8n3dNLmd4Hzvbfzij9wMhA1nKHrowwfVo/Cu11a9eSrZ1?=
 =?us-ascii?Q?LB+ntWtNQnMi/Duv7SXZEnH/FAeFFfyo5lbzNwwsvRT9Zmu5uVoQDN9UjGr6?=
 =?us-ascii?Q?vExEibQ7MnvsE9kbxhgh4xWd2eOjeDebaJZgv8oQO2rkV4BlUzFUh6eSLbiZ?=
 =?us-ascii?Q?A+FAiXrihsSCNNkOmmdntFQJGFAwCG0cgDM55B2vdGwOVrhM22gZ07ffsCaG?=
 =?us-ascii?Q?bUvlVzAd73Tjh0Y9WuOtYxXEPCVvzcGkGiKqsfug9k6m8WKLibXE73qO+/tk?=
 =?us-ascii?Q?bGo+ddsvs+7/6VGnFhjwWafN03qyNuH7QX+90WuhvELlxWGmmeB83IuP+ies?=
 =?us-ascii?Q?AkaloV3gGqv8JB6eLm796wVpcksEWSkRFx77yn3ZWJQpicAcvi0LFzlztEyU?=
 =?us-ascii?Q?/pVyp+8LgAJIkueWfrUiiL5vHdxXusajpI2wyvqZ35p0cP5akO2Xwmaaf0Lm?=
 =?us-ascii?Q?oxvTJM75ydJYhryrNoq9Xn0mmMAdCMXbEsIDVs0M82wkV2efeFWwlQMYcaL/?=
 =?us-ascii?Q?7bT4cZzldMj41AuwukIeZxelGHICGOSP5IEDzDTsilGrd4MkP5dk0DfjgSXw?=
 =?us-ascii?Q?7sNRroXFkLjYgllRnUe6z4+8hxv7/fUFILWkQd2KjKX9OmovQuOd2KEwq+wx?=
 =?us-ascii?Q?5peuaZw4pwHYDSlAtZVX0iE+2Jw26cc6yBPwklT71M4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7775b1-5011-4b11-dfd3-08dbf59db1f6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:23:04.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwbbYGUNtiqwu57mIsFLRzD0QqpSKIuHEbBf6o27Pa07L0lf+TCeYRju+Td2eqFRq9dDib/OvFgHY1Q2p4Eeog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_09,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050113
X-Proofpoint-ORIG-GUID: cImU_Ci-jqVDrjSSOQBksXaygdWpRdIZ
X-Proofpoint-GUID: cImU_Ci-jqVDrjSSOQBksXaygdWpRdIZ

On Tue, Dec 05, 2023 at 12:25:40PM +0100, Christian Brauner wrote:
> On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> > User-space processes always call task_work_run() as needed when
> > returning from a system call.  Kernel-threads generally do not.
> > Because of this some work that is best run in the task_works context
> > (guaranteed that no locks are held) cannot be queued to task_works from
> > kernel threads and so are queued to a (single) work_time to be managed
> > on a work queue.
> > 
> > This means that any cost for doing the work is not imposed on the kernel
> > thread, and importantly excessive amounts of work cannot apply
> > back-pressure to reduce the amount of new work queued.
> > 
> > I have evidence from a customer site when nfsd (which runs as kernel
> > threads) is being asked to modify many millions of files which causes
> > sufficient memory pressure that some cache (in XFS I think) gets cleaned
> > earlier than would be ideal.  When __dput (from the workqueue) calls
> > __dentry_kill, xfs_fs_destroy_inode() needs to synchronously read back
> > previously cached info from storage.  This slows down the single thread
> > that is making all the final __dput() calls for all the nfsd threads
> > with the net result that files are added to the delayed_fput_list faster
> > than they are removed, and the system eventually runs out of memory.
> > 
> > This happens because there is no back-pressure: the nfsd isn't forced to
> > slow down when __dput() is slow for any reason.  To fix this we can
> > change the nfsd threads to call task_work_run() regularly (much like
> > user-space processes do) and allow it to declare this so that work does
> > get queued to task_works rather than to a work queue.
> > 
> > This patch adds a new process flag PF_RUNS_TASK_WORK which is now used
> > instead of PF_KTHREAD to determine whether it is sensible to queue
> > something to task_works.  This flag is always set for non-kernel threads.
> > 
> > task_work_run() is also exported so that it can be called from a module
> > such as nfsd.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> 
> The thing that bugs me the most about this is that we expose task work
> infrastructure to modules which I think is a really bad idea. File
> handling code brings so many driver to their knees and now we're handing
> them another footgun.
> 
> I'm not per se opposed to all of this but is this really what the other
> NFS maintainers want to switch to as well? And is this really that badly
> needed and that common that we want to go down that road? I wouldn't
> mind not having to do all this if we can get by via other means.

The problem of slow flushing during close is not limited to XFS or
any particular underlying file system. Sometimes it is due to
performance or scalability bugs, but sometimes it's just a slow
storage stack on the NFS server (eg NFS re-export).

One slow synchronous flush in a single-threaded queue will result
in head-of-queue blocking. That is something that needs to be
addressed (IMHO, first).

Adding back pressure on NFS clients when NFSD is not able to get
dirty data onto durable storage fast enough is a long term solution,
but it's probably a heavier lift. I'm not wedded to using task_work
to do that, but it does seem to fit the problem at hand.


> >  fs/file_table.c       | 3 ++-
> >  fs/namespace.c        | 2 +-
> >  include/linux/sched.h | 2 +-
> >  kernel/fork.c         | 2 ++
> >  kernel/task_work.c    | 1 +
> >  5 files changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index ee21b3da9d08..d36cade6e366 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -435,7 +435,8 @@ void fput(struct file *file)
> >  	if (atomic_long_dec_and_test(&file->f_count)) {
> >  		struct task_struct *task = current;
> >  
> > -		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> > +		if (likely(!in_interrupt() &&
> > +			   (task->flags & PF_RUNS_TASK_WORK))) {
> >  			init_task_work(&file->f_rcuhead, ____fput);
> >  			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
> >  				return;
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index e157efc54023..46d640b70ca9 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
> >  
> >  	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
> >  		struct task_struct *task = current;
> > -		if (likely(!(task->flags & PF_KTHREAD))) {
> > +		if (likely((task->flags & PF_RUNS_TASK_WORK))) {
> >  			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
> >  			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
> >  				return;
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 77f01ac385f7..e4eebac708e7 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1747,7 +1747,7 @@ extern struct pid *cad_pid;
> >  						 * I am cleaning dirty pages from some other bdi. */
> >  #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
> >  #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
> > -#define PF__HOLE__00800000	0x00800000
> > +#define PF_RUNS_TASK_WORK	0x00800000	/* Will call task_work_run() periodically */
> 
> The flag seems better to me than just relying on exit_work as itt's
> easier to reason about.
> 
> >  #define PF__HOLE__01000000	0x01000000
> >  #define PF__HOLE__02000000	0x02000000
> >  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 3b6d20dfb9a8..d612d8f14861 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2330,6 +2330,8 @@ __latent_entropy struct task_struct *copy_process(
> >  	p->flags &= ~PF_KTHREAD;
> >  	if (args->kthread)
> >  		p->flags |= PF_KTHREAD;
> > +	else
> > +		p->flags |= PF_RUNS_TASK_WORK;
> >  	if (args->user_worker) {
> >  		/*
> >  		 * Mark us a user worker, and block any signal that isn't
> > diff --git a/kernel/task_work.c b/kernel/task_work.c
> > index 95a7e1b7f1da..aec19876e121 100644
> > --- a/kernel/task_work.c
> > +++ b/kernel/task_work.c
> > @@ -183,3 +183,4 @@ void task_work_run(void)
> >  		} while (work);
> >  	}
> >  }
> > +EXPORT_SYMBOL(task_work_run);
> > -- 
> > 2.43.0
> > 

-- 
Chuck Lever

