Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA3956378A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 18:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiGAQO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiGAQMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:12:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898F52315A;
        Fri,  1 Jul 2022 09:12:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261G3PO7031885;
        Fri, 1 Jul 2022 16:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0Dvv7SpG//R46NQm8PVCgeG9lpUmg3z0A7hEqetlGuY=;
 b=MFq/pc571eiEmZMdZBISTV/P10cAsTDM0JwGF6bq6W/ybRJo1R5fQWgk9G5nJljRqpzm
 B5eymInMoqYH916UIWGaxdcM08+l2Ff15AX/efZl9slM9YY65wHTVa6e9mZInvOGoP0p
 rHclBDR8CXCM21jxbW/thwIdXQzE0Q9PWVIM7z9Vreq+VQWjsH8F4bBHEeFgRHO3K/zL
 aAD0hEPpgocmdBqFtUEHH5hMhOH3anjBpvEH9bzv9oql5txwz8VxFtCjTBccP4OetDLK
 X9No9w2ixssU6H40wG2cTezPiZJqL/g7Z2hDhOFj/ixfrT+AltQnZc18g1OVXbeEtNuH sQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0qqcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 16:11:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 261G5hK5016066;
        Fri, 1 Jul 2022 16:11:48 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt4swmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 16:11:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4GGOfWexoqSAyZ6Cxt91l/Ppl94CyZPoaGcFtavcP8dst3/4YvebfWib2XwUeZq6BSmwWyZleQ+oiZrS6owfGwGvrVfr/zJ852R+COrEuQ1k0wqY+aqPjSqz3vmu7pyjv/X90AzFToHw5HkC3A0ZxNT4gBEG3PbyJAZPj2ZJZuVeG0q+/Adz8ntie3bdeOq5txh70TnSWyMtRwxebrQjE6khgrpvyQWmb2Brwu/7NhCvFPhqOvwn7+ghcz13K8bW59yu6cyjtRTuP48VTH03mHa1TixKQ6k9uXi+wlXhWsILTJlPiugaCqo4qL2zhKSr3Y8PlypTp0qBqaq2m1PQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Dvv7SpG//R46NQm8PVCgeG9lpUmg3z0A7hEqetlGuY=;
 b=VnNEefBjYU4p4UOzUUgxP2pEswZQZ0yzunuITWqFie117nYNlbhrQWHBOtcryp5KL8Ft1lf62NijAgKOSRc5qJYvki7ux+vn3FYpaapE3+bAw1Cr2lUTgrE/bf260kxbZ+v7KixQX8pPIFOW8GOcw5ARMk8Zp8nN+kEPOIR7EncziJiXPq1Q6bcP9ZMIJfuFYMbhTlnl5FCNZBNyCkxA1122D0s+ZWcgW4R3H2VFFS01mrsa0PISy1cBoovzpiLkWY4VFCRAYSE7uzAg05E7bLlhOMCWVwRvg/D7Pz7qgdXATSfU47Ji51QeVQO7XDmLTqNWbRXuPsn9MJa5tS6vQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dvv7SpG//R46NQm8PVCgeG9lpUmg3z0A7hEqetlGuY=;
 b=rFIxdQDdhkc7sr3xksvsv7g+aloijvuCVg7yjqGizrhAnKo8HRVg5Cl++fyCZvnDh/Kmmh8OntqQy10cNAafl0XTc+MSxagIG3GptiTliRRnotbHcSX2xK/rk1ap2YcN1S5ounyauyZft7tc7+/Q/PlsxopiFWZdBWpLotgkGBY=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BY5PR10MB3892.namprd10.prod.outlook.com (2603:10b6:a03:1fb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 16:11:46 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.022; Fri, 1 Jul 2022
 16:11:45 +0000
Message-ID: <85ce95fc-0baa-8b25-8393-bed1268cc17b@oracle.com>
Date:   Fri, 1 Jul 2022 10:11:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/9] mm/mshare: pre-populate msharefs with information
 file
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <34e2eabbef5916c784dc16856ce25b3967f9b405.1656531090.git.khalid.aziz@oracle.com>
 <Yr4rP7rfxqOzxbCZ@ZenIV>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <Yr4rP7rfxqOzxbCZ@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::11) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67f5b534-a055-46fb-2ed3-08da5b7c6514
