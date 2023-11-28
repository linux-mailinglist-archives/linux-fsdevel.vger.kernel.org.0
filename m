Return-Path: <linux-fsdevel+bounces-4070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FC07FC378
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 19:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551381F20E0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AAC3D0C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mfMPTbj9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="egKa7832"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65020DC;
	Tue, 28 Nov 2023 09:42:37 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASGhuoQ019904;
	Tue, 28 Nov 2023 17:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=66T0oWIABKwexOCzTZq1LGAlctaAKl8J8KVmc0ANyPk=;
 b=mfMPTbj9Qb49vlzCkEs0prEvSqSBkfjt4+J0ruQmsTAmjTNHvAgbnoflbg3vvvx+f4z7
 nfqDEvniddkWQRrTLDGt1TXkKECDzT8pSYuxPKxnlhXtrjB5lr6JUbbhvHQwBtyYhu+x
 3PaSeMI7kszoNSd3NUdbU7ZvpHKpyqidDBH39dwddpB2zT2fd1+znHfSUqNVpuDnMFt9
 z84oi8+evYkKCyu49IoZAg/osVENYkAPTOA1cJt2jSP0z2qSQbpZ3bfaKYFmdL1q1UVH
 hckOwx/NqD2CvOXt373ToAHfKbToQK/LjBokptn9vzLg6us4g5961CkwkXHz1knoCOAH Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8hu6fhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 17:42:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASH7laJ012634;
	Tue, 28 Nov 2023 17:42:18 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cd1d10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 17:42:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfsBxF/NZYsV8wKNV8e1OTKJUS7rEZPejiLJMTFtKOCahsdO/7jSnteDD6Zz6g4L/7/U0PzP49b8QIruSFakTIEcHZfvIY2m+ZChRuiGiU51Qh2NXrjaF+XTadhfKmoCUWULT73DDtqVcRI0+dKNM5nJytupI3sFIsKQ2qSdeCLvBeGoGX7+wT/eUgAOl9Lua4JuV060fvapKYr9i49DhSkiPDmR3VVviS+TNZqG+ifiuYYOTcOnm0+uJZ5XdLpEqGug40+xhbxGns4I/e02bhlkOlJOWyswoEN3D1Hy2W7VwkeDINUQh5r7TNIid/YNrn+5EyiVNETV8RSBuazXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66T0oWIABKwexOCzTZq1LGAlctaAKl8J8KVmc0ANyPk=;
 b=RMohNYIl3fs9+Jr4yufn1JRp+fWQAWtQ6WdKZPY0MTmaaVQOr1N1jnSMkj+A4y3BdkqRp1qubf05IewaB6fpYBCekBgqxTQPronVTNjD31LWj22OWu1Mimru2hrncnkFZ9/XsP2o1LKfK57ExmxBTxgKPAlalVI2cgU/6LsaTFDFXPhm46R3vKSXvlQreM/KBu4nAReyJZkmvNfCWJQwukRrXaTCozSr/lzsp/LQ7e03G6u/pSertxUZ5zTKOkqz2ULFTobWF6MeLIrHsuxG2Ib6Y6RnqaAzW0Kl+TReggaV0CwLH1Z6VRYhnyyXk2SJx5/ETBXWUNJXV+0cAaWejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66T0oWIABKwexOCzTZq1LGAlctaAKl8J8KVmc0ANyPk=;
 b=egKa7832DbzroHsHCqQJxEHO4LlxCv/QDti2EnG3K8st3ray1qG3cPOt+LjRhAFdlht3vjlU0Afs91SAxjkKT8s21bO+tu238UrZLvK04PDXrvpnodAxtOQAuAPzssBFdJs6rV9nNaVhq3wGDmaxW9wNrskrCLxDt7HTaVzEfVE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7375.namprd10.prod.outlook.com (2603:10b6:8:d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 17:42:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 17:42:16 +0000
Message-ID: <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
Date: Tue, 28 Nov 2023 17:42:10 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
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
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <20231128135619.GA12202@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0001.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af35aec-0725-4cc2-6e1b-08dbf0395cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qfI/XNXlTv1Sdm/EpL3yX60hBJlWZZBueManuZqIGl+boOybQIZ4Ey7sa+iIICRDsc8s1MoyFJa9+v3UWs82Pecj5hznrSCs0vcNVwyCX4M848JGAVYukLYZ5dO9DS98UFkavmZHNzTj3bixSZTG88+8G7mLC2b7pvXoOwioQtvA+pk0P0cjd/Oh5k+TlBiMv48r6dLBeEDAqT2pOYCUVlW0JpkWJ82TTMDnVkQa0NBJNVLixc1XSIilZ/XTPgXVcu2dcer3LOPk7K7pOnAnMeVL+ep4nWqXLEkZaw9hCu8dA+QQBw94sJ4GxRQYFmcO4s1/Uv2M5oWR3QEv1WfXu6Qa46YFTTVX169lBdYqZEqvrtn+GADC3U54ljQ5ZhF0sXdyc+VaBOESxi2fgSJ2r6vZ7BK/ZFqbu2Tnwnp1TWaytPLa7rdxQ1bDbZcBiHTPiShhnOMHNJX2/PLJyDIrXMB7JC1g3VlXLEqK1K/ZUf1Pf6XrE+BXXmHau554wcyKfixTKVnzGgThlrdxSr8SmhQwRsZLBbQjOxfydohMTQOD2OXKTInkJHooGxBDKio6zw/Raig3M+dsX1SMhoDWZIITGu+ncwjFQDmABKFXrGV0AYW1oqGbiKSrHGAm01EIYlYvrsQuQnVykGXCgzy2Aw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(36916002)(26005)(478600001)(53546011)(6666004)(6512007)(6506007)(2616005)(38100700002)(36756003)(86362001)(31696002)(5660300002)(2906002)(7416002)(41300700001)(83380400001)(316002)(8676002)(6486002)(6916009)(66556008)(66476007)(66946007)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjRPWmRDRWtmWElsU0M2MVVPQ3lZM2E5cTZKcjFsTEpWVUdoWmp1UmV3U3JF?=
 =?utf-8?B?Q28waTR1TkR2c2s1VHJITkpNQmppNExONXh0amh5T1hrN29XejVzazN5b1lw?=
 =?utf-8?B?Y0RjYU15dzh0UEtUcjhYYzkxV2UzbGV6OFlMdDJqSGFucGdBOHBJVU9iTW5k?=
 =?utf-8?B?ZkdlQ1NFMGNIcmdEWk5iREk0aTF6T1BwQS9nWDlwcXlZcHgrQW1IelhyUFBw?=
 =?utf-8?B?K0J1MzgyT1lLU08rcUg4RjNrdSszV1pPWkQxVm8ybStBUkxhWTVYdGZBaW5s?=
 =?utf-8?B?Vy9hcVRGSkVwdU1peVNQWmY5am9CZjZlTzQ5NC9mT04zdVNCS3plV0FNVGQ0?=
 =?utf-8?B?OUVIeXhYZzN3WHhzN09lT09iTFkzcDlwMkdmYkoyZzR4eVVsOW01NWVZTXIx?=
 =?utf-8?B?Tzl0ZElRNXZKWTdZNUY0cklVMnpDL1ZCVVJ0OUJiR09HaXptVlhMK0JLL3ZZ?=
 =?utf-8?B?MzZNaHI2NXB6WGlDM1YyM3l1M0dKdVhVUE5DMU8yM3gvNDRLMnFwWGpBdTgr?=
 =?utf-8?B?UTAvWCt0aEpETUZHRjlyY0RTOG9TeE81SkQxSkUxZGRVNGd1MW5kTjk3d2tB?=
 =?utf-8?B?bk1XOGQwb3RlZVBvRTJiN010dW02aitScmlUdUNUbGRIUUU5blhXVmx4c2wy?=
 =?utf-8?B?RmlmODIxcXVlTjRBS0tGS0JlWWhHUGdMKyt6WWp5ei9HTUhOeFJtWGhIZEhJ?=
 =?utf-8?B?WTFPdXdBRDhDR3hTR1hpTlJrSW5hai9HaFVBWE5JZ0FFRnZ3WDFWZmVEc0FJ?=
 =?utf-8?B?Tlo4SjRjZTV4VUFtQUFLQkdqcGhPc2RtYXNyUmdzUGJXaURlSHQwZWpQbXQ4?=
 =?utf-8?B?cFRSQzJTNmluTTcwTElhVG1EanFyK2JGcTdZWktMV2FZVGFydzlIWWZiRjNz?=
 =?utf-8?B?SlBRZHQ1RTF2VVN5aWZvejR6ZlR5MGhhT0F4cmhhc1AxUXBMOHRXODBtdy9R?=
 =?utf-8?B?WVNyK0x5VHhEQkgxVjR2Y3ZFSWk4bDVrcDlaWE5sbEp6TC9XTC81Q3labURj?=
 =?utf-8?B?RlllSkZEeXhjQjFNMjNhUHRVcldzTzRPRVE1NytRSndlYThaYURuT0djNFl2?=
 =?utf-8?B?RGhUV09pRERIZmdraTVoeVlCTFNOQkxDbUpzRjRFOW5GYjdKRnBRczlhL0hW?=
 =?utf-8?B?SUZBa0gvYmlvdzNJU202NEN2SU1zY2tDRk0wclBlQ01nK1AzYVJvUUpuNkdT?=
 =?utf-8?B?aStzTDZQVmEzVEF1YTl2Si9ONlp0bjdwS2duMDZpWDgxSW5PdjB5RkFwdlFO?=
 =?utf-8?B?UVRPYmI5Q3BZaVphTFdqQVBBcmVNU0tKQ0xBRk14RmtxcGxIUXFRbkRoUzJQ?=
 =?utf-8?B?WURBRS9ObFpmVWI4dGJUWUQ0RFQ2TWxOcW5MRUtud0xuTkkvUUdtYXNCNG9X?=
 =?utf-8?B?bHJ1TzJWcjlDaGpObDlZSHFnejBxVmFCbURWcFVNdzJ6THF6NExDR05TQklQ?=
 =?utf-8?B?eE51ZXFGZndEMGw5NTJoZytENjZXeGlRS1JqeTVpY1N4M0xSelM3UzJBajlu?=
 =?utf-8?B?QkZ4QUJmWG5qblVjTHR5TUhsdE4zWEVBcTd0YzV1Vnk2bzkzS3dZeXdrR1E3?=
 =?utf-8?B?eTB4Y3NjeEo0eGE4VDBxc2pNZjVBZjV0UkczQWF3MnFGVWZaakEzNmV3bGhn?=
 =?utf-8?B?VjFseUhtdDUwditPQjBzdlNJUUZ4dXIvb1ZublA1TVVKU0JmNm9NS3dlancw?=
 =?utf-8?B?SVgvUUZ4MTBzVVpUeDNkcVRoaDdKaWJ4dUFPQ2x6QktiMXRZdDBEaHBkWE5S?=
 =?utf-8?B?NkFhaWdCUERlM2YyUXpqRjVYYnR1UEN4em85ekMrVy9LZ3ZxakhwVDdEbVQr?=
 =?utf-8?B?RmkyVXNPVVc4WDQ3ZXhMK29ZSGtsTFhvVkY5UWhqdG51MndpaUFHa0cxK29q?=
 =?utf-8?B?K0l2d0hydmRPeXpYR2JsZWxhN3E3UDRKM0dTeHpvRjk2VFJCQlpobko4bUxz?=
 =?utf-8?B?UEdjSzRzMWcrbDZaZDJjRWVnOS9Vb08rMDBOZDdyRjJkOFZya3JyTUxMMktj?=
 =?utf-8?B?cWlURUJZaW1rS0VvZk42NUtjTGdMcVUxdjNUVXAvL3hvQnBuWktTRzZyNVYv?=
 =?utf-8?B?V3dEbkhHNTFTQk1qQ0JLOVZUVTd5c3Znc2ZrbmsyL0hqNCtIWmRWUElLRzN3?=
 =?utf-8?Q?ekBr/i3K36Z+G23ad61bgkHeZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?THVQTHErcjJyK0d0enUvQkdMWGxZNXk3L2x6T05yV3ZWeUh0K3JLMEdYT3Fq?=
 =?utf-8?B?SEd4ZnZiV1hPbGFEM21BWmRQbnlUM21WdFRiRSszeXpqeGE4M0hQRlhzcXU3?=
 =?utf-8?B?anh2bjcxaE1wcndyakFWMmRVRUtnU29vOERSRmh6ei9jNmZtQXVsNlRHNFhM?=
 =?utf-8?B?bTBtNDR6M2MxZVhBMFdVaEZsNUJVaUo1ZXk0aEN4K3Z5S2FKOVJrQmJTcGZq?=
 =?utf-8?B?aXkxT0RwRERQRllBK1JHM2RrQ1pnWG9OQ3c0cFhWMFBoVUxHT3YvSWRrOWxO?=
 =?utf-8?B?K0tuemdFTm1UbzZQNUk5WlBsZWRzTXFCZzdnZXY3a0hheTdFVEhwMTd4SzVZ?=
 =?utf-8?B?alNONWZaaVh0Z0hVb1JIajIrTnN2SU5vTTUrOWtNT3JrQmRiQjdjQ3FMUERT?=
 =?utf-8?B?U090Uzcwb3dVOG5xOGNWSWJwOXZzN3ZrWm9Ydkw3R2VtSWhFU1QreU9wUVJS?=
 =?utf-8?B?N0NQT2c5cHhMSmdpdmJOY0l4SGRNd2FrV1EvSmFabGxHY0E2Q3k0WXlzUldT?=
 =?utf-8?B?QmFqZG8yL01qaitQZERzbk5vTS9YYmpIdnFZTmNSUVp4Q0dLZlBkWDFGbkRm?=
 =?utf-8?B?UVhzZHVCY3c1L3hjdWM5QUIxNVp6MmQ4amJHaU5obGkxWmQ1K241TXpyUG1U?=
 =?utf-8?B?TmJTZWU5Y0YvNVZjVnBQclJxRDdyZFkweENFZkkvd25YRG5uaTN4cDd3eUxO?=
 =?utf-8?B?TndocnNqcStUTythdml6REZ3V3FtU1d1ZzlHSVo2Z3JIY3R2Q0xsRTdXeGly?=
 =?utf-8?B?YTdRS0lsVHlXak5TYnJHNlNMTjV2eUZpMXlMZnZydGwrUktDenZXZng5UUVT?=
 =?utf-8?B?WUphMWZ0SC92cmlHaVFWZmxtcmdiTjNuWVJJbWFPcFJHeTFDWDlaRHV2S3lS?=
 =?utf-8?B?VUpJOTc1V1N1MCtNVnExSXBOU2FzbVR0RVJoeFk0RGJMMDNzVElIMHFlSU8z?=
 =?utf-8?B?SldmSUcwRExERksyeGZBQy9xNjBkL1VrNXplSE5DdXdJQTNhL1pTaGQxOEMy?=
 =?utf-8?B?TjFYR01xalhoRldHYzE1SmNUelUyUngzanlzU0tlaXJyQXpzZ0FzTTkzZ2pO?=
 =?utf-8?B?Wk9HR08yRC85ZUxwMzZUdVRnK00zdlQ1enNPcVhMeDBsL2t5Y0F3eDVBb252?=
 =?utf-8?B?R1pGaTdQNlVlUEJlVTY3UXdtQnhhR2xRcy8vZldTSG9FY0IwenMxTFVNRXpi?=
 =?utf-8?B?cGdxKzVySU5Mb0dpRTR6RFRZUFJYaStCQ1dzZUlrMXFRWkRUa2VmVitEU2tE?=
 =?utf-8?B?eFZBT1VVdENNL1diVEkrQy9YWG1tQ1VJZGdrNzgxWGpSUjNyK1JuWVRiRS9L?=
 =?utf-8?B?T0lYcTZmdEhUdWR4VXhIT0tMQmJFbERDbzhxRURPTTZsR3R4cHZCbWNNSmw2?=
 =?utf-8?B?U29JVlJTbmZVdm1VWDI1QzdkQ1hKN0thV3BhblJlMUl1WFZqb0tqeWFQMmNi?=
 =?utf-8?B?dzZ5SU05dHpvTjUxaVVubUVTMGFHcFJIZ3JILzNnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af35aec-0725-4cc2-6e1b-08dbf0395cc6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 17:42:16.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq7TTgt3aq3zLkniK8Vl6L7IC3msGDHROKRwttaETMUKLyL/ua3dQtLfXu/2u1mFG64zyEV20MSrlnHzrXMTvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280141
X-Proofpoint-GUID: dARGLpdcmOR5R_laSSN-Gc-yZ1PhhKgC
X-Proofpoint-ORIG-GUID: dARGLpdcmOR5R_laSSN-Gc-yZ1PhhKgC

On 28/11/2023 13:56, Christoph Hellwig wrote:
> On Tue, Nov 28, 2023 at 08:56:37AM +0000, John Garry wrote:
>> Are you suggesting some sort of hybrid between the atomic write series you
>> had a few years ago and this solution?
> Very roughly, yes.
> 
>> To me that would be continuing with the following:
>> - per-IO RWF_ATOMIC (and not O_ATOMIC semantics of nothing is written until
>> some data sync)
> Yes.
> 
>> - writes must be a power-of-two and at a naturally-aligned offset
> Where offset is offset in the file? 

ok, fine, it would not be required for XFS with CoW. Some concerns still:
a. device atomic write boundary, if any
b. other FSes which do not have CoW support. ext4 is already being used 
for "atomic writes" in the field - see dubious amazon torn-write prevention.

About b., we could add the pow-of-2 and file offset alignment 
requirement for other FSes, but then need to add some method to 
advertise that restriction.

> It would not require it.  You
> probably want to do it for optimal performance, but requiring it
> feeels rather limited.
> 
>> - relying on atomic write HW support always
> And I think that's where we have different opinions.

I'm just trying to understand your idea and that is not necessarily my 
final opinion.

>  I think the hw
> offload is a nice optimization and we should use it wherever we can.

Sure, but to me it is a concern that we have 2x paths to make robust a. 
offload via hw, which may involve CoW b. no HW support, i.e. CoW always

And for no HW support, if we don't follow the O_ATOMIC model of 
committing nothing until a SYNC is issued, would we allocate, write, and 
later free a new extent for each write, right?

> But building the entire userspace API around it feels like a mistake.
> 

ok, but FWIW it works for the usecases which we know.

>> BTW, we also have rtvol support which does not use forcealign as it already
>> can guarantee alignment, but still does rely on the same principle of
>> requiring alignment - would you want CoW support there also?
> Upstream doesn't have out of place write support for the RT subvolume
> yet.  But Darrick has a series for it and we're actively working on
> upstreaming it.
Yeah, I thought that I heard this.

Thanks,
John

