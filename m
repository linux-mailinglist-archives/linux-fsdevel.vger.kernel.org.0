Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1F785D54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbjHWQck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbjHWQck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:32:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497D611F;
        Wed, 23 Aug 2023 09:32:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NFpfum026315;
        Wed, 23 Aug 2023 16:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=REB7X1o33M3+LcxToE3BoBoRj3uKKXfpTBOgd+XgDBE=;
 b=lyBxjh3sEyfq/h/0WULybJKCUIacbymH17QnU72BNnzwHvm2feT9Cq/qM1uuQYWn6BD3
 aoK9B9zh+6vOSFZwZ9To1kIvJAJwy9u491aDa00mvv225WfD2s3CuJ86eq4ynJt+tLMR
 JFWTbW9lhm8qzVBpraIFoZJIY683N/9n1RNGLvmEU31xUdusArzIvIYCfABU8hF2qQPR
 2Mp4zTemAkgYrq4InslnNsf0qN2B2kV94SFRUyTe2KroQHjfN9ozIgEMiVTpGH3Ao4ck
 kRPW4miCJEHdaM7B+F5gyEnCT9NitmS6GDnP2AmWvDTbfAB4qVKE7AFmDVetyMu8gKrJ eA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvt77d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 16:31:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37NG4H38036080;
        Wed, 23 Aug 2023 16:31:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ynaeng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 16:31:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqtJXyahWzTNnz0SqyOuMO5RCB90nQ1LNI2XQcruk2D+rNY8oWw8r6SP1OlKiDnPb08b0Rj0H+XgyXmlkcCF7a2PkrFEdHe3ArDfg6j2sPGxisOGCFXIRUpNDHYf48tpfZKH0QN3DQ7d7Cqohmt8ZWcPiWjytcw4Aq0yBc7Rzwb+Dl52X91bcBYpXbuUq1OnUyilmEZvzldd6EBDl878JUJmUxnWgdwb9b4w0hQBEFnElNPuYzriTNxwuaMrgd5jtntHgZLiIAGKECQuKJPDHcAyGXAPdrFNpmYWUb1bTnznhUPTob/Ds7SMpIQ8TjYnjFgu0zny23Lt6OHKgo6Iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REB7X1o33M3+LcxToE3BoBoRj3uKKXfpTBOgd+XgDBE=;
 b=CaunnTDZ4TzbvyWylNC7L2/CyaqeHKv+EsMO7ULiz7fAbHGZtdUiTlrtK/qbzeBksvOyb2RzBFt0z7f/plc7Gjd49/8GY1C+Cn5UUEWMpMu6vF8WkesoqyNz4pYmvBoX7aHtXaAcKTzp9ZEtWftZ88Cqml9/SnFlD5cNf64gk2QlKiEXMl1Ex5RwAy25jd4K9xc6gKcgV0Lbjej0L1Mu5/XqXJiTzU01unHY1Evnlm7sLYvY1UhcQWGzzhO8p6jpqQ1hyjIbjWHf8aHxz1j9rUtP7Ul9Yy58IZYaWpooywJ1hDjN/fzQG9L+aFetI9bEteF3lVwzZA3RiurxzG1dUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REB7X1o33M3+LcxToE3BoBoRj3uKKXfpTBOgd+XgDBE=;
 b=vIBddpSvfHBAphRXgS4kbjaWManawLFEEPyHYPWRZ5q0JmgJiKYXdqic3YD8CQsBCPfxY6GFpv8kFHWQYY0qma97kaZn3Vl5vimsjIoymT70/7/WReMRaz5ies1noUmXUR47+KE72uZG/LccyZyfO+QVE0oJwJ9vl2t8gLpOVcc=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by BLAPR10MB4852.namprd10.prod.outlook.com (2603:10b6:208:30f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 16:31:50 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::3b9f:c4fb:40f1:a1ff]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::3b9f:c4fb:40f1:a1ff%5]) with mapi id 15.20.6699.020; Wed, 23 Aug 2023
 16:31:50 +0000
