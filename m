Return-Path: <linux-fsdevel+bounces-2518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031347E6BE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54AD1B20D13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B44A1E526;
	Thu,  9 Nov 2023 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ymdNpyqA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TrwlEyY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48601DFFA
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:01:39 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C44272C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:01:38 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9DsI5P004100;
	Thu, 9 Nov 2023 14:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=zVL5VE3LdBrYWA4eK3Nu62D46Rzp0uEMP7kjq9rDWqA=;
 b=ymdNpyqAQT/B71Azf6Qs5zSNzHMiC1FtjAobj8XIEFlUuUicIP+ZYGS0Rnymh6r5rajG
 bFi8IV6IukK7oXIMYa2qAKH6Prm22Pv+QKFm4JiWt3wxY57oy0YsnTBYb98C+Yl2/lfu
 kcp0ie+Za4pCWykikPc5VaBUiD9ptZn3rlToNqpjbhhSQQCmMo/j+yyTsnoHOynIAqdW
 Mz4krGT3cFNmXRML1jjY8qUDvsAErtZj5UNNZbQsaKt9hHu/L1/6BcXG8Cn/R78BxlIk
 VCHEbuNqdPiRWLCbdwBk+6/X0bK2n6aKzop6VciRih52Eaahcml5i0kL1m61HwuUov/e 2w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2240mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Nov 2023 14:01:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9ChXhF000485;
	Thu, 9 Nov 2023 14:01:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w20fq42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Nov 2023 14:01:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1kAPUKeD87yOWJOjpGv1R96UvpVJs18jI0Zn+i9aSw50A9aFfur8Y9S2cqhub0PlarULY713KfNNlVwoK7COWClKMZRjTZ02QNQ8J8czjbKAJosOj0tJnYYNIiVAlkfn1tFXVyqHhrVCKWU9OmLAbrsXPrRbQBkiu5ivz6n3L0Kf1fq0Fuvmn9pveZxdNOopEhitf7h3vI3Wpjf8REniFvuOj63qVM8/3fEXyvUjchNsWH7nIzNA7s4F4ixR/yJKNfWNp92EwAoQUDoOeqsPP5H/SKoBrMu4+WbdEhoxwekKfJ8Zn1fNAU983aHWE+yuncMsPfthfcN3LHqCg9mBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVL5VE3LdBrYWA4eK3Nu62D46Rzp0uEMP7kjq9rDWqA=;
 b=KX1YmyUOfMhTsvcRlTT52OYFVW42q0u69oC8txlTFvOOW+v2LhjtSc9+Xfy0tDucmD6lI1UElMJ1eicpwvr3WwcVFfuaQbMfrALSx21JP6MwprVRLMigGKR2xhPPvEp1J+0wMifb8knSuXgw+e/boxElw+uJ391Tq4I+rGW5wEp0gZ7GwmRsdQfu6hp73nUtvft96X/ViJYhgTwHwr/a+bsgkUwbvkMHuSVeCO3IryMlveSPqWQpptuqtuznukE1HgVhOfRQaPU21QclLXydOAdrK5lpcrj6N1CnPmexsTmgNB2d5f5YWy0J2s6Jqgaeu+c3+OpyEiD6aDPt8b1eWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVL5VE3LdBrYWA4eK3Nu62D46Rzp0uEMP7kjq9rDWqA=;
 b=TrwlEyY/7aYVCFrWlpzXJVM7bNFoqs3B/etn94VPBYW9ozoEPpMV1bZ9PonUlMQTL6JnkpcM7VkgIeKwIMBZMYWlk3FvzumJhJPv/GTBzNFA+1rM6PRs2lGsHOkf5WLTTrwveuZzTrdJKUy2SQMjqCqLbGzMjCedCV2IdQ2KokE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4928.namprd10.prod.outlook.com (2603:10b6:5:3a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21; Thu, 9 Nov
 2023 14:01:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::3474:7bf6:94fe:4ef1%3]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 14:01:22 +0000
Date: Thu, 9 Nov 2023 09:01:19 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 02/22] switch nfsd_client_rmdir() to use of
 simple_recursive_removal()
