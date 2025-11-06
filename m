Return-Path: <linux-fsdevel+bounces-67279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BC2C3A5E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 11:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7572E3B48A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 10:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E79A2E7F02;
	Thu,  6 Nov 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GhA6SjAt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Du38w7e+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1E2E92A2;
	Thu,  6 Nov 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426008; cv=fail; b=bWUYwhFyiuTa0fL4s7x5sXmepsoHKLQTrLW0AMOfi/FhblZwnj90+QGOpq4qJWf662LlJU0J+BGUvGuNro8ZGf5zUW8TCow/MqkbFSEaJUvo6cSnThZMztfmHkL2SXCPlS5yInu0Mn3cRJL96qfbILftBHnkkF9LoUAZitSgqDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426008; c=relaxed/simple;
	bh=OkDeYw8SRt6LCUCi2TwLpLgurc41O05Rxi9B+mdOEFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gg8BHYmwxE39oCRSV3WWjdFFWIL5mFc/o2D7On9Ix/b7dSIz+yyXtX2ecfI3gL3OFlFmNNwwubB7qt2FZFvLm0Bym2Vg/lRIZwkB+bHni/1TZMTWvJ0FilbUHUscN3PMDYa6e3OHzK+Ns/AE2i6RIbhm26x3X9O0YImlfmhmJ5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GhA6SjAt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Du38w7e+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A61EjNo000895;
	Thu, 6 Nov 2025 10:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+fobxX0vDHNAxtYR3Afa3566lQgYw+5tDHxagMmrFN8=; b=
	GhA6SjAtU73VGs4LQpihsXyZJlQXirBenSZzMFZ9sgScH+GpQ+Vl67HhOp5lsdYc
	i0X+KK5IBJnP+FEvP4W/cxtlZq6sdPK+CHRnUDFRETwjUf82miBICKRxGDEjriEL
	Jy4ESXq7Z4PFKkdnfQ7YZs8r8UxDmxUX/JBwv4P+HB8MbvO7lXQCT7BBt/pmBCM5
	zq5+lvZx599B7NsVFG9240GRH//7B8rz1sxvkhfNMAE/PnHFuA3cLcfNtiw2IBZG
	I3MsXciIWaKee/rn1i5/3EnYuOk0uPe43J6rMDhJC+h3p7UQlJaumoe3SH2YjkRK
	Ik7LmAwm2NpFOlshT3S+BA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a89q41xf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 10:46:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A69w5P1039485;
	Thu, 6 Nov 2025 10:46:26 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc01kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 10:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFtrBf+5yqGUHd4+LHyKcd2DxAFy0n9lVjkuw0GSrVdo9g6VVazS7h8YPFEB7MuaAts9VHDOjLqE13u9jgv9V79Cgf+qH7yfPWMqRBDXtLqhMtfY6pTYTVOhyl8mnCXOVQjbVlbgHNOzPiZD41EIPIPc3/3jq7YNoeS2pdkhnbAhFPoClQmTZxk3usHVbs57YoBqX/RI4fzf0P30lXtyTjASDRGOekxo4D7QIlsCnQQQFYRqyeNSNdc7GGZwGKHd3biwx1orMEeW+3qSJyNLd+SdJt2rYkl3vzLCz8tvBolsIaUz2OUrYBIraUGD7LyQSAKRmAgN4LJXhiTP3nASYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fobxX0vDHNAxtYR3Afa3566lQgYw+5tDHxagMmrFN8=;
 b=kUqS8bHOEZzSGC8flVO6b9zm6DtIc1vs1bGylsd12CZwgLVczR1b4uYaJAuMjozAknEkuppXBsh83GdILM+Wv3n4RTA9gdxO0X4g3T9PtPkD9khOBBMxdmQv+waDOxdJyUyatBQoDtSybbqFlG+1rSf6Tg5aDMXu7JhzCEa41BN+iOs5tjLaGXwCQWsY+8TAD1oEdTrDnkalkGVaySOYwKCKpqwT4ALEybuAMDpGSiaDxXCJJikPQr7/OXfTzBhov78fAVwDGbD2xSu86pinlbnE4aKXow7VRlYgCOOV86mO9UNwbwZHUNNXZy2CH3pp0DhToZn1OWt3hSfqNegJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fobxX0vDHNAxtYR3Afa3566lQgYw+5tDHxagMmrFN8=;
 b=Du38w7e+skByfudEnn+Qku5/D5ZXqVjpkVtxv6vCl+5w1Bks2MTSX+DuW9os92urGcWu3WmIxLeE+D1saUw7VE946SRJNaEybrFVaJs1NrBVZ7CMotRKuy2aoHniAlaapI/wlZ7kV/vVCLlMfTG8KwpXIeag/d55m/L5p6dSZtc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8250.namprd10.prod.outlook.com (2603:10b6:208:573::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 10:46:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 10:46:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v2 1/5] mm: introduce VM_MAYBE_GUARD and make visible in /proc/$pid/smaps
