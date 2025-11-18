Return-Path: <linux-fsdevel+bounces-68908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5667C680DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9C8A72A35C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC74D2F9DB7;
	Tue, 18 Nov 2025 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B8AKwBCB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xx3YebY4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F032580F2;
	Tue, 18 Nov 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763452070; cv=fail; b=JtNdmuO0Zr56tBZE1H+Er3799FDMM3uTOOjUHF9PcGFq2dtSSk4CGP2DCW5HihKLeiRTvDHgdbnTN9HCXQpYuSp8rdAKNwYrh4LbAaW8eP3fXOZebVwWPSXPo6K5h4jWAgXeYgH+XQTa9sKTJsgOFsTkGwfzUMgBVcm9VisKA7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763452070; c=relaxed/simple;
	bh=PaUcLq8ZzN2q3ikXvPz+D8236GuOGfkkxz4E5pSOImc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AB4SqRkxTbI4p7aytUSudygE6a6es9s1EdGlVvDKGW3FRZhzI0PxUwucx0BoIw1/V7IByCYECZVSQzisEkl63FqbrHqGSDImTFdwcgMlaR6IaFbGDXjKSMZ9xvZhhG/2RY1ZpXgESI4/oU9u5L8iMW3RgcdBBPYx1wWisbtO25Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B8AKwBCB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xx3YebY4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI6NN17017907;
	Tue, 18 Nov 2025 07:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KKG0k54lbmzMTzWMD8
	ZQdv99wLE15C7DjxH2WF4Wsl8=; b=B8AKwBCBxV1VJNLQc/56nvtsOPGO+i09px
	mZFiXatW+PoaoqaB8NLG367fIRxZMcrzt2M2gesxDFordW1+xKciJSg+v2Zjb2F3
	KlAzzcQLvEm/K9BgyJtR41CpzmLNudabq9lG0fgEbDeqTCCbf0MSaHdZu6fkZV/r
	V0R8RVteLNNXqYoOuoYxyOPd/qBwGjTFJSWLBnj3R2Uec3BC1HRguzz0WPAwgUez
	e1Zd2Nz9yF1rw+tjpc43aCQepsJF3d9/bS0d0Bw4iILIaMrO1yckrRmJijGrrfbN
	mdhbR5Gho2NGQZ1CgOhXD9raroGSvNXZgPkFudWiUvK3ahz2U7Rg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej96483g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 07:46:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI7G4Rc009810;
	Tue, 18 Nov 2025 07:46:54 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefycu6ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 07:46:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCJ1eloF9F5QV6+EYw/9hwY8p7I+lTC0WuXIQdlI+fc8vA9p4vjoUqjpjYQ2yp2D/yVWb9PfQMqyQz5RP8lHjExeRiIZZxweYww0vWeUf0BDy58zO56OaPQ3ThFNv63RHGaMe4ytW7JtsYHo6DJsqr7vrvkP/Bm6lDazJPVIDyr+Todv3Wtbi1z+PD7ppbTbAkOxWMA7781wEPQhyYB/9d5FQ6j0ScqdCVjr+nhYmeZGFGrwhuYvjkrc5G9Fl8hSi2qGGju12v9K+U2aEwjWGiPOytBo7ClfVZ+bptTMDn3vYCbLGV84r/97OVs0mhY2K9UZazRHsx8K5gzQuSar1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKG0k54lbmzMTzWMD8ZQdv99wLE15C7DjxH2WF4Wsl8=;
 b=M1kkt28Ceq8j95Xg5G1YQPkcJXQF+aZQJdfrr67GEdXREqFH3F+R3K82T5QjTI+jgwbgcn0BC1y/QK/kIRwG0vFwbQYPafkyvMTe+uMfMHf0YeTY8PjSEm3vK1zhtUAAi1aLMUs9lQPUT974P2fb8S/N35XDGqndGwbGCk50h4ULynKyKXgSLOcoG3E2jhj7Z7l8gtbqlWLJxVw5B+TLnUMejsS8XFC4Fqmx5I9squlZf4DrB0zqFz6JMAuKwPf8hPOpWJM3QClOax572q2+ebb1y6qw/kLll+YLCKmqmkChpGPcL3x2tXPR+JMrwxXhK0nGtAHMmXnsJ40rawbPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKG0k54lbmzMTzWMD8ZQdv99wLE15C7DjxH2WF4Wsl8=;
 b=Xx3YebY4GrPG69NDFG7c2ixXNiUfEte2NzNQhQY/td0txQYJCTR+/6saggIm9WbVQ7+CH9V0h5V1s/KWki6sXla57kyyVLUqYNzeaFIER9W/YhwKGI3zY2fpKMQuzs1VOhon4mcaAL+VbO38BL3Yjln6mbiPZNj5vXWC8UQIA+w=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 07:46:51 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 07:46:51 +0000