Message-ID: <ZUzmL0ybLk1pMwY2@tissot.1015granger.net>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-2-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-2-viro@zeniv.linux.org.uk>
X-ClientProxiedBy: CH0PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:610:32::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 11893a67-a4e0-4380-f8dc-08dbe12c5af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/w6krAXbHnFlI4yihORQ0FyMN5yOVuDxy9kU+Ffv2DpY2MPA4ahb8w6xJHKGHRfYBkKcbOopegGV2q7OYM+BzlRICPe41WSeiDCBswUgVciXBXym3rDQAxJcRWN3J/WXZeGt2mfBER5+uo6o1eXrkdKJARbBLfFAYvG5ybEjWM3GP5xO0mhbavKmzJyVBZCfaaMXnkXRgH+SPu8NyVyEFOc1O9xEZkZ3fDLHNpnNKdqNM/407a8xLxaqHBtc7EuV3qI8fBKEhJrBmhDvrbdX38caOyZM7rKF8i5Tr2EsO3/GglWFv+aqI05JSrX1c8O6A5FLKEkadC8F0lbN+8V0DNWInm1vbCSmcYiEt+JIwiR8rboNInrB3XiJfo7vHQP4RNelU7uf3s+qw66p8+HfiXXm5rFpHGUQFsa+pns4EfkXj67Rs5iye0Akhr146Qu4Pb657x7QYXXYasH3DX69QTYPXibYQVvs1sabuJcTtbGnNLqJFXpMSkfSrUeuaoD0KgtrMMSO+NpOMC6CFqmNSZzi2pV9vWIMWW1qasJGp+ejG3NLgSFwLiVGXiHVBZa/H8hHM9oqpaN7JD1VnZ6kL28FipM1AOK2B12Udnqahx4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(44832011)(4326008)(8676002)(8936002)(2906002)(5660300002)(86362001)(41300700001)(26005)(9686003)(6512007)(6666004)(6506007)(478600001)(6486002)(83380400001)(54906003)(66556008)(66946007)(66476007)(316002)(38100700002)(6916009)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VNUpNyRSWCtVJKeZrvyo71D93gEG7tIzW88zSEXcUrKxC2j9xxDW8oEjglD8?=
 =?us-ascii?Q?dkK7jZb8OW0/YhiG0Y9HfWwrCxZkwR/RU8UBw9cKKZzxOhfPQ4waBiB3Urnf?=
 =?us-ascii?Q?09ZZZwqFNndg52bkRhyP3ELY9TTeLlgUTl0rFfO0XeFm8BPpD69txMReV7HK?=
 =?us-ascii?Q?ACFdIW/fJSPULW+gHc4tN0Gwf6rgf8qvPzR2lpGu8Go0FzN6wrcrMPJMhyh/?=
 =?us-ascii?Q?TU04u4W/jc8Qf9kt4heW37RLi/vzyjX971gKU08S9hzNNSUPbRyOV6pWjQiq?=
 =?us-ascii?Q?E+7HWxftyuC8jT31FOCvkcIyOTrt1VFc3RUuchAzXmJecR0sBt2hGsBAKl3g?=
 =?us-ascii?Q?Vk5PUMhXZQ5g4QtVF8h142xEy23Rcp5aInM8RNHxq6J42X6QEyC1AI9ykn/S?=
 =?us-ascii?Q?d2KQ8zZOlXURxPH+9u5iZ0fsEXLQcjLbILaP6vl+PM1mYbVNUQWVuDAxuy2y?=
 =?us-ascii?Q?WkoN97FNUXp0yrzL4zqFxv0JGroifv3ZPYKEWQLbcQv05nIeJSKkGvaOlcnr?=
 =?us-ascii?Q?HLUwrcV2T+T7oknC4xml2Bv3eeqOcxlNRW3NzkyCE0XLKm3m0IV8OXPhxmHh?=
 =?us-ascii?Q?2aaJvDiZRgILIB2N+ASFyvO3uS/h0LRkBb1HINWw35GObQ2MtOgCK0L5c3nL?=
 =?us-ascii?Q?/fsrUWj74udlQTHjIqEdOegApi9UuXH8g+FL3HQqMV+VXU6OGdHc7Vnn06AV?=
 =?us-ascii?Q?x1iYLnIdXz85KTa47vo386zFM5HGggS3WHZZTN5dx9NN2u9UDMdywFImNYBY?=
 =?us-ascii?Q?g2ApoIexHsFE0mjwLzfaeEm2VWgAtpQzV84Zfau2ddZkrhD/nlN1Cwu/h7EE?=
 =?us-ascii?Q?1YVfZOaIcv2hRP2JNVUUPr49le+4T8S8sC5zzMRGCidDVVVkFegA+f3lIWKJ?=
 =?us-ascii?Q?f2yYxRrshZhaIy4s0rOttTZPC7QTs99KaFh0LON/udvP6B+QrCw29MjBtfZ8?=
 =?us-ascii?Q?RLYZurcLd53e0zOD7jfmr2RSzMLpMewTjS/NWqElng17jbln4/A86n2ok7vE?=
 =?us-ascii?Q?dVYRKuTPhKvPva1ZGVXLlkqPerMVnut7LpjCLKH9LoRzEKVdWCY9uQCKui0Q?=
 =?us-ascii?Q?eUdDcOjdN+isle1+fqFEImlriTK/G2hqFuxJ/YVNnNkVhmCY20iiZXAplxzP?=
 =?us-ascii?Q?D4M6n83AFQQgREcvCGeNsxUvrM8nHIMDdy3A1tin71oVnD4LnGfblUD4G15V?=
 =?us-ascii?Q?tdETwelBQN8ehyQAvONOv1f/QGaiTgnNdgbvBwNL0ypGWv3prS7EsCyS9ZFr?=
 =?us-ascii?Q?YrwwFAnvURx5FslY1/43Scze0mjU7RAhq2pY0/8y+OGZafANihsSqDMJz9W1?=
 =?us-ascii?Q?V684efVbxOFwxRuyhVMgqVAogM3ToMojrR8P4fYfkg3oMS88qjugCW2t3tWx?=
 =?us-ascii?Q?UjDffkvetA1uuBW1gmPysCaTmPICEWAAI0a27sEAms7AZMXXv4TVznMG2w0P?=
 =?us-ascii?Q?bjX6nU0eraBdkRNkharSboCeJ9Kiy+/2ie2d2HC/rwfT4q66LfGX1/+hARwA?=
 =?us-ascii?Q?6slNeR8X/KInx01N/nVOxalWsu9LwCajjefij31v1G5ki2Vno6nIfy3SNRrO?=
 =?us-ascii?Q?27G09gq98+QXnizu3J+sPPsDrs0r2Si89raDHNIACbhTyp5ccsuZsYhqJruP?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xBgtv3YJXHozOHaxGJVpBaHhaRRJcsyOXt6+22T7HzeUH1qBCmZpCpuTkJepLratgEBhPqKS0jdWWovC4EsruT/XAvCQ3mNaEHLV9mQ21HaIZhaBnVL4iBtENpxsBb8v2MrfxzzQtqM8tC+NG1zl7oyTJ/G0bSVZvGmig5Cn1HBDk4tzni/uxP4lVcruKvzE+vsp0mFHoJeCLRtZ33FimglG4J73IkqzFtuFvnhtl67bGPlJEeeFdvfng4hIZBidWuvcCeN/XXZk/6pcbmFTthU3CekCOOwMGI9ZVZbhJA2iMVu7cXjeaTb6KsggHplvpy3bozvLSX+7RVSoUyVM6eWIdy/V+AE9s7O/oqloJPJeGmh0GnUe4ZHWBtB0hg9Ou3Ij1KSBb2uimVeZa1K5hI6pxAqrq2K0zsolSk08PKWmxepu92oEjd3P6PV6+WTT4+idNDQFpQtR6j44fAU+GK0frbvJ8pqA7GqF4YnqkMoKzlR9c4qvG3U+CUlxNfAms66k6eMcWCAN2DUsK51VdrJAD2kVYe0N5oyNKZ8d3YTLp1L+amge1azNDQAUvD//1H+kXL1kzgRb1+5bD75rvDcK8Ynp5YdL6CsJ/WmbspZDBTG/G9+QPU11oKUN7rE5/GUSS83p0RBodegSInsj57qHFQrDG78tRUlNOjSbGp2kvvpbRgcsMz6OEu+SqFqcXfWH6RPNXw37R3rJr8c5RpSQbGsnbR65VROzfCst/Jss2Y+phqMAvnwhP2r21HiMDRnEcw/c0pHgO5nn33SlGOPLvE56JAAyJ3dGj4dFThttUlG8TqAoy/0m4lyygTz0u92oyBhfuOG+IaezOWaLbazz+261R2/S719QURz1/fCjvS8hjIvpm7oX9oM8/hyRv1IPe5m8dPv8LY/fvu11DQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11893a67-a4e0-4380-f8dc-08dbe12c5af9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:01:22.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoDHrULrfTntdM5NeTImohE4UnINnnX5aw7RxphlQxATzxst2l0cDjmOtt3XQVcjCqurhhuwnoH8XOPR8+qT4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=968 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090106
