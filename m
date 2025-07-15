Return-Path: <linux-fsdevel+bounces-54905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F357B04EAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 05:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0ADA16A04C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 03:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A932D0C91;
	Tue, 15 Jul 2025 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="au1g+dnb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yCxgrf1s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C880B;
	Tue, 15 Jul 2025 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752549786; cv=fail; b=QRcTqBstiSe3ohHp2hu0FZdziDc/540rzc/wiAMbUwK9Zv2pN9eMX+/SWorYOD4icYbfKy0PgwXd51L+7r0HfDawQaWpN4NYBtRB7G+8OhG3nFzcJojHjwha3Xnm1k0QxdJN6gy9hFNJSLCthoSqEXGs2hUI0OpfS2EqGgRKgLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752549786; c=relaxed/simple;
	bh=r1B2oCVH2JXnuwdfA/6Z8A6q0z2OT7MayuTfQxpc5sE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=qVYIvq+ABK5lpJ0Dzxot+JGjLTrYvpABSIE1QRTB1hhpgbJUYkxShaqUk7DH50L4r+6NORMgjzbG+AX1xmXgZfD9huXVdI9srIorhJTYXxJ544/kuX749hMB8xEYG1CYalyf5IWGHF9/Nc21tutvnpARtQagNWUYVeG5cOhe6EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=au1g+dnb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yCxgrf1s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F1YpVQ027931;
	Tue, 15 Jul 2025 03:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6Zw4ItuV6YWbwz9hq1
	xfOCe8k1pe0Gsf7hpA2TezWZc=; b=au1g+dnbblq1VMTLynJTZdYTtdkhZCbSz/
	QGZK48HS+tQPOOtocJ88uN4uvgJUa598or1rk+3FCNDXJIriTPcDrGWruNks9HA5
	cEvVoS2pBd/Q8Qi+4hyLdtOuetzWNDAxeIIz6Ea1G2mHERW0FOmvMiwE3MMJRwG5
	9xRqm/ogQyANMt6KHkWL8CZpcxj9LIqRJVeQLi3sU4oyimOtAmtgx14RenKUNwou
	8/pnKFSkfABliWSBFk3o38dDUvu1GQt1v+11KHThamDuKa48/4iSJo2G9Paen1Ik
	14arh6Qn4PH0+tUjjdD+ShpcGs7bves/PTt8CI21SZCYj0BgKwrQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf645y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 03:22:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F0lBin010904;
	Tue, 15 Jul 2025 03:22:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59cc2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 03:22:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Plfvo0mx2VybRAKzfnJKQyKzSA7jEY1oqGrBl2IbutdBo3bvQ7l5Q4EwYw3UTqq3ymTcQ21ov450t6t3RDeXC4hTZNUMEIyZuGn17zGqjCcA93Fntza7fUzLmK3e7NvD/FDV/tAZFH/7z4Wlj49Mx1QGjNl89GkGaJQkgtvqlzA0J4vV2tuvEUNnqz31GUdTwtK/PE/px48fiHrwhgANFv2Jhz/onEIzjIEIAScxVAxHu7bKxiwifDIaZYAe4GjGc81GsQeHeisK90SEoPjBOa1FoUTJJDzBL4GSM7d8h8+4UeeqsdkHzJhN6tMLlflmd7i1GjEqZrXONipwzyhgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Zw4ItuV6YWbwz9hq1xfOCe8k1pe0Gsf7hpA2TezWZc=;
 b=jdVsg2FadYnnHWVUQnRGXIbgmLqJPjKOXHkQ+UMCdi3l6T095NCvnxN1UH5w9AV1HTjiFmD+QCicBSCKNIqF6nVhCk2UXDGq+P5WsOuovn+OMSzE4T+uth4TC1MJ/ebKMpnFq78BmIBVM8drTxo3IO44hfnNxLwLwuuBeTmRFS8RHuvP3gn9G1GbrtU9sX+dOSO1SoZVl2j6OobfgD1pE0yEoA8l+gk0Nqo/MCpt7WFNgJkm/HwQ2sFvd+SklYPop/iiwzcifa6dLzOt/C1tSU7nqlh2FBHfmWKPwdLLwTlkiFxUgq2I/GHmprvUQRBn8leXGGWUzFPaqtRRz/alcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Zw4ItuV6YWbwz9hq1xfOCe8k1pe0Gsf7hpA2TezWZc=;
 b=yCxgrf1scePxyDnD3Q1XlTS8eFpw1/IJgVl8oJaAN5B2nbqU9wv4OZ6T7DMm4I7nnh1+XXI6VBUloyfyBkmDK0c4w7EjUIXCNkY+18puntfnot1ROFfcd7NhIkPnT1nwkEHCPRausXmxUWNXRH3Puvm1Ma0N8S4WKaczvZeqxCU=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CH0PR10MB7461.namprd10.prod.outlook.com (2603:10b6:610:18d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 03:22:52 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 03:22:45 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Theodore Ts'o <tytso@mit.edu>, John Garry <john.g.garry@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250714133014.GA10090@lst.de> (Christoph Hellwig's message of
	"Mon, 14 Jul 2025 15:30:14 +0200")
