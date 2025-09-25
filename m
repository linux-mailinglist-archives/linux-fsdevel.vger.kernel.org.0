Return-Path: <linux-fsdevel+bounces-62733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E913CB9F9D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 230767B5D79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D317273D77;
	Thu, 25 Sep 2025 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MIMb+XW9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a/UX+2DL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD637271479;
	Thu, 25 Sep 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807625; cv=fail; b=ehNP99mbtrWZOO/NoPzsEgl3Q+q0Wo861tOVAq7ghem1EpKGmwujhLGY2Fy7BMjodDeehdqjzkf7u7USU3INq6GW0wS3j2EhafJVxsKvPsj2/+H5Knx/390G6Uy41wSmAcJTnELwAd9RMKOsSuK5o3XJMma8P0tM6iVqNXRY190=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807625; c=relaxed/simple;
	bh=STNxpyjwfhYPLSC6u6hFEuB6nf7EzRSuCaSgdMczIUE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rDDAyr+wkE2fE4Lud04hgB6XUtCSopEs3ZXEpYESGdc+XOIv9CBK2La/TytdnF/qMNe+is2dVWEsoBShqh5xhmEmPNl+11VHeZVl1qggzq3Hyr3/gG8lwR7xlRo9en0lQh3TwLhnre+YV7ANpHrZ16yvI9HFg2Otm8Syrg/zD/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MIMb+XW9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a/UX+2DL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAttJN015798;
	Thu, 25 Sep 2025 13:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bWJ+JudQs5Cw4/acw3VbPR+mFnY7kMP59kbswKkDqcI=; b=
	MIMb+XW9gY1g+Wmq0DzHU96pqB5eC4VAuM2CV5PbA0PENwKAJ4pOvszjcG4V+9ap
	/9aCgdczssag7OTjtOJpv0mn5Nj4OUyhEbdIo27J+S3fM1olCx6SlBfgxGM2ZOFU
	8/4l4vQbvAajTb+TxXkEKe7rjKiXgFYUK620ShE4fmbApww/6K0AjNdUFdMvv7u8
	/dRoD/jDBmgJamaac9NVfTzl4cDx8oFsx+Ibi3W5I8GN16K6fm7Z1lgtm/c7acA2
	dwCGwV1TJHutikwjyTPO9dRlZxTQOoAtDTdcoNGYEMy61BGY1ftceOb7GTTOnZlL
	vQFZV3U3ZeleveOg/UheEQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499m59j0ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:39:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCYdhw014675;
	Thu, 25 Sep 2025 13:39:29 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a9525gue-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:39:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuF7QbI404Rb0XUDJBgyJZt4W2bOMItbkEPrbuIfTA0CjHT23VP2/n1vusgFsPeUq4NfspchupE9IJw9gRGXoXIUDZOMyOscEje/8OPPeLTWXQ5vNXxZyxm83C1gvftAzAxjeUw6C2jWh1PgbJPkf3TGNhjKquc3MH987ZjvWtipR6gPsnIZfCvoWp5mpInvNJQOavw4VoUpIEY8eQ8548rNUF6n8/Oq+9Yz+8fu4ALimN4nK7xoDYqQuZepWLD4lN6011UnGh6LWF0KiIdw1zEODV5eCYOaTZlL6wlYa+SDB6PwJ9Q0lP4SQBn1GMo7/71F8+jT0rQ6m/YmLS5uBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWJ+JudQs5Cw4/acw3VbPR+mFnY7kMP59kbswKkDqcI=;
 b=eBBrPUZIn0CaIJidqslIePl1sjpU4E1cVb+NNGD5QaOIpFyC7EQz9tuhH+dGUmqftX8D92/io75uokC35LQ9DXsO8tV9xWzbM5yTZBXqFCjLuYW2Pt+N/Wza3D4oBNljJTr+4kZ/be0Ms8cC/xglBeida9WYY4DoEiN/7pl160PhAe1w0mPViSlj3jhF5/Z/cOArcmuXm785MoYovIn+byUNxGGmiqtvzfwJGbyDx0th7TMkhs7iwsnPVgctcKt7aAWW8p1IaynaRMJZAEnZnTIGg3/cUQRHM05NzzpiZOnirFHfJC7CxFAamabYksY+PucicH4MFe9/ETbjgRcMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWJ+JudQs5Cw4/acw3VbPR+mFnY7kMP59kbswKkDqcI=;
 b=a/UX+2DL0XbMS98Y7g0WXhgsPNlLDHwKNAZDh4BS+noggyds4iEATTRrhRR01qOOJ0bOSNsne0T3H6zH6j3OqSiy5SlSot/YM6yYNIa0eVLOkq7NjIYOVmhSFDNOGkfQ7IfPFQrid/BIzzEEiHUScqH/Mog19Dz3JfWs/hnuaLU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6649.namprd10.prod.outlook.com (2603:10b6:510:208::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 13:39:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:39:23 +0000
Message-ID: <e8889519-ca38-430f-b79c-790dabacafac@oracle.com>
Date: Thu, 25 Sep 2025 09:39:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/38] vfs, nfsd: implement directory delegations
To: Jeff Layton <jlayton@kernel.org>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Aring <alex.aring@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg
 <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
        Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-doc@vger.kernel.org, netfs@lists.linux.dev,
        ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:610:77::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b3d574-bc9f-4db7-c731-08ddfc38effe
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QW1BQW1xZDB2MDVDN1VKSHhsWnN2Y3ZScVBPbmlENXhYL3RaOFlsV3JiZTNk?=
 =?utf-8?B?MUZrZDhTbEorc2o4L1ZqWGtYMm5tZkhQd3owZTNESkxyakgwTlFyQkw2Z0tz?=
 =?utf-8?B?MEJudnRiMGVrNHBLakppTDhVYXR1dTZUK3JoL1F6WWVTZW5DbVd4L3QxcVdi?=
 =?utf-8?B?a3JoanF3SWcvUmtiMUdEclE5T0I4M1V4MEhiNUlIMXlxaUkxSTRRa0pUZEFm?=
 =?utf-8?B?K1VWNXo0blYyV2N3Ym5VTWlKSDBweTNucUtSSDBUam9ncFFPT3hoWlVSSHl2?=
 =?utf-8?B?Y1FjY1Z6SWgvNHRUaUVmSklacHZZQmlvbDViQ25GTWVjTE9CbUxlbVdzcXUz?=
 =?utf-8?B?TUErclhrZENRd2hxeUE3Q25waUtqS29uaCtTSHdrbTVaaGlIWXE1VHR1RzRW?=
 =?utf-8?B?cUVRejRVYUQ2cXA1Vm50RUw3MnJ2aFdTWlAxTlhPVGdua3cyM2loclFGZTRi?=
 =?utf-8?B?a2g3T0cxTldUZG9vSHZyRGQwcnk2dlRwbElxV0VYaG4ybFJVT1BVQ2NYaVBj?=
 =?utf-8?B?TEx0aFBVUTdhRDdlZUZFRTVTWXJ2Mno1MXpGV2FVMk9CSytVWm92cDYxVUxP?=
 =?utf-8?B?V2hZakFPMW92YnVadVkrTFF1ZitDc3IzWm83R0htVy9FeXNDcjN2Z1Q3emlq?=
 =?utf-8?B?MjJ4d21ZYnFuMlVEaStsNGdHdXRXODFxeFZMdS9YRjl0M1RZRkhMaFVRS0NX?=
 =?utf-8?B?bkc0VGtaTUhwcmdEZExTWlFnOUJFMzQrVUJ3bTlHNzU0UzIrcjZyQ1gxTFF0?=
 =?utf-8?B?ZFZMV0tQVXdjSzhyaEdqcEZwTjA5QVdqSmNrTGVRKzY0OHJxbWVmOUxEdXM5?=
 =?utf-8?B?UkE4dzgvVkl4R3BiZjErdUhtTlFWaTFEMURVMng5aElFeUUvQ29PTXQ5UmlZ?=
 =?utf-8?B?ZHUrbVJmM1I5UkFXd245Sm5KMFQ0VVRsUUN2Y1RSVDBXR3hPeFZlbmYwNjNU?=
 =?utf-8?B?eXFERnZ2Tm8xKzhFZ21jWHhsMXgybDh4ODVwaHFsekRNNFJNNCt3VkhpQVZi?=
 =?utf-8?B?REJWbnd2S0JxeGQ5Y2dvZEpTZ1ZZajh2RTdqR1IrMzl5cUpWckxFZmlaV1Er?=
 =?utf-8?B?bEFyN1g1MlRVc2c1NHhXRGQ4QjlaeWhtOFpjQ05DY1NFbnFyU1FFeHBmS0ln?=
 =?utf-8?B?Q3g4aVY4Wm9odnQwYmhpak4zMjV0Um40Zm1NMWRJUWROZkplRFNSM0FOZC9h?=
 =?utf-8?B?MXR4blUzYSt4SWhGc0hvRVJHR2ZlN1VJL2N0MXJNcnpqUllIdWU5eVI1KzdP?=
 =?utf-8?B?dnJWOCtNUGYvNnpLNXZYZXg2V0MxcUNnU1d0alAxeWlBd0wvRnAvaDd5SFpK?=
 =?utf-8?B?d0NMQmcycUVDcjQzY0dUZy9OcjdzcUpSN2Vmc3BUb09XRDVadm1rakNQN3NP?=
 =?utf-8?B?MzJHcDVidkVTUE9tbkR2bGdjYnhMZjhraDZEd3IxeUNtUjNTVFZZTGNxd3o5?=
 =?utf-8?B?YUw2SHowdzFCNG1XejE1ZkE2dkJPSjVjVk5XaWRYdFNoQmFYQ0J5dWNlQ0FO?=
 =?utf-8?B?SXFYempTZWVEQW15YlNBbnVlTllYL1ZBSlpRaEhXc0xlK1kwMytUN3dRWjQz?=
 =?utf-8?B?d2o3Z1VMcGtIZFpQMWltaWRqK1pMWHc2MUt5WWdwTlhvczZwUHNnVWo2MTVO?=
 =?utf-8?B?ZTIvNFVaaWJVNE5ZdXNqSGNJZ3F5NVU4WXpYTzQ1cVpzV3E1MTlIckkzS0JP?=
 =?utf-8?B?c3VuMDJpSFd5ZE42ZXluSldYVHJsL1RNQVZ1Y0E1c2NQTXo0UmxqSm56clQv?=
 =?utf-8?B?K3gwN0Nuci9JWWtPQzY0dnJlam1XS0wyVVBSRTJOWFlBbmM5N3U2Z0dwNmVq?=
 =?utf-8?B?U2ljeVRpcEl2UkIrMjJWUDFyY2p6eHlnbXV0enMzNEdnL0NrcVlaMHZIYURk?=
 =?utf-8?B?KzNReVhTRStYY0M2N01CeElidEhEYkt0Nm5aMkY0QjcvdzN3ekZLWmpoU1V6?=
 =?utf-8?Q?vkLB08OAv2U=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TGZoQ3ZDbnBwcW43cFJIOG0zTUJZc0RsZEErSFpkQ0lTZy9VMGFqSlBEVlB5?=
 =?utf-8?B?Y2tiWkZTaTFsQ2JJSTRmaGZPMDZFYVZCT3hIdzByY3Nabnd6Ly9QbGhmbHcy?=
 =?utf-8?B?VE54bVlETEtQUkgwdjQreFBGYnJENkZEYUljS0FrOVcyN0ZZMEpreWhKYzhR?=
 =?utf-8?B?Y1ljbFQ0OUNSeHJLR0l6ODlqYjJUdkUwaFlyWXRuOTh0Y2NRK3dQMytVN3li?=
 =?utf-8?B?WlZaZDl4Q2w0SlEyMzJ4Q0RuekZsa3pYYzE1YkF3UW1QcWdtN0pqOTVqNFJB?=
 =?utf-8?B?UXdzWDJnWmsvaE1WWld0SklDclhkd3ZDOWNqZmFjUUlzbk5DR2lpdU1RMzRx?=
 =?utf-8?B?elVGa2FlUVlSd2xoSnovL2t0OUFYK005MGVRQWdGUUVMYXYxRXQ0K2hHeity?=
 =?utf-8?B?UGZWSXZVSUdFMmgweUFaRlQ5Znl1ZGVuaG5BQjFRa2xrMTE1allOMEdRZ3pj?=
 =?utf-8?B?Wmk4NUpjYzIvcWJpSU1YUWZsb3JVUERJTDJxcnRuY0VvY2tJMmR2RjJDbUtX?=
 =?utf-8?B?azBab21WOS8ya3o1aHc4akZtQ004a0FBU0tYd3dpSWoyU3pFQUpNaE5DNnBO?=
 =?utf-8?B?TDZFZjFwZEJDNW9ENzJHaURabXVxVEtFRkxWS0dXcy9PS0NKQnFJT1FQbTB6?=
 =?utf-8?B?TTZod0tBaTkxOWdoZnhYajhUK3ArQ2JXN3lrQXVOSlZBNWs2anl3b1VUdUlD?=
 =?utf-8?B?RC9zVURoTVkxMnc5MDljM1hPSmxXdUZoU0trQUozS0xnTjVScGd0cXViQXcr?=
 =?utf-8?B?Mk1hZEpXb3FYajRQMEhYN3ZWYjR6bXJnSnl0NVRaaUdmajV5RVl2RjY2emxW?=
 =?utf-8?B?azJBd3RLT2lOMHpVU2dnVE9lOEl4S0tGYmMyUzNoR3Q1VlZiN29jS2NNN0p2?=
 =?utf-8?B?OEIvS1pzNG9SZ09pTFlyWDZabXB2R2NvSGFFOFhKTFVMRVlNcGdtdE00dFZ2?=
 =?utf-8?B?Ymx4R2t3MHJOSHFYTWJURlZmYVVpd0tHQkU5bGlVUXh0MGNkaGVHckdsOWJq?=
 =?utf-8?B?UHZVMnFyYXczRWZTbWJXZ1ljbUt5M1ZjWFVxWncyMnVmODFxMk9rYzIwM25T?=
 =?utf-8?B?eGh5eENIckpBNG1MZlkxL3oxd0FzenM2YTFYajhOZmZyc1ZzelBvVnhxeUZu?=
 =?utf-8?B?VDhnd0tmMFdJSzhGTzJ6R3QzNGd0MUZ5MCs1Q0xEWTJsOGJ0ZjhENTFBT2ox?=
 =?utf-8?B?WUJxdWY5aFNvdjRkY0hjWjRhYll0M2F3Wkgrd2p6Y1hkeDNLbnhVVHdtWTdl?=
 =?utf-8?B?K0J4V2o5VGU1N2tFRWlkMC9sRXVDU3FMOVhPaFJ4VFRXdzhjS3BWR1k0RDUx?=
 =?utf-8?B?b2hZUlZ1UnhaWkhVckdMbzY4MHBHQnpRWGIwQkY5dlRKN2ROYUFyRHRjRHRJ?=
 =?utf-8?B?RDU3aWVNUm4yaWpVZzZjTmw1cS9JTm0xbUNLY1lwZDk5bkViT0lhVHpxdlVP?=
 =?utf-8?B?MW5yUVo5L3FNYTQwdkNWQUtTTTVmUmxobWQrMXk5Y1FNQ21hVkdBd0ROdzgr?=
 =?utf-8?B?MEJ2di9MTTRDMDArQ3pRY2ZUNmcyaDFxYkFzcU9VUjJsYXB4ekNlTEx3ZXAv?=
 =?utf-8?B?NW1EaWwyd2Y2MGpHUGFuRzllSlNpZEpvdVQ3YUVYTUY2WnQ2YlJ4NFFXVHN5?=
 =?utf-8?B?eE9kTG5hTU5mYUhMbVNQaUk5VXVpL1VYZnpBZ0hPeG1heUxLVGZqYld6Yk1E?=
 =?utf-8?B?T01WTU9VN25oVVFSbXRsNysyd0F4NEJaMWViMFlBTXJaMTlPd0k2VW5XVWQ2?=
 =?utf-8?B?TGg3NVNRMUIyYmV1N1Jnc3NERFFPL0d1MDdBWVMxRlhCdllEVUNraDNOaVBx?=
 =?utf-8?B?WE1Vb0c5QTllK2Rob29BQ3BPT2NzNzZqSGdHSUlPUjlnREtLalNrQ3JlcXYw?=
 =?utf-8?B?UXJ0cWpxRnVJTGZRaS9Md3k2N3JkN0dzdmVjc3hNZlQ3dEdhMVYvSklNNTRp?=
 =?utf-8?B?dWEwNEFiMFN2UU1PN1ZMV0plVGdoOG1LMHlZMVBaMWdENkJxaHlLK2JjOXBH?=
 =?utf-8?B?bStMbGplQlJORTJEYk9vYUg2WEVUNlZtTlpmeTU4NFlNZnpiUUtuU0RraWZJ?=
 =?utf-8?B?N21XUmF1RlVnN0NvMEFYNkNyWlF3cTdDbW94Tm9SdnM3MFFLNUxLa0NkUFRi?=
 =?utf-8?Q?3bhS5h/eHsGlbh7V5Ia+BLaze?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	At5f5W9r14qUJ6XwiDklhYjGSMWEH2w2ALxy130HaZlOy3czlmLviEnGKhuOn+3EgUmBGPqZ0EwSTc4D1sYY8f+qkx5VqwWEB3PMOuvrj1SDdbmp/uzq6zBG+tE0bvAiVRIpQbr4vL6u5KwXc6kKmijRZ3AB1qnz/ZJJ0/qeZxikSOvV3MvRUtGKpPkDYtM1ml2VQQmxH7v+OQFWarVbCyUrjVYCiuC9/A7sf4YFr47hteicbcTFxsM0BeTTfoUMcBUoflJnloOnG/4OrAWNDZqzm4SkZqwed6W8MIp7EkHdFtOR3qt0fqNtrESzp24GruL+sN1LRGOCXN1q8upDBImk8dvKgpGj6U00x8exfOm1AuPeXAXCglh7OGSVWZ7oPAXHfxh6G3i1YBJV0ntNdXveh8dYfVUAmcvyPnsdW9fyewKcha6CcprFkjJazFdLr8GU96f6vQ4ZaNdyvPvM4Jn7rtYOHRT6uGMN6lrTPCZkKwc6wj8QvsB//kYruxWOvFzf9TyrUhOMnNx2NZ4NuzZKaQlvQVAbOlWrELwLu9Br5GSng6TkBE/b63ujx6LVweDhGNdG//iQ7RlPs1FpeN4VrBRKdPuXa72jbxAV8jE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b3d574-bc9f-4db7-c731-08ddfc38effe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:39:23.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAlZ71jAVeNwT3YRz649VpTrlyRUR79elKabKJ6Loko6JKkHEof68MTMFmCdqlJhOya7qI49DQhFvITsKnuEXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509250127
