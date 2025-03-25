Return-Path: <linux-fsdevel+bounces-45045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4614CA70A0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 20:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D3117ADB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FA21EF0A1;
	Tue, 25 Mar 2025 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSH5EH51";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VwQIIzbN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E645979;
	Tue, 25 Mar 2025 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929855; cv=fail; b=sZm+q0+Eo8yJgM0Y/iVbmvzGeW21TFLHK48nWj45BAywEjNJOq9D/2tAAI3ir6W1qHJKhvIHu9GNaWHTNiOj2GNej4E9HdCNrxqgQbdH/b1UbxlEQu2nEu0dh4YY82diEU5k9CC1BphOobSI6alakH6+5dAcEDzCzW3OGuwhhJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929855; c=relaxed/simple;
	bh=y3FxT0JFybQH6Z2AVmPygVOEK2iYz+Y8UjnQ5VmdP1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HSsio+QcG0jr6801Ok4Hcv4GxRGx15VDIXnMSjYo5LKBm/aGOrXgcQok5P71QqYmNOzfKY92yeinPfueEkBKouAAsAylF7GjsHJE10q+o3cbzrLT8whKkVZZr2aWH4iEtgY4txqt25+/0KNN1D+M42Zk5zxYgyvUGMb3mXIIbpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YSH5EH51; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VwQIIzbN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGvo90007580;
	Tue, 25 Mar 2025 19:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=8hLRnpbtxasMJ3QXsy
	6v4uVqJotAz9MWp4CkLmcH6bE=; b=YSH5EH51uSxdYGcEydW/eMGiSaNvxgkMj2
	dqxiBM/c1bkwyhV6vRytCLKyHpIilcISd5dadbQ+sugfXtRhC4WzuueMv/S3UF8d
	eyigEuNAmDk6D4TxxNDbN5RP9DPiCIENhsZtvXWvc5+xmmxxIFdTgSZi1y9GGj3G
	RAcvHrmlPzdF62P7zL8G+iwHXkbmxKGu8gkgrcBIoE55shfs9G+Q5QX487qb5w79
	HZ9depqEQfTzWQ86XLNErz5zi2kRIuzJA1Q7ZiB5YnVExaZesVm5eF1Rj9VGvLCr
	zKekoreoZ1O9QFPnpU8Ht3vJEJrUDsA80ivGvsXDTLwJp7hb/oMQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn9byxr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:09:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PI18IP024306;
	Tue, 25 Mar 2025 19:09:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjce486t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMaq6/raXIgrgPDIL+j24xh1KqVxohJX+j2MGsm2QBOyQO1Eh/BRoc/V53/aaGS7JqeNydJukrpB6TDfOXmYsTvQKI1vLIuT3OtCpbarEgqivp4i0EeUcx8PW0RWgfm6Bd1J+hHNwkPC0zmqt6U2FRjpljJM/ZJaTPAybUdk7TV1fvMd6fQGZHoQBtd3LIxVYW+o8bstYVLye/URYKPOHCOSI6BuE3Te1uXLwZlHa/kkcyoPo6qJsE386UgxFwSEXaAoSsJ+HojPnU7PinRCGQ4iCoPad0Fp/6s1kNgKnkOgesOj6XyzUQT+QPoOZKjTmvY7HsCb3Qr/PrqPX/23Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hLRnpbtxasMJ3QXsy6v4uVqJotAz9MWp4CkLmcH6bE=;
 b=pXu64xiS9ivbJDeUeycp72A8TZSXkPGtDuyMM/nfRXoCH4Ze4GBp5Xz0ijJH4BpHP/zF/Etw09YE7ZMqSv5cVScqYRfqanxrKOOL+0yBz1mTTjU8+1mjJXG/TXQmdc/QIHdIP0SZDN7h0oZaiVb8/LZFOvJ6CubQU5GMyJg/1Q3cSk41gysnVpIbwPhFTBSSea5VdQSw4I04xW7TnEldbY1OGiTtBMJccESbrG+LX/OfE3xyB8EeWz2G3ZSGXk2t1/RCVAaj8mOX8rGN7RfK3MSxMfzZS0XDNQuz95oarHXth9LrR4r5Kwy7ZBqKqr2fPH2X1+yur9F19imX2hAv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hLRnpbtxasMJ3QXsy6v4uVqJotAz9MWp4CkLmcH6bE=;
 b=VwQIIzbNMdlsKFYl5GMSn6Gy4V/HheXSxIFU8cBup0IIG2uflLlbPBghmbxhxI5wcd3V2alX/0wvzhC97yDdjRR+1PvcxP4valaWc68w4K+VcCIUWASqp2jHJpaJUt68VXx1c+BlgnhCIvzGhQaAXTSFclIGPPJ+4K1WOT9eozI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 19:09:45 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 19:09:45 +0000
