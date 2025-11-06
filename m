Return-Path: <linux-fsdevel+bounces-67282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB59C3A5B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 11:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0A074FD370
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F130C628;
	Thu,  6 Nov 2025 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XMZrivtB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LPXjfFfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2313090F7;
	Thu,  6 Nov 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426016; cv=fail; b=r55XWlYatJfTI5X7DKrlOjJe7OeC5x37r9or0nC8S10NPt0y0bU+Ug5Itih0G6XmWrlL6zcGxBzTbluPsZvBy4xwdALIoc4ZJIn7RUTjGtJ9gkCvXX8d4BoZ/1WVsvOePSd4VwmqWdpPV1o1WxYVz9VrvwXPbj4djkjsj1MWYzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426016; c=relaxed/simple;
	bh=kOaPbsgk0DyMF5/18TgHzD91U463nM+n8C/nY6UYIUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L4wNqANNnhmmsUJkHlMwRhDm5oec2xp7kZ9tX1Cmc7bZXXeLdUWIX3tGo8e3fq7EuFi0jvXlMd4J8iux8i5AG9qMwjh3M2H18M/p/G6Hbdz+Kg88yBLjbFmQRTu5L2KhEqkFg8+0LzFXMJKu1Cql0RFKPGJ/SvwYnctb2LTNwi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XMZrivtB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LPXjfFfk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A61CNFh025060;
	Thu, 6 Nov 2025 10:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fKBjo9f9SW2ZLjUHOSNR47gsbntZ27MhtV2A18HPhGE=; b=
	XMZrivtBD7qgobAxiEZe1oG8CGe+r2vAeTJWFTxWitALP+vqK9XClPXN1fwVW5xv
	MeakGlvkqpS8NQC0OapxB+D0NlO82NuKiBOuhVfOwh26m4BaMhinhmpyhpg1usu3
	LgnYGIDTMLtHgQVQUl1g08OwNUTmcrmRDS897Oc8AQ9zTc4MTwJOtAgWtTWE4U4z
	zvwXOonctBXEuMnjnQNspo2/+rwvg+/mcitc1IHLTzu6QTuloWIiH8Da9iOb5DlN
	eNBZ0TZrZCGYx1EVmWXFrmy58Za0bDErT7z1EDR/3BS+MnFSkb60fhIdjvBh5tzf
	E/SI/3KsaF70hOESNdbr8w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a88aka5d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 10:46:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A69XvXx014888;
	Thu, 6 Nov 2025 10:46:34 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc0evw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 10:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bc/tlW7wKughwnGBdVXoHrmdXwUTeIeZ4mw5Iy2SZP5JATpH1wq8o476r04G3VG8wFTr0Dci87cUnaauabalIk4Z+obO7TpS2Abhqm6UeVPNhmcvnGIxCko2ZQkuuxrxXjo4+hF1L67hpv1ImlQTM1//PgTU3LPCuqdB0pJueJpxHnEF6iHt1Vqo5M4yxbNWuVD8qCPs+ZBOPsd0joFA6+Y0Si/zOxaFnT8XKzPFM1C58Xqszien/frRJknzV6Rgrmo2syrXAlKL8pNweQFWAQp79cJnBCIKtDKeapgivQ7+Og2YdR9IYNW7SwXuNUAc9oFBzztWMwGqJVmroo8NNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKBjo9f9SW2ZLjUHOSNR47gsbntZ27MhtV2A18HPhGE=;
 b=mQFjHCHADCCSe/iAkTFO0+z7ZslOKFzMzzk0XWVxXx7Cv997NiQ8CF828W9n7GIoj055++yWMhApOeJfjiSjOd3cvlEqBwq7VL7wsTshxNO3omUyjX33PqPSFK0leQZqvhFudjf5PAWlLDj+dtW249C+J8x4LioeNU5x0MUBLFrO8oAQ601TJAbcKASJMbYRxttrekkOfHUmyPtuBc8DXLGk2DzJISJzKlyrtRT4085sN/rqB1yoB0DbHFxrz4UYl3UH2YEyPzaNE21yAoBqKauobTJGsL9o11S0pQJQHvn7ukXb1z/cHefU4Sp1ffrMdmlxM9oNO1krkb0xNLEkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKBjo9f9SW2ZLjUHOSNR47gsbntZ27MhtV2A18HPhGE=;
 b=LPXjfFfkTDm0VPOeo5BGENkB+222Wm/n0c2HzydbTV79jrQPnN0pc/RkyRq05z+tpKIY44iC2ZZ7kH/SP9yGU7ZFTWG/I3mkDimpphgmuqoIRiHPm/AK5uFlVW1bXtdLhUtPsaRriPBS0PkhpmtJCWQ8sEe6ZZBJ2SkRYBXv6JY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8250.namprd10.prod.outlook.com (2603:10b6:208:573::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 10:46:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 10:46:31 +0000
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
Subject: [PATCH v2 4/5] tools/testing/vma: add VMA sticky userland tests
Date: Thu,  6 Nov 2025 10:46:15 +0000
Message-ID: <feebc807423587c871894801fdd94f449e3c0cf5.1762422915.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b00eefa-0021-4cee-93d1-08de1d21bf33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xmzcJjLo44/Yf3AsXdDlfG1HXKwHOCDZxBQQoez0XS5bASZ+2jyZftEqIwpZ?=
 =?us-ascii?Q?g1ZVB5zAkQwWAJpgo9psr4W970mz7pVjk4kcjo03uqsLUlnP5d4DQ/qPjexc?=
 =?us-ascii?Q?7PUvOl2lxSQigs1LkJCtdgVP9AxAnRB30OCyLI7LWlUfIuR0kf8m29saiDzk?=
 =?us-ascii?Q?mvQAQR6MtnYD/ooSX9T3clGWToESj/VH1wA66xNVRu3PiqP6bMKjFtb5m7IF?=
 =?us-ascii?Q?VJGfsDP9eUVEPRKHkb/biz3OGXmBZQyW769qt1YAVZ5WyBqCxvIieCwivqOM?=
 =?us-ascii?Q?mJK2+tJKn2CdcmaBEpm6DYeeE9a643f/RGrNE8DR3Vhu6KEpwEWB8ZrtWrbj?=
 =?us-ascii?Q?lQNGicxgIO1Hke5q+EnBa23u5HifVuQ1/TKJzXrh7WXAAeLf3VBWoBtC33v/?=
 =?us-ascii?Q?+fnO3SDjV05csjYxEO4pjjGs77lQzBjg69VTm9bBpC9TKHiKnc2hTmwERk1o?=
 =?us-ascii?Q?W7FucmyMO5ANGzhZpGM0+ZF/OOCwwqG6CuJo7GY+6vS7HpKddkMo9hL5ntId?=
 =?us-ascii?Q?yz/k2i401wRPBaHAmL7uu8NmrR1BkgbnsX/Y4p98bCFKcffNY4U5LbuVZ7ns?=
 =?us-ascii?Q?XveQOwxaey/HYaJxaWsasLMcul+9UvFiAmqEq0NFzG6hnObJNqkmO6bubac6?=
 =?us-ascii?Q?kZrCJrNoYJj9TYs/9da9h49NzCTga+186t13Vc1MlxkLxp2zcMof7wMgGJU5?=
 =?us-ascii?Q?LdCQH2E/e6B3pMZ86JIKrKTtqm043lBI2dREMqEQZafTXs0Sed4jolT1fGHF?=
 =?us-ascii?Q?TiKB8w5AmUJ0NRU/lZ8fGgPTDQhjdObdv4P5EcYhhG32fRR78Vt4DXSZ3Rdd?=
 =?us-ascii?Q?ALQpODZ6X/oBVB5IsnvLMRlFakjqCafY3AO5NABiXq0AlG4JfkV5homftltJ?=
 =?us-ascii?Q?V1poLupQL4bsDPUjlVVImf5ADH1JtYRXyTttTu6UIAs8apQaxK8yXYj8nmju?=
 =?us-ascii?Q?fYCMluZhGYNwoPp5WjbdbtrL0My5i6O6jNlE+zF8QOMvHmu6A0/0aY4UTjYs?=
 =?us-ascii?Q?JKu9pVVRmUTq+tkxr9HxMB90sePilsO3fr2Fl7zG8N512BJPkhwChIEHGBgu?=
 =?us-ascii?Q?/RCJc1Ca7pYyudxvsqNKRhEkQEBHVscvxjkaHHjADTxLdcBxbUJu3qHqC2lR?=
 =?us-ascii?Q?Zo/kD2kljtHFjx1xHNuk4mFp/82hW3FbqD6yv7HIT/+LQBuksy37dFkvED4V?=
 =?us-ascii?Q?7ZWs5oDsZv4vAQ6qtwrtJwqbTxObjAXhoA9pgSG+Mv6I023m9SRfUp3ODHU3?=
 =?us-ascii?Q?Zx6ppFPekdbbkvWS5y3l4BHHCmcFFXMw3HWPzhVXNwhh5xrFURcY4WEznlU8?=
 =?us-ascii?Q?zOm2qJcfzKpIS8i2I0Yx+hB8sX0cyOBeoj58LUNwIVQC0yTl5UfOQutiiAZi?=
 =?us-ascii?Q?bguyUkCckJGdlE58L53QNvilAmcnss0c4YPoNfvwiZPAzy36ozME8fbnrL2p?=
 =?us-ascii?Q?wyQ8ViIAVimsBQ8lC2aWXfuNejg+1Uab?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KbAFISjM0l7heMneYk/yo9uljylj2eSmviEwmmxt8k+7Uv61jxUYopUzREEy?=
 =?us-ascii?Q?LbH6M5BRSDAxv7uJJj91VXVrQd7U0PcdwH08aFpsCMypC2SNeiSIuYc8s0ry?=
 =?us-ascii?Q?WWMsW9A+QWEYJwB7H/v/yZed4WekZreTEn2pKMztWMtOcGzxSqJaJG6cnLzB?=
 =?us-ascii?Q?Qsi8Cw82cWuIQCZjQPxAuKi2v9UtR6OuV/q8l+7pHXbl+B1VYZGPteHGIfH/?=
 =?us-ascii?Q?mJHOFEilkqv73rkuREVsfGgRQl8wpk8ShVd8ztohcBII1mpQwfW9d/lYfwFN?=
 =?us-ascii?Q?jSwr1z6lZJG9sa0sBEPKmpAaKuADhnjPI7JH+wmqDqWOrOzOHkK4xerov1zr?=
 =?us-ascii?Q?ieGpZ/UiQMI+/hVCw92nIeTTm1El/uLDNdNQ4klKbJzKt3IAh6IykuycBtmf?=
 =?us-ascii?Q?djsIoalPoQSoxdJYjbVVDMfgIkf2wIbwnsUyHiLRyVGwvaMlZvFJWcnT0dFm?=
 =?us-ascii?Q?QZ55+HubIK44QXkfC0oE92VELOfhTh2HGKTnS6vilZKSY5m0+Qgj3lqFYM6w?=
 =?us-ascii?Q?K5LVRRAmsV0BOU2/a2YviPwWJJSWuaHOQBj56prsruDVjaZVPyfIBGp6RA92?=
 =?us-ascii?Q?YJTM2o0gzINM9wZ1jwyYON6XlGJTqTRlxw6gSjmHviMJB+ZK8354D0vBReSD?=
 =?us-ascii?Q?Rwhc7MJ+S7WQskeDAsK3xaUplvsNz+Dl+aQifD7SLV2Xo+1NuCMiI/sImGZG?=
 =?us-ascii?Q?gi3clpcg2XRRB9mNeaLDSt+1ehtDvPPeN8Z1h5ZeNLJNmZnG85vcTs4+31vB?=
 =?us-ascii?Q?NKfG/fexjmWZYgpaWuh+i2jE3PPAEgsBLkK3GrgfsFFBfa5tNMXgRZw7zi/s?=
 =?us-ascii?Q?Ih7c2dJ9TyQPyaej3BTV2JqSTby4IUpm1BHk+jXRRSxWK0ngPRFs7aFmuv6Q?=
 =?us-ascii?Q?nS6fFCgDkOf/+yz4cC2JgAmPPRoLljCWAwAe6UlIYy3c9QHHzq3AXBTPiaZn?=
 =?us-ascii?Q?ggCa4dcsa+zSLzRWOC3Ri0xrgAUklTaeVXuTGCtwLXMx9286J6gccYU6k57i?=
 =?us-ascii?Q?x8Hz5D5e01iEjBSFUvMvRJY5bzAwI50eXXviPB+91bQoGkXtkHjb3HOU2uzX?=
 =?us-ascii?Q?1+WMByKKz5qOWt+pXFcOFc1YRMMZcgqB8Nj5+kVtZBBd2MWcyZpRtZEqufzh?=
 =?us-ascii?Q?jKdO0fJIy/5jv+lnbFRzWv8cwt0I2nRgXXoHeicn7MHm3CxtkXujX4Zu6b75?=
 =?us-ascii?Q?mE06gdPtHmyMscucRW0j0lQkrKp/54EuuEk88/Rsdgh7+I+9XSnLoa6dg+d9?=
 =?us-ascii?Q?MQwLxnLskJjjzCc3/6xC6qQ52VBwrBnFik3Xsc0ysZR6gBQ2G43TDEVTY1Xb?=
 =?us-ascii?Q?5PX/oTlDN6iqLBpz+KwfJdNxj0OYYhdgqLQ/zpUSGBHW6gvZdB81ps6GBaD9?=
 =?us-ascii?Q?6gs2IjvsQatr6guK5XQVI4AiEN0yH+3gjdGYt4x6HdhmgGdpdu9tfunfNx+2?=
 =?us-ascii?Q?4+LvfrHmZmk8Unb4CU56npaEXDAn2wsdB5F1pYAzhNY5uhYSA++huskNZtW+?=
 =?us-ascii?Q?H2Mtr0G/MpGj/e7+MM1MHEsCiMBuAhQUU5ZYYLSHnfk3w3Y+Ih1V6ULNGIDB?=
 =?us-ascii?Q?lRGWF6nkbmilnvH1dpZl2Mf4TnB6I6h2kf31zh9+8XsYQWnfzmXOT9awETWX?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RnbBG8ghXx+O4lV/bJ02O/TtrgfxOODRciFXnLVIEFlPPH78Ber7iVQvFKBUTR03CRt1cj4bF6eEJZMuGPOpcu6V/shBmylpjnO35mcCTARyRmHH0wk35gHhMURUXui2XpiMIAaUEYHKLjVUshai/8M4q+OejIk/uXGbp0UnfFFpf5VkPOeHQx5udqVdWrtM6CsAYmEUov+gw54gluh9EyLhJ7ld0CJHnfto+5BiHwoLvD2l1er27tw5llQ6FlxZWtcfTikDwcP3mjtCAOxDDLGHG73VitqMUuMifSW6ALmVplvkPVN/ZDqAMC0YRpLL5OSQartE5OI7HYPof9frVV2oJF0vDIbPTS3OjyUET9WrOw7uCECiso6Q/d46S7Wh2kawy7GluNkV3vs58ykFAiVGrih+9fP884rO/LC8NTXsFSVrBE2MoWgHocHF17VUDGf7FjK+h2FIShqH7Hc/BDMFvyoGtaXoDaa8vsiGVPHqGtpRKekHre+R+Ql2SeUOrgpi40/bmgCHdyO1VJ4/rs+nDFEau4LhK2rcvN6w77zkI2ZhRI1ZnnH3Wu5nWk6zQC9hjm/A6HEVXq3srZJRXZahdaJZ0C1sHu0/M5TDzcg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b00eefa-0021-4cee-93d1-08de1d21bf33
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:46:31.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1h8sP0X69t7laMP1TSxaKuMaKuKj7Hdgw9+LmGkqGFDRmDeH8rsnUmYkgb4hNJez2W+sHp7dcMpHN2+KqkaZZvrn5/coOstPHYwADIQDQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060084
X-Authority-Analysis: v=2.4 cv=LsGfC3dc c=1 sm=1 tr=0 ts=690c7c8a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=p333gLL91CABKhuAUmYA:9
X-Proofpoint-ORIG-GUID: L-h2x9YvZs8wqNRObk8qAg_QNIP6xtbm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEwOSBTYWx0ZWRfX2hwHtMrjJDbj
 DW44m3XClSCZ/MwMu51Q3j34MSNIkiD35E08ndj5zSEh5JUqro6H3F0P2LrFknyKqXIB3mu8hdL
 2/R8CiPtsTQu2S9GGlKrlFtdxU1xReM9ZzIwbWIMgZ49wm2NcjY6TP9TPdQ7FJwvNUix1IJTQzy
 TzY0SzguFirDY3EOwGpSEplUuUG0hjuKtsuRH8mu7Vn7u7SXzYLRR3on1XgPs6iHUcZPMg/7GnY
 JJoWmgUMw1N61fXAYUjzpyWabL557NRF7CnzCSKOzfJVT9+WscnXkxHo2ekFDtpk7CCW3RzQJJa
 czYyOIK4z35W1j6r7T/J1xlwVcReCm/p+sem7BhBSgFkyoir8a1f+p6d78YS+fIJIG741kAx7z1
 PM2N95sDpomnZqIOYhhoImVLbfWY1g==
X-Proofpoint-GUID: L-h2x9YvZs8wqNRObk8qAg_QNIP6xtbm

Modify existing merge new/existing userland VMA tests to assert that sticky
VMA flags behave as expected.

We do so by generating every possible permutation of VMAs being manipulated
being sticky/not sticky and asserting that VMA flags with this property
retain are retained upon merge.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma.c | 89 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 10 deletions(-)

diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 656e1c75b711..ee9d3547c421 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -48,6 +48,8 @@ static struct anon_vma dummy_anon_vma;
 #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
 #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
 
+#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
+
 static struct task_struct __current;
 
 struct task_struct *get_current(void)
@@ -441,7 +443,7 @@ static bool test_simple_shrink(void)
 	return true;
 }
 
