Return-Path: <linux-fsdevel+bounces-46289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D2AA86191
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651703A1EB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE69E20CCE8;
	Fri, 11 Apr 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="dPdrahPn";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="dPdrahPn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020108.outbound.protection.outlook.com [52.101.186.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06491C5489;
	Fri, 11 Apr 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384624; cv=fail; b=NxXTJpxXsnmJRhpU5xEDBo1LNzNkDMf1eSJ7j1MrfOgQkkNCJNNOcw/iaI+gpT4qNErNxMn8SRIzxbimWk66cu+QsVHQXDJXZv3Jb9KenM+M0PFCoca6AWkw7R1GWlHu1nyGkA1xqaFr/5s4NszK+a4+ElAkSzFIEtUR1E33W2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384624; c=relaxed/simple;
	bh=63GBqObIlK1rxBgjOxIxr4B2n3tBMDJ09U307h5tkYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lpd1lytBEE5khXx424In7QNhQB3naQvH0esdZqa9ASVWX7mnSoVvFsxORgoHvCtmCH4tgQZv1m+YJCmx3xzGuR7gFhqUf10lcq511HEwOVp6sVepqqjYM7/eEbpDS8HGpr+bsIU5lXw/LEZcz0CgW2lgNb0Tex4XafQnIV13eZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=dPdrahPn; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=dPdrahPn; arc=fail smtp.client-ip=52.101.186.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0xys2Z32n2nvah4I9nv5WAjq/ifRQdqEdTK5sjaZ0OIuRTJL28ZqRIv8ehA/G1FdPi1CjZNmiBwXEe+TzZyRBx+TjQFmisu23r3KN7rRhztoI/eU7bmOAHWAGSRynbQUY/zBOSVw1vM6VW8aUYxP+oTjVQWyrPpqDFBa1A+4nd0FnUDhf550HnrLDfOnOU6sUx/xWAOt0vLk2kCGY6Djuz7DodOeEcNMBoMyhyqclNm/8K4SyvqmfCBxEaWSad2wZctXPh+4IaLHIaN458XfFT92Dc9fVb5M05XVz+JgU8nFNJHVx62bIFSnZRiLj1BbA1V3roSsFNTD5U3D2dXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63GBqObIlK1rxBgjOxIxr4B2n3tBMDJ09U307h5tkYE=;
 b=jr/6PwrDdA2RZXC48cG8/5efAj43xvPvhd2POkiPZQflqwfvZmwSF9zPAiyM8B4cr5fCqy7DW8gG9hbeOfp1/Q9P7Vlm8mj7sJm3LlipGZFeJMfdMRWCaIx21y7AuKJKYjNFlz4ysGv4jkpPepYmmkgUdgJ+PCtKTj36Msl+hqx09vz4SPfZyVJbqH0F5FC/X0LSfMFcpfL/YK3PFCoRc0W6cKhdy+Y0+J9DpIhP00njzmpfHLE7Q4sLX/yTqcVHuQeFDTn0ZH/Xp4W/OEaSEQ7MT6Ywj/O65Y+9UmzGpyQaXkLyoRmdM7VtMF4RZW8cdWAG2kfmUcbX0tXcFuegqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=ddn.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63GBqObIlK1rxBgjOxIxr4B2n3tBMDJ09U307h5tkYE=;
 b=dPdrahPnCxWZVXu0HZY4hM/qbygeWN3ZPPjjwbabLQrXc0hGare4RBkmHBtDYm9in2UZHV320n+v55VI4JnfcI1DQo1t/L8v1K/J0KBE6Ic/TbPMhKDSqad+Z5tw015h8v2jvwT81/BcPUzA+FVs2j+Cg8vcDxvBLO+78XjnZwU=
Received: from PA7P264CA0423.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37d::6)
 by ZR1P278MB1626.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 15:16:56 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:102:37d:cafe::4f) by PA7P264CA0423.outlook.office365.com
 (2603:10a6:102:37d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 15:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Fri, 11 Apr 2025 15:16:56 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=dPdrahPn
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17012051.outbound.protection.outlook.com [40.93.85.51])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id 759BD805B3;
	Fri, 11 Apr 2025 17:16:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63GBqObIlK1rxBgjOxIxr4B2n3tBMDJ09U307h5tkYE=;
 b=dPdrahPnCxWZVXu0HZY4hM/qbygeWN3ZPPjjwbabLQrXc0hGare4RBkmHBtDYm9in2UZHV320n+v55VI4JnfcI1DQo1t/L8v1K/J0KBE6Ic/TbPMhKDSqad+Z5tw015h8v2jvwT81/BcPUzA+FVs2j+Cg8vcDxvBLO+78XjnZwU=
