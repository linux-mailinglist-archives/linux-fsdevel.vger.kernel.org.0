Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B4B79117C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 08:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352370AbjIDGhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 02:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjIDGhc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:37:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BCE1AD;
        Sun,  3 Sep 2023 23:37:20 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383IT1ah022501;
        Mon, 4 Sep 2023 06:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dCM2vIip3tNatLDDLycUaoSoKd8n2dvHoCBOI0OdoZk=;
 b=ggFLABsEERnMZ4fxOtJnXai6OrrB3SrO5JLK59nDuHFMyZ1B69ZHmx9NnWKjab3ObjzY
 55hd5u4dz98HwOsU7jm/nyZMzs8W8JMmV1B1nwXhyj5dVcUD9+Qokh24yA2/kpYsWlWZ
 k23c5aJiYunH5JOmx1a3GhY/cNG74stH5A9BTcWq6EivJCJPOwJj4G4BXLXdy+NBXZqG
 wb84YHCmHJUb6KF/SVrPa46+Q5sWxNSQcIj9kFcvB1NSGv1zta20Ii9C4hTFZtLSxYux
 Ef7KCAi1h9Ta+WdpK1x9lXy6nN6op6Jkfp9Y926T4GRV1NCJUjj+/89qk5mIxZ/WOyk+ yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suuybjkcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Sep 2023 06:36:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3846PfSP022835;
        Mon, 4 Sep 2023 06:36:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug9jcb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Sep 2023 06:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cc6s30xSLHiLumqHbDM6aXo/HWtQJrmZcLW5LDswEm9NwXCkeCusxRkPtKFmydE5+Rlq4BaG2ntpnfb5w5Klnv9xtJ04EBigMq0KGRfp/ppgqJRN2fpSpn0djiLo+V01YRH5RlnhydyRG/6XD5oDkn1sB8gRfG0MWxsn3cuO7OPgFUxAvOdnfh2M/xgQTDbrNE+kO+0uOOMmyQP1/ryuF7H3LvfmTqjxVR7Iot1uD7SiW9Q0oQNeLie2cO1ss7u73USkWvpFdH7Ycp7yrHQLZNIVGRK6Nm1zqfYQqFLzXN3uYvUa2R957KrAQEbLsRFiXfmv26nw2EhUdSJuT8PzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCM2vIip3tNatLDDLycUaoSoKd8n2dvHoCBOI0OdoZk=;
 b=DOFb3xrL6lUR3pGH4CNAroQbATxM2eKPdcK5Z0bMu3tuWRu/6bSXXoYa52W6i/ESKedO3gAeZPX67J/Zm7JyichWk3XawLJfqQ1d6xHRFbydE6+EJMuNAIlpu+rPdy70SdADcUK9gqTXbs14R1jaJIn1NJ9skvkLJ5Gc3N6LLAhWSaiadWI7ouThn0DrUdMO5GDGW3rgLG2M0exlMPwtEu3OPZ4SoVTZcJxktEYMpkWgO5ueFidi7jePTBSnH5VFo9ycKnGCQAcW7r07a5co+E9BT1MCNEZ3U53K0mHWo0KlsamJxW6cArhlXLhWV49/XXCzWYC/6bzpszxdxRvlew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCM2vIip3tNatLDDLycUaoSoKd8n2dvHoCBOI0OdoZk=;
 b=c/5JQTAyCG4J8jQ77rQp27D4DJ4/4EG9oKpoCyPiQlcjvdqGfbtvzRi9KzvVqKnr7rbq6ZX814qPSsb5oqXxmpQDVPblnuGUeLDK99MEiupnPgVO54lEqvw0IWoi29BcpJAnbY12DMx54R/eQedGbnn0dC5IztFJyCRFh8jaSuo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 06:36:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 06:36:37 +0000
