Return-Path: <linux-fsdevel+bounces-61989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12837B8178A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3031C281FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369C303A21;
	Wed, 17 Sep 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XlqLeIbt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="esii5Yws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACA32126F;
	Wed, 17 Sep 2025 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136341; cv=fail; b=D+DeTxJ/Fc80oSrqF3kScSl6OZQuIyQQbf/vWH6fa9jlC980/y3JPxc4mRXtd7MDwyaEr0bwM1XMQexAFwjRLLGPgyWHg45nxjnhhzgLnwchsYknzAgBX6pZz5IOFiJHs7gkoRkgyjBJcQ0Xx6aAUZTjthQfTAALTZPsQ+P/L/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136341; c=relaxed/simple;
	bh=TNXJDeBW0U2sLz4QBIhfmMGoGfHI/+eYYwAN8jcEck0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHVJ6pzHbUHGpTivMLC6y/qBQbJOxYgjflzrW+5zHxEegcACyYLEdD8FLoLOKE5d44ZMfIJ8LUDMkEXN5buXYNPdsJEpa+JiIX6/ACUSRD31JpeFJGSRVeAMiQ5LNeuJbXFSegtsZgjHvXma4d/fZy12K8hZxi3tP8igQjXtdyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XlqLeIbt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=esii5Yws; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIRmp001776;
	Wed, 17 Sep 2025 19:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cRrT8kxAEV89n2rq1tA2Vp7IFr1cOAltsr49McoQNM8=; b=
	XlqLeIbtLHaF7uNvn67fciZsL5PXWctCnYOjfpCTbKvhfmPo81X2FmBgd4JqqKEx
	rGxCHWLs4eQpKjqyuRpVB5W6ECqlmBGRgTOXP29/NiWG882hnRcWQDAIIhxodSYZ
	J0tycMKSwMyYHt+bUUpNQnnCuR7ANTe58N24g+AgFlw3Lpthn88XKnIdvZQ+tJ6p
	QVJwtXbO21jXEKubLFbXkyY/eC54BTWMrqktK/gViY0XCHg34d+xUZkDA99muTyI
	y15VmY0ciVD4SaT03R7wXveLouvxKUivHnstsfIg26voBfRFM9ejGPaJO67Or4R/
	AiPrzb0R0v4d8ZhVojyd0Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd2071-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHHrJ8028810;
	Wed, 17 Sep 2025 19:11:32 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2e5fkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi+79b8U6FmCrTrXIQqi51YhOIQkMN4aEdMQJ6AIwdi4AZdxJLd41lRMi/d6q58MXq2Y1H/xsEdZ2INxZFKNrsDoo7cRG8KuVL/4cfG8DhdMgdpMZn/1sWPZpYiqbi4IdscXsIZ4rq8281IDKWFCsSBWFBBU0d+ZykVNB/VoqPO1sp4+61jWYCrmvwaY5oEcyYSfEJ3iRJbQOP+Otsy4NrwtJnIU15XkFPwvOWUBjEQf/3O5K4YrgTr+fXqWRm9X3ekb3Qmz1x0sYqXU+n4FsL46W87l1e72QqSmbMGOhBuNxzi61NFF4nOPN+C6odYnf9Gaow76VtU5dKyuDy0Ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRrT8kxAEV89n2rq1tA2Vp7IFr1cOAltsr49McoQNM8=;
 b=b8vgATXbrM3vIUdmo4Kyi50aKXWI+9pulLurfbN3YZxJEWDGBr81+0ij2RKvX9AhC32Xw6cOIV6t9aeky6cFdYYZOW/fxcmpwe45jYIzlQLFuwOGHwI853awSZm1rRXNnoww5CQ+n1P6+c9GXXLfl7O+ocd8C7X9llYx61+amobZDvceL6ZjVb+scfAX4M//1qJdXZzyYZ7MPG0N8M33FvekaWLyToMmv3M3LjYeg8bmFiS5ghpkALUB9oGVE1BcikVBfe9wEWC4zBnykwL4o8rLscPe35aUikFOzkLF+FUgV1LTZCdcyK8HkKHhbWOkdTNKbwDa5dRtKQtfx45+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRrT8kxAEV89n2rq1tA2Vp7IFr1cOAltsr49McoQNM8=;
 b=esii5YwsSk5FGR4lnNRyxpkw/t7QgrvA2KbC29SOIki9lAaAvWaBO568D3RyO4ZDQGLB8atwIOMz8Xo0NqhfISUFJIeTjCUhDJYLeMhgSiKsmYrktnJtkNHbjcP/GvTrmVU6cAssupcdJRpUbome2GWpGeCSxyV2FUFO0hNFIxo=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by LV8PR10MB7774.namprd10.prod.outlook.com (2603:10b6:408:1e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 19:11:26 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 02/14] device/dax: update devdax to use mmap_prepare
