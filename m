Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9C6F6738
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjEDIZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 04:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjEDIZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 04:25:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538845BA3;
        Thu,  4 May 2023 01:18:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34444b2E003741;
        Thu, 4 May 2023 08:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vydLlT7Hfr+alOCXtsY20z/jVfrK7mkDW4rKO5QE2xM=;
 b=VXx/bfgIX1XtF2bAHUnIOPNQnWbLnkQTyC0iGam2eWIAqkzC/5zJ9Zm2HdT28Gdzyefh
 BzbY/J9JLjP1rU/QfUltaRj7vT9oCUBcacDpcERqZd0yJjOVeCdP0OTqjeijouRrj2yO
 4lup2YaOLFqzIKTQrUhRk13uApfQVAYlaDjEPaNQn4XphZjuEwKFz090u87Whabz35Xy
 6IFOsjGKEytsUUrnYpcsxvG8IaIXCr+ar0xmVPHQ0a1Bthc1RAwd21UzxYCsqK/Jw2oi
 fmnArIM4kKKKK45K9kAdMvRsVk7BMkx2+YVHDXdGhJUJ8m0PmIqRMhWM0qWLEk5xND6h 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1s7y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 08:18:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3447waQt024948;
        Thu, 4 May 2023 08:18:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8d8hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 08:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTaRr+bWpYNYXNGvGxnU52n6cgFwW9i7U8HUcvRysg6kZK0WzoTPhRUfzqUmHQh9cLLNrj/kyxQvL6sElUD0Bm5dH1jVxVj7+Bv3k+UFUfhh3cMGOr7i/6WhUUrtyYyqFi1E1T5csQjZ9VY+3LGLx+/g/YGNpfW5Zio3Cg3TmlsLEjHcVYIPw5EI+kwzFl/dOGz3A1f2mf0RHSKGWLwjepKz+fSMy3qWe4d5A1Z9weh+n/n8eQiNSUb3wzkaib2BZ/R17DA0n4BPpgBIivw5JXjXk7VYxnqP70g60eacMRnpBnwR+fwaAhZYOZQPyhfv2xYqBi1S7MJNPE+WKzShDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vydLlT7Hfr+alOCXtsY20z/jVfrK7mkDW4rKO5QE2xM=;
 b=PxAQjbTQQPDsl+xNyvB/a3C2suW4ALxbPUNL7td5lLV/y+VvaZj2eDHfkUU9kKT5Qtut2LbCdq3qd1B7PN9TziabUJ5j31BZ0LYJDrsmMxj0+7/IRe6L0aHi/AZTL0AF9n+HxawfJwJ8E5eMP12c2LhHsgsdIIn8LYKCScrtCzUbynxKgzx0UsZRqyIMQHMkO2IYNB69mtThg5XbJjp/KbVf/CyQuU0jqHRx5A5YUXLRfGM2+KkK1q34DHVtqJbBIqRfskRkuKGa4XCbaGguOC6uFyxMaQf0yeV2/9spIaxJXiGmf7wm3wbLtildheWa/Hdn83FXWyx0DOowp9IEnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vydLlT7Hfr+alOCXtsY20z/jVfrK7mkDW4rKO5QE2xM=;
 b=LwULChW348JB1oH6n1wYpvDSB98h5DgD7P8ztKO8XyZ8OOyArafjJLw/ORDirp19WsKyJCQgS/jRbXn9W7r9czu+HXPxnmMQRZbqC+aiEeU4mHiOe+8pCfTQrV7i4mZgdX/NGsK5bw5D/ZhKzFymuAVrizjlB2g3YLheU0YfJDc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4534.namprd10.prod.outlook.com (2603:10b6:510:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 08:17:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 08:17:54 +0000
Message-ID: <1f4b5f00-ea97-b8d2-e01a-a33b2dde5548@oracle.com>
Date:   Thu, 4 May 2023 09:17:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 14/16] scsi: sd: Add WRITE_ATOMIC_16 support
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-15-john.g.garry@oracle.com>
 <81ce524d-6186-e016-f597-153d214036bf@acm.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <81ce524d-6186-e016-f597-153d214036bf@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0322.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8e8d94-0d1d-4cd9-b7bc-08db4c780fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqr2cBenvD8WhNo8gbhgAW1EveUZ7/RH3OQI/bxGDA+jE0p+Oil8nVzUxlIOjHcrFbMujbJD/8/S7MM35j0YmnfK0LWX/Vg63vQZX4sInMYGgdmS5sclNnhe9Y998XVaUgMgdRIAcGk7YPJETRy2KR0XQA1z/CCRfCQ31Eh2kDVAJOtk3/dPEsAXgl9Ye28IvBgsYODYOcGcJKFa/fFEGI9A6KUntKD0yjr2KHWRMJLWc/pG2MxQrihby5c2TGb8wqK9msaCL094ftAWdKPG6ujZ0AQ5oCawHeqVBZptJoITJUIEJ6huSQVNheAGaed8gNA8AWK7RVPXyOhCRuw9NiASH62UrElwQlKPtTLXUgAtmivRl0ruTdE6aP6c8ek7+yF2AjROgk9Z7xltz0xrCdsg9PU0grN+qG6SJSOxBzFCnYQqUYA2eCsbW0LqzQii8y91E4C5QAniaF2JDcSUKPSXPT9MONogydg60IzW6S5uOhpd5CM53AOBzephcZkNlnGRw8g663SkGBygquW81XwRIPUZyNj6SJ/YOPJJQ5wLRHSjk8nTArQaGotdDBUNAAfhqxkeS8XWjespL36qhG3fSP02k37zqbmvdEAc/pSp5+M/rgSIYOX3B+iDBI2HnTWj+I2P5PIsX881XQxdHrQOKtaRxbnHkDWvdLFnitg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(6506007)(26005)(6512007)(53546011)(7416002)(186003)(31686004)(2906002)(5660300002)(2616005)(83380400001)(8936002)(8676002)(31696002)(6486002)(36916002)(921005)(6666004)(36756003)(38100700002)(478600001)(66556008)(316002)(66476007)(66946007)(41300700001)(86362001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2lyODlEQkkySlp1YXpUcDFPZjJYVnZxZ2hrMVZubjZabmltMlQrN3RDZUlD?=
 =?utf-8?B?KzVJRU8rdzJDekNySUxRZURGWC9CbUVZd1BvbVlTTWp1M0twYklXYXhJT0wz?=
 =?utf-8?B?VUZtRXBrSEd4QWlsTm5ZdWdVbVpMVmhubHNyR2pIZWFHTE5zNzhjQklPd0dr?=
 =?utf-8?B?YmFWY09SWEVIK0FwaFJkQ3RxLythQmpobHZzWnBMaVNLa01mY2VkSjRlSmlF?=
 =?utf-8?B?anpSd1FCTlhlYWUybWpDTkJFczFFY2Q5dHpBekRhMDExNXhyRlhObXVaTjJL?=
 =?utf-8?B?S2ltRFh3RDhqckFhcmowdU9MVnNPWFdMd2YwZVRhalFab3o2ejFudUtMQnhH?=
 =?utf-8?B?UUx4SmR3NjJ6eUIyYUpVTE4xaDBscUNycmp4NUhkOWtqQ3JyU2VhM29rMkpC?=
 =?utf-8?B?YUFBZ2Y3WUdGajNvYk9temVVTWlNWGQycTI4RlNaRnk1TitRSWNaWDA2WWxo?=
 =?utf-8?B?MGtuSWRtVGZOY0s5RzMrMFFYYW9BS0dyeW9rMTVzWVZjYXd6UkZTLy9FNEVv?=
 =?utf-8?B?NFBVSGFaYXlHY01aaVJ3Mmd6c1lSVXVPTW9OMGtyU0pzZHZ1cHV0YmNqV1Fp?=
 =?utf-8?B?RFVrWXdzcFZ5ajB1YldTZkRJTWpiTGtvSXFyaEVEZ2NsWjduTE82cEc4L1pD?=
 =?utf-8?B?T3VaZ0pZM0ZrT25SOUJrc3VLaDE5c3FkbHJPVFVudUJuRllub0FuRTJRMkVL?=
 =?utf-8?B?WUZLR3ZFSFBOWlhwUEgyYzkraGtYR3c0YTB5SzhIa0dhM1N1OFp4Um41K0x0?=
 =?utf-8?B?WkFQK0p5L012bzg2UVBnQ2YwWTRDNmd4SGFwUDlDVGZ1MDJ2RzJsTFBhOUlR?=
 =?utf-8?B?eHM5Zk5IdHUweGdabzhyVi80eUFIWGlEcE9uTWJITkI4dXpJMnA3TW5PN2Yy?=
 =?utf-8?B?NHNTVnV6NW9ObFpJNkNoeldLS3RlSzZQWGRmMUFNNG01enR2NGdYS2ViVnoz?=
 =?utf-8?B?blFNN3BiLzJVS2hyUVlVMEtZUmxJZEs0ZGl1a0ZkT3kxYUZEQWlvc29TSVVL?=
 =?utf-8?B?RVpYMUpxdmpaWTZ4dGFLMmxVWnB5ZHJwTmN0cGdrcU9MSzVQaFBWcVFoUEsy?=
 =?utf-8?B?Y09nRU5iVklvNlA1ckpxWkQ1SFp3WGdUZWNZNkE3K2QwcU9qRXlDSXhFbXpK?=
 =?utf-8?B?TEdYQURPNzh6OGwySFc2UnRZb2Z0c2tDaW1iQlEwYmQvaEZQWGtpMmZQaWE5?=
 =?utf-8?B?aTVTNGxRMlZsMlhpM3dVU0RQOE52YkxLUkpVVjFaUVcyZXZsdmxySE9LaDVh?=
 =?utf-8?B?WmF0cHZzQXZodE16WEVqcEtXanNXNXAvWTNpeDFZN1RmUGYxWGZEYVBERG56?=
 =?utf-8?B?QmR5S2JpejBLdWQydXlreUhYTUxrNUZTOWMvZjNQL0xUWWE1VW13UjVjajAv?=
 =?utf-8?B?YzJVckYvdSs3K0VndE14VGE2WlRsTVI2Q25UdG5kdjFPNWs0WitMOVo1Nm5N?=
 =?utf-8?B?cTV1dzI2aWtIelJ2WElESFZ0NmQwZ2lqcUZXRXpRWjN0NmpqMGZsZlJ1Q3Ay?=
 =?utf-8?B?dlcrWVE4MnRMdjdBbzRERkJWUTMvbklaaGxLWElCVDE0eGJvSVU3QVZqRjVZ?=
 =?utf-8?B?U24xK1hrY05kL2FFNElSWUtTeTY5bldBeWhxZmJLb1RsY0tjc3ZxTTVYSTlM?=
 =?utf-8?B?SDF6cGMzNWp4WGIyamRaanF1ZGJJd1JHRjJUUFg5L1ZGaVJuenlpckdWTERG?=
 =?utf-8?B?UHlmcWVIZVUwOWszVEQvUE1JV3NFYlMwRW5Ub3RtWU85WnhwWnJ0WXFweEVI?=
 =?utf-8?B?dVo3ejU2QzBYWjhXb1RGOXVlUUIzVFV0Z3U0bTZENGJ5NWtpOG1LM00xdnhZ?=
 =?utf-8?B?cVQ4NXVZVVA2UXlwdzIrTDg0cEE3d1FJQlhNck10M2lOYm5aWTRmMXBub1JW?=
 =?utf-8?B?SFV3SEpoeEVid3NaQ0p6V29TYWZIbzR0NTZEMTZSckZlM0s3bkhDbDNiQktB?=
 =?utf-8?B?U21xU2dnT21DOXFQTFFuZVRFYkk4U016ZzNnUEtWYWJINldzWmRzYzcxMEhQ?=
 =?utf-8?B?c2tNdDZJcTFMRmtKbXJ2aEN0dVI3SHNlbEFzanlTZkFYMjM4b1JOaXBjcmsx?=
 =?utf-8?B?VTVCRlB6anRQOVRadm9CUUpBaGJBUmRYanlrZHJiWXhXQzZ6R1VnbHBkQ0No?=
 =?utf-8?B?Uyt6T0xPTFpIa1pYSkZjd04vZFBKdjUxZkt1Nk9id0Q3cjdldDQ0NUtBa3ZD?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SW1FT2ptTE01dC8xV3p6WmxiYk1xaWxiT1JsbldreW9wMGowYmNVOGg1b3p0?=
 =?utf-8?B?a2RocUVOL3VWdWlkQW9sV0w5ZTdHekJ1R0NPZCs4WXQ3TTVOajROUlFER3ZP?=
 =?utf-8?B?NkxDZzNXWGdPMElaekx3UlBtU3U0dDc0bmR0RU5JK1JhZGtvd01ZYjRxYURU?=
 =?utf-8?B?VnhwYURiTGRzSlMrS0psQWFxQjNRVEkrcSs2bjVLNWJmYUMrZThpTnZocGsv?=
 =?utf-8?B?RVRPcVlGUzh0SG5CUmVNY3RUTmdDdlVQeHcvbG1XdFpDVmM4Y0o4a09idXQ2?=
 =?utf-8?B?VFNZSytSR2o5Z2haMlNwU2JUMG1QZThUai9ycWh1MHg0NStrcHRBdEpDQTJQ?=
 =?utf-8?B?aGkvc29PV3drVCs0U2xmcm9OZzk5bGlySm54aVVpZFJEVnVsajFUOUNaL3No?=
 =?utf-8?B?aW1kdnBPODNqZmdRTmZiclZPd01nUjAvOEtGVnJaYWJEcVVRRjNIeWtKeGlh?=
 =?utf-8?B?Mm5OZ1NwSU1ZVU1xSGRqL2JnblN4TDFseTZhRE1pQ24xdWpEMDhWY2NvV1p5?=
 =?utf-8?B?OFRheW1aTlpxQ3NEdXEyVHVadFFoQUl6MDhKRGh1YlRuTWM4b0k4SEVuaDRk?=
 =?utf-8?B?aGNPQnI2cE53bXVBOHJuSGZBd3VlYlBPeGQrUkJhZzlzSEFSSGRDR2dJRVdB?=
 =?utf-8?B?TXdqSWxZeGpSYjU5dERaYmFVMHY3N0xiVU5IUUxPcHQwM2JmSVhpNW1xMjZB?=
 =?utf-8?B?QVEwSTd5aDVXZ1pUek84WXJJTXNDQUdkeHZNOGpuOE00TFBrNk5LT3ZHYVV3?=
 =?utf-8?B?OWRpSGRrVlhEL1ZGV0Jsd1lyaHJzYlprcHVWb3lhL3VOcTZhZFZCWXAwRmpT?=
 =?utf-8?B?dm1wbXhUN21iK2lFSkw4NUpJOG1zeUllbWozcUtXSzdMZzVtTmxBVCtSSDFS?=
 =?utf-8?B?M01maGVBL0FLVDdjeFhXS2RWVnRZWmhkUU1IUkljOC91L2laOElVbVNVUEZC?=
 =?utf-8?B?UFN5bG5iNGx5RVg0cUZja1JxNmtoNlE3YU5Od2hqS1pVNzQrcnBWVDhrQmt6?=
 =?utf-8?B?cXliaTEwLzVobGhCdzVZNWpjeVRKZ2hrS0w5VSt6TU9KUWUwWnhiUnN3S0d2?=
 =?utf-8?B?bEltZmoxditLQ1VjZmVHVVVxWWdyUW5WVUNQVG0wNFJqZzJiOXlKT1gwcGoz?=
 =?utf-8?B?ZkMyMmZXSjFJYnZJUXVlcTlWOEtXOUFIeE1xYmFldGJueXg1YTV1Y1c2VnZn?=
 =?utf-8?B?UkVYWVBRVUdnV1VYQzlKa1JUdGNORkRHTTdUTGoyRStDVXpmajFKSlU2RGM2?=
 =?utf-8?B?MTBZcm1OWGluOWdqeEV4bUpjM3c0cE9jU2VRZ3JlRzNOV0R3MHFKMFZEanZ3?=
 =?utf-8?B?ZXJ2d1NhTGVQNkhjcnpsaDdjODhWSk9kMzhmY296bWdsL2FSN1I3cS8rN2ps?=
 =?utf-8?B?dWF0K3lrU0o0ZDZ1a1c2SVpJMlpvUXpLbEYxalFuN20rQ0RkUHpkd0cyd0RU?=
 =?utf-8?B?SFN0aFJ1VEJydEdORVl4RWhWRFZxdVFpVTRyMzYwUTJwNmh5ZnYzVnhIT3JI?=
 =?utf-8?B?RU1iTlByU3JBNG1qRGJMSGFXQTVRczFvSTZWU1hMbVk3d2FVeFJ6WTVWa0xL?=
 =?utf-8?B?eXlVUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8e8d94-0d1d-4cd9-b7bc-08db4c780fc5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 08:17:54.9393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFj5JRhjEC0SZ+MYwkTVogp/NfL9CaQjF4x320AebGqYKbZwoBQ2R+ouR4SIaKYJLwC+sNAG9I6bTBQdPltf/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4534
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_04,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040067
X-Proofpoint-GUID: sb46iikrmq410exb5kcFfutI7Aa9dPBq
X-Proofpoint-ORIG-GUID: sb46iikrmq410exb5kcFfutI7Aa9dPBq
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/05/2023 19:48, Bart Van Assche wrote:
> On 5/3/23 11:38, John Garry wrote:
>> +static blk_status_t sd_setup_atomic_cmnd(struct scsi_cmnd *cmd,
>> +                    sector_t lba, unsigned int nr_blocks,
>> +                    unsigned char flags)
>> +{
>> +    cmd->cmd_len  = 16;
>> +    cmd->cmnd[0]  = WRITE_ATOMIC_16;
>> +    cmd->cmnd[1]  = flags;
>> +    put_unaligned_be64(lba, &cmd->cmnd[2]);
>> +    cmd->cmnd[10] = 0;
>> +    cmd->cmnd[11] = 0;
>> +    put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
>> +    cmd->cmnd[14] = 0;
>> +    cmd->cmnd[15] = 0;
>> +
>> +    return BLK_STS_OK;
>> +}
> 
> A single space in front of the assignment operator please.

ok

> 
>> +
>>   static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>   {
>>       struct request *rq = scsi_cmd_to_rq(cmd);
>> @@ -1149,6 +1166,7 @@ static blk_status_t 
>> sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>       unsigned int nr_blocks = sectors_to_logical(sdp, 
>> blk_rq_sectors(rq));
>>       unsigned int mask = logical_to_sectors(sdp, 1) - 1;
>>       bool write = rq_data_dir(rq) == WRITE;
>> +    bool atomic_write = !!(rq->cmd_flags & REQ_ATOMIC) && write;
> 
> Isn't the !! superfluous in the above expression? I have not yet seen 
> any other kernel code where a flag test is used in a boolean expression 
> and where !! occurs in front of the flag test.

So you think that && means that (rq->cmd_flags & REQ_ATOMIC) will be 
auto a bool. Fine, I can change that.

Thanks,
John

