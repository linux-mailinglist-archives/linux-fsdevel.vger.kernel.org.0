Return-Path: <linux-fsdevel+bounces-1745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F2C7DE423
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 16:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0D81C20D85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4914A88;
	Wed,  1 Nov 2023 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0zllH6j5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OnkUS35S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84514295
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 15:48:47 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26730102;
	Wed,  1 Nov 2023 08:48:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1ATNGC011709;
	Wed, 1 Nov 2023 15:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8mhYkKlsnvVk///0pchx9GV0Utnbb7331HD4nGhk/7k=;
 b=0zllH6j51x0QalbUpT43VeQM+QoqSIn8h5j6m1kJrmh7O2UyBGMn8YB9SoeofaMJYS1H
 QQIImzkEgAIeCzev8cGOE/sbQX1empRovaaBzXuG3GLevNWkFJh94zOiYVrFm9lQG5Mv
 unkW4X8sp9XUTBuqe2XFV7lL6yac/+H17IV0cRBVQW9QBVv9rVM+wATotlyrfAtHJbrM
 CxpJ0sRaR7JeN3zKYsOpBQwxMiPw9gmONXCv1KV+E3JSe0OPN+6aFNcm81TD2Do6MNvU
 9jKguXHmyJBs4xBPiBZdD3oF4k3RzTjTbumTViwstiK4FmI/LaAC3neH1JCHZQHxHJkF 4Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s33ywhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Nov 2023 15:48:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1FLXX9022500;
	Wed, 1 Nov 2023 15:48:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr77xg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Nov 2023 15:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/2lh6PbMET2+OxJ0bU1nhNtACLZoVsUbMen2SqrLbxv+I/gBZZiynI5PFiwQK9q8uDxUN6OsVu1J/7LcRkk6nhfU7mqtR/SANIoepPRx62EkmLclNqrjJ9vJepPoxnLP1fCv2LPdjfU0SYLdyW6Apr1MW/ja1fdXt6oy7suyyzPb1iP6ZmQpCB70u1oaAM/oSHqnwD1YuJrViY4uxMgJQNj3eor6j9VYpcjtvn1TR4/PtWOykhd+Mh2IMjkS87AoNm5VI/41qvY4JsgMqUpeH6mYJIAJbXo8Ju3gV5pk4PWHNmA2mIVYBvou7Ia47XwzeKFTkG9a4yFC0Tzgdt79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mhYkKlsnvVk///0pchx9GV0Utnbb7331HD4nGhk/7k=;
 b=oP2CQF6F64nonfEExQRk3eCiOBhXH/JYNZaZQqv0cGiErVAxj0svMZLVHRGKjrDI3H7LSQzF6P0ZUVJ8V4OymQ+xdJ3OtHpOJjM1VnKB+wVvVT7E/Tvzpe64VgvVKnSoBiCFrFP8I0eSVFq6UOQrgOYjiDhRzvOBIpbC84wK8ZgQTXsp16a4fCQhdorlmnlBCFHcFqfKM37gmAu9d6VaR5uPdreuLse2AnhKXISc/yhAWE5tLXuz73brRLqhH0D38mbPMBvsXy89YiAm+CZ79qhN8V0+oPoYp0ArGlAD8vUAToMRVlKTSnKrZs0mvPT87VPmzgTRYdOY0MhuBB4PJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mhYkKlsnvVk///0pchx9GV0Utnbb7331HD4nGhk/7k=;
 b=OnkUS35S4LkBRAuGTKwkkcb1PcVfwowlUQT61j9UjQV1u3VdaozE0rOouOvldoYgxM4h/j2dFlfag4qO9oBtcv3dRS7R3McvOcQd58PF2+Lsvnss0k734R7Z+7x+pPsgdbCcnK1iHdE7FAFCOqTX/LMaTG3NavbwMI83byEdcns=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by IA0PR10MB7135.namprd10.prod.outlook.com (2603:10b6:208:401::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Wed, 1 Nov
 2023 15:48:28 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435%4]) with mapi id 15.20.6933.022; Wed, 1 Nov 2023
 15:48:27 +0000