Organization: Oracle Corporation
Message-ID: <yq1h5ze5hq4.fsf@ca-mkp.ca.oracle.com>
References: <20250714131713.GA8742@lst.de> <20250714132407.GC41071@mit.edu>
	<20250714133014.GA10090@lst.de>
Date: Mon, 14 Jul 2025 23:22:43 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0068.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::17) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CH0PR10MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: da45f12c-48f1-4e53-3afd-08ddc34edde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GrKgOiihUXnuAlk4wMaXZ22EdVOg8MIiEBDaz00bPRiIPrkOs3ltPWtjafQH?=
 =?us-ascii?Q?QmLqNI90A6ES7b7+bXiq+jxvkMcFQ5KheA+5X878YCapTR77Nl5LVpkDdYJk?=
 =?us-ascii?Q?gNfddmMhDCDPrrhO/vt+f4M8hd7TuXmQY6XhrQL3rBz5fB+2d0FzqHP6JKFz?=
 =?us-ascii?Q?FGrNW0bloHX6JY8jq1+fgZ6GflON90i9qKojHGmnHcYhaQJ2xpSfyv40/MLP?=
 =?us-ascii?Q?/QYHGcZOD7Tl/FhAlpO3JIo9W0XRuS6w9C5L7U2mhHdDoouXLn08jRMIFxxj?=
 =?us-ascii?Q?O4nPud0bhZA+NyLBL9olvc0OItEBkYvUST+hCiAN22+HCRnEmaQ9G3LI61oT?=
 =?us-ascii?Q?XBy9UqWRG0823eQYQfQ7tVHeWdpEPxzokdNdeEHn2SKhsoL3mTRK5OULGJ38?=
 =?us-ascii?Q?dKLcJPOO1zvuds00OwQEO7FKbX9AgAgSxuH8WJFQs4dklcc8dCQfCvJnfh7U?=
 =?us-ascii?Q?VtLddR36SyGQuToHIXToFPoMYF+TMi29htLx7A0Ig+y3g4hRHnwr4QER5a6C?=
 =?us-ascii?Q?gPeGSirD3k9j/5yY+QjM/cOPWRwo4U0JyrIiMhz16DHBhuqZOH7ZHMvW3Rhx?=
 =?us-ascii?Q?N7imwgUKdCDkYmtZSAsU/j6yR83cfYNbznlcuwaDSJMvycRetZ1MvUaeukGY?=
 =?us-ascii?Q?n7LRhZOgI77EJb28UecSoh/EGxTGSokHetO7nT/cqhCPbf8LZKh9rROu6onO?=
 =?us-ascii?Q?jmWXJjW8egnWRkpnLoiYm8vILxCrB8xCMXsWfXRxh/eGuvkUtapURxrCeOlj?=
 =?us-ascii?Q?NRuBUeAs5TKJgPAYrTq0LbjB4ZZXIM9Swd6afJcXH0cWSzOt++nIoP49vrSv?=
 =?us-ascii?Q?iAGACWbzRUT8uzqtC7GVjxg9zX8VXvtrnGLpOzjmeg0pSuPtI9tXPvUSAA6G?=
 =?us-ascii?Q?S2L73egnJiLmsXae2cAIO1H1L1lJ8qX9tJDI0wmimrezvDh1ludtem6rVOWL?=
 =?us-ascii?Q?aOTzzi3+Fyn2f/8csdnyIcSsYJf083JrtiQFHihxn3Wyi3TIidvCs4sCmOUE?=
 =?us-ascii?Q?1lHuPOa1Q/OsB5cX/oIXW35SZsaZhesAwmdb4ziMpfUy5UhzICQjY8oR0Uow?=
 =?us-ascii?Q?wrzHp3c1tH8bBHLxfSY8mtFcWOpjOeOsbdmsNdDo6EedXYK0bTQRBCmUEk4H?=
 =?us-ascii?Q?n9Gl3YFftTIbc9T38oDwBMSXDdiEopbR0/QWBIRD/u3YgKGYbd72+LY78d6D?=
 =?us-ascii?Q?PZmJYYd9sNRfvq361eTiqiSxmE0bwtN9hP+G9TJnEJjXEA4PnSqm7JzBwcIp?=
 =?us-ascii?Q?EYgXa8roomWqJz4KinX9CrTL0F0TJNsr6i/aNt23z5fNwvQ/8pKPqrrqA4zP?=
 =?us-ascii?Q?15GsnyVezqH9J/cNQlZHzL9IyP+le7Ubl7tEUl8/Pha9E7eLRVUDM936mvYM?=
 =?us-ascii?Q?nXflNtSJAJXh6BGZHMP5sjIIcWqKYweNIJFm4Gw70bUvJ7RAK1f8eW1yEazW?=
 =?us-ascii?Q?pr4zd9kznxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BbmDJ0sG98hYBaPNCX/4Gc3JW444J/2nmVU3Fk8ktiQ8e8KmrJVnjYNpjpo9?=
 =?us-ascii?Q?9ydZcyerPcXrWXO9SaVywtfqofnQWbY5d5Ue1jfxqHwJhALG+8dttZEC1OgO?=
 =?us-ascii?Q?o/v8ncLux7308xbSfNWNpTbOJhu0QInQ9ffGXadB1Btwz7nflfFpfOl68hyU?=
 =?us-ascii?Q?kJbMuqDY9C/jG/IEeovcnX+VlhWoCc/3XCUuTfS81z9RBV0L7ScHX/dUNfAE?=
 =?us-ascii?Q?MvXb03SCEanAD5qfGFJLxMenHki4yoK6eWgsMzPtogk9Q+gbg+KgMnAeZ/JZ?=
 =?us-ascii?Q?x9BmV0VMbDPXJckGVaO6eRfMV+5bE4CNgAPLM268IlfROAWTodpAvwN4oFkn?=
 =?us-ascii?Q?gb1oZKCDd5XPHTZxIxgKGPbFXTfTM3iWOaRBaZeMr3S+G2m0XRiRRC7q0u6m?=
 =?us-ascii?Q?n2MuTf+H/IqAoitgzKjrIGhss689MVTRgTVLcoGsFP1Ssh0VT8s4yTFMXodn?=
 =?us-ascii?Q?md2zqyRiq10J0pfBXnQqj7tpuZioDAE//WtIGb0sirezKnatLZ0FSeRAK+l8?=
 =?us-ascii?Q?2H92IL37eZYTnkJYe2GWbBILFoZyzdKBH+rcRoGQ+IwAH6CezJ7hYa5HY81I?=
 =?us-ascii?Q?vS5UU5AbbedV7SjG9BFlQc/1GGTJma3WcFf9YKuHrGPMtbGdjYbqTMYAtnaW?=
 =?us-ascii?Q?iEyqJQZBg63kwM8chqLDklNvxHyDg49MODuoy6bffin7343UnFmsIlBmOgks?=
 =?us-ascii?Q?M08qjkrtJYM5Cz2jMcXrWveK93a5uE6RcplA5evIqE3X1rMP340P+SS16LR4?=
 =?us-ascii?Q?BVJUO9az83huvtZKxIPBtnftxnSuErlPIrxv1g0OJmMkE2hv35b6qDN6hp6U?=
 =?us-ascii?Q?4sOm2+ZwJJkYEMDyXRRcgpxOhX+SJlqWsAm/seFegNArKglx22jnw3uXf7KJ?=
 =?us-ascii?Q?8l7IOf0pT6a7ckg+yACMfVjq2tI+WHMDbieaB5lLeyEGn/0WVtYd46T4TlXE?=
 =?us-ascii?Q?wEkGUq3pw9v3LKVQNdzGB8n2F8yS1t0sDoTJfpLhZE4ApYysX4htAlLxjS4H?=
 =?us-ascii?Q?ZV6ivGwF8mmOqKxRed/Nmyg0/kTC+aJw1b5RVTEkI6rnewu6xqMhiJAIbqK9?=
 =?us-ascii?Q?ak/kVFx8L0mIysXL4wi/dKF7kD268bGN9aLT+8uI0ZH15UipGzs6EIplGQdU?=
 =?us-ascii?Q?9+S4nAPwSX1CL0qZRnjvNLOLzosDok5cV5nzQjBWVF/AMu5ghAYyLODdCXOf?=
 =?us-ascii?Q?vUI/lHihX4SYmCxdvv2QeiCpU2lP6PqKKeS87GoinaHdzoo5v4Sh+Ksu96CO?=
 =?us-ascii?Q?Vb77M4Duw4KPQK8ebt4O54lLRCJrwOU0x79GHsQuuX4jml4EPU4w/lBJw8L/?=
 =?us-ascii?Q?46v94ZOvgB+GGFXzC3eHLAfpJSuv6kRL6Mt951Ny+q+Wl4zD2Lot92S3KFrD?=
 =?us-ascii?Q?KOvQ6SQJMzLwomfQXatQRV/GAiUDaxcjsLaYmx1Mf/KKBqWereWsYkWR3uHy?=
 =?us-ascii?Q?4aD52iBglPn60nzTU8NtMdBxPmgijTTGLf5B2S57wnV1fHEIVb8RM8hkTwpd?=
 =?us-ascii?Q?q3T/a8eOY8KD9Bf1QY7d8xt++fntSIWm8QdhXDu1epIP/MbC+jIpdB9Bj6tr?=
 =?us-ascii?Q?isBdlU+U7YPBBT+luXZm6saZzhr8JEIDPXHl5wbUDyD8rydu7W3HKp3NFNPI?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ymyrog92llH4+vsrPZyCmGmqmD6+IMANijv9e3iR/hn5BIXxpzWlXBg5deJ/MeFd0ieEeTFtP6a5kmiukRcrPQW64hVo1cVuURdpx+URnhsomjg1ZiTwC3FnkLsRLTzcN+/S9pvzMKnfEkykedp/xHw5ulh7UwMXFUqFLbr5pJ16kyBs67/F1dER9uJoNHXbOcROzzvvG8Sw4cDo8qbjeWlIOjzTELjNOASGSnoIkJCMEuIBlbuIjGKH7aVBbVIgYBPU9lowCRK8y1fo7bKGw57m9F6fqUqilFssTRbdXez2j8T5br1VCOnGuE/VRdDVTxoNGyE6WnpCP5IVvhYQ1aeYRUmaosrWdgqc5iZxBAf+0b4Z7Dcdv7BYdbmx5OrlwB3CeLcQF819GcIEWmhn3tjha1VodIgqF7fV460HxwlEWh7zBPQ/9PvTRg3QmVb4aLMfNrtnLJfp8vPnDy28/w7GOB1qmSyQhpY6B9nJidzcEGrdLT8DptymOTZ/fiEdTMPTLiY4S8sAPIsiGbn7GIc0CvlNKJPq8zARxRETm99nQmDhoYrYJ7DYWjDI3Hr8kSYFTgC5aLaKXC+UCatbLkYfVhhDmK6zdtcEBAMd6qc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da45f12c-48f1-4e53-3afd-08ddc34edde9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 03:22:45.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/qh68msC1rW+wdkP3QC7cmbG4WBsdC2F09lSSUH4euUDNdBJe26Yvdzb1MRXFb0RyWIm+tnco3tX2TnnlBtsoe4MtZGFe/0R8ON4YbB5g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=390 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150028