-static bool test_merge_new(void)
+static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky, bool c_is_sticky)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
@@ -469,23 +471,32 @@ static bool test_merge_new(void)
 	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
 	bool merged;
 
+	if (is_sticky)
+		vm_flags |= VM_STICKY;
+
 	/*
 	 * 0123456789abc
 	 * AA B       CC
 	 */
 	vma_a = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
 	ASSERT_NE(vma_a, NULL);
+	if (a_is_sticky)
+		vm_flags_set(vma_a, VM_STICKY);
 	/* We give each VMA a single avc so we can test anon_vma duplication. */
 	INIT_LIST_HEAD(&vma_a->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_a.same_vma, &vma_a->anon_vma_chain);
 
 	vma_b = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vm_flags);
 	ASSERT_NE(vma_b, NULL);
+	if (b_is_sticky)
+		vm_flags_set(vma_b, VM_STICKY);
 	INIT_LIST_HEAD(&vma_b->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_b.same_vma, &vma_b->anon_vma_chain);
 
 	vma_c = alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, vm_flags);
 	ASSERT_NE(vma_c, NULL);
+	if (c_is_sticky)
+		vm_flags_set(vma_c, VM_STICKY);
 	INIT_LIST_HEAD(&vma_c->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_c.same_vma, &vma_c->anon_vma_chain);
 
