Return-Path: <linux-fsdevel+bounces-4816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631D9804373
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 01:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1AD1C20B67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 00:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5BB20E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GqeG0FDB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F38cXeVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A92FF;
	Mon,  4 Dec 2023 15:48:36 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4MoDra004788;
	Mon, 4 Dec 2023 23:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=2EmRuB9JBSMw1bcYHJ/+d7IPydoyU1Rg5xivsTsvDZg=;
 b=GqeG0FDBYw+UubwZUhcsnpee74g/uZzKbjvyn/AKGFAchCLvhS+DcKaNUOQg9AZS8wky
 U3hjVfl+1NeepZ5enfMvAXQVCzvpJKoqUMZtO2ZUUNoAI5ogof1Rq5kphSoxgEe48Q2T
 KRyRNemWhLpQCJJ6VAT10J5aGP+/UK+52jR8xk8GFIzdW116ixdor8NDnFNxvgam42iT
 zuvAntk+qzYbgOTz0LfhP9eRKSTselDdioQnkMkKEZPl2t39jznWSp5CXLNUClXFVeRV
 4lv+d7wiaEGMKKpvpD5RRNfjVk9b2TDsUUkS39Hk3RAPSfz7doZPg2dh86IfjmAfwWWD lA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usqnf03xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 23:48:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4MIqN5018466;
	Mon, 4 Dec 2023 23:48:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu16jgsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 23:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRihtmWBBUrOAW02+RmOE2T0a7+EawwmhYV+6AzNssPjrpersx+mRoasNM2IvMbn/vwSRoOD3aLVR8wl1N3l5SHkuVdudnf7A5ntEDPUiSAlUf5gDQ94u3DzA+0NQOaNUtmn4mvMjhj+I4s73qlLlcvLm6SjfPvdYFwQjEBt4RnQZVart75fvoWLulr+KiRLmvbrwFQKIiVkbOmt+JqR51vnFg0zaJqOCOIRyutR/qfcVoJ6qr7YYql6Px2Ad5BaGQ2lbUR9kpZ9u8VPZawPGRxTsZoInf0DwjssZESU8IkaPAvCUf72auV1NzRaba8MAiymrq2Y2VxBcO5wk3NqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EmRuB9JBSMw1bcYHJ/+d7IPydoyU1Rg5xivsTsvDZg=;
 b=KFubGaFb8NcJYytCWjwLyrg35kh1Bw4cSkFq2WPRVubpXj32kREWSu+gpFteGyCa9AVvb4tH9nU9DPYPh3yb/O+aTwFRZxlkBgyQ1/R4Cbt2R1rmyjdsQSPKHEgqb8hEIyh6G7ZZ1AqRchUW3QlfSauvUFkLGtbJad9rPLI8xfyz5AaC2IZ8LM7FbFl0zA9n+ioA2QbaXg96gWDDAT4IZP6muBtiAI6mF1hbqH8i04y+XB9RJC2FSNA01G7Bb3iTrlJKP/roNTlT8N9FDwlFUoR2oULe8CsHlYOZeed9/HCbtKkSJbwC3UkGg1oCcQCBb9l2KEm4JounKTRpqsH1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EmRuB9JBSMw1bcYHJ/+d7IPydoyU1Rg5xivsTsvDZg=;
 b=F38cXeVuH3VkYiyUWnmePzJTxRuuwjoUsifH462cL7eFppg28vXHM83fB8t0HX7E/cMCtepInfqE7FwtDQZljZSUzWzccYyNEedbqP94ATky2uAkqSNV5EIYnHLf2odSb5EF5X/qA5sgwFFBi28nGTOXaea1pOsHaYaaFiTwe5I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7012.namprd10.prod.outlook.com (2603:10b6:510:272::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 23:48:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 23:48:16 +0000
Date: Mon, 4 Dec 2023 18:48:12 -0500
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
Subject: Re: [PATCH 2/2] nfsd: Don't leave work of closing files to a work
 queue.
Message-ID: <ZW5lPKF2ukGvN7D4@tissot.1015granger.net>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-3-neilb@suse.de>
 <ZW4FMaXIbJpz9q1P@tissot.1015granger.net>
 <170172846859.7109.7793736990503454731@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170172846859.7109.7793736990503454731@noble.neil.brown.name>
X-ClientProxiedBy: CH5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: cf00abc2-79de-41b1-d866-08dbf5237c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2h+aY6MGrn2qDKSPUKHPriFrCf2ebytLJOBQ/ogyUTGfkDOEaByGMPp48FfaNZZRpzIO/Eb4mMtbIvUb+Ps5tOwh9VQAtuR+gVW+n7x0R9TVNyGRaMmxzfsrvC5bXcTVAB52Nsw59P+BcuO+XPH4KwinEDeFDV5LL2lMBQ+5Xq3zcO6i7dUezdn3/y5RPZTdW80Dxtnp1jcN5+3STP7tK+Z51XAMxLuGWOuKTi3NuntbbGgCrpy6K5aV0S6lLPSYMAUeu5ee3MyDQQJndLzmRvkVNkhTo+O8ic9z211PTvTvP7oelLhrQj9b4ViWUvJ2ALRC3KNyNWcdNEpAlUTYGjzCOzQ+jbi18oh/Ug1C83nF6vf9c+cr31ks4JFMxRvLAJHj5DovHcJBqzOl0LEXtkvLw7kKIEqSGCEkN7rfY/tOUhZ0/gIW2jvDM8SIvV0LifW3+1qUMPZB5ktndLnzTHKgBuJ5IZQZvR1a3dC3R59yCaWyiIZfszELGOH+pcRGHe0LbVYUKkHnN+1ub8YWawcbMTDpcSVjNseYm76lXe8gTwsMZVtuboebMYR16L4m
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6916009)(66476007)(66556008)(66946007)(44832011)(54906003)(316002)(4326008)(66899024)(8936002)(8676002)(6512007)(6506007)(478600001)(9686003)(86362001)(6486002)(6666004)(2906002)(26005)(83380400001)(38100700002)(41300700001)(30864003)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8jMmHDLhSiOd4jOYAdtVCEoP5VDpSk4WGWSLNBO5o1IuCyB+aEq67WhOx3tB?=
 =?us-ascii?Q?WJye8H+ImgbgcOz7JAL+B6UvkRGP1/Yk8NmnxD93dU3Hrv04dqVom9SghY1F?=
 =?us-ascii?Q?4wedQZXw22A1JBWI6HA9bYxOY/xRSC3TsEMIrCCBhuSsnsZeS7yck1zkvfDp?=
 =?us-ascii?Q?ryP4dVZnfh5Pk8e93bb2b58urY/KK7qVA1Rz5J6uaMul9Ah1WIbLlWqdD2Pn?=
 =?us-ascii?Q?+PtpQViyOPkGmD9gJrlCFNV03l9zcca7T8Hz8/u8kJuqASc08KfgfnC3hGlZ?=
 =?us-ascii?Q?Fb/ZapL/2C02aRVwRqcblVJHteEkYRGxxJqLphQktq9nqTJiSA2DuLs3WrWd?=
 =?us-ascii?Q?3iXNw9BrWEMtkDI/ArlFePXLUAPVFh5UZo4Gsva1tt3r6tNWvY/ppBlXWWh0?=
 =?us-ascii?Q?AzwXUU0yzpOe85UqXDqZzDqeB2avGciSI/33bs6iVxHgRefFiDbc5fx10aJP?=
 =?us-ascii?Q?1wz6Pfha8UiqsQ4nB/Mkt43n0fSGRJZ+JWlyfiW+QGlgTsGFBm2HtQxDLn/l?=
 =?us-ascii?Q?qjHLDJbf9GYNsG9pN9SQ/QzlQTMnbjMkmjA0ZvmOJnt2480xy9xB6OOHPS0y?=
 =?us-ascii?Q?HKvn9VA0741yEqdOp7YcFgfFEM/MfyNndUtTP6cgoM+el5eOSlJwt8FBNON9?=
 =?us-ascii?Q?pEgMRapYVmTzAj5+kbUoesoS7zNXUc9CTlK4HcWNQ+u0bSpNuQT4aVR1djB+?=
 =?us-ascii?Q?NZUrU9GzKVvVjGfOuANl+FYdZYp8Hfw9+9/Jfpq2xGe4C3/JB343CLfWif51?=
 =?us-ascii?Q?Z8Ay+s5kLi+9tWsdWzlPvnARSoH1ZQMPv9AXQeMPnMcvUcGOa0OWxXytg9YU?=
 =?us-ascii?Q?Gdfmd4frUzm3TOq57yL6aUnYVS++iQCO3qvDunIcr/QeyqxVsXP0WWTH2jsD?=
 =?us-ascii?Q?1dp2P6ga+XN8tx89D+gsaYSq5e5c0+XStxhMXkx/NauP1S9Z4Y8uSLcWp20c?=
 =?us-ascii?Q?HS0NElwbrkt5VpVXogCfKjzZSCCUNJIWyCfEx08iu0zvLlM3lwELgJ3VsGZy?=
 =?us-ascii?Q?M9xOekzg3s9vEikK3X1iI3RLduUAgJSFvBGfmeoj9MRhbM8fPHLI011GO25p?=
 =?us-ascii?Q?S4zPFSl/636qcDMADdS+SrxULiwEIAFUxQcTKqKFUsPEse63lPBZ50p54mTt?=
 =?us-ascii?Q?+rlV3G6cJ6Cq1URmdRImuEzjtJpVBmRiZQ6U/o5boDzsXAjFUlSwhmiXvPgn?=
 =?us-ascii?Q?EWIrrxR92IqobiQnrl6HmqRirijb3dUrFnMRBDWQhfrx1YjYpghFOvfy5V8I?=
 =?us-ascii?Q?LiScAp/qXws6gISNmIkFBNT2X3OApPsUReUWzDmWh36LVyZe0VrhII3wR+oV?=
 =?us-ascii?Q?XleBWqPExQYB+/EieZhhWOqoGmknYSRnJor6063D/7bPZNgFJZnMq9wYPlnU?=
 =?us-ascii?Q?gmCIbW/YXXw0rHl4aL/jNDTA80OeLJnPf9Ikh6kUmRiAmCfvxQ4/eM1vlKge?=
 =?us-ascii?Q?H7qrSkgj12+fkb/DeCRM0bBqKp98dxZaIe5Q+ib/U5PiqUxWhBkQD9GItKUN?=
 =?us-ascii?Q?WRcxITUCVNWy2QOzSDmfkaiijDQ1KTsjEZ8gZANKkwGiGJh7jw3isDSQ076a?=
 =?us-ascii?Q?QPRQtG9jteuzgluKG495kgxaaK5LTQ0K8ZdCNYWe+rXiw3Z+aIIKyvfHBNFB?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?icKLTeioPUBWIHXSi6lNPYFqnD8BpQ9vIAOfjrxFALgCt1eb9kBmG9BPt3Dc?=
 =?us-ascii?Q?sL9/w4fwdHrn9wz1SnM2V6883uiAIUgQ1mBxrox5LE6Qlhv3yYcByF5xQBNp?=
 =?us-ascii?Q?fJzcMUHm16N7OnaprcDSZOygS8B6F3FNF159T9y91oTvg2dS4/67pWPI5eRe?=
 =?us-ascii?Q?wTGtfsDJdqZaGZMyWSy8bivJ2cHkcFuSm1oywANK9fPS/VH6JdX8yiQuRf4R?=
 =?us-ascii?Q?6jjyfb/e7F+qe9kG9Yf4PBIXegM67r/aMnDyRokQp7haqYYZH3Ya9daQZvuU?=
 =?us-ascii?Q?puOhIPEBlr//xTfRvOxvosPREkiIo5YRzOpTmuAntBvr3ZBVJKg1cQ9e7uVW?=
 =?us-ascii?Q?Cl1WMWyyrp0rekdnsNBkU++5PXgfuFOnowNXXAA64GJyP1RsB5GRm46x//Pa?=
 =?us-ascii?Q?XzFCQ59lwE0V0sM/MewtnC8KRcK/XDlGAIg1EpxNFTM5HdfoBB0+4XncAzPe?=
 =?us-ascii?Q?FJABw/3lZGTJhp3CaB/2e99cw2T4tYGvEuyFvT09lo3HcmGIpNai5VAyg3kK?=
 =?us-ascii?Q?D0w7oTziiW2U1Hq0CMsWX8I7dFuRJqq0JSteHVcxZuP697LhmuXmUE+3hfu4?=
 =?us-ascii?Q?1Xf/CpmRxmY1sF3vVBQwXxhII+uU3lnN9F5qVyUd7eH/6V1eHFwppORxlkDn?=
 =?us-ascii?Q?qgfHIOzZ5wQ1AeQGVwvMoS57a1NtqMbbFZfktH5mPlPn4ZRqLCDrxxfmqtFB?=
 =?us-ascii?Q?uuSGNYY2MAu5AS/B79agGu+h4tlckjW/MEzt6f/vsJFnDtDtitOfpYv/NDj+?=
 =?us-ascii?Q?GmyOaf9eB1muDkTfiSpfWV7X7TBcQFmttwZALStsJV5Od5MbTtyzbaZkVH20?=
 =?us-ascii?Q?D2r+1SYgjpdD/qwpNFNrv0R3ssQuZHQwAIgEC+eYTz23sTrz8Mdw118yoZB2?=
 =?us-ascii?Q?OJ/5PZicsjZWMTzy6VKpHr5EZ/LnKohrpgKw7LJN6xRhB/hlbSTxUzGnf/yp?=
 =?us-ascii?Q?/Pu1prGMpjeXnt+na/2q183eDFkUqmZCM1+ggLhSNWM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf00abc2-79de-41b1-d866-08dbf5237c41
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:48:16.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aljvok+k15uGzHtCm0NNcdQcc9186HshDTncL2F4qwGRdUuSzVnjgAXW8n1CFVvQynJv5ZWIv7wWD2ESIufrmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040187
X-Proofpoint-ORIG-GUID: aKsQErDMTiOgjZJyBZG9K_vnhA-sopkX
X-Proofpoint-GUID: aKsQErDMTiOgjZJyBZG9K_vnhA-sopkX

