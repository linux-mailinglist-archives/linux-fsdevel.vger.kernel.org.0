Return-Path: <linux-fsdevel+bounces-27064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEE695E41F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB191C20ACF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3478158D79;
	Sun, 25 Aug 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HFSXy7Pp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i2EYYBWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF01FA5;
	Sun, 25 Aug 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724599058; cv=fail; b=ro1mfL+CCyqfvsCeh3XxfA6YziCrX6cWlLFMvWSQSrNV0y0iKrYIsv8E6trhuocW1KGvTQ5i1DWBYFN2zHrOiDs7JmuQ3O1WIydsFqO0x+Xty9diYAuuBwkvBq3WtFvW1vgWR5hlyYgqvqkmzjuenEwiInkXjDadx9avuJoTVQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724599058; c=relaxed/simple;
	bh=tOmRzoJannEUaHa+GSQPUyjo0LCzJ1B4le+YDKVq0Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sEGwFKXM9nIMDUov4gwvP1/Bt6ttiqWEjYBzRhpK/LogUHQYRfk3iOkWVH0SP1LvD5GEj98y32/nBl6YEhH7YHzPwGfu4y3q8f6AU7zWHvUqPUorcftedea2Kb6+/3Ykrlw+/zm08hIP6H4fOxtPfWNsa6Hc1mOYRAtVXbJ5jh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HFSXy7Pp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i2EYYBWx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47P5t9BA022253;
	Sun, 25 Aug 2024 15:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Nhb1Hkld70ksaK1
	qU9iucVUOsNmbwnNyA9Ue4sT8JPM=; b=HFSXy7PplONrzhzHX+6n+60EV4N5Ikh
	uHvM8hGzh0JtNbi1SlZ19v+TZIVSeev1fGNblMfK+cvT/zMhZNG5Tnje32rmKJR0
	/9dHnMBEo7E3W/+EfAkMzZnlVobQtQ7gf9I2TJJ9LYxt11ygyfu5oTY6BPCfpjSH
	Dx0BfYOss57No/WJTe3VfkDc7nI+iBZpmIYZaKNzro7u4S/b222afbBM2coeQeKb
	21LRAwFqREXpZuq4oSV6/jY4xdApwcZFC1yHftqn4WfyKKiIePTLIjFkpZK4rcpS
	N+NWfMSyb84Y/u5vHKz9ImdyzKuxVHVqtCRU/+vQH/FEMTEx20DE+0g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177n41kc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:17:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47PDxUNk024876;
	Sun, 25 Aug 2024 15:17:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4185yu17ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXfvyAMbbExz3Yh6ugAeVxy7lz6nz7+i/YttrBpidfAWo2aNmN4Rsi2tsMGE8za1Ldo5fb8uoXIk25MINmiqCvnX3zAByrv3VtnskK33prpvkyJ3vWc6nc6Du7Qq74Z5BPMSnK+3udBreiBRsCC7pf4bG967Hp3qUOMD21ppyoWGoFL/KpBbKxiOvCM6HCwwMNIG7YF56VQPNpB29BRXGKPG0qWPUV335uOoTgYVcN5kU+X/zseKCZNS5zXcQhVUvYoqTKdX5LlMFIGTRojFABbnRBs2lcw2glnro766rwCaGxov0nN6jQvbAWo8OZZJbO+3OpJVxmjCw+DqNS2MaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nhb1Hkld70ksaK1qU9iucVUOsNmbwnNyA9Ue4sT8JPM=;
 b=xm3GsjP/7hRz3fvChiPFePFidenKYyoiVoragisycDbZcKDUHZPiXg3RY2STI2m+VBg++Sluuz5seEdRYTFIfI8GtFSEsGIW/I4c9e6SFeqbJyxnD8MKpn0P+M/EqA/5vOM9Ah9zr+YD/NzgA9x2fN/zsFScUZdknh1FNfEVaRORnkTeovhT/ihDg7FoeKKayuj9DQEJdVjkTVMsKL5TCmquZXJpWD/pkf3EPk8N6xFzHD6egDNhilt2levVGiEy+XJ9/8JDCDADHeU3MwuYbXj/ahp/hfGwUj7cZReCv1a+B0ywaWff6DwBNlqUActIdLrOcqqsmA5GwiuOe1Rgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nhb1Hkld70ksaK1qU9iucVUOsNmbwnNyA9Ue4sT8JPM=;
 b=i2EYYBWx6o6oLnodk4/GT4GP/7SV/+c0mSyrd92rAfoBGonp7300sREBrXFws9ZNq+Ev7V1ZwRB1gO4OS7etBNIa69gcw0cD1aoOl90v2lz+MhzNoorBegqQG016j6G8Z39ObhBWPeDpcc/ukAFyYXZgJIJdhYZ+KmdpnKY4nUM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5646.namprd10.prod.outlook.com (2603:10b6:a03:3d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Sun, 25 Aug
 2024 15:17:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Sun, 25 Aug 2024
 15:17:03 +0000
Date: Sun, 25 Aug 2024 11:17:00 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 07/19] SUNRPC: add rpcauth_map_clnt_to_svc_cred_local
Message-ID: <ZstK7BKf02uD17sl@tissot.1015granger.net>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-8-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823181423.20458-8-snitzer@kernel.org>
X-ClientProxiedBy: CH5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 5839ca0a-090b-4e36-a79f-08dcc518f92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1k+e0ggC3iHRg7gZ+XIdxhBuhtJ8xFIadhjr3t7nxDC3DDaq6V6iONQztry1?=
 =?us-ascii?Q?1hcVCiay/iHpNfDbYyvNVCxPkuImYiXOMzzujKntQp1/Dk1g+0MCHKhC/Fxy?=
 =?us-ascii?Q?xmlQ13XBmGvvpAi04OB/rEuVtOYDA+NSmYzuv0iY63DNqDRL2EY4Y86bBWd9?=
 =?us-ascii?Q?gHEyZXD3owQ+QAqxk3hKvT0CAaY845eBi5u8XQqAUc/+X1MKrwVAOsp/4c3J?=
 =?us-ascii?Q?uEha1J5XDvQ2q0LVaqdAFzBXNpOOwYk4ufnioaaVAdfygmQZCLeOXzFkAAC7?=
 =?us-ascii?Q?YSz1NTQqH5mZvKe6mIkntKT+CM56i1GH1b+jhwCP0eEwLixGueX+ZVgXa1KF?=
 =?us-ascii?Q?DAMOIncswHsry2HXxc+GxPR+ukPye8mvjEqYbRSK3pQVx6DQ6+Jpgo+gDP5H?=
 =?us-ascii?Q?HnuWrdVFTfLtLC+tU0vlSRWbZUgj0Fpwxrh+caB9DlmptB/ao/zTlx1HUdUO?=
 =?us-ascii?Q?f9SnGCEMmEFi7vgZjMhJgAzv/84L2dYUo7Gu7wdKrnLbpB/Yxiie94v4LVsJ?=
 =?us-ascii?Q?+K4T0GR4FhOxv77DDeP/Tg6KIVBZBcabk41xvzP5kGZjnVleYN7XqcSB3KZ7?=
 =?us-ascii?Q?CLWjK6yOTfQY4Opr+uTBHgqLE/GYWWcD1ltszvk+rYIHAuxVN1Inv5RgaoAz?=
 =?us-ascii?Q?TSQy6VJ/hXGANI4/FzkXA8wDU4BsvrM+ch4VT6E1Dah0m5d0cria9hF128yX?=
 =?us-ascii?Q?3RhaLuffryJb6Eop1+HJzMpBAo4+1yv8aWa4/wwzSNCzaXbKca1iiXygF5Bu?=
 =?us-ascii?Q?nBMg1DoAJt2araL0zvYr5/Rl7bcsbgM5BbGErsc8qNrlHRt69fPOU9we8JT2?=
 =?us-ascii?Q?plMzBqu+ipcPp3OvPXLTVHxltwqGo/STatyyJGYxLr5jw05nLti4iifymSG2?=
 =?us-ascii?Q?rFfBuwfwEDVnmNHB+kKtibYjOWr+I0hDJJjA5HDAbCUS0C54DY0O5emWf2FH?=
 =?us-ascii?Q?+/FljLZUq/cqBW1kBszT/LbtGzgqIOAHyJ6LN+9MY2K3eFdPVW9qCzMvEXbu?=
 =?us-ascii?Q?EEXaBbPfy9DbEbzxE8vt78w7Zyj0Aun3KjslhXjSqmAIPWBHZ1h7CpBHHvgz?=
 =?us-ascii?Q?U8aBChoSCq72fc2eVrIO9JfxJn8Cr10B9dB8CaIXCu2SGLs1GyW3+Ragbqpu?=
 =?us-ascii?Q?p76Mbb2kMkXd4wdXKH91DqrDhUVyRtQpXt9a/soeGhpU3SsLL4cOUray3Fkw?=
 =?us-ascii?Q?360VMZfLVgeRxMBpowJdtn32dKjIUg7skzBz9wyHYJJHwyr8Fw5Rt1YS6L5k?=
 =?us-ascii?Q?TXUhZnc01dbElCWU1bKMbPWVKmABGddlQV6vtQNqIkIcxtjdBF0iFrEHDfzS?=
 =?us-ascii?Q?QDlLi7UmE/XtkFC/TJFUnvpt8wQH5LRLtWkZJXlYDCAEIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xjLSAfS3ozp7YagQmvg6WLjYdCfDS3RDmEFWOUAKJ7SK60a/zHIXM1/WV8Qn?=
 =?us-ascii?Q?LBzxMy+v9IEG4REE8D/wlYc1doIzYzLaHSYbnDPovt5oOaSMLNMbQl0e24YN?=
 =?us-ascii?Q?0lfZTZMl3hjWUKAoq6EUR8kJuH7So0D5ipa31/nI9bt49m8wAw7y4fLUxk6/?=
 =?us-ascii?Q?3ds5I5wBtjOxrNeTGSIHqpqVvFnzfq5SHreV8lvn89e8BHT4hasYcQe7RAt/?=
 =?us-ascii?Q?t7MKz2ZssrFHenjECTz0nUlK/Fb56xjrAm2KYfSrt6UDDuVx5+jt1sOxpOld?=
 =?us-ascii?Q?zHiEjJ2WoYTDFXdvFYGLxTBEY/gy1ymTuT+S9rMLQtGiiybHGEHJNuaFm2uR?=
 =?us-ascii?Q?xjibO9eTQfx1zwf/lapjVVVBQTf1nz6YxU8KHrlSSVF64MQulllaNCPpBun9?=
 =?us-ascii?Q?4EMNssYI4/UNv1PQAYGgv4D7sgR7NjR/yHg0TZO1bwYmm3oGKwRr9njf9+nc?=
 =?us-ascii?Q?eaIPsXK30YhYUiwoxouduwtBF0GYJZvLtq1j46tjjoC7foMwHFj580MFJkWv?=
 =?us-ascii?Q?xkhQhGfX+BFtu/6iXmETiGf9ZrYFFwnykqPJ577J59erOV7olmUyhvnVkhgZ?=
 =?us-ascii?Q?86aBLQpRGH/2IWleMnIiY7lk6jkiGfXPEXtr6H0NLw8J70dO/jW2FIInyq60?=
 =?us-ascii?Q?3OoZl/jxm0alJSuwtBtxSksdqeaQxdnd1TZFXa52D0ZCFBwmS5K4NxGH8pVz?=
 =?us-ascii?Q?lGocPIkCPs+hNm4N4uZaNh2jbwKcavXvPwc9YrkJ6oaRw6FgAm12U369wUt3?=
 =?us-ascii?Q?YBk/BkhcVrv+cPOrhil7uTxUwHsypxNtxwK3edGcS06USiVX+Et2XtXcAotV?=
 =?us-ascii?Q?a4eKCoHeSMQJXSURWxeuANJ4afAAJkEO7OmI6v3fcCAwghEdIDjKbwIHvGWc?=
 =?us-ascii?Q?EGo1VdYBZJ5M/rTtCwAF1ybciH6mpZ+EU5kvzwkxm0AbCRn9Y1Idb28SEcIF?=
 =?us-ascii?Q?j8WGjFkT1clhBFgK14YhtAdFvkc/i08Cer8eS1RXDTU/Zyd+hkzHYYqAz548?=
 =?us-ascii?Q?/fAPO4kNT4UGH4KhEKkvtNTgpOpTQqkDb2NiOiUwVOp4J67YY3jTO1LFu94O?=
 =?us-ascii?Q?sMexgqlN9CF1TVmsIDk66LZjbZilP5jbNPK2KpBjVgos8SnGKRX6sqNt7OP9?=
 =?us-ascii?Q?t3MhnK8ycJYiaYHkpQY5knjEi83o3GmFmfbG4nbQ3iu7nv642Rbp8uMD7tiP?=
 =?us-ascii?Q?IyssMYyj1NQ3eU7/Mz5VxzX5RDtS67YNhYX6Td7ArA6i/qgZrWvEM7ZGKswX?=
 =?us-ascii?Q?+MIFgk6zRQ0XyCJpuaGf1V5Zxy5/kfNfo44kr1JvqCOHF8G+3g5MheoGQm0x?=
 =?us-ascii?Q?Acahdo/50QA4aV73ELDoO0HcUwfF8mJNXGvMME4e6nEdctmGWPQ8rXuSnP0k?=
 =?us-ascii?Q?GNiZM99G/vgqpRWqXbVksFDt3PaDflZ5JMeUZnPmiEu6N5dzMCuXRIfCMbb9?=
 =?us-ascii?Q?XY74DQ2IQKKFI348th8LqVICjgADmNnOcCpGMDvrKd92umlIrucnzxZtI5cv?=
 =?us-ascii?Q?L6vl/peN6H5vSHQDYXCrl6drBrs3BU2SbrRCi+XmBP0WYauZhClqmY12pdQt?=
 =?us-ascii?Q?JkCaNe+icVELsPpKt8PsFz+y5S0u+rrEvnOpy4mT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sWVlcCJOLkxNwyDioqS5xG3UejDKWswH+RSjrp05zVm9RDPvmt4fugw2h7z2S4QWxz6fVf8ZV/+j3eLlRVE2MgAEZfyZ07swlHXbBqwdsbTCrfE2660d1it4NHIpJk7EDro4O7GrPNAiksYXeJ2Wijt4ZldqI4yNaGBmSJw4XARoXmtw9VEcKNCt+QZSuprsw5MEIf71eLMBaK2DZaczXGyERINhmNU3iMkvuCrihFG2zhDKzLh9WVSitRCI1wDVCHIZpmGEafX7PrWGZOr3n7+m7ACOZQCye3+iNS/nps4RBE2fryBOrB2JoGq9xH1aZ3s4evOZIHBibBBZ3ghQhO0Uu1XOvXsTxf9+6Tt9/Qwvax0G1AnxsdM9gTYwFj6rmzfkc4kThB1fjRTZRfOeIrmyZkaCL8QO8aynAmGnAYFXcleev0CBi4AiZBKyf63E/lRJi/aROFDA9U37i2W9v5Um36Fp6KwbGDvPsLTa4wjYmGUPNsg4x1I0cpPIc+rHHM1ridud3wOMe0yfkbLXMRf04JuveZrDbnfljWXXMIORV5nUdLAOEEE1cFX5IzOHZ7X0eCqeMSd6l7Utwk+8RrYxMSZayGFxjrAr65dQOT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5839ca0a-090b-4e36-a79f-08dcc518f92e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 15:17:03.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsCQIbvM/I/luJZGb+OLGWNfFGuSNAm2kVI4D5nqEiuBJ08S+AaBtftJ/Jqofk+2iqevViqrRTuZboTT6RMZ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5646
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408250122
X-Proofpoint-GUID: ka-fXqwOM-HuGWsyoDw5M51QxYdBuSJ8
X-Proofpoint-ORIG-GUID: ka-fXqwOM-HuGWsyoDw5M51QxYdBuSJ8