@@ -520,6 +531,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky || a_is_sticky || b_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to PREVIOUS VMA.
@@ -537,6 +550,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky || a_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to NEXT VMA.
@@ -556,6 +571,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky) /* D uses is_sticky. */
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge BOTH sides.
@@ -574,6 +591,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (is_sticky || a_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to NEXT VMA.
@@ -592,6 +611,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (is_sticky || c_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge BOTH sides.
@@ -609,6 +630,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 1);
+	if (is_sticky || a_is_sticky || c_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Final state.
@@ -637,6 +660,20 @@ static bool test_merge_new(void)
 	return true;
 }
 
+static bool test_merge_new(void)
+{
+	int i, j, k, l;
+
+	/* Generate every possible permutation of sticky flags. */
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			for (k = 0; k < 2; k++)
+				for (l = 0; l < 2; l++)
+					ASSERT_TRUE(__test_merge_new(i, j, k, l));
+
+	return true;
+}
+
 static bool test_vma_merge_special_flags(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
@@ -973,9 +1010,11 @@ static bool test_vma_merge_new_with_close(void)
 	return true;
 }
 
-static bool test_merge_existing(void)
+static bool __test_merge_existing(bool prev_is_sticky, bool middle_is_sticky, bool next_is_sticky)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t prev_flags = vm_flags;
+	vm_flags_t next_flags = vm_flags;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vm_area_struct *vma, *vma_prev, *vma_next;
@@ -988,6 +1027,13 @@ static bool test_merge_existing(void)
 	};
 	struct anon_vma_chain avc = {};
 
