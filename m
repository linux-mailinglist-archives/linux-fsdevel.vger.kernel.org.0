Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9F77A5940
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 07:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjISFQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 01:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjISFQk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:16:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31A8FC;
        Mon, 18 Sep 2023 22:16:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK4wug015840;
        Tue, 19 Sep 2023 05:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oTGMYnmfyrgMUwB7P6rhbsXlWGz4BYid/dg2UDF7Kfk=;
 b=LhdezhsG+OAaYASi5rXSPoOGK92cJtZBlZHxQWFxB89jqlROIJeflhjWIFjYWF1wqn6a
 41HSSqKksW1FA+2RriH+2JCZxmrxtilo8l10G7bEFj35ojogxZgVMGaGmR95g4cB6dhu
 sbATeYE7XK6KFfUDLc5icf5eYtC1cR95eROr+pmVnjz7+X/RGGlTBzE/LMR52s1AaZ/x
 6TdF906Lgsw1fTb3qVjcRjkzftYcs7OvQJEvUgq9LEz9827dDpoXp/TvOCgZrrEP9iSS
 pCJHlNQdlUxQWiJzsDbmk0ZXumDPEnAuKEkr4qk/YehbqNnk95sGiCmEh6og91mto3sW SA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54wukyyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 05:15:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38J5Bvcs027043;
        Tue, 19 Sep 2023 05:15:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t5e1tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 05:15:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+Q85xv9RpghumNmNL+5Zb9q+qmVsorX5jvjoEHcLAyGv8eOBE8yXl3CoUbBjlmkz1pf4jpc7D+BKpGVpcxSjr/CwMQ4lCaLARtFYP757SpdUoifhvesLYoB3TbcWkTzcOyYMDzRq+LUcc1J6T0vPTP/zLQnO56eAudSJIjCzHO2G0Mi0MCNgCFcGeG9vEQY4fxpyY15t7LmCZuRYeh4smS6lUhQ8qqlcbsxUdDp3Sg2PmX0/SGdMB1e415zcz7Ydldj2PkuuZPJNumXbk7saDWKQZuovfWwv3l3ovHJ/c2/RtfcRq7hJlVfF+mrrpkKfNIpjyK54ZwTGUXbBwegEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTGMYnmfyrgMUwB7P6rhbsXlWGz4BYid/dg2UDF7Kfk=;
 b=WJ8l2eznzPf1X6GotwLDfR3xRszlrafFOaLB5fsqdudCwZDiKe/ebvG3UR94J50/UuPdVL8C0qWPRmZH0dtFGmMk290ujOodiczWSMRt1fv7mCdN5h4h1x3P6a9hSp5clOtPYdBa5YDoq2C7YihaPOlynEzu+6RVp7JMTdlENT9ZJCRcKnwiM0RG5tB/Txs2EhfC5VRaU6a6Znl1yrSV5R7cAiheJJJNKj7yNm+45BqWG4t5lIY9T5JImXJFRHiUXKYT4kqr8PqQseA6SUODl+DUONq2AMJhN0r6hJByzgjOGsPUDuUyBPl+KBMidn9JcNW+bY6JVQzo3yXRdiJ9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTGMYnmfyrgMUwB7P6rhbsXlWGz4BYid/dg2UDF7Kfk=;
 b=EoBUIH3AvEWoCb0wOwRCbax2ybW3zwzyGTsyme+YQceMvIbWJwlm9tznjaVpnJrSf1bKY2Xt7+EyA33t8o4ZO9JW35q7cwzxBo0GCchVzANSHIjj1HStfE6ApfukjPxhPe2ZaWCKPvHK6fPY4XSweG2BygxzVK7jqkVo/0TJA1A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5108.namprd10.prod.outlook.com (2603:10b6:208:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 05:15:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Tue, 19 Sep 2023
 05:15:53 +0000
Message-ID: <3397bee9-bf5e-d369-2e64-df2bd94c0eac@oracle.com>
Date:   Tue, 19 Sep 2023 13:15:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH V3 1/2] btrfs-progs: Add the single-dev feature (to both
 mkfs/tune)
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     clm@fb.com, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-2-gpiccoli@igalia.com>
 <9a679809-6e59-d0e2-3dd1-3287a7af5349@oracle.com>
 <8b629a31-9ee0-80db-0ef9-ade00a31255a@igalia.com>
