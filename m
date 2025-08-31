Return-Path: <linux-fsdevel+bounces-59713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF17B3D052
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 02:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3891C189BBC2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 00:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080F81494C3;
	Sun, 31 Aug 2025 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qB2LE1SN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="McH5eGvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB216F9EC;
	Sun, 31 Aug 2025 00:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756600839; cv=fail; b=lbnMfjSRt8NQiKHMWiMq+SFjOHt2Yc3Gb/C6B0T/TA/uD5lXp7gZQT2JkcROoWLA5jDa5+L3wEeIA7gQDWJbg7AiG7iCiZYFt31sO66InuynKuZJPhipLGrhWbAMxWYp19ha2yt1tnSLg+ZI5EGkK9yJGs4HNjnnrQ6woVPmba4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756600839; c=relaxed/simple;
	bh=1Vv23sEMP+YDrjhEa8WeO+1xKWkA5vpbYXR6hBzq5VY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ij7Fcqkr4YnKA9DFNvuxo3oDQ2wr3Fl9wl5I7PvG+ejJtI13m/6Tw7zE6Z81ASG5U9+OoCbQ8fJf/XD53/jeSXanErX5vGa8+wNJKrZYqmXWQyFqoimMuYabpUV+Vad/1hH+HG+AKqGz7wX5qsIQ2vK0GNujN1vA2emZWr6NixQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qB2LE1SN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=McH5eGvM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57V0CwMT009231;
	Sun, 31 Aug 2025 00:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Vz5P1AyyJhl0WjOwrY
	BlvgJjSBmI4WhaNApxaiyTS3s=; b=qB2LE1SNS9slPtjzRjGuTIOqTz+yJthAho
	R80B2lmW/6u18GaCFCItrGwVQhNZXnuTRfpte1Sf2mE3ObvIBWEdT+J8mnS8z96X
	GA2y6Zz9a/xGPMoaFmyWGOnxBpwsSRnIE6yzF3z8C3O8cHFBRAjVsYME2PDUZGz/
	zHGUBAyHulxkcyq5lopTNQSq7PrYcn8T4WhliMqz3jqtgCrcoBwgnhk37zztI/Xl
	o/lU4mBEdZe311DG0SDe6UhJlsLR81ZVnM6xdIorydRxuDxC8Be3nGad0pJNeded
	4mptoBD/m8sw9t7xhhxzLGPz0sDB5/zXVpEoSlMMaTHIQYVZNsjA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgrk5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 00:40:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57V0C3LM024822;
	Sun, 31 Aug 2025 00:40:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr6s05e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 00:40:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPoC+oJX39ZqRiTRE2HIe8VXNVVAlbsQKvixR0FV2H1uVCbVNr/ZkX3U77g5b2O2gP9o3UTdXI6I/LAsLCoyLylozzd6P462K3CsL9TlieEi80NN2lWWyd2e1tO5x5WmgsvXLfvx1eELbSfdnUaIaSBJjSuhgQ1MB1lmNb45BLhi3bsvXsptdUq30CSqHrM+X/DHVzlaf9et5lDEg2KzKsTzeCjbHVx4ZNLMG+CBJYl3VUtRtEPQ9Tl4sRBgUKX4VrFJhrkjenaUeRSzcz22qWN0VkaTqigd1F1sZ2GeX5sSFZoSqw+3r/ZRPG8djeFxTbw6xL/t9ylhnNjeTqYKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz5P1AyyJhl0WjOwrYBlvgJjSBmI4WhaNApxaiyTS3s=;
 b=MWC7aAC1GE/DMbr1WxYl9RyZnOLaM9TtBk5zQURZD2J2DDGG+nz5cZyl1eGrhJTpIo/fYfUanS6i8NgvJD4tb0N8noYuSDzTBepwfsJzHj5Ptkd2rLgLZM09iaGcfXyuVL8895PgVHc6GIXldHTLKMuRPhmcYUE58v939cMn+1GlZFRtC5dYkGzDyMfhgMSTOlbLIG7LBXBP9/P9T3+yiawCITddLEN61RR/xg/1gTmXU8iP/9xtef0j9UhjYdii7Qr8PZsreFvn+S22SjSuG15u5kIR/mrHXEAYEun19wuclMhBsf7OydVJcppkvzI044TUAdZBOW7nWyrNEDA6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz5P1AyyJhl0WjOwrYBlvgJjSBmI4WhaNApxaiyTS3s=;
 b=McH5eGvMoIpKmT0asGhpDYp9cNEdyJpukcyb4Kg3I3WW/kbeAOGEOfdGJYo1SUge5YY2TcRCIVHxf1PklCy4IrAUdaFSXT4+nAATIv0MxNRmWuizOgJrQasxSJq1oP26VtD8Ul5YAztMNbr1JHTT5u6IelyaDiGTCc4ppnfP4G4=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MW4PR10MB6345.namprd10.prod.outlook.com (2603:10b6:303:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 00:40:25 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 00:40:25 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <hch@lst.de>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 1/8] block: check for valid bio while splitting
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250827141258.63501-2-kbusch@meta.com> (Keith Busch's message
	of "Wed, 27 Aug 2025 07:12:51 -0700")
