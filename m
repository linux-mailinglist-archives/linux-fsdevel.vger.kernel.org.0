Return-Path: <linux-fsdevel+bounces-28340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0AE969845
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38C81C230AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018C81A265F;
	Tue,  3 Sep 2024 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HQLJyB0f";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HQLJyB0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2063.outbound.protection.outlook.com [40.107.249.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00619CC33;
	Tue,  3 Sep 2024 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354359; cv=fail; b=e1iGXh+c8j+rVhzjM7YPvzzCQREbIUmlLnLbwbkHHuCI6J7KVvGt9Fb3klRh5ZO0fG4dZ6AdWoOSmSohs7RHQHkh3E4mfb2H0eQQJ7+2WoPxwbMP4tJ3eoqf5ujnbVSnZhcSP0tMAoEg0Oi+5fWu/l/zLVVOTDed2w0sqB/go2Y=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354359; c=relaxed/simple;
	bh=PYszyiLWU9X2+NL3sLPbhhdJ7RuP5oQPMoLGxBB3a0I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3/nxvEMEuvDwk7VbLG/DW3IIe/7eI/WOmHiTraLE2ElugvK4NpEMB2zWNZpZeRtHMtdDDPpBe1Yqhoc1uPOF0eiL8X/iIvnrEUra87d4iSPH9E7X9BdJenqxWEfksE0f1yjD8BEK2TV60AC9TrlQz4igbkkmbpiWc3VM8n2Qho=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HQLJyB0f; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HQLJyB0f; arc=fail smtp.client-ip=40.107.249.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cQfOBGCoaJXmNg5Y0KU2jliM4YgiPKVpObZd6Ch2PBgpjRxwrtJGDhZmQxyhKou32gAoaNv/43PUGIuIY850lwbTBM07/RIhS2c6KIKhQE5Qpgp+J7cpCB0qG79jWQ1hWtv6kQfQKEOXbECa0DLTM7l7CQ+owwEovVjwLIxTIAA9GhHoGcWvJDuaIh31+r+dA30noGqzuANVtx6smrsFlTQEVhVewa39NSrkE0BkSsPsmcbWifBNZ8XXT+NsDdYUswLsdgv50JGCcE3FSJyiXM5Wxhw8SqWGyn5WuJyXnN4Rz2/96PyPNwvR9O/lm66Ho2J7EjzjP2Dq89XhcX7XtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sfRshfcYXYAqALdhl/s+8f2cqC2vS3QZ2MqRw6p6SE=;
 b=ZNt1Pcm5NnnAOunJMXVRKNQHy1L7wFvFKRC/BVUHrB3CSTUHqelFQ0G4NmlWNCs3VDKVh8I3Dd904QtlUulX6aH+6XpVQDj+3EjO8fK+9WMUAabbsffuaq/xGdLVgThtY3j9YHD0i8nUrmfYA6LzR7AJymjxiroBQ4CVj6kiIbOghNUcSwhUQkrWdFuDAyaI0b19onYGRH7czra2bDMvbJYq3o3vLwkdlgJMXCcMgvTazDY0WYmZfzoAqxgl/oiXMzkLVfxbcjVe3BNh6QKkFCeuuth1gk3hdC9yvFmdDjsY4DQLZy8ZquJ3m7YrJAKzEQAvNhbHeoY+//tVcEsfzQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sfRshfcYXYAqALdhl/s+8f2cqC2vS3QZ2MqRw6p6SE=;
 b=HQLJyB0fckVMsjQg1zqTfAoJK3PvFxhvOjbayrQkOdO8ssN2+A4iVQbLAVWzF1ErbiIhD9LwOZgEkzp5rs81jgsHS3kRo0LAuGH7Vs6JD1LqdKRtjDxYH4I2Cu1zfSPGXBuOw8DHU/+Sgc44iJRV4pK9fa96+vlJZHoDvVU441s=
