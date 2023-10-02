Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB7C7B512D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbjJBL2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbjJBL2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:28:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3547EC4;
        Mon,  2 Oct 2023 04:28:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3928XRsj027190;
        Mon, 2 Oct 2023 11:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fTsFE65Qqo9kf9S3JemLw/SvWxlqdv6wpuCWs5t/W5k=;
 b=v8DZXLIQSJGjIUkJJnNzOyJGC/EiIvwyuzlKppf+eaQWG1ZZ3F/MW8sd00LY9lklgGqV
 2ZmU9wirlpTx9sz7mhEaB/9m2Z6+Wk+nf87PCIGmYf5t5N4kiDOHlDqjXGzb9gqBqUBh
 ISIZQJy/QpmzrbibcnILDfL0G7N/IKY/P7M+fPpvx8O21jPqnCZlTzm4AgPcy8RV4Jfh
 ywwJwpErtKsqoc+JGPSoMICSmjJy1mCBOZOobX31LvyEzl14vqNsM4tbJqQCMG++o98R
 pGCbaGmQrnNXl5SqVy4L2Q+HVQXIUdsO5dzt7sJxL3UkQ4NlcmKWem3LGNTH/wsS7flX ew== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3eaa71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 11:28:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392AWXf0002983;
        Mon, 2 Oct 2023 11:28:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea44ehpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 11:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB8pmx8YkAG9/uXzzEo5DRZXu+JaxRE8/O+5C+jtZ04vAAYvfHj4d6EOYlWpQlH/Hl+TVctgPpWNW9/rWJyk1oN/dlUdE0Fj8dTJDFvuFIS6iXpy+zbqIxfNxpLlT2ENbEAvpD2p9vWCJvnY1Vgey6+yg4NkA2/hceXIeDqnZ6WEz8U3iJFwYOPp15pvqD605gPWGSgkg99FBJtFXH7otuYyF4dVA8f4TPIz/vpfrqQolIt0CDHK1+yVFTpBhYVmTK4LeZyYk3RsX9/HPEOQ/8wyvzoLX4U8gtid1KwH5cgl+RS/sW7Lzmqb5srWMmgdi2SdigFo+sq35DUTBdMPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTsFE65Qqo9kf9S3JemLw/SvWxlqdv6wpuCWs5t/W5k=;
 b=MieB7lg5fN15NcyLjKdgJwsZ6D9saeV/nZWmrPJvsFKO7UEYHfvx25T/kmJEE/Vc5U2sOQhX0j1CDta83iOFPl12HItRksnZACS5/unmJ34O4nQVfsXc8f2jlZJUQfK0wbSQCgZv9MbDM9mKrcJoN6oj0Atr0yIuwhRBRQrtbdq+MVvDL9E2U7dNM/YwPkX0SSnKyzlRxHrY7o+F9LeyB8sj/UpEK+nwed9i3BmrxT4lRHMqVnBiKqngCUjqGAL9z5qdpIsFy9zoqZx980orr4fcTVUWFYcr4OK8gQusF7pqCL76kPLn9wsViEIChp3GgcTgt/aRmctH1Mn2mfI/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTsFE65Qqo9kf9S3JemLw/SvWxlqdv6wpuCWs5t/W5k=;
 b=v0iiAw+Dfrp7t2xx5MoP+gufqjXNcZKILEYhDAK+t0skgZcAMWkCPnvvojWTvQiXerAbqsDYLDgVe9zEcbIufwZfqH3/Q+d5osseFwbSogl0iYR3IHkUyYRNP/P5RBMpCc7VGrlCbJtQaGux2oab+1iGQV2vcwWzxjVQIwZwidE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5545.namprd10.prod.outlook.com (2603:10b6:510:4b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 11:27:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 11:27:57 +0000
Message-ID: <53bfe07e-e125-7a69-4f89-481c10e0959e@oracle.com>
Date:   Mon, 2 Oct 2023 12:27:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 18/21] scsi: sd: Support reading atomic properties from
 block limits VPD
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
 <20230929102726.2985188-19-john.g.garry@oracle.com>
 <2e5af8a4-f2e1-4c2e-bd0b-14cc9894b48e@acm.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2e5af8a4-f2e1-4c2e-bd0b-14cc9894b48e@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: dadf3fc5-f6b0-49b1-ea8b-08dbc33aa0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yujYg2Hr7w9npnneHZn9l/1edxAYSquLXONLr/N2EjBW/eWerYhz1L6W0zSBxFZcvd2fGYMTE6DHF4OaaWn7uXWUt1s2kUjJyIHU2l83ffrM2dX1PCYsRtpS6T3F/xxyEYsVJlgfP2nWOBDKQJLmJmQ3M0IyAuSOAmqO5t6i5ygJvEChicRjQaIVfg8FUNuIx9DYJOpwsdYWj6MNKsRFwlPnE46C2d9sPJLes7h9qxLw5WYJReeQLePFpPR5NSSFobpyv3pSrmR78Mj3ifRI3SkhCqVmG2b5ZYwpETqrgIFDzzIQKd1TsaBIn1f4wMaCoOdjjovuzzcuHmUMbZw0hQl2exxjGgwPocV7Ao/O/nXbn8iMSme7xncWTqRi3vTogvFMrmMoOwRCDMWxKfZwnO9n+rd5ruY7SHU45eXil0F6cdgXxnW8NQkHPa6872Sg0L64xj9s5EPgOBHgAt4d+wcInKsaRxOtSGpmnVmCFRVZqCz60H41WNHR8OxUEoGHGuWEr2SMbqcAOzEIFCEt1osl8Zod8JPihlc9yW09uWSRrr7CINVA5M4GWdEYKy7tL6uxgGPDGH+geAPcXh+RfubO1ajJGMevEne5NBAI+zz/d63rCoeZVUyPcOi9T/RQK5/WB2zAbJqoGPLgLOEx/g3Z61LrRN02FOg5WYP/r6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2616005)(6512007)(53546011)(83380400001)(26005)(478600001)(36916002)(921005)(6506007)(31686004)(6666004)(6486002)(41300700001)(66946007)(8676002)(66556008)(316002)(8936002)(5660300002)(2906002)(7416002)(4326008)(31696002)(66476007)(86362001)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJYSVdvWCtvWnl1WXpzbHk3bElWOGRnQmhOSjc3MTJBTXRPOFlMakRmckdK?=
 =?utf-8?B?S21uSWdsd295REpEN25CZDlIUmJoUWViZlNiN0M2NXRrRUppTjFuMHpnaDd4?=
 =?utf-8?B?YkVFL1JHaFVqYkNweVpieS91anc2ZkxHamVNSk5HcnM3bUNWeTV4UGhmdEpP?=
 =?utf-8?B?ZE5mUEcwVFg1MUNpSUtCazVwQ0RSeWgyeE9DeE11L3A5OWRMRnRnbUs5T2lX?=
 =?utf-8?B?M3V4N21BNlRsYkhYQUdNNmlNTkVsbmhmTnUrc0piOS9VWkRnWFlOejlZdndi?=
 =?utf-8?B?emV5eUZkUUJiait3VjhwQzd2dWcybUNOeEI2dmZGRG1sV0pOVjlGN0l6QWxn?=
 =?utf-8?B?ejhoOFVqaG9jdXd2aXErSlV0endSZEo1V3BtOW4zTXdlb2tCUVVBZXNrK3E1?=
 =?utf-8?B?OGh2Z3dEallFVnBVS0tBWGNSTnNYVU9WRDkySndKekpTczRRZzVCZ1VHb05H?=
 =?utf-8?B?bDVLTVM0U2FGd0JOajFTUjN1Z2hJOUgzUG5HbmIvYVE4OU5RaDVnUG0zNHVl?=
 =?utf-8?B?TEJSanNDUzJxaGFjV0llQUZXZE44UEtmTHhIcGNNa3Y4NWo0TGdHS205WlRk?=
 =?utf-8?B?V0U3aGpXeGMwY016VWVEZEx2ck1qK0NuY3Ewdk5FeGZHS1hMUndlajY4TXN1?=
 =?utf-8?B?UEhyU1ZQOGZIR2Z0YVpISVhCUmxacEZCcDhUd2I0S0ZuQVJlbzZUaE44d2pY?=
 =?utf-8?B?dW1HcVdOMDBzN0d6NmFhSjkvZldwVVJiQVgvVVB1WGVQWXowcHdzdWdwOHJT?=
 =?utf-8?B?b2p6UVpvNnNsMGFNNEtOaXFxOERGRmFEWDF2VHZUZkg1VUxseFc2WDdFZUx2?=
 =?utf-8?B?V3NsSlFrZFVZM3VxcDFRVVBjRVpFWldKcjJtT2EzZTl0b0JPSWlNNXkvQzh6?=
 =?utf-8?B?STVIOHF2bkJMVXgwZFczUWdUREJQYklQcmtBaHJDK1l0L2huelhVM0RxRHN5?=
 =?utf-8?B?N3N2by9VVThVcFhPbWlKMGFrRnltb3pPK2RvWDNKWGxHS1VZWXJPREtFZjVY?=
 =?utf-8?B?Szc3RDFTV08vWTlLaWlKcjVLTmtYM0RKWVlVT3Z1MHVDVVg2T3R2cEhuNFFs?=
 =?utf-8?B?eVh4bFk4YkkwNVRMbExtTWN1aW5xNHo3amZ2SDc4Q0FLR2JjM0lLN05HK3Fa?=
 =?utf-8?B?MlFrdGFkNUhYcHVxTHp0VVdnT0pVaUw1WmZoRjR0aEVnRWZaUDJMREtDNUcy?=
 =?utf-8?B?NlVvUFYyWVkxL0V4dG5jLzFjQW5kanNueVJVbkgyeEIwd2RqVksyYTc4TDcx?=
 =?utf-8?B?N0RobHRRWUpxcUNvd1lWYWYwYUgvWDBTcFZWMnlWc3hadjJZcEFGNkZ2ck9T?=
 =?utf-8?B?d0RvZUh2bTZxVEYwZzRiVHRKYWZOVkFNZHhtdkordE5NNjVxb3ZJWk1xNHlt?=
 =?utf-8?B?MmY3MzROcGVlV3RXN1UwWGNKL0Z5bE9lS0J3TkVYazdpQUw5TWVYS0pPbEdU?=
 =?utf-8?B?TEhnMW43NGluRlZQUlhoVVoxelBBazczdmpDVDBxSWVmZ3VSaElabTd6L3Nz?=
 =?utf-8?B?WnY3OW9ubnRZcXgvSWdMcm1nZ1U4aWpXanV6OWZRZElNaUk1MituUmZHRkts?=
 =?utf-8?B?cis1NWxQUzBnTTZhblBwbnFyWDd1dkwwMGdPOHJFNDhIbmZVdk1lbmwzalM3?=
 =?utf-8?B?dFZyeWtCRVVzRzdiSEZNRzJIUlZHcmJYSENIY0Jsbzh6YXlKd01zMWx4VGVK?=
 =?utf-8?B?Mm9mSFNwV0s1R056aTNybDlpYmw2SFRleEdXZGpJaGpxcU9yMmxWWlhPVjAw?=
 =?utf-8?B?VkcvVTlRQ1BtZU0vSWx1T2lHZGxxRUtGZVdxOWIvZGkrd2xvUnJPRnFiSFgr?=
 =?utf-8?B?alNwTFRFdzh1Qys1U0hrRG1xc3JzMzVvSU40aXNiUDA0cVo5MDYrZDJKaFdo?=
 =?utf-8?B?WHZ6U2RvbzNySk40bmhDb0ZtelVVbGx2WmJHV1dBZHQ2QmJXbExIWk5qaWRB?=
 =?utf-8?B?QVg2c29KcDZSYlZ1b2Z1bi9qRCtwSkJJZGwvV3BuTmxkVnhHeHN5SXlvK0o4?=
 =?utf-8?B?L2NLbzlMUm9Sa0U1Zy9GVExJWnpJbzFMMkxJU2paSmQraCtnc1haUzRMODY2?=
 =?utf-8?B?bnFUSCtqalhHL1hxazBFL3FMZHM4OE1qNjc1Zmd6YVZQSjZsMTIrb3VreWZD?=
 =?utf-8?Q?GydqrX1smvOnMIiOItrpKNXpP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V3JBNnVrazNyNVVOUXgwYmYzamNwcnpqVWVNclJnVWpmcmVoQU9raDJFU3VE?=
 =?utf-8?B?SSttYi9BWWo2UTJBSXVzeFFzUGN2ME54OWdJMW1mM2VDVTdGWTAwcGNiZ2JN?=
 =?utf-8?B?TlN3VHZNeGY5TVY4dFFib0g4S3Q3Y24xb1kxSUpON2pSN0pDbDhRVWtCRi9O?=
 =?utf-8?B?clovSlViOUVZaitZdVMzZjVDTHNOWjZITWxsRThwbkVZNEprK0hwMHJRU2I3?=
 =?utf-8?B?b2tzQjFiKzFiaTR6dVpxaXk1bEtiZzJ1SWNpUlFDVFhJWEJUTzU2UWUvOXBu?=
 =?utf-8?B?d2w3MTM4cUlUdktuRDAxVUtqb1lXdUw4RitQTHZJOHJYSXZoSGZlSzRVNGM5?=
 =?utf-8?B?SmdieWNtaU5LNTZpVmVIUThOOEdjYndhOTFiQkQ0Q2dsb2N2Uit0d2k1aUtJ?=
 =?utf-8?B?bkRodVFGaHJkSXg0SVorY3V3RktmaXRpVnRKa21KWkNPV0tQQjlmek56Sndi?=
 =?utf-8?B?Y09wbW1RN2tqeENTZzBWeTR4VCtrQmZvVVhCY29Wc3JxVXFpOHY2WVErM3Bn?=
 =?utf-8?B?Z01MRkcvelhBa3ZodFB3NmpYdm9oQTUwdkZraHplMFZqc0pTcmUrTkF5Y1RS?=
 =?utf-8?B?azFNK1puN0VKNFhZVlJJQ0VZZkk1OE02OVNTNTJ2bStKdVF5ek0vRlRBbjJ0?=
 =?utf-8?B?NG5wbGhLUjhKUkhMOWJ6V1RCcFl6bnhiNDFMWnptSDRxTlNEeUcyUG83dU1a?=
 =?utf-8?B?ZlFjdmNvM0QvY1RBNzRTb1A1UC8vejYyWTV0RWZyWFdUMkQ5RXVzdmllVSs3?=
 =?utf-8?B?bWd2SG9CU0lETjZqZjVtS0g0K2FuZGN5K3A5UThVVDU3Nk9nQzUzTS9JbERF?=
 =?utf-8?B?Q1BDVjRJWXVvRDZ4T2V1RlZwQ1NtUjJ0WlJYOFJOWEhmWURVa29qbWNxSjVl?=
 =?utf-8?B?Qy9BRUtMRmhDR0U4QlhuT2diRlNzS2QyamRrNklTczhLaTJFMzluOHo5M05W?=
 =?utf-8?B?dUtLM29SQnhFUG9rUmg0c25nZjRjVDRjb3FFeHVCUVg1NHJhMHMxbXo1QkIv?=
 =?utf-8?B?dk91QzJDR2wvWWc0SUNzajd6YXZkT2c4QmZqaHJVcklZcFQrbmFuZ3E3SW5U?=
 =?utf-8?B?QmZQWWc5bWhIdENSck1UMGNwWWFlZzVCNWpFaC9EMUk0MUY4VjZBQXJqb1BE?=
 =?utf-8?B?VTJ1clM5YkRRSkdJQXU4ZTNpZTVtWXZiTmVFQ2dpMnZrY1M0QXQrM29FWktT?=
 =?utf-8?B?RG8zVGVvekJjbjVwcFFKenZiZnZRK2k5ayt3amIyYlFhK2U5REJaZU9JZmU2?=
 =?utf-8?B?dStURGFZTis0WEJaZTNhdVJ4dlFadkZ1M3FNZmpETEFSYTRMdFFESzFiZkU1?=
 =?utf-8?B?NnIvdGRsaFpjSk1DWkVYckRoa3UyaW82MzluZkxzQ25CeVpRbG9GbmFWUWlL?=
 =?utf-8?B?S1kyM3Y1bTBaZnpYblorV2NNMjhydjNWMlBZSmxFUzNxek1acFZKb1VPRlpF?=
 =?utf-8?B?VVVZdzRFT3pkSm5FSkwzTVdOUy95dlhIREpDU2dKMTl5U2xSVzFjNThiVlp6?=
 =?utf-8?Q?EdamTY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadf3fc5-f6b0-49b1-ea8b-08dbc33aa0be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 11:27:57.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hq+w2h8jzV5v/pIf1aZngSpq6sZEARY0LhHLjXuPRCzRrRCFvGyUDrV9kObVHBf/Ih0Lu94h6zO2pmhAmNFRNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310020085
