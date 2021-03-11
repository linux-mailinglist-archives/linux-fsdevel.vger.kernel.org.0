Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAB3337B97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 19:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhCKSAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 13:00:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56462 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhCKSAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:00:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BHu5wi040927;
        Thu, 11 Mar 2021 18:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xrY0CVS1DDxv+lHwQFNRX1eCuetrB9QUyTos9x9iM3s=;
 b=RvX88uIeuvtymksUGBltk9iwZsvqUvuQdKr8mg98rONC9q+UrfE/OKSAmi930z6P6EAW
 /vgzCpvu1k/xL4kG0rwq5Z1QV2NCYfaSXRtGZi+06UCndB6hEcOtMbroU/cN3rm2rdv4
 3Da+8GOHgpAExh1+NprLVxANHD1aO8JvKKpzkloArcXaEf4ennoscWnkQRKjrPnCnU23
 Qe4Ja3a9h3pAOWaVBqNctw/ABH/CAry4+YKNgD1jCavbFBvPwd6wBzQNyjCq4Cd5ksV2
 rxMVyjYinlBRG26vLbccsglkuyBNfCMfor7N4xehm9tDwOWOcFophWsnIZoLAun2VVkh QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3742cnff20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 18:00:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BHpd2f127941;
        Thu, 11 Mar 2021 17:59:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3020.oracle.com with ESMTP id 374kn2vy5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 17:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljchFqOfbEuv7tk4m7YmiIdn5wwL8Gouj/uMImld0qwho8+KFGTkwXwP0GCKjyl11Stf9y3C6Cb/JI5qZemlrNVu5jfNpCjX6/zc4+OE7d4ZaIweTqt9JBNatqBmskzVJAkW9K5PvAZHs0Zah0zzgvKWXIZ/jse7ZkkMXljfWQ/NZvdcrWec25G5dYdz/DOrYpeS5xeOX+VpR1Y4t6CDsOHhieLlOOGLGhjAf/W2YFezJR0Hiezz+F7hMQvEVOPjUgLBRPOaUW+u1wdwvZRZS9BcYjiub8BUW0BBL+BobutNx8++l5eYTXWGRtnMKFcU32nS+K+A1rzqZk1Hb0EUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrY0CVS1DDxv+lHwQFNRX1eCuetrB9QUyTos9x9iM3s=;
 b=JR6vyhKR32n7Ecu5mM1SGbSeu310RH9tAIebrFRFauSmxGbW/FfG9JMPI+mpy4ni7UuKGUVQ0OKqH49o2EwS7qV6keFm7WffjK0y0YnxmVOZSgzEsPVxF+jxcdVJvsKJMQ4PggREcJYjdymlCr+VgBYmNeWQHAkVIMhfWXz3ytst4vjCyjWz49rJZg75bORlnrmsbA0Q5vEebbjb9wDbcCAGnZr4I/kENWhF4DdAluXH5rnKSyqoRh2FgULFyVULE5C/vem1gcKOHS7ZtntjdiMg+M5HiLfsPrcZW6gL1P4GwhXHLdJHT8ZR44P0zL7p42DkJXcRLB6yuPRuq3NKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrY0CVS1DDxv+lHwQFNRX1eCuetrB9QUyTos9x9iM3s=;
 b=MN27fs1L4D6gxSFUL3pK+IJZi5gob/8lyo4AV7W8VUa75O0ryKs7BV5RhsWOJcIQcMZlNiM+iQBG8vf+ET8nFPxIpMSKAuRzE3pUZOHqu2NcUZ6GO0sALY4/BxDrzpoDJoxg/0dBAkocfqA558mGCsnZvCINY81E+BbD8Rc+imQ=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4784.namprd10.prod.outlook.com (2603:10b6:a03:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 17:59:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 17:59:56 +0000
Subject: Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com>
 <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
 <f9f19d38-f1a7-ac8c-6ba8-3ce0bcc1e6a0@oracle.com>
 <YEk1+mDZ4u85RKL3@dhcp22.suse.cz>
 <20210310214909.GY2696@paulmck-ThinkPad-P72>
 <68bc8cc9-a15b-2e97-9a2a-282fe6e9bd3f@oracle.com>
 <20210310232851.GZ2696@paulmck-ThinkPad-P72>
 <YEnXllhPEQhT0CRt@dhcp22.suse.cz> <YEoKa5oSm/hdgt5V@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <45f434da-b55b-da61-be36-c248a301f688@oracle.com>
Date:   Thu, 11 Mar 2021 09:59:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YEoKa5oSm/hdgt5V@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0310.namprd04.prod.outlook.com
 (2603:10b6:303:82::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0310.namprd04.prod.outlook.com (2603:10b6:303:82::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 17:59:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b0a0d9c-c2d1-4b40-fa5c-08d8e4b77aee
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4784EC6B6F6DA1D43BABEDBBE2909@SJ0PR10MB4784.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMUOuUjQw2AWYkL8OCjC7mDYRrGQzS6sDw/BPXTCupHutKl91mEgSXqo4xGM0bQ1AUse5Hd1t/uO0TKkcyxBTVQ7NRAlZKbDaKMJ57dr9glvMM9J6nFUF1uvPqV1NcFXAMsk7a2ramXELeIJ85HoJ0BZLGgadv40tSa/FesjFtpQzGsDEPhogOgrjcJCZSRPC+bZ8nzF/i51ZwamVLYKh+iViniAZ5TXnw61ZL8Y7tUfmF00bWE/zG0QCjZ7w6nKS6T1VL3j56i21uB+yh/AdGStcWJH8zzV38WwYrXOeAFcf+5VgqS7Jwuhxzi0JA66R1SxAeQ5UKNr1wWrlwG5SAsHsVziXjl7bDPB1m+fD2c5KEW6dBTpKnjQ49jYAk60wm9DJeNbytk9Vv3K+K4vtFKnqwBrBG7cZsnr7IuzClymPp85EHuqJdSkWjyiJ4rYMvnnEECi73kov1U0ZH3I8gc6FWPa/MPg8SC0L7DLDfdApCDxc99C3fObbKiOJTGDewCWWwh69RJyXRbvbHkBVEkGncLR2BAp8lS2OO4JBCO92wm5yVoG47aICoekwnifrgAbUyb3fias03lzAtHdFO5TMfiLBvLnpU5mGh5G8oNsdj+kLKJNAcRlsh59Zw/ri2Y1W2Hj6QMzp4Zz9aoQCTlsIZedSgmdtOoCKMtVXaKjzP9FFX3TCs0lCjm1rBMi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(136003)(366004)(376002)(83380400001)(2906002)(54906003)(186003)(16526019)(86362001)(26005)(2616005)(956004)(110136005)(44832011)(31686004)(7406005)(16576012)(31696002)(316002)(66946007)(36756003)(7416002)(52116002)(5660300002)(8676002)(478600001)(66556008)(66476007)(6486002)(53546011)(8936002)(4744005)(966005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T0U4R0E5K3oyeVRBOGhYamttQ3N5ZjMxdW40VUlpdmp4Lytyd3FYZVBTZ0ZK?=
 =?utf-8?B?aGVWQk1VYzB6U3BtVUI1eVdrTzkwKzZrRXJuc2RFQTAxMlFZRjYwYTBYQUxz?=
 =?utf-8?B?d1JmRHhIZ1VpNm9sdG5CTHI5VzltcUJOQmpCejJOc3lzYVF6WFE0cTRiNGJE?=
 =?utf-8?B?QUVneUg0cU5nK1Zxb3pGYmpGQm9mWmFZVjM3ak9WaUMyVTZraTYxWVc0U1Rz?=
 =?utf-8?B?M2JvVU85RS90ZGFxUVpOcTlFcHFRcGNnUndXQ1hkYStqOGw0Z0trVExRVkRl?=
 =?utf-8?B?S2V0VDNUclJlQ3c1RC9UeW90VUp3S2ZTakhqNFkxT3ZtdUtQWnVmYjh6RDFO?=
 =?utf-8?B?dmhzZ0lpdWNRM2VuVEsxTjRDaXdjWHhnTUtPamE1T2dYcHNLUWRZRytIMENq?=
 =?utf-8?B?dnA0SjdJZ1R5RkFRNlNORUJXZW1HNmpUR0txV09FZHRaM2hXRGQ0bE9Candy?=
 =?utf-8?B?aDdDZ2JHYlNzMFhyRDkybjdBbDhScFF1WWw2Mnh5Szc0eldWODRONWdwUkVW?=
 =?utf-8?B?blRwajEvbGtMclhOSUs1VWI1RzdONyt1QlQrNzlxbTBxbEpSOTlidENLM3VO?=
 =?utf-8?B?VW9zM1M0MVRlUkhEeTBzMG1nanUzMWxPdkFYbmJteklqa2JVRmVqYWM3VGFU?=
 =?utf-8?B?TUtCam5HODRYWVhuSFNLeGdvRlUwVHNGREM3WFFWOEdZSDY4QUVRMGxDeUVu?=
 =?utf-8?B?ZUcyTXVEMXVPU3Y5N1FXa1FqTEJZTFhQRTlGT1ZMak1FUWhOYVVhT0ljQmUv?=
 =?utf-8?B?d0x5ZkV3cFNGQlZkd2NzcXBIZEVTZFl2dkVmNWVsdWhJL293dzc1Z2RCSG82?=
 =?utf-8?B?R1Q3NHlKdzdHWHlIZ3cwRExRSERFRDVUOWFIL0d2UkhhOWNPc2dJYWt4SGJJ?=
 =?utf-8?B?ckdmbU5ZVk8wcy9QUkNvOE0yeFF5RVcxZGJsUlBockozVjJRTWVvSVNQdGlw?=
 =?utf-8?B?NnhvUkdZK1ZhYlNqbUZQQWxaeEJsOWVyRkdXbVMvV1R3TEszczNyNGpoMWVG?=
 =?utf-8?B?SzVHeGRpeTBUMEVsSW9CRk5zS3V4WFNkR1plQUpKTG1GQzNjNlp0TFo1TWJm?=
 =?utf-8?B?YkFZdm82OGVkTkllNms4bThnakYvNXlvT2FuaVZocjZEUXhoL2RLMFhXNm5N?=
 =?utf-8?B?dURycTRsRzRmZ3V1MjlIbW93cCt3NURHR1dJT3hKeGZneGFUUG5qY1FKcGZy?=
 =?utf-8?B?b28zY2lnTUc3UmJ0R1VKb2g0ZFNlM25Ub3lUaDRNQVJqaWRMVkUrbkFrOGFU?=
 =?utf-8?B?MzJQV2RzUWNIcnBXcVcxQVRLbHR5di8rR2ZhL2swTCtaS0h0MklnQTIzNE1j?=
 =?utf-8?B?d0dZU280K2h5VXpaY2JZd2dpSHFibFhxZktRaDBCemtaZmQwTmtwVWNhZHdr?=
 =?utf-8?B?dW15Vm90YllZQ3B5RUdrLytveWpBQ3pzWUk2dFUvSjBlUkdNaDExWFVBYjV6?=
 =?utf-8?B?TjFvMExUYXFYWW13MnFsa09zcWhCcHpXSTdiYnBFR2xwUXY3Y0tqbTEwZ2F4?=
 =?utf-8?B?cG1SSERKSHRDYWIwQy9uaEs4dmdVU3JpNDMxbS9pbExETXlnbWorN2hZOVUr?=
 =?utf-8?B?MHd3dklyT25ON0txcDhGemJ3RmRpRFVpZWNIa2lENlAveTQ1MldPY0ljRWt5?=
 =?utf-8?B?c2k4K3pVdmJjRnpwdjBDQ3N2cm9NME5CWGI3VVIrcm9zeS84L0lmbG9EUnM4?=
 =?utf-8?B?bUxiSlN5Y0tudmVSa05kTmJZelJIb2UxazZ0R2drUzN4UDhWTlVPNjMyL0g1?=
 =?utf-8?Q?cJSmq1H5j79qHUzREBWoknHI3YrsPezPiXa/Gq9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0a0d9c-c2d1-4b40-fa5c-08d8e4b77aee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 17:59:56.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tv8zjhjEgEeiAEDCBbHtjdtTOlV6RoPQI5tHlf4spanaPQeKzqB0bUWx/wC2Cx7dxu7pMWA5tTLtI4WB+cXf8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4784
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110092
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110092
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/11/21 4:17 AM, Michal Hocko wrote:
>> Yeah per cpu preempt counting shouldn't be noticeable but I have to
>> confess I haven't benchmarked it.
> 
> But all this seems moot now http://lkml.kernel.org/r/YEoA08n60+jzsnAl@hirez.programming.kicks-ass.net
> 

The proper fix for free_huge_page independent of this series would
involve:

- Make hugetlb_lock and subpool lock irq safe
- Hand off freeing to a workque if the freeing could sleep

Today, the only time we can sleep in free_huge_page is for gigantic
pages allocated via cma.  I 'think' the concern about undesirable
user visible side effects in this case is minimal as freeing/allocating
1G pages is not something that is going to happen at a high frequency.
My thinking could be wrong?

Of more concern, is the introduction of this series.  If this feature
is enabled, then ALL free_huge_page requests must be sent to a workqueue.
Any ideas on how to address this?
-- 
Mike Kravetz
