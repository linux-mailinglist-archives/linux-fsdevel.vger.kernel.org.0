Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7820A7B664F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 12:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjJCKYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjJCKYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:24:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617B793;
        Tue,  3 Oct 2023 03:24:04 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930igMi021652;
        Tue, 3 Oct 2023 10:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Chu3M0GhBeJZZGYMr2sGxTP1E1ppC5Xbc7xxz5yRbAc=;
 b=h5X71E01DcaIQNRz/IZk4yKgCNWw4wj0Ty/zGqf6Dsplca8Lnls3gqUdurYv1CrgWEW1
 8/XVwyim9lcK32v4nQjur6rHQ/zNV7UIZiAOzX9RKzCE+QfkRJzCh3yCGdQ14PZq4bsZ
 nc1aF6wDc2TUBFZma2DpR5M4IupWWB3akJgbqDqvofEKFMwtpjuEbw4KTY5ZkcESE5ne
 nRyWz2x8lxpNRoPTR/HejxH7eWLfONjPwCHzuK2B56a7k6yhggDHHZEdWyhhQdKEzP/g
 toMwXRKaA8UfVwryNP4qdpJfVdmer3aS2atSBeXv1lfHfRB71bWOkaumkMW64bpJ/UL9 eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakccdhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 10:23:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393ADAMR025796;
        Tue, 3 Oct 2023 10:23:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4c676c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 10:23:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTLb/Nq+U8BqWNz7oHOYpr9I0QYZMBYapDdy/Kajo4WaajpHkpYk4j8kNnre3qrvJ9/8aPsj22GGU1BCKxyAO+ynyb+yr4ZaXq3qHFzCIjmyl+2AdEfe6X33imAEvW0apNnOlgdEVOIwb9jDe59Wt+kUdZHx/4tDY5dSuZjCMVefjaS8bNSdhqyFNY9Ny0DKZu7anmRa9f580kNn6PmCuBlpHcsCfxweMd0lLK3t9ad/k8vrF5ANaIZjA4DN+D8dee5Argvvoi1S20mSCJd3+R8yBZ9oODaREKY+jdcvFQdHDk9qKyjotsB2tewPgvZMBtnpS0Ix0/tYm/5Exrnyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Chu3M0GhBeJZZGYMr2sGxTP1E1ppC5Xbc7xxz5yRbAc=;
 b=K8k1LUqZmrfLhHD9Y9EKuiMaEPGT+bGgMe8yA3XjXDtD27oL4+XOZxW+e/l0tY2bZE3tW+8w6vBMWLO2d6HUqhv6coqNwD+QHEbO9D7osVbA9YQXq3Tghui2GoRrDQi3ZY1CPxYrLaHForPZ9sybQbjotW2MADJD6XquZMoG2ytKwhedhIG3WilRn8hUsvneyksPuFZ6qXEPhSPPmVOxT6zYoG/cWEYQeo+lv+uTNFIoF6fn1Vc8gDpi5AH+oZQzNpRpVNmO2RI8VzXfjm0G9gssbpca+1/m9A7x/smHwrC2k3Vt6h0/b2FhskbMrEkUmWsEgtBA5a1Fx9goiVt2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Chu3M0GhBeJZZGYMr2sGxTP1E1ppC5Xbc7xxz5yRbAc=;
 b=mxYob2iGB44+kg6EyutAVM24gcH4Y0Qcv3p6wGpRjiwBMb2yQaEten1We5YE479pE11jDW+zAOXS6YuntU/CVoCRdqrHq9WPpn7vZwuPhV2U+mtLR/8cvfqrAL+FYfhBVS62T3UIRgulsaja0WZ7EpxfT2ZRjDuzjedL23ZgCdY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6875.namprd10.prod.outlook.com (2603:10b6:930:86::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 3 Oct
 2023 10:22:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 10:22:53 +0000
Message-ID: <efc33949-9950-d51a-a7d0-d8214a092a2c@oracle.com>
Date:   Tue, 3 Oct 2023 11:22:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 11/21] fs: xfs: Don't use low-space allocator for
 alignment > 1
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-12-john.g.garry@oracle.com>
 <ZRtrap9v9xJrf6nq@dread.disaster.area>
 <20231003030010.GE21298@frogsfrogsfrogs>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231003030010.GE21298@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: a18d5080-e054-4f77-bb79-08dbc3fab424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+HJyVu78BnzUVrFwxW6S/lNMdYPe3Y4z4lkgvWNz+AGn46fQODscianqmesRNFRgvCXyywFKlFVWe5tybrekiQMInD/L8ZNmIoyDTbcX4WCBvlzRkEeFnRMwT650N03xNGgdz+UlEeTrszowVWz9KNfIvm1llg6F8KJ8qtvn+Pmj0NZHmq46bnuV1zgsAnrSOWQ+Y2SpktxWXjN6x9+U7Tzf3WR4fzI6ymlIxcSBetXBKoL4mTSapE4zKgUsavwgxXWGkGnYwcXx9beUGOhQiaNP4dN70rp6WJRJR8/cxeZMGI+wKMhEVV8muDgn/PbcF2yQh8RgMB9MmsM1j9OdliJcW3CnNaax3C49IdAajdPKsbIqYLr19xy6mQHxyfCWWorLtiWPmu33fq5bPjRpzbg82jgstDgj27aUrQlYx1pTi2u1uGCk/YqNxdxv+3TeuILP4/Cs0vDMs14ouNWDEykPgARgMreBpsK0/N7HQE5wdanLqQPNUotwUobT+wMDeuyG1VL48fjvu/WhO5BiIRTuWQrjzW9qMILCnpLUQ9gJ7aRE/dSXW9VC03D+PS9QtTuF6kWEmzhtr9cQrmtZTj7LzV6CGih9vzW7PSoxVSIicqPYVZLN0MCNGNtdZya6Qu00L+gCB5ShbjfmxXTyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66946007)(66556008)(36916002)(7416002)(316002)(38100700002)(86362001)(478600001)(2616005)(31696002)(6666004)(2906002)(41300700001)(4744005)(6486002)(6506007)(36756003)(6512007)(66476007)(53546011)(26005)(31686004)(4326008)(8676002)(8936002)(5660300002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzFtSndJQ1BwK29PMjdBUzJoTmJKYUUrUTlUQmNSb2xmVGV1T2xMZTQzYTBv?=
 =?utf-8?B?VHQwOFZpd1ZYYU9Na2FRLzZocVlvUloyNVBrKzlYUzFpYjI5OXBlbEIvdDZn?=
 =?utf-8?B?NklhdzlOaU9teE1yY3l3WCtXbys0OXJSSzlmeUxVUllqeWprSGl0MVFYRUVY?=
 =?utf-8?B?eGJFaVhtWXpwVm1ZeFhrVDFxUHFuT2N1MUVMRWNQVE5qNzA0QW0rZmhPeXQw?=
 =?utf-8?B?WkZ6K2VESTBMY2FXak9aKzliR3lZbVZSWG05dTZYSHRiL09haXFRVExMTHRG?=
 =?utf-8?B?MnlFUTFEcmhPdzV4ZVcydlcwbGMvK0RoT1pibDF4R0plaThsS1lMV3luVTNj?=
 =?utf-8?B?bmw2TE9Da2pyeTFsQWpFMXdwOEVDNkJzY1VpczE0Y0pKd09Kc0s1WmZMbHVE?=
 =?utf-8?B?VGpJbkpNYTVvNEF3K2V5V2tIQTVMMTA5a2ZVNWxQOVZ3c0VkRTFoSTd2cTM4?=
 =?utf-8?B?REFJOVBkdXBBOUlYMk9TUWpEeG9KbmdUWXFOV2R2SFozV0E1WmU4cXVuOXYv?=
 =?utf-8?B?eCtJSmdLcXF3QmVnSmxORy81THY0QzJGUjZQWXRUa2tTbUtpOWFQNjZSUzJt?=
 =?utf-8?B?R2lmL3o5dElpdXNNdU1PaFpWVFZBWGNQREpyaDg0Qzc1dUM5SjJqYU81Z2N3?=
 =?utf-8?B?QnlybUF6YmpWZ0M0Rk04UVMyVmRuQ2dzdzNOVkRKZUR1dGNUK3N4L1h3UmRq?=
 =?utf-8?B?SURrWlFxNE40dXNFMHlkOUdVa3JUSUYzOGVBMVp5ZER1K2pycW02SzZaeTU1?=
 =?utf-8?B?Vy9NazVhV25XL2VsaEtwVnZ5T2Y5bytscXpINUYwY3lvSXFjVDFna0x1SHRP?=
 =?utf-8?B?dm8wVHFoYzMyNmFlRGVHdjQ5T1pySE1abVlkanJvUStKVCsrRGFXdmVVbzc0?=
 =?utf-8?B?TnVneHR2Tm9Gc0hUM210ckJTNUVmWDZmbUZSdDlxTks3dmRmQkV3VDN1ZE1y?=
 =?utf-8?B?Z2JaNG1EVE5TR014NmZMOEUza3JqVnkvT2x0cWluOVZtS1hRbVBlb29aTy80?=
 =?utf-8?B?U2tzSTdyVjFsL3hiQkNqelNPQ09DMFgxQytMYW41dFdJWXFZOG5XdlBWSFEr?=
 =?utf-8?B?MDJsUkpHazZFWUtYTTJZYzYwVUpHSWxlZE1FSWpHejN6N2ZvRGIwc0lrQjkv?=
 =?utf-8?B?RU9HOUNZQW5ZNG9SeHNWcU9OMmJBaUl1b09pcHliUmRyMitkeVExeDk1cld1?=
 =?utf-8?B?b1FQNkxPTU5pb3gwSHB1VWxrWUhKM2txaXNpbTJhYnNIQTl6aGRhdkpyTzZ3?=
 =?utf-8?B?Rk5WWFFXOVJ2SUpqU1l4RStlTFNRZFdKeEltY2tUQnNLS2pEM0dpVkJuM1Q4?=
 =?utf-8?B?YW1zdXlmNHMvNUNVY2hmODVCQnBiY1RHQVRHc3hFdmRmTGdLWk1kbll6czhP?=
 =?utf-8?B?NjdHNGxxN2RpQjFKeDBSTFZzSGFXMjF6WjE3YjVoTUNmWmxXZDVZQU5LYS8w?=
 =?utf-8?B?TDVtMTdZS0tGQXR3ZjZsRS8va0FwQmlORkJJeURHcU52T2hDVjQ2WXZ5MTcv?=
 =?utf-8?B?SnVhajkvMlE5ZlNncHk1VERqcy9ZVWRvZncycFRZL2Z5cVdBMmpnMVFKZ215?=
 =?utf-8?B?b1JPamtoRG0xTXNYRVZZaDhzMWp2NU00Y0JWQ2RpM0NBeGZQUWh0dEpxNlcz?=
 =?utf-8?B?dm5Kb1ZJbmRzSEtYdFlLRmxBRUdQRytaTzZOMDYzTlZWTytYZlorSmppeXRI?=
 =?utf-8?B?QnJrbTBqZ1pRbWdUaU1CK0JGeGZZNjNWRGFvdDNYeE5jYmdmOUl5ZWIyV25o?=
 =?utf-8?B?S084aC9LdXRmSVFmV1paNVBUeGFwbGF2RXpRVkkrTC9LQUhSQlhaczFKc0M1?=
 =?utf-8?B?aGVkcXc0L0JoODV6bmt4aXp5Mmx5NTRaa08yU2p4c2lmcy9hcUFRQUZOWDh0?=
 =?utf-8?B?U28xKzZnTXltUnBNeVlUNkRNMy9uYko0ZlRtbDNlbm9hMmpCVlJaek93QXUz?=
 =?utf-8?B?THdGa2xOWmJON2JSN2d1c29jSmMwaTVIeUxJTDFSeHBPQVRua0svL0ZZTWNi?=
 =?utf-8?B?ZjdadUZIbTFoS2RuS0RHQkdNVFRtanZMcnVpby9BMnJpU0ZiSG5tTE9KMEJk?=
 =?utf-8?B?QXhBM3dKRnlwZ1gvQVh6cFNqeFowL3FaRzNCbVU5WUxRS2JyQ0UwWExDUTBr?=
 =?utf-8?Q?TSl4MJhNzVWwwSqOw+apB7MG5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aENlczdnRllOWldURFBMc2c4YjZHYkYvcDU3aXkvZFpRSUtFQXhPRDhEUHVW?=
 =?utf-8?B?eDhCOEl1bGg5N1ZrbWFWYUtPVHZKZTV0SnhzK1VvRS9XRW84MGgwVUJHc1F4?=
 =?utf-8?B?RGN0MHZRZXovODRVVGtBRE5ZL1ZXb2VORnZrSTFMY3MrMXBzbWR6Ujg2UGxy?=
 =?utf-8?B?bVhGWnB1SjFqbVh4bHhFcHdHZUV1REJPaUZUVWhEYzQzOFcxb1BUMDJqMzJ2?=
 =?utf-8?B?VXh6QmowRE85WXM3ajBSaHk0R2RoWkgvbmFJYXFjdFM5V2JqcTk0QlVZMFcw?=
 =?utf-8?B?WWRsWlIxbFlwTWFTQXF4NE51Q3N4eDlJTlN1QUpVRTRJRURRbzRwOXpJSXdJ?=
 =?utf-8?B?R0c2MlVublFsZFBJQWdrZkJhamNBTFY4MUVUSVlrc21MUTdWenNlc0hTbHRP?=
 =?utf-8?B?QmlXMWNjK25RTmhBWC9UWnVxUWlBR3VacXgxNmc0ZElHckhWaVBrZmFzWE5D?=
 =?utf-8?B?T0lhTitCRDhKZ0JkTk90ZFhxUjllMjZMWGFFaC9STDdlS3VFWld5Q2loQVA2?=
 =?utf-8?B?ZGRST3A2R1I0aHEzWUJGa01sYlROYnJLR0RxRFh0Qnl0WHNXR3JMWVUwRHd1?=
 =?utf-8?B?bkROcUhYNTRacFF5SkkvTmk1L3NxWEEvQWUzV0VLNFRBTUJjMUdnUWpMbDVN?=
 =?utf-8?B?Y3lja2FHLzZmRVc5UFpNVlBJNW9GSUt5YXdtQnF2RnpVRVFQWCszWFpXajZY?=
 =?utf-8?B?dXBIYjI2WWVoV1dqRzIxNUVKanlMSTRBQks5L3UrV1BDTzVSZ2lyQWg4UFZ4?=
 =?utf-8?B?QldBRGhDMEdtSTlRY0dYczFybUNkVEtiWWhDZlhyeDBVU0R2elQ3cTRDUkpo?=
 =?utf-8?B?eWJSNWR1RVFHNGQwNWJ2UWxHSCt1VWM2MEo5dGpYVGdwZmx1QXhpY09lVldL?=
 =?utf-8?B?bGpOTDZYZjdHQlUwZ3EzbGZDNmZrYjdTRnA1aWE5ZHplSW1LMHdvbzlPdzUz?=
 =?utf-8?B?SlV0N3RvVGJjOVR3T2NUM2pVQWFpTVF6QXp4WUxzUEpWbklyelVMdXVqOFFm?=
 =?utf-8?B?U21kbVJVTEJUMkgvb3k5SHhOZG5NL0lTUlF3bjljdlNHWEFNMENpNUh6MjJp?=
 =?utf-8?B?QXlSL1duZDBNUkNpemx5NmV3SW5PNllQYnRQTWRsVUxnd3AxRVJ6eDZGMWVJ?=
 =?utf-8?B?OFp0RmMzRGFZUDJjNFFVZllZRnFvc0daR21HYkJ1cE1ZR2ttV1ZYYW95cFdJ?=
 =?utf-8?B?MnIxRm5mSlNXMG1ULy9SZU9tczFTdjRJMTFnMDI3ZnMwTGZubUkyRHhiVDcw?=
 =?utf-8?B?N1VzdE5POWwxSVhtcG9QL2xyVWxNYlp6YnAxZFBqeHkxMVZNK1h4RWgwSzBh?=
 =?utf-8?B?cWhuaWlvK0pqeTNNdW9RTE0wYktlTnpacnZtUHlCZnVtaER2TzgrRE9hZVhY?=
 =?utf-8?B?K3hGMEdORjBUY1dmMjBsdWp2L3JyM1lHdkxQcHlwbWhiR1NNS0Q1STBSa0xT?=
 =?utf-8?B?N0ltcDBwSjlneExYdDJudzJoZXVpVThMMEliVjFQOUdIOEl0T2tqY2xYcGZP?=
 =?utf-8?Q?LhssPfAu4rnzwSVE/UG+pDbdw+G?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18d5080-e054-4f77-bb79-08dbc3fab424
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 10:22:53.5825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvnWXyVKnmHSNHTwWZoxveJwsnyq503PLp/vaaXsgo2IaqDKvSgUnaTVncPQl0G5yYWRcTe8SytX3AsZNUK59A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030073
X-Proofpoint-GUID: qxxlS9ospwzccw_4F_N7eURpoKJcujf-
X-Proofpoint-ORIG-GUID: qxxlS9ospwzccw_4F_N7eURpoKJcujf-
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/10/2023 04:00, Darrick J. Wong wrote:
>> How does this happen?
>>
>> The earlier failing aligned allocations will clear alignment before
>> we get here....
> I was thinking the predicate should be xfs_inode_force_align(ip) to save
> me/us from thinking about all the other weird ways args->alignment could
> end up 1.
> 
> 	/* forced-alignment means we don't use low mode */
> 	if (xfs_inode_force_align(ip))

My idea was that if we add another feature which requires 
args->alignment > 1 be honoured, then we would need to change this code 
to cover both features, so better just check args->alignment > 1.

> 		return -ENOSPC;
Thanks,
John

