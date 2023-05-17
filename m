Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19908706F0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjEQRIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 13:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEQRId (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 13:08:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B3F1FDA;
        Wed, 17 May 2023 10:08:32 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4CHA032044;
        Wed, 17 May 2023 17:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DbO+6RvnoPipjVHAznIE8SL314W7nt07DuuylCE2byU=;
 b=uZHdLAqO71pkxECXSZ8Kln6xn5AGYs4j4WrBQrW9CdG1jgBfT2NyuoUFjx781ocp2vsY
 +VTb78S7rqZPm2tQy6x0v9ErymIF5EmSe5pYRKs1JrCHt4ZaYZlNqQrySNM/RgbA/vsp
 5mbKhRWj+/gJ6bs6l24aGEpsaFmXW7Bok1F6T1tFt/Y/1GTc7wzpy9fL5Oa7koVqd7Tv
 ofKphLq9JkgJsSmJ+t5xsCZJDkvOTlMzqyKQDP/vtQWZEzxPJ/0a7FfktOzOQoKUGYhR
 1chTnaI1Gy6g9FFXU3qoaNTFDRAnlAKw7TAW60cMyXhbp2bi/zf/c8ZZR+rrn8xzjmJO gw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdpen6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 17:02:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HFQi1Q033852;
        Wed, 17 May 2023 17:02:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10669j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 17:02:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gegngw6nDrxziioIdtDQ4OLrbdGtt1RnM5YhtOViRBVztFKzDCEvILDlhZ3qpNUg9oYnogpx3TqcyNs/WJF7FTGzlFeJEWN/diZKlJOibeAMLsorYewAwTHO7ZCgoIzqaAxb2PAMED+LqavCf9k7jElsp0J+C+yc5erpOQxq3us6cJP7xXgJ/FBCW9JiZAKVQUOQ/FtSUShq5l4s7tRBWIj+zqRAsRNhh9dvREDNafo1no2fh67DlkkHPXeqbWeXNf+UHkdxjF8KE56hjNQEiBxMWJMrHWgPGanE9/eyEg3qEx5+LxLBP3qHv9gN8Fv4diQ3npB5DgvwD1Is1kuI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbO+6RvnoPipjVHAznIE8SL314W7nt07DuuylCE2byU=;
 b=AxNqZV2g4vv0C56FaR2S8dWhweQWbgm85/TsImh69k9m2zgaCV16ytdqF3UoJiF2K3YhgsBb3Q83d+N1YnAC3CubXXuvTDwS0/Z7wTpjNZat+xnVhbkjwxZolk0OrOdO5PqbEOBXQxEXFjAmDTONPSjUeQYlpHO0JIKBbQGNscD0FTq8RbGJ6KA+AkwjSLWBZieGNe5tKdtBrkgZNaVGG99IZ9UBfTdrugGESGI8EOeWh/JKngmg9AIAHy7XTemyp7rWyYIUhx/+R198Al69WoVnUlt2a2rxajSxcal8zqO411ZSjWhNNgov55mddwIHQyUmkZqFkAI8wBpryqMg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbO+6RvnoPipjVHAznIE8SL314W7nt07DuuylCE2byU=;
 b=LhcmoXC1IMBw5jKPFok6YGeyJKUuIT1l2DjP/foufdRHP8gL+NEyfjPL6kv8rzIkQRLzc71MmtRwA1exohT/FO9vQkHgkvS7x9TT3sfA0dqZ0n+4L9qpOcI1A62v0e6m2kteBQ2Y/9+ktRs89T6YrksAkVXbHA3VGkYKrBhy7XE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7486.namprd10.prod.outlook.com (2603:10b6:208:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 17:02:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 17:02:22 +0000
Message-ID: <4c338833-5fb7-5031-ceac-2d735b70c212@oracle.com>
Date:   Wed, 17 May 2023 18:02:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        dm-devel@redhat.com
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <CAH6w=ay1NNxh=9mQv5PCcDi3OY0mgvRXO_0VrmKBLAd1dcUQqQ@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAH6w=ay1NNxh=9mQv5PCcDi3OY0mgvRXO_0VrmKBLAd1dcUQqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0140.eurprd07.prod.outlook.com
 (2603:10a6:207:8::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e97a17-e201-479d-613d-08db56f87b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZACmKChk/4QEhaPZLmoYIz/Fqek0kYQxwHy8l6UiwYaKAXETX1Wg1ir/yfIhxLoAxNpY3XUyk5Dn48uLZOKOgaRIHqf1ZynVgpKOcYsKsclXLLzDwhw2Y9EUhxWe+HozU1smJ+g+CUyBtq88VPXsDc8/7Ig0d7MmAI+dwlEYJn5e3d0L5UWMbpwMQdKx92PXKdUwMU/XLH4yq2cHULP+IgYd9GzcLchzQeG/N5EgeZWtuLf97ozWTtDXniykD5rR5A1jSNJWrhijhWhNUnpF6sQBQwYr9O/3o1qbg3ohK2ENy2iiZIJD+HOf7lOupk5ULW174ERnyF0L6YIl99qXZnHnKLwY4P3kgM65Cx7rNJ9mzUQKiyeZ2ZC9MguxMFDns5bsYsGqJrFM54WGozPykm8reU28u4SOe4U4XrJ4yTC5TftTGGMZUrZoTfwXmbanXnsDZTP9sEhy8iUN7pYvBSrdG5ERfT9Xe0YGoQP2WauDKChAAr1i92PVJK8rzv9Cu2e7SkdJLvObN86VtaPNZc7HtE2jIlNZcZOMCsArMbDhXvtZkGwILr4x/YMY9JWKlaB/hWUxbBUjNbJczO0Pf1YuO4NtksV2ZpY8YhCt6cZbS4eMx1l+CLISRCpAD1Bw5XmI9RxvmBHn2VpGlUwWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(31686004)(36916002)(6916009)(66556008)(66946007)(66476007)(6486002)(316002)(4326008)(36756003)(478600001)(6512007)(53546011)(6666004)(6506007)(2616005)(26005)(186003)(41300700001)(83380400001)(5660300002)(8676002)(86362001)(7416002)(2906002)(31696002)(8936002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWhPZ1ZTbC9QcnY2YitYYmdpMndyd1hQSTRuTStTYngvMCtQeTVVakNhT01Z?=
 =?utf-8?B?aVpVWitobUVjUi83SWRLWkU4RmtXMTFpZWpzVmdwMGpDRVFLTVd2R3FSZTBV?=
 =?utf-8?B?VUVJZURZOGlwUDlJZ1M3L2tONVBIbTE5c3B1bnpEa2ZLZWtlUjkyVG12RUpF?=
 =?utf-8?B?WVluUFBWSU9DZFVoZGVGZkdBdFZ2aHpnTDlOeGhRaFc2a3RGYnc5bksyaVVy?=
 =?utf-8?B?NDE2aC9VdTJRN0lLL2x6ejUyaXBGVDI5Tm9QZEJWNEJhZTFhTndIQmhSWEZ6?=
 =?utf-8?B?MlN5UktrSEtMMVNtcWhkejk0WHN2NkZTSXZDOE9hRk5aN3pEVEt4dG9KSzZC?=
 =?utf-8?B?aHU5VzB5Wi8yMTlUU2p0bGIrekVZNktaT3lxNEpmOXdsZXFRS3N6eXFEcGFV?=
 =?utf-8?B?cHhpd0VsUDB6QlVLcm5BMFZOT0YydkwwRDVucnV2TThUTDhoWS9Dak1FQnhW?=
 =?utf-8?B?NSs0VTI4bzRXdmF5QjM2bFFFWWZsZ0Flc0p5Z2ZRaHFKckZ4NGpxKzZodHRN?=
 =?utf-8?B?eFI5czdFZlpHUThzaCtRWlF1dHIxV1R2RTk4aklvM3ZEL1NrNnZGS3FGOGZt?=
 =?utf-8?B?cEVuVzI4QnNCT0JQTjBpaDJ5aFlDRjd5WjlZMndBOHpOTms4eTR1cGU0bEhX?=
 =?utf-8?B?K0hnd3lXVzZTenlaU1kwVVhTeUNtZkU5M2cxY0tFbGhZdU9zcW1uZjdWT1RD?=
 =?utf-8?B?SVlsWVNWOEJqaEs1THd2TnFxU0FGbzMrdEszQTFLY2p6SnYrYXNZR3VWY0ho?=
 =?utf-8?B?R3dYekJRWHJjdURHcFRQWHUwR2g2RHczLzdyeFFrOCs0SHNNRWs5Y2FOZ2RV?=
 =?utf-8?B?WDJNVk93VkY0Nml0THR1R3Z2T1cvc2RJR0o1S2pkQzB4TzdQQ28rVyt5a1dO?=
 =?utf-8?B?MTA4YVVZRVdJejZtZnBtZ2VDc0dLdFBlRDk2WlpFUXEwelVVNkpnelByT2xi?=
 =?utf-8?B?Y0pRZWhDOS95YlltSzNQdXRpcHRlSzVLU2ZPMHBnOUMvUnI4UXZpOTZPK3hz?=
 =?utf-8?B?Qno0bEtXNUI5VmY4RE9hT21uZGhLeWRneVJIbXBSbTJKcjhQdUdJcUZ2K0pS?=
 =?utf-8?B?Z0xBNjY2aWI5S3FiTjlYc0hTVWY0NE83OGdwMzhGM0M1Q1kvblNKOGkvcUUx?=
 =?utf-8?B?S3VpVUZnODJnS09yMmdKR250b3JnV3VVclp1N3JUcXNnZHduSllidURKWkFR?=
 =?utf-8?B?M1BsSEVKRy9kenFPRFFDMTlxYW1ucEhVbnpmd2UzWFpGcVZ4b1pacWxxM0cv?=
 =?utf-8?B?SzVPRjd3UHE0OFN1UHZmMlVvN1lmcWNPd1J1V1M4R1c4SS9ybHhXZDlSRTU5?=
 =?utf-8?B?ODRBNWlhQUx6Sy84QVlmaG54YXU3TCt4RCs1OVQwTStRZWRQdFd4eCttZXNT?=
 =?utf-8?B?OTFIR083dVhXSzFkc1NWdlpya2pPTlE3dTVaK3d6aEp1MFFzTGc3VlhzNFJR?=
 =?utf-8?B?U3B3RnNST0Fxa0drTEwwK2xTcDRqYVdxbVI4QmdmQnBhQWVCMWJKcEVuZ3Bi?=
 =?utf-8?B?T0dLbGNZeUVQM3ZhYzNHY2ZFMjU2b05qWGRyVlM1TU8xT1lWbHZLcmc0VE1t?=
 =?utf-8?B?bklRNlN4Qkttb245TldzajdsbEtRcFJpdFlkVHF4Q0dLL0h0MDB2UlVnTmtE?=
 =?utf-8?B?d0JXMlJkTnB4R2h2TE50V1E1cmxjcE9XMXc4bUNaL3M2MGJlTTFQakFhTUZR?=
 =?utf-8?B?MU1nQ2o4QURkbVVSZ0EzK2FOSmFzcWRKSG1kQUN3NDBWVHdrdFRMWUF1NzVq?=
 =?utf-8?B?dWYyYlE4TC9PM0U5Z3NGV2xSNDBaUzFZYk90UG4zQllVazFRWVp2bml6dyt1?=
 =?utf-8?B?ZDk1aGxTVlhtYlBzdDlyaFhHYlR3L2puTXBVSDVka0dZdmZSTGk3bXNveGNI?=
 =?utf-8?B?Mm90RGM1eEMrRDRJaDk2aFFqOVlraVVMNTAzOTBPdDJnNG9LaVlGZzV6RW5z?=
 =?utf-8?B?WHJ4MmFSVkwwSEdXTEU2ZXQ0V0JqN21FMm51SnR4RkJwOFk5bWpnNGUvdEMv?=
 =?utf-8?B?aXJmSWlLRTF5b2pldTdGSGdJN1k2L1NOckxmYUpvOWRIcnViQWliR2Q3Y2Vm?=
 =?utf-8?B?NVg1ZThrejRrMjk4ZVVqaHRQYzkvYWhvTG83YldhazlOdytZVVBCb3gvOEJh?=
 =?utf-8?B?OW41VkgzamV1bng2cEVlK3lPYjlnRUlEVW9Ub0JyTVY5T041dWUyMGR4VnQx?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dGUwcTUyd3ZPeWFOUjYySzNJa2VzNU9VM09KdGFZVG5URFJvM3JBVjlBSVBE?=
 =?utf-8?B?SDR5MlpZeGVYaUF6SElvUk5KZWFubU5NcXVVUmZuSG5rZlBYaWpkS3dpRFR3?=
 =?utf-8?B?U0tyNXBWNnhkK0xxQy9XWm5PN0M4eTdsTkJMWldVNHFSY0MvU0pXRFJDMmZD?=
 =?utf-8?B?c2xXR3lYZEpzM09td1R4eGhEejlSYk5Lb2t6bmZZSlNxb1FJWGdvTGUxbzdk?=
 =?utf-8?B?VVBpK1YrUS9lTVJoZFhnR09US2hLeGpMQnk3Rm5uN0Zjck4zK0lJUmVGYi9k?=
 =?utf-8?B?RnNoNzJYcE44MVdxOVQ5d25MYzM1SmtreXhGdUszMkN5S1hyOHdQSmZscUdE?=
 =?utf-8?B?Q3dMV1BXOHJRSmVuVmMwYU9aNndhT09lVWZDY0htYlFlS3UvaE13MzNRbGR2?=
 =?utf-8?B?dmEvSnJhREJ1bzdicDM4eFJ4RVlwMjlYOU01L2Q5ZDg2UjdzaGU5eHppREY5?=
 =?utf-8?B?N3kvQmZ5Ky9HditEYmpQRG5sck0vYVhPZTRmRmwxcStyOW9OWGpkZGVrcURZ?=
 =?utf-8?B?cWZjVjE1RzltMVhzOHpXRzdZeEEvL3J4dWozS2FiS2cyNHhOWklGUG5HREpV?=
 =?utf-8?B?SlJJaGRlTmhyNFZUakoralBmZTFMOHUrTWNqMmduRlVKRVFkYWptNlBoZUp4?=
 =?utf-8?B?Rm5NelpCdEdOc0xFZUdUamRUUHpUZUpGWXZYcDFLZTE3c3hKeFVvcXBUYnZE?=
 =?utf-8?B?VXdkY3cwQnJySEN4ZnFMMDNYRWxlOS9xYWNlWGZRVENOU1NQNE5aWk5zS3Y1?=
 =?utf-8?B?WVBIU3A1Z1Y5Q2Q4eFM4Nytyc2FaeVRTOHRQM1QyTmdQeHdMZTBqdkk1OE9V?=
 =?utf-8?B?empvQTJGOCtSaE5Mb01TTzFJM1RaYXdKZmFOTFpZTWFueUlJaWVnbGxHTWw2?=
 =?utf-8?B?M3I4OCs5dWtiK0VNaVNuSTY4YVAwcXJJcWFEL1ZBa1UxUVJSR0YyYklHalJV?=
 =?utf-8?B?d3RpQUNLbFpBeGF0UFRFOXNwL1R3eUd2RzFZM3d1cW81WjB3TDRGMXh2bDYv?=
 =?utf-8?B?dEZ0d3dCZk13dU5FZmh6ZEdwODRhZjVsZk5RK1lPUy9EQlM0bGxjRTNUWDhu?=
 =?utf-8?B?bWN2Q2VjNUh0cjNyOHV2N0VWUWtKc3ZLcGpzQURqZzlQNElmQ2NGMXBkcStS?=
 =?utf-8?B?b2ZQVCtoVE94akpKYTdNNm96WUsyZUdwTEtsMDQvRGUzdVVMdG1WR2hZSWV3?=
 =?utf-8?B?MFVjbXI2empWV0lVcGZYcjh2UEJEck8yYWNIaTEyZjVKVWVyWXZYejJlZDUw?=
 =?utf-8?B?ZFZBUlIwRm9PL0gydUtnZ0x1TFBGZW50NEozZ2ppMUhIcmRieUxBSi9VVk1O?=
 =?utf-8?B?Y0lTYkk2SDIraEV4OGlZNkZPVkFFdkVwT2Z4V2x6cHdPS09Ocm1WWGc1akoz?=
 =?utf-8?B?REczZU43dEh1cytjczRsRFh5bGxuYlFhV2NUQy9odnVGaG1heDMxd2l2N0ZE?=
 =?utf-8?B?UTVHRFpuUE1UUjh5QzY4Um9nV0pnOFNEZGJJTjlSL1U3dG15TUtkYWtKclRs?=
 =?utf-8?Q?elDxYfJpLNsr7uRgz4szkmiaYIU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e97a17-e201-479d-613d-08db56f87b20
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:02:22.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPmtLtDMZ30ri+vJzWnCdba3MQTn55QuK2rS6YX0rptQ8OvTsXdZNi6TDWY+/U6aAPqt7/+dbJ6sg9pKZRzZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7486
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170139
X-Proofpoint-GUID: yF1CEABBuUjnmwifmjd4Gpyk5cxBqfTZ
X-Proofpoint-ORIG-GUID: yF1CEABBuUjnmwifmjd4Gpyk5cxBqfTZ
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/05/2023 01:19, Mike Snitzer wrote:
> On Wed, May 3, 2023 at 2:40 PM John Garry <john.g.garry@oracle.com> wrote:
>>
>> From: Himanshu Madhani <himanshu.madhani@oracle.com>
>>
>> Add the following limits:
>> - atomic_write_boundary
>> - atomic_write_max_bytes
>> - atomic_write_unit_max
>> - atomic_write_unit_min
>>
>> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   Documentation/ABI/stable/sysfs-block | 42 +++++++++++++++++++++
>>   block/blk-settings.c                 | 56 ++++++++++++++++++++++++++++
>>   block/blk-sysfs.c                    | 33 ++++++++++++++++
>>   include/linux/blkdev.h               | 23 ++++++++++++
>>   4 files changed, 154 insertions(+)
>>
> 
> ...
> 
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 896b4654ab00..e21731715a12 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -59,6 +59,9 @@ void blk_set_default_limits(struct queue_limits *lim)
>>          lim->zoned = BLK_ZONED_NONE;
>>          lim->zone_write_granularity = 0;
>>          lim->dma_alignment = 511;
>> +       lim->atomic_write_unit_min = lim->atomic_write_unit_max = 1;
>> +       lim->atomic_write_max_bytes = 512;
>> +       lim->atomic_write_boundary = 0;
>>   }
> 
> Not seeing required changes to blk_set_stacking_limits() nor blk_stack_limits().
> 
> Sorry to remind you of DM and MD limits stacking requirements. ;)
> 

Hi Mike,

Sorry for the slow response.

The idea is that initially we would not be adding stacked device 
support, so we can leave atomic defaults as min unit we always consider 
atomic, i.e. logical block size/fixed 512B sector size.

Thanks,
John