Organization: Oracle Corporation
Message-ID: <yq1plccgw7t.fsf@ca-mkp.ca.oracle.com>
References: <20250827141258.63501-1-kbusch@meta.com>
	<20250827141258.63501-2-kbusch@meta.com>
Date: Sat, 30 Aug 2025 20:40:23 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::9) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MW4PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 36711c03-5aa0-4cd7-a354-08dde826f9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4TLh0NjehC9b39IsITzx5kI0ljYU8l1o2udgR9ndEXgsNDn34vGNZLrCl10L?=
 =?us-ascii?Q?KQLRsUdc5fONHRdSgraKRT5WHW4tofyGlNE41y+jj27b0qpR9LIEwByaW9CW?=
 =?us-ascii?Q?xkU1tyPxRzwybBDkW0livceJ7a9y6o4TB+dSVS6J7mFPb78p5LclvnZyNFWa?=
 =?us-ascii?Q?r966r93E9JBxDTmjiWb3sbLUKd24XgdoN0rHk2v0VyauzrwMGGeHyT/0YS4L?=
 =?us-ascii?Q?WQDp1exkFohXzHavadY2cBTATB84hBQhNFnjD3WE5z9lF2ooGiYWLMG8TzFU?=
 =?us-ascii?Q?5TQZ6uq4ZuTYZvPMVDl3tYz3sd6maJg+aTCOUOGcpoyLmZIRVYtxKm4A1hv3?=
 =?us-ascii?Q?+VZQJbZWjmFILLKTwO01i4bAXilCJp3J0V383xVGWgXm/W0xfeogyPixfwCu?=
 =?us-ascii?Q?F9/W4RlpszuafMo6z9TVeJ0hk26uxf4kUsnYIwTg5LSyeZgObNH9YzLkUQOn?=
 =?us-ascii?Q?IGyEGuBqPnziqPt275nEYf6WeKGoI8isN6jgWjn3iKlUzfcHBdbp3SaE8tEe?=
 =?us-ascii?Q?am4rawk6p7BbHJaBmgEW2AQARLn7w3r1Z8ygyKF+go7BwgfMDMwZEMBEwgai?=
 =?us-ascii?Q?Y6bEZV7ghDpK031ESWPqn3YYZmtPme0roAR0PMw0lM+FiWNQovgpkUJUaQBr?=
 =?us-ascii?Q?Dx5ZtABBVm0qP0U/jssevO8tjIzPm6dulS5Vgs5fvxHsCxlPBBO1PZwWubed?=
 =?us-ascii?Q?n0Xwdtxlktav0J3Awn4KsYirR78rpFrYzX+tFYftzdZGaaQeMVckeoPtr9vi?=
 =?us-ascii?Q?W3hZSd2VUYdxFOo61N4MP/MSG7AlOcrYKEuJTnqzNrX7Nk18RJowLNuwDjzH?=
 =?us-ascii?Q?1U7dhXGNxTr3RVeDYrS5tMmzDA1l51vlj/3OpwhFQ33lbtFPTE7sX+7s+WYR?=
 =?us-ascii?Q?nx32n7lNYALmHvra6yaPCflqF6RGJg0R98XvBijSETdMv5hDrFWa2lzUn6qN?=
 =?us-ascii?Q?FAYcrx9aho+DbKibME6D/WkzspHCtDDFQQZbbzq33lF+26eAqUdJ8nRuEqQs?=
 =?us-ascii?Q?BQMUxlz63snbX3/lqvHKHmCFfegezAMn1XSAQloi/QRLGlWP6lxA8VZa8wOe?=
 =?us-ascii?Q?G2Q3g/vALCH3mxTR4OQb9/7xZUnXGBPb7C9jsS1W0CdWK9uRJsBB1SG7/Oz5?=
 =?us-ascii?Q?5wQuxIHnxwzglQP9lFihCrcmE5ewjp99VX9Z91IeU6u9fnmyTPeqd93kTYw1?=
 =?us-ascii?Q?uaGBMXIpj+uLp/NM8G8wsgZjhlu9EkpHgka5BRiN7zrZUH5xGvsceoYzVqo4?=
 =?us-ascii?Q?TC1Hkusdxwz6VBIhSW0tuDRtxAISFtTZkfqFBaHK6p5/k6zWyd9KBb7L+FFN?=
 =?us-ascii?Q?7lCjUyOEJQ0GkloKOvOlK4tCA+7E5ejbXwjiSaE1bNjbW94u9ovxfylFtApI?=
 =?us-ascii?Q?iZZcq1KchyhL2RgFgTDwhYJL/nc7XcDZE8u+0b072dKG9AxbYsYrDPU0ouoY?=
 =?us-ascii?Q?BEBlJU392Jo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uBU67LdHG3+q9Xro3AduDoPwICLmJVqKh5fSBaFTn2JuCOwwD04iMtyXDtDk?=
 =?us-ascii?Q?p0z9EnQqEgkOkAYVdoYs7mDejyPjEqJjb4B3Exm9ruX0BzVmGdgMIo9TgoB+?=
 =?us-ascii?Q?ngqOIggbUnNAIooDW85wbXU0SpevZvC0supF3vERblHYF90rOdHOa4DF+pC8?=
 =?us-ascii?Q?0RizaMfZRUEtCTbb2Tbk5+Bt2Y7p8mRPcvc7yFB9TTfp3+pbU4JFChnXZVrO?=
 =?us-ascii?Q?c4VHj8fffuKNV8nM4/yAGQ8XotlhmcclAFhFWE9RHQ81KBmqJKryjJ3xro2n?=
 =?us-ascii?Q?FkEghmXfK0K2Hviuotm/jhXFfh+ZaoZDzviZTVnr0NRIw7RMsgwyrGfAJi2J?=
 =?us-ascii?Q?foUgknXnAlaoC1PrtmbYhtYOKUJOAdoVGIAKWujB5nP6Iyc7hZOHdZ8EPPbF?=
 =?us-ascii?Q?6LJdZQgjcQeGKvo2LRszQjDWbX2OXrE9WQ7h/GCwv7UfUNRZYbYrZe/PsxHX?=
 =?us-ascii?Q?5CaKw52Z1T29VNFU7VvptS57LURRm2RAL9+YmG1dFH6Egwu8Qbs1g3m8oBoV?=
 =?us-ascii?Q?9kmS9+8h7Pmsw9Yn7+PSyQfRRDwDu2u+CEN9eHmwimXOEReFx/R5HNblm+8D?=
 =?us-ascii?Q?K/PhKOBCId7tQVktWfm9PUzxi5nOHgCEiW3jwZrNtO4YBsfGnP/wAL+s1IeQ?=
 =?us-ascii?Q?4LauDjsMQ/RqKoXP7ypNjyemjm0hsMzOy2HphtCLEZ80fwYu9jkIRB2r07xF?=
 =?us-ascii?Q?t1cRdv/zwVyD7ccgar6DPuJruY1G0gi3x/Empuuuq+hg6ukqON9OqjRx3p3H?=
 =?us-ascii?Q?L8g4eZHwnwyvrtHqTOA05sYXx2CSgDPqfLEXuhCplAM6jzDBOeXKqpitORBI?=
 =?us-ascii?Q?lmJKoNdgrAfj7DgWTaLqETmN4WF81iH6iO5fK76lZVAIWW6XvB3LCtGjRuXy?=
 =?us-ascii?Q?w19cJ2U1oUvGDXsMShGp02/5RUO9tNpc+bDilh01qMxfhJ47TEnRl1uoaJP4?=
 =?us-ascii?Q?1Hycxu0Cq9sl9PXVsKf64I0QdAFeB7m1QTqi2sWsFu+QZrBrMri1Q73wX67P?=
 =?us-ascii?Q?WASoDpbTqvcLuuXB0JIuPF+3iQKbih9OBe6VAXUlt1WOo/gcRDkznfaGIIR4?=
 =?us-ascii?Q?aEkQbRgtgekCYQgIhX0OJVAlzjpeZuKy6ZvQf7gzCw8SccdKWgGvipNUiyv4?=
 =?us-ascii?Q?muJmHy2ggxBxQhkB9r5axFe3fBSEWkfq5/7h1qdY+LCiup6dTaSNzJLdlR5W?=
 =?us-ascii?Q?32dCkq4w2BCmm+guYR5aO9pnSV4i6yGoT0NhKeXINjYefgNxVMyUMumdApBw?=
 =?us-ascii?Q?8emRHlU8Xx1kfXUwAJGG390ZLJUDm4BbYSXxA+oN5QI7W5yOwG0qmgRIYvKY?=
 =?us-ascii?Q?TNUKtOfM9tpbz3iqxIFY3UI5GfeY/jmOkQwiIxP/sqx34ChMdDOEsC9ICKny?=
 =?us-ascii?Q?OfhRiALRIXuJoJr6xubrZ7QDtd3X6OnokpZWKWg4fJPrPG6Ui43d0sIC+1qb?=
 =?us-ascii?Q?r7P0aSSIuIC1cLIQy1A2KcpsPX5ntF3ByulnHIGIPPxpD1twSbwH8vi6ZEMl?=
 =?us-ascii?Q?2p3Am5o1Htl2z1lA65KPiJ2W+Hp1vRQbQZ0qMLbr2jzDg2XSE1Jcqqs5ZiET?=
 =?us-ascii?Q?+g+gkGsZW877c2lKZTdXEzJJM0DEAD7P71mzEJPDxgv36pgGUQwN88CQVPnT?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/fs9I6kWBNBHY/BHpl+KDG5aXMcjwQVfehJIQ5lODceVa716aVtJc89aDVg+8oC6JPkzZ5IEPPSddES0O5DbyGT9VafiGJocdXivs5ssuhY+IFutWx7tlZOUb9LSltKio/6GoD+kplWwNyrJLeTwhryNwzQMwbYRQYZAz7U7a7jVTWBiSHwva8jIFKNJZUbvTj7WvR0DeedLkiXxvx+M5y/MyIYFHieEc9KfyFD6my7FoInNhY/fE22kaBlSUeuIGHccAmqX+oUVkA/Cl+Rx+sHR7EMCCWjtbxGE2CPT1zYK3BF5Dj9U6E/CiX8kz7RRe6AKiBagoLclHFMGGNINSx6sdEp9O+vHQqnHwTNx6cp8WRtyn92ImT3J8KeW5+xA/WBqZRwbovA0fC2DhponeWOjhaG7zB8FKa8BLaZXaWJvEj3lkgCb0DLAkAoENdFXks4HLaKfcbUCPgEpUjo4Aa/IDJAaHDW5m9vbzSHDWxS1FW+6Pamn89KwOEqsKtfHRQlSnFw/9OHPnsIf3YWFlx85xj1ahbQ8T4dxBIrNFItpKyFA5mxWlYd10JKxr0WDPo4qFFLN72EN0GdHHGaikG2Cqy9dZgxCYjmupy4QIF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36711c03-5aa0-4cd7-a354-08dde826f9b2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 00:40:25.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: debH1b9jHENWRDpMEtECC9mewCzRj8i4aZ9+ui8etsrRSol3DeFaHXYvU3OCGyeRXEhXrcb3cOl3s9iIEgMRHNY3198kuogAmDy9AHanWlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-30_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508310004
