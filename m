Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C9C6F675D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 10:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjEDI2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 04:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjEDI1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 04:27:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1790840EB;
        Thu,  4 May 2023 01:22:15 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34444otA011117;
        Thu, 4 May 2023 08:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pwSlPgl005FrPARlgSM7FFxH6lCTgKHCxmJqWy67NeQ=;
 b=gRMs8r+0jKVkLHqPPZElaGaKy7U6QHPZSLjfOLz3QD15GG/L+p9bGZcWni4U997ohUCQ
 aptccWT9dzJjfoBYFXKifFHc67ROKutiwcydXDs6fuCE5GfRrChuRX2PBTWcIQQR2F6A
 fEnQfUNDxfoQujJkl2lrk2u0IDU7Ho9bfsA6YD/pIhdJ3Mb0kiLq4Z2Q8GHOE3vgd2aB
 PM1w0h0o2z9Vgaq3qJg5m+qPsR2bPzYv/lvkXOYLRcW2gBzjLlWHRGYvK0NWacWEn8qx
 q8y9nSSey7yJ9K+gyfQLok+PWnTsuWcPhG05/XUxO1V9JhpeDySWe47CPFgal7YilNv3 7Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fs860-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 08:19:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3447waJh024942;
        Thu, 4 May 2023 08:19:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8da7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 08:19:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyREmrmtJgkWjxpJ5Kw1WBNVj7a+cjNPrG/+KX1RKCmKbRUHZyC5D7SpLQ7ISv3wpYphhHxgJJbyfXUSDuwwaqvfieudxivrrzSdPShCy976mATn52IkGoE4TGwbrNNLaNM2m7dBB82kRBZwS8sYA7aYkoSMPHofSPXoEsDiLSECdXt4OocrMBIP3X3WogSmrqavw9/SEWTzdYYR2lo7DPVym8VKh0P9Cyok56W1jqXYlGJSzZ2bxgmmufLyasm03545Oeos8ebZCMkQ1wm+ikUHXDmMaZfXjk9GRDfj6acFZzEqXaqddNHnmpIQnowoFA/0lgYNMWgzuqPES76xkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwSlPgl005FrPARlgSM7FFxH6lCTgKHCxmJqWy67NeQ=;
 b=UnswyvY45uqPE7XUnS7CzLJwS2XU0aQMQ9XDUpo4r1NV5dAAyJTYNlMPfCzR+f8MT/9/K4bNTe8pzfrJmhkz8ttGbe4kVJ4B2edY9f46nADekYcqs806MD0D2nSFgCCpc47cqvdcN//BDvGd6OyUAmZAsKcWlqRo3Wmfh4CUoEptCyXDuql1uMob+IvTgPkoBXOEUkTeAfeHzu1LlinVAtYVX8eayJEAE9jswgXPNhiEBST9U/52nfOjUqtZejIz8RF7Be7T0RAkuW7GA9esfBCmLpBa0LDA2+MjrdKIuI049Irl1lb4NI5YTS2OCLuPdEt0z17meqiTSecer4XLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwSlPgl005FrPARlgSM7FFxH6lCTgKHCxmJqWy67NeQ=;
 b=a4cAx2b7+mPPhK9v/mgM/nXXGFpqDYCBeZxdT3iYMSaVKPIZswHCkwvXOyWWQGe1w43fFqobzwGCDRW1UP4PbJwUfYSftSjKgnzK2uH8f9QUeo+mlhxlxzBuXJUnqvxOnmTXxdACe/mZxfXbUNAoc/tGHmNJwXe8LXIrnMEfPmE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4534.namprd10.prod.outlook.com (2603:10b6:510:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 08:19:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 08:19:15 +0000
Message-ID: <37f089fd-ff1a-1008-1004-f6c70a46c3bc@oracle.com>
Date:   Thu, 4 May 2023 09:19:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 16/16] nvme: Support atomic writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Alan Adamson <alan.adamson@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-17-john.g.garry@oracle.com>
 <ab663865-9099-8f6b-de1e-30c1356d5078@acm.org>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ab663865-9099-8f6b-de1e-30c1356d5078@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a180d4-dfa2-47a3-8a5a-08db4c783ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BL4HDe2bC5fJf4Z0RRoPHbfnir4wlLv2wspdihuvhofy7UUrmvPRAG8n4KP44mP95uG42I1Ipkba3CvzzpjKqgg0DuZOx+H0/K1K18L4qYhHXBBcQopHoLvY9yHlxfDulzRfJ5t4FmqijPbTj33TXGeEwIk/W309gc23yKG7AwQ4YzeNWKJR2NgPQ7rbWpRs2FTwSs1xsBWox7UU6Ei3UTrOJTAr7joCoq+itq6O+PXVK+Q89BQXp3Rj3c6ONZjV9oV3XiGORAbuu7OHGT9McxMqLorpRgF6s/O8f5K1c+AJoSgn3CouKJWIwqQFKLcdL4LSqAQs/FkssQ/8NzOjWG1mOsBmK5vJpjPOUlVZrrwljBwxJf+QfUkKA0srQA98VWyXlYEVvQlC623ajm01DAjVGDX41uSXIv2bfe4p4zdU4ogNWs9pCQe+r3vEJoAYq+IaEe38KnDd18icGUdno/iBo0B1hPIBvTtRGFdWpLgk2iSPUEfRcFb+FEQuUE652qp4bF/06Wd1o0OgKJaL0EEW32Fw5kwHfsE6DE5Wb7Kku0Dm0A6/6RS4ujoTuu7ahKHtDJiM/sfMOEgayqmsr1vH2OzY8x9uYrlZiCgs1LeQVqw+00KFhiHF+Px7pyYZbGs6hdU5nWk7ICyB9RkomLJ9AakDOSpJlxW9NkVY3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(6506007)(26005)(6512007)(53546011)(7416002)(186003)(107886003)(31686004)(2906002)(5660300002)(2616005)(8936002)(8676002)(31696002)(6486002)(36916002)(921005)(6666004)(36756003)(38100700002)(478600001)(66556008)(316002)(558084003)(66476007)(66946007)(41300700001)(86362001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWMydlQvY3pKbkloTitHeks1TjJIVTFuNWkxSjJLWkU4ZHMzbU96eHRYTlJ1?=
 =?utf-8?B?VCtOQnROc3pYN2tzWHYzMWRnSVVFb05MOWhTRXNhZFdTaUxIWjYvWU9FOGxX?=
 =?utf-8?B?cnNQNVVVQXlvSmRvcGFhVGhjQVdnRGl1ZUVubjkxcEZRTXZhWmh0Wjkrdk9L?=
 =?utf-8?B?a2VjUjlkZ0YrV3Q5UWlsb1pZNktxRERyQ1ZOSVZab3ZHd2tXZnl1eThTRUFl?=
 =?utf-8?B?ZFhwZ1gyN1pEczkxbmlaOWtHdnEwY0l3STV4VGc0Y2w1bDd1SHJ0SXl6Z3hH?=
 =?utf-8?B?YitybjNoYnh5b0NuTWl4eXhMa0xrQnVLNzE2R0JMSm0welRmdlYyYTFrSElj?=
 =?utf-8?B?Zk5xRXhVaTRMbDI2K2N0L0hXY2pzaWJQM1M5b01JZE55cDNxR2JWS3gwd0xm?=
 =?utf-8?B?U0F6RDlBTjE0N2xtY3Y1dXA1OVowclpuekZaVlJ4cml0cndwRWFWTU00bHpJ?=
 =?utf-8?B?ZHY0M1RJRHRGdEhualBzK3VpWWFuQ092U2JNS2lYcW9XbThyRGxzdW5oZlBo?=
 =?utf-8?B?MWtLL0YvSVZQVHBLMmxXL1pUL3JuNmtiSGdqeXVPSWh4QitxMTl1UTc3Rnd6?=
 =?utf-8?B?cGV1ZUNRL2dZSUlGUU9sOGJER2kzVTlUZ05lOEJzMjZ2RDliMHhJUGhDVlBH?=
 =?utf-8?B?YlRCWWtGNXZVUHNqTWNHWm1wN0JtWHd6Yy9JZEJzcFF3M3ZJeVRjMm5mUHhW?=
 =?utf-8?B?MHpYQVE2SFFaRjE1VGJBWThhSlRSRWZGMG9yV0lUR1FKVFd1N1NVKzBpbktZ?=
 =?utf-8?B?Q3ZOTkNTRWpaSy9VY0JUeVhDZnlwZ3I5TzdiMVd3Z1VmTkJJYUVkQy9ZNXpt?=
 =?utf-8?B?eklFYThocHRrZzhjQUhjdE1kaGF6aWR4RVBKMW9RUWw3SUxUZTdhVllPN0Ns?=
 =?utf-8?B?VDhKd0tiVkVtNUhuS3VJQ2RDRHUwQXArNHRnM0tvQXlYbS9UMExpWEdBMUdU?=
 =?utf-8?B?Ui95UXVGUUJwY01XaEtDMENRdUNZTHRWbjV4QThheldhSmVwUXVkZHhvS25U?=
 =?utf-8?B?MmVEOGFDamxrUVJWNDBaWkZZNHovSnZpUXZ1T1dOdXdBZWZRdGZJbGxacTNP?=
 =?utf-8?B?K0h4UmZqYk55YzBuRDg1VFNscmwwcEtFbTJZUC82VE5Qc1kzRlhldUdYZEZy?=
 =?utf-8?B?SjVDeHdLU011OGdFL21ZL3gvSkt6aStNeTZXei9TY1VoU3p3NUZLY0pvdi9K?=
 =?utf-8?B?OTZpQUJ6aWhZeTZHMjYrSWlVU1N3TmJoWk01bVZVRWtTSExaU2wxUWU2dFRj?=
 =?utf-8?B?NFkya3RJaTRmK2ZPOFYxOVRoc3JZVVdxSWhqbG82NE5hSlV0cm1UVGo5SkNW?=
 =?utf-8?B?QW82QlRuNmlXZXVVVlVwL29sL2RvQkxXanhpVzA2Wmg3RERJcmltVHhVdGlm?=
 =?utf-8?B?MVVyM3d2bVF0VmRiL0dFYVI5akdScngxQmhaQWVVcFZ3QXJ0YnRrVjh5M2Rk?=
 =?utf-8?B?RWxpNGwyVktISXNwZW44S0ZQN0RHM3lvZHlVaUtZdUE1VEdiMXBYZkIyU0Er?=
 =?utf-8?B?eGhhTFZGRytYeWp2Z3RXMzlhalJEcVlUd3lhQmdzYmU1YjduWCt2bDNKZzVl?=
 =?utf-8?B?QU0vMWk2YjFFL05kWXBLaTZodGhkWVVTd2F4RmFmakdEeUdjQWE2eTBLKzFu?=
 =?utf-8?B?ZWgyMzdYSjFhZVZieUJTVWEzc2E2T09oSy9BRXdTZjBHSkJuTEdUQndvOGNw?=
 =?utf-8?B?RzNldlBiSUZWUUV4U3V4QS9MdzZVaXZaaU1Uc1NFcnI3S1gzQ1FDUUNwNGxO?=
 =?utf-8?B?TjRiK01mdFgxcXNoc0hyalRyaEJEazRhOXpleERudGdEVGlUSmducjJkNU8w?=
 =?utf-8?B?bm9wR3hmVWQ2VnBMM3ZIOHo5ODRhTk0zZmpNZk9qd3BvVGtCSFdVSDg2aVl5?=
 =?utf-8?B?VFNWbVBVTjFxRnB5akVSVS83S1h6dVc1TkIvVVJxK2IvajcxT0E1NjU5aXZR?=
 =?utf-8?B?MVNrcWtKdmZqZEFxUjlFUWV0YUUxTzM2S1hTQTBsdk01RlA5R1p4VFd1bUdR?=
 =?utf-8?B?NERDV2RlYXNXNHQ4M2NKaXF3azBJRkhrVDUyQThXMXhMM09MQWswQXQ5RmVv?=
 =?utf-8?B?ZWs4Smxub05XcEtlTkUwMHBZbTYxM0c4YXErREZHUXp3UUtjTzNsdEhiVmR6?=
 =?utf-8?B?OHhSODNTVTc1M3IzejIxVUVVWXo2eGtWYUpVRUhGMFptSERFdmsyNG52R3hx?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bkJBdlNuWmQ2MkxRTSt4UUdjY01ZWERCcUJMbEI3bUMrWk1zVEJOSzRHeXll?=
 =?utf-8?B?Q2dXbi9OUlRxUFU5S2pzZlQzQXZvd1FOZDBjSTB0czByalZKL2poRzZWaWdQ?=
 =?utf-8?B?ckdNOXFKWlFVWnpDRnVvZVNLQ053dURSZDFySzFpb2tUeUc3TERSSC9qcHlO?=
 =?utf-8?B?eWVnNjhjanFYSE1UMEVWNGVwWmdDTzk3cWE1WVRUMFRYaFQ1WkQ3WjVCV2pi?=
 =?utf-8?B?dHV3c3lqNlkyN21GdUQ0a3I4Y2NnOWFSYm1FQ1grQXFDOFlYcmFBTkVvdmdw?=
 =?utf-8?B?U1NCRVp4Q1h3TzllNzROYXh6ZzdnRXdCMXFvMUxGQVFZNG5NU1BmY3ZxZWxq?=
 =?utf-8?B?OE4yVnZuTnJVQVl4eCtGSFBwOEk2Z3dvc2FKUDJnRW9mZVljZThFd3k4UUk5?=
 =?utf-8?B?d3ZQVXhJYk9jQmJ5eExZSVpWdmJxYXUrYmczRlFRY0Rleno3UWkwd3hxU2d3?=
 =?utf-8?B?ZG95MXlpOE5SNDRYaTFRalpod0R5emUzN0FGcjF5c2ZRQ09tQlkrZnVzV3VM?=
 =?utf-8?B?WE5XZUduSXVLL3cyWTJCRERCWjJaakdLL3ZaM1JxS0hra0dnVzl0Y3RjdVBT?=
 =?utf-8?B?VnFET2dsREozUU1tZHZwN3dSWkRGNVJSRHlacHpIOTVCOHE4WFhvaUVTR1hO?=
 =?utf-8?B?aGlrR1FFMW0veWU1YWZWdVEzUG1Ta1dmMUErMnd0Ky92NDVraDFRWDVJR25y?=
 =?utf-8?B?RTFlV2x0RUQ2MXp3a3hlajhFUHJ0TW9nY1RkTjM4VnhXblRmSktacjhtMDRn?=
 =?utf-8?B?SG5aQnp4YWEzbDVRNlg4aEFKaXd6QlJrWm52Qk1IbkRmK3JKbXdMQnFpcDl5?=
 =?utf-8?B?T3lVL29DK2hidWtzNUQwRGgvSGErcFBCL09vd28zVWlyTmNCVzhlWUFZbHJ5?=
 =?utf-8?B?L0h0bXhVcmc5ZEdPUGUzTjlSSmxVY0ZvR2hEa0VINnZ4NXViZ1FZNjZLOWFr?=
 =?utf-8?B?ek1qYXJYWUJNa0puMW5CdlNMYTcwTjVaSHlGL2N1cGJZa0lxTzZSZytlQzJp?=
 =?utf-8?B?R0JHUTV3RDdWTHN4U1phemZpaDkwMGpKTlQ2WmF0Q25HcGlrNitzZ0tFOHlx?=
 =?utf-8?B?eHJnUGdOYmhBb2UxWTR5b2Y5RjlPa0pDWDlscnZKU01HMVdmbXVhS0xraEhs?=
 =?utf-8?B?SHJSK1FGZ1Z6R0ovQnlBNDN2SlU1NkgvSXltT2VGTXRHRjdiZDRCakdNNFZW?=
 =?utf-8?B?YlVvenFkUEwzYk0xVmdybmw5NThVZTdnNzlLdjhMa1FRVUM1OHM5OWNURU5s?=
 =?utf-8?B?WjFCemRvMTBJOEdsdHdVM3cydTU1aFpRR3FPZElsaUY5MkRDWjJ6VlhjOWxJ?=
 =?utf-8?B?ZzYxV1BQZEtEVThzUlFySDl6b2J3NDVXTDlGZzczczloU3VmK1RRZm9wRWwv?=
 =?utf-8?B?ZUJEUy9oalhlSnRzTS9aS2pNbUpONG9WNEZMdDBaejAxZnJxUDNOSFRnNWxE?=
 =?utf-8?B?RlhhMlowcXdEdUxyRnFlR3RWdWV0c2FOQk5Velp2dGk4TExIRElrZFRVZnJU?=
 =?utf-8?B?ZE4vVWZqR09SNE5HYkhIcGZMN1dIRmd1N1Z2V2JSRmY0NnQzeW0vQlJ0ZVpO?=
 =?utf-8?B?SkxUdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a180d4-dfa2-47a3-8a5a-08db4c783ff5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 08:19:15.7930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYIme9gegT1yVLKnD7fJlgQZiiWFS5TgZCKcLBx4l7dXtJRjZx8OoJNCYDwTV7dLEqbT746SJngEzQw/9VXgVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_04,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=955 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040067
X-Proofpoint-GUID: W82vmXTZGG0E0PqNb_mTM5EOSc8QmbVG
X-Proofpoint-ORIG-GUID: W82vmXTZGG0E0PqNb_mTM5EOSc8QmbVG
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/05/2023 19:49, Bart Van Assche wrote:
> On 5/3/23 11:38, John Garry wrote:
>> +            if (!(boundary & (boundary - 1))) {
> 
> Please use is_power_of_2() instead of open-coding it.

Sure, that can be changed, thanks
