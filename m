Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD3241C7B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbhI2PCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 11:02:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62366 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344934AbhI2PCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:02:39 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TEeOlJ013625;
        Wed, 29 Sep 2021 15:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cNa49YG+pdjys2nA8WWc5jfkEudTq1iUfeKyNbDTooA=;
 b=cXvBmSyj3W/jJmpWwvYYGVd3eFK3lprQnDCXVCKTZIyqZJXuGZl6cizj0X7lwX9gIO7G
 uWjqjrrhRfXkgvbNOjR3YymhskZXOsfpqI0L1YwuAyHMr1TNftuZnGbqsbMSi8vcZk3L
 H85+QVpdYCiTG832o8IIuazK8xDnmIbiTSyZ1+ZhzIWgo+weq8y7AQLfJV5wNstR8N7z
 +RnJNrjA84pHeF2GhS2LgMvbcHMO99TJ049qnCzlfBkEI0Dj6O5Vei3z4vSg7dMVUJu4
 opSfQRizy4esAqaOGK0tu5gxkDihguNN/POKhdBnH+ouTXOmPo+fSRx7JmVOu754TIIU Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcf6cuubc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 15:00:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TECWx9088712;
        Wed, 29 Sep 2021 14:22:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 3bc3bk02wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 14:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7sLU61+kNwi9sNIJFY0/QXNmz8DombIWW9jFiaMNA5Os5KPFWUVGKhnbqQewtpy4GXLrL7gGJItiDXfBrIx7/Jot22pdYgl2PrEOhasPZFo8gNiERQGusxkKcg4vA5AZ67oD8fTLf4/UvSt3tgkWmUrWurjzGkn4ua7L7nBLZ8gB907kOnv9rzSTxJem5nL9Ah866TaAsDojn7oqCocij28APZsopH0HIJ3R1AE6Vrs0BSYU8XZkwKf9QS2qZ0m+lH5+rhZ82ft8Y+73fOLHwcU7yzig4J+KrWsxCsAlL5dmyafoiTH72ZgnzZqxaig7aq/06RCfvIwldEfTLiZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cNa49YG+pdjys2nA8WWc5jfkEudTq1iUfeKyNbDTooA=;
 b=fmNe3Dki4C+OZI58WwwDszwu0c7DwdWod7h+d1VI8YztFtcwuOcFejDSgsmvDrX+Mz+Y92IqPXu3V079WWHQmoT3iwqbJvJXhNKDLlvVuDiiaSHvxG7eWpsQn6hoTAOqild3NUuopqWee3URYquoMqjTyTGYkJpPGFqFDU/cCfLsrWFwqFgnS3B6x+BA0dSuuqVwrgBoCe1MfjDmdbpAb0IuksVwsnX/A2y4l+eKAgyLVjaThltQz4sRURqadErO6tauqyuYYTNXyEzEE3SVe4ACIXS9xrPjm9GHcyn7mZZ6Ztp2SnxZl81PuPCsBrDUASVNjBcmcaVZVbBNofb1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNa49YG+pdjys2nA8WWc5jfkEudTq1iUfeKyNbDTooA=;
 b=DBTLHDlrMvC3RoiGNYmbJxRlmQFT0n2qh1WLIz7chzntd7pK17MgfQNQ9tfwzAYxHTj/mVCgtCPKrYpS5Po9qqQQ7Xn4x9U9N2nCLIFHyahZlFtztOliaqTwNxfFwAn2voUL0Lz2f5iELBTP+FX2fR0B6uhiaRVUODZpD636nW8=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4256.namprd10.prod.outlook.com (2603:10b6:208:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 14:22:11 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329%5]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 14:22:11 +0000
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
 <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
 <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com>