X-Proofpoint-GUID: Gj7TyuO6D0eKVTT_mKRCVKWGa_B2mq7F
X-Proofpoint-ORIG-GUID: Gj7TyuO6D0eKVTT_mKRCVKWGa_B2mq7F

On Thu, Nov 09, 2023 at 06:20:36AM +0000, Al Viro wrote:
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Future me is going to be mightily confused by the lack of a patch
description. I went back to the series cover letter and found some
text that would be nice to include here:

> 02/22) nfsd_client_rmdir() and its gut open-code simple_recursive_removal();
> converting to calling that cleans the things up in there *and* reduces
> the amount of places where we touch the list of children, which simplifies
> the work later in the series.


> ---
>  fs/nfsd/nfsctl.c | 70 ++++++++++--------------------------------------
>  1 file changed, 14 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7ed02fb88a36..035b42c1a181 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1235,63 +1235,34 @@ static inline void _nfsd_symlink(struct dentry *parent, const char *name,
>  
>  #endif
>  
> -static void clear_ncl(struct inode *inode)
> +static void clear_ncl(struct dentry *dentry)
>  {
> +	struct inode *inode = d_inode(dentry);
>  	struct nfsdfs_client *ncl = inode->i_private;
>  
> +	spin_lock(&inode->i_lock);
>  	inode->i_private = NULL;
> +	spin_unlock(&inode->i_lock);
>  	kref_put(&ncl->cl_ref, ncl->cl_release);
>  }
>  
> -static struct nfsdfs_client *__get_nfsdfs_client(struct inode *inode)
> -{
> -	struct nfsdfs_client *nc = inode->i_private;
> -
> -	if (nc)
> -		kref_get(&nc->cl_ref);
> -	return nc;
> -}
> -
>  struct nfsdfs_client *get_nfsdfs_client(struct inode *inode)
>  {
>  	struct nfsdfs_client *nc;
>  
> -	inode_lock_shared(inode);
> -	nc = __get_nfsdfs_client(inode);
> -	inode_unlock_shared(inode);
> +	spin_lock(&inode->i_lock);
> +	nc = inode->i_private;
> +	if (nc)
> +		kref_get(&nc->cl_ref);
> +	spin_unlock(&inode->i_lock);
>  	return nc;
>  }
> -/* from __rpc_unlink */
> -static void nfsdfs_remove_file(struct inode *dir, struct dentry *dentry)
> -{
> -	int ret;
> -
> -	clear_ncl(d_inode(dentry));
> -	dget(dentry);
> -	ret = simple_unlink(dir, dentry);
> -	d_drop(dentry);
> -	fsnotify_unlink(dir, dentry);
> -	dput(dentry);
> -	WARN_ON_ONCE(ret);
> -}
> -
> -static void nfsdfs_remove_files(struct dentry *root)
> -{
> -	struct dentry *dentry, *tmp;
> -
> -	list_for_each_entry_safe(dentry, tmp, &root->d_subdirs, d_child) {
> -		if (!simple_positive(dentry)) {
> -			WARN_ON_ONCE(1); /* I think this can't happen? */
> -			continue;
> -		}
> -		nfsdfs_remove_file(d_inode(root), dentry);
> -	}
> -}
>  
>  /* XXX: cut'n'paste from simple_fill_super; figure out if we could share
>   * code instead. */
>  static  int nfsdfs_create_files(struct dentry *root,
>  				const struct tree_descr *files,
> +				struct nfsdfs_client *ncl,
>  				struct dentry **fdentries)
>  {
>  	struct inode *dir = d_inode(root);
> @@ -1310,8 +1281,9 @@ static  int nfsdfs_create_files(struct dentry *root,
>  			dput(dentry);
>  			goto out;
>  		}
> +		kref_get(&ncl->cl_ref);
>  		inode->i_fop = files->ops;
> -		inode->i_private = __get_nfsdfs_client(dir);
> +		inode->i_private = ncl;
>  		d_add(dentry, inode);
>  		fsnotify_create(dir, dentry);
>  		if (fdentries)
> @@ -1320,7 +1292,6 @@ static  int nfsdfs_create_files(struct dentry *root,
>  	inode_unlock(dir);
>  	return 0;
>  out:
> -	nfsdfs_remove_files(root);
>  	inode_unlock(dir);
>  	return -ENOMEM;
>  }
> @@ -1340,7 +1311,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
>  	dentry = nfsd_mkdir(nn->nfsd_client_dir, ncl, name);
>  	if (IS_ERR(dentry)) /* XXX: tossing errors? */
>  		return NULL;
> -	ret = nfsdfs_create_files(dentry, files, fdentries);
> +	ret = nfsdfs_create_files(dentry, files, ncl, fdentries);
>  	if (ret) {
>  		nfsd_client_rmdir(dentry);
>  		return NULL;
> @@ -1351,20 +1322,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
>  /* Taken from __rpc_rmdir: */
>  void nfsd_client_rmdir(struct dentry *dentry)
>  {
> -	struct inode *dir = d_inode(dentry->d_parent);
> -	struct inode *inode = d_inode(dentry);
> -	int ret;
> -
> -	inode_lock(dir);
> -	nfsdfs_remove_files(dentry);
> -	clear_ncl(inode);
> -	dget(dentry);
> -	ret = simple_rmdir(dir, dentry);
> -	WARN_ON_ONCE(ret);
> -	d_drop(dentry);
> -	fsnotify_rmdir(dir, dentry);
> -	dput(dentry);
> -	inode_unlock(dir);
> +	simple_recursive_removal(dentry, clear_ncl);
>  }
>  
>  static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
> -- 
> 2.39.2
> 
> 

-- 
Chuck Lever

