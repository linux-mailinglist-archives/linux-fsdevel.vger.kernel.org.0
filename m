Return-Path: <linux-fsdevel+bounces-40435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850DAA23540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8A218881B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEF91F236A;
	Thu, 30 Jan 2025 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OL0oXIj0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mkb8IEAh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566CE1F1529;
	Thu, 30 Jan 2025 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269665; cv=fail; b=HaIWYRTAUg4FFe37Fc5FUw0bu2lreoOcb+9GrSKhW4GRPuel96aMBvdb8SBSqFCEgEEHhW3SITgFu7ErJEFrNaMNJjFIDgWXTsJJs8CfKafm+JXVlXQiW+8px9CoTNrxMKFFoHYtIx+aig+YrJ7fujEuzh1OTWnsCUJIQ1qiC90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269665; c=relaxed/simple;
	bh=eMIAbWrfjkbz+N14lia3pRzYZMjPla5GBVRG+TCF7tU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uvI0yQSb7tJqGj8Ipl0gteKS3plXD1qNTf/aZF7XqCgiZHh/K4wPnC/6XvbVuTTnEWEbFNyhxNL32A03OT87V9nFL1+uJZ94Zkk7hTQPDE5rR71CDhTUKtlKiSmNtU5nWo3QoIzVagmKXp9R3GE7bj0du2rg0rFMssvZOtebQ9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OL0oXIj0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mkb8IEAh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UKR4iY017776;
	Thu, 30 Jan 2025 20:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=L00qtDzmUzGxMTkI
	0LyhcGt7pq1eF/vG2DHjBw8OijY=; b=OL0oXIj0hVqizisqMyDjfZ27/H9daxiJ
	3EKWIq7+j7x6/0otpo0TT4ezK7BcgCgO9+iRMr/IeIB6lm3z6JiFaHMO/2n+mvqu
	V4B9y99TpKrTxwzZOXDnTuW2IwjlQBOB1jxC11YHZgV9VisvdDntrqlULggu+Z0E
	n/UjHez2BBmvZ2MvEezPMIrXL7EZiQ6zUIPGLRPhcawrRmeyJhD3CtArXGU9mGhk
	fmu1HyBWA1RmtH+oviOvrr8OOn76q47oi4pJAwefCJVVp2Pzw+sYO/LJfILyjc00
	GBMwfzRzy2nCM61o2LaY6BwYQ6SUFY++Vp6ApqUMumIVQuntHeMv1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ggfe80sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UKQDPP028176;
	Thu, 30 Jan 2025 20:40:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44g0vbm97k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUoTflH5EU7f+sFLZnhMCT8rdRecNpThpVptWrGGqNvJNX7LAu2qzJ0HKzGogbbtp68PiHRqATScJrNv9Vjbv1PsnB+8/lw+gQtVTWzxufHX/mTLZJJyl7TQGSv7vN4t4R1VVk/w/jGG/PbNbXbQ+LYpmoVkpUaTStUzWi3sp+3B5oPL/RN05qY54reoNpmYxPcB46/Cv5riRXgysfuJvTnW358ly2auec+AN11b9LQ8Incsi/9f70B3nFmXJ7g/dM66qn7Frfxeoyl2K8G+Ranu8WWFYbNLzmvlBWrQzLhIDo3j2TvKpsNqTjQ94J63gSLjP5D4v7rIZotmwAKnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L00qtDzmUzGxMTkI0LyhcGt7pq1eF/vG2DHjBw8OijY=;
 b=wFLUPgCMGbxCLuIAx5WmeyxPx5e/Qty1DwhmCb/72/XLXnOcq+2GrwUSu2+ELtXevJbUlyi79o7iE7MoY0ZGFAP4BW/Up9QMNoh8zu0qdyvnsi/0p0ECh8rcMLGsYVqwlVbGtLLh9vHVeg2ROEt411yCM33yQprOWLysxwbFQJ/axHHGRaXPoQ7McAi2KLiI6F4bUGwvJo88x20sJ3BfqUTxYij1UrPQYgng5Y0STs9DAgF7XJ7ySkj42lbshHofwX+wiJy8pv35OeWj9nNQ5bmI2SIl4zDj2nxxFWbHQ50wlZSWfbB4ypOa0QSXSgK33avxxCn9IA8/TG2+V0oTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L00qtDzmUzGxMTkI0LyhcGt7pq1eF/vG2DHjBw8OijY=;
 b=mkb8IEAhq1FCYE1sg9TkteJ6mrYV/JcgTdFRtm5t5/ykrjwVJD6Xd7pZA9futgNxo2X5qsjajYpdhKwpDUE7cvWw0sDk+wr0uMwHtIPCb25rymbsFiaMRuty7ncxv269pnRAU7D7xRT9ZzPm65lJcbaoZxUaRyEZrOIgk+GRQYY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6396.namprd10.prod.outlook.com (2603:10b6:303:1e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 20:40:35 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 20:40:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
Date: Thu, 30 Jan 2025 20:40:25 +0000
Message-ID: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: b9375a2f-5581-4716-8dd6-08dd416e58e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BoXQiCOJxEQc3gZKZ1LmY1ojn15cG5vjs1NC5osITEv1JiQcFJnlUNeSaymS?=
 =?us-ascii?Q?CnSaHlbieSxhihSSIjQSNioJzMDr/Xj33vS/lT0Vf+SLuKeTmJC7Lc5qollq?=
 =?us-ascii?Q?fht5rjKqtmqrXWicZOHbY5+uguvpLgtr64BXS6E1LMFd+qzlK0lczfbw1NDt?=
 =?us-ascii?Q?rsbpkN8j1OUY4oWgJtiPZEcXRPrVQGneCiH4uP3iYnOp3WfcKzwzDH642U9U?=
 =?us-ascii?Q?HX8Dp5yHR2bot2v9TxsTrkX44PUPXLObaC75M1O9GOyuNGA7SEmlToYrwwly?=
 =?us-ascii?Q?FtIB84COy/eEll2Ols0mafpxs7DAbJDM/lWIqvjQqEvltphfBcEtZlQsPUi6?=
 =?us-ascii?Q?AdxkgqAOhkZy262ZvxYiEvq+XIoqBvqwN07Ofuv7dSb4Ook3uVEVatNzVIfx?=
 =?us-ascii?Q?2oIfV1VACFN57g6+QcNT9n6h9QKiKWAvk6C3ABYbAdHG7MmN0dOLag+OGU1Q?=
 =?us-ascii?Q?8UZDb1NQbF9aP9onAOMytLKEqzEcz3GysigmO7H/aj1Or4WOrhEHvrWS2JEi?=
 =?us-ascii?Q?kZtmADVccEO6Pqk/ObbqT1ZkdvceQUOwBgvxyC8ZIz1/TM907/1RfU9Gn0q/?=
 =?us-ascii?Q?AbP1jJ6hv5n9I/n5mtNS6v8AVV3rqx9OA3SpgOpzmgPN+ZmEO4E2LMdxgOuO?=
 =?us-ascii?Q?4a6sJ6OenYhL4U5M1ZWZBESUg51n6FWvx+zfO0/VGZqvkYe6ys7NsJTCak+w?=
 =?us-ascii?Q?SbKUkfTMK6sZEsVr77XZC3V4XzaFDo7gaRotnfz5QkXw8RRXB4HD+WdrINnq?=
 =?us-ascii?Q?TNHSEolIfQhdDAjlOF90nRBZpmy8qXAt4uhxIoRXFWNg3o5XDlvTwHPJny5Q?=
 =?us-ascii?Q?MenGYIvaYZR816v+kEIgVo9Zn4zVM11oIqCn6ZWuGpZKqizknFmQpMnYOln6?=
 =?us-ascii?Q?2Mlo2y7k5LKMal8ZsqMLQcrS0uD4dtxyW/xB70Xq5vy2kYQv4IBEjcuBnxto?=
 =?us-ascii?Q?tXjNF5GRtbRGy+wbF8ciBimChwInaA2kYqGKnfsma5p5BSZJmLeqLSthIGkN?=
 =?us-ascii?Q?Z9KYTCW76zH+iyWCck7z1HeLnF1mXWOhqiGvN9hxb8CaL9LC7SFhwKr3IvDQ?=
 =?us-ascii?Q?r4u7SQN9Jq933Fsd8jeO3ETbkuj6CEbKa/JwLb7zsd9UMKgsi/4pcBchVf9u?=
 =?us-ascii?Q?fGUw/waB6S9Yi/yqPAbx3vaxF5tMRy0miNqGXlcm2k4e1tvJKZcPkwRNaeiw?=
 =?us-ascii?Q?WWiILB0DvuRPD6VpgQRuTg8YONuHvIa5FQjQO+RS3OdufBYhtlDt04Aw7xVK?=
 =?us-ascii?Q?tXeHJkT20LHvILUUvsQO4OuSE4QPHcbjsJwl7hZ+qOpiPel5biGLmHctvwrW?=
 =?us-ascii?Q?lIl4kDrmwG5e7KY/B10SyFKAYPwsg/GYPv2vnkUAJnq8qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ytaw1eorUkzXs7ZbeGypsMPAXg/BJVvjYIUkO3G7gArtHQsvCc7a3d/baKXE?=
 =?us-ascii?Q?TF67U9tRuGIgNPqqk82hqUhmwgDiu/1RCB7FAwroog7HkOqENw/W6kka8pKA?=
 =?us-ascii?Q?bIPirI4RBxfFSOkol6BJXrWu+3Owe6EpDWGB5EYhPboPyXcsEZKHKFcI2n4x?=
 =?us-ascii?Q?DTFA/AvTBY1+9A2SPtq1uMDS8Y1ajQVswmUCPLFxncIUN2+2R/Q3M6szSFcV?=
 =?us-ascii?Q?rVhEd8ltYpsMFL5QUBnQLE+Eq7sbA1FtlZ5ffLmojHSY1wkEZWGniLGLpxuz?=
 =?us-ascii?Q?KsMNZkixY4BYXHOyvPw5pIJW0v3bBM35tXUk/F+q/Iu2cTJbvYEiOG9/g/DG?=
 =?us-ascii?Q?gb69l/VFOxuOtI+Z4iIngo9CIFfCxpNEPqcvuTG+bkFvJE9Sbn97hYHQvfCk?=
 =?us-ascii?Q?jlSbQF2Z+NqAZtHe8wrgTTqLmQDTtKX5xHR6dio7MyJEAm62dwXj1jZ9EbKJ?=
 =?us-ascii?Q?ArtB+Vz2pVNtdnhUHm727XAMYHzZ5xGwIRJzsbtdUm7rjauPJSi6aY8s4caU?=
 =?us-ascii?Q?oDnt1Md8p1VNYPvyJTc7zMQk7QscTHIyJvuHCHyMoAy0rOT8yuOLctC+J1DM?=
 =?us-ascii?Q?jQ5Cs6Jf5DbCyL/hDLQBvLpupQukvz0uDmY9tt10x420OEBqgCjy0HE0JA6+?=
 =?us-ascii?Q?OE7eUMigT5b/IpTkiIGfCg7yvN8zWZUzzEOyTagS36VUe6f4CTGSMKVPMvfR?=
 =?us-ascii?Q?rbkiSbujaXEvOYRXS19QvBwYM3UmohYmrm7pyrliEuY13Zl5W3pf/n2JrJMj?=
 =?us-ascii?Q?GaQknB5jW9KZQpM7+e28LDyncmqVrrGcyLHQ00BlRIg3x/YPQX3WLATXw/Lt?=
 =?us-ascii?Q?Zt1MMDMQSeP2u5Go7dHfUCPQ3ZC1u32wde5hvp1uMVluaT+7pGzzYWnc45wa?=
 =?us-ascii?Q?FI+7Q2Y/5MXqi1+H5R/3xbEnDLvTUYM+vyJbKbLx32StGSmZfhYjwhRnyKQ9?=
 =?us-ascii?Q?kPF08Up7f/dgi5qIfx/gR1SDRtMou74c1r//ZAV17CstdhgQ9A4AJo1s0SqR?=
 =?us-ascii?Q?o/630VqRND87EzqvVbp+dpH1ZiTu/6PRTIK1CtvDBgDorjyoUBCtHV7DuXrk?=
 =?us-ascii?Q?g2I3fZ6KcNDlIIUS8xv6skkrQ7UxNtYXX7xeT6sj2iYhmat3pr5ypS3MuYeT?=
 =?us-ascii?Q?CELJEDAT6zkbWSM2zrRzCAlLoabYC0ksp3OP9vLMp7QgnwkO8CJmdQQtuYXl?=
 =?us-ascii?Q?zTccMu+2X/hT1jZtTqURBOw/zerqyj8Ip63S11qI/fSXlPRhJAg7nJs4fU4L?=
 =?us-ascii?Q?6ZjHASWr6hxpsg0zVnfKYT/c3gJKtd0jvUPnNbsjW3YPOlSIaQkeCO9nJ1iD?=
 =?us-ascii?Q?v8r4y8UAZ8lNctfiThSHs9d1q+vPMnn9YF+gg9QwW06p8k+Q+mTY94LUBJBS?=
 =?us-ascii?Q?TpxvYL20Fg2lngeKGES4TZNfyC9O25IzGQ/Umoc1TcCygn0BeF8r6rPQ+AZl?=
 =?us-ascii?Q?j6ZRzcdncDEYW+dLIsYFRskKBFuuoPVuNI7jV+ODIRvSdm6x+SBzFEj1lDzF?=
 =?us-ascii?Q?mIgWusRycbEHWwXRFrwkrgRbZOIquq/BehEbIFYhWIDnSF+q+dXLJ7j7mQt4?=
 =?us-ascii?Q?4SsQkbMPMgwsh3jctyosjSGjmaNj67rA43KgOeJ2Xtao698jBAOy4hZAn6R/?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QNeY3Gq1etDtbjp58yPnCyY4Q6eK5aKXgTI6RSrBc5Pr+TCU/+OkpcSfvpCCv4iOs11X5dljIUkT/ZRFtd+jmOKbCy6KuyExVWYwMtTjhGoGAcPZWnsfISTfvaVNerRD1VKvSVc3ej1O4WEnG+ckBLjPknSl/pAy8sxRuI8vZamCe1sIsY27ULfnNH8kb0jXChF3PlDDLpKCeCRQOgtuHe0KTDVrDeuqDOHkcAh25VVXXEXDNc10xIBqpTLR+gXKuwvtcPqAFttJaRpFiOEJrV3ojzOX1bPCju3V97eU29jbRtSjYxk5m/Cybv+k7GQ2MutnLvqsraojut5Nv1welWHtIJ6JPY7nbsIe82e+9E5fSacp5LuFVL4q/FOI0tpJcVGWTJIe0TvKG5mJFWurtG+yWV9AbUumn+RAV/BGEJMaM4c27EPNrh0ptUNXu6q9pHvdHvuCvdQlNis8UXt5wBbEusNIDSM1gNY9wZyYHdAfrdnh3mqgfFdbndyBBRFCS4/uL4fwJN0uPfDBOXKCEx/lNsYEzOVj1J0x7Kh459Wul7EZjjUHhIS14y7AuEl83FjrJCNrv3XHrsTf0WHx/5GSZ9fQUuzZglgCY6sAGVg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9375a2f-5581-4716-8dd6-08dd416e58e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 20:40:35.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVxGwUuZbB1fANQ3yNYmNXUeyrK6yG2xyftMk44rFsSSUe9mLtecAziszGzSGjkg2BCwLL+FYI+IqB/0Y+kQGiCQHGRdQUdbHyrvZMn7QYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501300158
X-Proofpoint-GUID: NZt6wwGBdk7Uo-SRMw9U-WiRCsM7ega7
X-Proofpoint-ORIG-GUID: NZt6wwGBdk7Uo-SRMw9U-WiRCsM7ega7

If you wish to utilise a pidfd interface to refer to the current process or
thread it is rather cumbersome, requiring something like:

	int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);

	...

	close(pidfd);