X-Proofpoint-ORIG-GUID: 5bBJgvGGB14D35qzZIpUsBNZDkCAVaRE
X-Proofpoint-GUID: 5bBJgvGGB14D35qzZIpUsBNZDkCAVaRE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOCBTYWx0ZWRfX6VVgpCQKMkul
 swiXT5ne1AMxq7IxCKAwx1nw6VCkvaPc2coH07QWkqxc0b5vrvCDSOo1z/VHpl1MjCFKGeKguIT
 14uh2u4uEEkr820vvvvV93uefjARqAS1d+hwY0vF5805wA5XcqOmSjIwBgsEjZvXoFBU8yXHGXU
 LHXjAOGPHbj8CuuhoShPZf2yatUvp66jkxPWEDKMiMSnU4B+Z/GGNKVV6TPtE1jrcMicjrrKeYr
 DtPPhPUnCuM71uG2cwg5PXrCzvAjJV58V5Mr8ZY44MD3AbtwrXqZ+RIqdtmVL1JRKsOEXTIewaO
 uVwpYShENpXKVaEQ41dH8yvKKAfBhI9uVx4RRgLZs4MBWn98DM2v5eE53VN0zodUDADHRwmGO2u
 otOuiPpfF9MaV3E4ofnQytacXMtFtA==
