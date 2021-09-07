Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC038402FCE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 22:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbhIGUgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 16:36:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13024 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346228AbhIGUg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:36:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187HjmdR022737;
        Tue, 7 Sep 2021 20:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EEJlkphaXiiyEkJ/y7k4XLhD3W6SL5K70vRY6oaA6Mg=;
 b=FychotdAOR9/4H9Bo5R4hV7ak75vYZ7lDOlnQIpqzVzo2XsbDMUf8+lfnsfKwjtSGm+i
 8SKZyjl2VWgw1RDE45W/tzB2vNFmHiNnkAZY0KxAW5RSxSkUoM9GfHUFULEt0jNSIFeo
 4Ze57yLsUeuYwliiV2jBodsV1pAsFkBJrCcabkC3EwueO+PpYBr34rmGEBPURFrEXI19
 MNTRce/LYCp7ZLECktum/sxqO11av6yj8iuJWG6eHLGeZAzWQGaZ7Z4Iz4dDH3+NYAEc
 b9zqFShJ7qsOqXOnS6ZEMGUD8J63E4qPjMaFj1qBqserFurEqPa7Ra+1jXcr6YLsG6wi zg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EEJlkphaXiiyEkJ/y7k4XLhD3W6SL5K70vRY6oaA6Mg=;
 b=HhLb1RAVTbx5M4qXjEnvA5foWQjBb7jTvSj/O1FOukATjsN2jERclGh3jwHeQ5YBRWbw
 RAfQv6PbTAM72OrcR70WFhGVYDMOJfQhCxIl+SCqKRW+y04ao0CLY3Qe2ya4JkRcSXht
 3Jjlaq24Pn5DlQwMNnbMKAg9nEQ/t/DD9usF3QJiWNP/rnemQ0NeAKyyDAbIxF7qBkoN
 oP5D8xKEGXL5mpNDkfyDqDpQH11890WvZK4s2LE13vDI7BUrx6ojF3FFI+mYugUJIJAc
 3tnlOBNJmsgoY7v7onlh/VT8fEKAx9crjFlzOzj3Zzt8052Ax9pgyFTvW6FFptZfeJJE xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcs18dtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:35:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187KQDja185500;
        Tue, 7 Sep 2021 20:35:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3020.oracle.com with ESMTP id 3axcpk76dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 20:35:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doJypeE6QUfJuJIy46b9/EucBEmT5OXRlOTXWAanKXIg8v8a5FS3Du/lvywunB53o2G4Spk8SDfhmlHRgzSwmQp/kK9JdwHIl8aUFQgIYZbul793BGjnp+G1X0eNGrPdLXVYmEtppaPBSaAYXkRdl0BIRQpw9zVM2j4PjqKK8iGgpS+/UhgPajMD+HMCm/b/uZMO4C801gWuEyNFVmirx+hIQtuIGPIk9kkYP7xF9TZwzyPfLhqTMr9pipZ2zQdjlozchtKrk+JgRwNzWQuQv0lahoMyqlv+tpy0tvFqLo/fctApve92hcjObVf03wv4oovMbguY+l3j8zcoe0CYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EEJlkphaXiiyEkJ/y7k4XLhD3W6SL5K70vRY6oaA6Mg=;
 b=V2Sm2HIhHgAuA48xk5epICVfhagbyvBGDj3aEVNtoCA3NwTLGmuWRvabRUuvXHiOoLLjPa1bSrHbWkYwUC+qwM/5JeT9E0q79Itx1a5aFbu6Ur576j+reKokhA2p+QjjGMVrxHmvQD5RV7qzI24OTYYmzutxEqXaTGhxVYptLh2Is8Q02DWJOk09V3HBX268HiKEpH5yzbKjZOkpiKQJ+B/k1XmZd66N7asIf/0+NetsBKqeXZosPai39jILcOVxPfTGVthYDPee/+z+26CgqMY1xhzbIB/lNrA4uMwqnWsj22vtOHqZaqXljX4xbuK9c5+uBOXJB/jG8FR53bKqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEJlkphaXiiyEkJ/y7k4XLhD3W6SL5K70vRY6oaA6Mg=;
 b=SWFYCIgovoWk2CLplphiMKFUEaWK0jBl8w8wNvusLIwR4FjyF7ZT81qsNAHWpB8inTBJVDEGUnRMJqFQMAhbFDI6lXH6ZVPnQBR1DuFTn0Tgw68CO1777HY/5zqxeK5A637v3tcNZJy7IyHjsqQvAcAzJphvkdI8e3CBBjryT88=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB3783.namprd10.prod.outlook.com (2603:10b6:610:1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 20:35:14 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 20:35:13 +0000
Subject: Re: [PATCH 3/3] namei: Standardize callers of filename_create()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
 <20210901175144.121048-4-stephen.s.brennan@oracle.com>
 <YTfH6RW+3+5kVD+y@zeniv-ca.linux.org.uk>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
Message-ID: <7e6cfce8-7fad-a55f-c1b6-47db62da4344@oracle.com>
Date:   Tue, 7 Sep 2021 13:35:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YTfH6RW+3+5kVD+y@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from stepbren-lnx.us.oracle.com (136.24.196.55) by SJ0PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:33f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.7 via Frontend Transport; Tue, 7 Sep 2021 20:35:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c3859d0-f1fe-468b-afc1-08d9723efecf
X-MS-TrafficTypeDiagnostic: CH2PR10MB3783:
X-Microsoft-Antispam-PRVS: <CH2PR10MB378346111FDB320093311C1FDBD39@CH2PR10MB3783.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCjYz9BByjjfNu1DScBVON2c0usZ48KJtgkXq1igO1a0yZW8A83cZceyh8TJKz/XlA2ygDyMYvDrsrSYd5VCu/aKLjunvi3UD2s+VvEa9u+On9A4Nu0a1H9l7ky15m9R9bG1xAnNCfdekj1/WzNxgolu2WtRRZRmB/8BqgGQd8ubdXX6aTE/CO8u3wkg+KvTusmH32stZsudsCYfeMqLLrfGbQW8BV3bPNDfp8gs+FSDH88SbvaVBA6D+cybtnUrWI3pxSRKp4haOB/giQaHQFH12xfAg3ZcAHYIKS5jWqqQu3coVi2UiABJprBM0ry48NSnmsCpTcJYLrtKfNBW0hzZCW85vAP/hGb8o59TpJZHGpiYGPzHn0oIRax75jtMxqD7xLFuPRF7T/F2sbOxcU/5f1jplZPg6iKY2cD52a2SAV6xhiWr+H+ePFjAxf8qU/bFg5WjLdTPus/Mn4CWJe7x4YKsnDv5umphbQ8d5EM6EO2iQorvWqrUpqoYVewLBTdZ1bBWwZ8HhVFZUjxezfUFGgRiwJT5nqSXNwKM7hsJBO1Lbs1BOuJ6wm868SgwfSj3w25qelOGQWIIV8cnaeMaFJwZGscOn6FpSAkDE8QXbxuuCR8x4+ZCZhfETIJWg0gDhE0ZZR7jzzK776zGgWm6/BhONS+huGzNWz7Et0rC7/MsOIHd0Mc+rbwNbMgLCW0Elwu/0iKsnfPS84JZjJpZDlxeQ0sEP562qnJVzbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(5660300002)(31686004)(38100700002)(7696005)(86362001)(2906002)(316002)(6486002)(31696002)(4326008)(4744005)(36756003)(53546011)(186003)(956004)(2616005)(66946007)(8936002)(6916009)(66556008)(66476007)(26005)(8676002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzFzNHpyZkVORkgxblM4V3hJdlhpUGZxVzczS2NWT0lXV0piNXNjMzBOTm44?=
 =?utf-8?B?S0dHSWY2MlZteS9CN2pPOXlVdDNsbEl5ZEZ0SVpodUhTdEZjSGZKRTNXS0FG?=
 =?utf-8?B?YmFNdkNHRjVpTHZtSHYxQWtkd2l2eU9Bb1BBdVpiazZyZEJpa2xvZGhKNmIv?=
 =?utf-8?B?NFVUbHBMZjRnMGtQcDJlNFpQdkwvSzZYZisxL2FTRG14UWZqeVJaWEE2dVUw?=
 =?utf-8?B?RDdyQVQ2cEMzTzVDdVhjbUJvUEdUNEFvdXNsY21NbTRVNHdqQk5tVEZDL2Iw?=
 =?utf-8?B?OENGTFIzUnI0eFB4Ykc1K0ZEOHMreTdjYlp3RU9RbkJ6UG5NY3lzblAyd1hh?=
 =?utf-8?B?Y1lSS0JIZzNmcDlEQmN3MUhtOUs5emcvaWtjeThwSGpNWDZnQUErZjBGLzgy?=
 =?utf-8?B?dWZibjFWSjZxUzVsSkpTNzMwaHlwcFFpSEVHaVZpSjBrMVA0RFlpQ3AzbzFJ?=
 =?utf-8?B?RUZXQXhnaC9zQ2V4eWtWSXVLNjZiQlZlTm04ZU5ZRHgvWDJHK2RmbEkxQVVF?=
 =?utf-8?B?QTR2T3FXRjlmRDROMk50TnFNZzlTMHlTVzFFWGozK0MrMXE4MmRNaUt4R0JI?=
 =?utf-8?B?dFRWQkRaNGEvMnczQzVucWVodkt3K0RHemhHcnRlcitwNWZ3Q0s2M3ZqVmtL?=
 =?utf-8?B?aG9pQ3dxQXZzYjVYVkdUU3dFM1dzUEtvQWNnZ2NZYXJyaFRaRmFjQWl4MFFr?=
 =?utf-8?B?aVVHRDFxTDR6Z3d3UTJGeEl1by9sZU1BVkVIdmpLVk4zZlB2STVpSHJSU25h?=
 =?utf-8?B?MDFNRlZhMCt6ejUyZUYrTjdueUU4aGQ0M3c1dU40d2I1ajU5LzlZbFJ4NW9L?=
 =?utf-8?B?N2JQMS9aSDVuS1NlSDF2endWbTNFNmR4dFREekgrdklKZVdNM09QZktxS21x?=
 =?utf-8?B?bUxRbE94MkVpSjBRc1VFVEVxQjYybEVNMVozWjZKMnNRRGJaODg1aWJNeFZ6?=
 =?utf-8?B?OGlZV1AzbTQwKzNkQjNDY08rZmdPcW9CcSswNE1yOW16bTZOWms5dThQNmhL?=
 =?utf-8?B?Y2V1M1VDVFRBMklpaEFWNGY4RUYrQnZ5ZlVRR3pDV1UrYVErTDRrR2NxbUlI?=
 =?utf-8?B?SWFXaEkwZi9hY3REY3BQM082Rm5ERENkT3czWW9na1lJVHZINzN4N3M3ZGx2?=
 =?utf-8?B?SVVGV1Y1R2pCZXNOVWp4VHhrQ1U1WTk3dndTb3U2MzBXWjl3amNwa0VtZ3Mw?=
 =?utf-8?B?Q2ZqM3VnSUZVeVpleDUyaVRKSE9LeE1LcjY1SDNJWm84OTM3U2k0elh6eVJV?=
 =?utf-8?B?ampOQUFzT29kTW1CSUdZZkJWYTZZU1daWGliZWNENDltbW96TmhhMDNPdEVq?=
 =?utf-8?B?N3l0b2JyY3RZazBWU1Y1TDloa09MeGRJWWcvSWJRWEI2WDJPRS8weGQ1RzU1?=
 =?utf-8?B?d0gySGdtMkZMTkVvdUpaYnNGVlJIL3RQdHdmMUM4M1NRMWxDVSsyT0pRTTU5?=
 =?utf-8?B?VFNUSHR5YTJIYWxBdUhHWmpIdG9HckNTOVhzRzRlcC9jaS9MYVB6YmtCb1JB?=
 =?utf-8?B?Vk1MWDVzRnV3cnJ5a01iMjdDZElKZ25JbUs0TS9nN0h2WC9HOUhjUmd2WHo2?=
 =?utf-8?B?VnA0emJJQUR6ZjVON3djRENYOWRPb01Gcy9rNTQ1UGlmSXlmY0xVc2pjdVBN?=
 =?utf-8?B?b0NaOXlFY28xVEVTcnFjdzdpZVpNME0weFFmWk81RVZtWk9tMi90cUk0M0ho?=
 =?utf-8?B?SkRrQlIrWmF6RlNWaUh0dzMzVndzc0tqR1JIdFUvRjF6cHF2bnluUXR4cEoz?=
 =?utf-8?Q?C9oPhhQ4Mv9CDVRJhHD+2+UMr3Kj+tE7CMFNwQT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3859d0-f1fe-468b-afc1-08d9723efecf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 20:35:13.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vY9YycuG0ZOLlEVojfFztOUFVh8aqq7WdQZSXrH2tRxoSItfc54SXJVyojC0Nq57ZUWqNZHc53HEgVdTV4efFqeM11q94z+uXN9QaQWIQRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3783
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070130
X-Proofpoint-ORIG-GUID: RuC-r-upw0GHNEx7sPaUAjZIItOzO-Zz
X-Proofpoint-GUID: RuC-r-upw0GHNEx7sPaUAjZIItOzO-Zz
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/7/21 1:13 PM, Al Viro wrote:
> On Wed, Sep 01, 2021 at 10:51:43AM -0700, Stephen Brennan wrote:
>>   inline struct dentry *user_path_create(int dfd, const char __user *pathname,
>>   				struct path *path, unsigned int lookup_flags)
>>   {
>> -	return filename_create(dfd, getname(pathname), path, lookup_flags);
>> +	struct filename *filename;
>> +	struct dentry *dentry;
>> +
>> +	filename = getname(pathname);
>> +	dentry = filename_create(dfd, getname(pathname), path, lookup_flags);
>> +	putname(filename);
>> +	return dentry;
> 
> Leaks, obviously...
> 

Ouch, thanks for the catch. I'll send v2 shortly.