Or the equivalent call opening /proc/self. It is more convenient to use a
sentinel value to indicate to an interface that accepts a pidfd that we
simply wish to refer to the current process thread.

This series introduces sentinels for this purposes which can be passed as
the pidfd in this instance rather than having to establish a dummy fd for
this purpose.

It is useful to refer to both the current thread from the userland's
perspective for which we use PIDFD_SELF, and the current process from the
userland's perspective, for which we use PIDFD_SELF_PROCESS.

There is unfortunately some confusion between the kernel and userland as to
what constitutes a process - a thread from the userland perspective is a
process in userland, and a userland process is a thread group (more
specifically the thread group leader from the kernel perspective). We
therefore alias things thusly:

* PIDFD_SELF_THREAD aliased by PIDFD_SELF - use PIDTYPE_PID.
* PIDFD_SELF_THREAD_GROUP alised by PIDFD_SELF_PROCESS - use PIDTYPE_TGID.

In all of the kernel code we refer to PIDFD_SELF_THREAD and
PIDFD_SELF_THREAD_GROUP. However we expect users to use PIDFD_SELF and
PIDFD_SELF_PROCESS.

This matters for cases where, for instance, a user unshare()'s FDs or does
thread-specific signal handling and where the user would be hugely confused
if the FDs referenced or signal processed referred to the thread group
leader rather than the individual thread.

