Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE296F7E2F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 09:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjEEHyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 03:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjEEHyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 03:54:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230C81609F;
        Fri,  5 May 2023 00:54:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3456Xd6C015223;
        Fri, 5 May 2023 07:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5cCUQ0AxmnSL+2ttn4kIowKitwsufurp9SBQQtcoHhA=;
 b=ZOsJ8Tt7mqO4EeH8BHnNoomxDuN9z+oLKINZ0yU1blRGD4RB7LGY7W5XvYGOzAroFrLr
 N+/1XQoZsRYVQFw71OvjC7v8X0fag+IxdUmGcVWD2kxIX3swvuTKvDgLB5zI78hNz8ra
 GHR95N+c5kQcrLo/ixO4sruRRpLFsnbtz5vd5LCBMLWSGgUR/iobywYjWJu4005Fcuxn
 /M8q79aBX+vbQSFFM7ExSSeziyakiYXCHcAj7xCtekrcbEjISvZrlky63IfnCtyTuJEB
 eGQxSl4DzoP4D1wNPw9kWLBAi8Sj8zanIR73KVKO9Qci5pQMDkLStdRCw1h6Tt7rVQnS nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8snec2ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 07:54:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3457NmvG009896;
        Fri, 5 May 2023 07:54:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa2f59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 07:54:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giOgjt6vQK4StcRQ1sHPnK8N7XO4grlJ0ZdRffusunAjj30yVYk8ue75ovaOxpHSOKg/AK8l6d9p4R5kfr6cOvRA2C2g9rCpYB8MwC+84cJsAF1UEmVnqZkY/tpzSkqKr7MTFrpOPE05Wm9QMtMwZctmFhvRG3/AiCI/uHRrmpqF/ZWpAuXex8j59G53L9WkA5eq38ZuXA64T+vnsM4+MUXq3DeG95+6pn3ioIL13//Bax3sgFamFpafWjhFvrS+n1zSEnSRyZxFSJugruHiyqOr+cEUMhmRqbcmDli/2j2KdAGZysJb6O2DKKdxoszswbI08p3+PjkKbDtAj1I/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cCUQ0AxmnSL+2ttn4kIowKitwsufurp9SBQQtcoHhA=;
 b=diqUI1NrxuVK2zZwwFzat/uDq3kuACg9aTRdSZyPwYAw2tMdSMExvRGjt+Qe4xyC4QHb69dQ2y6231JncObHZzDtEVD8JXsn3EVlRTqRiL3V12/TCyaDABLg+2en479sdGJ+YiCuaGsrlZi1TrgljtgwCdQCIA/KLBeZp2reKVNA0fXsB3K3+OG+BMFCnBSLaoNAs9RT5Nct824i3ouUoIaPijaO/g86ywD5CoNzp7xk8GrZi7FMBBG+7vMbkMUwuZ/Qz6HTwS67CJo2rLLkzK/e510vucf8/lHdeKFIwqMBWLiUPFh4//CewKG293kuURX9Tb+K7XY1HHEpAK3itA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cCUQ0AxmnSL+2ttn4kIowKitwsufurp9SBQQtcoHhA=;
 b=HJCWTj3RBIwCpJJOEjcK7Yh1sGkdNXe1u7Ck4etCFjWtCKmWsPClpbG4w7Ce6xvM91xWFHbofScCv6Y0tXT3jXdvirxgm+K9DqnsDkxcJncqe/9JAr6oZG5IEN1eKfwBhh7sdYr9D5GGw3DOnxjGXguXfGNPbaW+nnzJYEjPZ6I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 07:54:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 07:54:17 +0000
