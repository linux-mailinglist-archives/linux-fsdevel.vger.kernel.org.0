Return-Path: <linux-fsdevel+bounces-53104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73168AEA35F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC693BB4A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5872220C48C;
	Thu, 26 Jun 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KEcYi8OR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ng+EQhtf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E718871F;
	Thu, 26 Jun 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954814; cv=fail; b=Y/cmkcbZnjnkTcWz/PAB8487ZsTRAkbSujZoGBFBXSQSIUh9fvqCsNblGpUPSnGbpYaz0nwUtdpemnhBdjB01+CP4yjO8gtu9G3v8KpDiHg/AyoiL1L+iQqRJ8domUA4HXjYprdAb8HB+61dUdS1gK6fE7lmz1OMsW2mvRpXLIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954814; c=relaxed/simple;
	bh=dJUd8Vx7ry5ZNGs3Ak9w7vu//4pUP2qKr2TUur+jU/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M51jKLsTC67U/9ZCsrcQBkP0X8mWYScbzr5WbscrEVMh3NQ8zlFdB5A3ng/Jn4gMIZTYt/7zwlj98My5q1n8FNw+boXTjwNh4m2aanyjmYlNSqpnr8Q1Nsqq/nbwrKz6BcePSvvvFtJESrBzLJIE9RWn5KwDEyUY4YC+ObH8eaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KEcYi8OR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ng+EQhtf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QFu6mI021049;
	Thu, 26 Jun 2025 16:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gLCAvd/JV+K3I52bxC
	CPDRpnQu8iWr9jN1cToa3bVZI=; b=KEcYi8OR2HOVPQ+gQhVzXZr0s8ZlfjM4Co
	D5oLGExpFOMUpEHyvGhYNW1XuwChlgs7WsJ20aDl03LJXm5nubQgLEpcTBi0xylt
	YPLKdb4iJ2aDPZ4lewH/46dkskX+oRj+sAh7/nfpxLC7Oknv84oAZwBYF8vx+7Vk
	pEz+pgM3z8u7W048w34kd80pCqjwTQYzh/sph4gwdChayIW0z5cZasbBH5URD7sn
	IgdXsNxu6YZuAI6/kTxXhekJH0IaBq8Bvp+dWfbYfFFfmHa7nUGYO9ljSJdQNqF/
	KLZWEKnLDajJ8iGpsGXDBbR7g/eWTiM0F3PtTIGvr6yRpN9empCQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egums6u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 16:18:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55QFkZKA017947;
	Thu, 26 Jun 2025 16:18:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehw07jb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 16:18:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jt1GqTn6hXqbeU/Z7KhaQAVmrMDTb91RGNOTglw+DIAunqD/gs1CtyFospUGnpg8Wa3XJwHbUBz0GG8xrDoSo5VeQmEIW5ALC1NI8hzl9qKhBQzguLM18YrHowR9rZuBUphKI2+QJabu58UVtJxHDAH4njoffSEZ35DmZcPMAtUNC6BTQHXkzFNBchjSlEA+04Ydn2wg/4AP0/FqzBP4ihC6iTLUrh33IJfIH8ZaJPyt6LUdDO+76kaIhh73kvrBIymH9iUtP+CHEyaMiYuZVVg9tL28cYC9mSZpEdWrMufvIOzGPZcr8Rc/Nx4QX1mYyO8sK4+GKxhxUsreHYgjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLCAvd/JV+K3I52bxCCPDRpnQu8iWr9jN1cToa3bVZI=;
 b=B4hS3hsFXPWVeYj0jZ6ZBht8iceowVd7wLOH5IssWuU157O0oVeOBYFinXDl6/0R+s+26bNFPOLubGlXphEkvKQ52eOB0/ce96nRDa08iu3IIPFQkcqbAdfIzSqeU3SHQM8+Y1l3gLSXqgAKmJIPlWFvdDGjHNiVdrlF9UHu/OElh5ndVUeTYCn4Cjj7th0/YBIUoECPJ8M/ntRw9t0N+Ctn2y4M6bqTpyXlVH9+VHWk5SveJ0LDiO6GTJjNCWnets9Uz1Qkzv7K8vA0am+L5cgv+YkMWG5OY2kVEycQektim/v0qyoZ8qVryvhHh2wjPHHR+t1FdDqlTXCAvubOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLCAvd/JV+K3I52bxCCPDRpnQu8iWr9jN1cToa3bVZI=;
 b=Ng+EQhtfJV/k/3myiPn7cLR9bb6pO5QGXu57eMLmkwdQESHpChgJJmQZjQEGhuxSs1wAGWHMV2zWytbl3/a025YfKnP8tOPO3bBdHk3CmeWtFiIbtzUdTYV6UwILMZDx6lhQoAjnKMjjmJc2urym4vywfz7OcAfoyGNVO7V7M/w=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA4PR10MB8658.namprd10.prod.outlook.com (2603:10b6:208:562::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 26 Jun
 2025 16:17:48 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 16:17:48 +0000
Date: Thu, 26 Jun 2025 12:17:41 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kuan-Ying Lee <kuan-ying.lee@canonical.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Etienne Buira <etienne.buira@free.fr>,
        Antonio Quartulli <antonio@mandelbit.com>,
        Illia Ostapyshyn <illia@yshyn.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:PER-CPU MEMORY ALLOCATOR" <linux-mm@kvack.org>,
        "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MAPLE TREE" <maple-tree@lists.infradead.org>,
        "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 00/16] MAINTAINERS: Include GDB scripts under their
 relevant subsystems
Message-ID: <fynmrmsglw4liexcb37ykutf724lh7zbibilcjpysbmvgtkmes@mtjrfkve4av7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-kernel@vger.kernel.org, 
	Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Uladzislau Rezki <urezki@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Kuan-Ying Lee <kuan-ying.lee@canonical.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Etienne Buira <etienne.buira@free.fr>, Antonio Quartulli <antonio@mandelbit.com>, 
	Illia Ostapyshyn <illia@yshyn.com>, "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, 
	"open list:PER-CPU MEMORY ALLOCATOR" <linux-mm@kvack.org>, "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>, 
	"open list:KASAN" <kasan-dev@googlegroups.com>, "open list:MAPLE TREE" <maple-tree@lists.infradead.org>, 
	"open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>, "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>
References: <20250625231053.1134589-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625231053.1134589-1-florian.fainelli@broadcom.com>
User-Agent: NeoMutt/20250404
X-ClientProxiedBy: YT4PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::23) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA4PR10MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: a69dc42c-ad1d-419c-196d-08ddb4ccfd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QNBFVtPvYdGJL8nKYChk8IHI03LHAO2DECI24eTTqR9dHGzYLQR+jK2195Ge?=
 =?us-ascii?Q?aWAKeY2o0dfPsVxvU3P2/eu5D5eDR4e86kH6oegLEEIHZanpU7k744PUU/J0?=
 =?us-ascii?Q?buv5gCB6EwYVBRmlKq+hDE859iFhbSk1y8/Jbusk5o2C5HaK8qj7DD233RHB?=
 =?us-ascii?Q?amGarZFKUBxl3nvFLbRq1o/63Hy4g9hAQn8Icii28o+jrYHgurK9xWu3jL7/?=
 =?us-ascii?Q?QeRxhFJtBOQaFA2pJOKdNi5L0VnRxXfLeXLYZbRa1zdhDsvyY/5jKWX4rKag?=
 =?us-ascii?Q?5nJR5XtjS1z6qDJ4sqnhdTF5c99qbyBw+DrbeBLcJ08VETyX7vJN8HMukJ3g?=
 =?us-ascii?Q?B2L+kyZ7Jebw7Od4Np6TDaEXo2XkNSvs6vOGPWyRIakLhGPn+5nz/DOZh+8o?=
 =?us-ascii?Q?vL7rzC9f4yFIhBfGeFmUMOuVae6UEUiS5wxEt1FOp72f6qrd6xHVQV7w+/bQ?=
 =?us-ascii?Q?ZAC6X0KW4XDedefV2CdI17FRddXZJFx9wjcJTOHxUl1gye1RGdJBhm2G+0JV?=
 =?us-ascii?Q?bmzUwFyJLzFPK5Iq4+N1VR/Tk6YXtOVNYydoNgOLBnGc6QqcqhEo9H8M+Tk0?=
 =?us-ascii?Q?wslBWRz8yo5KhWX/s8a2TgDKjaL8oAhe1OCSQxhP7h5HvDcsk4//kb6EIkw8?=
 =?us-ascii?Q?VQcvuyGc0scyneml5nJrrfdnbDg6RaDSUX9NiXvIyfXpzCAxfxLupQon6iQb?=
 =?us-ascii?Q?hCh5sA/S1Ecn2sSjxyXlYtBb3Aff/I4kGDKQboJDivu5YQwILObsBecfBW2t?=
 =?us-ascii?Q?62l6wwtpXb2IWLWqbc90HWNMq8v11NUDw8BfqQ8G/QtJkWqb/qbqaW/p5/ac?=
 =?us-ascii?Q?S0byD+s1lanQRCT8tqXUNdIPrJoJ5oSlQ68DA+nVEuf/rv6IYZaapOe/udxc?=
 =?us-ascii?Q?2FEqJZ40POW4XmhA2Lnhq40Vhwj2yS+DlMeiQTabICV5mXH2ZEJ7ffLSjzHT?=
 =?us-ascii?Q?5NcUgNy++SczvFurpJicUVp6u7LHQypjBiqvGnhVVomoYXNJuYj2QVsoBRvm?=
 =?us-ascii?Q?jORMisGshGE2zslevjvtr8RTx4+Aw169Zvs1bh/yrUP5V6K9NhgL+yZI3Wvp?=
 =?us-ascii?Q?N6AMNXxEow+9g0xpmVTyhwEKBUb9sBiHmgJ4lGf5qmv8/P8h3edLKvTm9XH5?=
 =?us-ascii?Q?MXwWz8ECwXAUWwC8Ytao1BIh8qcUkhF2p6ORk/yhkoJp1bhNtQNKXRKUyFM1?=
 =?us-ascii?Q?f+Xszt4nTn/4nRKkMdcoQ1Yt1OJiYSVF6BBhMtRqyHH1uUFA6ChaZgMUmRJI?=
 =?us-ascii?Q?FuMh9U7CigL5DZ9NPbJXLIaSv7pOEpf8tJ9lvT4OpudB6EFiK+rVRTIXZIlM?=
 =?us-ascii?Q?6Dyz68kxoiyfgqsuzrjhAHEPQs6KIylsxfMYIn9hLZMHSmhXkZChc3m19zc0?=
 =?us-ascii?Q?At9FxI9QhR2QERJeA2u3qH7rYMoHQHG4eft5DX7HFtXoZs2czk8ml/Tu/oLi?=
 =?us-ascii?Q?AhvWGR4bdNWVR9DswRUN31L5My0X++3bgQ3TNl1zmrXmb/8vg93taSH8ggs5?=
 =?us-ascii?Q?rD9O2m9AL7Ff5ps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KckzkHc+uT3F62GMtZ8jpisftJhTsr2KdhnmrBMA34Th+296fGfvpLLUt3dR?=
 =?us-ascii?Q?lnwlZKdM+GfHBvaoAYGYO6WrfSBeVmcnbcRiRvnTJWelCaTtka06kFUxfhx9?=
 =?us-ascii?Q?4kVkT7X8yN21beAlySPf7QS6Q2jgs+f4ZeHiTDE2Kqsd9iz7NTuQeQ8VHmH2?=
 =?us-ascii?Q?ZiXoxJEPRxy+wjqtryEI28pNLFzXybeU0romaoH8BV0Fo+NQmrcAQ3k1RCYg?=
 =?us-ascii?Q?QxFvjEkhkRvomV1tseD8o942UbFJTxuwaEVmu7x6Lkrov80axEKig3BIT9Rk?=
 =?us-ascii?Q?Ip4bsHArWs86/WeZS1LQwxJW68O1+1n7zkdN3LxqK8m7rAYzSUQxuB5ipNw3?=
 =?us-ascii?Q?xf1d3BiBHEW3upualrlhevfxxC7xHKGRN8H880p+rtBdRvqMoQ4A4xll+jfP?=
 =?us-ascii?Q?Gml0WfF4qdPGpuzsOq6Ew1pDE7JaI4rw1KZIG+ngvhruxIpmsrexMI9e7yG3?=
 =?us-ascii?Q?rGTTkUM/wIZvlTYREQ9204r1sxD5e60QWFTAGtB03oaD9sD1m59mFsYZjT/2?=
 =?us-ascii?Q?vW7tvDlZ4HPp+bAft0Jku2xc9CyGW3M+FXlluKdOg/jPtkbCl3ccxeezP3+N?=
 =?us-ascii?Q?B+tpZgJti36Mq6txMPQZv10z618+fMdKVNnU7b7UYEepGvCgCy+5NDD7jdmI?=
 =?us-ascii?Q?xx3VPK345Mf8kIN1i9QGqtGAaF+2kx+84m8ah/s5gvpIui8+j02wwpnTz1QU?=
 =?us-ascii?Q?ikjg84qzKiaF/pYwK0B6gjrHQS1dNBvo51nHxy6Cd2uXVcw3e7VM4bjmF722?=
 =?us-ascii?Q?kcmHpNjsfBgLw32S+vgXa2VSZ5L6U8OWPU+mRjkksVcEI+QMi0BpN9n8YBLx?=
 =?us-ascii?Q?9RC6Z9MOdVYXXRSlUxQjPUfTMb4hzpc8rF7297BtvegmPbT7s13fU3e5UBaF?=
 =?us-ascii?Q?Ak9ztU6eeQRiD9Ws9pn5MU509ICvopUp7tIGqrTYu//EhLmuYIXP1C4fMq8/?=
 =?us-ascii?Q?10HLjyBkGTh2ta1LIDgIaTfl8cleVwy/GYgocxzAulngbdbMuRj+bo6xyAnB?=
 =?us-ascii?Q?3PBfd7om5/rAGBYVA+cNma+rH1oXTnZ8lwS0Gly1u37vWOpvGgWg1KLvAC7g?=
 =?us-ascii?Q?0+/+aF9UvbXeGfxqxRK8BSlP86okDbxQ07jBvQNAr37rI1KN8rzrekFu2PzV?=
 =?us-ascii?Q?AI6g95WvwUOy50N6kuYZudiCxBZZDPcCoGDnzRFkn7D9myxb/LARJTKRYPco?=
 =?us-ascii?Q?TtIs3pQ4oLxUCriavu6SR1bs8k/OldTmIYU8YHDMU+itGfP6mU2/MrVrG1tq?=
 =?us-ascii?Q?l2IHO7Ot6XLF44Mjnh9tU3dGjAI6ZgnPIYUEcdwlZIisGg9I+nEmDJs7tVRn?=
 =?us-ascii?Q?G5v6TmPo7vnatqV+LGIzjAwGbeIAQTAeNtCeZK0QmXUw7jU6c6X0Z7MG9H7H?=
 =?us-ascii?Q?OVhKNutJgdR/Z6ZTEpWUwe/NaWy7cc9hTbpOPHW+zocCRBBIyQJAgMVFtjVe?=
 =?us-ascii?Q?hzt+zygcxx882PgLBKGknEouQJ5A3G3DB30YMiqinaOjtXcN2zpzkSubQUIQ?=
 =?us-ascii?Q?y6ZOCUla3kwTRcymjjr6nUseIRJXEdQrcCG4TrflVdG/g+c3B+x/5ycn3SVD?=
 =?us-ascii?Q?pdr895hryrmsPP8Ay+XGwwRKX1nvFRVr81h1eR39?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	diQ/sRkGjrolr1efxgi27DeIvEVof86opNCrSTqQUG7fUGiO96O+k8Lt3BZj1pg17zXxTNKLeBDeWNJuZGur48P6/Dw9Eao36IZordQX4I3EDFzHJtLOFRE0S8DybErayllEq3ez6iD0Lj+FLIsH/SPD6GDaIUWa9dvjgCwIQvglDJ5VxEoUt7YyG+0GHpZxiSLJro6MnPF6ow5QunizfZxHlMOU21PytFPL9c7jAlHnFxImy6Gwq1xWNwp8J+g5v2szMvni4sYlvBGyJ7E9DhyROgALU3TmaxTuwhP8TgHkO6JxMJjb1x6qCi8QXdMd6le9Jz6vK/8qAHzZhMj2WZowVNeVh8tqwSoWkqAcvF+BJBbqnoSEavNoUiAySd3IJUD1RbcTpQBpQlxez0NYCmnKb1PP4fLzUISBkWP1KeT0Fpf8yZAz48fxL1363n1j5RXALiaI2DJfN5B4l+bqtfCn+vmGKZF38QW2eEJF395giXQWmzCSBAGvdAl8ySZT4UYJjLVAABcuGoC4D4zzpIAuiFX0CCzlvtWmzShzKq6Im+Br2v7WQWAzjqMsnNahsK9wt5Cw86LddtUTG+GA+T3W4JRnrvmfY9WRYkUdlog=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69dc42c-ad1d-419c-196d-08ddb4ccfd87
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 16:17:47.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28AutF3DPerlouH6ewR/f5b5uJC5TIIIVHQuojYtTDWcy03fySINgrEu+sih1HpVeHzI7Lg+itYHWrcfBqvHUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506260139
X-Proofpoint-ORIG-GUID: 3MIASCle8-cB-Nog5KITk7cb0bEJM0rS
X-Proofpoint-GUID: 3MIASCle8-cB-Nog5KITk7cb0bEJM0rS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEzOCBTYWx0ZWRfX3G/Sv1eyrJtS JJ2a1KJK1MI+f+sftoaxGkBvABJua2O9GiLaBV/Doob+rNUamBQvNA1si30HX4UuPsVg24YziJK mI07NuyjSlkNAcCd+jWRtTStJk2arAV4Lpw00baGNv/JVXAUt3b6oqqtO5Aa1i3uV/gsGzJjWDe
 W7wLc6A/zs9r8h+jkjZM5hwFSxfKuWb/O0zwIDFEFT8lBjbPbRq/bSgRHqL2p5IJ5yv+WqSzHSH OEYKdYT9p3VnnmzsdIWLdLFT2wBJD9qiS0OT52NkRfJh2UUZRn30URNTtL3MhWvTirLe7eA6IAt iVfkwFK+6gedpUBYVp0JxngT3DEdwGF4EegfO2T1xGq40n4rH5sY78cgB9TlyiNrTxKBnjhNHhs
 haCdCCUVy4hqeE1QisWG9zVJ71sl73t4apIQ8foJP416lU5DRkBDWRILdU0/IHksRJcxgi2x