On Fri, Aug 23, 2024 at 02:14:05PM -0400, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
> 
> Add new funtion rpcauth_map_clnt_to_svc_cred_local which maps a
> generic cred to a svc_cred suitable for use in nfsd.
> 
> This is needed by the localio code to map nfs client creds to nfs
> server credentials.
> 
> Following from net/sunrpc/auth_unix.c:unx_marshal() it is clear that
> ->fsuid and ->fsgid must be used (rather than ->uid and ->gid).  In
> addition, these uid and gid must be translated with from_kuid_munged()
> so local client uses correct uid and gid when acting as local server.
> 
> Suggested-by: NeilBrown <neilb@suse.de> # to approximate unx_marshal()
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  include/linux/sunrpc/auth.h |  4 ++++
>  net/sunrpc/auth.c           | 22 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
> index 61e58327b1aa..4cfb68f511db 100644
> --- a/include/linux/sunrpc/auth.h
> +++ b/include/linux/sunrpc/auth.h
> @@ -11,6 +11,7 @@
>  #define _LINUX_SUNRPC_AUTH_H
>  
>  #include <linux/sunrpc/sched.h>
> +#include <linux/sunrpc/svcauth.h>
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/sunrpc/xdr.h>
>  
> @@ -184,6 +185,9 @@ int			rpcauth_uptodatecred(struct rpc_task *);
>  int			rpcauth_init_credcache(struct rpc_auth *);
>  void			rpcauth_destroy_credcache(struct rpc_auth *);
>  void			rpcauth_clear_credcache(struct rpc_cred_cache *);
> +void			rpcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
> +							   const struct cred *,
> +							   struct svc_cred *);
>  char *			rpcauth_stringify_acceptor(struct rpc_cred *);
>  
>  static inline
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 04534ea537c8..3b6d91b36589 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -17,6 +17,7 @@
>  #include <linux/sunrpc/clnt.h>
>  #include <linux/sunrpc/gss_api.h>
>  #include <linux/spinlock.h>
> +#include <linux/user_namespace.h>
>  
>  #include <trace/events/sunrpc.h>
>  
> @@ -308,6 +309,27 @@ rpcauth_init_credcache(struct rpc_auth *auth)
>  }
>  EXPORT_SYMBOL_GPL(rpcauth_init_credcache);
>  