+	if (prev_is_sticky)
+		prev_flags |= VM_STICKY;
+	if (middle_is_sticky)
+		vm_flags |= VM_STICKY;
+	if (next_is_sticky)
+		next_flags |= VM_STICKY;
+
 	/*
 	 * Merge right case - partial span.
 	 *
@@ -1000,7 +1046,7 @@ static bool test_merge_existing(void)
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
@@ -1018,6 +1064,8 @@ static bool test_merge_existing(void)
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 2);
+	if (middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1033,7 +1081,7 @@ static bool test_merge_existing(void)
 	 *   NNNNNNN
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range_anon_vma(&vmg, 0x2000, 0x6000, 2, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
@@ -1046,6 +1094,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 1);
+	if (middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1060,7 +1110,7 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPV
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
@@ -1080,6 +1130,8 @@ static bool test_merge_existing(void)
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (prev_is_sticky || middle_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1094,7 +1146,7 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
@@ -1109,6 +1161,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
+	if (prev_is_sticky || middle_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1123,10 +1177,10 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, next_flags);
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
@@ -1139,6 +1193,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
+	if (prev_is_sticky || middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted prev and next. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1158,9 +1214,9 @@ static bool test_merge_existing(void)
 	 * PPPVVVVVNNN
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, next_flags);
 
 	vmg_set_range(&vmg, 0x4000, 0x5000, 4, vm_flags);
 	vmg.prev = vma;
@@ -1203,6 +1259,19 @@ static bool test_merge_existing(void)
 	return true;
 }
 
+static bool test_merge_existing(void)
+{
+	int i, j, k;
+
+	/* Generate every possible permutation of sticky flags. */
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			for (k = 0; k < 2; k++)
+				ASSERT_TRUE(__test_merge_existing(i, j, k));
+
+	return true;
+}
+
 static bool test_anon_vma_non_mergeable(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
-- 
2.51.0