Date: Thu,  6 Nov 2025 10:46:12 +0000
Message-ID: <fe38b1a43364f72d1ce7a6217e53a33c9c0bb0c5.1762422915.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0474.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fc300a-0250-46a1-6fb8-08de1d21ba70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+s46mkADUrh3laKUeYDUPPaBZagAa9smVYKlEhpuzLYJrJ32t12o3BQjNJai?=
 =?us-ascii?Q?dsXA9rTczOyflL24qCqOAcBH0uaus3PszKhwDfnJpQGAB/5AzKVQpShirJUD?=
 =?us-ascii?Q?F4NyS9meCBmbcwGbBMYpmF5VltVdMyGOH5ejHFjGIHZeyN7sdOyLpVoGNlXm?=
 =?us-ascii?Q?+iEWgknCmW+HOsykAE89NFoq1Cn/BR3Q7dBv3IcjQeXy7xcxYuLd7YDFCfap?=
 =?us-ascii?Q?cX4Z3RmKOUIj1Ae3I7B9OSX0qyjZGPvVOyWVCWCzwDOQszFCrUaNvKvGyCkg?=
 =?us-ascii?Q?cQtCuzxnBz3Z8e2gPXKRsIgcjqEcvzrzptIZZJ9hXZl+GumQvIJxWdnbNH3C?=
 =?us-ascii?Q?yutSVJxFrXZV/cCHtAu38t+JOkiSUQxEcXUgWanhf1lLVYCqbMSvo4zVTO+8?=
 =?us-ascii?Q?mtaq2//ykVLobL5GQxK+CucQkzXXKWuJ9sMP0zgUgjPDdBr6jWdGbw5qFRnk?=
 =?us-ascii?Q?NoR/T5XbY6ego3xgkNl8lkANC0t+m+0GiktCIPZ0I0qcKm5paAC55+3lQDvf?=
 =?us-ascii?Q?YDKXaADn2/DQ2u4W+CvTOW4CkoAdIHtvLZmPUyQl1XjFlGDRX9nnpCgluZ+E?=
 =?us-ascii?Q?4xr5WSBPilgmE86Sq8ePIfcyAxeB6u7jtf39IHkxQ8J8Wrl3wuiEhvOjPcEZ?=
 =?us-ascii?Q?egTzt0BYjFmy69IQ8Q+41RuJ9tgJWQeL5O/Iv4qZwWqgmbmXlp3yYkgx9bjN?=
 =?us-ascii?Q?MwYJMQsKoi/fqIq6Ci4Jis9T6hK6nIovpzCdkxKZjwrXYy6Lya2QDh6sKYMb?=
 =?us-ascii?Q?SHoVNCN+Ch8BLRrCwU6WcWigvCRFPACz9bKYPVAP2YJ2nJaJ6TkAHr7PKlp/?=
 =?us-ascii?Q?rIxbxezyAj9u26cmLTWRU5nYmpHhLpE85EpZGRQABqAi409XnUheRLmJUAS7?=
 =?us-ascii?Q?OXKDs7i2lhmf+hP9gncUIG8NISTVIeEmKF//PY+q17Nd/CvTyDVV92HNNGHo?=
 =?us-ascii?Q?9CVIXBoIvsHEDvhX5tU16vN3OGbl1FcvleufsBoaAoL7ekD+Di6j1OMwCTO0?=
 =?us-ascii?Q?e9l95FvNWBSB28TVVzCILMFBPUfYSEiU70R4kXJwAPKwPSry6Igxkq/TCYul?=
 =?us-ascii?Q?R7HbxU2gLKGgcp1ebO6fZ1Hy5O8FyVnWpuIrkWc6c/OVamdR2yfOzocnWQ6G?=
 =?us-ascii?Q?7LKKP+kBHaHIuJbPoB5pEgYFQoxeWmPM/pdEsI/li1Vts0e5fHreud9APlO/?=
 =?us-ascii?Q?jVapHxFw4q66QOs98Ho2gswX8c+KDqPeD7qsw2Ui8NQ7g5a5JisnUjMLcOOv?=
 =?us-ascii?Q?OBqNV5Fxg9b5WNNGqb5bgg9pWEMFUapc+lmrHqs7YRIOKK0hl9Ym3V4rO5P8?=
 =?us-ascii?Q?MdaS2l0fE6H6OgPecG+sGOIxtDF8ext3XW46jrpWPOLrLbbxI/+fvVsgn4bK?=
 =?us-ascii?Q?U7lsAQ5qfdKPTG9d0O7vraa7wPCY7A13NVJlxG7Dtxek1JOrd0UPQiLxrgZL?=
 =?us-ascii?Q?wFHjuXTHKNUvZUpD1ptr80EOKSQkt2ZB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AAKbEHWDtv+ZxBpTXlBx5LoW/XDpsWaHVyVAAn36FqYFnJXdfbNKpBXsAVoi?=
 =?us-ascii?Q?xYOUrLdepfb78bsihHVixJkxGvKOmwXiNS/IQAMKwIwDekTscCkIhAhYGngI?=
 =?us-ascii?Q?7p22KtFQHj1ROCuhutUGjbjaOoQByaMkyR4yjfyPsmRopS8SZfZ1lIfp4Zf3?=
 =?us-ascii?Q?wOd/R5Sx1XXJrrlOKCQpLs+GY/HNmMBJnBZHW9b/4z04BBdwrKsXySPmje0x?=
 =?us-ascii?Q?hc9fOR6vPwb4+9P0rrL9fvG7Ly+wgXn+iZWnl5J8vbJGNQ9eP4qY7JroXAjF?=
 =?us-ascii?Q?M9yRweqZi4YYpvJgBiM5DO+CXb1iVVIJhKTgvVH2wXMW1FlXn/rCz5rgrY3h?=
 =?us-ascii?Q?yM327da9+l7qTNv5dM1BTxG/YjzlMeOHwPuVqqBJJX8fghEiX+bKGkvGHyIT?=
 =?us-ascii?Q?42dJ83b33kfl53+UREJQ+Qy5baMwKtj71dto/dpKQ1Fp62sMBMeTyhk8EQDZ?=
 =?us-ascii?Q?oVnKkKNauR8/wmZuuhOAh3rVwOPvaXHN+/yu90xDdfC9MJnttoTIZAwBbaya?=
 =?us-ascii?Q?F7TAIf6jwplrytm9Nu1Gd38X0r4KQGC3wKuKnabaPSOgxBkozPGQtDNCijcR?=
 =?us-ascii?Q?153aN0SORRO2awOohsNoAs0UiiVMlpFSCKlLoO7XSNi3RggWpi6TcXR11r96?=
 =?us-ascii?Q?9P7LQHa6dq7gQ19eHW6Hxc827bL0+xEkVL/bwmN/txjO7lU6qIDe1/XbiuZy?=
 =?us-ascii?Q?cQn7C1KVqGT79jPF1+8RuQPeMZU9d2G/2dsEAsFxHFLsvcW7RIVs/bhwOILr?=
 =?us-ascii?Q?Ji5GlkpGlbXZcMh6v2KwBbg+iOdH6v9CJPOMUsCSwqbbFCzCwqpm3zLUkByL?=
 =?us-ascii?Q?X9FYw5ZaW5PCr3K1Fei6mIRuvaVRdqttEpGoJrxRYQsrK0CceSQfPXlgxDmJ?=
 =?us-ascii?Q?S0vFI7cwXoMfRvZB+Wv57WtN3r6xcEs69GjSEhJ+86i/jDdMIvmxK9YgqYOP?=
 =?us-ascii?Q?Bjerpstnyf6xdFB+ABmkddr3Fm9/TD3iAbz1+d+4MIBomPDLMVYtMS1CTp9y?=
 =?us-ascii?Q?YnKCEcqK7Ksns2ku3sai1QzoO/NWBpASevKsCtqJ/FRidTPvqBVv5h4Jm+id?=
 =?us-ascii?Q?dYDH0q5/PVFPnvI6M5FlEMuwRUyB2BhBzbFfGyvQ79J0N7p/QrybzlkIEcDa?=
 =?us-ascii?Q?jmKRmPKrcMpWsn3qelct1M6GsE7BezCDrQoq30EbyZKcNz0GogXfIEGZwHRy?=
 =?us-ascii?Q?reMzAeFSLwz+M1OIDyFOB3FuoU/FVYpDkhst0VWiD/tgQaXbvAwIHvb7ggso?=
 =?us-ascii?Q?RXF77x7UET0P31YTEk1YhN4TM4hdXdpAnx+zovYBYXTCRYmmXH/NeRzSsYhs?=
 =?us-ascii?Q?0hgdal71UFewT8TQNGCkj0OkCV1whYObTgYmqAgkQI1EoyZFx+lAjR0TNcwQ?=
 =?us-ascii?Q?ODgvu8QX3DquhWKNVpaLNlzI0U4wlb/3u48pJ9HKId9Y8qVh1/PSvIO5h+Xk?=
 =?us-ascii?Q?o7fj/1kxbitqusa0NM0NS0eVe/hXoy1gw0/7y0jUU9IaKgDKglRDWWlwqm0r?=
 =?us-ascii?Q?xZlFyCf8N7mK2M6hh1iwc1udZYFm5c59bIrSpF5OiQXUcxH+K7YuuhcM43jQ?=
 =?us-ascii?Q?zhcMwWbIYlcZx3IWX7BfVN+AarhkD1H0SWvFnZBtBQNgeNAWbIc4y+jZf4ue?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1fafqGfvmhZfNEc+QGZJHqWJb0GdccTUo8YcLkNQ0ymsciocSZJVq8cHhzioSt5vm13ohdoz1O7j1n2uINGQUPc3F6P+iy4vu9Mbi/yDPZ2UBSyIOKdCReIGfzxoloERQ5fTLcGB/xUn0IXgHauSk+ShAruQDjHipmr8yxIA8JGX5YsniBTcSFUzARbiIMR5u4xDDA6d7uuHLBbB//+dPXpTPlpBVvYy+a7OlvVv4QFFZhnwjhzEcZrh2XfkscsXMofbHXi4IK7Gs1tKXKgtlNDbQoIftVeKqWolW8NLD+H2BECbNMO8VX7JPs1ILqIF2aC/YpIEwv8esDP1IcMiTn0Tg2RLiOPQXjV8BLc/2uFy6G9Jf1blH7ZMuqFDAumcsRzL6U3QWhHRO36ywc6mcxujniM04clXnbHQLurpBiJfCYzScDTIdZFEESwPmHsHFOL0EBOQwFKUG/cBDEL0rrnXHoXML02lIBC+J82Nr56ckUlIHBbt7qwmnEj+ofevREqPMvsuhLzj0F+ityFNdfeleFanMWsn3mIi5B9IP38gntXVjtmUQd/0ORiRCMKXlRs5S6BEJ/OzZLvH4/ztpUoeLg5UCNd0gh/RzRLQ5YQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fc300a-0250-46a1-6fb8-08de1d21ba70
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:46:23.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h94p4qiwDHzWqy70J6Fj1cMuertzqoJcAL9AmL5ixvs51MxYNJdbjScyBynQWhOMVnMzZwaG3NhUVZp0oaHKqZq1kBJ+JFpYv/GnlreECho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyMyBTYWx0ZWRfX2iTxBMyEn8vi
 9ypXUq+u8pRfrPw2S/mGwbMyOhvvrduQk1tZp+KGMm970Oup4uDyKiONxwP12M82MiwsQinF9zJ
 mVZ5VXJy6N+xmcrV57cIHkZGXLVlFVlR6Nae4wGhwCjGeuMB2QoQOTgYusYA4hVtkkrPMqt9gnm
 3Np+gZZfHsIKe+/QoJKk2GLlw/s0zA+J7nmPRJGitxppPFxXPwdOfh17nsUxgJdh3wiStQV6nsp
 VNtnQX+BN2a9HBDk7+iMX3MW2H8KIr+1lWTp+cCuMw2wJBp6MeGRCZ9SedQveZJZ19cBb35tpq/
 fFP6xa0wkgSzQ4rDMkSWoA8uBbp+f146apZ3x67KSia/TtR7fUfAr7+hVY/AOxH+3G9tD5mGh8a
 vBkQmW6K27SIj3Rk9/m8VTJTmIYbtA==