Received: from GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:42::7) by
 ZR0P278MB1074.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:57::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.28; Fri, 11 Apr 2025 15:16:54 +0000
Received: from GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4336:6bd9:d554:87f1]) by GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4336:6bd9:d554:87f1%4]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 15:16:54 +0000
From: Laura Promberger <laura.promberger@cern.ch>
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bschubert@ddn.com>, Dave Chinner <david@fromorbit.com>,
	Matt Harvey <mharvey@jumptrading.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation
 behaviour
Thread-Topic: [PATCH v8] fuse: add more control over cache invalidation
 behaviour
Thread-Index: AQHbiC78vz1B7dg/NUOfn0lxItJH+rNn26CXgATK8YCACqiPWoAniaJm
Date: Fri, 11 Apr 2025 15:16:53 +0000
Message-ID:
 <GV0P278MB07182F4A1BDFD2506E2F58AC85B62@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
References: <20250226091451.11899-1-luis@igalia.com>
	<87msdwrh72.fsf@igalia.com>
	<CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
 <875xk7zyjm.fsf@igalia.com>
In-Reply-To: <875xk7zyjm.fsf@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
x-ms-traffictypediagnostic:
	GV0P278MB0718:EE_|ZR0P278MB1074:EE_|AMS1EPF00000040:EE_|ZR1P278MB1626:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4b8a04-72ed-43ac-ac8d-08dd790be5e9
