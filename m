Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0D7B8223
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjJDOUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 10:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjJDOUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:20:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73ECAB;
        Wed,  4 Oct 2023 07:20:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948ipE4031373;
        Wed, 4 Oct 2023 14:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NFS4UXBW848Ozv5QNZEt4ExKJE2OACn5VYlQwWtIsCc=;
 b=KiCC9lYNuvXJ+yTECmBZ9Kbp8rp+Xkz9n14RURrWuXmcGzLWrpzHq5wsKZdmHv7Mr7xY
 Y+O4zNk+pkXWgiAhfYDUuQsnYYhLLd/RSjOrDQ3/QaCXAk6cspCebdqxlT16Y526arii
 6xZ+Ks0/c80sdw2B/Yc5PQiP5hweceD04ty8kOaJE/rqhlSvvE1iabPtPgsczBd8svhd
 IvEPspoU1lcUGF0EJ54Arteo6CcqmerJOxZd6tF+ON/JxopgLiYe+Qe6Pky2vLvaNAqv
 53ohslLLSlz9oLEWRHl7pk24F39hegcol8Z1rm745z/MTwd97WzPtkl6mbd/tACqIIm+ Rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf478kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 14:20:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394DFnPl008676;
        Wed, 4 Oct 2023 14:20:03 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea485sar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 14:20:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3eNBGkBnwU6uQEYUiI/mQPEVFU78NwDI4QwjRnvZpVxPLdsGhFjMwBlrUOKRb25SeB8Ly5BM4dx5UPV9hJDhbpAt3r2Fq72m/KibURj2HoNt+7O7qVWnMnfd6UjiCz+z+WYSkykkrKBlYZd3kBsKWDUEDYwqzmpbiP5XQ1uCeS2tkIW5KmLmT6yeVK96u/wFjJkn+ZouvrJOP65ixhacbbXB8G0RF4sH8rUZaM1CL7jyJ1nRN8iA6WSj6IOsx6qf4dTF4dhTLjHohKqaXFvNiU4ufYb51xs1Zskjm6zWo3ZWmWdUpK0+FCgR3I+SYxh8k/fMURxmrytFvpQlPd5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFS4UXBW848Ozv5QNZEt4ExKJE2OACn5VYlQwWtIsCc=;
 b=nkGk7ICAgGCTU7e5RifWV496GCt+A4b7p0fxeyyyynjgxLkcfKteSDuUwdspVwuuVfB2KufVMWLHwFkcdDDDF2KoWx5rf3/2tQkHreNNevs8ZWMmH6rPV3QsJ0l6p7dOb453LcAXU3RNdfVUQdDLL7vwSeIMjG8AEps91VWqbzaXseM5g2mrJn/No1XhhM7tnyQuYnW7m5XUTPAC4mwYYoksW23/luMzpEfRMkJNxqaNkJ6396BJEls6H19G0NIc6s9tjg0/RC8Qk0XRdkpuxi/5FusKpQki2dUZadRNdb5pc1ZNYn6gu8NTDFby6siVPIspQwxxWXn2/2vptZvVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFS4UXBW848Ozv5QNZEt4ExKJE2OACn5VYlQwWtIsCc=;
 b=Jgl3ekShJhmXQ8S+1KxzyW4J6oeIzKl3XxV+pZIqmme2B0FtgY9aT3qzEkuS6Sd5dndiqxogfryQY1hBX9YKXlYHxa7Ryz8ypQnoS65ghN11LN2OJnDiaQT9mQEvM9ujCgPTKWm7iSM7qkseudPpnRmfzEKIECpoTIdMIa1xNu4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5646.namprd10.prod.outlook.com (2603:10b6:a03:3d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Wed, 4 Oct
 2023 14:20:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 14:20:00 +0000
Message-ID: <e5664354-c07a-8313-5604-e7d1800ab1ef@oracle.com>
Date:   Wed, 4 Oct 2023 15:19:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Eric Biggers <ebiggers@kernel.org>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
 <20230929224922.GB11839@google.com>
 <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
 <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
 <ZRtztUQvaWV8FgXW@dread.disaster.area>
 <20231003025703.GD21298@frogsfrogsfrogs>
 <da12e81d-cf29-6dd3-b01e-2319aa9487d5@oracle.com>
 <20231003154643.GF21298@frogsfrogsfrogs>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231003154643.GF21298@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: a8746f10-c3f6-4b84-d331-08dbc4e4fe94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: caaoEKvO/f7fKYodfX7DPphIpZ5+WPJYoh/1dlEkizo5kvnBZriNWnqp15JOMWjotOwcDooVT2v273SCQcjrg+x1kTwk3rchhcEva5mhM/+sSVhJ5UeIFEq1KyHhW7MTjbHAjNZZWPT3bUO85d+mouHTE5LdShV4IpwH2IKxdsadY7/s7MIOOXnXbTKaF3K/xc8Cm/uZUYv+Nnr4brw0QzLvdw5wteTv4NTHegIacVkXN3lZEo2MwvzvzHsSNBRBJshuafMUvNDPwyz6A8B80rw1JE3Nl61VW0rruoRZWoSwCgMpRuciAN1n9hUGSG9pPFoBu+uw81tkAQ/tSxwOaBblV30p5XfdYZDDsHs1/6m69HvkYOVi5Svir6LFbG7SRap2XrufJ20JM4yfx++0ROEiA8xW5HTpLFfE7Fc7brAm4e6FfM/z7WZuFqF9JRjGGK6C3b9Pmrq+CFHomY9hxKm+qmxgZY9/2qt1a/TWFoA5oJ8ZEETCGT+ed9MTtucoF5n5bGWxvSxYefMcayfvnMaAze/eHqonZs7tcJZcrle105aaesVD332iXV+NXhSuAcVzKUYnRGtQxOjCQ4PCGv6KnDsZ2bjz4WVB8qGRRSGFCZkalWGPZ6CO7Y3toAGK5G1KbiTpUj3UGBLNwqI63Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(31696002)(107886003)(53546011)(6666004)(66556008)(38100700002)(86362001)(6512007)(66946007)(83380400001)(54906003)(6916009)(6486002)(26005)(6506007)(4326008)(8676002)(316002)(66476007)(5660300002)(7416002)(41300700001)(8936002)(36756003)(478600001)(36916002)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGFzVTE2Uk1JS3U3UG9TWVBHcy9mTlcvSEt0cDczNjhMSnUzWmRmdktUaUxP?=
 =?utf-8?B?TE1XTFdyN05zcDA5OFZGblJtM2RsT2xBS0s3NFovY2wxSllMVnVUVjErY2M0?=
 =?utf-8?B?ZUJiL3pocUdibTRGUVNKdCtaSXdNanBrKzh4YTF5b2ZrMDBCWmNSOFZQMlE2?=
 =?utf-8?B?cnV0VFdXZUtiZXkxYlcvZEU1M1VkWFNXclBWQkhObDJSRDZxUDVLaWVyQWRP?=
 =?utf-8?B?aUVpTXJ6MnpPckoyM1AxUGlzank3cDYyQmQxczFwbTdQU1Y3SzhiN0lWd3lq?=
 =?utf-8?B?TitITWROWUt0MkNuLy9NU3llR3ZFRGJCLzMzSE8zSDRPaktyN1VtdXRqMFNY?=
 =?utf-8?B?VnNDVHNzZmNTcXBnMm5rVkhhTU1ldm1Sc29UdTAwaEFqQU00VFlpSFVqZ2hN?=
 =?utf-8?B?MmJzd2ZPN1dpem0yQXdsL2l4ZGM2N2xIQXE0UjdUSlRGbkhpUUd3U1B0bGJU?=
 =?utf-8?B?NWlQenNUa0drR0NObHlBRVROVG50emZyTThyYm5xbXRKZ2Qwa2Z4cHJUTkVl?=
 =?utf-8?B?dE0zVTZmY0NSOWJMZlAzU3c4ZW42ZG94K24xSzFxNXZUVkRzRE82RHVDZCs4?=
 =?utf-8?B?R1JpSEtxRDFrNWpyQWhhamRQTkVWS2xOcnJRSXdKL0wzdXF5eDIrdEdwdW96?=
 =?utf-8?B?N3VhN29tNmFEbElRczJtQ1Z3dUZ3L1gxUjdRUzRJZEpBSklDcEJQbUVoWXg2?=
 =?utf-8?B?aFNvS2poaGdpdTM3VkJOM09ZTTVxOFBmaGI0TXZ1bEU1bUc3VGZHNjRYQThl?=
 =?utf-8?B?dVd6V1V4azNvNENHaGs5N3NaSlNkZjJlbmZRRnFwRHhIQ3Jzb0JMOGVYdmNs?=
 =?utf-8?B?S0toZHMyaWxiRTAzSjZCNElxYjJLRXBoNnJ2bUh6OEREb3IzVm9YMTdWZUJj?=
 =?utf-8?B?bUU1Y0c2b0RmQlJhbFFqQ2RLSkZacjlWcVFQaEFDWTB0UzJYRm5nR1NqcmI2?=
 =?utf-8?B?SUtTai9YbUJSQzNTMjZMZDBFdW1odGdWNXhKa3lWVVJXaTFaYTJtU0pEMXI5?=
 =?utf-8?B?ditzRVpPRXlVeUhmVzh2Y0VFbVpnbUhIaXpZWkxQTjdUUTA4Q2Z3SEVQV2dI?=
 =?utf-8?B?aGVRcmxBVkw2UXNRM1pQbUNwbHBzUEZJakl6Mng4THh0WWRqUGkzS3RtV09s?=
 =?utf-8?B?eHo0Qk1hOER0REdDakNkb0hDK2pOSnE2VE5jZnpWMFZvUE9wbW9Xb0JiUXlr?=
 =?utf-8?B?Y1BHMFdQVHNtYTZXc0FVcnJQTXBkSEoxVkVVSUtjbnZ0TVAzbjVwcC8zbEY1?=
 =?utf-8?B?RTdMd1ZpYkxkMjU5eWkyd2szUU5FaEZWUklNb1cxdE1VSG9lRVdRbG0rTWRh?=
 =?utf-8?B?bzJSdFNRZytZTVF5QmtLOWVMMFVkUFlZRFVUUUdCVVZjOHlVTzMzbFZaemo5?=
 =?utf-8?B?Zko5bjE4R0RnakduMnJNWUpYcUVoWHlSY3MxT0Y2NUJDZkJyb1djL2xFVXR5?=
 =?utf-8?B?OGNzQXZHWHJmVVAxZFgxWHlRZEY4UWt3R00vdU5OMGtWemN0dkNsaFQ3bDF1?=
 =?utf-8?B?cUMvUDFzQnZpQ1JmeEZ4WmpDNjRUdlRqVTdXRzA3eDBSYWJ5eFFuSE96MmlG?=
 =?utf-8?B?TkJrS0o0cHRLMC9MYTJUWU1yaHEzMUxIOE9LZW5oT3RjR2NJeHJIVUZlR3Qr?=
 =?utf-8?B?N2hWZndDSXpmSDEwc2pBd3dNeVVBUmV0NHdpMGVxV1lFdWVQRGJFRVFHbGdw?=
 =?utf-8?B?ZXd2TDVlZE9FVGNhWEwreXNlSHBjeDFPZEg4MkwzMFhhMW10YVpOOWdES3d2?=
 =?utf-8?B?ekt6V043MlltVnBQSWhjZ09jRTc5UzJOdWlTQ3ZtWVJvbTV1Qm9JeThQUkJj?=
 =?utf-8?B?R3puTmdINmlHRjFzcnhrQ0tWTlZiZmQyck5icC9qdHRXRWN3K1l0ZVBhN2k3?=
 =?utf-8?B?ZWJPVlZXUkxvR0VLZzJ4N3paZ1VNeXVxZ280V3NGbmg3VE43NktmSWQ1NFpL?=
 =?utf-8?B?VHZtTy9JUzZXak1hbjFKekt2STZBTG1LRk85N1YvNDIwTnhjM2pwdHNMTlVW?=
 =?utf-8?B?SVBRUTF1cEw5MEk4UFplejM1ZVQzbUxvWmdFejU0RjZLbno0VXVOOFp5VnVQ?=
 =?utf-8?B?STkvelhvYVBXWlpuc1JlaEYxa0EvSlVxeUJnTjZPSENxZUsxVVA3TXdJVE1r?=
 =?utf-8?Q?xkR6xtZmtaqZtrvTA1mBDwSL8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q3M5YVVHQmo4RU5tanNlMHIxNDRtTDBZU0twOVl0YVR4clc1WS9NSHltYm9W?=
 =?utf-8?B?OEpsdVlmWXhWdFRqczM3YTNBTTlZTkFMMnNBZ25mQVpuKzJoTFJ1TGozcGQ5?=
 =?utf-8?B?ZkZNLzhMRnpDY3FhZmRMTXpYalkyVk1QQVR5WDVoL0I4SmpXenlJSUQxRVdt?=
 =?utf-8?B?c2hVaTlrbU1HNVMvNlB4eHdiNHpVTHM4YVBQL09JQm9TT2ptcDdWeDVqSmR5?=
 =?utf-8?B?WmxkdDJIMUNYSTQ1WlZpeWg3M3dXQ3BnRnYxMTQxdUVBbDhlRkVUTkp3NThy?=
 =?utf-8?B?dUpHQlhlSmtqbyszSzZ3dEFWa3VQZnArZlRIK2JadzM2eGxsWGZJdWR3NHZW?=
 =?utf-8?B?QWZ5M2E2a3ZWMTlPQysxcUR6N0x5TWNvVGhOZFQvVnlvdFRPdXc4TVh2NXRh?=
 =?utf-8?B?VFlJcm13bmxNNWlJa1VZR2dYcWpnOVJKS08xS01IZURZVVRmaFdaQmZjVmFm?=
 =?utf-8?B?bWxaVG9UUnpqQXMxcWJ1akFERHBOU3J0aWNBZWs1WU9JVmp1c04xM3FUMTYv?=
 =?utf-8?B?ZlRtWm4rZVV2ODcwcUcwRXJzNlV1djNBbm12YThXYVduaDJuemkyOVlteEY3?=
 =?utf-8?B?VDdvbGZrUUpCdW56Tmp5WEw5YUZ0Qm94SnRpV3F4bjNJeXNsOVVYc2MybmJp?=
 =?utf-8?B?YU5GNnhUMjBWWmkvNDFiR1JqT0Z1YnBSbFh1S0o2SFB4OHVXSTkyQ1haWUZs?=
 =?utf-8?B?RzhpOVpSTEQ2NEVGbFlMTDhuSDNubUYxcS83VGpGSUViZTBvQ3RMbTN4MmxI?=
 =?utf-8?B?aHpsamNDTFY4ZmdmTU96YzhlUXBObEFaZjFTdW5xSHd1RkVPdk1BdFRjYTh1?=
 =?utf-8?B?aVdNQmZUNlg3TWY1SFdwb1JlUmgyeTQrYWJNaThOd29BUUZHa3VuSWR4TlJP?=
 =?utf-8?B?amp1anVNT1RsZnRTWkF3S3IwK0prbmRDOEtycnI4Q0UvVk9scFlxSU1hUHVv?=
 =?utf-8?B?cHVldUl4NjNxdXQ0U05VMndoenp1d3NMb09pam1kcFVCVW1ML3BaaEM1bk9q?=
 =?utf-8?B?VGErLzMrZzNVMjAwRDZIdzFhNktacTV6Y0h6TmdRSEVISjN3dWJYbUFpajZB?=
 =?utf-8?B?RHNodmowSXMvYis0OEM1Y1kxYktDOXZjNG9IRGxOdHYrSEhPWlFEWEEvMG9Q?=
 =?utf-8?B?TERsSDV4V0k2MzE2U3JYaUZwSkppZDI1aVJXSzhta1hUS2pEbTVENitYdTFK?=
 =?utf-8?B?RmhZTzdOdmhlM2M3WGkyZXpjZ28zcnEvYmFpVElVQmFKVHpxYUNJS3RCWVVK?=
 =?utf-8?B?L2xJcjlqVWtsZC9QOVNsK3JTUExNVE9kNEJIVk82UUJmb3BwRHlUWW9CdTB3?=
 =?utf-8?B?RWtuckRVd1NnQ2owZVJ6L1NHQjdzSHZrVDFNZ2dnZUxqL1QyVzJ6dUpPTmNa?=
 =?utf-8?B?am5aeU1QQWpQR3QycGVaTUhNRFZJaEhaYmxrM0M2UGpxN242L0gzTzlHK1JT?=
 =?utf-8?B?TnFGZlBSdVgyYWNYQm83YjkyeHJBY044MXB5ZVlYKys3cTdHZ3BjU1FOb1VB?=
 =?utf-8?B?VHluM0N5Zk93TjJJTTYvRXRZSG9CdkJ0OHJZYXFQZXZ3eHFIdlJibXhZeWla?=
 =?utf-8?B?YWdydz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8746f10-c3f6-4b84-d331-08dbc4e4fe94
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:20:00.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0hozBqS5+YBPlUHvfU+tjXkzhX2R555aidJxsrYZLKqBAM1ZlgzS4RHoY4mKLY0XqdXvUqTrd+10unm2EZtyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5646
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_06,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040104
X-Proofpoint-GUID: DAB_0ak_jFWZ-gCwe_0J4cS93ypPVdMF
X-Proofpoint-ORIG-GUID: DAB_0ak_jFWZ-gCwe_0J4cS93ypPVdMF
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/10/2023 16:46, Darrick J. Wong wrote:
>>      stat->result_mask |= STATX_WRITE_ATOMIC;
> The result_mask (which becomes the statx stx_mask) needs to have
> STATX_WRITE_ATOMIC set any time a filesystem responds to
> STATX_WRITE_ATOMIC being set in the request_mask, even if the response
> is "not supported".
> 
> The attributes_mask also needs to have STATX_ATTR_WRITE_ATOMIC set if
> the filesystem+file can support the flag, even if it's not currently set
> for that file.  This should get turned into a generic vfs helper for the
> next fs that wants to support atomic write units:
> 
> static void generic_fill_statx_atomic_writes(struct kstat *stat,
> 		struct block_device *bdev)
> {
> 	u64 min_bytes;
> 
> 	/* Confirm that the fs driver knows about this statx request */
> 	stat->result_mask |= STATX_WRITE_ATOMIC;
> 
> 	/* Confirm that the file attribute is known to the fs. */
> 	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
> 
> 	/* Fill out the rest of the atomic write fields if supported */
> 	min_bytes = queue_atomic_write_unit_min_bytes(bdev->bd_queue);
> 	if (min_bytes == 0)
> 		return;
> 
> 	stat->atomic_write_unit_min = min_bytes;
> 	stat->atomic_write_unit_max =
> 			queue_atomic_write_unit_max_bytes(bdev->bd_queue);
> 
> 	/* Atomic writes actually supported on this file. */
> 	stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
> }
> 
> and then:
> 
> 	if (request_mask & STATX_WRITE_ATOMIC)
> 		generic_fill_statx_atomic_writes(stat, bdev);
> 
> 

That looks sensible, but, if used by an FS, we would still need a method 
to include extra FS restrictions, like extent alignment as in 15/21.

Thanks,
John
