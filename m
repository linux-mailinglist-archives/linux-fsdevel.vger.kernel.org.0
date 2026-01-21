Return-Path: <linux-fsdevel+bounces-74812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJzWJup6cGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:06:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E34D52939
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9436A4A6408
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 07:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDC63191C3;
	Wed, 21 Jan 2026 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8JN/DbJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894212DCBF7;
	Wed, 21 Jan 2026 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979159; cv=fail; b=amUz8toi1lJkbJ4ylaptdmwyXe1B0jFobPoxS0cBqvXSz7qkXymojowJ8QJ9Vt9uXcjxM7Ep93MCohP7wOBlggw3qZQTQokYp7YNnRwmy1PIC9Fud0gqjQankGUr/7gMZbsN34CzNTF5NCePOs7tGf+iLIWl64VlRdTs4tM4TZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979159; c=relaxed/simple;
	bh=hoVJRwZ6AlA2CPYyh7EAwMkgxAYc3PMZk4bvdOMXEdo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=DMrvMQIsZW7f1A+cWsRK640zgLFLUy7QV52M5jvKb2gqjqemaHi5P8TvF4ku9u3+QY8SDWZ2v4dg11RJG52a/wqL1g3N7TQZn8wX0aSdKpnw0etS347tEtcx96K/lmTTnksAaLDdybsAc5BmW3hPVCYrcmUARIwSe2AAF8U0DSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8JN/DbJ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768979158; x=1800515158;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=hoVJRwZ6AlA2CPYyh7EAwMkgxAYc3PMZk4bvdOMXEdo=;
  b=P8JN/DbJCUh9fu7pBsiSXPjyQX+kYlTrbz4tgB0BhsFNYfWQGX9Nfkup
   NWmmv30MbSAr+rj1VlKB1Qh7sil1Fh0+T9JCeYbvILDnfpNvjMR3V8ihl
   lJ8E4+o7MHaNzBn8qi3efYWlhCtYtU0O1PslKikbYlN7lD6cQax6g2hTs
   io04VdAYKfmflYNL3K//RJG/4ex/PIiONGtghuuKJMkRHVlEQk9dwhb2T
   2MguV3O4sValKEBNso6wGFX6aFvAEkW7sCMILrjSDsoD3bAF6VoWQHsLd
   f/NNRWXN7slxMBym/bgVChK1UEflOXeewaTw8ga+VoSfecEZW5w4Aeu9I
   A==;