Message-ID: <9dae9ca5-be94-af95-e7c3-0cb1d04731f2@oracle.com>
Date:   Thu, 24 Aug 2023 00:31:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] btrfs: Introduce the single-dev feature
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-3-gpiccoli@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230803154453.1488248-3-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|BLAPR10MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a22a46-6db7-4ea2-4883-08dba3f67383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spJ8wmBXPaspuX29QT0TnlWp71iYGTrXpzig0YVwjnfGH2OrNmEX0mihpjhZD018jeZqVIkSLdaSRi9zSpXC7WNSi5EVkpMayEgbRqBODEXjWNmnsYe510nzzqLhIxAQn2lwCRCn3McAZlRACM+VBROdTTUb1u04bV5YnLdzF432s+5tn4+42twTp5hiGEhcBbsw9nz709WL2x3snSnt3t5YB6SjJneo44w8wxPUKD/22IL7H4Tplb5UCy7CHwWI4W0sEDcud1IqJ9hb2wOLGvOphjOCQw9MPMR+VAGsTWHSqtnnCe2R7fHdvm7QxxTqVv3L2hMnIwx/kmCYBzBl6GmYfjBBTySMjUZzyJ2Ot/Kkj7QvA5XEbMEFLN9zVqr/V3WKmybdBR0XMAzEqRC1Sbp/X+eVU7cfUz8v0/rk6gZ8l/1VcTWqe/3yvTCCcbffppqkpT90v4y2B0pRVorf3xG1oola5Dx7Q17IYUpyNW4dAt8D2/wCTJUoprr6+dD9f+7dhNoubKbtBZYheXw10Y//WegQP6Ev1+drsXa84cHzyVdlBu4scxrvoW7UBfrgb8IbAGVQTuLj09sRGGHnpOZdKU5f1vg1tJDXGwB8xOAiQ3vwBPAPE6egrZtr344v3/xYM3T8tkVfQwKoc6+1cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(186009)(451199024)(1800799009)(2616005)(6486002)(6506007)(316002)(53546011)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(41300700001)(6512007)(26005)(7416002)(5660300002)(44832011)(6666004)(478600001)(31686004)(83380400001)(30864003)(36756003)(31696002)(86362001)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0FieTlaYlNodFBlbWxtU3Q2eGY3ZEo4QmFxOTVwUjA2a1R2TGZRZEpEL3lG?=
 =?utf-8?B?Z0VCYnBML2xwL3E2ZDc4SzZRSjh0Z3dMVFFUNzVGdWsvVVVMeE1qVVdLMDBs?=
 =?utf-8?B?OUJHL1p6VkdOTFJCMFQ0amxZVDcxVzNpVDJacGFablhVakFteXdwcDl2VmxI?=
 =?utf-8?B?Z3Zkc3VKUXpXd1cwaE1vUlE2Y0lveUlNbWs3c2ZZaGEzMUVZMGx2OUtvMGZn?=
 =?utf-8?B?TkRKSVJyanZTdTZaM0kwSEN3RXU4NlJ2b25SUzFzNk16a0R0alRVN3ZsZzVh?=
 =?utf-8?B?Q3hoRmRtb05YQVpmV0wvMWFLYlFzdzJDbXpYNHl3cSsrRWlWelkvWEdtYndp?=
 =?utf-8?B?aERneVd4L25SenE1SlR0WVhiYjk0U1FrM3lwd2Q0SVdJUU5QcFhvRlR2SFR6?=
 =?utf-8?B?TnZxbzJYZ1FNTjY5ZFNyd3NHaGlSMkZEWkRNR29ScUlDMzFZSjhuTkR3L3p5?=
 =?utf-8?B?K0pWWHVURlVOZnMxaDVQR1RvTDZVWGFUWm1kU3JMV2NpM2djMFowdzhLYTkz?=
 =?utf-8?B?RmptbFYxN1RVclRZSWhzeWwvV3J0QzRqWjVPOCtzd2hWMHFlTzhtam1pU1VY?=
 =?utf-8?B?QUZwQURFMDZZMWZXcGo4aHNQeGtmaWxDb2FqUkxFME8zbFQxdFFtVGNMZUdT?=
 =?utf-8?B?RGpJb3F2Qzc0QzVyUHNrQ1I5NVRSbHd6NXFCRjlUNDRuaTgrSkt5YlJHMzlD?=
 =?utf-8?B?U096YS9xZ3kzNGRPWU9XR1Y4VTNXMCsyeXMxbmZjSFptQkhHM2FmSW5nOGZk?=
 =?utf-8?B?WkJaZjBYRXRKRFJlU1lqTTVsUWZVSDJQSnUvRk5aa1lPU2ExYkdldEZiMmhM?=
 =?utf-8?B?NE0xRnAwSlQrUk5nVlhKdzd1RmtVb0I4bEVaOXc2OTVJZlpTS0lNemxMNDB0?=
 =?utf-8?B?ZWV1SnU3Zm8zMUpjaEVVYWNIbzhzb0g1Mm9pT2VOcGg4UkhJL1o5TldyY3hI?=
 =?utf-8?B?UWJCdTNuQk9VZDZYODA2WXdXZUZTRC9iRXpGQzdrcHEyN2g0d1V2YVJaSVFi?=
 =?utf-8?B?R29nN2xTN296S055dUFiZXRlZ2VpWnJmOGRRL3BOSEUrWjZWUDR0azlmUjhv?=
 =?utf-8?B?Mzlwc1E1MUNBL0NtWXg2bGhhNUZoY0R4aVhaZ1lVcitIQmRhd0ZCWFVoYWdj?=
 =?utf-8?B?Ym10dHhuVndheE5sSG1pdXp4OVRQeVZkMmFjV0dwWlp6cEZIUWJhdmJ5anJa?=
 =?utf-8?B?L2xrMzZGdTlaN0lCSDFnVmE1Ylk2YTNsbUYxdGRuazR4MUhxL0tCaWZOVGhX?=
 =?utf-8?B?Q2NET2dJYzhEdDQ1aHp0WVhXbjZsb2x1VE5LOERkWm1HRDJKSHB6alNqbXlY?=
 =?utf-8?B?WXV5Tmx2OWYzc1llM2FmWTV3YVpGaG5BY3ZxNklVcjhSSDJ3eTJVczcya0c5?=
 =?utf-8?B?WWcyMDdNODFzcHE5RVFtSVpqNFZsdnY1Wlc0YWpDQmx6d3k5T3ZVMXpxdWJh?=
 =?utf-8?B?N09oNFpDNWFSaHZLdktQcWU0UlhWb2s5WEhIL2doNWNENS9nbHJuU2FFbG1j?=
 =?utf-8?B?WkJvd2VNTXRHdWNIUWZhRzdqdjlmRHhPMEQyc2R1cVg4ckJrcGhGeVpueHFi?=
 =?utf-8?B?clFtZ1RuaVM4UmZUc1FuTXA3bHl2Z2ZqalR0TXlvMC9acGQxTzhIU2FQWGFZ?=
 =?utf-8?B?eUhkUTFycE9xY3p6NjFSL2Zvb3JDTXg2TjNBSVA1TlVoTnE3aHk2aWtOZm9l?=
 =?utf-8?B?QllqdlpjR3ozUTFsMFhqcXQxQklpTUdLdkxWQ01LVWRjRWlQaituamVuRUVw?=
 =?utf-8?B?QUxmWVNCQ2czczFwYTlmS2NScDlOcUg1S2JlRzNZQ20vaXp3Y2psR245VFJD?=
 =?utf-8?B?N3dGTmNYWHZEcUVKSFVmUmdjS093dU5rVVlndkxtUmtuUTdFczdRZUNTVVdy?=
 =?utf-8?B?K2tDeDNNWkNUTmMxRmVxNW9MZFBUK2xlVjczNEpCci9BVnFCL3FoMXVFV2Rv?=
 =?utf-8?B?RDhkMnR3RlczSjZoV2JCeHFVOXdheDJIaWdGS1YrbkQxY3d1bERlNVNNSWln?=
 =?utf-8?B?MWNVS2pHemtIcWVhZ2RtSktUQ2tLbFd1UEpLYnIxV1JFMzQ5Q2NlQnl6dzlm?=
 =?utf-8?B?YVhjS1VJb2xmNXYydHBjUDY4a0J3RURPbGFvMmp2bC9xNks3Y1prOG1BeC92?=
 =?utf-8?B?QnBRWGNUR1ZDMU9yblJ5TEs5SFdSdmJpZDhYMDZkdnQxWEdvSGplWXByUU1Q?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bVFQZmNBMkpMMzJ2c055cG9IQUNQSWRvWHMxa3JsV1lPUTVRUzhhd3VpR3pI?=
 =?utf-8?B?Q3Q0ZmUxNUJFZGJKalZYY0hhek85d0IzZ3g0WGEraXF3ajcwY29NdVdSSEhD?=
 =?utf-8?B?TGdHUENxdEJzQTlUbTUyQ3dBNGpjNm9YY0I0N0xGcDdoS2RnVnhiRDVBVnlp?=
 =?utf-8?B?UE9RY3M3emFjWTQ4THFpc2dKMndsbU9acnlFZ2RPSGgydHNKZ2hZUXlRUG9w?=
 =?utf-8?B?cUE5enllc2xNMWcyT2pnU0x0dVhScW9nR01LOU41Sm1QdGRvT0VuR05wLzRp?=
 =?utf-8?B?Rk1oSzFiRFZaZUxVQVk5TkRFbGRPN2JBZjZ4Vk5Vb2FXMml5bVlDMUFYS0M2?=
 =?utf-8?B?WnY3cHdWVlRka0VIdGQxa1pvSis3SFo2U0ZyNFkzc1k5eG1YY0xCVzFaaHN3?=
 =?utf-8?B?TU41L1hqTVl0Snd1aU9FSGZJbURRQjhPZHhnc3Z4Um5FL1ZKRytIV0ZudTNN?=
 =?utf-8?B?L3dhN0VsZ0Rzcm5YRjMvN2Y4L1hpQkFWeGZkU0NoMU16Tk53Zytld0hiYk1s?=
 =?utf-8?B?SDdzOURmbFY2Q1dFVmNhZU5PSVRrVGFuRHAyYmFEVG50SjRiMHBoTDVLdzBV?=
 =?utf-8?B?SHRXLzgyKzNxQjd5NzhDYlJ6ekxodFFsclhhemQ3MGtidjYyK0R2TlNBWUVD?=
 =?utf-8?B?Y3ZtbU53Y1VrZGw0OU42c1FIcmdFUXhvZE0wN0VPQ1pQOWIvUGlOVVlVbDNx?=
 =?utf-8?B?cjdDcXM3OUR4NFFmVEhudzBINUlDaDhFTjgyU3ZlQ2pUL0RaSVA3dExQRW1k?=
 =?utf-8?B?c3FBb3RPZ2UyU2g4aFN2TFNUUXM5STZLeTZwaHpDMEZMNUpucnE3NlJiMEZK?=
 =?utf-8?B?SnBNbGJwUldLYjZDTm5lNUxJV0xvR3d0MlkyeFNnQWl4WFViWnVjUTV0U3VI?=
 =?utf-8?B?Wk5weVNVN3hvR1dRWGc0QVQxWk5Udk1tVCtJcDZFR2JFVkZoYzRjbXhIbG43?=
 =?utf-8?B?VEFIeGJ1MjI3NHIrRUZ2aFhvVXREbHRjL1EvTytMU1NIQ0gzeDVaOWJ4M2tP?=
 =?utf-8?B?d2JqVjc4Lytka2w4TFkrVDZFZVc4dmJjTlhSajlMcG1TcnJ0eENpVlBiQUtK?=
 =?utf-8?B?disvbE5oM3RwZkM0bVhqYzIydHZOSzVJc0hNR0JadEpoVFpTeWVZYzNQdDIx?=
 =?utf-8?B?M1M3RU9lNEtQVE1pYVloQnRkTXppcWl0SUF4bVNPQ0lleEVwYStMMHc2K0VJ?=
 =?utf-8?B?ZDVvVWlHcGZGTWlEUDVraFZBM3lSUVpjaXJLRDZpWlJyQ2hLVUJ0YUV1dHAz?=
 =?utf-8?B?NzRTZTI3YzdZNWdYN0pZOW5HK2dnQmhyaFJodm1DZWdBTS9ubzdNK0MxVUZ0?=
 =?utf-8?B?THNWeXVoVEZLSm9xQ1Z2bTVzU1UvaGhpQUhmT2dtVTVHSDBGNkRBbkpHRlF5?=
 =?utf-8?B?UElSYzllYmFaOGJ5dXRtQXViRkE0VCs1SzBYdzVEa3U5TGx1WmFWUGpISGdQ?=
 =?utf-8?B?b1ZaZUZOSlpNMTRoTFFpVmxsSU94eHlFVnBjQ3hBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a22a46-6db7-4ea2-4883-08dba3f67383
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:31:50.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/gdeqh5yvj4J4wI/2TqhgxjTcEOmvQaK9ZVE5+vJxUqN8Y448wvi1FeFbBlta4ertQ4jKBeAYVBO+lo2Hg42A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_11,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230149
X-Proofpoint-ORIG-GUID: cKd7bQcIPHq8doq_gXz_Y63Fxb4KR_bQ
X-Proofpoint-GUID: cKd7bQcIPHq8doq_gXz_Y63Fxb4KR_bQ
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/3/23 23:43, Guilherme G. Piccoli wrote:
> Btrfs doesn't currently support to mount 2 different devices holding the
> same filesystem - the fsid is used as a unique identifier in the driver.

