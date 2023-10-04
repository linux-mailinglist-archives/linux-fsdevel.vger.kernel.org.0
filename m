Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4372A7B7B8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 11:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbjJDJPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 05:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241885AbjJDJP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:15:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B96AB;
        Wed,  4 Oct 2023 02:15:25 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948iehR021245;
        Wed, 4 Oct 2023 09:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ET21yQI9GGrJehp9qKnMQ0jIvy8nST/ScgcJ33/4zKE=;
 b=iFpZW5hBiyfzGqYfjTIyYbDs0sTv+A/NB/huKVAUMGAjhvFFdvuvpqqAJTYGD35IE/SU
 QB8LbXPgNV2bTjpoF6xm9Pdo9oqzJwg/OM1wNsGVGoUTrrF+DcvQDcsYm0pkY/t3liIs
 lpTpq03dbi0n/aRpZJvCHSgtdnXfGo2o7tWY4q8Ae6MVXRRyfh95NxM4qovqcqGTMkBl
 HkpY0Yh3cMdmsLe7344jIWABn+O3PCEwBdxHzRyXCUPxpZSOEFN5odkjVdA4Trv7KTjS
 aBty0Ms7QlleYk4EuEPy0cKTSDtPAPEHCjwJDl9eioNVHwokB3YgMis3bTyjVzaMIJYg zQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakceny7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 09:14:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3948h0Hl000377;
        Wed, 4 Oct 2023 09:14:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea477s98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 09:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGKVMiGnRQ2tDpw9StC3w6ViFO2EZVWBdvoI6tjRzREsjP1SkQrAhLtHpaiZSmrb34v+4wITcPn8RrtpR0z+4Q7AHM9gcJ9+iIQlY0q7Uu1kquTE3XVoum/QGTVlmbYgovki3tHLignWp0ECBY+vvI13HNC/dCMTN92WhFaNPkX23hX7P5rfFSL1BpKepFQQWMrbnQMq1z5xjj/ycz1bOMX7yY4a+tXezyHs04z/UuLhrq3Z2NyMQSb9L7lxWP52myDlka6Hxic5x2STBniVTvmLsCwIiJ9UDPppKDuBDrzUmG4YEmDGxHp1fk8m4OW0VfosuFH15jeTIfzreWBHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET21yQI9GGrJehp9qKnMQ0jIvy8nST/ScgcJ33/4zKE=;
 b=Pe5z2XE78YwI2aaj79l0ZUqiG+Oebw1wHNhBt0R47rc1cVoO4Ew8HZa2XQFtwUBJYmH8cBN871ImIpo4h45m1EKKOo/3VxUJEYw/LdUy0/dmsdRd0X8ce7TWh3AvAgVo9n2+2VTsHwVnA9S0UoBZK/oWfs4RSUXIwFDyYRHKnA5hT9RRxQXKvLVvmjprBKRE79Xo+idCGMJTYoe59ZUAqus+ubH1T6eKvrqm66H3psWhEngNrAJjWMlNc1RV6QhwqcZjsr7xuHJBQrNUcaI/c98mUK9BSY3dCULdFJ+h8zL2MutEl953YlmdkWHWAQiW7eoTByYMFNiX2XJOZM1qlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET21yQI9GGrJehp9qKnMQ0jIvy8nST/ScgcJ33/4zKE=;
 b=TMeCK+4Xxm3GkfAIwO1j/G4cnjDfvesNqAsAYK5f085u8eBNALiBHpZmK8jQRMsSNDe+VQ6yuVTb3ijeU6w8Ni8ZUB8Vw12fCEt9XRZslip2YYLpct8U9yGSdYyMV+p0XAs4bbEwZlGQColIUbCHY5pTNwCvcQw19SN6Z0Cl2qo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN4PR10MB5797.namprd10.prod.outlook.com (2603:10b6:806:204::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Wed, 4 Oct
 2023 09:14:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 09:14:32 +0000
Message-ID: <d981dea1-9851-6511-d101-22ea8d7fd31e@oracle.com>
Date:   Wed, 4 Oct 2023 10:14:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <1adeff8e-e2fe-7dc3-283e-4979f9bd6adc@oracle.com>
 <8e2f4aeb-e00e-453a-9658-b1c4ae352084@acm.org>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8e2f4aeb-e00e-453a-9658-b1c4ae352084@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0292.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN4PR10MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: a98943ef-f8bd-4dda-f13d-08dbc4ba5222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yz4XDWeYZIY5xmm4U9M3M7/Hnp3Kz4YnRjnGNNo7wqCP2NVsi21Cd2qvpMjkOcNTyRAZFSvRyDNFdkugZJYx9PSfnjV8/hsWJgCORiJsi2sfjx/+eWhaudW80gXZlSXOLZOgmNZzZodqQQxaITXZeMjwoILVItj6NxOhBFv+AJeCUKd2F2lAgVl1XjRSoH0kJWbGmCeW21IsLNWuSPx9+LuWqpUgksG2S/2rlKq2Fnf3VHBbliiSpjxwg2EKcfShlI5EDAqzmriFS2E0Se/R1q/4uTm3pjyxSFtvx/6quYKtLZ4ZYgH+ipwxqj6P66VlaeiEjiHFyPBFAhyOflLfvdzxFuNyP8fEip8fKQl15+yswuz4clnLNqC6kIXPaDD1/GrmsEPWUK1cW3ob/6dSpac/lPza0kzWwa3E313pal4W7NxtfSkcV8N5M8XSU9dLD52sJMfxbE83beOsp7s1pLo8j0AfwbtpMc8fJSYjGlgRMfK7vVeXRrc5r5tWdHLlwWRDNKTgkoAojfILl2agnJNS44CEDZUDQYLBiQxsxQ5LvtsCEqFeIl+1T0AmXCgo0xrzyHi+kkcN1yjOWMEMBYE0EQ2pwGyBXZ07QBw3FWt1L7qGFiv8NUpvgyZdWoG1kzZAR3oMB5KvgeFqvRcED6VOfUFD4o1Dg84YVcOgdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(86362001)(6486002)(31686004)(36756003)(6512007)(38100700002)(6666004)(31696002)(6506007)(36916002)(53546011)(478600001)(921005)(316002)(66946007)(66476007)(66556008)(2616005)(41300700001)(26005)(8676002)(4326008)(8936002)(83380400001)(5660300002)(66899024)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3FUaFFoRGdaS2c5LzNFenRHVnMyRmk0ZkNhMXU3US9UTlFzc3FYcDBMcWZL?=
 =?utf-8?B?ZWdUdWx0c0JhOEUwQ2JYM0pPQmRFSDJrYmtiRk1EZHlxOFlJUzMvL1cwNzBu?=
 =?utf-8?B?Y214QmlLRFRtRXd5c0E2Z3VyTVdQbVRaYm9xTjY4c2xhbDUySkwydzIybyt3?=
 =?utf-8?B?Y05kMlRPNzZRS1V0RnVXQktlZU42dnNyNkEwc0lIOFNGa2ExWVdzZnJha1dB?=
 =?utf-8?B?UTF0WGVKbnNDSUsyT2E5bnBJYktOUE5CYnNhQkF6K1RZZGhMUG9BRWJKK2Ft?=
 =?utf-8?B?aEdHeURTNW9WUTJhb3VGeHBibEdueGozQWQzS05CM2ZYakJTK2lqbFdFbjVu?=
 =?utf-8?B?a0lkbXZ5WFQwY05hVkdWVWdQMVJMZFo5NEJ1aC92UVNkMmxHRGRQcHBzdTlz?=
 =?utf-8?B?bStPcS90SEE5bDhudG51d3k5RHJOVEtrMXRTSEE1WGRSOFo1OXF6emJpTUhi?=
 =?utf-8?B?ZEplc1M3Z01GWGZVcFVQcGlrcTQ2Z3I4dktCbitMMmdZT29Hb3d6NkEyV0F2?=
 =?utf-8?B?T3ZNd2ZDTU9URUVxb1g2ODFUK2xXUmVqVVJZbTJlSDU0bjFXMDhJalhob0pO?=
 =?utf-8?B?d3JGMGZXazRWbDMzV1praE5UUWFKYkYweS9PZGEzdzVoVmdkeEhiRXBmeEZB?=
 =?utf-8?B?b3VpUlJ5akVDQUdqaWpseklZVDlab0NiZjZRMEJ5QlJ6MlcyTVNGRDBaK3BJ?=
 =?utf-8?B?c3hXZnczNm9TSmpweHZqNE8xMUlJcXRJdGVFSWJHSzR1Zy9ERTJvUlV2UFpE?=
 =?utf-8?B?ZmwxZ3JOR1ZNTnNsZWJ3Z3JKbmZMQ2JadTZwbElKY09uY1dMc0lzOU5MV3ZK?=
 =?utf-8?B?ckdNZko5VzlzaG54VjJpOXF4OHAzZjZRRlpUL3dkcGI2RnMzOFpqWlE3RWlX?=
 =?utf-8?B?ODBwMk5QMkExTlZLclBxNWI5ZWwzNHdVK3lEY3Fqampnbk96WTFXeFNDOTVU?=
 =?utf-8?B?VHM4cHR5ODJOVy9UNUxXczZwd1pRbXkxTS91UTg0cWMvMnAxL0ptVWpqY1RB?=
 =?utf-8?B?dFFCVFJHSTZXUjNhcTlyNllGSFZBQVA2OXRwY3BiTk5YN0g3azc0OURSeDdM?=
 =?utf-8?B?NWR4c2ppc2Rlb0xobzVBYkFybm4xamRyQi9sVEQ0OVVZYXBrN2xCSnN5dm04?=
 =?utf-8?B?YTQvVkhKSzVmSzZRa1FMTk9GSVRWS3lXTytLZU9IUy9xdCtYRUc1dmEzcHJk?=
 =?utf-8?B?ZGFSbEF0VkFRamxVS3RGSStUbW8vYjE1dDJDNE13ZG8xZ2NRQnZucGpzNW9z?=
 =?utf-8?B?bGhxZFJnZzh4VU9lUWlaL25TT2owQTYwa2UvTVl4VkN3SHpZZnRrTFF2YnEy?=
 =?utf-8?B?bGk3aGhwMXl1TnRUa2FwT3NsVnZObGVsU0FZRUFqMmdFbjJPVWp2NEM2Qktl?=
 =?utf-8?B?cEQ0NVVCNUZ1emZCQW9TVktqVjNZQnJ3QTU5L2tuYlhlVkc1U3hkeG1XSE9M?=
 =?utf-8?B?UXN2dEdjMy9tOU1QTXFVUlR3a3MzdlJGUHZMUDlHVkJnbTdqR3NaZEwvUlgv?=
 =?utf-8?B?TWo0Tk9qeVM2U3NUdDl2RnNESjR3allHODFjelUwOGZWSjRoOTFiMUp2eWZ0?=
 =?utf-8?B?SU5NdWtMNGFSVHFhZy8zRkx3WWwySmN2WVUyRTNDZHRuKzlVbUpVQmdOWEZD?=
 =?utf-8?B?eUxiaU9hbHJsNldIek45Q1E3NklRdnI5MFROalgzU2xzajMzcGFoRVgrcWlM?=
 =?utf-8?B?azBkWmRhd3dKNVBHMUxXT3QzbjZKYkJOMnVNYVErV0p5VzVlU1JoZjVIOTE2?=
 =?utf-8?B?VnJpVGhkcFFlRklGdWxRVjZGRTVwOTRua0t6N2FNQ0JlM2dOdFUwRnh4OEUv?=
 =?utf-8?B?ZmxWVENzMFNaaytSeWVuU05ublFvQkdLM28vTDZ6SEdQUVZxN0MvR1BiS2FZ?=
 =?utf-8?B?bWdJcFVyM09TdXBUUVNlOW9GUDMvQ3JweDVsTFhHWng4c2dlWGd4ejVxSDM0?=
 =?utf-8?B?em4xS2p5TkZYTUVFWjM5cTIrUnhVd3ZqVERSam5VZ3VNMDc5QVFIK0EyNGs1?=
 =?utf-8?B?OS92ek5GU29rV1RXWGVlODIxa09DU3dFOTFCTzVnQ1FIMTh6Z2RTODhseU8y?=
 =?utf-8?B?TmRBb2FkSU12SUp1MDZyYmZ6ZGtOeDh6ODRIUXd0MlBCQ2I2L1NsUGlKeTh4?=
 =?utf-8?B?YTZ4T2RrUmh1VTVxTDR0VjdJbWljNm9UWXY1dlJOc0VJSWwxYkJhbHpRNmNX?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Vlg3N3VsZ2o1MG0vMGd2TnBNcWhBeHFtV0Yzc2cwZk9xM1N6VCswOE9rWHh4?=
 =?utf-8?B?N0VuWVcxWTFBUzJLeVVQNmsxem9LdDFsNGt3eDNLK2dkMVJndE9ZUWZTRVp5?=
 =?utf-8?B?VG82R0VRUVR5ekQvM1VFTkpmMHovMDk2bDhjOWhlbUdqUys2ZFhkWFRSN3pV?=
 =?utf-8?B?bVlLdlpEU1N0R1hWSk9ONytPUEsrQk41cXBMYno5ejM3bzYxWjUxOERPYkdp?=
 =?utf-8?B?bUZpTzdJWDZUN3h0b0xLYloycXVDbkRtb0Y2aTJzNndSS1dJUU5RaW1sN0Nt?=
 =?utf-8?B?NzZrQXVCQ2R4bUw5dGhxTlBQeHU0eUNrVWJXcFJLVXUxNGptMGpEU0pjUUxD?=
 =?utf-8?B?ZEJWVXlKRWFkeEE2YitTYVlHZnMwcEYrWnhzYnVhQ0ZXVm1HTTMzZlM1ajky?=
 =?utf-8?B?cm5NRXFTMFc0RHZqNUVRRE5sWVBOR25RM0J3OVpHYVJOSXRBSVIvaHZ6ZjA0?=
 =?utf-8?B?VmtWek5heWtpd0NQZExKaVFSaVVWcytZZVI2Q010OG5kSEhQb0QzVTFoZXNT?=
 =?utf-8?B?eGo0cndxSkxrd2NZbWNpeUJZZXFFK3FsbzRkWTVlMFNmOGgwNld3UERaMHd6?=
 =?utf-8?B?VG5ENkgrUHVraWVKZVFjTzhxK2ttVk9yam5IbWZCQlJoaDVMWHlXRlYyazRF?=
 =?utf-8?B?U0FuQXRxSjdGSTNkNk0wYW16QzhVZ0tKKzFxWE5JQWpwRWpHa0dWUVYrUHR4?=
 =?utf-8?B?dm4zaHM2ZzFjSkR1TUpnbUdnRW9oM0N3UXJ5d3FONWRrTUF3VllTdi9ISW4x?=
 =?utf-8?B?NW1zYnFaeXlndGUwRjkyZWZSMkZ2cWlPaTFyTXY0VllTVForTmJKcG9CV09j?=
 =?utf-8?B?MU5wSDBWRGloY2ZlQ0VqSExEWE9MQ2xJK3lRSUt3SnFEcTZHeUdJaW1sTTNM?=
 =?utf-8?B?Q3lmU1pTakNsNTZKazV2ZUE3eDh6c0FOblppa3kyRHVqMWltQU9zWmZXeDQ0?=
 =?utf-8?B?N2k2OU00eGF4eWpZV2FKT201WWRIV01qTXpRQmlENTlZb3RMNDVBSzZvNkNs?=
 =?utf-8?B?K0FCMENLR3hKOFFHdWlBSnBhRzA0cFR0aUU5RFFMN0ZCMTlRdGJBMEZtNUdh?=
 =?utf-8?B?dWVTdFdYM2dDaDM0cGdWWm11aWF2KzN3YmtGT2ZDeDhlaGRIbDNhMDIrSnVY?=
 =?utf-8?B?MmdDK2FieCtSVVE0a0tBV2duSVhBMFhlOXhFZG96RXJROHlDY2pka3NsMDdG?=
 =?utf-8?B?SDNBL3RtMnEwSHVQOVRZTWJkOGRneUpvQkc5SzFsMmVCQjdpUTBGYWtIWTFZ?=
 =?utf-8?B?L3NJd3BiaitkRTlxYkh2b0gxYktjRDJ1UzlTRE1HVWpTZWhza1pxOE9LbVRt?=
 =?utf-8?B?b0szSzUvSE9BdGV0SEhqcS9RYVdrSnBxbWo4dDRqVTAydGdhNjBUeDFKeXZN?=
 =?utf-8?B?Zk1oaytjeDZYbUlYNTljRVRJNzJRQjB5R0o0dkNJYnRrTnZhQVNkdElmTnQ2?=
 =?utf-8?B?U3dNTzROL1U4Sm9ZNHpraG1QN3l2c2NoTHgvY3JQYkRKTWNPQjQwUXo2b2Vk?=
 =?utf-8?Q?hNxJAc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98943ef-f8bd-4dda-f13d-08dbc4ba5222
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:14:32.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTBH0WBY2VQ0xJaMYqXLL0EkGtUvPHfgBxrPgGziZlr6XeebnfN4snQwcbFH9fAiYYSUw1JcJPuxscWD6XbXQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040065
X-Proofpoint-GUID: Gff2rOV59fKG7d85dtL_zFQrYnO6c6jW
X-Proofpoint-ORIG-GUID: Gff2rOV59fKG7d85dtL_zFQrYnO6c6jW
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/10/2023 17:45, Bart Van Assche wrote:
> On 10/3/23 01:37, John Garry wrote:
>> I don't think that is_power_of_2(write length) is specific to XFS.
> 
> I think this is specific to XFS. Can you show me the F2FS code that 
> restricts the length of an atomic write to a power of two? I haven't 
> found it. The only power-of-two check that I found in F2FS is the 
> following (maybe I overlooked something):
> 
> $ git grep -nH is_power fs/f2fs
> fs/f2fs/super.c:3914:    if (!is_power_of_2(zone_sectors)) {

Any usecases which we know of requires a power-of-2 block size.

Do you know of a requirement for other sizes? Or are you concerned that 
it is unnecessarily restrictive?

We have to deal with HW features like atomic write boundary and FS 
restrictions like extent and stripe alignment transparent, which are 
almost always powers-of-2, so naturally we would want to work with 
powers-of-2 for atomic write sizes.

The power-of-2 stuff could be dropped if that is what people want. 
However we still want to provide a set of rules to the user to make 
those HW and FS features mentioned transparent to the user.

Thanks,
John

