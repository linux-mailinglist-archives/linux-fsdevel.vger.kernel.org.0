Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B787B6996
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjJCM4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 08:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjJCM4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:56:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B3E9B;
        Tue,  3 Oct 2023 05:56:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930iF1d019046;
        Tue, 3 Oct 2023 12:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mPSWvd23dXXMVZaG7jRae3SkaLt0Uey0jQWZ+IhA+RY=;
 b=xNZo0CrzAE6VIXUFM040Nu86NAUAwmhp8RbTEhYsFGX9s8mA92SsyMZOFOve0TCoOfDu
 zuUC3U6r4U+cAs24JWanmH9VPjW6vxSXtdiL3bo15Web/9PCE2MTAE7gR0XckTQldujx
 9Bhy1CnHdMl8+LJsv93XdzNi7+xOURE7P3fHNIZsZMelJD0QKyWjVgTNjFTdmiwoZ7AJ
 9bgCIsNMiimaH9GVPZ/4bFicPnK+GX92QoshMzWKGnTx4NLXfHb5X13dm2VARm94C2lB
 TaLLdVQbotX7+VlUCeXYkK/xiDhBEjtV7I8svbPkCPP//6wAJgVemdZ7sp7nrWHHyZUu hA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3ecmbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 12:55:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393C31PJ005851;
        Tue, 3 Oct 2023 12:55:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45y9jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 12:55:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd1DkxDNUoaFLuHHI+Lp969EVoFLW7cuNYrv9Z5ZNtnri9EZbd0FP2hzOHFy+pWlrc5MZ+iqyl0qH81/NC32i/aLV8zi8+OJ0WIlDt7at5MIW2J4L2/lmW8xds7GVO7D8PH3tKOyBNnm5aT9Q3UC8z45g8ovcslkHt+lR2a5wcU/GHrHRh5u1DelWfTcHiTxTzu7gS1HpSyGXZ40ZFiEhBZ9GxgCx/hoDAp1kveC1ttJqisiknvaDdxles2WYsZutxmSxsr2XkjI/1KEbnpI8hk9Hda0QfHSdLTfxsflNEEcnaJHeMM7WawCYzkrzuFh/TPl3pRyin6arg75c3gG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPSWvd23dXXMVZaG7jRae3SkaLt0Uey0jQWZ+IhA+RY=;
 b=F0nunXonHlFueqCMnmmnQ4dqd9OsxukObefgunm60tffNxbSIIT93XpHCnk0IaKRTCvPbA3tg6hUs5Ab6pHzU+MCyKBaZsBVcTh7pFacvm5r433nQkl1dI7Juyrt0H91TeNDWIGKzB6aBrMndh8KmJVAsX7aVhWCl5k0tLkQW0op4ccssWQWGdegQ3c3Kx/SwFL3YXkxufJ8Svc5tvS1cPzvE2zpSKw0n+BBWAT7o81JpA2eelzxf00ChHQARzvkYQghyCLxD04+AsTMEh1+OeKogTAjfS/xbuHZEv/UnNX/Hk0kxNINj/8YS1PK5LVgCVmIZkMWcagNCgjUBpPe9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPSWvd23dXXMVZaG7jRae3SkaLt0Uey0jQWZ+IhA+RY=;
 b=u3P6R33UZJQ2sY2yzUyNuBL33t8a7w6Vn+yglgkDtmvkIt/b+9oS1K1L/KacR+yhQFvmKxSeXGSMI7AliGf5m1kFvY/8iimrr7iQYhZiqOvLkVpEEOBEqEy/GJtgEZL/OA3yoEeAWh2jRuiln5JmJcL1NycNfcCBlzy8J5+AguE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7070.namprd10.prod.outlook.com (2603:10b6:806:311::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 12:55:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 12:55:36 +0000
Message-ID: <fc98c53e-8043-807a-6dfd-37be726832eb@oracle.com>
Date:   Tue, 3 Oct 2023 13:55:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 16/21] fs: iomap: Atomic write support
To:     Dave Chinner <david@fromorbit.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-17-john.g.garry@oracle.com>
 <ZRuXd/iG1kyeFQDh@dread.disaster.area>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZRuXd/iG1kyeFQDh@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0232.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1f2751-98a8-41f0-7ff6-08dbc41009ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vk3Q9cZpVOusMn70eIIA74nfVil2exavgsxB5o+AqpyJZ3j4htRbBioT1PhSztpeet521FazyrTClOgxZLdt5vo34tksrbg1zmL4w32sDKRbpj6V4So3fsDmeutJ7JuIfaHqS3FHMxvFpe32CPTQY+cMRSwlntRVSSual8xHowwO35o+N5M8JMdFoe0p0IZ6+5VjFdi5E/R+YXphKT0jW2XW/RPRseennicUC6VBIE5utcdkjCpxOXZP1r7gxQSx/IGkw5DuUc21DTArR/e7jYknu5E1yXUFvMZqgmJ7BL/APWvFJcxrFqVIc4hy+ICkZVOBi12MKhcZWXIyLNazkp7bF9lLn+MSqnlEjtvejx37BCQ6HYuqRCSm281SFNJjfQat+8oglp8DdKYrTC9IOdETfu391MLpHrg63ysWzAsoFGCqcaeoyYpNwmB1HIQXC6bSLV4ZpC3/ZWDB5OLkAOsz8SH9RWd/4Mn/eraNFkzZN+BE7Z94cHFqFZpBvSv9ZNKHoia0ggU93L29XM1frjuXKyhUCvlMF8GBKiV/jh7RjU7xsdzbj6PByqb1XgM1ezbJPzZgwktp8WqMkgxT4H76dd4YMaeqokoYGImy5JJFiDgyBexhb1xTsqGcLA8YI+z7nelEc2az4cgXsGlIsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(30864003)(7416002)(36756003)(86362001)(31696002)(38100700002)(316002)(6916009)(66476007)(66556008)(66946007)(2616005)(6512007)(6506007)(53546011)(4326008)(8676002)(26005)(41300700001)(8936002)(6486002)(478600001)(6666004)(36916002)(31686004)(5660300002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXlwQm5hSjYzV3c3SmtNSEFkUmx4ZHlhNlk5VnBpbkVqZHN2MnNQZkRqNjV1?=
 =?utf-8?B?MElPK0g5QXQrN29ySm5hZGlGNG0zN0IrRmZvQXFBaXlOcENDL1Zuck9IdC9i?=
 =?utf-8?B?TWRQYVN4dC9GSnFpb24vK3pVTnpjM1l1aVNQQWFsRnBIaDlYM3lyaDJsZ2h4?=
 =?utf-8?B?eVFiNUR5ZUpIdGN4MHp4blpyR1phUVAwRDdlTVBuRnI4TDE5YnZnbWV5cWda?=
 =?utf-8?B?Mm5DaEhvZEhlcS9naEx5eXNqMW9PMWR3bDlpak9YcFNpR0dKRG1JOTZvRll6?=
 =?utf-8?B?d0NYSnlLbzRkNGVXcGV5Q2NtQ1V1ZWkwYklBL3Nrekdldm5QNytYTVJ5Z21j?=
 =?utf-8?B?Nmx4b05taE9lZHVUV1k1eXhtYjdsenU4VmtxanBtOFFJbytEMkVDK0xpN1Nw?=
 =?utf-8?B?WndaSG1Hd000Y29zNThkMUExYUc2Q0NXeUJlOHp0WlBZalBwaEU0cCthMmli?=
 =?utf-8?B?a1A2R3VxY1pkdVBuZFNDZ3M3SnErMkJDTnJvcVV5aURWZzJBRnVJaWpBTEli?=
 =?utf-8?B?cXpKOWQ4QVZlNkRna1UxUWI3NHlzU0hJZ2FHbjRzc1RjdjVuck9uUUxqQm5J?=
 =?utf-8?B?bndBdE5aTTVwQXVUWm00YVR3VjlPUlFaRWNYMkhCVENYa3F5anl4MDZzay9F?=
 =?utf-8?B?dGtQNE5NQkNFcndsMitzNkRXd3d3TytlMFFjcWVvZnUyZ2hYalMzWExBMDhp?=
 =?utf-8?B?SUI0SjV6N29oTDAxTVpMNktQWFhxcmM0TmFLMjlndENodytuMER0YTJGd3NF?=
 =?utf-8?B?RWVRamtUMkZxUm12dXAvaGR3MzRhbjdFU0V6MUFpTWhRR2I5TllQbVZCempR?=
 =?utf-8?B?OTB5TS80UzFPN2h6a1AzKzZzbUFTUmI5Rm9ha0V6M3hSWEFRaHVqUUt6U01w?=
 =?utf-8?B?eWNYMHF6YlBiM1RBTnNBa29rbytOR0FvVVVJNHlRZmRpZWtSY2NxYXM3NTQx?=
 =?utf-8?B?VVE5MDFWUmpGdzl4V1hRWFNIdDJMRHlaRmsxNGlvV2x4WkFSaEZWc1FXZ3Vt?=
 =?utf-8?B?UDM3WHFtc2pUUWJ6cGpXNlNiSEh1OVVwc2dlaElDVVUvVVVwdWlHaysxR205?=
 =?utf-8?B?UFczdExGa2tJYjlLeFN1Ykw0bTNhbGwrNks5bkp0bksvYTVmNEIwQnZJYWdG?=
 =?utf-8?B?d0pQYWY0SDc3cHRmeUR6UzFuVk1mTEhTaGcyZ0J2MFJhYktJVnJnUUt6WDFV?=
 =?utf-8?B?R3lKdmRwalVOOUFScHYwRTI3OU4xY204VmtuUlZ5eDRmbTBLcHRlYmRYM0xu?=
 =?utf-8?B?Tk54aThTdzhZbU13bjNrTDI5RkNjVzRKbFNnbjdzY1N1ZWlaU2lZRGhTV3Fw?=
 =?utf-8?B?eExHQ3VFOTREYzFEa0RyeWdBekJudi9GcjNjNFVsNkFDNFBvVm1DbmxmRktB?=
 =?utf-8?B?TFlKcE5TMzFOTngvVXJzSDA5S2dmb0kyK3NwVlhPRWR6dklicEFDc0ZSOFVV?=
 =?utf-8?B?UHl6M1lOU0xSRTY0Z0VxRVNXU1E5ODl1SGNWem5BYmd1TjcwbkcvcHRtKy93?=
 =?utf-8?B?SjlHbmlNVnFZclhUOEYvSTJDNFJxaUJrcTh2cHdqVE00cW52cWFwenJXbEx3?=
 =?utf-8?B?RkhZZS9vK1EydWpSUFRoRnFEakgrMkgvNi82VGhuTjdUbXJ2dWM4SDRtRzVW?=
 =?utf-8?B?UEJyWmNmS1ZiSXNSTWxrQ0t4Z0QzamtkV3J2aXpSZ1hlbmJ5Yk1mTmpIV2ZK?=
 =?utf-8?B?OXNHL3VVMjFKdnBKMFpOM3FiQjBuckxEZGtHdDdSQ2hLM2VXanNJWHNOUjdE?=
 =?utf-8?B?Z2gxTEtZbEpHS0JiU1BvWVBMemNDWUczcHFITGl1R3JlS0o2SFNTNy9BRDNP?=
 =?utf-8?B?dXFBb0NWbE82dUEwSnBWcWFSRVpIOW82YjBPY2dHYW10SHZWUlRwVm9tS2Na?=
 =?utf-8?B?d0dCTmN5MS9WNFhPYzVxRFkrME84SE5TeW9YS2FZZFJpaVptUTVYNGR4UXFS?=
 =?utf-8?B?VHBZTHU0UFdpNEpGY0hPb1lMcXBtREtEc092US9YM0xvdGpXWFoxWFBldWZ4?=
 =?utf-8?B?enR4YzdUcXNyUVdiUUgzV015dTdJVE5IRzZWNk9oYmsxV1pNRE1wOU1xRWZk?=
 =?utf-8?B?NUw5QlFOQXdNbUNEMDY2UzRhOHJ1N1hFeXhrVEhSdnhleWxIRDlYa09Td0ky?=
 =?utf-8?Q?4MOUQk+5Li8quwDf2SlIIuRZK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aEtaYUZyU00wdktmUWJtU09neGhwU1VweTZPNllCK3ZGKzlNZXdGM3pIaVpL?=
 =?utf-8?B?QnVWcTVxTlY1elR1aTkya2hFQlZ6b3VtV2UvVmw1UytNYytZOEdBZkMyaTIr?=
 =?utf-8?B?SjJRUmQ5NzNUVlhoWDFwc0JwWTJINThnTmd5SmNKWkkrYkcxS0thUXB3dmFO?=
 =?utf-8?B?WWEwQUplbTFQUFRzRUZ5RUY3M25Qbmh6VS85azc2NTV1QWlPM2I2V0kvUHFP?=
 =?utf-8?B?TnpocDFQWnM0NnhtQjJYd0NDSWJ4Mi8vQ09ZQjJNMmE5NHRxTy94QUVUek5w?=
 =?utf-8?B?cUROUVVwRFhoc0NBdVYwTUJzYms0VHRiRmhEaXZGNXE1T0sxRHBIMXF1QWRw?=
 =?utf-8?B?a1JmSk9kamxrMDdwM1F3cG5pVEprRVh4cWdhc1MxSVhMV3BGQytycmVrQk9G?=
 =?utf-8?B?NHlZcVFxTUdUcGNBV1h2ZVMyREdFaGQyaElVd3R4Z1hkVFhIN0E5bERpWVlX?=
 =?utf-8?B?UTZRQklUV3hwTUJMM1RiN3VweVl5YlJRWDE2cXZvWklrM2ZFQzZQWXRIK3VU?=
 =?utf-8?B?UHlPZGhMRFNlWkhuVStZYkhXZU5YMDhwd0x5M1NVUXBOM2VpbTJRcHNyWVFI?=
 =?utf-8?B?MkFFdmZ5OWRObU0xSWo3MExOMnh2S2JPREJtdkZFYmtUT1ZvU3ZmRS9Gd0Ny?=
 =?utf-8?B?Zk5IMjV5SHFxazRVbW02dzlONjZrQWdTNXZnRERSSlZ5aVJ1VTJBbnJ1SFQx?=
 =?utf-8?B?a01xNUVsYm9qUnVsMk1ZSmtocWEzVEZJMG1KM1ZmK3o3TjdUS1hqZk1PVlU0?=
 =?utf-8?B?YStaYzVFME9FV205Y28vd2YyTzNDT0ZPZEQzS3BiQ05oUDg4bkswRmx4NXhm?=
 =?utf-8?B?NlJ5ZVl1Yy9UU1huckVxbzhmbVcySDIzbFZXQ2tMRjl5MVdVTlVlT1ZQQlBG?=
 =?utf-8?B?T0ZKVXhOdDRpbTBqV0RDY1UwVkZRNkVRbGZhay9OR09qUmYxcjBEM0FhaXVX?=
 =?utf-8?B?bHdhWUxUVUZ4V2YwM3FCVDdLdHI0MmJyWCtGQ0pEbVRrbENEdUg1QWpyNzM5?=
 =?utf-8?B?WURlWEhpTDA2L1hwZnMyb05qWFJXN0tMMnFDVUU2YnFkVU9OeTQ4dDhsamY3?=
 =?utf-8?B?RDdIcFQ0Z3pOT3pveC9BQVd4a01NY2phRnV3UnpCMFc5QXBJQ2lDbkdTRUph?=
 =?utf-8?B?VjJ4MlY0VVZvU2pmcnRPd1ljQ0hnVUUzUzkvQXNIbmJ0V0Vlbk90QjlMYnpU?=
 =?utf-8?B?TkpORUtnekYrR2U5WnVpb1pzVi9ZYm83ZEJobThxdVZHZXdvYmpZRXBnSFla?=
 =?utf-8?B?TG9HODBCblhIMTRXNCtsZ3A4cU50VFpscWwvRXV5TTRkV25TdVdFMkpsMWZN?=
 =?utf-8?B?RlNGcGZadkxoQ2Q1UWR1SC9UQnpxWmY3U0c4MXdaVUV3Y245MTZ1Z2FOci9a?=
 =?utf-8?B?S3ZPZWI5N3FIenhKS0FzMm9adld2MHY1YzVyZFMvSFJUd25za2VKdks5YXJm?=
 =?utf-8?B?SHlYTldvMEs4NDV5d2pUOUV0eWd0NFoxTHhQNFdmQk1mRG5ORExlNlpaNDBs?=
 =?utf-8?Q?/6vPxSd89qJuv8QU28GphAST/de?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1f2751-98a8-41f0-7ff6-08dbc41009ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 12:55:36.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqWc+EHt1qqgVYmUj6RaLbQj4hLDOlzZIS7bhpnvqGnmFPDDCCeNG8OUg55dn8cIyNHa2HM8zW7KYA0Msy8qXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030094
X-Proofpoint-ORIG-GUID: 3uVbSpNM_tjzqob_pYxJEO1hSMiCzPMV
X-Proofpoint-GUID: 3uVbSpNM_tjzqob_pYxJEO1hSMiCzPMV
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/10/2023 05:24, Dave Chinner wrote:
> On Fri, Sep 29, 2023 at 10:27:21AM +0000, John Garry wrote:
>> Add flag IOMAP_ATOMIC_WRITE to indicate to the FS that an atomic write
>> bio is being created and all the rules there need to be followed.
>>
>> It is the task of the FS iomap iter callbacks to ensure that the mapping
>> created adheres to those rules, like size is power-of-2, is at a
>> naturally-aligned offset, etc.
> 
> The mapping being returned by the filesystem can span a much greater
> range than the actual IO needs - the iomap itself is not guaranteed
> to be aligned to anything in particular, but the IO location within
> that map can still conform to atomic IO constraints. See how
> iomap_sector() calculates the actual LBA address of the IO from
> the iomap and the current file position the IO is being done at.

I see, but I was working on the basis that the filesystem produces an 
iomap which itself conforms to all the rules. And that is because the 
atomic write unit min and max for the file depend on the extent 
alignment, which only the filesystem is aware of.

> 
> hence I think saying "the filesysetm should make sure all IO
> alignment adheres to atomic IO rules is probably wrong. The iomap
> layer doesn't care what the filesystem does, all it cares about is
> whether the IO can be done given the extent map that was returned to
> it.
> 
> Indeed, iomap_dio_bio_iter() is doing all these alignment checks for
> normal DIO reads and writes which must be logical block sized
> aligned. i.e. this check:
> 
>          if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>              !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>                  return -EINVAL;
> 
> Hence I think that atomic IO units, which are similarly defined by
> the bdev, should be checked at the iomap layer, too. e.g, by
> following up with:
> 
> 	if ((dio->iocb->ki_flags & IOCB_ATOMIC) &&
> 	    ((pos | length) & (bdev_atomic_unit_min(iomap->bdev) - 1) ||
> 	     !bdev_iter_is_atomic_aligned(iomap->bdev, dio->submit.iter))
> 		return -EINVAL;

Seems ok for at least enforcing alignment for the bdev. Again, 
filesystem extent alignment is my concern.

> 
> At this point, filesystems don't really need to know anything about
> atomic IO - if they've allocated a large contiguous extent (e.g. via
> fallocate()), then RWF_ATOMIC will just work for the cases where the
> block device supports it...
> 
> This then means that stuff like XFS extent size hints only need to
> check when the hint is set that it is aligned to the underlying
> device atomic IO constraints. Then when it sees the IOMAP_ATOMIC
> modifier, it can fail allocation if it can't get extent size hint
> aligned allocation.

I am not sure what you mean by allocation in this context. I assume that 
fallocate allocates the extents, but they remain unwritten. So if we 
then dd into that file to zero it or init it any other way, they become 
written and the extent size hint or bdev atomic write constraints would 
be just ignored then.

BTW, if you remember, we did propose an XFS fallocate extension for 
extent alignment in the initial RFC, but decided to drop it.

> 
> IOWs, I'm starting to think this doesn't need any change to the
> on-disk format for XFS - it can be driven entirely through two
> dynamic mechanisms:
> 
> 1. (IOMAP_WRITE | IOMAP_ATOMIC) requests from the direct IO layer
> which causes mapping/allocation to fail if it can't allocate (or
> map) atomic IO compatible extents for the IO.
> 
> 2. FALLOC_FL_ATOMIC preallocation flag modifier to tell fallocate()
> to force alignment of all preallocated extents to atomic IO
> constraints.

