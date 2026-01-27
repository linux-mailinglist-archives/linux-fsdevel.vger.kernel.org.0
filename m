Return-Path: <linux-fsdevel+bounces-75606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHf0DK7LeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:29:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C368C95ADC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB4163096E54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E53B2BE051;
	Tue, 27 Jan 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pK1fDItV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eu8RnQMS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61235B627;
	Tue, 27 Jan 2026 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523813; cv=fail; b=FSaBKyATF/Ms2GYvMm+4QmB4Kr0iY56dcnZz6aI9siG0WxRksICS5kmZ9gxVCv79uwlaMVAPtYrwE9wHGMS/1Au0m17wWE/qcBnJ6wmYZG1zRaNe3yh2kvbef83l0890DWkeYC5kUpp7iRExU040tcfqNT9ExhWstMjHJ1CWBSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523813; c=relaxed/simple;
	bh=DIKutYrVFXvkVz4mNTwEfy7eLoNqpiU0HYDsBw6z+00=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=pfPe82X7rt1oCrLqcuEgSDgbONVwVmfCkk9osuGPlbM+G146KlS62CtRvnpNCb6OTUVG/upXKNgyuCK6aapfWDjlQ2VNUUroABV5l4P3cwYyAHL1Nxhbm5o5X3uW8AZfekZw/8AfPBE7imaqImIB5H4rqw74zzSHy6sBN7ojQhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pK1fDItV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eu8RnQMS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEfZq4056597;
	Tue, 27 Jan 2026 14:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ikF3yr7fygqJDEesdg
	QKS45Z0IzzdXDKYtzFU6KLMhc=; b=pK1fDItVSmxKY4SWZenwTEve97di+ejsz4
	FYGRNCXgSLJ5Cy7Q57UzWlXrXrIq5K9v+r1bYgWmH544sL7PAMnJ8DatStS3ZZWK
	bIy+V3zf6Z7JPgK4/iB8NJY96dZfWO+yIKA4cfSv7dpIPKHjHpVDou9whgUDg3Ny
	UQxIcJ6Q3uT+CmquCJyki/pOi26Xh9YtsjUWUQKQD1b7qKSppFyhjjAI1pcgyaXW
	RecctoZxAfOnDPLYvUFkE+fnWxTOi2XeH/I0aA4KYU50atYx2UlO8jPDThu2R0Ux
	TqMUOrWYQ6kcbsgwULvOOljzyCNmuPYDT1H++aa9btF6SYGsgsEA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvnpsc2ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:23:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60REDOjP001797;
	Tue, 27 Jan 2026 14:23:23 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhe0m6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:23:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfs/JuJpaZe7rVNbd1kXAehgGW+mGKY9rCoPNDnRaaFANxqZyrFTWCEC33T/Iua/cjwWMggZAp6m0hEdwwWmQuI4XNn6MlzRg/ywkrwCHavbDx52Bkv3qtP9PWqWFxghIccDtFjpwjPP5NRrhSQtLO21iSvX8fNJkLRkfwLEEbnCDk5JEmipRXVOJIPuD4oUl6S1Wi477fZUdRigVnGwqJveAhArW+CDhlMMgix5Bh0L4WMGFMzt77OTc8GhSlGifCbbgRNo0iowslt/6UOtht+VHem5uSLGZGGllrhhrgvB0XLtEgKCRWPhJiSZ8aiY7ELiRBT1iOubAUQXYwsfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikF3yr7fygqJDEesdgQKS45Z0IzzdXDKYtzFU6KLMhc=;
 b=yheOw0XQQIObLPbR7wfum1DI/ug3oV95yj4AJsT67ziKphp8q3FExqeDUry8JCrCx/CQKBhMdx5UhFZzcvXSijbWEugnuW4BB6pjZHMv4hap87c7+EZfzVytVL8OXy2U6NohPVD6h60MmJ4GvigAdrRn8XEfg2jFx7b77U7GEdRE2UrBfmkH5XiZqV5jpYiRChisB+Y95znXKLFAG9hhbcx91H8UPlGAwLzsogtRGMPNnpP/xRM4qoSow1mjyVOT/rYouXDY/BQodBUtxaQc8rdgq6WpqKwMsog3ubXwCBCgcnGYgsCT0GLFNPyT5vsw03NBWBL4M2x4cR/AAa+7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikF3yr7fygqJDEesdgQKS45Z0IzzdXDKYtzFU6KLMhc=;
 b=eu8RnQMSw1ka2Z8UvC/H5ldeiw1GW5Q9lLUbB8NLu5cNqo1a7TTX9UV6nI+l5fuPK9MVtefDqV3Mp6TI2AkAVR++J5PiI+osTNa6VrTKsGGJvlGPzCIuVOvfhtIEoTJF0VWyz/vJy63ujfsV786sfMOKbnC0QSJmJb4K29k4CFQ=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA2PR10MB4538.namprd10.prod.outlook.com (2603:10b6:806:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 14:23:02 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:23:01 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/15] block: add a BIO_MAX_SIZE constant and use it
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260126055406.1421026-2-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 26 Jan 2026 06:53:32 +0100")
Organization: Oracle Corporation
Message-ID: <yq1a4xzuocn.fsf@ca-mkp.ca.oracle.com>
References: <20260126055406.1421026-1-hch@lst.de>
	<20260126055406.1421026-2-hch@lst.de>
