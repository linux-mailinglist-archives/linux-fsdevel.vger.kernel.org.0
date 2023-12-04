Return-Path: <linux-fsdevel+bounces-4755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356F8030AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 11:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7411F20EE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B73224D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o0GKZPum";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GVl05G3q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A50CA8;
	Mon,  4 Dec 2023 01:03:18 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B48wdo8031622;
	Mon, 4 Dec 2023 09:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6Ax4+f+MwzV4DGnyjMmazCBeZFOZlZjsyNBYtb0jBaA=;
 b=o0GKZPumoQOIdK1O0iUHEL3UKABDHzazxssS6ZYf3rTLKCpfdyt3rUevQRfcef4Oo2Wq
 FKMu+rXaytpKOqozvDELlWZkhyJ8vijCS6pu5vSS/vSG+XRsliMxb5Gnn1pJzxcbpMAb
 NMOl8YAQmDWjhT8zCqzPioTFyo7MugJGGCrsSntD/wCLBm3kdk9JsotD5N7X/tNIzmr9
 FsboE6jPnZ/c6GD1NNlvCA/7NB2HyeUJTIAZ1auF+JvEGcPqIjWCT9P68ocyznK8TjR/
 ijFs/mGNe/JvUq9bzhZlOWIlecZ2tmdUBHtQ5eXLYBnVw208VQyxhLU4bgkV3sXD6ica hA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usavx86pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 09:03:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B47MAcd020749;
	Mon, 4 Dec 2023 09:03:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15htpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 09:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4T5j9CY8Tjgi1E8Qb7mi7gxtpNYWzrszsyAg8Ay4cfq6S2vDdzwNNvnBtQvNu9wO3/wOb24nZ0Q11NYPXSiO51nVZQfvWGilHeIME1TAwXFZ0uB5jEYm131XCQn83ZF/tXe4m3yXRrIssQQho2lmOXVIPsAi6HBiWIjKHR8Xvm3MxPGtTscgwWvlkgtCxJg8O6IBMsGGzihYkQ31/ksiouyh3ZibWF6ESNrOBxQdkJDFkAwPOR7gWks1UJktycQXroWpVYx/rQbnk0fQphBPKYxJ3ztMnms5BCIuwE51lHZxrDJjBGeiwc6RQJ3jLiTsE/DsDStIYTN5VEXTrnkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ax4+f+MwzV4DGnyjMmazCBeZFOZlZjsyNBYtb0jBaA=;
 b=es0ETo2owEnUzOJYFgM4lHko1lbHJxQYC26ch7Bi8OGEIPNIv31auBZqH+NrgbN3Xx+pQFs9bgOZil6iYn3HNwlY0XDcbwHnxVxp19/ujM0IRcLVMxyjEHHGweiXIexiNahj04hlMriUQSYE6p7wz4/22PLZh6UgCVrHUKkYUfgwzTVO8/2j7NQCpzDbG7/7kkkz/0QTz7f4HvAAcXKCIp/edgw31pPK+BCCWF4RZy7dPqYK8QtChnhI6mCN5USgfZzUGbAsjSg4zuY6QtGhyIBRiv3PILb8mVOdcfSb0RmKDhIqYjpndP2S3gSket7BX8YBocqgXnpmVPaJcOLVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ax4+f+MwzV4DGnyjMmazCBeZFOZlZjsyNBYtb0jBaA=;
 b=GVl05G3qmWGZ+TXD3GM1PPlqIYhOUnqelRPA9YeR15tPh152T9bEfspkPT/kc2HcHkGBVVDHJS43lrHjdW7rwaCRh+k5W1YgDVpJePCzSJARG+y/RwoZJhxDke09tsz0UfugrTC7aq47GYv34JZXpuhsEuiy39a9P+HTg+b4+gk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7107.namprd10.prod.outlook.com (2603:10b6:510:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 09:03:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 09:02:59 +0000
Message-ID: <2aced048-4d4b-4a48-9a45-049f73763697@oracle.com>
Date: Mon, 4 Dec 2023 09:02:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/7] iomap: Don't fall back to buffered write if the write
 is atomic