Date:   Wed, 29 Sep 2021 10:22:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BLAPR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:208:32e::20) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
Received: from [10.74.99.231] (160.34.89.231) by BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 29 Sep 2021 14:22:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3bbbc54-c9df-4045-f8c6-08d983548687
X-MS-TrafficTypeDiagnostic: MN2PR10MB4256:
X-Microsoft-Antispam-PRVS: <MN2PR10MB42568C672075B186D7D71A048AA99@MN2PR10MB4256.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azXtEWuJiK0fdiSDxA7JVs8roo0D2WShIYFkYSvmFe0X4rt+0FOxoBhCpAD9CVgOGKKE+0PiLuq+9sUsxGPoXXyMPUYGlNY55e4vmORntr1hk+KDetSX8rfvu+6rALsCYRiT4xvsjysQvu2BFemm4NMy8sG1Ur51H/MQ220hJIcH8MSVEXm9MfMCC7kOmPpeOiX/FrTTH5SMck/rv3Pm9abliFJ+aUqVWir8/dY/RmZyo9Zc6ZXfRmqPpbs0J8s2Pr97DLgsjgbKhwm/oaVlaOFdmibGCKmCKaJiiFnSn68mtmQorJ1XpWdfqT4Gkc4EANuAPmaaJLdn6HgH/ZPenViafbzX9q4xQxotl8sqPwovdT97+mjr7uWwhwoUMfPSHxkP990lCyCiJDvKVJFc0AOsX1xeZ6s8KGmllLXKo+D7KLJeHbS4xl/ZtLL1DtaiJC4Z1OgskwpQM6g9SnPkp4DnsEZ6Q6wo8ou4ZFa/CAQnR2n0iD9kVitoemz2AeaqWNB9IL92eaNaMVn8UiPS9RNSuwZiebDeVdXRLe3PSI8YAZw/fuew/zYwS0iVXDsK0/wyI86UELdu7hAsvKVtiQ1SoHhDsotSimFIw2dDhZAtmiZc71LyLUxLP8CC0tZtLCOOZc0jjAC1LhJsEPmldYb2Dv40z0/KK/qWgwoZYRKyJ2WLAOS59uK9IV4jKcLT55XDT2s0IXkDI1oMPvsjTLdIAeaDOPHXlKWdcQ9Sk3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(316002)(54906003)(7416002)(8936002)(86362001)(5660300002)(38100700002)(66476007)(16576012)(66556008)(36756003)(66946007)(31686004)(4326008)(6486002)(2616005)(8676002)(956004)(31696002)(26005)(186003)(44832011)(53546011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkZGejU1YkRyZnVacitYRk5JR3BmMFJFZzV2bSt1cWJGTU1nektNK0V2ZDYx?=
 =?utf-8?B?TEIvWlR5Q1BBekMyUkRKai95N0RiUnhxNVZtcVdtR216eUIxS2gyYjREdS9o?=
 =?utf-8?B?TXBYVC83TGVwQnBUSmszU1RPcmtOZFVoMUZxRU4wQmZuT2xzNWtZMFpudGZs?=
 =?utf-8?B?V3hhY1lSU0QzeVU3dDFlMFZnUmhOM29qelJJOHo2VkJFbmlKYzBTSUliVXI5?=
 =?utf-8?B?SFFoOWU4M1pwUnNsNW1waDFKT2IzdEkwcVJjWHBLUk1NWlNrZnp3b29tdnl0?=
 =?utf-8?B?VDdWQ2NuL2Y1d3VOTy9laHZhNzhmQlkwMStqTXB6MjN1OXJqUFFGWUtuaDJI?=
 =?utf-8?B?ZktVR25kYXhtdGJlWXNpQkc0RWI1SUhLOE9TYTh2TzJZVWY4UzJhZk9XbnVJ?=
 =?utf-8?B?d2VJczZpQlZLMSs3cTV0NUdDbTJqYWxsb2dtWHJYRmo2T0RjMFJsdStUZVZ6?=
 =?utf-8?B?UmUxaWZPaGw0Y0Fza3JmZEZMbnVFaGNUdnJhSytMVE9nWHN2UDVvYUZJMzdD?=
 =?utf-8?B?TkttTGFFWFBUQjdoVy9iUWZDcXoyb1luSlVUTHJhcERoUjVoQ2pFZXFjT1l0?=
 =?utf-8?B?elNoNWZUKzN4ZllHVXVYeWMzbjZCQ0pVdFJ5R0FFc1hGVXJOdXNaZEIvcC9Z?=
 =?utf-8?B?citIOXhDWHpzclZscktBcjcwN2twMFFKbkpUOHpLb0Y0S2x5Tkw4S2ZNdnZU?=
 =?utf-8?B?ZGozZkF6M3Zady9VeERhQjF3dFZhSUs5YzVhM091blBwbklrYVFKcytjNlBt?=
 =?utf-8?B?WVRVTk1Pem1zNm43N1k0OW9yeHJPdi9BSVJlVE1kMUlIV3RNUnFsNlFsMUx6?=
 =?utf-8?B?U2JsM1JSaEI4dXZodW4wbjNyN212WXp6NUJ0OHpPWmsvRG9nV1NGK2c2ZGpS?=
 =?utf-8?B?Z0Iwc1ZQU3hjV1JpRkN2WlNFZFE2dXpzd1g0bUFJOTBOZnZxYnFrbU9Ib1hv?=
 =?utf-8?B?eDdaTDVIQ29nTjJyVk1DWUtDVGR1cnhhemNwMEVCNXVwVEZjNVZ0ODRCQUh4?=
 =?utf-8?B?cnMvWEpaVTlzbk9pNEVaVlNwNVVjWUxUM281dE4zcDVIVk45dnZFUjMyY3RD?=
 =?utf-8?B?RENqaXZQTU1BRXdBVy9heE5pb251MnN2SzhzVUE1ZG9BaEhnRkorSzd4ZGNV?=
 =?utf-8?B?TFp2djl3MjlnZGxFaFFVaUx0VVVkM1ZkaE5WVVlIeGg0cUNIYUtPckhqRDlM?=
 =?utf-8?B?SDcwVkROaXN6V3Y5WlY3MXFUYUNrdVhkamJXVU4zem9VMy9EUmhVMFNESzJT?=
 =?utf-8?B?R0NyUE9yUXlSOVg0djVFYWRXRGlGSnF3ME9wbFJ4K2JheGlsZUpaOHFoZzNB?=
 =?utf-8?B?Vnl1c0ZDQjJaa1pLcG91ZUw4bmI3blVNbXpkV0R6UXpMZFNGeDFoTkordkxP?=
 =?utf-8?B?aUxPK3N5UWE1SFRXNWJRbzlEblBwbXhZanlNekhoUFZDZFRQV2FaT2MyU2kz?=
 =?utf-8?B?dnduWmJianVpYXlaUi9rSG83MlFFYllGSEt0aWdpUkJEbGhoMGRmdElmR1c1?=
 =?utf-8?B?Z2sya1hSTnowRm41UmpDRitla3A5bTBEZTdkd3U4Q1VCY1Z5SmZYYllDYTRQ?=
 =?utf-8?B?L01XU25kQmlvNU83S0pDWEx1dUNRaXZNVWxSNlg1eUlRNi9vcUJ2dGZHMkNN?=
 =?utf-8?B?RURvUmE5VHQ0SVI3WWlDbEhTb2JSVWVRQlFZZndYajFwdU9mR05HRXRHU2Ux?=
 =?utf-8?B?K005WG5pYTUzWlV3c2lXNytoamp0NjcyeHpuUS9JNnBCdDR2cGpPV1FtMys1?=
 =?utf-8?Q?m78cTlBTE3d58Vjajl2WQl19AH0Znv9xj9BWUC6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bbbc54-c9df-4045-f8c6-08d983548687
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 14:22:10.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMdriNBFwQVFfWL3dz6ApDwfdbfGxJEWfnKdCmTuP7hK5ZnmAKZ5whRtqfqQ356giLcxBDbI4x+W0yHFjGfuPO4TPuIuTI3olX5XhXFy+n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4256
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290089
X-Proofpoint-GUID: PkBLbRGZ5d5dZzyjxXUaMDKbPdBPQLe0
X-Proofpoint-ORIG-GUID: PkBLbRGZ5d5dZzyjxXUaMDKbPdBPQLe0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/29/21 5:03 AM, David Hildenbrand wrote:
> On 29.09.21 10:45, David Hildenbrand wrote:
>>>
>> Can we go one step further and do
>>
>>
>> @@ -20,24 +20,11 @@ static int xen_oldmem_pfn_is_ram(unsigned long pfn)
>>           struct xen_hvm_get_mem_type a = {
>>                   .domid = DOMID_SELF,
>>                   .pfn = pfn,
>> +               .mem_type = HVMMEM_ram_rw,
>>           };
>> -       int ram;
>>    -       if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a))
>> -               return -ENXIO;
>> -
>> -       switch (a.mem_type) {
>> -       case HVMMEM_mmio_dm:
>> -               ram = 0;
>> -               break;
>> -       case HVMMEM_ram_rw:
>> -       case HVMMEM_ram_ro:
>> -       default:
>> -               ram = 1;
>> -               break;
>> -       }
>> -
>> -       return ram;
>> +       HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a);
>> +       return a.mem_type != HVMMEM_mmio_dm;


I was actually thinking of asking you to add another patch with pr_warn_once() here (and print error code as well). This call failing is indication of something going quite wrong and it would be good to know about this.


>>    }
>>    #endif
>>
>>
>> Assuming that if HYPERVISOR_hvm_op() fails that
>> .mem_type is not set to HVMMEM_mmio_dm.


I don't think we can assume that argument described as OUT in the ABI will not be clobbered in case of error


>>
>
> Okay we can't, due to "__must_check" ...


so this is a good thing ;-)


-boris

