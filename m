Return-Path: <linux-fsdevel+bounces-4560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 928E4800B05
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 13:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC76B20B74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A802554E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lSmEGBgl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LSTJB8Et"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B311FD4A;
	Fri,  1 Dec 2023 02:43:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1ACWGX000393;
	Fri, 1 Dec 2023 10:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Cl81cm2oR95qK+NauR74sIjj++uyut8VpGgfiMZdZ+g=;
 b=lSmEGBglmZQ8CwfDeO+k1axjP7cgxTf6clXZrykRJ0bi9sN9y89g6SC0pjJPU6zV0bII
 IqULVv+truGBbxAl2C2cra198V9jxoAjist7CfL/pv6IZBnFwdjjC/Jj2kFjtiyvbawd
 3mvVz5u4pv6m4j6cXtRa4TjxxRs+ZftFMZWq66pPEJBjV9YSaZKeUjQwXvr1yvr/1RZh
 aBPaGTS8g2SIgOrN/HlZwhQ84x9qVKvfcUulpvgSFBdJ8wQa29U/n3ZD9VCRxXinHEfT
 lnQuteydcfuScZwhihgX/cJKfTVJAfXZsz0Pi7ECinvRiho/JlVYDb+ZmdbxdcXMx5Jz eQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uqd7xr3pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Dec 2023 10:43:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1A6g05012574;
	Fri, 1 Dec 2023 10:43:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cc72b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Dec 2023 10:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzOzNNCuo8IrLCr75dTtH41TVrRssHW8thXjTzMZCQdYWodj41B/4TmyKbaNOYhCgLJf5RdCg1EDYtF3kcP5bwYFZgsSxHAIVq7HG+9JRYvm6WV5lZcpa+Vvjm0OhvlSqLAHMxniswkzWa+GlggzXvHJMDPcRoHPY14EGYV58NZPIumNcEmJTUmqaUzi7pF+DEfJOxPcCoEQwLqsh6Wri5EOS9XuPdp+B9ExTGN6LT64XP/tx2IghFTZ6e8U+hxCx3P+UszddDT1n1Kbe34vtLbdB8RVL8lWe79P1w5L3eHf9IhySd838Kvor7DXTqcOnoehrfHRf2b1+F2kW5za1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl81cm2oR95qK+NauR74sIjj++uyut8VpGgfiMZdZ+g=;
 b=FwfoH4F7dDS2A2og8jRa9iFLt8SbctAu5kOK6aIAP2neRLQ0OcRpqemtYla7EIm6WWzNDuaSlwEQYPzP6XLCw6UMhd+zb7za559gA75YK1aH94WRBjERxfgKD5sghYBpGw3s9s+kehOPDs6/QeIkhRDcVRy1bVXym275ss9AYLIMMvxEkBf7VUxNVKelA7njODLbUsjqdf35dN9Y9ffzudsfPg/Thjyo6EQr9sWgKpYG8mjeW74D3z6gUVr0nHUUYFEKWfDQQqudUT45Oin+YTYV99TE482IaeUvyPActi8/HQ/DRs0rZVzR/8zENVoT2pevm0RixpWZkejFf9yg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl81cm2oR95qK+NauR74sIjj++uyut8VpGgfiMZdZ+g=;
 b=LSTJB8EtlIL9jNSOelZ1OkKOcox4cV+3QwIL4oPtjQm7Zol+Yc2VAOvVau4FcVgfbAdoiH+VHW0QhM6HsuF56DXjGBkPXOeCRFtRmwIos7RfN/3nStBXbPjlgz5fXoYPbkZxfEP2RKuvT/X7l3XY60i8NUhjdK87CDkh2arVbbc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6196.namprd10.prod.outlook.com (2603:10b6:208:3a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 10:43:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 10:43:02 +0000
Message-ID: <85d1b27c-f4ef-43dd-8eed-f497817ab86d@oracle.com>
Date: Fri, 1 Dec 2023 10:42:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/7] iomap: Don't fall back to buffered write if the write
 is atomic
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
 <ZWj6Tt1zKUL4WPGr@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZWj6Tt1zKUL4WPGr@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: e1654667-1dd7-4e6f-8bdc-08dbf25a4ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ftpfIMFG8XTIzQ3NeKvTilnnrFzlHBeeUCOnMVxW7RnhzfmAbjgJr6o7FTj008BfMFciSISqRKipyQOEOc55eEzXN1sRg5KE9dv0IRfuOS/Z6T82ed2BO9jPIFVPy5b5gos3LPrYeJ0uFB6RI040NcR/cuPpl4b1D/cE1fAEkA2cWxpDjSbYGgm1+jFL5GM4v5lPmgCSSqZPthQ0A6DYRB/qOvp1HuY7FehI0jZfYX9RDEA99iTjz/GFuVASO+cIQVTcvOAqBi2D8DeI8dLNyKBJDHOmWJa8jZwdZZsRoP5E/w++tcx1MSKMJ11o8Rbm8XVA0QUQNcq7WjJduDR8bCTtfQ4/0qkg55F1d7i281dqn8wcR52c0Zpc8M9lASsGje5wJ48KTRUvB25dl06lbbkFlh0fWdkQw0A6/qbGretSrft3ZFMIieQ21ScENnrpmgowFzvD7zH18vk9IIF2jiHAyeuDZ5rmDcocR7KYMect2be1n64MoghaT9pgRLzTPJOCSTtJpSl6t8YkioixRSG0mhJme4TikTj8uNeQ93N6mN2VVe3T9vFCQruRjj2EW8XFnKV+wvd2a8VGK6zW6yTP0d5x++jC0oZ7soa431567rkbiLsD08F/qvX1hhtDS1YWmNAHlAGjlxHLfJum9w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(38100700002)(36756003)(86362001)(31696002)(66946007)(110136005)(4326008)(8676002)(8936002)(54906003)(66476007)(316002)(66556008)(7416002)(5660300002)(2906002)(31686004)(53546011)(6512007)(2616005)(478600001)(6486002)(6506007)(36916002)(26005)(6666004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dU9ySTQvWVNSVlFFU1JaV0tSVHFjV1pLVnNOMFF3TzRWeWZvSmZpNC9kM2NT?=
 =?utf-8?B?ZUxDZGlsdTYzS3RXQ2t1TXJtakdwdUVGd0hZN1lhbmxLQlU2YWdGOEJZcU03?=
 =?utf-8?B?RCt5R1NIYzRQUXBXOE9kR0krR0xiT3plb1ZBSW9GZUthRk9EcUp3ZzRsWU9B?=
 =?utf-8?B?TXVwUlRrbHpLeG1vMVcyNjJVOFBQNzZTalF0V1RlcDZ3SnRUVHFUd05wSE5R?=
 =?utf-8?B?d09rNHZwZkVaNXhlbmdpV3dqY05scmRPMHg3bjl6b3dQZW5rOUhGSk5vbytU?=
 =?utf-8?B?WEh3Wk9MTTJTVEFyS3ZoSndCay9sQi9OVkkrekJ1VzNveGN5YjRvclVCc0d1?=
 =?utf-8?B?SzFlVmh0NjlqOENrWDVFbDZhNEx3MWdlR3lpYnFsWjROK2Q0bzhOazR4TDk0?=
 =?utf-8?B?NlJuZmFKUlBHeW1wRXk4VjE0a0d1M0x1VUlnNU1sRW10Zm1qVSsyMjhUcGhC?=
 =?utf-8?B?MnEwcDNXUDN2VUtsQlBIRXRBTEtJamJXWGFaeFVldW9iL2hHQ090UWVkT0M4?=
 =?utf-8?B?M0JpeVVlM2liLzYyUU45anRWRzM2eEhIakhDVUdIemJCeHJiNHp2ZzZ3bXhy?=
 =?utf-8?B?L29NZU85R0FjYStQbjU5dnE5NG00SndXdXBNbSs5WUROeWtJNXFZR1RvRnox?=
 =?utf-8?B?QXUxK251Uk5XQU53QWlwNisxQXhzMDduaU9tcW4zZEIzdmZkd0dGUERSTTFz?=
 =?utf-8?B?d2xtUjRnUDY1ZkxuejFucm04MXJYVjJOcEx0dXIyOUk4YUdnSGFreGZjbzlH?=
 =?utf-8?B?NTJSNEd6SS8zODZ2aDFpOWdOVnFWdkt3REVBWmhIbW1jSmYxbXFtbHlhSnVZ?=
 =?utf-8?B?azY5bEVxQVZiZm5adG9iVXd4S0FOUjlwanZHNTZSMFFtVGxYVjZsQW16anZt?=
 =?utf-8?B?MUpRMGtMTEw1c2d2eXZaaXRvVGtLM05QN2QzdGR5RjUrREJGNy9tMld2Tkk5?=
 =?utf-8?B?QzlNc1NMb1ovNnF0TFczcDRLdU9EQitteUE1YWJ5YU42OEZ1ZUtrOXpEbFFV?=
 =?utf-8?B?Qy9WOGVnMGh6OVJadStxSUY2dEJYRFhGL2dXVmRsWjBPYmc1cnJaUGdQa3VD?=
 =?utf-8?B?L0RPUXNwMCtMTHZYYW9FK096U3c3cUNSZ3hFNUJkQllHMDkyNzQvOTI0R0hn?=
 =?utf-8?B?RFRQS3p4YUQ5ZGc4V25Fd21KamVacUIxenVuN2ptcnpIdUFrRVdwSm5VK0w3?=
 =?utf-8?B?aDk4cjFrcUJqSDFXS1Y1VnQza2VmdWJtZ3NBTUhVTEx6ZlFKVk5pQ1ROc2tw?=
 =?utf-8?B?aVF3Tk9uMllmOTZaMTBOcXIvS2dDalo2YW9vc0lkV3M0N0M5VzJjK3lhSldy?=
 =?utf-8?B?c1k5djVUbVpEZitkeFF2TUo3a3VHZjR5eTZRTXVoTlhNaHRzNDZsbm9UekRP?=
 =?utf-8?B?ZDNkaWs0OUpzTmpWV3FTdXJBRGZxV3FLSmRMT3RwZlY0Tm9ndUtKcmhiZmtC?=
 =?utf-8?B?b2pxRFVYdjBCbHYzU0RKcDRBbjc1dGhuWSt4RmYveTRtMnBuMmJvZmE1T3ZV?=
 =?utf-8?B?djA2NHlUb3ErM2ZkTE1zZGhoUEtoMUVIazJacEluektKS2l5MUxVMmtuZkZT?=
 =?utf-8?B?MVdCYmVuVlFPMU9WQUJLOEpWbkVPVnREZjZ2djd5S2d2WFA2a0duN2JyS2tk?=
 =?utf-8?B?OUVoTHVBeFdMUm15ZHU2N2R1aFMyRGlmSUIyM3ZNTmFvdC9mM2VLMEZwT2Va?=
 =?utf-8?B?Nk9vRUFyVSthYVovY1F1OWhMNXgrUm03UkRMbDdlaXVoQlR0QXpCcE9XcUpC?=
 =?utf-8?B?RE4vUW4vR05WMVg4M25HeGU1cTNBQk9FcExlUEVtZ3NKOENXeWZKbEtwV3I4?=
 =?utf-8?B?STczNnJtaWgzM0JibklrOHY5ejFEckFlaDhjWE1JTzNkcmNlMFk4TUVVbUhV?=
 =?utf-8?B?T3ZzRkFBNWgxQk5lTkl4Z2NhRGZjNytOMXRnZFhyY3cwWVpwazZZbXFhc3lP?=
 =?utf-8?B?WWlXUEFBZ1JMRHgzd2ZGUXhhcC84RnEyQ1ZPa3Y4WDdIaEd6bmJ2eFRBdTlC?=
 =?utf-8?B?ak8ra1pxSERCTTdOcGg2OTlBZGE3RGFuNmU5SWdpejRvc0ZBRWk0c09lOXZX?=
 =?utf-8?B?ejZLZW13RGQwR3QzaU9wZUdJZkdaWlIxVU9laVFHRWRzcGpCYkdoRFpMaUtC?=
 =?utf-8?Q?mcQ8CADF6QC8eMirvTXE1WGkw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?QTJYV29DbFZlUWN3VTZ2QjZTcllrcHlXMW9SVGR5dndpM2hoUnBsMmNPQ1dk?=
 =?utf-8?B?ZWx5QmlaVk1TMnVDNFFJNkFGOHprZXlxSFFkWGZIaFhXRk1jdDRha3ZyZkdK?=
 =?utf-8?B?alBaR0dZYXB0Y0ZySWYxYWUxWnhLR1RPYlRaNjZ3Wm9jZm9RMEM3VTNNL1hY?=
 =?utf-8?B?WHpUbEc5VnVNMVJ6T3FPeUUwSVBlQUdCT3ZTNy8yUTRPeEhsTnNYc2hGRXEy?=
 =?utf-8?B?Q2V5cXdrOXdJUHNjYTJBUHZMN1RhNmlnSnZqVlB5dkFsYWg4TjRqU0QwU3VQ?=
 =?utf-8?B?V2thbHlVMGpwaExSeEJTdHJNUzhPU1N3cVJUUGNuYnJTVkpkVHRPZzVJRmVr?=
 =?utf-8?B?UURCY3dEQi8wRWsvYkN3MGx4Z3BPWEZUT25NTTJDbHIwSUNqTzJ6TzZWbW51?=
 =?utf-8?B?dms5T2FTZ3hBeXBaNFh5dzdScXFVdXhJckFnQ3p3cVVFbUozclZQdG43dmhT?=
 =?utf-8?B?YzRPWGxsUHRkMncxMlJFSHA3VXJnWUR5b1pyNnZFQ1JIbTBoVVMwUFY1TVBj?=
 =?utf-8?B?VWsvMEpHcEs1TWZCL0E2L0hMK0docXR6dTJibkNDYTJJUC8wUVdXOUl1dXl6?=
 =?utf-8?B?U254NExoalUxQnlDK1F2YnJqaVh5elRlQkw2WVB1L1lDMmJPUWVza3orZ1NX?=
 =?utf-8?B?dE80emx6ekEvUHhjbUkxMXFwcWxXc0NMZ1I0RVVDVGw5dlZxcUZ0eTFuVlla?=
 =?utf-8?B?NW1MUGQ4V1RmZzBVWE5qUGd1eDBDb3RLdWlGcllRSDB1Rm14anZ5cTVBbnhj?=
 =?utf-8?B?SDRSRnAyaU5hWXRLM0xEVEJlVlZNQlhZWWJnTlljMmdxSjE1R2pieURGYVZY?=
 =?utf-8?B?Smt5SGFPRjZDNEhMd1Jjcy9xYjFMTGJXU2xETTdiSE4zRE9ZdmQ2RXhvZUdQ?=
 =?utf-8?B?ZlBENncyZjNwa21KdE84SEY3Z2RmazZnZWhpY2sxK3hnZit3N29ZaksrdSt2?=
 =?utf-8?B?Vi8zb2FrNnpiSk1vRGFYNU1YS3ZuYnZnNjl4UkRPbExyTkExRXZMc0puMld3?=
 =?utf-8?B?TW5HZWowemZMVnpjM09vZm10aUFwQml3cDB6RGJpTVJZMzQyL0E1ZVBGcEY1?=
 =?utf-8?B?eDhrZForZE5PaVU3YUgvNVl1WWgzdnMvcnNHdFlFbEJWV0dKNUZBaXRBREMx?=
 =?utf-8?B?aVdwQTlWMW5PYVd2OSswZDhaVEMvcDdGWXhhL1NORnl1SzBtcjF4WVppNEp0?=
 =?utf-8?B?TXlMRTVvRWZpWkUvSWo4QW1xaHRraUdsK0Z2ZnpsNjE2SWF0T3JMcmhYd2xI?=
 =?utf-8?Q?C108I21Md87aFzQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1654667-1dd7-4e6f-8bdc-08dbf25a4ae5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 10:43:02.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvwgQzaA40fNOTlzdlVMUuIZQFnr3pzYaETZsPY+jPOvRu3oNUNiM0hi219KtL65Na3hLdf5L5mv6zZcVLpFaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_08,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010070
X-Proofpoint-ORIG-GUID: ZC2_859SwiCUO-99MltaBurD2J3hHMg9
X-Proofpoint-GUID: ZC2_859SwiCUO-99MltaBurD2J3hHMg9

On 30/11/2023 21:10, Dave Chinner wrote:
> On Thu, Nov 30, 2023 at 07:23:09PM +0530, Ojaswin Mujoo wrote:
>> Currently, iomap only supports atomic writes for direct IOs and there is
>> no guarantees that a buffered IO will be atomic. Hence, if the user has
>> explicitly requested the direct write to be atomic and there's a
>> failure, return -EIO instead of falling back to buffered IO.
>>
>> Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>
>> ---
>>   fs/iomap/direct-io.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index 6ef25e26f1a1..3e7cd9bc8f4d 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -662,7 +662,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   			if (ret != -EAGAIN) {
>>   				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
>>   								iomi.len);
>> -				ret = -ENOTBLK;
>> +				/*
>> +				 * if this write was supposed to be atomic,
>> +				 * return the err rather than trying to fall
>> +				 * back to buffered IO.
>> +				 */
>> +				if (!atomic_write)
>> +					ret = -ENOTBLK;
> This belongs in the caller when it receives an -ENOTBLK from
> iomap_dio_rw(). The iomap code is saying "this IO cannot be done
> with direct IO" by returning this value, and then the caller can
> make the determination of whether to run a buffered IO or not.
> 
> For example, a filesystem might still be able to perform an atomic
> IO via a COW-based buffered IO slow path. Sure, ext4 can't do this,
> but the above patch would prevent filesystems that could from being
> able to implement such a fallback....

Sure, and I think that we need a better story for supporting buffered IO 
for atomic writes.

Currently we have:
- man pages tell us RWF_ATOMIC is only supported for direct IO
- statx gives atomic write unit min/max, not explicitly telling us it's 
for direct IO
- RWF_ATOMIC is ignored for !O_DIRECT

So I am thinking of expanding statx support to enable querying of atomic 
write capabilities for buffered IO and direct IO separately.

Thanks,
John


