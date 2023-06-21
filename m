Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35B173925B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 00:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjFUWQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 18:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFUWQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:16:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4619C;
        Wed, 21 Jun 2023 15:16:33 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LK8YBs030147;
        Wed, 21 Jun 2023 22:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dxaRlKdg9MOIrthGDIMATvuwiTUwmk1xlg8RiGIOavw=;
 b=ZTIwT/bn6DKdj/h2JZJxpBsQ4iYDqMXSwL7XaSsqbHYyo/3WLwEsyhCgqmxZIiKgjspw
 bMxusEcWQtqNvsE/6Z4ArnSpXT1rhj9aNq1WW8KUIGMMeS0JTsFoDZFjtVg3WkRF/oeq
 eb5GRoSedPtJ79hLtDQn4ogG1CPyBjbHdG0eDViGiV76VJQLdzYxz7Q8PMKULFJXcEEy
 Egz9M8cLtOzgKYv4ZW89uUQ59E7VYPlc+F2MBG//1dQ/d5F0RF8VOCH+vLbuZ32US6+S
 C4mzM0W4xuGdnNHgPmyv97d1h+VpT3OQjAPdsVxJD1COZEWoHPYEX6nt5Okwxlm85Ejd IA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbrm2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 22:15:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LLT3bA038670;
        Wed, 21 Jun 2023 22:15:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9396nk0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 22:15:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAoHMO8qfYHp2Fq3zKht9n5kDX0jXvB33oFSvl+hkJ77UlzyU+oTyEkRwj6qLdRWVqu1JJgxBoEJcYy2ZB2qm7894EzYxQMBVAhq/iTAo5mJF5Udpfo4tmHB5Gd7W363bKHvIXvEW3A9TtjEnK0Zv2jI+lwXUPuNGuPjwpiPkunTnELenqCPgtmiCvqXVNBBKmLfs2vQWEDenXpyHF2ujofpTLHZ+eBs/zNLKbLPbeIRxtWqnnz7d8zAowq+5I/ph7XRsmlqdD4fORE0rLrGoBoDC9wm4Jzfjzkg1tEfXlf7aQi9d9RNsn+tlVhBnkazr7nLv/i/DNZV7cC6fBx7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxaRlKdg9MOIrthGDIMATvuwiTUwmk1xlg8RiGIOavw=;
 b=PNStRpigQjQ/AuH46XH5dac+8z91GJ+F8t2H2ZVMBFmWknPhkujbEF+PkRohsy4KV6MDF4yUi+lSF9FgW/aaRCCmV/8Lv8qaNuD+z+NU+X+2z5laPLn9tgf63rkbetziYw4WFu48nCiwzsnVC1Dl7MKE01jc5aYc0VtdAwBiQNoP7m0W7uQA0xMARgpALX4+8uDPGBUvyBQ42V1LfqfgY/wwQ/snYeG8iIFvizqr6prx6Sil5ghdy7XqYdOOzW95aqi6yEhb5qJ1yt6mmcMqDvXbTb0UR5fJdKb6nWhnbjRWF3ffiSg6xv7pmZ0338RxYCZuzH8+o+yhpBNZwBSG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxaRlKdg9MOIrthGDIMATvuwiTUwmk1xlg8RiGIOavw=;
 b=xiAmSV66r+sHgjJn7mMeAfGrrk1LuncMpQsTvUhrge49wcw5uMpdpjQ6MIE2Dc4u6LvHoy4WzevvNO/x5J/hjA/5cqnaH8/Be4yVQR08u6cVsJpZ4Z8ByK7AuFh5SZ9QdUfHF+HBS2DFc8iYBuXIOf/rl/xugDcvQQVLKNBoPlY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BLAPR10MB4882.namprd10.prod.outlook.com (2603:10b6:208:30d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 22:15:12 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6521.024; Wed, 21 Jun 2023
 22:15:12 +0000
Message-ID: <ae101ca7-2bad-942d-14a3-7a44588d4913@oracle.com>
Date:   Wed, 21 Jun 2023 15:15:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] Revert "page cache: fix page_cache_next/prev_miss off
 by one"
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
References: <20230621212403.174710-1-mike.kravetz@oracle.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230621212403.174710-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:a03:100::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BLAPR10MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 90706f38-1306-4b65-bac7-08db72a4fb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmISAefAvw4w84ufogS2a6hjm6a+ouJ/VAmaxypid8YR7UhNnEpGeNQAg69BE6R9KFyy2WxnzFM5b0Ohj4Dteq57iDM0U6FCBlSCgEp8KouprLkLMwszsN3dFw9O7CCCZCm8i2kRxIGl6fU/bHAz2djIN74VTvbSkWQ40eA56ekyVYRHlCL6dQWOyDD/W8E6T0Og0XGT3lQa5/jI2k2tHRE/s839dHdbA8Fd64u0ErTe31QCmXG9eI2eZLlaWQ86OeNx06wD4IxZcxMckug1yXUmuTe7Cxe9NABt3FMUsun+MvfBJamDlzDR0zIhxnbQlv4923brvagCOD687qK5VLf6RicS3NlAQrarL+UP/RxUH/h5Q7A9edhnrzogAV6k0A0zyyfmYCLCgKOm/easJDtaxMdtsYFPaNg0oyWiYrfhfmBOSypGTS/sz+S1PXslgQ6jpr/fxGayMxWCWzQihjSDt6Npa9A8k3ItwZlzo3daz0LN9PQ1YPDZKq4s220kCQ+tuCOLiDru0YXhoqkFmz7dAWrol5kcvsxu3bDPk1EUl78rwCWAjAODOgYY1+Y3x8NkcBDDw+wcbO+E7X4KAIdUHp1sxSnf3o026V9UUklpmdSExzERG5xEG0d+rN5qGQs2dN1uUaPd5opCN+3j2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(38100700002)(53546011)(83380400001)(6506007)(186003)(2616005)(6486002)(966005)(44832011)(7416002)(5660300002)(2906002)(8936002)(8676002)(41300700001)(36756003)(6666004)(478600001)(66476007)(66556008)(66946007)(54906003)(4326008)(6512007)(31696002)(86362001)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2dxTGc2allEVUVob25UVmxzc0taeTRtK1lKeHE0UjNMMjVDc2xGZHQ4M2lF?=
 =?utf-8?B?WklUZS82YnRUMlpDQ0tEcHg1ZmF0Ym4rakpsd05ZOUFkZFNEUTJXYWhJZkVl?=
 =?utf-8?B?R2szYklnQnV5VE5CajlGRE55K29zMWdyTlNObnI5QkdUcWhWOUlzS0l1UmxZ?=
 =?utf-8?B?dlNBbmd5anhQeUpXdU80dFkxQXpra05LeU1NaHZXMGxaU3AzOWMvNi9QNkZZ?=
 =?utf-8?B?U1ovQ3oxU1d0Q0d4UExpNUF6RjEzWlFlQlFZRWhPM0c1SmVzWDlJbDZiRGo4?=
 =?utf-8?B?S3hrQ0NQakUwSlM1bkRZbFQ0Z2tyb0d3cXFoY1dqdTBHc0tCSWVFa1pwamZM?=
 =?utf-8?B?TmNsUDRoR0xnQ2VEb3lDdW1UZzVnNXBteXEya2VHNHRRbzVpWnY4WFMvUitK?=
 =?utf-8?B?eXp3ZTdKVzJDc3ExN1NraWM0VXhBR2lteVhkSkxkcGxjV2tUNWdqVWt2d1VN?=
 =?utf-8?B?Y21uWmxyWnJNdjI1anlPL01uYm5ESXhvZ3NBUkhZeVJqbFpDUnRpMkdUYVhR?=
 =?utf-8?B?SjdXdXVxeCt0YllFcUNReGFaQzJGeERlUURQY1lvTG56cFJlR1hZL1hPbW00?=
 =?utf-8?B?SlhlYjV4SG5qQllwYXdQUkkwN1dNb280ZzlwQk5zRFlpY2NrOFZjNzdzTDI1?=
 =?utf-8?B?M0RIcy9pSk1RSy9zemVjTm9JQzlmUHhSYVZsTGhYZ2NWWWxOSnh1WVZSamhI?=
 =?utf-8?B?eDhBbU5hL2p4V0hzQkxHb25vS3d5bmtWOExhNzNSbktvQ1NXY01aQVEwcU9q?=
 =?utf-8?B?SDdwZ1JKVHdmeUNRR2R2S3VFdWFnZkVaYTBzTS92UThnZGkrK1dOLzhxQ3F6?=
 =?utf-8?B?ckkyWjV6MDAvV3FVNGJDMzcwanV3Ukw1SzB1TUJPZG1kU1dVOUhFNjc1czN4?=
 =?utf-8?B?MkNSL21lM0txNkEyZkNpaUN1Vk9LUmJvTzBIaWpLdkh1NlhTRHVmQ1h3UjVO?=
 =?utf-8?B?YUdUZjU5WHBLcllpNElCeE5BWFZMUHdOYWd2Zmd2VnZxMm5Nemhqak1wdzdX?=
 =?utf-8?B?c0pNS3J3OFJiWUFHZVR0N3N1NkMxbXovVHM2S0FmeGZ4V3p6eVE0MDNTQkF4?=
 =?utf-8?B?ZWJ6RkN5ekpNYWhoNUVIUXlTS1RhNzd3R3JaaTdVV09BZXB4azdUczB4cmJh?=
 =?utf-8?B?V3lCZ0lkeFZNK1hxb05xaVg5Z0VCT3ZXVTZSRWhRVVNxRjNKM0RKY25KN2NK?=
 =?utf-8?B?VHpkQi85VGZpdERJZ3dsOWtwNDZwUDIvKzk4dTVFQTl3cFZVUVhhVk1sMi9M?=
 =?utf-8?B?RE5Jc3U0Q0ttSHRUUXBHTlE0QXd6b3k5ZFVzUjR1KzlPcFBHazZ0bHBvanFo?=
 =?utf-8?B?Q2lLcFpCcVl1ZWxVOW40STBHL1VjcUd5Rnkyd3lOaVdYMW5HNHh6TnZBZi9n?=
 =?utf-8?B?ZUhvZG0vNHhka2RJdk9NcFZaakxFais4L3JjeWJ6MElHa1hkTUtOaFhYTWl1?=
 =?utf-8?B?YlJ0Ulg4T0M0N3VIaVNrb1ZrNzhrbndrUWx5OHNJZ0ZBajNZc2ErWU5uT1JO?=
 =?utf-8?B?M25kNHprUTdGRVpLb1FROVZ5VlNFL1dCMm91eGE5eUVha3duVnJWUlBSNFQ1?=
 =?utf-8?B?ZVhtdWtnRy8vTElDQkpIR21oeWtmQ0xXWmlmK0FsQ0ZjZzlZMndPUG1MVi9X?=
 =?utf-8?B?VjhzS0UzckJEcS9KRlZKWE4xRTd3cTBTYVFDNW1TdnE4YzVzQ3VVNE0zcWZp?=
 =?utf-8?B?N2ZYY0JpRFpLMmVPY3p6U0t6VFp2YVVtZ2grZ3NpV1VrY2Uxa3pib3drbFda?=
 =?utf-8?B?SURTdU54OHRFdDN2Z1VQWnJkRXF6UCtvek5LQjU5cnhZdHlqOFByTDZLSnlj?=
 =?utf-8?B?UVorYVRmM1U3RHJJZVNjSm16Y1hhZnNwaTBOMkM3dXRLNWlaVmpkTmYzVkNz?=
 =?utf-8?B?blBHTVYvNFNXSVJuVnVvVkI4b2ZHcjdHN3lQMng3cEEvVk0xZlNGazQzNjdD?=
 =?utf-8?B?U3VsM3VaSy9YazlveHJDbUNWMTg4NzdTeDcrMlA2anJvdDZRY1MrOE5mTlpU?=
 =?utf-8?B?cmJ3T24wZ1dwNk4weXZYVEVIS2pybGloQ2drMGFpZFRBaFJydDlaREN1cnVj?=
 =?utf-8?B?WWhFam5zWmxld2lETlREcHZiR3RnUkZZU3l4di82VjA2WWJYRkhEY1d2NmMr?=
 =?utf-8?B?MzdrME1BRHYybTNKWUwrL0FEcnA3TkROcGQ5OTZZbHc5bmIxTEJOd1VFZE1T?=
 =?utf-8?Q?HXZQjAgzUXqe7uuMeBCXLMM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OFVsRmIybVUrWXE3OFNxZ2tzT29SYkZCdE5WZEFDWHpPT3VaSTdJaVcxKzBt?=
 =?utf-8?B?SUxna2NFMFRHakhDZkRMcnBCYTFjZmFCYW4xU29tOGcwSSsvUElWZUs1aFNr?=
 =?utf-8?B?eDdkL0JNdkNmWjhOQUpxN3dHWmc0Qzd3VEJDQUtOVVN3MlZ4VkFVeWZMRGNp?=
 =?utf-8?B?ZWVMVjFRNERrTmFudVJnZFVkNG1XWnF4TkJ0SGs1TXloM0RCaWVLVlcvdXhz?=
 =?utf-8?B?dXdDMXUrV0dkL0s0QmxLSng0aHhQd2JxckphdHNKWHVuOUViRE5leUtTYVNk?=
 =?utf-8?B?K2hOdHN4bjBTYjZmeWsySDJDSGg1cUMvNlB5Y1d2Qng2NDRndXNwaFcxTTNq?=
 =?utf-8?B?R1RTRitZUkZ4aVAwbU5SNW91c05FSXJXRThxQUtaUjVUUCtUNE1jL1djOHRW?=
 =?utf-8?B?UUJNbElPUUJ0L0JrdzRteWNvYk1mVUpFZ3VBeUxXMzFaMXU0UEo0RUZCR2Ju?=
 =?utf-8?B?OUVRV0JvbVRFMytpRWpUS0xRMjdtc2tKb2JrNjhtVmVrelZWcGg5RklKcTMx?=
 =?utf-8?B?OHo4MFkyNnEyOGM2emRYY2pFMkUyclFCKzh0MUZzTkpwNFA3OVc3RnlxNXda?=
 =?utf-8?B?eUpXNDlwdHpDUDZBTEkvaWZCZmVnWTBqWGJ2SDZrU1prNDFENmZCM2NRazlV?=
 =?utf-8?B?NC9LOHN0bitBK3FWZ0Rzbm5zZkVjcHZKejJ4UEp3TjE4TVdYOVpCSTlGLzVK?=
 =?utf-8?B?MDduak5Mb3Y1VVppTHFwM2VlMlF0YUVPOHZpc1hSTTR5azdXbmFjZDRLeDZi?=
 =?utf-8?B?dFdzRUtaWWpTbjU1ZEtpRmxHdndnRXZCQlIyT1BKOW1IVVJVOXV5L1dTV1Ns?=
 =?utf-8?B?dmFzUExUNzc4VVJ5UVU1YmhpemY1NGNtSmI1UHN2NGRkTHN3RDM4eTIxMnBS?=
 =?utf-8?B?UWZNemNFWGxUdGtSUDk1SDg3NU12dWZUeG52b0l5V2tGUTZOZ0dCU2JKVVRW?=
 =?utf-8?B?cXpzZ05sNEdzVEVWUTB1VGh1RG5TM2xmUTBzbUZwMUsyYm1jRnhFNXpveldD?=
 =?utf-8?B?WEZWL0V6SmllVDVNSHNXdEFENmVSanJsVy9VbDdTeGk0K1dIOUlXZnA0b0hI?=
 =?utf-8?B?UmNRUTF4RlVIRDJvb3g3cDZrd1pvbjhvN2kvdlBBSG0vKzBaVEpaWUFkQVZi?=
 =?utf-8?B?Mk83VjhySWRFeHkyRG93OXh0ZXhUdDQvUFRXLy9DTG41UnhnMHhhTFIxZHZO?=
 =?utf-8?B?VUhjQ01abW5OWnM3QnpvUnp3Qlhxa0QwbTVIMEovTjgyRUQrMy96Ui9IMWxL?=
 =?utf-8?B?bkZ2UmRCb3ZDMHdCMFJxbEgvQXYxcHlhU2d4NVdEdHQrNnhJQUZuZnZKbjgz?=
 =?utf-8?B?dW1BaDFjckhBK0k0Wjk1RVVJK0krUkp5V2JkZHFDSW01SHl1WVlRcDhnckVD?=
 =?utf-8?B?Z2hvN2gwd3hob0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90706f38-1306-4b65-bac7-08db72a4fb98
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 22:15:12.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4i9DxQ8dWa90jYDeTEqBbR9qfJ1Jj2DQ7LJIOGfmoCXEXpXrUiNemXxAYBi9N2t3uyEbLVwYz6vQnczj2gu8Z0/3xTr0HOPl++QY9GTbR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210186
X-Proofpoint-ORIG-GUID: 6mVS7Bm-0YJFSTcl6TfTqsEgG0vP54Mu
X-Proofpoint-GUID: 6mVS7Bm-0YJFSTcl6TfTqsEgG0vP54Mu
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/23 2:24 PM, Mike Kravetz wrote:
> This reverts commit 9425c591e06a9ab27a145ba655fb50532cf0bcc9
> 
> The reverted commit fixed up routines primarily used by readahead code
> such that they could also be used by hugetlb.  Unfortunately, this
> caused a performance regression as pointed out by the Closes: tag.
> 
> The hugetlb code which uses page_cache_next_miss will be addressed in
> a subsequent patch.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202306211346.1e9ff03e-oliver.sang@intel.com
> Fixes: 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by one")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/filemap.c | 26 ++++++++++----------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 3b73101f9f86..9e44a49bbd74 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1728,9 +1728,7 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
>    *
>    * Return: The index of the gap if found, otherwise an index outside the
>    * range specified (in which case 'return - index >= max_scan' will be true).
> - * In the rare case of index wrap-around, 0 will be returned.  0 will also
> - * be returned if index == 0 and there is a gap at the index.  We can not
> - * wrap-around if passed index == 0.
> + * In the rare case of index wrap-around, 0 will be returned.
>    */
>   pgoff_t page_cache_next_miss(struct address_space *mapping,
>   			     pgoff_t index, unsigned long max_scan)
> @@ -1740,13 +1738,12 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
>   	while (max_scan--) {
>   		void *entry = xas_next(&xas);
>   		if (!entry || xa_is_value(entry))
> -			return xas.xa_index;
> -		if (xas.xa_index == 0 && index != 0)
> -			return xas.xa_index;
> +			break;
> +		if (xas.xa_index == 0)
> +			break;
>   	}
>   
> -	/* No gaps in range and no wrap-around, return index beyond range */
> -	return xas.xa_index + 1;
> +	return xas.xa_index;
>   }
>   EXPORT_SYMBOL(page_cache_next_miss);
>   
> @@ -1767,9 +1764,7 @@ EXPORT_SYMBOL(page_cache_next_miss);
>    *
>    * Return: The index of the gap if found, otherwise an index outside the
>    * range specified (in which case 'index - return >= max_scan' will be true).
> - * In the rare case of wrap-around, ULONG_MAX will be returned.  ULONG_MAX
> - * will also be returned if index == ULONG_MAX and there is a gap at the
> - * index.  We can not wrap-around if passed index == ULONG_MAX.
> + * In the rare case of wrap-around, ULONG_MAX will be returned.
>    */
>   pgoff_t page_cache_prev_miss(struct address_space *mapping,
>   			     pgoff_t index, unsigned long max_scan)
> @@ -1779,13 +1774,12 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
>   	while (max_scan--) {
>   		void *entry = xas_prev(&xas);
>   		if (!entry || xa_is_value(entry))
> -			return xas.xa_index;
> -		if (xas.xa_index == ULONG_MAX && index != ULONG_MAX)
> -			return xas.xa_index;
> +			break;
> +		if (xas.xa_index == ULONG_MAX)
> +			break;
>   	}
>   
> -	/* No gaps in range and no wrap-around, return index beyond range */
> -	return xas.xa_index - 1;
> +	return xas.xa_index;
>   }
>   EXPORT_SYMBOL(page_cache_prev_miss);
>   
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