X-Proofpoint-ORIG-GUID: oZGLjQxNm9VRliYUk2phvt4tFMDmHxDY
X-Proofpoint-GUID: oZGLjQxNm9VRliYUk2phvt4tFMDmHxDY
X-Authority-Analysis: v=2.4 cv=PcPyRyhd c=1 sm=1 tr=0 ts=690c7c82 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=lkmYoepbxJn_IgOSQAYA:9 a=cPQSjfK2_nFv0Q5t_7PE:22

Currently, if a user needs to determine if guard regions are present in a
range, they have to scan all VMAs (or have knowledge of which ones might
have guard regions).

Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
pagemap") and the related commit a516403787e0 ("fs/proc: extend the
PAGEMAP_SCAN ioctl to report guard regions"), users can use either
/proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
operation at a virtual address level.

This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
that guard regions exist in ranges.

This patch remedies the situation by establishing a new VMA flag,
VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
uncertain because we cannot reasonably determine whether a
MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
additionally VMAs may change across merge/split).

We utilise 0x800 for this flag which makes it available to 32-bit
architectures also, a flag that was previously used by VM_DENYWRITE, which
was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
bee reused yet.

We also update the smaps logic and documentation to identify these VMAs.

Another major use of this functionality is that we can use it to identify
that we ought to copy page tables on fork.