x-ld-processed: c80d3499-4a40-4a8c-986e-abce017d6b19,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?cyajKWSCiq0JRfZ2BIU0Aw33beuONtNfdYmOecUFwh/+rwO87z3S3scHzb?=
 =?iso-8859-1?Q?dLGnhV4Zy9+mBa72CT/8rFjJwZXsNJuAZPdjUfm6UukgbMqNrT7DpGMwlI?=
 =?iso-8859-1?Q?LmC66HBDfJWCjLAuXZoUjS4Zh39PGTHHNBjgamh1b2uRMQ+RQaXER1uagu?=
 =?iso-8859-1?Q?uKsBrq4Xk3vK6UGGs143TQIaVvmUN5EJamOH7SCHqfFWEdbmKfF31WNtIQ?=
 =?iso-8859-1?Q?RKQoeQz6WFnMh5AcvYp4+mBVfwI3wIL/hxOVQsTmwYaN9co+gRGAT1IIQ2?=
 =?iso-8859-1?Q?sF5gt7kyqFoNHTKfyywNCSYFcTX1I/xbYG2rm1wEVdJWleztnrpn2zBClc?=
 =?iso-8859-1?Q?hnbljdIer1ADycBhjo8fY3e3kP4oS27/p7Qb2cEWDR/sqNEfCIFMWhntyx?=
 =?iso-8859-1?Q?irU3kdQkmKESKxdH1eXnJ9ihQfvzARlN6i3TIx1SEpwpY56U5/X/scMG9x?=
 =?iso-8859-1?Q?MrYzTvNtJSRwXIzzwCOUmUlrtufHR8lF7HC01THxgmDy8rJhHm2p1mQY6y?=
 =?iso-8859-1?Q?FDiThz3mgxYml2kx23XcOnyD3hRB6AQuvwVm1u2WO+K0ba5a8VThP/DYJK?=
 =?iso-8859-1?Q?91jIKFODhML1dr3UYSgLSZuzAropSeJ8ERtjEIJfz6NBugJLeohMWoLHK2?=
 =?iso-8859-1?Q?P71Xo9cDQ7qyDvZRCvpOQGJrkvlQ4DtZ1AwkPEOa/QMmYagC5isd1GTNfr?=
 =?iso-8859-1?Q?8E2KbJikJVTInWLEcu+jyfdk/EyNTc6jdASvjd/qi4gaKbUvs3m9tuHzSm?=
 =?iso-8859-1?Q?Q4t6n5pLA2gQdSME/Uek7gID7fDAyUOhJZLIAqzxnWPA7Z87nR6wsYJLyJ?=
 =?iso-8859-1?Q?3Ggi6S71ga1DN77lJOf/PlSt2GPZ3A1j0WMC6FGTHH5hhIh2kGImxyJ23m?=
 =?iso-8859-1?Q?1zXN732Helk/OZXhJmSZyg45zTlGg6J0ZOCanxBLc0BVWXuRdYdUn1p4Au?=
 =?iso-8859-1?Q?mn7PNP3oguLZCK42fN/AIzpIGX52ZtnN4ZBbJxMt35/5VD59d6Il4XweiO?=
 =?iso-8859-1?Q?OWZtClWHrcpx6k55DfaJPaO1ECVJ7SCs2s1uThErJMJkVcmyPFMlHvng6i?=
 =?iso-8859-1?Q?7lpMoORBsDHVC+Jk+Yr4jgWeSgzzeByNpswGjE3Z2YzrF5hT40wrfRBq5y?=
 =?iso-8859-1?Q?8Qq6Z9cR46/Cs4WPOhfMqMAYRQ0D3yh1IJBuZZaYOj34D2FkhiKfkUxCYQ?=
 =?iso-8859-1?Q?diqO5e5aUiVPs1dvYA0lczuTHSKrkk0SVM8h2fVhNBGFuVqBfUAM7yjzHu?=
 =?iso-8859-1?Q?w4Yd8K1BizfyRjRLlOJQhp5UG5Ek36ufzntpMb4vUEI0xsCar/ST9VmCUA?=
 =?iso-8859-1?Q?7zpCuj1KAu+wrfrDkxcLbXl2xz+yQo8tjP5Bv5sK7UZCfPySxJ9SVZ7T/X?=
 =?iso-8859-1?Q?gWJkop3nggG/xiHqh4AFjDVY9/ia7V6Wl5qBVyUCZVPP7wWljOZg4xqWhV?=
 =?iso-8859-1?Q?yGK2b68/vluZOUdagLEUO29Ge2gDJXdlA+M2aRZPilCjTBGYJTqRSjcMK0?=
 =?iso-8859-1?Q?BsqcARR5IW15FL75lwQhoplPdEGZlY1bXK2IIOAGpUIDugEZtruVfBpFiO?=
 =?iso-8859-1?Q?bKiJIPY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1074
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	74e1bcde-addc-4295-1068-08dd790be468
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|82310400026|14060799003|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?B+2ctUHiNvYjC4I97FMoWxCyA7yVFrnQhbfv8NN2SUjITFq/VnrHtUb+ey?=
 =?iso-8859-1?Q?jW9AMzfkeHLBTEFMjIAqnugrL0fqx1bNgAeuNjVw5amMVQmvPedjL4fII0?=
 =?iso-8859-1?Q?z/8eBw3+6xoWX46KWzLRsdkWq1PfTVJcWtbfHXEShRG7dAQFQ0Jgzau29S?=
 =?iso-8859-1?Q?m3RuUv0gzgG1S1E4aQgcjsGbsKgbaFTSzziVmqC2EpYyGBywUpxK3PN1Dk?=
 =?iso-8859-1?Q?K7iD+8EzSQ3SnVXl3oxVvPUMLBrCNdCnTZJN+rX7BHz/NBcL0j4m/L3Dfy?=
 =?iso-8859-1?Q?T+zeHmb6o8bASAhqN/FTgVByBMdLWw9z2ii5F32DKH5/rrIKQmVgp8pImC?=
 =?iso-8859-1?Q?BPFbfLOId0VHrr+0hnJK7eirpTAimAx2EdX+FohuhTCFCJymmW7BsTgy1W?=
 =?iso-8859-1?Q?H6hM5u4fK8WBqBAd9UWWoy7WG+OK1nAGjCbl5ncNRfGpjOYp7AzSlewrZK?=
 =?iso-8859-1?Q?oTltJwSgc1BeiV62dcrXgq8UtLyhsV5rLrO0+raitWxyqueqypzG/dx92D?=
 =?iso-8859-1?Q?nnAVfbF6psAOUoh+GPPjLk8goBvpwGcKlLeOLRSCHlA52WLc6r2hrilGec?=
 =?iso-8859-1?Q?UnSi0mz3mh6vbHwP0LQKx94As/xXkC8bDrhQ9Kv6mG2BtB88yEYml26Ne0?=
 =?iso-8859-1?Q?S97k3TpTz7DxgJDad6Ei6DxoFcA3fMaKkdhEGPC0rc8T5PBjzOycIG+di2?=
 =?iso-8859-1?Q?BHFj4SuBrWR5/Lvw+/0bIlB5re9NjlZ6WaHrmzJeAGxhBRyzHzYOMoHMjP?=
 =?iso-8859-1?Q?dNR/heYp7kzCzGTUeJyZ+n94XiG8HOoyG2301FVC7OgRqRnDfAl8h6+l+n?=
 =?iso-8859-1?Q?U5LiTBsJOTgqmFl4Ta4Pn4n3ig+LalR1S4BMVPG4ASEXE/qIRVOi5ZagVS?=
 =?iso-8859-1?Q?c/hJbNQ18c2tQjXJXOU6H2RJFkD8xVi2g54p46rldAgTA949FtJ/nLfVio?=
 =?iso-8859-1?Q?QQyYAy+NBTp5itUrrfkvwxBfkZQtpOT+Ayt/yT0NZNb7BdqeVGtRPQThv2?=
 =?iso-8859-1?Q?EgvoQZoPgt+oD+hLimse5YNECBu3LJgoXLlwRgvvGHmmJDWuV6PYuy1r2Z?=
 =?iso-8859-1?Q?en81FD46YSYupfeYnMN2/76L7y1/H0Rmuvjvuwxw2ZM3BVl60iSRY60kbX?=
 =?iso-8859-1?Q?0/e6bdl9OlOENIYYxkcKyKSjQ4ccX7oAV/RzdUjzWKn3u6OsOPULJwdE8W?=
 =?iso-8859-1?Q?MevOsmbfg4nzAiReIVmWE9XOlSx5DOMjPx0OFb7EilsWh/X2o3ObNiuezi?=
 =?iso-8859-1?Q?zE2Tnil25WqNR1+OGv9ruzAT4wSqgLPN5uReMNy5Jai2qu6CzDBPIAkWvp?=
 =?iso-8859-1?Q?agI/F2Uz2OtMvrqO6F6iTR/nisGwo+T1jM3HlA98tcYIC4rl3SlBLJBDHU?=
 =?iso-8859-1?Q?4HdTlSPqIOph+7n21UkfTosf5hKkKtpWnytLxKFLTr9hBDrQAG/lAEHm3p?=
 =?iso-8859-1?Q?1FquWcOeTeNIzwMwJDrRCMTS6LS6p/tiy9dgJGI9ayf3vWPqO55Ad0W8It?=
 =?iso-8859-1?Q?JbjEqd8nwoUrzjeecB+hVfp0iZCWR5yX9a9NmXR/AL0Xfcx+At03fod0KU?=
 =?iso-8859-1?Q?5fGQkXwVIx2NtVHHmSn9gEivuVANT81tLZ5V6Z6SlgWd6vF5Mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(82310400026)(14060799003)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:16:56.4594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4b8a04-72ed-43ac-ac8d-08dd790be5e9
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1626

