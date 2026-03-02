Return-Path: <linux-fsdevel+bounces-78941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKkIC4/FpWnEFgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:14:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E981DDA24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4733B308A42D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D27426686;
	Mon,  2 Mar 2026 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Idjjt3mb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lN1gcZpr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB8425CE3;
	Mon,  2 Mar 2026 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470929; cv=fail; b=Qkt0K/NCcPzXibMq2gHl9FR+ApdKed6ujx82YiKOr2281xeE3qv0IXAXUcsZ7epSVPWG43MMcxpxkicMU06jlIdK7hLJaC8dMxsTkMUiOmRjcaeyGnoZl9t4DLY5hIIXDnji/bD9a+CRSwSWwT2KKvxBi8MukE8PtR6h5mx9ox0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470929; c=relaxed/simple;
	bh=F/wl7ffLbpEQHUI2YvCIayIHElT2UxJTo4l847kEIpg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J7e7RiS/WgPSZx4m5skM4rCABcPmzvI7Jl1WNNvGkQdqW1pBQ2xTdFK9hZGpxCbIuQqu8htrj+VzgDGwHjFD2T+suffZe9QB4A0M3Dsj6KwR1lGcDZC7eXrw/eYwJlfklkCL4znf4lozfKRxy80wKfaZpGktH223JR1Siuq/ZPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Idjjt3mb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lN1gcZpr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622GM5Ei2117329;
	Mon, 2 Mar 2026 17:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ewcd5FxuxchAg7+4jMcejUnpzfomB4xQxBfXx5b4//I=; b=
	Idjjt3mbeqYeakAmpldjgyz20IqpPQ7GRDplH3gBtGUueBPyEhY6mzMCjbhFpBiw
	dQ1KIVuYLB3iPCfa3F5wCAIsc714hY6e2flZFgLwrShU8blQtFYN0D0A4EpA7gGX
	Qou6Q00sZHIlL6N/z7kSOBsjLzJ/am5PO/gf6gMny1ycgntgM4J7czTW24mpn8iv
	c2WVbQuMEdGTRdn6o0hJImQwKINrDAgDwE1m96SQd7+iujSH2ukGvou88kbjmKZ6
	TwyVSf4wHkmth6FL1OzuDzC8cZ4Affw+/bHgDLCjm7i/jQ417jDfPOJHpKy4XPwf
	G0dgv/9nFsFPTgbPBGbzzg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cne0sr2hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 17:01:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622H1Fhr037803;
	Mon, 2 Mar 2026 17:01:43 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptdfj1p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 17:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxp2HMqAcNRswJjNi+rTBQfKMz9vLZy5kUwPQOzCpCJ1ow6z7a1ciHcFEz8nMYwXSO7tSYM8GnGdkfjez4NxHj2IhL9QtMvzDW/R1qnYmnIu+0hi1Pgi2mcEj7BPvB/dzrQSaGTuL+HD4vylR0+DcrhhyxhpgedzUKb3eNvXM5IWATFYR/rwKfKQ+dvV29S+QOJR8zLt2tl/k+h8UsVRvZ/0+v3cLFEBniv7FYmVwJWMOwcDMw7qBRpqRKym/xlPuQsPiem25U+CF2JsRs2Q1iMYuHL7QYrFN5+ksSqwSpEhg8DWKEFINv837BV8ydrdLmOAOiwBLNUcW5tExiiOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ewcd5FxuxchAg7+4jMcejUnpzfomB4xQxBfXx5b4//I=;
 b=mLh4BIQt0jbo8ReFU8NR13OPkilS1XHA1eGbMBPxaSBDZrnGTsy3SY66igF+y5I5S4DwPSjj5g+dqEMI2ePgqN4BIeW2gy9RHu5mlN3O/M9zlVVPaSO/tXMdyu8YVbKzNB6S4XZ0qsa3Q9AU5NTb0nBQfdnjvkPRWewRyPNLtfDOlRBnX3u6GU8lX8ApmXGK2+3DbkyZeFlKjZ6TgyQHezJpy5iLCFJ1Byo2hKgTscNmW5BBw4j/LVheYCHLgWoDeE+5ugdTPW67cJbWkOD3t9r5WcRauphXWJYgBn++FMoPrQgn4mbTZkZ8DCszETQcHwZZyav1pP3aa0E2sTTu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ewcd5FxuxchAg7+4jMcejUnpzfomB4xQxBfXx5b4//I=;
 b=lN1gcZprE1x/NRScx8+NI/A44h87nJQZ3JhkQwRAZ6pOFwzvZmHc5cjsqe+Xum6vS1sYC8/aYHw8quYmNd/qp1W9sy93bd1B3QJR6xLaQz4DQ41F0HhKw9Q/NqLX4ta4uqyXB40qsAvhjL23CfixryTEjdVK5dmHIKF4VeDOxzo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7381.namprd10.prod.outlook.com (2603:10b6:208:442::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 17:01:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 17:01:37 +0000
Message-ID: <f52659c6-37ed-4b5f-90a1-de5455745ab7@oracle.com>
Date: Mon, 2 Mar 2026 12:01:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: NeilBrown <neil@brown.name>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20260224163908.44060-1-cel@kernel.org>
 <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner>
 <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org>
 <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
 <177242454307.7472.11164903103911826962@noble.neil.brown.name>
 <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ee28c0-b4e5-42f9-d9d0-08de787d5dd6
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 xaQIshYYdMs2Zt1LVPxgImB8BtlO4WwaMJQOeFBjItRnTOWLSlUAkN5t+kA1T+hbef7PRHh+nKeBwWK6E8MjqDz3slFV9CqTGstS6wtc5zbRiWGXyHsXbpevWw8ShYcft0kPt5BOjfrqmXMxPbcNuScAG5+NmzEIGinPJ5e5Q7RqN6RMiswIu6dP5LHonXFxOpw2iBDBYLpbLHm4hVTu5glNuc/e7YLKa/2mk29vWqKxN/HfKEaUGJ3WAs2RemWRCIiPVr8EQN5BNaPMMbSlWVPVNwVNE/fF0dc6sTif14kFP9xZW44CYL9ORrEBjtYVYrlVhKY+FIPHpDxko0rRiRUAwKcdcQupx+H0NB9phXHTN7FeZGIOSAwkfs5ZWXlZRs+rowlMtGAyXQml+KJktNW2zlHQd8neGOt9jivGGZEsOCT25dQf8PP+PqJGZGG7GeOrnCATpV6Q+w1AakkJBqHGJ8VBejc/q7oId+Qr5DFMIT4k9m8cUMcjhRN2115IiSCcYd8CqNdTvGjNVNtXTFHn4S37KZLDsMh6Gpf+aRoruEz6Xjv63X7392NrzFzI0nuobBYmhBuISkXE+/7ELcJ7aqm24gDaftwu1S87wv3r0QNioqGy/Msu713jxFQknWOxWyz9Tnh/f+qkMyUiUUMNpYt7L4tqf9UCCAIGfoipGTZkxsjRbcQppmF+I3+fqPD+i3pMAs3bFo4r6hjlqcQH4u8KOB/i6VDef5Lv0lE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WU9NelZBSHdoa1l6eVo1amIwRGlMSHoxNG1ySTFNQkl4MFZMT3pDVW55SmFu?=
 =?utf-8?B?NFVhRnduRm14aVVZZEdHeVViREtYdEptendEZUVFN2pFeU9SWE1HQjlFNWFJ?=
 =?utf-8?B?LzhKNkhxNDZ4SDFoTkU2eitpd0lBRHBIMERncGg5NzA0VDhXd295QTV1NkxD?=
 =?utf-8?B?RFF2am93V2dIVHZoemx2RE16V1M2ZjUvMU9sa2xvbm55T2lEbGtyUHpNbHdt?=
 =?utf-8?B?aWU3L1pwTEhJMFpYSEdEKzBhTk52V2lVckRaUjNzSnd3ak5UY0JnTUsrbERx?=
 =?utf-8?B?VFVGek96OHRZczdsQkc5MUNyVnNpRkx5bkg2Q1NILzNNWlZOdDEyajQzRFgr?=
 =?utf-8?B?RXg1SkdmSFVPMjNZdXF3eVE1SzIxNmo1dVJjT2VoZzh5cEJDcEVKcFlLcE12?=
 =?utf-8?B?VzBYZEI3eFh2ZkduRHE3QlgydXJ0c2FuUTVQTllPRXh1QXB0Q2xZT1RyZEhK?=
 =?utf-8?B?aUxBT05kMzJSYlRORmN0US9Mdkp4RTZpd01wcjJ5WW84dEdUdEtBZkpjSFZj?=
 =?utf-8?B?Yjh1NGwzd3dZU2N1Qi94eW9Cb0dMWjA3WE0vL3FaSVM3UFZxTE96QXR2Wld1?=
 =?utf-8?B?Mk0wdEU2bmhXMHpmMFJ3cnI4Zy9IcUU5bGUwNHhkM3NLRE0yeUhTeFIySVg3?=
 =?utf-8?B?c1pVd0Z4UHIyZjNQRnhoS2JEcTVHZDRKUWx2MExXTkFEbjduaS9SRjJrcDhJ?=
 =?utf-8?B?alBpRGlQUEZCNTgrekUyWWp1YXBDUTM3TXBob1ppQzBUUXNkZXdxU3MxTm56?=
 =?utf-8?B?WG1XM2lFRjBwdDErN0ZaaW84eUdKU0FFajZMdVI1bVo0UmU1TUpiUDhhNnN6?=
 =?utf-8?B?bE5UZGpHeWpjYm1HYWIwT3lwSmZCckY3V3QzYXhZU0hHM01PVGx1QWttZ1Bl?=
 =?utf-8?B?OWJMcXFNVm5SeE9rVnRid1kzeHIwdk0xbU1hUCthTTR2NWY2MVFDQTZTcStP?=
 =?utf-8?B?YTErQXVlcWkwNEJEOEk0MWh3N1Fqcm1IYUZlV1h2SzBlb0tlVFYrMndaMFV2?=
 =?utf-8?B?TEQ3MFY1aTgwZVZjTTRSNnd5cWJuMjRibm40ODVkT1NZMjBzUUE0bjk2em41?=
 =?utf-8?B?VzFnaXRJV3p1eTJUaW4zbU1WVEY5dEd4TGdkbmNIN3RvNEcvSlBMdnc3TkVH?=
 =?utf-8?B?bWpGNG1xSnBRR2RncTdTTFVQYVdQdWJKeHZ6RjV2UnZwLzBGckJDYjMrNVc3?=
 =?utf-8?B?OWEvLzZuMEpIVklodTFFcFlUVlNrM0l4V3V2bXM5KzBFWmMzNWxHWXF2Z2lF?=
 =?utf-8?B?a0JydWFsQ0NpR1YxdHptUyt0WGtzbFZ4Z1BhRzJKTW9jVkRxTVpwbDJaZTRO?=
 =?utf-8?B?T0htUThBMkdxSDBTVEdVZXJkMVRRelVWeHV5bDMzazFQRkZqUDhMYm5mRS9s?=
 =?utf-8?B?anN2WmF0VlBZd0Z2d08vcVN4Mk1TbEYxOUNMZjJNRU5uODBWanhjS1RFTWtk?=
 =?utf-8?B?YmtKaEZ6NmV0aUVBeEFJeE50MEcyMjZNeVdvMG94SFRrUHdJK2ZsZkpSRExv?=
 =?utf-8?B?WmU4dzN1R1BrZEZnWHRnWkNyVWhGbDFsL2hxZ25DQ0VhWWJkNGtpbWx4QlNX?=
 =?utf-8?B?UDZXcnM4bTh3dkJ1cmxOVGZNN3Z6ZHJoTmtKTW8wMmQ3R1diTHFkb0ZRU0Fy?=
 =?utf-8?B?SmJZTjdtUHNzb3dTKzR3YityN2VqdHBQd1FCMXZubFNHVFdpaHZYdEF3Wm11?=
 =?utf-8?B?Y2pheHdOcnpRUnNmYTM0T0VDcm14d2E5WCtyeGV3eStIRVY2WmFvdTdOSXJt?=
 =?utf-8?B?aGxjMEpTK1F5b2N5b3BxaU9ZbTV5aWJrMVFFK1VkU2V6UWo0NW44Y2FsblRi?=
 =?utf-8?B?dXVYU1NKUjI2dW1zeStZbzIyZGdXSzNXV2tDcE9hNHh6NDRkcHB6SGJCaFdi?=
 =?utf-8?B?dGM3RzhzTGdYemQxSGJUWDNBUkhJV0RjM1JvazloR05DUEladzRubUEwTlRU?=
 =?utf-8?B?TndCTjZDQTU5TzI1ZmZTcVpNb0Z4N3pHSjhJTE9ML1c5Tmh3Skt5TDlOUUdI?=
 =?utf-8?B?RmtBQmZ2RmVINHFWTWZrMnhDR3RhMW4vcjU3Sm9GaDFldFZnenAvVTBLeElG?=
 =?utf-8?B?bVdPVlBZUFg0WEwzZzZNSmlUcHdtd21LdmV0UGNzK25JMVlsQmcyaHpOdXJN?=
 =?utf-8?B?OFFVM3pRN09TZEh2M3hFNWpOQUtBb3ZQc0ZRYUUvZXY4Z0poZ3NqWStMZVRH?=
 =?utf-8?B?V0JkQnRmaHRaKzNkRER3TnBKWlY5eGZMSnRFejVWMGxUZHJrZDRYVmdyMFFL?=
 =?utf-8?B?SnJmb2JIK2g3bWJnMWhTVFZwdmhsWXZVRGZUaGxac2I5S2d6enFHRjV1dVZ6?=
 =?utf-8?B?eGt0cHVBUnJQbFFBTmlrZ0V0ei82eDZBeTdSdXR3dUZud0tKMFN6dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mXK+QQLGa1pNqclw5IRqDCkLAYIMiNrgVWkFVMtu/OaAPL5kivc0U1FoojwabEdGQNVNIr3pLWzKkluJFUq97A5nZNAS8L14TahXTvo9+6/Z+TWdZGTEcq7wF9sYJNPDoGwH1BOq7OgyDWYB2TFNIhjIovxojzTpPYPOvohZUTETuwPjwGsmZNpNR0H4Pjgyn6mLGuCDxn27OTe/ko9Cdo6D1qkRmx1Cn8Fny8o0lIGnLlySXfzxiTVkagpyTn2AeNM33bI9PJhyBC1cbtSHkM8phXIQbJE9KZ+6Bezz5v6WeZgNhK0lEeTuXLxzCDUWb/cFD+FAU6Ask3sbvLL7j88pAEuL7hUcC3diVO1U08D0seRSm+DUD4ZZ4yWX49oP36XZVth1/daBI4nsDHIPG7g2ywcx+aPWYm7+G1PO79C277vCY7bqfdd7yQByfX/ndX1zZ7uGTs91QoFxgiZ/hPKrtzaSgffDH73M4xNVy6fPQHrqH1hQNm/9S7vsVYTTvDfXm+GZRS9DcBoxLaEdJPHoIWTXIHFew9IfODZzQ0gJuD+FCDf1/LmH+5Muzh//OBFjt8LSNDfB10QvTfeLFf8M/4baSehb9nSCR55MwHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ee28c0-b4e5-42f9-d9d0-08de787d5dd6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 17:01:37.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hx71T5g6n84XzcgCmXu2YEy9p02trLL5iPsMPyatSL57O7JNg6YoFmaAFQYMetANkmPjjaw0P7HVAXZ9Xe0+Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=722 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020139
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzOSBTYWx0ZWRfX1/225aWIQOxW
 Hb/j34muqmXiIzKYDYw5cujvVdH/CTSX991EwS2/ahLY8d2r2c2toVJjgkOZSRx3nFxHSlpYHxF
 Ue4p/C5KZJFvsl06pyJfkvjs1lBy/d/PoTyPguhWOWsiVblrnf7/jXh0sOikUfn9tv7AdHX/duS
 N3nPuNkWxsOEt0AYio6q+6nYj0tfOHk8+nCcbs5ai+A5G3vtzUu10nceLmkWUtyR2MPhpbxDH56
 o7Scw5K4+B+3/z+2tbx04Mu2SClXe75LFp8SkAovTOcqxLfr4UVggNC7SiwKOMtOuhMBsW4Lj9I
 eLInaIzUNkio4RgJJE5RIWf8/PhnXhTXjjIksl/kJBmiZHqvPJLDAgJWP+MaNAFk3NCx4nmpEWF
 vZQIf60JRWgHWfhS+c1HwNRYRGHWOGS52IAbQCCI9vlegK80iEtoUnq2XvewwsxXt6NGG3/Q1R5
 lWLl1TiEUJEuYy+XkREY+CUYp4vQu0nmyqZhBeXY=
X-Authority-Analysis: v=2.4 cv=ObuVzxTY c=1 sm=1 tr=0 ts=69a5c278 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=WHUxydz_X519rBHM10UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13810
X-Proofpoint-ORIG-GUID: _dwX60KMdPt3al6gelA1PrGlnHq1aynD
X-Proofpoint-GUID: _dwX60KMdPt3al6gelA1PrGlnHq1aynD
X-Rspamd-Queue-Id: 76E981DDA24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-78941-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:dkim,oracle.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 3/2/26 8:57 AM, Chuck Lever wrote:
> On 3/1/26 11:09 PM, NeilBrown wrote:
>> On Mon, 02 Mar 2026, Chuck Lever wrote:
>>>
>>> On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
>>>> On Sun, Mar 1, 2026 at 6:21 PM Chuck Lever <cel@kernel.org> wrote:
>>>>> Perhaps that description nails down too much implementation detail,
>>>>> and it might be stale. A broader description is this user story:
>>>>>
>>>>> "As a system administrator, I'd like to be able to unexport an NFSD
>>>>
>>>> Doesn't "unexporting" involve communicating to nfsd?
>>>> Meaning calling to svc_export_put() to path_put() the
>>>> share root path?
>>>>
>>>>> share that is being accessed by NFSv4 clients, and then unmount it,
>>>>> reliably (for example, via automation). Currently the umount step
>>>>> hangs if there are still outstanding delegations granted to the NFSv4
>>>>> clients."
>>>>
>>>> Can't svc_export_put() be the trigger for nfsd to release all resources
>>>> associated with this share?
>>>
>>> Currently unexport does not revoke NFSv4 state. So, that would
>>> be a user-visible behavior change. I suggested that approach a
>>> few months ago to linux-nfs@ and there was push-back.
>>>
>>
>> Could we add a "-F" or similar flag to "exportfs -u" which implements the
>> desired semantic?  i.e.  asking nfsd to release all locks and close all
>> state on the filesystem.
> 
> That meets my needs, but should be passed by the linux-nfs@ review
> committee.

Discussed with the reporter. -F addresses the automation requirement,
but users still expect "exportfs -u" to work the same way for NFSv3 and
NFSv4: "unexport" followed by "unmount" always works.

I am not remembering clearly why the linux-nfs folks though that NFSv4
delegations should stay in place after unexport. In my view, unexport
should be a security boundary, stopping access to the files on the
export.

But during a warm server reboot, do we want that behavior?


> -F could probably just use the existing "unlock filesystem" API
> after it does the unexport.

-- 
Chuck Lever