fsid is for the external frontend, systemd, and udev stuff;
metadata_uuid pertains to the actual btrfs on-disk.

> This case is supported though in some other common filesystems, like
> ext4;

> one of the reasons for which is not trivial supporting this case
> on btrfs is due to its multi-device filesystem nature, native RAID, etc.

How is it related to the multi-device aspect? The main limitation is
that a disk image can be cloned without maintaining a unique device-
uuid.

> Supporting the same-fsid mounts has the advantage of allowing btrfs to
> be used in A/B partitioned devices, like mobile phones or the Steam Deck
> for example.

> Without this support, it's not safe for users to keep the
> same "image version" in both A and B partitions, a setup that is quite
> common for development, for example. Also, as a big bonus, it allows fs
> integrity check based on block devices for RO devices (whereas currently
> it is required that both have different fsid, breaking the block device
> hash comparison).

Does it apply to smaller disk images? Otherwise, it will be very 
time-consuming. Just curious, how is the checksum verified for the entire
disk? (Btrfs might provide a checksum tree-based solution at
some point.)

> Such same-fsid mounting is hereby added through the usage of the
> filesystem feature "single-dev" - when such feature is used, btrfs
> generates a random fsid for the filesystem and leverages the long-term
> present metadata_uuid infrastructure to enable the usage of this
> secondary virtual fsid, effectively requiring few non-invasive changes
> to the code and no new potential corner cases.
> 
> In order to prevent more code complexity and corner cases, given
> the nature of this mechanism (single-devices), the single-dev feature
> is not allowed when the metadata_uuid flag is already present on the
> fs, or if the device is on fsid-change state. Device removal/replace
> is also disabled for devices presenting the single-dev feature.
> 
> Suggested-by: John Schoenick <johns@valvesoftware.com>
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>   fs/btrfs/disk-io.c         | 19 +++++++-
>   fs/btrfs/fs.h              |  3 +-
>   fs/btrfs/ioctl.c           | 18 +++++++
>   fs/btrfs/super.c           |  8 ++--
>   fs/btrfs/volumes.c         | 97 ++++++++++++++++++++++++++++++--------
>   fs/btrfs/volumes.h         |  3 +-
>   include/uapi/linux/btrfs.h |  7 +++
>   7 files changed, 127 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 669b10355091..455fa4949c98 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -320,7 +320,7 @@ static bool check_tree_block_fsid(struct extent_buffer *eb)
>   	/*
>   	 * alloc_fs_devices() copies the fsid into metadata_uuid if the
>   	 * metadata_uuid is unset in the superblock, including for a seed device.
> -	 * So, we can use fs_devices->metadata_uuid.
> +	 * So, we can use fs_devices->metadata_uuid; same for SINGLE_DEV devices.
>   	 */
>   	if (!memcmp(fsid, fs_info->fs_devices->metadata_uuid, BTRFS_FSID_SIZE))
>   		return false;
> @@ -2288,6 +2288,7 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>   {
>   	u64 nodesize = btrfs_super_nodesize(sb);
>   	u64 sectorsize = btrfs_super_sectorsize(sb);
> +	u8 *fsid;
>   	int ret = 0;
>   
>   	if (btrfs_super_magic(sb) != BTRFS_MAGIC) {
> @@ -2368,7 +2369,21 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>   		ret = -EINVAL;
>   	}
>   
> -	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE)) {
> +	/*
> +	 * For SINGLE_DEV devices, btrfs creates a random fsid and makes
> +	 * use of the metadata_uuid infrastructure in order to allow, for
> +	 * example, two devices with same fsid getting mounted at the same
> +	 * time. But notice no changes happen at the disk level, so the
> +	 * random generated fsid is a driver abstraction, not to be written
> +	 * in the disk. That's the reason we're required here to compare the
> +	 * fsid with the metadata_uuid for such devices.
> +	 */
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV))
> +		fsid = fs_info->fs_devices->metadata_uuid;
> +	else
> +		fsid = fs_info->fs_devices->fsid;