Hello Miklos, Luis,=0A=
=0A=
I tested Luis NOTIFY_INC_EPOCH patch (kernel, libfuse, cvmfs) on RHEL9 and =
can confirm that in combination with your fix to the symlink truncate it so=
lves all the problem we had with cvmfs when applying a new revision and at =
the same time hammering a symlink with readlink() that would change its tar=
get. ( https://github.com/cvmfs/cvmfs/issues/3626 )=0A=
=0A=
With those two patches we no longer end up with corrupted symlinks or get s=
tuck on an old revision.=0A=
(old revision was possible because the kernel started caching the old one a=
gain during the update due to the high access rate and the asynchronous evi=
ct of inodes)=0A=
=0A=
As such we would be very happy if this patch could be accepted.=0A=
=0A=
Have a nice weekend=0A=
Laura=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Luis Henriques <luis@igalia.com>=0A=
Sent:=A0Monday, March 17, 2025 12:28=0A=
To:=A0Miklos Szeredi <miklos@szeredi.hu>=0A=
Cc:=A0Laura Promberger <laura.promberger@cern.ch>; Bernd Schubert <bschuber=
t@ddn.com>; Dave Chinner <david@fromorbit.com>; Matt Harvey <mharvey@jumptr=
ading.com>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>; =
linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH v8] fuse: add more control over cache invalidation be=
haviour=0A=
=A0=0A=
Hi Miklos,=0A=
=0A=
[ adding Laura to CC, something I should have done before ]=0A=
=0A=
On Mon, Mar 10 2025, Miklos Szeredi wrote:=0A=
=0A=
> On Fri, 7 Mar 2025 at 16:31, Luis Henriques <luis@igalia.com> wrote:=0A=
>=0A=
>> Any further feedback on this patch, or is it already OK for being merged=
?=0A=
>=0A=
> The patch looks okay.=A0 I have ideas about improving the name, but that =
can wait.=0A=
>=0A=
> What I think is still needed is an actual use case with performance numbe=
rs.=0A=
=0A=
As requested, I've run some tests on CVMFS using this kernel patch[1].=0A=
For reference, I'm also sharing the changes I've done to libfuse[2] and=0A=
CVMFS[3] in order to use this new FUSE operation.=A0 The changes to these=
=0A=
two repositories are in a branch named 'wip-notify-inc-epoch'.=0A=
=0A=
As for the details, basically what I've done was to hack the CVMFS loop in=
=0A=
FuseInvalidator::MainInvalidator() so that it would do a single call to=0A=
the libfuse operation fuse_lowlevel_notify_increment_epoch() instead of=0A=
cycling through the inodes list.=A0 The CVMFS patch is ugly, it just=0A=
short-circuiting the loop, but I didn't want to spend any more time with=0A=
it at this stage.=A0 The real patch will be slightly more complex in order=
=0A=
to deal with both approaches, in case the NOTIFY_INC_EPOCH isn't=0A=
available.=0A=
=0A=
Anyway, my test environment was a small VM, where I have two scenarios: a=
=0A=
small file-system with just a few inodes, and a larger one with around=0A=
8000 inodes.=A0 The test approach was to simply mount the filesystem, load=
=0A=
the caches with 'find /mnt' and force a flush using the cvmfs_swissknife=0A=
tool, with the 'ingest' command.=0A=
=0A=
[ Disclosure: my test environment actually uses a fork of upstream cvmfs,=
=0A=
=A0 but for the purposes of these tests that shouldn't really make any=0A=
=A0 difference. ]=0A=
=0A=
The numbers in the table below represent the average time (tests were run=
=0A=
100 times) it takes to run the MainInvalidator() function.=A0 As expected,=
=0A=
using the NOTIFY_INC_EPOCH is much faster, as it's a single operation, a=0A=
single call into FUSE.=A0 Using the NOTIFY_INVAL_* is much more expensive -=
-=0A=
it requires calling into the kernel several times, depending on the number=
=0A=
of inodes on the list.=0A=
=0A=
|------------------+------------------+----------------|=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | small filesystem | "=
big" fs=A0=A0=A0=A0=A0=A0 |=0A=
|=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | (~20 inodes)=A0=A0=
=A0=A0 | (~8000 inodes) |=0A=
|------------------+------------------+----------------|=0A=
| NOTIFY_INVAL_*=A0=A0 | 330 us=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 4300 us=A0=
=A0=A0=A0=A0=A0=A0 |=0A=
| NOTIFY_INC_EPOCH | 40 us=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 45 us=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=0A=
|------------------+------------------+----------------|=0A=
=0A=
Hopefully these results help answering Miklos questions regarding the=0A=
cvmfs use-case.=0A=
=0A=
[1] https://lore.kernel.org/all/20250226091451.11899-1-luis@igalia.com/=0A=
[2] https://github.com/luis-henrix/libfuse=0A=
[3] https://github.com/luis-henrix/cvmfs=0A=
=0A=
Cheers,=0A=
--=0A=
Lu=EDs=