Content-Language: en-US
In-Reply-To: <8b629a31-9ee0-80db-0ef9-ade00a31255a@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3bff7b-2b30-4673-6b1a-08dbb8cf7f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X09zRob6f++mLa7jBTyEFhOcC60UF8cUh9NeDelE+U7E5qQwek1eHxK3nnA++6FlLfljRT3GFyZhZgXmu1pTPHOq+N3xAxJcHeomG9TfHTdSmrupyZtoNJgYZi5w0wDWIrDfCxxvcllwdLlrvK8Mo3WVoaopwZYTXKDHqzkYM7S1jmSOdxLunVN+3MZaNAoAI57rbhlmK2LO1AqBcF6vY8amgt6kxEqxKD6Az+zedUyvpbA3ratGcFEc0pmKzcfihLnwW6nqH8k2sQiP6ToJxtuakbA4So8ME2Vv9Y8Amt7AvrV6OZnQrHRlGh1lRl0W3JLG2BTpSeyw8/JiZvY7VrAUTLM00WrJQ5X8LAUuoPmDZef7nQe+vV33Fvq4gjnzf925bMIiRDwAIV0IdL6JAC5IWPquAE8HAaWJKXqOnvjy64YpcIxl8LdrxmAaPh/H7bld1ywswgQxc2hy+1U/P+amaJnyYUVC8Lm8mJUwJIug9/DwF66WnoH+8nBbT4o1QrEZp8Qokm2V1TM77W7a6Yq6VAFgg7ufLKvi/SAU5CwXfcMa0oFwmWZtN38RNsZWxct0HAXNR+O76INOzcd9R5wF8E2x4MAA5kXVPO2bfGTwVm1x/GkAC/7Zv+L5RM1pp8cwmluqTvacJzjenp7zSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199024)(1800799009)(186009)(41300700001)(316002)(66556008)(6916009)(66476007)(66946007)(6666004)(38100700002)(7416002)(2906002)(478600001)(86362001)(36756003)(31696002)(4326008)(44832011)(8676002)(5660300002)(8936002)(26005)(83380400001)(2616005)(6486002)(6506007)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHVjamM0dUh3UkZGZ3dhS09MeHYvY011RUhYeC84TC9Pd3dKUUhSWTdleVN3?=
 =?utf-8?B?anJoZndkd2NYa2dhMTYxaDM0RWFrSkNQSGpVRFVublk4SnRWRjNTTlVZL3dZ?=
 =?utf-8?B?dEpzYUs2VEZ6YmtKMXRkeUVHcHJGRGRGR0RqRW4rcXNKcUpzY0NwZXF5WGZx?=
 =?utf-8?B?dGUyekRjWjhwZThZU1hyY0l6VTVmdzNRM09qTEVIVUlSMzBKZjV0eEtTWkx3?=
 =?utf-8?B?d2VoTzE0dlJlSmFtblhMV2FQQ0VlMk0yMVBUS1J2dnU3Mklsd1hVK3FoeFFP?=
 =?utf-8?B?cnhqTEZSRkVsYm43YVlKa1JVL2w1YjBoTkViTHFveHZ2RVFUcFQrWTdkVm0v?=
 =?utf-8?B?eGU3eURMZndiU3BRcjZvd2VJNzBNcldGRFZTQ0dLbXBTQU15bUl6dEZyOXEr?=
 =?utf-8?B?Qlo4OTFHaWdkdDVtT3pNNkZyck03V0hKaVVBL0VpbnU5aXFhMGtPcnNYMXV5?=
 =?utf-8?B?R3Z1S2FEcEQ0MHlFUUdNS1gzd3JRcWdJYmVqQlZ6NlNkWjhHSy9zT1NwaGJi?=
 =?utf-8?B?ZG9UNjZyV1NtSXU4VTRjN0gvTzFiejJBUmRXa0x1MTN4ODRPcGNsYkdveXdG?=
 =?utf-8?B?UlR6TXorVEkvZkRjNzRDY3AwUkxBdDl2SkpCeU56ZGhyVzZiVXM3TmJRQnVp?=
 =?utf-8?B?QzBDTjhuOU91UXUrL3cyTWI0UVQxdWJXNlhCQU0xSFVKRXAvN01ldjUzVDRp?=
 =?utf-8?B?MTlwdWxBVUFkNHpDZ1hCTGRSVmFaeU9qa0swYitxL05SVzhRWjVRa000bnkx?=
 =?utf-8?B?WG1PM0hvWmtjVHQxaExXcC8zZ0dScU1RaHVDWkVyeVdzQUJWOXhRVk1yeS9V?=
 =?utf-8?B?WmsyWEI3OWlNVUtFb3NYR3NSRG9ZSXlqZUxGSy91U2l4WERvQnQzVUZOdnIv?=
 =?utf-8?B?L2VqTGRZWW5VLzh1RENYVUZkcmNOTElHcWJ3MWthNmFVc1FXTmZTWHpLYk9E?=
 =?utf-8?B?V21nZU53S2UzY1IzdnUyd3ZhVWsyb2JpZUNlL3JBMFVnWlhRS3ptWXo3NHRG?=
 =?utf-8?B?cW5vREZZUkJyS0Y2VTVaUVQySFRTVnE2TVZWVytyWnkvMDZMMHIxVVQ0amFm?=
 =?utf-8?B?RzRncUFGbGhJUHpzRWNxNjgrK083YlFsdEQwYStsdXNxTHRlVHRPWlJzRUFN?=
 =?utf-8?B?ZTF2SEpTZmJhWjVoWWpNSUxTRHVqNFladXREWThGUzVxYVhqaU5yR3kzVHBQ?=
 =?utf-8?B?VSs4SDVQcnl3UnQraHc2TWV2T1VzMU1WR0hyWTZhVVNmY014TEJ2R3F0TjI2?=
 =?utf-8?B?MEF5TXB4cUxUTlExOE9tdjRKcGJxdFQ5TndrMEpCMk0xMnRXTXUzOWh0Q3lS?=
 =?utf-8?B?L0pmVGtDL25QaXhPMFUvaHJ6RHk5SUJoNGR0S2wwVGVEZDdOdnZNMi9MaTVE?=
 =?utf-8?B?NUFNR1lxWjNBVUdUMmdTczlzeGwrYWcrSnE0VmVGNEs1WnkyanFZSnNHZ0xz?=
 =?utf-8?B?VGRuT0x2Ymp5ZVVZOXM4bjIxSDRCZzIxL05lMUg4N3NTK0NkNndLSUdLWXVx?=
 =?utf-8?B?QjVQWUdRRVpNTllKK3o1Y0ZXL3dTK05nQ0NtR21aTXQ4Z0tKc3FoVzh2Umlu?=
 =?utf-8?B?MDJFR1YvY3NNWWhqSDkvQzRKOCtWVFJQTmQwNEpOaXhpb0JKRXg3aFRseU5H?=
 =?utf-8?B?NFE2UzlOaWpHZmROblFOVEdNdEMyTUNTYWNUUDFBc2VmTTlaVi9jc21tTDBz?=
 =?utf-8?B?bkIxUy9BdFE2N1hzY2JwM3NmL3h3aFMzcS81cUc5OXE2NXdXcU55SlRuUDBh?=
 =?utf-8?B?bXlGdEg1NGhWdTcwbXNjRTZTME1PS0xPK3FZc3ptQjZwMCtCSE83WXFQVDNz?=
 =?utf-8?B?TEVBZ25QdDFqZ3NxTEkwajNTWWZBU2s1SkZ5MHNpclJ3V2s3MHlRNFpvVTlC?=
 =?utf-8?B?VjNDdUNpNWJLVWYwRHEwV3NWb1VtUGprdjhuVU4waGE1RVVqK2lOd0dpdG9t?=
 =?utf-8?B?MGJRWSt0NlMyU0hoMG1nb0VoYk9Sc2pZSm41ejB6UWswcmRqWUJ4K0NKY1hB?=
 =?utf-8?B?QmtZMTgrZ1J5dFB6d2xJdHVna2FPd0FFTEEwMm9wS1hMcWs4SGUveEh5VERz?=
 =?utf-8?B?eEczL0xoRy8xZVB1OHp5dVZ6aWhSZG8vUGpCTkR3Skp0Mm01SVE1azV6WVZn?=
 =?utf-8?Q?KSqqENs0NeK0DnyK+98Q5uJcc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WW9hRURodG53eUdzM0ZreTZxNUZOd1RHMmphM2lJR080aFF0WWhQSjIrSWgz?=
 =?utf-8?B?WXdzSlhNVTltbGpIcVErbjJaSnVXRW5uTUEwcVQ0NVZiTkVvYzVuTktvTWFn?=
 =?utf-8?B?SHVsY2ZXKzRUbTB5Qzk2SjBuM1J0UHVYRjNCS0Fnb0Y1ZzFPajNRWU1pYzF3?=
 =?utf-8?B?Yk9HV05uTXJiaU8wNzd0NklCaEtyOG5abXRwV2o5Y05wM1JZMndnMTJSNUFV?=
 =?utf-8?B?SytGc2ZhSkVWSGx2bnB4NmZ5THpHZW1tNkdSQUp5ZDR2UW9ZL2VQR3pnamVC?=
 =?utf-8?B?SW5rYzBYZGxFRDRTTC9walVpN3c4aXdnOFNzVTM4RVA3SzhLemV5N2lreXVt?=
 =?utf-8?B?VGx1eU1oV1hQWHNDb0lyZmFWR1JqYXJXYzA5cTIwLzh5dDJJYjc3YmdQQnRl?=
 =?utf-8?B?QWp4TTFRL25lU3dzNmhHVTU0T0E1dW5DVVVuYWQrK2lVNkUvejNjT2ZQY3Y4?=
 =?utf-8?B?RWIySlNOWSthQW42aC9EMmpocGlqSDFwNkJiMlFNQmM4Mm5mamRjODlPNTlU?=
 =?utf-8?B?bFV6MGthSWNHcStlbXUramhTdGoxQ2k5dlhucDFtWTJRdE80MWZrRzgzcHpN?=
 =?utf-8?B?ZVViRHBhMXltTy9WOFFEazNHRldRQ2ltUHdLVWVVZXU1anhKS1lBSWVqVjVN?=
 =?utf-8?B?bGwvTGJ4eVZwUkx6aWV0a0hMYzZJZWswV0NyRjY1MEVNUzBXWG4wT21iby8z?=
 =?utf-8?B?aEpLc1UwU0ptNVFpdGFJRUwzL21KekFPaVFOMWYyV0ZCRjFOQWN5WWZPeS9k?=
 =?utf-8?B?Y2FsRkFGb3U3NkVJOTkrVC9FUFpubnMxWHBQdzFnZlJaK0pWZFl2QzJjbEIx?=
 =?utf-8?B?TW5vOWtUbFd1cEVMSUluRFpEZTFRSnljMVJsM0hzSzdDb1YzSzhkNlB2RmR2?=
 =?utf-8?B?eEF3cysvRGw5TlliZ25iNlI1dkxlQUlvbFJJSUNLSWwxdkVBY2xQL1l3Qk92?=
 =?utf-8?B?OUxKaVNHRU9zS1lXdTlIYUhOOU5YUFVHdDBHKzlLNFVYUGYzZU52VWQvNUJW?=
 =?utf-8?B?ZTJ0c2oyaUkzcHRMTWUrY1NkYzhBcVpJZ2J3TFFzN2xoN0ZNWFU3RndTVngz?=
 =?utf-8?B?VlhGSlVoS3VmVmdGaWg1MWZpQWR4QnZGNFN6R2JTM2tIUWt3c1I2VzlvV0pt?=
 =?utf-8?B?dVltZFJxRXhuNlBEejNUeVRSTnkwL0hyY3RxL2ltZGdQRzNhYjdQQ0hTektE?=
 =?utf-8?B?OVlHZUZ0WlhDL1RhSzQzcldyd29FdklJQkxMN1RDZ0FIdGRlcFdLbTRxTDBz?=
 =?utf-8?B?WFNLcDdFcVArcGRvRkUvbXJ1dkp6Z01EY3BMVitHVXk3WmFUUmtERWpiR3I1?=
 =?utf-8?B?RDNSbHFhazJjOU9ZNWtjdVQzQ0ZUQ3hQRHoySUNEYlJ3cVNzM1NiQ2hrZzZv?=
 =?utf-8?B?bzRTMlhrOEFSbkYvalV6RjBaVEJrV25GSS8zMjBLK3RqSGhoSk1yUk05L3Zk?=
 =?utf-8?B?ZkhLaG1KZTVSUFFFZkduSkVSWFpBeGR6L3hNMmtBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3bff7b-2b30-4673-6b1a-08dbb8cf7f03
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 05:15:53.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVRTNxnDhy9Oq3xpJKYKvo9E7dCW7Mm+MUQLUspdTIIHuC0IbI4dXpvCp76034YKo4DEV5Sp1vkVD2xkGKXg1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190044
X-Proofpoint-GUID: Ae2mlHu5gD3DT53if_masmH0bQgSSC6i
X-Proofpoint-ORIG-GUID: Ae2mlHu5gD3DT53if_masmH0bQgSSC6i
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> $ btrfs filesystem show
> Label: none  uuid: c80a52e3-8f16-4095-bdc2-cc24bd01cf7d
>          Total devices 1 FS bytes used 144.00KiB
>          devid    1 size 1022.00MiB used 126.12MiB path /dev/nvme0n1p1
> 
> Label: none  uuid: 5a0a6628-8cd0-4353-8daf-b01ca254c10d
>          Total devices 1 FS bytes used 144.00KiB
>          devid    1 size 1022.00MiB used 126.12MiB path /dev/nvme1n1p1
> 
> Label: none  uuid: 94b67f81-b51f-479e-9f44-0d33d5cec2d4
>          Total devices 1 FS bytes used 144.00KiB
>          devid    1 size 1022.00MiB used 126.12MiB path /dev/nvme1n1p1
> 
> 
> It seems to me it's correct "enough" right? It shows the mounted
> filesystems according to the temporary fsid.
> 
> Also, I've noticed that the real fsid is omitted for device nvme0n1p1,
> i.e., the command de-duplicates devices with the same fsid - tested here
> without the TEMP_FSID feature and it behaves the same way.

  Mounted devices should be fine with those unique temporary fsids in
  place. However, my main concern lies with those cloned devices before
  they are mounted. Btrfs-progs build the in-memory device list from
  the fsid list, and that part requires some fixing.

  In the past, we did not handle duplicate fsids. If we had cloned
  devices, they had to be fixed with their fsid using 'btrfstune -u|m'
  before mounting. Sorting them by fsid worked fine. However, if we want
  to allow duplicate fsids, we might need to consider how the end user
  will identify the btrfs devices before they are mounted.

  I believe that currently, it only displays the last device that was
  scanned.

> In case you think we could improve such output, I appreciate
> suggestions, and I'd be glad if that could be considered an improvement
> (i.e., not blocking the patch merge on misc-next) since I might not have
> the time to work on this for some weeks...

  These commands represent the basic steps users take when trying out
  the new feature. We need to make sure it works.

Thanks, Anand