For now we only adjust pidfd_get_task() and the pidfd_send_signal() system
call with specific handling for this, implementing this functionality for
process_madvise(), process_mrelease() (albeit, using it here wouldn't
really make sense) and pidfd_send_signal().

We defer making further changes, as this would require a significant rework
of the pidfd mechanism.

The motivating case here is to support PIDFD_SELF in process_madvise(), so
this suffices for immediate uses. Moving forward, this can be further
expanded to other uses.

v7:
* Reworked implementation according to Christian's requirements. We now
  only support process_madvise() and pidfd_send_signal() system calls with
  PIDFD_SELF as specified.
* Updated tests to account for broken pidfd_open_test.c implementation.
* Fixed missing includes in pidfd self tests.
* Removed tests relating to functionality no longer supported.
* Update guard pages test to use PIDFD_SELF.

v6:
* Avoid static inline in UAPI header as suggested by Pedro.
* Place PIDFD_SELF values out of range of errors and any other sentinel as
  suggested by Pedro.
https://lore.kernel.org/linux-mm/cover.1729926229.git.lorenzo.stoakes@oracle.com/

v5:
* Fixup self test dependencies on pidfd/pidfd.h.
https://lore.kernel.org/linux-mm/cover.1729848252.git.lorenzo.stoakes@oracle.com/

