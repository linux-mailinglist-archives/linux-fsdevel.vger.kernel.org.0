Return-Path: <linux-fsdevel+bounces-4793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15833803D38
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 19:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3791F1C20992
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CFF2FC21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="goYvvsX5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z8USXsMF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369CEFA;
	Mon,  4 Dec 2023 10:06:39 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4I1RPk006928;
	Mon, 4 Dec 2023 18:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Qxj73s5an90wupVqHvruaYylCXXG4beRmYypCpMiQCs=;
 b=goYvvsX5hjN7xhn8kXnbob0hIPAlhQT8fhX9mX3EcpCp65xJK71j2BlYDRwxtmEf76Rj
 TMjMUpyNmmWatwKWB3uQ9123UmtvUnwMGQTiniHLyJ6AK/WXRtGWknYGhucMjoLyhHLT
 NIexZ9uNSlxSJir8felsuOMqMyJkuHw/+FCTWLVRz6rzoBGiJ6VnUhsIZ8Iasfgp9dUz
 iQgi4UctFwPL+t24jkJjq82VUYNdsqw0b6WJhMV9chWZqM0H0RYKX/YojDO+4cbfTNci
 6jYC6+SXjZX06VYID7rUwUlP3xTObdqX3iVVrqv17Ld9VNQXnJd6b2oxXL53uwmBKCLb XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uskp9r0pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 18:06:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4HjGHp003922;
	Mon, 4 Dec 2023 18:06:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu167reg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 18:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2JnnYf2mbB+iK4XrkwaJI1DDL9YKQuZqCHWUnqWohGWF3SV9OpHCJsr1VVLfKbZEqb8KJ2EAb1gmgIVXJBjXOcworFsImzdTZRSE/f/MidVKcX4hnA+YZgL/ojWNaqe7wUFiL1UU66WW5G6NcA6X0CrWHLUKfsuYXZW3suavfNNH9kdheEufvpnncOvJVh3VowFqMVlnCEyX3KSqDpXmbqJcRISXlXya0vmzm8HuIDYfylMPeNxXRbsAinCb7MwJAeT/KWyeMiQtMP5KQ25FUFKafhqakO2TjDKqy472EdmW12qBsaNw1RzHDwTW9IIXUnvT5q2nSmpjT/U2gl4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qxj73s5an90wupVqHvruaYylCXXG4beRmYypCpMiQCs=;
 b=DxREn2PHQgnJnFf3GIzclJ45JE4I+EQgfS/On40etIXZCFeNPKgfLF7acip9nbhM5POH6dkcyjsf9Am/VeK7HzixRG2KlVww58BWPuGDiLfs6IBsTBJ0mfkH3GRwfFHrA5BXj+RJ92u7G7tzWTfaxXrTcVXiaKiZA+oCBTV1FDGTsLNVXeZF/D4RbehTkCTwkeOJsvmdZdJMdf3uY9ePF3ZTst9FrwxbYBIJ1Oyo9A8dFqZ49++aJT53q/ONozW57X6MH+zSbnmZv8ZoIgWmO5ZdutebVaqk51uLKTK0wvKLXS2C6W+KaN+M+fx5E2p1gYjkWJyzSAUmRDsaTMwXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qxj73s5an90wupVqHvruaYylCXXG4beRmYypCpMiQCs=;
 b=Z8USXsMFY3jPPHCbHZ186vmdbmU4GvbVp3+ikeE7Qz0qqzmwcxhQp6E0+cP22+5b5oEG7a3m8wYWUP+Uh/MXuOQIbUWojzrx7xlz8tOUdTfuOg9PA5MJEQhA5eLvAgTmSaUb7Xvuyyi8mt+cZzXzqbBAI3s94az5GeEbrSb/A5g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29; Mon, 4 Dec
 2023 18:06:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 18:06:08 +0000
