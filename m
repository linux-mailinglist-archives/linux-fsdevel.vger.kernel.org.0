Return-Path: <linux-fsdevel+bounces-73234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0700D12CAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E3DF3008994
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958543590C5;
	Mon, 12 Jan 2026 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qUYHC2bA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bEIKhRH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C432A3C8;
	Mon, 12 Jan 2026 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224509; cv=fail; b=ZXi8ZTRKZ7l5CTapr1UeIvuQo25fdIo7ohRZVU9L5GYpq5p3jid1HoN1bz3sxj5xh7savkUfBUvVBjukUJ4u3aJZ4apeEavdggOiAyDye317Wtjm/UttlhANW+fi5U+3m1QWf/nEE7L+eJK1xKQ3YUvWRbwBi+rkHSQI7p53iMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224509; c=relaxed/simple;
	bh=/C02l/6dw2UOieSUZZx/8WbJqA+M9PVzIfV1G/0Qho0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X6Bbnf5nBLbLOFLJodSSqhq+1SwpboE1LUrqyBilopCzjxFW68PnymUppioadXhQjHW/FRBdhA+nXRADtJjrRvKk2LNbtjg5QfiXgcn+2c4GdXXqqVLSM2y+3W7GvmXMJUgIaCAYd4BO1cHQCjk03Mmxr2Bg4afsCUX0d3ygl4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qUYHC2bA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bEIKhRH1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C1RXjl346070;
	Mon, 12 Jan 2026 13:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=giQUPoB9+KnnRpn2IM
	wnI5yXPgcUkUqAXVVp3SG5r2M=; b=qUYHC2bAE9vNy8iHfyhp9m4MFWWj4ksV1S
	7EJISIPftdFxHyE6WTpMrOOO2akidMYr0n0NcAcBQPoUa6jnM5MGuLSjNL0z928C
	t56KJbLwj6XIPQcT+uG+IhaSGfxYTbLSHlL8dhPgpZncGcuXf4s+HHYV0YLXp22d
	32TtQJD4Inv2pnvy317mOqzjPkHO1YaxqBTUqj2OyTM/m8nOf8iyHc+8Rwhl3Ssn
	/gOW0x5eDlgQfCp0vqwYNjIzbXMZ1VlWr4FvXDxBnFQZphS51QLH07ifXT/b/bKy
	1JzQ2l9CQbjmjFKMLfPiTC6Ow3kGREXyGpzYwh1fxkEgARXKxKiA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrr89k61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 13:28:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60CCDVPx035374;
	Mon, 12 Jan 2026 13:28:18 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd77e19u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 13:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUVOPBLxlu8dAZ1vqydJNXcXzrlHcVYEZIyAuTDRIKMACxeLzws3ec0khRvfWZGcPf9AFvvlbSo1zsa2/3mYX+vm9IJiICbV3eNhZiPim6kEwNZeyk9oGvNQycyUZ8khgvUgf5ETmU1MqRIVJDO5+7hp1j5KZwV8MW5sKr4UruoTbjC2K5t9PdT8+h4eqUutZzxVM4sNR8EH2gRgOnZhouMrdo0GlC2YsoXPOT2N8kaNXerKIBIcxK0r13RSvP3wwl3Q86kZYlQXlUpmoJOUYOEZcNBsZjPxCo+McS+tNwcIuCaHKQR1vLamFN0d3WFYUL04v8ALFVdr3dwQwGvSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giQUPoB9+KnnRpn2IMwnI5yXPgcUkUqAXVVp3SG5r2M=;
 b=bLRzEJskc/W1E3Q54tNzWLvcKZ0TLXPrSW3H59K8yAsTurcl+zTHQnrHja73b1AQm35ce9yEsVmNEpFG9ARNIAlsqjPnyhU+uL6rgogGL2La3+2SypB0BIL29xmqgf+nnbJFY9da/6YZ8GxOSnDMmtxr2Fh6GYsDFTNwKhxtJ4khG0TYfjzWpiBAQkGByfzdYeDuUhSYdwi829AC96HxnhUxn+3GApnNoTJWN2T4TqDXloX2ejDyKuJW8VlKhyu6DE7c3HLkg4K1bpWrFkRDXdctuv/hTOUxZEDpzLM7mw1c63ugGHCHotrDCLE5ruuW737pwDQULHD3/dK/4oRb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giQUPoB9+KnnRpn2IMwnI5yXPgcUkUqAXVVp3SG5r2M=;
 b=bEIKhRH1lRuseaiV0z0PTOs1s++VERdfApEUN3fu21m/RR4zpFAWSJPdSyJneeY0g+PXCX2aqwCmJgM+lZdR0/MxszXFPz8DmvOOYcNKIDK+RrzRsU4i9Y+g0YmQak9fxOB/hk4wwpupBWlSm8/SGvWvoPysOYS9TVzfAji0z5Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:28:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 13:28:14 +0000
