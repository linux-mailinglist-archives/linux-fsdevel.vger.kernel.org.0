Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9896F67B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjEDIqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 04:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjEDIqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 04:46:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF37E7;
        Thu,  4 May 2023 01:46:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34444Dae008989;
        Thu, 4 May 2023 08:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZdT/AUW6+HQoNg/zMORSMt/a67bUvEhkG6bCDX4p/B8=;
 b=Qve+C1iHB8rCIYhPzvP70nEyQz9zz/ETX/6wkVFdpuObPCmq7HmJ3uG6dAVzD0eskW65
 TM/1TZA52Rne0n3mHCHGKCn6Ll7c0GLGCe3mi86yHCAiafCqvuM87Llyu7lDYHI5D538
 Cn79dpQW3ZyHod12HBIkLDwtdS04Hmf+VHl1SrsOs6mxAhG/tGgXHrB8iiAOzRTEaACD
 BZbmPG3MqNrL8uWc+Mr1klRy4NM3lNGlhlpjeu3/PHjqwt3iiBuvvzhDTMlEivL+ore5
 gdERifT/bgrXYhBTkzV2LcrSRbZd94gP5llJeSXcFFAXYnmvoJpI+LqWjYSbb8YcoDgY XQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9d1eps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 08:45:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34481OLC027573;
        Thu, 4 May 2023 08:45:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8speg393-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 08:45:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8ns+F/Qnk9yiS9i+UL+wyrGyJ2XG/0LR0X7H+Ryh2KMc9PDte12tUduXT1aFZA57O5uoabPvqlqhF8DgRxgm9o680NI5sWwkNLsJdpRb+aTiT6qsnGmgV/DG2u+Q+4H+jsNrf1DxiJRxSifxhzqTfov/fYI6N/i6ERtQ9acjT1+NZvGTSUESp7Fo74B/oH8xB6Ht1l2I6JADeqhHb0pVTW/fBnFCPTvU9NRbyXolCB4E2GCf28ZX4R1YDs6yRwMIYykCGbaoX+n3EjAdX6oNa2pz8to33yNwCi7odaxSzMjexqILjtYaO1cWZJ3uD9yMfDNJcoBwG+1yRu9aHcB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdT/AUW6+HQoNg/zMORSMt/a67bUvEhkG6bCDX4p/B8=;
 b=TXluduB0DwLUQVq12cDJ384i9hqQuh+nnSTDU46ZsLIVFBUV011igGsn9Khitq2KVMxkxZ2oM2sfGOYCNYd+OitrPSwphPJcl0ZPRDMeji1AXkVLfTctxSrK9etoxk1ZtTVty9upX+5ZJBhGgQaFBGDnj+GYUv2zxDmcXOQrXy9p7gL1Svyp3aZiAHAmzYf7lrkeaRPaec+ky5JOwZIFXpsRoSAyxPqXRT7oFBe5nAl8hdJn9za7KeHoad3pk7YjQEJUYLhmmBQTiWxSXHgWIYcJ9V2W2DftBE7mf2taMhxdRfx7+TE76XTewfrxG+elCgeMQLZEWm07UN2cbCPd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdT/AUW6+HQoNg/zMORSMt/a67bUvEhkG6bCDX4p/B8=;
 b=W0UHQieWdvHxIsV7bNmUy3hyYan8k3LzNRDJJeFSVqf2aoP1xNEuqBZavwCdkHvD1kB313KzXO1axCZMTjLdANjY/DGJx77ID21gUrb+C/txKIPQrTlma6D7jdLrW4T1sKu8vRDBUXsN2fY4OWJlDHFBiC5dMb16Io7kq+H0Xbo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 08:45:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 08:45:55 +0000