Message-ID: <e3c0e7aa-2ee5-4958-99c5-74c25c3869e4@oracle.com>
Date: Wed, 1 Nov 2023 10:48:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix uaf in jfs_evict_inode
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
        syzbot+01cf2dbcbe2022454388@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000007b8bed0608abc6c2@google.com>
 <tencent_69E996EDCACDBC79A66CB02F956C3494D80A@qq.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <tencent_69E996EDCACDBC79A66CB02F956C3494D80A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:610:33::26) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|IA0PR10MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a9bd75-c92d-454c-f5eb-08dbdaf1fd62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uK9rh4FL0dOAjafsPkjXlivWgGNss86VjG54vMd3JNPYwX7j4uEF+kptK7GTmKDnk7U6fE15M9zlEYHMvGjvvanv0HKb4AScSVbzD51TyjCgUzQAxJsIUgzFvznIkKHYSFElatv0Y+5F2n0AbtujQC3PqgA+Z6v8S3H4QVygDGNjM02+5XIkL1Y0CB0I6NesQ5jS9fTWhJo5soizUgoeEUDPLvtBaNA9yNcDLCdcAweKXcdZwSnqBGJUgTdgIALeXDP0cHcQuNhJc8mFaLHMb4uc2OJ70+ozKcvjjh01aoqLonBZQn9m3BP5uwiu1HS7g6zSipowncx4e54aFKMdQMRr5DM6Nh8Z67LuHUSrpkRnyjmrsSDHCM599z0ONex4WnA6Uk/8/VU+rRIIjCbRTyvHUAsQcHqK76TVvOZwlFrn/l3qkJGJadCim3tqFr21jCIsYUPUtzdpAA2sgjd/ykvOjA58CUPv8BPq1bdlMn6NHCFO9+1VQ3ViQ2NXeDqrUG1+yfgsF1esw7ahF2/zUgfnaw3tlQbqlrfgOKdndYfN2ns+eSRhBrIXHXEzZ3gnTpAlYk0fyufFuYittkkGHy5irT3sWXBdyG3tZ7ohAVw0p44TyGetdd+Hl12vwjFD5qZqNhg5ZhNgvfpEG/SAlg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(478600001)(6506007)(6486002)(2616005)(26005)(6512007)(36756003)(8936002)(2906002)(83380400001)(44832011)(86362001)(5660300002)(31696002)(41300700001)(8676002)(38100700002)(31686004)(4326008)(66476007)(66556008)(316002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d21QZHExTHpCeEJkeG5FNG5JQnpObzFnQVB0OVNVTDF3eENBWVR0UXFBZWdt?=
 =?utf-8?B?M0EyRFRqNTh2NmNycm5OYmdiT0NkVGlRTWNzODNqMTlvdnZLK0R6WFRJT3Rt?=
 =?utf-8?B?QjNuV3NZZHZiZjNJR1o2OEgrOEJER2lubHJ4YjZ0TnRySkp4MGFwRmR2dHUw?=
 =?utf-8?B?VFhUSjBoNXBYNHlSQmlScnFRVFFtUUxUZXc2UTVTekp1ZThBcjRQOUY4R3pm?=
 =?utf-8?B?ZWwwSERLcExMc1QyQnFEeTlCbWlpQWQ3UEVBeCtvNVFxNXdoemMwTXNzRHFH?=
 =?utf-8?B?Q0dFQjV4bnp5bmd3V3dIMzJWYjlmWmwyRjh6R3pyTklUa1d4KzFTTmoxVk1B?=
 =?utf-8?B?L2tRTWFDalh4M3ZGUTNxQ1dhZ2FLWVRTc2xzVlIxSlBhb2w5d3NUWjE1UERh?=
 =?utf-8?B?T0ViS0hIL2h5WFVOWjZGVGJFZGxrckN3elAzNEZPczNCTnd6RWpsNWRiMmda?=
 =?utf-8?B?UzJqR3VreXd1ZkhJM3lGWFBGeGdMQjNyeEppeTlqS1RmdU50SkEvVDZ6MzN6?=
 =?utf-8?B?UEhVWmtqL003VzFkMTZ0RDdXYm5zSXBlYU9VS01CTDNaY2dYdVhsZXUzR2g4?=
 =?utf-8?B?MVNoOWdWUnhpVzJGZTdac0lYTkpaaWFrZFkwQUUwTzBETGxGQ3lhUHRKMDVS?=
 =?utf-8?B?eWZjRXJaWnpFQkFDczdxOUxidDVhUVI5NC9QOGxYK0FQN1hXem5walR2dzEr?=
 =?utf-8?B?RXhkdzcwbGk2UmpMZ3V6QlYzeDJrT3RPQ3AvNktDQmRzdS9JRjlxTmFJL0Uv?=
 =?utf-8?B?UTJOS3hleUUwU3dGUERvZVVubkF5QkswSExYSWZWWDU0b0tsZVIremxRUTBa?=
 =?utf-8?B?UERaaUFwc3ZmUFpIWW4rTlJKb2M4TlN6dXJqZEE4eTh5Z3o0MXZvN1hSQVB6?=
 =?utf-8?B?U2FzVWtFdGpERXJFRVA4M1ptUGhFdGlwKy9ONTE4bTlJZlhTc25IL3hyNHVC?=
 =?utf-8?B?b3ZNK3pSR0VDNGQzZTJCSG1Ca2xBZ0daeXI1akl3OWJsK2I5Y003OUNLaitK?=
 =?utf-8?B?Z2thUStGcjNoNURTamtFVkhZQStSZVNORXFnaWtoMElCQlRBVG03NXdzSWQ4?=
 =?utf-8?B?NTBUem9KblBwTHFXZENLUEZsNVh2dHBHTk5KRUFDTDJ5dzQwQVJOZGxTSlJX?=
 =?utf-8?B?UG92VXVSaFFPMVduMkJYQjd3NHVTZDcxd1kxYmVBRm0xaVpJRVRRTjg5OVZT?=
 =?utf-8?B?Y0Z6Rkt6Rm9vZW80dlAzTUVuSzdPQVNaVlV2QjgxMkZTNjE3NkJyd0ZGRTRz?=
 =?utf-8?B?SWl0SklabXhzSnoyWmhDUVF5VktmcEN4RkZxLzN3dE1acDdFT0crTEtHZXNO?=
 =?utf-8?B?WkpFL3V2b3llMytmdEo3d3RxVDg5SUxkWG1JM0xPSW9BMFU5THZxdTA2TXo4?=
 =?utf-8?B?RWZaZXlRanZPdWx5d0hYWWpVcGZXakowVmdMOW5MMzQ1U3ZmaWU3WDE3ei92?=
 =?utf-8?B?djM4ei8vaFA2QnZpRmo1TDNUV0xUN1JteURLdzAvUmlDSlVyZlBnMmQ5Zlpz?=
 =?utf-8?B?em5rMGd4QmRjRWk3UW5pMFU3bUJwcnB5QzJJV2NzRmZxVUVyWU4rU2VFUEVU?=
 =?utf-8?B?TzFoWU41SzFLV1AzSURxNld0TnFZMEdTdW8xTkhkWGMyN2pjTkZqSnJkcGpj?=
 =?utf-8?B?OE1SZDhJTHVRZm5UNUxYeHM0Nkl0ZlJlUXQ5L0t5Y2I3anU5akE4Z2xWNlFE?=
 =?utf-8?B?bVpqQ21DbTc2Rlc2MlMvNXBHSkI5cmhpMWJHT1JpYTJQbGhTT1pIbFZXc0Z6?=
 =?utf-8?B?U2lFdjhoN01YSXJFMWRjQVh6QVdUaVVJaHJzcnBIZGRUOWFOYmsxaXVmclVh?=
 =?utf-8?B?UEY3aEhyckJ0eHFNZWtLWmRLYjBqNzhGUzRmVnozREZJNGU0QTZZRW5pdmNs?=
 =?utf-8?B?K3hjR3hHejVjSm4ramFabElDcDNDYlYvMitKcGZvWHRJRmwraXVWZndtUEVm?=
 =?utf-8?B?cUt1R3FIdlFsclBqTWZncVQzdnB3b0I5Q0djSVJpVlEvbTVLZUt5cklMSHVq?=
 =?utf-8?B?NFcxNnE2SW5Td1dhWTQ1eTFrcVBNNWtZalE0M0t6NThLM05Hd3BldGZCaytW?=
 =?utf-8?B?WGdTYmRvUFFtZFlQbG5GdFhJbmlWUlFTU1dxcmU3SS9tTmo2ZGp4T3MvbDFV?=
 =?utf-8?B?NDdoNE5YYi9WNS9qNkFSYnVwbjRCVk1HUmorM2hJeHNCN3lxSGpVZWI5bVNp?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?U2czRUVZWnhMcXhqcDgyOHpyb3JkNGRYM3JkYm1zSmNsWlZaNm9kbkJtYkNh?=
 =?utf-8?B?cnNwdmJTWTQ4dEJGS3JXdS9QNmxXK291N01YZUhFVWVxeStxQ0l1SGJuVFk1?=
 =?utf-8?B?SWtZVU8zbHc3bmRHSmZIWmQ4OVB0eE9JQXF5d0YzKzlMVENLcURxVmJMeHNX?=
 =?utf-8?B?dGV1QWRTWG1oaXpPYVE0TkJLb2pQM2F3Rm9ERDQyVTg4ZEdTWWo0ZXppQi9t?=
 =?utf-8?B?di9PQThZazlXRW8yWHMySDdoM3h0NlV6blM0Rm9scEdEQ05IVjM0YU1CWktQ?=
 =?utf-8?B?cDI4SUxaRE1YSXMrKzJyMTBobzRRNDhxb1VaOUFFVGkvbHd3RFk0YVN0YXk1?=
 =?utf-8?B?M2VHdldZbzJLSHprSlR0dVQ1d2tFSzdqa0JoajRmdUVqZm9hN05LeEVmU21o?=
 =?utf-8?B?SzdVVEpZbHp5WWVhbUpMaDhHMlhyQVhQN0RjRGJDeS9KT29FamVQQ09JNGI4?=
 =?utf-8?B?VjQ4VU5adWpSeWcrRWY4ZkYzTXdES0xTbHIra24yV3NuaEVhU3BzRmlGd2pl?=
 =?utf-8?B?amh6c1RWZElQM0RyK3NJcU1LbVJzY0VqQkVjWjBPV2ZSSURWaS9FbXVsU3J0?=
 =?utf-8?B?SUt6cTlyNEVlL2M2K1ZXbTY2azVHUjFpUHBCVktSWlEwcFN6WTdxL1ZLeXQr?=
 =?utf-8?B?VFpnbnR4NWsrdm5DM0lGU0hDakZqMWVPQXNmMjJVZ1RtU09kUUp1aFBWWEM5?=
 =?utf-8?B?S0gyVm0wenNQMTg2Z0Fidk50VlRSeGxSVkhVVjZ5TGNYTkNzZVkyaVgyeFZ1?=
 =?utf-8?B?V0haVlR1MVp6c0ZLdVdIMHNTZzBleTRrSXhyL1R2Y3o3OHR0SHRwNGdxOTFJ?=
 =?utf-8?B?Rk5wU0NxZ0MwczNsWU5Fd1JNcE1GMXp4b2paRlJPNzd1bmVJTThXUWRITzFX?=
 =?utf-8?B?YVdidS9jc3NXdk84ckJGTCtHdlJwWU9UNmJlR2FpdjUwSHVxQnJuTTcvV1U4?=
 =?utf-8?B?aHhLS05jQ2JVZEhCM2ZrWUVCSlkraHArTUZBK2hBNlNhdFNZT3hyazEwRjRv?=
 =?utf-8?B?VU1FMUppaDNKYTFnVW9aa1hJdUM5dnlWcmFqdDhJT0RocklJS0d6bXU0T2xj?=
 =?utf-8?B?bjMrL1RjNXVlaDQ3YVVqcEJVTGcwbWlzekdCUzVDUDJBSHRIK1BEMlI5VU9x?=
 =?utf-8?B?VUd2SVBoODVGaGQ4ZDdHaHU5Y25yeTFFdWRKbE94VWJTOGJPVWpsVHBKYlNq?=
 =?utf-8?B?VWYxNTYrS2RUdXJFeUxoWEVMbzZOam9zNXVoV1NGMDZqbEcxRXp2TGlIK1JQ?=
 =?utf-8?B?N0VlUXU4OTJWZGZGbVVqRHBjb0hpREN4Z2dKN0g4Vm11a1Mzdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a9bd75-c92d-454c-f5eb-08dbdaf1fd62
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:48:27.8283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISGtL1YcrUeGUPNZGGwyHTGHmozHPl5y0yLD42XmiVQJIYj7O1CTPkbP3IlZdWSsu+ERYA2/SSgBiZC28dJOh/ROMp2eLpjG8knpmBm1+Cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_14,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010129
X-Proofpoint-GUID: CqLwwdhg5IbUe1B_9KqTNnu64KvaTXgb
X-Proofpoint-ORIG-GUID: CqLwwdhg5IbUe1B_9KqTNnu64KvaTXgb

On 10/31/23 12:39AM, Edward Adam Davis wrote:
> When the execution of diMount(ipimap) fails, the object ipimap that has been
> released may be accessed in diFreeSpecial(). Asynchronous ipimap release occurs
> when rcu_core() calls jfs_free_node().
> 
> Therefore, when diMount(ipimap) fails, sbi->ipimap should not be initialized as
> ipimap.
> 
> Reported-and-tested-by: syzbot+01cf2dbcbe2022454388@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Looks good.

Thanks,
Shaggy

> ---
>   fs/jfs/jfs_mount.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
> index 415eb65a36ff..9b5c6a20b30c 100644
> --- a/fs/jfs/jfs_mount.c
> +++ b/fs/jfs/jfs_mount.c
> @@ -172,15 +172,15 @@ int jfs_mount(struct super_block *sb)
>   	}
>   	jfs_info("jfs_mount: ipimap:0x%p", ipimap);
>   
> -	/* map further access of per fileset inodes by the fileset inode */
> -	sbi->ipimap = ipimap;
> -
>   	/* initialize fileset inode allocation map */
>   	if ((rc = diMount(ipimap))) {
>   		jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
>   		goto err_ipimap;
>   	}
>   
> +	/* map further access of per fileset inodes by the fileset inode */
> +	sbi->ipimap = ipimap;
> +
>   	return rc;
>   
>   	/*

