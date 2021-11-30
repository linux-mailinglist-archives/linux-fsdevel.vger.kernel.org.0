Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71068462D60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 08:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbhK3HRH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 02:17:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38264 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233216AbhK3HRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:17:06 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU5kbej000934;
        Tue, 30 Nov 2021 07:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Jy40BpBE41nBnXDS78PR3rsIu7oqZWfw9LtQFz0vvZ4=;
 b=VO6CwX8RzgTVcM8RZJFf1xYzfHp2zRILHAKj8cigoW5B3ihXMgSJbHtk0kqtgvSWOm2D
 jo2lOFe4dYJB8qu2rtnsyd0A05ywXfDmgSeN5TmBQo6/VJ52vITvOaXMhZhT4CAZgZqc
 dNeTDSsh4c3wVsHZ3sMRZRD/vqRHiSkJyQOUbABCWf4jkslg51wnLutIQk1RyEoI4vQX
 HnGpvO7MV6+2cm1RchU8CY9CMGhJLhBHWfHTdQe8+G5mPkg8oGQ95aoA78ZDEcNJyH9C
 sSeSQ+4aLRRr099tPZCGMmyTwYQRm3d4qXuOwI1aiKCCZbcqLCBPYWnpLnt5ubbhr1sl oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmrt7ynv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 07:13:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU7A84M114855;
        Tue, 30 Nov 2021 07:13:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 3cke4p0869-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 07:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYQ3v0QjvUUqDV38ca5bHVFAVDqKQQKqHR9CGg+O+L6iLgrEtP6wBlKDXarqzfo9CHuRFPCVJEL0g4obeeKJbYIB/Ygcu4Aycg4f8ApHqWPcPbPITd6oQu29XU04IeQdgd7H7AZeiGNlAlOt4afqKQDw/TlY5PSjquTtzecFHlF8F59pYNmkQno8HNY4uA9e/0liTpz9N8YR5IrhIS0tDM9NozrHAvoS4luyWRdKclKkMziMRohwDfTC9IS4wzhb3bwMDtdUzqZWEXO7weNXqJslg4WY3Oj3Y3GuEKjMVVru2UYgAJStjiAvrr7zUrmHrVBQVTy1OY4ktEYEQ+4pOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy40BpBE41nBnXDS78PR3rsIu7oqZWfw9LtQFz0vvZ4=;
 b=AX7FyV12Mpp4DSGzb5e3l2w2rL3yciN2KFpecqFCm7Jp0evu7Isrito9r57YueeGmEZ6egkCmDMbkr4D5V1Qswl2qhakC3A4D8t4nPCmATmrNTy2MFOSgPiegFBPvsu26pvqIYHPJkBE2bNsCE6KRK4pE9R99DZrK1Ze5dHsk/iqu4dzDvwaKqFvsMZ+d1EUl/ktMbch5jCLUfjShCEjHf9Yhly3ykaIGmgpE7baVWsTUeKL4rIBlebR5GfYDR9mKEiuhW8M+XvKxQJ0rNPiJn9kCoc4Kmh6OrXPo0pVBNK2q2+1ztJGZdzkTIS/fTpG68SjXw13TKzCeOzEcGAuxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy40BpBE41nBnXDS78PR3rsIu7oqZWfw9LtQFz0vvZ4=;
 b=hP9pUBv9WbAHCY9fTvSqChgs9enTvum0Gx4/ruh11DtEwEccu5DIZqKh31o/9mWzk3BJKu8WyNPTgciweKoVRUNGC48nDUz2fuxy5YjVRofpFMp+iKslwmOzIx/tjPmfaBW/N0jwPiNGGHd7PDkaUB8jXcr+1K/lCj535qsTu9s=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5471.namprd10.prod.outlook.com (2603:10b6:a03:302::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 07:13:39 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Tue, 30 Nov 2021
 07:13:39 +0000
Message-ID: <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
Date:   Mon, 29 Nov 2021 23:13:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0055.namprd16.prod.outlook.com
 (2603:10b6:805:ca::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.137.41] (138.3.200.41) by SN6PR16CA0055.namprd16.prod.outlook.com (2603:10b6:805:ca::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 07:13:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 698289b8-333b-49af-0448-08d9b3d0eed2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5471:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5471C4D7609AE4DFF43216F487679@SJ0PR10MB5471.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q1wLX8clzpyei5YDpr9Pa+TPEtoV40IDyaw4MhRE0fpjiQdk7lHLf7KY4lzKlXmUGOYSbDUOMh+f+WYZOadevbnwqAHWG6NpnbT2P2gLR8pOYQ1Gwy3WgtWmJxgxmAyU+L1uvLwVJ2ro8ZYiPAIzmAhWQBrgbEAZGn0E9zF+sL5DuX3YlsQ7x10P5gnzSjaCaUZfOAqIFwfwJi5Cn/2n1Lm+/UNLHaY0OpnSpsEXMu95aprXuRdX62R0r5KpG/mOp/Zsm467d0ammu/Dyj7Bzx9DGlXt7q8DxrXRovdvliL1EWvaYUgmn22Prs1to3r43InT1rxPtKSPrwxH3wj5WwNphKnJEvcghLPk/8ULg7De8uQCuHUErtLC1DA90gtsFzdpy9c2d0kNvR+LpBtnbka0B7h4b7amzBrY7g7/Z1/DSzcGdwewal0UcXC3a/XrR1TjbVfqBgjZt7BMk4ZSeiPPsx+TXWhlmiQRlVp0otNrpgHxEje7tBqveWxn5rUWoHo1csQoXplmaENSMz6nZEUVaJmOYOFbETuSvc+9vHOxN0bY98qADDiWCd2XNZnpHAOI1fKB9bGz13PUW6lNWRrbETz/x2V9fSc8JLO2WWw4KDVmV2zhvpsWdFlSkB+CS/qDMAiQ0VdTa/i2OY3aPkMuvXLB8NK2woEQ2K4IPQadFETOO+imHQum6YW8nmcKBlvosodPrGEtSxn9rUXDHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(36756003)(8676002)(4326008)(8936002)(53546011)(2906002)(6486002)(54906003)(37006003)(31686004)(26005)(31696002)(83380400001)(2616005)(6862004)(956004)(38100700002)(16576012)(6666004)(5660300002)(66946007)(316002)(508600001)(9686003)(66476007)(86362001)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzB6YnY3U1prTmUxVkQ0VEVoT3o4WTVVbWRXNTRwU3JGM1granNjZld4cFR2?=
 =?utf-8?B?M1BNSnQ1WVdBc0NEMW1qMUk3VWNVemxWclVnYlc3Z2F3dTFwQ2p0a3IzcDR0?=
 =?utf-8?B?V21FWHhFdEFIRlpYbFc1UDB3a1dJMVFSd2dpcm1ReEJvTENSQjIvQ2VYUk5Q?=
 =?utf-8?B?NFhQTUtNdjJQS1c5OGJTZVZJZGFMbEdGRnlmc25GQ1R5a1FlOU1YeGxOSHh0?=
 =?utf-8?B?Y05xSUExRE9EZXovN282UjZ1SlQ3SjhHSUZ1NjZpenp4TFp0STdra2NIMXZn?=
 =?utf-8?B?MCtBNmlabjg0T0hLV3JFRmdnaGpidGJtSUw5R3RzaVplVitXczhHZSsxM3RD?=
 =?utf-8?B?elY4TWdkY1BEVldGY010YTFXZlhJUmtCby92L1hUNHNvM05RRldvc2swUVpS?=
 =?utf-8?B?VTVGY09EN1IyMmpSellXOFRCSmRkMURDZHNIUktZb1p2cTNFYXFCcGUzM1ky?=
 =?utf-8?B?Y21tL0ZuWFNyc25xeVk2aExza1Qwb2xnb3FZeHZuOCtFdkluWGFVRGttT2dZ?=
 =?utf-8?B?K0lIOE5VWHRWVjE5WDJuUEFKbVhnYXRIZThrV2RnbzUwS2VEdGNHeXBzSGo4?=
 =?utf-8?B?QWFoOHIwZ2F4NCtHQWpiMlBZR1BkdGhCZFdqS2R6RjBxSVpwVldtSmxxVjNW?=
 =?utf-8?B?blhFT3pOZmVkT1VIR0Fpb0dzVWRFQ3RLdXAyVSsvcldaSkU1Sjd4REhndm1W?=
 =?utf-8?B?M1lqeGs0dXpuNW9BQ2lkOVNjeTkzWllSY0xoWWQ2TGtKMm1FTTRsY2d0SWFC?=
 =?utf-8?B?MjhqM2s1T0ZaV1hUZjV4LzJuTDBJb0xkc2lHcVU3RUtNekNsaitNeUYzb2p2?=
 =?utf-8?B?WGpDbjVHUjQwNnp6ZlZWR0tCQnRITUEzL0NseFo2MGRZZE11WFp4dC9pSUln?=
 =?utf-8?B?Rml0YjZPZGtLakM5VXkvWm9YVkx5bno0VEtmdlJFZFVSNWs0K2dHZ1QwYXg1?=
 =?utf-8?B?Q0s3REtyZEhYbFhwbTE4WGZ6aDYvYjBvMVBYMEY2S2RnVXVOMmpGZ09RclJ4?=
 =?utf-8?B?MVBXZ3lJYUkvaU1HZ3NBZnNzWjJhbUlNVUpMcjAweVJvVXIyaVVkMVZmaVcx?=
 =?utf-8?B?NTg5VW81R3YzUXBMWTZNWitLbXgzVmRBb2h6NTl2NkpEbERoWTVwYVp3dDVB?=
 =?utf-8?B?NnV3ajk5UmN4a2RFTU5oOVhFajBKSTA2V1o1Rjl3YWxzR3Z0ZDVnWGErVFVN?=
 =?utf-8?B?c1FiaVNrSzhmdVVJbUt0K05VVmx2bUhJYjRCYVJBK0YzR3JCQUtNeUF1WjVQ?=
 =?utf-8?B?T3Myd1h4eXFQYWVycHFZVEljQ09Idys3cHBZakl0aVRaR09NSlExK1ZaZHhp?=
 =?utf-8?B?eEJINXV6VS9EOWNYb3lIbU1pQ2xMckEwWUNVbWNabytrdzdGellBZzZpWi9Y?=
 =?utf-8?B?TnBwNFpCOVNQdmJmWHd0ODNkZ285MHN2bmlseGllVGpHT2VhWDRGcTFVQjY3?=
 =?utf-8?B?M0FwU29MQUdEUlE5bll1WXlnemFpL2lsa2RqMEcvK1hMTk5CRFJYUGdOMUNC?=
 =?utf-8?B?T3F4V3VIUEw5VDVzbEY0NzAxbTBzSXBCZzZJSERsSXhqZTJobXpwaW9aYi8x?=
 =?utf-8?B?SFF1VCtTdjN6VkhJVlR4S3NuU216UG9zanBKMkpLUDhxZnk1eEpScnVsek5S?=
 =?utf-8?B?Y2VsLzRJc1ZodWwxeVNyK0hWTHI5TzlKSXh2d004R2twSXlhbVUxWnpKWmpE?=
 =?utf-8?B?VGJzQTRHb2RSTVBMWjNDMmt1bXVNRk9ZdDJEUVVqR05adXluZkpKUDVLdnM1?=
 =?utf-8?B?KzhYS1UzSXk4WFhKZS9hRitaaU5NKzV3cldudC9JWC9JQURXUWJSNHAyRS9m?=
 =?utf-8?B?SHFCM0dKdG80TlVNT29DcGl6czVYaTZreXZlcytHTEtDVzhwOVd1amp5bVhz?=
 =?utf-8?B?TlVPaVhiSGt6RStYR3hvbUl2ZmtqV0NIUDhXUE5WemtJL01PbTYyZnVIY2tJ?=
 =?utf-8?B?alV1NVYyZGZqN3pZVTZBS3cybFJEK0Zza3IrVC9yRFRTWHpwd1gzbWtDemt1?=
 =?utf-8?B?OTlzSGZ0RjRpVCtPdlRxT2Z5V3NlL0pHVHBjZmg1bHlBa3l1UnBtWCtBc0d6?=
 =?utf-8?B?WW1jaVJuY1BKUjQ5MVpyWGFBYUhaWWpmSnU1bENqUXdCOFNVeXphSDZ4dWt3?=
 =?utf-8?B?TjBOa3V4U3ZhVHdlRTYvdE9NaC8rQmw2WHJCcXkyN2x6RXB6aU9VaFpwYXdN?=
 =?utf-8?Q?yaj+gaDN1S0DvRikVDFI3L0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698289b8-333b-49af-0448-08d9b3d0eed2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:13:39.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JxLHnI5ok52b1xeNxY41m4rAF6h3lIQWjnjxwwxfL+3vDXCBCozsbudbP3IZXId9Tjo6sEfF8wehbSyPVJzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5471
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300041
X-Proofpoint-ORIG-GUID: 7LsBgBCjJyrL5NvYhbiEITzeKdbY_ApC
X-Proofpoint-GUID: 7LsBgBCjJyrL5NvYhbiEITzeKdbY_ApC
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/29/21 5:42 PM, Chuck Lever III wrote:
>> On Nov 29, 2021, at 7:11 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> ﻿
>>> On 11/29/21 1:10 PM, Chuck Lever III wrote:
>>>
>>>>> On Nov 29, 2021, at 2:36 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>
>>>> On 11/29/21 11:03 AM, Chuck Lever III wrote:
>>>>> Hello Dai!
>>>>>
>>>>>
>>>>>> On Nov 29, 2021, at 1:32 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 11/29/21 9:30 AM, J. Bruce Fields wrote:
>>>>>>> On Mon, Nov 29, 2021 at 09:13:16AM -0800, dai.ngo@oracle.com wrote:
>>>>>>>> Hi Bruce,
>>>>>>>>
>>>>>>>> On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
>>>>>>>>> On 11/17/21 4:34 PM, J. Bruce Fields wrote:
>>>>>>>>>> On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
>>>>>>>>>>> On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
>>>>>>>>>>>> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
>>>>>>>>>>>>> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
>>>>>>>>>>>>>> Just a reminder that this patch is still waiting for your review.
>>>>>>>>>>>>> Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
>>>>>>>>>>>>> failure for me....
>>>>>>>>>>>> Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
>>>>>>>>>>>> all OPEN tests together with 5.15-rc7 to see if the problem you've
>>>>>>>>>>>> seen still there.
>>>>>>>>>>> I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courteous
>>>>>>>>>>> 5.15-rc7 server.
>>>>>>>>>>>
>>>>>>>>>>> Nfs4.1 results are the same for both courteous and
>>>>>>>>>>> non-courteous server:
>>>>>>>>>>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
>>>>>>>>>>> Results of nfs4.0 with non-courteous server:
>>>>>>>>>>>> Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>>>>>>> test failed: LOCK24
>>>>>>>>>>>
>>>>>>>>>>> Results of nfs4.0 with courteous server:
>>>>>>>>>>>> Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
>>>>>>>>>>> tests failed: LOCK24, OPEN18, OPEN30
>>>>>>>>>>>
>>>>>>>>>>> OPEN18 and OPEN30 test pass if each is run by itself.
>>>>>>>>>> Could well be a bug in the tests, I don't know.
>>>>>>>>> The reason OPEN18 failed was because the test timed out waiting for
>>>>>>>>> the reply of an OPEN call. The RPC connection used for the test was
>>>>>>>>> configured with 15 secs timeout. Note that OPEN18 only fails when
>>>>>>>>> the tests were run with 'all' option, this test passes if it's run
>>>>>>>>> by itself.
>>>>>>>>>
>>>>>>>>> With courteous server, by the time OPEN18 runs, there are about 1026
>>>>>>>>> courtesy 4.0 clients on the server and all of these clients have opened
>>>>>>>>> the same file X with WRITE access. These clients were created by the
>>>>>>>>> previous tests. After each test completed, since 4.0 does not have
>>>>>>>>> session, the client states are not cleaned up immediately on the
>>>>>>>>> server and are allowed to become courtesy clients.
>>>>>>>>>
>>>>>>>>> When OPEN18 runs (about 20 minutes after the 1st test started), it
>>>>>>>>> sends OPEN of file X with OPEN4_SHARE_DENY_WRITE which causes the
>>>>>>>>> server to check for conflicts with courtesy clients. The loop that
>>>>>>>>> checks 1026 courtesy clients for share/access conflict took less
>>>>>>>>> than 1 sec. But it took about 55 secs, on my VM, for the server
>>>>>>>>> to expire all 1026 courtesy clients.
>>>>>>>>>
>>>>>>>>> I modified pynfs to configure the 4.0 RPC connection with 60 seconds
>>>>>>>>> timeout and OPEN18 now consistently passed. The 4.0 test results are
>>>>>>>>> now the same for courteous and non-courteous server:
>>>>>>>>>
>>>>>>>>> 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>>>>>
>>>>>>>>> Note that 4.1 tests do not suffer this timeout problem because the
>>>>>>>>> 4.1 clients and sessions are destroyed after each test completes.
>>>>>>>> Do you want me to send the patch to increase the timeout for pynfs?
>>>>>>>> or is there any other things you think we should do?
>>>>>>> I don't know.
>>>>>>>
>>>>>>> 55 seconds to clean up 1026 clients is about 50ms per client, which is
>>>>>>> pretty slow.  I wonder why.  I guess it's probably updating the stable
>>>>>>> storage information.  Is /var/lib/nfs/ on your server backed by a hard
>>>>>>> drive or an SSD or something else?
>>>>>> My server is a virtualbox VM that has 1 CPU, 4GB RAM and 64GB of hard
>>>>>> disk. I think a production system that supports this many clients should
>>>>>> have faster CPUs, faster storage.
>>>>>>
>>>>>>> I wonder if that's an argument for limiting the number of courtesy
>>>>>>> clients.
>>>>>> I think we might want to treat 4.0 clients a bit different from 4.1
>>>>>> clients. With 4.0, every client will become a courtesy client after
>>>>>> the client is done with the export and unmounts it.
>>>>> It should be safe for a server to purge a client's lease immediately
>>>>> if there is no open or lock state associated with it.
>>>> In this case, each client has opened files so there are open states
>>>> associated with them.
>>>>
>>>>> When an NFSv4.0 client unmounts, all files should be closed at that
>>>>> point,
>>>> I'm not sure pynfs does proper clean up after each subtest, I will
>>>> check. There must be state associated with the client in order for
>>>> it to become courtesy client.
>>> Makes sense. Then a synthetic client like pynfs can DoS a courteous
>>> server.
>>>
>>>
>>>>> so the server can wait for the lease to expire and purge it
>>>>> normally. Or am I missing something?
>>>> When 4.0 client lease expires and there are still states associated
>>>> with the client then the server allows this client to become courtesy
>>>> client.
>>> I think the same thing happens if an NFSv4.1 client neglects to send
>>> DESTROY_SESSION / DESTROY_CLIENTID. Either such a client is broken
>>> or malicious, but the server faces the same issue of protecting
>>> itself from a DoS attack.
>>>
>>> IMO you should consider limiting the number of courteous clients
>>> the server can hold onto. Let's say that number is 1000. When the
>>> server wants to turn a 1001st client into a courteous client, it
>>> can simply expire and purge the oldest courteous client on its
>>> list. Otherwise, over time, the 24-hour expiry will reduce the
>>> set of courteous clients back to zero.
>>>
>>> What do you think?
>> Limiting the number of courteous clients to handle the cases of
>> broken/malicious 4.1 clients seems reasonable as the last resort.
>>
>> I think if a malicious 4.1 clients could mount the server's export,
>> opens a file (to create state) and repeats the same with a different
>> client id then it seems like some basic security was already broken;
>> allowing unauthorized clients to mount server's exports.
> You can do this today with AUTH_SYS. I consider it a genuine attack surface.
>
>
>> I think if we have to enforce a limit, then it's only for handling
>> of seriously buggy 4.1 clients which should not be the norm. The
>> issue with this is how to pick an optimal number that is suitable
>> for the running server which can be a very slow or a very fast server.
>>
>> Note that even if we impose an limit, that does not completely solve
>> the problem with pynfs 4.0 test since its RPC timeout is configured
>> with 15 secs which just enough to expire 277 clients based on 53ms
>> for each client, unless we limit it ~270 clients which I think it's
>> too low.
>>
>> This is what I plan to do:
>>
>> 1. do not support 4.0 courteous clients, for sure.
> Not supporting 4.0 isn’t an option, IMHO. It is a fully supported protocol at this time, and the same exposure exists for 4.1, it’s just a little harder to exploit.
>
> If you submit the courteous server patch without support for 4.0, I think it needs to include a plan for how 4.0 will be added later.

Seems like we should support both 4.0 and 4.x (x>=1) at the same time.

>
>
>> 2. limit the number of courteous clients to 1000 (?), if you still
>> think we need it.
>   I think this limit is necessary. It can be set based on the server’s physical memory size if a dynamic limit is desired.

Just to be clear, the problem of pynfs with 4.0 is that the server takes
~55 secs to expire 1026 4.0 courteous clients, which comes out to ~50ms
per client. This causes the test to time out in waiting for RPC reply of
the OPEN that triggers the conflicts.

I don't know exactly where the time spent in the process of expiring a
client. But as Bruce mentioned, it could be related to the time to access
/var/lib/nfs to remove the client's persistent record. I think that is most
likely the case because the number of states owned by each client should be
small since each test is short and does simple ops. So I think this problem
is related to the number of clients and not number of states owned by the
clients. This is not the memory resource shortage problem due to too many
state which we have planned to address it after the initial phase.

I'd vote to use a static limit for now, say 1000 clients, to avoid
complicating the courteous server code for something that would not
happen most of the time.

-Dai

>
>
>> Pls let me know what you think.
>>
>> Thanks,
>> -Dai
>>
>>>
>>>>>> Since there is
>>>>>> no destroy session/client with 4.0, the courteous server allows the
>>>>>> client to be around and becomes a courtesy client. So after awhile,
>>>>>> even with normal usage, there will be lots 4.0 courtesy clients
>>>>>> hanging around and these clients won't be destroyed until 24hrs
>>>>>> later, or until they cause conflicts with other clients.
>>>>>>
>>>>>> We can reduce the courtesy_client_expiry time for 4.0 clients from
>>>>>> 24hrs to 15/20 mins, enough for most network partition to heal?,
>>>>>> or limit the number of 4.0 courtesy clients. Or don't support 4.0
>>>>>> clients at all which is my preference since I think in general users
>>>>>> should skip 4.0 and use 4.1 instead.
>>>>>>
>>>>>> -Dai
>>>>> --
>>>>> Chuck Lever
>>>>>
>>>>>
>>>>>
>>> --
>>> Chuck Lever
>>>
>>>
>>>