X-CSE-ConnectionGUID: ccRuzyg8Q/62JM9KHmNayg==
X-CSE-MsgGUID: GeIzscDKR6uGtcoQw7tW0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70107041"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70107041"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:05:55 -0800
X-CSE-ConnectionGUID: ZN+l1WZITq+Kq0s1tvVtag==
X-CSE-MsgGUID: bZWk8cKWQXeGVPDnwh1j1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206423769"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:05:55 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 23:05:54 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 23:05:54 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.42)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 23:05:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMw2p2wCIQxhcr8rwop/7E8tpTRWV7wHTMrckWrH4DJQEo4S1hMOxjonyGqLf4W67DAXndL9TJhidQTbC201iyfRmce5n96/j5B7OFR0r2SaGzsxu1VM/A66CLGazPWiombhWQE0rDvaf/SYIxDOFmsE7IzMFN2XUw2IFFI3sL60xCwLTknJSXu1sGiD+bG5cksvFKuJRi4BBG7ezhOXgQ7SWICIA26Wy1sk5C0y5kR3lTfahMzWnKss7yy+W1vhDI4P/oKTC3jTlfUikcVSrPCcNyjI71DAUq6/XPCL1fF0ZgbYyUcKqfXQZROLZlvfFAX1KCn9Ycg4VPOyEooiaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YchuqoQm5GjTacHmGOewCvdIom7BUMVEl2148DzbWsI=;
 b=bGh80cIYgp9UbOS0LB+WlmISsm03zdESlkPfMqkqdY/07kp4TNMi6loUIYtvzr+S5lsXNIGO/3uI3JYVP2TIX5L+YgtF/nApFBtSdlO67VLTHMC77UnrmCv5Xx8vMHkYkR73zQF2HQcw/zKsQHMt3k128GBIUWa7A7Ssxa3cPLA8Z9aYL47JzIVTIk5Wg4NMya4nXihkKa8K2dNoNeJOh2jZ7vZ6G7LS8odm1Q7nhrRxcw/CNJWS0cGeJLD96D2mPfv7Cm/f2oP54fh6cSlyeODm6E10ly2qChgCPj4O3OzI/Dix1CZwMk3P6yn11q/VHV0uSKnj74eH18phXawSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB4924.namprd11.prod.outlook.com (2603:10b6:806:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 21 Jan
 2026 07:05:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 07:05:51 +0000
Date: Wed, 21 Jan 2026 15:05:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [fs]  177fdbae39:
 fxmark.ssd_ext4_no_jnl_MRPL_4_bufferedio.works/sec 6.8% improvement
Message-ID: <202601211419.2b6838bf-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: c121ceda-144c-4d57-92fd-08de58bb8317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?vHU3MqcnyjMvwxuvZwZ8ZM7XQ2KHZly1Tpoe3SRQQjIqRV5Hl2G0FqoXvP?=
 =?iso-8859-1?Q?4zvIQfvgLE1Nxt/L0iqFwe5WX9occ0qmORCh7oCCQyrS5BIlKTHqPZ8G2a?=
 =?iso-8859-1?Q?lAZ1vbUyypFRrxpU+A/gqDj0mlZ1lvqAllse67IRRm+Ejjc2QCDXT1hbPK?=
 =?iso-8859-1?Q?FD9a/4p+hOZj+K/eKGTTt5fv9mhD6Pi3ls9S3PwXt2bdvRjLkbs6gCi4HN?=
 =?iso-8859-1?Q?k1MJlDOWFISqPwdjj60/r1z7qTck5MP51EUnO7oQ77p3dLIWLXrhy4uQzw?=
 =?iso-8859-1?Q?GI5AjN5mW8dnjf0C/ruqsFmcUWYE0VfjVFMMX2qbzwBG/Jiwb8IyDV8jbn?=
 =?iso-8859-1?Q?VwvzbE1ExfcDAdkzeZ67hVOm3lF8uaQq1g3+VcNgXD0FTZtdIfDdsoMCoJ?=
 =?iso-8859-1?Q?pFW6vDxgGXXE3WlE04vkzxKv34y6cHVyvUqALr6rw1l32p37/5+9rSQn1G?=
 =?iso-8859-1?Q?5QFO3sJWpLFsmNUttjVLQns2PnPsn07cdrmbHFyWapvtzxAyqlcZ9cJvRX?=
 =?iso-8859-1?Q?DrnSgC25Pe+H/xWA/SZX/WP4hp0aSxx0ZGz6vwmneD70+53jpz3a6VBVz/?=
 =?iso-8859-1?Q?ngwWuuK5Z+svhyqI1+XxAuVh2fgoeSaATG9U44ZTacQJd6nlFTreacugvN?=
 =?iso-8859-1?Q?cTTnX+ro7qXOHu3XMKA2bgabLvwHCIQCqPEak04iVTS+/zYjVV0AIVsuT2?=
 =?iso-8859-1?Q?bEjd5Y/mfiPfL4tY7G4KiYVI5awne0SZ1IPDBwNOw254rvk8/4tmEAbLuA?=
 =?iso-8859-1?Q?KB2WyvD9jeyCHFJCqnhC4OpNbKkMv9VIV33YfyZMXfEprPQSGc2t39ck5K?=
 =?iso-8859-1?Q?v1rNSU1eujCNqN51d5Os7v+PvXtx10kwqjr2PKoKlJig2QuC47+ZYLR3kJ?=
 =?iso-8859-1?Q?HXojXIyxI352Swz45ZYOcT4ysI8vv6++jQKDN9jaQ8meTZVRVXKv2sP5ri?=
 =?iso-8859-1?Q?jmURBPMA7weqML9sqlji0Vir6AXbXfM4HLPdi3PFBRUFcCzrBTh23DP8h4?=
 =?iso-8859-1?Q?ry85hzPqT0bpDEGYmNj4kCdaziuRzlsi1hwooAl0e1hnS3ZGuho5HlgXvP?=
 =?iso-8859-1?Q?ubuxM50mQeAF2ukNVg1EjUZkRwL8xgWfPiSTiiXwEDG0/b/loCKeF18bgY?=
 =?iso-8859-1?Q?QJro+b1BUpt1aue7sJ9fJm4Bm1tl26Qjn9CHZdjc8b/WYpU4ClsLMSCLpJ?=
 =?iso-8859-1?Q?r3SlDYso4thgkmPOdJ8WipHbx32Ree06ZoB0vQSsBhVRrGYimOrN3HOCOo?=
 =?iso-8859-1?Q?c0FNJQO8IB184wFaz5T5Nn/T0HvPV4rKe+lEkpM/Y4jSSMd3IWqYdQiCyj?=
 =?iso-8859-1?Q?NvGQP2rdVPjbxo3w/0wfpOKlhz6Lzj51e6Z7izZu6z279StyVQdccl+xgE?=
 =?iso-8859-1?Q?SErJga3P5NOmM+qKyAJ741cah2+ORnAEb2jm5PuDssIv92Mt4qUwbbqre7?=
 =?iso-8859-1?Q?j/PjZwept7GteqqNiYZbTm9j7G7UsAbpq/RJd7QQENItfEQL2PbMs/W8kK?=
 =?iso-8859-1?Q?+5fb/PLDX2L92wsngeIK9s3U+NiyqH22bqAzKDVTqpJnxMgEjxhEoGBNLq?=
 =?iso-8859-1?Q?Q8Aq2bsXQwgRinXXqXIYAATMEcA/wN/xRGo+yAgn6zAIUF+oBcRzC82FzT?=
 =?iso-8859-1?Q?eM4JCacET5IzxgLcRD80N9ylUVFqu9bI6K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fTh/d9baiNcLU7V8KgaqETp18KFr2rm/qI9Z+5H4B4DJ4xdvHJSGuM0NAx?=
 =?iso-8859-1?Q?7eC1hwgaoQ2vLc3gihVRVBkouljwIcXAcTrIiv46cyYMjDh7y4cVdyub/1?=
 =?iso-8859-1?Q?S59QAmpD96SMfNRsPb79xU1CMBiEttLO65JzoNK9YwK/oUlm9uZANs9S3l?=
 =?iso-8859-1?Q?ZBkuvqsmrpa1n2D1TDL2X77LzwW8DGuliHvIBq1WSfkkfBJDSLuOTwLJKF?=
 =?iso-8859-1?Q?rSjHtCejpbsbLDwG7nX57OEIPRDUUJGSKJnIFTthCS9a1uWuCRonhExH3T?=
 =?iso-8859-1?Q?nXzMBYK55DjYIq4JPL5HJQai64gCDeGuuz5Nb8iWqTYR1ZLQ19S2UJAw1O?=
 =?iso-8859-1?Q?A8FXrZIPwagOyqjaFoqKcEaUKkHnkQXWOr8TxDlKx6KUAehstJcafM4AtH?=
 =?iso-8859-1?Q?jk3/0zorz6MLr2PtZeNG+3k2pKTkiR819fzmc4vmaUS7s0ULCpaJUiAuPX?=
 =?iso-8859-1?Q?L71Y1HYaMsDdnWooe6QPG2b/aD7ea5l5n1yNlLOHoBW7iWFw3hwP8wje0h?=
 =?iso-8859-1?Q?wYmEB8X29++BRcyi+ZyRE0Frs0fDriZUvZ+HwC/F2PNIcYgZM5zS3ywO4z?=
 =?iso-8859-1?Q?bRB9RYOn/gmOIeT9FG60GsrHArgFpKxMrnMSMrq44Gjja/YZOAw+MbTYyX?=
 =?iso-8859-1?Q?rJP1tNE3pjDA2SJ1PBjxQP0F9YuSPCwJt4iLnl3EE9G9g7c56GLzvv2jhA?=
 =?iso-8859-1?Q?XtVIk8v7hogIGY/33kuWuOzcS3bekfUBdtESl9tjTbWaND1R/AnIxE1ba5?=
 =?iso-8859-1?Q?MTfjB9pPVPeTjw4JG8qFLWuwuyQzfOEBviVLEbv/yeQzP/CJph93cxJgAQ?=
 =?iso-8859-1?Q?A1wzWHYclf8S6/JaPYsDfF2Sbs8J1ZVM15fvhC22bME/4G0IU+MI/hEVaT?=
 =?iso-8859-1?Q?s6q60KlTOOVCTmlMuwkLS9pDETIJl/T4hwQe5KcRTiq9Gv1OG8W+2Jee13?=
 =?iso-8859-1?Q?05cxWyorEIqxS6YbvjRaKTCOBzF1VWTJYETH0nNsy7Z1ltvT1bdpxUKpbg?=
 =?iso-8859-1?Q?YFUo3nKOHW9wz0AU4mX4v3DcUmhbOkPrz3dZ74Es8OKSwFaSUB0hq9f437?=
 =?iso-8859-1?Q?MN9zoyfQ4brOkukNEb6HYGdxop0LAKNGLHdYP04EdWcGwmGq2t1ruUref3?=
 =?iso-8859-1?Q?L3IsXRblcaqQPXNqvVAVeaYd8P1wJrz32a2uqGeEsQlwGNqA6gLx7ZMpr+?=
 =?iso-8859-1?Q?NJzTWIzXQKlmzIk5mI/l6YD4Pu8yOYIK2Q2DjruIBSlpSrvIY8Q3uXx/E1?=
 =?iso-8859-1?Q?QT1NWlx0Rgf2GxkmSp/4s12Zw+dIZYXn6pSA4q2m412pjZzQd76dCN/OIL?=
 =?iso-8859-1?Q?KZl8SeBZN1XmEti0QRDI1UcZCFCZ8BFkvPHfu0HFTMeeHvpwjrlfoJcUaY?=
 =?iso-8859-1?Q?O3nWF2hXRghzGROTxvQIeWypyjrhen/vm5/gJsM/BrGeh07zeGxIZKCEST?=
 =?iso-8859-1?Q?BZv/+d57cmFz6JVPKh9Qy9uzZuiqztqsS9SD8imJtcyNv7UWR/JmioHg4f?=
 =?iso-8859-1?Q?jCKjehQxqjISIywrSF/DT++aYcgS8x/URnA8wyqWiizC8BI3oqtcbJVDup?=
 =?iso-8859-1?Q?XkUa12J+EJilOwa+rc+fWg9Zp4mG6cgB4m6zXboNQkVuwlHCQ2Q7K4NWWV?=
 =?iso-8859-1?Q?vvkYNf5NNo7RIhI01Mx1DasUQBn7TPTjaoqCqiVavikvLkhZczOCwICmJQ?=
 =?iso-8859-1?Q?dQdlC7q6Itdp/K2n/EApQhWOkiElTr9bFf1TbRoA6uvAVVg9Y9W0ALVFfN?=
 =?iso-8859-1?Q?9oVQ+zQZlM7vTukJKluyQ82WAwzj/gS/gtUGJHBIZiVY+abFQW2JNBJFBK?=
 =?iso-8859-1?Q?ACYPQT/vqg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c121ceda-144c-4d57-92fd-08de58bb8317
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 07:05:51.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pe4V3Uhc8qppBExfiTGKgaHsvLvVXGBqOhNZq7IgIb3n46lO2MQiUcRHYDz4J2ZiF4vDft6aoM2KXMrlrxkjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4924
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-74812-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,01.org:url,intel.com:mid,intel.com:dkim];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3E34D52939
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Hello,