We do not actually implement usage of this flag in mm/madvise.c yet as we
need to allow some VMA flags to be applied atomically under mmap/VMA read
lock in order to avoid the need to acquire a write lock for this purpose.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 Documentation/filesystems/proc.rst | 1 +
 fs/proc/task_mmu.c                 | 1 +
 include/linux/mm.h                 | 3 +++
 include/trace/events/mmflags.h     | 1 +
 mm/memory.c                        | 4 ++++
 tools/testing/vma/vma_internal.h   | 3 +++
 6 files changed, 13 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 0b86a8022fa1..b8a423ca590a 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -591,6 +591,7 @@ encoded manner. The codes are the following:
     sl    sealed
     lf    lock on fault pages
     dp    always lazily freeable mapping
+    gu    maybe contains guard regions (if not set, definitely doesn't)
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a9894aefbca..a420dcf9ffbb 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1147,6 +1147,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MAYSHARE)]	= "ms",
 		[ilog2(VM_GROWSDOWN)]	= "gd",
 		[ilog2(VM_PFNMAP)]	= "pf",
+		[ilog2(VM_MAYBE_GUARD)]	= "gu",
 		[ilog2(VM_LOCKED)]	= "lo",
 		[ilog2(VM_IO)]		= "io",
 		[ilog2(VM_SEQ_READ)]	= "sr",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6e5ca5287e21..2a5516bff75a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -271,6 +271,8 @@ extern struct rw_semaphore nommu_region_sem;
 extern unsigned int kobjsize(const void *objp);
 #endif
 