Date: Mon, 12 Jan 2026 13:28:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+bf5de69ebb4bdf86f59f@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] memory leak in __shmem_file_setup
Message-ID: <654b5d28-5e1b-4773-aca6-ef650fdb0e60@lucifer.local>
References: <6964a92b.050a0220.eaf7.008a.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6964a92b.050a0220.eaf7.008a.GAE@google.com>
X-ClientProxiedBy: LO4P265CA0271.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbd7f2c-22dc-41a7-3f79-08de51de702e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hGZaYPuvlfnjg2EE5DAeGnfwmX4+oiFu5Wwf4XV8zcMe8EW1234qScGJD5Uz?=
 =?us-ascii?Q?/MOSR5P5HC4cZbAGMQGrBGrutulAGwBqIoDk1vlbrkz9kfBAuvkydh8XNc92?=
 =?us-ascii?Q?kL9OHIk/iTADnQZSwV7/fFTWjibj1rQc7R3e0COP8K3DmOtp5zCQA+wU7e1E?=
 =?us-ascii?Q?gu7umL7jpw/M+/p3XTnhtrPx6ntNwCo+UqoUNfI9/F7QUESLP8yW2PZnSasj?=
 =?us-ascii?Q?l55eUhULWB26U5fFDOjg7vIteTl9mZOmPK2pBPcRqUpR1dvCc8leoiynHXBl?=
 =?us-ascii?Q?9ujlfaH0wyjaCFbwRim3d2nbUKwukZHpmKu5OHoNb1IZQ96bCUQmhxLBfTeU?=
 =?us-ascii?Q?bjvn50dr0g4tMUYj73AbxhRjlJurxnF62YvnUNrpmuszGdGrQ2ZoMoCn6RcK?=
 =?us-ascii?Q?WSzxUWVuAiuZ0FnLpboZj9TZrIaO3mhIyQTcEvesxeaoMlMc9GMpHM1OHRZj?=
 =?us-ascii?Q?S+IcjxhJbKDL30XRxndEt9J31mgJgONjwzDTmmQb3h3GjpCOSSAjvYV8wAmx?=
 =?us-ascii?Q?mw6HgXudpsMupRKsU2QOoGgX+VGb83Gtm1maOMeYSVUGnagOUS01PFMo+Z8I?=
 =?us-ascii?Q?RBO4PB2fKE4ORF2CkS+QKJ11E3ofQldxLBCI4XNlRpDU1GPfvkSNLcbtQ8kH?=
 =?us-ascii?Q?r+kL/p8NVqAFRi2UkZbJtILfDsAOCrgmPOfupHzHBlBc5eOOd31nKirN9v7O?=
 =?us-ascii?Q?wM9Va/muM5w4FzJZtF3IeARHe9l9M+qBt6Jxc1cV/pot6vFpswcJ/OLocqwR?=
 =?us-ascii?Q?27q+UU5eBEm+WULBbTW3QJH0CJpENMYzLUb//m7Jl4PMWzbx6Wu+/fBwbfeC?=
 =?us-ascii?Q?luXM1rt54GqBu1s+lbXbrTTH/0o67TWEL0nZAnleA3T43rqiaAZ+ORTent1T?=
 =?us-ascii?Q?ASj8NmxG2Hs7nYvqPqsvWFVCAHKbETNXCca9lFSecopISY8nl5WZ1pIoSymu?=
 =?us-ascii?Q?HBkAhCzS2zI38UjJc2I8jqlcgATzyz+PPevsDgt58UOIfLQmsfjNy8dAFuEE?=
 =?us-ascii?Q?has5jDYP8zTn4dktFHHfsYHHFV7rlAjpVQJHUOdd5hQHH8KnMFpH3f6g68Aq?=
 =?us-ascii?Q?lOLcJGrsXrNrgmR0h0/tA8AsZfUbYs54elkfMmmEYoYi/vQM0QwS94SeGUKB?=
 =?us-ascii?Q?qts9ynikP89VfU2Lh0EdF8wRbwLB5M80qG5heXNzW7vwx6qpxb0/6tGP6leL?=
 =?us-ascii?Q?iuLTfWx4e+3R7wHNGDK81gDsweC+mATpF0KFp4Nvti0tQH62QIewdnQ764Q/?=
 =?us-ascii?Q?mW9RO+o+tGbcUz4L2uRanXuOegiH0cPJU9zObOdwDTOc3+8AaRD3gtuyytyR?=
 =?us-ascii?Q?KcSLVZDVxzylmXP2KJxuat52GVA4G1rO4bwFo31dVP9k9zYjE3aqW8hVrlSV?=
 =?us-ascii?Q?w3gtNXS8q9hVp5w6k3pukh73+ihj+KRDIwl/gujCdLaBgV78aA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dkS7HwDW8g12qJgajDxPnWUBmLS5UU1DienvftxDulc+fvjAl8O2STNBj39T?=
 =?us-ascii?Q?d+VTZxmtTZaGCKpQIaFyhN15bKdL4ZAjfLgbdfFHtl5ap6pdoHcUiav+wB2b?=
 =?us-ascii?Q?/NV7/WU/t2M1UBLdA35KtjlvcIIwG1/sVD5c5PrLOCpM9L4xQ7zVaJxnpFZK?=
 =?us-ascii?Q?d+sF2OUjjm+h2NyfEppQAHREUrIc+52WWW8c2aJpPNDgxVwCoQjZg9U7pPxq?=
 =?us-ascii?Q?7DzuiaRm0wu3cbs9AVgtzSNZXgbu9klIrWXuKnWzudnnvSDfksX7rOACcBny?=
 =?us-ascii?Q?M8wrwmO0qMPWxjaLM+sgRaoKQ6AHteYRrRQGffRTpxIB0ey7Rxxdu7o9uaP2?=
 =?us-ascii?Q?V4lV44iSlRJJ7Xn2QShje7kpGrc5QJUtA0pQtd/DHr5DZiKTFaj5TJGPGvm8?=
 =?us-ascii?Q?MVmublGvqXfhOKQcECraKTpdeqZKHycg1QRE4lkcemTCUzVEs8lDHsBMz/en?=
 =?us-ascii?Q?acNeSbK38EgXZZNy2h79NUgj+uqrsGzeOZCzV06Cuvxk0VnX8G7k6Q3rPXDe?=
 =?us-ascii?Q?cq5Nl0DdZvuV6pzkYJBk0IcuWFUhf8+225EmMzBdoDmAhHbx98//T5GAv1qr?=
 =?us-ascii?Q?+K92gkNR1yWIde/Z4sHRCBXqV8E0/9II4lJANO2zON0cz06Z5iyv/URGK4Ed?=
 =?us-ascii?Q?sR/YvYhwjCbP89D4tbxi1sKTmQ/vCWnWY4BYucOB4EBhgTeCEPaWo41zKW8Z?=
 =?us-ascii?Q?avGoOyASWrvq1GL6H0Tjv2KLPUiIlFjGkqKovHZxxH3sCuJLBF2K5vVfMQss?=
 =?us-ascii?Q?uoM4jveZx7BGPF57mq8caTfYgLbrcEIul1Qo8pnw9FPNtzjKU9Bumr8fhu+U?=
 =?us-ascii?Q?+5hzNfWbienuS3Dw7+i03OWv7iqiu6ePD6I65TzjjxbxtuwdzT81ykxfXPRL?=
 =?us-ascii?Q?YmBIDd6Jsxzjrogk3eYGieGsoYJqvYWJy++rpsgyET0+3Qpfh3Slf/skSj34?=
 =?us-ascii?Q?Knme6acRn5h451dsaeylSNDsGdosjxp3Mp0x6pgDnUE2xQboitPxb6FiGM7Q?=
 =?us-ascii?Q?3ml1ZwAJz6gdRof+RXahj67T7BZfR0ADjuPNVxEzAMAJ1dL3fH3kL2XSK6vj?=
 =?us-ascii?Q?x6tX0zhMiUgc0I+lulTpOX++zD4z9LzbdriV/vTayMcQrsHVD2Z91kmbeO7I?=
 =?us-ascii?Q?7DCFdziCt0qjBu9WmtaYStkRATeUxL87Z7sk/SXGS1OMmIyjC3uIuB4Dzdkq?=
 =?us-ascii?Q?EtCYeELxb+sWg96XPI3Fupmc34SaXogygkOd0789oc85xacqADu888rMDele?=
 =?us-ascii?Q?mHyNyULY0iqApfR66XziKQOreuPBOtey0MEpAbbB+fgf9Gpi6D++gFPpfwWy?=
 =?us-ascii?Q?ERexfvLON0hyvZwVG+QE7mXBMxdvjoGG0R4fMEt+219Sg0hfBTHkalGB1nbc?=
 =?us-ascii?Q?OJR5Vmj4y/WWAnh5U+s+5JS7Rv+zC/NrFY2qlUswQj42oqqyI1jswV645DEP?=
 =?us-ascii?Q?iyIC7WwxYM2YDfS9QgdMPrC4AAg1HHA+ErrLfheNXIlI1UeYkn+SkcIKjpGa?=
 =?us-ascii?Q?ACjABnepV41C4pywyfpt0blUs6KbjrzCwnwY+SsvQtJSOW41dp34IW4mMFWB?=
 =?us-ascii?Q?ECp/q6lpRUqc5pFXdQ6fJoeDFEgreZKx3d9IQ5kUvbX3dNFRqQDJ9rM1KoKg?=
 =?us-ascii?Q?/MRA9dcCCWiC3mJBlW4F+JRVGweOk7jRXJuZ4HnIvzFJkymSm5OtX0Rr02d/?=
 =?us-ascii?Q?aCA1wc1jQml4oB5ZqDTWnm9yQ8QqLRgAOQ+2jPFUQGloyjYCSEKZHuob3JGy?=
 =?us-ascii?Q?QYwC2XfVxif1+xqWiVaeY0tNemwckqs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	84JP24LxFv3pK0ocSP3iT0EB0LZ9nPqhwDzIJ997owYDbJntuZ7NJkkGIS1MtyAPDwX6hdJzyLctxBu6f6+vw7//LhbERlb9Jsty2YcaljOX/uNqt5AF7LR3x4u6CPdlD0Itqk+VodwLF6EAlNI4J7anHFDuO8z+b1oIMTJ52B/6pUxXdNb5ETLEV3riHq3Os2KEgI9sZR9uxXppZ3aEuOAWT4+g3MZOvZv8gHglgf8Yw3kuLhe4HvCEIL5QeZ3756IZxBiZF30fuoLb6avL6ygIHnVpvZZaf0f6TuscHv3twTphMDoViTbEOUUdRUkKvqMpqwohg2PhWec2S3YoRIaLU+nxsBAYTGCzNHTgCVT8cbP/n73FvE/N8wH+K+CODaJOuzfwyW7WY6NlyGMbwJhwlfvHFtlkgtmieIWcFEXCuI3BNOKfGWXE4Cls0eDDLG5Fx+B8wenBvF5w59iiapJCP6Hl3oi3/oZJwks7zq3JMluRLyKW/LJSCLVngkJ37krTWAVw0Z9sEIWPRo0vEDXAMo4rca6aXzYnBe9wpCTo9bh5LDHsVxnxAHXRnd4XcAGXiMr7m0OqAVtWKncGpysif16qKG2tLd9jktBwsA4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbd7f2c-22dc-41a7-3f79-08de51de702e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:28:14.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6kr3AIPTHjOb+Vzs5IfS0r3DaWKB1eY97uy12DyDzltQ1QmL+7ZEnvRLYINcvdT7Sn0BmWwk/Xin6G+4UKDl1d51L6suIGeAT5bw3RLHKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601120108