Date: Tue, 25 Mar 2025 15:09:37 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, anup@brainfault.org,
        atishp@atishpatra.org, oleg@redhat.com, kees@kernel.org,
        tglx@linutronix.de, will@kernel.org, mark.rutland@arm.com,
        brauner@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org,
        edumazet@google.com, unicorn_wang@outlook.com, inochiama@outlook.com,
        gaohan@iscas.ac.cn, shihua@iscas.ac.cn, jiawei@iscas.ac.cn,
        wuwei2016@iscas.ac.cn, drew@pdp7.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com,
        wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com,
        josef@toxicpanda.com, dsterba@suse.com, mingo@redhat.com,
        peterz@infradead.org, boqun.feng@gmail.com, xiao.w.wang@intel.com,
        qingfang.deng@siflower.com.cn, leobras@redhat.com, jszhang@kernel.org,
        conor.dooley@microchip.com, samuel.holland@sifive.com,
        yongxuan.wang@sifive.com, luxu.kernel@bytedance.com, david@redhat.com,
        ruanjinjie@huawei.com, cuiyunhui@bytedance.com,
        wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, ardb@kernel.org,
        ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [RFC PATCH V3 31/43] rv64ilp32_abi: maple_tree: Use
 BITS_PER_LONG instead of CONFIG_64BIT
Message-ID: <4gph4xikdbg6loy2id72uyxgldsldecc7gquhymusl3vreiw3a@ephk5ahhrdw7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	guoren@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	anup@brainfault.org, atishp@atishpatra.org, oleg@redhat.com, kees@kernel.org, 
	tglx@linutronix.de, will@kernel.org, mark.rutland@arm.com, brauner@kernel.org, 
	akpm@linux-foundation.org, rostedt@goodmis.org, edumazet@google.com, 
	unicorn_wang@outlook.com, inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, wefu@redhat.com, kuba@kernel.org, 
	pabeni@redhat.com, josef@toxicpanda.com, dsterba@suse.com, mingo@redhat.com, 
	peterz@infradead.org, boqun.feng@gmail.com, xiao.w.wang@intel.com, 
	qingfang.deng@siflower.com.cn, leobras@redhat.com, jszhang@kernel.org, 
	conor.dooley@microchip.com, samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, cuiyunhui@bytedance.com, 
	wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, ardb@kernel.org, ast@kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, linux-crypto@vger.kernel.org, 
	bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
