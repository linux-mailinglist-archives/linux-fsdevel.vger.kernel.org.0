Return-Path: <linux-fsdevel+bounces-5626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DAD80E50F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 08:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E8AB21C41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 07:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D317984;
	Tue, 12 Dec 2023 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TzXLu7/a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BDmU6z7i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7813ED2;
	Mon, 11 Dec 2023 23:47:07 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hl8N020148;
	Tue, 12 Dec 2023 07:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EzEtjp0WNF8f3ElMEi0MBd68dpq9vmhSDOuicGhuEgc=;
 b=TzXLu7/a3wdVOGveQGGb180Fy3bMWRYPFRgM/PR6uuJz0aPtQmJ0Vd+Kh6CMPudr/xh9
 yCSIkaRxXl2xEdBRmvz0OTuP0TDW3ZVfUJMplT+0Hl7y2PKVcjbqgk5KKEwtM1OOop9d
 lHSUP+AkAMGzQr/WQkP/9PwYiEg97CLP4becHmXixLCChtaqV9gwNNbqgQmNWEiADZAa
 gKxkvImzVk+vKAcg/94ymwF5Zm3jurcQf2mHQVfWO4jfm4paJaXytnONHFaNyLUHfZ62
 Ejmo0pMj8vIHHtY9LKXwZShPb8z3n6tyr61BXwHDamd/mH18DibJB2o5JB+dbNowXwKg 1Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrkawh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 07:46:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC70x44003100;
	Tue, 12 Dec 2023 07:46:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep66s4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 07:46:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKvOsPSB9ghvRAJ+Pgaf+Cj+qq95+3yzxSf2XdgjvJ1S7D9YfU2FL/IXiwKFgaCSf2aRWY9IjPMiSdWJsQAMnAI0M9DquoHreBSgK1XnR2G1UOa7dFuf5QsIU/FEx/wbRUSagBRMIgsEGdibug/RqJGrc9uaT+GOY/LxLmnkeWObrvmIgwZOaNZlogHf3DmoFA9tQD0Hqh9EHko5h2k53mwjBp58YdQ7jZ11MEZvYKfGesSJwr4NPjoyQzMC2ZNkffDmEyRKjXeWGmekQBmyKwP+2Sk5lpFaJoNv+0RLo63BpE4NYEQpKmtBQvXf0n1fGAYie2Dja6j221Ub45pl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzEtjp0WNF8f3ElMEi0MBd68dpq9vmhSDOuicGhuEgc=;
 b=YBMTyPXLaINqqQJ2zTD1J4w/6I2uWKY/0cerrNvKa01xWZu5B1Sttt9101mW+5cIsuVo8v7hjsGVGXVta3bKkyRVjkJ/36hxpT4e5dQNMcX6vCGHrkEPQAtp8yr7/iSgkzj1rs1OCliKM9BYJrZZ+gtgN0af4vdnMw1J6uTggqpoOt+l4cRvTtFNFD1o5PMm0YiJl78Gy4i2ZVHHAiAQXUC1sqXL+9DddzQBBFgKGqsy0hWwXxOzmp15R5QnaVd0/QmT1keboaSmBugaOVxLKkLsl20B1sahO9GsJxQ7iM3V0mXYBzaJbHC9yvJA1A6ip9d1eixlsQj29knC5O7vWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzEtjp0WNF8f3ElMEi0MBd68dpq9vmhSDOuicGhuEgc=;
 b=BDmU6z7iFlecLZb0jyQYX03GuIQ9veL/zwKrH9OcWeGI5VXE7efJyP+urrBaoVk6DaA3ioUMaVKjYxkE00dD7wFI+qGY220R42yvQBhOGL/vAbuZ/myXExGf/6AXzWoezwIWcZHY1E4VOH8LincCmwpAJ8K8g/HbSvWe59/3VeM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 07:46:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 07:46:55 +0000
