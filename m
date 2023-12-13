Return-Path: <linux-fsdevel+bounces-5839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADF8810F56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 12:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655B9281C6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959223755;
	Wed, 13 Dec 2023 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cywEsdc9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SAYU2TQL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D8114;
	Wed, 13 Dec 2023 03:03:09 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD9SuhL027205;
	Wed, 13 Dec 2023 11:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=txg7IFCNhytUg6AFTZ5BYk/sP5P8Aoy3yZJTQgunc8I=;
 b=cywEsdc9mozO0N1jzMaxc1elB1mZJ96jsVaezhdG/iDAgEG4dQP89tA59nBgDifE7KvE
 sFjYH21xBk4FLV3vajSWj2vMmiYIGQZvjAY7HhFeZT/XiGtVESlRGd7Iq2HXfEngaaJg
 9a78NO+oB6R4jUmocClzejzTJ2aeXPU1pp/pEB2gA3jkPvPJ2kbW+72AgbHeqrMOdbfI
 z3fLJP4dfzxXotWsi84jePD/X4dQv9YdK785oTZIucsRIVSH/Sst28Cknb5EMgQmA7KT
 ZBBzkb9NQDF7UeiiELXAYuqc6UyyhrMCd4SAH4gjcA2LSHqH5h/n6eWxdFwGYczkNXtP JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3p756-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 11:02:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD9oUUP012849;
	Wed, 13 Dec 2023 11:02:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep83e2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 11:02:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnzIHZRFKSfiTRGaXE+Qv8P7D15Xtdd3dz/F88/QqHcCjs7S2HXkCSH4VKy273sEALHNYWnEHYLivtIAeCiB6b/api1+ekw5tvYZrMA7WgceW1OCmXSC73M5RA2MeSc7ifH63t8M3p0zIfqw1jzyN9E5s+a0sDCPNXpi2PUTDer9XO2wAf0U1vYNY+G0/whHCZTa+VnS9n/xAZlCAQOYdG6rIKfPhTMUgpQPicXrIdhNimNLDTgmpWrWYJnkx0/FTlj9CeuaG7hrNbNRMDY9RZiv0ULilZsg1H9DFikknkKDD06opWmZ/HSLuap7x5emwSnpbs+mtXIpJWeJbK75Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txg7IFCNhytUg6AFTZ5BYk/sP5P8Aoy3yZJTQgunc8I=;
 b=SbbOFSx0xXtPyyoZJNX0Eh/+eb1bKehoQqTsGl4lVNrAs8wFzA4zYfkBOMWMpZSlq/ON1OJsJhIXvgHLxokSVbNo6ZBbnAXNKVZM1qs6IFMJspdy6lTSJI55cCw+KfE+dxHz7NmDMdOPrmWQP29NwsYsMiJi9PVaoP++7ur/GzweZPmLIj5s/MpkMKk4SdBTa1BKOqHzqLhl2coVvWzVQWA4R0P2y6ZIMJHuzTHy2CdzCZQUVyyUuovEtFWPfPhDwqod4a0bX15BLC5/1a6I7hiXZ72VTx6djvbiFMokjXehgNa40C2wcu1+tMLtXe2qZJK+Kkay8bssuO4Ssy33MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txg7IFCNhytUg6AFTZ5BYk/sP5P8Aoy3yZJTQgunc8I=;
 b=SAYU2TQLijspYhJJjBKWZDPeWivSWBU1JFbD9/KuolGB7BMyBi8O2PomQikbZrCcEMNqhHhaamItYirlVRolBn+qs+huLYviXOUPtwuWPWv80WOU+f3HAEApdC0eliABIJWlHrkx0wT+Ouh+mOgTaASEWvNIuhXBtOVLKwWR43E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB4913.namprd10.prod.outlook.com (2603:10b6:208:307::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 11:02:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 11:02:41 +0000
Message-ID: <bb7c50da-1ee2-4ba1-9f54-8e98dff14b6d@oracle.com>
Date: Wed, 13 Dec 2023 11:02:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] fs/bdev: Add atomic write support info to statx
To: Jan Kara <jack@suse.cz>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org, Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-4-john.g.garry@oracle.com>
 <20231213102401.epkxytqq7e5lskw2@quack3>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231213102401.epkxytqq7e5lskw2@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0100.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: 35942ec9-4eab-47a2-38f7-08dbfbcb06a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yCEy6y7RGebXcsmPXaDV7iMj/PJleD3mi3dEZsk2D7PbvjNlPr34P0sjYlqpkt7iYRGUL4WM1OqzMRPgovSo6zhZv+16lTUfRePAn/U5/RSrijf8cE8u+SgrtNif9Uw9aCdKXlyVd1vOoRwNd/d4jSHzzyhNartuyaUTS0aVk7n6aJkNHyTzdwKeixmn1Xk6WMcXqMBDbIU89mn+OK+fStbiPxjn95sy9+NPuTr4nYJeByn5VceU+R/aTyEj9Q8eB5dqgn33kDIorPNrSjZeXFD3Fs5Sq3gsJStsM/rQ0L/W7BN7s4cRXAmyeOs/lQCfHyM/f0bd7VWN1AjTr+G86iRRF0Q+yInuX/k5ZR/N8c5HdPSWfe9A4C6BYAeGZc6JY6WwESerh8EGMz1+bJkCmj+ODMtSKDgrkoAdxs7yLS/pOogocuUHNpIW/TKIaqGf8QRIXFR3LYpiKGPY565MjKrhjn3oXkziBxX/bVeMeeGUv/JvPfYSX0hs000sL5fmHrIWEc/kMupkbHbC20uRzWXGQlVFqGcKN2FSUJADRRex8x8mjJq3nPHyayeJ/ibS0zC0tmnQoYXqQwo36et2OZ+KjwTF6RbtojDR6ZWLAXkdJ9w8o0ytcLaV3eruEK9RSg+RC5Eiljh6tfdMya0oSA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(31696002)(86362001)(36756003)(2616005)(66946007)(6666004)(36916002)(6512007)(6506007)(53546011)(41300700001)(66556008)(6486002)(26005)(38100700002)(107886003)(83380400001)(5660300002)(7416002)(4744005)(2906002)(8676002)(66476007)(478600001)(4326008)(8936002)(6916009)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eEZEdmVDSXlMeGRvSVJzK2ZQN3RaQXFmeFF2UXltSEp0WTZrRWxIbld2VTBv?=
 =?utf-8?B?cHJaRzRyeGtyS3VWK2dyZDV0WTF5NWRranB4YmYvQ203TU01c0JWNjlxaS9s?=
 =?utf-8?B?aVRlQi9ReUFJT1BvTUVMbWNqTjA5L1E5aXZsNW5KQ21sbVZIVmtqbjVTYU9z?=
 =?utf-8?B?dGlnb3FYT3VENlVPc1ExbjRUSnpzQitLb2d1Syt4V1p2aXZaQ0pIeUhoQzhk?=
 =?utf-8?B?OWNqMEdTbjNjaVAwc0xnK3FVVjgxWWxUUWRyenpiMGVSb0hIVW5OMTZaT1pD?=
 =?utf-8?B?Wk5Wakl1U3JldFVzcnlaS3hEODlQdTRDaTQxS1VXUHV3WjV3K3RjV05LTm5z?=
 =?utf-8?B?SE9tZXYwZUF4M0FBaHY3M3NJV2VURFI4bEpURW9PVko5SnR4SEJ5Snlubzlx?=
 =?utf-8?B?R1h0UmVvQzlMcE1vNVhkV0hOUDBlVmJFVk1TRWNZWUZvZmIvSFNYZDdtZ2dE?=
 =?utf-8?B?TnhXZU9weUpPRkRJdGlnWk1CWnh4NDU5cEYrQ28rWExVTkZJa2dHNFdvVkdF?=
 =?utf-8?B?RU8wMEM0UXZJKzA4UnFWVyt6YXhBZ3JvOE5wR3cwTTZBNXNyK1B0eERYayt3?=
 =?utf-8?B?enBadHJxOUNKZkpUSlF4M2htSWJ5MDA5enBCeDczbENsS1c1RVJ6TVdibXRy?=
 =?utf-8?B?a0NBV2xrNzMwQ2VNUlM0emt2c091OTdWbXRxSGxsbDFxZmRTTW9TTHY3bGh0?=
 =?utf-8?B?NUN1blBjbWdtL25jczdXY0wxRFVFcXQ5QjFDaGZRdmdoUnNZNExTZ0plQkFP?=
 =?utf-8?B?ekRrcFRHVkRZZytzT2oyS0lJdWgzRm1VWHhoR0ZPM0ZYbEZPZ1Zabm5oRUVH?=
 =?utf-8?B?a0YxK0JNbGkvei8rZkpvVDRRREpGRzY5aGtnQ1E0NlNYR05yRHdDYk1uenZh?=
 =?utf-8?B?T1JmVldCQ2ltL0ZlY3E3VERZdmwxSjFtZXNiZmY5QjFUK0RNdk45NkVZaHg3?=
 =?utf-8?B?SkVLKytjbitBdElVZ1F5YWNNNGVtWkEyOG5zN2g3aFQ2NXlaWlRkRUNjQUQx?=
 =?utf-8?B?Mm9JdWwrVnNMcGFsYTQyL1hFclhBNDAwS0ZQdWdCY1JmS1cxTHVMSENrNm1B?=
 =?utf-8?B?THZkTzJ3dC8zdWx3Y0YzNXJVOXBVU3VvNWN2RXA2Q2ZzZTlYZHBrN0VmRTVB?=
 =?utf-8?B?cW5QUUZqSXYvRXYzVkpueGd2NVhsVTc4aVdFNUVzcStHS2VsZ2MwMW5KL0xR?=
 =?utf-8?B?RFRNb1pXRWpmcmJMdkwvOTJuZ2VWZ3NCWWNoSDF5UXl2RHZTUzBjSFMxT0R1?=
 =?utf-8?B?Nkd6NW1VVFNHMDMveGZwbDZuZTVSa0xLSnBuZXBqOWdPWk83ZnpxbUpScTNK?=
 =?utf-8?B?Z3lsUnQ2TS9acXNHRVdlU3Y0dzd0YjBNRkJzUXVCYmNiaXdEaFM1WWVoL1dE?=
 =?utf-8?B?VmU5U0xIQzBGS2FJc2VpUWlBenU5eWZERll4Y0JaQ1c1Mm1QcFZESmFkRnlH?=
 =?utf-8?B?ZTZ6STJacUhSZDlTaENrcjd6RFNVbVpaQmkyTFpvUFd0SFBtYlBTK0EyZi8v?=
 =?utf-8?B?akVVYTBjWGkyRFVaYmY4ZVJFQTE5d0E3SWU4KzlmckJqa3BkaUtqSkMwM3B1?=
 =?utf-8?B?MEpjK29sQVdwVmQxcWtERENOME0zQ2lKOXhRcUtVeWpSbmliRTBoUnRQZnV2?=
 =?utf-8?B?WmFrQjlkZklNdDREUTVCSzljdVRYLzJGOHIreWIxVnNveXR5NHN4bVhuNitw?=
 =?utf-8?B?ZmozTFZEbGp1STl4Zml1SXplRWdWdHhlNzlqVnV5bmdJajJtU3l6L045U2xy?=
 =?utf-8?B?UWFYRVE1NkFObHEwczJyc2s0aHFoWUtPN1ZES2JyWHozMjM0M2JJd2hLUThq?=
 =?utf-8?B?ckVFSi93V0RmRnBUQjNPSys3bzZOU3JWQWVXRzVweEJiSnYxekpOQ0lSOUp0?=
 =?utf-8?B?cGZtUlVnZXRaMklOdHo5ejFNbEN5MVduc1VpR01VdGJJemFuMmhtUE1nZ1d5?=
 =?utf-8?B?dTZ6T3VqUFVEeUJNcDZ2ODNpY3RnQ1QwNHVFc3hVRmpYZFBtamV0QWkvRmdF?=
 =?utf-8?B?Um00K3EwM1lqOUx1VW5XMUlCclU0ZDFlUjdlaHhON3VoNUtXd252aEFGSjFn?=
 =?utf-8?B?TVFhM2lqRnRydGZvZzhRdzlyK3NsSzJoa3B4dmxPK3Q1YTJoVi9WNFZHcDZp?=
 =?utf-8?B?VndrTGJKTmZCUkg0eHUrSXh6ZFZDb1ZFemwya2ttY2pDTUNMZlFycU5PL056?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	G50WKIcq7S+U4eoFTItgck1+T7VA+IXzEBfzsORlx43i2yRuYGXTEsBf2/ytUrDHWlykBOU+X4YSxyHut75fBl9PEPjQYdyEMkYpGf3skglLIjfQMFI5dxF8t5FQsJ7uT6dRhcYTlG/4HgeAfUefVCOUsdSmXXRuN6ao7qf/4b7Xo7EUBL3nKvYyidU3pQ2UshL7Gqlj27M7us+YnOaEQMwh7Dqi7dxG33y6Z4ONTdAcPxN+1yRY4/xjXJOblYHDQZVX2YK3yHCo3JKPv168l5lTk26Mn22atkLGpBqsD4B6XSgzQSl15r/EvGpI53iQTKiF1iY9pU6o6Hb4OzMKF41KSxU/52goYkFYB7ffTm68DF4DmT5O2ispPVf5g1Ule9Vm5M5/YBDcIbVnOjCCaXRd8e3xtJ7IissS41TnDjLu+PGJ/k3BZmKO43BzG2Tlcz6nzcqS4pqdyrNdiLTMhDeCCW2MP1LfqGH43CnUKYyhxsGUh7Fma/G2UAUjWFxdcS1teyNfMM2NMyzwgq31qFU/bUTlMc7TSAzg8G3IoW/ZTu/Ofo7Hk/7TiswxNRFKVt7csSKsTCxl3U8ewE0HuiwT5v1BkzMxTXjOb5Gi3tw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35942ec9-4eab-47a2-38f7-08dbfbcb06a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 11:02:41.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OEQz0COXdZE/QX+PqkkxBdFbtBsEgg1TgiidC/wwzmuSDwsQc3bqSXFB3/E/FwTvw0SO10Fh16DdPTttUEuLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_03,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130080
X-Proofpoint-ORIG-GUID: gOqRUzekoNiOu0SKRpLtide7sHxJficy
X-Proofpoint-GUID: gOqRUzekoNiOu0SKRpLtide7sHxJficy

On 13/12/2023 10:24, Jan Kara wrote:
>> Signed-off-by: Prasad Singamsetty<prasad.singamsetty@oracle.com>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
> Just some nits below.
> 
>> +#define BDEV_STATX_SUPPORTED_MSK (STATX_DIOALIGN | STATX_WRITE_ATOMIC)
>                                  ^^^
> 				I believe saving one letter here is not
> really beneficial so just spell out MASK here...

ok

> 
>>   /*
>> - * Handle STATX_DIOALIGN for block devices.
>> - *
>> - * Note that the inode passed to this is the inode of a block device node file,
>> - * not the block device's internal inode.  Therefore it is*not*  valid to use
>> - * I_BDEV() here; the block device has to be looked up by i_rdev instead.
>> + * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
>>    */
> Please keep "Note ..." from the above comment (or you can move the note in
> front of blkdev_get_no_open() if you want).

ok, fine, I think that moving it to in front of blkdev_get_no_open() may 
be best.

Thanks,
John