Message-ID: <96a2f875-7f99-cd36-e9c3-abbadeb9833b@oracle.com>
Date:   Thu, 4 May 2023 09:45:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 02/16] fs/bdev: Add atomic write support info to statx
To:     Dave Chinner <david@fromorbit.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-3-john.g.garry@oracle.com>
 <20230503215846.GE3223426@dread.disaster.area>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230503215846.GE3223426@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0501CA0064.eurprd05.prod.outlook.com
 (2603:10a6:200:68::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b85da7-2de1-4d9c-17c6-08db4c7bf93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK6z7L0XE5BTBfneNI5lWUFEfMZ24kk8h+QLPmynKQrWwdFQn6XgA+kVy/Z95iLnhAuo6CqlpR8LrrhqP1yuUxm3z936BVETrKjfthCqfzqTpq1gF+vs9cmTkrHfvrMz2R8U8R4hd17LB5v35Ic87L1IgnSgZOR6/V8JQnnEuo1y8w0AwrBFCpLkeCPxS2YhgnAkuiVSf9ArBtroUdcn8xZuAa4sPEYkIcybvNLEFtjg4C68t8kE3FQnCAXQSMkfYcrF9yfumV4s442slNR/TtY2Tc6QPSwkwFjjCeUsbd4TMPSI4w/eJn8H4ZQfDnH2tcBobK9+LOIzsEPuViDQfU87zxmjhxR9d5t2hHLbNGaMu7TPDNSMRIIXmS/pg6u3Ue4xiY/tkCHRhvQc/M+QXAvyF+F7+cTZqs57mTG0ajpOIt72/wcM6dZyWi5nTyR47+rMwasXIKIgHUastma1wp/+2vZCv+SeGUymK+/DmtciB3H6pItlRmH4Sp/0ExiJiu+GktpSlnqFGyZvtkqGHoXoolewRIxjS0TTve0JYWPmC7nLMP3a8OrmNK9JlLWuUzi+QdgoLFhrN3ixFElpmctiNTEpEMhDYzSXxRFgQLaOHDC9vQGtv/1IUxJKMNd0IsUgZzqTwgHsoG29X9BVQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(316002)(36916002)(41300700001)(2906002)(186003)(53546011)(6506007)(26005)(6916009)(31696002)(6666004)(2616005)(4326008)(6512007)(83380400001)(107886003)(6486002)(66476007)(86362001)(66946007)(66556008)(36756003)(31686004)(478600001)(7416002)(8676002)(8936002)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0NDR010d1hXbU1IdlpFZ3NURGRjUmJ4UmNIRFpVay9HRWk3OHkrSmtxWlZu?=
 =?utf-8?B?dWZwaXFmSjRoTGY1SmsxQW15WjVwL2JBQ2ZUZ28wMkdHVzRBUDZwMkFUUFdq?=
 =?utf-8?B?UHY2c0FnUlQzRW56NEhkREJROWNiWW04RnBJckh5Y3A3V0dYOFNYSFd2c2RZ?=
 =?utf-8?B?OFFJbGpnNWdMNzJEYTk1TS96aUxtOXJwVExGNmVCY293R1RxWDl4MnZ0UkZ3?=
 =?utf-8?B?eXgrUmlkZzRCNkRnTmthMEx0VWNXSk15dTNPZ0wxWkd1TkxNZjUwYU9yOGRP?=
 =?utf-8?B?Z2dPK3dvQ1lqVXc0U2VuNzdxbnRSdEoyK3RWZDZ5N09JQTFCd25DaXN4Ukwx?=
 =?utf-8?B?cGtERzFnWWt6NDY2ekU1N0pCWnhyWUZMbkhwQlJqRXMxcG41SUxKOTR6ZHVn?=
 =?utf-8?B?Z3c4UWhZeTNuVWlNZGtpemxHelBKbTRxbkdyYU5JVnlXZGNSTEFxWHlLWi81?=
 =?utf-8?B?d3ZkUWREdnUzZjBQRDE4VlhEUXpwdnM2TnRpTXJYdjdITVVOWDZhaXZVbVhZ?=
 =?utf-8?B?b1Q3N25JNElBL05mUDA2bm9BcnRIQ29keno3RWk3Y2J0NjdFSitiWkhwUXdJ?=
 =?utf-8?B?a0NKNHFQaWs3RkFtemFjQk5hWndEVjhuN2NXd3FDVkUxTEZSTlZiekZNeFkv?=
 =?utf-8?B?TG12YUZSSEhRMnovYVlMaG94ZDBybzUvWmFWakFDQXRLVkdnWjkzSDNYTktY?=
 =?utf-8?B?Zm5aUmlIS3pKZHdHUUZGdzFNSnV0NVh6OFBOY1cyeEx5R29URVQ1UWlvTkdm?=
 =?utf-8?B?eStlYUxLblJFWnBYZDY2TWtqa0xiTy9HUU54OWV5VHFZZHU4anJyR1htdTNY?=
 =?utf-8?B?K0NHQW5WMDJ6TWI4L29KWFJ2cHBOckhNYWh4MkpvS0J6aDRlSWNVR0Z0bndJ?=
 =?utf-8?B?Nys3ZXZSRHFBRnFwUzYvWkhXU0M1Ri90Nnd3bitXT0JHeTlCZzh2c0dYTEN4?=
 =?utf-8?B?bkhERWhZelZOOFdOK1hiMGV2eGVNSWQxY1NiZTd1K3QwTXBheFRiVDFWVlNE?=
 =?utf-8?B?dStQSTcySTQwbUFMVUc2OVUvWHlzUkRKV2doZ1VQc3hySEplTDEwTDliYkp3?=
 =?utf-8?B?L1h3dHo0WVVkQmJ5dENHYWdSTjNYU253Y01zVzJUNmVyZFZ4aWJKUmFXTzAr?=
 =?utf-8?B?aHJyN2JEcm1JR2tSdGhYeFZFejVmMlZhSGtRZ2ZId0tXOGs2SUZoWC9YZkdK?=
 =?utf-8?B?MEUwL1dSUHZld0pyNkErck9SNkFtL3J5QWdBODRTeUZsVG5kY1o1VGhXbkQx?=
 =?utf-8?B?Y0F5RWhCRURsWHlRczBCL3pMZ3U3azgyNVRkT3dhWGtDN2ZXSXR0TDFhZm9z?=
 =?utf-8?B?VCtJSW1kVWRKeGRWTXcyZ1JsWEJadmlIMG56UFNVM1Y0TC9MMjhtaW5rblg4?=
 =?utf-8?B?SnltbmljQm5jcFZIUnpuV1JwV295V3p6Y0xNRDlhNGFkaVk3YndHWXoxODls?=
 =?utf-8?B?d3lRdHAxbXJLVHZZTzU5SytGcFdjTzJRcE5qdjZuaDBXTjJZemtvZ3JEMGZ2?=
 =?utf-8?B?WkRSeS9OOFhTSU1RQjJLaWZac2RQSU1aTXdmMDNYRlB4akl1aldpVWcwNjkw?=
 =?utf-8?B?dDMyM0p0M2lDbEFTUnBkK0RQb2FEUzYxUFBndUpLK2FVeFIzZ2ZLazFNcE0z?=
 =?utf-8?B?RTJRQWVxaHVCckRiZTR2L0Y1UGxId0NqOExHaExIRW53WU94STYyb3doRE9y?=
 =?utf-8?B?R1FjZXFQREJCNXR4K20rVC9CMFNST3ZSVFpxZDhrZjlGR2FJNlJOOU9Rc3BV?=
 =?utf-8?B?Ny9rUXVqNWNIVXZ1ZVArZ0tRSmZkaG9GUDk1bkFsOW90cUEvYUdDUjRpaGRl?=
 =?utf-8?B?SitnelpDSjZBUmo1V2NZOEl2Rk0zVEVTb3Z1L24zV3BHa3cxQVdVYitsKzA0?=
 =?utf-8?B?bGx5RFBzTTRudEJ1V0ZKZGZzMFY3eDNlRG1ib1hjczdWMzQ2NENneWdYQjEz?=
 =?utf-8?B?TWprUUFFeGdpdUx2SFhOUVRyYzQ0OW9kdFpNRlZSeTQ5L0Z6cHhoQ2laQXFk?=
 =?utf-8?B?dkRzTjYzR3FXSVlEc292T2pkSU42UUl4Y25saWNJM1d4TVlLNjhIeTJFc1No?=
 =?utf-8?B?ZEo5SzFmUEUrWGFYbEkyM2VPc0FGbWVncFYxbFQwMGNpZTFqOTZRTEZqaUo1?=
 =?utf-8?B?WFplLzRrYnlUei9hNVljdmJMbWtjaCtSc3lva21ieGxKYlYrdmJTa0ZZNHhX?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L3FzdGJvSjVlSFFMOFQrQ2NkSy9haGlhWmNxOWM1d01qSndFYzFhYmZXMC94?=
 =?utf-8?B?Z08zcEc2QzZDV0NkczJyWFduZy9Qa2l6Vk1DQUNBTTVsdHVYVngwSjBYK0JY?=
 =?utf-8?B?NTAxUk9wbDk0VTFxWFEvY1haMHp0ckEzUjljd2ZCc2k2V2ZSb0tSbTJPS0Z5?=
 =?utf-8?B?dmxSL2pTUVN1SmdIc1dPOVJSdlh0ck9iMUkzVHZiQUF6RTRTVUJwUEI1SG1O?=
 =?utf-8?B?cCt1VkxKajNIc0p4VTZGRVYzYzdvTDNXV3JseGVUWG1rRWpuYXJHRnROdDNx?=
 =?utf-8?B?VWRNOTcyUzRsM0lJK3VQMzd5VE9DcW8vS0YvbHY5NXRLcEl0LytKYVdCQkh6?=
 =?utf-8?B?UXJ2NTJKV2RLZUhpVjB1QzZ5Y3VBSUJWR0xDSEtQL3ZhTGIwczRXSmF3azYr?=
 =?utf-8?B?Vm5wS1F6RWsxemErMHVzZ1J4UkovV2ZMenJlM0h4eHJRb1lNV2k5b0dTVXNk?=
 =?utf-8?B?NTFwb1VwWmQwZ0NDdEdlRzFEaktLU001TzNSWVozOTFjYUt5OWlPZnFLN3cz?=
 =?utf-8?B?dzI2UnJrZjFIV1RpbFFhWWpvRHlXOU1BYTRaR1VUdjN6Sm9XZ3hVM1V5Rzhv?=
 =?utf-8?B?NWk2eDF5cTh3UzJ2K0EwYW95NnBIVGR1cGxOQk9hUGt4bmt6dzV6S0hZSXc1?=
 =?utf-8?B?S2J6WmFJOGFhclhxQXZIVU9RenJKdlZvaU90VFZXZmk3YWgzUG4reWVyVkdk?=
 =?utf-8?B?a3EvRWRHQ2JsLzV6bk9qYStoNnhLNFl0bnExTXptUEN5ZDFOcURlYld2R0hW?=
 =?utf-8?B?MTk2aUZLNjBnVm5Zd2RNUzIvZXJwUVJQRFd0eHF6SmRRcENjSTNIbEV2WnZ1?=
 =?utf-8?B?ZU1TdmhOTmU5OTFQOCsxVXJaQ254dVdrYkQvVWhmR2VqQVg1S0t0LzIvZWdM?=
 =?utf-8?B?MmxIbzhzQnp2MDkzRTJ1ZXdOcXRyZVNuK2NFNFFJY0dkVUgyNzRSL3QrQ2E5?=
 =?utf-8?B?QzBVREdaZTlFbHJHUWpjakprblZ4UkdqK1Q5UGNjK2hRMTF3WUtzWEhSR3l4?=
 =?utf-8?B?U0NZSDAzRmF4STdTd0dML2tMNkZHci91cktZM3J4TmtKSk5TM3poVStFWlM2?=
 =?utf-8?B?K1E1SlJldlIwaC9CVlpiTCtCekJBaG1XeWF1ang5R3hxUHdsVGs3enZRbVVl?=
 =?utf-8?B?SWxPUFN1c1ZyT283WlJyamJXbnJNa2UrTDVHbiswbTJLdEhnVndPc0daMTBG?=
 =?utf-8?B?QlFLdm95OEhDc1JTbVNQNkNiZ1pCbFQ2YWtPa2tjS2YzMUFKeTBJOXNadDlm?=
 =?utf-8?B?akp6eUIzNXgzclVUeENKZDl0REZFVTkvVStXUXR2ajJqQzdoUC9MaVdxUlFJ?=
 =?utf-8?B?Wkl4T0xDT3FoL0s0YktBZW15R1BxTGtITSt1ZDV6Zk56OVZZejZSQXB5TlJY?=
 =?utf-8?B?V21YUDNBSUg1Rzk2VlY5ZkxlVUZZcnlXcTg2T1pNZllhOGRqUnBYdnRjWURY?=
 =?utf-8?B?UCt4ejFuRytadjVpVHE4QnBBWXpIdHAycDhNekdwYzRkRzB3SmJrUUpTVXpq?=
 =?utf-8?B?WWpEanliWW1NYzhrSUFzQnBGOFVpbnpBU3ZXSDVpYlI2dXlPZlR2SlVRTy9G?=
 =?utf-8?Q?u2XH8WjwIns9wI/5RBknTDxi0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b85da7-2de1-4d9c-17c6-08db4c7bf93a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 08:45:55.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5Y1DRkNR4xi3h+4ikWqdisKOqiJOGUgUoVUK3CF+N5+nmF/4N+DLhvmi40qngAs+9bN5g01aAj4/e4zI9V7ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_05,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040070
X-Proofpoint-GUID: w4og8oITTG7plGicmcboFBf8iFvKvH9V
X-Proofpoint-ORIG-GUID: w4og8oITTG7plGicmcboFBf8iFvKvH9V
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/05/2023 22:58, Dave Chinner wrote:

Hi Dave,

>> +	/* Handle STATX_WRITE_ATOMIC for block devices */
>> +	if (request_mask & STATX_WRITE_ATOMIC) {
>> +		struct inode *inode = d_backing_inode(path.dentry);
>> +
>> +		if (S_ISBLK(inode->i_mode))
>> +			bdev_statx_atomic(inode, stat);
>> +	}
> This duplicates STATX_DIOALIGN bdev handling.
> 
> Really, the bdev attribute handling should be completely factored
> out of vfs_statx() - blockdevs are not the common fastpath for stat
> operations. Somthing like:
> 
> 	/*
> 	 * If this is a block device inode, override the filesystem
> 	 * attributes with the block device specific parameters
> 	 * that need to be obtained from the bdev backing inode.
> 	 */
> 	if (S_ISBLK(d_backing_inode(path.dentry)->i_mode))
> 		bdev_statx(path.dentry, stat);
> 
> And then all the overrides can go in the one function that doesn't
> need to repeatedly check S_ISBLK()....

ok, that looks like a reasonable idea. We'll look to make that change.

> 
> 
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 6b6f2992338c..19d33b2897b2 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1527,6 +1527,7 @@ int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
>>   int sync_blockdev_nowait(struct block_device *bdev);
>>   void sync_bdevs(bool wait);
>>   void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
>> +void bdev_statx_atomic(struct inode *inode, struct kstat *stat);
>>   void printk_all_partitions(void);
>>   #else
>>   static inline void invalidate_bdev(struct block_device *bdev)
>> @@ -1546,6 +1547,9 @@ static inline void sync_bdevs(bool wait)
>>   static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
>>   {
>>   }
>> +static inline void bdev_statx_atomic(struct inode *inode, struct kstat *stat)
>> +{
>> +}
>>   static inline void printk_all_partitions(void)
>>   {
>>   }
> That also gets rid of the need for all these fine grained exports
> out of the bdev code for statx....

Sure

> 
>> diff --git a/include/linux/stat.h b/include/linux/stat.h
>> index 52150570d37a..dfa69ecfaacf 100644
>> --- a/include/linux/stat.h
>> +++ b/include/linux/stat.h
>> @@ -53,6 +53,8 @@ struct kstat {
>>   	u32		dio_mem_align;
>>   	u32		dio_offset_align;
>>   	u64		change_cookie;
>> +	u32		atomic_write_unit_max;
>> +	u32		atomic_write_unit_min;
>>   };
>>   
>>   /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
>> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
>> index 7cab2c65d3d7..c99d7cac2aa6 100644
>> --- a/include/uapi/linux/stat.h
>> +++ b/include/uapi/linux/stat.h
>> @@ -127,7 +127,10 @@ struct statx {
>>   	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>>   	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>>   	/* 0xa0 */
>> -	__u64	__spare3[12];	/* Spare space for future expansion */
>> +	__u32	stx_atomic_write_unit_max;
>> +	__u32	stx_atomic_write_unit_min;
>> +	/* 0xb0 */
>> +	__u64	__spare3[11];	/* Spare space for future expansion */
>>   	/* 0x100 */
>>   };
> No documentation on what units these are in.

It's in bytes, we're really just continuing the pattern of what we do 
for dio. I think that it would be reasonable to limit to u32.

> Is there a statx() man
> page update for this addition?

No, not yet. Is it normally expected to provide a proposed man page 
update in parallel? Or somewhat later, when the kernel API change has 
some appreciable level of agreement?

Thanks,
John