+#define VM_MAYBE_GUARD_BIT 11
+
 /*
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
@@ -296,6 +298,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_UFFD_MISSING	0
 #endif /* CONFIG_MMU */
 #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
+#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */
 #define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
 
 #define VM_LOCKED	0x00002000
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index aa441f593e9a..a6e5a44c9b42 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -213,6 +213,7 @@ IF_HAVE_PG_ARCH_3(arch_3)
 	{VM_UFFD_MISSING,		"uffd_missing"	},		\
 IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
 	{VM_PFNMAP,			"pfnmap"	},		\
+	{VM_MAYBE_GUARD,		"maybe_guard"	},		\
 	{VM_UFFD_WP,			"uffd_wp"	},		\
 	{VM_LOCKED,			"locked"	},		\
 	{VM_IO,				"io"		},		\
diff --git a/mm/memory.c b/mm/memory.c
index 046579a6ec2f..334732ab6733 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1480,6 +1480,10 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	if (src_vma->anon_vma)
 		return true;
 
+	/* Guard regions have momdified page tables that require copying. */
+	if (src_vma->vm_flags & VM_MAYBE_GUARD)
+		return true;
+
 	/*
 	 * Don't copy ptes where a page fault will fill them correctly.  Fork
 	 * becomes much lighter when there are big shared or private readonly
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index c68d382dac81..ddf58a5e1add 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -46,6 +46,8 @@ extern unsigned long dac_mmap_min_addr;
 
 #define MMF_HAS_MDWE	28
 
+#define VM_MAYBE_GUARD_BIT 11
+
 #define VM_NONE		0x00000000
 #define VM_READ		0x00000001
 #define VM_WRITE	0x00000002
@@ -56,6 +58,7 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_MAYEXEC	0x00000040
 #define VM_GROWSDOWN	0x00000100
 #define VM_PFNMAP	0x00000400
+#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */
 #define VM_LOCKED	0x00002000
 #define VM_IO           0x00004000
 #define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-- 
2.51.0