Below alloc_fs_device(), fsid is still being kept equal to metadata_uuid
in memory for single_dev. So, this distinction is unnecessary.


> +
> +	if (memcmp(fsid, sb->fsid, BTRFS_FSID_SIZE)) {

David prefers memcmp to be either compared to == or != to 0
depending on the requirement.


>   		btrfs_err(fs_info,
>   		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
>   			  sb->fsid, fs_info->fs_devices->fsid);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 203d2a267828..c6d124973361 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -200,7 +200,8 @@ enum {
>   	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
>   	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
>   	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
> -	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
> +	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE |	\
> +	 BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV)
>   
>   #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
>   #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a895d105464b..56703d87def9 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2678,6 +2678,12 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on SINGLE_DEV devices\n");
> +		return -EINVAL;
> +	}
> +
>   	vol_args = memdup_user(arg, sizeof(*vol_args));
>   	if (IS_ERR(vol_args))
>   		return PTR_ERR(vol_args);
> @@ -2744,6 +2750,12 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on SINGLE_DEV devices\n");
> +		return -EINVAL;
> +	}
> +
>   	vol_args = memdup_user(arg, sizeof(*vol_args));
>   	if (IS_ERR(vol_args))
>   		return PTR_ERR(vol_args);
> @@ -3268,6 +3280,12 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> +	if (btrfs_fs_compat_ro(fs_info, SINGLE_DEV)) {
> +		btrfs_err(fs_info,
> +			  "device removal is unsupported on SINGLE_DEV devices\n");
> +		return -EINVAL;
> +	}
> +
>   	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>   		btrfs_err(fs_info, "device replace not supported on extent tree v2 yet");
>   		return -EINVAL;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f1dd172d8d5b..ee87189b1ccd 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -883,7 +883,7 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
>   				error = -ENOMEM;
>   				goto out;
>   			}
> -			device = btrfs_scan_one_device(device_name, flags);
> +			device = btrfs_scan_one_device(device_name, flags, true);
>   			kfree(device_name);
>   			if (IS_ERR(device)) {
>   				error = PTR_ERR(device);
> @@ -1478,7 +1478,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>   		goto error_fs_info;
>   	}
>   
> -	device = btrfs_scan_one_device(device_name, mode);
> +	device = btrfs_scan_one_device(device_name, mode, true);
>   	if (IS_ERR(device)) {
>   		mutex_unlock(&uuid_mutex);
>   		error = PTR_ERR(device);
> @@ -2190,7 +2190,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   	switch (cmd) {
>   	case BTRFS_IOC_SCAN_DEV:
>   		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>   		ret = PTR_ERR_OR_ZERO(device);
>   		mutex_unlock(&uuid_mutex);
>   		break;
> @@ -2204,7 +2204,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   		break;
>   	case BTRFS_IOC_DEVICES_READY:
>   		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>   		if (IS_ERR(device)) {
>   			mutex_unlock(&uuid_mutex);
>   			ret = PTR_ERR(device);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 73753dae111a..433a490f2de8 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -681,12 +681,14 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   	return -EINVAL;
>   }
>   


> -static u8 *btrfs_sb_metadata_uuid_or_null(struct btrfs_super_block *sb)
> +static u8 *btrfs_sb_metadata_uuid_single_dev(struct btrfs_super_block *sb,
> +					     bool has_metadata_uuid,
> +					     bool single_dev)
>   {
> -	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
> -				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
> +	if (has_metadata_uuid || single_dev)
> +		return sb->metadata_uuid;
>   
> -	return has_metadata_uuid ? sb->metadata_uuid : NULL;
> +	return NULL;
>   }
>   
>   u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)

You can rebase the code onto the latest misc-next branch.
This is because we have dropped the function
btrfs_sb_metadata_uuid_or_null() in the final integration.


> @@ -775,8 +777,36 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
>   
>   	return NULL;
>   }
> +
> +static void prepare_virtual_fsid(struct btrfs_super_block *disk_super,
> +				 const char *path)
> +{
> +	struct btrfs_fs_devices *fs_devices;
> +	u8 vfsid[BTRFS_FSID_SIZE];
> +	bool dup_fsid = true;
> +
> +	while (dup_fsid) {
> +		dup_fsid = false;
> +		generate_random_uuid(vfsid);
> +
> +		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +			if (!memcmp(vfsid, fs_devices->fsid, BTRFS_FSID_SIZE) ||
> +			    !memcmp(vfsid, fs_devices->metadata_uuid,
> +				    BTRFS_FSID_SIZE))
> +				dup_fsid = true;
> +		}
> +	}
> +
> +	memcpy(disk_super->metadata_uuid, disk_super->fsid, BTRFS_FSID_SIZE);
> +	memcpy(disk_super->fsid, vfsid, BTRFS_FSID_SIZE);
> +
> +	pr_info("BTRFS: virtual fsid (%pU) set for SINGLE_DEV device %s (real fsid %pU)\n",
> +		disk_super->fsid, path, disk_super->metadata_uuid);
> +}
> +
>   /*
> - * Add new device to list of registered devices
> + * Add new device to list of registered devices, or in case of a SINGLE_DEV
> + * device, also creates a virtual fsid to cope with same-fsid cases.
>    *
>    * Returns:
>    * device pointer which was just added or updated when successful
> @@ -784,7 +814,7 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
>    */
>   static noinline struct btrfs_device *device_list_add(const char *path,
>   			   struct btrfs_super_block *disk_super,
> -			   bool *new_device_added)
> +			   bool *new_device_added, bool single_dev)
>   {
>   	struct btrfs_device *device;
>   	struct btrfs_fs_devices *fs_devices = NULL;
> @@ -805,23 +835,32 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		return ERR_PTR(error);
>   	}
>   
> -	if (fsid_change_in_progress) {
> -		if (!has_metadata_uuid)
> -			fs_devices = find_fsid_inprogress(disk_super);
> -		else
> -			fs_devices = find_fsid_changed(disk_super);
> -	} else if (has_metadata_uuid) {
> -		fs_devices = find_fsid_with_metadata_uuid(disk_super);
> +	if (single_dev) {
> +		if (has_metadata_uuid || fsid_change_in_progress) {
> +			btrfs_err(NULL,
> +		"SINGLE_DEV devices don't support the metadata_uuid feature\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +		prepare_virtual_fsid(disk_super, path);
>   	} else {
> -		fs_devices = find_fsid_reverted_metadata(disk_super);
> -		if (!fs_devices)
> -			fs_devices = find_fsid(disk_super->fsid, NULL);
> +		if (fsid_change_in_progress) {
> +			if (!has_metadata_uuid)
> +				fs_devices = find_fsid_inprogress(disk_super);
> +			else
> +				fs_devices = find_fsid_changed(disk_super);
> +		} else if (has_metadata_uuid) {
> +			fs_devices = find_fsid_with_metadata_uuid(disk_super);
> +		} else {
> +			fs_devices = find_fsid_reverted_metadata(disk_super);
> +			if (!fs_devices)
> +				fs_devices = find_fsid(disk_super->fsid, NULL);
> +		}
>   	}
>   
> -
>   	if (!fs_devices) {
>   		fs_devices = alloc_fs_devices(disk_super->fsid,
> -				btrfs_sb_metadata_uuid_or_null(disk_super));
> +				btrfs_sb_metadata_uuid_single_dev(disk_super,
> +							has_metadata_uuid, single_dev));

I think it is a good idea to rebase on latest misc-next and add the
below patch, as the arguments of alloc_fs_device() have been simplified.

    [PATCH resend] btrfs: simplify alloc_fs_devices() remove arg2


Thanks, Anand

>   		if (IS_ERR(fs_devices))
>   			return ERR_CAST(fs_devices);
>   
> @@ -1365,13 +1404,15 @@ int btrfs_forget_devices(dev_t devt)
>    * and we are not allowed to call set_blocksize during the scan. The superblock
>    * is read via pagecache
>    */
> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> +					   bool mounting)
>   {
>   	struct btrfs_super_block *disk_super;
>   	bool new_device_added = false;
>   	struct btrfs_device *device = NULL;
>   	struct block_device *bdev;
>   	u64 bytenr, bytenr_orig;
> +	bool single_dev;
>   	int ret;
>   
>   	lockdep_assert_held(&uuid_mutex);
> @@ -1410,7 +1451,17 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
>   		goto error_bdev_put;
>   	}
>   
> -	device = device_list_add(path, disk_super, &new_device_added);
> +	single_dev = btrfs_super_compat_ro_flags(disk_super) &
> +			BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV;
> +
> +	if (!mounting && single_dev) {
> +		pr_info("BTRFS: skipped non-mount scan on SINGLE_DEV device %s\n",
> +			path);
> +		btrfs_release_disk_super(disk_super);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	device = device_list_add(path, disk_super, &new_device_added, single_dev);
>   	if (!IS_ERR(device) && new_device_added)
>   		btrfs_free_stale_devices(device->devt, device);
>   
> @@ -2406,6 +2457,12 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
>   
>   	args->devid = btrfs_stack_device_id(&disk_super->dev_item);
>   	memcpy(args->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE);
> +
> +	/*
> +	 * Note that SINGLE_DEV devices are not handled in a special way here;
> +	 * device removal/replace is instead forbidden when such feature is
> +	 * present, this note is for future users/readers of this function.
> +	 */
>   	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
>   		memcpy(args->fsid, disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>   	else
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 0f87057bb575..b9856c801567 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -611,7 +611,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
>   void btrfs_mapping_tree_free(struct extent_map_tree *tree);
>   int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>   		       blk_mode_t flags, void *holder);
> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags);
> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> +					   bool mounting);
>   int btrfs_forget_devices(dev_t devt);
>   void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
>   void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index dbb8b96da50d..cb7a7cfe1ea9 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -313,6 +313,13 @@ struct btrfs_ioctl_fs_info_args {
>    */
>   #define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 3)
>   
> +/*
> + * Single devices (as flagged by the corresponding compat_ro flag) only
> + * gets scanned during mount time; also, a random fsid is generated for
> + * them, in order to cope with same-fsid filesystem mounts.
> + */
> +#define BTRFS_FEATURE_COMPAT_RO_SINGLE_DEV		(1ULL << 4)
> +
>   #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
>   #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
>   #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
