Return-Path: <linux-fsdevel+bounces-74732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBrZEmPzb2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:28:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E81C74C401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC14690DB26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999BF45BD45;
	Tue, 20 Jan 2026 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WFvKGzK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECCC44D00E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942274; cv=fail; b=dZtUdSGYeSyld6/n6TqTiDBTV8EWrmF1EaEqiBeasjOdqcxxZXwSlY+it/zGdABPG1rF1GElSGdaZZFbA4EBMz+g0NtUuj5xWpn1JwmpBToVw8I+61UosNkP+64mtexYs8+FQuOa0FTDKKOx5HuW9KV7/0Nzra0HLIqV5uTDFmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942274; c=relaxed/simple;
	bh=MJTysLEwXXQlxp14+ioOfMypTimEisdd0UQGeZBRDuM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qC4M9wKSpPxRJqLxC2Hdtl41zf0RDV4GmxXpYRB9U0akdr4kU92GPsesWkGk1VqSN+859jH8bdK82M8zbkwiplfRHAZDNNPq7GaINciOR+DLex4wkIX/C7/xxeW0HwXnN6qr1zXdP661BvbDnrNQ/91sXQdnUPfni1SaBbeOICE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WFvKGzK8; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60KEkmJ9007750
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=+TJA9jePWfZaTbbsIET9JCIExRU/BkN1xsyACq8HnMg=; b=WFvKGzK8
	ynkT2ARpEuUb+djbJObSf/2ft3ZRl4fuyUJ5G8yb9p1LxNH6vnlukOatTAwl7wyx
	c4qlWX+HudT147/hBBK6q6hCdj3bPFhXmXKXpDoOPv2BINaPxs8meUr1KmMXFsWa
	ZG9TlJZm/nLHZpbty8Yl/PgaiAeblKwH5ZLbE+vhxhIdM6PJakVBKsZHDohshCKU
	TJhaA8yoNaC9SdYY0t6s+VReb0thuMaKsN6VfQrLwnZ9my24UC5xg6e8VbdSQNsX
	3tBE7U0K6rNw15oKL2GGQywyFz7NpySfQcj4pI+rzABJuWogO8wkfZ3kN+Wc/8PT
	JopiAx1CU0n7iw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyuk7q8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:51:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60KKmG9u015136
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:51:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyuk7q83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 20:51:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60KKn3eX016838;
	Tue, 20 Jan 2026 20:51:09 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyuk7q82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 20:51:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuvOdsJhCJkHqX8EAoE0iG13Ycyqo1bbxyrmpmcDfaqjiijVH+RX/nEWj/ft+vosIwBYo9aWp8t4NAb64QaJ/nFroWy73KdizFRbTOac9bFCCeEmouAsvcX5o/P+vPg1F8/Emb4fY/it0dhkY1iDgSKM0DIEGjkatDt1qIGz4rmszqWU2L2umasCDk/o6r/6PS/Z8VK0bA1q9ebuuu27MNLE6Da586xrnhyyb1DBGhb3ckT6eb28m362rhpRpLsQzekOFX72lG8jOMYqn6o2SF07g3wQAvV9AHZnlShTYH+QbOLAtkS9QwJwdbEj9NXmO5Qj4TVP62yI+H4HtfnfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n2wnm/vnLEVBCzTM+cBBsMsT1X7TFM/gRfVriAGDPc=;
 b=fOGxnVx7MHrLd8E3FGzMd3Ge93m8ML4qgp65CcUn/hgtDlrufkfjGrV2ELdQliMLx9lK6RgUl7is9tNKPBpajcqxEEUUdJ+LJXQhROaLaq8uH570k63mu3lGfeMm51xJ2mErAe22dYSoS5MIsIrGTpJVu9QYiUTro5Wum4rMwd2Z9duHd6ZrweTwr8dn/yej4/W5jtti7//ehd74cTpJp1EuBUEq6odfYQaztjlRRTGJFTYlHRLHy+3gK8TQKHfTRADXFiQGm2eY5NzJ0Ubrk/rLM2qXSpdH2viawdB+yHfOW4w6wzVrWnFcU3nY6L+YBm49dfUVusTJkpUwCsRCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM3PPF5F63655A7.namprd15.prod.outlook.com (2603:10b6:f:fc00::41a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.8; Tue, 20 Jan
 2026 20:51:06 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 20:51:06 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "wangjinchao600@gmail.com" <wangjinchao600@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com"
	<syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH] fs/hfs: fix ABBA deadlock in
 hfs_mdb_commit