On Tue, Dec 05, 2023 at 09:21:08AM +1100, NeilBrown wrote:
> On Tue, 05 Dec 2023, Chuck Lever wrote:
> > On Mon, Dec 04, 2023 at 12:36:42PM +1100, NeilBrown wrote:
> > > The work of closing a file can have non-trivial cost.  Doing it in a
> > > separate work queue thread means that cost isn't imposed on the nfsd
> > > threads and an imbalance can be created.
> > > 
> > > I have evidence from a customer site when nfsd is being asked to modify
> > > many millions of files which causes sufficient memory pressure that some
> > > cache (in XFS I think) gets cleaned earlier than would be ideal.  When
> > > __dput (from the workqueue) calls __dentry_kill, xfs_fs_destroy_inode()
> > > needs to synchronously read back previously cached info from storage.
> > > This slows down the single thread that is making all the final __dput()
> > > calls for all the nfsd threads with the net result that files are added
> > > to the delayed_fput_list faster than they are removed, and the system
> > > eventually runs out of memory.
> > > 
> > > To avoid this work imbalance that exhausts memory, this patch moves all
> > > work for closing files into the nfsd threads.  This means that when the
> > > work imposes a cost, that cost appears where it would be expected - in
> > > the work of the nfsd thread.
> > 
> > Thanks for pursuing this next step in the evolution of the NFSD
> > file cache.
> > 
> > Your problem statement should mention whether you have observed the
> > issue with an NFSv3 or an NFSv4 workload or if you see this issue
> > with both, since those two use cases are handled very differently
> > within the file cache implementation.
> 
> I have added:
> 
> =============
> The customer was using NFSv4.  I can demonstrate the same problem using
> NFSv3 or NFSv4 (which close files in different ways) by adding
> msleep(25) to for FMODE_WRITE files in __fput().  This simulates
> slowness in the final close and when writing through nfsd it causes
> /proc/sys/fs/file-nr to grow without bound.
> ==============
> 
> > 
> > 
> > > There are two changes to achieve this.
> > > 
> > > 1/ PF_RUNS_TASK_WORK is set and task_work_run() is called, so that the
> > >    final __dput() for any file closed by a given nfsd thread is handled
> > >    by that thread.  This ensures that the number of files that are
> > >    queued for a final close is limited by the number of threads and
> > >    cannot grow without bound.
> > > 
> > > 2/ Files opened for NFSv3 are never explicitly closed by the client and are
> > >   kept open by the server in the "filecache", which responds to memory
> > >   pressure, is garbage collected even when there is no pressure, and
> > >   sometimes closes files when there is particular need such as for
> > >   rename.
> > 
> > There is a good reason for close-on-rename: IIRC we want to avoid
> > triggering a silly-rename on NFS re-exports.
> > 
> > Also, I think we do want to close cached garbage-collected files
> > quickly, even without memory pressure. Files left open in this way
> > can conflict with subsequent NFSv4 OPENs that might hand out a
> > delegation as long as no other clients are using them. Files held
> > open by the file cache will interfere with that.
> 
> Yes - I agree all this behaviour is appropriate.  I was just setting out
> the current behaviour of the filecache so that effect of the proposed
> changes would be easier to understand.