rpcauth_map_clnt_to_svc_cred_local() needs a kdoc comment.

Since it is called only from fs/nfsd/localio.c -- should this API
                                ^^^^
reside in net/sunrpc/svcauth.c instead of net/sunrpc/auth.c ?


> +void
> +rpcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
> +				   const struct cred *cred,
> +				   struct svc_cred *svc)
> +{
> +	struct user_namespace *userns = clnt->cl_cred ?
> +		clnt->cl_cred->user_ns : &init_user_ns;
> +
> +	memset(svc, 0, sizeof(struct svc_cred));
> +
> +	svc->cr_uid = KUIDT_INIT(from_kuid_munged(userns, cred->fsuid));
> +	svc->cr_gid = KGIDT_INIT(from_kgid_munged(userns, cred->fsgid));
> +	svc->cr_flavor = clnt->cl_auth->au_flavor;
> +	if (cred->group_info)
> +		svc->cr_group_info = get_group_info(cred->group_info);
> +	/* These aren't relevant for local (network is bypassed) */
> +	svc->cr_principal = NULL;
> +	svc->cr_gss_mech = NULL;
> +}
> +EXPORT_SYMBOL_GPL(rpcauth_map_clnt_to_svc_cred_local);
> +
>  char *
>  rpcauth_stringify_acceptor(struct rpc_cred *cred)
>  {
> -- 
> 2.44.0
> 

-- 
Chuck Lever

