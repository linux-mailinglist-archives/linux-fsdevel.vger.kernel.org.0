Return-Path: <linux-fsdevel+bounces-4799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC52804012
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 21:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39691281382
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA1935EF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jkc7OMWF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0EGIrwfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060AED5;
	Mon,  4 Dec 2023 10:42:23 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4IWRqM015704;
	Mon, 4 Dec 2023 18:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8zXIFoIb9aKaGRDMa7uSm+8LB5pCI/4XJ09ktQ9ki4A=;
 b=jkc7OMWFFULfzy6Bl9Jn+D5zjL6kTm4Lpr393Z9Qo0S7Xf1fGMUZFFs8QEXDtGVAvZOG
 HLxsCxt4VSBwwy/C7RAGgk1f6bcYbvnByPlFiDwYUeRaZoHigNuxEcQAv4tkFZlCN9iA
 3iaD/+1zNybS2kjKkfc79N9hsfNWjDz3doIRRyN/97zfSIBTvLmPuwn3JLTIMdM1N+r5
 YTw1q7WzHRxNMpj/CiIB+fcO2GIe9jDvyQ27mh//dlyyU3fobwAJ3ZRUVNXGbQUrbqoN
 zmrnKvx/r43b96QS8GQcGWDihP6bbzotXplRRsjHJzRUA9pvMIlDQ2WYztbhAPcXokco eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usm4p00rr-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 18:42:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4I2b6u023362;
	Mon, 4 Dec 2023 18:34:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu1cpdb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 18:34:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNcX7JINhuNe2kjvizHiCTX8KvFGw2ejix0b5Rx3r8XM5rL2r5N6jwK7DQROsqLroz8bumN4CGBh39y+JBNMBJQuR0aCynesjU0uBo3jcpiiVZIVJ3BLgfCgzYbwgJ5lhfTi6PDQH7g/XzBP6pGQcFIwPRX8cVDwRM1wQu3xV1vTnwK3iPuYDQiXVGSeH8O8fYtIpw//GSOtQvcxpHcGzQU95uP2dRV1G6HPa6HNw7wWd23iK1tkixS/334sotps5dRQPzZTWXE5t4R5ZykbnuU5EJWppKtl3fqzvz/8JvrGMG9vT9JYHMihM6CgJfevVDbQ5zVTr324aspd0rqbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zXIFoIb9aKaGRDMa7uSm+8LB5pCI/4XJ09ktQ9ki4A=;
 b=aooX52p3vJZHanq7h3HdE9fEXeHM35NgQE9i3x9XHV+u1IKYS7lxik1bGafNjdLu+MFNm/82Z7Yr167UG+VvbRGei4L7UluWAvLtQWEOuKkfKcfuIvWCSge24ZFNpwBika5s0WvMXw1UVQ9LHBUO8y3/kukap5snhW1d4AusiGo4aKsMi4OuThlvU/BxeYH8UeB0O52ZxLTWQC9oM/wGqNucKI6++5D50i1jJp8qlv6+1+vUs+LJy2XxmQ7B5WAmgOnDwfyYUt5RzYjS/57M4W7ODSq/qNUwxznk0DuuwkZax+7st16oUU2OiDHPGS8WTh5zcjSTVVlwxRK8eH3/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zXIFoIb9aKaGRDMa7uSm+8LB5pCI/4XJ09ktQ9ki4A=;
 b=0EGIrwfxWdaahl9R2pzqMVa/LzBPaBD89M06PVq0d6yeGpYMOvRN2R8pPcls0+o12zzDQ7vITIdkoGsb3TINDy8qt9+CPd0+7aJJtrBS8qOhdp4rlG8rui8wbhp/Wja5wyUEmdSOe3GsR1mqH359mGDs8e0c6drp+MxjHXwlncM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Mon, 4 Dec
 2023 18:34:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 18:34:15 +0000