X-Proofpoint-ORIG-GUID: vBVFSWv3Uh-4tPTACfp_glgkK7lp34ou
X-Proofpoint-GUID: vBVFSWv3Uh-4tPTACfp_glgkK7lp34ou
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/09/2023 18:54, Bart Van Assche wrote:
> On 9/29/23 03:27, John Garry wrote:
>> +static void sd_config_atomic(struct scsi_disk *sdkp)
>> +{
>> +    unsigned int logical_block_size = sdkp->device->sector_size;
>> +    struct request_queue *q = sdkp->disk->queue;
>> +
>> +    if (sdkp->max_atomic) {
> 
> Please use the "return early" style here to keep the indentation
> level in this function low.

ok, fine.

> 
>> +        unsigned int max_atomic = max_t(unsigned int,
>> +            rounddown_pow_of_two(sdkp->max_atomic),
>> +            rounddown_pow_of_two(sdkp->max_atomic_with_boundary));
>> +        unsigned int unit_min = sdkp->atomic_granularity ?
>> +            rounddown_pow_of_two(sdkp->atomic_granularity) :
>> +            physical_block_size_sectors;
>> +        unsigned int unit_max = max_atomic;
>> +
>> +        if (sdkp->max_atomic_boundary)
>> +            unit_max = min_t(unsigned int, unit_max,
>> +                rounddown_pow_of_two(sdkp->max_atomic_boundary));
> 
> Why does "rounddown_pow_of_two()" occur in the above code?

I assume that you are talking about all the code above to calculate 
atomic write values for the device.

The reason is that atomic write unit min and max are always a power-of-2 
- see rules described earlier - as so that we why we rounddown to a 
power-of-2.

Thanks,
John