X-Authority-Analysis: v=2.4 cv=S5rZwJsP c=1 sm=1 tr=0 ts=685d72cb b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=ybGqZvYXq4FKXwSi81QA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14723

* Florian Fainelli <florian.fainelli@broadcom.com> [250625 19:13]:
> Linux has a number of very useful GDB scripts under scripts/gdb/linux/*
> that provide OS awareness for debuggers and allows for debugging of a
> variety of data structures (lists, timers, radix tree, mapletree, etc.)
> as well as subsystems (clocks, devices, classes, busses, etc.).
> 
> These scripts are typically maintained in isolation from the subsystem
> that they parse the data structures and symbols of, which can lead to
> people playing catch up with fixing bugs or updating the script to work
> with updates made to the internal APIs/objects etc. Here are some
> recents examples:
> 
> https://lore.kernel.org/all/20250601055027.3661480-1-tony.ambardar@gmail.com/
> https://lore.kernel.org/all/20250619225105.320729-1-florian.fainelli@broadcom.com/
> https://lore.kernel.org/all/20250625021020.1056930-1-florian.fainelli@broadcom.com/
> 
> This patch series is intentionally split such that each subsystem
> maintainer can decide whether to accept the extra
> review/maintenance/guidance that can be offered when GDB scripts are
> being updated or added.

I don't see why you think it was okay to propose this in the way you
have gone about it.  Looking at the mailing list, you've been around for
a while.

The file you are telling me about seems to be extremely new and I needed
to pull akpm/mm-new to discover where it came from.. because you never
Cc'ed me on the file you are asking me to own.

I'm actually apposed to the filename you used for the script you want me
to own.

I consider myself a low-volume email maintainer and I get enough useless
emails about apparent trivial fixes that end up causing significant
damage if they are not dealt with.  So I take care not to sign up for
more time erosion from meaningful forward progress on tasks I hope to
have high impact.  I suspect you know that, but I don't know you so I
don't want to assume.

Is there anything else you might want to share to entice me to maintain
this file?  Perhaps there's a documentation pointer that shows how
useful it is and why I should use it?

Right now, I have no idea what that file does or how to even check if
that file works today, so I cannot sign on to maintain it.

If you want to depend on APIs, this should probably be generated in a
way that enables updates.  And if that's the case, then why even have a
file at all and just generate it when needed?  Or, at least, half
generated and finished by hand?

Maybe this is the case but scripts/gdb doesn't have any documentation in
there, there's no Documentation/scripts or Documentation/gdb either.

Can you please include more details on the uses of these files?  Failing
that, perhaps you could point to any documentation?

...

Regards,
Liam