Message-ID: <c4cf3924-f67d-4f04-8460-054dbad70b93@oracle.com>
Date: Tue, 12 Dec 2023 07:46:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
 <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
 <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 0699aff5-8c0f-4c3a-43ff-08dbfae68330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Jrg+ep2yD1ZgN7cIVcXfp0YV7QakwgqahxxNS8mX+Sjcrz+9YIa0R5PBq3rTd8KGiHRZM6xvfA+dgZezEVmK6wwLQslF6VVNCyWdVXRoYdOJs5a/Kp2QPDcAZ0a+ubHZUtt9/wMiKLZ5mVgDuCzOLwGUvKXgfi8PWlJ08p2BQt2+qO2A7O0Kv1qkLnty5YKP1Wi78MUmFU+stDdW9xIWN+EPVdzR99JzBMnN6zrzR1Tim+lq01SS1xqYheLG5mQMh0QZUbBI6i3I6eh9bf/Z/eQlNNxDDTQyYnb4TdIbfqbOo4TiQVTZLyFFAa7PDTIkcWyK6+Kl9X/VqBYD5RkgSKGq87uHgxUeqFA2GLQEVk+ZEaOlbmYxQv0gqfxPIoBZAe7MZAOjDxblslOxJ/oez1bGgj4XJ9oglFhcXiXFwUsJk154j6u5agBTDNSeMvPMED3YJJhpi2Iaw76f4LKMwoCihhnIirJkRq+SfDhPzowAd+3YLkGGZOLKQgoB9sf+nwDHwL7p4NNH/jwbIjQZT1VcGoRcTEBw/gMIJ9jmN22AZsngtmKnFsTB7PzLyfjHIPuXAOysbnbyIDYmrgXjZHAHFAZ5ey/5FavNhzxiPUm5JjNWxOsAKxbWEPenzGx5x57fU93lxsdkt+5UsTGJaKuqHS4Fodfu1AshRcPifVEpRko8xj1hAARxnzwdk1uB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(38100700002)(8676002)(8936002)(86362001)(31696002)(316002)(36756003)(66556008)(66476007)(66946007)(6916009)(54906003)(478600001)(6486002)(2906002)(36916002)(6512007)(31686004)(7416002)(26005)(6506007)(53546011)(5660300002)(2616005)(83380400001)(6666004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zlh5UWdYQWI5b0hSdlBRN3MvVi96ZytNRDRpWEdhOEVITjNEd0xqaXYwazI4?=
 =?utf-8?B?WEVHK2RUN3Y5YXltOExpRnJaNC8rWVErM2xFaXRhUmg2Q0xoOFhUTWhVVXV3?=
 =?utf-8?B?R2VQMmFsNGhXSTQ2RCtKaVVxN00wWnQ2UDdOMm9pLzBBWEFpZ1ozUDRDU09N?=
 =?utf-8?B?aE8xVktDcFRLckh2RXZtVXZlWFJZb0pUOTRYNHdYV0VscUcxMGRvem9DUVph?=
 =?utf-8?B?a3pLaFE2STBNSVQ3dE5UVDNxM0N2ZXptcHBEdEFZVHo3b0MxMDBmRDFtN2gy?=
 =?utf-8?B?UFRlV2h6VCt0S1pNZEFkTjRwTkpwMWNhV2Q5ckpacGhhM2h3S08rNWNXTzBm?=
 =?utf-8?B?ZDNCckFqVW1rY2dTNEowRWk1OXRNQWNhOXFiSC9EVHdBTE9UZy9VbHZzNm5x?=
 =?utf-8?B?ZlRXMUkwZnZIY3greE9XUkYyQWdoMlhyWG9EWHVOWm1EbGpRb2JaWjR6MzRs?=
 =?utf-8?B?V3RFRWEwL3JKT1RmSExjZmJXQzJEdXdEdWpCOGNiR1lKbXlEVXNCMlN3bWZW?=
 =?utf-8?B?RGJ2M3NKL1BXMWFxYkJxMGlBbXlvM09sU0Z6WUt2clY0QkFSUjRCMVZGU0t3?=
 =?utf-8?B?aFF0V2UxejVRTmE1YVVOUGE0TXA0cXZhcVlyN3JwK005Q1dYM0VZM0Y5eE1j?=
 =?utf-8?B?Rm54dWJscExEcUNraDhEanZXcXBuV0Q1MmUvMHM2MUZaZXRtR0JoYXRIcm5Z?=
 =?utf-8?B?YWVnWVNSYXZUcjlUa0VSUlBsa0QrS1hjYjd1bDlqTXo1VHZtTzJ4L0JWMzYv?=
 =?utf-8?B?WktGd1RPUDFqekF6THQrZXNFTGQrenV5aG5aY3N3eTdQZjZ5aHZnekJLb0JD?=
 =?utf-8?B?WWxvV1dMNWpKbDE5L3pucFRrdG1LcEtVSVNnNDMyZVpib21uS2U2SUF4OGFR?=
 =?utf-8?B?K05ERVJDWHNYMjRoVE9xUUdoWUZuUktVd3g1ZmswOXVtbW95Uy9NbGpMZ1Zl?=
 =?utf-8?B?V0ZpV3FqWlRyVlZ5QlRSRE5MdytrRWNjN2sxbzlYdXN1VDQxL3piWDZmY1VJ?=
 =?utf-8?B?dWZ0UVB2cXVyTmliUnRJb3VHWUI3WkRUT09GQWxIZWtlTlYrUC9LN3pYaWRS?=
 =?utf-8?B?aDFTdEFUUTl1RXZpUEh4OEhlK1FpNUc2UG9iZEljRVN6a0JhYVlUdUtHNWJC?=
 =?utf-8?B?SStqSUFEa2p2WjZLWVZRYkZXcWRvRUp5amVZMmpFTFE0QU42MDBLRjdGdFVT?=
 =?utf-8?B?T25laGs5U2FGUjhEUXgwVmluekRLVmwybFpLRkJpemJaVmV3MEZCd3UxOEpy?=
 =?utf-8?B?QXZjRW1rVndsQWN5NC84MUtMVjBaV0xPK1EyZzM5RW5MbGpVbVA5TjJYL25K?=
 =?utf-8?B?Z2M3T2F1eHNBMGNuYjVEUkhEdjJYRGIweWdYa0N4am1FTXp6VzZEVWFWV2pH?=
 =?utf-8?B?aGhaVkU5NFU3V2NxbHVneWp1SUtGaTNYenAzd1RFQm9sTitWbnMwSEMvV3lW?=
 =?utf-8?B?NFo0cVRPczNCN0pzTGpjMDZUREtuUzdUVXgrdDFOSkJXUFA5L1lBN21UUkgv?=
 =?utf-8?B?SUVya2RxVkNlYm4wVEhSdlBydWp4Uldwd1hsSUwrWHhFUXh5UTRkZlByY2l2?=
 =?utf-8?B?UXBCWmV1bkxOelBiMTcyZkNnaTZhRVg3eFpMK0I0NzJKd05WUWlMQUFuUWp1?=
 =?utf-8?B?WG1nVUR0bFpheER2RkVDY1k2M3ArS1JxZHRNS1luWm9CTFpEQUtSQ3Fzc2VB?=
 =?utf-8?B?L1I1bE5Ld1dOMzVOWVR6QjY4S0ZIZCswSElKTEJjZUs2dldMNTBwdnlFSW41?=
 =?utf-8?B?dFY1NGhvRFNTQXlKckdaNC96VFFhb0Jycmw1L0t0NG9rekRqTzhRSWViU1VZ?=
 =?utf-8?B?dmcrRXNWa2FRVEhndTRCQ0RCMVNYSDE4RFluNkdCRUtTb1hMK29ERVI4TEc4?=
 =?utf-8?B?WXVqSVRPeUpDUDNPbS8wMjQzUGpDZ1BpSmw3OEswUmdyZkVSTXdwQ2Vlc21J?=
 =?utf-8?B?R2M5b0tDdFFGSFpsVUpuTUk4cEhvL2pNQTVIWlpCNUkzYk41eXo3R3JLV1lZ?=
 =?utf-8?B?aFB3TW1DODBZa2NXb2pPK0pheGJ1aEVFSVhSNlhPVHM1WWh6cjgwcG0xY1BY?=
 =?utf-8?B?RHBmdDA5K0xhMnpiNFFNdm9jVVNndmJ4R2lKS0RHVVFRdGhYUFZ2ZjljaE1B?=
 =?utf-8?Q?SX9USGreRLmDqqwVEc8jj/5D4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eo+C6VdPE3Z/HfuQ6RiTJjJF3HtrFGM5EBqDfntbxhmsrHsfaOseUS6vt4Fih3K6ls/xmiTWBv1hXxCIKtnmd9FAUklvOrkL7Uezu0r2PNLXC0pO2FTTn98sczjv2W8s8bYlLrFgqhVuGXtvyggJQewh2aL7GZ71B33p1pvc+sK3qS138Adp94UYR1UcQTlHEo2vhSFclf8R3aLE0SSQ2L7mdMVBYUZ5f/OxEjzFySEr6d1tmRyu/5mt2I+/RqSDwGQPU3PuJkq93CkLQ6HLdCaw/m8odXjaG9YvJGKiID8QyEDKBDDzkFY1wt8WxJuRvc6BzDxki9lWWBb2fciOU/MGbR/MifU45QMtv5swIpWtbEVIhtEGBQ8/o6PkpT/V8g3DJm5V55hVHsf9Sle70xVh8RNC3wHtA/R2poigP+fxqYKM1B3G9udK+L4eL3iN91AZZwrw4nuQClYblRZ1T1j+4BvObhTtkbeUSD7bijueKApR8W4oOLc90eIqz+C0CQpO9js35WFlg5Y0dEHMPaS9YtSdmXy7PFV5c0LaXSUxTpCNFZvKSdnxF7UqRJg0VrRpoeDUGuWI1F+6WLe6n8mp2HqAXolOef+v5HsnCN2ttD+QBglVoXfFxtK+XJSETO+D8aqp8oiUV4057NT3Ws5FqY4aWLso5ACJ7YKIREA0GFUbBTd/aNZTapAjTmxft3rhB9/kGqTpXufOli8nLCQ27V9k8rZrA0iAeKaJ0yhnMLKBvUQoP6C1mJKJG4PM3zPXhA2jaQ0umLu2UL5osvhWGdsjQ3Vv16NU5Q0V4DLH7+VZWfPWbtXWqT01T0RW3Ap6ysNrb5yUptv5vEkZBQyVZ0bYBHl+0q3qLtWWawlsEhUnUTlf+l+t/PlyYiXYWQkJSm247++f40x89PoeOVMcDDAZ1MRkI4VkqDChWAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0699aff5-8c0f-4c3a-43ff-08dbfae68330
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 07:46:55.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUPuLCr5f6k82auMvpXUxZEsRO8BImt+Sa8ldSf5+ve0FPhUhooAEmCoDiTz/ZZXzgQo9ukcAjjnipk5igWd8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=869 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120060
X-Proofpoint-GUID: V3GPE70KL6D4XoLPtR_qhKRayaFdmtp9
X-Proofpoint-ORIG-GUID: V3GPE70KL6D4XoLPtR_qhKRayaFdmtp9

On 11/12/2023 10:54, Ojaswin Mujoo wrote:
>> This seems a rather big drawback.
> So if I'm not wrong, we force the extent alignment as well as the size
> of the extent in xfs right.

For XFS in my v1 patchset, we only force alignment (but not size).

It is assumed that the user will fallocate/dd the complete file before 
issuing atomic writes, and we will have extent alignment and length as 
required.

However - as we have seen with a trial user - it can create a problem if 
we don't do that and we write 4K and then overwrite with a 16K atomic 
write to a file, as 2x extents may be allocated for the complete 16K and 
it cannot be issued as a single BIO.

> 
> We didn't want to overly restrict the users of atomic writes by forcing
> the extents to be of a certain alignment/size irrespective of the size
> of write. The design in this patchset provides this flexibility at the
> cost of some added precautions that the user should take (eg not doing
> an atomic write on a pre existing unaligned extent etc).

Doesn't bigalloc already give you what you require here?

Thanks,
John