Message-ID: <52d64bce-5852-4527-8677-f04e23015e34@oracle.com>
Date: Mon, 4 Dec 2023 18:06:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Content-Language: en-US
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
 <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
 <20231128135619.GA12202@lst.de>
 <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
 <20231204134509.GA25834@lst.de>
 <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
 <20231204153912.GA3580@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231204153912.GA3580@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0405.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1c236b-0d7d-41b1-4a37-08dbf4f3b0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7VfHK/DC/WMLpCeMZwD3jHunGQdytREU7BvPwm5D0Wmxotdnp1txOi1630b0Oqfgjl7Ig868gq40ZCAur2yP4Yq3Cz+X5z/bwEpewv/he40sMicPFxEEPRD30ZGjWgWg+yp7tXp08LFX0t1WmVKhQzvkMsgi1qnCGgqqhPewS6b67crWiwnOkaqQmlfaJm6iWtDTlAw5eiIbjbnSJHRK3juPYphQ8n2Qz6uKk23G7XCZPKvMxa1pEo7fH9yd0dCIpAHk54R2uJkPgeASqTPIOfFPeubbtwebsEmShSb1aeFoR5jJ8cyMP7ocbokoqh88GeNTq7cushmvd5lBzWpbCjUFV+HAHUhQnWxgn65qWtmWxiZfPzvWJCUhBE8KG3cwsHxlw6xpZ8A704FLm1J/xSDo2RP4bMt7vypYzG42d45ne3Tmsv8WS8n2P9BVlFgDoIaoXA6cdqNqigd20ucS4GjL1cCKGn6KBHtMCy5wfeqwd+8+h8L35Wbyni35O2gBf+d+K1rpgHqvpqO/RcaP0xEkM0xaQhfSwsYGkPlqD9To6SGBme0qyKc86HDi6cLTCSy/4WBWxPqe7nbEB9tEl+v0Ummix6raFGfLKXcD0Ltuz1GxmTsXyj/Q4/WsRAGiw04Nk3sMhoGxCXFSSEem2Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(6486002)(38100700002)(4744005)(7416002)(5660300002)(36756003)(41300700001)(2906002)(86362001)(31696002)(8936002)(31686004)(2616005)(4326008)(83380400001)(53546011)(8676002)(26005)(6512007)(36916002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U0NOdlN5Syszb0FFdVE0MlEyV1JzT1diVHprWXlvWnBoNGRSOVlKYmR3N0pM?=
 =?utf-8?B?aHl2N1BzMU1PRlZhUzJoWCtjTGlEVElXOHdmSVR5UWdDb05wak1kdWFaRU9Y?=
 =?utf-8?B?V0FDdjQycnREaXkyOVhiUUdZWWpLK3VZM0ZkMFkyUWJBeFQ3Z01vcGNuNGRE?=
 =?utf-8?B?VTIwWXgzYnp3S1BqaWthWGp6dDR1UzFGeG1CNWxGTXBkUTBscURHZlprMkQy?=
 =?utf-8?B?Q3dQYkJVd2dTa3pjNGloU0xnNVZJN05HRnVZN0FCN2pIcFgydTNTc0ZjVU5B?=
 =?utf-8?B?eGsyd0x3MXg1TnlyWkN3QUxBR1FnYTl0cm9qL0VaVnlnSjhsamIxdGhMSXNo?=
 =?utf-8?B?eEpZYnp4b1lOZUtVZTdaTW9OemxZVVl4bFVyMlBTMVhaUzl1RTdYSXFTRXZM?=
 =?utf-8?B?T1dGa3c4VzIwSjkwV21uZ243TmorcXVKdXYvUmdmK1hwYXdaam9lMHRjeXZG?=
 =?utf-8?B?cmlrSVNUSUNQb2FxQkdpYXRNYVdzQ2c4SHBqdXNKTmtib2krV0JVbXIrSzVE?=
 =?utf-8?B?U1pad1MvNXJrSDhTci9CL0lzQ2FPTFJ5UGZ6NHZ4SVhhdmh5dk1qNEdwUHJw?=
 =?utf-8?B?MlNkb2tIcEJmZUxRNEpEbFZVL3NBYXFob2lSeW5oemZGRjVrTFd5dWtGc3pa?=
 =?utf-8?B?YmdUazNsNlFVY05XdXl5ODlxTEY5dVZ0eWJIdTFRWG8vSFBwcFBqSVRVcHJi?=
 =?utf-8?B?bWh1MTFzdW1yWm5mZnl3NEJYb0lhcWplMnlkdGVjY292bTRXdUNUZEFCWXlJ?=
 =?utf-8?B?RWpSbTdkTE9yTk45K2NSNEdNaUNhOWpLWmVwTFlLWk4rNzFnMnI4YjBSMWVr?=
 =?utf-8?B?S2FzbjNMVmhHMEJwSXgvY2lqZVZPRVFZT3h5amNOZDNKaWttMEp0UmdGVmVz?=
 =?utf-8?B?L3hrZTJhOG5kWHA3QW12RXNNdnNuQXd4VjVTNXBXY2NZcVFHY3QwVElUQWg2?=
 =?utf-8?B?NDFZeTJxeEZabS9uMXFkd056enM0SjNnb1c0cmMxNGFTVURKdnZ2UnhqUWcr?=
 =?utf-8?B?aDJqR0tMZjZ0b0FUSkQrRFNGTis1Q2VFNktnRS80a1lBN2hhVnRjZjlqRnpu?=
 =?utf-8?B?SFJnV1A1b0YvVlcycFpoWU1wVkloMmNlWW8yMXI1aGtsZ3VJODB4bGdvcVZk?=
 =?utf-8?B?Vm55VDRiQ2FVRDYzSFJjTE5kb1cxK1dCOWRTK3BIZUYvL3l0Qnk4UlBVSnJF?=
 =?utf-8?B?dWx0U3BpMWF0bGtuVlh5UVNra3ArTm4xdkxjaStIUnJ3Zkpvd2lXclZEeWww?=
 =?utf-8?B?Z1plZVh4c0RlSkE0dWpMN1laWWpRMkdlUm5yUit5cHNtT2Qva0p4SVVUa1A1?=
 =?utf-8?B?UDhYa3Z0YU1SbStIZG1IVStocG9UcU9JazVqM3VmNms2RWIwaXFMREN2Mk90?=
 =?utf-8?B?STJmUERWbXp0L1pVWjZrZUlxWi9ZNXkvTWJjUVU4dnhPR3RVUE40UGJLMTZE?=
 =?utf-8?B?WVJjQjRpaWIvL0JBeWxOMFNmQVpXQ2FHZ3E0aTZCamt3ay96ZnFJcXhFemtl?=
 =?utf-8?B?TzhRNCtTa0RPR1g5VHI5VDYvR21tTzVtVWErZ01zdmcxUWczUGJtTlRuK3hm?=
 =?utf-8?B?bFVOLzZPZnB5anA2WUM2OS9CRUwwSU9qaWJhd0xuMjdwZ1BvWjBsTVhWbHBI?=
 =?utf-8?B?Q3lRanlVYTcwUXcyTlovYTUxYWlsc3FDWkF2UHk3dVp0ck5VM29LSzlsZkQw?=
 =?utf-8?B?U3cxcndTU1ZzRjhnaGUxUTl2aFl1bVZpN1krMjA5ZzRvYVRWODlzTXdBeGZK?=
 =?utf-8?B?b25IeU5ORmpUc0ZtK0ppREY0V2FWZVBUS0FvemgxbDJidU80b0JnZjFLbTh4?=
 =?utf-8?B?MkozR0EwS09jd2huTm9mb1pTc1NjcDNkR1NSQy90Sy9UYWIzRzA4T3J5MUhq?=
 =?utf-8?B?Z2Q4M0tKV2lzWWdVTFRBOHRvc1lsdDBta0daeENxOGM0cUpkLzVxQmVNMUVM?=
 =?utf-8?B?NXg0NWtiNzRjWCtHWnRDSE5wSloweHp6TWx3cG15aEVaV1Z2WU5NZFgxOTFG?=
 =?utf-8?B?OTVPMEZ6YnNLd1RMWENMVk0wc251VDdNRkpob3pJWE9KSmtjclJ0WWRja3Fa?=
 =?utf-8?B?c0dSNHd1aEN2T2NHV0pCSyt6UmZpUGJwZU96T1h4S3M3dDIrQWYxdnNpRU9Z?=
 =?utf-8?B?M3BOenR4eXhuV0hvd0lVSis3bDg4cXFWMEgvOEs1Z2lZVjlETmt2Q1ZESXIw?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?MHJlakxYS3REL0x0elJtSXBYVmw4MnZtbk51NktuSEN2R3BJcmpjaTE3KzhI?=
 =?utf-8?B?TnBKdG9jclFrOFFPL2FNeFJCUmQ1ZTJlSGtjSWRzZUtkMm1IV2NrWnByRWty?=
 =?utf-8?B?anI3U1lmR2tTanpOUkRVYnZYenVja3N0USs5WTdTcEJOVSszQXp5WmljZDA5?=
 =?utf-8?B?ZGdEaDNNS2JVUGVZdWhnOFMvN1lzMXZlcjRRS3duemEraDh3TmNwR2NRcnF5?=
 =?utf-8?B?RWllalNITWVQSURtNWpjS0VNVGNFKzNPOWZGeC9QRWpKL0I4Q1llSkJ1em52?=
 =?utf-8?B?MmhzOWhNbWtYWTFJSFJNVWV0enpZbS93a2VRMVg4WE9pQWhhcnRNeExTVWlD?=
 =?utf-8?B?cW1vWUhTMTVYYUNsVzN1MDROeGJobUZmVXZYbDF0dzV4NVRMckNOKzJsMXFv?=
 =?utf-8?B?RENtZkVPRnlyZzJpSTJhZmtOeENHM3lpVFRyTXM0UmtoMmFFTGllNGxvbHl6?=
 =?utf-8?B?SFM2b1VEZitmK0RubDdoTVdwVzlNeE1ZYkxoTmhFc3poZDdpUTBEQ2hFTHRp?=
 =?utf-8?B?WTRRdkZuNS82a05Qa2NGTXNpZ05BaTZLNEc0MkV5WFpKbGhyanZhcm1Rd09T?=
 =?utf-8?B?NVQ1bEhZUkE2enpLdlpRZHdNb2ZnOCtLTzJBRjIvb1FOMnRubnpNazZsVFgz?=
 =?utf-8?B?amVxZXJnbGk4ZlVrcDMyN3lhNGNpZ2wxWkMzU256TThTNjhVMTFxcXcvek9R?=
 =?utf-8?B?SVNJR1U2WlM3dXlXd3hpc1pwWDcyUTJRWlNiVUdwNDRQVVVPZ3hSaFJvaGlE?=
 =?utf-8?B?dzVuLy9ucWdLdHEwOXVqYXF3ejM3cUhpSnVHR0E1YjNNdUVLYndwdFFTNUpN?=
 =?utf-8?B?bFdXN0pvSGNPUFN2MVcvd2UzUXJydUtEbGdsUEUzVDF2bm9oY1k4STdNbnU0?=
 =?utf-8?B?bFJMd2N1TWRXYkRsZVdwZGZLbDluTnlKVlZ2MWsyeVh3YmJMQmNFdVdrYUhQ?=
 =?utf-8?B?ck85QUsvUDlDOEExaUpMMEoxeTZzbmppT1VQRnV3R2YzdTBnWXNSRlZRNmRr?=
 =?utf-8?B?UEo5YzRFNTU3ZmQ2d0pJcGlsbFhNbzhhUEpLNnRBZEZDNE5tT1pvRXBqV1F5?=
 =?utf-8?B?WVRNeEVzUkc0LzBPR0xVeloxM29iRFhYOFJTK2ZnMzdYL1gzZTlEeHRFVXdQ?=
 =?utf-8?B?YUdxQThmQ0dtaFpHbmVPbmE0Z00zM0xPdUFPTVgxVFdpUHVEUEtIWk41eG81?=
 =?utf-8?B?VC9RTUxsSXJUMFU1QXpVSGhpSW1SMmN6bVZXNkNBWHFseXAyZ09iRmYraG5S?=
 =?utf-8?B?dzhVUWdqUDhHZnBlR08xQVgvTnZYbDBxWEFKUk9sNjJUeXdmUFJwTllOODBv?=
 =?utf-8?B?a3FUNnJOSk4vNHhScU51dTMzZmNjVXVnWlhyaWRxbW5XUHhZWmhucUozM2xQ?=
 =?utf-8?B?aUlON2V0UmRuaHFWRTBKaEc1eHljUytIQ29XcEFQZHNZQmR1VDdaMTRqcWth?=
 =?utf-8?B?Z1F6UnhVeEllWUdtRVpmbnJUdllqVkVYZnB4S01RPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1c236b-0d7d-41b1-4a37-08dbf4f3b0c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 18:06:08.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgZFai2VMAwEmlF+nHoZhgAPt+CQd6qVfqZS87ty8t6dzzJQah4/X5Z/L6EGvsDeveonOpvF88MV8iUHzyE7fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_17,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040139
X-Proofpoint-ORIG-GUID: 5lbiXrgAFNqPWWJ7Neva07L18kjc6kVw
X-Proofpoint-GUID: 5lbiXrgAFNqPWWJ7Neva07L18kjc6kVw

On 04/12/2023 15:39, Christoph Hellwig wrote:
>> So what would you propose as the next step? Would it to be first achieve
>> atomic write support for XFS with HW support + CoW to ensure contiguous
>> extents (and without XFS forcealign)?
> I think the very first priority is just block device support without
> any fs enablement.  We just need to make sure the API isn't too limited
> for additional use cases.

Sounds ok