Message-ID: <90522281-863f-58bf-9b26-675374c72cc7@oracle.com>
Date:   Fri, 5 May 2023 08:54:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
To:     Dave Chinner <david@fromorbit.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <20230503213925.GD3223426@dread.disaster.area>
 <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
 <20230504222623.GI3223426@dread.disaster.area>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230504222623.GI3223426@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ae6759-0ef9-4300-970b-08db4d3ded50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbpjKoKr+vRds0OSquDYvXRrbQfgG5yxdLrrGltHLVn3TRIUIMu7XfyTPzYGcAh8zhyt7FVN3Maen1RIl6fL1KMOVaRVuhPck5ijTg8Er6b120v/V/7Y4l417grOZ8XsSN5iIhNkxYheidSbs/Q2MLlgjKGe4S38poH3WqFlr+c98gNGmSyKDdd3+HiTkesiPlY0XEtptbS3ZqVqlxPj9zK6kQBu0GPvn9SN1Z7yv50AXAbr+J9oTVKqlBED328CYR9FTdCf4plB2tuTW09W1z5pCjOFV8hu1/FwU/pf4Y08fUD347PgIsXkT7WYAxSe54hVaojHYClbEJK2oyT93JZ0lagNE1OPF0AXwSuRFw04IBvpmmwIBhSPWRd+jzUBDhQbsrpXEWPUu0X4HjUCsVBeS2aE98fpvSmmCsjbrrt1Pxp/KRVoucheBZ59MCiLb0aD87mjKuGslMCFmRgft6Z4Cpv+2pFU5WGlnbVo0Stq7E3CG/p3AyAU+1KQlaKX+Tdw2PJjCV3sMUXsUudlnJkpk7NtSyDzMOKuTHtauR510kRvdmH6m2D4XEjZ+swK0nqSKu3sat+NOFiOi9zE7Xj6FDTniiERxZFpBrROFsJJBwCIIV1XyNsHm+/pOjlquCxV0C+cE69RSiV0XT5I0ObMyYH8FbM68au7K0ExP9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(36756003)(86362001)(31696002)(316002)(66946007)(66556008)(66476007)(6916009)(4326008)(36916002)(6486002)(478600001)(6666004)(8676002)(8936002)(5660300002)(30864003)(2906002)(7416002)(41300700001)(38100700002)(186003)(2616005)(107886003)(53546011)(6512007)(6506007)(26005)(83380400001)(66899021)(31686004)(60764002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzNHUG96bmkwUTNYWE14U2hZWGVsckR4dVN1OS9KUUJwSjh4SWtmaVNMR2I3?=
 =?utf-8?B?NWhVa3RKRDlKT0dUa0x5UzNaN3p4SThPbXFSWmhxQ1NGeEdEV3ZtdVFPUGVq?=
 =?utf-8?B?anlrdXpSOHNhZjJ6L3NYQS9PQVhMNXBQYVpsRm14eFRtZDlMei9KdmJoaytC?=
 =?utf-8?B?akNGc2VneXY1UkZHZ0d6c1VYVUxpdUUwTjFwb1VkK09FK0RvZVcxNENKTi9l?=
 =?utf-8?B?SE9HWjFHSEQzOGVRbmNBbkQrSzlibFd0clppN1h5K1FwMzlDaEtBdndTYkU2?=
 =?utf-8?B?VjVGWVAwR0VkUWoxM093TUlGQ0ZnRldqWFBjQmJoZ1E2Tmh6Q3ZENUo5WDNS?=
 =?utf-8?B?Y3llbURhRVBvOTFObDgraFdxKzlXQWxEWVFKS2ZRZEFOb2NaRFpuWngvZ2d6?=
 =?utf-8?B?cFF1WkhMbnRCNjV0T2FQYzQzQkhBbHZ1aGpjSFc2dFlXU3V5WmlzTENxWEJp?=
 =?utf-8?B?RGh5RW80YnBwVTlDTyt2ZHpvYjZPYWlPOXp3U21pdFc1SmZyZFQvdUtJVDY3?=
 =?utf-8?B?SkJnZk1CTFJYdW92R0Q4NlozQ2pWbkV5eVdiSnl4a2h2aDFqT2VxdmhhYjF1?=
 =?utf-8?B?UHRCOEVKUlM5TlBzQ2E5eFdUQTkwY3puWEhBSUhHL3BHRWRSK3c1SE1JT1NY?=
 =?utf-8?B?SGRkYndPUk5GK1dTRzN5UGZyRndyUE8xekJoOEZCMUpZdS9PNjJrZlRPaG5i?=
 =?utf-8?B?VnFyNStDNXVORCtPSkNCVkZNbWlycFpNeU1HTVlCOHJ2dzFuOUJUcnMyZzBw?=
 =?utf-8?B?cHFlejZZUzNyVk51YXQ5UjdoMDZ0TDRLenR3aHh6V1BwLytKU1BjYjcvMllR?=
 =?utf-8?B?bGQvVmQyQVdFa2o5RDU3R2RTWUI0alZNY0ptUC9SRHhVRTFycG81aXgzbFJY?=
 =?utf-8?B?Q1NuWURSQitIYlVBZ1J4WDVhSFJoZGpSbVVHS1BHbFBjbHMzRENQVDBtNHVF?=
 =?utf-8?B?ZDFDTTFENWxnVHBVdWE5aVdBS0JGczJLMFA0TGxWZ1pkM1ZMUlc5ZkJMbHBr?=
 =?utf-8?B?d25VZWlTV2tEcDdjYWkwNnozTVBCWDVvM24vcXpLSzdCd1J4RnR2dU4xN3E5?=
 =?utf-8?B?bmNpcUVyMy9SUGJ4eCttaTBlVHkrVHNiMTIwb2NFd3V6ZUg2Q3lXMEV5MFQ1?=
 =?utf-8?B?YitvT2lOZ1pFRnpNTUpHUTl1VUJiK3paNnBpRFhLQkFsOTBvRjFkOXJQNUh4?=
 =?utf-8?B?TXFxK3FnTlZJVmQ0bDArVE1UVERCVnVoSGFiOWF1RzQvYlJsSnlRUHM4WGY3?=
 =?utf-8?B?cE00WngvTUpiSFI4UENMTlNPWmhGWXVZVTBPcy9qWTZMb2RCRnVBZWVSeldD?=
 =?utf-8?B?N2Q5aUllMkxmUHcxeFBIckY2eW4vOFZlL0FRU2NFWUc3RUxRV1d6MlB2cWQ1?=
 =?utf-8?B?dDAwNTVuV25PMmU2SkNBQXRkV2R1dlBOWWxibVdzZ3lwUTJLbEk3MmNXWHAw?=
 =?utf-8?B?T1FRQlBnWjNQU0F3ZXJ0dzROb3cxWENRMzlXamdZazA3OE81dkhVc3ZDQkJj?=
 =?utf-8?B?dE9HN3FoT2UxTEdxZG5qNFVNMXFubHZ6OEZ4N1NUKzlqRkNyNnQ4SzBEemt5?=
 =?utf-8?B?dUpVZ3NSdzY2V1RpVmt0UEZLMitvWkdxK21ZRXAzTnZRQXZJRFpDekhxYVE4?=
 =?utf-8?B?Zlc1c241RUg1elVTZEZCL3laYW5ESXdKYi9ySmE0YWU2UHpxOUxVVk5NK2Zl?=
 =?utf-8?B?djkwbDlVRXR3RCt5by9OUkNWRU43TjVSU0tZbE5rVWZuTzdpQlZseHZOV0tI?=
 =?utf-8?B?S0toSHdmcXBIcGFmM2ZvVTZueldjR205TnhzanN6eUY3RnRObFk1c2w5V2la?=
 =?utf-8?B?SUkvVG56U2JTMWIyQk5IY1A2ZU9nN1E4WjIrSE5vMW1rblVVaksrbU82TEdQ?=
 =?utf-8?B?TXdtVW5YZHloRHRvbkYzYzNWbGs3eFdOWnBLQW9Gcnk1MTdUdkM5MG1jMmY1?=
 =?utf-8?B?cy83REh1dFZJSktuaU9uUVJoQ2xRQmNJZEc2S3U3NmdOOTZDSTY3UjNTQnlX?=
 =?utf-8?B?WjMvOVdTZG4zMzRQbytnMndwMFh1aWRWM3FmdVRabHBYdjczVVl3ek1oNnJi?=
 =?utf-8?B?c2JJSW5mVS9wRnVSM285T1U4cDNrc01pSVRrU2h1SXBZNzFFSjRoRDYvdkR5?=
 =?utf-8?Q?GufteyE83Cm2pINHKaxBC9y0r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MlhzSW15RGN3eVRod2JPU0pGN2lXT25md0hjampQQ0FUMmU3WXZXc2VOb3Qr?=
 =?utf-8?B?MkdZUzlUTHpHejRORzFkZWtrNmR6YmdhNzhqZ3VzcnNaS2ZMZlYyZmx3WXJL?=
 =?utf-8?B?UjE5MEdIc2dNT29vckMwSE1LT0pqRHVVQkdJL2krRER5cEswYzl4MHFid2Rx?=
 =?utf-8?B?Y0FFT2NKUXBGOE1uTDdwaXFPSEhlQUxYYjFxeW1TU2piZ1dhWTl2ZnNDVzl3?=
 =?utf-8?B?Y0RUeXZYQXVtSys2N2VhR3c0TDNRQnBFdDduVkF4ekJnVDNEeWRFdHA2RWRx?=
 =?utf-8?B?NUdKdWxtOS9FYkNPZHlFa2VoNmhCUkxuN1pYWC9lUjViOE5maEdydDVSQWoy?=
 =?utf-8?B?TTUySzZIZ2x4MWR1Y0xEZjYvQWd6Vkl2c2UzRWErVWQ1dS9FaXZ0TEpUaTRi?=
 =?utf-8?B?bkc5c2lzTFdWRFBTeTcyZ01vTEpVQjJyNTBpVXQ5YmFNalJhWXVSS25CcGZ6?=
 =?utf-8?B?dmxEMjVRNHpEZ3JId0czR1FGaTFFaTZCNFp1bHdabXZnMjRncFk2VnRQQzVl?=
 =?utf-8?B?WitRclExSGxuNDdHSzVnUWdocGpoSHphcEFwczlEKzZMbmdwUGpCeEIybGFk?=
 =?utf-8?B?VDV4aGtmbUVORGh2ejZtS3BvV3NJcXByeUJHMmJYRWs0c3d0VXFkNzFidXo3?=
 =?utf-8?B?YjVnN0sxLzBaVDNmYi9uSEI2UzhKWTRRQlBZT281citNKzhMd0V2QUpWeXNt?=
 =?utf-8?B?T01oZnBLM0dRSDFSNFF3STFTZEhXWG9wVWlqQmpkUmNuRjJjbFA3dlA1bUVB?=
 =?utf-8?B?bDlyUGpzMW1tSFNzSTZwVFB6TVhJSHVQUHlpZkMrY1dKWUFIbkRzak8wVVlN?=
 =?utf-8?B?Y0dlZEFvNUs5TkNaTUtmWG5ENG92b3k2R3M0L1paeFExUVR3WVB1RUMvV2Ri?=
 =?utf-8?B?NTBscmExNzdwRTVCc256RWszaVppYWlvaC9oK1NOWTN2WDZzUHd0d3kyN3VD?=
 =?utf-8?B?akVOZ0FScnJzZGFiZ1J2UnhuWE45ME9aeE92VUdyQ0ovSncrVWVHK0U2WTVK?=
 =?utf-8?B?amljdGFLVjNXT2RrWEZ1R3RyODlQWDVZUFU1M3hyMWs3QXFjWGNlVlVjT3VO?=
 =?utf-8?B?cE5Fdmg5b1lNQ1ptM1hDV0xlYjc4Zm90Skc2a1VqSS8rTkhSR2VIdDJ1TjVx?=
 =?utf-8?B?QTVWSVpaZDVjVkUvOXlqNU9HYkRMUUNJQkFCUXc4cndiZmJyd2FtcUdOSlRH?=
 =?utf-8?B?OEI1RUUxSjVTSUUzajZnc0JuY1IwbGo4emoxVHhRaXFjcWtqbTVDbGwwejll?=
 =?utf-8?B?S0Y1R1REM0tncEREMlg2NjNsekVpdVd3ZWdEb2dLbno1eWhQb0hTTVVhQmd3?=
 =?utf-8?B?Nis2SUVCSytXQXNSeXZhUHZYNStRY2tGMjJFOUoxdkJJNHpRSXp6SDJ0YWhv?=
 =?utf-8?B?RlRCeW0vNjRLMGdjY3NsWENOZGRWVEpUOEV1cUgwUjFmYThrK000Z3h5dG5m?=
 =?utf-8?B?em5nM3g3RWhWMnpJcUV5OVlkdkkvS3k4dkFnNVVIQkVxRnhBRE9oL0Mxcmxs?=
 =?utf-8?B?UmVCR3ZPcHJydk04REVJVElEbTNSK2dhNXFBbXVndWRTZ3FWNGRTMUFRaS9Z?=
 =?utf-8?Q?UoM7ZqH4v9Alne5lfGl9bHESU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ae6759-0ef9-4300-970b-08db4d3ded50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 07:54:17.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfjdoDrCShPox8VP8B/8p7fYDfAB9tbk4ByOdXTat4cmK9OYWHLItVzDmjn/xb2b82NsTathMglkqG5luCmT4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050068
X-Proofpoint-GUID: zIN0lFvD3YecHIbRaaqqgpYAE1qy9IrB
X-Proofpoint-ORIG-GUID: zIN0lFvD3YecHIbRaaqqgpYAE1qy9IrB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/05/2023 23:26, Dave Chinner wrote:

Hi Dave,

>> atomic_write_unit_max is largest application block size which we can
>> support, while atomic_write_max_bytes is the max size of an atomic operation
>> which the HW supports.
> Why are these different? If the hardware supports 128kB atomic
> writes, why limit applications to something smaller?

Two reasons:
a. If you see patch 6/16, we need to apply a limit on 
atomic_write_unit_max from what is guaranteed we can fit in a bio 
without it being required to be split when submitted.

Consider iomap generates an atomic write bio for a single userspace 
block and submits to the block layer - if the block layer needs to split 
due to block driver request_queue limits, like max_segments, then we're 
in trouble. So we need to limit atomic_write_unit_max such that this 
will not occur. That same limit should not apply to atomic_write_max_bytes.

b. For NVMe, atomic_write_unit_max and atomic_write_max_bytes which the 
host reports will be the same (ignoring a.).

However for SCSI they may be different. SCSI has its own concept of 
boundary and it is relevant here. This is confusing as it is very 
different from NVMe boundary. NVMe is a media boundary really. For SCSI, 
a boundary is a sub-segment which the device may split an atomic write 
operation. For a SCSI device which only supports this boundary mode of 
operation, we limit atomic_write_unit_max to the max boundary segment 
size (such that we don't get splitting of an atomic write by the device) 
and then limit atomic_write_max_bytes to what is known in the spec as 
"maximum atomic transfer length with boundary". So in this device mode 
of operation, atomic_write_max_bytes and atomic_write_unit_max should be 
different.

> 
>>  From your review on the iomap patch, I assume that now you realise that we
>> are proposing a write which may include multiple application data blocks
>> (each limited in size to atomic_write_unit_max), and the limit in total size
>> of that write is atomic_write_max_bytes.
> I still don't get it - you haven't explained why/what an application
> atomic block write might be, nor why the block device should be
> determining the size of application data blocks, etc.  If the block
> device can do 128kB atomic writes, why wouldn't the device allow the
> application to do 128kB atomic writes if they've aligned the atomic
> write correctly?

An application block needs to be:
- sized at a power-of-two
- sized between atomic_write_unit_min and atomic_write_unit_max, inclusive
- naturally aligned

Please consider that the application does not explicitly tell the kernel 
the size of its data blocks, it's implied from the size of the write and 
file offset. So, assuming that userspace follows the rules properly when 
issuing a write, the kernel may deduce the application block size and 
ensure only that each individual user data block is not split.

If userspace wants a guarantee of no splitting of all in its write, then 
it may issue a write for a single userspace data block, e.g. userspace 
block size is 16KB, then write at a file offset aligned to 16KB and a 
total write size of 16KB will be guaranteed to be written atomically by 
the device.

> 
> What happens we we get hardware that can do atomic writes at any
> alignment, of any size up to atomic_write_max_bytes? Because this
> interface defines atomic writes as "must be a multiple of 2 of
> atomic_write_unit_min" then hardware that can do atomic writes of
> any size can not be effectively utilised by this interface....
> 
>> user applications should only pay attention to what we return from statx,
>> that being atomic_write_unit_min and atomic_write_unit_max.
>>
>> atomic_write_max_bytes and atomic_write_boundary is only relevant to the
>> block layer.
> If applications can issue an multi-atomic_write_unit_max-block
> writes as a single, non-atomic, multi-bio RWF_ATOMIC pwritev2() IO
> and such IO is constrainted to atomic_write_max_bytes, then
> atomic_write_max_bytes is most definitely relevant to user
> applications.

But we still do not guarantee that multi-atomic_write_unit_max-block 
writes as a single, non-atomic, multi-bio RWF_ATOMIC pwritev2() IO and 
such IO is constrained to atomic_write_max_bytes will be written 
atomically by the device.

Three things may happen in the kernel:
- we may need to split due to atomic boundary
- we may need to split due to the write spanning discontig extents
- atomic_write_max_bytes may be much larger than what we could fit in a 
bio, so may need multiple bios

And maybe more which does not come to mind.

So I am not sure what value there is in reporting atomic_write_max_bytes 
to the user. The description would need to be something like "we 
guarantee that if the total write length is greater than 
atomic_write_max_bytes, then all data will never be submitted to the 
device atomically. Otherwise it might be".

> 
> 
>>>> +What:		/sys/block/<disk>/atomic_write_boundary
>>>> +Date:		May 2023
>>>> +Contact:	Himanshu Madhani<himanshu.madhani@oracle.com>
>>>> +Description:
>>>> +		[RO] A device may need to internally split I/Os which
>>>> +		straddle a given logical block address boundary. In that
>>>> +		case a single atomic write operation will be processed as
>>>> +		one of more sub-operations which each complete atomically.
>>>> +		This parameter specifies the size in bytes of the atomic
>>>> +		boundary if one is reported by the device. This value must
>>>> +		be a power-of-two.
>>> How are users/filesystems supposed to use this?
>> As above, this is not relevant to the user.
> Applications will greatly care if their atomic IO gets split into
> multiple IOs whose persistence order is undefined.

Sure, so maybe then we need to define and support persistence ordering 
rules. But still, any atomic_write_boundary is already taken into 
account when we report atomic_write_unit_min and atomic_write_unit_max 
to the user.

> I think it also
> matters for filesystems when it comes to allocation, because we are
> going to have to be very careful not to have extents straddle ranges
> that will cause an atomic write to be split.

Note that block drivers need to ensure that they report the following:
- atomic_write_unit_max is a power-of-2
- atomic_write_boundary is a power-of-2 (and naturally it would need to 
be greater or equal to atomic_write_unit_max)
[sidenote: I actually think that atomic_write_boundary needs to be just 
a multiple of atomic_write_unit_max, but let's stick with these rules 
for the moment]

As such, if we split a write due to a boundary, we would still always be 
able to split such that we don't need to split an individual userspace 
data block.

> 
> e.g. how does this work with striped devices? e.g. we have a stripe
> unit of 16kB, but the devices support atomic_write_unit_max = 32kB.
> Instantly, we have a configuration where atomic writes need to be
> split at 16kB boundaries, and so the maximum atomic write size that
> can be supported is actually 16kB - the stripe unit of RAID device.

OK, so in that case, I think that we would need to limit the reported 
atomic_write_unit_max value to the stripe value in a RAID config.

> 
> This means the filesystem must, at minimum, align all allocations
> for atomic IO to 16kB stripe unit alignment, and must not allow
> atomic IOs that are not stripe unit aligned or sized to proceed
> because they can't be processed as an atomic IO....

As above. Martin may be able to comment more on this.

> 
> 
>>>>    /**
>>>> @@ -183,6 +186,59 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>>>>    }
>>>>    EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>>>> +/**
>>>> + * blk_queue_atomic_write_max_bytes - set max bytes supported by
>>>> + * the device for atomic write operations.
>>>> + * @q:  the request queue for the device
>>>> + * @size: maximum bytes supported
>>>> + */
>>>> +void blk_queue_atomic_write_max_bytes(struct request_queue *q,
>>>> +				      unsigned int size)
>>>> +{
>>>> +	q->limits.atomic_write_max_bytes = size;
>>>> +}
>>>> +EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);
>>>> +
>>>> +/**
>>>> + * blk_queue_atomic_write_boundary - Device's logical block address space
>>>> + * which an atomic write should not cross.
>>> I have no idea what "logical block address space which an atomic
>>> write should not cross" means, especially as the unit is in bytes
>>> and not in sectors (which are the units LBAs are expressed in).
>> It means that an atomic operation which straddles the atomic boundary is not
>> guaranteed to be atomic by the device, so we should (must) not cross it to
>> maintain atomic behaviour for an application block. That's one reason that
>> we have all these size and alignment rules.
> Yes, That much is obvious. What I have no idea diea about is what
> this means in practice. When is this ever going to be non-zero, and
> what should be we doing at the filesystem allocation level when it
> is non-zero to ensure that allocations for atomic writes never cross
> such a boundary. i.e. how do we prevent applications from ever
> needing this functionality to be triggered? i.e. so the filesystem
> can guarantee a single RWF_ATOMIC user IO is actually dispatched
> as a single REQ_ATOMIC IO....

We only guarantee that a single user data block will not be split. So to 
avoid any splitting at all, all you can do is write a single user data 
block. That's the best which we can offer.

As mentioned earlier, atomic boundary is only relevant to NVMe. If the 
device does not support an atomic boundary which is not compliant with 
the rules, then we cannot support atomic writes for that device.

> 
>> ...
>>
>>>> +static inline unsigned int queue_atomic_write_unit_max(const struct request_queue *q)
>>>> +{
>>>> +	return q->limits.atomic_write_unit_max << SECTOR_SHIFT;
>>>> +}
>>>> +
>>>> +static inline unsigned int queue_atomic_write_unit_min(const struct request_queue *q)
>>>> +{
>>>> +	return q->limits.atomic_write_unit_min << SECTOR_SHIFT;
>>>> +}
>>> Ah, what? This undocumented interface reports "unit limits" in
>>> bytes, but it's not using the physical device sector size to convert
>>> between sector units and bytes. This really needs some more
>>> documentation and work to make it present all units consistently and
>>> not result in confusion when devices have 4kB sector sizes and not
>>> 512 byte sectors...
>> ok, we'll look to fix this up to give a coherent and clear interface.
>>
>>> Also, I think all the byte ranges should support full 64 bit values,
>>> otherwise there will be silent overflows in converting 32 bit sector
>>> counts to byte ranges. And, eventually, something will want to do
>>> larger than 4GB atomic IOs
>>>
>> ok, we can do that but would also then make statx field 64b. I'm fine with
>> that if it is wise to do so - I don't don't want to wastefully use up an
>> extra 2 x 32b in struct statx.
> Why do we need specific varibles for DIO atomic write alignment
> limits?

I guess that we don't

> We already have direct IO alignment and size constraints in statx(),
> so why wouldn't we just reuse those variables when the user requests
> atomic limits for DIO?
> 
> i.e. if STATX_DIOALIGN is set, we return normal DIO alignment
> constraints. If STATX_DIOALIGN_ATOMIC is set, we return the atomic
> DIO alignment requirements in those variables.....
> 
> Yes, we probably need the dio max size to be added to statx for
> this. Historically speaking, I wanted statx to support this in the
> first place because that's what we were already giving userspace
> with XFS_IOC_DIOINFO and we already knew that atomic IO when it came
> along would require a bound maximum IO size much smaller than normal
> DIO limits.  i.e.:
> 
> struct dioattr {
>          __u32           d_mem;          /* data buffer memory alignment */
>          __u32           d_miniosz;      /* min xfer size                */
>          __u32           d_maxiosz;      /* max xfer size                */
> };
> 
> where d_miniosz defined the alignment and size constraints for DIOs.
> 
> If we simply document that STATX_DIOALIGN_ATOMIC returns minimum
> (unit) atomic IO size and alignment in statx->dio_offset_align (as
> per STATX_DIOALIGN) and the maximum atomic IO size in
> statx->dio_max_iosize, then we don't burn up anywhere near as much
> space in the statx structure....

ok, so you are saying to unionize them, right? That would seem 
reasonable to me.

Thanks,
John