X-Proofpoint-GUID: se5hv5Aq5xV3VNxgqcZTjtVKDS1inxhG
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=6875c98f b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kLWA3gBXtu5QbDPQ:21 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=GYs117gn2OsVnTHolqkA:9 a=zgiPjhLxNE0A:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: se5hv5Aq5xV3VNxgqcZTjtVKDS1inxhG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAyOSBTYWx0ZWRfX98c5cHfFRd2z wZaWHl0/mibw6HR48txB3Rh3cj3P8BhUULEAs4kgXb7ZuUo9YvblGrFVZFmYRXDAFff0e5iRR3x mZD8ntbSjU3pSggGIfKYRa5V7ctiVOJ5+kfEhdGX/F/X5KYofx38CN7hf4SitwLoo8Nhll6/inp
 F0pimzmfMN1nlolLIv40EKLNoretWMciqlWzASs36u1U0YLlAXDfk2gGHBhhU7NuEuKrE/7NO88 +sv3jxOfJE5QZfNRkO9IU/MRIfQyWcKZW2xY68wUZeV8fG1Z9FSJASMc+kd7CWkFu5y1ZwnsfUr DWH3MxavL3WLjzVsusEjPpuKSNahYtPGUZ47ApEeFpAOewwbCupAGMqRQ5I1VREfP75LhiqoJUm
 r6nahpTrxpN/UZ0teDr6px4W6gs4Lmg2+ELfI/rOKkRBkKP3xXV0/hrxfUCLgFeQJHg51k9t


Christoph,

> I don't know. But cheap consumer SSDs can basically exhibit any
> brokenness you can imagine. And claiming to support atomics basically
> just means filling out a single field in identify with a non-zero
> value. So my hopes of only seeing it in a few devices is low, moreover
> we will only notice it was broken when people lost data.

It's very unfortunate that AWUN/AWUPF are useless. Even when it comes to
something as simple as sanity checking the reported NAWUN/NAWUPF.

For PCIe transport devices maybe we could consider adding an additional
heuristic based on something like PLP or VWC?

-- 
Martin K. Petersen

