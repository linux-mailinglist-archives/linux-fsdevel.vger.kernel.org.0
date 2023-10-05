Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BB17BA126
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbjJEOsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbjJEOpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:45:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A49014;
        Thu,  5 Oct 2023 07:27:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395081cl014828;
        Thu, 5 Oct 2023 08:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cXk+VwhjT8EiT6vclE0B1YeihBudxjnADQ5iEjP33BA=;
 b=Mee5bkkOJngPCATLhtxfqcyefCvTinbXiljUImwW7Gv86hh9JD7RWM0ari95aVsrjWLH
 HPNwxTcDQcpPznDq8BQqmC40e9oHEf5/vDkr9HPI5jjQgqVLsP2zj5oXHP9nHOH87bcM
 N8GJ0SFRma3oyg3ZWNwkJng2fusLfFM2HayyQ3k3NuvTCtBYYNdeWII+SE2U72LDZDAE
 1KbzQDQzAeZvbE5G3K76eNZk/GY44j15trwhIcP6MDBG3ZUbg0KRIbDqeNHsntSNPy3I
 M4qc+L195fOkU3oExWW4uCZmRMYMnaLLSiIft0sjjO9zF4uyAkHI2SCqJOnwJ/jWATX5 PQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vgv1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 08:23:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3956678M005811;
        Thu, 5 Oct 2023 08:23:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea48t8dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 08:23:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG2GfRy/Qcyb7rC/VJt6QGwFCimu9HZ8eT/r5RDYeVa2fDjrkvjvWbvgSMakvwDAgXH+/xIQTCfotF2zdoM/Q0x4Ei5oeYqKL3fFFvcaNUvAF4OHY+gW1oKMPrB2GK9PvryOkzDOc8n+80QyxWp5ihyf4nDqVIAyadsMqq/hUPn8JbfCWNGNRRFnJSBp2xUjyw3vc7Hoa83YJRcNHmK2R2115oW4VF3FPWGhUYmCPhn81/pVfDF1nwuK/n6y6fdCG4T3x+zabX2C94bKkDzSp6x45tMcMu8sAk1nH58+4Nl4PxfKNPD2gMDZQGWzICKNqAfViBUxHbxfaYpldii03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXk+VwhjT8EiT6vclE0B1YeihBudxjnADQ5iEjP33BA=;
 b=m254olncUJW2qn/mTZIHJr4rrDF8rDCnAzLgCHl6g2SYgNZd+NofWkjYgGwCTis3+JwY5jyvdJfZN95QoL42ey0ieT1kgaSfrbmQYrTTFhCYSBHl0Sq4LlN+QW+iTP+umCI6jsrWLxE5OyoUG7lVZFAK86hfVqp+OAb4Z/KOxX2fmuw8hoChLQndX8uvkoDZTGAldmkm/9f/+fnhUyQMEFFuERagK3Rml0Ty8cM1O54lwufhdzg8p/qzkjZlzWTArXgOOjLMBldfrl5xI3S0nAhJWEQ4bBDuRt2VbOURMXlb6VenBN6PtWtSdhUOZwSi1JPyz12DBJ6jKPrZ15ci3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXk+VwhjT8EiT6vclE0B1YeihBudxjnADQ5iEjP33BA=;
 b=oUjq8vQOKajHovYcO0bRRDHPKxBlhfExumfUVp2A7tM5BFrrEICP1x3cjj1y22WahcY4DYTlJ5w1+iEsJgpXAWxb/OlQlkp29SymlIyCSaZTA4OEWDAygTHder8caDgukMVrMHe/a+eiw7V0O6FTl1N/cq6n7Q2bn84EDCEFWrc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB6374.namprd10.prod.outlook.com (2603:10b6:a03:47f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 08:23:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 08:23:02 +0000
Message-ID: <f1033cd2-82da-7ea5-7e12-94a2f3793a2d@oracle.com>
Date:   Thu, 5 Oct 2023 09:22:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/21] block: Add atomic write operations to request_queue
 limits
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-2-john.g.garry@oracle.com>
 <7f031c7a-1830-4331-86f9-4d5fbca94b8a@acm.org>
 <yq1bkdfrt8l.fsf@ca-mkp.ca.oracle.com>
 <45bc1c01-09c7-4c54-b305-f349d0d0e19b@acm.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <45bc1c01-09c7-4c54-b305-f349d0d0e19b@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0052.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f917478-ddae-47ee-984a-08dbc57c4a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHuJ+288gpOVazAVmLhq9OOpqUqpiL+7W4gJf631DYU+B6esO/HCijKI15A4eJonp3k6DRLlcZM2bq20LavjqNvV+uqVrph2v6Pf7baY1Wzrr4NUPylYsyxpHbqjbObRYYKzfQ2UyJKfpUfjP4SPnCD+Gkdzx8FQZOC43EDVUGHoTXJSzAqxxVCzRMxasGnp37b9/Bt48waZ8yCfx4OAUx+JzPpHn8MjSIoqaN09FZnF4ap9r07r+Wg6cHW0lwMKstTZnOY7Hd0/hnWgx7YkwyWWxcGIoJcHbNfm7dmD740Lc7aIaq+GefYmrEMpg5DQx6WXNpyebpnlzT9/c95D1sLwoBP37NQXFhNsog7Oz4ps51YRhpgZb14zC1KhqsRHOJ6CG8zjjsYOTKmmD2v6W0jKoMwh3kxHRLaoXWS9ce50Z5Gcg+7ISmd8QoHXQXuRB18tRJkGwfOnAiE9KgSpRdC688uWI1Fk/yowOB+ZNZKrLtdq+fPLMCtPioRX27GitQpX38IftA4Qm0csC1Vql5cTsKyKXCD+ljeeZBHuAsR07efMrHT8t/ZsAGtwhTNYY4m/Z00mHoP5Bz0CV7EdF6nC/qFMJETDFd5RbqDM2rpPEJORYy9ItJh7eiylMI2NDnrsT4lNTaVByFLAX9PSpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66556008)(66946007)(66476007)(6636002)(316002)(41300700001)(107886003)(53546011)(6512007)(26005)(36916002)(36756003)(6666004)(6506007)(478600001)(6486002)(38100700002)(86362001)(31696002)(83380400001)(110136005)(2616005)(31686004)(7416002)(2906002)(4326008)(8936002)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hIRXVGR21ScUVsZDUvcERiQmk4akVXZ1JPdFhiYXN3MEh4WkNwZzlkeWtz?=
 =?utf-8?B?d0NwZDhJWldwOVBDSFgzRFRaUk5VNVcyRHJPL2ppQWQzMFpqYitMWmZJVHhz?=
 =?utf-8?B?V2xZSjQwS1hkUlB6NGQ1cGQ1Sk9jZUl2UW0yV1ZOQk5xakNnM2pNcGVOM2hW?=
 =?utf-8?B?MHFuZW1JWDBkNndic29qWmU5QTZoUWRHb0tabnI1RUZWb1RETTNtWDhsa3Yr?=
 =?utf-8?B?VWp5dzlRQkRPMDB5eEVHU2NjNjkvQ1g3dGdTOU1GRk9xenNJUmlWdzFmQlc0?=
 =?utf-8?B?SCtQTHBkUW0yTTBuMDFONWtMV1lYeStvaUh3MWFSR2JVOXlybExEM0JiNFRT?=
 =?utf-8?B?N2NndndkUjR2V0VXZTV6V1pkWnVBWi9oREdpVEpUQW1lN0tVdEkySHRWSHVZ?=
 =?utf-8?B?T2lJWndPRGRzZWJ5ZTV4aEthNi8rdEJxNWdUaXRjUkRINmVQcktkOWdQZkJ1?=
 =?utf-8?B?YkQ4dXphSWFjZ2d3SHFYaTBxL2dmTUYvUzNJRU9JVEg1cGRIMlk2elhJZnVh?=
 =?utf-8?B?RkFqdVJiRWF2WHlZNDY4U0NTa0grS0k2L0o1dHJhSzlaUWhpZzdPdnBycXJI?=
 =?utf-8?B?UmljYVB3cytHbnkyUmZyc1BXZlVRVzVoUnM4NXBCM1FHcXBrNVpuWmVLbTNO?=
 =?utf-8?B?TDAxZ0MvSmdRRTdVaUx2eDV3NW83SW94YVdZYjAvVmVleGYzMGNac0ZIUm5s?=
 =?utf-8?B?N21XQndyZWM4MVcxWHpUYjVIZ2NmV2NKZ0x4cW9tVHE5T3VybmpYTU9Ycyti?=
 =?utf-8?B?RndhMFVNMzhEbWlPaDMzaXNwcS9NOExaRCs4Y0poeDMyV0hXT21UU0V3UEdh?=
 =?utf-8?B?ME9kZVFJdThDMW1ZRGRySVAvemdVbHloWHpPVkZLWi9tQVU4S1ZCdW1JUDlu?=
 =?utf-8?B?NzkyMXREVlozN3h2QitnZkpHYXZEcFN4V1g0Nit6eFM5bE9ZT2pZa3FUcHlo?=
 =?utf-8?B?KzNjSVBZc01INHhVVlhqMitINEJ0a2I0MCt6WGdLbUlhUnZCVjFwNE1wZW9r?=
 =?utf-8?B?QS9oWWdYdm0xNWZnZGMyUnNtLzNISi9TVVY5eUZ3MDZaZU1PYXliRkpRb0c4?=
 =?utf-8?B?N0JwajAvSTlGUVZvVFFVWTB3QVpQVno3VVYrUCtPQlp0ZHFaeXJzQjNIaTZO?=
 =?utf-8?B?TjVDMktWeE9HRWJWNEhzdEdzbzhmRDNzL3BEb0tOanNPVDhGd3RxVjFjdlVw?=
 =?utf-8?B?NEZ5ZVlNeXVKWVVWT2RSQmY4OU9jNExEYVM0amNnSzFGd2FGb2hFWCtTR0FJ?=
 =?utf-8?B?eGt3UEd6K1BteUpHdGU0S0xvbFMwSE9zTmNlQzBOeEN3Z0o1L0U2ak1WUkI5?=
 =?utf-8?B?VVZXRFRtemZmS1ljd2xIYjN5azUzQUljRnVEM1ZpVkZ2bysxWHBaaDBXRHJP?=
 =?utf-8?B?WjhnSHdNUmMyNHB0YU9kblVKZUNpczdDTm4zaEUxS1VtTHVWQS9wRnhRand4?=
 =?utf-8?B?dGphWU5Qd2Zvek1ubGhPQ3FKbjJUTDJZdkFGVlRmNkt5cmkxeEcveTlBVDJ3?=
 =?utf-8?B?ZHllWDlJc1JiNDlXT1BmYzZYWWg5RytDbXFBZzFocFN0bHdnMVNCWUh5S2Rj?=
 =?utf-8?B?WEpsaW0rbUJaWlR5YkY2RFV5Q0hqNk1MYXNqTDNHZlk1UGVTUk44SFltT09r?=
 =?utf-8?B?VUdqemRoSkRoSHFVcW5zZjVnblUvSExUNUpuS3FucEptNUJTaDNyMEJwaTFM?=
 =?utf-8?B?NVZOWjRsVW9DbWhhRVNpZzgxWFpBUm9oSXBvbE1aNS9qaGt0NTd2Wk9FV0RB?=
 =?utf-8?B?UGRnT282ckg5ODVFTzhVRzhnQm1qQnd2bk4wR2hJS1FUbmVEaVVVTE4xdjAw?=
 =?utf-8?B?UUxJQnRPMkZCc2ZGSWtNL0lFTFhEbzdMM0RhVXAxcEMxQjRQbjdDL3E3VVd3?=
 =?utf-8?B?enZnTWY3cUFsZWRFcjQwZDNHYlhuVVc1WHlobmtWTlBLRkRPbXE4NC91STYy?=
 =?utf-8?B?VUhXZk1tZ3lKNnc5SVBsV0RPdWQ4RzNxc2Z2OFFxSHFoVWlScjVhQVREUTRT?=
 =?utf-8?B?b1dON3RVZHVyV1NKYWtVQW5qWnFnT0pyMVpWV005R1lLNnpBMHhzUjA4ZXNq?=
 =?utf-8?B?OG56TlJtbWlUTVREMzJ2dFhBeHBmMEtOaWhkd0tESGhmSnhBN3JmbXBnVVJN?=
 =?utf-8?Q?iAW81TfbV8AGhu0/qw2dVeeY8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U0N0bmw2d2ZUOWN6NUwvNHdMb0JtVG16NHFPMnRESS9sUmw5d0hHVzdEcXFX?=
 =?utf-8?B?V2k0VVNPTVRFWVlJYnh5TDhvaVRvODBQOXJwSU43SHdQRVFQUkR3OHMvOHRS?=
 =?utf-8?B?eDRKcEM5R0c1L0VKZnd3eXVIUk1LODBWK2pwUWE0Tnl3bWpuZnlaaDFJR1JL?=
 =?utf-8?B?L1lHOTNON21nQmZ1N3NueFo5ZzZUODErUStwUGEyTys5VFlpb3BkU2RCNXlh?=
 =?utf-8?B?ZnBjUTcxY1B2T0ZCQmZQc2puY2ROUGxuenhjbmtkaUxSUWlhMmZlZEVqSUo5?=
 =?utf-8?B?dlBiZDF1UFFiZ1pnRUl1UERUQTZTNVlmRWh5TDRvL29kTHVOQW9ZSFY1aTRG?=
 =?utf-8?B?NjhtY3lMd2dhY3RFV2tqdzc3cDZxTzRhRWx1OExzb3l0K1BTQW5ndmR0TXRu?=
 =?utf-8?B?Ui9HVkNUNVJ4eDY1aFVsTkNrOXM5UEk1bDgxQ0RLbmpaN2ZUZDJtMzUzays4?=
 =?utf-8?B?bGViTWIxM0x0VEErVkduK1hDQzlQVlB3bVN5aUdjL29zaFpHZmZyeS9VUDB5?=
 =?utf-8?B?YjJDMFcwczllOVdPaGQ3ZzZTcHY5aGEwdlBReFk4Q2hzZE50K25LR0w3emcy?=
 =?utf-8?B?ZmY4NGJBdU1NMnlvS2ZZWE1GRmFnVHlwNHZ5TGdhL3BIQlBRQ0FONnRwVlow?=
 =?utf-8?B?ZlNUSVI2YlBJZkRuVHlOeWNZeGtyRjY1UkNiU0N6alN5U0Zqa1JwTzlaRUZU?=
 =?utf-8?B?REZIOTRLWjZCcEtPVlV2a3FaQjJjcG8vUDM5UnFXZ3E5a2ViNzBNSUFqR1Jp?=
 =?utf-8?B?NkhteDhtenUvczRYSTBUU2lqZ00vWkRDR1JaMmUzSmhWZlE2R2hPbk84bTBX?=
 =?utf-8?B?RjRoeUNKN1NwZ1VPSUNCdm9tZGVJQllreEl5SU9wV3ZwMmxEL2Y4K3MvejhO?=
 =?utf-8?B?WUxLZVZJMEtIMCsxZ0JDYS9vQ2Y0dEJaaVRVS0hpdXczUnVDRllhRlliTmto?=
 =?utf-8?B?cW9jdjhoSXRiRTUrTCs5SVFSQ0FWR0lTMXJFak0wRXkzTnRHVnFZZWtyZWlN?=
 =?utf-8?B?YkJ6U1NVc2h4bEkxMUh1Rk9FWnZqNlpMcDZWSTk0NGZFZUNvcHA3U1Y2Z1Q1?=
 =?utf-8?B?RVg1WGpNOUZTbm1aNzN1a0QzemJJaGZXTGFJSkRPK0NrUmNpSFdBK1ZHdXNO?=
 =?utf-8?B?enNEbXRSM3lUUHdFTVRjTllpS3RnQVJsWW5mL25FekFjT0wrbXBEUTZhS0VG?=
 =?utf-8?B?WmNUcnRPRi9sNXdjSkRZUUhSWG5IdHVYRWs1ZnM4U1NCYVVsWmpsSUtKd3NI?=
 =?utf-8?B?R2NHK0h6d0IvQnFwdFhBODNkaEhWaXJvZ05ESWx6UGhLRjg3c1czKzN0TXFz?=
 =?utf-8?B?aWYyMVFFT1k0VWFwaUlWWjg3eG92cmluLytCbjd2aHBQbHJOZFZvRG9zOWNW?=
 =?utf-8?B?SWZFa3FEN0pkN3JUMDlOZmhsanMrTEhJQ0hiYStFZjMvanNCSEtCMHZGdmlz?=
 =?utf-8?B?WXFGaGpGN1RteTdLWnJZTEllazlDSitVbHZId3piZXNKdmxaZDRiOURlUUJC?=
 =?utf-8?Q?TqSu1Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f917478-ddae-47ee-984a-08dbc57c4a18
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 08:23:02.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0Oei4ac1f8TgOostuOtbz5hzdUjr0mlMYCbAsWrBqnlEz+zJeClMjDPmml9DFk8cGdTQk6RuBrDvi2UbMPYFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_05,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050063
X-Proofpoint-ORIG-GUID: spK9u3dXW_sN1Cn_WIM8VtyMibWKc8YB
X-Proofpoint-GUID: spK9u3dXW_sN1Cn_WIM8VtyMibWKc8YB
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/10/2023 22:00, Bart Van Assche wrote:
>>
>> We only care about *PF. The *N variants were cut from the same cloth as
>> TRIM and UNMAP.
> 
> Hi Martin,
> 
> Has the following approach been considered? RWF_ATOMIC only guarantees 
> atomicity. Persistence is not guaranteed without fsync() / fdatasync().

This is the approach taken. Please consult the proposed man pages, where 
we say that persistence is not guaranteed without 
O_SYNC/O_DSYNC/fsync()/fdatasync()

The only thing which RWF_ATOMIC guarantees is that the write will not be 
torn.

If you see 2.1.4.2.2 Non-volatile requirements in the NVMe spec, it 
implies that the FUA bit or a flush command is required for persistence.

In 4.29.2 Atomic write operations that do not complete in SBC-4, we are 
told that atomic writes may pend in the device volatile cache and no 
atomic write data will be written if a power failure causes loss of data 
from the write.

> 
> I think this would be more friendly towards battery-powered devices
> (smartphones). On these devices it can be safe to skip fsync() / 
> fdatasync() if the battery level is high enough.

Thanks,
John