Thread-Index:
 AQHchQJlsj80quEwJ0uCe1jfsMW4jLVSDkAAgACHcICAASexAIAAt7iAgAVeTwCAAHVwgIABSiCA
Date: Tue, 20 Jan 2026 20:51:06 +0000
Message-ID: <3a5b428754b6e006025c462f37e610b5a5e361a5.camel@ibm.com>
References: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
	 <20260113081952.2431735-1-wangjinchao600@gmail.com>
	 <a2b8144a25206fba69e59e805d93c05444080132.camel@ibm.com>
	 <aWcHhTiUrDppotRg@ndev>
	 <d382b5c97a71d769598fd32bc22cae9f960fea70.camel@ibm.com>
	 <aWhgNujuXujxSg3E@ndev>
	 <b718505beca70f2a3c1e0e20c74e43ae558b29d5.camel@ibm.com>
	 <aWnybRfDcsUAtsol@ndev>
	 <0349430786e4553845c30490e19b08451c8b999f.camel@ibm.com>
	 <aW7Vy_RpxseBC4UQ@ndev>
In-Reply-To: <aW7Vy_RpxseBC4UQ@ndev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM3PPF5F63655A7:EE_
x-ms-office365-filtering-correlation-id: 78ee087a-a811-48b3-2678-08de5865a1cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTNmMjhpa0lPa0szcUEvLzFwWGMvRmFIV0ZzYmRhUTNWdDZMaFR3ckpWdHQ2?=
 =?utf-8?B?NmV5SjdRcUxmVmpsb29PeUxVclRuQXpzaVRsR3FRWEhYRW14bStMS1hoWDZY?=
 =?utf-8?B?Mnp1MktVaG5DUjQ2akUvUzZwd1drWWVydTJibnRGei91eWFOS0dwZDJ0cGVu?=
 =?utf-8?B?OXBQdkxjR1RIQWpqRTF0aDJkbDYxNUpleHREYS9wVlpPc3RUR0piaDl5YUVU?=
 =?utf-8?B?RWkrZEVKdkdOckg3SS9UVmNlZFVTV29qQVU5Q3FQZ3VqcU9WRUdZVXAyMVF1?=
 =?utf-8?B?enk1RDMwZDU1NU4zcnNjUW9wNlZ3cG1VWDF4NjJEWnNtb25jNmtQT0pZU0sy?=
 =?utf-8?B?V3llNWZIRmxOQldsZHM4U3drSTE1b2Y5S2JaVHJKQWxHM3EybnlYV3NkUUZW?=
 =?utf-8?B?clpSNENRWko0anhic1JQTjgwcld0Mis0Z0trQmlZT0k2K08wV2pZZC9pcEkw?=
 =?utf-8?B?R1VyTlo5ZDFUUG9CQ0RFTW1kUE9ReUlVK2d2bDgrdFRqd1dxa1UyRWd5WStr?=
 =?utf-8?B?cUtuM0tYQWVjclRtalZlMnI1YnRXMUE1UlNqbCtFMGZ5RUV1S3NmS1VsM2NJ?=
 =?utf-8?B?a0wwU0FBamtnQ3phK1E4OVpxZkZkRzN2di83YU1sQWYyWjRveldDd2lpTHhO?=
 =?utf-8?B?cXdOY3lST2xOTEZ5ZHJuQVluSWcreFYzMlBScE15bDNsMnZkOHg4TlJZK2Fx?=
 =?utf-8?B?WmthMEZ1T1JnQkVJNmJNRVRJclFqczVXaCtJUDdjckFRSGpMNDNYSFVtQnh1?=
 =?utf-8?B?UmxuNHo2YlppUzlZa1pDek1nNzMzTXhXMEoxYktHaE5pL2RXNFkzWFJKRUht?=
 =?utf-8?B?OFpFZytaTXhxK1FGYUNKRm1Wbk50c3R1VHNVVWpIczNVOHQ3WldLOXhXc0g2?=
 =?utf-8?B?ZVlscXA4SHVocy9sdVBRc2ZOMFJaSEpEbEpSd0h2Z0R5YjY3eE1HRzUzKzNT?=
 =?utf-8?B?V3hNTWRMTFN4UTJQZVZ3dXBBQ1kvU0N2QVdyOE1sZEFBZ0x6ejMrNWlXaGNK?=
 =?utf-8?B?WmtSbHlLa29WR25CQTdvRUJTMVo3WEJoYVhnb25oNnNQYnRTdWZ5cSt5WDlr?=
 =?utf-8?B?WEtsVGlBVkFuSkZoQi9COVNYRXhPbGNhSWh6RlBRemRoK3U2Um4rc2F2NzY2?=
 =?utf-8?B?cnpCSkQrbnF3ZThMeC9tTzVzdWZmS01ZanpIazRQV2cwVjgxakhkazdCc1Vi?=
 =?utf-8?B?cU5vUkFHQm56bkVhMHVoc1RMWUVGYVd2bHVqSlBNRnJtZFRiWUk4ajZVRHBi?=
 =?utf-8?B?ejQ5VWh6a1ZuYTZUWGtzbTlKM2wvaGZyQkRxU1F2c3JiZEtDK056Y25pbmV1?=
 =?utf-8?B?elBZQ0hkZXdtRGdUTHpkN1gxa1VvdzhYdFZYQzNESW5ib1lpYmZ2MTRqV0Zt?=
 =?utf-8?B?c1p2aS8xa2Y1M2NYMUdVeUkwU3JoTzNRcHZFbUdPbXNocUduaGw1WEJsNHRG?=
 =?utf-8?B?Nm12U0NzMjM4MGhnMXpLZmQwc0VMUGpqaVFvd3ZUeFFxdGdkc3lhQjh0aUh4?=
 =?utf-8?B?cjRFdGVOYTVrS1VNYkR3U0lWU3NiL2FXRFFFeWNIenBwNUJ5djRIZDkwSklM?=
 =?utf-8?B?MGJ6bXhiQk5salUvNDNRbmVpdysyVmFXOWhNZkFGLzhZRVorUXo5djYzU1p4?=
 =?utf-8?B?UDJ0NmIyZ1lLTWRsSlUrMzVxVHRIdTlWL0krQm9sSHNoOFJMZk5ERWVLU2NS?=
 =?utf-8?B?R1VETGxGZkcrSEZCOEZsMnNidkNqOTgrZVpOeG52eW5Ud21leFVuN25Uby9x?=
 =?utf-8?B?S2tYRm9yNk9sUGhnVDl2VkFKSnBKdW9QbE9uTXRwbVIyc2F3cUZPUDVSUVND?=
 =?utf-8?B?YUxSNStkYldqaDk5eEVlaGF0ZDV3OE9WR1NDM3JabmwwU1pjZVV3YzRHSlZ2?=
 =?utf-8?B?QkFOVXpLSkJGYVZQRlNDRWZaUzZqNjVoSHlDL3BCeksyY2xUOHZoK2czNlI3?=
 =?utf-8?B?dlZweUxrTWxjeEI3Mk1NaE9mbHNUMVM0c21YbjdNbXJET1B0SS8vOXBZZGdn?=
 =?utf-8?B?MlA0S2daWU1OOFZpb1RNRXlCUEtLT0hLQ0labVlhc1pPdlp2bXNkRWh6dkp0?=
 =?utf-8?B?OGVwMXVWcXZ6VkpYbTErQ2E1Mm5JUnBwdGlrcTZOTlQ0WGUxY2F6SHRaTk5j?=
 =?utf-8?Q?fa/Y4AnmaMasB5LuouB6DcKmm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yno3WGlYN3N2Rk9odUY3UHo0bDBVL3hJU2VjdlZZb1lldnpDSVdLOThiYzBa?=
 =?utf-8?B?ZnlTMFlTWDBwVk1FWEVsK01vZFJjWk1ndUNKZVRmVFNxTHZudjE5QjVrclN4?=
 =?utf-8?B?U2ZWZ2NQMzBxUUZVeVovc2FRNXVOL2NmUTlIUkJUWEl5SHlSK0Q1c3lnS0xD?=
 =?utf-8?B?RElkT3VIYTBvOWp1NUR1bE01TGhWcEdvYWlMblJDMlZOMWlYNnpZaUxvazJN?=
 =?utf-8?B?eWhZNGFMRWdsY0ExTmNjS25kRHNJOGJZRXQ1QnUxZzlnQTVBQW9CdmFFWDZC?=
 =?utf-8?B?SmNnaDMvYVkvbjV2KzY3R1V6M0VWWUYzeU5ML053ZGFjbG5vdTM2d2drQkhL?=
 =?utf-8?B?U0FGR0FEMmJzQ2ZITTU1MmV4d2M0dmo5bGxwL0JlU2J1ZlVLV3VzVUtrcHNv?=
 =?utf-8?B?YXpIV213RHNkVVhoR20rQVZ5Q1Y1eXlzcTV3UlZFbE5LaS8rcEFvMjg2R2N5?=
 =?utf-8?B?NFd5K1BDRmlWUlZMQkF2QXRIaktFVW8rV092ckNmSGI0RHdJVUdFY2xiWngw?=
 =?utf-8?B?b2p5U1FUaC96Q3J6d29VVjBIeTU5YTBKNE92Qmh4WHBoNkNjVHo0Z2tVWlVV?=
 =?utf-8?B?L1dSUEdlSlRIMGJFQzNmQm1nMzNTcjVkV3VWbnJ6SFR2NkE1S1NXc2FBclB2?=
 =?utf-8?B?OHBrcnFjSG94ZEp6cjNqL2VEeTNqbG9IRW9NazJHVmNlU0lqNm12ZUtGSUNy?=
 =?utf-8?B?emJXdmFQWXhPVUJTbGJkRDVDWlZwRWJCYWoyN3hFYU5DUGtvTFpUazRiUTJI?=
 =?utf-8?B?aTVRdVBrSW1qNGpWTUdqS1NVbVhjWW5WL29CVjNjcHZPSVJsdk1PTmdFa25h?=
 =?utf-8?B?c1BQWTYvUzVaK2gxbGo0MDBwTm4zZ0tSb0JGM1R1R2VaV1g1aWJXQnM3Rm5x?=
 =?utf-8?B?NlVuUDFXSEhIdVhiWXFuMEpNVnNsS1U2MDd3elRsY0p2YjR6Q1c1TUFZeVhi?=
 =?utf-8?B?YndLRTZIS2dxSnF3SlFucDhHZ1dBT1dNamRHcDBQMitISnBQOW9HbUYzTGJL?=
 =?utf-8?B?MTdONHlBallJMkxFeDdlaUZzM3FGMmx0U3FldnhRZE1qbWhHZWozWTRoVUtM?=
 =?utf-8?B?RGh0enJsblRqNFpHRjF6UFJUdHdlb2UrRXlGSmhYYWZUbnBrTGRwN1Nna2cv?=
 =?utf-8?B?aHJpeDdsRWZOY05xS3QycFRXRkFrTm9YVTIvdWNqSDBHNExWUmV3Z1AvYUNr?=
 =?utf-8?B?QzRJMXQyUmhoYzhMaktMeWdOKzBmWkZENHlIbHB0TXpmMEJQU0xRV29wVEtw?=
 =?utf-8?B?NFhGOWhDdldPOFdYTTdkKzl3L3lWS1U3QjI0elZjYm1udXZPb0theDErc1Vz?=
 =?utf-8?B?MVc4ZnBpVFVtaU56a09pR25nSGRDa2FBTWxLYWkvQjBpaDhUeUFKZ2dxRWV0?=
 =?utf-8?B?RWpjemZ6akc5bXpxSjVIMUVOVWpPK3phOUNiMHdYcFFyTnNnQ3M0RXhLZ0t2?=
 =?utf-8?B?ZW1IVEErT3hxQU54a2V2ZE1EU1hCT2RxRXFLd2RuT2F6cUtSazNyVlFvZVFO?=
 =?utf-8?B?Ym9qazdWbzZ0dHFoaGE1L1hlRGVOMHpwemJ5aTNrTmRWaTR4citIekNHRW5R?=
 =?utf-8?B?OXRmUFVWcm8vZUZaeVY2QzBZUFE4eDhpVDNDKzEzQzEyNDRhUnZHaUoyTnRH?=
 =?utf-8?B?bFI4MTdESnNVYisxSithdThtU3NFbHJUeFVZcWk3QTAvM2U0MjZIS0ZWR3Fu?=
 =?utf-8?B?Z0VZSzBVdXY4M0JyODhac1RnMExzRG1Ud09UaTYrRWUxdTM2K2ZUdGV3UzhX?=
 =?utf-8?B?NDIycVVtSzBrVjJUUUZSK1o5b3I3TjBaeC9LNlh4Um1uQzUyVWVqbFRxeWFD?=
 =?utf-8?B?ZmV1SU1ON1Rjc2dBMnVWeTRDMnFFUTlpSElnZGpySzVPM05ENTgxa1VpbnhC?=
 =?utf-8?B?TTZ5VmFFMytaS3ljblkvcWNXNmlReWhDS1ZyMnJrZmZHYitlS2UzbzI3b0h2?=
 =?utf-8?B?bVFzbGY3a3hmek9xYTBoNHlyYWFGbUs1Wmc2QVNWSnlZRjMyN0llaXdkOE85?=
 =?utf-8?B?MDI5dnEvY0U3Mm5FNkxncjBlYWdnRFlhRG4rdFZYemZjVVo1NlJHK1gzQ2x4?=
 =?utf-8?B?emRaTm53c3RzWjhnbUN1SzZzTE5qbFhBY3FCeEF6bVV3Y052bTU5MVhLNWFW?=
 =?utf-8?B?NmZROE9aS281SUFyVXpxd2FIeE40b25rME5aM3dBZWJKTlRVeWNQVC9HcXNX?=
 =?utf-8?B?UWV2aG8yMFdQNXZ6VUp3VGh5U0ZBVk9pTVpKRUZUVWtvUzNpNHdDc2ZVY2pM?=
 =?utf-8?B?OFV6U0huZ21NT0ZveURJYUJ3UzdqUm9IamEzSnM2aFdDb3FPeTV1RjVacVZQ?=
 =?utf-8?B?TmwvQ3FVQ0FEemg4S3FQYmR1NUk4RWtEdFJJWmZ4Zy9OZzlRSkZuV0hXKy81?=
 =?utf-8?Q?UAespLzW9Eq7u04bDIjTcnhmR6Ioi2GCsclYs?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ee087a-a811-48b3-2678-08de5865a1cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 20:51:06.2099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ucOgPp61DSAYvIu2NKI6uLtudbQcKyVaBpOuoIxCtETOeT9xQL8W/SV834+Qc5ZqvjgWhrMvWfZaZMKWpSG/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5F63655A7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE3NSBTYWx0ZWRfXyD15vuLTwKBz
 icc3R2TIoi/YsuR28DmhBY0tUJyKKVNsh89DqO8uHbEdC1Mwyh3U+yXNPVPzhzflUXMaoMuZDd0
 mLl5HlQc4Q5S1yvRTBcETZdr+fVzGpAxKkOwIygTQTM7V3JFSYhWAzwu+yaaCe9PGCVs0OHpyhh
 ZTqR7RfccxTEkjzh/EnVF+Qk9w5gP430lfEpt8KKXGneojwn6G8t4jILrd/E5p8eBAdDxvLepgC
 HSwSb+Kb+FnEwt5QMTuAtn3e54RSAQuNYJMVnpQG7//Py0jfeLjqavsMwvL85Io4ikzy//jNpYx
 aoizS+YNt9UUDmPo5Ne6fYqtRmFJKTMGB1mIixt0LGHZ6HsHPJDUEBSORDJjH2OgWyeCVwLDeGK
 b/jmzsidFOlrsQRjZwy0qT83HaiRghBw8jFe8VPCau+TOd1BTvPbCVooq2gwkxWrPy5yGeCGUJ1
 jaNVZ9+T7D6Cv92ugNw==