Date: Tue, 18 Nov 2025 07:46:49 +0000
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
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 3/8] mm: implement sticky VMA flags
Message-ID: <d90275d5-5d56-42ac-b610-4162eb97fef2@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
 <cf58c518-05d0-494f-8fe4-571879834031@lucifer.local>
 <20251117144332.d338e8368d59c3ab665db986@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117144332.d338e8368d59c3ab665db986@linux-foundation.org>
X-ClientProxiedBy: LO2P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::25) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: ec09249d-8920-453d-e6d1-08de2676a2d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mi42ZJAjr3ZTFcXcFlk3ododI65sSTEoHXYaQ5i6St9bWt5mDeMoz/PZnbd1?=
 =?us-ascii?Q?ro0z37ZvieqJPxdOxR+7ijWnZVoYjXHcp/G0do3N98jZ5ff2IvEQSls5tUwY?=
 =?us-ascii?Q?qaMyv/O35SKCnf1HCdWEUPDk5qJrbsnK3sPIt4S0mUAB61oo2l+STlrs/Zay?=
 =?us-ascii?Q?Dtp4Y4mEf504yycr4Eoyc7K5Cr9jZqfVcMR64AuuQI8qacyGwbLsVLE15GRl?=
 =?us-ascii?Q?J/7C1iYTL5jP2wC7NFnUpVAq30wJRm8cCwbSfksSnp1nxamXv0emtSXj4Xjj?=
 =?us-ascii?Q?OPSahbCmC1xemn+0sPaWmE/j5bmsILW0r7fXMMyqRTug4BbEr4He2g5QnAZy?=
 =?us-ascii?Q?a4pYVEd/uaKORnbv4tIYZ3XTzmW3KJ3/AeLNSp1tpZlGY6MyL1KaAUuLJUf8?=
 =?us-ascii?Q?q66obWBeG+eYGq/H1AaW0QO4Ex0l14vaduGbtgMY8ELKHlCXq5rTfyTraxSM?=
 =?us-ascii?Q?/tReFs6TapV5zBNaa9Eg0DVghMPUWGklnewrrH4Y7GkW5QZNUoAvXZjiIYxt?=
 =?us-ascii?Q?pf71u50p/Ak5REv184KeQ7ugs2mMY1iWR3zm1Mbx6QiW2/fEsjnk9R64Oajt?=
 =?us-ascii?Q?BMjoSDjLSansiIazWm3/L1AS99QER0hFQDHGkxBzzdOaZK92GOGh1KdQ4Y2I?=
 =?us-ascii?Q?kHXTQkL8rVkAPJZFgjwrDh5X+mPr4EEMsT891NBig+W37Yt8nl7vOY1BPvgc?=
 =?us-ascii?Q?3EkTC1HG+5bGSnDBLih7Asxw2b/8/ibbGT1bS+d5u0Hc8A3hfmDJKlLlbUZd?=
 =?us-ascii?Q?TMqvZ2jTZIOUATIuKEW1ffIe2aiVprlWrxh9mtQ190G97GMO9OSO+EDyVInJ?=
 =?us-ascii?Q?xGr0Ajauk4KujtwJ+O0iNm8mF31u4L6j3aU19CRu2Q9YnHTXkl1INxbwLWtG?=
 =?us-ascii?Q?LEYD64VE39oDtR9+nynsYWOeD08vHjtUgsAxfrLEYwRdn03GfgQwLqIqaYus?=
 =?us-ascii?Q?8FO9Gdcyosb2QUNvr863y37UDPsOzDqe+WZJNRhtDnePHJ2WYIkbTj/0ff5e?=
 =?us-ascii?Q?6e33pqglJ1aWjl1m3ndG/+XzTcm5InuurF3guwK2aNvktaRTjO+J+vIK9PRQ?=
 =?us-ascii?Q?+DeeCyCa+71qJFBw7oyVcYsSx2Gfvwyi0IlGTgsZJFRSnTUQQOnhtKoaLa6X?=
 =?us-ascii?Q?4B0Q+O1dTxGFHV5hLn30cZSWFcbGS2kei1IrMxk+/uGaQ+eh+557riTOkvRT?=
 =?us-ascii?Q?TenQ8Y1dxXB5d3K4iKTFZAvpHQOhDXMEKGJJlYE3Yf6dFuJrX9vDqcqHy3Y3?=
 =?us-ascii?Q?rEVidT4R7N/5ODk15jsQUgzyhZLMwnpVtu1Yt6X6oEK8RPQQrvEwKU6U9YKg?=
 =?us-ascii?Q?SEzHSD16Vg9q+3B1QUtNJ9juJW2FK7QOP68bKD5C21oBytFoAMLIIjPTLVId?=
 =?us-ascii?Q?AXGRwBuUJcPJjLI+ZYQiwPL8fH625TLCx8XxZty3v07Jk/DZ0mGsC3nBvt8g?=
 =?us-ascii?Q?iyY5yodWjei0+fr/9wm4hiy817vle+X0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UjbStNLw8HBHTxuRVBAXugtuCz/niV3Bkj41YM00emA8Tkd/g2NAExoPztMP?=
 =?us-ascii?Q?Xs9RMaCOkYUXEyXnuKMRx7OPgYtxXBNG6hF8mCuU6N0Ua/JoCEuYKnL50GDG?=
 =?us-ascii?Q?jUeKVTHjAJxY/qBH5gOzJBC9jrHL6BJRUmyrRi2XpTG3LE20+sW4Wg8EAaZN?=
 =?us-ascii?Q?b0EUGRnC5kFQp2UAgjL48o2rJbDDSSiWACWB/2KgLZOC1kJfl1Rx5dBS9Khn?=
 =?us-ascii?Q?EkE9BNkFao9heEF0lQXLgST8N1GjsZjY3NMsnZFzxYX5BiEgta/gzEA4TDav?=
 =?us-ascii?Q?YUUcxPUC6xih+jf8vM3+u75N9D3XJxFro/CmexULCSj5CDfs7LVPMRctWHc3?=
 =?us-ascii?Q?iiIUOas1H3ZiYLJsN4LG1CQ+fBLekm3xfBXcqDVnjarjn31GI4t8B59rjgdv?=
 =?us-ascii?Q?SZKRx+U/o7KoiWtbYwNVgoPMQWbOjONZoUScQEi4/YCjVXaVy1KYaI0/vPJu?=
 =?us-ascii?Q?caa6kY6nEZ2wW9UrJZVjpd6H7IVRIkDkZgksoS+MA0LoJ1JIYXgHRwI9rTYY?=
 =?us-ascii?Q?hmqfT4rtOiVgyzv0O+AqYE0wNUc1qVb1kNFibUEnwrxQobo2E5P3xikjA0i8?=
 =?us-ascii?Q?7rjCO4rTnmBkUhM+eTnHmJVktYNhmw/JQRlIdJ/HhLwAiK84mFJ24vmU7GP9?=
 =?us-ascii?Q?opSUG625ASRyYemncwwb8AZYzeRE1HSproTLxy0cTJwoWWfyX5jYlJJFT7yk?=
 =?us-ascii?Q?PL/9JahyieGpc7p507tnlsEnzH5mMuM1nmeJ0bCN+3p2t365fDD6/zAx03kG?=
 =?us-ascii?Q?FMMRvTaLRGmni/htUpzLe1VNPUbItthib1fgxPyN2icF1nHkKblLG8DTmlCb?=
 =?us-ascii?Q?+28ogaRjQGiGdK8Z0K8rKceofVSwNyjHZFFZ87xyYecglwtmgZIvu7xXvAGq?=
 =?us-ascii?Q?CkAE8rWSM+6lY7k2NhBrWv1TEOwNnmRDqkwlB6jTqkIzmV7AN2/1ZQZxW8VZ?=
 =?us-ascii?Q?dQ/qI47TFDEuPfimZHoa8PrtLsV3p75WtXqoFFdf1bAbAcDJMQWY1COIVyCS?=
 =?us-ascii?Q?367mZK5Og0ypXf7JPCnWGzgjs6RG0UXSqeWcoIz8vUmHYfCxBvLyIbsy10LP?=
 =?us-ascii?Q?OTzaGamK2VI/TSRkcWSGM0lO8mQZf3/pMoRa9/ot4hWFvUS0WUIbOaBQFfpK?=
 =?us-ascii?Q?IIwqiVkSoHBCt7x3JCZ9mtY9Lqg9XOz1FwtqvELElMv3fqU84OKaUdj9Rmq/?=
 =?us-ascii?Q?a/JxHMVxDZeIuWCmOpDMdPvtKZVP81t77ILkczt5B1h12W5NVQJyhIerDWOe?=
 =?us-ascii?Q?OLPPfdtcfghI4bn2dXMcQUpYao8+AxlWZ52Gp9luPmlO9twBZnfPlEsg5gcC?=
 =?us-ascii?Q?aZB80qBdr3vpvJkelC0Y8+BYPaUk46d9o280Lsndc8/Bn79qmJICn29fJ6Fe?=
 =?us-ascii?Q?ISWQlh/CrLtoGXZHxCqvnENoMRCgSNtD44pqe0g1xRfRZIZh99u1hsWQpEB+?=
 =?us-ascii?Q?FgUX/iE+qH7D4JT7M3bkRm4IZJgNEW4oO5kOchF7om2o5NG8Y0AU+YGkipUA?=
 =?us-ascii?Q?DkzSAUMCthqaNs1Ds1wSbOTJiRcC/SZ83EDBPVND/RM6EYoTm0jz1nYkQkUO?=
 =?us-ascii?Q?Ibq9f+OHaXPvRkPU6oD0Vt10WC5aEsGsNNRMbYUG2Tc5MXN571nKH2G2CvLy?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yod/FrYgro2LykBR6m6IGRyaZpo7oIo69qa+Un+yXU3QIXznRThgCW7OPhGPpWOcXYm8MM71WClHaV6GARfpmo1iYqLVk4q4sWLPynTMfgsJgvzHaYFQNOt5pE1o2xUrALB5gsnxcv8z7HCmjSHRBeFJ8Mw9/VnTyUNkGj98shWoX/3G0M/KBk3YvXAplQhm6W3eUYYerSQ7LkOqIV58L3DYLLaEKXqwUHQ4Hd3Dy5cI8F/ZGAU0rGFOxATnOvwgRW36yGD1bix2nCsy2Nzo/wl1KIJLqZh5pRY8YM+7gL6oPl4tYQvRYyDgDPNDv0c+9Er7NTiVVSAR35V6A3cglhqDoGuy+eE1QP9iUhSGQGEJlO/CDVIbkiFUhNTNSjVprTQGdm8iujrRwCBQfqRnxBhd33cmoVY8ENn/CoXeGjfhTAu+wIFm/QalG3T2ZQjdts1a4g4hLMYWRMrX3ns8YSm4vhCCrm2JDJWtuq8AEhY+YJQYyewN80ZnuUVQOroA8OHRZPuWhZouZF+sqELxt22cDrA3BkMARawJwySuBQYAW7AbKxIZ5fGlC4ihNo0bwEI/STsazQF7loH7xJ8YoOZY6n6Mlf9Qe48/U2MKiuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec09249d-8920-453d-e6d1-08de2676a2d5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 07:46:51.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+8vQFWZxsVWGMPJygCG4udQgAXwPUS4JooZbWvas94KDyxOV0MqOX4pDsorvl7rFvgeXLUoKGwtQsLxnd5uG/34kazuz42NDlVfvsJCOz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511180060
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691c2470 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=mUO715r_6lxILAA5gf4A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13643
X-Proofpoint-GUID: apeLo-ZZA3l16nytDOkYXeuqIMzJFLzq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXwaIpakVRXLJe
 aa7c3ofs7kayYZIeJ3dBFFZF355FpOIJ0OHMpzJQLGqgIxYRoHjihr7PC5YzD8demfRDecQ0pd7
 Izvzb0DLnfgq5o2AMxjP87w3pwo93EFDh8xZ03idP1mehjT6QOr79/W97pcsqxd/W8WAkI9Jva2
 pd2/dT3fcMY/kSKKurWD4dTxfeYnMk89yYF5ofowFFKeAB6M4WSGcPnOmRAg7Ra16Wm+sJjreC4
 MFmz6noURA+QNZvwplFmCEh5j01I+n4CFFqz9QZph8JFFjSPs8P3MAP8AK2hx1eT+aWreQYnNuu
 IpLKEhMr/n3uPNwwBSSX9+Dor9Y3kB+Q+z+tBqkIAtz6P6mAwNVsEsMcVmi1l2ixJAOrWO/LTeZ
 p4+Yft285/DTJZ4Zg48Ow+2qoQ+bY30cU0d0tMh44knIjO8weR8=
