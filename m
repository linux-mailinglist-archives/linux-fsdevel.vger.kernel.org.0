Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7476E6C70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 20:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDRS4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 14:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRS4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:56:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8109C6E8E;
        Tue, 18 Apr 2023 11:56:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IEwv1u016678;
        Tue, 18 Apr 2023 18:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jNFY104MjzIZPzqlHigvrVcLMLCmAtHWmHuWCMtQFGY=;
 b=qBNSSx6oUXQdgozl6WpJFcCsrCYp6Zy8t6h7c1f87CLoPbZdLDUh27Ub7CpZECKd0+Ie
 kj7J/3l9YbWTcKEBbQVaE0f87yH7EkWUOwlnaiHoNA9NQq6JLLp9WeGymf2ifjvdiMY8
 XGFpG0T5KYIc9BRvJzyBbXl7XQHs7/Fe2iwDJM2uNbflaXB74qECJP63N3aAjxdctypT
 9V8E3ZRC2pDGlvgi3TthZR01M0cIUNYYdTtb93Up/lP2lPGMOLfYovcILYCmvUNwcK+D
 uWe4KcPH37lrnXAl86G/Oep+ukcRrmpZq4D7ohxu4bI6wBi03IRbxz+9iZxqSi2kE5f5 5g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjq46hm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 18:55:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33IIrm7N015628;
        Tue, 18 Apr 2023 18:55:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcbya5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 18:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XluRJXtdV6Xts8enY3qTHeEpKC7Rqeqq64WYpi6n/T/Pkal5bzWjfJQ45UHR+dOPUXFJT6UWE8RTxnSkJ2Ge0gMsUh1JN2WuvlqvRu8x13hQ0/AxgA+RVHissD+XyUAdtWtE+Sp8jHzdAu257dtrWWzFrOZtY08ybFS4GDc53zoTAK8E38RmmmJz1YMyq/8Fx9fjnQiwTq77/bvj+hrma6U5pgcPFZVA8ylsd/d+7V9tPP98wE8I8dVQR9V+9YSa3Sn2QrOQqJTuKQHm7eZ5URtKSWWT6sslU5kVvuPY802Jvz9mlkfmGnCWeIEmZQPifcW77SiCnVLxWZ2xryB76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNFY104MjzIZPzqlHigvrVcLMLCmAtHWmHuWCMtQFGY=;
 b=NbaUMfTEEEKpFFjq6ZlbmRg/tYOEUcSMtWokl0vCNdLC+O8z9w4WGn1qhjBNfW++Brbqv1BdaFWdHQlCVgItvd4LXYjY/TRYjCXFdGo8en9sqjRRyLov2rbc2ySWK2msGWY7X8NFbTWJLQsR5JUoUt8QAhXouoJFdaQWF5n+mt5M/DHOQGVmX2wdwXDpurF26BY+Rwwqc9gSnAnGYLZrGz9bF9g6vIXXBJjbZn9fkjFKCiqQ5qaIbNgRiRWOR/E5XM1LwDEj6MzlquXy7LOqXb5sWWawPeSe9C21a0PdgARe6G/avt7dnW9RaZLPn6uMdrBrprnQqQ8aOZa9I1Bw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNFY104MjzIZPzqlHigvrVcLMLCmAtHWmHuWCMtQFGY=;
 b=BxHgxkQyBxQSjLFmoQR/faM2R/SJN8EGEAO1bUVscQZTZvB17gfJb13/p5vKkZ/f5HI2VUTeisv1oM6DkAi30jDhjjVB7T+WBh5PaxL+YuldfwCsEWaU9ZgfhkpWTihxWRJ6+OK+nn1NzcAgQhrLrnKS5jYRRVHRvf0K0kIU4ww=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by IA1PR10MB6146.namprd10.prod.outlook.com (2603:10b6:208:3aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 18:55:44 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9%5]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 18:55:44 +0000
