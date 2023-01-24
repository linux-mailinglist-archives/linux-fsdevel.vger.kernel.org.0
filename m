Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC127679D2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 16:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjAXPQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 10:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjAXPQc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:16:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51D274B3;
        Tue, 24 Jan 2023 07:16:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OEnO18012200;
        Tue, 24 Jan 2023 15:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8pfWXkJ9nqvzOPmL8pvfaiMq2JmKKtlx4ftXNFnWOXg=;
 b=YBBuNxm0cY+FZA7kfJeXi1ymmzGo/+KQ/jZQcWMBcrVXYGUOUpdn1Q/Pa0AbwYRiLMc/
 yraoY3O3ROMxf+IStbqEMNbXIzexUXPTeSuHzmsax5aRo9QSqfXHWJe5tZ2deDg4SbF6
 FNA+iRcPicHuscpMbQKJX2CDerWp5KDw3fcCVjzWd5Y9++S0dogT7Hl31i8DYvAoo78H
 UkaPas/ed0y7xePrdoqKBpBakai0MkoUiPOa6RvSiWlZ0Lnhs2rz9KOfKAi5aHUkfmdD
 K5d89pbKbIeD1yG06pLElcfor2me7yViHAAQf+xw5wbvU5dTNhidoYQ4Pr5y5wUSC/UZ dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ktweq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 15:16:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OE6Ffl021075;
        Tue, 24 Jan 2023 15:16:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gbv6e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 15:16:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfPiZGu9pCJGD+6JxeyGfE1zANps/dWPeiq8LRBSFbT0/OfSeJOAZawmInqbSVYiD1QmJrbujGBiYpoRn8wgfWHkg18Usc/pBBMUJqX7551WLLO4wXMyzJqDZ3swCKgTl8vrmJmBuTsuf7NsgmZCYAqw9SK5ZmnXlAeV1GraCZ+Dvxj9hD7KZOzaWgj7cM4Kix0TGnm67rPli/H+kPFN/p/o1Jef4F2zmJjmZ9+YRtmPt/LXaOngvl7uyx3rXa/nlpSyi+oczQUs9BkxpquatrfcrPEMMrqOHpRPXUJgdMwnnTu+fJ4Lg0e6M86uSVJ/IkBr5AySdhhAOVjjNR7wig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pfWXkJ9nqvzOPmL8pvfaiMq2JmKKtlx4ftXNFnWOXg=;
 b=bDHa1kP7A04PTWipVj4gC/NBedDz2PNKBT5vCKZZGPifSrRfurzIgobw0K7MCcl9V0pimWsBpKckTv43Vg6IkCKvqgYlea/JuFJmztpaMZFSApUkejxUnmNitexcYnSVVn9dWQWl/gn3H+fLO5GSKozjfAQo3d+F7gpBJZyLshJal2Kg9SdOQsZ7Vm1+axNYJqeYR5d2J1saksujjzly79GyzW++0aHnQVvsdHonrpfD7iMOhIOGx28oUwnoARRm8adY8/PHik824fVOSnubXveKLsIAi+Pf5s1GGllFzIgEcj3iOQ7rU+LELxckE/sk18F+Z3B/fLZCUxbHbDNgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pfWXkJ9nqvzOPmL8pvfaiMq2JmKKtlx4ftXNFnWOXg=;
 b=U1h124i+BF/TI3nlXShUL/YopoPvvTxX2XFZjPfSxBf9Mkp6JrOghOUO6G1xpLTQpk+f78tG9U6RfRqo5u1EbMSB2rkJRTm8BAjXflO2y7xLz1cn5FmHYUMuNF2wz4capNdy4Ws4gbr40RQxYOAYCMPhI5syKWMFKBktvyUzCzw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB6785.namprd10.prod.outlook.com (2603:10b6:610:141::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Tue, 24 Jan
 2023 15:16:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6043.009; Tue, 24 Jan 2023
 15:16:16 +0000
Message-ID: <de947279-533c-db5d-aaf6-cb85ca45d871@oracle.com>
Date:   Tue, 24 Jan 2023 23:16:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 05/34] btrfs: simplify btrfs_lookup_bio_sums
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-6-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230121065031.1139353-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb8f290-105d-43d5-01f9-08dafe1df011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPK0jda3X5zqkeFfc8tsvpuL/4ZfDsh92Wfjbaeud+sPMkkFX5TPZJzXGzihYQZygLs1TfFZw+zRI6uJXg9LBklkewuZQEhXZNbRBr3pmVMNyZgFUO5t2aiJaDToHtR2LfD0LPsd+mPso0WblUZl7olcSTUkkLpMWPu7o2zGc1G3Jh5oSkvYRXw2cin/UC5TZJC9/pWVcxFnsqs7JwbyVAYU5jKiSvu2AuD7GyG3dukNP90trYJ/pHqSyu2T0oBmgA2IllACIrRyLnHOYr2yuoXfV7qbF8/VViqxMmPw4KTnZFofSMacIPhbZ6MH+BeIgpqHDyppm6iz2qq0KlJi7vl4WE8a7guONT8GesN3DuK/P4VfaMl4+roX+R0Nz2jzJVdOtxsUKlvZQX7HZl2b2Q7WhWi8suDLTJcdGCf47Mtq1lYWjGCPH/s5JNSFJS40jpCdTC5s9nYnM6hbg0UZ2d1TgieQQqE9QO55v0fO42dIwLHbcWowt72/SAvvtzafkC1tYcgJgvkC0H3rKVgtoVyAx8gFJppoSEUwPyGUCc7VHWktmA4psWD27JBi507CQTocXJWkuLgz9WMj1htRNmHRE2FJyY0060uWNgzybKRNiSOsqFzqHc93+LvofEsEd995uZPO/ZtLEkmo4SGN5LsTuOKPnf5RDdir558NTqVbLJjIK2M6gxZNr1UgU8o58rXYeHQo0yKuxmqg8THmld3k19pP5nMpbXLw1wpHMrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199015)(2906002)(44832011)(19618925003)(7416002)(5660300002)(8936002)(86362001)(66476007)(4326008)(36756003)(66556008)(66946007)(8676002)(110136005)(54906003)(316002)(558084003)(41300700001)(31696002)(2616005)(4270600006)(186003)(31686004)(26005)(6512007)(6666004)(6506007)(38100700002)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWxFTGxNYVBKKy9tcXJ6dDBPSHRldGptTUZSZFo1UWtVUVA1emZrN1pVTzFO?=
 =?utf-8?B?UmorTm1OcE8vYzA5QW5ZVGE1M2dlWjFGNHY0QXdSNmowcHdlUTVVaGRFRzNh?=
 =?utf-8?B?YTV4R2kxWllxdFI2UVFKMDVaVXRaT0IySlFoYS9YdEFYNWg1dGdoQ2tnT3pD?=
 =?utf-8?B?K2lqY0FVNmlpREtOL2ZQQVhkS0ZNbVVKdXpFUlVFU0M2R3VDSjN2bVZNeEFB?=
 =?utf-8?B?c01Yby96VHg4Y2tQNlZ4dXM5T2tzVVRzRXUyMytVbFlFQW9TbGEzTFF1R3gy?=
 =?utf-8?B?VjBBVDVROWdyejl5MGc1YjVaSTExMGdNbzZ3VmUrVlZQZVNwaUEySFpKYW92?=
 =?utf-8?B?anE2VmczMTQ2MEMyNndtN0xUZkZQQm9KenN0SmV4VTh5T2YvZHhWeUxCRU53?=
 =?utf-8?B?aHNhblRpNEZPN0U2OEdLUUFDTGF5bmpQNFJWaDNvNEdoU05KdXl5bHhIMm4y?=
 =?utf-8?B?OXE0QzZGSVcvTFA3OFNHbUlSZWNuUXAvTko2aXNGdm9wNzUwdGkrT3lsdXND?=
 =?utf-8?B?S0p4UnhiR05KU2dhZCs3KzJnZi9TSzJFcHNhZ1dYek1RcEtnUlpwa1IrejNp?=
 =?utf-8?B?ZDNtV25XQkRJRkt2V3k3VGFkSUR6R1JpekxiZjZOYzkvVWxtTGhOeGFTUWNi?=
 =?utf-8?B?RlJ3cFh1N2dmRVhkOU5Nbit3OW91Q3lpU2xGQm9sTHF6Q1JScFh4N05XNUhH?=
 =?utf-8?B?TmxacFV4RHd4ajBnc2RScEpyRWFLRlpra1grcFFXbjJxUlhFcXFMRmEzWkJD?=
 =?utf-8?B?NFI2SFpqT1Byc1ZESWhGNnV4NUlHNFNwRHBCLzVydWpHUFZGbXpwL2I4ajZL?=
 =?utf-8?B?WFRnejltYVNpQmRZYXBzOUNkWHpSR1hsOTNSUmlMWUtZYUk0NmhQdnRtTXpy?=
 =?utf-8?B?NnFvOG1OQmFMNUxNYkVEa0JtRE9LVlp4UTNuUGlKQXZTMTBpaEt2Y1lqOE54?=
 =?utf-8?B?bzkvSCtEeEZUTDhBaHRyam0rVUVOeWc1ZTJMQXRZRkJsL0FsQzJmWWpBT2FE?=
 =?utf-8?B?WmhZTitTVGRSamNhekJuSUozdDgvVlk2SUdlMDM3MGQyeS9peGRHd0VQVjhI?=
 =?utf-8?B?aHZPbXhhMzdJSnV2SFlIK2NyM28weUw1Z0FCczc1WlVWcWloVGlWdkxld2lM?=
 =?utf-8?B?K3VKeTVGRVRwQWV0d3V1dmpMM1BKdEpvWUpqeWg4a0xOTkR1Y2xLSzlsb1lU?=
 =?utf-8?B?amppOVFUM3p0UjI4ZWhDNFN1dnAwTmlFaEV5ek5QZHRVN0lQcmJNdjFWT1dS?=
 =?utf-8?B?VmduRGxxQ2RsU3pDN1lqVjZobmcrWDVVUnM2SVpQdmVIdG5KclFsYU9SK25o?=
 =?utf-8?B?U001QzNUcXNaSHFTWDZYK1diUUNrTFZRc2hJZ2RGcWhTR2ZFNWlONlFiQWgx?=
 =?utf-8?B?cmNjMmZrSzVlVjFSUDh3TFVyRE4vcVV2Q05IU3J3UzFKdFE3OS9iL3dwN1FM?=
 =?utf-8?B?L3pGSGZIdUY0R1M2elZYdWVuTXE1YUZZcFoxa1d0MnBPejUwSVExOTMwQVB2?=
 =?utf-8?B?S2N3VUt0VElEUXltcEhtRkFHdWlHQ0hoMExKTFptanZSNVhnREoycCt6di9q?=
 =?utf-8?B?NXVSRDZmWk53aEVIQXhmbmh5cjdhUEUvSVNJMGljRmVuQlExMWlaUnhrMHdO?=
 =?utf-8?B?THUwMHpWZjJFUUF5TVY3bXpTbzNBRS9nR2htaXNGaUgrVHZ3UEFLK2NXZlFy?=
 =?utf-8?B?RDE3T1FFd1ExQXpwUzJBTHB0WmxJbklsN1laVGZZSlNPRnZBOE91LytNWnhB?=
 =?utf-8?B?MFNXN212RG81OTEzckNhNXgvbm0xRnRyUDk4NmZXb0g4dXNpc0IzL2lKTHJa?=
 =?utf-8?B?R1ErSkhnbklVcUVLZkpNbHZSQ21SQW8yN3RESDR4RFhxRFZoVlN0eHZxRmpv?=
 =?utf-8?B?MGNsZmlQOHJGTitSanF3N3U3SUlwT2hDRUNyeXVQeTNCMFdYdi9EV0ZZSy84?=
 =?utf-8?B?NXQ0RjZ3UlY4MjRwRlJFTFJtNkEwYTBGMTlmTGdYaGF5ZCtWTjZuY0RpVW9R?=
 =?utf-8?B?VWI2UVpNeExWV3UremF6V1pUS3p0aXRUSHh3UUk1SURHVFU5Tll0WnBTbklD?=
 =?utf-8?B?bGo1Z0N4S0VuSW9TZTdHWlp2YzNIQk9MWnVMUWdzMWsxdTFSUitRUVMzUms2?=
 =?utf-8?B?SUxZOUJmSEdpUEZ6ZkxTYnVra1hONVZKVDRlSWtQN3dqRXJkQ2tLeDlNYTJ5?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZGRoSEREdUY3bEt2OThLdHlOMmRaYThPS01CUGxpRGwyaGMwV0JzNDZwR3Jq?=
 =?utf-8?B?aFNQU0x2OHdCLzJ3a0ZFeW1sa2M2TWNBaVJmUTBoRmV0RlBXaXZkNXduK1l1?=
 =?utf-8?B?Rmg3bmdYOVJWNjc3c3Avam1ualgyZGRxS3VvZGVRamNNd1hjOGY3OVgrU2lS?=
 =?utf-8?B?VE5VY2FJRUc5czJqcW53MUE4MGpaQXZKanQrbXBZbXRaY2VjU0ExdW5PNUIv?=
 =?utf-8?B?L2JpWTBXNDhLclhwcFBpWE5GckdSTW9VU0dZWndTS2N2VmVKdkNyRUtDWXNp?=
 =?utf-8?B?T2ZKRlIrZ2FlQmxyQmtXYXUvMkVmdDFFaGlHZDg5eEhkL1NvZzQ5YkRzT283?=
 =?utf-8?B?SGJ1Qm5zN0EyTWc2eUJ3NVUzYUFyZFBlYmFNZmZnck8zQ3hJa09JMkpkM3Zl?=
 =?utf-8?B?RHdOYklDSXp3aVVEZ0QrVXN4YjB1Z1FncUJNaFg1RkVLbU1GOFpnUW5iYlpl?=
 =?utf-8?B?RW1JNWdxc3haMXY1T2MwR3VHd3FVTHRHeXFaUGxCbHdyaUowRFJBMzh0U2hX?=
 =?utf-8?B?ZzcxS0NEb0JRV2ZKMTRIU1VvVjk3Q0dTMHdYakg3aExsaldDU2FYcXNjcHZF?=
 =?utf-8?B?U0dmYmc1djVMczRGUE8rZGhoRGQ3TU52bHVhNWkxcDBLbkdDVEplYUVISlEw?=
 =?utf-8?B?cWdFY29zQ3dycFd5NE9LZmdsZHZHZWJhbzhleklCOHdITVU4TDdkK05nS2p5?=
 =?utf-8?B?ZEQ0N0NUSTB0R2hjaTEyNGVQSlBMTXNPYTRzajRHbXlvUGdleSszRVN1dm1h?=
 =?utf-8?B?cFByV2crbHUzTUwyaEc0Z2VMdWg3TlRUMmljejhKcTNINmRJWVAvMnZHZHk4?=
 =?utf-8?B?aEkrcTVZUGpjbytZQjBjK3hPcWdKWTc0ZlhadVJScXh5c1dhZkw2eEpmY2ZY?=
 =?utf-8?B?ZnVIWE8vOStma0V0Z2cyTXh2dUZUSUNhdHVPVHJORS92aENHdFFxSmUzOTRo?=
 =?utf-8?B?QkFycDc5ZldjcXkxaEJ0NUtTdDduUDhHWiszZVhJd0t6MzkzdkhjUGk2ejlz?=
 =?utf-8?B?OGVSV3dPTlBTR1JtYzFGcCs5M1pVUkhxZ3lWQmNnQW1Jb2VZZmJhbUlMTXVM?=
 =?utf-8?B?cEwyVEpkRWNyS2d1Qk5iaDU2UWhzbVd2Wm5HcHpNbWtZVXlCV3ZTTDgrSUx1?=
 =?utf-8?B?WXl1Wk1QZGZjV21aSHNiaUZJNWtRSStZRTVDSHQzeUFlbWVsZzRiTmIxZjVQ?=
 =?utf-8?B?cEQyaG8yVk8yWjd4KzJFK1lqWXZZbDFQU045UytFVHEySUhIdmw4ZVNHZ05U?=
 =?utf-8?Q?AhmEzwstvVgrMnd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb8f290-105d-43d5-01f9-08dafe1df011
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:16:16.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0iaYwab19pswbIlLWzZnMQbgcGdsvIJ6ngcbtSyZTswqXaY02uDzXAC/5h+r8V7yDKmUg+cvybB5Q7nSxD0cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240138
X-Proofpoint-GUID: jyIFbY20V_AagyzC5TrJJJljKnh64y8Q
X-Proofpoint-ORIG-GUID: jyIFbY20V_AagyzC5TrJJJljKnh64y8Q
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>