X-Proofpoint-ORIG-GUID: apeLo-ZZA3l16nytDOkYXeuqIMzJFLzq

On Mon, Nov 17, 2025 at 02:43:32PM -0800, Andrew Morton wrote:
> On Mon, 17 Nov 2025 20:02:03 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Sorry to be a pain here, and can respin if it's easier, but can we update the
> > text of the comments below? As in discussion with Liam off-list we agreed that
> > the current wording is rather unclear and we can do a lot better.
> >
> > I provide the improved version inline below:
>
> np,
>
>  include/linux/mm.h               |    7 +++----
>  tools/testing/vma/vma_internal.h |    7 +++----
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> --- a/include/linux/mm.h~mm-implement-sticky-vma-flags-fix-2
> +++ a/include/linux/mm.h
> @@ -549,10 +549,9 @@ extern unsigned int kobjsize(const void
>   *                pressure on the memory system forcing the kernel to generate
>   *                new VMAs when old one could be extended instead.
>   *
> - *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
> - *                which should propagate to all VMAs, but the other does not,
> - *                the merge should still proceed with the merge logic applying
> - *                sticky flags to the final VMA.
> + *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
> + *                'sticky'. If any sticky flags exist in either VMA, we simply
> + *                set all of them on the merged VMA.
>   */
>  #define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
>
> --- a/tools/testing/vma/vma_internal.h~mm-implement-sticky-vma-flags-fix-2
> +++ a/tools/testing/vma/vma_internal.h
> @@ -139,10 +139,9 @@ extern unsigned long dac_mmap_min_addr;
>   *                pressure on the memory system forcing the kernel to generate
>   *                new VMAs when old one could be extended instead.
>   *
> - *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
> - *                which should propagate to all VMAs, but the other does not,
> - *                the merge should still proceed with the merge logic applying
> - *                sticky flags to the final VMA.
> + *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
> + *                'sticky'. If any sticky flags exist in either VMA, we simply
> + *                set all of them on the merged VMA.
>   */
>  #define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
>
> _
>

Thanks, much appreciated!

Despite your having very kindly done this, I apologise as I realise now after
all I have to respin... doh!

There was yet another typo as pointed out by Jane (and previously off-list,
Liam) plus Pedro (off-list) mentioned a silly mistake in my code fixup, and at
this point I think it'll keep us all a lot saner to just respin :>)

Cheers, Lorenzo