v4:
* Avoid returning an fd in the __pidfd_get_pid() function as pointed out by
  Christian, instead simply always pin the pid and maintain fd scope in the
  helper alone.
* Add wrapper header file in tools/include/linux to allow for import of
  UAPI pidfd.h header without encountering the collision between system
  fcntl.h and linux/fcntl.h as discussed with Shuah and John.
* Fixup tests to import the UAPI pidfd.h header working around conflicts
  between system fcntl.h and linux/fcntl.h which the UAPI pidfd.h imports,
  as reported by Shuah.
* Use an int for pidfd_is_self_sentinel() to avoid any dependency on
  stdbool.h in userland.
https://lore.kernel.org/linux-mm/cover.1729198898.git.lorenzo.stoakes@oracle.com/

v3:
* Do not fput() an invalid fd as reported by kernel test bot.
* Fix unintended churn from moving variable declaration.
https://lore.kernel.org/linux-mm/cover.1729073310.git.lorenzo.stoakes@oracle.com/

v2:
* Fix tests as reported by Shuah.
* Correct RFC version lore link.
https://lore.kernel.org/linux-mm/cover.1728643714.git.lorenzo.stoakes@oracle.com/

Non-RFC v1:
* Removed RFC tag - there seems to be general consensus that this change is
  a good idea, but perhaps some debate to be had on implementation. It
  seems sensible then to move forward with the RFC flag removed.
