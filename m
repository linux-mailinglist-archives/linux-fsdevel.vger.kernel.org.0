Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8456264D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 00:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiF3WzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 18:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiF3WzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:55:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F651B39;
        Thu, 30 Jun 2022 15:55:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UM4QGh003301;
        Thu, 30 Jun 2022 22:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JhNbFHDc6YW6ziVXiw1WZM3nsdyqffH95gz6BliNTYg=;
 b=jlnPQ1RuM2kRs3q8T+nkU37HaeMd/50QamPI/qvTeoEe5xIqPUsyrTNd1zUe7M0NHSON
 KecCb/JBy45Ad4CEwMMLx8LbJxvhxCXfyHjh5M2iMO9h+ouA7oiNb0uUhkRW9QSI8izW
 7Dqbb1MmhVVu/Gl9pHKhUchEytw5G282hZC3sAiSVAnN9+IPaS/gzN4bkjSlUTWoeZNm
 uufZXaS06dsUms9Ald7YDsrJg3IZTDp2nBELqdWRinHt5HMsVwCE62gqy9crPtk29nsU
 /TJau/hmuqz9seSHndczk65CvaKkKtWM1s6CckqAWN1xayni7YOvkPZwp9uCaV5VIfoy cA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscnex0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 22:54:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UMp2tt029402;
        Thu, 30 Jun 2022 22:54:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrtae2a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 22:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZM5nkrc0vdZgVyeFhYPOZojusgQ1tyiDDq+T6yiFLssYKBSxjcUy/5qSjef1jCRsDR7chwvng7qwPGP5bfiXuVYBEWWBd74gan+N7BNYDMSxDe0O8PAT+Y7OPf1fSyPvx/jC31GLEoTW1UaAdZwRVvsBNcdIGEwZeW9WThKE38hIoR3TjbKlqg+Ycde8naS7b46bd7hc6No5HGrGEvKHeuMPqN+nwl7j69vt0/XP+SdXobnNsnuARe5ViJhZV7tF5HUWsZS1rISLVApyg4cxoU/nS51b7JmsUyYVCwMbQOUwyXJyHmLSDjuFeFpK4tovcHYmIithOhMst6pf2DYHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhNbFHDc6YW6ziVXiw1WZM3nsdyqffH95gz6BliNTYg=;
 b=YXFstrAWhQygP6mw9MgwQ0zqiusrDif7jS88J+KfNvHpJkRtjFzkEhhiUPkI0fb8CkePNPPf0Yj9OGGMSat8iE2XeqT9Zyx4prubV0MSW9BOnttw+/2qrTNWubwCZnLRTP0C05Jl/xDTjcl6aR7IeAeRUlRsTxOe5kPmGMOb0Abaku8R0Rn2ZAcVU+gPJ43AbIiHaEXcRA//ZpBScY+PVCQ4qnxlV7GvazbhoGJ5h3GESdltxuWmoDEwsDyiTAhP/gvh6Moz8hVSi3Vh2rnBoe+vAVk5WXEOb7pIdj7EPks82JzMkNkesU1fNDccjh4UsoIjYaNYaEN3eHOhokZdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhNbFHDc6YW6ziVXiw1WZM3nsdyqffH95gz6BliNTYg=;
 b=pqcp1ZS2MsZUSOaSIEGO/XFj3L28DcRL8nRUtQFNS4JeW92+lpK2ZAx6IzoACjIOHN3O6tkn8IUi+F17ymjUj4JoSE6/althgVvXuHAC/GbSrx3K9h37niUrhIbWcL2SEdmZjP5RTbtuLiF00rTNos/AL20srzhNBc6C0Ba/yTI=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1594.namprd10.prod.outlook.com (2603:10b6:3:f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Thu, 30 Jun 2022 22:54:31 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.022; Thu, 30 Jun 2022
 22:54:31 +0000
Message-ID: <528a5c36-d47d-e36a-f5f2-dda464eae982@oracle.com>
Date:   Thu, 30 Jun 2022 16:54:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/9] mm/mshare: pre-populate msharefs with information
 file
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
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
 <Yr4Xqe22CI/ff0ge@magnolia>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <Yr4Xqe22CI/ff0ge@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:5:40::23) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53d904c9-3a78-443f-4759-08da5aeb7e7b