Message-ID: <fee2dcd5-065d-1e60-5871-4a606405a683@oracle.com>
Date:   Mon, 4 Sep 2023 14:36:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH V3 0/2] Supporting same fsid mounting through the
 single-dev compat_ro feature
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230831001544.3379273-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: ce25ed54-6912-468f-b3a7-08dbad114a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MarOamT8+dK1eOOlVoZ/vtmaIKt/qsrqkySe/o/KvMYRkQKgfV7zMqThyIFVmXemkeEr4YHFXlkEc1rQsTtbzdhzpZR0EBhb68Dv5uzJq7v8qqRrj9HdtwU2LqSjfQ7V9x9ydsDLU+ODEf3RCzMCVjdMRCDHlpiSP8eqg1Ay2GIgXk4BlO60eZxYC0HemEid7y2zYLxM4mlDBA5sf4JSYJ+78B45HAMX9QpHdX+XPTNo9iuPYM767f2oy8cAx/+j/zeXsnmlu03Epnx93Jo4w3FzXE5FidIfFVAQTuSQY6p2ui8MFrsFR4E8Oe7CYPEr+FDC0AHCItiIlgQ5/C599Wmk+B432rV/dwnmcEP7OoswHQ2BM0ekPTsbc9puihZD1FTWy4NtQSytEr1fBd5nr/giSegjZbD4SrudeuedWV73sAt14BGlU5IZVbvL+iFBFItOdp8iUQPSow740xuMP2dXRwYkl8vFEBi7qhl27qqmt0XbhzN3ujHBIkI401JSihQ5SUPBvRNP/ynWiss8MC8U7KM5fvwpXQ4F09x95bZB6pZVJs0/U0ZAA6DVACuHS3OZFy6LOOn3R7xFZyi6DchXcxujT4ybRc5LdxrYAu8BFE3n4EV+qvj36jTASaCufOeqTjYJw22cquBlUM+9GzRUV8AjtMwmyRxTv2m+oPOd/e8niSSPrY+1eJXfBfNm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(186009)(1800799009)(451199024)(478600001)(2616005)(966005)(6666004)(66556008)(66946007)(66476007)(26005)(53546011)(6486002)(6506007)(6512007)(2906002)(4326008)(8676002)(8936002)(316002)(41300700001)(7416002)(44832011)(5660300002)(31696002)(86362001)(36756003)(38100700002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG41Z1ZGekRJTlpNTThlT0FCS0JLUTVvMVBTQWhqYXczUXpkNWZSemF5SHha?=
 =?utf-8?B?OHV5RVI2UW93N3cxV20wKzk3cWJHMmdjT29abXc2dTJSTTl1SDBCV3FxWTdp?=
 =?utf-8?B?VEhBdExjWXBMTEtLSzZpb0U0VmQ0M1Y0YUora3QyR0ZEVW83WGtoUTBZR2J1?=
 =?utf-8?B?WUZlb2wwbXNLMUp3R1RZMVFXampSRVRFalp6cEFQQXZta1F2UkpiNFZVK3ND?=
 =?utf-8?B?L21CL1NuUWVNQUhnaXZZUWxKQkxBRk9kaTZXMVRNUlczV2hCUFZObWI0RE5O?=
 =?utf-8?B?NWZYWm4wQmU5bTJ4QzREN0JySGlLL0FIUHRNaitVWitjS0pXdVFaS0hxVjF3?=
 =?utf-8?B?ZGtvT1p2QmRxV2VHdlZLUlV3eStZdDBVWXNaWUtwK0lHVmVBMWRucEZHVVMz?=
 =?utf-8?B?YTRkeGNHSGF1WU1VN0R1STNWUGxHcEFtUnlLaU1KbWc5WUw1YXBsYTA4NXJv?=
 =?utf-8?B?Q2EvclNOeERGZVVBNTVvVUpDa1NWUHNkY0xzM3p0M1hlSWY5TW5lZHE2QUNV?=
 =?utf-8?B?RG02cVdTWGpwcVdFMDA1U05YdHUrUFpCc0FWQmNzN1ZyQTUyT2piZGVKclZi?=
 =?utf-8?B?azhBV2hUQ3A4UFU1RU9Fck5NNi9LMXJHaGRROWpXVHBQSTBlMS9qVjN1WFpm?=
 =?utf-8?B?K1Yydm9ad0V6cGtmTjZDZk0yN0dSZHc4L01TMDNodGpmNU5FTlBsUGwvWkNI?=
 =?utf-8?B?ZkxUcHhDMGZ6WFl1Z1cvZzJJc29xNVBiS3BVZDZmbnJTT1RUTDZaTFR4K0ln?=
 =?utf-8?B?K1g1dXNkY1l6UDM1M1VCcFlNNVpueStwUm8rWC9nWnc3ZFZKYVM1TWhIbUIx?=
 =?utf-8?B?aHc1SlpNUzl3eHhrMFoyd294QkphcnlDaE95eWUwalNhaDlHZlgvbkFObjh2?=
 =?utf-8?B?RUF3Qmt4UnVGQ20vS2t4NkhQekk0VFM5YlJPVWtzSjk2Slc0a2NyU2FKM2t4?=
 =?utf-8?B?aC9HaGxac1ltYm1hNVdWMXBhRG5QV1hoa3hjRERENmRnWWR1amc4dkpIOU0y?=
 =?utf-8?B?cDI3N0xtdFR1K2FNRkNuTEsxdDRWSkZUSFByUGNMOHVpckNRYlZORzJ6U1A4?=
 =?utf-8?B?T0ZkeVdQK08wQ256TFduOUF6Y2NEbzhvaFJUZmREbWRNWExpWW5TMzdnaTJH?=
 =?utf-8?B?WVRDQlJJZGNKeU1OVWJ0WUliK21aczZ2dldaY1NPeVc1UWc5a3E2YnNkT2d0?=
 =?utf-8?B?Wlh1bkdkWE1BbFJjcmVuTW5RQlNUeW5RQUdqV3RQcEFKeS9KbXRuNWhuYUZw?=
 =?utf-8?B?S1JLOS81NTJaandzVldTdThtNEdmTkt6R092MlVOUG04NkppV2NTSUdiZWY1?=
 =?utf-8?B?S01zYkh3clVScmJaLzRhaG1uNFV2d2Fya2pZWThoYjU3YnNlTkhkT0RJNGRV?=
 =?utf-8?B?Z2wrMERQbnROR1FrSjNLRFBKeWoxcmpTZjNiNHU5R1p0TnVtS001eDBaTEpn?=
 =?utf-8?B?T0oxVEVLTkw0NW5zOWdzSnVnOVl3YkpRd1NEZ3VJVHpRK1IwSjdFdHRWVHov?=
 =?utf-8?B?NUVCZUtEQVBrMWVZUjNoRkI2dEdLNUIzS1BzeW5xS2F3ZFBrMm91cytFejZt?=
 =?utf-8?B?ZEVmVC9OMGgwWmRyZURHSno0cG9ZcE10UVdHQTdRMmFXdG1Mb296b0Rua20y?=
 =?utf-8?B?ckFrZGJ0YzZqb3lEbEhsMmU0aEc1NFh0eS9WQ3c1bTFNUVJnQWlOOUJYeW1m?=
 =?utf-8?B?T3hpMDY0bW1ZKzZLSk1ZNGJXUExORnVRYlpmRFE0VmNxNmpNUHVMN0Y0b3Nw?=
 =?utf-8?B?aGZ3UmtQdDdHdXBLM3hjM3JFZjFWeXJCVFFRd1ZZa0IyYlNvSWtwS3UyQVZz?=
 =?utf-8?B?ckVqMnUvTStKbzh5WTQ2Qkw5SWVoSCtqcmlKQTZzazE5a29iVGxBaWU0aTA3?=
 =?utf-8?B?MkNGOFZDOUxrYjJhS214RVBPRldyYkhUeGhqSmdrbzNkaGpzdCtpQ2gvRmtY?=
 =?utf-8?B?WTNVdjcwY21ORXVidys2WFdpMzVBaGs4NVJ6aFh3amsrRXlvVmNBd3hveS9Y?=
 =?utf-8?B?NFhESHZOeHFqNlp5OUdBZkEwUmNZbVJCckRLaU1vbHk0WEhmbnJGbnAvcHpx?=
 =?utf-8?B?VU9STXlrQUJiYXB1VFprOEFGUHplaVdBc2RDQ1F6VzBGelliaEt5eVlMaExC?=
 =?utf-8?Q?RDt77V91Fd5fJZKgDW2vPY04n?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UytWZUZ5Y2lEcWJJcEwveFBra1hnckQwSml5Y2tlTWx6VUNZc1d3dXhYTE1B?=
 =?utf-8?B?SzFWLzBTNFVaRDYzWlNuVkE1Sk5hb3F6dS9KWXZPL0g1T0Y1STVVMllPS2k0?=
 =?utf-8?B?cmNzUFJ1ZDY0TllQUE05bzE5V0FUL3MyZ3pIOUZjZmMxcU5QWWZNeTJ2WGgx?=
 =?utf-8?B?dm9vUlg0dVY0QWRCTSs5ZUFEQU5WamJ6U1FpK0x5M21qWlNYQWJJU0hQMEZl?=
 =?utf-8?B?S1dzWjJMOTRWbGtyZDF3cG9DUEszSFlKQ2Q2NWtLQVBSY1NXL3hOdld6SVVY?=
 =?utf-8?B?S1BjbVFvNlowcEFYaWV3YUl2VXQrU2ZSams2V1RjaWo5b0ZLTGppRlU5cnlT?=
 =?utf-8?B?SWw4d0d6UzRDeE5FZElrRDhEVyt6YUZJVkhuMFluTUlXUFJBbDJpb3llU2Ji?=
 =?utf-8?B?SkREWm9NQkMrV3p0Y3BKN2x0VmhSYVhwRGEvNDBRU2NuUVYyNWRQS3ZIU1kz?=
 =?utf-8?B?amFmSXREVXRqOEcrT21TQUg1emovZTZXMmFnaEh3ekVNU2ZmbEx2b3pwS3pN?=
 =?utf-8?B?RjZ2QnhobHpmbmxaN1NQMStDVnNCNzdHRDVzR2tCK0w0bUVjK1QreGhtajVM?=
 =?utf-8?B?TjZTcTBSWllocldRTW9QbFBzbDRvYWc1NVloQUpEVFhUaTZmNXRmQWdDUFl5?=
 =?utf-8?B?ZnY2d2pEMWlVWmR2QXNER0xrYmlrN2hvRmlYNC9wVU9VV09tcUc2Tjdka0pF?=
 =?utf-8?B?NGFyZXByLzdwM3lyOFJkY0UvbDQvMjYrbE9VOVpNWng4YXVyZFk1R09BVXZU?=
 =?utf-8?B?emoxMlNWamhTVGx3Z3pZaU4rZnk2M0U3bCtzR1VZdUdxcjBBbjVFUHl4b2hL?=
 =?utf-8?B?OUNpZUk5b0hTMWZQUXF5czZKeENoSVd2NndONUIxdXN2a3o3eC9CTmgxa1BV?=
 =?utf-8?B?SktIMmdKNmZ0Nnh4NXhFVE14NVZzVHZlOUhobG9mb0NWRWhXdEJMblRhWlE0?=
 =?utf-8?B?OWptbnh4MHh1YXpCYlBmVkRuenB3K1d2VmFyVGdiU3NCUE1jR3NZNTQ4VmQ2?=
 =?utf-8?B?ZlJSZnVNeWFCVEVMQUNPTldCbVVjcFFSMTBSQlNHRTJibUMyejB2bUgvZkQ1?=
 =?utf-8?B?NThMOGp5dEVnVC9OQmpHYnFVdEZ2Sk1NcjJETEdMMEJxSjhYOXpSZDc4Z3NP?=
 =?utf-8?B?SkFxVWYvL21QTWo4ZWd5TEgxTldIbGlrYUtaUm1YbS9RV2h0OVlIamFDVTNo?=
 =?utf-8?B?NFU4cGw4QXpGMHY3czFZNTFoanVobm8xdGw0NnRwcFY3SXZQOCtROVhNTXNl?=
 =?utf-8?B?dnY3azFzQXZwRk9iSUkzMW9RVUdScll1R1lCdzlYdEU3WDlrZ0dlUExGZGhH?=
 =?utf-8?B?OFVNRis0RkpBd2tocTNuTloxdnpzZGFNNmNrSU0rRmgraDJkYUVWTnJ1cHVG?=
 =?utf-8?B?MklqK09rOFRDSG5sWmZWaHdlWFFRUXVmdmFjSVJaMk1xVncrUjVBWjJlTHo4?=
 =?utf-8?Q?h9XqDRMH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce25ed54-6912-468f-b3a7-08dbad114a4a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 06:36:37.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/EAWBJpF0rIjU1wBwZlFBOR0M1PIyJNa64NsRZkw0owJWOYGhowZ9cAlmFsCGvURtsy7T2CzN8fmjJZ/+JFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040059
X-Proofpoint-GUID: GmUzGahD5AYHonaIG-XYnmeg6rzztRsI
X-Proofpoint-ORIG-GUID: GmUzGahD5AYHonaIG-XYnmeg6rzztRsI
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/31/23 08:12, Guilherme G. Piccoli wrote:
> Hi folks, this is the third round of the same fsid mounting patch. Our goal
> is to allow btrfs to have the same filesystem mounting at the same time;
> for more details, please take a look in the:
> 
> V2: https://lore.kernel.org/linux-btrfs/20230803154453.1488248-1-gpiccoli@igalia.com/
> 
> V1: https://lore.kernel.org/linux-btrfs/20230504170708.787361-1-gpiccoli@igalia.com/
> 
> 
> In this V3, besides small changes / improvements in the patches (see the
> changelog per patch), we dropped the module parameter workaround (which
> was the 3rd patch in V2) and implemented the fstests test (as suggested
> by Josef): https://lore.kernel.org/fstests/20230830221943.3375955-1-gpiccoli@igalia.com/

We need some manual tests as well to understand how this feature
will behave in a multi-pathed device, especially in SAN and iSCSI
environments.

I have noticed that Ubuntu has two different device
paths for the root device during boot. It should be validated
as the root file system using some popular OS distributions.

Thanks, Anand

> 
> As usual, suggestions / reviews are greatly appreciated.
> Thanks in advance!
> 
> 
> Guilherme G. Piccoli (2):
>    btrfs-progs: Add the single-dev feature (to both mkfs/tune)
>    btrfs: Introduce the single-dev feature
> 
> btrfs-progs:
>   common/fsfeatures.c        |  7 ++++
>   kernel-shared/ctree.h      |  3 +-
>   kernel-shared/uapi/btrfs.h |  7 ++++
>   mkfs/main.c                |  4 +-
>   tune/main.c                | 76 ++++++++++++++++++++++++--------------
>   5 files changed, 67 insertions(+), 30 deletions(-)
> 
> kernel:
>   fs/btrfs/disk-io.c         | 17 +++++++-
>   fs/btrfs/fs.h              |  3 +-
>   fs/btrfs/ioctl.c           | 18 ++++++++
>   fs/btrfs/super.c           |  8 ++--
>   fs/btrfs/sysfs.c           |  2 +
>   fs/btrfs/volumes.c         | 84 ++++++++++++++++++++++++++++++++------
>   fs/btrfs/volumes.h         |  3 +-
>   include/uapi/linux/btrfs.h |  7 ++++
>   8 files changed, 122 insertions(+), 20 deletions(-)
> 