X-Proofpoint-ORIG-GUID: fB7Bg8SztNe9lP_Dd8vOS31scqlK1LsX
X-Proofpoint-GUID: fB7Bg8SztNe9lP_Dd8vOS31scqlK1LsX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDEwOCBTYWx0ZWRfX4ip+3k0Ijp1R
 wKMs6i/ROL2BCvcJSBX6zclK2yOX1JkOR7m5/dCj1xM6W4u+DVzOnNcrzC6oLBBJ0xzNZRBLOLZ
 VSig3ytUwbDKPA7HYE019Xc3mIml4r7RsUBDk/OoLiq9aJX3I6++mwKcLOnbHlsvVMrRBjm18B5
 Y42qF6vBduNuq48vCEkFg7pH7q1Weami/0jy+fEzSnaHUs/Pvd54EXQT9L66cvOEzO5CIUEDza9
 EtoXm1Ex/98zYcvY9eSpfh5CW3qgO9G2UNaIIO+WctDfoGWjQPgIuQ3hEzjRDFTBmfnrupn/v6V
 O7DBJNn6Uasx2bHfJiiDnsBbBN9AuEKJLBE4eOVDfXd9nvZ4hgrxJjaMvYGhUh5xg+punT3E5G7
 Vm8triThaaeROeH4me4iVBxB+9iRBlP61olojWAANGG436c5wirA5/vDWSmJ9G/A0FqUNdnzysY
 JfHWmBgiIseKtGdifbw==