X-MS-TrafficTypeDiagnostic: DM5PR10MB1594:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XcDIe6oct22qpkjSS/9ev5GIj7H3ri9AN7NP6krcObVkCkrEo+830meEoRdl68fyIVTLrxO6/CIDbkIxObKfqIca6kGacM0XKIXkzLU1BvmvauqI/N1uCU5HmPuCzX0stEX7n/fdL5yuqSkcw5Zm1nGsoU2EPcKx3w1miGCG4L8zHti7srKtQLoR+dTqLZLKnSJ1cjFfBAK7Qrf61GnU4TPM2cFJ30G9ItG1DtSSnSTWibyxLiXn+F6/8aKpaM4mN0eVqdzYBB5F46KwE/yRohqzEQEnNTgsVy+ZAHFu7HqGJCdPkv9GF5EjwgXGj89+tF2vNXrp9VUOsbgezKxVbNLtLMSORnaR2hkCb2zNFSlscUHnQo53az8Vc+UDZ2eItYeTuuWK1MYFDg9MRwW9xZlDGHnw7PVAK8bqqzgQ01VlnD7CI9rDvUeNDukRImR26VdTGVE3VOQjHxFAQ1Ftp6Z+oN0R5sbCvdXn0SiFeWdAk+YanSQVkcJtbp90y9nqUDzkfQxMVKIk8qATOTqeMTmiF9JNmMO//Zc26udkgz3UJoOVN40FYSdz3JlOyLiRlMak/cIGE5fEmn7snTV0LiovupYCakVbxR1HcR3SqM+RgMOaBtZFABM6b8g6MmdUzrjhIoI8KQu3lgRKIOYHh1JDJuEQMik5Q6srtxPNw181DVyMnVItjOaHjUclS7VuVB7iujRlcIry9Nq26xbx5i/UHV9WF7tW1Ybr1Ru0jxqwIXoWDdPoQ7oiIxpV3loitin3ZVLHVL26FCaPIolmAGjPh+DDhnbHQv2xfEsXKPNSDvtIJkttgdYhu01cNcPx9LerogmLbqHh1wnSukucw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39860400002)(31686004)(66946007)(6486002)(6916009)(41300700001)(186003)(6666004)(36756003)(2616005)(31696002)(478600001)(66476007)(44832011)(4326008)(2906002)(38100700002)(6512007)(6506007)(7416002)(53546011)(83380400001)(86362001)(5660300002)(8936002)(66556008)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTBJWXo4dlozWnlweVFvUzZDcGlGdGNSMHFUMGg2UTh1MjVJSStySW9SaXdG?=
 =?utf-8?B?ZXlONDNFYTlPK1ZxZFg0ZDdCNFYvTFNzSmFkNWRJVkEwa3BhNCtUK1I2QlBs?=
 =?utf-8?B?SnUzRXpkaFVVWkhYVjkyMmQrL1ZoSnBaaUp3K2o2SS9tdU92MmlneG5qdmxq?=
 =?utf-8?B?MVVzYWsyUGd3VEhmSEM2ckJpMkpVKzdWN21yanRYWWViNldkUlh3eVdwQUh4?=
 =?utf-8?B?NDJkcW9Eb2prUHN4OW9yMUszZEx5c1dmKy9Fc1M0T3plc2hTRytuQkk3RjRp?=
 =?utf-8?B?MXZPMWNsdUFrbG9pLzRrdjhSWUpDWjVwMXdNUnpUWksraVAvQ0ZPRmh5YzVp?=
 =?utf-8?B?RjRpbG5jTFZadytIcWdwNmI2WDdUY1ZvUEFXWk9raVBwcS9rbklNeG1INGh6?=
 =?utf-8?B?bnNvdHZ0cDgzZElZTEdFS0RjOHZyL20xRTA3S1NicUp4KzBrK0lGQmxjbmxO?=
 =?utf-8?B?bnBBRnRNNHFZS3BybjVqaGROVFh1ZlJRb2RIc3J2TzFYWktYWm0vYm53aWJW?=
 =?utf-8?B?cjF4QkwzRVBOOTNvb2dSVm9zUGNUMUt4MHNUby9MTUxtcUdVaGlqMkpjNmRR?=
 =?utf-8?B?ZUxPMjMvbEo0UTEyNHhSMjV4TXllR1lZQWJSZ2hnVUE4eDRmY0k4b3ppNkpQ?=
 =?utf-8?B?RXNEMjBzRFhDbzNTNTF0S0xaaFViNzVtOHl2S3RaUzNJVVV5c1N3RXhNSHJG?=
 =?utf-8?B?c3V2Mi9WOExNazE2aVd6YjFXMnJsQ2NWWFZjNjV4M1R1ZjZOUXdlUzhERHpx?=
 =?utf-8?B?WkN0TklORlN0ekxNdmFqSFp2OUNxOG9EcDF6WjhnNkFhSnVZdUdaUHh3VTNR?=
 =?utf-8?B?RUJUcU54em9nWE02bWk0ODE5dHkrOG9paUhKYW5MRi9paWRXZnQrL05SWEZO?=
 =?utf-8?B?VUNiczhzTWt6MlpYdG0yOHNVTERpSVZ6d3BhUHAyaTAwM0VMWnBCOHA1Kyta?=
 =?utf-8?B?RTh3WmtMcHNZL1g0MEp6Y0hLMWZ0YWIyMDM2T0trOGtFTnN3QVJUWWMzQUgz?=
 =?utf-8?B?UUxKcnB3L0VzNkxJd3BBTFgxVmFOTnRSQ2NLeEZqUE9JQU9Dd1ZVdlFRM05r?=
 =?utf-8?B?cWNqOUpXS2djNjBDQ0lzOGhRVTRLZ2VHTm9naW8xVmRqdjRuSUtaQWc4OFBn?=
 =?utf-8?B?ZXVja2wrTFNiV2p2WC9FMWlEcFZwQzhQSXdFMkdYb1pSQUNEMXpscTdCZnJD?=
 =?utf-8?B?UW83aHRqcW9FdFZLOVBkOExkaVREQlpwcnFrYUI3S0RXejJhOXNORzFwWWtN?=
 =?utf-8?B?OFZSM2Zvdjh3Z01MdWdnTy9LbmZ5TXFuazRrbzJNbGdVMktxSjlkU2lvb1FR?=
 =?utf-8?B?T256WStvUmFPS1l1b0tJTDNTRHU1cCtScllIRTlLLzIrQjBxQjFVWTRsY292?=
 =?utf-8?B?T0dlMkw2aytlWGlJR2I0RkhLLy9UdzRWeWdHYzhma3NhVWJjbTBkaWVUR1po?=
 =?utf-8?B?WUNXdVlDQkZNZzJsMmFnMmxxMFpWVVhHRGJOZ3BOV0x3R0h0T0dZMXUzNEZk?=
 =?utf-8?B?a1R3UUw2UTUrKzlzdGR2WXQyTmNKK0E0VzI3NmdtQ1pYMjJjeWtsREROR3VT?=
 =?utf-8?B?eGo0MmQreFhVTjFwU2VKQzF4cThzOWhwelY3ZEM1aWxPYWVjWXhQTmY5V1NG?=
 =?utf-8?B?YWUyUzM4V1pudjNDRzBiSXlhaENRVDBVTW9UUXFlcmNOM0VTYzl3cHhjcjZi?=
 =?utf-8?B?ckl4czZkTC9LVTVqS2g2NXlzbnRYazJkVnZPNVJ5OGV5WjZ6MHFrdldjdTdv?=
 =?utf-8?B?dzZZeGs2eCtKSFZ2bTNiL3JqNUlheHA3V3ozUlZqYVdiR1NFZDF4YnBqNmFZ?=
 =?utf-8?B?UmJMQll3WkxkbXV3d1JVVEJUZGZOWGRVQmVRYXNtL1N6bnErK0FDcHd2RG01?=
 =?utf-8?B?NFB1d1d1VXljK2ZwUzRFZ0pmc05tUGJyRmRFL1hpQXVBRnlpdHlCaE5YTVh2?=
 =?utf-8?B?RUEwZWtkOFlRUzg0aHVVNlhOTm41dkhMS2doR1RxRm9ib0F2QnNmcmNxNU9y?=
 =?utf-8?B?SFJUaHF3MlUwaHF5NjE1VXg0UGozVG8xVit0QlFRWVBNUEoyRWpoaE40WmNr?=
 =?utf-8?B?Q0RiOHpFanl6RlB0a0VZeUZ3Z05GODR1V2ovbm9rM2hQYnB5bkh4RExwVmQ2?=
 =?utf-8?B?WHpqTEd4eG80Q0E4ZVlDUzk0aG1NTC8xRnVSMFJWTU1sNUVaWTFzWlI1UGYx?=
 =?utf-8?B?RlV3c0lNY0hLODhrRE13UWs5MFByZjZxY1d3QVErYjI3WnRvZElzbWZkNHFk?=
 =?utf-8?B?bUNVTm01RzIwTkRIc1IvNENRN3B3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d904c9-3a78-443f-4759-08da5aeb7e7b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 22:54:31.4200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jijvP81MuG09+VbCLT0xZpfcfcTIbX4rXKy+FN2bdf3xX1akGke1a+bpg8u6p+HBJulb2Fs5EEJTvZi7l53IHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1594
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_14:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206300088
X-Proofpoint-ORIG-GUID: ORIPBe99zvzfjDOwyygxLAPwxfguexAF
X-Proofpoint-GUID: ORIPBe99zvzfjDOwyygxLAPwxfguexAF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 15:37, Darrick J. Wong wrote:
> On Wed, Jun 29, 2022 at 04:53:53PM -0600, Khalid Aziz wrote:
>> Users of mshare feature to share page tables need to know the size
>> and alignment requirement for shared regions. Pre-populate msharefs
>> with a file, mshare_info, that provides this information.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> ---
>>   mm/mshare.c | 62 +++++++++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 48 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/mshare.c b/mm/mshare.c
>> index c8fab3869bab..3e448e11c742 100644
>> --- a/mm/mshare.c
>> +++ b/mm/mshare.c
>> @@ -25,8 +25,8 @@
>>   static struct super_block *msharefs_sb;
>>   
>>   static const struct file_operations msharefs_file_operations = {
>> -	.open	= simple_open,
>> -	.llseek	= no_llseek,
>> +	.open		= simple_open,
>> +	.llseek		= no_llseek,
> 
> I feel like there's a lot of churn between the previous patch and this
> one that could have been in the previous patch.

I will look at what changes can be consolidated between two patches, including this change. Thanks for catching this.

> 
>>   };
>>   
>>   static int
>> @@ -42,23 +42,52 @@ msharefs_d_hash(const struct dentry *dentry, struct qstr *qstr)
>>   	return 0;
>>   }
>>   
>> +static void
>> +mshare_evict_inode(struct inode *inode)
>> +{
>> +	clear_inode(inode);
>> +}
>> +
>>   static const struct dentry_operations msharefs_d_ops = {
>>   	.d_hash = msharefs_d_hash,
>>   };
>>   
>> +static ssize_t
>> +mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
>> +		loff_t *ppos)
>> +{
>> +	char s[80];
>> +
>> +	sprintf(s, "%ld", PGDIR_SIZE);
> 
> SO what is this "mshare_info" file supposed to reveal?  Hugepage size?
> I wonder why this isn't exported in struct mshare_info?

This file gives the alignment and size requirement for mshare regions which is the same for every mshare region. struct 
mshare_info is a per-mshare region structure that provides starting address and size for just that region.

--
Khalid

> 
>> +	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
>> +}
>> +
>> +static const struct file_operations mshare_info_ops = {
>> +	.read   = mshare_info_read,
>> +	.llseek	= noop_llseek,
>> +};
>> +
>> +static const struct super_operations mshare_s_ops = {
>> +	.statfs	     = simple_statfs,
>> +	.evict_inode = mshare_evict_inode,
>> +};
>> +
>>   static int
>>   msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
>>   {
>> -	static const struct tree_descr empty_descr = {""};
>> +	static const struct tree_descr mshare_files[] = {
>> +		[2] = { "mshare_info", &mshare_info_ops, 0444},
>> +		{""},
>> +	};
>>   	int err;
>>   
>> -	sb->s_d_op = &msharefs_d_ops;
>> -	err = simple_fill_super(sb, MSHARE_MAGIC, &empty_descr);
>> -	if (err)
>> -		return err;
>> -
>> -	msharefs_sb = sb;
>> -	return 0;
>> +	err = simple_fill_super(sb, MSHARE_MAGIC, mshare_files);
>> +	if (!err) {
>> +		msharefs_sb = sb;
>> +		sb->s_d_op = &msharefs_d_ops;
>> +		sb->s_op = &mshare_s_ops;
>> +	}
>> +	return err;
>>   }
>>   
>>   static int
>> @@ -84,20 +113,25 @@ static struct file_system_type mshare_fs = {
>>   	.kill_sb		= kill_litter_super,
>>   };
>>   
>> -static int
>> +static int __init
>>   mshare_init(void)
>>   {
>>   	int ret = 0;
>>   
>>   	ret = sysfs_create_mount_point(fs_kobj, "mshare");
>>   	if (ret)
>> -		return ret;
>> +		goto out;
>>   
>>   	ret = register_filesystem(&mshare_fs);
>> -	if (ret)
>> +	if (ret) {
>>   		sysfs_remove_mount_point(fs_kobj, "mshare");
>> +		goto out;
>> +	}
>> +
>> +	return 0;
>>   
>> +out:
>>   	return ret;
>>   }
>>   
>> -fs_initcall(mshare_init);
>> +core_initcall(mshare_init);
>> -- 
>> 2.32.0
>>