Date: Wed, 17 Sep 2025 20:11:04 +0100
Message-ID: <d3581c50693d169102bc2d8e31be55bc2aabef97.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0314.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::6) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|LV8PR10MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dca9c49-8c09-4f9a-71cc-08ddf61dffa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hp1MJKxfeg18GA9nX79Sm5L/4uC4suZUMUiwlygi5/l4i33n9rmnMCp1l6YW?=
 =?us-ascii?Q?EUTmvvpSozyCqvBPl6Hqk0gPi6VdpMw5xG1NEyNGuWbY/OBHdyduTCBW35wO?=
 =?us-ascii?Q?VTXHEhM5Nl2tMAY6SviY6GNf2zIn8ebPvFWAF0w/6Wp2esiuaX8xGGAO+0ce?=
 =?us-ascii?Q?1elL5cwRQ5kcKQ/DugqyCAZ7t7gu3ngJZEv7bIrjlLOU4jW9vhSZBJh3kYxE?=
 =?us-ascii?Q?C6lITUwWZDWaQVAWEHSIBnZZDUlk7Cy/vhFRV6qB9tyd/irgW0NoQB2pWQiz?=
 =?us-ascii?Q?3I2I4A4uxOYOkyM7QW/zgnxGj1Evc/EX98ErcKBDaarwxX4ie/0SLoX1TXfL?=
 =?us-ascii?Q?dHICc8Yr+g1GzYY/EfS70NDZw3JHvZ1Hc3Z1nqi0dYlSVZNy5JFzAch0CdgU?=
 =?us-ascii?Q?mpRCAXtfofOLocdqUziWdIS5TUnUwhTT/5fAGdXWmfNVTMUjlyBu4b54Rqow?=
 =?us-ascii?Q?48lPDY6lGo1z1KviJBKhbaM9/7ER5R2BFykfh9TQK+vZFNq2KcEIokogN95e?=
 =?us-ascii?Q?PqaOdleMMBh5lulS5/mmms6XXA5aw2qpNwLb+5NWSBZYNfPP6DJL36gFIexz?=
 =?us-ascii?Q?7uglkkVB+3ksqZHV/HEjLwtream3GnoOevcohws81YeUolfRXGYj+YuflYfI?=
 =?us-ascii?Q?VoSfqmQs8wCeRuMB9gnuW1scUpFuYq2qeBmO/Wb6MBAQk9wUNfSpdTm8EIXk?=
 =?us-ascii?Q?5WMEqZamPyQv1Rkmz5JogHbiWCVjlqAqhEuawuDredQixIhfhFMtdEKjNa8v?=
 =?us-ascii?Q?SRjJ39EwH0oacODdrd0N+v0UFDqbyko/OuETPeXlgbi+jtVw/6mQsdhSDKC2?=
 =?us-ascii?Q?+JPlscvA1yZiV0t+4zYygJm0A9qph1VEqWODS3kTmmOeYbeFvlK8sVsv/e0z?=
 =?us-ascii?Q?bpDFypb4vaNqEGmNySwry0qZKzNk2P5UYT0nAE8JNbIatCJY5l6Uu16WLgvp?=
 =?us-ascii?Q?5QT3ghQ66/1DGY23BSCyTCuzd6gPe06Ku6gsVdXBS1cmqIOri0+QAKsYjbL/?=
 =?us-ascii?Q?Hcq4aG4oNnR86L7wnmb/VExz1f2KcAfsBZxxLJA0e0b92tFnVYKDQ1Y64uuA?=
 =?us-ascii?Q?ui25yBdmNDc8pW+gyhH2yW0OCvBIrPE4PAprOgXp87C1qcl7zQkeQ2BSlOwn?=
 =?us-ascii?Q?Dx6QMYr39ymsxgv5KTec8tEnYd2STU3I4Z7lz5h7UfT7WTOWLNJBsErjopxu?=
 =?us-ascii?Q?sL8bS3LnhB/LyXtiVkW7XOTRX2yNy42VG3j4jT4J8azMe2BEaXd6cHZ6K9aE?=
 =?us-ascii?Q?gBqHBC6qce6/VXGn0KCLhA9mcJTNtQxmhg6AsOcCEzXbXaxQpeMbfKTlbRHR?=
 =?us-ascii?Q?C4LBUF/oYpveMEGyV7RChSHEp+XlkuthXtjt9OXQkyQ2Z3rMfLoy13raHOZn?=
 =?us-ascii?Q?JqQz4Wk3okNQLd6suz/YD1bG5grrg3+QY8Ji5V9y98PCIgdK85jpD8IiYAlJ?=
 =?us-ascii?Q?GqiO8wLD01Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2zQyqqlW85bNRAhAqi35SIPN3Ez8elTvzlxICYJdnO7Kmto8C6jvU58/6MP5?=
 =?us-ascii?Q?LPYzD7dsii387FlntqSDncYA8BYOuFYyfyP/snflwapLC4XXyznIiqAWBx4G?=
 =?us-ascii?Q?7W/ILb0Zp6O2onzJf2MRZEOD/maMPZBtqFb7QF0djTDHFkdkS5xqDrTlGyZM?=
 =?us-ascii?Q?X7dAPzYj0KRFBntAeIHaB4MtnbdIN7yz5GwF9ip34ta/DBsS0hQUuX4dvcua?=
 =?us-ascii?Q?qZGOYS7acKeWmfdM5fPxO/chXuzY6C3Cp4uyA1mx/AkJ6RLpMp/AN2XKBtPB?=
 =?us-ascii?Q?4HWy0nmAR4T/b2+A2N/B2TPMXnLZx1qrNlSaGZVWZyp0kdJXUoQ2jjagXaya?=
 =?us-ascii?Q?d9Q7kHXpgWyaI14ntq/AIonoxqltxJLrTxBsdixVdw7JU8nASc3VyV+ONXIK?=
 =?us-ascii?Q?4yxj9Ug64Z7Hu05J5fC0x6qnzoqJvgB/MJUJwFz8OmAWjc2NI+qqCTI7tMCa?=
 =?us-ascii?Q?yB1WEIIQvtZIx77boNA7rjqTI+oNft7kOAK/BMbYg9YoL6LFyId3RbCQqOaC?=
 =?us-ascii?Q?4clJTugkmzJFYuCZItFzc6bqdyNkS1BD2vq0eq0nu6e78T4X5L9dIxbUx7n/?=
 =?us-ascii?Q?x9qHLyzjESfML1Lb6gIrlDyXUypiTJKWvfnMKA43m52pzZZKAieI7iDx0TB0?=
 =?us-ascii?Q?rBha1tBVjAsQxe1sGusMGDZ75zQNviSuKjRInzttjASlVGS4LJBYtWGsFFFO?=
 =?us-ascii?Q?SBO6//exk1SXejgdKTJmXHzTA0oKi1BpeLGx8V8QlU8QDaDjYvquWqUrIdtL?=
 =?us-ascii?Q?hYZZqTohuYATZFyTFN11YAtxgyIMuWQNaGiePkLlXHzgEjn8xg1AOrz5tWAY?=
 =?us-ascii?Q?z0I26DrzsOaZU3XOyLVaVHrFENIzzDGhPeascStl/vi9ZWB0TyyI4RldXnTc?=
 =?us-ascii?Q?pX7QqXn0wX44vROqf3FMDPeIcGkDf7/7EUi4sA487jGrwXVJvRfDY8sl2ZE7?=
 =?us-ascii?Q?QqUsVIcj86FdsPJxvkMlP3kp0fgJ5aAfo2UjUOm0K8cHL+D5JN/1Jc6xHLVr?=
 =?us-ascii?Q?by/x71ALBXmZfJo2TUoorUmIyc4MR/RKoBM5+ELoOqBWCyD/Qx5fd64MOEXr?=
 =?us-ascii?Q?th11j4bOOmD+4K1+Jn/c4U3dT3V6KnilZYnvAghdru0A02hpNTc2oSv5v5aE?=
 =?us-ascii?Q?WBIMNmyroCcS4eM2/MJkLPviNhDrHIBnrYbeCtje10OgRStrqR7AX1xSPwZK?=
 =?us-ascii?Q?VUMNkkGaoZwp9QACexLIP4WNl7UvHj3Y+8nI++7FzZKXhWNhLbTAFMTzf8d7?=
 =?us-ascii?Q?mgaLBfaOoowtMn01WuVHvrxCUfX162OFjwRFbbF5zoxbEMp5L5PcE/iulHY/?=
 =?us-ascii?Q?jtJ5+1zJtCMBSWWo0L/mqGqvAAAhiK2hA6VcMujB1ZnoUzUi+LCJwMRPRLgZ?=
 =?us-ascii?Q?sxB2umM2J2SgPBlMU2lZb5IBPimMUF2GuGBZ0ZdgYjW3Tfq+iQiT3zXT61O2?=
 =?us-ascii?Q?dTHN1O1tBK12dgX6w5T8lwKu+FUPDokVayBV6gwxtaZcApYsBw+Am5dNB5J7?=
 =?us-ascii?Q?RpWR98fCaqqXEjO0We3QUUbcPZiNaCUDA9IIwwKb+eFThgjTkAIb/m3N9MbQ?=
 =?us-ascii?Q?A4apSv931vSTRRfN21yWtb7abLbxIHNad+Nb1spoE/W482fKMUOTHQNAC7Jb?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	idDHcPtQyfUoazZeDrgbikTwzUB1VeLGPm7ZquzLL14yvHikozUBU8AWYmTNhfuRP4GU/9OD4pOON+ol7blaupYo7ceAne3Y2E9YMLzBGlPRPESAo7kW0s7wn98QifRm/Ki1lVtRzvH5ePoKtHYFQNQVs+ZREI9l8x6eaUwU+umxqPL0KtTXYEIx/rThrPQpq2eSgfBkSNj6nLdhHJjqHp7vDv4pVNPjUcOD5AM6V8WbpGb0ME/lwqyAM4PZ1ObhLbbDwe0VehEUAsWlTWcg42jPLVvPjhrR/QoKnZrCcRJXbieMOGVkHm0YEs5qA1O/6gxiTXPHCdci9qmhJSBMulKiwmAN+7ecC8agH0C8Ns42FinxuEZESKQWVmhS1iO2VvbiQhU6ZtL6bdaaa9EeiPIAjNPBcgXDV28JfMDnftIQ82DniC/bHGM0vC810jsjv6LBK9XMGqf/Oqb1zvAeLtHYSPKI4sWiBVDlpSG5Qi/DOxis5C2sUGwWhZnWq9HLjx2e5XPiLA7I3BUIvCAEwyt8PxoGach97cTVDg0Y8CAYnYbCZFBckynJKe+yj+RrXDKCm1j8jp5IkdVfJnO6iR/ViND8SKxBL8fSyUcxKrQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dca9c49-8c09-4f9a-71cc-08ddf61dffa2
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:26.1135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5A/dZAVxlqGscyjL+HoRc+qyPuODgkD0OqeRW0hKu04HYEcsTDiwy0/ONst++dQU/MLJyFiaFmiCf7ZQtUsmKZXf4tAqUcJsTNjnewPrjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170187
X-Proofpoint-GUID: lNDe-b5pZ0xmZt9wS6VzxvJJIwsL726_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3UMCu+50mxkT
 nmOQy4SatZlVeTqZl+aZlrtgitpeuUx6CIVAk3y2f3sHbhlH8CwZjLSOFlNiOArxgWBFbwEAuu+
 35fWdDF1iffiI3D06KJCtvhlS6kQGwv9+Rb5+Giz4UUe1Cr8drfGAqczrnc8cztgtAf5EgCCZ1x
 eLvp5veGqnOQ833XWFTp5XK40SYxa3mYX/9NliPqgm0aDba4G2jy9IJ4tba+Nt6hCqnYzOm7vq1
 ZgVQHA2GcJnmxVIOaifNfQ49UAerRr59p3x5ODuPFvKpqMtzCBY0jwYNHfZ2WfLZqiWUWxgQGjZ
 8PBWPKFrqObr19NmDfTwlY5JbXX0rS4JdacRXAxkPwkX5Jyi1BWe8cXeHN4LDnD/DzpgAF1yTdd
 3RkRI4rP
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cb07e5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8
 a=miBipihQI5mFMOzj8b0A:9