X-Proofpoint-ORIG-GUID: 86a1BN-4GAbhAJNoEIZxBaXiT2fLu8zm
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=696feabd cx=c_pps
 a=ziZy7zD1dJq8wwEro8zYwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8
 a=UnWnYN_Vox0bqZkaOY4A:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-GUID: eTzOq5eY23Smt50wRNAfDL69CtqFELCZ
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5D282DCB0963047BE7716FBB0FA1D06@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [RFC PATCH] fs/hfs: fix ABBA deadlock in hfs_mdb_commit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_05,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2601150000 definitions=main-2601200175
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-74732-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,reject];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1e3ff4b07c16ca0f6fe2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E81C74C401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 09:09 +0800, Jinchao Wang wrote:
>=20

<skipped>

> >=20
> > Firs of all, I've tried to check the syzbot report that you are mention=
ing in
> > the patch. And I was confused because it was report for FAT. So, I don'=
t see the
> > way how I can reproduce the issue on my side.
> >=20
> > Secondly, I need to see the real call trace of the issue. This discussi=
on
> > doesn't make sense without the reproduction path and the call trace(s) =
of the
> > issue.
> >=20
> > Thanks,
> > Slava.
> There are many crash in the syz report page, please follow the specified =
time and version.
>=20
> Syzbot report: https://syzkaller.appspot.com/bug?extid=3D1e3ff4b07c16ca0f=
6fe2 =20
>=20
> For this version:
> > time             |  kernel    | Commit       | Syzkaller |
> > 2025/12/20 17:03 | linux-next | cc3aa43b44bd | d6526ea3  |
>=20
> The full call trace can be found in the crash log of "2025/12/20 17:03", =
which url is:
>=20
> Crash log: https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D12909b1a=
580000 =20