Would that be a sticky flag? What stops the extents mutating before the 
atomic write?

> 
> This doesn't require extent size hints at all. The filesystem can
> query the bdev at mount time, store the min/max atomic write sizes,
> and then use them for all requests that have _ATOMIC modifiers set
> on them.

A drawback is that the storage device may support atomic write unit max 
much bigger than the user requires and cause inefficient alignment, e.g. 
  bdev atomic write unit max = 1M, and we only ever want 8KB atomic 
writes. But you are mentioning extent size hints can be paid attention 
to, below.

> 
> With iomap doing the same "get the atomic constraints from the bdev"
> style lookups for per-IO file offset and size checking, I don't
> think we actually need extent size hints or an on-disk flag to force
> extent size hint alignment.
> 
> That doesn't mean extent size hints can't be used - it just means
> that extent size hints have to be constrained to being aligned to
> atomic IOs (e.g. extent size hint must be an integer multiple of the
> max atomic IO size). 

Yeah, well I think that we already agreed something like this.

> This then acts as a modifier for _ATOMIC
> context allocations, much like it is a modifier for normal
> allocations now.
> 
>> In iomap_dio_bio_iter(), ensure that for a non-dsync iocb that the mapping
>> is not dirty nor unmapped.
>>
>> A write should only produce a single bio, so error when it doesn't.
> 
> I comment on both these things below.
> 
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/iomap/direct-io.c  | 26 ++++++++++++++++++++++++--
>>   fs/iomap/trace.h      |  3 ++-
>>   include/linux/iomap.h |  1 +
>>   3 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index bcd3f8cf5ea4..6ef25e26f1a1 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -275,10 +275,11 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>>   static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   		struct iomap_dio *dio)
>>   {
>> +	bool atomic_write = iter->flags & IOMAP_ATOMIC_WRITE;
>>   	const struct iomap *iomap = &iter->iomap;
>>   	struct inode *inode = iter->inode;
>>   	unsigned int fs_block_size = i_blocksize(inode), pad;
>> -	loff_t length = iomap_length(iter);
>> +	const loff_t length = iomap_length(iter);
>>   	loff_t pos = iter->pos;
>>   	blk_opf_t bio_opf;
>>   	struct bio *bio;
>> @@ -292,6 +293,13 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>>   		return -EINVAL;
>>   
>> +	if (atomic_write && !iocb_is_dsync(dio->iocb)) {
>> +		if (iomap->flags & IOMAP_F_DIRTY)
>> +			return -EIO;
>> +		if (iomap->type != IOMAP_MAPPED)
>> +			return -EIO;
>> +	}
> 
> How do we get here without space having been allocated for the
> write?

I don't think that we can, but we are checking that the space is also 
written.

> 
> Perhaps what this is trying to do is make RWF_ATOMIC only be valid
> into written space? 

Yes, and we now detail this in the man pages.

> I mean, this will fail with preallocated space
> (IOMAP_UNWRITTEN) even though we still have exactly the RWF_ATOMIC
> all-or-nothing behaviour guaranteed after a crash because of journal
> recovery behaviour. i.e. if the unwritten conversion gets written to
> the journal, the data will be there. If it isn't written to the
> journal, then the space remains unwritten and there's no data across
> that entire range....
> 
> So I'm not really sure that either of these checks are valid or why
> they are actually needed....

I think that the idea is that the space is already written and the 
metadata for the space is persisted or going to be. Darrick guided me on 
this, so hopefully can comment more.

> 
>> +
>>   	if (iomap->type == IOMAP_UNWRITTEN) {
>>   		dio->flags |= IOMAP_DIO_UNWRITTEN;
>>   		need_zeroout = true;
>> @@ -381,6 +389,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   					  GFP_KERNEL);
>>   		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>>   		bio->bi_ioprio = dio->iocb->ki_ioprio;
>> +		if (atomic_write)
>> +			bio->bi_opf |= REQ_ATOMIC;
>> +
>>   		bio->bi_private = dio;
>>   		bio->bi_end_io = iomap_dio_bio_end_io;
>>   
>> @@ -397,6 +408,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   		}
>>   
>>   		n = bio->bi_iter.bi_size;
>> +		if (atomic_write && n != length) {
>> +			/* This bio should have covered the complete length */
>> +			ret = -EINVAL;
>> +			bio_put(bio);
>> +			goto out;
> 
> Why? The actual bio can be any length that meets the aligned
> criteria between min and max, yes?

The write also needs to be a power-of-2 in length. atomic write min and 
max will always be a power-of-2.

> So it's valid to split a
> RWF_ATOMIC write request up into multiple min unit sized bios, is it
> not?

It is not. In the RFC we sent in May there was a scheme to break up the 
atomic write into multiple userspace block-sized bios, but that is no 
longer supported.

Now an atomic write only produces a single bio. So userspace may do a 
16KB atomic write, for example, and we only ever issue that as a single 
16KB operation to the storage device.

> I mean, that's the whole point of the min/max unit setup, isn't
> it?

The point of min/max is to ensure that userspace executes an atomic 
write which is guaranteed to be only ever issued as a single write to 
the storage device. In addition, the length and position for that write 
conforms to the storage device atomic write constraints.

> That the max sized write only guarantees that it will tear at
> min unit boundaries, not within those min unit boundaries?

There is no tearing. As mentioned, the RFC in May did support some 
splitting but we decided to drop it.

> If
> I've understood this correctly, then why does this "single bio for
> large atomic write" constraint need to exist?

atomic write means that a write will never we torn.

> 
> 
>> +		}
>>   		if (dio->flags & IOMAP_DIO_WRITE) {
>>   			task_io_account_write(n);
>>   		} else {
>> @@ -554,6 +571,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   	struct blk_plug plug;
>>   	struct iomap_dio *dio;
>>   	loff_t ret = 0;
>> +	bool is_read = iov_iter_rw(iter) == READ;
>> +	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
> 
> This does not need to be done here, because....
> 
>>   
>>   	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
>>   
>> @@ -579,7 +598,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   	if (iocb->ki_flags & IOCB_NOWAIT)
>>   		iomi.flags |= IOMAP_NOWAIT;
>>   
>> -	if (iov_iter_rw(iter) == READ) {
>> +	if (is_read) {
>>   		/* reads can always complete inline */
>>   		dio->flags |= IOMAP_DIO_INLINE_COMP;
>>   
>> @@ -605,6 +624,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   		if (iocb->ki_flags & IOCB_DIO_CALLER_COMP)
>>   			dio->flags |= IOMAP_DIO_CALLER_COMP;
>>   
>> +		if (atomic_write)
>> +			iomi.flags |= IOMAP_ATOMIC_WRITE;
> 
> .... it is only checked once in the write path, so

ok

> 
> 		if (iocb->ki_flags & IOCB_ATOMIC)
> 			iomi.flags |= IOMAP_ATOMIC;
> 
>> +
>>   		if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
>>   			ret = -EAGAIN;
>>   			if (iomi.pos >= dio->i_size ||
>> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
>> index c16fd55f5595..f9932733c180 100644
>> --- a/fs/iomap/trace.h
>> +++ b/fs/iomap/trace.h
>> @@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>>   	{ IOMAP_REPORT,		"REPORT" }, \
>>   	{ IOMAP_FAULT,		"FAULT" }, \
>>   	{ IOMAP_DIRECT,		"DIRECT" }, \
>> -	{ IOMAP_NOWAIT,		"NOWAIT" }
>> +	{ IOMAP_NOWAIT,		"NOWAIT" }, \
>> +	{ IOMAP_ATOMIC_WRITE,	"ATOMIC" }
> 
> We already have an IOMAP_WRITE flag, so IOMAP_ATOMIC is the modifier
> for the write IO behaviour (like NOWAIT), not a replacement write
> flag.

The name IOMAP_ATOMIC_WRITE is the issue then. The iomap trace still 
just has "ATOMIC" as the trace modifier.

Thanks,
John