X-Authority-Analysis: v=2.4 cv=HJrDFptv c=1 sm=1 tr=0 ts=68d54613 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=vnREMb7VAAAA:8
 a=P6JkxrBpAAAA:8 a=oJ1ooLWfrCxnF6czbPMA:9 a=QEXdDO2ut3YA:10
 a=dwOG0T2NmQ8MtARghG3a:22 cc=ntf awl=host:12090

On 9/24/25 11:05 AM, Jeff Layton wrote:
> This patchset is an update to a patchset that I posted in early June
> this year [1]. This version should be basically feature-complete, with a
> few caveats.
> 
> NFSv4.1 adds a GET_DIR_DELEGATION operation, to allow clients
> to request a delegation on a directory. If the client holds a directory
> delegation, then it knows that nothing will change the dentries in it
> until it has been recalled (modulo the case where the client requests
> notifications of directory changes).
> 
> In 2023, Rick Macklem gave a talk at the NFS Bakeathon on his
> implementation of directory delegations for FreeBSD [2], and showed that
> it can greatly improve LOOKUP-heavy workloads. There is also some
> earlier work by CITI [3] that showed similar results. The SMB protocol
> also has a similar sort of construct, and they have also seen large
> performance improvements on certain workloads.
> 
> This version also starts with support for trivial directory delegations
> that support no notifications.  From there it adds VFS support for
> ignoring certain break_lease() events in directories. It then adds
> support for basic CB_NOTIFY calls (with names only). Next, support for
> sending attributes in the notifications is added.
> 
> I think that this version should be getting close to merge ready. Anna
> has graciously agreed to work on the client-side pieces for this. I've
> mostly been testing using pynfs tests (which I will submit soon).
> 
> The main limitation at this point is that callback requests are
> currently limited to a single page, so we can't send very many in a
> single CB_NOTIFY call. This will make it easy to "get into the weeds" if
> you're changing a directory quickly. The server will just recall the
> delegation in that case, so it's harmless even though it's not ideal.
> 
> If this approach looks acceptable I'll see if we can increase that
> limitation (it seems doable).
> 
> If anyone wishes to try this out, it's in the "dir-deleg" branch in my
> tree at kernel.org [4].
> 
> [1]: https://lore.kernel.org/linux-nfs/20250602-dir-deleg-v2-0-a7919700de86@kernel.org/
> [2]: https://www.youtube.com/watch?v=DdFyH3BN5pI
> [3]: https://linux-nfs.org/wiki/index.php/CITI_Experience_with_Directory_Delegations
> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v3:
> - Rework to do minimal work in fsnotify callbacks
> - Add support for sending attributes in CB_NOTIFY calls
> - Add support for dir attr change notifications
> - Link to v2: https://lore.kernel.org/r/20250602-dir-deleg-v2-0-a7919700de86@kernel.org
> 
> Changes in v2:
> - add support for ignoring certain break_lease() events
> - basic support for CB_NOTIFY
> - Link to v1: https://lore.kernel.org/r/20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org
> 
> ---
> Jeff Layton (38):
>       filelock: push the S_ISREG check down to ->setlease handlers
>       filelock: add a lm_may_setlease lease_manager callback
>       vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
>       vfs: allow mkdir to wait for delegation break on parent
>       vfs: allow rmdir to wait for delegation break on parent
>       vfs: break parent dir delegations in open(..., O_CREAT) codepath
>       vfs: make vfs_create break delegations on parent directory
>       vfs: make vfs_mknod break delegations on parent directory
>       filelock: lift the ban on directory leases in generic_setlease
>       nfsd: allow filecache to hold S_IFDIR files
>       nfsd: allow DELEGRETURN on directories
>       nfsd: check for delegation conflicts vs. the same client
>       nfsd: wire up GET_DIR_DELEGATION handling
>       filelock: rework the __break_lease API to use flags
>       filelock: add struct delegated_inode
>       filelock: add support for ignoring deleg breaks for dir change events
>       filelock: add a tracepoint to start of break_lease()
>       filelock: add an inode_lease_ignore_mask helper
>       nfsd: add protocol support for CB_NOTIFY
>       nfs_common: add new NOTIFY4_* flags proposed in RFC8881bis
>       nfsd: allow nfsd to get a dir lease with an ignore mask
>       vfs: add fsnotify_modify_mark_mask()
>       nfsd: update the fsnotify mark when setting or removing a dir delegation
>       nfsd: make nfsd4_callback_ops->prepare operation bool return
>       nfsd: add callback encoding and decoding linkages for CB_NOTIFY
>       nfsd: add data structures for handling CB_NOTIFY to directory delegation
>       nfsd: add notification handlers for dir events
>       nfsd: add tracepoint to dir_event handler
>       nfsd: apply the notify mask to the delegation when requested
>       nfsd: add helper to marshal a fattr4 from completed args
>       nfsd: allow nfsd4_encode_fattr4_change() to work with no export
>       nfsd: send basic file attributes in CB_NOTIFY
>       nfsd: allow encoding a filehandle into fattr4 without a svc_fh
>       nfsd: add a fi_connectable flag to struct nfs4_file
>       nfsd: add the filehandle to returned attributes in CB_NOTIFY
>       nfsd: properly track requested child attributes
>       nfsd: track requested dir attributes
>       nfsd: add support to CB_NOTIFY for dir attribute changes
> 
>  Documentation/sunrpc/xdr/nfs4_1.x    | 267 +++++++++++++++++-
>  drivers/base/devtmpfs.c              |   2 +-
>  fs/attr.c                            |   4 +-
>  fs/cachefiles/namei.c                |   2 +-
>  fs/ecryptfs/inode.c                  |   2 +-
>  fs/fuse/dir.c                        |   1 +
>  fs/init.c                            |   2 +-
>  fs/locks.c                           | 122 ++++++--
>  fs/namei.c                           | 253 +++++++++++------
>  fs/nfs/nfs4file.c                    |   2 +
>  fs/nfsd/filecache.c                  | 101 +++++--
>  fs/nfsd/filecache.h                  |   2 +
>  fs/nfsd/nfs4callback.c               |  60 +++-
>  fs/nfsd/nfs4layouts.c                |   3 +-
>  fs/nfsd/nfs4proc.c                   |  36 ++-
>  fs/nfsd/nfs4recover.c                |   2 +-
>  fs/nfsd/nfs4state.c                  | 531 +++++++++++++++++++++++++++++++++--
>  fs/nfsd/nfs4xdr.c                    | 298 +++++++++++++++++---
>  fs/nfsd/nfs4xdr_gen.c                | 506 ++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfs4xdr_gen.h                |  20 +-
>  fs/nfsd/state.h                      |  73 ++++-
>  fs/nfsd/trace.h                      |  21 ++
>  fs/nfsd/vfs.c                        |   7 +-
>  fs/nfsd/vfs.h                        |   2 +-
>  fs/nfsd/xdr4.h                       |   3 +
>  fs/nfsd/xdr4cb.h                     |  12 +
>  fs/notify/mark.c                     |  29 ++
>  fs/open.c                            |   8 +-
>  fs/overlayfs/overlayfs.h             |   2 +-
>  fs/posix_acl.c                       |  12 +-
>  fs/smb/client/cifsfs.c               |   3 +
>  fs/smb/server/vfs.c                  |   2 +-
>  fs/utimes.c                          |   4 +-
>  fs/xattr.c                           |  16 +-
>  fs/xfs/scrub/orphanage.c             |   2 +-
>  include/linux/filelock.h             | 143 +++++++---
>  include/linux/fs.h                   |  11 +-
>  include/linux/fsnotify_backend.h     |   1 +
>  include/linux/nfs4.h                 | 127 ---------
>  include/linux/sunrpc/xdrgen/nfs4_1.h | 304 +++++++++++++++++++-
>  include/linux/xattr.h                |   4 +-
>  include/trace/events/filelock.h      |  38 ++-
>  include/uapi/linux/nfs4.h            |   2 -
>  43 files changed, 2636 insertions(+), 406 deletions(-)
> ---
> base-commit: 36c204d169319562eed170f266c58460d5dad635
> change-id: 20240215-dir-deleg-e212210ba9d4
> 
> Best regards,

Series is clean and easy to read, thanks for your hard work! I agree
that the NFSD portions appear to be complete and ready to accept.

Because the series is cross-subsystem, we will need to discuss a merge
plan. So I'll hold off on R-b or Acked until that is nailed down.


-- 
Chuck Lever