* Introduced PIDFD_SELF_THREAD, PIDFD_SELF_THREAD_GROUP and their aliases
  PIDFD_SELF and PIDFD_SELF_PROCESS respectively.
* Updated testing accordingly.
https://lore.kernel.org/linux-mm/cover.1728578231.git.lorenzo.stoakes@oracle.com/

RFC version:
https://lore.kernel.org/linux-mm/cover.1727644404.git.lorenzo.stoakes@oracle.com/


Lorenzo Stoakes (6):
  pidfd: add PIDFD_SELF* sentinels to refer to own thread/process
  selftests/pidfd: add missing system header imcludes to pidfd tests
  tools: testing: separate out wait_for_pid() into helper header
  selftests: pidfd: add pidfd.h UAPI wrapper
  selftests: pidfd: add tests for PIDFD_SELF_*
  selftests/mm: use PIDFD_SELF in guard pages test

 include/uapi/linux/pidfd.h                    |  24 ++++
 kernel/pid.c                                  |  24 +++-
 kernel/signal.c                               | 106 +++++++++++-------
 tools/include/linux/pidfd.h                   |  14 +++
 tools/testing/selftests/cgroup/test_kill.c    |   2 +-
 tools/testing/selftests/mm/Makefile           |   4 +
 tools/testing/selftests/mm/guard-pages.c      |  15 +--
 .../pid_namespace/regression_enomem.c         |   2 +-
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 tools/testing/selftests/pidfd/pidfd.h         |  28 +----
 .../selftests/pidfd/pidfd_fdinfo_test.c       |   1 +
 tools/testing/selftests/pidfd/pidfd_helpers.h |  39 +++++++
 .../testing/selftests/pidfd/pidfd_open_test.c |   6 +-
 .../selftests/pidfd/pidfd_setns_test.c        |   1 +
 tools/testing/selftests/pidfd/pidfd_test.c    |  76 +++++++++++--
 15 files changed, 242 insertions(+), 103 deletions(-)
 create mode 100644 tools/include/linux/pidfd.h
 create mode 100644 tools/testing/selftests/pidfd/pidfd_helpers.h

--
2.48.1