X-Proofpoint-ORIG-GUID: IHViB_xR68mJ01KgZn7ty9eN6zaE3iv6
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b399fd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=MeePH1VQSlUQUWQkWtAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX5vckKXJao8Un
 sKIfourvIs+KSBvSXCw+K7dkaVasdWp2m7Mqytnu4dqSbHNccjigPEZqB11BSOcKbEHBggZM577
 B8L9lQ0Tkf9Ch/08RMCrfq8pJh740DN0Vyg/2HSZb76mNgJD1V4YPTKoqgfyU9NWt4ELA23AA8y
 K9kOM0KC3EztPlZgE7LNIYaMC17iTQZILXwThRpYc2AyevWLv0FtrRRHTbXvDYV4pVZfZQYEyaZ
 tfWQ27SZ4qFga7crlQYqGt3jmPxLifdbk5OolipiLOerhKKgcWz8vOOJp2ql+ee8adoJAPkFceX
 1N0G++yVciJXJmnrq65KVtEYzHe3THqw8dg2PS4OlDJShlYx48N6RpopMQEQaxyduV059j/6uIq
 cJSeKaLo
X-Proofpoint-GUID: IHViB_xR68mJ01KgZn7ty9eN6zaE3iv6


Keith,

> We're already iterating every segment, so check these for a valid IO
> lengths at the same time. Individual segment lengths will not be
> checked on passthrough commands. The read/write command segments must
> be sized to the dma alignment.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