Message-ID: <fe325e29-718c-20e3-c7fd-2b8b39e3d87e@oracle.com>
Date:   Tue, 18 Apr 2023 11:55:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Content-Language: en-US
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230406230127.716716-1-jane.chu@oracle.com>
In-Reply-To: <20230406230127.716716-1-jane.chu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:6e::7) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|IA1PR10MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: e216d809-d3b7-4062-27cc-08db403e8356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKNa0hJGlP0jhdXf25PzKiH/SfvGMFYPwcC6iv3/doKcacv8LA0wv1kO51lFVf09EygPDwap9TNeZ6HMvqryX8hFZ5YqxaQsJAagpKNlHMKi+tMzXIZGcGszHL+fUtiq+d4PMLMrMyEqtoM1KIzIORFSLWGYYke0kQTnmUV8uRDp4hQslzGTLrPmeqHgUUbtDjgH10xT2K+GplTCtWPhJ7fBHGy6oWaSB6gbpPulnKh8CtPEV0rsGxE8n+/9OL8ghUi9GBrcWGacuAmDzXd2WeG9BuOpQj7jWxezqbF7Y3gg56MpntQHxD/OwGterdXaRMfkqW8tCRcVqubUsTzf0kWgtqQvw+g0o91h0JeOf2GbDkAw1Hn4AdN01jIm5Ss+g9Wgj8fwNT1XHIEYK5l3/rkG0p25+4cHCVuWxa95iZnd4ztlOGyDP/7M8gl4OryCjzDODQRd5/eLN1gUtFtoCO0CWSda3+aXajmc6wjOSyh8/aq9uFNH09qCp9KnYIUKp+htjqoiQOseE7wf2LOBDglzPXSHr+kG0WYUz3Y6Td1HF9GOsBcUvEUoDMLQsw6z4XzBaz55XqlbXtKuhN05xMRgwfdA/SbOJ9Uvc0nO+13NBO/NxFZAqEujsjVfLESQ+qfhyI7GVNKHvnsJYSSvhlDUOpGDYuheBNO8Vd+jo94=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(2616005)(31686004)(38100700002)(6486002)(6666004)(83380400001)(186003)(6506007)(26005)(53546011)(6512007)(66556008)(478600001)(44832011)(7416002)(66946007)(66476007)(41300700001)(921005)(316002)(5660300002)(36756003)(86362001)(2906002)(31696002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW8zM0ZCcEZFV3Z5c1JhWlpPdWhiWVdCd25zMitPZk1kNnBFeFFOL2FnU1ky?=
 =?utf-8?B?ajltVG5sN3c0WGFDU294dklLempaeVU4ZW5rdWtISHhoSDJkZEJnaVE3VUxU?=
 =?utf-8?B?QVM2WHVaLzJKSzJRWjhTcE9FeFh5MVV3cmxOdkhzMG9NaDFrVk1PUXR4KzVU?=
 =?utf-8?B?Uk5sZ2k5RkYvVVl5OHUrcDVPYzArQk5lTXV3eCt0cytEN1dPdHR3YVNpa0Ny?=
 =?utf-8?B?cDYyb1kzTEhNMFlwZHBkNENFbHZBK2ZXVFNad3NLQzNXcDZaalowbnNuZldB?=
 =?utf-8?B?NzJuSlVlMDVvbzVwY2JhRzJxRWpOMDJmWVUwdTgyaEhKY3grZ3BhOE5yLzFh?=
 =?utf-8?B?STRGOWxMalB5S1FiOC9ET1d0b1ZsMTJwbFpqT1FzR0VlanRqTjdlVnRVWVYw?=
 =?utf-8?B?Vi9Qai9vbU9SYjc4NnYxVmFCY0pqc0NkOUx0cTR1V1IzWmZ3QlAzVHdlVyty?=
 =?utf-8?B?M1dzZnRJeHBTRmlFc1lXc00zdnRzNDh2MnJOY3F0b1lKM1g0RHlMSGUyZVlK?=
 =?utf-8?B?Rytjdi9ETS9TV3Rrei9kdlI3U20xZk10anFCK1Z4SnNPS3VmZUxCd1h6YUdS?=
 =?utf-8?B?c3J1dks1MVJkaVllQjMrejg4MVJBNm90L0tWc3Z0NlNWSHJFZnY5L0tuYWZ0?=
 =?utf-8?B?cW9wMnBIZ3BRcGJmUm9hMkhUTTZHUUpkSWRiM3ZlL0Y2MXRJYUdBb2o4enI1?=
 =?utf-8?B?aGplMVRGOWlmekdhM1ptd1VwSWdoUzhJZHV1aEVYZEtLKzR1dWNNQ1ZEaE5L?=
 =?utf-8?B?QzZGd3BySkNwRldhcFJCZ1pRVnVYU1RQVGF5aG56VjFYWkNMS3VqaWpvVWFt?=
 =?utf-8?B?aVpBRE40UGY5ajIrRGMyUEZiaGRrb2RjN2xTaEE2M3BHLzZQYlpLZ3JmQmZh?=
 =?utf-8?B?MFZ5bEpCYU9FZ0Q1c1FBUUhqNVF1TkQxMCtDbTh6ZlQ5a1NJR3AwWlMwQlpo?=
 =?utf-8?B?MU53dEZ3VTlTWVkzNTRvQjBZMTJmVUJxWGpMck1vSkYyelo0dUtXMGVEa3ZC?=
 =?utf-8?B?R3l0VDFGV3ZrZmFkbEdTZStMSkFsSk1uRSt1WGUrc0hLK21nNDlwcHNDdUIz?=
 =?utf-8?B?djZJQUhIOWQxL2dUa21vaE4yQ0VLMHNWVFZseWtaTTI4M2R5L05Ta0N5SHRX?=
 =?utf-8?B?VksyeFJyMUgwNEc5K1FIV0lQdEQ4SkNiMzFDRk5EUVdMQUY5U0JZVzd4eGZk?=
 =?utf-8?B?REdQeXFneStKT3VzY1ozR3pNbHhVY1duZ3hYYnY4QVF6M2x1TEFWT1NJU2dm?=
 =?utf-8?B?KzhDWjNSalFkU3hIUDFGaktoN1NyVmEwWjk1NFYzSThDZVVQemNTQlJ4Ykpa?=
 =?utf-8?B?RUQ2em9FU1EwRFNIOGN2Qk91RU9telB6ajNHQ2ZVZFBQcERQY3dsNTJGQzd4?=
 =?utf-8?B?cXFWME5UeHRMZFlLajh0WWMwU2ZFd1ZxNHBXSU5EeGFJV05NZmpRV1hRdFFh?=
 =?utf-8?B?UlNNR3puQXJhQjN6bjMweDFpUDlscmx6Q2tyTWl0aDZmQ0EySlJWMjQ2T1Bk?=
 =?utf-8?B?WjlpQVNHdWFneVp4UlRNYlFzNGNWblBLNmhmRWRxK0RUSDM1QmtjZDEwREho?=
 =?utf-8?B?SlY4L2R3d2N4RlF6SGc3eTNtbzhDWGdrbDVIQmVHOFk1ZUN2cHRWOER1OEFL?=
 =?utf-8?B?ZVhUUldTaHU4RkxxSjUzd2lkNjlVdS9TdWhVQ203RitHS2RVNHdENzNZU0ly?=
 =?utf-8?B?VzRsVkZnakc1VTlRMkZMT2tFb2daeHVnckVOWVBVWkhnVHpsbXl0Q3N1cE5I?=
 =?utf-8?B?ZEEyZGRZdUxCa0ZJeGxiU01xSGEzU2dYdTdQcytNRHpENmRtb0FCUU5jS2lH?=
 =?utf-8?B?b3JPeTduZ3NqbCs1dWhmeHVyVnVmeS8wbDB2OWRTU1FUY2EvQW44MlFjdUhz?=
 =?utf-8?B?cHJoL2wvVFFSc2RMSEtlQ3YwMkZaMERjMzU3NU1iYk9uRUdaV1prNy9PNGNI?=
 =?utf-8?B?ZkZ1RTV2NnA3bVBZekZUTWpISXd5WDdlQVl2YUJPbEFKQ3JNSUZoN1JLdnhu?=
 =?utf-8?B?UDczVzYzV0o5bmZZbjZEbmJqU05zK1NJMDlacVJranR1T3YyZitGb1l3ZVlq?=
 =?utf-8?B?aHVuMzB3KzhhSFlBY2ZMb0VTU1VZekVVTlZKVWJhLytpTzVaclUrMldIbC9V?=
 =?utf-8?Q?IaOpDZmnGHpsJdU81NDTU8rmI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VHFScjJjV1FQWGczQlFkRXZLZlZvVURvbUwrbDREMjV1akJ0R0c0VXZXZndY?=
 =?utf-8?B?MlNtQmJjNXEzNjdNa21qNmpNUWJ5OUhnaENJWG13R2xYaXFOTkRRZTN0VWd0?=
 =?utf-8?B?WVcxZk9peUZvc2NtSWkxbzYxNG1Yc1dpc3R0TS9OWVZMNWo3MWNkTGNpYzY4?=
 =?utf-8?B?YlY5S25rSHJDS3RZTktZQXFMSStQcnlRcFc3ZTJYSzRMNmVxcEMxeXZhazZV?=
 =?utf-8?B?UjVlNHVrb3BLdkJ3RVNRQWlTKzFUUU1OQlpxRkhqMmpxc2pjeWhvN3ZFdWlr?=
 =?utf-8?B?Sy9SNXUrOXNQMTFoeHlqVU4vWUgrRHV1OWlGanVnUTRTM3hKa0Q4TkozWlhB?=
 =?utf-8?B?cWZsc2ZxTTFFQkxxbkNJQ3BPMTMwVDZob0l1NmhIRmpUZWVhWVVtRVhLTlN1?=
 =?utf-8?B?cDVhNlF3V29WSERGSSsxVkI3R21FanFRM1kvSld0cXhadlViVmVWQWVKYzJC?=
 =?utf-8?B?NG80cnBJUHNRZ1RLYW5pdS92OTNKL2hkdGpvNDlHdGZvY3BOUkVkc2tVdEx5?=
 =?utf-8?B?TyszdFE0SUpFVWlWd3BkSHBZZGd4RUt2WDMxTjZ6QVRJWVIvc0tTSnYzZTlW?=
 =?utf-8?B?anNsSDRYSU96M0p4Q3ZVdkV1M2xQdnVqY01VUFFkTzVSVUk1ODgvSGlHMkM3?=
 =?utf-8?B?SHpkMnVKZEUrNk53ODFoVjJvbDVGTTFxVno5L3lrck8zOHhYb1pTSXpycmZJ?=
 =?utf-8?B?M2hOckJFZEV0Y3hVT2k5clI1bzNTOURJNmMwY3NDUU1HRjl6WHQ0UVI2UnZu?=
 =?utf-8?B?bjRMNUdkbVNTU2kvbGhzWlIyRjdVb1BKRjJFSE5nQjkvejVseG5JZlUyYm8w?=
 =?utf-8?B?U2hoNUY3blZIa09TRXJjQXgvN1RiaXVJLzVpQXk5NS9yZVN1NlAzckZCMTVz?=
 =?utf-8?B?dWJCS2J2cVlZYy9XajhYWFBucTgrZWV6K1RhN2hGRVFjaGN0alVzU25pMFlI?=
 =?utf-8?B?THJ6YU1Nd1pOMjI2eW9OSlJsT0JqL0FkUXVsUG51V0VYV2YrMFFaSTF4SXlr?=
 =?utf-8?B?Ty80RzA4ODhCb2xCcjUram54ZmUydE80cVZINUQ4RzFOVTZvQ2pjaVIzZnJu?=
 =?utf-8?B?b1JNYnZUbnYvRXh0cHZ5MSsxVUROSXFSVExKMUhwREtMU1EwRmxsaU5QMWpC?=
 =?utf-8?B?NmJtVHVpZk5VVkw5ZXRmM3RFQ0tVN0JBa2tFeUp1ZDVMSGxlY0JrRnNib1kz?=
 =?utf-8?B?RmUzZmNZenJtNGFlZFdxOFErZzBSVHk4M2lkc2JGcWxjYmNiTUExeHZBUDlP?=
 =?utf-8?Q?J6cub2JC7umScFd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e216d809-d3b7-4062-27cc-08db403e8356
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 18:55:44.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+URBYqVc/GCJvzfjCTIQ/iKnEM+YjRfQpV5ClCcB0AWaGqsLMJlrxiK7tCtkv9fT5aUXGuNcs9q/TkqsIlTaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180155
X-Proofpoint-GUID: RU0yuzjikxjNi2ra7nPGadR7wXQ43Ydu
X-Proofpoint-ORIG-GUID: RU0yuzjikxjNi2ra7nPGadR7wXQ43Ydu
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping, any comment?

thanks,
-jane

On 4/6/2023 4:01 PM, Jane Chu wrote:
> When dax fault handler fails to provision the fault page due to
> hwpoison, it returns VM_FAULT_SIGBUS which lead to a sigbus delivered
> to userspace with .si_code BUS_ADRERR.  Channel dax backend driver's
> detection on hwpoison to the filesystem to provide the precise reason
> for the fault.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>   drivers/nvdimm/pmem.c | 2 +-
>   fs/dax.c              | 2 +-
>   include/linux/mm.h    | 2 ++
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index ceea55f621cc..46e094e56159 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -260,7 +260,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>   		long actual_nr;
>   
>   		if (mode != DAX_RECOVERY_WRITE)
> -			return -EIO;
> +			return -EHWPOISON;
>   
>   		/*
>   		 * Set the recovery stride is set to kernel page size because
> diff --git a/fs/dax.c b/fs/dax.c
> index 3e457a16c7d1..c93191cd4802 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1456,7 +1456,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>   
>   		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
>   				DAX_ACCESS, &kaddr, NULL);
> -		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
> +		if (map_len == -EHWPOISON && iov_iter_rw(iter) == WRITE) {
>   			map_len = dax_direct_access(dax_dev, pgoff,
>   					PHYS_PFN(size), DAX_RECOVERY_WRITE,
>   					&kaddr, NULL);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1f79667824eb..e4c974587659 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3217,6 +3217,8 @@ static inline vm_fault_t vmf_error(int err)
>   {
>   	if (err == -ENOMEM)
>   		return VM_FAULT_OOM;
> +	else if (err == -EHWPOISON)
> +		return VM_FAULT_HWPOISON;
>   	return VM_FAULT_SIGBUS;
>   }
>   
