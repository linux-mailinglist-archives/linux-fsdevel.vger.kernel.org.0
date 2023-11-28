Return-Path: <linux-fsdevel+bounces-4016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F45D7FB4FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 09:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98228B2174A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AA33457D;
	Tue, 28 Nov 2023 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dFZ+dvmh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O7CoGlpS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F59A7;
	Tue, 28 Nov 2023 00:57:09 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS8YBCb020856;
	Tue, 28 Nov 2023 08:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=J3SV7koUqNwnstklPVEKbZdt7Jahxpt5hhW43yeCf8Q=;
 b=dFZ+dvmh/qvxoDtL8ZxkhCqagJpe9tEL83VAGi2WnMMVi2SghvRQFzlPNYoJAMAR5LZ5
 Quzn6E7+lqzyvrm2qiFU6qGEtsLR7LFu9EblEC6ACqdT3yVX/8Fphde1Drkjgj6knQBv
 FQrMW+XvSOLqnDv9d30lQ3rZRgI1q33CTeFjcfzO/MQWwjIlOsIsY9uBLLqmicR7u6tr
 GaZgm9S7ob6WZqVyU8GkiQV5IYQT6QisQEMYeV30mtLWXG99cagDYbXZ0I0d6M1Qh+0H
 T0upgVIJn5u1MVNv0SzVUlvp8QY0OEWVjbzNsOOp6okvKd6Duccef6eqA7zSUf3tTFbJ Zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7h2n515-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 08:56:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS8TvxJ027045;
	Tue, 28 Nov 2023 08:56:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cctbn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 08:56:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqnIgQKJ4n9k6hwmWDQzr4QGhfxXVZE5ymoNVVCRsT1ae5pJ7C1TFwtZeOBx5TEBqER+jaUBg8lgngvP0ubPC1oIdqIGN3HtS1Ak3h2IcG7zhaT0PZU5nsdD+IcMhMwg1Ze9ti5sTWg5bNr2ZAL1zmfd5XLtXFCxG1e6MaRqAtJSHLoawWoUNQXaYMZqfIUQwqHV0+TCG+fHdOngr6fiKFbagPLGADlrF8aZ50evvSqpRjr3MaLV1r4nn/EJ/oF5fn33gWxRZJL4A8/URof4vUFS54OSdS66B/hTAe7JrNzLcYn1z6TbkfwjKeO3Wn9GUkGA8PAM3ytBKA0VufDi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3SV7koUqNwnstklPVEKbZdt7Jahxpt5hhW43yeCf8Q=;
 b=D3hXCPNqRHObY5L0P0crTWIFqxJMe9bcr20h8KRkp9vKVwbikDCBYB3lkYUXNrSCWYN7QZIoNFiW1AZCs4B61q/SRqVpFdFchRIvBxfD6HHGuultKUSwb7JtFzITv/6A+UPJJ5IhzSm+O7zLDaTVBF/iCG1gUPf5BWSb6/vf0za5FJmuwsEoTLjxDWV9M8CzuVEcIcMao9VNykWJQpLoP+yommtEQ1NXC27qqd7HWVfcJYiElBBly7E7HLwMkgVXj0XtdTJO+ouu9tXQoZk4IOdYTllxBgOYEFVCutEh/RTOZqpNPoy2PKQnxW6hEd2GnwQKXQ0FMMoH7ST20gcmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3SV7koUqNwnstklPVEKbZdt7Jahxpt5hhW43yeCf8Q=;
 b=O7CoGlpSmB32AJp83ZKZDehWNCTQ5n9H4779Be6BlxtONKcX0UeUyrmvFevVui7txNX7ZqvH2At/gi4Pd1wLHYipgLQJ4Z8gnFeVUgBhPw5dWVQeTjwIsVmY3e7ds8VFWW5uCfzIHz3I41Oc4iWtOL5P4wy5tOGuQsDV4YzJbI8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7376.namprd10.prod.outlook.com (2603:10b6:8:d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 08:56:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 08:56:42 +0000
Message-ID: <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
Date: Tue, 28 Nov 2023 08:56:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
From: John Garry <john.g.garry@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-18-john.g.garry@oracle.com>
 <20231109152615.GB1521@lst.de>
 <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 3350faf5-023f-4092-d272-08dbefeff0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZGE6R+BZ2kneu8+xiaxFxBurLuIG3bcuzv9eFJDArx7hghd5qSqTcxwvX9gC5km1bu9JXlRyRiCWazRyKeu0WX4AccWFOg3zKT46C8XRScEyTNeYTsyS8C2fo+IeitSuwyzDGRn9BKMjf42IySTB2O/nslPRNkTUWhG2cFKZ9i15PDLNCICnSLSAZr/VYYvH5aoaeoWAtmy2q/e873rg9x1TJGw7Fb08Fowl4dMULVL4XUbBb0bMmT7kyGDnsSZVmuS4WZ9va5uTdcHFV4vtOwQ1ii8ZysJngrYt8W7kA5JxSabAwcr0GBGYxYsXzrH3LiZPIvs44zps+xrqJfSEPD+AwLCZ5zk5vU6RRj5Q8BPo9B/sxwhUwv4FwxpyrCgR/sdr9V/aJhfHx1Xbyds19JLck/vRoT7tTFMg/+21H5971yFyo/PJ2BCweU/WZCH2v13Wj6Bc3bXt+FlQDwVVLTdg6zj7ID0cyITyW32rGnPdbWSYX0P5421V6zXeITdZPbgHFYiK0h9tffBWvx7rY6sFeu5Ye291WyAi2ThBhiC2IJfNrO1EX9rljAddjB9geLrPhSY84o2XPkI0ESXPncwF5fESezZqga2i/EfwCzAIAqxqqLxaKWCuYeL2mbsGN6om7hPh9tsAL45ATpo8Kg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(41300700001)(36756003)(86362001)(31686004)(83380400001)(5660300002)(7416002)(26005)(2616005)(2906002)(31696002)(6512007)(36916002)(6506007)(6666004)(8676002)(4326008)(8936002)(478600001)(6486002)(66556008)(66946007)(66476007)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UjVsYzBkdERlRUZ6dmtmb1RtTWNJMUc4NlZVb1NDa2tvM2Nad1dOL2hhclps?=
 =?utf-8?B?S25HcnlnNDZ0WDB0bGVPVURtY3l3R3dYcEN1cVBMZkxxS0xiaDRBQm1Zdnpp?=
 =?utf-8?B?QmthYytDeGdJbklrSzd0bXJTT3ozZ1d2Rm5aTWtvOThMaFc0aHdLZlhtOVUw?=
 =?utf-8?B?alhkSVZFbUNtOTJTUVRRV0MvSWZza0liaXBvcEd2SFo2c2RVbWprVndrOVpO?=
 =?utf-8?B?OWRDeWRTYVIvbUpmU3g2ak1CR2lGUTM5Vm1nb3Q2MGZITXEweklzZlZhaFRm?=
 =?utf-8?B?RHJZdWI3VGtHdVJpK3hVOVNnVlU0TUV0cHVzRUxZaitlRGQ5QkMrdWU5VEZC?=
 =?utf-8?B?ZmlwN2c4R0t6dE10WE5vWHdrRnZEZlphdUgxZGVnQW9KVkM1OEJGRFVYbEtL?=
 =?utf-8?B?WjFXaHJDU1hKVjJmTklVQXhoajBjMXE0ckd0WHhsbGpqNWJxaUU2eTJJUGNs?=
 =?utf-8?B?UWdNbHBqQ3BFWENCOEhyQXhxS0lWTEFidTVKYUNqSy9qYzNsMlhsbzFtVElj?=
 =?utf-8?B?R3lKeU5jNWJrRDZlYUVza0NqS0hSandPWWl3aVV3YkpnUFRBdEJXaWJvaEJh?=
 =?utf-8?B?eEVsUXViMGEvTFpFd0hRcU1pSVZJQmxocmFlQVFHOHZNUW1PVGJ5ZHFKTzBj?=
 =?utf-8?B?ci9pTFA0eGU2aTIyVlpUa252S3YxME5MN3lpRGFIWkNicXlsaEluOXJkdDB3?=
 =?utf-8?B?QTJQUnMxZUNNYnM1V3p2ZGIvY2FzN3RodzFKUThOREd2RXJyMTlpUHhmd3Ft?=
 =?utf-8?B?RENhUkFvYlJkNlNnT0cyQXg2VVNWVkc5OFRiSDg1REV4NlkwMlkvRHFUK1Nj?=
 =?utf-8?B?TnZSeVd1UFF3R2dEVnQzdEJ6N3NXUStiYTEvU0NjbFJUU3hZWlFXQnpXR0du?=
 =?utf-8?B?eG5UMGFPYkExVkR6akpBZFJIQitWVjlTbkp2eXFyUEl6cEtrRk5wK041MWpV?=
 =?utf-8?B?bzdUOWZuVW0rSm5kbFhjdGF1cnBmWWtKTlBqSlNUNkYvd0hlNzBRYXBqNmJQ?=
 =?utf-8?B?MXdDYTJMb2FNK0R6QWE4UFdEQktEUW5iWlhsNVdDamFGRERyTGRXTTV0SHZY?=
 =?utf-8?B?VGJOaXM5TUtHY0dodGpwTFozemo4VVM0L0puT0haRWNWclRKRzVmeUN0ek82?=
 =?utf-8?B?elNaTWttQlc5OUY4WWtCeE1DUzhNT2xGQXJOWmN5MW1jUllSMWNJcGR3K2Rr?=
 =?utf-8?B?eUErWk1HSTRtaUdpRmU4WklSY29rM3VYcGIyQ2c4T256TWt1Z2x1L2dDSEdS?=
 =?utf-8?B?SjdWM1JzcllwUmJXUDZQY1BYMmhieGViaUVkUE9TaEJrL0VleFJkblhBNXZi?=
 =?utf-8?B?N0MvMzVvdHJ1RkFML1BmeEhYQThSUlZCSkowS251ZUY1bmhrWU80ZCtFbFk0?=
 =?utf-8?B?Uk0weXdvU0dKN04zdzFmRUpVeUV3WHcvTitNeHlic1UvYXgwTW4wekFVbWxr?=
 =?utf-8?B?cTZzZFlUZlRHRVNUWHN4VE12dUNnWUszS0lZcnBORDZLM21sQnk5cXYwcHNC?=
 =?utf-8?B?d25KVHBGN0NuZWYrU1hRRHFKZHRYN0U3RG5BS0xYYWlndkpPUVlKTWVHWXVW?=
 =?utf-8?B?UHhjb1RRYlFrcFpaV3B3SzlHalRHZkNOdW9NTHVqWWk4enpjZ0o5a2MxTFdi?=
 =?utf-8?B?RnZvYnBmQURmNlpmQnVWeDdia2NFalhkcklkY0RQcDkzcjErSmdDWDJIZXFU?=
 =?utf-8?B?YWhIakpFczhCRFI0V21WN3dML3ArdVczZ1ZZK20vVVl5em9WS3FiSnptc3hX?=
 =?utf-8?B?cDRKbFNmRGhveVlUK3BQb3UxU2lXb2x3OHV0dVhRWENrbVV5b21FdzdrL3lN?=
 =?utf-8?B?ZVFNc29xZUhQRmJXSVlkbHNHT2xSaWIzZjRzenM0WU1zUzFPZENFakw5SG13?=
 =?utf-8?B?bklDclhzVnZSWEQ0SzNSN0RvYWlqR3VrTnZ3NldKZWxZdGRWSkRaTjQwUHFE?=
 =?utf-8?B?QlJWUDF0aFEwcDRWV0RQZDRxL1Zab3dXZFh4OHl3Nm56cWM0dmFmZlZONWhR?=
 =?utf-8?B?WUE3NkJCYnRncXEyYjBHYWxJaVFWSmxLTzBjcmxscmRzTnh1S24yWFdWREFn?=
 =?utf-8?B?K0w5ZVNOUUxtdCt4bTcrVm0zUi9EU1RxQ1lmUHF1LzZ5RkZURnM2VWh3cUlt?=
 =?utf-8?Q?vIs2pH27IIXhvTq5AHcXe+vCN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RjhqbjZNd3lTSnFBUENOaHZhbjYzek02T2hPVCtlbVBxQ1ViZ2tMN2pvdUxK?=
 =?utf-8?B?OW9tT2szVnZ4NnduWGV1cDlkU3psaXFGNjhaUm1vL1VWUDdvbW9LcUxSTnRs?=
 =?utf-8?B?UTJQeUxiMmJxTXVVR1drRUt4TDRxbG9WWkJDNm5SOWpPV3RjM1BUK3ptUlFu?=
 =?utf-8?B?UUVLYmtyMThvdzlWRTcxdkpxL1VlRUxZZ3BGc285V3k2TnVQdDJ6cnl1MVli?=
 =?utf-8?B?eU1GdGtMMlJHdlN0K2FBUHJRWEFEY1NjN1IyMVdod1hPR2ZGWW9OZEEyU0lM?=
 =?utf-8?B?UkY2QkR5NnlOMkZ4cGZKL0h4WmRSRkdGWHoySVRqU01oblk4Y3hCUW94K0hO?=
 =?utf-8?B?MVVRRG1Yczl5U2o0QW44RkxXU25jbGxnR0NJbVc3YVJwQ1ZXV1VqVU9WMi9m?=
 =?utf-8?B?Rml1ckRsa0JHeC9GdHNMNEdhRDRGWHZwN1I5UkF2OTY3bmFVcVdSck05V25Z?=
 =?utf-8?B?c2NhY3pIVnBxYUtKV2NqUTdDSUJ5Y2xNWXVxQVBmOWhOMlZFVTJTeEwxK3NO?=
 =?utf-8?B?NnJ1U2JycTBrSTR6bWdpWEtEL3hoaFgrYTlxUW5kL05QQ1MraVNVVkcyVy96?=
 =?utf-8?B?bEsvT0FhVWo3TTdTdmN5cEdOVlpGQlc5dEhDZ09NeDYwdE9Fb1BzdXYvaUpS?=
 =?utf-8?B?K2JWN2JHTGk0cUdJbXNPcjBZMW1XNi9nQllick8wUlcyZVk1L2w4OG8ybTE5?=
 =?utf-8?B?WU44T3BmMGhXaXdsM0lDQVdpTS9GSFRBNkFSUGRlYnBQVEJTTjJQSmtTbVhB?=
 =?utf-8?B?Z1FsdllpVmZ4VllibGM3cVhvaUdpeE1ab3VxbVd5OHd2WEcxVk1aSzVqbnNa?=
 =?utf-8?B?MEtIT1p2SmoreXJsNHRuU3h3aERiUnlTc2xTaHNjQlkxMUtWTnVKY04zMDI3?=
 =?utf-8?B?dmZrMHROaEZKSXRIZUduUTcwRGtyWS9hWXBlN08vNmVKdzA5S3RqK2h0MDJq?=
 =?utf-8?B?d3dGMnVlcE4yZXJ5SGFuOE51SWVxNkxTMzA5RW01ajdIMEp4WEZoWk5QbkdV?=
 =?utf-8?B?VHNPQm5MWCs5WlFQazdyOHZSbHY3Sm9idzF3Zng3T2c2TDMvaWxzSzhSdElX?=
 =?utf-8?B?MHVxUDFXNnVZMVZieTU3SzBKa1pnc3dJSDFkbVV6REw3V0pZRkRkM044TXBy?=
 =?utf-8?B?ZVFDRDRNVi9zelVUVjFxRWM5VE5KbkZpMGdySFR0ZzZiWmlueUNJQzlrN0pH?=
 =?utf-8?B?Tmh0UlJrNmV6b0tRNExtam90aXhHak9aaDNxRVhIcGpRbFNOUVBST0FYWExB?=
 =?utf-8?B?V1ltUEVIRjJUQm1hWkxEeDJSRE9iVHBCT2o4Wms0UDduYlg5Ym5TeTRlWlNV?=
 =?utf-8?B?UDl2MG5qWFYyQmlMT0pmUnFTQWUwOEpPZnZFQ0RCclJRNWhlWGtEc242VndB?=
 =?utf-8?B?ZEE5MWdmN1Q5Y1VXeDhNZWJXNzBSNjAyc3RZdGhFWHBrN1Nwei9zRVUwdVV0?=
 =?utf-8?B?MnFYSVRKV2tHOTRFZzNTRmJiZzNDSHlnZTZOWTdnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3350faf5-023f-4092-d272-08dbefeff0ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:56:42.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lznJaBr4HhcB5emR4xVGJu0ai+OGd08RK0F5QI2NTPe6dqu4jPPSjQyGgJmQS9bWeEt7D73kNPlMCW90DM44A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_07,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280069
X-Proofpoint-GUID: 5bAyPVDMnnE44xU58OSS42dRpouXa_TI
X-Proofpoint-ORIG-GUID: 5bAyPVDMnnE44xU58OSS42dRpouXa_TI

Hi Christoph,

>>>
>>> Currently minimum granularity is the FS block size, but it should be
>>> possibly to support lower in future.
>> I really dislike how this forces aligned allocations.  Aligned
>> allocations are a nice optimization to offload some of the work
>> to the storage hard/firmware, but we need to support it in general.
>> And I think with out of place writes into the COW fork, and atomic
>> transactions to swap it in we can do that pretty easily.
>>
>> That should also allow to get rid of the horrible forcealign mode,
>> as we can still try align if possible and just fall back to the
>> out of place writes.
>>

Can you try to explain your idea a bit more? This is blocking us.

Are you suggesting some sort of hybrid between the atomic write series 
you had a few years ago and this solution?

To me that would be continuing with the following:
- per-IO RWF_ATOMIC (and not O_ATOMIC semantics of nothing is written 
until some data sync)
- writes must be a power-of-two and at a naturally-aligned offset
- relying on atomic write HW support always

But for extents which are misaligned, we CoW to a new extent? I suppose 
we would align that extent to alignment of the write (i.e. length of write).

BTW, we also have rtvol support which does not use forcealign as it 
already can guarantee alignment, but still does rely on the same 
principle of requiring alignment - would you want CoW support there also?

Thanks,
John