Date: Tue, 27 Jan 2026 09:22:59 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::17) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA2PR10MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: f72f2dae-06ed-4b9e-8396-08de5daf93fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zopaa4DTybdfSSMDUCBXP4KhyOCEsMnYyDZCMhVBBTLJVDlxl1TCf+rXgtId?=
 =?us-ascii?Q?PA+i7vcBIjUzmuPR+WOZQ1bFXoH913Fr1GvljAm4JBMMYHiz7JvgvJG2tdU3?=
 =?us-ascii?Q?46dqn+kchu5KBTweTwnN3+WfG0lS+K4SLdN4umOGmkBKMDusL6H6OfJZs8nS?=
 =?us-ascii?Q?TbTAXyZoRV/XWXcl1zodOhgtZKTDlJxJ9RPKHzGii1UDIXBCUlk4p/gfUKk4?=
 =?us-ascii?Q?sRIxgtGOjkwHofK1PpnoE+PVGjGAr6aFpShsRvhPlwA41rMWD3/iPg0aokXJ?=
 =?us-ascii?Q?A5YWtIc0Uqr+Tpw/F1/8LsQkCfGbOZ5A64iJi3FtoBgVKCfoylTVVd3BfoiR?=
 =?us-ascii?Q?0utbqeXiWxGg3gLoTIAQ+3RMUOJWsduoDdgl6dkcakCWPe+UPyZCaOtwLDoE?=
 =?us-ascii?Q?xMgYqa/nHOFMKgD+D9hW8KYs7tZbi3pgouQnd4qsydFezvxU0QDoF3e3H9Zt?=
 =?us-ascii?Q?B0lxYoVx/g73I1BMz9mxrXirN4LDGSsAvkPj0k1ULRCKY/4ZPYMRtJTrlCu3?=
 =?us-ascii?Q?GTiLVdIZ0ummCK8yv8JC2aI18nybPNBM7ZVWFDAwr5TXVwquupwUUZ+tOG7e?=
 =?us-ascii?Q?vPOrcXb9Otb81EhKJ2xC4oMkVvM312rPjG4s1jZuI+YR7LMNuLoeKobcMaMz?=
 =?us-ascii?Q?HeChi8JjbTA9PQVShPQlcKuHZGObZ8Ca3RzNxdb5ko14JRuliGaU2hX8hy/K?=
 =?us-ascii?Q?HkvkRG7l+U3U3I96S7MDVGU5Otw0r2613vqG38bHamp0U5lwhl0Ju31R2q9S?=
 =?us-ascii?Q?RnPKJlmvptO6UWqn9wzqHHiHC3JJtNRE2dTA/McSiSeG4t+SFlnUeuncqE9a?=
 =?us-ascii?Q?Pd42DmqwLShR6aM1Vi86v75mgAQh/6bOAwLO3BMuq1VInevURy8JrB+P0eif?=
 =?us-ascii?Q?EfkfQqs+nkbdQUp4h8Bf1moZ/flcPwyqhble0PMQWpPQMde1GYNrO1eGwUNo?=
 =?us-ascii?Q?RbARCdq3/CPyAWXqyRLKAFRSbM9zpfEGXiTQQhy/zYm85X+BaFq3U+5/GimA?=
 =?us-ascii?Q?UjgM1JRiI25umaJajSK2SEP4EI9pfx/dc7J6QwdSz315DyL7P8Re1iPXs+tR?=
 =?us-ascii?Q?zvcIQuq9Aka6ioMM2vYk/d+Y8ReJhzNlN0RBgHKLgiFvJUqqns/8k7v0Enio?=
 =?us-ascii?Q?T5zGA8cUr1Gn1OOMPdUIrSF0FPEZfZeC+kD5WcPb2pPLTEClRMrJLy7ZGKky?=
 =?us-ascii?Q?zhpyJW68BgaiOwepMuREzXeXUZ0hGJ8UZoIzZvKrjcM1rftWvmi7SoHmMsc6?=
 =?us-ascii?Q?uYiCOlLi8bkblKvxzyFU/mQRxGaSw53Sk9VljIyAiavNMQ7gnOMRdepRvxnT?=
 =?us-ascii?Q?18U6eUb7S2PP6HF7bDSaTbb1I3a5G482uN5J1rEVApeHQfv76wXXebhn53z0?=
 =?us-ascii?Q?A7UUsIOsOhKQcUS1bHnXEsKw/cIo/FrZxlnXslXSqsUvmdIUO1zl5bIdA3Wv?=
 =?us-ascii?Q?jZPo4sNXZLszD6awnYvVNGSTxie7e7WXxEEhig1Fxgkl4fPMSSliZcGH/usE?=
 =?us-ascii?Q?On7cfSdX0byD9krbu4tfDc7BZXWtGK0Z9i8HDxwd/yF0tY1AhBtcG3Iwa7vm?=
 =?us-ascii?Q?hlJE7qxqpZg7Gujg1ig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CrM/GZIi2JOGqdRWnA3MTzoFAjS0RwPgxrOLooics7j/XQ/zDDRxy9Sq4uBx?=
 =?us-ascii?Q?/Ev1cJRdfalylRTD/WiCwqVBbSJ0ZsCn4ycUuwHYEswbqKjC4XU4WLak4Eph?=
 =?us-ascii?Q?PjisH2jOI3rT9rkwOK+dlwByoCZwZoet/uUwURVFJ0nBvNjHiCb/C8ITiPjm?=
 =?us-ascii?Q?iPudEXyWGfpFUWezWs4+BSOwvuTvG4c+Ar6m/OA2X9eMwFE9Ghm3fIAkHLfr?=
 =?us-ascii?Q?QLQwlFkpKoJcqz9knfMNNApvOQ9xU7/oZxn+HcyLCKL3h1IZPUazk7ox4ESU?=
 =?us-ascii?Q?WdcxKb3RRA3u4tTxo6aNph5gULTmQ6GviTWabBV9HUU0VKaLQ8ORZEU3CO4Y?=
 =?us-ascii?Q?8etH14/7jodOnKacdTcI6K6xVFrZ/C6WYQ12jjfpIlR0GhcFrb2Vz2z8N6I/?=
 =?us-ascii?Q?iSrPf+uvZjXNw01sVeLFWmMIUVx0OQwZUtAgacl2Jj1EMrOztjlsdiqb8kRF?=
 =?us-ascii?Q?3+UFbEewDytDpcBrFQ5JIVuECoygdr7+UIPljO/3V+OeYyE/FwCpHNChnEgB?=
 =?us-ascii?Q?mdqva4f//1nts7YRb/W6h4xjkUQqIcJq635JXdBMyx3jWR3SGwn1kFCeBY6c?=
 =?us-ascii?Q?Kk6H/Oz0noxv6/FvR6b+G+TS1earu+hlkvdAQATq3mifk9bs2WRcw5iEZa5c?=
 =?us-ascii?Q?TLrSszOaevY+Ua/741D5Zh2Zj3hoyNr6etDu5o2p78XfGsXFk2hBU0tR2BVV?=
 =?us-ascii?Q?zauOgxOejP/fB0MvjheRXFibQVI2ZxF9uMAN/39UXCdAgpJpnxPFqOtcCPhI?=
 =?us-ascii?Q?R9iI9tzUD6LDZ26XGUy/iNHS+GYGAWNTFL3+A9csdGrG8NChnBsrlLDzO/NJ?=
 =?us-ascii?Q?J4Ar5iAUk0GYEZ3KxrP0QtK88BIz9NvseT89U9f03l9snoXLN/YM3yadsUeW?=
 =?us-ascii?Q?yi6ao4gooJpu7GJJN/kj2FhWiPuoPYJ4+9/kISFwtHSedQvtcPSpl9FlXI9p?=
 =?us-ascii?Q?U1ze5kvQb9whZkxjTm1NBZPNVsX2XoodI8Sno42N6ETuaDHwxXpP7U4BEARH?=
 =?us-ascii?Q?0bo0rBAtLS9AUfoPShcAguL+3N/irE7Jl2OaFCJgGhkFDYYcg8TZDzJxVrNZ?=
 =?us-ascii?Q?nz6l4S9MslGefIMqXOfXfB1V2xEiGQGUEXVw/vPryh4XSKW1iuITvyqCMyqi?=
 =?us-ascii?Q?sYD7z74zZZ5/FNsSlF6/ci0RuT6hWl8ToEHZ2fjRqQ1OQgXL5cXPKZrbKoi0?=
 =?us-ascii?Q?g8aq6x2L5oTPd2GGioKYAzHKC1dM0LTxGGzggOcOr1PRyZiE8NG4gDbBd2EK?=
 =?us-ascii?Q?ASNs/bcrF8h72JD8peyzXW8fuWeUr+goiE7QSi/30q79HeetaeTSu3ZzfZdw?=
 =?us-ascii?Q?t4Gx59JsBkYuAvZCcE++Z1KznB+54jvHgJZMODZXL6MToMYSobMrrPW5guP9?=
 =?us-ascii?Q?z5d/2pH2FoHsQEg2BPrNFXm906VOBUaLgppsjrFjniyDr5eBVeq7Sdj+u7/l?=
 =?us-ascii?Q?gG7013sh6W8SxERO5zgsSqvo9F4n5a5OUQ00ajcE4zGYFg+9/r/hrD38fRBU?=
 =?us-ascii?Q?Yt9U9dZlWmIdcjhcn22vkvgOz2PCh6HEMfFnLpKVIAWF6zotGhUr8Wm2uLV5?=
 =?us-ascii?Q?9r8Q4CEQ/r+HOpJtAWGi3ba1zBvB1oMhVKWJMc0ulV7nwQpBVVjHAxIwqsM4?=
 =?us-ascii?Q?K26PsQfkE5klNJxA4OekkCHAkQKs6rF/k+K4mBcKbjjuNhcF38Vis3Cj/4eX?=
 =?us-ascii?Q?3nqBX3RV7Xkmb84DQTnHwC0gMkKtr3K5h4gjHTVt/koEAhCOjL7NuB882vFU?=
 =?us-ascii?Q?IdsYoPeiY/i0VrsSb9eBq5MbeDAOSn4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TBtSIJlJNahNd93zOeoMu347W4F9w3wM9bQzh/MQQ7uLQ6j6EvatXNlT1dknJcrgzMtLzeqHzdIfW2YYv7L/4nIfRKlitTmEZtGZkXSv3f21bPqwKjjxOGaKPqscq9NWFxF8Yn7guDWBn40c3osLZY4pgGhnEBsWPLZB7qoGrDrOMN0vFeFN7QUfiSo9xxZuCECDBoohmXU7dBt1uakqD+FBE/rHPBVq4fLETYrPGwD9fcVA0+hQpc+A16fmv6RrPB98/EgZdZdYsOfEkKRIvPZYOsSg5fw3VdnxuGt8tpqo7FLteQJ5qP7sxZhaCqy2Q3au8euok9wmjiV9PVQFj6R9YNSygs5MhZyIH4mW8jGyf+1oSbrKyh7wyRl0p+IxTUM26hkgpm+L/vfB2MXF/xVHFeX4puEzT8n7oB7yrz1Z7rXsKpfnjY488FrHtOXp0s3P6kGNbKQgAEz6ayNrk4w+05f+p8zI4IvYLgP2syo3X4vXBA0lGLALmT8FNy1kSXXqLgxTwSXbpSKlQz1YFrltQhyuPw50UoqfmRYRzLIaSsOp3Dm1nRo0A1A4QCBTSudXh8a3qd0xhOeYMlgaOm0fEvxG89h06rm7vSVt0Kg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72f2dae-06ed-4b9e-8396-08de5daf93fd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:23:01.7927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhYGslOl0iGfuz4nCMSKKYh6cxb9IAzcGkmyfS7CNfV0r+e3vPo9hxmxGm9ZiHH9s8ma+7HISgqEypwrRl/L3gviIlszCa4Noyg+pDxzX50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270118
