Return-Path: <linux-fsdevel+bounces-2843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9117EB44F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 17:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4483F2811F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4141779;
	Tue, 14 Nov 2023 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ueok4213";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DXaGhJ+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008D24A11
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 16:01:10 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308C6FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 08:01:05 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEFNqYb024950;
	Tue, 14 Nov 2023 16:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=095FJZD9WwvNnHWvVxA1eE655lWxrIqrjbW39D26DwM=;
 b=ueok42132R5dage9MrnuoCMPON2xfXiN4PC8qJQT0pk9OEUVXfyAAHOE+O4+Nx0xO9Xl
 ttVI1fUNeeP7znzZBnhV6A3X/iqLotcyMuE1eBg80j6jz7sB26TF/zZq8DfPbvhD3USn
 AsyIWEW5fCkykkHqoKLyBoOKFcHL5qb/zbpiQpEhga2YcHEWCXFbSM8tw9thdIj4xLpd
 aQZdBeBeiCGluxsszIBK4dXIE3f8w+nbkpDCTAi+1Cmq7xM9JxhG6fkgr9M0S8kje6PR
 w7xpVJR2R7uFGH4l0QYZMXd2X6gYFGNToQmb6g9i4IKzc7+uTMSRbPccp3gaViyZa/Kl 1Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n9x15y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 16:00:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEErlQu013372;
	Tue, 14 Nov 2023 16:00:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxpyf8ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 16:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYcQsCLRkvFWa83+a5KgsF9FESboQA8xEydTeylWC1Zi3kQg4K0bxrn32SfpMdPLz9j9FnRr0N2GQtEuXH9rtwKF8OxgSNaaGWmNe8cihm+g7eilN9g4IRMpbuSQX5KB9BKVSg8PiYnceICk4V2bhQHmXW2hjsGK9s6DXprGvQ3f9TP49k9yz0rSD2l474NS11/XuthwJiG37zrAgIPHtPYSpBm9cXPLwt3OYF43rNo+emMyj05/MfLtSYsoheQSSXPN7atjgf7rkw3v36BySSMqlyIonhq0snZg7o9iFBk39THBOV07paSvcR4ltAWYKsjj7PKmJzFLYgKYqNNxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=095FJZD9WwvNnHWvVxA1eE655lWxrIqrjbW39D26DwM=;
 b=Ign3/gFzAs5tmVs1vmvZ1lpYxONg4vhM09/KqLuY4dmViPIYtC7OkPc7H99TVJM0WFYn5WxL5jgDV6fSreduyHUB9LvRbZDBcLljABB/uH8RIGWRcGgz8iuI3soEZxTedc9D2pUwwY/gApfwnBsZZjSJE5gm1Ej7SGsrn2k/RbmkAOk2UDNdWBbE4huuf/6uRstQVzZu1JK/o5m1a4ZnqS2iUiyCMew6CpMPbsDAcocHv2JJrnpOgPhkcz0KvKi1+oqDxpd4tirgk35yUePAGfn9dOYYhTQvUmT+i3xB5zV6rX4OJYN6hGVLv/4LyQ0B/dGIHIR/Zd7vQfMZTRqi/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=095FJZD9WwvNnHWvVxA1eE655lWxrIqrjbW39D26DwM=;
 b=DXaGhJ+jFtDek1/0+1C9GpDX7oJBs4K+0we2FFFiE3zasjzqIGsvAS6EJME2uDw6vXpxtk33ZmukBSHUZLL8sk3munpFe6Cfmm4jVwT/bXmFEACQqfgS6JVexOjKkKMQQ5wzkitjwJWnSEazGShHHYKEYMBmOJP1X2KY52GRCvM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7524.namprd10.prod.outlook.com (2603:10b6:8:15c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 16:00:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 16:00:19 +0000
Date: Tue, 14 Nov 2023 11:00:16 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chuck Lever <cel@kernel.org>, akpm@linux-foundation.org,
        brauner@kernel.org, hughd@google.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, Tavian Barnes <tavianator@tavianator.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC] libfs: getdents() should return 0 after reaching EOD