kernel test robot noticed a 6.8% improvement of fxmark.ssd_ext4_no_jnl_MRPL_4_bufferedio.works/sec on:

commit: 177fdbae39ecccb441d45e5e5ab146ea35b03d49 ("fs: inline step_into() and walk_component()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: fxmark
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	disk: 1SSD
	media: ssd
	test: MRPL
	fstype: ext4_no_jnl
	directio: bufferedio
	thread_nr: 4
	cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260121/202601211419.2b6838bf-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/thread_nr:
  gcc-14/performance/bufferedio/1SSD/ext4_no_jnl/x86_64-rhel-9.4/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/MRPL/fxmark/4

commit: 
  9d2a6211a7 ("fs: tidy up step_into() & friends before inlining")
  177fdbae39 ("fs: inline step_into() and walk_component()")

9d2a6211a7b97256 177fdbae39ecccb441d45e5e5ab 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   7403946            +6.8%    7907512        fxmark.ssd_ext4_no_jnl_MRPL_4_bufferedio.works/sec
      8028 ±  3%     -13.1%       6980 ±  5%  numa-meminfo.node0.KernelStack
      5780 ±  5%     +18.5%       6851 ±  5%  numa-meminfo.node1.KernelStack
      8029 ±  3%     -13.0%       6982 ±  6%  numa-vmstat.node0.nr_kernel_stack
      5781 ±  5%     +18.5%       6852 ±  5%  numa-vmstat.node1.nr_kernel_stack
      3107 ± 13%     -14.2%       2665        perf-sched.total_wait_and_delay.max.ms
      3107 ± 13%     -14.2%       2665        perf-sched.total_wait_time.max.ms
   1610350            +2.0%    1642966        perf-stat.i.cache-references
   1587301            +2.0%    1619507        perf-stat.ps.cache-references
      6.94 ± 83%      -6.1        0.88 ±223%  perf-profile.calltrace.cycles-pp.iput.__dentry_kill.dput.__fput.task_work_run
      8.67 ± 84%      -4.8        3.89 ±143%  perf-profile.calltrace.cycles-pp.mutex_unlock.sw_perf_event_destroy.__free_event.perf_event_release_kernel.perf_release
      7.84 ± 83%      -3.3        4.52 ±163%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      5.17 ±117%      -2.3        2.86 ±144%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      5.17 ±117%      -2.3        2.86 ±144%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap
      5.17 ±117%      -2.3        2.86 ±144%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      6.94 ± 83%      -6.1        0.88 ±223%  perf-profile.children.cycles-pp.iput
     10.34 ± 99%      -5.3        5.00 ±152%  perf-profile.children.cycles-pp.mutex_unlock
      7.84 ± 83%      -3.3        4.52 ±163%  perf-profile.children.cycles-pp.tlb_finish_mmu
      5.17 ±117%      -2.3        2.86 ±144%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      5.17 ±117%      -2.3        2.86 ±144%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      6.94 ± 83%      -6.1        0.88 ±223%  perf-profile.self.cycles-pp.iput
     10.34 ± 99%      -5.3        5.00 ±152%  perf-profile.self.cycles-pp.mutex_unlock
      3.78 ±100%      -1.4        2.38 ±223%  perf-profile.self.cycles-pp.zap_present_ptes



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


