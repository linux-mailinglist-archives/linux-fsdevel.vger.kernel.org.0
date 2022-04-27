Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B585121FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiD0TEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 15:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiD0TDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:03:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB890AFB22;
        Wed, 27 Apr 2022 11:50:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RIUra2032133;
        Wed, 27 Apr 2022 18:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TviayUT3PXcfyV6awrS+DZuPGGXcQv6aNfeJX1XVxkA=;
 b=JKoWvNfawFY26ZeWvcDO07LI8pzg+3XU8qmL4VM646umJhHF4JIaRTMUI13t2i3p4yAr
 oKPT3lkt/dfJRSPUoRehvWEUy8nlHC8JlOE4RsC8bXWJBJa6l6wtQ4pLAdYjfcq8cA0k
 wv5ii1rjNWMI5kflCb/C0Tq2BTDUoRmVvzTi1R3mGWKYs5RmUMXBUXIsnwkGccNlx9xd
 5CzusgqKa0zE78n7z9dhXgkLnsCTCnhKnL6Y9fm+9/lcpXNSyV5mnGApSrtbBjHr/Xj2
 PCDaqUzyKwB8zM++tGtPcf1b90eU23r2j/mPHH6FvrqFe17v3KHA595wlUU+UvJ3Vhhv EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb101kga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 18:50:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RIkaNA016795;
        Wed, 27 Apr 2022 18:50:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ymghn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 18:50:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0o3bHE2gRmBWcBjxrNpNv0Ty78vJupv5XlCClOJef0zOifnOWE7RI4IH6zav6xrtslMH6aG4KiC+viKxOkqg9x66hbJFCewk9lPqAsru53FBkBd97XZczIkG9DtryIYM0FhAvGrLx//pel9HJTHUSQReejJiXpIKyEawuSiBm8SKh0Wd9C9z5AZyxeg6GRKr/B67HrIlaI/KU43VuoQNPbxHFuOq61My5RDfeMLRgAyuKF1ZymL5NFcwgQSu0+Tep/HgW12Ggv9UK+Zbg0B7vV0MPPFxXx0So/scw/IwNyvo1QJIoLpx/UPdJxE7KLh6WY5SgASjAMQzrjr7fOVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TviayUT3PXcfyV6awrS+DZuPGGXcQv6aNfeJX1XVxkA=;
 b=EuONtKYtLUoRinZkycbY4KYgAGSJ41LPaBGFm+nLCcqgXPVqb4XZAiBwPOfgNCCerU8sitX95AtzVrxZeJnCI6W/C5/0FE64XWS+pbQLp8LmskSsI9mhe73USASQ4ho05G8InzZEHrmtVX9jpLqItvEIKfNJb8y92R0CA9kCFxgYKYKrBSDsETZTQRj9VLb+WygDYYxvqs8TFr37l3NAwxlGUdx9O+9BMhNBzuiMkLAOPGRb693NOeUr0d/3gx1sHA69XlTIFuL+i7vgH4U9T+Q5Z2Od+lpJQSKM5RhNeVZ4IQ84VrE5jHKMROnQT83eTYs6zMdmUnBCdgaAHehqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TviayUT3PXcfyV6awrS+DZuPGGXcQv6aNfeJX1XVxkA=;
 b=AJHnWnVdmA9Hy6zLX7ggRPHm9gokAN6aQOb6nsWi0V25ail9g5/5c91Gma7wK7nJ9t0mss0Y3Tv/3pvKfQOgnxhun94UprAm5wgQ5d46Elh/A3YZV9M5f6qcIGAhLrY6TE3CxQ7j5axHjFwRAt3nkHn+kDx93IE9Yuhad6FfLbg=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by MN2PR10MB4303.namprd10.prod.outlook.com (2603:10b6:208:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 18:50:15 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::2cd7:43a8:eaa3:2b85]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::2cd7:43a8:eaa3:2b85%8]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 18:50:15 +0000
