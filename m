Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D72C7A60B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 13:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjISLIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 07:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjISLHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:07:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E928F0;
        Tue, 19 Sep 2023 04:07:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6Sx0x015321;
        Tue, 19 Sep 2023 11:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=x3eqkFrp21Q6+oIUzx1ajnscwAnpTPDq5XfbbkArSOI=;
 b=Q0tYlsMsUBMFfOyvfe3CTawUMKHOdVT0hCg96lbYKS4AdO9+F1KzfmS0knUoViSlknF1
 BqnQFQuWG+z30xfPpY/qU7fLvPoQYV3piCUCMUKRtJbwGrth9FEI8jhYZpFUxcrm9gw+
 54WmHEx1use8tjauiEuZUJUshTZ3bStYWmRJn+xR0BbcU/QLsaFUlIXeS9hWd/4DSJoO
 CsOuVZ6MImJ16bM/9+2HdFJ97rcPOLHIefUSF9iLA/s7prgXm3+o+BsSYq4KDgmZqGx0
 W5IKP86tcoGNfieolBGuPDYHh1A1NFHRT6b/dfRjNnlkfFHSnokRAoKR82FvQX5n64bw WQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52sdvmcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 11:06:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38J9d6UQ030252;
        Tue, 19 Sep 2023 11:06:51 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t5fxpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 11:06:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzcwuje+pgE9XdNkP8qPPj4z1mV6WM1AbfZaOBpIuarIrKVfBas5dIxlJvVsrdyzl3qT93EvmIYrwj2CYlMjt+uschncvXsDdVzgwTDDxLAlqENfSaQCy4ZOPP8uLlfZfOsUejuVAcDs3HNVCn/aDcjNeZr7El30rw3GLQ5lJkAP9UPG3/VGgpEU5o5+5GR3McSFdOJrjF6SyWDDn12rxOB00jD60llNOL/GZkpbMhP6GccxFnlAd7jMZUCkWa1vKOKTQCK1Edn4amaVFHBWUVeyYYgAnu/GWLpyfVtnEWPdaw8MW9LB+CeuG5efruOgXsEgEe0/v3eFk/NH6gTBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3eqkFrp21Q6+oIUzx1ajnscwAnpTPDq5XfbbkArSOI=;
 b=e7dD8ZbrD7db2btzOmjkYgMjrZoxzy/Eki2tYvr8wFQN365vKST3zaQ6y1rN67Amu8dMmjUUY+XOcz+RKtmG59eGwyNf9x+/LSo1QCYvy3v4PXpSi22llLbYA9re9LlLpELVn55VNU6UejFdv9NVn93RmnMM6uE73kJJdqZWk5go8XPSpvwTzDEyt81NnsP59JlQSgacOwgMFthwDJ0zwrD8RO0qwYXOY2FoxS6uVHt+xW91W9Xa029+geMg8dWPG99j84CH8z/OJGnXJ4qo61FG+zFkCtHsIN1/nj6DVw9ygow8uJ7EDZ5kokYDMc8qTTu79L+/q4jdMySnBW1XoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3eqkFrp21Q6+oIUzx1ajnscwAnpTPDq5XfbbkArSOI=;
 b=Fac3R/tHtvhlL6cSr50mj5G2551lGrvzL7yBABzQB4+5pLEKaCLvc/q4fMMAT2ElfmhWoIL88wrz/WUuXHTe0yK3sI3zJRzVx9RKR/XbM0LhHiNSoEwjRudaXF0gb4/RtkJQMWuVlpyJyRMjD9ziQNPz+si76QALKJvKHjxvIUE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6532.namprd10.prod.outlook.com (2603:10b6:510:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 11:06:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Tue, 19 Sep 2023
 11:06:49 +0000
Message-ID: <f976c005-29fe-4f7e-e1d2-5262d638761a@oracle.com>
Date:   Tue, 19 Sep 2023 19:06:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/2] btrfs: Introduce the temp-fsid feature
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230913224402.3940543-1-gpiccoli@igalia.com>
 <20230913224402.3940543-3-gpiccoli@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230913224402.3940543-3-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a56c79-1cf7-46fc-f2b1-08dbb900852e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JdaEhaCbaiwH92N5K3eopBloLgzAjltbgOQZc2imwsXSZYSYBW49jgONjEEDfRu4yItzhm2DayFnvX4QokSIG5Z9n+bPRaFNyrZeT2kG4Ci5xHClPqO6/wl0vjnYIty8BJeuGp18P/ajC0lZgfGZXCbe4QVQcLlRFcWh6zO6rPEfl1xJofJzJLCQUhehv9XzZ0KUVqR0YlNcj18AN9tbli/KGaY48ORHjqJFNnwJtzRbybUIKR2Fwt4tONB4v8KkKcPQCzvsfv3d1y+vcDmoghTaHoMprcLvyLoLNbErC7u3fbyy1twiGwtrIM1cilAKVoXdHwJCPhXev0s6+RkpcACFCt5caoc7McE64xE9PR1g1tf2XkL1tWA3zmv3qqnku1sMGAtTJLDlOyBuwPt6YcHyU65Nqcjo+3/JXLA5QjHFngwxzQQF9p0L5quIMZXpYNKD2AhFFXIVyyjhLDL9M1g8dT+31tGJnLjfnkH9i43fe48b3QcA8zi0jFpR2qCVbbdL5zrtm2LxLLnTNUeE7b92viaKBnm/pMVAVapfeCg9PV8gcfpr1zj1Z61GtQCo9RDBN+O8VdObPdEuPN2E06C03s6/mf+dgxLSOy6J0V5Kl2MDseNEMLREkz19UJN8kTo/SNzmJepJIyx2VtuJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(1800799009)(451199024)(186009)(316002)(41300700001)(8676002)(8936002)(4326008)(6512007)(26005)(2616005)(83380400001)(6506007)(6486002)(478600001)(36756003)(6666004)(38100700002)(31696002)(86362001)(66946007)(66556008)(66476007)(2906002)(31686004)(4744005)(44832011)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGJTYjMyb0tWSktIRjQyTC83OHEzZHV5QUhSdWlWTVUrYWRmaDBpL21wdWtO?=
 =?utf-8?B?ZENRanBTbGdLRERYejNYMVFFOS9CV3VINE9ZQUtBVGdnUUNqS0FmSmxIKzJv?=
 =?utf-8?B?eFViZDBSRVQxT2dvcTl4TW1nMmJ0K0hjZGU2OG83MWpjeUpmMW0zdEJhLzBR?=
 =?utf-8?B?UE8xVkNrbFYreWN3bEFVVWliZDU5dE9SeWx5VzljN2lidFY3WHFaemdRdVVw?=
 =?utf-8?B?VTBHRDkvZHVRdElXSmpkR05BeE42SjNWc2hRM1g2d01wd0VZcTgzWW5zVXhh?=
 =?utf-8?B?aElOQjlwb3pzemRwbkU2akpWL1BzV3dMTXF1RERRQi8zdnprNHU2c0FNRCtB?=
 =?utf-8?B?NERQUUNkOGpYb25ibEFGODN1c2FzWEphNTJKVEVzZ3B2d1lna29YdWtsN1oy?=
 =?utf-8?B?ejlreUxsU0N3VHpoQTdONEhFM3Jnd3BZWkRPT25IbTh4SVY3N1JFV3pyOVFa?=
 =?utf-8?B?WFNhaG8zaWRFTFNDUEk5b1BqOHA4TEorTmhvTWFEaUVqb1pIVlR6THh4SkJO?=
 =?utf-8?B?dCtBbWtIanI5MTdBem5zT3pmM1hoenR3Y0t6cXl3a0thM2ZBbWRMNURJU3JL?=
 =?utf-8?B?aExwR0JOOWNnWDVDOHRUY0ZvOGN4Ty9HV3hxZlQ4MEhXOXpWcGZaUEg4cUNh?=
 =?utf-8?B?UTNhOGlOSGVIRW50QzNudVpKYlJOUWZndW5mRDN2eUZZVXVwNFFqdmxtQzZ3?=
 =?utf-8?B?NFhDUVRXU1orWVpYTmc5VThYdC9Zd2swS0dlZlZHZzBDMmRJNTRGeElWNEFL?=
 =?utf-8?B?RGdYWHFZazdUVWoyZGNacDl5Ujd3S0xiLzFNQzFhTzRXMlVUalkzTk1Qc29s?=
 =?utf-8?B?ZXQraGNTMjNQRmEyZlR0ZmlvaG00MjlOTWovaGdMdDFxVjMweEpIUWxrWm1X?=
 =?utf-8?B?ZTFBOEJTT1pqNTVWa3loL3VQR3Y3YlVnb1o0NG56bzYrbHNuWVdkOTUyajhJ?=
 =?utf-8?B?bVdYVUhZMkF4QlhBZWhWRjBXOXhpeUpacXBXaTRYSlhYaS9RZEtiOWx0QmJm?=
 =?utf-8?B?alFsV3pWWVhMcCtYU25vRllHNUhJcWcycXMxS09wUmozb2NFODI1S1Y1NFBV?=
 =?utf-8?B?bU5oeVVIblZHQWluOGRXVldyZ3Z6ZEE1alNVL1U0b1BwdHB6S3FLWElOS08y?=
 =?utf-8?B?akVsMjc1K3JjbHpqaGR3VHhYcXF1bEl4NHU0MngyUkV2aUZnMWxRQW42Sjlu?=
 =?utf-8?B?SGErYjJ1K0E1UzZkWGdPSGk1cGtQTWUvcnp3Tmo4YVBteGZNUFEyZmVxQnhY?=
 =?utf-8?B?dFJTV3JSZDN1cWhMdEd0YVp5WUV0cEJ3bURIQ3VuQ2Vrb1JlYXBSVXYxWFph?=
 =?utf-8?B?eGVPVlJJYytBeUpnckxROTlTSDNwamsxbmFRbUhTNGlGWnhTREN3NTFNTEd4?=
 =?utf-8?B?Sm5VTkxzbDBzZkh5VVhLQ3lpSHF0TU5CRHRNTVYxbEl3eUxNM2QrbVdYcWVv?=
 =?utf-8?B?TDFQMU9PQ05mTXJCVzhCcDNXMU5ySk5JemFSMHI4c2JmVGs1TUFPVysydWMv?=
 =?utf-8?B?THVYVVVYd3lnS09aa3V2SWFFUTZwcENQWlNhdlkxb2tBc3dQbS9FSzgyRTBN?=
 =?utf-8?B?THhJRDNIajNUU1N0dElRbzJiQUh5OTZWSG4ybFlWSXM2dCtZVjdhQzdWZm44?=
 =?utf-8?B?ZExrOXFFMml2VllRdHFlRG0yclBWMEtjMUVhVGwwZjYza3pmVzRIc1JVQ2V6?=
 =?utf-8?B?bGpPOWRBbjhZcGFQVXpDOHRNSCs2S0hLOEdHWVFWUHhPcHBRVE5zVmtwNUJN?=
 =?utf-8?B?RWNTYWcxbGJQQ0NCN2pNczZLWjF5akFabWRMSUdOQytJeGgrN05oNkRnZktL?=
 =?utf-8?B?WlVMemF1TjdWVk8xNGlhbmw3d1M5bWVlaU1vVzkzRXVqSXU3ODN2aFBCRWhp?=
 =?utf-8?B?bG5uYkkrRW5abXU5OTluc092STh0aXBSaFkwYlVrUkFEUlI2TkswM0ZFU2d2?=
 =?utf-8?B?a1NvaFlWM2xFR0JyaDVBR2lzWDZ2bGg4SWpZS2tVLzlDbzNTV094S2Raemwz?=
 =?utf-8?B?WkdvT1FOS1J1Zzc5OVRjaXBpaUhUNkpsVGlIN0MzRk82bFdNR1JZdFgwRFlM?=
 =?utf-8?B?cG1XOFlIcVk3TUxuaktXSFNKa3dUTVEvSys3UUN1OHlpaklhSEdrbGtnNGFv?=
 =?utf-8?Q?vN9KO/DHr0dvfShYi44mIbrK3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?amFnNmZkQzViNzRIL0Q4T1FiRTh2eEpZMms0R1Z2R3dXNitXRmh6Yk92MUpp?=
 =?utf-8?B?c3J6TE51cTNRY3lmZXp0UHdmYTdzS3BSZjhBYW5qS24vSGJhdmh2SzFjV1NH?=
 =?utf-8?B?M3l2WWdqbGtBKy9IOEVyeXg5blFJVkFCeElXaGRuR2R3NVFFSEZBRTR5dTlZ?=
 =?utf-8?B?MkFPMVBRNmErVkdwYzhFdUJtb3plell3dUxIaFFSaldXNVY1ZmVuUkVOZU9o?=
 =?utf-8?B?dldiMlk5UGRBU1Q5Sk9uam10NG1seFB0WU5Ja3VpcjJJeW9idGdla05OdDBj?=
 =?utf-8?B?MDBkR1c4MlIydFc0ZmJ0b3R6NGcybHpYcElLYm1waC9wb2VQUEVQRTkwRmZz?=
 =?utf-8?B?eGIxdVcvRHV6ZXJKN1YzV2lKcW5JZU9xYXhtcGVFWE1sOVd4VVBLS04wNkV4?=
 =?utf-8?B?NnpzTkg2OCtjNVFydGthM24xc1NRUEFMeEFyV1FraWFqSW1BR2lxWnNvdmRH?=
 =?utf-8?B?ZWJjS1dqbkwzL3Z3NkR1Yi9ndGdMZ2dzSlVBeHJTbEpWUUVrQ2RLWDdnYUxW?=
 =?utf-8?B?aXNaN2s3WEw0MGpvLzNMb1RFSEZCcW9HMXcraWhwV3JVMmJqWUtUVkVWMGh2?=
 =?utf-8?B?K3FndXNkMEwvNE1hdm1mMWt1Zmlxa0p0ODR4OTFmS0NxdWlqZk44MjlFZy9w?=
 =?utf-8?B?RTFtUmliZGFlQ1U5UUNkOE00UElCYjhORGFpSHhBT1lFVWtLM2dlaUs4VnN1?=
 =?utf-8?B?dURUN1dOM2JzWEdENDI3ZENhK3RtcU9oQ3FJZ0kyY1lFYTBFVXZibWVHTGlD?=
 =?utf-8?B?VUxrNDVkdTBhNHcwQ1hnV3N0VlFqR29tNE8rK0VGZlZZMWdGK2lOdVR0Y2Fx?=
 =?utf-8?B?R3lwSWJYVDNOUld4b2N2S3YxQ3cvOG5VOXNUZkMwRUlwbEM1ZXRhb1FpTnNL?=
 =?utf-8?B?cVczNGJ6QzhrTGZZL0xNZUpQcVYrd21mQ09DdENyZmthR3VhdXNZSEp2bkdr?=
 =?utf-8?B?NjNkTEwzcXk4amQ2eHdQS3pmRUc2RThMSzltQitFYUQyazUxTVJBOFQzM1c0?=
 =?utf-8?B?TnRmVFFFYTFqWFJzSzlzTTFKUE5wZmhTYStTZlN0Vmh5QUY2M245bkNKRTU3?=
 =?utf-8?B?Q1AzQ3JiLzFmNTEwczdWTTE3SFVhT2lRK09WVmdtdVFCeHNoN0ZaTWNibU9E?=
 =?utf-8?B?cEFKeWNiMWxRYjJwZmdoWHNqbmRQcHdhczBtMFNSbHQwWmlQL3FuRlprRTVV?=
 =?utf-8?B?aitrbnRwL2tVRnJ1U3RpWlFPYkhla1RQcldLSmJKR1JuNE54MitwMDhVODB4?=
 =?utf-8?B?NmJJY1dqbHpUWGdRT0t6eU1ieVB0NFd0M2U3RTc5YjJLUGlLdVMwVytnc3F2?=
 =?utf-8?B?M0g1VkF4bjVsTVJqZ2t2UU5aMEh0V2NLMmdpeFdYcGp5QXZDVGVJbUJMOUZN?=
 =?utf-8?B?R1dHbmJFNjhyQmlUdlg2WWIrcjdvdjZObW90aXgwcHc3Wlg2QVVPU2RVZjl6?=
 =?utf-8?B?Tnc2aTJZUW1ISkJkc2VtWEhYam1lVVMvWjIyb0NsbDcrL2Y1YzJEck5CcFNr?=
 =?utf-8?Q?zL/ndo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a56c79-1cf7-46fc-f2b1-08dbb900852e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:06:49.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfDpsy7JuTZT50ELaP6ZpUco9h0dFj6jxw5i9rGAFkianyN98NFn/XvOHgrMGQRj/xvndtHwHxHduQblVyzJxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6532
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190094
X-Proofpoint-GUID: 5yzMmegK8F2BjVd49PbputTotd0XECHH
X-Proofpoint-ORIG-GUID: 5yzMmegK8F2BjVd49PbputTotd0XECHH
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> +
> +static void prepare_random_fsid(struct btrfs_super_block *disk_super,
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
		

I've noticed this section of the code a few times, but I don't believe
I've mentioned it before. We've been using generate_random_guid() and
generate_random_uuid() without checking for UUID clashes. Why extra
uuid clash check here?

Thanks, Anand