X-Proofpoint-ORIG-GUID: lNDe-b5pZ0xmZt9wS6VzxvJJIwsL726_

The devdax driver does nothing special in its f_op->mmap hook, so
straightforwardly update it to use the mmap_prepare hook instead.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Pedro Falcato <pfalcato@suse.de>
---
 drivers/dax/device.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2bb40a6060af..c2181439f925 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -13,8 +13,9 @@
 #include "dax-private.h"
 #include "bus.h"
 
-static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
-		const char *func)
+static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
+		       unsigned long start, unsigned long end, struct file *file,
+		       const char *func)
 {
 	struct device *dev = &dev_dax->dev;
 	unsigned long mask;
@@ -23,7 +24,7 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		return -ENXIO;
 
 	/* prevent private mappings from being established */
-	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
+	if ((vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, attempted private mapping\n",
 				current->comm, func);
@@ -31,15 +32,15 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 	}
 
 	mask = dev_dax->align - 1;
-	if (vma->vm_start & mask || vma->vm_end & mask) {
+	if (start & mask || end & mask) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, unaligned vma (%#lx - %#lx, %#lx)\n",
-				current->comm, func, vma->vm_start, vma->vm_end,
+				current->comm, func, start, end,
 				mask);
 		return -EINVAL;
 	}
 
-	if (!vma_is_dax(vma)) {
+	if (!file_is_dax(file)) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, vma is not DAX capable\n",
 				current->comm, func);
@@ -49,6 +50,13 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 	return 0;
 }
 