X-Authority-Analysis: v=2.4 cv=dY2NHHXe c=1 sm=1 tr=0 ts=6978ca5c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=piP5eN5RsAH79KfBhxwA:9 cc=ntf awl=host:13644
X-Proofpoint-GUID: NBF-redfIBu9kXzlHb66YlkiW32qjPAt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNyBTYWx0ZWRfX0a55MGsE3FtY
 W8Iv9/KRrbMiQJYXM+JZf7+rnovmnNcdpntJfmVEnq1O/aLyE4Mz8w6VIvwyCMN/RQlmZmnF254
 mJxK6SSmGrPUSNuxSudnjbXq9EgQWi3aEddx88NIKKLD1ij4pevzqYW7GIarOqysF+SzsHNfjom
 XWH3id7To3TK55Pgghpsf0/kmQu1cG/f6BWrK3HnWraf6DA0hYcVJJ51/wYBeCZQnenwR4+aNNd
 CEiwATOVrhuhZINuLuCtgGP5YSQhAfbOmQSrzZwrdqLrR2xYxS+RTxPFvdsdsbPvoDWzWip2J3X
 XgvEIeR9lEir6ghsD8ZBpVyXpawRhXPnpprDd85zoGFxyEiu5JLnoE4szyqw3O9Bna1ISKLl33d
 hOYwMbtXyNb3Z9hUV8BUqjedcLl1wCiEfJPs3pH9TQY/d5hKvKU/2UnjX8xUv2r4WgU5fA2QiKa
 zXROXTTzlwz4XFoy5nA6ZxpkhEDWNQBCcrAT08bw=
X-Proofpoint-ORIG-GUID: NBF-redfIBu9kXzlHb66YlkiW32qjPAt
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75606-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ca-mkp.ca.oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C368C95ADC
X-Rspamd-Action: no action


Christoph,

> Currently the only constant for the maximum bio size is
> BIO_MAX_SECTORS, which is in units of 512-byte sectors, but a lot of
> user need a byte limit.
>
> Add a BIO_MAX_SIZE constant, redefine BIO_MAX_SECTORS in terms of it,
> and switch all bio-related uses of UINT_MAX for the maximum size to
> use the symbolic names instead.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