Received: from DUZPR01CA0333.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::27) by AM0PR08MB5521.eurprd08.prod.outlook.com
 (2603:10a6:208:18a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Tue, 3 Sep
 2024 09:05:48 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::fe) by DUZPR01CA0333.outlook.office365.com
 (2603:10a6:10:4b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 09:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Tue, 3 Sep 2024 09:05:48 +0000
Received: ("Tessian outbound 7d86ec5dfeb5:v403"); Tue, 03 Sep 2024 09:05:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f3126d8f3a8f366f
X-CR-MTA-TID: 64aa7808
Received: from L93db8b2c1ed3.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 50EED0E7-7C43-4A18-9B17-7DBDEBE09C67.1;
	Tue, 03 Sep 2024 09:05:40 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L93db8b2c1ed3.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Sep 2024 09:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpGcUjw9vLVsJx1PxHmpykK8QIy7Iix+969W/ElQaOUz8iglvneeqIyhuY7xO/1LZtsZNFQSefq3Au46Saf49fNqvVOayoTlOnLTaVxukH+FMTizd4AZ2ZldTN1WlSe6Yc+XJB9GwU9Bd1eGa3dNFYKP62p7GpN0ZXahZX3uGO6/Ji9jXs+Wifmj+z4qE8tkK0+0eImQghzYCsXoee0DEuixedeZN3tsZQKu7yy4++ZkhaA744RlpTH8xuJEBk7IAlIvh3THamfRVk61Ki+obFPA1KlsE0E8dulv2GJilQbjIfO40grrTNP1HzSs3B3fKwJx0stQ0EzOZQJ8pklPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sfRshfcYXYAqALdhl/s+8f2cqC2vS3QZ2MqRw6p6SE=;
 b=b7F1sz8g3hHRitB7xh2XzmNythywZFDnvPZlvNxkQkbv1Vwdc6MN54lQ/RXP4UgCp9D8d6jDel4jYWmADTSdPRGJT0Pnc2K82MrWNsQA/Ve8YnGHKeSN/TNvoTfX/7qwHNGpW2IQyPNbh8EbfA51tzMqmtQBEnbBQDwkOXqHzd77tvvXNFHZacaiwUqcnsd4KNoAch2WJPKoQ5l3uLXx/1gZBHuybmmtxR3WDh+kVEdVtw6tNFTj7rqOwCms4RzzpB94cyppnqYHDpwvbq+VCiNPBg47+8Z+mcpD8rzlECk0gKBNqNdkLXA/tlP3kw5AKFrY8S4HtiUEZJPPnVrfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sfRshfcYXYAqALdhl/s+8f2cqC2vS3QZ2MqRw6p6SE=;
 b=HQLJyB0fckVMsjQg1zqTfAoJK3PvFxhvOjbayrQkOdO8ssN2+A4iVQbLAVWzF1ErbiIhD9LwOZgEkzp5rs81jgsHS3kRo0LAuGH7Vs6JD1LqdKRtjDxYH4I2Cu1zfSPGXBuOw8DHU/+Sgc44iJRV4pK9fa96+vlJZHoDvVU441s=
Received: from DU7PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::15) by AM8PR08MB5715.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Tue, 3 Sep
 2024 09:05:33 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::e0) by DU7PR01CA0012.outlook.office365.com
 (2603:10a6:10:50f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Tue, 3 Sep 2024 09:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 09:05:33 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 09:05:08 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 09:05:07 +0000
Received: from arm.com (10.1.28.157) by mail.arm.com (10.251.24.31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 09:05:06 +0000
Date: Tue, 3 Sep 2024 10:05:05 +0100
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: Mark Brown <broonie@kernel.org>
CC: <Szabolcs.Nagy@arm.com>, <akpm@linux-foundation.org>,
	<aou@eecs.berkeley.edu>, <ardb@kernel.org>, <arnd@arndb.de>,
	<brauner@kernel.org>, <catalin.marinas@arm.com>, <corbet@lwn.net>,
	<debug@rivosinc.com>, <ebiederm@xmission.com>, <fweimer@redhat.com>,
	<hjl.tools@gmail.com>, <james.morse@arm.com>, <kees@kernel.org>,
	<kvmarm@lists.linux.dev>, <linux-arch@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-riscv@lists.infradead.org>, <maz@kernel.org>, <oleg@redhat.com>,
	<oliver.upton@linux.dev>, <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
	<rick.p.edgecombe@intel.com>, <ross.burton@arm.com>, <shuah@kernel.org>,
	<suzuki.poulose@arm.com>, <thiago.bauermann@linaro.org>,
	<wilco.dijkstra@arm.com>, <will@kernel.org>, <yury.khrustalev@arm.com>
Subject: Re: [PATCH v12 23/39] arm64/mm: Implement map_shadow_stack()
Message-ID: <ZtbRQYiGCZuhQcmX@arm.com>
References: <20240829-arm64-gcs-v12-23-42fec947436a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240829-arm64-gcs-v12-23-42fec947436a@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DU6PEPF0000A7E2:EE_|AM8PR08MB5715:EE_|DB1PEPF000509E2:EE_|AM0PR08MB5521:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a2af7a-9a04-4f9f-bd93-08dccbf79a00
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?EUH5bqCUfaSNiOsSOX/ZyB/ApFB05j7+3+tyQGeXuDTyfJKvF5dFb+2nP/K9?=
 =?us-ascii?Q?FGdRA88HFm0mOL3UvbgP/9KD3UlDZGUv28Gq6bwhA1XmfD6kOSkCiWFSvFzR?=
 =?us-ascii?Q?jbmJvbUzxOdt29NQM7ANiHF/K8Zh+2J5oAtHzaBG2rOPh1doaxljapVPDIWz?=
 =?us-ascii?Q?qWPjK28s8nvjZx8zB205PzxabwvXt7tbNEedUeElVoEyXV2/wJkDq2F7sVZu?=
 =?us-ascii?Q?fOQM77iuzkqFQWkXwcBYI8WI34ThFhE/1LbKkBsYGGIWbYAJ/Rw9u8m0X2Fl?=
 =?us-ascii?Q?x1TuTOFOfmXC/lTxi/ihLy5vn/7GkacV6Zvx5IrJ22rvgtB5yKNniqRW2ZBO?=
 =?us-ascii?Q?kR3WdiP3nfqQmgDyYSC8I3eqI0aAh+WkqiiKSqGELP+jfMLVmUA3ubuuE8f9?=
 =?us-ascii?Q?5zhBCRL7OkHftumxEVF49sUHhpGgqcF4YZWxOK8FgdwXZx6GJ4WLoMneHqv2?=
 =?us-ascii?Q?w9TX0kwh8BCCIXxC6lv80quNVPe2TPJv3yjf0P0dpdCwJELC9JlRE0YUDx5a?=
 =?us-ascii?Q?MEtZidvYHvgYx3h/qxAtQGblwbvyynkYdsPG1T3FM25qWSo3MudMD6ebjBS3?=
 =?us-ascii?Q?FUiOTqxWkkPubgIH48nCkVyXyp3FpBxt3PPGfHgssJmgxwVL3/x37MfA/SBG?=
 =?us-ascii?Q?fPE8XJShwEFwLiDnWxpZ6vnsg2bo8Hvvg5INJdaRksNFufgW8+ykKsiw1Baf?=
 =?us-ascii?Q?OFn2uXkAogdIrpYzivNnb1B7grf+q2VrrttVZHAt/vcEmGWSvv/xlWXFA/b3?=
 =?us-ascii?Q?oG1Cko91RuiAOGuzxMBLdzBTGSFWe7eukXrWnZWjeailcSzax6CY/2rPZB7Y?=
 =?us-ascii?Q?idrs89+F7DKEqhwta8DolgQpkNFZYHmkYTE7rzOaCVAniiis+CcQdJmPx1CO?=
 =?us-ascii?Q?OfTRMIM7hvkXBIrxddfGGKG3JNI9i5XzMcyKEiBbmJ9JLbHTdiAzoKP0HISD?=
 =?us-ascii?Q?lrXqwdS72ibyeTDEcIlS/LRiRhjnIZjtQOo+mmOic6C/8kCZEfJRkJWUfWsa?=
 =?us-ascii?Q?yPopCqLKTZnNhzuLIEFiAz3wU0nFWE2PPdd/3HS5716lBDOY9hKQX1iVLNfA?=
 =?us-ascii?Q?LHb1roUjgJV2sPGm1D8/l0uk0dyVWQbM1Ju55Tbb3MlcbLM53XpyhJh3wxfM?=
 =?us-ascii?Q?T6/FutITXtckuibP7lauUty179r+zCs7Yrdcj0kpR95ZZGbDJIuxXO2N9xa/?=
 =?us-ascii?Q?oErbUtZrC/mACoyX9wZ/+zWyvVze1fmqNx1CAPhEKwwXvxcXPP6cMS38wl7r?=
 =?us-ascii?Q?kvig+n9gGTrg5v1iTbaJ0bomkuu7FVdNabyvpC6j215hQK3zON0EgTC1mozB?=
 =?us-ascii?Q?annPdDtJRRybq/CW6h568+gSLWVL0EBJQ1FiN6b1ioxzPgNh5Udg6bbJ7v8G?=
 =?us-ascii?Q?zNQIF2SwOxsk+6rLAdUxTKdQW6qNtarTmAFNL6vRI8t5r3kEDNIHFOCak9Bj?=
 =?us-ascii?Q?RJV0fDt5E0OU77u1SUvrU06g6yS85bKG?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5715
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:50f::15];domain=DU7PR01CA0012.eurprd01.prod.exchangelabs.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bb5bcc78-003b-42af-fb29-08dccbf79163
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nw6Rn+2MMb3A6R+y0D2u6TDg+xfa2P+YKPTP76N8B0p9F7u70TzBD5wfo6UI?=
 =?us-ascii?Q?6AtTyiwSqqC+2TcnBHR+DGE2p4PTVqnuORGN1QAcgoICPlHOo17rPwtXZAVW?=
 =?us-ascii?Q?CRkBUOnaCuSEcbw4TeubQAl/mOVMFWVVbuqPFIuEMeFll7loEa6AC/Q7NqU0?=
 =?us-ascii?Q?ZgPcMeNcmXCX0g/imbMZwcuCesWOrbaTyC9kMzeS0yjkeHfGrYv6K2ptZwf/?=
 =?us-ascii?Q?W5mMD6nAMh4CxFgdsYOjucmnyTZRXFNdU3gAX6QPUEunGDjlbN8CntIt2+K0?=
 =?us-ascii?Q?/xWIGaDb4snxZV83qYBHXVlFwUTDdUKtH5+YgP93wN7DogD1wbC0uAeU3Cac?=
 =?us-ascii?Q?f2i/36ceidKbBE6FGfRWYoYPAFLYUkmL9Od5eLLQ9YT+uj+f1pBMahcWEsdz?=
 =?us-ascii?Q?LhVsChdXYgqLiedVJ1T7/BGzLK+u2pK4edhCajjtcl42WGX43jB3083URFtN?=
 =?us-ascii?Q?HkdXz3cM/lZ1SjjPZHvzy04d2PoKXQ4MFVN9Qu8eSN83GJzcRlA30d1KieEQ?=
 =?us-ascii?Q?8lNx8p3U0gtn9yS3ddngBVngewcoQqtLm3gAkQ3Z7B8Kc191Xg0vwzL1ftbr?=
 =?us-ascii?Q?rDdADOgMI3TKdlHXlKuDOQPDSzXxeawqWgEXDRpIyktusOdC5OkZv1l9KZaV?=
 =?us-ascii?Q?dR/GppsW9K6TKT2qvk0MOFWaCCZyrIwu/LZamTwZzkBSa8QpPyJPqu3dSJoF?=
 =?us-ascii?Q?mjfV+LJDGtRUfMPnLt+bM1swFNxhozSLSfXjgixeL46/XwIsZrHd310/hjpy?=
 =?us-ascii?Q?eYj0BTVk7i+8mDQE6gjJQZgo7C5h5nRLGvPylPkF5aFvx1s5anxWkYiy6pOE?=
 =?us-ascii?Q?kyOLjyunYfPLQaSfkcUu5BagfSRwkdCn+MGPpHK4VrJfXWF+XsDdvE3VAEk7?=
 =?us-ascii?Q?SYJhQy6MNvEvE7r6qciZkZ0T+jawHok7urNZW5Y8gN3sUrsPpElvsEMpWfZB?=
 =?us-ascii?Q?5Zw66vmpajhNRJftf1vc2pSutk5mw2HJKYkZ3A+2tv1Owdg3DU/9c+0fZsHS?=
 =?us-ascii?Q?uuJdBSPzKilDCE7WBhGNNcmFV52UCLZjmMz3dYn6gBZTJ9J7mjwpmm58QBd2?=
 =?us-ascii?Q?HuunStcGHsJuzHw3k8wq5pnfaNLflGx3xwQFvH+KTmkX0TTicQm2VaguCc2C?=
 =?us-ascii?Q?0q22yYGtMek726jCPFBkVXEuldnXa7lCPLRbuLhDcflHscfh1PrumHGmd6ro?=
 =?us-ascii?Q?inn2T8qlvt5c/qSUpXbzQ2vEJcmCxEfKXrXgvnFCyMJN2cRslT+8NuhuzO8X?=
 =?us-ascii?Q?GdjTMV/JwikWSEdmMGre4DmSnrkQZ0QOklmLSILZs6/kmyEECIhV3e2skb5w?=
 =?us-ascii?Q?pJaySS46fViHePDx5gPjsYwSsDjQU1kbfboDW2d6BeyeBjSoGzHFAyeWYGtW?=
 =?us-ascii?Q?fbikUBiicgEzfkbeav/hNIONhUOQMVewG3a76/tbWMBKlCbxCwERLOekYWlQ?=
 =?us-ascii?Q?u7iXxcN2xUOAFumQnRYWLXSsUliMUB6Z?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 09:05:48.0555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a2af7a-9a04-4f9f-bd93-08dccbf79a00
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5521

On Thu, Aug 29, 2024 at 12:27:39AM +0100, Mark Brown wrote:
> As discussed extensively in the changelog for the addition of this
> syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
> existing mmap() and madvise() syscalls do not map entirely well onto the
> security requirements for guarded control stacks since they lead to
> windows where memory is allocated but not yet protected or stacks which
> are not properly and safely initialised. Instead a new syscall
> map_shadow_stack() has been defined which allocates and initialises a
> shadow stack page.
> 
> Implement this for arm64.  Two flags are provided, allowing applications
> to request that the stack be initialised with a valid cap token at the
> top of the stack and optionally also an end of stack marker above that.
> We support requesting an end of stack marker alone but since this is a
> NULL pointer it is indistinguishable from not initialising anything by
> itself.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>