Ok, I misread "when there is particular need" as "when there is no
particular need." My bad.


> > >   These files currently have filp_close() called in a dedicated
> > >   work queue, so their __dput() can have no effect on nfsd threads.
> > > 
> > >   This patch discards the work queue and instead has each nfsd thread
> > >   call flip_close() on as many as 8 files from the filecache each time
> > >   it acts on a client request (or finds there are no pending client
> > >   requests).  If there are more to be closed, more threads are woken.
> > >   This spreads the work of __dput() over multiple threads and imposes
> > >   any cost on those threads.
> > > 
> > >   The number 8 is somewhat arbitrary.  It needs to be greater than 1 to
> > >   ensure that files are closed more quickly than they can be added to
> > >   the cache.  It needs to be small enough to limit the per-request
> > >   delays that will be imposed on clients when all threads are busy
> > >   closing files.
> > 
> > IMO we want to explicitly separate the mechanisms of handling
> > garbage-collected files and non-garbage-collected files.
> 
> I think we already have explicit separation.
> garbage-collected files are handled to nfsd_file_display_list_delayed(),
> either when they fall off the lru or through nfsd_file_close_inode() -
> which is used by lease and fsnotify callbacks.
> 
> non-garbage collected files are closed directly by nfsd_file_put().

The separation is more clear to me now. Building this all into a
single patch kind of blurred the edges between the two.