X-Authority-Analysis: v=2.4 cv=QIllhwLL c=1 sm=1 tr=0 ts=6964f6f3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8
 a=4RBUngkUAAAA:8 a=P82eWFCzbfU5FSlCyqAA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19
 a=CjuIK1q_8ugA:10 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22
 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22

Hi all,

I have bisected this to commit ab04945f91bc ("mm: update mem char driver to use
mmap_prepare"), i.e. my patch, so apologies for that.

Will figure out what's happening here and come up with a hotfix.

When I saw /dev/zero I did suspect this exact commit, would have saved me some
bisecting had I just tested it first but there we are :P

Cheers, Lorenzo

On Sun, Jan 11, 2026 at 11:56:27PM -0800, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f0b9d8eb98df Merge tag 'nfsd-6.19-3' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12ec819a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d60836e327fd6756
> dashboard link: https://syzkaller.appspot.com/bug?extid=bf5de69ebb4bdf86f59f
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ec819a580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bcc19a580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/aad2d47ff01d/disk-f0b9d8eb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c31e7ae85c07/vmlinux-f0b9d8eb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5525fab81561/bzImage-f0b9d8eb.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bf5de69ebb4bdf86f59f@syzkaller.appspotmail.com
>
> 2026/01/08 07:49:49 executed programs: 5
> BUG: memory leak
> unreferenced object 0xffff888112c4b240 (size 184):
>   comm "syz.0.17", pid 6070, jiffies 4294944898
>   hex dump (first 32 bytes):
>     00 00 00 00 07 00 0e 02 00 e4 66 85 ff ff ff ff  ..........f.....
>     98 38 89 09 81 88 ff ff 00 00 00 00 00 00 00 00  .8..............
>   backtrace (crc 987747be):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4958 [inline]
>     slab_alloc_node mm/slub.c:5263 [inline]
>     kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
>     alloc_empty_file+0x51/0x1a0 fs/file_table.c:237
>     alloc_file fs/file_table.c:354 [inline]
>     alloc_file_pseudo+0xae/0x140 fs/file_table.c:383
>     __shmem_file_setup+0x11a/0x210 mm/shmem.c:5846
>     shmem_kernel_file_setup mm/shmem.c:5865 [inline]
>     __shmem_zero_setup mm/shmem.c:5905 [inline]
>     shmem_zero_setup_desc+0x33/0x90 mm/shmem.c:5936
>     mmap_zero_prepare+0x4e/0x60 drivers/char/mem.c:524
>     vfs_mmap_prepare include/linux/fs.h:2058 [inline]
>     call_mmap_prepare mm/vma.c:2596 [inline]
>     __mmap_region+0x8b8/0x13e0 mm/vma.c:2692
>     mmap_region+0x19f/0x1e0 mm/vma.c:2786
>     do_mmap+0x6a3/0xb60 mm/mmap.c:558
>     vm_mmap_pgoff+0x1a6/0x2d0 mm/util.c:581
>     ksys_mmap_pgoff+0x233/0x2d0 mm/mmap.c:604
>     __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
>     __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
>     __x64_sys_mmap+0x6f/0xa0 arch/x86/kernel/sys_x86_64.c:82
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> BUG: memory leak
> unreferenced object 0xffff888101e46ca8 (size 40):
>   comm "syz.0.17", pid 6070, jiffies 4294944898
>   hex dump (first 32 bytes):
>     ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 f8 52 86 00 81 88 ff ff  .........R......
>   backtrace (crc 2d2a393c):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4958 [inline]
>     slab_alloc_node mm/slub.c:5263 [inline]
>     kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
>     lsm_file_alloc security/security.c:169 [inline]
>     security_file_alloc+0x30/0x240 security/security.c:2380
>     init_file+0x3e/0x160 fs/file_table.c:159
>     alloc_empty_file+0x6f/0x1a0 fs/file_table.c:241
>     alloc_file fs/file_table.c:354 [inline]
>     alloc_file_pseudo+0xae/0x140 fs/file_table.c:383
>     __shmem_file_setup+0x11a/0x210 mm/shmem.c:5846
>     shmem_kernel_file_setup mm/shmem.c:5865 [inline]
>     __shmem_zero_setup mm/shmem.c:5905 [inline]
>     shmem_zero_setup_desc+0x33/0x90 mm/shmem.c:5936
>     mmap_zero_prepare+0x4e/0x60 drivers/char/mem.c:524
>     vfs_mmap_prepare include/linux/fs.h:2058 [inline]
>     call_mmap_prepare mm/vma.c:2596 [inline]
>     __mmap_region+0x8b8/0x13e0 mm/vma.c:2692
>     mmap_region+0x19f/0x1e0 mm/vma.c:2786
>     do_mmap+0x6a3/0xb60 mm/mmap.c:558
>     vm_mmap_pgoff+0x1a6/0x2d0 mm/util.c:581
>     ksys_mmap_pgoff+0x233/0x2d0 mm/mmap.c:604
>     __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
>     __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
>     __x64_sys_mmap+0x6f/0xa0 arch/x86/kernel/sys_x86_64.c:82
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> BUG: memory leak
> unreferenced object 0xffff888108f03840 (size 184):
>   comm "syz-executor", pid 5988, jiffies 4294944899
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 5869ffdf):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4958 [inline]
>     slab_alloc_node mm/slub.c:5263 [inline]
>     kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
>     prepare_creds+0x22/0x5e0 kernel/cred.c:185
>     copy_creds+0x44/0x290 kernel/cred.c:286
>     copy_process+0x979/0x2860 kernel/fork.c:2086
>     kernel_clone+0x119/0x6c0 kernel/fork.c:2651
>     __do_sys_clone+0x7b/0xb0 kernel/fork.c:2792
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> BUG: memory leak
> unreferenced object 0xffff888109a7b8e0 (size 32):
>   comm "syz-executor", pid 5988, jiffies 4294944899
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     f8 52 86 00 81 88 ff ff 00 00 00 00 00 00 00 00  .R..............
>   backtrace (crc 336e1c5f):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4958 [inline]
>     slab_alloc_node mm/slub.c:5263 [inline]
>     __do_kmalloc_node mm/slub.c:5656 [inline]
>     __kmalloc_noprof+0x3e0/0x660 mm/slub.c:5669
>     kmalloc_noprof include/linux/slab.h:961 [inline]
>     kzalloc_noprof include/linux/slab.h:1094 [inline]
>     lsm_blob_alloc+0x4d/0x70 security/security.c:192
>     lsm_cred_alloc security/security.c:209 [inline]
>     security_prepare_creds+0x2f/0x270 security/security.c:2763
>     prepare_creds+0x385/0x5e0 kernel/cred.c:215
>     copy_creds+0x44/0x290 kernel/cred.c:286
>     copy_process+0x979/0x2860 kernel/fork.c:2086
>     kernel_clone+0x119/0x6c0 kernel/fork.c:2651
>     __do_sys_clone+0x7b/0xb0 kernel/fork.c:2792
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> BUG: memory leak
> unreferenced object 0xffff888109b169c0 (size 184):
>   comm "syz.0.18", pid 6072, jiffies 4294944899
>   hex dump (first 32 bytes):
>     00 00 00 00 07 00 0e 02 00 e4 66 85 ff ff ff ff  ..........f.....
>     68 e6 05 0e 81 88 ff ff 00 00 00 00 00 00 00 00  h...............
>   backtrace (crc 86e9bbaa):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4958 [inline]
>     slab_alloc_node mm/slub.c:5263 [inline]
>     kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
>     alloc_empty_file+0x51/0x1a0 fs/file_table.c:237
>     alloc_file fs/file_table.c:354 [inline]
>     alloc_file_pseudo+0xae/0x140 fs/file_table.c:383
>     __shmem_file_setup+0x11a/0x210 mm/shmem.c:5846
>     shmem_kernel_file_setup mm/shmem.c:5865 [inline]
>     __shmem_zero_setup mm/shmem.c:5905 [inline]
>     shmem_zero_setup_desc+0x33/0x90 mm/shmem.c:5936
>     mmap_zero_prepare+0x4e/0x60 drivers/char/mem.c:524
>     vfs_mmap_prepare include/linux/fs.h:2058 [inline]
>     call_mmap_prepare mm/vma.c:2596 [inline]
>     __mmap_region+0x8b8/0x13e0 mm/vma.c:2692
>     mmap_region+0x19f/0x1e0 mm/vma.c:2786
>     do_mmap+0x6a3/0xb60 mm/mmap.c:558
>     vm_mmap_pgoff+0x1a6/0x2d0 mm/util.c:581
>     ksys_mmap_pgoff+0x233/0x2d0 mm/mmap.c:604
>     __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
>     __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
>     __x64_sys_mmap+0x6f/0xa0 arch/x86/kernel/sys_x86_64.c:82
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