This call trace is dedicated to flushing inode's dirty pages in page cache,=
 as
far as I can see:

[  504.401993][   T31] INFO: task kworker/u8:1:13 blocked for more than 143
seconds.
[  504.434587][   T31]       Not tainted syzkaller #0
[  504.441437][   T31] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  504.451145][   T31] task:kworker/u8:1    state:D stack:22792 pid:13  =20
tgid:13    ppid:2      task_flags:0x4208060 flags:0x00080000
[  504.463591][   T31] Workqueue: writeback wb_workfn (flush-7:4)
[  504.471997][   T31] Call Trace:
[  504.475502][   T31]  <TASK>
[  504.479684][   T31]  __schedule+0x150e/0x5070
[  504.484307][   T31]  ? __pfx___schedule+0x10/0x10
[  504.491526][   T31]  ? __blk_flush_plug+0x3fc/0x4b0
[  504.496683][   T31]  ? schedule+0x91/0x360
[  504.501085][   T31]  schedule+0x165/0x360
[  504.505366][   T31]  io_schedule+0x80/0xd0
[  504.510102][   T31]  folio_wait_bit_common+0x6b0/0xb80
[  504.532721][   T31]  ? __pfx_folio_wait_bit_common+0x10/0x10
[  504.538760][   T31]  ? __pfx_wake_page_function+0x10/0x10
[  504.544344][   T31]  ? _raw_spin_unlock_irqrestore+0xad/0x110
[  504.551446][   T31]  ? writeback_iter+0x853/0x1280
[  504.556492][   T31]  writeback_iter+0x8d8/0x1280
[  504.564484][   T31]  blkdev_writepages+0xb7/0x170
[  504.569517][   T31]  ? __pfx_blkdev_writepages+0x10/0x10
[  504.575043][   T31]  ? __pfx_blkdev_writepages+0x10/0x10
[  504.580705][   T31]  do_writepages+0x32e/0x550
[  504.585344][   T31]  ? reacquire_held_locks+0x121/0x1c0
[  504.591296][   T31]  ? writeback_sb_inodes+0x3bd/0x1870
[  504.596806][   T31]  __writeback_single_inode+0x133/0x1240
[  504.603290][   T31]  ? do_raw_spin_unlock+0x122/0x240
[  504.608620][   T31]  writeback_sb_inodes+0x93a/0x1870
[  504.613878][   T31]  ? __pfx_writeback_sb_inodes+0x10/0x10
[  504.637194][   T31]  ? __pfx_down_read_trylock+0x10/0x10
[  504.642838][   T31]  ? __pfx_move_expired_inodes+0x10/0x10
[  504.648717][   T31]  __writeback_inodes_wb+0x111/0x240
[  504.654048][   T31]  wb_writeback+0x43f/0xaa0
[  504.658709][   T31]  ? queue_io+0x281/0x450
[  504.663179][   T31]  ? __pfx_wb_writeback+0x10/0x10
[  504.668641][   T31]  wb_workfn+0x8ee/0xed0
[  504.673021][   T31]  ? __pfx_wb_workfn+0x10/0x10
[  504.677989][   T31]  ? _raw_spin_unlock_irqrestore+0xad/0x110
[  504.683916][   T31]  ? preempt_schedule+0xae/0xc0
[  504.688852][   T31]  ? preempt_schedule_common+0x83/0xd0
[  504.694389][   T31]  ? process_one_work+0x868/0x15a0
[  504.699698][   T31]  process_one_work+0x93a/0x15a0
[  504.704752][   T31]  ? __pfx_process_one_work+0x10/0x10
[  504.717115][   T31]  ? assign_work+0x3c7/0x5b0
[  504.739767][   T31]  worker_thread+0x9b0/0xee0
[  504.744502][   T31]  kthread+0x711/0x8a0
[  504.748698][   T31]  ? __pfx_worker_thread+0x10/0x10
[  504.753855][   T31]  ? __pfx_kthread+0x10/0x10
[  504.758645][   T31]  ? _raw_spin_unlock_irq+0x23/0x50
[  504.763888][   T31]  ? lockdep_hardirqs_on+0x98/0x140
[  504.769331][   T31]  ? __pfx_kthread+0x10/0x10
[  504.773958][   T31]  ret_from_fork+0x599/0xb30
[  504.779253][   T31]  ? __pfx_ret_from_fork+0x10/0x10
[  504.784718][   T31]  ? __switch_to_asm+0x39/0x70
[  504.791355][   T31]  ? __switch_to_asm+0x33/0x70
[  504.796167][   T31]  ? __pfx_kthread+0x10/0x10
[  504.800882][   T31]  ret_from_fork_asm+0x1a/0x30
[  504.805695][   T31]  </TASK>