Message-ID: <e40b27c4-137b-4e3a-a800-d2f3027a44ca@oracle.com>
Date: Mon, 4 Dec 2023 18:34:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/7] iomap: Don't fall back to buffered write if the write
 is atomic
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Ojaswin Mujoo
 <ojaswin@linux.ibm.com>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
 <ZWj6Tt1zKUL4WPGr@dread.disaster.area>
 <85d1b27c-f4ef-43dd-8eed-f497817ab86d@oracle.com>
 <ZWpZJicSjW2XqMmp@dread.disaster.area>
 <2aced048-4d4b-4a48-9a45-049f73763697@oracle.com>
 <20231204181723.GW361584@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231204181723.GW361584@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0050.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1cddfa-2b62-4a77-f39a-08dbf4f79e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ju8TdrWJkwoohvApYdDNgqJYvmOlvld94co1VkE+xTbqV96vRT9KXRYPHUtggnPKubZS7nDU29rrR0HAchUJtYwuKn8uL/OiaX5wE2W2oCodOXNsRP76Bw4aNa0yDRupjaJmJJTohhgpMKrHOb6cp36HoyRwY1m6uK+4/AOXars+6kE7jqMlUBYNx4ebhuEepfM2H8vFOZ/BXW7c9FcbVt9X7eZA7C3vC00YUPWpVFUCz1p6iMqcZ1VFZ1JLW5C+SwR4x/D3RpL8ivKbEAZnoMy8TgOmZ1rp+I5N+rwILltRYydFGx10wL54ogYs15xtosMRlBmHbJnYr7iJamS0coHiwM6vNORF3DppZq+0Vjcmu/yhn7hDvHzkNJr/gtxp/jSKpw5lsma5sBR/i0kO1OESoICS/WiVsia6UcxUhlBJIeV6f6wYTUO8k9DCZSv5zoUAM1RD+WmYFY2rgUq7bkOr4JTjKL0y4esTphOJLMQYrekx7im+ksiwUxfGhsHVlJ1g/9mfPTbMa8hKM0h4jIMTY3+gByTuuqFrOQDCzMR4XObZ1LZf9UVlPTnTKcL++ZsO0cGMYR/cUZLEIrDNtDdNZULuhBg07eJuyAl3WrJKqoezMQzlpqc/u1AkU0+zrU793F/sZaVLMm7BSUpyAA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6486002)(26005)(478600001)(36916002)(6666004)(6506007)(6512007)(53546011)(36756003)(2616005)(316002)(66946007)(6916009)(66476007)(54906003)(66556008)(31686004)(38100700002)(5660300002)(4326008)(86362001)(7416002)(8936002)(8676002)(2906002)(4744005)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SXZnVG5iUG5PVWNPTGtuVnVxL2ZKWktMRnM3K0o3WmtieDRzeWRRTEo2eTd1?=
 =?utf-8?B?YlFRUHBhSUZBcUtxTkxDQVpydDhmY0IvWlIxUTA0Y1JwZmYvU3FaYm1OakNt?=
 =?utf-8?B?SG85L2xEN0owOG9QcUJScGRqZ2tNbE9ZVzZOZFl2MW1ROGxZOGtUZ2Vlc0py?=
 =?utf-8?B?dm1MTFN6M2NyU293Zit5c2lOa1pWTHNmcnN2Vlo3dCtSNnpmVlV6dzJhWjc2?=
 =?utf-8?B?OFVRNTlnRnVteDBCVWkyKytRUXQwUWU4eWwxemo4YzNFdmdrVERBNTBFZktw?=
 =?utf-8?B?Ukh5aW10SUg2Z3JDWlgxOXhpU1Y5TWhUenR5K2dPdjFaYURuUFhMQUlKdjV2?=
 =?utf-8?B?dzZSVklOZTJxVWIxdkVQd21nSWtDRmg2TDZadVdXeEd5VXJMeERQUHIvOWE5?=
 =?utf-8?B?cUY3UmRXK2UzUk1pc0YweU5YOHJhNjFDeUN1bldCaXJWZWI5MThBc2cya2ov?=
 =?utf-8?B?a0o1S3FGR25oekp6blduM0VEWXYwMktyeVIwYlV4YkZ0dUYxMC91MW1LQzhS?=
 =?utf-8?B?WWg1amFwQ0lpRWxoeklBQ0ZkcW9WODQxUmRleUZ3UXNzSTlIcVlvWDJvL1hE?=
 =?utf-8?B?SDEwYy9qOUVHNnk3d0g5NVloZ0xUSm9qWTFXNHZRVmYzSjJ4a0hYVGszVWdP?=
 =?utf-8?B?ZVFYZDV1ZElKQzhxNkFxdVBvZTg2Wkp4ME92R3NCSk5uTXBaYzdHdEEvWHha?=
 =?utf-8?B?aU9UcGgyZitEUFZ4d3JiNUJmb2NkMDF5NTRpUkZ0dU5hUnFxcWR0aEpWQzZr?=
 =?utf-8?B?QjRKOE5aczVheUxyNVhoK21RY2gwOExBTjBSUXFSSkl1ZGtQdGNjanVCaXVx?=
 =?utf-8?B?NGhzMzk5NlhjWkVnT0s4QnRmdzJuZjRMQ1BOczZrUEdsWURSV0VMVmpRMlYz?=
 =?utf-8?B?TUIySEFaaXA1YXNndXNUWXQ4Z1hoTlR3OHkyUlNjUW9tMlE0RG9UWWE3Sjdz?=
 =?utf-8?B?eUJ5WVJSOXIwaDNGR2ZqWStyVHJIMkFQWUV3MFZxdUNleFpqU1h1alRuNWlJ?=
 =?utf-8?B?dEl2eE5OUG5KaFF5ZmY1R1hrcFhXMFppT2dZSFVXQnlkNUdzQmIzNlNzeGY1?=
 =?utf-8?B?NXNnanNjVzQvbkZkTW9YVFpJVU1EMytvb3JGaDdGVkxqR2lSOGoyTzZIaTRm?=
 =?utf-8?B?ZGN1Y0o4WXczTUpGbTd2ZVNRVEJmWHJ2YXhvTHJrYmY3eEVxUlZjb3R6cWNv?=
 =?utf-8?B?aE9UZ28rL0luQ1JKQXRCYkpoaE5SbjV3Z1kzT3YxRWpvbklkem04bFh6eDF5?=
 =?utf-8?B?VlJIMFBKYTE3b2ZSTzNSOXFxVWdZMlAzeVNTYjJ6MjdpRHlmZ0JxUk1NL01R?=
 =?utf-8?B?WFpjV0k4a2lzM0hZRHUybk5QeGhrUEJMRUIxY0Zma1ZUUktpMjRsSElHd3Yw?=
 =?utf-8?B?N2JTZUdBZTljM1QzOVRRL0VkRGgzYnRlcFBwdVVacHVzWjRRaDZlWUpQOWpQ?=
 =?utf-8?B?WlYyVHF6Nm1WZXA1U3ZHTjhLSGR0bTN0RzRIbXdzcEg5NTFHTEZqa2dBLzhp?=
 =?utf-8?B?QlpMWURtL0JORTBQWmd0VHFmT08yUlJiNGZxckJ0eWVoRVJ0QzJsQ3pWNERD?=
 =?utf-8?B?aDIvQ2x3NTlPb25aVCtXeElTOVZwMWFiWkRJOHJ3aHhDSWNTQUFEMTVWdnNZ?=
 =?utf-8?B?U1d0ancwZ2o5b0E0Y01ENGpnMmlsV051SU9Ub05Sb2xHUjZMOThYQkpSZFZC?=
 =?utf-8?B?eXB2SXVPNTdCZmxHSlVqRjQ2TjlHSE1hY29MeFNwZUdpdGtkRmlHZkJ3VjdI?=
 =?utf-8?B?NSsvZDFsUndTbDhlWXd5SzByVUpVVGdTN2dxYkdnTWRzU1BHU014ZTR6YW1R?=
 =?utf-8?B?YjF4enBMQTZWQmVjZC9xdGRlc2EvQlY3eFN2c2MxL1JYeEIyRWczTGVoanNH?=
 =?utf-8?B?M0N1NGVldkl1V3VTZnpCNUR4ajg1ckhkb2YxQlpLbFZZS05CNDlhaEFZMU9n?=
 =?utf-8?B?QjYwVi9rQTVOVTBRa0IxZ3dwQW84bUFKY2x3cXg1SW1CejFuRFpRTmZCMkx3?=
 =?utf-8?B?clR2K2laRHNVVUNpd3F1Z0xReDBZazBDZU1DQXkwcmcxWkl1cmo0N1pHYXBN?=
 =?utf-8?B?YXpGZ0lvM3BpRDBWOFd3VDhjeWs3bEZ6N21zVjBkVnloMmRzQU9sMmNxTTN3?=
 =?utf-8?B?d1EzU3BoUU5KeGU5MExTQlcyZ2FpL0l4Z3RSM2VRTE9kczlqMEFEeFBoR2M2?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?SU05ZWFCZ1pPaE5JSWh5blByOG9rYVpRL2E0VEVoZzNsUW5lajhQV2RXTTNQ?=
 =?utf-8?B?bHh0QWtmVnRQL09wNkxwcitKajRvUTdSQXZmZktaY3B3QzcxaGtwQnlEUk5S?=
 =?utf-8?B?cHJxWjRFTU9pUDVnQ0Q4SzRWZjNLR1kyZUNtdTRTTjV2d2NvNzUxd2FNTFFJ?=
 =?utf-8?B?OFdlY0V0bTlGakp2MUFFY0QrbUcyWHdkT1p2R0VqUjRKUjlKN243YnZrd0hy?=
 =?utf-8?B?QXg4S1FzTStYWXhyeGZIaUh4b0JrL2twWGVkY2ZLREZYOEMyNGtrNmNmaU5o?=
 =?utf-8?B?QnNieHdXWmsrc011dkxoREJQQ0dVRjJzUEZIdU0yN2RtWlNqbTBhLzkweCsr?=
 =?utf-8?B?NTc2YWUzcnordGhEaUJjQkhxcng4bTZwdkhsVW9LWWIwcXl5RnF3TndRQ3A0?=
 =?utf-8?B?SGFHRWhJYUxYbHpjQkVpbWNRNExHaElBUnpsUzgzZ28wNm04RmFMaGdkYlZT?=
 =?utf-8?B?aldwK2ZWRERPQUVnVERpdGt1Q2FoWUIySDlTRElYUHNzRFE1SWNaYmYrY1J6?=
 =?utf-8?B?eWRCYUVqQ0FZKzllTzU3WFNacUpGQ3BvQUxscTBEbHZtWWpyVmxqOHVKQUFi?=
 =?utf-8?B?cE53a2drVklJdmFBR3QveDJ4Z3k2VkRhdlVrRUJCT3BXZGY0bG1hSDZQcnlZ?=
 =?utf-8?B?NXFVMGVRajV2blJqV3R4T05CMlM0RnpQUy9kMVl2MU9xTmZkTXh3R3lSOFBV?=
 =?utf-8?B?ZlB1WmVTazF6QU1ZbkFoU0M2Tm1TL3MvNzN4VjBmS3NhZnFTMzdyQStpeGZC?=
 =?utf-8?B?REV0MDl0TWQ1RG1UR0xIOU0zNFFVejEvYmU0NnRNUGxiNXlYWHk2WkpOT0M3?=
 =?utf-8?B?SVYyM3poODlmSmNwaEhFa05oR3lqMnc4MnNuaTc3a2xGWk5YclVDUGdzUTNV?=
 =?utf-8?B?Y0dIL0V5Q3c4T2x1anRLTGpIbzRENnlsQmNMa0ZJRDZDMDNMK3Q1YVY5Qk5Z?=
 =?utf-8?B?SFM5dkoxTkttT09GSHgvSEVpVHFGQjczWnc2TlhVMzV2SHN4a05zNkduTTVT?=
 =?utf-8?B?RXFNKzFGT21ISmpsWnNZRkdoaEpJdzlJRUF6cDRObVhBQ0lLN3cwK2F2c3Vn?=
 =?utf-8?B?VCtDU2JhcXFWLzhRZ3pNYWY4V1hDK1FWN1UrdG5RWjZXRDdDOXBycXlSZmkv?=
 =?utf-8?B?ZG85d2FncFBUbm9pcWovYUFaTEJmUmp5aGUwYUtPTndqQm0vRlBnd1RCVnhq?=
 =?utf-8?B?Ykx3SnNXQXhhM3pWR0NRR3M1L25jZllyWjNlZkRDRytJbXNrbEdrUXF6Uno2?=
 =?utf-8?Q?Jddj0pDN6/ODxk0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1cddfa-2b62-4a77-f39a-08dbf4f79e24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 18:34:15.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wiBgK6qBXmh17H1cjib3SUNx+24JJuDJlJ2LKCL4G8lLZhXjDuYylZtt5gZiK3trcq914JEizEQFyE7LuxugQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=896
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040143
X-Proofpoint-GUID: KjTKCRegjQsHXBPmHm89K6cmKviJL0ve
X-Proofpoint-ORIG-GUID: KjTKCRegjQsHXBPmHm89K6cmKviJL0ve

On 04/12/2023 18:17, Darrick J. Wong wrote:
>> If we could just run statx on a file descriptor here then that would be
>> simpler...
> statx(fd, "", AT_EMPTY_PATH, ...); ?

I really meant that if we could only run statx on a fd then we could 
know if we want DIO or buffered IO (as that is how it was opened).

Thanks,
John