Message-ID: <4804b08a-52bb-1bb8-02de-8d861c439925@oracle.com>
Date:   Wed, 27 Apr 2022 11:50:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v22 6/7] NFSD: add support for lock conflict to
 courteous server
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
 <1651049573-29552-7-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1651049573-29552-7-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To MN2PR10MB4270.namprd10.prod.outlook.com
 (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb52edf5-3c21-474b-0b40-08da287ec3ff
X-MS-TrafficTypeDiagnostic: MN2PR10MB4303:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4303C2735CD627E8EA4BCB3087FA9@MN2PR10MB4303.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvHC2r8kKPt9wD1MgKqRFdWoMnmhwEoe9QeRKlRgyYsIc0ZtL2oDhQBQQhwwSAzaKBymqk7Ku/9Zub2cEaYJHu6sLN4gA8PFp1JIvW4ZeqSN80xqpY5hvzS6o1EyxuHxHYKfhCDdwH+fU2mCFBioQg0xgEpE6OxfWEfFyu6WkAy9iffR8xcpmpDu/3lsuhv5nTCJoMA8KDFaUW3EiX6MS85BZiG46SGK/AakHL4U0l46JKcFdlaQc+BlvsnU6iUg8GM/euDtyYxuenU1rfmPs9RhqAStc4FcP3Vi37zLCFigopFqKZLX7MUOIa8aCaD3pm+TbEonf2LO6HYD+gpq4oRf3snvSR6eNONr/c8NS0eJICemoZKuIlR9A6oRLun1jH4dQ8fRHqnLAYSUXH6kln+o6nQepS6NC0E7YwBn9Q8Fu2QxySqimMPU/qrb9gvFydaN8k4uZY5ZB3kWldI4KkseHn4SQsUjiGH0wFnv2LPOmZ//0pT6CPjvJ3wl3El+WSDYF9FHborqtXT1pe0/Spu01s+j5EHIIeZB8xtyhQs/7vc0P1KBG8TyVzLiQBMSQzZ5HjsfLsURd+kB9oNBkXdL5tTHrrcdoac5Gg7CMYAEOILjpjJucwhlustn0VwOI/VPD9qv6Z0QyIldUJSh22VGS0DeyD8vUf0E7Xa2Y4ZWp/eUNZH5xOCs3GqgEMUKIaGwRGWTQG0ZNMOe2e60Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(86362001)(508600001)(6666004)(6506007)(6512007)(9686003)(38100700002)(2616005)(31696002)(8936002)(4744005)(4326008)(36756003)(8676002)(31686004)(5660300002)(2906002)(316002)(66556008)(66946007)(26005)(66476007)(83380400001)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3pJTzVQT20rZXdGOUJ2OHlPTzh1RDBCenl2bDZwZyt0bEY4emhiaGdZeHEz?=
 =?utf-8?B?VGowbjVBa2VqM083dDA4dFI2WUpDd1dtcENjVUdvMXRkWUpxSkJKN0R2ZGtU?=
 =?utf-8?B?SnR0cGxmaXRQTDZwQ09OdHJFbXpOa2ZxZHNNUktrQWNLblVkSzVzQ1pBZ214?=
 =?utf-8?B?NHNyMUd3dGtMNVZFR0pQQ1VRMDNlTm5Tb3N4U3N5RmhKckMzbmNqR3UwT0NZ?=
 =?utf-8?B?ZnEzbzhjTjJScUFtRU14N1JQeHF4dnRtdVBjOEhBTUUyck1reUg5MzNqOWgx?=
 =?utf-8?B?VUFtUUlESjlmUHBCOFFuQnVGQmlxckFjZkVtSmFxVmVTVTFQaHM4bXlFQTFM?=
 =?utf-8?B?Z1hjbm9qYW5WTy9vK1Z4WERCMnJ3ZEVhaFBlNWZvR2FaNmNuZlZIb0hEMWYx?=
 =?utf-8?B?SE5CQXlaTDNUakhnOVdaSThnSmxQS1BPb3JLcCtKa25qUjZ6MkQzcGpWc21M?=
 =?utf-8?B?Q1hxaEVSbTNyM1RZRkFGNzZGVEFqb0FwbkoyeC9MblhnNEpYcndLRUdreHQz?=
 =?utf-8?B?Z01OUzJkZGpRcDFHdGRxb2dZS00rdWlMUWxpNi85emUyK3lYbXluaVRLc0xI?=
 =?utf-8?B?elhKT1dLUk44UVdsYk1GVTBMZG1Hc3FFbmdFUlBpMm1mMHZ4YmxBNGNlSmFm?=
 =?utf-8?B?SVQwQ1lJdC9kUGVkTDE2RjBzYVRMQm9OUk0yblRFbXkrb0I1NFBLa3VoYXEw?=
 =?utf-8?B?SXhPSjdCNFhKQmRIejFmL1J3V285UHNYcFpObEJEdVJRQldEcFFsUGVRZEtY?=
 =?utf-8?B?T2h1VWdjUjRUaHRGU0JMdWFDd2tKRjF5c1NBZW1ZaUpNT0hmWUd5c3FoaitX?=
 =?utf-8?B?TlVzWTNnNG5ic1l5VkI5N3JKTnF3bk9iT29UMUpJWDdFWHpTajdsNHpPcTRt?=
 =?utf-8?B?YWpTYW1DanlmTUNUOENFc2xVWFhiUG13VUh1L20rZlRCZnFMYzJWcGN2aFFD?=
 =?utf-8?B?YjIwcGMrTTNtelhGNUZ3TEp3Z21XRE80T3BXSlJoaklBLzVXTWxpcHZzbU5j?=
 =?utf-8?B?V3NkUzF2TjBjSFhXQ1I2eStTZjhqbXpIemF0VVR0UUNHNWcybFhVMFRTYm9K?=
 =?utf-8?B?WXNMUlZwTW0yenpMNVZja0NibG5xakN2ZWFySUZ3T1pvOXlQL3phUml2R0ps?=
 =?utf-8?B?V3hBV0dUVEl3NGpYRWpsVlN0UDZlaG5rWGhXejNIQ0gwVVdiWnBleHVYbkJR?=
 =?utf-8?B?ZG1oVW5ocytORSs4dE9XK1A5QzA5OVpITmRyNERYN0p2T2I0dWU3dWpzY2hu?=
 =?utf-8?B?K3oySWJwbTg4WGhpNkNWTElvTmpYZ25IY05WZ2I5S1VsS1hmUHZBTVVrTTdX?=
 =?utf-8?B?QWRON3hpMmI5MkNrazNBdjVQN1VkanJHVVVhVWs0MFJlWDNlUWxYUzRIc2Jr?=
 =?utf-8?B?U3k2czZ2NjdpbTB3M0U2K3RXZ2Z2S1Y4eWNrck1ieUM2VkF5U1ZPTGIxcFFE?=
 =?utf-8?B?RTZEUzhPb3JCSTRhZlJ0ZE5MM2R0T1Fja29ISjhNS0ROZEJRTTd4cVVSbU50?=
 =?utf-8?B?YVFlZldsKzZFcUFaTjZ1M3o2dlYvTXpVZlJNOGg5Z2REYi9jRUNJUE5LY1Fh?=
 =?utf-8?B?S3RpQXJ3UWllVEtRZ1pGaTRhK0luaTFaMTdJZERUcVduOTRPYUJCdnFwZXRj?=
 =?utf-8?B?RmZkWit3V0tlSjZJNmNQT1RrakQ4TEVCYmZiV3dmcDJ4QWtaMkJieFVKdGRM?=
 =?utf-8?B?dml5b29rTExFNkh2aFhINUMxVWRtWSt3MjVMZVFIYnk1Q0VaazlCOFR4V2Iy?=
 =?utf-8?B?aXFYNjB1WUptdDVPNTRaOHhuNTAwb3pwd0tjb3BsZTE3ZjJPbm40S0ZHaXNw?=
 =?utf-8?B?bmllMDU5MUlRbGh3NXNnTlk1dFR4ZkZ4SHBjYVhocTRYSjhEUDdSdVNGQkov?=
 =?utf-8?B?dFI3SzR0WDFJZVg1cWltUTZuc2U1RVlZWEs1Zm43UUZQTXBiQW11Uk1SYStp?=
 =?utf-8?B?S2oxTDc5bGU1QkZ0aU00TE1QZk1IQXZaRUEwODByQWVYVnp1NXNYYkV6T3Fl?=
 =?utf-8?B?MFJmQW9HekFDcGx4ZmR0b21yaXRKRGpPWjl0OWlMR0ttZDZQOE5FTFEwOWpw?=
 =?utf-8?B?bXJNTGNtb3oyYUFKNEZmMFpLY0QxL1hMN1JZazZsQ2ZIVEk2b2JuOGpqcVBE?=
 =?utf-8?B?SXZ6azdQc0htSXA3L0xOMW85bk5kazBjNmJnTkFrc0pYM3RTUy9xaVlMdDE1?=
 =?utf-8?B?OGdoWTNXejBtRDBLT2dzcXlhYkxDcjBJZHBQNXdwRGtRRTNZY3dJZzIxOThm?=
 =?utf-8?B?LzVNRkhnOCtOM0hRb0w4UmQ3a1RsbkNmdm5EVXdKdzUxNnhSVzJjZWNJZFA1?=
 =?utf-8?B?aXVqRGtLbUpJclRIMXI2RHZGRFNzT2FpRGJNdExCa25FNm0zRzZxUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb52edf5-3c21-474b-0b40-08da287ec3ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 18:50:14.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SaI604iaIPa3VEGDlnkPTK9FK/RoYoS+ucncxKLIS3k+0Mpr5UpphKJpveYpaYlqrPZtjtUlHKfTzO8chaRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4303
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=995 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270117
X-Proofpoint-ORIG-GUID: 5FT-m76etqc1YuRBrT_Swe1YvT_Vos05
X-Proofpoint-GUID: 5FT-m76etqc1YuRBrT_Swe1YvT_Vos05
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> +/* return pointer to struct nfs4_client if client is expirable */
> +static void *
> +nfsd4_lm_lock_expirable(struct file_lock *cfl)
> +{
> +	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)cfl->fl_owner;
> +	struct nfs4_client *clp = lo->lo_owner.so_client;
> +
> +	if (try_to_expire_client(clp))

I dropped the mod_delayed_work here, will add it back.

> +		return clp;
> +	return NULL;
> +}

-Dai