> > In the non-garbage-collected (NFSv4) case, the kthread can wait
> > for everything it has opened to be closed. task_work seems
> > appropriate for that IIUC.
> 
> Agreed.  The task_work change is all that we need for NFSv4.
> 
> > The problem with handling a limited number of garbage-collected
> > items is that once the RPC workload stops, any remaining open
> > files will remain open because garbage collection has effectively
> > stopped. We really need those files closed out within a couple of
> > seconds.
> 
> Why would garbage collection stop?

Because with your patch GC now appears to be driven through
nfsd_file_dispose_some(). I see now that there is a hidden
recursion that wakes more nfsd threads if there's more GC to
be done. So file disposal is indeed not dependent on more
ingress RPC traffic.

The "If there are more to be closed" remark above in the patch
description was ambiguous to me, but I think I get it now.


> nfsd_filecache_laundrette is still running on the system_wq.  It will
> continue to garbage collect and queue files using
> nfsd_file_display_list_delayed().
> That will wake up an nfsd thread if none is running.  The thread will
> close a few, but will first wake another thread if there was more than
> it was willing to manage.  So the closing of files should proceed
> promptly, and if any close operation takes a non-trivial amount of time,
> more threads will be woken and work will proceed in parallel.

OK, that is what the svc_wake_up()s are doing.