Message-ID: <ZVOZkB2PcWvFOZBl@tissot.1015granger.net>
References: <169997697704.4588.14555611205729567800.stgit@bazille.1015granger.net>
 <ZVOYwikYNWMBg1bC@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVOYwikYNWMBg1bC@casper.infradead.org>
X-ClientProxiedBy: CH2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:610:4d::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c054b3-b153-4243-ed6b-08dbe52accf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZHFyHNsWzBt40iQY+aC+R7YZkhpUIXwBw/vC7SQ+OXGgzcX+bFr9d+S9J1Gsxps4zlA88G+h+QiU2rUpGVi1CrCKriYYN+n5DCyDohplFX/TGhS7W/n7CrpqsgeGn3I90n/T1MVXkg1Z251mCnpjgG8z/53YftKAx07WjWyIXC4kmTUPeo99bw+Cljfw7Skof5d9SycFHuAxN8reNRmUxzruLuDabkPEhToYOD3y5H/jfzQM31jVSdsAz1bE/Fr//9gSKTMBGx9NDpb2PoIPQy1K/PLhlNgR0+16IIyFmVAxuQXgHV4VDwkljMcnKA832uV+ITfgZI6v9L2UQuhyNKR3KBepVg/YIrKA60Q4bUqcECYnInA8BtoGm0WZoN0MhjSguBSO037Ljn1H9VTZZs+zDEMctIvGRfrlcgKnCKa33oE+DxuVlpxMDoEF0V3pQXDAAaRnQhUPcrZXKd+/9IF5QOHz5ApbhZKk6EpTVaS4bQFrFKjcyqQgQS+kQ+o1KAFhC90P0Ml8ipuMvUCe817g3LvIgB8LDvNexwTRxQRKGsksDT/GIbNIiRaJWzNP
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(54906003)(66476007)(66946007)(6916009)(66556008)(38100700002)(86362001)(6512007)(9686003)(26005)(6506007)(2906002)(478600001)(316002)(6486002)(6666004)(7416002)(8676002)(5660300002)(8936002)(44832011)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pbRUlL/xH+3cjj2mftwR6UWtB9KkPXm/DvYpunUHhRrpn+Cnd9lBFlPAZQVZ?=
 =?us-ascii?Q?VJOmkLbp85Hq5KoBkLUxKY50aPA+WV+WOuGZPbxVbrCFMKrwZAfEVKeZV5ku?=
 =?us-ascii?Q?rtpLuIIXjbc3KJpBH8Xk82F45R5u2RWuho3HGxALR2nygVXXpuzTnY/XgVOE?=
 =?us-ascii?Q?W13ThlpBgrB1Vf7dkP5aiEZ71fuJJBQiuUN6oLeQbrNZ2DGh/FTHDI3E/VYg?=
 =?us-ascii?Q?CYRow00OdL53ThoYQz0EXJF1p40Mr9oEaXbiaszBRrTirh+JygQPG54A7Oma?=
 =?us-ascii?Q?Ov6ZgfQMQExfXVTcTnfwu/vj5z3yU3NQ09UVxuIGtRVx9gp8vZxu/vOxa/+w?=
 =?us-ascii?Q?Nt8MLAuGhKMqB4XpUN+OAIrjoRRxynDP6zpGE6bVyG4UzT0H0yTwlQ3IcerW?=
 =?us-ascii?Q?DjVwJ6oxV9xr4qYKgyXRPKot19zc5nRh+kwAqyk9moZo5s3tU75f/dL9AE74?=
 =?us-ascii?Q?7vzBsXwfiM2EQi2G0Qng8K3DEO0+Bgh+0XRgsMp2lFUrbj6n39rnUvMGdxKW?=
 =?us-ascii?Q?Kx5Wmnn/pQSfCyqYzPKsUHbV/CtSwfI2o+SdxoydoWJyBz0cgZWKzSd2CJO8?=
 =?us-ascii?Q?u+Cz8gpnpc9d8mtbXbNWnJ64r/nRcm2ODx47r32OlmwQHne+ZxqTqMudZyK2?=
 =?us-ascii?Q?kU5qTmNXSpHK8uF0gU5sQjQA3utVsbpr9b92THNoixMQH0//MC0JGUHK03Sz?=
 =?us-ascii?Q?En1t4Mj53cwRf05rr+UY30y35T/K+Am12ms5y13MpgwLOVInYryblgXLoCcQ?=
 =?us-ascii?Q?pPM8fzVAZ7phnuAfkpLYibCNEgRiE0J34zqADZxxoZu5bEhDQeqn2ocPW04W?=
 =?us-ascii?Q?KZ2KMlk4OTIpdA6C7vbEQB79fdp3dlUYMCnyL3j/Y3AtZg5f4Ykl+B7eaIsq?=
 =?us-ascii?Q?PW3SNcgRii/UsWGC7KHnjQiYO3N+j8Ui7RrHRQleBRQNgHNVWiXJkaReZKR0?=
 =?us-ascii?Q?qAGhXGe9Y8FWuOlCe6NxqEr2SHzjANC7K4d1oo3+RpZS4M/slFFVp50G7Cit?=
 =?us-ascii?Q?Br7X/eMYKT4QRvWKKs9LRWF9vvIu59A12adayz0QH/VJuvcRp9+fnyPMhBxc?=
 =?us-ascii?Q?uaAy1oKEmTwZnYFAmOk5PG8BIEAlas4S3XAypT7fzvFnddfiLfAjJt/C6zsP?=
 =?us-ascii?Q?y/NngLkzP2NKKvGtJODVmZreQNzt1S01urfiXDV4SJf42W+Li0P576EniNLA?=
 =?us-ascii?Q?JF6nOVWES2ioW5om5jTyPDQi+gIU+RbjJ5xWizvmzrlJE9iecro4Vw+yDv/+?=
 =?us-ascii?Q?6zmhslgEbuny1re1pEJq0Q31wq9+yq9Z/3TgjYcaIVHZ3nfYkq5BJhDZtuQc?=
 =?us-ascii?Q?1FFWIy4B3LriyTNZyeo53dm+CP92nDvTTZR5BabnclDttP2SU+W9zh0/0tdV?=
 =?us-ascii?Q?MKM4yTU7jeArtFYElWDcW7H+fuiIlcq3X5flNpI7+WH+ytO+UGi6d37iD7ks?=
 =?us-ascii?Q?PTrlzoElYT3d1VfENhp4K2j6uwRNsauKPEFB+RdI/PESsb2DmDjsOcbd77+R?=
 =?us-ascii?Q?SJT2iJEsZbVhoj1b7JQp80WT//Zb/6Lj9vwoHGFNrwFYWIRWbWx+aKDB+sWc?=
 =?us-ascii?Q?mzmzhygkdoE651QP9B8S5mZ7mf7coiu8EHXojazeOifF56GTrkYQbIPeqEEp?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?9gTV4NeTx003C1vGnSAe66GXOGVzoRekhAHh1MkZujf7Xe94i5yzFNGmmow8?=
 =?us-ascii?Q?D3sxPWARvRagIXoWfCDwvRJgTO+nGkqc13ZvaMN9b3yPAK+bf5+0UKcTxkVN?=
 =?us-ascii?Q?4Tbv5Do8MRWD5GZi3ESqU2LVM8R3Mw9bJLhNEoA7LYQcvfSO+NFbf5M3zV02?=
 =?us-ascii?Q?NpNqXARXZ1FLGGs0qBK3o0vbHOF9SuTDIuQOm39sX5+Al3g8VgXffxd/84Zn?=
 =?us-ascii?Q?+L0hfcAwWsdj/S+m9oXbvH+Z/8Hg18l3PPIzzlo8JV6FhGIN0AL1CoNivRfL?=
 =?us-ascii?Q?a/EAtIyi1SCMkR3bA91lEmUcpb+KmayVoKuDq2Q/hN3dVVdKvzuAwgcPeQgo?=
 =?us-ascii?Q?aXa4PTFU/AfoSEfYcbPyCU2wd6/+JVZq3JSC8ksSG5/NYCSZbmnx/Fe3NfjO?=
 =?us-ascii?Q?xvRqRapt4ZzZecEqHf2jT2BgaSrYDT1NG0v2TvnVwoM963UcaAfyzHL3Ol6A?=
 =?us-ascii?Q?F7vX3NDAyhymkB+Xu+BP9AxKIKExNTWwW+9wJ+rbcw4CENKrQLjPjDS2V5dC?=
 =?us-ascii?Q?NhqEKSMUmsQQ/arCKDG+SKtKdrBzKee+ouxME5asJ69JCUcc3YBX51bJNQlI?=
 =?us-ascii?Q?e9oQpy9tFNDlzGhZ1sl9kkgwoRpoWdjGbWyl/pk8sTk9AZmHJyiJ5f2xQR2C?=
 =?us-ascii?Q?6IbGvj0ZDr85M6Nn5FQuh7WyuC3wVtpvvlseyJm2PvyiSv96Y1BTO+pXI/uT?=
 =?us-ascii?Q?jvIknNmMaNr9Ae1BhPCyZvX3ZCGEtPWQEbiz08GCM+iV6AG6cYb9bf0aKjjD?=
 =?us-ascii?Q?WRHvqX+ocSZ5HBa1Gq/s12l+vNC9By6wT3PK5wGPv+qcs1hPAnt94D44mQu0?=
 =?us-ascii?Q?F3g9MqU1iDf5gC2Ojl+2vqLTWU8pERoTuoaG7FY2g2VVKQdFvE0M9Wju+UH8?=
 =?us-ascii?Q?Wb9gyhaULljmjx1qkcJEvt38hlM2QKJrNT+WxAQAgLa3XFt09Q6QK1P7oDJ1?=
 =?us-ascii?Q?na0wsmfRkpFnl8IKk+UB8356c02rBzQm3AOeIdskNr7B+K9FsscH7gnAT8rZ?=
 =?us-ascii?Q?1OXH4I6o2XGCxet2CebDjW9En2XUx8CKmzZIWEeKVL1K5liZr+7POxU3lXoi?=
 =?us-ascii?Q?d5PCF4wt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c054b3-b153-4243-ed6b-08dbe52accf1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 16:00:19.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkfTtV5jouLoYJQWWayPIQtCZe4BbObcsnIhppijJeoHnQZmHfEOx8WwU0KvwroJ1Ztrp8283VZaW3knhPxRVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_16,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=934 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140123