References: <20250325121624.523258-1-guoren@kernel.org>
 <20250325121624.523258-32-guoren@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325121624.523258-32-guoren@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: MN2PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:208:236::8) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM6PR10MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: dae776e9-1a9b-45fe-8f73-08dd6bd09b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p/VY7aZcWWMnM5NgcRiQZewG4ucRwmIsty+F1dEf0TrY5vfujAh29bsTIykX?=
 =?us-ascii?Q?NRK/+BeAKb5I8V8GAEIOwVEsCvKgu8G1HssRI+gkIAZmRYmBv4FFUIDMeNvU?=
 =?us-ascii?Q?MCODSpmaegj23q2PNft45gxi/NqG3qEX9cg/qZGrzNsY9cPHeA3L/v0AzgaZ?=
 =?us-ascii?Q?Wr4oJBp4vRkYK/MAS13l0cN9sEKILN/hxStrx1Q8QqaLR7Iqv7juwhBXvc59?=
 =?us-ascii?Q?c45peRCxdmZWVHG2mwNJpOQSnaXUkc0f0ovUusj993ylBWSFljvHzuasavtX?=
 =?us-ascii?Q?+SGqX6Jp9TiuO5NYqXoCi7Wf00aH0gBu5G4ExCMh5BJFmm+BJnA2r6Yf7MK5?=
 =?us-ascii?Q?K496IgvoxvqhjzyIQ7ojm64seFz/jlURfX8LcgfIw9gegiPNV9+uA5pKGgZ7?=
 =?us-ascii?Q?gc4QfXJqyLBJkHFrY1v/QfozGwpZY2cC3r+t00GQJoZrpsOrgl5XQbI+GTPs?=
 =?us-ascii?Q?heDSDyuG0Ym19RhX9cYpBGqO0EPMBW+xKRiGab1TJNRte7XOZIno6GbtWNnf?=
 =?us-ascii?Q?MqF3jneBBQDtIdqemwt85R90JBUS8/0+Fxum1WWqu8gGJFIvCvlhLWyn2bhJ?=
 =?us-ascii?Q?Y8ZhXX0hPBjwEt5Xj0W/v1Orrjn9t54QLmtNClT8eFVEk/gb4wZg95kYx9+I?=
 =?us-ascii?Q?AWQheJiqfctqRMSSIc7OocNKA6aWPdUyYn/8UvQtEfgsimtTtyIC1yVwt3Jg?=
 =?us-ascii?Q?E9SKsBhZcdKDdPar0E+A+Fuhsy2+4lpxksohnc/5VqltW2fpjYNLCgHK6618?=
 =?us-ascii?Q?lsFDL00kWpIR5LfuXbnirQsZCkV4QjgUk32oH1mtzywlkia+l2fL4S5lkeoO?=
 =?us-ascii?Q?vMKIS+KugL9SNlX6Cv9lC7OevyHoBbSHBf8krdmOhao+/lCHfERUHm0yAiyI?=
 =?us-ascii?Q?BRIFSDLLUW6Di4aIC2qToeAfBd0bT8KTzzC9LKeI4GTI25p/AIPyiMOihlmt?=
 =?us-ascii?Q?BvQUzg37cjRwum8ZhXOFxRveHxqQVBzlZK5ax5m7zyvMWzjFV+b2sJYj5pIp?=
 =?us-ascii?Q?jg4Rhpggec/WFm/XWQQoS1QVQoWbybx02AllNN9aw14HVsV9ADJ35XolOhZ9?=
 =?us-ascii?Q?tfAF9Vho9VVPVNfve+QDCi6YQiE/wRrsmBqWwdqoFg3RXdMortET0tR/v7Ek?=
 =?us-ascii?Q?tuEf21jIqN0c71XiX/AP8eFOzkNfnO3joE7TQn1XCQEyV3de+Ci07vlOTmwM?=
 =?us-ascii?Q?uk000tVA2Ze6OgRFyqxiMqpmEfiWAesMjgkFrTEobQfh1S3iBWmi5ashf+pf?=
 =?us-ascii?Q?AISXtmv6oodcQnx8+VbOyOpLbRRa5gxgTFo5ZEmgEsn0t8UG3axkz+FOD1i+?=
 =?us-ascii?Q?KMeNXCxUpogMLc04NOyop1jHX/hiqPa3YqBqo5zpmy5BRu5Wv8+M/E3bDzxW?=
 =?us-ascii?Q?LzwP8SWUVF8YPldh9ewbJGnGwIBb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ukKV6w9XHgW8kgYleE5+L0Cz9jfRFRuzvdrOEkK+af76KH1MziszPMzpLno?=
 =?us-ascii?Q?Um/O12GQfgt6VvFvJ5rEuSL+JIPFz5Lh1UiyLzip+i5h1gcbwr3lcuAl6J50?=
 =?us-ascii?Q?Ii0qCv/2gMci5BWuvr8Y1UE5lEdmfo4SJMybJeEIMFemE1vFwvMuZM6gNDC9?=
 =?us-ascii?Q?Pirv3OcgML7yGRCyH8xOq96JRcCtW+LJlrLLj2dFu8RC69OcoeUbcd7RgigK?=
 =?us-ascii?Q?FzD5Mt8vA66jhjeD8O8nkYoTGpNLK5w7sFGrJyZ2qQ5UJTRRmPziMHnXqi3R?=
 =?us-ascii?Q?tOnfyNKyNBXzDZ0XVQ43Owg9p4PUCRk08pxHLoKJMj4rrqPopwHwMGmSrpCX?=
 =?us-ascii?Q?AAO+I+Am4qGFz0xUko6WgetZFm6+Z0xwMrEheK1rqzaC3N5nRe2U2s5UhTaY?=
 =?us-ascii?Q?vFr+dclR3JB0q2A6ZrZMGEfLwJHnpdH13qQ2BptGtARWtJ0JXs/BwMDZhDG0?=
 =?us-ascii?Q?+n/pbMbceIxZQfU9I/DD3Qh1K+CvrMeDZcZnyc4Vtx5nFMbvbczi9+DcJIG4?=
 =?us-ascii?Q?o2mkB88qfFRQu1YZa7qV60iZ8Gmfqglb4ZZ1fpeVFmX3HDc3PjwpVdhtPWLa?=
 =?us-ascii?Q?tqsRpESpQHGf3KZWM8jUk4nnFYsvywsC1K+nTOtgn3n5B3nuiu74e0xxf0ts?=
 =?us-ascii?Q?IQ28qcDXTbccya+SNWP7eiCEVT/gXWLsW3FKW7SHAImMJANTau3kzE7RcU4L?=
 =?us-ascii?Q?Ckm2bYguBLGtH6yuP5495zit40wS89EtYm0cO22HSQnMUlftmlENt3ngDFsf?=
 =?us-ascii?Q?L6F42fzPEdC0U59JpjSoXfweO19HBUQV3EQtcBhXRb/iE0zw7RAJXnRuaLkA?=
 =?us-ascii?Q?3Ls7Z1w2o+lC78EQ4/1E8h3M3nYr40dznA8ZVaoCzl6dGROeAQnahCIGBfAb?=
 =?us-ascii?Q?NlKz0az2f1spBkcGS8bT39iMSBw6dbWGyqKY4ecCO1ibIGsQNZz+FUG4MgtB?=
 =?us-ascii?Q?TdAgi43wGZR59Zb7Jyjx9XPrCeageSpA7Mbzso7NUMDh8GukrPYxvwYCSglW?=
 =?us-ascii?Q?awa24TWd9hjJLFoX2gpaHZ/3boFbisMuhSQawD3p8DV6az+hQOfu3EEnXdW8?=
 =?us-ascii?Q?N7Ba/e4BXpP9XvJu4rQ/ahAZ2TIbtb7pVcSSBmhgBLktJv3I+/xzo3HdkRyD?=
 =?us-ascii?Q?jSB1lxz3Vy33L8ZCD0oRs3Amdcc9xiBnqqRAU4JvqQSfAeVyPqqkl05NkQ0J?=
 =?us-ascii?Q?JXwSqaH7NHyJuxXt/9984qcqzhuwGb/ycbSRwFIHGu1iXw9J+SH7gbEsWAzc?=
 =?us-ascii?Q?+Gy+1DdUUPBf6Cqq3AsuTCL94HXHZrsTGDcIEobu3zyJhmKAfavwkKBXqeJN?=
 =?us-ascii?Q?16pNGJEulzCOFpoVOI5ndqioTopCckX+JXvJs2742vmVHcsbxe+WKxf3lAG2?=
 =?us-ascii?Q?lRc6Sw0deCyBe/og7OmaW9NJNYLw8GKV6D2GtBawz78ZzdFB70Ha7QQlez3S?=
 =?us-ascii?Q?V275RUZckMOGlATNpV1HCQczntDAFFPJPpXv6SFyTIcZXKNI1Eac/qmzw0gD?=
 =?us-ascii?Q?tTct2m8/uxqpZ4UpcBFCcpTK7eccIUqaPXGtyXfsmxVfTyDrJiWcsIpnI5Oi?=
 =?us-ascii?Q?BgwVhfhS0809ih5ROdjHtH294nmbSCpZmQdqJsjB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qjQk20bSQtlnbhXJK+Vfmlc7QhFhuPX+k/d8S3hNurchsAEA/SbRsF0yBiwcPXzsSSJR340Dpgump29Gp3OR8aHJPs0CAmMrVInhkDzTv0pOdOqeY9MUKZWsw0GOr1FsFGAzCYokT0NiCaTK3gkgcxfj7J3k2t3Ox1cImed+NAdYrD/s7KDDXrAcNzGUzO9PYSvYLLH2gylE4+TQOrYo/PEW6sUEK2tH8Jgjt+QBYJtjOUMOWZPjb6ZkkMYdtf7c6QuV9v+0da6o3PpN+8OrXij0z289d0x35t9rQi9IohBMDXYhCscSj7FvlXro3rL9U3nhJXCeGTJIEMVGDGBlrcgDEYzJwvXlyow0io4Q/kQlBglpAVgVTrgixDGKuHlr3+wq7OA7skYr6r3mVCxKLJ2frPl7NaDAPdGiyPRt/wqesje8s03Mj++3xOSZPZwu0NzScP0Dnvefs9lMVqX8FOsoBmTs8QLrZ3/7Cy5MJg+cbm2qNJd1Gjj4O96vFP1uvdXrkJwiFb+MdlNnL5R9UPxY6+GzWeG3k1TnzrGXBOPycaTYRHdUWWsQ7w0rNyhAv6ixCZXBDqDOPj4X2pC0avXWKQdMx6LkIxKq7cDLD0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae776e9-1a9b-45fe-8f73-08dd6bd09b04
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 19:09:45.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AR8uCqelSwIoDQtXqW76HgNu0yHuWc89SUlRDIpl3wX5GYK6QIA277P0QG4QX8UugMA++9w8AaZotk6jS5nqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_08,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250130
X-Proofpoint-GUID: tQhqFB6uDgFqdm-bUZQjQ8aPbvkrWtUQ
X-Proofpoint-ORIG-GUID: tQhqFB6uDgFqdm-bUZQjQ8aPbvkrWtUQ

* guoren@kernel.org <guoren@kernel.org> [250325 08:24]:
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> 
> The Maple tree algorithm uses ulong type for each element. The
> number of slots is based on BITS_PER_LONG for RV64ILP32 ABI, so
> use BITS_PER_LONG instead of CONFIG_64BIT.
> 
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
>  include/linux/maple_tree.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index cbbcd18d4186..ff6265b6468b 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -24,7 +24,7 @@
>   *
>   * Nodes in the tree point to their parent unless bit 0 is set.
>   */
> -#if defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)
> +#if (BITS_PER_LONG == 64) || defined(BUILD_VDSO32_64)

This will break my userspace testing, if you do not update the testing as
well.  This can be found in tools/testing/radix-tree.  Please also look
at the Makefile as well since it will generate a build flag for the
userspace.

This raises other concerns as the code is found with a grep command, so
I'm not sure why it was missed and if anything else is missed?

If you consider this email to be the (unasked) question about what to do
here, then please CC me, the maintainer of the files including the one
you are updating here.

Thank you,
Liam