X-MS-TrafficTypeDiagnostic: BY5PR10MB3892:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oL36HjLXhMcAxSNN7jpoKN90xWVyMlTH5xWDt2P3PoHZuPp5CeNuZOXKpjGHyQWde7MO73SLpw3/q/LeNWt1DMixtv12ohzOUGqNObtZjj9ZwE9svQapszTXKhanvmJWnSw+PDihF3JL5r1i+4RWeii8Jzbeong2+JEQhHxZ5mhbMQVnQ9ONh5ZWXc2h2Qh8xkrrDXF/QJmRkAqLCnEXB/oZP1YPhci0wf8FetFNOwN3Sf8IE3xiJfTyFKc0nL3mPnZ7tJAb9vHnGdyQzNcl3uUKWdVF/pdkrfzKBCc7Xh7vlX9d4pa2XFcQaaKXGTAeG+GJrpFAldEJ3FvGwuVEyYf1U/P9xX8N9ToRXgaze3A/fUh8d5gyYhx89qerP4zzVHWyjMG5TF9Irypa+hXs7v0B7dCaS5cvltg+6oPtmJ10UZB+SaM2WiLiUmqLY88j+v5EGiob2xT9dQMi/JgDPdFMs3PgZgi2SepklB+Jjhf0XeHAn07sA1g0QqTdl3bXGe0nyaXY59k9lRBLWlDkyz+5GnBU6KcCey+o0wo8VSNVVHrzRBPdpPUNzEDekvgwyO9sweGF8nP3wPZj13BmV8I1nfaCq6ifnHrMBnRrGdgZbGEZbDoChEcGCPHWWJyQ4J/arK6iddtqjxyeCqd61l/PfMDJqFiUq3n3CqAP/lsZ1+2onLtaAh2CIizBfE9Urkm6s8Tbr3bpFOX7nQVr+VGH+54SVMeSD9dexF3Vt0cJ2w6ou5QtxxZ1EMV78EB39FE1VkvM6mmr3uQxH9Uwha1MYIWdvg14YqS8bv+50wnvxJaet4Fqte/DBBM1+QIr1laMdXbJUZx19EeRuUrQpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(39860400002)(376002)(346002)(26005)(6512007)(86362001)(2616005)(4744005)(44832011)(5660300002)(8936002)(53546011)(6506007)(6666004)(6486002)(31696002)(186003)(478600001)(2906002)(41300700001)(7416002)(36756003)(31686004)(38100700002)(66946007)(8676002)(316002)(66476007)(66556008)(4326008)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJuaDFqYmU5ZC9DbW1WUFY5MWxMZzRGdHJLWjJ2YndIOVBlc0o0VjhwZGda?=
 =?utf-8?B?VUFJdW5mdDU0cytOLzdsSE8zV1FTcUljUWxGaTVRRzRnT2lPbEcxek5LRExP?=
 =?utf-8?B?MTl1TnpRK2x4dTRraVNFRjl6cGo2elFXTVJONFAxSHpnM2ZuMklJS0F6NXBz?=
 =?utf-8?B?UlMxVXhwM01JcklINjhMcHBibEpKYlAydFZ6em5nU2dVVUplcFAzVW1TT3R0?=
 =?utf-8?B?VlkzRDVRU3hvS3U2cE9VaCtNWFM1QjU3L2l6cTRIUHkzcEVoamhRS21xZjVk?=
 =?utf-8?B?SWZFVVZDQXRDS3E0U295SFk0Z3NHQVZVU3VTMFZIRytmcCtFb0svUjl6K01o?=
 =?utf-8?B?VEM3L3BqaFlNaTZXRTdtVjhWZVdsYnlYVE9yVDVaTGl4SnpKUzIyTU5qQ3Nw?=
 =?utf-8?B?OWVIZG5IazlFNXlsZ3Vtc1dMYmkwSDY2SmFqc2puZ1NiR25yNjFWQjYxZk5y?=
 =?utf-8?B?aUd1RlVzbXBYK0hwOEp2bHhIWGYwSVlvREZMSzA1aUczcHo5Y0dXS3QrL2Zq?=
 =?utf-8?B?cUdQc3NyNUpKajEwdWQzNFZjQkprcnEwUzZEb2J2K0JLQk8yOGsvWTNFTnJp?=
 =?utf-8?B?L2xZZHZFRWpFMGFtbmhzZlBJVndlZnhYOTZ1UXc5OVBKWEN3enJzQlNYL3Rm?=
 =?utf-8?B?ZStQMGFVSnNYbElkY3dkSFVrWUhXNm1CVUZoeWlJYjFZck84UW15NDhPM2Rs?=
 =?utf-8?B?eDVGcFJUNDlGWmg2Uy9LTlBqRWZ2ZE4rbG03TEN1WkdVb1d2TXFkYjRvS1lB?=
 =?utf-8?B?aUozcTJEYTFzS1RyNE1vSXB5aTR4YitEeHExSFA5SUdPaDl3L2hHNllCbjlC?=
 =?utf-8?B?NGxTWVZZSjViRjVheFB5cE5rL2NURkhWcjhmbU5MVUduaitkVndtNTNvdU9t?=
 =?utf-8?B?bTB0WUtDSFE3aVMyM2pvYVpnWUJ5TTRmaXhGSVUvS3V0S1AySU1maUtJd1FJ?=
 =?utf-8?B?bi9qcHVNWDRCVGlteC9WRDRDNENIa3ZxTUtCN2xxZHNvemg4NVc4S1AvRnRl?=
 =?utf-8?B?dGYvaWlPa014dSsyaEFHWWpCbUp2aE92c3N0TjQ3OEFYdjJXYi9WcktDS1N1?=
 =?utf-8?B?cXAzVlhLaGxCdHlxcE1VMzBEaW05M0tZQkdCNzFMelhjMW9LdWtpYytyaDJK?=
 =?utf-8?B?Vk5uM2dXWkJKZEVUTFkyMHhDa1JvWUJCeFhBWGxGUGtnaXY4RVk2a3B2eERK?=
 =?utf-8?B?czFMU3A3QUdOOEhlaVJoMm5yZmtVNWNzR2k3cy9EeUJxbTdLcW5yNCtLdzNx?=
 =?utf-8?B?YWovaFZOczFCWnYwWFpML0lOekJCaEpYc1plb1RzSHQ4Mk1WdUtwUVk0b0RZ?=
 =?utf-8?B?V25hcUg4b0hLaEZjMElPQmxaMU14elVKeHROUzlPenY3NHZObjc5cVg0eWdu?=
 =?utf-8?B?MjZ0bGZQallBdnpCc0FUVFIxK0E5ZUhFYUxKZGtxSDlTbUlsQVpiWEVTRS9x?=
 =?utf-8?B?TklFakdnU0o1cDdqS0dCdTlGZ3RaSTJWQzArVGMyYzI2SC96SVRpRVl3ZC95?=
 =?utf-8?B?TEJDSTNBdEFCSmFqMS9ZY3U2cDZqdFNwaFJBOGdpeVlsdzRsK2daS2t6TVVM?=
 =?utf-8?B?ZGhuaDZwT21qSkRDelBJcWRKSlVZdTR1NjVkQlBLUDFhZVltb3VKbkZ3OHBN?=
 =?utf-8?B?SlJhUCtqV1dFWis3M1paQmtUTzBIY3h6VFdqcjhGUDV4Z0w1cWpwSU9LVlFR?=
 =?utf-8?B?Q1pTWGNGSnB4TDRqWis0a0NHTEduSk1kb25DV1VVSXpLMHhjSk1OYnZWN20r?=
 =?utf-8?B?c2ZIWlpvN2RuQ2ttN2YxYXRLSVlUQjV2UHM2M3QrblV5U2grUEJJSXhTSmN0?=
 =?utf-8?B?S0Y1eVV2R2NkcWRWczVKbGlQYklVa0t3M1lyMEVpalNaU01CZUN2TnNVUEpm?=
 =?utf-8?B?Y2R3SktQZFRiSFBicjZhalh5QzNTQkNzM25HMnUwYzNpbWFKakZnNFozWk9M?=
 =?utf-8?B?dlZHanl3YWJJZEtFbEZZKytLbzZkSXNPTEZTREZpUjF0bjFXdTYydVN5ZFFo?=
 =?utf-8?B?cmQxZDdVdk1uVlVJT2xZV0xRODdmUVZ5enh6TnBqQXNER05zdGZ5dE41ZW45?=
 =?utf-8?B?d3VhK0tIYjdGVVF1MnNVbk5raTdCaysxQWYxOTlkNUUvZnF6MEdIM1RneHFq?=
 =?utf-8?Q?M2jztSd8KFfnFwA0jP1amu+Sm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f5b534-a055-46fb-2ed3-08da5b7c6514
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 16:11:45.8427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/jvWvKNoi5rLzH6atAeTZcxknn1gcE0SdHSuoNmVFMTQB4/gtqsJrpbt1IsSjKSlDLSng8Zl1nCf+fxDhelmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3892
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_08:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207010064
X-Proofpoint-GUID: HrQmfynTd3aoLlPF5Db_sW8OCyytZXh0
X-Proofpoint-ORIG-GUID: HrQmfynTd3aoLlPF5Db_sW8OCyytZXh0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 17:01, Al Viro wrote:
> On Wed, Jun 29, 2022 at 04:53:53PM -0600, Khalid Aziz wrote:
> 
>> +static void
>> +mshare_evict_inode(struct inode *inode)
>> +{
>> +	clear_inode(inode);
>> +}
> 
> Again, what for?  And while we are at it, shouldn't you evict the
> pages when inode gets freed and ->i_data along with it?
> IOW, aren't you missing
>                  truncate_inode_pages_final(&inode->i_data);
> That, or just leave ->evict_inode NULL...

Good suggestion. I thought I would need to do more in evict_inode() but turned out I didn't. It is time to eject this 
routine from my code.

Thanks,
Khalid