To: Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
 <ZWj6Tt1zKUL4WPGr@dread.disaster.area>
 <85d1b27c-f4ef-43dd-8eed-f497817ab86d@oracle.com>
 <ZWpZJicSjW2XqMmp@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZWpZJicSjW2XqMmp@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: bc519ff0-dd37-48a7-b69d-08dbf4a7d06e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	34r7fgvcSxvBEOtjCKGY6ZcWe18g4W+OHUfGvoDv8JhxbVXFffJUvWOWMTMfwA75m6R4VxYBoXEoIXzsPQ23AjGsJaDp72BoS27tZEORL6htCRCG6VixrnEEkzsm5MkozsRRIb5SlEJrnXJn4/+4HnTh/NwS7yPtzTsDct7tky+2cl2Io+8TqJA1kqX1rSL7FOxW7fLnTu1SThZJuj7SoPOyfON37cazREAJQfF9LwP3bFY4bjCKFFepxnvQheSs+74ZXGdFBpwO9kl8c1VW16uh1r3ENcaxqUCKhxgtzkvO9GpIhtfkZbHZbJsIAsPzsw7vPW2mWn3C3B90kyPYqAp8FFglLqsuLKoqLMQKX1aFjJaxLAXOuQ1FSHHzGG667yOFpkW6m1YItCO1VtHLSKUFzMjg6ftMUsKxTqpUNnLarRKMMzdX81w7p0HJnqbj+LJKAcNTHHTPOr7ysii22rJJ/BkhCMtyVsZ7Y/PRWrCM4j+P3tztqealLvz1JiNwCY0kZvXiIXpMYkWIAyg3OcwVi4dRfRgfDuDvbFd7rzYWn8fxdhTrV40jfyIyrG3Olpaf3F06/Bb9pqYP1FBHfbSSAQJj0hoyfjMOtox2Nd3zIZeYAZ/tI34PSHkjyG9kOpfZjzmVddlqatox3p1xvQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(2616005)(4326008)(8936002)(8676002)(6512007)(6506007)(36916002)(53546011)(83380400001)(26005)(6486002)(478600001)(6666004)(66476007)(54906003)(66946007)(66556008)(316002)(6916009)(2906002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djhHUzlHcEowRXNXNjBlcFdMMDRhOHBrM0tTU0hrUWJJcFFkUlRNR09ZaUtT?=
 =?utf-8?B?dHhNaXQ0dDVVeGhLa2NSMi9oWWx6YVE0R0FkcjVkb3Y0am9URTR1NjZrdExs?=
 =?utf-8?B?ZkZMUE9ITmF1QnJPRGNtSEpvbHhtZGlzM0tabmVkV2xBMkhiVW0vaWQ5bDdY?=
 =?utf-8?B?MWVKdW5YQmwxSEd5RXFEcDdUS0s1QXI4b3N4eis5elhBS1h6SytyNkMwM0RZ?=
 =?utf-8?B?MjRlOXArTkM3RVpPNHYrczdmN1lMMEVFdUlNTi82Uy82ZjBUT3ovMzhEa2lC?=
 =?utf-8?B?SVlzY01kWU9PV2J1d1Bka1k5SnNRcktmU29rWTV2U1diYXZGNCtiMjdaanJC?=
 =?utf-8?B?Y25YQW50VXJ1NmdaMG9Ia21WMis5blVLblhUbVhmVk5rTVhDRGJ5VFErbU9R?=
 =?utf-8?B?azdFdWtsREdzUlNINXBoUlB1Q2NzSEx1YmlUejNiUEFSdWNIcmFKSjFtZ2xX?=
 =?utf-8?B?WXYyKzRxSGxZY1o2T0hqcy95KzcxazUzM2JHNStFMGJLL0VhajkvN0tudnNl?=
 =?utf-8?B?U3NSS1dUeWw3RDUrdEtPaWM0eXlnS0ZKZUM1a04wdy9FbGNaQlRWb1lSTmRV?=
 =?utf-8?B?N1JXU2NFbUpQOWFIZ1JxMWZUeE5adVU0M1FPVTZJRVVqTCtLeXUySDZURGNQ?=
 =?utf-8?B?ZzgvV2ozSllnYTdPQ2tJdkRSREVvaDYvMTNRNmlrM0MybW0zMS9IRHJJMWc5?=
 =?utf-8?B?ekMyNitIQXhZTjRaVWsvNlQ5ZDhaV0JaQUhVTDd5RTVOYTBCUHQzdk5OdTQz?=
 =?utf-8?B?NWhYMTRjMG1qNTdJR3U5TXlJRDlYbS9rMytqQTJ4a05rOUxnTjJBNkhDWTNE?=
 =?utf-8?B?U0dnTzhFUkxnai9XKzVOYXN4N0p0UERWWVVuQTJaSWRZclkyTnhuUkMyd0hl?=
 =?utf-8?B?Nk1iZnhqdy8xdERaRkp3UEpCcVNLQW9EbE9ZWGhVN0pNdUE5MlBWeVY1aDgy?=
 =?utf-8?B?eG9IN3FJQlgxcVZxNzBDUnFsdXJybjc2S2llSnJZMm1HekVUeVVHS2tUZHBR?=
 =?utf-8?B?azdsSVV0VlJxZUwyb1NCMXVseVJOTkZRV1VTdWxHallwaVV3anZma052bElP?=
 =?utf-8?B?Q0RseEgzenFhaFVIdWV6RU1NZi80dHZoOFJZeUdVMTBvY2ZPODFxK2VDSTd0?=
 =?utf-8?B?V3FRRWtZbDcxSTB3NDVpeTNmQ1VIUmdJWVVSQkQxTkhrTWpva1ZnMElvdmpF?=
 =?utf-8?B?a2Q4RXpSMnhBeXk5eGtNU2RPcmpFelRRTCtxZEExcTh2MFNuM3RlNUUzZE1u?=
 =?utf-8?B?S3ZnRlJKaGMzaTF0K280VmI4elllZW9rdXJBc0xNb3EwVS9QNVZYOHJ0SHo2?=
 =?utf-8?B?YTBleEd2UTVDT3RFcEtvYXkzeFQ3cm5qYlpWVkMvbGNuS2MzaW02Wnp4dDdl?=
 =?utf-8?B?cWEvV0g1SVc4L2RvZDdpQXExRVJlYjRGUmZxM3NqYVA1b0xYRTh1eHFja25B?=
 =?utf-8?B?ZEJxWVh4UE9sOU9acjJNNDRZWVNHV2ViVUpNb0VXUVMzUHB0cnRsVUI0aFpN?=
 =?utf-8?B?OERpeGZFYUF1YS9TeDd2WElrMEVFU1NoMVFka0Y3SEZsVml6UXNRcUJabEQ1?=
 =?utf-8?B?VFdqNmtEQkIyVnhMNzk2eXpFc3ZHR1oySWdYMDU0ejZKZGNEbURWcWpFK2F6?=
 =?utf-8?B?bTViLzVMOExWTjhmNVVEajVWU281Y0ZONlg3NEZtL2c0RGtCUEZiOEhrbklp?=
 =?utf-8?B?S21FNDZLd3pxNHFVZksyT01aMjBVUXFFdTRjc0F1SFkwMlVaYUFaZmNmZVQ5?=
 =?utf-8?B?cHdjaEZWQVNxYzlwbFJGK2M4SE5WQU53ZUdWV29RTzR4YmsrdlNKRFJ0disx?=
 =?utf-8?B?VmM4VmJac21ndys2dG4yR2VQUTJGYWp2ZFVmd25DcWV1bi9KY2pPTWVtdDRK?=
 =?utf-8?B?Z3NSY2swc2N6TlBEcUhBRHE4SzUzeERvdUxJYTV3Uy9IWHhNNGdRYy95NTBV?=
 =?utf-8?B?MDVaRFhpejZ3ZHpHUFRPYmVsSFZyaFZxcTdhREZmLzRLdEo5TU83WS9oUk84?=
 =?utf-8?B?QldDcFFZRVE4ck8xSWZyS2VNeFZjQmFnT002d3dGazdHbHc2U0VPSDQyQyty?=
 =?utf-8?B?UGh1TEJXSG9WTHBKcDRqTFJ5d09CeEhlS2xxM1MxQW8rWVA5UzdhWkJhVXNT?=
 =?utf-8?Q?AFLxnEj6WCeHqZGgsURXyWxdh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?aENpZTlKcEV6Y2w2dWcza05Idm01Q3hMdFJoQW1Ra1ZRcDAwN0FnbXFETWl2?=
 =?utf-8?B?YVUvRisvWStKbVAxVzlaK2c1Szc1Z3NZV3B3VVNNdWwxSEFJSGpTbUVqdHdl?=
 =?utf-8?B?OCs2UmQxVTkweDJCNTI5RExMc0NFRUJZOVNVdWg3V3JhSWM2ZjdIem5VSlBi?=
 =?utf-8?B?dGZzanhyZnFmZE4vSmlYTUd3SHhiVkdzai9semdrVFhxTDdzdnVoaXhkZHFy?=
 =?utf-8?B?VXpDYStlYVdWYWFGeGIwNk1aYjRtR0NCZDludStqTzhVTUtYdXR0aHFscDZr?=
 =?utf-8?B?QStVTkJFR3dIUnlIMFpvaEM3REI2UW43eHkwVHptdFMzSmxDS09ybHJ5SHFD?=
 =?utf-8?B?M3pIUllKNlhMYnl6MXpHY2RQM1ZXRi9mb2grNHljKzRpcU1XY1lCRExlblcx?=
 =?utf-8?B?SDIwWk41aWxkRlRrQ3RicEtlQlduMkg4bmtRM2lORWt2dldJcHg5NXRTbWNT?=
 =?utf-8?B?dlRPY2drdnNTU0dEOFB3dURyTmFEU1B2V0R5bkJnVHZ4K1V0ajRkb3l1alpt?=
 =?utf-8?B?YThmWm5VeEQ3R1NUL3oyekRpUDZnWllWZWZGUjlBa2NXZTVnTUtOeENBMnJU?=
 =?utf-8?B?TW1DZFNzOGlnWE5lSnVBcC9QbktMT2lOU1o2L2RXUEdSWWpTanhxZ0V1QnE4?=
 =?utf-8?B?SWdZUHd0M0YveU8xbTZDeTRWT2tkbUFqVjRiUTc2cWFkUG5GZXdqMjRsNnh1?=
 =?utf-8?B?b25VUWYxZkdhWllrNDZvOUd2K3BMNTRDYU9aS1B4Rzl3Mkx6cHNyQjhMWXdZ?=
 =?utf-8?B?L3huRnRIeDBaSXEzNVdaTmZQTURxc2NUVkl2TWhXenpJazMrOUhZWDRpVTZv?=
 =?utf-8?B?NUZIM0JRdG1lK0QwZXR6Wmk4YlBMTldET0ZlNVh3NlFOZUhMQSt0NlErelJ1?=
 =?utf-8?B?VlZyWEFpMno1U09uclZVQm9EU2FBaDVzVHphdjEzSTNkVm5GOU5UcUhjcEpw?=
 =?utf-8?B?VmtRdlIxZWN1UE1KcHhGT0owR09sNzJiNTlXS09rUW9vc0NPUFNnb0hVU1BG?=
 =?utf-8?B?TzJmUVVqTjNzVlpWZ3cvcExCNzBqYXA0aGRCY3k1WDBHZGpqZEZaL2IyWkZr?=
 =?utf-8?B?eEU5Q1ZRTHVRUzh4MGpRRHROaElyWG1OVmlqMkFwRjduMXdLWFdsNjdYMktO?=
 =?utf-8?B?NTNlS3lYOVNSOHRmdk9kTFNacEh5ek9WbUg3enRDREZjTExiQ2ZDZGpuR1hZ?=
 =?utf-8?B?NUtzTDM2WEZ1UW53bUR6aHFMUlpMZElCY0RsR3ZUbVJTaWpya2duczViMkdu?=
 =?utf-8?Q?ewAtyOUlEWQ3JvV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc519ff0-dd37-48a7-b69d-08dbf4a7d06e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 09:02:59.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZ5RVT2qvDZV9b0xK+hFtByKHc0PBtPxKZ+T8WYjEaSLG7pz1gH0BRu/nszQzYOf/sygJdD/Tjtz2TAtgK7ABw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040067
X-Proofpoint-GUID: zTPwP9m2Uqz7j2Co8mc3eUPLRVA4Qj8U
X-Proofpoint-ORIG-GUID: zTPwP9m2Uqz7j2Co8mc3eUPLRVA4Qj8U

On 01/12/2023 22:07, Dave Chinner wrote:
>> Sure, and I think that we need a better story for supporting buffered IO for
>> atomic writes.
>>
>> Currently we have:
>> - man pages tell us RWF_ATOMIC is only supported for direct IO
>> - statx gives atomic write unit min/max, not explicitly telling us it's for
>> direct IO
>> - RWF_ATOMIC is ignored for !O_DIRECT
>>
>> So I am thinking of expanding statx support to enable querying of atomic
>> write capabilities for buffered IO and direct IO separately.
> You're over complicating this way too much by trying to restrict the
> functionality down to just what you want to implement right now.
> 
> RWF_ATOMIC is no different to RWF_NOWAIT. The API doesn't decide
> what can be supported - the filesystems themselves decide what part
> of the API they can support and implement those pieces.

Sure, but for RWF_ATOMIC we still have the associated statx call to tell 
us whether atomic writes are supported for a file and the specific range 
capability.

> 
> TO go back to RWF_NOWAIT, for a long time we (XFS) only supported
> RWF_NOWAIT on DIO, and buffered reads and writes were given
> -EOPNOTSUPP by the filesystem. Then other filesystems started
> supporting DIO with RWF_NOWAIT. Then buffered read support was added
> to the page cache and XFS, and as other filesystems were converted
> they removed the RWF_NOWAIT exclusion check from their read IO
> paths.
> 
> We are now in the same place with buffered write support for
> RWF_NOWAIT. XFS, the page cache and iomap allow buffered writes w/
> RWF_NOWAIT, but ext4, btrfs and f2fs still all return -EOPNOTSUPP
> because they don't support non-blocking buffered writes yet.
> 
> This is the same model we should be applying with RWF_ATOMIC - we
> know that over time we'll be able to expand support for atomic
> writes across both direct and buffered IO, so we should not be
> restricting the API or infrastructure to only allow RWF_ATOMIC w/
> DIO.

Agreed.

> Just have the filesystems reject RWF_ATOMIC w/ -EOPNOTSUPP if
> they don't support it,

Yes, I was going to add this regardless.

> and for those that do it is conditional on
> whther the filesystem supports it for the given type of IO being
> done.
> 
> Seriously - an application can easily probe for RWF_ATOMIC support
> without needing information to be directly exposed in statx() - just
> open a O_TMPFILE, issue the type of RWF_ATOMIC IO you require to be
> supported, and if it returns -EOPNOTSUPP then it you can't use
> RWF_ATOMIC optimisations in the application....

ok, if that is the done thing.

So I can't imagine that atomic write unit range will be different for 
direct IO and buffered IO (ignoring for a moment Christoph's idea for 
CoW always for no HW offload) when supported. But it seems that we may 
have a scenario where statx tells is that atomic writes are supported 
for a file, and a DIO write succeeds and a buffered IO write may return 
-EOPNOTSUPP. If that's acceptable then I'll work towards that.

If we could just run statx on a file descriptor here then that would be 
simpler...

Thanks,
John



