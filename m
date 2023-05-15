Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EDD703C99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 20:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbjEOS1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 14:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbjEOS07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 14:26:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB7416902;
        Mon, 15 May 2023 11:26:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FGn863013010;
        Mon, 15 May 2023 18:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DK/XJz2RhZ77iBhOYRiwW0ran2vk3k2+rahQ2zknDUw=;
 b=cWbES/px/1oSBR+AHIU8YW630LCsHg7cMFvJ7ZFPq84YWI7sRUAVUPyrx8VL5YrIZcZh
 f3bNVR3+1tkOUfO+zt3bjJdqIHfQodvR9crxwJQtvKbkyFtXYJIpXkZrVaiuJhXV+OfT
 q8dxDuifz0SFoxTRU1eVNi8u3P+r2ySkH4uP4ekhMSn+TimjRNB9EhaIcL2H23qInz3E
 OrHkVSwdr2Ma9Hvf8CQ6TMGO98rMD/uvqDYKWxIR5snDhPzFMp6HN+nS28lSaqyETQ4v
 IROAAwobLvZ++UouqHkCrQDccx2LBKFYR3GUbjWSN3mJZD/iueZdXB5Aeu/TRSXzXm0M zQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye0p9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 18:26:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FIBn1A039045;
        Mon, 15 May 2023 18:26:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1091m8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 18:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnquwm2rMwuwwg8F9/AzF8eHrtWkAxtxMv5D6eGRTHGFH0RRNtTQhdEAce3heIq2vluNBtOhqTXo/DxugWR8jppj0dlPpaDpbECFWHUCwqxA3squRfTfJ+SOoQ+srjE074qXK6XtYxWvv3b/fVfrJl4sYuy/281IilPHBeyMW9UTxKsfTPDJhmADqx3mpIvsGp7sKb7I3eWUl+NGqmjSBoWBcMu7As2nXlYONcwvdfqNKyY9vt/hMSJEkKsaawsqtvtONopdATp6fjWv8lY6bLpltulBXr8vLQH0xgSj3ybZwZ6oAYN/kQCKZYsxDGmHUnX3OXzGxY1RtVPVFtNkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DK/XJz2RhZ77iBhOYRiwW0ran2vk3k2+rahQ2zknDUw=;
 b=oTKAs4uaFO63pIsh1ofKdjlt9JECusk1XFRd2HhLMqM/WGhewe9TqbleRNsuCmfCqncSp4OOg+GNO6Bj3UqE2lvyEQPvnndYW2zQ3zlWh+8XdMa3nRbSNbu5THcJirga0MHRJJiPomhMX6lAXDe6PBkIKaKKV2hjWkb/u5CMdr/I1Wp+Cp8PYzUAefs3+K4se1evE5IP/jFinGMEchFdJgPV+j3azL3+GkyBhYh2c78hjRH/5+WH9NwnflyLhKO6EyBGcmCxcW9TGGGwV6ddRva7Fy/hnr8pQ4981q64M6P4ja/4+JbDzxyrY2FNqv9VWWNO7V9yW4TtFydjm3gklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK/XJz2RhZ77iBhOYRiwW0ran2vk3k2+rahQ2zknDUw=;
 b=sbnXLmD2XnTJ60g0KoCDZPc74VzY2YPw2nImuwH3jj2JrUDI/K3/iyXAYsunHgLGi+ocTP0Bhsj9RfRstcR0W7eE9nfunNXM0J6YWIKRZh+3Qicjuoe+9aq0oVy68pvCtfRJOziwH969psV6dFdrFKhhJU9jN6Ars5CpvFWob7w=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH7PR10MB6203.namprd10.prod.outlook.com (2603:10b6:510:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:26:43 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 18:26:43 +0000
Message-ID: <392379f7-4e28-fae5-a799-00b4e35fe6fd@oracle.com>
Date:   Mon, 15 May 2023 11:26:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
Content-Language: en-US
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
 <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
 <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
From:   dai.ngo@oracle.com
In-Reply-To: <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0052.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::28) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|PH7PR10MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8fc50d-b27e-4d22-f549-08db5571ef0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NcJPSuOPFAQIcuN2dVEEFQzWgaZROcgwesR+TZAXMfgUj53Oh4U9LmWXhvESZc9MgLjfeudj06YPBA4cjHVtVEWK48IX3JXfmvZVoqR8yWwiyPIWSsUGWbTo7HiN4OnQXyPZLEv+lrZkRf8d4UshlW+MHrScMnWrPsdLtZ7VIH+pMMf1aWERwy0tiYNHgENT8wLWaWCGIIIfIX1Vqhu3+QMe0cmYpvoMsoV8MOGODsmmHwrhmpf8evCmH+kTxTL+iyx1HmrVOIyMl5+PSLfkE3dHVoWARYz5N/bXPVRjQj0zLrWXzy36fPXhXtK0zNZD3zEKKsc2AsYU/YcvFwfg70Ql3j/JFVyKcTir6u/WjuXDEyfOQ3DiOeNrGftaP4bgnTaa5VN5W0LkcojwloMp3kcYpobSu2fVo2rsvJBAZ79y10GU7SlgXy4Ads7LHFqsktkVmDiQWSg53CyuRAehYOfyslGZUIYPx3X7fPBeUwbpzT3C2FfAXVKoyUc5lAytwG5obOz70TQZ/1rO2kxeSDtC+oR/RAOAnJbdTa5Yvh+31tIJJJj2Cv0nkotwbYulCgmPJdFbpMZNf1vULzSCslNv0H6PawG0h/5IhSIanRmY45FAJ4fV87SxdNcIrdwO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(36756003)(478600001)(66946007)(66476007)(66556008)(9686003)(6512007)(6506007)(26005)(53546011)(6486002)(6916009)(41300700001)(4326008)(316002)(8936002)(8676002)(5660300002)(2906002)(38100700002)(31696002)(86362001)(83380400001)(186003)(2616005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW5yanpVazd6cDNUUFIySm00eGY4QXdqelN5cEdUaldtbG5rR1lwZC94eWxo?=
 =?utf-8?B?NE9zaC9RcW5JdmlJTDNDTE5rM2NCWGV0QU9rZ1FvZm1FM20xLzRpU08xUmpk?=
 =?utf-8?B?LzRsb0daUVV1NHVmdzk0aThMWi9hcCtKMFZ1eXR1eWlsUEZpb2pLSHVXS3JK?=
 =?utf-8?B?ek9iQUozUjN1QnBKbkpnS3RDdWttVG1JVG1TZXBUb05sVFpOZ2RDcjBlWnpI?=
 =?utf-8?B?d20xTEtjYzlTTG1qM2pBcFJrTVNsNnNZTHQxYndjQUlWNGc1YTU0K2VHV2Qv?=
 =?utf-8?B?WVZ2Zy9wRnU3cWU0cmtKeloxWFlteUVpbTNwZU0rbUEyQkE5VlFoa2RKQVFj?=
 =?utf-8?B?L3lISzhVTXMwSkxRV29nNWV0MGVDejdUaFVxTnRjZVNZNDNEZVpCc0tvNXdF?=
 =?utf-8?B?Nk1KaHFvb1RLNHBHMUV5UzhsK2xIZGxWMkVLcVB5bDNrL3g4SzRyZW15Y2Rw?=
 =?utf-8?B?MnhzYWR6bWNYUGhEemh4ZzVxZXAra3JGR1NSeDJSUTh0N25DSVJXOXJUR24v?=
 =?utf-8?B?ckVWUVNwbC8rbnRONjFNZHhCeWNqWGRxcklyNjlTRzM0YWo3d2NzaXl0emtV?=
 =?utf-8?B?V2FQKzl1Y0RTNVd0Y1Z4VHgxTDBOL3kyKzh5MGEyVDlPblpSeUFMMDF6dWhS?=
 =?utf-8?B?TWhneEIvRmdUMFRWSUtHUTFmL1lXTDFHS0FXUittd1hhbC8rTVdxcHBQQW9z?=
 =?utf-8?B?VGNzL1BaZmVTTEZyY1drM0hnTnRoTVJHVnZKUVRROXZrZU02WXA0NXBmY1N0?=
 =?utf-8?B?SmZQdHNQVFJHeWU2YjMrTmFpZTNKYXlOd2lyQWJTQUxwUEJndzlqNy8reStX?=
 =?utf-8?B?MXlSTmh5TGZmZnMwdCt6L3kwb1QyYUNxQzFmcVNwZHQ0SHo0VVVJMm5kNDJD?=
 =?utf-8?B?NExYOHp5WFdGRXZydjFDandRM0Npa2VlR09GMnZoUEdLRDAwMFU1YWdZdERJ?=
 =?utf-8?B?K2o1VEF0UlFwcVp1UWZ1YjdsbmpWMFU5dHRkTDR2NG5kOWlGVVJyNlNIcllv?=
 =?utf-8?B?bnk1eHBBdlVtNDNUQTdvZ2RlZ2hKbnRrMnRJWXJkSzFkTnhGd3dZQmYxZi9E?=
 =?utf-8?B?bHJlQ095eWxnM1Q4K2lGaUNKcDdKN2d1ZWJCU0Qzd2Z1WWVUOFN0SW45K1Zu?=
 =?utf-8?B?dE5ydlBid3lvaUwzbEZqdnR3TTZNU3B0SjM1Sm0rcFRVVkhPSXVRTkJTVWkw?=
 =?utf-8?B?bUNnOW5xeStzSnpRTUFXR255SUxNQk54RUJ2MFcxaG5SbVdreU5pbFRJaFZW?=
 =?utf-8?B?UnJpZDZ5b1FseHpuQ2tWZzJaMUNGZFVudUMvZHROakkvdHRvVS9BNVlISy9K?=
 =?utf-8?B?bkdpSDBreURIUzhtNlNSS0dIdEZod3dPKzJJbHJlUDMvcW1DN3A0Y3Z5bCsw?=
 =?utf-8?B?QjdNN21WRC9JNkJUU002YnREL2pSRk1peXNVN3RVK3FFbzgwU2dTY0VsSGtK?=
 =?utf-8?B?Vm13RldSSCtuT1c3ZVFkVXlOMEN4UHIzODE2dGhEK0FMbnY2cjNNWExTVzFw?=
 =?utf-8?B?ZVl2Q2ZYKzZaMnJ2d2tDa3pFekYzSnd1bGp0VzlKaXJOOGdEeTdnMlVMbVdt?=
 =?utf-8?B?bHZZSW9ZbEVmd2M4ZFZRZHNvSldaZmZUblBaa2M0aVdHbVBMZEtGUlRyVmhy?=
 =?utf-8?B?Q01DVHc2N3gwbHFvYzlmR215K1dzNGovMEhPaVlUZVJkNENOT3lJdzlsSDlZ?=
 =?utf-8?B?WXZxTmJ3Q2RRM09pb296OTNjcUJpeEFzOW5zekRrbkh4Q2YvRHVwTlB4SmtF?=
 =?utf-8?B?VVpKdktGeFpMQmRORm14cmg1eWRJbTJXRmNoSjZVRFBRWHpLMklUY05VZGUw?=
 =?utf-8?B?cEczQktZWnVOVHlrMXBURnMvRG02VkQ2eUdmN2xjcUdUWHg0MFlsT1dyMUtB?=
 =?utf-8?B?UFBoVnA3S0hmQmE0YXZibmY4S01jKzR2dnUvREprWCtRRFlJTDhDcHptNnlq?=
 =?utf-8?B?QnBjVmEwVXlzZFhFV3ZaVDVweHRVMzdUalVQa1d3MzZFTkxOYjlkTmR1eVA3?=
 =?utf-8?B?YmlZSUNNaXNRZTBnUnZEeW1ibmNSc0NrUGx6YUpZZlVGRmdNRWU2VnV3d1dn?=
 =?utf-8?B?V1ZKTGJZMjZmKzI4UU9sRlpzcDkvTkdUM2V2WWp0WGVjZVFKUmxaNGsySkh5?=
 =?utf-8?Q?j79xO9WZwKlq77dSMe0w5WdF4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7lQnp6sjsLRWKRFPvyAFsQo92VLGuHtjJNA41y1YfMiLKV/buKOBRHZLl63xOJ0TKlYljR34QK8rWcBzSiKuRRaWdAtalw4zmVNop1iyG0BRpTARj15fiqIDQmlgAXr3OJdSHVIHIMZCxK/hgJouqQsNk7OTdXG2DlosYAlp+rEnGi/EmsgcN/jHBtS81Gi3z4dx4SfMHZoJPrwgxhh7q553MS4slTQNLh/+6KsMvfWV2OyTxmpeelSa+5tqbvucKgcSoVBq3kRyAaSbFn7NYZPWx3oXYP4Z3D4y+oAiVXycn/ibzalGAV0KslPtwE3JEq1oE5PVFXGVNiOH4KEtugAxHrB3rX64gnz65idSaG3EdPD5AVIYGnrUOjqrKyuwc1X3XGPMUINDGej0Pv+1Z/I2a+EB5m95VycpESe+oj6/naKR+sxAlhvx4mDoaWp+9UvDH8nUIX+/WcEukUaRVPvI/N8XYJNua43dfHN9h9LcNDQDZ2zxWEl+eqPlrk71s6PVAq1asp2aLhLN1VwC4F3EPYiB/QF4DTPRBr8lmfHJWVo5fhnEOGtwcI0+qXE5Gg7uK6+6iNj/nHdxeHMTpf57i/9JXrE5N9LGRfFQkeuWYr+DAIdeHy1NH3qeRCHVnv5QbCq0c9OuvWgtC7C8lK7tS+OwLzRlZhZlTiJ5vqBLjFeKeHns81DPI0wE2txZGWiR51GTiOuNEDsZsGpN2wLNBcAfIHZXelDIPpEqDvntjkP+IMweP//xQSjr1N5YCKWbcdpM9pOZADEh1PEsImp/1RoRfTi55eOYOH/u10rxGGsylqKShZfDpyDOz8Vp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8fc50d-b27e-4d22-f549-08db5571ef0d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:26:43.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hS9m1LCUaNnbB2Y0CEpAHx/3blXORoGArfd5XZeL9RpTV7OdANUkFGw8UYF0GVa6hOSAe1cH4pyINZSbllPiUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150155
X-Proofpoint-ORIG-GUID: 7udHCSu7GMyBJZv9qbFS9Q34qjY8_KOm
X-Proofpoint-GUID: 7udHCSu7GMyBJZv9qbFS9Q34qjY8_KOm
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/15/23 11:14 AM, Olga Kornievskaia wrote:
> On Sun, May 14, 2023 at 8:56 PM Dai Ngo <dai.ngo@oracle.com> wrote:
>> If the GETATTR request on a file that has write delegation in effect
>> and the request attributes include the change info and size attribute
>> then the request is handled as below:
>>
>> Server sends CB_GETATTR to client to get the latest change info and file
>> size. If these values are the same as the server's cached values then
>> the GETATTR proceeds as normal.
>>
>> If either the change info or file size is different from the server's
>> cached values, or the file was already marked as modified, then:
>>
>>     . update time_modify and time_metadata into file's metadata
>>       with current time
>>
>>     . encode GETATTR as normal except the file size is encoded with
>>       the value returned from CB_GETATTR
>>
>>     . mark the file as modified
>>
>> If the CB_GETATTR fails for any reasons, the delegation is recalled
>> and NFS4ERR_DELAY is returned for the GETATTR.
> Hi Dai,
>
> I'm curious what does the server gain by implementing handling of
> GETATTR with delegations? As far as I can tell it is not strictly
> required by the RFC(s). When the file is being written any attempt at
> querying its attribute is immediately stale.

Yes, you're right that handling of GETATTR with delegations is not
required by the spec. The only benefit I see is that the server
provides a more accurate state of the file as whether the file has
been changed/updated since the client's last GETATTR. This allows
the app on the client to take appropriate action (whatever that
might be) when sharing files among multiple clients.

-Dai

>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 58 ++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4xdr.c   | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   fs/nfsd/state.h     |  7 +++++
>>   3 files changed, 148 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 09a9e16407f9..fb305b28a090 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
>>
>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
>>   static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
>>
>>   static struct workqueue_struct *laundry_wq;
>>
>> @@ -1175,6 +1176,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>>          dp->dl_recalled = false;
>>          nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>>                        &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
>> +       nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
>> +                       &nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
>> +       dp->dl_cb_fattr.ncf_file_modified = false;
>> +       dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
>>          get_nfs4_file(fp);
>>          dp->dl_stid.sc_file = fp;
>>          return dp;
>> @@ -2882,11 +2887,49 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
>>          spin_unlock(&nn->client_lock);
>>   }
>>
>> +static int
>> +nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
>> +{
>> +       struct nfs4_cb_fattr *ncf =
>> +               container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>> +
>> +       ncf->ncf_cb_status = task->tk_status;
>> +       switch (task->tk_status) {
>> +       case -NFS4ERR_DELAY:
>> +               rpc_delay(task, 2 * HZ);
>> +               return 0;
>> +       default:
>> +               return 1;
>> +       }
>> +}
>> +
>> +static void
>> +nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
>> +{
>> +       struct nfs4_cb_fattr *ncf =
>> +               container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
>> +
>> +       clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
>> +       wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
>> +}
>> +
>>   static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
>>          .done           = nfsd4_cb_recall_any_done,
>>          .release        = nfsd4_cb_recall_any_release,
>>   };
>>
>> +static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
>> +       .done           = nfsd4_cb_getattr_done,
>> +       .release        = nfsd4_cb_getattr_release,
>> +};
>> +
>> +void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
>> +{
>> +       if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
>> +               return;
>> +       nfsd4_run_cb(&ncf->ncf_getattr);
>> +}
>> +
>>   static struct nfs4_client *create_client(struct xdr_netobj name,
>>                  struct svc_rqst *rqstp, nfs4_verifier *verf)
>>   {
>> @@ -5591,6 +5634,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>          int cb_up;
>>          int status = 0;
>>          u32 wdeleg = false;
>> +       struct kstat stat;
>> +       struct path path;
>>
>>          cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
>>          open->op_recall = 0;
>> @@ -5626,6 +5671,19 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>          wdeleg = open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
>>          open->op_delegate_type = wdeleg ?
>>                          NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_READ;
>> +       if (wdeleg) {
>> +               path.mnt = currentfh->fh_export->ex_path.mnt;
>> +               path.dentry = currentfh->fh_dentry;
>> +               if (vfs_getattr(&path, &stat, STATX_BASIC_STATS,
>> +                                               AT_STATX_SYNC_AS_STAT)) {
>> +                       nfs4_put_stid(&dp->dl_stid);
>> +                       destroy_delegation(dp);
>> +                       goto out_no_deleg;
>> +               }
>> +               dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>> +               dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat,
>> +                                                       d_inode(currentfh->fh_dentry));
>> +       }
>>          nfs4_put_stid(&dp->dl_stid);
>>          return;
>>   out_no_deleg:
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 76db2fe29624..5d7e11db8ccf 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2920,6 +2920,77 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
>>          return nfserr_resource;
>>   }
>>
>> +static struct file_lock *
>> +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
>> +{
>> +       struct file_lock_context *ctx;
>> +       struct file_lock *fl;
>> +
>> +       ctx = locks_inode_context(inode);
>> +       if (!ctx)
>> +               return NULL;
>> +       spin_lock(&ctx->flc_lock);
>> +       list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
>> +               if (fl->fl_type == F_WRLCK) {
>> +                       spin_unlock(&ctx->flc_lock);
>> +                       return fl;
>> +               }
>> +       }
>> +       spin_unlock(&ctx->flc_lock);
>> +       return NULL;
>> +}
>> +
>> +static __be32
>> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode,
>> +                       bool *modified, u64 *size)
>> +{
>> +       __be32 status;
>> +       struct file_lock *fl;
>> +       struct nfs4_delegation *dp;
>> +       struct nfs4_cb_fattr *ncf;
>> +       struct iattr attrs;
>> +
>> +       *modified = false;
>> +       fl = nfs4_wrdeleg_filelock(rqstp, inode);
>> +       if (!fl)
>> +               return 0;
>> +       dp = fl->fl_owner;
>> +       ncf = &dp->dl_cb_fattr;
>> +       if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker))
>> +               return 0;
>> +
>> +       refcount_inc(&dp->dl_stid.sc_count);
>> +       nfs4_cb_getattr(&dp->dl_cb_fattr);
>> +       wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
>> +       if (ncf->ncf_cb_status) {
>> +               status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>> +               nfs4_put_stid(&dp->dl_stid);
>> +               return status;
>> +       }
>> +       ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
>> +       if (!ncf->ncf_file_modified &&
>> +                       (ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
>> +                       ncf->ncf_cur_fsize != ncf->ncf_cb_fsize)) {
>> +               ncf->ncf_file_modified = true;
>> +       }
>> +
>> +       if (ncf->ncf_file_modified) {
>> +               /*
>> +                * The server would not update the file's metadata
>> +                * with the client's modified size.
>> +                * nfsd4 change attribute is constructed from ctime.
>> +                */
>> +               attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
>> +               attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
>> +               setattr_copy(&nop_mnt_idmap, inode, &attrs);
>> +               mark_inode_dirty(inode);
>> +               *size = ncf->ncf_cur_fsize;
>> +               *modified = true;
>> +       }
>> +       nfs4_put_stid(&dp->dl_stid);
>> +       return 0;
>> +}
>> +
>>   /*
>>    * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
>>    * ourselves.
>> @@ -2957,6 +3028,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>                  .dentry = dentry,
>>          };
>>          struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +       bool file_modified;
>> +       u64 size = 0;
>>
>>          BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
>>          BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
>> @@ -2966,6 +3039,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>                  if (status)
>>                          goto out;
>>          }
>> +       if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>> +               status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry),
>> +                                               &file_modified, &size);
>> +               if (status)
>> +                       goto out;
>> +       }
>>
>>          err = vfs_getattr(&path, &stat,
>>                            STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
>> @@ -3089,7 +3168,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>                  p = xdr_reserve_space(xdr, 8);
>>                  if (!p)
>>                          goto out_resource;
>> -               p = xdr_encode_hyper(p, stat.size);
>> +               if (file_modified)
>> +                       p = xdr_encode_hyper(p, size);
>> +               else
>> +                       p = xdr_encode_hyper(p, stat.size);
>>          }
>>          if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
>>                  p = xdr_reserve_space(xdr, 4);
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 9fb69ed8ae80..b20b65fe89b4 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -121,6 +121,10 @@ struct nfs4_cb_fattr {
>>          struct nfsd4_callback ncf_getattr;
>>          u32 ncf_cb_status;
>>          u32 ncf_cb_bmap[1];
>> +       unsigned long ncf_cb_flags;
>> +       bool ncf_file_modified;
>> +       u64 ncf_initial_cinfo;
>> +       u64 ncf_cur_fsize;
>>
>>          /* from CB_GETATTR reply */
>>          u64 ncf_cb_change;
>> @@ -744,6 +748,9 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
>>   extern int nfsd4_client_record_check(struct nfs4_client *clp);
>>   extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>>
>> +/* CB_GETTTAR */
>> +extern void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf);
>> +
>>   static inline bool try_to_expire_client(struct nfs4_client *clp)
>>   {
>>          cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>> --
>> 2.9.5
>>