+static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
+		     const char *func)
+{
+	return __check_vma(dev_dax, vma->vm_flags, vma->vm_start, vma->vm_end,
+			   vma->vm_file, func);
+}
+
 /* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
 __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 		unsigned long size)
@@ -285,8 +293,9 @@ static const struct vm_operations_struct dax_vm_ops = {
 	.pagesize = dev_dax_pagesize,
 };
 
-static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
+static int dax_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *filp = desc->file;
 	struct dev_dax *dev_dax = filp->private_data;
 	int rc, id;
 
@@ -297,13 +306,14 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
 	 * fault time.
 	 */
 	id = dax_read_lock();
-	rc = check_vma(dev_dax, vma, __func__);
+	rc = __check_vma(dev_dax, desc->vm_flags, desc->start, desc->end, filp,
+			 __func__);
 	dax_read_unlock(id);
 	if (rc)
 		return rc;
 
-	vma->vm_ops = &dax_vm_ops;
-	vm_flags_set(vma, VM_HUGEPAGE);
+	desc->vm_ops = &dax_vm_ops;
+	desc->vm_flags |= VM_HUGEPAGE;
 	return 0;
 }
 
@@ -377,7 +387,7 @@ static const struct file_operations dax_fops = {
 	.open = dax_open,
 	.release = dax_release,
 	.get_unmapped_area = dax_get_unmapped_area,
-	.mmap = dax_mmap,
+	.mmap_prepare = dax_mmap_prepare,
 	.fop_flags = FOP_MMAP_SYNC,
 };
 
-- 
2.51.0