X-Proofpoint-GUID: Q1uaAs-LhR5NgRY_I4qWOwMZV4iKlQXi
X-Proofpoint-ORIG-GUID: Q1uaAs-LhR5NgRY_I4qWOwMZV4iKlQXi

On Tue, Nov 14, 2023 at 03:56:50PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 14, 2023 at 10:49:37AM -0500, Chuck Lever wrote:
> > -static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> > +static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> >  {
> >  	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
> >  	XA_STATE(xas, &so_ctx->xa, ctx->pos);
> > @@ -437,7 +437,8 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> >  	while (true) {
> >  		dentry = offset_find_next(&xas);
> >  		if (!dentry)
> > -			break;
> > +			/* readdir has reached the current EOD */
> > +			return (void *)0x10;
> 
> Funny, you used the same bit pattern as ZERO_SIZE_PTR without using
> the macro ...

On purpose, it's an eye catcher because I didn't have a better idea.
It obviously worked!


> > @@ -479,7 +481,12 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
> >  	if (!dir_emit_dots(file, ctx))
> >  		return 0;
> >  
> > -	offset_iterate_dir(d_inode(dir), ctx);
> > +	if (ctx->pos == 2)
> > +		file->private_data = NULL;
> > +	else if (file->private_data == (void *)0x10)
> > +		return 0;
> > +
> > +	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
> >  	return 0;
> >  }
> 
> It might make more sense to use ERR_PTR(-ENOENT) or ERANGE or something
> that's a more understandable sentinel value?

Yes, thanks. That's a better idea.

-- 
Chuck Lever