And this call trace is dedicated to superblock commit:=20

[  505.186758][   T31] INFO: task kworker/1:4:5971 blocked for more than 144
seconds.
[  505.194752][ T8014] Bluetooth: hci37: command tx timeout
[  505.210267][   T31]       Not tainted syzkaller #0
[  505.215260][   T31] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  505.273687][   T31] task:kworker/1:4     state:D stack:24152 pid:5971=20
tgid:5971  ppid:2      task_flags:0x4208060 flags:0x00080000
[  505.287569][   T31] Workqueue: events_long flush_mdb
[  505.293762][   T31] Call Trace:
[  505.297607][   T31]  <TASK>
[  505.307307][   T31]  __schedule+0x150e/0x5070
[  505.314414][   T31]  ? __pfx___schedule+0x10/0x10
[  505.325453][   T31]  ? _raw_spin_unlock_irqrestore+0xad/0x110
[  505.331535][   T31]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[  505.354296][   T31]  ? preempt_schedule+0xae/0xc0
[  505.359482][   T31]  ? preempt_schedule+0xae/0xc0
[  505.364399][   T31]  ? __pfx___schedule+0x10/0x10
[  505.369493][   T31]  ? schedule+0x91/0x360
[  505.373819][   T31]  schedule+0x165/0x360
[  505.378340][   T31]  io_schedule+0x80/0xd0
[  505.382626][   T31]  bit_wait_io+0x11/0xd0
[  505.387219][   T31]  __wait_on_bit_lock+0xec/0x4f0
[  505.392201][   T31]  ? __pfx_bit_wait_io+0x10/0x10
[  505.397441][   T31]  ? __pfx_bit_wait_io+0x10/0x10
[  505.402435][   T31]  out_of_line_wait_on_bit_lock+0x123/0x170
[  505.408661][   T31]  ? __pfx___might_resched+0x10/0x10
[  505.414026][   T31]  ? __pfx_out_of_line_wait_on_bit_lock+0x10/0x10
[  505.420693][   T31]  ? __pfx_wake_bit_function+0x10/0x10
[  505.426212][   T31]  ? __lock_buffer+0xe/0x80
[  505.431646][   T31]  hfs_mdb_commit+0x115/0x12e0
[  505.451949][   T31]  ? do_raw_spin_unlock+0x122/0x240
[  505.457642][   T31]  ? _raw_spin_unlock+0x28/0x50
[  505.462552][   T31]  ? process_one_work+0x868/0x15a0
[  505.467897][   T31]  process_one_work+0x93a/0x15a0
[  505.472917][   T31]  ? __pfx_process_one_work+0x10/0x10
[  505.478463][   T31]  ? assign_work+0x3c7/0x5b0
[  505.483113][   T31]  worker_thread+0x9b0/0xee0
[  505.487894][   T31]  kthread+0x711/0x8a0
[  505.492015][   T31]  ? __pfx_worker_thread+0x10/0x10
[  505.497303][   T31]  ? __pfx_kthread+0x10/0x10
[  505.502429][   T31]  ? _raw_spin_unlock_irq+0x23/0x50
[  505.510913][   T31]  ? lockdep_hardirqs_on+0x98/0x140
[  505.516183][   T31]  ? __pfx_kthread+0x10/0x10
[  505.521290][   T31]  ret_from_fork+0x599/0xb30
[  505.525991][   T31]  ? __pfx_ret_from_fork+0x10/0x10
[  505.531301][   T31]  ? __switch_to_asm+0x39/0x70
[  505.535600][ T8874] chnl_net:caif_netlink_parms(): no params data found
[  505.536284][   T31]  ? __switch_to_asm+0x33/0x70
[  505.560487][   T31]  ? __pfx_kthread+0x10/0x10
[  505.565188][   T31]  ret_from_fork_asm+0x1a/0x30
[  505.570372][   T31]  </TASK>

I don't see any relation between folios in inode's page cache and HFS_SB(sb=
)-
>mdb_bh because they cannot share the same folio. I still don't see from yo=
ur
explanation how the issue could happen. I don't see how lock_buffer(HFS_SB(=
sb)-
>mdb_bh) can be responsible for the issue. Oppositely, if we follow to your
logic, then we never can be able to mount any HFS volume. But xfstests work=
s for
HFS file systems (of course, multiple tests fail) and I cannot see the dead=
lock
for common situation. So, you need to explain which particular use-case can
reproduce the issue and what is mechanism of deadlock happening.

Thanks,
Slava.

