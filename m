Return-Path: <linux-fsdevel+bounces-5995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ED9811DE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 20:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643091C20BE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D79D67B6B;
	Wed, 13 Dec 2023 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BrRY10Rn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nWXNh3JC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD290C9;
	Wed, 13 Dec 2023 11:02:21 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDEQx5N020988;
	Wed, 13 Dec 2023 19:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=FLriMew6PSfP/imqwlsDrPOFKr9LQdFHU6VT+lK38HE=;
 b=BrRY10RnviCTJucNRTAtU59AXsWavwGWV8aHYUvjhuUQAyQe6gmRLtyIWdW5TqH/JPX8
 B6aIhDH47lFYe9PmE07VobGaprNCH2lV7gDQfL7xtSeLKEaFDc8Lxf3d/vZ4bevW4T35
 0dFYVY4Nnbsa654tSefIa4CiEmK2qaZziXgw35wNUF2UPF+JkPAng3awn8F4BUOzfP0U
 +nfePk6jm9yGQ+Zf+tRTDESqaXUl70A1Dq0mklHYhPP2kQ0tUqHC+KqDkA0QyyD/JQN3
 bjK+vjxdzaN4eUYNXoqdf5PuOsPq//bIP61+1eINRFhRTJg/CQEmOhED5h5bFhInrqnW ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu915p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 19:01:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDI5xTj009848;
	Wed, 13 Dec 2023 19:01:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8t38h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 19:01:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoNaf1SoELwV7YaoNxhQnsqr12rOjUANN9GZJ9xQ6Css7WZSqP4QXKDrDgYXaetiQcb/jIA5UZKWF10AXmcumtIjfp/FjLx0bGZ5gD2swBFZd+IokODXHdisLhTgpKR6/Y0K4VRVgKZkB6xjmHY5x/rSyinURIuKmcaaiMb432xxoS7UQ/mnK0OkJ/yV20joiAhYnD14VBIwq3Fyjv/hF+hz2bNrJcg2/2VCZyndIItWGPzQ2RqAQwmC2PT2K+TKD+DM+j4wYKd6dhpBoxddZO7UE/E7+i1o0mGVqpkdHTDgkBNPyoVUs+ADnVGkIBN/bRoDY1iQ+bDcF4eUNg4N+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLriMew6PSfP/imqwlsDrPOFKr9LQdFHU6VT+lK38HE=;
 b=fvSb9IjJT8XQ9sSjRDEfuP98lGKDnw+J8LJOlIYqFU7DrQ0XItZWGWTWuxfS4FT0JbD5XKg/UYelJfPClRRh33tXMW94i/MHQEn9egxH4kiyWt4kIWkjFt9XLUy8oaYkCMoU+YXEoiCoQ87vPc1ygprP5A0gZQ5j1JwNsU0A5Hfkvkni7VtQC09QvK1MfafPXVB+vvCb/icEQv2dOi58ya499RaJr5tIDRrhBGXOOl2XfE/ilvRSBZ4KFw34Xrha3VvI72u589/7vQUcBnf3CHeNe3zjIBOsiICcvtqIexE5l8Pxp5cKyvTQuKJJbRy5+d4Eo4B6oKsiYsI/nKhpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLriMew6PSfP/imqwlsDrPOFKr9LQdFHU6VT+lK38HE=;
 b=nWXNh3JCigo78LnITC1pySny0GD3EHV+KZyk0DmJBZsmsHO2YUNlOHHCNhOdeOYRHXBkzYp+7w9wLGB/lHhW9FXP4iXnuTucBuArkeQ2A0g2q135UYpZh78puhvdCvekd78YDPua/Laila0Rt93G5RZW/gBcyYuIoWUIpOAKy7k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6250.namprd10.prod.outlook.com (2603:10b6:510:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 19:01:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 19:01:26 +0000
Message-ID: <15255c5a-82ec-4ce1-8caa-da250fcb7187@oracle.com>
Date: Wed, 13 Dec 2023 19:01:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] block: Add atomic write operations to
 request_queue limits
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        jaswin@linux.ibm.com, bvanassche@acm.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-2-john.g.garry@oracle.com> <ZXkIEnQld577uHqu@fedora>
 <36ee54b4-b8d5-4b3c-81a0-cc824b6ef68e@oracle.com> <ZXmjdnIqGHILTfQN@fedora>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZXmjdnIqGHILTfQN@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8eaf05-35e4-46e4-1616-08dbfc0de81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nJo/S4DuXkTeNOEzKT0ZmGUGFgUPxfv484iM2gzaz5c/3wvE659fbwI05XnGsDNB9ouVin9YLmbW1ijkE6q+rZNG4cIqgFAzRQ+0E3A5Ki4a5TOLW8Ge2yYDzBmj+0uUheXe8sgt/FNLSunnx43cSQipjaH54RDlG5v87PBdVOFBOyrLA/oD/2isDuyXi3uoHKr/G1ylkaRgWvyvIy4WPQo1vPZpD3Ih9WuK/jQ0ea7ev3X5x22WQW7SD3iOtndQhcnsXbS8CbIK4D8oinTijCI4KNpcjH/MomAF1zjXlldXDD6rBBC4UJZ1LJ2hqcKNOgR8blOxSmtiOkJy9aXA3XSJwTqFndexYS7tpnV6fWwLVTdAh8ic1Bh6hV/7XZt9stMwDe6O9LY1MF/wKYDni+rHZaEtU4PNjeSvuBHtGs12cMZv4FQAIbVd3n9v2FucYbhKPPPJBVVPTVKmCSMLGkd3hZIUwk7RnxUd6JAULTvm4ojPpsA8BxwcwuQoxD8xMOMyWXJjGRhfhBlnNohIqd6MpSQ8r2qJ1M64bkzg2Ye59A/3nnq3MiUtOa4GdcA/92YqNFK0dF2O2aTCDV/uKroUalfMw7G5fZuJlEJ+5PHUmr8PvbQyWegyhPkPs/Q5MZQZFOgyEEmGsA9zXwGRFw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(31686004)(478600001)(107886003)(6486002)(6666004)(2616005)(6512007)(26005)(36916002)(53546011)(6506007)(41300700001)(38100700002)(31696002)(86362001)(36756003)(5660300002)(6916009)(66476007)(66556008)(2906002)(83380400001)(7416002)(66946007)(8936002)(316002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHBiV29jdnVSWkxFQW1QYWwwQWxqcjhoZ1N5bXRkMW5YZ3BtQjF2YldEbll0?=
 =?utf-8?B?elA5eitjMXhvWDFDblZ4WGhkQWZkSW85dHg4SjExeVNHemdpMGRYUjNDbzNs?=
 =?utf-8?B?RFhreTRaWWh4UFJsWGw2c2RndU9sWmZRTEFxdEVDRitFSTNnZG1UTUh4eTNL?=
 =?utf-8?B?TjduQmEzZmVNemExWlhIU05MUmd5SXBjZVNDWThSVzBDRWlBc0oyWHNyT2xM?=
 =?utf-8?B?VC8rMGFpOVQ2T2h3VG9Pcml0azB0Ui96bTJjS1pEcEFTT3ZWdXI3b0U1eEhX?=
 =?utf-8?B?QTlIcjZvQ2FwQjhIcU5Ga0JYNHNmYnZkd0w2RkxRaVJkbjBxUFNaaWUxSENa?=
 =?utf-8?B?TVpSNWRiV1M2T3d0NWNxSUErWXdhcnl3RTJqcEF3UE5CSG5YRGRYUUJ3RDFl?=
 =?utf-8?B?emo3WXBDN3N3QkZpNkp3OVVsSUdVRmN2V0lnc3p6RWFLWTlyOFlJNEdMVkFO?=
 =?utf-8?B?K01OaFVXdTEwdStick9zYjdGMmVWeVFEanFBaGErQjAwSXNHSmhpT3NMcGo5?=
 =?utf-8?B?bWFWNkYyMHFmRHZUNTB4Tkp1OGxyQ2FORU5hMk4wZUVuK2ZSOUVxWGlsc3VK?=
 =?utf-8?B?amNaWW5mRFhNamtnbXAvVDVubndnYVFiLytjU0FCVkp1YjU5UnpoU2V4OEhj?=
 =?utf-8?B?dnFwSno5azk1ZjVRZ3pEMm1BREg1Vm4xMkhwa2dvQlFuY3ZkcHcxa1g1ZVVS?=
 =?utf-8?B?N0w4OUcxWFFOVzg2Q0VFd1lZWnJMYnhTMHdzRFgrTlVwRHJGQ1J3cjZXQk5C?=
 =?utf-8?B?dkNDVFZUM25xWVlFb3dxRDQvSU0rRkdXK3pncWZKRVRIclpRQ0pKS1JMUGFV?=
 =?utf-8?B?K2VUUXJCYUNRYzFXYldPNDJLQ0RXYTNLY0ZZTDBYdVg1cjBkMHVoUlNrK0pX?=
 =?utf-8?B?TlArZG8wQWIwb2gxaVVHR2U2SGNmTjMySU44TlJLZDdqRjl5Y3QzUXJFZVpr?=
 =?utf-8?B?YUtEUUQ4QUNvRFpMOXJMRWxYekgxSytkNzBsSWFUREMrZ2E5Zk9MMXgzZUNu?=
 =?utf-8?B?RHQva1VVOXBldytCYXpwNXVHMzVqWUhuYjdDb1FwbFBNdkVlUnVHTjVrYS85?=
 =?utf-8?B?SU1LM3RxTlVHMGgxaFprNXJLeGlzTUx3YVRwSFlqWGRFeU5vamhrQWdMNm1k?=
 =?utf-8?B?d0NVbVZtODRob3ZHOEwxaE9tczFBMXh0UmFuUGk4eEppUG9JZXdnS1VHN3Z3?=
 =?utf-8?B?RGc5S3ZJQ2NMRjV0bXF3SnhxUHdjazh5LytReUgzRmk3ZjBha1YyQ2c0clVX?=
 =?utf-8?B?S0RJTWk1T2NDeVlFeDFWTjNMK1RGdGNsUlJqbjcrNGVTNzByejNlOHpyWThs?=
 =?utf-8?B?OXBVVm9wZ2NxV2RDUkJYUGF5M3JEUnJaNlBBSHdIZDFkRFo0Zk9yVjlzZnJ6?=
 =?utf-8?B?TlBzcVV3cDBYM2R1a1VVQjNjVENhZnlXbWZvL2ZlRGYxcEpvNHo1bzJkb2NH?=
 =?utf-8?B?WU5CcTdnK2pwbG1sYzVVL1BnZDQ1TnNNdE5tN1F1RXV2dHBYVTVXSW9PMFV2?=
 =?utf-8?B?aTFqY3R1bHdzeHNJQUZWVkhNbmJiUHpYQzdIWWdZNzlrZm5HUmkyVHU3TlhF?=
 =?utf-8?B?cTBKUGZET1lTTVZQUTZPQ1A5MWExdUZIMGdvSzBQa1dCYm1iYi85dWdCTGZm?=
 =?utf-8?B?OUg3VWVhdlgwTTJqVVllcHo0bjdQTGx2b0RqaDhmQ1NQcnM4UVVrVnBLNXZq?=
 =?utf-8?B?UTlUb2dXd1lwMGhIc1JDL093T1dLS0NzWEN0T2hNcjRXM3o3Uk5QZEFQUWVQ?=
 =?utf-8?B?MXVuN3pNOFZkeE9UWllqNSt4RkxMS1lkMWx0dFczOS8xODVJcy9iRURYdGFI?=
 =?utf-8?B?Q0poNDYzT0liWVZ1bHdKczVGcklsbmxCeEs0dEVRZlY3WGZGUGFUc0JEVmx0?=
 =?utf-8?B?aUxCK3p4ZFQvb2Ezdlh0WEJZR2JUSzcvWUZSZzA5SWZNZW9FT1ZxdjU1MUJT?=
 =?utf-8?B?UUhTSmgzd0tseEdGTXhqeXBOYnJ4QWZOOEwzamdpSS85UGFKbnYxNjd2NWF5?=
 =?utf-8?B?eHMwTmlucDRxM09vRFF5MVllTUZOR1VEaCtuejM2SWluZzF2SFg3bGtsRkJt?=
 =?utf-8?B?RFlTeGJ1S3c5L2lpdHliWjBxMk1oSHJsdUhRZmN0aVYrWHByM0EvSDcwZmxr?=
 =?utf-8?Q?Kx3ofANZnBL71cgG3CkTIow+Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?Rm5YMFBYb1o2SGxEMGlJV1hYUC8ydGt0QThBejZmaHhPUEp0SlJZYU4zZ0o4?=
 =?utf-8?B?YjFURXIwZGhRTG43WndqNFJnd2ovQ3hVcjZJOHhWajhManFZUXFuYUhjY3Ey?=
 =?utf-8?B?aHc4SXR6TzZ6anZFaEtPdkx1N3hueHhzWThVYWhkMmxpT2JEVnp2SzhscWp1?=
 =?utf-8?B?eWtNVVZULzREUXJKVEFOdTBuWHoyNTFZblMrYWRlbEMxQXQ3eGN2bTZVT0ZM?=
 =?utf-8?B?WjhtTkVhSFNuaDJNOHF5M29EU09ZNnlBUThtcmYzU1RKSklnQnMxNGllQkNI?=
 =?utf-8?B?Wm5KMU5LdG9RNFNiWWg3WnRSWS9KRnVzYnJNRTRnN3JTZkNkZVYwZ0FVQ1dV?=
 =?utf-8?B?OWduYjVtOVkybE82Qks4eVBDT1dOMngzQlVmUUh0WWdwc2FBRWh4QU41MXVO?=
 =?utf-8?B?M1lxRmYza1luR2dhVlhtLy9lZjA1MTJLUTZJazIzOW1qUjF5SlA1U2Z3WGhx?=
 =?utf-8?B?WjJLVWtoQVNUZ25NWWl6SlBGdjBMaFRMUXFXM1ozREtZVTF1ME1UOGg2U0FY?=
 =?utf-8?B?eVhsWkdDcU9xUzRTdFNGdStydzR0V2l6QjFOZVJpREx4enJVUjBzZVFrcmRZ?=
 =?utf-8?B?UjB5MUtXSGNxU1ZHZ2F2M2hrY05FbXJ0OEt5QWtIdnlVbUlIUU1jSDBxSEo2?=
 =?utf-8?B?bzcrM2dxYW80a2lRajRaRjJoa1hSZzhFMk5DQ3JoOWd3WVBwMnAwSDR6Z1NY?=
 =?utf-8?B?RkIwK0YrdjV0T1ZXam11dTRkQ2IvVXZtUm43VHNXdVgyc0p3eGpmQzErNDk3?=
 =?utf-8?B?a21iVkhVVUNCRmdxT1EvZFplOVh4R1pVQ0RlaUNkNGFqWHRYL3hORW50anVi?=
 =?utf-8?B?QVZqckNES2NLNlptSnB4RTgyTUpIenVlS1JHdithTk1lWTJDbFVqUTgzelBI?=
 =?utf-8?B?NmtQeDBJT3FiMEpVZ0swN2ZoMzlNMkRYMHlqMzQzZWdSbm1ZWlZXZHVrV2s5?=
 =?utf-8?B?M2cxVEVYcGN6TkcyMnlHOXBvQTNwdjBTa2NnZVN6NlhTczFwcXE1bGxobkdP?=
 =?utf-8?B?U08zUGpiaTBIeDkweStzdUZCa3dEYWYxNVBTN1EwdkwvRC8rU0I4Tm5xWWZ1?=
 =?utf-8?B?bDdEVFZSUTdNaVhZelRhdDJmRDgwYzJlcnlsTWQzanU5UFBaVU1zWVI1WnJu?=
 =?utf-8?B?b01EVkZ1Y00xZVJrVHQ1MzhEVVQ0VFBNTHY5ZlRkak9ZSi9lUWg2UTRldGpu?=
 =?utf-8?B?NGVnNGFyTTZWOTZGMVFpc0tudk1zdWhyLzRWb0l1QTRnVHMxc3htTjFZYjRj?=
 =?utf-8?B?MldqVkU5aXlkZzF3aExvZ2VuUUw2aGhMYTVkamt2MHlySHk4VE1Obm1yNHZV?=
 =?utf-8?B?UWRjWnUrbkk3N3M0R3JKQjBPdnNoclJqWjQ2bnFQYkszR0FXc0JOVEVzWDVh?=
 =?utf-8?B?QmZ2MlltbjZUdTRzWHoxQTNoa0pPejY5OGhQdGd0RFpZbzFmRktYY01vNFg3?=
 =?utf-8?B?UDN6UTBZVC9KY25CK1paeWlZVDBmQkRBQzJYTjMvZFZITXQ2b1dDZmI4ODlF?=
 =?utf-8?Q?yXoOfL9l88eg4eVdGWMUpZfE1WP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8eaf05-35e4-46e4-1616-08dbfc0de81d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:01:26.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +R6nkktdHEi+ZXUYHGcmykUMBCzYowgBFZzTxRRp+OHcQBUSV9uC6QSFgUQgX/WvMdtIG8GPJniztbh3BpK2dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130136
X-Proofpoint-GUID: ZUuNZwbOs2fDkzcsXqOzPntt-P3QAoqD
X-Proofpoint-ORIG-GUID: ZUuNZwbOs2fDkzcsXqOzPntt-P3QAoqD

On 13/12/2023 12:28, Ming Lei wrote:
>> For NVMe, we use the logical block size. For physical block size, that can
>> be greater than the logical block size for npwg set, and I don't think it's
>> suitable use that as minimum atomic write unit.
> I highly suspect it is wrong to use logical block size as minimum
> support atomic write unit, given physical block size is supposed to
> be the minimum atomic write unit.

I would tend to agree, but I am still a bit curious on how npwg is used 
to calculate atomic_bs/phys_bs as it seems to be a recommended 
performance-related value. It would hint to me that it is the phys_bs, 
but is that same as atomic min granularity?

> 
>> Anyway, I am not too keen on sanitizing this value in this way.
>>
>>>> +
>>>> +/*
>>>> + * blk_queue_atomic_write_unit_max_sectors - largest unit that can be written
>>>> + * atomically to the device.
>>>> + * @q: the request queue for the device
>>>> + * @sectors: must be a power-of-two.
>>>> + */
>>>> +void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
>>>> +					     unsigned int sectors)
>>>> +{
>>>> +	struct queue_limits *limits = &q->limits;
>>>> +
>>>> +	limits->atomic_write_unit_max_sectors = sectors;
>>>> +}
>>>> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_max_sectors);
>>> atomic_write_unit_max_sectors should be >= atomic_write_unit_min_sectors.
>>>
>> Again, we rely on the driver to provide sound values. However, as mentioned,
>> we can sanitize.
> Relying on driver to provide sound value is absolutely bad design from API
> viewpoint.

OK, fine, I'll look to revise the API to make it more robust.

Thanks,
John