> > And, as we discussed in a previous thread, replacing the per-
> > namespace worker with a parallel mechanism would help GC proceed
> > more quickly to reduce the flush/close backlog for NFSv3.
> 
> This patch discards the per-namespace worker.
> 
> The GC step (searching the LRU list for "garbage") is still
> single-threaded. The filecache is shared by all net-namespaces and
> there is a single GC thread for the filecache.

Agreed.


> Files that are found *were* filp_close()ed by per-net-fs work-items.
> With this patch the filp_close() is called by the nfsd threads.
> 
> The file __fput of those files *was* handled by a single system-wide
> work-item.  With this patch they are called by the nfsd thread which
> called the filp_close().

Fwiw, none of that is obvious to me when looking at the diff.


> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/filecache.c | 62 ++++++++++++++++++---------------------------
> > >  fs/nfsd/filecache.h |  1 +
> > >  fs/nfsd/nfssvc.c    |  6 +++++
> > >  3 files changed, 32 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index ee9c923192e0..55268b7362d4 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -39,6 +39,7 @@
> > >  #include <linux/fsnotify.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/rhashtable.h>
> > > +#include <linux/task_work.h>
> > >  
> > >  #include "vfs.h"
> > >  #include "nfsd.h"
> > > @@ -61,13 +62,10 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
> > >  static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
> > >  
> > >  struct nfsd_fcache_disposal {
> > > -	struct work_struct work;
> > >  	spinlock_t lock;
> > >  	struct list_head freeme;
> > >  };
> > >  
> > > -static struct workqueue_struct *nfsd_filecache_wq __read_mostly;
> > > -
> > >  static struct kmem_cache		*nfsd_file_slab;
> > >  static struct kmem_cache		*nfsd_file_mark_slab;
> > >  static struct list_lru			nfsd_file_lru;
> > > @@ -421,10 +419,31 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
> > >  		spin_lock(&l->lock);
> > >  		list_move_tail(&nf->nf_lru, &l->freeme);
> > >  		spin_unlock(&l->lock);
> > > -		queue_work(nfsd_filecache_wq, &l->work);
> > > +		svc_wake_up(nn->nfsd_serv);
> > >  	}
> > >  }
> > >  
> > > +/**
> > > + * nfsd_file_dispose_some
> > 
> > This needs a short description and:
> > 
> >  * @nn: namespace to check
> > 
> > Or something more enlightening than that.
> > 
> > Also, the function name exposes mechanism; I think I'd prefer a name
> > that is more abstract, such as nfsd_file_net_release() ?
> 
> Sometimes exposing mechanism is a good thing.  It means the casual reader
> can get a sense of what the function does without having to look at the
> function.
> So I still prefer my name, but I changed to nfsd_file_net_dispose() so
> as suit your preference, but follow the established pattern of using the
> word "dispose".  "release" usually just drops a reference.  "dispose"
> makes it clear that the thing is going away now.
> 
> /**
>  * nfsd_file_net_dispose - deal with nfsd_files wait to be disposed.
>  * @nn: nfsd_net in which to find files to be disposed.
>  *
>  * When files held open for nfsv3 are removed from the filecache, whether

This comment is helpful. But note that we quite purposely do not
refer to NFS versions in filecache.c -- it's either garbage-
collected or not garbage-collected files. IIRC on occasion NFSv3
wants to use a non-garbage-collected file, and NFSv4 might sometimes
use a GC-d file. I've forgotten the details.


>  * due to memory pressure or garbage collection, they are queued to
>  * a per-net-ns queue.  This function completes the disposal, either
>  * directly or by waking another nfsd thread to help with the work.
>  */

I understand why you want to keep this name: this function handles
only garbage-collected files.

I would still like nfsd() to call a wrapper function to handle
the details of closing both types of files rather than open-coding
calling nfsd_file_net_dispose() and task_run_work(), especially
because there is no code comment explaining why the task_run_work()
call is needed. That level of filecache implementation detail
doesn't belong in nfsd().


-- 
Chuck Lever

